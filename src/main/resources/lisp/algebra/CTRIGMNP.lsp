
(SDEFUN |CTRIGMNP;real;FE;1| ((|f| (F)) ($ (|Expression| R)))
        (SPADCALL (SPADCALL |f| (QREFELT $ 10)) (QREFELT $ 12))) 

(SDEFUN |CTRIGMNP;imag;FE;2| ((|f| (F)) ($ (|Expression| R)))
        (SPADCALL (SPADCALL |f| (QREFELT $ 10)) (QREFELT $ 14))) 

(SDEFUN |CTRIGMNP;rreal?| ((|r| (|Complex| R)) ($ (|Boolean|)))
        (SPADCALL (SPADCALL |r| (QREFELT $ 17)) (QREFELT $ 19))) 

(SDEFUN |CTRIGMNP;kreal?| ((|k| (|Kernel| F)) ($ (|Boolean|)))
        (SPADCALL (ELT $ 20) (SPADCALL |k| (QREFELT $ 23)) (QREFELT $ 25))) 

(SDEFUN |CTRIGMNP;complexForm;FC;5|
        ((|f| (F)) ($ (|Complex| (|Expression| R))))
        (SPADCALL |f| (QREFELT $ 27))) 

(SDEFUN |CTRIGMNP;trigs;2F;6| ((|f| (F)) ($ (F)))
        (SPADCALL (SPADCALL |f| (QREFELT $ 27)) (QREFELT $ 28))) 

