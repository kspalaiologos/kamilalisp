
(PUT '|FM;rep| '|SPADreplace| '(XLAM (|x|) |x|)) 

(SDEFUN |FM;rep| ((|x| ($)) ($ (|Rep|))) |x|) 

(PUT '|FM;per| '|SPADreplace| '(XLAM (|r|) |r|)) 

(SDEFUN |FM;per| ((|r| (|Rep|)) ($ ($))) |r|) 

(SDEFUN |FM;*;R2$;3| ((|r| (R)) (|x| ($)) ($ ($)))
        (SPROG ((#1=#:G720 NIL) (|u| NIL) (#2=#:G719 NIL))
               (SEQ
                (COND ((SPADCALL |r| (QREFELT $ 13)) (|spadConstant| $ 14))
                      ((SPADCALL |r| (QREFELT $ 11) (QREFELT $ 15)) |x|)
                      ('T
                       (PROGN
                        (LETT #2# NIL)
                        (SEQ (LETT |u| NIL) (LETT #1# |x|) G190
                             (COND
                              ((OR (ATOM #1#) (PROGN (LETT |u| (CAR #1#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #2#
                                     (CONS
                                      (CONS (QCAR |u|)
                                            (SPADCALL |r| (QCDR |u|)
                                                      (QREFELT $ 16)))
                                      #2#))))
                             (LETT #1# (CDR #1#)) (GO G190) G191
                             (EXIT (NREVERSE #2#))))))))) 

(SDEFUN |FM;*;R2$;4| ((|r| (R)) (|x| ($)) ($ ($)))
        (SPROG ((|a| (R)) (#1=#:G728 NIL) (|u| NIL) (#2=#:G727 NIL))
               (SEQ
                (COND ((SPADCALL |r| (QREFELT $ 13)) (|spadConstant| $ 14))
                      ((SPADCALL |r| (QREFELT $ 11) (QREFELT $ 15)) |x|)
                      ('T
                       (PROGN
                        (LETT #2# NIL)
                        (SEQ (LETT |u| NIL) (LETT #1# |x|) G190
                             (COND
                              ((OR (ATOM #1#) (PROGN (LETT |u| (CAR #1#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (COND
                                ((SPADCALL
                                  (LETT |a|
                                        (SPADCALL |r| (QCDR |u|)
                                                  (QREFELT $ 16)))
                                  (|spadConstant| $ 10) (QREFELT $ 18))
                                 (LETT #2#
                                       (CONS (CONS (QCAR |u|) |a|) #2#))))))
                             (LETT #1# (CDR #1#)) (GO G190) G191
                             (EXIT (NREVERSE #2#))))))))) 

(SDEFUN |FM;*;$R$;5| ((|x| ($)) (|r| (R)) ($ ($)))
        (SPROG ((#1=#:G734 NIL) (|u| NIL) (#2=#:G733 NIL))
               (SEQ
                (COND ((SPADCALL |r| (QREFELT $ 13)) (|spadConstant| $ 14))
                      ((SPADCALL |r| (QREFELT $ 11) (QREFELT $ 15)) |x|)
                      ('T
                       (PROGN
                        (LETT #2# NIL)
                        (SEQ (LETT |u| NIL) (LETT #1# |x|) G190
                             (COND
                              ((OR (ATOM #1#) (PROGN (LETT |u| (CAR #1#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #2#
                                     (CONS
                                      (CONS (QCAR |u|)
                                            (SPADCALL (QCDR |u|) |r|
                                                      (QREFELT $ 16)))
                                      #2#))))
                             (LETT #1# (CDR #1#)) (GO G190) G191
                             (EXIT (NREVERSE #2#))))))))) 

(SDEFUN |FM;*;$R$;6| ((|x| ($)) (|r| (R)) ($ ($)))
        (SPROG ((|a| (R)) (#1=#:G740 NIL) (|u| NIL) (#2=#:G739 NIL))
               (SEQ
                (COND ((SPADCALL |r| (QREFELT $ 13)) (|spadConstant| $ 14))
                      ((SPADCALL |r| (QREFELT $ 11) (QREFELT $ 15)) |x|)
                      ('T
                       (PROGN
                        (LETT #2# NIL)
                        (SEQ (LETT |u| NIL) (LETT #1# |x|) G190
                             (COND
                              ((OR (ATOM #1#) (PROGN (LETT |u| (CAR #1#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (COND
                                ((SPADCALL
                                  (LETT |a|
                                        (SPADCALL (QCDR |u|) |r|
                                                  (QREFELT $ 16)))
                                  (|spadConstant| $ 10) (QREFELT $ 18))
                                 (LETT #2#
                                       (CONS (CONS (QCAR |u|) |a|) #2#))))))
                             (LETT #1# (CDR #1#)) (GO G190) G191
                             (EXIT (NREVERSE #2#))))))))) 

(SDEFUN |FM;*;RS$;7| ((|r| (R)) (|s| (S)) ($ ($)))
        (COND
         ((SPADCALL |r| (|spadConstant| $ 10) (QREFELT $ 15))
          (|spadConstant| $ 14))
         ('T (LIST (CONS |s| |r|))))) 

(SDEFUN |FM;*;SR$;8| ((|s| (S)) (|r| (R)) ($ ($)))
        (COND
         ((SPADCALL |r| (|spadConstant| $ 10) (QREFELT $ 15))
          (|spadConstant| $ 14))
         ('T (LIST (CONS |s| |r|))))) 

(SDEFUN |FM;coerce;$Of;9| ((|x| ($)) ($ (|OutputForm|)))
        (SPROG ((|le| (|List| (|OutputForm|))) (#1=#:G755 NIL) (|rec| NIL))
               (SEQ
                (COND
                 ((NULL |x|) (SPADCALL (|spadConstant| $ 10) (QREFELT $ 23)))
                 ('T
                  (SEQ (LETT |le| NIL)
                       (SEQ (LETT |rec| NIL) (LETT #1# (REVERSE |x|)) G190
                            (COND
                             ((OR (ATOM #1#)
                                  (PROGN (LETT |rec| (CAR #1#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (COND
                               ((SPADCALL (QCDR |rec|) (|spadConstant| $ 9)
                                          (QREFELT $ 15))
                                (LETT |le|
                                      (CONS
                                       (SPADCALL (QCAR |rec|) (QREFELT $ 24))
                                       |le|)))
                               ('T
                                (LETT |le|
                                      (CONS
                                       (SPADCALL
                                        (SPADCALL (QCDR |rec|) (QREFELT $ 23))
                                        (SPADCALL (QCAR |rec|) (QREFELT $ 24))
                                        (QREFELT $ 25))
                                       |le|))))))
                            (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                       (EXIT (SPADCALL (ELT $ 26) |le| (QREFELT $ 29))))))))) 

(SDEFUN |FM;coerce;$Of;10| ((|x| ($)) ($ (|OutputForm|)))
        (SPROG ((#1=#:G772 NIL) (|rec| NIL) (#2=#:G771 NIL))
               (SEQ
                (SPADCALL (ELT $ 26)
                          (PROGN
                           (LETT #2# NIL)
                           (SEQ (LETT |rec| NIL) (LETT #1# |x|) G190
                                (COND
                                 ((OR (ATOM #1#)
                                      (PROGN (LETT |rec| (CAR #1#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #2#
                                        (CONS
                                         (SPADCALL
                                          (SPADCALL (QCDR |rec|)
                                                    (QREFELT $ 23))
                                          (SPADCALL (QCAR |rec|)
                                                    (QREFELT $ 24))
                                          (QREFELT $ 25))
                                         #2#))))
                                (LETT #1# (CDR #1#)) (GO G190) G191
                                (EXIT (NREVERSE #2#))))
                          (QREFELT $ 29))))) 

(SDEFUN |FM;support;$L;11| ((|x| ($)) ($ (|List| S)))
        (SPROG ((#1=#:G777 NIL) (|t| NIL) (#2=#:G776 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |t| NIL) (LETT #1# |x|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |t| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ (EXIT (LETT #2# (CONS (QCAR |t|) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |FM;coefficients;$L;12| ((|x| ($)) ($ (|List| R)))
        (SPROG ((#1=#:G782 NIL) (|t| NIL) (#2=#:G781 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |t| NIL) (LETT #1# |x|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |t| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ (EXIT (LETT #2# (CONS (QCDR |t|) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |FM;monom| ((|b| (S)) (|r| (R)) ($ ($))) (LIST (CONS |b| |r|))) 

(SDEFUN |FM;monomials;$L;14| ((|x| ($)) ($ (|List| $)))
        (SPROG ((#1=#:G788 NIL) (|t| NIL) (#2=#:G787 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |t| NIL) (LETT #1# |x|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |t| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS (|FM;monom| (QCAR |t|) (QCDR |t|) $)
                                    #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |FM;retractIfCan;$U;15| ((|x| ($)) ($ (|Union| S "failed")))
        (COND
         ((OR (SPADCALL (SPADCALL |x| (QREFELT $ 38)) 1 (QREFELT $ 40))
              (NULL
               (SPADCALL (QCDR (|SPADfirst| |x|)) (|spadConstant| $ 9)
                         (QREFELT $ 15))))
          (CONS 1 "failed"))
         ('T (CONS 0 (QCAR (|SPADfirst| |x|)))))) 

(SDEFUN |FM;retract;$S;16| ((|x| ($)) ($ (S)))
        (SPROG ((|rr| (|Union| S "failed")))
               (SEQ (LETT |rr| (SPADCALL |x| (QREFELT $ 42)))
                    (EXIT
                     (COND ((QEQCAR |rr| 1) (|error| "FM1.retract impossible"))
                           ('T (QCDR |rr|))))))) 

(SDEFUN |FM;coerce;S$;17| ((|s| (S)) ($ ($)))
        (LIST (CONS |s| (|spadConstant| $ 9)))) 

(SDEFUN |FM;coefficient;$SR;18| ((|x| ($)) (|s| (S)) ($ (R)))
        (COND ((NULL |x|) (|spadConstant| $ 10))
              ((SPADCALL |s| (QCAR (|SPADfirst| |x|)) (QREFELT $ 45))
               (SPADCALL (CDR |x|) |s| (QREFELT $ 46)))
              ((SPADCALL (QCAR (|SPADfirst| |x|)) |s| (QREFELT $ 47))
               (QCDR (|SPADfirst| |x|)))
              ('T (|spadConstant| $ 10)))) 

(SDEFUN |FM;coefficient;$SR;19| ((|x| ($)) (|s| (S)) ($ (R)))
        (SPROG ((#1=#:G813 NIL) (#2=#:G814 NIL) (|t| NIL) (|xr| (|Rep|)))
               (SEQ
                (EXIT
                 (SEQ (LETT |xr| |x|)
                      (SEQ (LETT |t| NIL) (LETT #2# |xr|) G190
                           (COND
                            ((OR (ATOM #2#) (PROGN (LETT |t| (CAR #2#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((SPADCALL (QCAR |t|) |s| (QREFELT $ 47))
                               (PROGN (LETT #1# (QCDR |t|)) (GO #3=#:G812))))))
                           (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                      (EXIT (|spadConstant| $ 10))))
                #3# (EXIT #1#)))) 

(SDEFUN |FM;linearExtend;M$R;20| ((|f| (|Mapping| R S)) (|x| ($)) ($ (R)))
        (SPROG ((|res| (R)) (#1=#:G821 NIL) (|t| NIL))
               (SEQ
                (COND ((SPADCALL |x| (QREFELT $ 48)) (|spadConstant| $ 10))
                      ('T
                       (SEQ (LETT |res| (|spadConstant| $ 10))
                            (SEQ (LETT |t| NIL)
                                 (LETT #1# (SPADCALL |x| (QREFELT $ 51))) G190
                                 (COND
                                  ((OR (ATOM #1#)
                                       (PROGN (LETT |t| (CAR #1#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT |res|
                                         (SPADCALL |res|
                                                   (SPADCALL (QCDR |t|)
                                                             (SPADCALL
                                                              (QCAR |t|) |f|)
                                                             (QREFELT $ 16))
                                                   (QREFELT $ 52)))))
                                 (LETT #1# (CDR #1#)) (GO G190) G191
                                 (EXIT NIL))
                            (EXIT |res|))))))) 

(DECLAIM (NOTINLINE |FreeModule;|)) 

(DEFUN |FreeModule| (&REST #1=#:G829)
  (SPROG NIL
         (PROG (#2=#:G830)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|FreeModule|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |FreeModule;|) #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|FreeModule|)))))))))) 

(DEFUN |FreeModule;| (|#1| |#2|)
  (SPROG
   ((|pv$| NIL) (#1=#:G828 NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT |dv$| (LIST '|FreeModule| DV$1 DV$2))
    (LETT $ (GETREFV 61))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#1| '(|AbelianGroup|))
                                        (|HasCategory| |#1|
                                                       '(|CommutativeRing|))
                                        (OR
                                         (|HasCategory| |#1| '(|AbelianGroup|))
                                         (|HasCategory| |#1|
                                                        '(|AbelianMonoid|))
                                         (|HasCategory| |#1|
                                                        '(|CancellationAbelianMonoid|)))
                                        (OR
                                         (|HasCategory| |#1| '(|AbelianGroup|))
                                         (|HasCategory| |#1|
                                                        '(|CancellationAbelianMonoid|)))
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|OrderedAbelianMonoidSup|))
                                         (|HasCategory| |#2| '(|OrderedSet|)))
                                        (OR
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|OrderedAbelianMonoid|))
                                          (|HasCategory| |#2| '(|OrderedSet|)))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|OrderedAbelianMonoidSup|))
                                          (|HasCategory| |#2|
                                                         '(|OrderedSet|))))
                                        (|HasCategory| |#1| '(|SemiRing|))
                                        (LETT #1#
                                              (|HasCategory| |#2|
                                                             '(|Comparable|)))
                                        (OR
                                         (AND
                                          (|HasCategory| |#1| '(|Comparable|))
                                          #1#)
                                         (AND
                                          (|HasCategory| |#1| '(|Comparable|))
                                          (|HasCategory| |#2| '(|OrderedSet|)))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|OrderedAbelianMonoid|))
                                          (|HasCategory| |#2| '(|OrderedSet|)))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|OrderedAbelianMonoidSup|))
                                          (|HasCategory| |#2|
                                                         '(|OrderedSet|))))
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|AbelianMonoid|))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|OrderedAbelianMonoid|))
                                          (|HasCategory| |#2| '(|OrderedSet|)))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|OrderedAbelianMonoidSup|))
                                          (|HasCategory| |#2|
                                                         '(|OrderedSet|))))
                                        (OR
                                         (|HasCategory| |#1| '(|AbelianGroup|))
                                         (|HasCategory| |#1|
                                                        '(|CancellationAbelianMonoid|))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|OrderedAbelianMonoidSup|))
                                          (|HasCategory| |#2|
                                                         '(|OrderedSet|))))
                                        (OR
                                         (AND
                                          (|HasCategory| |#1| '(|Comparable|))
                                          #1#)
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|OrderedAbelianMonoid|))
                                          (|HasCategory| |#2| '(|OrderedSet|)))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|OrderedAbelianMonoidSup|))
                                          (|HasCategory| |#2|
                                                         '(|OrderedSet|))))))))
    (|haddProp| |$ConstructorCache| '|FreeModule| (LIST DV$1 DV$2) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 8 (|List| (|Record| (|:| |k| |#2|) (|:| |c| |#1|))))
    (QSETREFV $ 11
              (COND ((|HasCategory| |#1| '(|Monoid|)) (|spadConstant| $ 9))
                    ('T (|spadConstant| $ 10))))
    (COND
     ((|HasCategory| |#1| '(|noZeroDivisors|))
      (QSETREFV $ 17 (CONS (|dispatchFunction| |FM;*;R2$;3|) $)))
     ('T (QSETREFV $ 17 (CONS (|dispatchFunction| |FM;*;R2$;4|) $))))
    (COND
     ((|HasCategory| |#1| '(|noZeroDivisors|))
      (QSETREFV $ 19 (CONS (|dispatchFunction| |FM;*;$R$;5|) $)))
     ('T (QSETREFV $ 19 (CONS (|dispatchFunction| |FM;*;$R$;6|) $))))
    (COND
     ((|HasCategory| |#1| '(|Monoid|))
      (QSETREFV $ 30 (CONS (|dispatchFunction| |FM;coerce;$Of;9|) $)))
     ('T (QSETREFV $ 30 (CONS (|dispatchFunction| |FM;coerce;$Of;10|) $))))
    (COND
     ((|testBitVector| |pv$| 7)
      (PROGN
       (QSETREFV $ 42 (CONS (|dispatchFunction| |FM;retractIfCan;$U;15|) $))
       (QSETREFV $ 43 (CONS (|dispatchFunction| |FM;retract;$S;16|) $))
       (QSETREFV $ 44 (CONS (|dispatchFunction| |FM;coerce;S$;17|) $)))))
    (COND
     ((|testBitVector| |pv$| 8)
      (QSETREFV $ 46 (CONS (|dispatchFunction| |FM;coefficient;$SR;18|) $)))
     ('T
      (QSETREFV $ 46 (CONS (|dispatchFunction| |FM;coefficient;$SR;19|) $))))
    (COND
     ((|testBitVector| |pv$| 2)
      (PROGN
       (QSETREFV $ 54
                 (CONS (|dispatchFunction| |FM;linearExtend;M$R;20|) $)))))
    $))) 

(MAKEPROP '|FreeModule| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|IndexedDirectProductObject| 6 7)
              (|local| |#1|) (|local| |#2|) '|Rep| (0 . |One|) (4 . |Zero|)
              '|r_one| (|Boolean|) (8 . |zero?|) (13 . |Zero|) (17 . =)
              (23 . *) (29 . *) (35 . ~=) (41 . *) |FM;*;RS$;7| |FM;*;SR$;8|
              (|OutputForm|) (47 . |coerce|) (52 . |coerce|) (57 . *) (63 . +)
              (|Mapping| 22 22 22) (|List| 22) (69 . |reduce|) (75 . |coerce|)
              (|List| 7) |FM;support;$L;11| (|List| 6) |FM;coefficients;$L;12|
              (|List| $) |FM;monomials;$L;14| (|NonNegativeInteger|)
              (80 . |numberOfMonomials|) (|Integer|) (85 . ~=)
              (|Union| 7 '"failed") (91 . |retractIfCan|) (96 . |retract|)
              (101 . |coerce|) (106 . |smaller?|) (112 . |coefficient|)
              (118 . =) (124 . |zero?|) (|Record| (|:| |k| 7) (|:| |c| 6))
              (|List| 49) (129 . |listOfTerms|) (134 . +) (|Mapping| 6 7)
              (140 . |linearExtend|) (|Union| $ '"failed") (|Mapping| 6 6)
              (|PositiveInteger|) (|HashState|) (|String|) (|SingleInteger|))
           '#(|zero?| 146 |support| 151 |retractIfCan| 156 |retract| 161
              |numberOfMonomials| 166 |monomials| 171 |listOfTerms| 176
              |linearExtend| 181 |coerce| 187 |coefficients| 197 |coefficient|
              202 |Zero| 208 * 212)
           'NIL
           (CONS
            (|makeByteWordVec2| 9
                                '(0 0 2 0 0 5 0 0 0 5 1 6 4 6 3 6 0 9 0 7 0 0 6
                                  7))
            (CONS
             '#(|FreeModuleCategory&| NIL |Module&| NIL NIL NIL NIL NIL NIL NIL
                |AbelianGroup&| NIL NIL NIL |AbelianMonoid&| |OrderedSet&|
                |AbelianSemiGroup&| NIL |SetCategory&| |RetractableTo&|
                |BasicType&| NIL |PartialOrder&| NIL)
             (CONS
              '#((|FreeModuleCategory| 6 7)
                 (|IndexedDirectProductCategory| 6 7) (|Module| 6)
                 (|IndexedProductCategory| 6 7) (|BiModule| 6 6)
                 (|OrderedAbelianMonoidSup|) (|AbelianProductCategory| 6)
                 (|LeftModule| 6) (|RightModule| 6)
                 (|OrderedCancellationAbelianMonoid|) (|AbelianGroup|)
                 (|OrderedAbelianMonoid|) (|CancellationAbelianMonoid|)
                 (|OrderedAbelianSemiGroup|) (|AbelianMonoid|) (|OrderedSet|)
                 (|AbelianSemiGroup|) (|Comparable|) (|SetCategory|)
                 (|RetractableTo| 7) (|BasicType|) (|CoercibleTo| 22)
                 (|PartialOrder|) (|CoercibleFrom| 7))
              (|makeByteWordVec2| 54
                                  '(0 6 0 9 0 6 0 10 1 6 12 0 13 0 0 0 14 2 6
                                    12 0 0 15 2 6 0 0 0 16 2 0 0 6 0 17 2 6 12
                                    0 0 18 2 0 0 0 6 19 1 6 22 0 23 1 7 22 0 24
                                    2 22 0 0 0 25 2 22 0 0 0 26 2 28 22 27 0 29
                                    1 0 22 0 30 1 0 37 0 38 2 39 12 0 0 40 1 0
                                    41 0 42 1 0 7 0 43 1 0 0 7 44 2 7 12 0 0 45
                                    2 0 6 0 7 46 2 7 12 0 0 47 1 0 12 0 48 1 0
                                    50 0 51 2 6 0 0 0 52 2 0 6 53 0 54 1 10 12
                                    0 48 1 0 31 0 32 1 7 41 0 42 1 7 7 0 43 1 0
                                    37 0 38 1 0 35 0 36 1 0 50 0 51 2 2 6 53 0
                                    54 1 7 0 7 44 1 0 22 0 30 1 0 33 0 34 2 0 6
                                    0 7 46 0 10 0 14 2 0 0 7 6 21 2 0 0 6 7 20
                                    2 0 0 0 6 19 2 0 0 6 0 17)))))
           '|lookupIncomplete|)) 
