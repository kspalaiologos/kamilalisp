
(SDEFUN |FFHOM;compare|
        ((|g| (|SparseUnivariatePolynomial| GF))
         (|f| (|SparseUnivariatePolynomial| GF)) ($ (|Boolean|)))
        (SPROG
         ((|equal| (|Integer|)) (|g1| #1=(|PositiveInteger|)) (|f1| #1#)
          (|i| NIL))
         (SEQ
          (COND
           ((> (SPADCALL |f| (QREFELT $ 33)) (SPADCALL |g| (QREFELT $ 33))) 'T)
           ((< (SPADCALL |f| (QREFELT $ 33)) (SPADCALL |g| (QREFELT $ 33)))
            NIL)
           (#2='T
            (SEQ (LETT |equal| 0)
                 (SEQ (LETT |i| (SPADCALL |f| (QREFELT $ 33))) G190
                      (COND ((OR (< |i| 0) (NULL (EQL |equal| 0))) (GO G191)))
                      (SEQ
                       (COND
                        ((NULL
                          (SPADCALL (SPADCALL |f| |i| (QREFELT $ 38))
                                    (QREFELT $ 39)))
                         (COND
                          ((SPADCALL (SPADCALL |g| |i| (QREFELT $ 38))
                                     (QREFELT $ 39))
                           (EXIT (LETT |equal| 1))))))
                       (COND
                        ((NULL
                          (SPADCALL (SPADCALL |g| |i| (QREFELT $ 38))
                                    (QREFELT $ 39)))
                         (COND
                          ((SPADCALL (SPADCALL |f| |i| (QREFELT $ 38))
                                     (QREFELT $ 39))
                           (EXIT (LETT |equal| -1))))))
                       (LETT |f1|
                             (SPADCALL (SPADCALL |f| |i| (QREFELT $ 38))
                                       (QREFELT $ 40)))
                       (LETT |g1|
                             (SPADCALL (SPADCALL |g| |i| (QREFELT $ 38))
                                       (QREFELT $ 40)))
                       (EXIT
                        (COND ((> |f1| |g1|) (LETT |equal| 1))
                              ((< |f1| |g1|) (LETT |equal| -1)))))
                      (LETT |i| (+ |i| -1)) (GO G190) G191 (EXIT NIL))
                 (EXIT (COND ((EQL |equal| 1) 'T) (#2# NIL))))))))) 

(SDEFUN |FFHOM;initialize| (($ (|Void|)))
        (SPROG
         ((|matbs| #1=(|Matrix| GF)) (#2=#:G734 NIL) (|matsb| #1#)
          (#3=#:G765 NIL) (|i| NIL) (|mat| #1#)
          (|arr| (|PrimitiveArray| (|SparseUnivariatePolynomial| GF)))
          (#4=#:G764 NIL) (#5=#:G763 NIL) (|rowind| (|Integer|))
          (|ra| (|Integer|)) (|iVec| (|Vector| (|Integer|)))
          (|a| #6=(|FiniteFieldExtensionByPolynomial| GF |dPbig|))
          (#7=#:G762 NIL) (|root| #6#)
          (|rTsmall|
           (|Union| #8="prime" #9="polynomial" #10="normal" #11="cyclic"))
          (|dPsmall| (|SparseUnivariatePolynomial| GF))
          (|rTbig| (|Union| #8# #9# #10# #11#))
          (|dPbig| (|SparseUnivariatePolynomial| GF))
          (|degbig| (|NonNegativeInteger|)) (|degsmall| (|NonNegativeInteger|))
          (#12=#:G761 NIL))
         (SEQ
          (COND
           ((SPADCALL (QREFELT $ 30) (QREFELT $ 32) (QREFELT $ 41))
            (SEQ
             (LETT |mat|
                   (SPADCALL (QREFELT $ 11) (QREFELT $ 11) (QREFELT $ 19)))
             (LETT |arr| (SPADCALL (QREFELT $ 30) (QREFELT $ 44)))
             (SEQ (LETT |i| 1) (LETT #12# (QREFELT $ 11)) G190
                  (COND ((|greater_SI| |i| #12#) (GO G191)))
                  (SEQ
                   (EXIT
                    (SPADCALL |mat| |i|
                              (SPADCALL (QAREF1 |arr| (- |i| 1)) (QREFELT $ 11)
                                        (QREFELT $ 46))
                              (QREFELT $ 48))))
                  (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
             (EXIT
              (COND
               ((SPADCALL (QREFELT $ 24) (CONS 2 "normal") (QREFELT $ 49))
                (SEQ (SETELT $ 20 (SPADCALL |mat| (QREFELT $ 50)))
                     (SETELT $ 21
                             (SPADCALL
                              (PROG2 (LETT #2# (SPADCALL |mat| (QREFELT $ 52)))
                                  (QCDR #2#)
                                (|check_union2| (QEQCAR #2# 0)
                                                (|Matrix| (QREFELT $ 7))
                                                (|Union|
                                                 (|Matrix| (QREFELT $ 7))
                                                 #13="failed")
                                                #2#))
                              (QREFELT $ 50)))
                     (SETELT $ 27 NIL) (EXIT (SPADCALL (QREFELT $ 54)))))
               (#14='T
                (SEQ (SETELT $ 21 (SPADCALL |mat| (QREFELT $ 50)))
                     (SETELT $ 20
                             (SPADCALL
                              (PROG2 (LETT #2# (SPADCALL |mat| (QREFELT $ 52)))
                                  (QCDR #2#)
                                (|check_union2| (QEQCAR #2# 0)
                                                (|Matrix| (QREFELT $ 7))
                                                (|Union|
                                                 (|Matrix| (QREFELT $ 7)) #13#)
                                                #2#))
                              (QREFELT $ 50)))
                     (SETELT $ 27 NIL) (EXIT (SPADCALL (QREFELT $ 54)))))))))
           (#14#
            (SEQ (LETT |dPbig| (QREFELT $ 32)) (LETT |rTbig| (QREFELT $ 26))
                 (LETT |dPsmall| (QREFELT $ 30))
                 (LETT |rTsmall| (QREFELT $ 24)) (LETT |degbig| (QREFELT $ 13))
                 (LETT |degsmall| (QREFELT $ 11))
                 (COND
                  ((|FFHOM;compare| (QREFELT $ 32) (QREFELT $ 30) $)
                   (SEQ (LETT |degsmall| (QREFELT $ 13))
                        (LETT |degbig| (QREFELT $ 11))
                        (LETT |dPbig| (QREFELT $ 30))
                        (LETT |rTbig| (QREFELT $ 24))
                        (LETT |dPsmall| (QREFELT $ 32))
                        (EXIT (LETT |rTsmall| (QREFELT $ 26))))))
                 (LETT |root|
                       (SPADCALL |dPsmall|
                                 (|compiledLookupCheck|
                                  '|rootOfIrreduciblePoly|
                                  (LIST
                                   (LIST '|FiniteFieldExtensionByPolynomial|
                                         (|devaluate| (ELT $ 7)) |dPbig|)
                                   (LIST '|SparseUnivariatePolynomial|
                                         (|devaluate| (ELT $ 7))))
                                  (|FiniteFieldPolynomialPackage2|
                                   (|FiniteFieldExtensionByPolynomial|
                                    (ELT $ 7) |dPbig|)
                                   (ELT $ 7)))))
                 (LETT |matsb| (SPADCALL |degbig| |degsmall| (QREFELT $ 19)))
                 (QSETAREF2O |matsb| 1 1 (|spadConstant| $ 35) 1 1)
                 (LETT |a| |root|)
                 (SEQ (LETT |i| 2) (LETT #7# |degsmall|) G190
                      (COND ((|greater_SI| |i| #7#) (GO G191)))
                      (SEQ
                       (SPADCALL |matsb| |i|
                                 (SPADCALL |a|
                                           (|compiledLookupCheck|
                                            '|coordinates|
                                            (LIST
                                             (LIST '|Vector|
                                                   (|devaluate| (ELT $ 7)))
                                             '$)
                                            (|FiniteFieldExtensionByPolynomial|
                                             (ELT $ 7) |dPbig|)))
                                 (QREFELT $ 48))
                       (EXIT
                        (LETT |a|
                              (SPADCALL |a| |root|
                                        (|compiledLookupCheck| '*
                                                               (LIST '$ '$ '$)
                                                               (|FiniteFieldExtensionByPolynomial|
                                                                (ELT $ 7)
                                                                |dPbig|))))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                 (LETT |ra| 1)
                 (LETT |mat|
                       (SPADCALL (SPADCALL |matsb| 1 (QREFELT $ 55))
                                 (QREFELT $ 56)))
                 (LETT |rowind| 2) (LETT |iVec| (MAKEARR1 |degsmall| 1))
                 (SEQ G190 (COND ((NULL (< |ra| |degsmall|)) (GO G191)))
                      (SEQ
                       (COND
                        ((>
                          (SPADCALL
                           (SPADCALL |mat|
                                     (SPADCALL
                                      (SPADCALL |matsb| |rowind|
                                                (QREFELT $ 55))
                                      (QREFELT $ 56))
                                     (QREFELT $ 57))
                           (QREFELT $ 58))
                          |ra|)
                         (SEQ
                          (LETT |mat|
                                (SPADCALL |mat|
                                          (SPADCALL
                                           (SPADCALL |matsb| |rowind|
                                                     (QREFELT $ 55))
                                           (QREFELT $ 56))
                                          (QREFELT $ 57)))
                          (LETT |ra| (+ |ra| 1))
                          (EXIT
                           (SPADCALL |iVec| |ra| |rowind| (QREFELT $ 60))))))
                       (EXIT (LETT |rowind| (+ |rowind| 1))))
                      NIL (GO G190) G191 (EXIT NIL))
                 (LETT |mat|
                       (PROG2 (LETT #2# (SPADCALL |mat| (QREFELT $ 52)))
                           (QCDR #2#)
                         (|check_union2| (QEQCAR #2# 0)
                                         (|Matrix| (QREFELT $ 7))
                                         (|Union| (|Matrix| (QREFELT $ 7))
                                                  #13#)
                                         #2#)))
                 (LETT |matbs| (SPADCALL |degsmall| |degbig| (QREFELT $ 19)))
                 (SEQ (LETT |i| 1) (LETT #5# |degsmall|) G190
                      (COND ((|greater_SI| |i| #5#) (GO G191)))
                      (SEQ
                       (EXIT
                        (SPADCALL |matbs| (SPADCALL |iVec| |i| (QREFELT $ 61))
                                  (SPADCALL |mat| |i| (QREFELT $ 62))
                                  (QREFELT $ 48))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                 (COND
                  ((SPADCALL |rTbig| (CONS 2 "normal") (QREFELT $ 49))
                   (SEQ (LETT |arr| (SPADCALL |dPbig| (QREFELT $ 44)))
                        (LETT |mat|
                              (SPADCALL |degbig| |degbig| (QREFELT $ 19)))
                        (SEQ (LETT |i| 1) (LETT #4# |degbig|) G190
                             (COND ((|greater_SI| |i| #4#) (GO G191)))
                             (SEQ
                              (EXIT
                               (SPADCALL |mat| |i|
                                         (SPADCALL (QAREF1 |arr| (- |i| 1))
                                                   |degbig| (QREFELT $ 46))
                                         (QREFELT $ 48))))
                             (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                             (EXIT NIL))
                        (LETT |matsb|
                              (SPADCALL
                               (PROG2
                                   (LETT #2# (SPADCALL |mat| (QREFELT $ 52)))
                                   (QCDR #2#)
                                 (|check_union2| (QEQCAR #2# 0)
                                                 (|Matrix| (QREFELT $ 7))
                                                 (|Union|
                                                  (|Matrix| (QREFELT $ 7))
                                                  #13#)
                                                 #2#))
                               |matsb| (QREFELT $ 63)))
                        (EXIT
                         (LETT |matbs|
                               (SPADCALL |matbs| |mat| (QREFELT $ 63)))))))
                 (COND
                  ((SPADCALL |rTsmall| (CONS 2 "normal") (QREFELT $ 49))
                   (SEQ (LETT |arr| (SPADCALL |dPsmall| (QREFELT $ 44)))
                        (LETT |mat|
                              (SPADCALL |degsmall| |degsmall| (QREFELT $ 19)))
                        (SEQ (LETT |i| 1) (LETT #3# |degsmall|) G190
                             (COND ((|greater_SI| |i| #3#) (GO G191)))
                             (SEQ
                              (EXIT
                               (SPADCALL |mat| |i|
                                         (SPADCALL (QAREF1 |arr| (- |i| 1))
                                                   |degsmall| (QREFELT $ 46))
                                         (QREFELT $ 48))))
                             (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                             (EXIT NIL))
                        (LETT |matsb| (SPADCALL |matsb| |mat| (QREFELT $ 63)))
                        (EXIT
                         (LETT |matbs|
                               (SPADCALL
                                (PROG2
                                    (LETT #2# (SPADCALL |mat| (QREFELT $ 52)))
                                    (QCDR #2#)
                                  (|check_union2| (QEQCAR #2# 0)
                                                  (|Matrix| (QREFELT $ 7))
                                                  (|Union|
                                                   (|Matrix| (QREFELT $ 7))
                                                   #13#)
                                                  #2#))
                                |matbs| (QREFELT $ 63)))))))
                 (EXIT
                  (COND
                   ((SPADCALL |dPbig| (QREFELT $ 32) (QREFELT $ 41))
                    (SEQ (SETELT $ 20 |matsb|) (SETELT $ 21 |matbs|)
                         (SETELT $ 27 NIL) (EXIT (SPADCALL (QREFELT $ 54)))))
                   (#14#
                    (SEQ (SETELT $ 20 |matbs|) (SETELT $ 21 |matsb|)
                         (SETELT $ 27 NIL)
                         (EXIT (SPADCALL (QREFELT $ 54))))))))))))) 

(SDEFUN |FFHOM;coerce;F1F2;3| ((|x| (F1)) ($ (F2)))
        (COND
         ((SPADCALL |x| (QREFELT $ 64))
          (SPADCALL (SPADCALL |x| (QREFELT $ 65)) (QREFELT $ 66)))
         ((SPADCALL (QREFELT $ 30) (QREFELT $ 32) (QREFELT $ 41))
          (|FFHOM;convertWRTsameDefPol12| |x| $))
         ('T (|FFHOM;convertWRTdifferentDefPol12| |x| $)))) 

(SDEFUN |FFHOM;convertWRTsameDefPol12| ((|x| (F1)) ($ (F2)))
        (SEQ
         (COND ((SPADCALL (QREFELT $ 24) (QREFELT $ 26) (QREFELT $ 49)) |x|)
               ((SPADCALL (QREFELT $ 24) (CONS 3 "cyclic") (QREFELT $ 49))
                (COND
                 ((SPADCALL |x| (|spadConstant| $ 36) (QREFELT $ 68))
                  (|spadConstant| $ 69))
                 (#1='T
                  (SPADCALL (SPADCALL (QREFELT $ 70)) |x| (QREFELT $ 71)))))
               ((SPADCALL (QREFELT $ 26) (CONS 3 "cyclic") (QREFELT $ 49))
                (COND
                 ((SPADCALL |x| (|spadConstant| $ 36) (QREFELT $ 68))
                  (|spadConstant| $ 69))
                 (#1# (SPADCALL |x| (QREFELT $ 72)))))
               (#1#
                (SEQ (COND ((QREFELT $ 27) (|FFHOM;initialize| $)))
                     (EXIT
                      (SPADCALL
                       (SPADCALL (QREFELT $ 20) (SPADCALL |x| (QREFELT $ 73))
                                 (QREFELT $ 74))
                       (QREFELT $ 75)))))))) 

(SDEFUN |FFHOM;convertWRTdifferentDefPol12| ((|x| (F1)) ($ (F2)))
        (SEQ (COND ((QREFELT $ 27) (|FFHOM;initialize| $)))
             (COND
              ((> (QREFELT $ 11) (QREFELT $ 13))
               (COND
                ((SPADCALL
                  (SPADCALL (QREFELT $ 13) (SPADCALL |x| (QREFELT $ 78))
                            (QREFELT $ 79))
                  0 (QREFELT $ 80))
                 (|error|
                  "coerce: element doesn't belong to smaller field")))))
             (EXIT
              (SPADCALL
               (SPADCALL (QREFELT $ 20) (SPADCALL |x| (QREFELT $ 73))
                         (QREFELT $ 74))
               (QREFELT $ 75))))) 

(SDEFUN |FFHOM;coerce;F2F1;6| ((|x| (F2)) ($ (F1)))
        (COND
         ((SPADCALL |x| (QREFELT $ 81))
          (SPADCALL (SPADCALL |x| (QREFELT $ 82)) (QREFELT $ 83)))
         ((SPADCALL (QREFELT $ 30) (QREFELT $ 32) (QREFELT $ 41))
          (|FFHOM;convertWRTsameDefPol21| |x| $))
         ('T (|FFHOM;convertWRTdifferentDefPol21| |x| $)))) 

(SDEFUN |FFHOM;convertWRTsameDefPol21| ((|x| (F2)) ($ (F1)))
        (SEQ
         (COND ((SPADCALL (QREFELT $ 24) (QREFELT $ 26) (QREFELT $ 49)) |x|)
               ((SPADCALL (QREFELT $ 26) (CONS 3 "cyclic") (QREFELT $ 49))
                (COND
                 ((SPADCALL |x| (|spadConstant| $ 69) (QREFELT $ 85))
                  (|spadConstant| $ 36))
                 (#1='T
                  (SPADCALL (SPADCALL (QREFELT $ 86)) |x| (QREFELT $ 87)))))
               ((SPADCALL (QREFELT $ 24) (CONS 3 "cyclic") (QREFELT $ 49))
                (COND
                 ((SPADCALL |x| (|spadConstant| $ 69) (QREFELT $ 85))
                  (|spadConstant| $ 36))
                 (#1# (SPADCALL |x| (QREFELT $ 88)))))
               (#1#
                (SEQ (COND ((QREFELT $ 27) (|FFHOM;initialize| $)))
                     (EXIT
                      (SPADCALL
                       (SPADCALL (QREFELT $ 21) (SPADCALL |x| (QREFELT $ 89))
                                 (QREFELT $ 74))
                       (QREFELT $ 90)))))))) 

(SDEFUN |FFHOM;convertWRTdifferentDefPol21| ((|x| (F2)) ($ (F1)))
        (SEQ (COND ((QREFELT $ 27) (|FFHOM;initialize| $)))
             (COND
              ((> (QREFELT $ 13) (QREFELT $ 11))
               (COND
                ((SPADCALL
                  (SPADCALL (QREFELT $ 11) (SPADCALL |x| (QREFELT $ 92))
                            (QREFELT $ 79))
                  0 (QREFELT $ 80))
                 (|error|
                  "coerce: element doesn't belong to smaller field")))))
             (EXIT
              (SPADCALL
               (SPADCALL (QREFELT $ 21) (SPADCALL |x| (QREFELT $ 89))
                         (QREFELT $ 74))
               (QREFELT $ 90))))) 

(DECLAIM (NOTINLINE |FiniteFieldHomomorphisms;|)) 

(DEFUN |FiniteFieldHomomorphisms| (&REST #1=#:G785)
  (SPROG NIL
         (PROG (#2=#:G786)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|FiniteFieldHomomorphisms|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |FiniteFieldHomomorphisms;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|FiniteFieldHomomorphisms|)))))))))) 

(DEFUN |FiniteFieldHomomorphisms;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|FiniteFieldHomomorphisms| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 93))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FiniteFieldHomomorphisms|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 11 (SPADCALL (QREFELT $ 10)))
          (QSETREFV $ 13 (SPADCALL (QREFELT $ 12)))
          (QSETREFV $ 17
                    (SPADCALL
                     (REM (MAX (QREFELT $ 11) (QREFELT $ 13))
                          (MIN (QREFELT $ 11) (QREFELT $ 13)))
                     0 (QREFELT $ 16)))
          (COND
           ((QREFELT $ 17)
            (|error| "FFHOM: one extension degree must divide the other one")))
          (QSETREFV $ 20
                    (SPADCALL (QREFELT $ 13) (QREFELT $ 11) (QREFELT $ 19)))
          (QSETREFV $ 21
                    (SPADCALL (QREFELT $ 11) (QREFELT $ 13) (QREFELT $ 19)))
          (QSETREFV $ 24 (SPADCALL (QREFELT $ 23)))
          (QSETREFV $ 26 (SPADCALL (QREFELT $ 25)))
          (QSETREFV $ 27 'T)
          (QSETREFV $ 30 (SPADCALL (QREFELT $ 29)))
          (QSETREFV $ 32 (SPADCALL (QREFELT $ 31)))
          $))) 

(MAKEPROP '|FiniteFieldHomomorphisms| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|PositiveInteger|) (0 . |extensionDegree|)
              '|degree1| (4 . |extensionDegree|) '|degree2| (|Boolean|)
              (|NonNegativeInteger|) (8 . ~=) '#:G689 (|Matrix| 7)
              (14 . |zero|) '|conMat1to2| '|conMat2to1|
              (|Union| '"prime" '"polynomial" '"normal" '"cyclic")
              (20 . |representationType|) '|repType1|
              (24 . |representationType|) '|repType2| '|init?|
              (|SparseUnivariatePolynomial| 7) (28 . |definingPolynomial|)
              '|defPol1| (32 . |definingPolynomial|) '|defPol2| (36 . |degree|)
              (41 . |One|) (45 . |One|) (49 . |Zero|) (53 . |Zero|)
              (57 . |coefficient|) (63 . |zero?|) (68 . |lookup|) (73 . =)
              (|PrimitiveArray| 28) (|FiniteFieldPolynomialPackage| 7)
              (79 . |reducedQPowers|) (|Vector| 7) (84 . |vectorise|)
              (|Integer|) (90 . |setColumn!|) (97 . =) (103 . |copy|)
              (|Union| $ '"failed") (108 . |inverse|) (|Void|) (113 . |void|)
              (117 . |row|) (123 . |transpose|) (128 . |vertConcat|)
              (134 . |rank|) (|Vector| 47) (139 . |setelt!|) (146 . |elt|)
              (152 . |column|) (158 . *) (164 . |inGroundField?|)
              (169 . |retract|) (174 . |coerce|) |FFHOM;coerce;F1F2;3|
              (179 . =) (185 . |Zero|) (189 . |primitiveElement|) (193 . ^)
              (199 . |discreteLog|) (204 . |coordinates|) (209 . *)
              (215 . |represents|) (|OnePointCompletion| 9) (220 . |degree|)
              (225 . |degree|) (230 . |positiveRemainder|) (236 . ~=)
              (242 . |inGroundField?|) (247 . |retract|) (252 . |coerce|)
              |FFHOM;coerce;F2F1;6| (257 . =) (263 . |primitiveElement|)
              (267 . ^) (273 . |discreteLog|) (278 . |coordinates|)
              (283 . |represents|) (288 . |degree|) (293 . |degree|))
           '#(|coerce| 298) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|coerce| (|#3| |#1|)) T)
                                   '((|coerce| (|#1| |#3|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 92
                                            '(0 6 9 10 0 8 9 12 2 15 14 0 0 16
                                              2 18 0 15 15 19 0 6 22 23 0 8 22
                                              25 0 6 28 29 0 8 28 31 1 28 15 0
                                              33 0 6 0 34 0 7 0 35 0 6 0 36 0 7
                                              0 37 2 28 7 0 15 38 1 7 14 0 39 1
                                              7 9 0 40 2 28 14 0 0 41 1 43 42
                                              28 44 2 28 45 0 15 46 3 18 0 0 47
                                              45 48 2 22 14 0 0 49 1 18 0 0 50
                                              1 18 51 0 52 0 53 0 54 2 18 45 0
                                              47 55 1 18 0 45 56 2 18 0 0 0 57
                                              1 18 15 0 58 3 59 47 0 47 47 60 2
                                              59 47 0 47 61 2 18 45 0 47 62 2
                                              18 0 0 0 63 1 6 14 0 64 1 6 7 0
                                              65 1 8 0 7 66 2 6 14 0 0 68 0 8 0
                                              69 0 8 0 70 2 8 0 0 47 71 1 6 15
                                              0 72 1 6 45 0 73 2 18 45 0 45 74
                                              1 8 0 45 75 1 6 76 0 77 1 6 9 0
                                              78 2 47 0 0 0 79 2 47 14 0 0 80 1
                                              8 14 0 81 1 8 7 0 82 1 6 0 7 83 2
                                              8 14 0 0 85 0 6 0 86 2 6 0 0 47
                                              87 1 8 15 0 88 1 8 45 0 89 1 6 0
                                              45 90 1 8 76 0 91 1 8 9 0 92 1 0
                                              6 8 84 1 0 8 6 67)))))
           '|lookupComplete|)) 
