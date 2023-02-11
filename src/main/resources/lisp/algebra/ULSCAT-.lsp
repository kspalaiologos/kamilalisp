
(SDEFUN |ULSCAT-;laurentTerms|
        ((|n| (|Integer|)) (|st| (|Stream| |Coef|))
         ($ (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))))
        (SPROG NIL
               (SEQ
                (SPADCALL (CONS #'|ULSCAT-;laurentTerms!0| (VECTOR |n| $ |st|))
                          (QREFELT $ 24))))) 

(SDEFUN |ULSCAT-;laurentTerms!0| (($$ NIL))
        (PROG (|st| $ |n|)
          (LETT |st| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |n| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|c| NIL))
                   (SEQ
                    (COND
                     ((SPADCALL |st| (QREFELT $ 10)) (SPADCALL (QREFELT $ 13)))
                     ('T
                      (SEQ (LETT |c| (SPADCALL |st| (QREFELT $ 14)))
                           (EXIT
                            (COND
                             ((SPADCALL |c| (QREFELT $ 15))
                              (|ULSCAT-;laurentTerms|
                               (SPADCALL |n| (|spadConstant| $ 19)
                                         (QREFELT $ 20))
                               (SPADCALL |st| (QREFELT $ 21)) $))
                             ('T
                              (SPADCALL (CONS |n| |c|)
                                        (|ULSCAT-;laurentTerms|
                                         (SPADCALL |n| (|spadConstant| $ 19)
                                                   (QREFELT $ 20))
                                         (SPADCALL |st| (QREFELT $ 21)) $)
                                        (QREFELT $ 22)))))))))))))) 

(SDEFUN |ULSCAT-;laurent;ISS;2|
        ((|n| (|Integer|)) (|st| (|Stream| |Coef|)) ($ (S)))
        (SPADCALL (|ULSCAT-;laurentTerms| |n| |st| $) (QREFELT $ 25))) 

(DECLAIM (NOTINLINE |UnivariateLaurentSeriesCategory&;|)) 

(DEFUN |UnivariateLaurentSeriesCategory&| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|UnivariateLaurentSeriesCategory&| DV$1 DV$2))
          (LETT $ (GETREFV 27))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#2| '(|Field|))
                                              (|HasCategory| |#2|
                                                             '(|IntegralDomain|))))))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|UnivariateLaurentSeriesCategory&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (|Boolean|)
              (|Stream| 7) (0 . |empty?|) (|Record| (|:| |k| 18) (|:| |c| 7))
              (|Stream| 11) (5 . |empty|) (9 . |frst|) (14 . |zero?|)
              (19 . |One|) (23 . |One|) (|Integer|) (27 . |One|) (31 . +)
              (37 . |rst|) (42 . |concat|) (|Mapping| $) (48 . |delay|)
              (53 . |series|) |ULSCAT-;laurent;ISS;2|)
           '#(|laurent| 58) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|laurent| (|#1| (|Integer|) (|Stream| |#2|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 26
                                            '(1 9 8 0 10 0 12 0 13 1 9 7 0 14 1
                                              7 8 0 15 0 6 0 16 0 7 0 17 0 18 0
                                              19 2 18 0 0 0 20 1 9 0 0 21 2 12
                                              0 11 0 22 1 12 0 23 24 1 6 0 12
                                              25 2 0 0 18 9 26)))))
           '|lookupComplete|)) 