(SDEFUN |CTRIGMNP;real?;FB;7| ((|f| (F)) ($ (|Boolean|)))
        (COND
         ((SPADCALL (CONS (|function| |CTRIGMNP;rreal?|) $)
                    (SPADCALL (SPADCALL |f| (QREFELT $ 31)) (QREFELT $ 34))
                    (QREFELT $ 36))
          (COND
           ((SPADCALL (CONS (|function| |CTRIGMNP;rreal?|) $)
                      (SPADCALL (SPADCALL |f| (QREFELT $ 37)) (QREFELT $ 34))
                      (QREFELT $ 36))
            (SPADCALL (CONS (|function| |CTRIGMNP;kreal?|) $)
                      (SPADCALL |f| (QREFELT $ 39)) (QREFELT $ 42)))
           (#1='T NIL)))
         (#1# NIL))) 

(SDEFUN |CTRIGMNP;localexplogs| ((|f| (F)) (|g| (F)) ($ (F)))
        (SPROG ((#1=#:G730 NIL) (|k| NIL) (#2=#:G729 NIL))
               (SEQ
                (SPADCALL |g|
                          (PROGN
                           (LETT #2# NIL)
                           (SEQ (LETT |k| NIL)
                                (LETT #1# (SPADCALL |f| (QREFELT $ 43))) G190
                                (COND
                                 ((OR (ATOM #1#)
                                      (PROGN (LETT |k| (CAR #1#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (COND
                                   ((COND
                                     ((SPADCALL |k| '|tan| (QREFELT $ 45)) 'T)
                                     ('T (SPADCALL |k| '|cot| (QREFELT $ 45))))
                                    (LETT #2# (CONS |k| #2#))))))
                                (LETT #1# (CDR #1#)) (GO G190) G191
                                (EXIT (NREVERSE #2#))))
                          (QREFELT $ 46))))) 

(SDEFUN |CTRIGMNP;complexElementary;2F;9| ((|f| (F)) ($ (F)))
        (SPROG ((|g| (F)))
               (COND
                ((SPADCALL
                  (CONS #'|CTRIGMNP;complexElementary;2F;9!0|
                        (VECTOR $ (QREFELT $ 8)))
                  (SPADCALL (LETT |g| (SPADCALL |f| (QREFELT $ 50)))
                            (QREFELT $ 52))
                  (QREFELT $ 54))
                 (|CTRIGMNP;localexplogs| |f| |g| $))
                ('T |g|)))) 

(SDEFUN |CTRIGMNP;complexElementary;2F;9!0| ((|x| NIL) ($$ NIL))
        (PROG (RTRIG $)
          (LETT RTRIG (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x| RTRIG (QREFELT $ 48)))))) 

(SDEFUN |CTRIGMNP;complexElementary;FSF;10|
        ((|f| (F)) (|x| (|Symbol|)) ($ (F)))
        (SPROG ((#1=#:G740 NIL) (|g| (F)) (|k| NIL) (#2=#:G739 NIL))
               (SEQ
                (COND
                 ((SPADCALL
                   (CONS #'|CTRIGMNP;complexElementary;FSF;10!0|
                         (VECTOR (QREFELT $ 8) $))
                   (PROGN
                    (LETT #2# NIL)
                    (SEQ (LETT |k| NIL)
                         (LETT #1#
                               (SPADCALL
                                (LETT |g| (SPADCALL |f| |x| (QREFELT $ 57)))
                                (QREFELT $ 43)))
                         G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |k| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL |x|
                                       (SPADCALL (SPADCALL |k| (QREFELT $ 59))
                                                 (QREFELT $ 61))
                                       (QREFELT $ 62))
                             (LETT #2# (CONS |k| #2#))))))
                         (LETT #1# (CDR #1#)) (GO G190) G191
                         (EXIT (NREVERSE #2#))))
                   (QREFELT $ 63))
                  (|CTRIGMNP;localexplogs| |f| |g| $))
                 ('T |g|))))) 

(SDEFUN |CTRIGMNP;complexElementary;FSF;10!0| ((|y| NIL) ($$ NIL))
        (PROG ($ RTRIG)
          (LETT $ (QREFELT $$ 1))
          (LETT RTRIG (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |y| (QREFELT $ 56)) RTRIG (QREFELT $ 48)))))) 

(SDEFUN |CTRIGMNP;complexNormalize;FSF;11| ((|f| (F)) (|x| (|Symbol|)) ($ (F)))
        (SPROG ((#1=#:G748 NIL) (|g| (F)) (|k| NIL) (#2=#:G747 NIL))
               (SEQ
                (COND
                 ((SPADCALL
                   (CONS #'|CTRIGMNP;complexNormalize;FSF;11!0|
                         (VECTOR (QREFELT $ 8) $))
                   (PROGN
                    (LETT #2# NIL)
                    (SEQ (LETT |k| NIL)
                         (LETT #1#
                               (SPADCALL
                                (LETT |g| (SPADCALL |f| |x| (QREFELT $ 57)))
                                (QREFELT $ 43)))
                         G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |k| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL |x|
                                       (SPADCALL (SPADCALL |k| (QREFELT $ 59))
                                                 (QREFELT $ 61))
                                       (QREFELT $ 62))
                             (LETT #2# (CONS |k| #2#))))))
                         (LETT #1# (CDR #1#)) (GO G190) G191
                         (EXIT (NREVERSE #2#))))
                   (QREFELT $ 63))
                  (QVELT
                   (SPADCALL (|CTRIGMNP;localexplogs| |f| |g| $) |x|
                             (QREFELT $ 66))
                   0))
                 ('T (QVELT (SPADCALL |g| |x| (QREFELT $ 66)) 0)))))) 

(SDEFUN |CTRIGMNP;complexNormalize;FSF;11!0| ((|y| NIL) ($$ NIL))
        (PROG ($ RTRIG)
          (LETT $ (QREFELT $$ 1))
          (LETT RTRIG (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |y| (QREFELT $ 56)) RTRIG (QREFELT $ 48)))))) 

(SDEFUN |CTRIGMNP;complexNormalize;2F;12| ((|f| (F)) ($ (F)))
        (SPROG ((|h| (F)) (|g| (F)))
               (SEQ (LETT |g| (SPADCALL |f| (QREFELT $ 50)))
                    (EXIT
                     (COND
                      ((SPADCALL
                        (CONS #'|CTRIGMNP;complexNormalize;2F;12!0|
                              (VECTOR $ (QREFELT $ 8)))
                        (SPADCALL |g| (QREFELT $ 52)) (QREFELT $ 54))
                       (SEQ (LETT |h| (|CTRIGMNP;localexplogs| |f| |g| $))
                            (EXIT
                             (QVELT (SPADCALL |h| NIL (QREFELT $ 68)) 0))))
                      ('T (QVELT (SPADCALL |g| NIL (QREFELT $ 68)) 0))))))) 

(SDEFUN |CTRIGMNP;complexNormalize;2F;12!0| ((|y| NIL) ($$ NIL))
        (PROG (RTRIG $)
          (LETT RTRIG (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |y| RTRIG (QREFELT $ 48)))))) 

(DECLAIM (NOTINLINE |ComplexTrigonometricManipulations;|)) 

(DEFUN |ComplexTrigonometricManipulations| (&REST #1=#:G754)
  (SPROG NIL
         (PROG (#2=#:G755)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|ComplexTrigonometricManipulations|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |ComplexTrigonometricManipulations;|)
                             #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|ComplexTrigonometricManipulations|)))))))))) 

(DEFUN |ComplexTrigonometricManipulations;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|ComplexTrigonometricManipulations| DV$1 DV$2))
          (LETT $ (GETREFV 70))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ComplexTrigonometricManipulations|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 8 '|rtrig|)
          $))) 

(MAKEPROP '|ComplexTrigonometricManipulations| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) 'RTRIG
              (|Complex| 11) |CTRIGMNP;complexForm;FC;5| (|Expression| 6)
              (0 . |real|) |CTRIGMNP;real;FE;1| (5 . |imag|)
              |CTRIGMNP;imag;FE;2| (|Complex| 6) (10 . |imag|) (|Boolean|)
              (15 . |zero?|) |CTRIGMNP;real?;FB;7| (|List| 7) (|Kernel| 7)
              (20 . |argument|) (|Mapping| 18 7) (25 . |every?|)
              (|InnerTrigonometricManipulations| 6 11 7) (31 . |explogs2trigs|)
              (36 . GF2FG) |CTRIGMNP;trigs;2F;6|
              (|SparseMultivariatePolynomial| 16 58) (41 . |numer|) (|List| 16)
              (|SparseMultivariatePolynomial| 16 22) (46 . |coefficients|)
              (|Mapping| 18 16) (51 . |every?|) (57 . |denom|) (|List| 58)
              (62 . |kernels|) (|Mapping| 18 22) (|List| 22) (67 . |every?|)
              (73 . |tower|) (|Symbol|) (78 . |is?|) (84 . |trigs2explogs|)
              (|BasicOperator|) (90 . |has?|)
              (|ElementaryFunctionStructurePackage| 16 7)
              (96 . |realElementary|) (|List| 47) (101 . |operators|)
              (|Mapping| 18 47) (106 . |any?|)
              |CTRIGMNP;complexElementary;2F;9| (112 . |operator|)
              (117 . |realElementary|) (|Kernel| $) (123 . |coerce|)
              (|List| 44) (128 . |variables|) (133 . |member?|) (139 . |any?|)
              |CTRIGMNP;complexElementary;FSF;10|
              (|Record| (|:| |func| 7) (|:| |kers| 41) (|:| |vals| 21))
              (145 . |rischNormalize|) |CTRIGMNP;complexNormalize;FSF;11|
              (151 . |rischNormalize|) |CTRIGMNP;complexNormalize;2F;12|)
           '#(|trigs| 157 |real?| 162 |real| 167 |imag| 172 |complexNormalize|
              177 |complexForm| 188 |complexElementary| 193)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|complexNormalize| (|#2| |#2|)) T)
                                   '((|complexNormalize|
                                      (|#2| |#2| (|Symbol|)))
                                     T)
                                   '((|complexElementary| (|#2| |#2|)) T)
                                   '((|complexElementary|
                                      (|#2| |#2| (|Symbol|)))
                                     T)
                                   '((|real| ((|Expression| |#1|) |#2|)) T)
                                   '((|imag| ((|Expression| |#1|) |#2|)) T)
                                   '((|real?| ((|Boolean|) |#2|)) T)
                                   '((|trigs| (|#2| |#2|)) T)
                                   '((|complexForm|
                                      ((|Complex| (|Expression| |#1|)) |#2|))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 69
                                            '(1 9 11 0 12 1 9 11 0 14 1 16 6 0
                                              17 1 6 18 0 19 1 22 21 0 23 2 21
                                              18 24 0 25 1 26 9 7 27 1 26 7 9
                                              28 1 7 30 0 31 1 33 32 0 34 2 32
                                              18 35 0 36 1 7 30 0 37 1 7 38 0
                                              39 2 41 18 40 0 42 1 7 38 0 43 2
                                              22 18 0 44 45 2 26 7 7 41 46 2 47
                                              18 0 44 48 1 49 7 7 50 1 7 51 0
                                              52 2 51 18 53 0 54 1 22 47 0 56 2
                                              49 7 7 44 57 1 7 0 58 59 1 7 60 0
                                              61 2 60 18 44 0 62 2 41 18 40 0
                                              63 2 49 65 7 44 66 2 49 65 7 60
                                              68 1 0 7 7 29 1 0 18 7 20 1 0 11
                                              7 13 1 0 11 7 15 2 0 7 7 44 67 1
                                              0 7 7 69 1 0 9 7 10 2 0 7 7 44 64
                                              1 0 7 7 55)))))
           '|lookupComplete|)) 
