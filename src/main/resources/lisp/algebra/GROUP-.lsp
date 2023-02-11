
(SDEFUN |GROUP-;/;3S;1| ((|x| (S)) (|y| (S)) ($ (S)))
        (SPADCALL |x| (SPADCALL |y| (QREFELT $ 7)) (QREFELT $ 8))) 

(SDEFUN |GROUP-;recip;SU;2| ((|x| (S)) ($ (|Union| S "failed")))
        (CONS 0 (SPADCALL |x| (QREFELT $ 7)))) 

(SDEFUN |GROUP-;^;SIS;3| ((|x| (S)) (|n| (|Integer|)) ($ (S)))
        (COND ((ZEROP |n|) (|spadConstant| $ 12))
              ((< |n| 0)
               (SPADCALL (SPADCALL |x| (QREFELT $ 7)) (- |n|) (QREFELT $ 15)))
              ('T (SPADCALL |x| |n| (QREFELT $ 15))))) 

(SDEFUN |GROUP-;conjugate;3S;4| ((|p| (S)) (|q| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |q| (QREFELT $ 7)) |p| (QREFELT $ 8)) |q|
                  (QREFELT $ 8))) 

(SDEFUN |GROUP-;commutator;3S;5| ((|p| (S)) (|q| (S)) ($ (S)))
        (SPADCALL
         (SPADCALL
          (SPADCALL (SPADCALL |p| (QREFELT $ 7)) (SPADCALL |q| (QREFELT $ 7))
                    (QREFELT $ 8))
          |p| (QREFELT $ 8))
         |q| (QREFELT $ 8))) 

(DECLAIM (NOTINLINE |Group&;|)) 

(DEFUN |Group&| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|Group&| DV$1))
          (LETT $ (GETREFV 21))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|Group&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (0 . |inv|) (5 . *)
              |GROUP-;/;3S;1| (|Union| $ '#1="failed") |GROUP-;recip;SU;2|
              (11 . |One|) (|PositiveInteger|) (|RepeatedSquaring| 6)
              (15 . |expt|) (|Integer|) |GROUP-;^;SIS;3|
              |GROUP-;conjugate;3S;4| |GROUP-;commutator;3S;5|
              (|NonNegativeInteger|))
           '#(|recip| 21 |conjugate| 26 |commutator| 32 ^ 38 / 44) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|commutator| (|#1| |#1| |#1|)) T)
                                   '((|conjugate| (|#1| |#1| |#1|)) T)
                                   '((^ (|#1| |#1| (|Integer|))) T)
                                   '((/ (|#1| |#1| |#1|)) T)
                                   '((^ (|#1| |#1| (|NonNegativeInteger|))) T)
                                   '((|recip| ((|Union| |#1| #1#) |#1|)) T)
                                   '((^ (|#1| |#1| (|PositiveInteger|))) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 19
                                            '(1 6 0 0 7 2 6 0 0 0 8 0 6 0 12 2
                                              14 6 6 13 15 1 0 10 0 11 2 0 0 0
                                              0 18 2 0 0 0 0 19 2 0 0 0 16 17 2
                                              0 0 0 0 9)))))
           '|lookupComplete|)) 
