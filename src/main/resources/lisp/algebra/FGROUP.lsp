
(SDEFUN |FGROUP;One;$;1| (($ ($))) (SPADCALL (QREFELT $ 9))) 

(SDEFUN |FGROUP;one?;$B;2| ((|f| ($)) ($ (|Boolean|)))
        (NULL (SPADCALL |f| (QREFELT $ 12)))) 

(SDEFUN |FGROUP;^;SI$;3| ((|s| (S)) (|n| (|Integer|)) ($ ($)))
        (SPADCALL |s| |n| (QREFELT $ 16))) 

(SDEFUN |FGROUP;*;$S$;4| ((|f| ($)) (|s| (S)) ($ ($)))
        (SPADCALL |f| |s| (QREFELT $ 18))) 

(SDEFUN |FGROUP;*;S2$;5| ((|s| (S)) (|f| ($)) ($ ($)))
        (SPADCALL |s| |f| (QREFELT $ 20))) 

(SDEFUN |FGROUP;inv;2$;6| ((|f| ($)) ($ ($)))
        (SPADCALL (SPADCALL (ELT $ 22) |f| (QREFELT $ 24)) (QREFELT $ 25))) 

(SDEFUN |FGROUP;factors;$L;7|
        ((|f| ($))
         ($ (|List| (|Record| (|:| |gen| S) (|:| |exp| (|Integer|))))))
        (SPADCALL (SPADCALL |f| (QREFELT $ 12)) (QREFELT $ 27))) 

(SDEFUN |FGROUP;mapExpon;M2$;8|
        ((|f| (|Mapping| (|Integer|) (|Integer|))) (|x| ($)) ($ ($)))
        (SPADCALL |f| |x| (QREFELT $ 29))) 

(SDEFUN |FGROUP;mapGen;M2$;9| ((|f| (|Mapping| S S)) (|x| ($)) ($ ($)))
        (SPADCALL |f| |x| (QREFELT $ 31))) 

(SDEFUN |FGROUP;coerce;$Of;10| ((|f| ($)) ($ (|OutputForm|)))
        (SPADCALL |f| (ELT $ 34) (ELT $ 35) 1 (QREFELT $ 37))) 

(SDEFUN |FGROUP;*;3$;11| ((|f| ($)) (|g| ($)) ($ ($)))
        (SPROG
         ((|h| (|List| (|Record| (|:| |gen| S) (|:| |exp| (|Integer|)))))
          (|newexp| (|Integer|))
          (|q| (|List| (|Record| (|:| |gen| S) (|:| |exp| (|Integer|)))))
          (|r| (|List| (|Record| (|:| |gen| S) (|:| |exp| (|Integer|))))))
         (SEQ
          (COND ((SPADCALL |f| (QREFELT $ 14)) |g|)
                ((SPADCALL |g| (QREFELT $ 14)) |f|)
                (#1='T
                 (SEQ (LETT |r| (REVERSE (SPADCALL |f| (QREFELT $ 12))))
                      (LETT |q|
                            (SPADCALL (SPADCALL |g| (QREFELT $ 12))
                                      (QREFELT $ 27)))
                      (SEQ G190
                           (COND
                            ((NULL
                              (COND
                               ((OR (NULL |r|) (NULL |q|)
                                    (NULL
                                     (SPADCALL (QCAR (|SPADfirst| |r|))
                                               (QCAR (|SPADfirst| |q|))
                                               (QREFELT $ 39))))
                                NIL)
                               ('T
                                (EQL (QCDR (|SPADfirst| |r|))
                                     (- (QCDR (|SPADfirst| |q|)))))))
                             (GO G191)))
                           (SEQ (LETT |r| (CDR |r|))
                                (EXIT (LETT |q| (CDR |q|))))
                           NIL (GO G190) G191 (EXIT NIL))
                      (EXIT
                       (COND ((NULL |r|) (SPADCALL |q| (QREFELT $ 40)))
                             ((NULL |q|)
                              (SPADCALL (NREVERSE |r|) (QREFELT $ 40)))
                             ((SPADCALL (QCAR (|SPADfirst| |r|))
                                        (QCAR (|SPADfirst| |q|))
                                        (QREFELT $ 39))
                              (SEQ
                               (LETT |newexp|
                                     (+ (QCDR (|SPADfirst| |q|))
                                        (QCDR (|SPADfirst| |r|))))
                               (SPADCALL (LETT |h| (NREVERSE |r|))
                                         (CONS (QCAR (|SPADfirst| |q|))
                                               |newexp|)
                                         (QREFELT $ 41))
                               (EXIT
                                (SPADCALL
                                 (SPADCALL |h| (CDR |q|) (QREFELT $ 42))
                                 (QREFELT $ 40)))))
                             (#1#
                              (SPADCALL
                               (SPADCALL (NREVERSE |r|) |q| (QREFELT $ 42))
                               (QREFELT $ 40))))))))))) 

