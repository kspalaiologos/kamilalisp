
(SDEFUN |TRIGMNIP;K2KG|
        ((|k| (|Kernel| F)) ($ (|Kernel| (|Expression| (|Complex| R)))))
        (SPADCALL
         (SPADCALL
          (SPADCALL (|SPADfirst| (SPADCALL |k| (QREFELT $ 18))) (QREFELT $ 21))
          (QREFELT $ 22))
         (QREFELT $ 24))) 

(SDEFUN |TRIGMNIP;real?;FB;2| ((|f| (F)) ($ (|Boolean|)))
        (NULL (QCAR (|TRIGMNIP;complexKernels| |f| $)))) 

(SDEFUN |TRIGMNIP;real;2F;3| ((|f| (F)) ($ (F)))
        (SPADCALL (SPADCALL |f| (QREFELT $ 28)) (QREFELT $ 29))) 

(SDEFUN |TRIGMNIP;imag;2F;4| ((|f| (F)) ($ (F)))
        (SPADCALL (SPADCALL |f| (QREFELT $ 28)) (QREFELT $ 31))) 

(SDEFUN |TRIGMNIP;complexKernels|
        ((|f| (F))
         ($
          (|Record| (|:| |ker| (|List| (|Kernel| F))) (|:| |val| (|List| F)))))
        (SPROG
         ((|lv| (|List| F)) (|lk| (|List| (|Kernel| F)))
          (|u| (|Union| F "failed")) (#1=#:G738 NIL) (|k| NIL))
         (SEQ (LETT |lk| NIL) (LETT |lv| NIL)
              (SEQ (LETT |k| NIL) (LETT #1# (SPADCALL |f| (QREFELT $ 34))) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |k| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |u| (|TRIGMNIP;kcomplex| |k| $))
                        (EXIT
                         (COND
                          ((QEQCAR |u| 0)
                           (SEQ (LETT |lk| (CONS |k| |lk|))
                                (EXIT (LETT |lv| (CONS (QCDR |u|) |lv|))))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |lk| |lv|))))) 

(SDEFUN |TRIGMNIP;kcomplex| ((|k| (|Kernel| F)) ($ (|Union| F "failed")))
        (SPROG
         ((#1=#:G758 NIL) (|u| (|Union| (|Integer|) "failed")) (|a| (F))
          (#2=#:G757 NIL) (|n| (F)) (|arg| (|List| F))
          (|op| (|BasicOperator|)))
         (SEQ (LETT |op| (SPADCALL |k| (QREFELT $ 36)))
              (EXIT
               (COND
                ((SPADCALL |k| '|nthRoot| (QREFELT $ 38))
                 (SEQ
                  (EXIT
                   (SEQ (LETT |arg| (SPADCALL |k| (QREFELT $ 18)))
                        (COND
                         ((EVENP
                           (SPADCALL (LETT |n| (SPADCALL |arg| (QREFELT $ 39)))
                                     (QREFELT $ 41)))
                          (SEQ
                           (LETT |u|
                                 (SPADCALL (|SPADfirst| |arg|) (QREFELT $ 44)))
                           (EXIT
                            (COND
                             ((QEQCAR |u| 0)
                              (COND
                               ((< (QCDR |u|) 0)
                                (PROGN
                                 (LETT #2#
                                       (CONS 0
                                             (SPADCALL
                                              (SPADCALL |op| (QREFELT $ 12)
                                                        (SPADCALL |n|
                                                                  (SPADCALL 2
                                                                            (QREFELT
                                                                             $
                                                                             45))
                                                                  (QREFELT $
                                                                           46))
                                                        (QREFELT $ 47))
                                              (SPADCALL |op|
                                                        (SPADCALL
                                                         (|SPADfirst| |arg|)
                                                         (QREFELT $ 10))
                                                        |n| (QREFELT $ 47))
                                              (QREFELT $ 14))))
                                 (GO #3=#:G750))))))))))
                        (EXIT (CONS 1 "failed"))))
                  #3# (EXIT #2#)))
                ('T
                 (SEQ
                  (EXIT
                   (SEQ
                    (COND
                     ((SPADCALL |k| '|log| (QREFELT $ 38))
                      (SEQ
                       (LETT |u|
                             (SPADCALL
                              (LETT |a|
                                    (|SPADfirst|
                                     (SPADCALL |k| (QREFELT $ 18))))
                              (QREFELT $ 44)))
                       (EXIT
                        (COND
                         ((QEQCAR |u| 0)
                          (COND
                           ((< (QCDR |u|) 0)
                            (PROGN
                             (LETT #1#
                                   (CONS 0
                                         (SPADCALL
                                          (SPADCALL |op|
                                                    (SPADCALL |a|
                                                              (QREFELT $ 10))
                                                    (QREFELT $ 48))
                                          (QREFELT $ 15) (QREFELT $ 49))))
                             (GO #4=#:G754))))))))))
                    (EXIT (CONS 1 "failed"))))
                  #4# (EXIT #1#)))))))) 

(SDEFUN |TRIGMNIP;complexForm;FC;7| ((|f| (F)) ($ (|Complex| F)))
        (SPROG
         ((|l|
           (|Record| (|:| |ker| (|List| (|Kernel| F)))
                     (|:| |val| (|List| F)))))
         (COND
          ((NULL (QCAR (LETT |l| (|TRIGMNIP;complexKernels| |f| $))))
           (SPADCALL |f| (|spadConstant| $ 51) (QREFELT $ 52)))
          ('T
           (SPADCALL
            (|TRIGMNIP;locexplogs|
             (SPADCALL |f| (QCAR |l|) (QCDR |l|) (QREFELT $ 54)) $)
            (QREFELT $ 55)))))) 

(SDEFUN |TRIGMNIP;locexplogs| ((|f| (F)) ($ (|Expression| (|Complex| R))))
        (SPROG ((|g| (F)))
               (COND
                ((SPADCALL
                  (CONS #'|TRIGMNIP;locexplogs!0| (VECTOR $ (QREFELT $ 8)))
                  (SPADCALL (LETT |g| (SPADCALL |f| (QREFELT $ 58)))
                            (QREFELT $ 60))
                  (QREFELT $ 62))
                 (|TRIGMNIP;localexplogs| |f| |g| $))
                ('T (SPADCALL |g| (QREFELT $ 21)))))) 

(SDEFUN |TRIGMNIP;locexplogs!0| ((|x| NIL) ($$ NIL))
        (PROG (RTRIG $)
          (LETT RTRIG (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x| RTRIG (QREFELT $ 56)))))) 

(SDEFUN |TRIGMNIP;complexNormalize;FSF;9| ((|f| (F)) (|x| (|Symbol|)) ($ (F)))
        (SPROG ((#1=#:G773 NIL) (|g| (F)) (|k| NIL) (#2=#:G772 NIL))
               (SEQ
                (COND
                 ((SPADCALL
                   (CONS #'|TRIGMNIP;complexNormalize;FSF;9!0|
                         (VECTOR (QREFELT $ 8) $))
                   (PROGN
                    (LETT #2# NIL)
                    (SEQ (LETT |k| NIL)
                         (LETT #1#
                               (SPADCALL
                                (LETT |g| (SPADCALL |f| |x| (QREFELT $ 63)))
                                (QREFELT $ 34)))
                         G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |k| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL |x|
                                       (SPADCALL (SPADCALL |k| (QREFELT $ 64))
                                                 (QREFELT $ 66))
                                       (QREFELT $ 67))
                             (LETT #2# (CONS |k| #2#))))))
                         (LETT #1# (CDR #1#)) (GO G190) G191
                         (EXIT (NREVERSE #2#))))
                   (QREFELT $ 70))
                  (SPADCALL
                   (QVELT
                    (SPADCALL (|TRIGMNIP;localexplogs| |f| |g| $) |x|
                              (QREFELT $ 73))
                    0)
                   (QREFELT $ 74)))
                 ('T (QVELT (SPADCALL |g| |x| (QREFELT $ 76)) 0)))))) 

(SDEFUN |TRIGMNIP;complexNormalize;FSF;9!0| ((|y| NIL) ($$ NIL))
        (PROG ($ RTRIG)
          (LETT $ (QREFELT $$ 1))
          (LETT RTRIG (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |y| (QREFELT $ 36)) RTRIG (QREFELT $ 56)))))) 

(SDEFUN |TRIGMNIP;complexNormalize;2F;10| ((|f| (F)) ($ (F)))
        (SPROG ((|g| (F)) (|h| (|Expression| (|Complex| R))))
               (SEQ (LETT |g| (SPADCALL |f| (QREFELT $ 58)))
                    (EXIT
                     (COND
                      ((SPADCALL
                        (CONS #'|TRIGMNIP;complexNormalize;2F;10!0|
                              (VECTOR $ (QREFELT $ 8)))
                        (SPADCALL |g| (QREFELT $ 60)) (QREFELT $ 62))
                       (SEQ (LETT |h| (|TRIGMNIP;localexplogs| |f| |g| $))
                            (LETT |h|
                                  (QVELT (SPADCALL |h| NIL (QREFELT $ 78)) 0))
                            (EXIT (SPADCALL |h| (QREFELT $ 74)))))
                      ('T
                       (SEQ
                        (LETT |g| (QVELT (SPADCALL |g| NIL (QREFELT $ 79)) 0))
                        (EXIT |g|)))))))) 

(SDEFUN |TRIGMNIP;complexNormalize;2F;10!0| ((|x| NIL) ($$ NIL))
        (PROG (RTRIG $)
          (LETT RTRIG (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x| RTRIG (QREFELT $ 56)))))) 

(SDEFUN |TRIGMNIP;complexElementary;FSF;11|
        ((|f| (F)) (|x| (|Symbol|)) ($ (F)))
        (SPROG ((#1=#:G787 NIL) (|g| (F)) (|k| NIL) (#2=#:G786 NIL))
               (SEQ
                (COND
                 ((SPADCALL
                   (CONS #'|TRIGMNIP;complexElementary;FSF;11!0|
                         (VECTOR (QREFELT $ 8) $))
                   (PROGN
                    (LETT #2# NIL)
                    (SEQ (LETT |k| NIL)
                         (LETT #1#
                               (SPADCALL
                                (LETT |g| (SPADCALL |f| |x| (QREFELT $ 63)))
                                (QREFELT $ 34)))
                         G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |k| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL |x|
                                       (SPADCALL (SPADCALL |k| (QREFELT $ 64))
                                                 (QREFELT $ 66))
                                       (QREFELT $ 67))
                             (LETT #2# (CONS |k| #2#))))))
                         (LETT #1# (CDR #1#)) (GO G190) G191
                         (EXIT (NREVERSE #2#))))
                   (QREFELT $ 70))
                  (SPADCALL (|TRIGMNIP;localexplogs| |f| |g| $)
                            (QREFELT $ 74)))
                 ('T |g|))))) 

(SDEFUN |TRIGMNIP;complexElementary;FSF;11!0| ((|y| NIL) ($$ NIL))
        (PROG ($ RTRIG)
          (LETT $ (QREFELT $$ 1))
          (LETT RTRIG (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |y| (QREFELT $ 36)) RTRIG (QREFELT $ 56)))))) 

(SDEFUN |TRIGMNIP;complexElementary;2F;12| ((|f| (F)) ($ (F)))
        (SPROG ((|g| (F)))
               (COND
                ((SPADCALL
                  (CONS #'|TRIGMNIP;complexElementary;2F;12!0|
                        (VECTOR $ (QREFELT $ 8)))
                  (SPADCALL (LETT |g| (SPADCALL |f| (QREFELT $ 58)))
                            (QREFELT $ 60))
                  (QREFELT $ 62))
                 (SPADCALL (|TRIGMNIP;localexplogs| |f| |g| $) (QREFELT $ 74)))
                ('T |g|)))) 

(SDEFUN |TRIGMNIP;complexElementary;2F;12!0| ((|x| NIL) ($$ NIL))
        (PROG (RTRIG $)
          (LETT RTRIG (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x| RTRIG (QREFELT $ 56)))))) 

(SDEFUN |TRIGMNIP;localexplogs|
        ((|f| (F)) (|g| (F)) ($ (|Expression| (|Complex| R))))
        (SPROG ((#1=#:G796 NIL) (|k| NIL) (#2=#:G795 NIL))
               (SEQ
                (SPADCALL (SPADCALL |g| (QREFELT $ 21))
                          (PROGN
                           (LETT #2# NIL)
                           (SEQ (LETT |k| NIL)
                                (LETT #1# (SPADCALL |f| (QREFELT $ 34))) G190
                                (COND
                                 ((OR (ATOM #1#)
                                      (PROGN (LETT |k| (CAR #1#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (COND
                                   ((COND
                                     ((SPADCALL |k| '|tan| (QREFELT $ 38)) 'T)
                                     ('T (SPADCALL |k| '|cot| (QREFELT $ 38))))
                                    (LETT #2#
                                          (CONS (|TRIGMNIP;K2KG| |k| $)
                                                #2#))))))
                                (LETT #1# (CDR #1#)) (GO G190) G191
                                (EXIT (NREVERSE #2#))))
                          (QREFELT $ 84))))) 

(SDEFUN |TRIGMNIP;trigs;2F;14| ((|f| (F)) ($ (F)))
        (SPROG ((|g| (|Complex| F)))
               (SEQ
                (COND ((SPADCALL |f| (QREFELT $ 26)) |f|)
                      ('T
                       (SEQ
                        (LETT |g|
                              (SPADCALL (SPADCALL |f| (QREFELT $ 21))
                                        (QREFELT $ 55)))
                        (EXIT
                         (SPADCALL (SPADCALL |g| (QREFELT $ 29))
                                   (SPADCALL (QREFELT $ 12)
                                             (SPADCALL |g| (QREFELT $ 31))
                                             (QREFELT $ 14))
                                   (QREFELT $ 49))))))))) 

(DECLAIM (NOTINLINE |TrigonometricManipulations;|)) 

(DEFUN |TrigonometricManipulations| (&REST #1=#:G800)
  (SPROG NIL
         (PROG (#2=#:G801)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|TrigonometricManipulations|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |TrigonometricManipulations;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|TrigonometricManipulations|)))))))))) 

(DEFUN |TrigonometricManipulations;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|TrigonometricManipulations| DV$1 DV$2))
          (LETT $ (GETREFV 86))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|TrigonometricManipulations|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 8 '|rtrig|)
          (QSETREFV $ 12
                    (SPADCALL (SPADCALL (|spadConstant| $ 9) (QREFELT $ 10))
                              (QREFELT $ 11)))
          (QSETREFV $ 15
                    (SPADCALL (SPADCALL (QREFELT $ 13)) (QREFELT $ 12)
                              (QREFELT $ 14)))
          $))) 

(MAKEPROP '|TrigonometricManipulations| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) 'RTRIG
              (0 . |One|) (4 . -) (9 . |sqrt|) '|s1| (14 . |pi|) (18 . *)
              '|ipi| (|List| 7) (|Kernel| 7) (24 . |argument|)
              (|Expression| (|Complex| 6))
              (|InnerTrigonometricManipulations| 6 7 19) (29 . F2FG)
              (34 . |tan|) (|Kernel| $) (39 . |retract|) (|Boolean|)
              |TRIGMNIP;real?;FB;2| (|Complex| 7) |TRIGMNIP;complexForm;FC;7|
              (44 . |real|) |TRIGMNIP;real;2F;3| (49 . |imag|)
              |TRIGMNIP;imag;2F;4| (|List| 23) (54 . |tower|) (|BasicOperator|)
              (59 . |operator|) (|Symbol|) (64 . |is?|) (70 . |second|)
              (|Integer|) (75 . |retract|) (|Union| 40 '"failed")
              (|ElementaryFunctionSign| 6 7) (80 . |sign|) (85 . |coerce|)
              (90 . /) (96 . |elt|) (103 . |elt|) (109 . +) (115 . |Zero|)
              (119 . |Zero|) (123 . |complex|) (|List| $) (129 . |eval|)
              (136 . |explogs2trigs|) (141 . |has?|)
              (|ElementaryFunctionStructurePackage| 6 7)
              (147 . |realElementary|) (|List| 35) (152 . |operators|)
              (|Mapping| 25 35) (157 . |any?|) (163 . |realElementary|)
              (169 . |coerce|) (|List| 37) (174 . |variables|)
              (179 . |member?|) (|Mapping| 25 17) (|List| 17) (185 . |any?|)
              (|Record| (|:| |func| 19) (|:| |kers| 83)
                        (|:| |vals| (|List| 19)))
              (|ElementaryFunctionStructurePackage| (|Complex| 6) 19)
              (191 . |rischNormalize|) (197 . FG2F)
              (|Record| (|:| |func| 7) (|:| |kers| 69) (|:| |vals| 16))
              (202 . |rischNormalize|) |TRIGMNIP;complexNormalize;FSF;9|
              (208 . |rischNormalize|) (214 . |rischNormalize|)
              |TRIGMNIP;complexNormalize;2F;10|
              |TRIGMNIP;complexElementary;FSF;11|
              |TRIGMNIP;complexElementary;2F;12| (|List| (|Kernel| 19))
              (220 . |trigs2explogs|) |TRIGMNIP;trigs;2F;14|)
           '#(|trigs| 226 |real?| 231 |real| 236 |imag| 241 |complexNormalize|
              246 |complexForm| 257 |complexElementary| 262)
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
                                   '((|trigs| (|#2| |#2|)) T)
                                   '((|real| (|#2| |#2|)) T)
                                   '((|imag| (|#2| |#2|)) T)
                                   '((|real?| ((|Boolean|) |#2|)) T)
                                   '((|complexForm| ((|Complex| |#2|) |#2|))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 85
                                            '(0 7 0 9 1 7 0 0 10 1 7 0 0 11 0 7
                                              0 13 2 7 0 0 0 14 1 17 16 0 18 1
                                              20 19 7 21 1 19 0 0 22 1 19 23 0
                                              24 1 27 7 0 29 1 27 7 0 31 1 7 33
                                              0 34 1 17 35 0 36 2 17 25 0 37 38
                                              1 16 7 0 39 1 7 40 0 41 1 43 42 7
                                              44 1 7 0 40 45 2 7 0 0 0 46 3 7 0
                                              35 0 0 47 2 7 0 35 0 48 2 7 0 0 0
                                              49 0 6 0 50 0 7 0 51 2 27 0 7 7
                                              52 3 7 0 0 33 53 54 1 20 27 19 55
                                              2 35 25 0 37 56 1 57 7 7 58 1 7
                                              59 0 60 2 59 25 61 0 62 2 57 7 7
                                              37 63 1 7 0 23 64 1 7 65 0 66 2
                                              65 25 37 0 67 2 69 25 68 0 70 2
                                              72 71 19 37 73 1 20 7 19 74 2 57
                                              75 7 37 76 2 72 71 19 65 78 2 57
                                              75 7 65 79 2 20 19 19 83 84 1 0 7
                                              7 85 1 0 25 7 26 1 0 7 7 30 1 0 7
                                              7 32 2 0 7 7 37 77 1 0 7 7 80 1 0
                                              27 7 28 2 0 7 7 37 81 1 0 7 7
                                              82)))))
           '|lookupComplete|)) 
