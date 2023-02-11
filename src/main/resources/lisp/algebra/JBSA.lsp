
(SDEFUN |JBSA;setNotation;2S;1| ((|s| (|Symbol|)) ($ (|Symbol|)))
        (SEQ
         (SPADCALL
          (SPADCALL "only repeated index notation possible" (QREFELT $ 34))
          (QREFELT $ 36))
         (EXIT '|Repeated|))) 

(PUT '|JBSA;getNotation;S;2| '|SPADreplace| '(XLAM NIL '|Repeated|)) 

(SDEFUN |JBSA;getNotation;S;2| (($ (|Symbol|))) '|Repeated|) 

(SDEFUN |JBSA;multiIndex;$L;3| ((|jv| ($)) ($ (|List| (|NonNegativeInteger|))))
        (SPADCALL |jv| (QREFELT $ 40))) 

(SDEFUN |JBSA;index;$Pi;4| ((|jv| ($)) ($ (|PositiveInteger|)))
        (SPADCALL |jv| (QREFELT $ 42))) 

(SDEFUN |JBSA;type;$S;5| ((|jv| ($)) ($ (|Symbol|)))
        (SPADCALL |jv| (QREFELT $ 44))) 

(SDEFUN |JBSA;X;Pi$;6| ((|up| (|PositiveInteger|)) ($ ($)))
        (SPADCALL |up| (QREFELT $ 46))) 

(SDEFUN |JBSA;U;Pi$;7| ((|up| (|PositiveInteger|)) ($ ($)))
        (SPADCALL |up| (QREFELT $ 48))) 

(SDEFUN |JBSA;Pm;PiL$;8|
        ((|up| (|PositiveInteger|)) (|lo| (|List| (|NonNegativeInteger|)))
         ($ ($)))
        (SPADCALL |up| |lo| (QREFELT $ 50))) 

(SDEFUN |JBSA;coerce;S$;9| ((|s| (|Symbol|)) ($ ($)))
        (SPADCALL |s| (QREFELT $ 52))) 

(SDEFUN |JBSA;D;SL$;10| ((|u| (|Symbol|)) (|der| (|List| (|Symbol|))) ($ ($)))
        (SPADCALL |u| |der| (QREFELT $ 54))) 

(SDEFUN |JBSA;One;$;11| (($ ($))) (|spadConstant| $ 56)) 

(SDEFUN |JBSA;numIndVar;Pi;12| (($ (|PositiveInteger|)))
        (+ (QREFELT $ 11) (QREFELT $ 13))) 

(SDEFUN |JBSA;numDepVar;Pi;13| (($ (|PositiveInteger|)))
        (+ (QREFELT $ 11) (QREFELT $ 13))) 

(SDEFUN |JBSA;name;$S;14| ((|jv| ($)) ($ (|Symbol|)))
        (SPADCALL |jv| (QREFELT $ 59))) 

(SDEFUN |JBSA;coerce;$E;15| ((|jv| ($)) ($ (|Expression| (|Integer|))))
        (SPADCALL |jv| (QREFELT $ 62))) 

(DECLAIM (NOTINLINE |JetBundleSymAna;|)) 

(DEFUN |JetBundleSymAna| (&REST #1=#:G761)
  (SPROG NIL
         (PROG (#2=#:G762)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction|
                     (|devaluate_sig| #1# '(T NIL NIL))
                     (HGET |$ConstructorCache| '|JetBundleSymAna|)
                     '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |JetBundleSymAna;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|JetBundleSymAna|)))))))))) 

(DEFUN |JetBundleSymAna;| (|#1| |#2| |#3|)
  (SPROG
   ((#1=#:G760 NIL) (|i| NIL) (#2=#:G759 NIL) (#3=#:G758 NIL) (#4=#:G757 NIL)
    (#5=#:G756 NIL) (|jv| NIL) (#6=#:G755 NIL) (#7=#:G715 NIL) (#8=#:G754 NIL)
    (#9=#:G753 NIL) (#10=#:G711 NIL) (#11=#:G752 NIL) (#12=#:G751 NIL)
    (|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
   (SEQ
    (PROGN
     (LETT DV$1 (|devaluate| |#1|))
     (LETT DV$2 |#2|)
     (LETT DV$3 |#3|)
     (LETT |dv$| (LIST '|JetBundleSymAna| DV$1 DV$2 DV$3))
     (LETT $ (GETREFV 72))
     (QSETREFV $ 0 |dv$|)
     (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
     (|haddProp| |$ConstructorCache| '|JetBundleSymAna| (LIST DV$1 DV$2 DV$3)
                 (CONS 1 $))
     (|stuffDomainSlots| $)
     (QSETREFV $ 6 |#1|)
     (QSETREFV $ 7 |#2|)
     (QSETREFV $ 8 |#3|)
     (SETF |pv$| (QREFELT $ 3))
     (QSETREFV $ 11 (SPADCALL (QREFELT $ 10)))
     (QSETREFV $ 13 (SPADCALL (QREFELT $ 12)))
     (QSETREFV $ 18
               (SPADCALL
                (PROGN
                 (LETT #12# NIL)
                 (SEQ (LETT |i| 1) (LETT #11# (QREFELT $ 11)) G190
                      (COND ((|greater_SI| |i| #11#) (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #12#
                              (CONS
                               (SPADCALL
                                (PROG1 (LETT #10# |i|)
                                  (|check_subtype2| (> #10# 0)
                                                    '(|PositiveInteger|)
                                                    '(|NonNegativeInteger|)
                                                    #10#))
                                (QREFELT $ 14))
                               #12#))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                      (EXIT (NREVERSE #12#))))
                (PROGN
                 (LETT #9# NIL)
                 (SEQ (LETT |i| 1) (LETT #8# (QREFELT $ 13)) G190
                      (COND ((|greater_SI| |i| #8#) (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #9#
                              (CONS
                               (SPADCALL
                                (PROG1 (LETT #7# |i|)
                                  (|check_subtype2| (> #7# 0)
                                                    '(|PositiveInteger|)
                                                    '(|NonNegativeInteger|)
                                                    #7#))
                                (QREFELT $ 15))
                               #9#))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                      (EXIT (NREVERSE #9#))))
                (QREFELT $ 17)))
     (QSETREFV $ 21
               (PROGN
                (LETT #6# NIL)
                (SEQ (LETT |jv| NIL) (LETT #5# (QREFELT $ 18)) G190
                     (COND
                      ((OR (ATOM #5#) (PROGN (LETT |jv| (CAR #5#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT #6# (CONS (SPADCALL |jv| (QREFELT $ 20)) #6#))))
                     (LETT #5# (CDR #5#)) (GO G190) G191
                     (EXIT (NREVERSE #6#)))))
     (QSETREFV $ 22 NIL)
     (COND
      ((QEQCAR |#2| 0)
       (COND
        ((> (QREFELT $ 11) 1)
         (SETELT $ 22
                 (PROGN
                  (LETT #4# NIL)
                  (SEQ (LETT |i| 1) (LETT #3# (QREFELT $ 11)) G190
                       (COND ((|greater_SI| |i| #3#) (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #4#
                               (CONS
                                (SPADCALL (QCDR |#2|)
                                          (LIST (SPADCALL |i| (QREFELT $ 27)))
                                          (QREFELT $ 29))
                                #4#))))
                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                       (EXIT (NREVERSE #4#))))))
        ('T (SETELT $ 22 (LIST (QCDR |#2|))))))
      ('T (SETELT $ 22 (QCDR |#2|))))
     (COND
      ((QEQCAR |#3| 0)
       (COND
        ((> (QREFELT $ 13) 1)
         (SETELT $ 22
                 (SPADCALL (QREFELT $ 22)
                           (PROGN
                            (LETT #2# NIL)
                            (SEQ (LETT |i| 1) (LETT #1# (QREFELT $ 13)) G190
                                 (COND ((|greater_SI| |i| #1#) (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT #2#
                                         (CONS
                                          (SPADCALL (QCDR |#3|)
                                                    (LIST
                                                     (SPADCALL |i|
                                                               (QREFELT $ 27)))
                                                    (QREFELT $ 29))
                                          #2#))))
                                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                 (EXIT (NREVERSE #2#))))
                           (QREFELT $ 31))))
        ('T
         (SETELT $ 22
                 (SPADCALL (QREFELT $ 22) (LIST (QCDR |#3|))
                           (QREFELT $ 31))))))
      ('T (SETELT $ 22 (SPADCALL (QREFELT $ 22) (QCDR |#3|) (QREFELT $ 31)))))
     (QSETREFV $ 32 (|JetBundle| (QREFELT $ 21) (QREFELT $ 22)))
     $)))) 

(MAKEPROP '|JetBundleSymAna| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|PositiveInteger|) (0 . |numIndVar|) '|nn|
              (4 . |numDepVar|) '|mm| (8 . X) (13 . U) (|List| 6)
              (18 . |concat!|) '|vars| (|Symbol|) (24 . |name|) '|indVars|
              '|depVars|
              (CONS IDENTITY (FUNCALL (|dispatchFunction| |JBSA;One;$;11|) $))
              (29 . |One|) (|OutputForm|) (|NonNegativeInteger|)
              (33 . |coerce|) (|List| 25) (38 . |superscript|) (|List| 19)
              (44 . |append|) '|Rep| (|String|) (50 . |message|) (|Void|)
              (55 . |print|) |JBSA;setNotation;2S;1| |JBSA;getNotation;S;2|
              (|List| 26) (60 . |multiIndex|) |JBSA;multiIndex;$L;3|
              (65 . |index|) |JBSA;index;$Pi;4| (70 . |type|) |JBSA;type;$S;5|
              (75 . X) |JBSA;X;Pi$;6| (80 . U) |JBSA;U;Pi$;7| (85 . |Pm|)
              |JBSA;Pm;PiL$;8| (91 . |coerce|) |JBSA;coerce;S$;9| (96 . D)
              |JBSA;D;SL$;10| (102 . |One|) |JBSA;numIndVar;Pi;12|
              |JBSA;numDepVar;Pi;13| (106 . |name|) |JBSA;name;$S;14|
              (|Expression| (|Integer|)) (111 . |coerce|) |JBSA;coerce;$E;15|
              (|List| $) (|Boolean|) (|List| 9) (|Union| $ '"failed")
              (|Union| $ '"0") (|List| 66) (|HashState|) (|SingleInteger|))
           '#(~= 116 |weight| 122 |variables| 127 |type| 138 |smaller?| 143
              |setNotation| 149 |repeatedIndex| 154 |r2m| 159 |order| 164
              |one?| 169 |numIndVar| 174 |numDepVar| 178 |name| 182
              |multiIndex| 187 |min| 192 |max| 198 |m2r| 204 |latex| 209
              |integrateIfCan| 214 |integrate| 220 |index| 226 |hashUpdate!|
              231 |hash| 237 |getNotation| 242 |dimS| 246 |dimJ| 251
              |differentiate| 256 |derivativeOf?| 262 |coerce| 268 |class| 283
              |allRepeated| 293 X 298 U 307 |Pr| 316 |Pm| 322 P 328 |One| 350 D
              354 >= 360 > 366 = 372 <= 378 < 384)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 0 0 0))
                 (CONS
                  '#(|JetBundleCategory&| |OrderedSet&| NIL |SetCategory&|
                     |BasicType&| NIL |PartialOrder&| NIL)
                  (CONS
                   '#((|JetBundleCategory|) (|OrderedSet|) (|Comparable|)
                      (|SetCategory|) (|BasicType|) (|CoercibleTo| 61)
                      (|PartialOrder|) (|CoercibleTo| 25))
                   (|makeByteWordVec2| 71
                                       '(0 6 9 10 0 6 9 12 1 6 0 9 14 1 6 0 9
                                         15 2 16 0 0 0 17 1 6 19 0 20 0 6 0 24
                                         1 26 25 0 27 2 19 0 0 28 29 2 30 0 0 0
                                         31 1 25 0 33 34 1 25 35 0 36 1 32 39 0
                                         40 1 32 9 0 42 1 32 19 0 44 1 32 0 9
                                         46 1 32 0 9 48 2 32 0 9 39 50 1 32 0
                                         19 52 2 32 0 19 30 54 0 32 0 56 1 32
                                         19 0 59 1 32 61 0 62 2 0 65 0 0 1 1 0
                                         26 0 1 2 0 64 26 9 1 1 0 64 26 1 1 0
                                         19 0 45 2 0 65 0 0 1 1 0 19 19 37 1 0
                                         66 0 1 1 0 39 66 1 1 0 26 0 1 1 0 65 0
                                         1 0 0 9 57 0 0 9 58 1 0 19 0 60 1 0 39
                                         0 41 2 0 0 0 0 1 2 0 0 0 0 1 1 0 66 39
                                         1 1 0 33 0 1 2 0 67 0 9 1 2 0 0 0 9 1
                                         1 0 9 0 43 2 0 70 70 0 1 1 0 71 0 1 0
                                         0 19 38 1 0 26 26 1 1 0 26 26 1 2 0 68
                                         0 9 1 2 0 39 0 0 1 1 0 0 19 53 1 0 61
                                         0 63 1 0 25 0 1 1 0 26 0 1 1 0 26 39 1
                                         1 0 69 39 1 0 0 0 1 1 0 0 9 47 0 0 0 1
                                         1 0 0 9 49 2 0 0 9 66 1 2 0 0 9 39 51
                                         1 0 0 26 1 1 0 0 39 1 2 0 0 9 26 1 2 0
                                         0 9 39 1 0 0 0 23 2 0 0 19 30 55 2 0
                                         65 0 0 1 2 0 65 0 0 1 2 0 65 0 0 1 2 0
                                         65 0 0 1 2 0 65 0 0 1)))))
           '|lookupComplete|)) 
