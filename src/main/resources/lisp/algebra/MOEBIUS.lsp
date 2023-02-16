
(PUT '|MOEBIUS;moebius;4F$;1| '|SPADreplace| 'VECTOR) 

(SDEFUN |MOEBIUS;moebius;4F$;1|
        ((|aa| (F)) (|bb| (F)) (|cc| (F)) (|dd| (F)) ($ ($)))
        (VECTOR |aa| |bb| |cc| |dd|)) 

(PUT '|MOEBIUS;a| '|SPADreplace| '(XLAM (|t|) (QVELT |t| 0))) 

(SDEFUN |MOEBIUS;a| ((|t| ($)) ($ (F))) (QVELT |t| 0)) 

(PUT '|MOEBIUS;b| '|SPADreplace| '(XLAM (|t|) (QVELT |t| 1))) 

(SDEFUN |MOEBIUS;b| ((|t| ($)) ($ (F))) (QVELT |t| 1)) 

(PUT '|MOEBIUS;c| '|SPADreplace| '(XLAM (|t|) (QVELT |t| 2))) 

(SDEFUN |MOEBIUS;c| ((|t| ($)) ($ (F))) (QVELT |t| 2)) 

(PUT '|MOEBIUS;d| '|SPADreplace| '(XLAM (|t|) (QVELT |t| 3))) 

(SDEFUN |MOEBIUS;d| ((|t| ($)) ($ (F))) (QVELT |t| 3)) 

(SDEFUN |MOEBIUS;One;$;6| (($ ($)))
        (SPADCALL (|spadConstant| $ 10) (|spadConstant| $ 11)
                  (|spadConstant| $ 11) (|spadConstant| $ 10) (QREFELT $ 8))) 

(SDEFUN |MOEBIUS;*;3$;7| ((|t| ($)) (|s| ($)) ($ ($)))
        (SPADCALL
         (SPADCALL
          (SPADCALL (|MOEBIUS;b| |t| $) (|MOEBIUS;c| |s| $) (QREFELT $ 12))
          (SPADCALL (|MOEBIUS;a| |t| $) (|MOEBIUS;a| |s| $) (QREFELT $ 12))
          (QREFELT $ 13))
         (SPADCALL
          (SPADCALL (|MOEBIUS;b| |t| $) (|MOEBIUS;d| |s| $) (QREFELT $ 12))
          (SPADCALL (|MOEBIUS;a| |t| $) (|MOEBIUS;b| |s| $) (QREFELT $ 12))
          (QREFELT $ 13))
         (SPADCALL
          (SPADCALL (|MOEBIUS;d| |t| $) (|MOEBIUS;c| |s| $) (QREFELT $ 12))
          (SPADCALL (|MOEBIUS;c| |t| $) (|MOEBIUS;a| |s| $) (QREFELT $ 12))
          (QREFELT $ 13))
         (SPADCALL
          (SPADCALL (|MOEBIUS;d| |t| $) (|MOEBIUS;d| |s| $) (QREFELT $ 12))
          (SPADCALL (|MOEBIUS;c| |t| $) (|MOEBIUS;b| |s| $) (QREFELT $ 12))
          (QREFELT $ 13))
         (QREFELT $ 8))) 

(SDEFUN |MOEBIUS;inv;2$;8| ((|t| ($)) ($ ($)))
        (SPADCALL (|MOEBIUS;d| |t| $)
                  (SPADCALL (|MOEBIUS;b| |t| $) (QREFELT $ 15))
                  (SPADCALL (|MOEBIUS;c| |t| $) (QREFELT $ 15))
                  (|MOEBIUS;a| |t| $) (QREFELT $ 8))) 

(SDEFUN |MOEBIUS;shift;F$;9| ((|f| (F)) ($ ($)))
        (SPADCALL (|spadConstant| $ 10) |f| (|spadConstant| $ 11)
                  (|spadConstant| $ 10) (QREFELT $ 8))) 

(SDEFUN |MOEBIUS;scale;F$;10| ((|f| (F)) ($ ($)))
        (SPADCALL |f| (|spadConstant| $ 11) (|spadConstant| $ 11)
                  (|spadConstant| $ 10) (QREFELT $ 8))) 

(SDEFUN |MOEBIUS;recip;$;11| (($ ($)))
        (SPADCALL (|spadConstant| $ 11) (|spadConstant| $ 10)
                  (|spadConstant| $ 10) (|spadConstant| $ 11) (QREFELT $ 8))) 

(SDEFUN |MOEBIUS;shift;$F$;12| ((|t| ($)) (|f| (F)) ($ ($)))
        (SPADCALL
         (SPADCALL (|MOEBIUS;a| |t| $)
                   (SPADCALL |f| (|MOEBIUS;c| |t| $) (QREFELT $ 12))
                   (QREFELT $ 13))
         (SPADCALL (|MOEBIUS;b| |t| $)
                   (SPADCALL |f| (|MOEBIUS;d| |t| $) (QREFELT $ 12))
                   (QREFELT $ 13))
         (|MOEBIUS;c| |t| $) (|MOEBIUS;d| |t| $) (QREFELT $ 8))) 

(SDEFUN |MOEBIUS;scale;$F$;13| ((|t| ($)) (|f| (F)) ($ ($)))
        (SPADCALL (SPADCALL |f| (|MOEBIUS;a| |t| $) (QREFELT $ 12))
                  (SPADCALL |f| (|MOEBIUS;b| |t| $) (QREFELT $ 12))
                  (|MOEBIUS;c| |t| $) (|MOEBIUS;d| |t| $) (QREFELT $ 8))) 

(SDEFUN |MOEBIUS;recip;2$;14| ((|t| ($)) ($ ($)))
        (SPADCALL (|MOEBIUS;c| |t| $) (|MOEBIUS;d| |t| $) (|MOEBIUS;a| |t| $)
                  (|MOEBIUS;b| |t| $) (QREFELT $ 8))) 

(SDEFUN |MOEBIUS;eval;$2F;15| ((|t| ($)) (|f| (F)) ($ (F)))
        (SPADCALL
         (SPADCALL (SPADCALL (|MOEBIUS;a| |t| $) |f| (QREFELT $ 12))
                   (|MOEBIUS;b| |t| $) (QREFELT $ 13))
         (SPADCALL (SPADCALL (|MOEBIUS;c| |t| $) |f| (QREFELT $ 12))
                   (|MOEBIUS;d| |t| $) (QREFELT $ 13))
         (QREFELT $ 23))) 

(SDEFUN |MOEBIUS;eval;$2Opc;16|
        ((|t| ($)) (|f| (|OnePointCompletion| F)) ($ (|OnePointCompletion| F)))
        (SPROG ((|den| (F)) (|fff| (F)) (|ff| (|Union| F "failed")))
               (SEQ (LETT |ff| (SPADCALL |f| (QREFELT $ 27)))
                    (EXIT
                     (COND
                      ((QEQCAR |ff| 1)
                       (SPADCALL
                        (SPADCALL (|MOEBIUS;a| |t| $) (|MOEBIUS;c| |t| $)
                                  (QREFELT $ 23))
                        (QREFELT $ 28)))
                      ((SPADCALL
                        (LETT |den|
                              (SPADCALL
                               (SPADCALL (|MOEBIUS;c| |t| $)
                                         (LETT |fff| (QCDR |ff|))
                                         (QREFELT $ 12))
                               (|MOEBIUS;d| |t| $) (QREFELT $ 13)))
                        (QREFELT $ 30))
                       (SPADCALL (QREFELT $ 31)))
                      ('T
                       (SPADCALL
                        (SPADCALL
                         (SPADCALL
                          (SPADCALL (|MOEBIUS;a| |t| $) |fff| (QREFELT $ 12))
                          (|MOEBIUS;b| |t| $) (QREFELT $ 13))
                         |den| (QREFELT $ 23))
                        (QREFELT $ 28)))))))) 

(SDEFUN |MOEBIUS;coerce;$Of;17| ((|t| ($)) ($ (|OutputForm|)))
        (SPROG ((|den| #1=(|OutputForm|)) (|num| #1#) (|var| (|OutputForm|)))
               (SEQ (LETT |var| (SPADCALL "%x" (QREFELT $ 35)))
                    (LETT |num|
                          (SPADCALL
                           (SPADCALL
                            (SPADCALL (|MOEBIUS;a| |t| $) (QREFELT $ 36)) |var|
                            (QREFELT $ 37))
                           (SPADCALL (|MOEBIUS;b| |t| $) (QREFELT $ 36))
                           (QREFELT $ 38)))
                    (LETT |den|
                          (SPADCALL
                           (SPADCALL
                            (SPADCALL (|MOEBIUS;c| |t| $) (QREFELT $ 36)) |var|
                            (QREFELT $ 37))
                           (SPADCALL (|MOEBIUS;d| |t| $) (QREFELT $ 36))
                           (QREFELT $ 38)))
                    (EXIT
                     (SPADCALL |var| (SPADCALL |num| |den| (QREFELT $ 39))
                               (QREFELT $ 40)))))) 

(SDEFUN |MOEBIUS;proportional?|
        ((|list1| (|List| F)) (|list2| (|List| F)) ($ (|Boolean|)))
        (SPROG ((|x2| (F)) (|x1| (F)))
               (COND ((NULL |list1|) (NULL |list2|)) ((NULL |list2|) NIL)
                     ((SPADCALL (LETT |x1| (|SPADfirst| |list1|))
                                (QREFELT $ 30))
                      (COND
                       ((SPADCALL (|SPADfirst| |list2|) (QREFELT $ 30))
                        (|MOEBIUS;proportional?| (CDR |list1|) (CDR |list2|)
                         $))
                       (#1='T NIL)))
                     ((SPADCALL (LETT |x2| (|SPADfirst| |list2|))
                                (QREFELT $ 30))
                      NIL)
                     (#1#
                      (SPADCALL
                       (SPADCALL
                        (CONS #'|MOEBIUS;proportional?!0| (VECTOR $ |x1|))
                        |list1| (QREFELT $ 44))
                       (SPADCALL
                        (CONS #'|MOEBIUS;proportional?!1| (VECTOR $ |x2|))
                        |list2| (QREFELT $ 44))
                       (QREFELT $ 45)))))) 

(SDEFUN |MOEBIUS;proportional?!1| ((|f1| NIL) ($$ NIL))
        (PROG (|x2| $)
          (LETT |x2| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |f1| |x2| (QREFELT $ 23)))))) 

(SDEFUN |MOEBIUS;proportional?!0| ((|f1| NIL) ($$ NIL))
        (PROG (|x1| $)
          (LETT |x1| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |f1| |x1| (QREFELT $ 23)))))) 

(SDEFUN |MOEBIUS;=;2$B;19| ((|t| ($)) (|s| ($)) ($ (|Boolean|)))
        (SPROG ((|list2| (|List| F)) (|list1| (|List| F)))
               (SEQ
                (LETT |list1|
                      (LIST (|MOEBIUS;a| |t| $) (|MOEBIUS;b| |t| $)
                            (|MOEBIUS;c| |t| $) (|MOEBIUS;d| |t| $)))
                (LETT |list2|
                      (LIST (|MOEBIUS;a| |s| $) (|MOEBIUS;b| |s| $)
                            (|MOEBIUS;c| |s| $) (|MOEBIUS;d| |s| $)))
                (EXIT (|MOEBIUS;proportional?| |list1| |list2| $))))) 

(DECLAIM (NOTINLINE |MoebiusTransform;|)) 

(DEFUN |MoebiusTransform| (#1=#:G758)
  (SPROG NIL
         (PROG (#2=#:G759)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|MoebiusTransform|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|MoebiusTransform;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|MoebiusTransform|)))))))))) 

(DEFUN |MoebiusTransform;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|MoebiusTransform| DV$1))
          (LETT $ (GETREFV 53))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|MoebiusTransform| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7
                    (|Record| (|:| |a| |#1|) (|:| |b| |#1|) (|:| |c| |#1|)
                              (|:| |d| |#1|)))
          $))) 

(MAKEPROP '|MoebiusTransform| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep|
              |MOEBIUS;moebius;4F$;1|
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |MOEBIUS;One;$;6|) $))
              (0 . |One|) (4 . |Zero|) (8 . *) (14 . +) |MOEBIUS;*;3$;7|
              (20 . -) |MOEBIUS;inv;2$;8| |MOEBIUS;shift;F$;9|
              |MOEBIUS;scale;F$;10| |MOEBIUS;recip;$;11| |MOEBIUS;shift;$F$;12|
              |MOEBIUS;scale;$F$;13| |MOEBIUS;recip;2$;14| (25 . /)
              |MOEBIUS;eval;$2F;15| (|Union| 6 '"failed")
              (|OnePointCompletion| 6) (31 . |retractIfCan|) (36 . |coerce|)
              (|Boolean|) (41 . |zero?|) (46 . |infinity|)
              |MOEBIUS;eval;$2Opc;16| (|String|) (|OutputForm|)
              (50 . |message|) (55 . |coerce|) (60 . *) (66 . +) (72 . /)
              (78 . |rarrow|) |MOEBIUS;coerce;$Of;17| (|Mapping| 6 6)
              (|List| 6) (84 . |map|) (90 . =) |MOEBIUS;=;2$B;19| (|Integer|)
              (|NonNegativeInteger|) (|Union| $ '"failed") (|PositiveInteger|)
              (|SingleInteger|) (|HashState|))
           '#(~= 96 |shift| 102 |scale| 113 |sample| 124 |rightRecip| 128
              |rightPower| 133 |recip| 145 |one?| 159 |moebius| 164 |leftRecip|
              172 |leftPower| 177 |latex| 189 |inv| 194 |hashUpdate!| 199
              |hash| 205 |eval| 210 |conjugate| 222 |commutator| 228 |coerce|
              234 ^ 239 |One| 257 = 261 / 267 * 273)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 0 0 0 0 0))
                 (CONS
                  '#(|Group&| NIL NIL |MagmaWithUnit&| |Magma&| |SetCategory&|
                     NIL NIL |BasicType&| NIL)
                  (CONS
                   '#((|Group|) (|Monoid|) (|SemiGroup|) (|MagmaWithUnit|)
                      (|Magma|) (|SetCategory|) (|unitsKnown|)
                      (|TwoSidedRecip|) (|BasicType|) (|CoercibleTo| 34))
                   (|makeByteWordVec2| 52
                                       '(0 6 0 10 0 6 0 11 2 6 0 0 0 12 2 6 0 0
                                         0 13 1 6 0 0 15 2 6 0 0 0 23 1 26 25 0
                                         27 1 26 0 6 28 1 6 29 0 30 0 26 0 31 1
                                         34 0 33 35 1 6 34 0 36 2 34 0 0 0 37 2
                                         34 0 0 0 38 2 34 0 0 0 39 2 34 0 0 0
                                         40 2 43 0 42 0 44 2 43 29 0 0 45 2 0
                                         29 0 0 1 2 0 0 0 6 20 1 0 0 6 17 2 0 0
                                         0 6 21 1 0 0 6 18 0 0 0 1 1 0 49 0 1 2
                                         0 0 0 48 1 2 0 0 0 50 1 1 0 0 0 22 0 0
                                         0 19 1 0 49 0 1 1 0 29 0 1 4 0 0 6 6 6
                                         6 8 1 0 49 0 1 2 0 0 0 48 1 2 0 0 0 50
                                         1 1 0 33 0 1 1 0 0 0 16 2 0 52 52 0 1
                                         1 0 51 0 1 2 0 6 0 6 24 2 0 26 0 26 32
                                         2 0 0 0 0 1 2 0 0 0 0 1 1 0 34 0 41 2
                                         0 0 0 47 1 2 0 0 0 48 1 2 0 0 0 50 1 0
                                         0 0 9 2 0 29 0 0 46 2 0 0 0 0 1 2 0 0
                                         0 0 14)))))
           '|lookupComplete|)) 