(SDEFUN |FGROUP;smaller?;2$B;12| ((|a| ($)) (|b| ($)) ($ (|Boolean|)))
        (SPROG
         ((|lb| #1=(|List| (|Record| (|:| |gen| S) (|:| |exp| (|Integer|)))))
          (|la| #1#) (#2=#:G768 NIL) (|nb| (|Integer|)) (|na| (|Integer|)))
         (SEQ
          (EXIT
           (SEQ (LETT |la| (SPADCALL |a| (QREFELT $ 12)))
                (LETT |lb| (SPADCALL |b| (QREFELT $ 12)))
                (LETT |na| (LENGTH |la|)) (LETT |nb| (LENGTH |lb|))
                (EXIT
                 (COND ((< |na| |nb|) (PROGN (LETT #2# 'T) (GO #3=#:G767)))
                       ((< |nb| |na|) (PROGN (LETT #2# NIL) (GO #3#)))
                       ('T
                        (SEQ
                         (SEQ G190 (COND ((NULL (NULL (NULL |la|))) (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((SPADCALL (QCAR (|SPADfirst| |la|))
                                            (QCAR (|SPADfirst| |lb|))
                                            (QREFELT $ 44))
                                  (PROGN (LETT #2# 'T) (GO #3#)))
                                 ((SPADCALL (QCAR (|SPADfirst| |lb|))
                                            (QCAR (|SPADfirst| |la|))
                                            (QREFELT $ 44))
                                  (PROGN (LETT #2# NIL) (GO #3#)))
                                 ((< (QCDR (|SPADfirst| |la|))
                                     (QCDR (|SPADfirst| |lb|)))
                                  (PROGN (LETT #2# 'T) (GO #3#)))
                                 ((< (QCDR (|SPADfirst| |lb|))
                                     (QCDR (|SPADfirst| |la|)))
                                  (PROGN (LETT #2# NIL) (GO #3#)))
                                 ('T
                                  (SEQ (LETT |la| (CDR |la|))
                                       (EXIT (LETT |lb| (CDR |lb|))))))))
                              NIL (GO G190) G191 (EXIT NIL))
                         (EXIT NIL)))))))
          #3# (EXIT #2#)))) 

(DECLAIM (NOTINLINE |FreeGroup;|)) 

(DEFUN |FreeGroup| (#1=#:G779)
  (SPROG NIL
         (PROG (#2=#:G780)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|FreeGroup|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|FreeGroup;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|FreeGroup|)))))))))) 

(DEFUN |FreeGroup;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|FreeGroup| DV$1))
          (LETT $ (GETREFV 53))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|Comparable|))))))
          (|haddProp| |$ConstructorCache| '|FreeGroup| (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 8 (|ListMonoidOps| |#1| (|Integer|) 1))
          (COND
           ((|testBitVector| |pv$| 1)
            (QSETREFV $ 45
                      (CONS (|dispatchFunction| |FGROUP;smaller?;2$B;12|) $))))
          $))) 

(MAKEPROP '|FreeGroup| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|ListMonoidOps| 6 15 (NRTEVAL 1))
              (|local| |#1|)
              (CONS IDENTITY (FUNCALL (|dispatchFunction| |FGROUP;One;$;1|) $))
              '|Rep| (0 . |makeUnit|) (|Record| (|:| |gen| 6) (|:| |exp| 15))
              (|List| 10) (4 . |listOfMonoms|) (|Boolean|) |FGROUP;one?;$B;2|
              (|Integer|) (9 . |makeTerm|) |FGROUP;^;SI$;3| (15 . |rightMult|)
              |FGROUP;*;$S$;4| (21 . |leftMult|) |FGROUP;*;S2$;5| (27 . -)
              (|Mapping| 15 15) |FGROUP;mapExpon;M2$;8| (32 . |reverse!|)
              |FGROUP;inv;2$;6| (37 . |copy|) |FGROUP;factors;$L;7|
              (42 . |mapExpon|) (|Mapping| 6 6) (48 . |mapGen|)
              |FGROUP;mapGen;M2$;9| (|OutputForm|) (54 . *) (60 . ^)
              (|Mapping| 33 33 33) (66 . |outputForm|) |FGROUP;coerce;$Of;10|
              (74 . =) (80 . |makeMulti|) (85 . |setlast!|) (91 . |concat!|)
              |FGROUP;*;3$;11| (97 . |smaller?|) (103 . |smaller?|)
              (|NonNegativeInteger|) (|Union| 6 '"failed")
              (|Union| $ '"failed") (|PositiveInteger|) (|String|)
              (|SingleInteger|) (|HashState|))
           '#(~= 109 |smaller?| 115 |size| 121 |sample| 126 |rightRecip| 130
              |rightPower| 135 |retractIfCan| 147 |retract| 152 |recip| 157
              |one?| 162 |nthFactor| 167 |nthExpon| 173 |mapGen| 179 |mapExpon|
              185 |leftRecip| 191 |leftPower| 196 |latex| 208 |inv| 213
              |hashUpdate!| 218 |hash| 224 |factors| 229 |conjugate| 234
              |commutator| 240 |coerce| 246 ^ 256 |One| 280 = 284 / 290 * 296)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 1 0 0 0 0 0 0 0))
                 (CONS
                  '#(|Group&| NIL NIL |MagmaWithUnit&| |Magma&| NIL
                     |RetractableTo&| |SetCategory&| NIL NIL NIL |BasicType&|
                     NIL)
                  (CONS
                   '#((|Group|) (|Monoid|) (|SemiGroup|) (|MagmaWithUnit|)
                      (|Magma|) (|Comparable|) (|RetractableTo| 6)
                      (|SetCategory|) (|CoercibleFrom| 6) (|unitsKnown|)
                      (|TwoSidedRecip|) (|BasicType|) (|CoercibleTo| 33))
                   (|makeByteWordVec2| 52
                                       '(0 8 0 9 1 8 11 0 12 2 8 0 6 15 16 2 8
                                         0 0 6 18 2 8 0 6 0 20 1 15 0 0 22 1 8
                                         0 0 25 1 11 0 0 27 2 8 0 23 0 29 2 8 0
                                         30 0 31 2 33 0 0 0 34 2 33 0 0 0 35 4
                                         8 33 0 36 36 15 37 2 6 13 0 0 39 1 8 0
                                         11 40 2 11 10 0 10 41 2 11 0 0 0 42 2
                                         6 13 0 0 44 2 0 13 0 0 45 2 0 13 0 0 1
                                         2 1 13 0 0 45 1 0 46 0 1 0 0 0 1 1 0
                                         48 0 1 2 0 0 0 46 1 2 0 0 0 49 1 1 0
                                         47 0 1 1 0 6 0 1 1 0 48 0 1 1 0 13 0
                                         14 2 0 6 0 15 1 2 0 15 0 15 1 2 0 0 30
                                         0 32 2 0 0 23 0 24 1 0 48 0 1 2 0 0 0
                                         46 1 2 0 0 0 49 1 1 0 50 0 1 1 0 0 0
                                         26 2 0 52 52 0 1 1 0 51 0 1 1 0 11 0
                                         28 2 0 0 0 0 1 2 0 0 0 0 1 1 0 0 6 1 1
                                         0 33 0 38 2 0 0 6 15 17 2 0 0 0 15 1 2
                                         0 0 0 46 1 2 0 0 0 49 1 0 0 0 7 2 0 13
                                         0 0 1 2 0 0 0 0 1 2 0 0 6 0 21 2 0 0 0
                                         6 19 2 0 0 0 0 43)))))
           '|lookupComplete|)) 
