
(SDEFUN |VIEW3D;checkViewport| ((|viewport| ($)) ($ (|Boolean|)))
        (SPROG ((|i| (|Integer|)))
               (SEQ (|sockSendInt| |$ViewportServer| (QVELT |viewport| 0))
                    (LETT |i| (|sockGetInt| |$ViewportServer|))
                    (EXIT
                     (COND
                      ((< |i| 0)
                       (SEQ (QSETVELT |viewport| 0 0)
                            (EXIT
                             (|error|
                              "This viewport has already been closed!"))))
                      ('T 'T)))))) 

(SDEFUN |VIEW3D;doOptions| ((|v| (|Rep|)) ($ (|Void|)))
        (SPROG ((|st| (|String|)))
               (SEQ
                (QSETVELT |v| 2
                          (SPADCALL (QVELT |v| 12) "FriCAS3D" (QREFELT $ 27)))
                (LETT |st| (SPADCALL (QVELT |v| 12) "render" (QREFELT $ 28)))
                (COND
                 ((OR (EQUAL |st| "shade") (EQUAL |st| "render"))
                  (QSETVELT (QVELT |v| 7) 1 3))
                 ((OR (EQUAL |st| "solid") (EQUAL |st| "opaque"))
                  (QSETVELT (QVELT |v| 7) 1 7))
                 ((EQUAL |st| "contour") (QSETVELT (QVELT |v| 7) 1 24))
                 ((EQUAL |st| "smooth") (QSETVELT (QVELT |v| 7) 1 22))
                 ((EQUAL |st| "wireMesh") (QSETVELT (QVELT |v| 7) 1 9))
                 ('T (QSETVELT (QVELT |v| 7) 1 3)))
                (EXIT
                 (QSETVELT |v| 5
                           (SPADCALL (QVELT |v| 12)
                                     (VECTOR (QREFELT $ 18) (QREFELT $ 20)
                                             (QREFELT $ 21) 1.0 1.0 1.0
                                             (QREFELT $ 22) (QREFELT $ 23))
                                     (QREFELT $ 30))))))) 

(SDEFUN |VIEW3D;viewport3D;$;3| (($ ($)))
        (VECTOR 0 1 "FriCAS3D"
                (CONS (SPADCALL (SPADCALL (QREFELT $ 33)) 1 (QREFELT $ 35))
                      (SPADCALL (SPADCALL (QREFELT $ 33)) 2 (QREFELT $ 35)))
                (CONS (SPADCALL (SPADCALL (QREFELT $ 37)) 1 (QREFELT $ 38))
                      (SPADCALL (SPADCALL (QREFELT $ 37)) 2 (QREFELT $ 38)))
                (VECTOR (QREFELT $ 18) (QREFELT $ 20) (QREFELT $ 21) 1.0 1.0
                        1.0 (QREFELT $ 22) (QREFELT $ 23))
                (CONS 0 27) (VECTOR 0 3 1 0 1 0)
                (VECTOR 0.0 0.0 1.0 0.0 0.0 1.0)
                (VECTOR 1 (FLOAT 500 MOST-POSITIVE-DOUBLE-FLOAT)
                        (FLOAT -250 MOST-POSITIVE-DOUBLE-FLOAT))
                (VECTOR 0.0 1.0 0.0 1.0 0.0 1.0 0 1) (SPADCALL (QREFELT $ 40))
                NIL)) 

(PUT '|VIEW3D;subspace;$Ts;4| '|SPADreplace|
     '(XLAM (|viewport|) (QVELT |viewport| 11))) 

(SDEFUN |VIEW3D;subspace;$Ts;4|
        ((|viewport| ($)) ($ (|ThreeSpace| (|DoubleFloat|))))
        (QVELT |viewport| 11)) 

(SDEFUN |VIEW3D;subspace;$Ts$;5|
        ((|viewport| ($)) (|space| (|ThreeSpace| (|DoubleFloat|))) ($ ($)))
        (SEQ (QSETVELT |viewport| 11 |space|) (EXIT |viewport|))) 

(PUT '|VIEW3D;options;$L;6| '|SPADreplace|
     '(XLAM (|viewport|) (QVELT |viewport| 12))) 

(SDEFUN |VIEW3D;options;$L;6| ((|viewport| ($)) ($ (|List| (|DrawOption|))))
        (QVELT |viewport| 12)) 

(SDEFUN |VIEW3D;options;$L$;7|
        ((|viewport| ($)) (|opts| (|List| (|DrawOption|))) ($ ($)))
        (SEQ (QSETVELT |viewport| 12 |opts|) (EXIT |viewport|))) 

(SDEFUN |VIEW3D;makeViewport3D;2$;8| ((|viewport| ($)) ($ ($)))
        (|VIEW3D;makeViewport3D0| (MOVEVEC (MAKE_VEC 13) |viewport|) $)) 

(SDEFUN |VIEW3D;makeViewport3D;TsS$;9|
        ((|space| (|ThreeSpace| (|DoubleFloat|))) (|Title| (|String|)) ($ ($)))
        (SPROG ((|v| ($)))
               (SEQ (LETT |v| (SPADCALL (QREFELT $ 41)))
                    (QSETVELT |v| 11 |space|)
                    (QSETVELT |v| 12 (LIST (SPADCALL |Title| (QREFELT $ 48))))
                    (EXIT (|VIEW3D;makeViewport3D0| |v| $))))) 

(SDEFUN |VIEW3D;makeViewport3D;TsL$;10|
        ((|space| (|ThreeSpace| (|DoubleFloat|)))
         (|opts| (|List| (|DrawOption|))) ($ ($)))
        (SPROG ((|v| ($)))
               (SEQ (LETT |v| (SPADCALL (QREFELT $ 41)))
                    (QSETVELT |v| 11 |space|) (QSETVELT |v| 12 |opts|)
                    (EXIT (|VIEW3D;makeViewport3D0| |v| $))))) 

(SDEFUN |VIEW3D;makeViewport3D0| ((|viewport| ($)) ($ ($)))
        (SPROG
         ((#1=#:G843 NIL) (|oneIndexedPoint| NIL) (#2=#:G841 NIL)
          (|alipts| NIL) (#3=#:G842 NIL) (|tinyprop| NIL) (#4=#:G838 NIL)
          (|allipts| NIL) (#5=#:G839 NIL) (|oneprop| NIL) (#6=#:G840 NIL)
          (|onelprops| NIL) (|aPoint| #7=(|Point| (|DoubleFloat|)))
          (#8=#:G837 NIL) (|pt| NIL) (|n| (|PositiveInteger|)) (#9=#:G836 NIL)
          (|s| (|Set| (|PositiveInteger|)))
          (|lprops| (|List| (|SubSpaceComponentProperty|)))
          (|llprops| (|List| (|List| (|SubSpaceComponentProperty|))))
          (|lllipts| (|List| (|List| (|List| (|NonNegativeInteger|)))))
          (|lpts| (|List| (|Point| (|DoubleFloat|))))
          (|transform| (|Mapping| #7# (|Point| (|DoubleFloat|)))))
         (SEQ (|VIEW3D;doOptions| |viewport| $)
              (SPADCALL "   Transmitting data..." (QREFELT $ 53))
              (LETT |transform|
                    (SPADCALL (QVELT |viewport| 12) (ELT $ 56) (QREFELT $ 58)))
              (SPADCALL (QVELT |viewport| 11) (QREFELT $ 59))
              (LETT |lpts| (SPADCALL (QVELT |viewport| 11) (QREFELT $ 61)))
              (LETT |lllipts| (SPADCALL (QVELT |viewport| 11) (QREFELT $ 63)))
              (LETT |llprops| (SPADCALL (QVELT |viewport| 11) (QREFELT $ 65)))
              (LETT |lprops| (SPADCALL (QVELT |viewport| 11) (QREFELT $ 67)))
              (LETT |s| (SPADCALL (QREFELT $ 69)))
              (SEQ (LETT |pt| NIL) (LETT #9# |lpts|) G190
                   (COND
                    ((OR (ATOM #9#) (PROGN (LETT |pt| (CAR #9#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (SPADCALL (SPADCALL |pt| (QREFELT $ 70)) |s|
                               (QREFELT $ 71))))
                   (LETT #9# (CDR #9#)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (COND
                ((> (SPADCALL |s| (QREFELT $ 72)) 1)
                 (|error| "All points should have the same dimension"))
                (#10='T
                 (SEQ (LETT |n| (|SPADfirst| (SPADCALL |s| (QREFELT $ 73))))
                      (EXIT
                       (COND
                        ((< |n| 3)
                         (|error|
                          "Dimension of points should be greater than 2"))
                        (#10#
                         (SEQ
                          (|sockSendInt| |$ViewportServer|
                                         (QVELT |viewport| 1))
                          (|sockSendInt| |$ViewportServer| -1)
                          (|sockSendString| |$ViewportServer|
                                            (QVELT |viewport| 2))
                          (|sockSendFloat| |$ViewportServer|
                                           (QVELT (QVELT |viewport| 5) 6))
                          (|sockSendFloat| |$ViewportServer|
                                           (QVELT (QVELT |viewport| 5) 7))
                          (|sockSendFloat| |$ViewportServer|
                                           (QVELT (QVELT |viewport| 5) 2))
                          (|sockSendFloat| |$ViewportServer|
                                           (QVELT (QVELT |viewport| 5) 3))
                          (|sockSendFloat| |$ViewportServer|
                                           (QVELT (QVELT |viewport| 5) 4))
                          (|sockSendFloat| |$ViewportServer|
                                           (QVELT (QVELT |viewport| 5) 5))
                          (|sockSendFloat| |$ViewportServer|
                                           (QVELT (QVELT |viewport| 5) 0))
                          (|sockSendFloat| |$ViewportServer|
                                           (QVELT (QVELT |viewport| 5) 1))
                          (|sockSendInt| |$ViewportServer|
                                         (QCAR (QVELT |viewport| 3)))
                          (|sockSendInt| |$ViewportServer|
                                         (QCDR (QVELT |viewport| 3)))
                          (|sockSendInt| |$ViewportServer|
                                         (QCAR (QVELT |viewport| 4)))
                          (|sockSendInt| |$ViewportServer|
                                         (QCDR (QVELT |viewport| 4)))
                          (|sockSendInt| |$ViewportServer|
                                         (QVELT (QVELT |viewport| 7) 0))
                          (|sockSendInt| |$ViewportServer|
                                         (QVELT (QVELT |viewport| 7) 1))
                          (|sockSendInt| |$ViewportServer|
                                         (QVELT (QVELT |viewport| 7) 2))
                          (|sockSendInt| |$ViewportServer|
                                         (QVELT (QVELT |viewport| 7) 3))
                          (|sockSendInt| |$ViewportServer|
                                         (QVELT (QVELT |viewport| 7) 4))
                          (|sockSendInt| |$ViewportServer|
                                         (QVELT (QVELT |viewport| 7) 5))
                          (|sockSendInt| |$ViewportServer|
                                         (QVELT (QVELT |viewport| 10) 6))
                          (|sockSendInt| |$ViewportServer|
                                         (QVELT (QVELT |viewport| 10) 7))
                          (|sockSendInt| |$ViewportServer|
                                         (QCAR (QVELT |viewport| 6)))
                          (|sockSendInt| |$ViewportServer|
                                         (QCDR (QVELT |viewport| 6)))
                          (|sockSendFloat| |$ViewportServer|
                                           (QVELT (QVELT |viewport| 8) 0))
                          (|sockSendFloat| |$ViewportServer|
                                           (QVELT (QVELT |viewport| 8) 1))
                          (|sockSendFloat| |$ViewportServer|
                                           (QVELT (QVELT |viewport| 8) 2))
                          (|sockSendFloat| |$ViewportServer|
                                           (QVELT (QVELT |viewport| 8) 5))
                          (|sockSendInt| |$ViewportServer|
                                         (QVELT (QVELT |viewport| 9) 0))
                          (|sockSendFloat| |$ViewportServer|
                                           (QVELT (QVELT |viewport| 9) 1))
                          (|sockSendInt| |$ViewportServer| (LENGTH |lpts|))
                          (SEQ (LETT |pt| NIL) (LETT #8# |lpts|) G190
                               (COND
                                ((OR (ATOM #8#)
                                     (PROGN (LETT |pt| (CAR #8#)) NIL))
                                 (GO G191)))
                               (SEQ (LETT |aPoint| (SPADCALL |pt| |transform|))
                                    (|sockSendFloat| |$ViewportServer|
                                                     (SPADCALL |aPoint|
                                                               (QREFELT $ 76)))
                                    (|sockSendFloat| |$ViewportServer|
                                                     (SPADCALL |aPoint|
                                                               (QREFELT $ 77)))
                                    (|sockSendFloat| |$ViewportServer|
                                                     (SPADCALL |aPoint|
                                                               (QREFELT $ 78)))
                                    (EXIT
                                     (COND
                                      ((EQL |n| 3)
                                       (|sockSendFloat| |$ViewportServer|
                                                        (SPADCALL |aPoint|
                                                                  (QREFELT $
                                                                           78))))
                                      ('T
                                       (|sockSendFloat| |$ViewportServer|
                                                        (SPADCALL |aPoint|
                                                                  (QREFELT $
                                                                           79)))))))
                               (LETT #8# (CDR #8#)) (GO G190) G191 (EXIT NIL))
                          (|sockSendInt| |$ViewportServer| (LENGTH |lllipts|))
                          (SEQ (LETT |onelprops| NIL) (LETT #6# |llprops|)
                               (LETT |oneprop| NIL) (LETT #5# |lprops|)
                               (LETT |allipts| NIL) (LETT #4# |lllipts|) G190
                               (COND
                                ((OR (ATOM #4#)
                                     (PROGN (LETT |allipts| (CAR #4#)) NIL)
                                     (ATOM #5#)
                                     (PROGN (LETT |oneprop| (CAR #5#)) NIL)
                                     (ATOM #6#)
                                     (PROGN (LETT |onelprops| (CAR #6#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (|sockSendInt| |$ViewportServer|
                                               (COND
                                                ((SPADCALL |oneprop|
                                                           (QREFELT $ 82))
                                                 1)
                                                ('T 0)))
                                (|sockSendInt| |$ViewportServer|
                                               (COND
                                                ((SPADCALL |oneprop|
                                                           (QREFELT $ 83))
                                                 1)
                                                ('T 0)))
                                (|sockSendInt| |$ViewportServer|
                                               (LENGTH |allipts|))
                                (EXIT
                                 (SEQ (LETT |tinyprop| NIL)
                                      (LETT #3# |onelprops|)
                                      (LETT |alipts| NIL) (LETT #2# |allipts|)
                                      G190
                                      (COND
                                       ((OR (ATOM #2#)
                                            (PROGN
                                             (LETT |alipts| (CAR #2#))
                                             NIL)
                                            (ATOM #3#)
                                            (PROGN
                                             (LETT |tinyprop| (CAR #3#))
                                             NIL))
                                        (GO G191)))
                                      (SEQ
                                       (|sockSendInt| |$ViewportServer|
                                                      (COND
                                                       ((SPADCALL |tinyprop|
                                                                  (QREFELT $
                                                                           82))
                                                        1)
                                                       ('T 0)))
                                       (|sockSendInt| |$ViewportServer|
                                                      (COND
                                                       ((SPADCALL |tinyprop|
                                                                  (QREFELT $
                                                                           83))
                                                        1)
                                                       ('T 0)))
                                       (|sockSendInt| |$ViewportServer|
                                                      (SPADCALL |alipts|
                                                                (QREFELT $
                                                                         84)))
                                       (EXIT
                                        (SEQ (LETT |oneIndexedPoint| NIL)
                                             (LETT #1# |alipts|) G190
                                             (COND
                                              ((OR (ATOM #1#)
                                                   (PROGN
                                                    (LETT |oneIndexedPoint|
                                                          (CAR #1#))
                                                    NIL))
                                               (GO G191)))
                                             (SEQ
                                              (EXIT
                                               (|sockSendInt| |$ViewportServer|
                                                              |oneIndexedPoint|)))
                                             (LETT #1# (CDR #1#)) (GO G190)
                                             G191 (EXIT NIL))))
                                      (LETT #2#
                                            (PROG1 (CDR #2#)
                                              (LETT #3# (CDR #3#))))
                                      (GO G190) G191 (EXIT NIL))))
                               (LETT #4#
                                     (PROG1 (CDR #4#)
                                       (LETT #5#
                                             (PROG1 (CDR #5#)
                                               (LETT #6# (CDR #6#))))))
                               (GO G190) G191 (EXIT NIL))
                          (QSETVELT |viewport| 0
                                    (|sockGetInt| |$ViewportServer|))
                          (EXIT |viewport|)))))))))))) 

(SDEFUN |VIEW3D;viewThetaDefault;F;12| (($ (|Float|)))
        (SPADCALL (QREFELT $ 18) (QREFELT $ 85))) 

(SDEFUN |VIEW3D;viewThetaDefault;2F;13| ((|t| (|Float|)) ($ (|Float|)))
        (SEQ (SETELT $ 18 (SPADCALL |t| (QREFELT $ 17))) (EXIT |t|))) 

(SDEFUN |VIEW3D;viewPhiDefault;F;14| (($ (|Float|)))
        (SPADCALL (QREFELT $ 20) (QREFELT $ 85))) 

(SDEFUN |VIEW3D;viewPhiDefault;2F;15| ((|t| (|Float|)) ($ (|Float|)))
        (SEQ (SETELT $ 20 (SPADCALL |t| (QREFELT $ 17))) (EXIT |t|))) 

(SDEFUN |VIEW3D;viewZoomDefault;F;16| (($ (|Float|)))
        (SPADCALL (QREFELT $ 21) (QREFELT $ 85))) 

(SDEFUN |VIEW3D;viewZoomDefault;2F;17| ((|t| (|Float|)) ($ (|Float|)))
        (SEQ (SETELT $ 21 (SPADCALL |t| (QREFELT $ 17))) (EXIT |t|))) 

(SDEFUN |VIEW3D;viewDeltaXDefault;F;18| (($ (|Float|)))
        (SPADCALL (QREFELT $ 22) (QREFELT $ 85))) 

(SDEFUN |VIEW3D;viewDeltaXDefault;2F;19| ((|t| (|Float|)) ($ (|Float|)))
        (SEQ (SETELT $ 22 (SPADCALL |t| (QREFELT $ 17))) (EXIT |t|))) 

(SDEFUN |VIEW3D;viewDeltaYDefault;F;20| (($ (|Float|)))
        (SPADCALL (QREFELT $ 23) (QREFELT $ 85))) 

(SDEFUN |VIEW3D;viewDeltaYDefault;2F;21| ((|t| (|Float|)) ($ (|Float|)))
        (SEQ (SETELT $ 23 (SPADCALL |t| (QREFELT $ 17))) (EXIT |t|))) 

(SDEFUN |VIEW3D;lighting;$3FV;22|
        ((|viewport| ($)) (|Xlight| (|Float|)) (|Ylight| (|Float|))
         (|Zlight| (|Float|)) ($ (|Void|)))
        (SPROG ((#1=#:G864 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (QSETVELT (QVELT |viewport| 8) 0
                            (SPADCALL |Xlight| (QREFELT $ 17)))
                  (QSETVELT (QVELT |viewport| 8) 1
                            (SPADCALL |Ylight| (QREFELT $ 17)))
                  (QSETVELT (QVELT |viewport| 8) 2
                            (SPADCALL |Zlight| (QREFELT $ 17)))
                  (EXIT
                   (COND
                    ((SPADCALL (SPADCALL |viewport| (QREFELT $ 96)) 0
                               (QREFELT $ 97))
                     (PROGN
                      (LETT #1#
                            (SEQ (|sockSendInt| |$ViewportServer| 1)
                                 (|sockSendInt| |$ViewportServer| 108)
                                 (EXIT
                                  (COND
                                   ((|VIEW3D;checkViewport| |viewport| $)
                                    (SEQ
                                     (|sockSendFloat| |$ViewportServer|
                                                      (QVELT
                                                       (QVELT |viewport| 8) 0))
                                     (|sockSendFloat| |$ViewportServer|
                                                      (QVELT
                                                       (QVELT |viewport| 8) 1))
                                     (|sockSendFloat| |$ViewportServer|
                                                      (QVELT
                                                       (QVELT |viewport| 8) 2))
                                     (EXIT
                                      (|sockGetInt| |$ViewportServer|))))))))
                      (GO #2=#:G862)))))))
                #2# (EXIT #1#)))) 

(SDEFUN |VIEW3D;axes;$SV;23|
        ((|viewport| ($)) (|onOff| (|String|)) ($ (|Void|)))
        (SPROG ((#1=#:G870 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((EQUAL |onOff| "on") (QSETVELT (QVELT |viewport| 7) 2 1))
                   ('T (QSETVELT (QVELT |viewport| 7) 2 0)))
                  (EXIT
                   (COND
                    ((SPADCALL (SPADCALL |viewport| (QREFELT $ 96)) 0
                               (QREFELT $ 97))
                     (PROGN
                      (LETT #1#
                            (SEQ (|sockSendInt| |$ViewportServer| 1)
                                 (|sockSendInt| |$ViewportServer| 6)
                                 (EXIT
                                  (COND
                                   ((|VIEW3D;checkViewport| |viewport| $)
                                    (SEQ
                                     (|sockSendInt| |$ViewportServer|
                                                    (QVELT (QVELT |viewport| 7)
                                                           2))
                                     (EXIT
                                      (|sockGetInt| |$ViewportServer|))))))))
                      (GO #2=#:G868)))))))
                #2# (EXIT #1#)))) 

(SDEFUN |VIEW3D;diagonals;$SV;24|
        ((|viewport| ($)) (|onOff| (|String|)) ($ (|Void|)))
        (SPROG ((#1=#:G876 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((EQUAL |onOff| "on") (QSETVELT (QVELT |viewport| 7) 3 1))
                   ('T (QSETVELT (QVELT |viewport| 7) 3 0)))
                  (EXIT
                   (COND
                    ((SPADCALL (SPADCALL |viewport| (QREFELT $ 96)) 0
                               (QREFELT $ 97))
                     (PROGN
                      (LETT #1#
                            (SEQ (|sockSendInt| |$ViewportServer| 1)
                                 (|sockSendInt| |$ViewportServer| 26)
                                 (EXIT
                                  (COND
                                   ((|VIEW3D;checkViewport| |viewport| $)
                                    (SEQ
                                     (|sockSendInt| |$ViewportServer|
                                                    (QVELT (QVELT |viewport| 7)
                                                           3))
                                     (EXIT
                                      (|sockGetInt| |$ViewportServer|))))))))
                      (GO #2=#:G874)))))))
                #2# (EXIT #1#)))) 

(SDEFUN |VIEW3D;outlineRender;$SV;25|
        ((|viewport| ($)) (|onOff| (|String|)) ($ (|Void|)))
        (SPROG ((#1=#:G882 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((EQUAL |onOff| "on") (QSETVELT (QVELT |viewport| 7) 4 1))
                   ('T (QSETVELT (QVELT |viewport| 7) 4 0)))
                  (EXIT
                   (COND
                    ((SPADCALL (SPADCALL |viewport| (QREFELT $ 96)) 0
                               (QREFELT $ 97))
                     (PROGN
                      (LETT #1#
                            (SEQ (|sockSendInt| |$ViewportServer| 1)
                                 (|sockSendInt| |$ViewportServer| 13)
                                 (EXIT
                                  (COND
                                   ((|VIEW3D;checkViewport| |viewport| $)
                                    (SEQ
                                     (|sockSendInt| |$ViewportServer|
                                                    (QVELT (QVELT |viewport| 7)
                                                           4))
                                     (EXIT
                                      (|sockGetInt| |$ViewportServer|))))))))
                      (GO #2=#:G880)))))))
                #2# (EXIT #1#)))) 

(SDEFUN |VIEW3D;controlPanel;$SV;26|
        ((|viewport| ($)) (|onOff| (|String|)) ($ (|Void|)))
        (SPROG ((#1=#:G888 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((EQUAL |onOff| "on") (QSETVELT (QVELT |viewport| 7) 0 1))
                   ('T (QSETVELT (QVELT |viewport| 7) 0 0)))
                  (EXIT
                   (COND
                    ((SPADCALL (SPADCALL |viewport| (QREFELT $ 96)) 0
                               (QREFELT $ 97))
                     (PROGN
                      (LETT #1#
                            (SEQ (|sockSendInt| |$ViewportServer| 1)
                                 (|sockSendInt| |$ViewportServer| 4)
                                 (EXIT
                                  (COND
                                   ((|VIEW3D;checkViewport| |viewport| $)
                                    (SEQ
                                     (|sockSendInt| |$ViewportServer|
                                                    (QVELT (QVELT |viewport| 7)
                                                           0))
                                     (EXIT
                                      (|sockGetInt| |$ViewportServer|))))))))
                      (GO #2=#:G886)))))))
                #2# (EXIT #1#)))) 

(SDEFUN |VIEW3D;drawStyle;$SV;27|
        ((|viewport| ($)) (|how| (|String|)) ($ (|Void|)))
        (SPROG ((#1=#:G893 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((EQUAL |how| "shade") (QSETVELT (QVELT |viewport| 7) 1 3))
                   ((EQUAL |how| "solid") (QSETVELT (QVELT |viewport| 7) 1 7))
                   ((EQUAL |how| "contour")
                    (QSETVELT (QVELT |viewport| 7) 1 24))
                   ((EQUAL |how| "smooth")
                    (QSETVELT (QVELT |viewport| 7) 1 22))
                   ('T (QSETVELT (QVELT |viewport| 7) 1 9)))
                  (EXIT
                   (COND
                    ((SPADCALL (SPADCALL |viewport| (QREFELT $ 96)) 0
                               (QREFELT $ 97))
                     (PROGN
                      (LETT #1#
                            (SEQ (|sockSendInt| |$ViewportServer| 1)
                                 (|sockSendInt| |$ViewportServer|
                                                (QVELT (QVELT |viewport| 7) 1))
                                 (EXIT
                                  (COND
                                   ((|VIEW3D;checkViewport| |viewport| $)
                                    (|sockGetInt| |$ViewportServer|))))))
                      (GO #2=#:G891)))))))
                #2# (EXIT #1#)))) 

(SDEFUN |VIEW3D;reset;$V;28| ((|viewport| ($)) ($ (|Void|)))
        (SEQ
         (COND
          ((SPADCALL (SPADCALL |viewport| (QREFELT $ 96)) 0 (QREFELT $ 97))
           (SEQ (|sockSendInt| |$ViewportServer| 1)
                (|sockSendInt| |$ViewportServer| 100)
                (EXIT
                 (COND
                  ((|VIEW3D;checkViewport| |viewport| $)
                   (SEQ (|sockSendInt| |$ViewportServer| 8)
                        (EXIT (|sockGetInt| |$ViewportServer|))))))))
          ('T (SPADCALL (QREFELT $ 104)))))) 

(SDEFUN |VIEW3D;close;$V;29| ((|viewport| ($)) ($ (|Void|)))
        (SEQ
         (COND
          ((SPADCALL (SPADCALL |viewport| (QREFELT $ 96)) 0 (QREFELT $ 97))
           (SEQ (|sockSendInt| |$ViewportServer| 1)
                (|sockSendInt| |$ViewportServer| 5)
                (EXIT
                 (COND
                  ((|VIEW3D;checkViewport| |viewport| $)
                   (SEQ (|sockGetInt| |$ViewportServer|)
                        (EXIT (QSETVELT |viewport| 0 0))))))))
          ('T (SPADCALL (QREFELT $ 104)))))) 

(SDEFUN |VIEW3D;viewpoint;$R;30|
        ((|viewport| ($))
         ($
          (|Record| (|:| |theta| (|DoubleFloat|)) (|:| |phi| (|DoubleFloat|))
                    (|:| |scale| (|DoubleFloat|))
                    (|:| |scaleX| (|DoubleFloat|))
                    (|:| |scaleY| (|DoubleFloat|))
                    (|:| |scaleZ| (|DoubleFloat|))
                    (|:| |deltaX| (|DoubleFloat|))
                    (|:| |deltaY| (|DoubleFloat|)))))
        (SPROG
         ((|phi_sf| (|DoubleFloat|)) (|theta_sf| (|DoubleFloat|))
          (|scaleZ_sf| (|DoubleFloat|)) (|scaleY_sf| (|DoubleFloat|))
          (|scaleX_sf| (|DoubleFloat|)) (|scale_sf| (|DoubleFloat|))
          (|deltaY_sf| (|DoubleFloat|)) (|deltaX_sf| (|DoubleFloat|)))
         (SEQ
          (COND
           ((SPADCALL (SPADCALL |viewport| (QREFELT $ 96)) 0 (QREFELT $ 97))
            (SEQ (|sockSendInt| |$ViewportServer| 1)
                 (|sockSendInt| |$ViewportServer| 117)
                 (EXIT
                  (COND
                   ((|VIEW3D;checkViewport| |viewport| $)
                    (SEQ (LETT |deltaX_sf| (|sockGetFloat| |$ViewportServer|))
                         (LETT |deltaY_sf| (|sockGetFloat| |$ViewportServer|))
                         (LETT |scale_sf| (|sockGetFloat| |$ViewportServer|))
                         (LETT |scaleX_sf| (|sockGetFloat| |$ViewportServer|))
                         (LETT |scaleY_sf| (|sockGetFloat| |$ViewportServer|))
                         (LETT |scaleZ_sf| (|sockGetFloat| |$ViewportServer|))
                         (LETT |theta_sf| (|sockGetFloat| |$ViewportServer|))
                         (LETT |phi_sf| (|sockGetFloat| |$ViewportServer|))
                         (|sockGetInt| |$ViewportServer|)
                         (EXIT
                          (QSETVELT |viewport| 5
                                    (VECTOR |theta_sf| |phi_sf| |scale_sf|
                                            |scaleX_sf| |scaleY_sf| |scaleZ_sf|
                                            |deltaX_sf| |deltaY_sf|)))))
                   (#1='T (QVELT |viewport| 5))))))
           (#1# (QVELT |viewport| 5)))))) 

(SDEFUN |VIEW3D;viewpoint;$RV;31|
        ((|viewport| ($))
         (|viewpt|
          (|Record| (|:| |theta| (|DoubleFloat|)) (|:| |phi| (|DoubleFloat|))
                    (|:| |scale| (|DoubleFloat|))
                    (|:| |scaleX| (|DoubleFloat|))
                    (|:| |scaleY| (|DoubleFloat|))
                    (|:| |scaleZ| (|DoubleFloat|))
                    (|:| |deltaX| (|DoubleFloat|))
                    (|:| |deltaY| (|DoubleFloat|))))
         ($ (|Void|)))
        (SPROG ((#1=#:G914 NIL))
               (SEQ
                (EXIT
                 (SEQ (QSETVELT |viewport| 5 |viewpt|)
                      (EXIT
                       (COND
                        ((SPADCALL (SPADCALL |viewport| (QREFELT $ 96)) 0
                                   (QREFELT $ 97))
                         (PROGN
                          (LETT #1#
                                (SEQ (|sockSendInt| |$ViewportServer| 1)
                                     (|sockSendInt| |$ViewportServer| 118)
                                     (EXIT
                                      (COND
                                       ((|VIEW3D;checkViewport| |viewport| $)
                                        (SEQ
                                         (|sockSendFloat| |$ViewportServer|
                                                          (QVELT
                                                           (QVELT |viewport| 5)
                                                           6))
                                         (|sockSendFloat| |$ViewportServer|
                                                          (QVELT
                                                           (QVELT |viewport| 5)
                                                           7))
                                         (|sockSendFloat| |$ViewportServer|
                                                          (QVELT
                                                           (QVELT |viewport| 5)
                                                           2))
                                         (|sockSendFloat| |$ViewportServer|
                                                          (QVELT
                                                           (QVELT |viewport| 5)
                                                           3))
                                         (|sockSendFloat| |$ViewportServer|
                                                          (QVELT
                                                           (QVELT |viewport| 5)
                                                           4))
                                         (|sockSendFloat| |$ViewportServer|
                                                          (QVELT
                                                           (QVELT |viewport| 5)
                                                           5))
                                         (|sockSendFloat| |$ViewportServer|
                                                          (QVELT
                                                           (QVELT |viewport| 5)
                                                           0))
                                         (|sockSendFloat| |$ViewportServer|
                                                          (QVELT
                                                           (QVELT |viewport| 5)
                                                           1))
                                         (EXIT
                                          (|sockGetInt|
                                           |$ViewportServer|))))))))
                          (GO #2=#:G912)))))))
                #2# (EXIT #1#)))) 

(SDEFUN |VIEW3D;viewpoint;$5FV;32|
        ((|viewport| ($)) (|Theta| (|Float|)) (|Phi| (|Float|))
         (|Scale| (|Float|)) (|DeltaX| (|Float|)) (|DeltaY| (|Float|))
         ($ (|Void|)))
        (QSETVELT |viewport| 5
                  (VECTOR (SPADCALL |Theta| (QREFELT $ 17))
                          (SPADCALL |Phi| (QREFELT $ 17))
                          (SPADCALL |Scale| (QREFELT $ 17)) 1.0 1.0 1.0
                          (SPADCALL |DeltaX| (QREFELT $ 17))
                          (SPADCALL |DeltaY| (QREFELT $ 17))))) 

(SDEFUN |VIEW3D;viewpoint;$2I3FV;33|
        ((|viewport| ($)) (|Theta| (|Integer|)) (|Phi| (|Integer|))
         (|Scale| (|Float|)) (|DeltaX| (|Float|)) (|DeltaY| (|Float|))
         ($ (|Void|)))
        (QSETVELT |viewport| 5
                  (VECTOR
                   (|mul_DF| (FLOAT |Theta| MOST-POSITIVE-DOUBLE-FLOAT)
                             (QREFELT $ 15))
                   (|mul_DF| (FLOAT |Phi| MOST-POSITIVE-DOUBLE-FLOAT)
                             (QREFELT $ 15))
                   (SPADCALL |Scale| (QREFELT $ 17)) 1.0 1.0 1.0
                   (SPADCALL |DeltaX| (QREFELT $ 17))
                   (SPADCALL |DeltaY| (QREFELT $ 17))))) 

(SDEFUN |VIEW3D;viewpoint;$2FV;34|
        ((|viewport| ($)) (|Theta| (|Float|)) (|Phi| (|Float|)) ($ (|Void|)))
        (SEQ
         (QSETVELT (QVELT |viewport| 5) 0 (SPADCALL |Theta| (QREFELT $ 17)))
         (EXIT
          (QSETVELT (QVELT |viewport| 5) 1 (SPADCALL |Phi| (QREFELT $ 17)))))) 

(SDEFUN |VIEW3D;viewpoint;$3FV;35|
        ((|viewport| ($)) (X (|Float|)) (Y (|Float|)) (Z (|Float|))
         ($ (|Void|)))
        (SPROG ((|Phi| #1=(|Float|)) (|Theta| #1#) (R (|Float|)))
               (SEQ
                (COND
                 ((SPADCALL X (|spadConstant| $ 9) (QREFELT $ 112))
                  (COND
                   ((SPADCALL Y (|spadConstant| $ 9) (QREFELT $ 112))
                    (SEQ (LETT |Theta| (|spadConstant| $ 9))
                         (EXIT
                          (COND
                           ((SPADCALL Z (|spadConstant| $ 9) (QREFELT $ 113))
                            (LETT |Phi| (|spadConstant| $ 9)))
                           (#2='T (LETT |Phi| (SPADCALL (QREFELT $ 8))))))))
                   (#2#
                    (SEQ
                     (LETT |Theta|
                           (SPADCALL
                            (SPADCALL Y
                                      (LETT R
                                            (SPADCALL
                                             (SPADCALL
                                              (SPADCALL X X (QREFELT $ 114))
                                              (SPADCALL Y Y (QREFELT $ 114))
                                              (QREFELT $ 115))
                                             (QREFELT $ 116)))
                                      (QREFELT $ 13))
                            (QREFELT $ 117)))
                     (EXIT
                      (COND
                       ((SPADCALL Z (|spadConstant| $ 9) (QREFELT $ 112))
                        (LETT |Phi|
                              (SPADCALL (SPADCALL (QREFELT $ 8))
                                        (SPADCALL 2 (QREFELT $ 118))
                                        (QREFELT $ 13))))
                       (#2#
                        (LETT |Phi|
                              (SPADCALL (SPADCALL Z R (QREFELT $ 13))
                                        (QREFELT $ 119))))))))))
                 (#2#
                  (SEQ
                   (LETT |Theta|
                         (SPADCALL
                          (SPADCALL Y
                                    (LETT R
                                          (SPADCALL
                                           (SPADCALL
                                            (SPADCALL X X (QREFELT $ 114))
                                            (SPADCALL Y Y (QREFELT $ 114))
                                            (QREFELT $ 115))
                                           (QREFELT $ 116)))
                                    (QREFELT $ 13))
                          (QREFELT $ 117)))
                   (EXIT
                    (COND
                     ((SPADCALL Z (|spadConstant| $ 9) (QREFELT $ 112))
                      (LETT |Phi|
                            (SPADCALL (SPADCALL (QREFELT $ 8))
                                      (SPADCALL 2 (QREFELT $ 118))
                                      (QREFELT $ 13))))
                     (#2#
                      (LETT |Phi|
                            (SPADCALL (SPADCALL Z R (QREFELT $ 13))
                                      (QREFELT $ 119)))))))))
                (EXIT (SPADCALL |viewport| |Theta| |Phi| (QREFELT $ 120)))))) 

(SDEFUN |VIEW3D;title;$SV;36|
        ((|viewport| ($)) (|Title| (|String|)) ($ (|Void|)))
        (SPROG ((#1=#:G935 NIL))
               (SEQ
                (EXIT
                 (SEQ (QSETVELT |viewport| 2 |Title|)
                      (EXIT
                       (COND
                        ((SPADCALL (SPADCALL |viewport| (QREFELT $ 96)) 0
                                   (QREFELT $ 97))
                         (PROGN
                          (LETT #1#
                                (SEQ (|sockSendInt| |$ViewportServer| 1)
                                     (|sockSendInt| |$ViewportServer| 104)
                                     (EXIT
                                      (COND
                                       ((|VIEW3D;checkViewport| |viewport| $)
                                        (SEQ
                                         (|sockSendString| |$ViewportServer|
                                                           |Title|)
                                         (EXIT
                                          (|sockGetInt|
                                           |$ViewportServer|))))))))
                          (GO #2=#:G933)))))))
                #2# (EXIT #1#)))) 

(SDEFUN |VIEW3D;colorDef;$2CV;37|
        ((|viewport| ($)) (|HueOffset| (|Color|)) (|HueNumber| (|Color|))
         ($ (|Void|)))
        (SPROG ((#1=#:G942 NIL) (|h| (|Integer|)))
               (SEQ
                (EXIT
                 (SEQ
                  (QSETVELT |viewport| 6
                            (CONS
                             (LETT |h| (SPADCALL |HueOffset| (QREFELT $ 124)))
                             (- (SPADCALL |HueNumber| (QREFELT $ 124)) |h|)))
                  (EXIT
                   (COND
                    ((SPADCALL (SPADCALL |viewport| (QREFELT $ 96)) 0
                               (QREFELT $ 97))
                     (PROGN
                      (LETT #1#
                            (SEQ (|sockSendInt| |$ViewportServer| 1)
                                 (|sockSendInt| |$ViewportServer| 101)
                                 (EXIT
                                  (COND
                                   ((|VIEW3D;checkViewport| |viewport| $)
                                    (SEQ
                                     (|sockSendInt| |$ViewportServer|
                                                    (SPADCALL |HueOffset|
                                                              (QREFELT $ 124)))
                                     (|sockSendInt| |$ViewportServer|
                                                    (SPADCALL |HueNumber|
                                                              (QREFELT $ 124)))
                                     (EXIT
                                      (|sockGetInt| |$ViewportServer|))))))))
                      (GO #2=#:G940)))))))
                #2# (EXIT #1#)))) 

(SDEFUN |VIEW3D;dimensions;$2Nni2PiV;38|
        ((|viewport| ($)) (|ViewX| (|NonNegativeInteger|))
         (|ViewY| (|NonNegativeInteger|)) (|ViewWidth| (|PositiveInteger|))
         (|ViewHeight| (|PositiveInteger|)) ($ (|Void|)))
        (SEQ (QSETVELT |viewport| 3 (CONS |ViewX| |ViewY|))
             (EXIT (QSETVELT |viewport| 4 (CONS |ViewWidth| |ViewHeight|))))) 

(SDEFUN |VIEW3D;move;$2NniV;39|
        ((|viewport| ($)) (|xLoc| (|NonNegativeInteger|))
         (|yLoc| (|NonNegativeInteger|)) ($ (|Void|)))
        (SPROG ((#1=#:G953 NIL))
               (SEQ
                (EXIT
                 (SEQ (QSETVELT |viewport| 3 (CONS |xLoc| |yLoc|))
                      (EXIT
                       (COND
                        ((SPADCALL (SPADCALL |viewport| (QREFELT $ 96)) 0
                                   (QREFELT $ 97))
                         (PROGN
                          (LETT #1#
                                (SEQ (|sockSendInt| |$ViewportServer| 1)
                                     (|sockSendInt| |$ViewportServer| 102)
                                     (EXIT
                                      (COND
                                       ((|VIEW3D;checkViewport| |viewport| $)
                                        (SEQ
                                         (|sockSendInt| |$ViewportServer|
                                                        |xLoc|)
                                         (|sockSendInt| |$ViewportServer|
                                                        |yLoc|)
                                         (EXIT
                                          (|sockGetInt|
                                           |$ViewportServer|))))))))
                          (GO #2=#:G951)))))))
                #2# (EXIT #1#)))) 

(SDEFUN |VIEW3D;resize;$2PiV;40|
        ((|viewport| ($)) (|xSize| (|PositiveInteger|))
         (|ySize| (|PositiveInteger|)) ($ (|Void|)))
        (SPROG ((#1=#:G960 NIL))
               (SEQ
                (EXIT
                 (SEQ (QSETVELT |viewport| 4 (CONS |xSize| |ySize|))
                      (EXIT
                       (COND
                        ((SPADCALL (SPADCALL |viewport| (QREFELT $ 96)) 0
                                   (QREFELT $ 97))
                         (PROGN
                          (LETT #1#
                                (SEQ (|sockSendInt| |$ViewportServer| 1)
                                     (|sockSendInt| |$ViewportServer| 103)
                                     (EXIT
                                      (COND
                                       ((|VIEW3D;checkViewport| |viewport| $)
                                        (SEQ
                                         (|sockSendInt| |$ViewportServer|
                                                        |xSize|)
                                         (|sockSendInt| |$ViewportServer|
                                                        |ySize|)
                                         (EXIT
                                          (|sockGetInt|
                                           |$ViewportServer|))))))))
                          (GO #2=#:G958)))))))
                #2# (EXIT #1#)))) 

(SDEFUN |VIEW3D;coerce;$Of;41| ((|viewport| ($)) ($ (|OutputForm|)))
        (COND
         ((EQL (SPADCALL |viewport| (QREFELT $ 96)) 0)
          (SPADCALL
           (LIST
            (SPADCALL "Closed or Undefined ThreeDimensionalViewport: "
                      (QREFELT $ 130))
            (SPADCALL (QVELT |viewport| 2) (QREFELT $ 131)))
           (QREFELT $ 133)))
         ('T
          (SPADCALL
           (LIST (SPADCALL "ThreeDimensionalViewport: " (QREFELT $ 130))
                 (SPADCALL (QVELT |viewport| 2) (QREFELT $ 131)))
           (QREFELT $ 133))))) 

(PUT '|VIEW3D;key;$I;42| '|SPADreplace|
     '(XLAM (|viewport|) (QVELT |viewport| 0))) 

(SDEFUN |VIEW3D;key;$I;42| ((|viewport| ($)) ($ (|Integer|)))
        (QVELT |viewport| 0)) 

(SDEFUN |VIEW3D;rotate;$2IV;43|
        ((|viewport| ($)) (|Theta| (|Integer|)) (|Phi| (|Integer|))
         ($ (|Void|)))
        (SPADCALL |viewport|
                  (SPADCALL (SPADCALL |Theta| (QREFELT $ 118)) (QREFELT $ 14)
                            (QREFELT $ 114))
                  (SPADCALL (SPADCALL |Phi| (QREFELT $ 118)) (QREFELT $ 14)
                            (QREFELT $ 114))
                  (QREFELT $ 120))) 

(SDEFUN |VIEW3D;rotate;$2FV;44|
        ((|viewport| ($)) (|Theta| (|Float|)) (|Phi| (|Float|)) ($ (|Void|)))
        (SPROG ((#1=#:G971 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (QSETVELT (QVELT |viewport| 5) 0
                            (SPADCALL |Theta| (QREFELT $ 17)))
                  (QSETVELT (QVELT |viewport| 5) 1
                            (SPADCALL |Phi| (QREFELT $ 17)))
                  (EXIT
                   (COND
                    ((SPADCALL (SPADCALL |viewport| (QREFELT $ 96)) 0
                               (QREFELT $ 97))
                     (PROGN
                      (LETT #1#
                            (SEQ (|sockSendInt| |$ViewportServer| 1)
                                 (|sockSendInt| |$ViewportServer| 0)
                                 (EXIT
                                  (COND
                                   ((|VIEW3D;checkViewport| |viewport| $)
                                    (SEQ
                                     (|sockSendFloat| |$ViewportServer|
                                                      (QVELT
                                                       (QVELT |viewport| 5) 0))
                                     (|sockSendFloat| |$ViewportServer|
                                                      (QVELT
                                                       (QVELT |viewport| 5) 1))
                                     (EXIT
                                      (|sockGetInt| |$ViewportServer|))))))))
                      (GO #2=#:G969)))))))
                #2# (EXIT #1#)))) 

(SDEFUN |VIEW3D;zoom;$FV;45|
        ((|viewport| ($)) (|Scale| (|Float|)) ($ (|Void|)))
        (SPROG ((#1=#:G977 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (QSETVELT (QVELT |viewport| 5) 2
                            (SPADCALL |Scale| (QREFELT $ 17)))
                  (EXIT
                   (COND
                    ((SPADCALL (SPADCALL |viewport| (QREFELT $ 96)) 0
                               (QREFELT $ 97))
                     (PROGN
                      (LETT #1#
                            (SEQ (|sockSendInt| |$ViewportServer| 1)
                                 (|sockSendInt| |$ViewportServer| 1)
                                 (EXIT
                                  (COND
                                   ((|VIEW3D;checkViewport| |viewport| $)
                                    (SEQ
                                     (|sockSendFloat| |$ViewportServer|
                                                      (QVELT
                                                       (QVELT |viewport| 5) 2))
                                     (EXIT
                                      (|sockGetInt| |$ViewportServer|))))))))
                      (GO #2=#:G975)))))))
                #2# (EXIT #1#)))) 

(SDEFUN |VIEW3D;zoom;$3FV;46|
        ((|viewport| ($)) (|ScaleX| (|Float|)) (|ScaleY| (|Float|))
         (|ScaleZ| (|Float|)) ($ (|Void|)))
        (SPROG ((#1=#:G983 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (QSETVELT (QVELT |viewport| 5) 3
                            (SPADCALL |ScaleX| (QREFELT $ 17)))
                  (QSETVELT (QVELT |viewport| 5) 4
                            (SPADCALL |ScaleY| (QREFELT $ 17)))
                  (QSETVELT (QVELT |viewport| 5) 5
                            (SPADCALL |ScaleZ| (QREFELT $ 17)))
                  (EXIT
                   (COND
                    ((SPADCALL (SPADCALL |viewport| (QREFELT $ 96)) 0
                               (QREFELT $ 97))
                     (PROGN
                      (LETT #1#
                            (SEQ (|sockSendInt| |$ViewportServer| 1)
                                 (|sockSendInt| |$ViewportServer| 14)
                                 (EXIT
                                  (COND
                                   ((|VIEW3D;checkViewport| |viewport| $)
                                    (SEQ
                                     (|sockSendFloat| |$ViewportServer|
                                                      (QVELT
                                                       (QVELT |viewport| 5) 3))
                                     (|sockSendFloat| |$ViewportServer|
                                                      (QVELT
                                                       (QVELT |viewport| 5) 4))
                                     (|sockSendFloat| |$ViewportServer|
                                                      (QVELT
                                                       (QVELT |viewport| 5) 5))
                                     (EXIT
                                      (|sockGetInt| |$ViewportServer|))))))))
                      (GO #2=#:G981)))))))
                #2# (EXIT #1#)))) 

(SDEFUN |VIEW3D;translate;$2FV;47|
        ((|viewport| ($)) (|DeltaX| (|Float|)) (|DeltaY| (|Float|))
         ($ (|Void|)))
        (SPROG ((#1=#:G989 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (QSETVELT (QVELT |viewport| 5) 6
                            (SPADCALL |DeltaX| (QREFELT $ 17)))
                  (QSETVELT (QVELT |viewport| 5) 7
                            (SPADCALL |DeltaY| (QREFELT $ 17)))
                  (EXIT
                   (COND
                    ((SPADCALL (SPADCALL |viewport| (QREFELT $ 96)) 0
                               (QREFELT $ 97))
                     (PROGN
                      (LETT #1#
                            (SEQ (|sockSendInt| |$ViewportServer| 1)
                                 (|sockSendInt| |$ViewportServer| 2)
                                 (EXIT
                                  (COND
                                   ((|VIEW3D;checkViewport| |viewport| $)
                                    (SEQ
                                     (|sockSendFloat| |$ViewportServer|
                                                      (QVELT
                                                       (QVELT |viewport| 5) 6))
                                     (|sockSendFloat| |$ViewportServer|
                                                      (QVELT
                                                       (QVELT |viewport| 5) 7))
                                     (EXIT
                                      (|sockGetInt| |$ViewportServer|))))))))
                      (GO #2=#:G987)))))))
                #2# (EXIT #1#)))) 

(SDEFUN |VIEW3D;intensity;$FV;48|
        ((|viewport| ($)) (|Amount| (|Float|)) ($ (|Void|)))
        (SPROG ((#1=#:G997 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((OR
                     (SPADCALL |Amount| (|spadConstant| $ 9) (QREFELT $ 139))
                     (SPADCALL |Amount| (|spadConstant| $ 74) (QREFELT $ 140)))
                    (|error|
                     "The intensity must be a value between 0 and 1, inclusively.")))
                  (QSETVELT (QVELT |viewport| 8) 5
                            (SPADCALL |Amount| (QREFELT $ 17)))
                  (EXIT
                   (COND
                    ((SPADCALL (SPADCALL |viewport| (QREFELT $ 96)) 0
                               (QREFELT $ 97))
                     (PROGN
                      (LETT #1#
                            (SEQ (|sockSendInt| |$ViewportServer| 1)
                                 (|sockSendInt| |$ViewportServer| 109)
                                 (EXIT
                                  (COND
                                   ((|VIEW3D;checkViewport| |viewport| $)
                                    (SEQ
                                     (|sockSendFloat| |$ViewportServer|
                                                      (QVELT
                                                       (QVELT |viewport| 8) 5))
                                     (EXIT
                                      (|sockGetInt| |$ViewportServer|))))))))
                      (GO #2=#:G995)))))))
                #2# (EXIT #1#)))) 

(SDEFUN |VIEW3D;write;$3S;49|
        ((|viewport| ($)) (|Filename| (|String|)) (|aThingToWrite| (|String|))
         ($ (|String|)))
        (SPADCALL |viewport| |Filename| (LIST |aThingToWrite|) (QREFELT $ 143))) 

(SDEFUN |VIEW3D;write;$2S;50|
        ((|viewport| ($)) (|Filename| (|String|)) ($ (|String|)))
        (SPADCALL |viewport| |Filename| (SPADCALL (QREFELT $ 145))
                  (QREFELT $ 143))) 

(SDEFUN |VIEW3D;write;$SLS;51|
        ((|viewport| ($)) (|Filename| (|String|))
         (|thingsToWrite| (|List| (|String|))) ($ (|String|)))
        (SPROG
         ((|writeTypeInt| (|Integer|)) (#1=#:G1011 NIL) (|aTypeOfFile| NIL)
          (|m| (|Integer|)) (|avail| (|List| (|String|))))
         (SEQ
          (COND
           ((SPADCALL (SPADCALL |viewport| (QREFELT $ 96)) 0 (QREFELT $ 97))
            (SEQ (|sockSendInt| |$ViewportServer| 1)
                 (|sockSendInt| |$ViewportServer| 110)
                 (EXIT
                  (COND
                   ((|VIEW3D;checkViewport| |viewport| $)
                    (SEQ (|sockSendString| |$ViewportServer| |Filename|)
                         (LETT |m|
                               (PROGN
                                (LETT |avail| (SPADCALL (QREFELT $ 147)))
                                1))
                         (SEQ (LETT |aTypeOfFile| NIL)
                              (LETT #1# |thingsToWrite|) G190
                              (COND
                               ((OR (ATOM #1#)
                                    (PROGN (LETT |aTypeOfFile| (CAR #1#)) NIL))
                                (GO G191)))
                              (SEQ
                               (LETT |writeTypeInt|
                                     (-
                                      (SPADCALL
                                       (SPADCALL |aTypeOfFile| (QREFELT $ 148))
                                       |avail| (QREFELT $ 149))
                                      |m|))
                               (EXIT
                                (COND
                                 ((< |writeTypeInt| 0)
                                  (SPADCALL
                                   (LIST "  > " |aTypeOfFile|
                                         " is not a valid file type for writing a 3D viewport")
                                   (QREFELT $ 150)))
                                 ('T
                                  (|sockSendInt| |$ViewportServer|
                                                 (+ |writeTypeInt| 1))))))
                              (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                         (|sockSendInt| |$ViewportServer| 0)
                         (|sockGetInt| |$ViewportServer|) (EXIT |Filename|)))
                   (#2='T (|error| "write: problem with viewport"))))))
           (#2# (|error| "write: problem contacting viewman")))))) 

(SDEFUN |VIEW3D;perspective;$SV;52|
        ((|viewport| ($)) (|onOff| (|String|)) ($ (|Void|)))
        (SPROG ((#1=#:G1017 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((EQUAL |onOff| "on") (QSETVELT (QVELT |viewport| 9) 0 1))
                   ('T (QSETVELT (QVELT |viewport| 9) 0 0)))
                  (EXIT
                   (COND
                    ((SPADCALL (SPADCALL |viewport| (QREFELT $ 96)) 0
                               (QREFELT $ 97))
                     (PROGN
                      (LETT #1#
                            (SEQ (|sockSendInt| |$ViewportServer| 1)
                                 (|sockSendInt| |$ViewportServer| 27)
                                 (EXIT
                                  (COND
                                   ((|VIEW3D;checkViewport| |viewport| $)
                                    (SEQ
                                     (|sockSendInt| |$ViewportServer|
                                                    (QVELT (QVELT |viewport| 9)
                                                           0))
                                     (EXIT
                                      (|sockGetInt| |$ViewportServer|))))))))
                      (GO #2=#:G1015)))))))
                #2# (EXIT #1#)))) 

(SDEFUN |VIEW3D;showRegion;$SV;53|
        ((|viewport| ($)) (|onOff| (|String|)) ($ (|Void|)))
        (SPROG ((#1=#:G1023 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((EQUAL |onOff| "on") (QSETVELT (QVELT |viewport| 7) 5 1))
                   ('T (QSETVELT (QVELT |viewport| 7) 5 0)))
                  (EXIT
                   (COND
                    ((SPADCALL (SPADCALL |viewport| (QREFELT $ 96)) 0
                               (QREFELT $ 97))
                     (PROGN
                      (LETT #1#
                            (SEQ (|sockSendInt| |$ViewportServer| 1)
                                 (|sockSendInt| |$ViewportServer| 12)
                                 (EXIT
                                  (COND
                                   ((|VIEW3D;checkViewport| |viewport| $)
                                    (SEQ
                                     (|sockSendInt| |$ViewportServer|
                                                    (QVELT (QVELT |viewport| 7)
                                                           5))
                                     (EXIT
                                      (|sockGetInt| |$ViewportServer|))))))))
                      (GO #2=#:G1021)))))))
                #2# (EXIT #1#)))) 

(SDEFUN |VIEW3D;showClipRegion;$SV;54|
        ((|viewport| ($)) (|onOff| (|String|)) ($ (|Void|)))
        (SPROG ((#1=#:G1029 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((EQUAL |onOff| "on") (QSETVELT (QVELT |viewport| 10) 6 1))
                   ('T (QSETVELT (QVELT |viewport| 10) 6 0)))
                  (EXIT
                   (COND
                    ((SPADCALL (SPADCALL |viewport| (QREFELT $ 96)) 0
                               (QREFELT $ 97))
                     (PROGN
                      (LETT #1#
                            (SEQ (|sockSendInt| |$ViewportServer| 1)
                                 (|sockSendInt| |$ViewportServer| 66)
                                 (EXIT
                                  (COND
                                   ((|VIEW3D;checkViewport| |viewport| $)
                                    (SEQ
                                     (|sockSendInt| |$ViewportServer|
                                                    (QVELT
                                                     (QVELT |viewport| 10) 6))
                                     (EXIT
                                      (|sockGetInt| |$ViewportServer|))))))))
                      (GO #2=#:G1027)))))))
                #2# (EXIT #1#)))) 

(SDEFUN |VIEW3D;clipSurface;$SV;55|
        ((|viewport| ($)) (|onOff| (|String|)) ($ (|Void|)))
        (SPROG ((#1=#:G1035 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((EQUAL |onOff| "on") (QSETVELT (QVELT |viewport| 10) 7 1))
                   ('T (QSETVELT (QVELT |viewport| 10) 7 0)))
                  (EXIT
                   (COND
                    ((SPADCALL (SPADCALL |viewport| (QREFELT $ 96)) 0
                               (QREFELT $ 97))
                     (PROGN
                      (LETT #1#
                            (SEQ (|sockSendInt| |$ViewportServer| 1)
                                 (|sockSendInt| |$ViewportServer| 67)
                                 (EXIT
                                  (COND
                                   ((|VIEW3D;checkViewport| |viewport| $)
                                    (SEQ
                                     (|sockSendInt| |$ViewportServer|
                                                    (QVELT
                                                     (QVELT |viewport| 10) 7))
                                     (EXIT
                                      (|sockGetInt| |$ViewportServer|))))))))
                      (GO #2=#:G1033)))))))
                #2# (EXIT #1#)))) 

(SDEFUN |VIEW3D;eyeDistance;$FV;56|
        ((|viewport| ($)) (|EyeDistance| (|Float|)) ($ (|Void|)))
        (SPROG ((#1=#:G1041 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (QSETVELT (QVELT |viewport| 9) 1
                            (SPADCALL |EyeDistance| (QREFELT $ 17)))
                  (EXIT
                   (COND
                    ((SPADCALL (SPADCALL |viewport| (QREFELT $ 96)) 0
                               (QREFELT $ 97))
                     (PROGN
                      (LETT #1#
                            (SEQ (|sockSendInt| |$ViewportServer| 1)
                                 (|sockSendInt| |$ViewportServer| 111)
                                 (EXIT
                                  (COND
                                   ((|VIEW3D;checkViewport| |viewport| $)
                                    (SEQ
                                     (|sockSendFloat| |$ViewportServer|
                                                      (QVELT
                                                       (QVELT |viewport| 9) 1))
                                     (EXIT
                                      (|sockGetInt| |$ViewportServer|))))))))
                      (GO #2=#:G1039)))))))
                #2# (EXIT #1#)))) 

(SDEFUN |VIEW3D;hitherPlane;$FV;57|
        ((|viewport| ($)) (|HitherPlane| (|Float|)) ($ (|Void|)))
        (SPROG ((#1=#:G1047 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (QSETVELT (QVELT |viewport| 9) 2
                            (SPADCALL |HitherPlane| (QREFELT $ 17)))
                  (EXIT
                   (COND
                    ((SPADCALL (SPADCALL |viewport| (QREFELT $ 96)) 0
                               (QREFELT $ 97))
                     (PROGN
                      (LETT #1#
                            (SEQ (|sockSendInt| |$ViewportServer| 1)
                                 (|sockSendInt| |$ViewportServer| 116)
                                 (EXIT
                                  (COND
                                   ((|VIEW3D;checkViewport| |viewport| $)
                                    (SEQ
                                     (|sockSendFloat| |$ViewportServer|
                                                      (QVELT
                                                       (QVELT |viewport| 9) 2))
                                     (EXIT
                                      (|sockGetInt| |$ViewportServer|))))))))
                      (GO #2=#:G1045)))))))
                #2# (EXIT #1#)))) 

(SDEFUN |VIEW3D;modifyPointData;$NniPV;58|
        ((|viewport| ($)) (|anIndex| (|NonNegativeInteger|))
         (|aPoint| (|Point| (|DoubleFloat|))) ($ (|Void|)))
        (SPROG ((#1=#:G1054 NIL) (|n| (|PositiveInteger|)))
               (SEQ (LETT |n| (SPADCALL |aPoint| (QREFELT $ 70)))
                    (EXIT
                     (COND
                      ((< |n| 3)
                       (|error|
                        "The point should have dimension of at least 3"))
                      (#2='T
                       (SEQ
                        (EXIT
                         (SEQ
                          (QSETVELT |viewport| 11
                                    (SPADCALL (QVELT |viewport| 11) |anIndex|
                                              |aPoint| (QREFELT $ 157)))
                          (EXIT
                           (COND
                            ((SPADCALL (SPADCALL |viewport| (QREFELT $ 96)) 0
                                       (QREFELT $ 97))
                             (PROGN
                              (LETT #1#
                                    (SEQ (|sockSendInt| |$ViewportServer| 1)
                                         (|sockSendInt| |$ViewportServer| 114)
                                         (EXIT
                                          (COND
                                           ((|VIEW3D;checkViewport| |viewport|
                                             $)
                                            (SEQ
                                             (|sockSendInt| |$ViewportServer|
                                                            |anIndex|)
                                             (|sockSendFloat| |$ViewportServer|
                                                              (SPADCALL
                                                               |aPoint|
                                                               (QREFELT $ 76)))
                                             (|sockSendFloat| |$ViewportServer|
                                                              (SPADCALL
                                                               |aPoint|
                                                               (QREFELT $ 77)))
                                             (|sockSendFloat| |$ViewportServer|
                                                              (SPADCALL
                                                               |aPoint|
                                                               (QREFELT $ 78)))
                                             (COND
                                              ((EQL |n| 3)
                                               (|sockSendFloat|
                                                |$ViewportServer|
                                                (SPADCALL
                                                 (SPADCALL 5 -1 10
                                                           (QREFELT $ 12))
                                                 (QREFELT $ 17))))
                                              (#2#
                                               (|sockSendFloat|
                                                |$ViewportServer|
                                                (SPADCALL |aPoint|
                                                          (QREFELT $ 79)))))
                                             (EXIT
                                              (|sockGetInt|
                                               |$ViewportServer|))))))))
                              (GO #3=#:G1051)))))))
                        #3# (EXIT #1#)))))))) 

(DECLAIM (NOTINLINE |ThreeDimensionalViewport;|)) 

(DEFUN |ThreeDimensionalViewport| ()
  (SPROG NIL
         (PROG (#1=#:G1056)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|ThreeDimensionalViewport|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|ThreeDimensionalViewport|
                             (LIST
                              (CONS NIL
                                    (CONS 1 (|ThreeDimensionalViewport;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache|
                        '|ThreeDimensionalViewport|)))))))))) 

(DEFUN |ThreeDimensionalViewport;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|ThreeDimensionalViewport|))
          (LETT $ (GETREFV 161))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ThreeDimensionalViewport| NIL
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6
                    (|Record| (|:| |key| (|Integer|)) (|:| |fun| (|Integer|))
                              (|:| |title| (|String|))
                              (|:| |moveTo|
                                   (|Record| (|:| X (|NonNegativeInteger|))
                                             (|:| Y (|NonNegativeInteger|))))
                              (|:| |size|
                                   (|Record| (|:| X (|PositiveInteger|))
                                             (|:| Y (|PositiveInteger|))))
                              (|:| |viewpoint|
                                   (|Record| (|:| |theta| (|DoubleFloat|))
                                             (|:| |phi| (|DoubleFloat|))
                                             (|:| |scale| (|DoubleFloat|))
                                             (|:| |scaleX| (|DoubleFloat|))
                                             (|:| |scaleY| (|DoubleFloat|))
                                             (|:| |scaleZ| (|DoubleFloat|))
                                             (|:| |deltaX| (|DoubleFloat|))
                                             (|:| |deltaY| (|DoubleFloat|))))
                              (|:| |colors|
                                   (|Record| (|:| |hueOffset| (|Integer|))
                                             (|:| |hueNumber| (|Integer|))))
                              (|:| |flags|
                                   (|Record| (|:| |showCP| (|Integer|))
                                             (|:| |style| (|Integer|))
                                             (|:| |axesOn| (|Integer|))
                                             (|:| |diagonalsOn| (|Integer|))
                                             (|:| |outlineRenderOn|
                                                  (|Integer|))
                                             (|:| |showRegionField|
                                                  (|Integer|))))
                              (|:| |lighting|
                                   (|Record| (|:| |lightX| (|DoubleFloat|))
                                             (|:| |lightY| (|DoubleFloat|))
                                             (|:| |lightZ| (|DoubleFloat|))
                                             (|:| |lightTheta| (|DoubleFloat|))
                                             (|:| |lightPhi| (|DoubleFloat|))
                                             (|:| |translucence|
                                                  (|DoubleFloat|))))
                              (|:| |perspective|
                                   (|Record|
                                    (|:| |perspectiveField| (|Integer|))
                                    (|:| |eyeDistance| (|DoubleFloat|))
                                    (|:| |hitherPlane| (|DoubleFloat|))))
                              (|:| |volume|
                                   (|Record| (|:| |clipXMin| (|DoubleFloat|))
                                             (|:| |clipXMax| (|DoubleFloat|))
                                             (|:| |clipYMin| (|DoubleFloat|))
                                             (|:| |clipYMax| (|DoubleFloat|))
                                             (|:| |clipZMin| (|DoubleFloat|))
                                             (|:| |clipZMax| (|DoubleFloat|))
                                             (|:| |clipRegionField|
                                                  (|Integer|))
                                             (|:| |clipSurfaceField|
                                                  (|Integer|))))
                              (|:| |space3D| (|ThreeSpace| (|DoubleFloat|)))
                              (|:| |optionsField| (|List| (|DrawOption|)))))
          (QSETREFV $ 14
                    (SPADCALL (SPADCALL (QREFELT $ 8))
                              (SPADCALL 180 0 10 (QREFELT $ 12))
                              (QREFELT $ 13)))
          (QSETREFV $ 15
                    (|div_DF_I| (FLOAT PI MOST-POSITIVE-DOUBLE-FLOAT) 180))
          (QSETREFV $ 18
                    (SPADCALL
                     (SPADCALL (SPADCALL (QREFELT $ 8))
                               (SPADCALL 4 0 10 (QREFELT $ 12)) (QREFELT $ 13))
                     (QREFELT $ 17)))
          (QSETREFV $ 20
                    (SPADCALL
                     (SPADCALL
                      (SPADCALL (SPADCALL (QREFELT $ 8))
                                (SPADCALL 4 0 10 (QREFELT $ 12))
                                (QREFELT $ 13))
                      (QREFELT $ 19))
                     (QREFELT $ 17)))
          (QSETREFV $ 21
                    (SPADCALL (SPADCALL 12 -1 10 (QREFELT $ 12))
                              (QREFELT $ 17)))
          (QSETREFV $ 22 0.0)
          (QSETREFV $ 23 0.0)
          $))) 

(MAKEPROP '|ThreeDimensionalViewport| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|Rep| (|Float|) (0 . |pi|) (4 . |Zero|)
              (|Integer|) (|PositiveInteger|) (8 . |float|) (15 . /) '|degrees|
              '|degreesSF| (|DoubleFloat|) (21 . |convert|) '|defaultTheta|
              (26 . -) '|defaultPhi| '|defaultZoom| '|defaultDeltaX|
              '|defaultDeltaY| (|String|) (|List| 47) (|DrawOptionFunctions0|)
              (31 . |title|) (37 . |style|)
              (|Record| (|:| |theta| 16) (|:| |phi| 16) (|:| |scale| 16)
                        (|:| |scaleX| 16) (|:| |scaleY| 16) (|:| |scaleZ| 16)
                        (|:| |deltaX| 16) (|:| |deltaY| 16))
              (43 . |viewpoint|) (|List| 34) (|ViewDefaultsPackage|)
              (49 . |viewPosDefault|) (|NonNegativeInteger|) (53 . |elt|)
              (|List| 11) (59 . |viewSizeDefault|) (63 . |elt|)
              (|ThreeSpace| 16) (69 . |create3Space|) |VIEW3D;viewport3D;$;3|
              |VIEW3D;subspace;$Ts;4| |VIEW3D;subspace;$Ts$;5|
              |VIEW3D;options;$L;6| |VIEW3D;options;$L$;7|
              |VIEW3D;makeViewport3D;2$;8| (|DrawOption|) (73 . |title|)
              |VIEW3D;makeViewport3D;TsS$;9| |VIEW3D;makeViewport3D;TsL$;10|
              (|Void|) (|DisplayPackage|) (78 . |say|) (|Point| 16)
              (|CoordinateSystems| 16) (83 . |cartesian|) (|Mapping| 54 54)
              (88 . |coord|) (94 . |check|) (|List| 54) (99 . |lp|)
              (|List| (|List| 31)) (104 . |lllip|) (|List| 66) (109 . |llprop|)
              (|List| 81) (114 . |lprop|) (|Set| 11) (119 . |empty|)
              (123 . |dimension|) (128 . |insert!|) (134 . |#|) (139 . |parts|)
              (144 . |One|) (|PointPackage| 16) (148 . |xCoord|)
              (153 . |yCoord|) (158 . |zCoord|) (163 . |color|) (|Boolean|)
              (|SubSpaceComponentProperty|) (168 . |closed?|) (173 . |solid?|)
              (178 . |#|) (183 . |convert|) |VIEW3D;viewThetaDefault;F;12|
              |VIEW3D;viewThetaDefault;2F;13| |VIEW3D;viewPhiDefault;F;14|
              |VIEW3D;viewPhiDefault;2F;15| |VIEW3D;viewZoomDefault;F;16|
              |VIEW3D;viewZoomDefault;2F;17| |VIEW3D;viewDeltaXDefault;F;18|
              |VIEW3D;viewDeltaXDefault;2F;19| |VIEW3D;viewDeltaYDefault;F;20|
              |VIEW3D;viewDeltaYDefault;2F;21| |VIEW3D;key;$I;42| (188 . ~=)
              |VIEW3D;lighting;$3FV;22| |VIEW3D;axes;$SV;23|
              |VIEW3D;diagonals;$SV;24| |VIEW3D;outlineRender;$SV;25|
              |VIEW3D;controlPanel;$SV;26| |VIEW3D;drawStyle;$SV;27|
              (194 . |void|) |VIEW3D;reset;$V;28| |VIEW3D;close;$V;29|
              |VIEW3D;viewpoint;$R;30| |VIEW3D;viewpoint;$RV;31|
              |VIEW3D;viewpoint;$5FV;32| |VIEW3D;viewpoint;$2I3FV;33|
              |VIEW3D;viewpoint;$2FV;34| (198 . =) (204 . >=) (210 . *)
              (216 . +) (222 . |sqrt|) (227 . |asin|) (232 . |coerce|)
              (237 . |atan|) |VIEW3D;rotate;$2FV;44| |VIEW3D;viewpoint;$3FV;35|
              |VIEW3D;title;$SV;36| (|Color|) (242 . |hue|)
              |VIEW3D;colorDef;$2CV;37| |VIEW3D;dimensions;$2Nni2PiV;38|
              |VIEW3D;move;$2NniV;39| |VIEW3D;resize;$2PiV;40| (|OutputForm|)
              (247 . |message|) (252 . |coerce|) (|List| $) (257 . |hconcat|)
              |VIEW3D;coerce;$Of;41| |VIEW3D;rotate;$2IV;43|
              |VIEW3D;zoom;$FV;45| |VIEW3D;zoom;$3FV;46|
              |VIEW3D;translate;$2FV;47| (262 . <) (268 . >)
              |VIEW3D;intensity;$FV;48| (|List| 24) |VIEW3D;write;$SLS;51|
              |VIEW3D;write;$3S;49| (274 . |viewWriteDefault|)
              |VIEW3D;write;$2S;50| (278 . |viewWriteAvailable|)
              (282 . |upperCase|) (287 . |position|) (293 . |say|)
              |VIEW3D;perspective;$SV;52| |VIEW3D;showRegion;$SV;53|
              |VIEW3D;showClipRegion;$SV;54| |VIEW3D;clipSurface;$SV;55|
              |VIEW3D;eyeDistance;$FV;56| |VIEW3D;hitherPlane;$FV;57|
              (298 . |modifyPointData|) |VIEW3D;modifyPointData;$NniPV;58|
              (|HashState|) (|SingleInteger|))
           '#(~= 305 |zoom| 311 |write| 325 |viewport3D| 345 |viewpoint| 349
              |viewZoomDefault| 395 |viewThetaDefault| 404 |viewPhiDefault| 413
              |viewDeltaYDefault| 422 |viewDeltaXDefault| 431 |translate| 440
              |title| 447 |subspace| 453 |showRegion| 464 |showClipRegion| 470
              |rotate| 476 |resize| 490 |reset| 497 |perspective| 502
              |outlineRender| 508 |options| 514 |move| 525 |modifyPointData|
              532 |makeViewport3D| 539 |lighting| 556 |latex| 564 |key| 569
              |intensity| 574 |hitherPlane| 580 |hashUpdate!| 586 |hash| 592
              |eyeDistance| 597 |drawStyle| 603 |dimensions| 609 |diagonals|
              618 |controlPanel| 624 |colorDef| 630 |coerce| 637 |close| 642
              |clipSurface| 647 |axes| 653 = 659)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0))
                 (CONS '#(|SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|SetCategory|) (|BasicType|) (|CoercibleTo| 129))
                        (|makeByteWordVec2| 160
                                            '(0 7 0 8 0 7 0 9 3 7 0 10 10 11 12
                                              2 7 0 0 0 13 1 7 16 0 17 1 7 0 0
                                              19 2 26 24 25 24 27 2 26 24 25 24
                                              28 2 26 29 25 29 30 0 32 31 33 2
                                              31 34 0 10 35 0 32 36 37 2 36 11
                                              0 10 38 0 39 0 40 1 47 0 24 48 1
                                              52 51 24 53 1 55 54 54 56 2 26 57
                                              25 57 58 1 39 0 0 59 1 39 60 0 61
                                              1 39 62 0 63 1 39 64 0 65 1 39 66
                                              0 67 0 68 0 69 1 54 11 0 70 2 68
                                              0 11 0 71 1 68 34 0 72 1 68 36 0
                                              73 0 7 0 74 1 75 16 54 76 1 75 16
                                              54 77 1 75 16 54 78 1 75 16 54 79
                                              1 81 80 0 82 1 81 80 0 83 1 31 34
                                              0 84 1 7 0 16 85 2 10 80 0 0 97 0
                                              51 0 104 2 7 80 0 0 112 2 7 80 0
                                              0 113 2 7 0 0 0 114 2 7 0 0 0 115
                                              1 7 0 0 116 1 7 0 0 117 1 7 0 10
                                              118 1 7 0 0 119 1 123 10 0 124 1
                                              129 0 24 130 1 24 129 0 131 1 129
                                              0 132 133 2 7 80 0 0 139 2 7 80 0
                                              0 140 0 32 142 145 0 32 142 147 1
                                              24 0 0 148 2 142 10 24 0 149 1 52
                                              51 142 150 3 39 0 0 34 54 157 2 0
                                              80 0 0 1 2 0 51 0 7 136 4 0 51 0
                                              7 7 7 137 3 0 24 0 24 142 143 2 0
                                              24 0 24 146 3 0 24 0 24 24 144 0
                                              0 0 41 4 0 51 0 7 7 7 121 6 0 51
                                              0 10 10 7 7 7 110 3 0 51 0 7 7
                                              111 1 0 29 0 107 2 0 51 0 29 108
                                              6 0 51 0 7 7 7 7 7 109 0 0 7 90 1
                                              0 7 7 91 0 0 7 86 1 0 7 7 87 0 0
                                              7 88 1 0 7 7 89 1 0 7 7 95 0 0 7
                                              94 0 0 7 92 1 0 7 7 93 3 0 51 0 7
                                              7 138 2 0 51 0 24 122 2 0 0 0 39
                                              43 1 0 39 0 42 2 0 51 0 24 152 2
                                              0 51 0 24 153 3 0 51 0 7 7 120 3
                                              0 51 0 10 10 135 3 0 51 0 11 11
                                              128 1 0 51 0 105 2 0 51 0 24 151
                                              2 0 51 0 24 101 1 0 25 0 44 2 0 0
                                              0 25 45 3 0 51 0 34 34 127 3 0 51
                                              0 34 54 158 2 0 0 39 25 50 1 0 0
                                              0 46 2 0 0 39 24 49 4 0 51 0 7 7
                                              7 98 1 0 24 0 1 1 0 10 0 96 2 0
                                              51 0 7 141 2 0 51 0 7 156 2 0 159
                                              159 0 1 1 0 160 0 1 2 0 51 0 7
                                              155 2 0 51 0 24 103 5 0 51 0 34
                                              34 11 11 126 2 0 51 0 24 100 2 0
                                              51 0 24 102 3 0 51 0 123 123 125
                                              1 0 129 0 134 1 0 51 0 106 2 0 51
                                              0 24 154 2 0 51 0 24 99 2 0 80 0
                                              0 1)))))
           '|lookupComplete|)) 

(MAKEPROP '|ThreeDimensionalViewport| 'NILADIC T) 
