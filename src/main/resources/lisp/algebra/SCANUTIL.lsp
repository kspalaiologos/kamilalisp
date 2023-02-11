
(SDEFUN |SCANUTIL;parse_integer2|
        ((|str| (|String|)) (|i0| (|SingleInteger|)) (|l| (|SingleInteger|))
         (|l2l| (|List| (|SingleInteger|))) (|tpl| (|List| (|Integer|)))
         ($ (|Integer|)))
        (SPROG
         ((|res| (|Integer|)) (|l2| #1=(|SingleInteger|)) (|tp| (|Integer|))
          (|l1| (|SingleInteger|)) (|s1| (|SingleInteger|)) (|dig_val| #1#)
          (#2=#:G721 NIL) (|i| NIL) (#3=#:G720 NIL) (#4=#:G719 NIL)
          (|ten7| (|Integer|)) (|ten| #5=(|SingleInteger|)) (|b| #5#))
         (SEQ (LETT |b| 48) (LETT |ten| 10) (LETT |ten7| 10000000)
              (EXIT
               (COND
                ((|eql_SI| |l| 2)
                 (SEQ (LETT |s1| 0)
                      (SEQ (LETT |i| |i0|) (LETT #4# (|add_SI| |i0| 6)) G190
                           (COND ((|greater_SI| |i| #4#) (GO G191)))
                           (SEQ
                            (LETT |dig_val|
                                  (|sub_SI| (STR_ELT1 |str| |i|) |b|))
                            (EXIT
                             (LETT |s1|
                                   (|add_SI| (|mul_SI| |ten| |s1|)
                                             |dig_val|))))
                           (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                      (LETT |res| |s1|) (LETT |s1| 0)
                      (SEQ (LETT |i| (|add_SI| |i0| 7))
                           (LETT #3# (|add_SI| |i0| 13)) G190
                           (COND ((|greater_SI| |i| #3#) (GO G191)))
                           (SEQ
                            (LETT |dig_val|
                                  (|sub_SI| (STR_ELT1 |str| |i|) |b|))
                            (EXIT
                             (LETT |s1|
                                   (|add_SI| (|mul_SI| |ten| |s1|)
                                             |dig_val|))))
                           (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                      (EXIT (+ (* |ten7| |res|) |s1|))))
                ((|eql_SI| |l| 1)
                 (SEQ (LETT |s1| 0)
                      (SEQ (LETT |i| |i0|) (LETT #2# (|add_SI| |i0| 6)) G190
                           (COND ((|greater_SI| |i| #2#) (GO G191)))
                           (SEQ
                            (LETT |dig_val|
                                  (|sub_SI| (STR_ELT1 |str| |i|) |b|))
                            (EXIT
                             (LETT |s1|
                                   (|add_SI| (|mul_SI| |ten| |s1|)
                                             |dig_val|))))
                           (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                      (EXIT |s1|)))
                ('T
                 (SEQ (LETT |l1| (|SPADfirst| |l2l|)) (LETT |l2l| (CDR |l2l|))
                      (LETT |tp| (|SPADfirst| |tpl|)) (LETT |tpl| (CDR |tpl|))
                      (LETT |l2| (|sub_SI| |l| |l1|))
                      (LETT |res|
                            (|SCANUTIL;parse_integer2| |str|
                             (|add_SI| |i0| (SPADCALL 7 |l2| (QREFELT $ 8)))
                             |l1| |l2l| |tpl| $))
                      (SEQ G190
                           (COND
                            ((NULL (NULL (|less_SI| (|SPADfirst| |l2l|) |l2|)))
                             (GO G191)))
                           (SEQ (LETT |l2l| (CDR |l2l|))
                                (EXIT (LETT |tpl| (CDR |tpl|))))
                           NIL (GO G190) G191 (EXIT NIL))
                      (EXIT
                       (+ |res|
                          (* |tp|
                             (|SCANUTIL;parse_integer2| |str| |i0| |l2| |l2l|
                              |tpl| $))))))))))) 

(SDEFUN |SCANUTIL;parse_integer;SI;2| ((|str| (|String|)) ($ (|Integer|)))
        (SPROG
         ((|res| (|Integer|)) (|j| (|SingleInteger|))
          (|s1| #1=(|SingleInteger|)) (|dig_val| #2=(|SingleInteger|))
          (#3=#:G741 NIL) (|i| NIL) (#4=#:G740 NIL) (|k| NIL)
          (|ll| #5=(|SingleInteger|)) (|tpl| (|List| #6=(|Integer|)))
          (|l2l| (|List| #1#)) (|tp| #6#) (|ten7| #6#) (|l2| #2#) (|l20| #2#)
          (#7=#:G739 NIL) (|ten| #5#) (|l1| (|SingleInteger|)) (|l| #5#)
          (|b| #5#))
         (SEQ (LETT |b| 48) (LETT |l| (QCSIZE |str|))
              (LETT |l1| (|rem_SI| |l| 7)) (LETT |s1| 0) (LETT |ten| 10)
              (SEQ (LETT |i| 1) (LETT #7# |l1|) G190
                   (COND ((|greater_SI| |i| #7#) (GO G191)))
                   (SEQ (LETT |dig_val| (|sub_SI| (STR_ELT1 |str| |i|) |b|))
                        (EXIT
                         (LETT |s1|
                               (|add_SI| (|mul_SI| |ten| |s1|) |dig_val|))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |l20| (LETT |l2| (|sub_SI| |l| |l1|))) (LETT |res| |s1|)
              (EXIT
               (COND ((|eql_SI| |l2| 0) |res|)
                     (#8='T
                      (SEQ (LETT |l2| (|quo_SI| |l2| 7))
                           (LETT |j| (|add_SI| |l1| 1)) (LETT |ten7| 10000000)
                           (EXIT
                            (COND
                             ((|less_SI| 3 |l2|)
                              (SEQ (LETT |l2l| (LIST 1 0))
                                   (LETT |tpl| (LIST |ten7| 1))
                                   (LETT |tp| |ten7|) (LETT |ll| 2)
                                   (SEQ G190
                                        (COND
                                         ((NULL (|less_SI| |ll| |l2|))
                                          (GO G191)))
                                        (SEQ (LETT |tp| (* |tp| |tp|))
                                             (LETT |l2l| (CONS |ll| |l2l|))
                                             (LETT |tpl| (CONS |tp| |tpl|))
                                             (EXIT
                                              (LETT |ll|
                                                    (|add_SI| |ll| |ll|))))
                                        NIL (GO G190) G191 (EXIT NIL))
                                   (EXIT
                                    (+ (* |res| (EXPT 10 |l20|))
                                       (|SCANUTIL;parse_integer2| |str| |j|
                                        |l2| |l2l| |tpl| $)))))
                             (#8#
                              (SEQ
                               (SEQ (LETT |k| 1) (LETT #4# |l2|) G190
                                    (COND ((|greater_SI| |k| #4#) (GO G191)))
                                    (SEQ (LETT |s1| 0)
                                         (SEQ (LETT |i| |j|)
                                              (LETT #3# (|add_SI| |j| 6)) G190
                                              (COND
                                               ((|greater_SI| |i| #3#)
                                                (GO G191)))
                                              (SEQ
                                               (LETT |dig_val|
                                                     (|sub_SI|
                                                      (STR_ELT1 |str| |i|)
                                                      |b|))
                                               (EXIT
                                                (LETT |s1|
                                                      (|add_SI|
                                                       (|mul_SI| |ten| |s1|)
                                                       |dig_val|))))
                                              (LETT |i| (|inc_SI| |i|))
                                              (GO G190) G191 (EXIT NIL))
                                         (LETT |j| (|add_SI| |j| 7))
                                         (EXIT
                                          (LETT |res|
                                                (+ (* |ten7| |res|) |s1|))))
                                    (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                    (EXIT NIL))
                               (EXIT |res|)))))))))))) 

(DECLAIM (NOTINLINE |ScanningUtilities;|)) 

(DEFUN |ScanningUtilities| ()
  (SPROG NIL
         (PROG (#1=#:G743)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|ScanningUtilities|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|ScanningUtilities|
                             (LIST
                              (CONS NIL (CONS 1 (|ScanningUtilities;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|ScanningUtilities|)))))))))) 

(DEFUN |ScanningUtilities;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|ScanningUtilities|))
          (LETT $ (GETREFV 11))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ScanningUtilities| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|ScanningUtilities| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Integer|) (|SingleInteger|) (0 . *)
              (|String|) |SCANUTIL;parse_integer;SI;2|)
           '#(|parse_integer| 6) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|parse_integer| ((|Integer|) (|String|))) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 10 '(2 7 0 6 0 8 1 0 6 9 10)))))
           '|lookupComplete|)) 

(MAKEPROP '|ScanningUtilities| 'NILADIC T) 
