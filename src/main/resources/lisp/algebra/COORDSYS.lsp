
(PUT '|COORDSYS;cartesian;2P;1| '|SPADreplace| '(XLAM (|pt|) |pt|)) 

(SDEFUN |COORDSYS;cartesian;2P;1| ((|pt| (|Point| R)) ($ (|Point| R))) |pt|) 

(SDEFUN |COORDSYS;polar;2P;2| ((|pt0| (|Point| R)) ($ (|Point| R)))
        (SPROG ((|theta| (R)) (|r| (R)) (|pt| (|Point| R)))
               (SEQ (LETT |pt| (SPADCALL |pt0| (QREFELT $ 9)))
                    (LETT |r| (SPADCALL |pt0| 1 (QREFELT $ 12)))
                    (LETT |theta| (SPADCALL |pt0| 2 (QREFELT $ 12)))
                    (SPADCALL |pt| 1
                              (SPADCALL |r| (SPADCALL |theta| (QREFELT $ 13))
                                        (QREFELT $ 14))
                              (QREFELT $ 15))
                    (SPADCALL |pt| 2
                              (SPADCALL |r| (SPADCALL |theta| (QREFELT $ 16))
                                        (QREFELT $ 14))
                              (QREFELT $ 15))
                    (EXIT |pt|)))) 

(SDEFUN |COORDSYS;cylindrical;2P;3| ((|pt0| (|Point| R)) ($ (|Point| R)))
        (SPADCALL |pt0| (QREFELT $ 17))) 

(SDEFUN |COORDSYS;spherical;2P;4| ((|pt0| (|Point| R)) ($ (|Point| R)))
        (SPROG ((|phi| (R)) (|theta| (R)) (|r| (R)) (|pt| (|Point| R)))
               (SEQ (LETT |pt| (SPADCALL |pt0| (QREFELT $ 9)))
                    (LETT |r| (SPADCALL |pt0| 1 (QREFELT $ 12)))
                    (LETT |theta| (SPADCALL |pt0| 2 (QREFELT $ 12)))
                    (LETT |phi| (SPADCALL |pt0| 3 (QREFELT $ 12)))
                    (SPADCALL |pt| 1
                              (SPADCALL
                               (SPADCALL |r| (SPADCALL |phi| (QREFELT $ 16))
                                         (QREFELT $ 14))
                               (SPADCALL |theta| (QREFELT $ 13))
                               (QREFELT $ 14))
                              (QREFELT $ 15))
                    (SPADCALL |pt| 2
                              (SPADCALL
                               (SPADCALL |r| (SPADCALL |phi| (QREFELT $ 16))
                                         (QREFELT $ 14))
                               (SPADCALL |theta| (QREFELT $ 16))
                               (QREFELT $ 14))
                              (QREFELT $ 15))
                    (SPADCALL |pt| 3
                              (SPADCALL |r| (SPADCALL |phi| (QREFELT $ 13))
                                        (QREFELT $ 14))
                              (QREFELT $ 15))
                    (EXIT |pt|)))) 

(SDEFUN |COORDSYS;parabolic;2P;5| ((|pt0| (|Point| R)) ($ (|Point| R)))
        (SPROG ((|v| (R)) (|u| (R)) (|pt| (|Point| R)))
               (SEQ (LETT |pt| (SPADCALL |pt0| (QREFELT $ 9)))
                    (LETT |u| (SPADCALL |pt0| 1 (QREFELT $ 12)))
                    (LETT |v| (SPADCALL |pt0| 2 (QREFELT $ 12)))
                    (SPADCALL |pt| 1
                              (SPADCALL
                               (SPADCALL (SPADCALL |u| |u| (QREFELT $ 14))
                                         (SPADCALL |v| |v| (QREFELT $ 14))
                                         (QREFELT $ 20))
                               (SPADCALL 2 (QREFELT $ 21)) (QREFELT $ 22))
                              (QREFELT $ 15))
                    (SPADCALL |pt| 2 (SPADCALL |u| |v| (QREFELT $ 14))
                              (QREFELT $ 15))
                    (EXIT |pt|)))) 

(SDEFUN |COORDSYS;parabolicCylindrical;2P;6|
        ((|pt0| (|Point| R)) ($ (|Point| R))) (SPADCALL |pt0| (QREFELT $ 23))) 

(SDEFUN |COORDSYS;paraboloidal;2P;7| ((|pt0| (|Point| R)) ($ (|Point| R)))
        (SPROG ((|phi| (R)) (|v| (R)) (|u| (R)) (|pt| (|Point| R)))
               (SEQ (LETT |pt| (SPADCALL |pt0| (QREFELT $ 9)))
                    (LETT |u| (SPADCALL |pt0| 1 (QREFELT $ 12)))
                    (LETT |v| (SPADCALL |pt0| 2 (QREFELT $ 12)))
                    (LETT |phi| (SPADCALL |pt0| 3 (QREFELT $ 12)))
                    (SPADCALL |pt| 1
                              (SPADCALL (SPADCALL |u| |v| (QREFELT $ 14))
                                        (SPADCALL |phi| (QREFELT $ 13))
                                        (QREFELT $ 14))
                              (QREFELT $ 15))
                    (SPADCALL |pt| 2
                              (SPADCALL (SPADCALL |u| |v| (QREFELT $ 14))
                                        (SPADCALL |phi| (QREFELT $ 16))
                                        (QREFELT $ 14))
                              (QREFELT $ 15))
                    (SPADCALL |pt| 3
                              (SPADCALL
                               (SPADCALL (SPADCALL |u| |u| (QREFELT $ 14))
                                         (SPADCALL |v| |v| (QREFELT $ 14))
                                         (QREFELT $ 20))
                               (SPADCALL 2 (QREFELT $ 21)) (QREFELT $ 22))
                              (QREFELT $ 15))
                    (EXIT |pt|)))) 

(SDEFUN |COORDSYS;elliptic;RM;8|
        ((|a| (R)) ($ (|Mapping| (|Point| R) (|Point| R))))
        (SPROG NIL (SEQ (CONS #'|COORDSYS;elliptic;RM;8!0| (VECTOR |a| $))))) 

(SDEFUN |COORDSYS;elliptic;RM;8!0| ((|x| NIL) ($$ NIL))
        (PROG ($ |a|)
          (LETT $ (QREFELT $$ 1))
          (LETT |a| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|v| NIL) (|u| NIL) (|pt| NIL))
                   (SEQ (LETT |pt| (SPADCALL |x| (QREFELT $ 9)))
                        (LETT |u|
                              (SPADCALL |x| (|spadConstant| $ 26)
                                        (QREFELT $ 12)))
                        (LETT |v| (SPADCALL |x| 2 (QREFELT $ 12)))
                        (SPADCALL |pt| (|spadConstant| $ 28)
                                  (SPADCALL
                                   (SPADCALL |a| (SPADCALL |u| (QREFELT $ 29))
                                             (QREFELT $ 14))
                                   (SPADCALL |v| (QREFELT $ 13))
                                   (QREFELT $ 14))
                                  (QREFELT $ 15))
                        (SPADCALL |pt| 2
                                  (SPADCALL
                                   (SPADCALL |a| (SPADCALL |u| (QREFELT $ 30))
                                             (QREFELT $ 14))
                                   (SPADCALL |v| (QREFELT $ 16))
                                   (QREFELT $ 14))
                                  (QREFELT $ 15))
                        (EXIT |pt|))))))) 

(SDEFUN |COORDSYS;ellipticCylindrical;RM;9|
        ((|a| (R)) ($ (|Mapping| (|Point| R) (|Point| R))))
        (SPADCALL |a| (QREFELT $ 32))) 

(SDEFUN |COORDSYS;prolateSpheroidal;RM;10|
        ((|a| (R)) ($ (|Mapping| (|Point| R) (|Point| R))))
        (SPROG NIL
               (SEQ
                (CONS #'|COORDSYS;prolateSpheroidal;RM;10!0| (VECTOR |a| $))))) 

(SDEFUN |COORDSYS;prolateSpheroidal;RM;10!0| ((|x| NIL) ($$ NIL))
        (PROG ($ |a|)
          (LETT $ (QREFELT $$ 1))
          (LETT |a| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|phi| NIL) (|eta| NIL) (|xi| NIL) (|pt| NIL))
                   (SEQ (LETT |pt| (SPADCALL |x| (QREFELT $ 9)))
                        (LETT |xi|
                              (SPADCALL |x| (|spadConstant| $ 26)
                                        (QREFELT $ 12)))
                        (LETT |eta| (SPADCALL |x| 2 (QREFELT $ 12)))
                        (LETT |phi| (SPADCALL |x| 3 (QREFELT $ 12)))
                        (SPADCALL |pt| (|spadConstant| $ 28)
                                  (SPADCALL
                                   (SPADCALL
                                    (SPADCALL |a|
                                              (SPADCALL |xi| (QREFELT $ 30))
                                              (QREFELT $ 14))
                                    (SPADCALL |eta| (QREFELT $ 16))
                                    (QREFELT $ 14))
                                   (SPADCALL |phi| (QREFELT $ 13))
                                   (QREFELT $ 14))
                                  (QREFELT $ 15))
                        (SPADCALL |pt| 2
                                  (SPADCALL
                                   (SPADCALL
                                    (SPADCALL |a|
                                              (SPADCALL |xi| (QREFELT $ 30))
                                              (QREFELT $ 14))
                                    (SPADCALL |eta| (QREFELT $ 16))
                                    (QREFELT $ 14))
                                   (SPADCALL |phi| (QREFELT $ 16))
                                   (QREFELT $ 14))
                                  (QREFELT $ 15))
                        (SPADCALL |pt| 3
                                  (SPADCALL
                                   (SPADCALL |a| (SPADCALL |xi| (QREFELT $ 29))
                                             (QREFELT $ 14))
                                   (SPADCALL |eta| (QREFELT $ 13))
                                   (QREFELT $ 14))
                                  (QREFELT $ 15))
                        (EXIT |pt|))))))) 

(SDEFUN |COORDSYS;oblateSpheroidal;RM;11|
        ((|a| (R)) ($ (|Mapping| (|Point| R) (|Point| R))))
        (SPROG NIL
               (SEQ
                (CONS #'|COORDSYS;oblateSpheroidal;RM;11!0| (VECTOR |a| $))))) 

(SDEFUN |COORDSYS;oblateSpheroidal;RM;11!0| ((|x| NIL) ($$ NIL))
        (PROG ($ |a|)
          (LETT $ (QREFELT $$ 1))
          (LETT |a| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|phi| NIL) (|eta| NIL) (|xi| NIL) (|pt| NIL))
                   (SEQ (LETT |pt| (SPADCALL |x| (QREFELT $ 9)))
                        (LETT |xi|
                              (SPADCALL |x| (|spadConstant| $ 26)
                                        (QREFELT $ 12)))
                        (LETT |eta| (SPADCALL |x| 2 (QREFELT $ 12)))
                        (LETT |phi| (SPADCALL |x| 3 (QREFELT $ 12)))
                        (SPADCALL |pt| (|spadConstant| $ 28)
                                  (SPADCALL
                                   (SPADCALL
                                    (SPADCALL |a|
                                              (SPADCALL |xi| (QREFELT $ 30))
                                              (QREFELT $ 14))
                                    (SPADCALL |eta| (QREFELT $ 16))
                                    (QREFELT $ 14))
                                   (SPADCALL |phi| (QREFELT $ 13))
                                   (QREFELT $ 14))
                                  (QREFELT $ 15))
                        (SPADCALL |pt| 2
                                  (SPADCALL
                                   (SPADCALL
                                    (SPADCALL |a|
                                              (SPADCALL |xi| (QREFELT $ 29))
                                              (QREFELT $ 14))
                                    (SPADCALL |eta| (QREFELT $ 13))
                                    (QREFELT $ 14))
                                   (SPADCALL |phi| (QREFELT $ 16))
                                   (QREFELT $ 14))
                                  (QREFELT $ 15))
                        (SPADCALL |pt| 3
                                  (SPADCALL
                                   (SPADCALL |a| (SPADCALL |xi| (QREFELT $ 30))
                                             (QREFELT $ 14))
                                   (SPADCALL |eta| (QREFELT $ 16))
                                   (QREFELT $ 14))
                                  (QREFELT $ 15))
                        (EXIT |pt|))))))) 

(SDEFUN |COORDSYS;bipolar;RM;12|
        ((|a| (R)) ($ (|Mapping| (|Point| R) (|Point| R))))
        (SPROG NIL (SEQ (CONS #'|COORDSYS;bipolar;RM;12!0| (VECTOR |a| $))))) 

(SDEFUN |COORDSYS;bipolar;RM;12!0| ((|x| NIL) ($$ NIL))
        (PROG ($ |a|)
          (LETT $ (QREFELT $$ 1))
          (LETT |a| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|v| NIL) (|u| NIL) (|pt| NIL))
                   (SEQ (LETT |pt| (SPADCALL |x| (QREFELT $ 9)))
                        (LETT |u|
                              (SPADCALL |x| (|spadConstant| $ 26)
                                        (QREFELT $ 12)))
                        (LETT |v| (SPADCALL |x| 2 (QREFELT $ 12)))
                        (SPADCALL |pt| (|spadConstant| $ 28)
                                  (SPADCALL
                                   (SPADCALL |a| (SPADCALL |v| (QREFELT $ 30))
                                             (QREFELT $ 14))
                                   (SPADCALL (SPADCALL |v| (QREFELT $ 29))
                                             (SPADCALL |u| (QREFELT $ 13))
                                             (QREFELT $ 20))
                                   (QREFELT $ 22))
                                  (QREFELT $ 15))
                        (SPADCALL |pt| 2
                                  (SPADCALL
                                   (SPADCALL |a| (SPADCALL |u| (QREFELT $ 16))
                                             (QREFELT $ 14))
                                   (SPADCALL (SPADCALL |v| (QREFELT $ 29))
                                             (SPADCALL |u| (QREFELT $ 13))
                                             (QREFELT $ 20))
                                   (QREFELT $ 22))
                                  (QREFELT $ 15))
                        (EXIT |pt|))))))) 

(SDEFUN |COORDSYS;bipolarCylindrical;RM;13|
        ((|a| (R)) ($ (|Mapping| (|Point| R) (|Point| R))))
        (SPADCALL |a| (QREFELT $ 36))) 

(SDEFUN |COORDSYS;toroidal;RM;14|
        ((|a| (R)) ($ (|Mapping| (|Point| R) (|Point| R))))
        (SPROG NIL (SEQ (CONS #'|COORDSYS;toroidal;RM;14!0| (VECTOR |a| $))))) 

(SDEFUN |COORDSYS;toroidal;RM;14!0| ((|x| NIL) ($$ NIL))
        (PROG ($ |a|)
          (LETT $ (QREFELT $$ 1))
          (LETT |a| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|phi| NIL) (|v| NIL) (|u| NIL) (|pt| NIL))
                   (SEQ (LETT |pt| (SPADCALL |x| (QREFELT $ 9)))
                        (LETT |u|
                              (SPADCALL |x| (|spadConstant| $ 26)
                                        (QREFELT $ 12)))
                        (LETT |v| (SPADCALL |x| 2 (QREFELT $ 12)))
                        (LETT |phi| (SPADCALL |x| 3 (QREFELT $ 12)))
                        (SPADCALL |pt| (|spadConstant| $ 28)
                                  (SPADCALL
                                   (SPADCALL
                                    (SPADCALL |a| (SPADCALL |v| (QREFELT $ 30))
                                              (QREFELT $ 14))
                                    (SPADCALL |phi| (QREFELT $ 13))
                                    (QREFELT $ 14))
                                   (SPADCALL (SPADCALL |v| (QREFELT $ 29))
                                             (SPADCALL |u| (QREFELT $ 13))
                                             (QREFELT $ 20))
                                   (QREFELT $ 22))
                                  (QREFELT $ 15))
                        (SPADCALL |pt| 2
                                  (SPADCALL
                                   (SPADCALL
                                    (SPADCALL |a| (SPADCALL |v| (QREFELT $ 30))
                                              (QREFELT $ 14))
                                    (SPADCALL |phi| (QREFELT $ 16))
                                    (QREFELT $ 14))
                                   (SPADCALL (SPADCALL |v| (QREFELT $ 29))
                                             (SPADCALL |u| (QREFELT $ 13))
                                             (QREFELT $ 20))
                                   (QREFELT $ 22))
                                  (QREFELT $ 15))
                        (SPADCALL |pt| 3
                                  (SPADCALL
                                   (SPADCALL |a| (SPADCALL |u| (QREFELT $ 16))
                                             (QREFELT $ 14))
                                   (SPADCALL (SPADCALL |v| (QREFELT $ 29))
                                             (SPADCALL |u| (QREFELT $ 13))
                                             (QREFELT $ 20))
                                   (QREFELT $ 22))
                                  (QREFELT $ 15))
                        (EXIT |pt|))))))) 

(SDEFUN |COORDSYS;conical;2RM;15|
        ((|a| (R)) (|b| (R)) ($ (|Mapping| (|Point| R) (|Point| R))))
        (SPROG NIL
               (SEQ (CONS #'|COORDSYS;conical;2RM;15!0| (VECTOR |b| |a| $))))) 

(SDEFUN |COORDSYS;conical;2RM;15!0| ((|x| NIL) ($$ NIL))
        (PROG ($ |a| |b|)
          (LETT $ (QREFELT $$ 2))
          (LETT |a| (QREFELT $$ 1))
          (LETT |b| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|nu| NIL) (|mu| NIL) (|lambda| NIL) (|pt| NIL))
                   (SEQ (LETT |pt| (SPADCALL |x| (QREFELT $ 9)))
                        (LETT |lambda|
                              (SPADCALL |x| (|spadConstant| $ 26)
                                        (QREFELT $ 12)))
                        (LETT |mu| (SPADCALL |x| 2 (QREFELT $ 12)))
                        (LETT |nu| (SPADCALL |x| 3 (QREFELT $ 12)))
                        (SPADCALL |pt| (|spadConstant| $ 28)
                                  (SPADCALL
                                   (SPADCALL
                                    (SPADCALL |lambda| |mu| (QREFELT $ 14))
                                    |nu| (QREFELT $ 14))
                                   (SPADCALL |a| |b| (QREFELT $ 14))
                                   (QREFELT $ 22))
                                  (QREFELT $ 15))
                        (SPADCALL |pt| 2
                                  (SPADCALL
                                   (SPADCALL |lambda| |a| (QREFELT $ 22))
                                   (SPADCALL
                                    (SPADCALL
                                     (SPADCALL
                                      (SPADCALL
                                       (SPADCALL |mu| 2 (QREFELT $ 39))
                                       (SPADCALL |a| 2 (QREFELT $ 39))
                                       (QREFELT $ 20))
                                      (SPADCALL
                                       (SPADCALL |nu| 2 (QREFELT $ 39))
                                       (SPADCALL |a| 2 (QREFELT $ 39))
                                       (QREFELT $ 20))
                                      (QREFELT $ 14))
                                     (SPADCALL (SPADCALL |a| 2 (QREFELT $ 39))
                                               (SPADCALL |b| 2 (QREFELT $ 39))
                                               (QREFELT $ 20))
                                     (QREFELT $ 22))
                                    (QREFELT $ 40))
                                   (QREFELT $ 14))
                                  (QREFELT $ 15))
                        (SPADCALL |pt| 3
                                  (SPADCALL
                                   (SPADCALL |lambda| |b| (QREFELT $ 22))
                                   (SPADCALL
                                    (SPADCALL
                                     (SPADCALL
                                      (SPADCALL
                                       (SPADCALL |mu| 2 (QREFELT $ 39))
                                       (SPADCALL |b| 2 (QREFELT $ 39))
                                       (QREFELT $ 20))
                                      (SPADCALL
                                       (SPADCALL |nu| 2 (QREFELT $ 39))
                                       (SPADCALL |b| 2 (QREFELT $ 39))
                                       (QREFELT $ 20))
                                      (QREFELT $ 14))
                                     (SPADCALL (SPADCALL |b| 2 (QREFELT $ 39))
                                               (SPADCALL |a| 2 (QREFELT $ 39))
                                               (QREFELT $ 20))
                                     (QREFELT $ 22))
                                    (QREFELT $ 40))
                                   (QREFELT $ 14))
                                  (QREFELT $ 15))
                        (EXIT |pt|))))))) 

(DECLAIM (NOTINLINE |CoordinateSystems;|)) 

(DEFUN |CoordinateSystems| (#1=#:G728)
  (SPROG NIL
         (PROG (#2=#:G729)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|CoordinateSystems|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|CoordinateSystems;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|CoordinateSystems|)))))))))) 

(DEFUN |CoordinateSystems;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|CoordinateSystems| DV$1))
          (LETT $ (GETREFV 42))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|CoordinateSystems| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|CoordinateSystems| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Point| 6)
              |COORDSYS;cartesian;2P;1| (0 . |copy|) (5 . |One|) (|Integer|)
              (9 . |elt|) (15 . |cos|) (20 . *) (26 . |setelt!|) (33 . |sin|)
              |COORDSYS;polar;2P;2| |COORDSYS;cylindrical;2P;3|
              |COORDSYS;spherical;2P;4| (38 . -) (44 . |coerce|) (49 . /)
              |COORDSYS;parabolic;2P;5| |COORDSYS;parabolicCylindrical;2P;6|
              |COORDSYS;paraboloidal;2P;7| (55 . |One|) (|PositiveInteger|)
              (59 . |One|) (63 . |cosh|) (68 . |sinh|) (|Mapping| 7 7)
              |COORDSYS;elliptic;RM;8| |COORDSYS;ellipticCylindrical;RM;9|
              |COORDSYS;prolateSpheroidal;RM;10|
              |COORDSYS;oblateSpheroidal;RM;11| |COORDSYS;bipolar;RM;12|
              |COORDSYS;bipolarCylindrical;RM;13| |COORDSYS;toroidal;RM;14|
              (73 . ^) (79 . |sqrt|) |COORDSYS;conical;2RM;15|)
           '#(|toroidal| 84 |spherical| 89 |prolateSpheroidal| 94 |polar| 99
              |paraboloidal| 104 |parabolicCylindrical| 109 |parabolic| 114
              |oblateSpheroidal| 119 |ellipticCylindrical| 124 |elliptic| 129
              |cylindrical| 134 |conical| 139 |cartesian| 145
              |bipolarCylindrical| 150 |bipolar| 155)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|cartesian| ((|Point| |#1|) (|Point| |#1|)))
                                T)
                              '((|polar| ((|Point| |#1|) (|Point| |#1|))) T)
                              '((|cylindrical| ((|Point| |#1|) (|Point| |#1|)))
                                T)
                              '((|spherical| ((|Point| |#1|) (|Point| |#1|)))
                                T)
                              '((|parabolic| ((|Point| |#1|) (|Point| |#1|)))
                                T)
                              '((|parabolicCylindrical|
                                 ((|Point| |#1|) (|Point| |#1|)))
                                T)
                              '((|paraboloidal|
                                 ((|Point| |#1|) (|Point| |#1|)))
                                T)
                              '((|elliptic|
                                 ((|Mapping| (|Point| |#1|) (|Point| |#1|))
                                  |#1|))
                                T)
                              '((|ellipticCylindrical|
                                 ((|Mapping| (|Point| |#1|) (|Point| |#1|))
                                  |#1|))
                                T)
                              '((|prolateSpheroidal|
                                 ((|Mapping| (|Point| |#1|) (|Point| |#1|))
                                  |#1|))
                                T)
                              '((|oblateSpheroidal|
                                 ((|Mapping| (|Point| |#1|) (|Point| |#1|))
                                  |#1|))
                                T)
                              '((|bipolar|
                                 ((|Mapping| (|Point| |#1|) (|Point| |#1|))
                                  |#1|))
                                T)
                              '((|bipolarCylindrical|
                                 ((|Mapping| (|Point| |#1|) (|Point| |#1|))
                                  |#1|))
                                T)
                              '((|toroidal|
                                 ((|Mapping| (|Point| |#1|) (|Point| |#1|))
                                  |#1|))
                                T)
                              '((|conical|
                                 ((|Mapping| (|Point| |#1|) (|Point| |#1|))
                                  |#1| |#1|))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 41
                                            '(1 7 0 0 9 0 6 0 10 2 7 6 0 11 12
                                              1 6 0 0 13 2 6 0 0 0 14 3 7 6 0
                                              11 6 15 1 6 0 0 16 2 6 0 0 0 20 1
                                              6 0 11 21 2 6 0 0 0 22 0 11 0 26
                                              0 27 0 28 1 6 0 0 29 1 6 0 0 30 2
                                              6 0 0 27 39 1 6 0 0 40 1 0 31 6
                                              38 1 0 7 7 19 1 0 31 6 34 1 0 7 7
                                              17 1 0 7 7 25 1 0 7 7 24 1 0 7 7
                                              23 1 0 31 6 35 1 0 31 6 33 1 0 31
                                              6 32 1 0 7 7 18 2 0 31 6 6 41 1 0
                                              7 7 8 1 0 31 6 37 1 0 31 6
                                              36)))))
           '|lookupComplete|)) 
