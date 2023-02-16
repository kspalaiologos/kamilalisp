
(SDEFUN |RRCC-;zero?;ThePolsSB;1|
        ((|toTest| (|ThePols|)) (|rootChar| (S)) ($ (|Boolean|)))
        (EQL (SPADCALL |toTest| |rootChar| (QREFELT $ 10)) 0)) 

(SDEFUN |RRCC-;negative?;ThePolsSB;2|
        ((|toTest| (|ThePols|)) (|rootChar| (S)) ($ (|Boolean|)))
        (< (SPADCALL |toTest| |rootChar| (QREFELT $ 10)) 0)) 

(SDEFUN |RRCC-;positive?;ThePolsSB;3|
        ((|toTest| (|ThePols|)) (|rootChar| (S)) ($ (|Boolean|)))
        (> (SPADCALL |toTest| |rootChar| (QREFELT $ 10)) 0)) 

(SDEFUN |RRCC-;rootOf;ThePolsPiU;4|
        ((|pol| (|ThePols|)) (|n| (|PositiveInteger|))
         ($ (|Union| S "failed")))
        (SPROG ((|liste| (|List| S)))
               (SEQ (LETT |liste| (SPADCALL |pol| (QREFELT $ 16)))
                    (EXIT
                     (COND ((> (LENGTH |liste|) |n|) (CONS 1 "failed"))
                           ('T
                            (CONS 0 (SPADCALL |liste| |n| (QREFELT $ 18))))))))) 

(SDEFUN |RRCC-;recip;ThePolsSU;5|
        ((|toInv| (|ThePols|)) (|rootChar| (S))
         ($ (|Union| |ThePols| #1="failed")))
        (SPROG
         ((|d|
           (|Record| (|:| |coef| (|List| |ThePols|))
                     (|:| |generator| |ThePols|)))
          (|defPol| (|ThePols|)) (#2=#:G733 NIL)
          (|res| (|Union| |TheField| "failed")))
         (SEQ
          (COND
           ((EQL (SPADCALL |toInv| (QREFELT $ 23)) 0)
            (SEQ
             (LETT |res|
                   (SPADCALL (SPADCALL |toInv| (QREFELT $ 24)) (QREFELT $ 25)))
             (EXIT
              (COND ((QEQCAR |res| 1) (CONS 1 "failed"))
                    (#3='T (CONS 0 (SPADCALL (QCDR |res|) (QREFELT $ 26))))))))
           (#3#
            (SEQ (LETT |defPol| (SPADCALL |rootChar| (QREFELT $ 27)))
                 (LETT |d| (SPADCALL (LIST |defPol| |toInv|) (QREFELT $ 29)))
                 (EXIT
                  (COND
                   ((SPADCALL (QCDR |d|) |rootChar| (QREFELT $ 30))
                    (CONS 1 "failed"))
                   (#3#
                    (SEQ
                     (COND
                      ((SPADCALL (SPADCALL (QCDR |d|) (QREFELT $ 23)) 0
                                 (QREFELT $ 31))
                       (SEQ
                        (LETT |defPol|
                              (PROG2
                                  (LETT #2#
                                        (SPADCALL |defPol| (QCDR |d|)
                                                  (QREFELT $ 32)))
                                  (QCDR #2#)
                                (|check_union2| (QEQCAR #2# 0) (QREFELT $ 8)
                                                (|Union| (QREFELT $ 8) #1#)
                                                #2#)))
                        (EXIT
                         (LETT |d|
                               (SPADCALL (LIST |defPol| |toInv|)
                                         (QREFELT $ 29)))))))
                     (EXIT
                      (CONS 0 (SPADCALL (QCAR |d|) 2 (QREFELT $ 34)))))))))))))) 

(DECLAIM (NOTINLINE |RealRootCharacterizationCategory&;|)) 

(DEFUN |RealRootCharacterizationCategory&| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$|
                (LIST '|RealRootCharacterizationCategory&| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 37))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|RealRootCharacterizationCategory&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|Integer|) (0 . |sign|) (|Boolean|)
              |RRCC-;zero?;ThePolsSB;1| |RRCC-;negative?;ThePolsSB;2|
              |RRCC-;positive?;ThePolsSB;3| (|List| $) (6 . |allRootsOf|)
              (|List| 6) (11 . |elt|) (|Union| $ '#1="failed")
              (|PositiveInteger|) |RRCC-;rootOf;ThePolsPiU;4|
              (|NonNegativeInteger|) (17 . |degree|)
              (22 . |leadingCoefficient|) (27 . |recip|) (32 . |coerce|)
              (37 . |definingPolynomial|)
              (|Record| (|:| |coef| 15) (|:| |generator| $))
              (42 . |principalIdeal|) (47 . |zero?|) (53 . ~=) (59 . |exquo|)
              (|List| 8) (65 . |elt|) (|Union| 8 '#2="failed")
              |RRCC-;recip;ThePolsSU;5|)
           '#(|zero?| 71 |rootOf| 77 |recip| 83 |positive?| 89 |negative?| 95)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|rootOf|
                                 ((|Union| |#1| #1#) |#3| (|PositiveInteger|)))
                                T)
                              '((|recip| ((|Union| |#3| #2#) |#3| |#1|)) T)
                              '((|positive?| ((|Boolean|) |#3| |#1|)) T)
                              '((|negative?| ((|Boolean|) |#3| |#1|)) T)
                              '((|zero?| ((|Boolean|) |#3| |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 36
                                            '(2 6 9 8 0 10 1 6 15 8 16 2 17 6 0
                                              9 18 1 8 22 0 23 1 8 7 0 24 1 7
                                              19 0 25 1 8 0 7 26 1 6 8 0 27 1 8
                                              28 15 29 2 6 11 8 0 30 2 9 11 0 0
                                              31 2 8 19 0 0 32 2 33 8 0 9 34 2
                                              0 11 8 0 12 2 0 19 8 20 21 2 0 35
                                              8 0 36 2 0 11 8 0 14 2 0 11 8 0
                                              13)))))
           '|lookupComplete|)) 
