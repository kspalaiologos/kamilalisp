
(SDEFUN |MFLOAT;retractIfCan;$U;1|
        ((|u| ($)) ($ (|Union| (|Fraction| (|Integer|)) "failed")))
        (CONS 0
              (SPADCALL (SPADCALL |u| (QREFELT $ 14))
                        (SPADCALL (SPADCALL (QREFELT $ 8) 1 (QREFELT $ 19))
                                  (SPADCALL |u| (QREFELT $ 20)) (QREFELT $ 21))
                        (QREFELT $ 22)))) 

(SDEFUN |MFLOAT;wholePart;$I;2| ((|u| ($)) ($ #1=(|Integer|)))
        (SPROG ((|f| #1#) (|exp| (|Integer|)) (|man| (|Integer|)))
               (SEQ (LETT |man| (SPADCALL |u| (QREFELT $ 14)))
                    (LETT |exp| (SPADCALL |u| (QREFELT $ 20)))
                    (EXIT
                     (LETT |f|
                           (COND
                            ((PLUSP |exp|)
                             (* |man| (EXPT (QREFELT $ 8) |exp|)))
                            ((ZEROP |exp|) |man|)
                            ('T
                             (SPADCALL
                              (SPADCALL |man| (EXPT (QREFELT $ 8) (- |exp|))
                                        (QREFELT $ 19))
                              (QREFELT $ 25))))))))) 

(SDEFUN |MFLOAT;normalise| ((|u| ($)) ($ ($)))
        (SPROG
         ((|man| (|Integer|)) (|exp| (|Integer|))
          (|q1| #1=(|Fraction| (|Integer|))) (BBF #1#) (|sgn| (|Integer|))
          (BB (|Integer|)))
         (SEQ (LETT |exp| (SPADCALL |u| (QREFELT $ 20)))
              (LETT |man| (SPADCALL |u| (QREFELT $ 14)))
              (LETT BB (QREFELT $ 8))
              (LETT |sgn| (SPADCALL |man| (QREFELT $ 27)))
              (LETT |man| (ABS |man|))
              (EXIT
               (COND ((ZEROP |man|) (CONS 0 0))
                     (#2='T
                      (SEQ
                       (COND
                        ((< |man| (QREFELT $ 12))
                         (SEQ G190
                              (COND
                               ((NULL (< |man| (QREFELT $ 12))) (GO G191)))
                              (SEQ (LETT |exp| (- |exp| 1))
                                   (EXIT (LETT |man| (* |man| BB))))
                              NIL (GO G190) G191 (EXIT NIL))))
                       (COND
                        ((> |man| (QREFELT $ 12))
                         (SEQ (LETT |q1| (SPADCALL |man| 1 (QREFELT $ 19)))
                              (LETT BBF (SPADCALL BB 1 (QREFELT $ 19)))
                              (SEQ G190
                                   (COND
                                    ((NULL
                                      (> (SPADCALL |q1| (QREFELT $ 25))
                                         (QREFELT $ 12)))
                                     (GO G191)))
                                   (SEQ
                                    (LETT |q1|
                                          (SPADCALL |q1| BBF (QREFELT $ 30)))
                                    (EXIT (LETT |exp| (+ |exp| 1))))
                                   NIL (GO G190) G191 (EXIT NIL))
                              (EXIT (LETT |man| (|MFLOAT;locRound| |q1| $))))))
                       (EXIT
                        (COND
                         ((PLUSP |sgn|)
                          (|MFLOAT;checkExponent| (CONS |man| |exp|) $))
                         (#2#
                          (|MFLOAT;checkExponent| (CONS (- |man|) |exp|)
                           $))))))))))) 

(PUT '|MFLOAT;mantissa;$I;4| '|SPADreplace| 'QCAR) 

(SDEFUN |MFLOAT;mantissa;$I;4| ((|u| ($)) ($ (|Integer|))) (QCAR |u|)) 

(PUT '|MFLOAT;exponent;$I;5| '|SPADreplace| 'QCDR) 

(SDEFUN |MFLOAT;exponent;$I;5| ((|u| ($)) ($ (|Integer|))) (QCDR |u|)) 

(SDEFUN |MFLOAT;newPower|
        ((|base| #1=(|PositiveInteger|)) (|prec| (|PositiveInteger|))
         ($ (|Void|)))
        (SPROG
         ((|power| (|PositiveInteger|)) (|current| #1#)
          (|target| (|PositiveInteger|)))
         (SEQ (LETT |power| 1) (LETT |target| (EXPT 10 |prec|))
              (LETT |current| |base|)
              (SEQ G190
                   (COND
                    ((NULL (< (LETT |current| (* |current| |base|)) |target|))
                     (GO G191)))
                   (SEQ (EXIT (LETT |power| (+ |power| 1)))) NIL (GO G190) G191
                   (EXIT NIL))
              (SETELT $ 11 |power|)
              (SETELT $ 12 (EXPT (QREFELT $ 8) (QREFELT $ 11)))
              (EXIT (SPADCALL (QREFELT $ 32)))))) 

(SDEFUN |MFLOAT;changeBase;2IPi$;7|
        ((|exp| (|Integer|)) (|man| (|Integer|)) (|base| (|PositiveInteger|))
         ($ ($)))
        (SPROG
         ((|newMan| (|Integer|)) (|f| (|Fraction| (|Integer|)))
          (|newExp| (|Integer|)) (BB (|Fraction| (|Integer|)))
          (|sign| (|Integer|)))
         (SEQ (LETT |newExp| 0)
              (LETT |f|
                    (SPADCALL |man|
                              (SPADCALL (SPADCALL |base| (QREFELT $ 33)) |exp|
                                        (QREFELT $ 21))
                              (QREFELT $ 22)))
              (LETT |sign| (SPADCALL |f| (QREFELT $ 34)))
              (LETT |f| (SPADCALL |f| (QREFELT $ 35)))
              (LETT |newMan| (SPADCALL |f| (QREFELT $ 25)))
              (EXIT
               (COND ((SPADCALL |f| (QREFELT $ 37)) (CONS 0 0))
                     ('T
                      (SEQ (LETT BB (SPADCALL (QREFELT $ 8) (QREFELT $ 33)))
                           (COND
                            ((< |newMan| (QREFELT $ 12))
                             (SEQ G190
                                  (COND
                                   ((NULL (< |newMan| (QREFELT $ 12)))
                                    (GO G191)))
                                  (SEQ (LETT |newExp| (- |newExp| 1))
                                       (LETT |f|
                                             (SPADCALL |f| BB (QREFELT $ 38)))
                                       (EXIT
                                        (LETT |newMan|
                                              (SPADCALL |f| (QREFELT $ 25)))))
                                  NIL (GO G190) G191 (EXIT NIL))))
                           (COND
                            ((> |newMan| (QREFELT $ 12))
                             (SEQ G190
                                  (COND
                                   ((NULL (> |newMan| (QREFELT $ 12)))
                                    (GO G191)))
                                  (SEQ (LETT |newExp| (+ |newExp| 1))
                                       (LETT |f|
                                             (SPADCALL |f| BB (QREFELT $ 30)))
                                       (EXIT
                                        (LETT |newMan|
                                              (SPADCALL |f| (QREFELT $ 25)))))
                                  NIL (GO G190) G191 (EXIT NIL))))
                           (EXIT (CONS (* |sign| |newMan|) |newExp|))))))))) 

(SDEFUN |MFLOAT;checkExponent| ((|u| ($)) ($ ($)))
        (SPROG ((|message| (|String|)))
               (SEQ
                (COND
                 ((OR (< (SPADCALL |u| (QREFELT $ 20)) (QREFELT $ 9))
                      (> (SPADCALL |u| (QREFELT $ 20)) (QREFELT $ 10)))
                  (SEQ
                   (LETT |message|
                         (SPADCALL
                          (LIST "Exponent out of range: "
                                (STRINGIMAGE (QREFELT $ 9)) ".."
                                (STRINGIMAGE (QREFELT $ 10)))
                          (QREFELT $ 43)))
                   (EXIT (|error| |message|))))
                 ('T |u|))))) 

(SDEFUN |MFLOAT;coerce;$Of;9| ((|u| ($)) ($ (|OutputForm|)))
        (SPADCALL (SPADCALL |u| (QREFELT $ 44)) (QREFELT $ 46))) 

(SDEFUN |MFLOAT;coerce;Mi$;10| ((|u| (|MachineInteger|)) ($ ($)))
        (|MFLOAT;checkExponent|
         (SPADCALL 0 (SPADCALL |u| (QREFELT $ 49)) 10 (QREFELT $ 40)) $)) 

(SDEFUN |MFLOAT;coerce;$F;11| ((|u| ($)) ($ (|Float|)))
        (SPROG ((|r| (|Float|)) (|oldDigits| (|PositiveInteger|)))
               (SEQ (LETT |oldDigits| (SPADCALL (QREFELT $ 7) (QREFELT $ 51)))
                    (LETT |r|
                          (SPADCALL (SPADCALL |u| (QREFELT $ 14))
                                    (SPADCALL |u| (QREFELT $ 20)) (QREFELT $ 8)
                                    (QREFELT $ 52)))
                    (SPADCALL |oldDigits| (QREFELT $ 51)) (EXIT |r|)))) 

(SDEFUN |MFLOAT;coerce;F$;12| ((|u| (|Float|)) ($ ($)))
        (|MFLOAT;checkExponent|
         (SPADCALL (SPADCALL |u| (QREFELT $ 53)) (SPADCALL |u| (QREFELT $ 54))
                   (SPADCALL (QREFELT $ 55)) (QREFELT $ 40))
         $)) 

(SDEFUN |MFLOAT;coerce;I$;13| ((|u| (|Integer|)) ($ ($)))
        (|MFLOAT;checkExponent| (SPADCALL 0 |u| 10 (QREFELT $ 40)) $)) 

(SDEFUN |MFLOAT;coerce;F$;14| ((|u| (|Fraction| (|Integer|))) ($ ($)))
        (SPADCALL (SPADCALL (SPADCALL |u| (QREFELT $ 58)) (QREFELT $ 57))
                  (SPADCALL (SPADCALL |u| (QREFELT $ 59)) (QREFELT $ 57))
                  (QREFELT $ 60))) 

(SDEFUN |MFLOAT;retract;$F;15| ((|u| ($)) ($ (|Fraction| (|Integer|))))
        (SPROG ((|value| (|Union| (|Fraction| (|Integer|)) "failed")))
               (SEQ (LETT |value| (SPADCALL |u| (QREFELT $ 24)))
                    (EXIT
                     (COND
                      ((QEQCAR |value| 1)
                       (|error| "Cannot retract to a Fraction Integer"))
                      ('T (QCDR |value|))))))) 

(SDEFUN |MFLOAT;retract;$F;16| ((|u| ($)) ($ (|Float|)))
        (SPADCALL |u| (QREFELT $ 44))) 

(SDEFUN |MFLOAT;retractIfCan;$U;17|
        ((|u| ($)) ($ (|Union| (|Float|) "failed")))
        (CONS 0 (SPADCALL |u| (QREFELT $ 44)))) 

(SDEFUN |MFLOAT;retractIfCan;$U;18|
        ((|u| ($)) ($ (|Union| (|Integer|) "failed")))
        (SPROG ((|value| (|Fraction| (|Integer|))))
               (SEQ
                (LETT |value|
                      (SPADCALL (SPADCALL |u| (QREFELT $ 14))
                                (SPADCALL
                                 (SPADCALL (QREFELT $ 8) (QREFELT $ 33))
                                 (SPADCALL |u| (QREFELT $ 20)) (QREFELT $ 21))
                                (QREFELT $ 22)))
                (EXIT
                 (COND
                  ((SPADCALL (SPADCALL |value| (QREFELT $ 66)) (QREFELT $ 37))
                   (CONS 0 (SPADCALL |value| (QREFELT $ 25))))
                  ('T (CONS 1 "failed"))))))) 

(SDEFUN |MFLOAT;retract;$I;19| ((|u| ($)) ($ (|Integer|)))
        (SPROG ((#1=#:G807 NIL) (|result| (|Union| (|Integer|) "failed")))
               (SEQ (LETT |result| (SPADCALL |u| (QREFELT $ 68)))
                    (EXIT
                     (COND
                      ((SPADCALL |result| (CONS 1 "failed") (QREFELT $ 69))
                       (|error| "Not an Integer"))
                      ('T
                       (PROG2 (LETT #1# |result|)
                           (QCDR #1#)
                         (|check_union2| (QEQCAR #1# 0) (|Integer|)
                                         (|Union| (|Integer|) "failed")
                                         #1#)))))))) 

(SDEFUN |MFLOAT;precision;2Pi;20|
        ((|p| (|PositiveInteger|)) ($ (|PositiveInteger|)))
        (SPROG ((|old| (|PositiveInteger|)))
               (SEQ (LETT |old| (QREFELT $ 7))
                    (|MFLOAT;newPower| (QREFELT $ 8) |p| $) (SETELT $ 7 |p|)
                    (EXIT |old|)))) 

(SDEFUN |MFLOAT;precision;Pi;21| (($ (|PositiveInteger|))) (QREFELT $ 7)) 

(SDEFUN |MFLOAT;base;2Pi;22|
        ((|b| (|PositiveInteger|)) ($ (|PositiveInteger|)))
        (SPROG ((|old| (|PositiveInteger|)))
               (SEQ (LETT |old| |b|) (|MFLOAT;newPower| |b| (QREFELT $ 7) $)
                    (SETELT $ 8 |b|) (EXIT |old|)))) 

(SDEFUN |MFLOAT;base;Pi;23| (($ (|PositiveInteger|))) (QREFELT $ 8)) 

(SDEFUN |MFLOAT;maximumExponent;2I;24| ((|u| (|Integer|)) ($ (|Integer|)))
        (SPROG ((|old| (|Integer|)))
               (SEQ (LETT |old| (QREFELT $ 10)) (SETELT $ 10 |u|)
                    (EXIT |old|)))) 

(SDEFUN |MFLOAT;maximumExponent;I;25| (($ (|Integer|))) (QREFELT $ 10)) 

(SDEFUN |MFLOAT;minimumExponent;2I;26| ((|u| (|Integer|)) ($ (|Integer|)))
        (SPROG ((|old| (|Integer|)))
               (SEQ (LETT |old| (QREFELT $ 9)) (SETELT $ 9 |u|) (EXIT |old|)))) 

(SDEFUN |MFLOAT;minimumExponent;I;27| (($ (|Integer|))) (QREFELT $ 9)) 

(PUT '|MFLOAT;Zero;$;28| '|SPADreplace| '(XLAM NIL (CONS 0 0))) 

(SDEFUN |MFLOAT;Zero;$;28| (($ ($))) (CONS 0 0)) 

(SDEFUN |MFLOAT;One;$;29| (($ ($))) (SPADCALL 0 1 10 (QREFELT $ 40))) 

(SDEFUN |MFLOAT;zero?;$B;30| ((|u| ($)) ($ (|Boolean|)))
        (SPADCALL |u| (CONS 0 0) (QREFELT $ 79))) 

(SDEFUN |MFLOAT;locRound| ((|x| (|Fraction| (|Integer|))) ($ (|Integer|)))
        (COND
         ((SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 66)) (QREFELT $ 35))
                    (SPADCALL 1 2 (QREFELT $ 19)) (QREFELT $ 81))
          (+ (SPADCALL |x| (QREFELT $ 25)) (SPADCALL |x| (QREFELT $ 34))))
         ('T (SPADCALL |x| (QREFELT $ 25))))) 

(SDEFUN |MFLOAT;recip;$U;32| ((|f1| ($)) ($ (|Union| $ "failed")))
        (COND ((SPADCALL |f1| (QREFELT $ 80)) (CONS 1 "failed"))
              ('T
               (CONS 0
                     (|MFLOAT;normalise|
                      (CONS
                       (|MFLOAT;locRound|
                        (SPADCALL (EXPT (QREFELT $ 8) (* 2 (QREFELT $ 11)))
                                  (SPADCALL |f1| (QREFELT $ 14))
                                  (QREFELT $ 19))
                        $)
                       (-
                        (+ (SPADCALL |f1| (QREFELT $ 20))
                           (* 2 (QREFELT $ 11)))))
                      $))))) 

(SDEFUN |MFLOAT;*;3$;33| ((|f1| ($)) (|f2| ($)) ($ ($)))
        (|MFLOAT;normalise|
         (CONS
          (* (SPADCALL |f1| (QREFELT $ 14)) (SPADCALL |f2| (QREFELT $ 14)))
          (+ (SPADCALL |f1| (QREFELT $ 20)) (SPADCALL |f2| (QREFELT $ 20))))
         $)) 

(SDEFUN |MFLOAT;^;$F$;34| ((|f1| ($)) (|p| (|Fraction| (|Integer|))) ($ ($)))
        (SPADCALL (SPADCALL (SPADCALL |f1| (QREFELT $ 44)) |p| (QREFELT $ 85))
                  (QREFELT $ 56))) 

(SDEFUN |MFLOAT;/;3$;35| ((|f1| ($)) (|f2| ($)) ($ ($)))
        (COND ((SPADCALL |f2| (QREFELT $ 80)) (|error| "division by zero"))
              ((SPADCALL |f1| (QREFELT $ 80)) (|spadConstant| $ 28))
              ((SPADCALL |f1| |f2| (QREFELT $ 79)) (|spadConstant| $ 15))
              ('T
               (|MFLOAT;normalise|
                (CONS
                 (|MFLOAT;locRound|
                  (SPADCALL
                   (* (SPADCALL |f1| (QREFELT $ 14))
                      (EXPT (QREFELT $ 8) (* 2 (QREFELT $ 11))))
                   (SPADCALL |f2| (QREFELT $ 14)) (QREFELT $ 19))
                  $)
                 (- (SPADCALL |f1| (QREFELT $ 20))
                    (+ (SPADCALL |f2| (QREFELT $ 20)) (* 2 (QREFELT $ 11)))))
                $)))) 

(SDEFUN |MFLOAT;inv;2$;36| ((|f1| ($)) ($ ($)))
        (SPADCALL (|spadConstant| $ 15) |f1| (QREFELT $ 60))) 

(SDEFUN |MFLOAT;exquo;2$U;37| ((|f1| ($)) (|f2| ($)) ($ (|Union| $ "failed")))
        (CONS 0 (SPADCALL |f1| |f2| (QREFELT $ 60)))) 

(SDEFUN |MFLOAT;divide;2$R;38|
        ((|f1| ($)) (|f2| ($))
         ($ (|Record| (|:| |quotient| $) (|:| |remainder| $))))
        (CONS (SPADCALL |f1| |f2| (QREFELT $ 60)) (|spadConstant| $ 28))) 

(SDEFUN |MFLOAT;quo;3$;39| ((|f1| ($)) (|f2| ($)) ($ ($)))
        (SPADCALL |f1| |f2| (QREFELT $ 60))) 

(SDEFUN |MFLOAT;rem;3$;40| ((|f1| ($)) (|f2| ($)) ($ ($)))
        (|spadConstant| $ 28)) 

(SDEFUN |MFLOAT;*;I2$;41| ((|u| (|Integer|)) (|f1| ($)) ($ ($)))
        (|MFLOAT;normalise|
         (CONS (* |u| (SPADCALL |f1| (QREFELT $ 14)))
               (SPADCALL |f1| (QREFELT $ 20)))
         $)) 

(SDEFUN |MFLOAT;=;2$B;42| ((|f1| ($)) (|f2| ($)) ($ (|Boolean|)))
        (COND
         ((EQL (SPADCALL |f1| (QREFELT $ 14)) (SPADCALL |f2| (QREFELT $ 14)))
          (EQL (SPADCALL |f1| (QREFELT $ 20)) (SPADCALL |f2| (QREFELT $ 20))))
         ('T NIL))) 

(SDEFUN |MFLOAT;+;3$;43| ((|f1| ($)) (|f2| ($)) ($ ($)))
        (SPROG
         ((|e2| #1=(|Integer|)) (|e1| #1#) (|m2| #2=(|Integer|)) (|m1| #2#))
         (SEQ (LETT |m1| (SPADCALL |f1| (QREFELT $ 14)))
              (LETT |m2| (SPADCALL |f2| (QREFELT $ 14)))
              (LETT |e1| (SPADCALL |f1| (QREFELT $ 20)))
              (LETT |e2| (SPADCALL |f2| (QREFELT $ 20)))
              (EXIT
               (COND
                ((> |e1| |e2|)
                 (COND
                  ((> |e1| (+ (+ |e2| (QREFELT $ 11)) 2))
                   (COND ((SPADCALL |f1| (QREFELT $ 80)) |f2|) (#3='T |f1|)))
                  (#3#
                   (|MFLOAT;normalise|
                    (CONS (+ (* |m1| (EXPT (QREFELT $ 8) (- |e1| |e2|))) |m2|)
                          |e2|)
                    $))))
                ((> |e2| (+ (+ |e1| (QREFELT $ 11)) 2))
                 (COND ((SPADCALL |f2| (QREFELT $ 80)) |f1|) (#3# |f2|)))
                (#3#
                 (|MFLOAT;normalise|
                  (CONS (+ (* |m2| (EXPT (QREFELT $ 8) (- |e2| |e1|))) |m1|)
                        |e1|)
                  $))))))) 

(SDEFUN |MFLOAT;-;2$;44| ((|f1| ($)) ($ ($)))
        (CONS (- (SPADCALL |f1| (QREFELT $ 14)))
              (SPADCALL |f1| (QREFELT $ 20)))) 

(SDEFUN |MFLOAT;-;3$;45| ((|f1| ($)) (|f2| ($)) ($ ($)))
        (SPADCALL |f1| (SPADCALL |f2| (QREFELT $ 95)) (QREFELT $ 94))) 

(SDEFUN |MFLOAT;<;2$B;46| ((|f1| ($)) (|f2| ($)) ($ (|Boolean|)))
        (SPROG
         ((|e2| #1=(|Integer|)) (|e1| #1#) (|m2| #2=(|Integer|)) (|m1| #2#))
         (SEQ (LETT |m1| (SPADCALL |f1| (QREFELT $ 14)))
              (LETT |m2| (SPADCALL |f2| (QREFELT $ 14)))
              (LETT |e1| (SPADCALL |f1| (QREFELT $ 20)))
              (LETT |e2| (SPADCALL |f2| (QREFELT $ 20)))
              (EXIT
               (COND
                ((EQL (SPADCALL |m1| (QREFELT $ 27))
                      (SPADCALL |m2| (QREFELT $ 27)))
                 (COND ((< |e1| |e2|) 'T)
                       (#3='T
                        (SEQ
                         (COND
                          ((EQL |e1| |e2|) (COND ((< |m1| |m2|) (EXIT 'T)))))
                         (EXIT NIL)))))
                ((EQL (SPADCALL |m1| (QREFELT $ 27)) 1) NIL)
                (#3#
                 (SEQ
                  (COND
                   ((EQL (SPADCALL |m1| (QREFELT $ 27)) 0)
                    (COND
                     ((EQL (SPADCALL |m2| (QREFELT $ 27)) -1) (EXIT NIL)))))
                  (EXIT 'T)))))))) 

(PUT '|MFLOAT;characteristic;Nni;47| '|SPADreplace| '(XLAM NIL 0)) 

(SDEFUN |MFLOAT;characteristic;Nni;47| (($ (|NonNegativeInteger|))) 0) 

(DECLAIM (NOTINLINE |MachineFloat;|)) 

(DEFUN |MachineFloat| ()
  (SPROG NIL
         (PROG (#1=#:G902)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|MachineFloat|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|MachineFloat|
                             (LIST (CONS NIL (CONS 1 (|MachineFloat;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#) (HREM |$ConstructorCache| '|MachineFloat|)))))))))) 

(DEFUN |MachineFloat;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|MachineFloat|))
          (LETT $ (GETREFV 114))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|MachineFloat| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (AND (|HasCategory| $ '(|arbitraryPrecision|))
               (|augmentPredVector| $ 1))
          (AND (|not| (|HasCategory| $ '(|arbitraryExponent|)))
               (|not| (|HasCategory| $ '(|arbitraryPrecision|)))
               (|augmentPredVector| $ 2))
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6
                    (|Record| (|:| |mantissa| (|Integer|))
                              (|:| |exponent| (|Integer|))))
          (QSETREFV $ 7 16)
          (QSETREFV $ 8 2)
          (QSETREFV $ 9 -1021)
          (QSETREFV $ 10 1024)
          (QSETREFV $ 11 53)
          (QSETREFV $ 12 (EXPT (QREFELT $ 8) (QREFELT $ 11)))
          $))) 

(MAKEPROP '|MachineFloat| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|Rep| 'P 'B 'EMIN 'EMAX 'POWER 'MMAX
              (|Integer|) |MFLOAT;mantissa;$I;4|
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |MFLOAT;One;$;29|) $))
              (|Float|) (0 . |One|) (|Fraction| 13) (4 . /)
              |MFLOAT;exponent;$I;5| (10 . ^) (16 . *) (|Union| 18 '"failed")
              |MFLOAT;retractIfCan;$U;1| (22 . |wholePart|)
              |MFLOAT;wholePart;$I;2| (27 . |sign|)
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |MFLOAT;Zero;$;28|) $))
              (32 . |Zero|) (36 . /) (|Void|) (42 . |void|) (46 . |coerce|)
              (51 . |sign|) (56 . |abs|) (|Boolean|) (61 . |zero?|) (66 . *)
              (|PositiveInteger|) |MFLOAT;changeBase;2IPi$;7| (|List| $)
              (|String|) (72 . |concat|) |MFLOAT;coerce;$F;11| (|OutputForm|)
              (77 . |coerce|) |MFLOAT;coerce;$Of;9| (|MachineInteger|)
              (82 . |retract|) |MFLOAT;coerce;Mi$;10| (87 . |digits|)
              (92 . |float|) (99 . |exponent|) (104 . |mantissa|)
              (109 . |base|) |MFLOAT;coerce;F$;12| |MFLOAT;coerce;I$;13|
              (113 . |numer|) (118 . |denom|) |MFLOAT;/;3$;35|
              |MFLOAT;coerce;F$;14| |MFLOAT;retract;$F;15|
              |MFLOAT;retract;$F;16| (|Union| 16 '"failed")
              |MFLOAT;retractIfCan;$U;17| (123 . |fractionPart|)
              (|Union| 13 '"failed") |MFLOAT;retractIfCan;$U;18| (128 . =)
              |MFLOAT;retract;$I;19| |MFLOAT;precision;2Pi;20|
              |MFLOAT;precision;Pi;21| |MFLOAT;base;2Pi;22| |MFLOAT;base;Pi;23|
              |MFLOAT;maximumExponent;2I;24| |MFLOAT;maximumExponent;I;25|
              |MFLOAT;minimumExponent;2I;26| |MFLOAT;minimumExponent;I;27|
              |MFLOAT;=;2$B;42| |MFLOAT;zero?;$B;30| (134 . >=)
              (|Union| $ '"failed") |MFLOAT;recip;$U;32| |MFLOAT;*;3$;33|
              (140 . ^) |MFLOAT;^;$F$;34| |MFLOAT;inv;2$;36|
              |MFLOAT;exquo;2$U;37|
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              |MFLOAT;divide;2$R;38| |MFLOAT;quo;3$;39| |MFLOAT;rem;3$;40|
              |MFLOAT;*;I2$;41| |MFLOAT;+;3$;43| |MFLOAT;-;2$;44|
              |MFLOAT;-;3$;45| |MFLOAT;<;2$B;46| (|NonNegativeInteger|)
              |MFLOAT;characteristic;Nni;47| (|Pattern| 16)
              (|PatternMatchResult| 16 $) (|DoubleFloat|) (|Factored| $)
              (|Record| (|:| |coef1| $) (|:| |coef2| $))
              (|Union| 104 '#1="failed") (|Union| 41 '#1#)
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (|Record| (|:| |coef| 41) (|:| |generator| $))
              (|SparseUnivariatePolynomial| $)
              (|Record| (|:| |llcm_res| $) (|:| |coeff1| $) (|:| |coeff2| $))
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|SingleInteger|) (|HashState|))
           '#(~= 146 |zero?| 152 |wholePart| 157 |unitNormal| 162
              |unitCanonical| 167 |unit?| 172 |truncate| 177 |toString| 182
              |subtractIfCan| 193 |squareFreePart| 199 |squareFree| 204 |sqrt|
              209 |smaller?| 214 |sizeLess?| 220 |sign| 226 |sample| 231
              |round| 235 |rightRecip| 240 |rightPower| 245 |retractIfCan| 257
              |retract| 272 |rem| 287 |recip| 293 |quo| 298 |principalIdeal|
              304 |prime?| 309 |precision| 314 |positive?| 323 |patternMatch|
              328 |order| 335 |opposite?| 340 |one?| 346 |nthRoot| 351 |norm|
              357 |negative?| 362 |multiEuclidean| 367 |minimumExponent| 373
              |min| 382 |maximumExponent| 392 |max| 401 |mantissa| 411
              |leftRecip| 416 |leftPower| 421 |lcmCoef| 433 |lcm| 439 |latex|
              450 |inv| 455 |increasePrecision| 460 |hashUpdate!| 465 |hash|
              471 |gcdPolynomial| 476 |gcd| 482 |fractionPart| 493 |floor| 498
              |float| 503 |factor| 516 |extendedEuclidean| 521 |exquo| 534
              |expressIdealMember| 540 |exponent| 546 |euclideanSize| 551
              |divide| 556 |digits| 562 |decreasePrecision| 571 |convert| 576
              |commutator| 596 |coerce| 602 |characteristic| 637 |changeBase|
              641 |ceiling| 648 |bits| 653 |base| 662 |associator| 671
              |associates?| 678 |antiCommutator| 684 |annihilate?| 690 |abs|
              696 ^ 701 |Zero| 725 |One| 729 >= 733 > 739 = 745 <= 751 < 757 /
              763 - 775 + 786 * 792)
           'NIL
           (CONS
            (|makeByteWordVec2| 1
                                '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                  0 0))
            (CONS
             '#(|FloatingPointSystem&| |RealNumberSystem&| |Field&|
                |EuclideanDomain&| NIL |UniqueFactorizationDomain&| NIL
                |GcdDomain&| NIL |OrderedRing&| |DivisionRing&| NIL NIL NIL
                |Algebra&| |EntireRing&| |Algebra&| NIL |Rng&| NIL |Module&|
                |Module&| NIL NIL NIL NIL |NonAssociativeRing&| NIL NIL NIL NIL
                |NonAssociativeRng&| NIL NIL |AbelianGroup&| NIL NIL NIL NIL
                |OrderedSet&| NIL |MagmaWithUnit&| |NonAssociativeSemiRng&|
                |AbelianMonoid&| NIL NIL |Magma&| |AbelianSemiGroup&|
                |RetractableTo&| |RetractableTo&| |RetractableTo&| NIL NIL
                |SetCategory&| NIL NIL NIL NIL |RadicalCategory&| NIL NIL NIL
                NIL |PartialOrder&| NIL NIL NIL NIL NIL |BasicType&| NIL)
             (CONS
              '#((|FloatingPointSystem|) (|RealNumberSystem|) (|Field|)
                 (|EuclideanDomain|) (|PrincipalIdealDomain|)
                 (|UniqueFactorizationDomain|) (|FortranMachineTypeCategory|)
                 (|GcdDomain|) (|IntegralDomain|) (|OrderedRing|)
                 (|DivisionRing|) (|CommutativeRing|) (|LeftOreRing|)
                 (|CharacteristicZero|) (|Algebra| 18) (|EntireRing|)
                 (|Algebra| $$) (|Ring|) (|Rng|) (|SemiRing|) (|Module| 18)
                 (|Module| $$) (|SemiRng|) (|OrderedAbelianGroup|)
                 (|BiModule| 18 18) (|BiModule| $$ $$) (|NonAssociativeRing|)
                 (|OrderedCancellationAbelianMonoid|) (|RightModule| 18)
                 (|LeftModule| 18) (|LeftModule| $$) (|NonAssociativeRng|)
                 (|RightModule| $$) (|OrderedAbelianMonoid|) (|AbelianGroup|)
                 (|OrderedAbelianSemiGroup|) (|Monoid|)
                 (|NonAssociativeSemiRing|) (|CancellationAbelianMonoid|)
                 (|OrderedSet|) (|SemiGroup|) (|MagmaWithUnit|)
                 (|NonAssociativeSemiRng|) (|AbelianMonoid|)
                 (|PatternMatchable| 16) (|Comparable|) (|Magma|)
                 (|AbelianSemiGroup|) (|RetractableTo| 16) (|RetractableTo| 18)
                 (|RetractableTo| 13) (|RealConstant|) (|CommutativeStar|)
                 (|SetCategory|) (|CoercibleFrom| 16) (|ConvertibleTo| 42)
                 (|Approximate|) (|ConvertibleTo| 100) (|RadicalCategory|)
                 (|CoercibleFrom| 18) (|CoercibleFrom| 13) (|ConvertibleTo| 16)
                 (|ConvertibleTo| 102) (|PartialOrder|) (|canonicalsClosed|)
                 (|canonicalUnitNormal|) (|noZeroDivisors|) (|TwoSidedRecip|)
                 (|unitsKnown|) (|BasicType|) (|CoercibleTo| 45))
              (|makeByteWordVec2| 113
                                  '(0 16 0 17 2 18 0 13 13 19 2 18 0 0 13 21 2
                                    18 0 13 0 22 1 18 13 0 25 1 13 13 0 27 0 16
                                    0 29 2 18 0 0 0 30 0 31 0 32 1 18 0 13 33 1
                                    18 13 0 34 1 18 0 0 35 1 18 36 0 37 2 18 0
                                    0 18 38 1 42 0 41 43 1 16 45 0 46 1 48 13 0
                                    49 1 16 39 39 51 3 16 0 13 13 39 52 1 16 13
                                    0 53 1 16 13 0 54 0 16 39 55 1 18 13 0 58 1
                                    18 13 0 59 1 18 0 0 66 2 67 36 0 0 69 2 18
                                    36 0 0 81 2 16 0 0 18 85 2 0 36 0 0 1 1 0
                                    36 0 80 1 0 13 0 26 1 0 111 0 1 1 0 0 0 1 1
                                    0 36 0 1 1 0 0 0 1 2 0 42 0 98 1 1 0 42 0 1
                                    2 0 82 0 0 1 1 0 0 0 1 1 0 103 0 1 1 0 0 0
                                    1 2 0 36 0 0 1 2 0 36 0 0 1 1 0 13 0 1 0 0
                                    0 1 1 0 0 0 1 1 0 82 0 1 2 0 0 0 98 1 2 0 0
                                    0 39 1 1 0 64 0 65 1 0 23 0 24 1 0 67 0 68
                                    1 0 16 0 63 1 0 18 0 62 1 0 13 0 70 2 0 0 0
                                    0 92 1 0 82 0 83 2 0 0 0 0 91 1 0 108 41 1
                                    1 0 36 0 1 1 0 39 39 71 0 0 39 72 1 0 36 0
                                    1 3 0 101 0 100 101 1 1 0 13 0 1 2 0 36 0 0
                                    1 1 0 36 0 1 2 0 0 0 13 1 1 0 0 0 1 1 0 36
                                    0 1 2 0 106 41 0 1 0 0 13 78 1 0 13 13 77 0
                                    2 0 1 2 0 0 0 0 1 0 0 13 76 1 0 13 13 75 0
                                    2 0 1 2 0 0 0 0 1 1 0 13 0 14 1 0 82 0 1 2
                                    0 0 0 98 1 2 0 0 0 39 1 2 0 110 0 0 1 1 0 0
                                    41 1 2 0 0 0 0 1 1 0 42 0 1 1 0 0 0 87 1 1
                                    39 13 1 2 0 113 113 0 1 1 0 112 0 1 2 0 109
                                    109 109 1 1 0 0 41 1 2 0 0 0 0 1 1 0 0 0 1
                                    1 0 0 0 1 3 0 0 13 13 39 1 2 0 0 13 13 1 1
                                    0 103 0 1 3 0 105 0 0 0 1 2 0 107 0 0 1 2 0
                                    82 0 0 88 2 0 106 41 0 1 1 0 13 0 20 1 0 98
                                    0 1 2 0 89 0 0 90 1 1 39 39 1 0 0 39 1 1 1
                                    39 13 1 1 0 42 0 1 1 0 100 0 1 1 0 102 0 1
                                    1 0 16 0 1 2 0 0 0 0 1 1 0 0 48 50 1 0 16 0
                                    44 1 0 0 16 56 1 0 0 18 61 1 0 0 13 57 1 0
                                    0 0 1 1 0 45 0 47 0 0 98 99 3 0 0 13 13 39
                                    40 1 0 0 0 1 1 1 39 39 1 0 0 39 1 1 0 39 39
                                    73 0 0 39 74 3 0 0 0 0 0 1 2 0 36 0 0 1 2 0
                                    0 0 0 1 2 0 36 0 0 1 1 0 0 0 1 2 0 0 0 18
                                    86 2 0 0 0 13 1 2 0 0 0 98 1 2 0 0 0 39 1 0
                                    0 0 28 0 0 0 15 2 0 36 0 0 1 2 0 36 0 0 1 2
                                    0 36 0 0 79 2 0 36 0 0 1 2 0 36 0 0 97 2 0
                                    0 0 13 1 2 0 0 0 0 60 1 0 0 0 95 2 0 0 0 0
                                    96 2 0 0 0 0 94 2 0 0 0 18 1 2 0 0 18 0 1 2
                                    0 0 98 0 1 2 0 0 13 0 93 2 0 0 0 0 84 2 0 0
                                    39 0 1)))))
           '|lookupComplete|)) 

(MAKEPROP '|MachineFloat| 'NILADIC T) 
