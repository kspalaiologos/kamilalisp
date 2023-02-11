
(SDEFUN |PARRPKG;nextMotzkinRow|
        ((|vv| #1=(|List| R)) (|aa| (|Stream| R)) (|bb| (|Stream| R))
         (|cc| (|Stream| R)) ($ (|List| R)))
        (SPROG
         ((|vvnew| (|List| R)) (|vva| (|List| R)) (|vi| (R)) (|vvc| (|List| R))
          (|vvb| #1#))
         (SEQ (LETT |vvnew| NIL) (LETT |vva| (CONS (|spadConstant| $ 7) |vv|))
              (LETT |aa| (SPADCALL (|spadConstant| $ 7) |aa| (QREFELT $ 9)))
              (LETT |vvb| |vv|) (LETT |vvc| (CDR |vv|))
              (SEQ G190 (COND ((NULL (NULL (NULL |vvc|))) (GO G191)))
                   (SEQ
                    (LETT |vi|
                          (SPADCALL
                           (SPADCALL
                            (SPADCALL (|SPADfirst| |vva|)
                                      (SPADCALL |aa| (QREFELT $ 10))
                                      (QREFELT $ 11))
                            (SPADCALL (|SPADfirst| |vvb|)
                                      (SPADCALL |bb| (QREFELT $ 10))
                                      (QREFELT $ 11))
                            (QREFELT $ 12))
                           (SPADCALL (|SPADfirst| |vvc|)
                                     (SPADCALL |cc| (QREFELT $ 10))
                                     (QREFELT $ 11))
                           (QREFELT $ 12)))
                    (LETT |vvnew| (CONS |vi| |vvnew|)) (LETT |vva| (CDR |vva|))
                    (LETT |vvb| (CDR |vvb|)) (LETT |vvc| (CDR |vvc|))
                    (LETT |aa| (SPADCALL |aa| (QREFELT $ 13)))
                    (LETT |bb| (SPADCALL |bb| (QREFELT $ 13)))
                    (EXIT (LETT |cc| (SPADCALL |cc| (QREFELT $ 13)))))
                   NIL (GO G190) G191 (EXIT NIL))
              (LETT |vi|
                    (SPADCALL
                     (SPADCALL (|SPADfirst| |vva|)
                               (SPADCALL |aa| (QREFELT $ 10)) (QREFELT $ 11))
                     (SPADCALL (|SPADfirst| |vvb|)
                               (SPADCALL |bb| (QREFELT $ 10)) (QREFELT $ 11))
                     (QREFELT $ 12)))
              (LETT |vvnew| (CONS |vi| |vvnew|)) (LETT |vva| (CDR |vva|))
              (LETT |aa| (SPADCALL |aa| (QREFELT $ 13)))
              (LETT |vvnew|
                    (CONS
                     (SPADCALL (|SPADfirst| |vva|)
                               (SPADCALL |aa| (QREFELT $ 10)) (QREFELT $ 11))
                     |vvnew|))
              (EXIT (LETT |vvnew| (NREVERSE |vvnew|)))))) 

(SDEFUN |PARRPKG;nextJacobiRow|
        ((|vv| #1=(|List| R)) (|bb| (|Stream| R)) (|cc| (|Stream| R))
         ($ (|List| R)))
        (SPROG
         ((|vvnew| (|List| R)) (|vva| (|List| R)) (|vi| (R)) (|vvc| (|List| R))
          (|vvb| #1#))
         (SEQ (LETT |vvnew| NIL) (LETT |vva| (CONS (|spadConstant| $ 7) |vv|))
              (LETT |vvb| |vv|) (LETT |vvc| (CDR |vv|))
              (SEQ G190 (COND ((NULL (NULL (NULL |vvc|))) (GO G191)))
                   (SEQ
                    (LETT |vi|
                          (SPADCALL
                           (SPADCALL (|SPADfirst| |vva|)
                                     (SPADCALL (|SPADfirst| |vvb|)
                                               (SPADCALL |bb| (QREFELT $ 10))
                                               (QREFELT $ 11))
                                     (QREFELT $ 12))
                           (SPADCALL (|SPADfirst| |vvc|)
                                     (SPADCALL |cc| (QREFELT $ 10))
                                     (QREFELT $ 11))
                           (QREFELT $ 12)))
                    (LETT |vvnew| (CONS |vi| |vvnew|)) (LETT |vva| (CDR |vva|))
                    (LETT |vvb| (CDR |vvb|)) (LETT |vvc| (CDR |vvc|))
                    (LETT |bb| (SPADCALL |bb| (QREFELT $ 13)))
                    (EXIT (LETT |cc| (SPADCALL |cc| (QREFELT $ 13)))))
                   NIL (GO G190) G191 (EXIT NIL))
              (LETT |vi|
                    (SPADCALL (|SPADfirst| |vva|)
                              (SPADCALL (|SPADfirst| |vvb|)
                                        (SPADCALL |bb| (QREFELT $ 10))
                                        (QREFELT $ 11))
                              (QREFELT $ 12)))
              (LETT |vvnew| (CONS |vi| |vvnew|)) (LETT |vva| (CDR |vva|))
              (LETT |vvnew| (CONS (|SPADfirst| |vva|) |vvnew|))
              (EXIT (LETT |vvnew| (NREVERSE |vvnew|)))))) 

(SDEFUN |PARRPKG;motzkinPathArray;3SS;3|
        ((|aa| (|Stream| R)) (|bb| (|Stream| R)) (|cc| (|Stream| R))
         ($ (|Stream| (|List| R))))
        (SPROG ((|start| (|List| R)))
               (SEQ (LETT |start| (LIST (|spadConstant| $ 14)))
                    (EXIT
                     (SPADCALL
                      (CONS #'|PARRPKG;motzkinPathArray;3SS;3!0|
                            (VECTOR $ |cc| |bb| |aa|))
                      |start| (QREFELT $ 18)))))) 

(SDEFUN |PARRPKG;motzkinPathArray;3SS;3!0| ((|vv| NIL) ($$ NIL))
        (PROG (|aa| |bb| |cc| $)
          (LETT |aa| (QREFELT $$ 3))
          (LETT |bb| (QREFELT $$ 2))
          (LETT |cc| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|PARRPKG;nextMotzkinRow| |vv| |aa| |bb| |cc| $))))) 

(SDEFUN |PARRPKG;jacobiPathArray;2SS;4|
        ((|bb| (|Stream| R)) (|cc| (|Stream| R)) ($ (|Stream| (|List| R))))
        (SPROG ((|start| (|List| R)))
               (SEQ (LETT |start| (LIST (|spadConstant| $ 14)))
                    (EXIT
                     (SPADCALL
                      (CONS #'|PARRPKG;jacobiPathArray;2SS;4!0|
                            (VECTOR $ |cc| |bb|))
                      |start| (QREFELT $ 18)))))) 

(SDEFUN |PARRPKG;jacobiPathArray;2SS;4!0| ((|vv| NIL) ($$ NIL))
        (PROG (|bb| |cc| $)
          (LETT |bb| (QREFELT $$ 2))
          (LETT |cc| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|PARRPKG;nextJacobiRow| |vv| |bb| |cc| $))))) 

(SDEFUN |PARRPKG;bottom;SS;5| ((|x| (|Stream| (|List| R))) ($ (|Stream| R)))
        (SPADCALL (ELT $ 21) |x| (QREFELT $ 24))) 

(DECLAIM (NOTINLINE |PathArrayPackage;|)) 

(DEFUN |PathArrayPackage| (#1=#:G720)
  (SPROG NIL
         (PROG (#2=#:G721)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|PathArrayPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|PathArrayPackage;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|PathArrayPackage|)))))))))) 

(DEFUN |PathArrayPackage;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|PathArrayPackage| DV$1))
          (LETT $ (GETREFV 26))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PathArrayPackage| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|PathArrayPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (0 . |Zero|) (|Stream| 6)
              (4 . |cons|) (10 . |first|) (15 . *) (21 . +) (27 . |rest|)
              (32 . |One|) (|Mapping| 16 16) (|List| 6) (|Stream| 16)
              (36 . |stream|) |PARRPKG;motzkinPathArray;3SS;3|
              |PARRPKG;jacobiPathArray;2SS;4| (42 . |first|) (|Mapping| 6 16)
              (|StreamFunctions2| 16 6) (47 . |map|) |PARRPKG;bottom;SS;5|)
           '#(|motzkinPathArray| 53 |jacobiPathArray| 60 |bottom| 66) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|motzkinPathArray|
                                 ((|Stream| (|List| |#1|)) (|Stream| |#1|)
                                  (|Stream| |#1|) (|Stream| |#1|)))
                                T)
                              '((|jacobiPathArray|
                                 ((|Stream| (|List| |#1|)) (|Stream| |#1|)
                                  (|Stream| |#1|)))
                                T)
                              '((|bottom|
                                 ((|Stream| |#1|) (|Stream| (|List| |#1|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 25
                                            '(0 6 0 7 2 8 0 6 0 9 1 8 6 0 10 2
                                              6 0 0 0 11 2 6 0 0 0 12 1 8 0 0
                                              13 0 6 0 14 2 17 0 15 16 18 1 16
                                              6 0 21 2 23 8 22 17 24 3 0 17 8 8
                                              8 19 2 0 17 8 8 20 1 0 8 17
                                              25)))))
           '|lookupComplete|)) 
