
(PUT '|JBBFC-;U;PiS;1| '|SPADreplace|
     '(XLAM (|i|) (|error| "Only functions of independent variables allowed"))) 

(SDEFUN |JBBFC-;U;PiS;1| ((|i| (|PositiveInteger|)) ($ (S)))
        (|error| "Only functions of independent variables allowed")) 

(PUT '|JBBFC-;U;S;2| '|SPADreplace|
     '(XLAM NIL (|error| "Only functions of independent variables allowed"))) 

(SDEFUN |JBBFC-;U;S;2| (($ (S)))
        (|error| "Only functions of independent variables allowed")) 

(PUT '|JBBFC-;P;PiLS;3| '|SPADreplace|
     '(XLAM (|i| |l|)
       (|error| "Only functions of independent variables allowed"))) 

(SDEFUN |JBBFC-;P;PiLS;3|
        ((|i| (|PositiveInteger|)) (|l| (|List| (|NonNegativeInteger|)))
         ($ (S)))
        (|error| "Only functions of independent variables allowed")) 

(PUT '|JBBFC-;P;LS;4| '|SPADreplace|
     '(XLAM (|l|) (|error| "Only functions of independent variables allowed"))) 

(SDEFUN |JBBFC-;P;LS;4| ((|l| (|List| (|NonNegativeInteger|))) ($ (S)))
        (|error| "Only functions of independent variables allowed")) 

(PUT '|JBBFC-;P;PiNniS;5| '|SPADreplace|
     '(XLAM (|i| |l|)
       (|error| "Only functions of independent variables allowed"))) 

(SDEFUN |JBBFC-;P;PiNniS;5|
        ((|i| (|PositiveInteger|)) (|l| (|NonNegativeInteger|)) ($ (S)))
        (|error| "Only functions of independent variables allowed")) 

(PUT '|JBBFC-;P;NniS;6| '|SPADreplace|
     '(XLAM (|i|) (|error| "Only functions of independent variables allowed"))) 

(SDEFUN |JBBFC-;P;NniS;6| ((|i| (|NonNegativeInteger|)) ($ (S)))
        (|error| "Only functions of independent variables allowed")) 

(DECLAIM (NOTINLINE |JetBundleBaseFunctionCategory&;|)) 

(DEFUN |JetBundleBaseFunctionCategory&| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|JetBundleBaseFunctionCategory&| DV$1 DV$2))
          (LETT $ (GETREFV 17))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|JetBundleBaseFunctionCategory&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|PositiveInteger|) |JBBFC-;U;PiS;1| |JBBFC-;U;S;2| (|List| 14)
              |JBBFC-;P;PiLS;3| |JBBFC-;P;LS;4| (|NonNegativeInteger|)
              |JBBFC-;P;PiNniS;5| |JBBFC-;P;NniS;6|)
           '#(U 0 P 9) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((P (|#1| (|NonNegativeInteger|))) T)
                                   '((P
                                      (|#1| (|PositiveInteger|)
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((P (|#1| (|List| (|NonNegativeInteger|))))
                                     T)
                                   '((U (|#1|)) T)
                                   '((P
                                      (|#1| (|PositiveInteger|)
                                       (|List| (|NonNegativeInteger|))))
                                     T)
                                   '((U (|#1| (|PositiveInteger|))) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 16
                                            '(0 0 0 10 1 0 0 8 9 1 0 0 14 16 1
                                              0 0 11 13 2 0 0 8 14 15 2 0 0 8
                                              11 12)))))
           '|lookupComplete|)) 
