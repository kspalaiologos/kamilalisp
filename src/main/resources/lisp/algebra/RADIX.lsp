
(PUT '|RADIX;characteristic;Nni;1| '|SPADreplace| '(XLAM NIL 0)) 

(SDEFUN |RADIX;characteristic;Nni;1| (($ (|NonNegativeInteger|))) 0) 

(SDEFUN |RADIX;differentiate;2$;2| ((|a| ($)) ($ ($))) (|spadConstant| $ 10)) 

(PUT '|RADIX;Zero;$;3| '|SPADreplace| '(XLAM NIL (VECTOR 1 NIL NIL NIL))) 

(SDEFUN |RADIX;Zero;$;3| (($ ($))) (VECTOR 1 NIL NIL NIL)) 

(SDEFUN |RADIX;One;$;4| (($ ($))) (VECTOR 1 (LIST 1) NIL NIL)) 

(SDEFUN |RADIX;-;2$;5| ((|a| ($)) ($ ($)))
        (COND
         ((SPADCALL |a| (|spadConstant| $ 10) (QREFELT $ 14))
          (|spadConstant| $ 10))
         ('T
          (VECTOR (- (QVELT |a| 0)) (QVELT |a| 1) (QVELT |a| 2)
                  (QVELT |a| 3))))) 

(SDEFUN |RADIX;+;3$;6| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL
         (SPADCALL (SPADCALL |a| (QREFELT $ 17)) (SPADCALL |b| (QREFELT $ 17))
                   (QREFELT $ 18))
         (QREFELT $ 19))) 

(SDEFUN |RADIX;-;3$;7| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL
         (SPADCALL (SPADCALL |a| (QREFELT $ 17)) (SPADCALL |b| (QREFELT $ 17))
                   (QREFELT $ 21))
         (QREFELT $ 19))) 

(SDEFUN |RADIX;*;I2$;8| ((|n| (|Integer|)) (|a| ($)) ($ ($)))
        (SPADCALL (SPADCALL |n| (SPADCALL |a| (QREFELT $ 17)) (QREFELT $ 24))
                  (QREFELT $ 19))) 

(SDEFUN |RADIX;*;3$;9| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL
         (SPADCALL (SPADCALL |a| (QREFELT $ 17)) (SPADCALL |b| (QREFELT $ 17))
                   (QREFELT $ 26))
         (QREFELT $ 19))) 

(SDEFUN |RADIX;/;3$;10| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL
         (SPADCALL (SPADCALL |a| (QREFELT $ 17)) (SPADCALL |b| (QREFELT $ 17))
                   (QREFELT $ 28))
         (QREFELT $ 19))) 

(SDEFUN |RADIX;/;2I$;11| ((|i| #1=(|Integer|)) (|j| #1#) ($ ($)))
        (SPADCALL (SPADCALL |i| |j| (QREFELT $ 30)) (QREFELT $ 19))) 

(SDEFUN |RADIX;<;2$B;12| ((|a| ($)) (|b| ($)) ($ (|Boolean|)))
        (SPADCALL (SPADCALL |a| (QREFELT $ 17)) (SPADCALL |b| (QREFELT $ 17))
                  (QREFELT $ 32))) 

(SDEFUN |RADIX;=;2$B;13| ((|a| ($)) (|b| ($)) ($ (|Boolean|)))
        (COND
         ((EQL (QVELT |a| 0) (QVELT |b| 0))
          (COND
           ((SPADCALL (QVELT |a| 1) (QVELT |b| 1) (QREFELT $ 35))
            (COND
             ((SPADCALL (QVELT |a| 2) (QVELT |b| 2) (QREFELT $ 35))
              (SPADCALL (QVELT |a| 3) (QVELT |b| 3) (QREFELT $ 35)))
             (#1='T NIL)))
           (#1# NIL)))
         (#1# NIL))) 

(SDEFUN |RADIX;numer;$I;14| ((|a| ($)) ($ (|Integer|)))
        (SPADCALL (SPADCALL |a| (QREFELT $ 17)) (QREFELT $ 36))) 

(SDEFUN |RADIX;denom;$I;15| ((|a| ($)) ($ (|Integer|)))
        (SPADCALL (SPADCALL |a| (QREFELT $ 17)) (QREFELT $ 38))) 

(SDEFUN |RADIX;coerce;$F;16| ((|a| ($)) ($ (|Fraction| (|Integer|))))
        (SPADCALL (SPADCALL (SPADCALL |a| (QREFELT $ 40)) (QREFELT $ 41))
                  (SPADCALL |a| (QREFELT $ 42)) (QREFELT $ 18))) 

(SDEFUN |RADIX;coerce;I$;17| ((|n| (|Integer|)) ($ ($)))
        (SPADCALL (SPADCALL |n| (QREFELT $ 41)) (QREFELT $ 19))) 

(SDEFUN |RADIX;coerce;F$;18| ((|q| (|Fraction| (|Integer|))) ($ ($)))
        (SPROG
         ((|cycle| #1=(|List| (|Integer|)))
          (|fractn|
           (|Record| (|:| |pfx| (|List| (|Integer|))) (|:| |cyc| #1#)))
          (|whole| (|List| (|Integer|)))
          (|qr|
           (|Record| (|:| |quotient| (|Integer|))
                     (|:| |remainder| (|Integer|))))
          (|s| (|Integer|)))
         (SEQ (LETT |s| 1)
              (COND
               ((SPADCALL |q| (|spadConstant| $ 44) (QREFELT $ 32))
                (SEQ (LETT |s| -1)
                     (EXIT (LETT |q| (SPADCALL |q| (QREFELT $ 45)))))))
              (LETT |qr|
                    (DIVIDE2 (SPADCALL |q| (QREFELT $ 36))
                             (SPADCALL |q| (QREFELT $ 38))))
              (LETT |whole| (|RADIX;radixInt| (QCAR |qr|) (QREFELT $ 6) $))
              (LETT |fractn|
                    (|RADIX;radixFrac| (QCDR |qr|)
                     (SPADCALL |q| (QREFELT $ 38)) (QREFELT $ 6) $))
              (LETT |cycle|
                    (COND
                     ((SPADCALL (QCDR |fractn|) (LIST 0) (QREFELT $ 35)) NIL)
                     ('T (QCDR |fractn|))))
              (EXIT (VECTOR |s| |whole| (QCAR |fractn|) |cycle|))))) 

(SDEFUN |RADIX;retractIfCan;$U;19|
        ((|a| ($)) ($ (|Union| (|Fraction| (|Integer|)) "failed")))
        (CONS 0 (SPADCALL |a| (QREFELT $ 17)))) 

(SDEFUN |RADIX;retractIfCan;$U;20|
        ((|a| ($)) ($ (|Union| (|Integer|) "failed")))
        (SEQ
         (COND
          ((NULL (QVELT |a| 2))
           (COND
            ((NULL (QVELT |a| 3))
             (EXIT (CONS 0 (SPADCALL |a| (QREFELT $ 40))))))))
         (EXIT (CONS 1 "failed")))) 

(SDEFUN |RADIX;ceiling;$I;21| ((|a| ($)) ($ (|Integer|)))
        (SPADCALL (SPADCALL |a| (QREFELT $ 17)) (QREFELT $ 50))) 

(SDEFUN |RADIX;floor;$I;22| ((|a| ($)) ($ (|Integer|)))
        (SPADCALL (SPADCALL |a| (QREFELT $ 17)) (QREFELT $ 52))) 

(SDEFUN |RADIX;wholePart;$I;23| ((|a| ($)) ($ (|Integer|)))
        (SPROG ((|n0| (|Integer|)) (#1=#:G783 NIL) (|r| NIL))
               (SEQ (LETT |n0| 0)
                    (SEQ (LETT |r| NIL) (LETT #1# (QVELT |a| 1)) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |r| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT (LETT |n0| (+ (* (QREFELT $ 6) |n0|) |r|))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT (* (QVELT |a| 0) |n0|))))) 

(SDEFUN |RADIX;fractionPart;$F;24| ((|a| ($)) ($ (|Fraction| (|Integer|))))
        (SPROG
         ((|d| (|Integer|)) (|n| (|Integer|)) (|n1| (|Integer|))
          (#1=#:G792 NIL) (|r| NIL) (|n0| (|Integer|)) (#2=#:G791 NIL))
         (SEQ (LETT |n0| 0)
              (SEQ (LETT |r| NIL) (LETT #2# (QVELT |a| 2)) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |r| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ (EXIT (LETT |n0| (+ (* (QREFELT $ 6) |n0|) |r|))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (COND
                ((NULL (QVELT |a| 3))
                 (SPADCALL (* (QVELT |a| 0) |n0|)
                           (EXPT (QREFELT $ 6) (LENGTH (QVELT |a| 2)))
                           (QREFELT $ 30)))
                ('T
                 (SEQ (LETT |n1| |n0|)
                      (SEQ (LETT |r| NIL) (LETT #1# (QVELT |a| 3)) G190
                           (COND
                            ((OR (ATOM #1#) (PROGN (LETT |r| (CAR #1#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT (LETT |n1| (+ (* (QREFELT $ 6) |n1|) |r|))))
                           (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                      (LETT |n| (- |n1| |n0|))
                      (LETT |d|
                            (*
                             (- (EXPT (QREFELT $ 6) (LENGTH (QVELT |a| 3))) 1)
                             (EXPT (QREFELT $ 6) (LENGTH (QVELT |a| 2)))))
                      (EXIT
                       (SPADCALL (* (QVELT |a| 0) |n|) |d|
                                 (QREFELT $ 30)))))))))) 

(PUT '|RADIX;wholeRagits;$L;25| '|SPADreplace| '(XLAM (|a|) (QVELT |a| 1))) 

(SDEFUN |RADIX;wholeRagits;$L;25| ((|a| ($)) ($ (|List| (|Integer|))))
        (QVELT |a| 1)) 

(SDEFUN |RADIX;fractRagits;$S;26| ((|a| ($)) ($ (|Stream| (|Integer|))))
        (SPADCALL (SPADCALL (QVELT |a| 2) (QREFELT $ 56))
                  (SPADCALL (QVELT |a| 3) (QREFELT $ 57)) (QREFELT $ 58))) 

(PUT '|RADIX;prefixRagits;$L;27| '|SPADreplace| '(XLAM (|a|) (QVELT |a| 2))) 

(SDEFUN |RADIX;prefixRagits;$L;27| ((|a| ($)) ($ (|List| (|Integer|))))
        (QVELT |a| 2)) 

(PUT '|RADIX;cycleRagits;$L;28| '|SPADreplace| '(XLAM (|a|) (QVELT |a| 3))) 

(SDEFUN |RADIX;cycleRagits;$L;28| ((|a| ($)) ($ (|List| (|Integer|))))
        (QVELT |a| 3)) 

(SDEFUN |RADIX;wholeRadix;L$;29| ((|li| (|List| (|Integer|))) ($ ($)))
        (SEQ (|RADIX;checkRagits| |li| $) (EXIT (VECTOR 1 |li| NIL NIL)))) 

(SDEFUN |RADIX;fractRadix;2L$;30|
        ((|lpfx| (|List| (|Integer|))) (|lcyc| (|List| (|Integer|))) ($ ($)))
        (SEQ (|RADIX;checkRagits| |lpfx| $) (|RADIX;checkRagits| |lcyc| $)
             (EXIT (VECTOR 1 NIL |lpfx| |lcyc|)))) 

(SDEFUN |RADIX;intToExpr| ((|i| (|Integer|)) ($ (|OutputForm|)))
        (COND ((< |i| 10) (SPADCALL |i| (QREFELT $ 66)))
              ('T
               (SPADCALL
                (SPADCALL (QREFELT $ 64)
                          (+ (- |i| 10)
                             (SPADCALL (QREFELT $ 64) (QREFELT $ 68)))
                          (QREFELT $ 70))
                (QREFELT $ 71))))) 

(SDEFUN |RADIX;exprgroup| ((|le| (|List| (|OutputForm|))) ($ (|OutputForm|)))
        (COND ((NULL |le|) (|error| "exprgroup needs non-null list"))
              ((NULL (CDR |le|)) (|SPADfirst| |le|))
              ((<= (ABS (QREFELT $ 6)) 36) (SPADCALL |le| (QREFELT $ 73)))
              ('T (SPADCALL |le| (QREFELT $ 74))))) 

(SDEFUN |RADIX;intgroup| ((|li| (|List| (|Integer|))) ($ (|OutputForm|)))
        (SPROG
         ((#1=#:G825 NIL) (|i| NIL) (#2=#:G824 NIL) (#3=#:G823 NIL)
          (#4=#:G822 NIL) (#5=#:G821 NIL) (#6=#:G820 NIL))
         (SEQ
          (COND ((NULL |li|) (|error| "intgroup needs non-null list"))
                ((NULL (CDR |li|))
                 (COND
                  ((<= (ABS (QREFELT $ 6)) 36)
                   (|RADIX;intToExpr| (|SPADfirst| |li|) $))
                  (#7='T (SPADCALL (|SPADfirst| |li|) (QREFELT $ 66)))))
                ((<= (ABS (QREFELT $ 6)) 10)
                 (SPADCALL
                  (PROGN
                   (LETT #6# NIL)
                   (SEQ (LETT |i| NIL) (LETT #5# |li|) G190
                        (COND
                         ((OR (ATOM #5#) (PROGN (LETT |i| (CAR #5#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT #6# (CONS (SPADCALL |i| (QREFELT $ 66)) #6#))))
                        (LETT #5# (CDR #5#)) (GO G190) G191
                        (EXIT (NREVERSE #6#))))
                  (QREFELT $ 73)))
                ((<= (ABS (QREFELT $ 6)) 36)
                 (SPADCALL
                  (PROGN
                   (LETT #4# NIL)
                   (SEQ (LETT |i| NIL) (LETT #3# |li|) G190
                        (COND
                         ((OR (ATOM #3#) (PROGN (LETT |i| (CAR #3#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT #4# (CONS (|RADIX;intToExpr| |i| $) #4#))))
                        (LETT #3# (CDR #3#)) (GO G190) G191
                        (EXIT (NREVERSE #4#))))
                  (QREFELT $ 73)))
                (#7#
                 (SPADCALL
                  (PROGN
                   (LETT #2# NIL)
                   (SEQ (LETT |i| NIL) (LETT #1# |li|) G190
                        (COND
                         ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT #2# (CONS (SPADCALL |i| (QREFELT $ 66)) #2#))))
                        (LETT #1# (CDR #1#)) (GO G190) G191
                        (EXIT (NREVERSE #2#))))
                  (QREFELT $ 74))))))) 

(SDEFUN |RADIX;overBar| ((|li| (|List| (|Integer|))) ($ (|OutputForm|)))
        (SPADCALL (|RADIX;intgroup| |li| $) (QREFELT $ 75))) 

(SDEFUN |RADIX;coerce;$Of;35| ((|a| ($)) ($ (|OutputForm|)))
        (SPROG ((|rex| (|OutputForm|)) (|le| (|List| (|OutputForm|))))
               (SEQ (LETT |le| NIL)
                    (COND
                     ((NULL (NULL (QVELT |a| 3)))
                      (LETT |le|
                            (CONS (|RADIX;overBar| (QVELT |a| 3) $) |le|))))
                    (COND
                     ((NULL (NULL (QVELT |a| 2)))
                      (LETT |le|
                            (CONS (|RADIX;intgroup| (QVELT |a| 2) $) |le|))))
                    (COND
                     ((NULL (NULL |le|))
                      (LETT |le| (CONS (SPADCALL "." (QREFELT $ 76)) |le|))))
                    (COND
                     ((NULL (QVELT |a| 1))
                      (LETT |le| (CONS (SPADCALL 0 (QREFELT $ 66)) |le|)))
                     (#1='T
                      (LETT |le|
                            (CONS (|RADIX;intgroup| (QVELT |a| 1) $) |le|))))
                    (LETT |rex| (|RADIX;exprgroup| |le| $))
                    (EXIT
                     (COND
                      ((< (QVELT |a| 0) 0) (SPADCALL |rex| (QREFELT $ 77)))
                      (#1# |rex|)))))) 

(SDEFUN |RADIX;checkRagits| ((|li| (|List| (|Integer|))) ($ (|Boolean|)))
        (SPROG ((#1=#:G837 NIL) (|i| NIL))
               (SEQ
                (SEQ (LETT |i| NIL) (LETT #1# |li|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((OR (< |i| 0) (>= |i| (QREFELT $ 6)))
                         (|error|
                          "Each ragit (digit) must be between 0 and base-1")))))
                     (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                (EXIT 'T)))) 

(SDEFUN |RADIX;radixInt|
        ((|n| (|Integer|)) (|bas| (|Integer|)) ($ (|List| (|Integer|))))
        (SPROG
         ((|rits| (|List| (|Integer|)))
          (|qr|
           (|Record| (|:| |quotient| (|Integer|))
                     (|:| |remainder| (|Integer|)))))
         (SEQ (LETT |rits| NIL)
              (SEQ G190
                   (COND
                    ((NULL (SPADCALL (ABS |n|) 0 (QREFELT $ 79))) (GO G191)))
                   (SEQ (LETT |qr| (DIVIDE2 |n| |bas|)) (LETT |n| (QCAR |qr|))
                        (EXIT (LETT |rits| (CONS (QCDR |qr|) |rits|))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT |rits|)))) 

(SDEFUN |RADIX;radixFrac|
        ((|num| (|Integer|)) (|den| (|Integer|)) (|bas| (|Integer|))
         ($
          (|Record| (|:| |pfx| (|List| (|Integer|)))
                    (|:| |cyc| (|List| (|Integer|))))))
        (SPROG
         ((|rits|
           (|List|
            #1=(|Record| (|:| |quotient| (|Integer|))
                         (|:| |remainder| (|Integer|)))))
          (|ritscyc| (|List| (|Integer|))) (#2=#:G875 NIL) (|i| (|Integer|))
          (|ritspfx| (|List| (|Integer|))) (#3=#:G874 NIL) (|c| (|Integer|))
          (|cfound| (|Boolean|))
          (|ritsn|
           #4=(|List|
               (|Record| (|:| |quotient| (|Integer|))
                         (|:| |remainder| (|Integer|)))))
          (#5=#:G873 NIL)
          (|rn|
           (|Record| (|:| |quotient| (|Integer|))
                     (|:| |remainder| (|Integer|))))
          (#6=#:G872 NIL) (|p| #7=(|Integer|)) (|ritsi| #4#) (#8=#:G871 NIL)
          (|n| #7#) (|qr2i| #1#) (|qrt| #1#) (|qr1i| #1#) (#9=#:G870 NIL)
          (|qr| #1#))
         (SEQ (LETT |qr| (DIVIDE2 (* |bas| |num|) |den|)) (LETT |i| 0)
              (LETT |qr1i| (LETT |qr2i| |qr|)) (LETT |rits| (LIST |qr|))
              (SEQ (LETT #9# NIL) G190 (COND (#9# (GO G191)))
                   (SEQ (LETT |qr1i| (DIVIDE2 (* |bas| (QCDR |qr1i|)) |den|))
                        (LETT |qrt| (DIVIDE2 (* |bas| (QCDR |qr2i|)) |den|))
                        (LETT |qr2i| (DIVIDE2 (* |bas| (QCDR |qrt|)) |den|))
                        (LETT |rits| (CONS |qr2i| (CONS |qrt| |rits|)))
                        (EXIT (LETT |i| (+ |i| 1))))
                   (LETT #9# (SPADCALL |qr1i| |qr2i| (QREFELT $ 81))) (GO G190)
                   G191 (EXIT NIL))
              (LETT |rits| (NREVERSE |rits|)) (LETT |n| |i|)
              (LETT |ritsi| |rits|) (LETT |ritsn| |rits|)
              (SEQ (LETT |i| 1) (LETT #8# |n|) G190
                   (COND ((|greater_SI| |i| #8#) (GO G191)))
                   (SEQ (EXIT (LETT |ritsn| (CDR |ritsn|))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |i| 0)
              (SEQ G190
                   (COND
                    ((NULL
                      (SPADCALL (|SPADfirst| |ritsi|) (|SPADfirst| |ritsn|)
                                (QREFELT $ 82)))
                     (GO G191)))
                   (SEQ (LETT |ritsi| (CDR |ritsi|))
                        (LETT |ritsn| (CDR |ritsn|))
                        (EXIT (LETT |i| (+ |i| 1))))
                   NIL (GO G190) G191 (EXIT NIL))
              (LETT |p| |i|) (LETT |ritsn| |rits|)
              (SEQ (LETT |i| 1) (LETT #6# |n|) G190
                   (COND ((|greater_SI| |i| #6#) (GO G191)))
                   (SEQ (EXIT (LETT |ritsn| (CDR |ritsn|))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |rn| (|SPADfirst| |ritsn|)) (LETT |cfound| NIL)
              (LETT |c| 0)
              (SEQ (LETT |i| 1) (LETT #5# |p|) G190
                   (COND
                    ((OR (|greater_SI| |i| #5#) (NULL (NULL |cfound|)))
                     (GO G191)))
                   (SEQ (LETT |ritsn| (CDR |ritsn|))
                        (EXIT
                         (COND
                          ((SPADCALL |rn| (|SPADfirst| |ritsn|) (QREFELT $ 81))
                           (SEQ (LETT |c| |i|) (EXIT (LETT |cfound| 'T)))))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (COND ((NULL |cfound|) (LETT |c| |n|))) (LETT |ritspfx| NIL)
              (LETT |ritscyc| NIL)
              (SEQ (LETT |i| 1) (LETT #3# |p|) G190
                   (COND ((|greater_SI| |i| #3#) (GO G191)))
                   (SEQ
                    (LETT |ritspfx|
                          (CONS (QCAR (|SPADfirst| |rits|)) |ritspfx|))
                    (EXIT (LETT |rits| (CDR |rits|))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (SEQ (LETT |i| 1) (LETT #2# |c|) G190
                   (COND ((|greater_SI| |i| #2#) (GO G191)))
                   (SEQ
                    (LETT |ritscyc|
                          (CONS (QCAR (|SPADfirst| |rits|)) |ritscyc|))
                    (EXIT (LETT |rits| (CDR |rits|))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS (NREVERSE |ritspfx|) (NREVERSE |ritscyc|)))))) 

(DECLAIM (NOTINLINE |RadixExpansion;|)) 

(DEFUN |RadixExpansion| (#1=#:G919)
  (SPROG NIL
         (PROG (#2=#:G920)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST #1#)
                                               (HGET |$ConstructorCache|
                                                     '|RadixExpansion|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|RadixExpansion;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|RadixExpansion|)))))))))) 

(DEFUN |RadixExpansion;| (|#1|)
  (SPROG ((|pv$| NIL) (#1=#:G918 NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 |#1|)
          (LETT |dv$| (LIST '|RadixExpansion| DV$1))
          (LETT $ (GETREFV 119))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| (|Integer|)
                                                             '(|PolynomialFactorizationExplicit|))
                                              (|HasCategory| (|Integer|)
                                                             '(|RetractableTo|
                                                               (|Symbol|)))
                                              (|HasCategory| (|Integer|)
                                                             '(|CharacteristicNonZero|))
                                              (|HasCategory| (|Integer|)
                                                             '(|CharacteristicZero|))
                                              (|HasCategory| (|Integer|)
                                                             '(|ConvertibleTo|
                                                               (|InputForm|)))
                                              (|HasCategory| (|Integer|)
                                                             '(|RealConstant|))
                                              (|HasCategory| (|Integer|)
                                                             '(|OrderedIntegralDomain|))
                                              (|HasCategory| (|Integer|)
                                                             '(|OrderedSet|))
                                              (OR
                                               (|HasCategory| (|Integer|)
                                                              '(|OrderedIntegralDomain|))
                                               (|HasCategory| (|Integer|)
                                                              '(|OrderedSet|)))
                                              (|HasCategory| (|Integer|)
                                                             '(|RetractableTo|
                                                               (|Integer|)))
                                              (|HasCategory| (|Integer|)
                                                             '(|StepThrough|))
                                              (|HasCategory| (|Integer|)
                                                             '(|InnerEvalable|
                                                               (|Symbol|)
                                                               (|Integer|)))
                                              (|HasCategory| (|Integer|)
                                                             '(|Evalable|
                                                               (|Integer|)))
                                              (|HasCategory| (|Integer|)
                                                             '(|Eltable|
                                                               (|Integer|)
                                                               (|Integer|)))
                                              (|HasCategory| (|Integer|)
                                                             '(|PartialDifferentialRing|
                                                               (|Symbol|)))
                                              (|HasCategory| (|Integer|)
                                                             '(|DifferentialRing|))
                                              (|HasCategory| (|Integer|)
                                                             '(|ConvertibleTo|
                                                               (|Pattern|
                                                                (|Float|))))
                                              (|HasCategory| (|Integer|)
                                                             '(|ConvertibleTo|
                                                               (|Pattern|
                                                                (|Integer|))))
                                              (|HasCategory| (|Integer|)
                                                             '(|PatternMatchable|
                                                               (|Float|)))
                                              (|HasCategory| (|Integer|)
                                                             '(|PatternMatchable|
                                                               (|Integer|)))
                                              (|HasCategory| (|Integer|)
                                                             '(|LinearlyExplicitOver|
                                                               (|Integer|)))
                                              (|HasCategory| (|Integer|)
                                                             '(|EuclideanDomain|))
                                              (|HasCategory| (|Integer|)
                                                             '(|IntegerNumberSystem|))
                                              (LETT #1#
                                                    (|HasCategory| (|Integer|)
                                                                   '(|Comparable|)))
                                              (OR #1#
                                                  (|HasCategory| (|Integer|)
                                                                 '(|OrderedIntegralDomain|))
                                                  (|HasCategory| (|Integer|)
                                                                 '(|OrderedSet|)))))))
          (|haddProp| |$ConstructorCache| '|RadixExpansion| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (AND (|HasCategory| $ '(|CharacteristicNonZero|))
               (|HasCategory| (|Integer|) '(|PolynomialFactorizationExplicit|))
               (|augmentPredVector| $ 33554432))
          (AND
           (OR
            (AND (|HasCategory| $ '(|CharacteristicNonZero|))
                 (|HasCategory| (|Integer|)
                                '(|PolynomialFactorizationExplicit|)))
            (|HasCategory| (|Integer|) '(|CharacteristicNonZero|)))
           (|augmentPredVector| $ 67108864))
          (SETF |pv$| (QREFELT $ 3))
          (COND ((< |#1| 2) (|error| "Radix base must be at least 2")))
          (QSETREFV $ 7
                    (|Record| (|:| |sgn| (|Integer|))
                              (|:| |int| (|List| (|Integer|)))
                              (|:| |pfx| (|List| (|Integer|)))
                              (|:| |cyc| (|List| (|Integer|)))))
          (QSETREFV $ 64 "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
          $))) 

(MAKEPROP '|RadixExpansion| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep|
              (|NonNegativeInteger|) |RADIX;characteristic;Nni;1|
              (CONS IDENTITY (FUNCALL (|dispatchFunction| |RADIX;Zero;$;3|) $))
              |RADIX;differentiate;2$;2|
              (CONS IDENTITY (FUNCALL (|dispatchFunction| |RADIX;One;$;4|) $))
              (|Boolean|) |RADIX;=;2$B;13| |RADIX;-;2$;5| (|Fraction| 23)
              |RADIX;coerce;$F;16| (0 . +) |RADIX;coerce;F$;18| |RADIX;+;3$;6|
              (6 . -) |RADIX;-;3$;7| (|Integer|) (12 . *) |RADIX;*;I2$;8|
              (18 . *) |RADIX;*;3$;9| (24 . /) |RADIX;/;3$;10| (30 . /)
              |RADIX;/;2I$;11| (36 . <) |RADIX;<;2$B;12| (|List| 23) (42 . =)
              (48 . |numer|) |RADIX;numer;$I;14| (53 . |denom|)
              |RADIX;denom;$I;15| |RADIX;wholePart;$I;23| (58 . |coerce|)
              |RADIX;fractionPart;$F;24| |RADIX;coerce;I$;17| (63 . |Zero|)
              (67 . -) (|Union| 16 '"failed") |RADIX;retractIfCan;$U;19|
              (|Union| 23 '"failed") |RADIX;retractIfCan;$U;20|
              (72 . |ceiling|) |RADIX;ceiling;$I;21| (77 . |floor|)
              |RADIX;floor;$I;22| |RADIX;wholeRagits;$L;25| (|Stream| 23)
              (82 . |construct|) (87 . |repeating|) (92 . |concat|)
              |RADIX;fractRagits;$S;26| |RADIX;prefixRagits;$L;27|
              |RADIX;cycleRagits;$L;28| |RADIX;wholeRadix;L$;29|
              |RADIX;fractRadix;2L$;30| 'ALPHAS (|OutputForm|) (98 . |coerce|)
              (|String|) (103 . |minIndex|) (|Character|) (108 . |elt|)
              (114 . |coerce|) (|List| $) (119 . |hconcat|)
              (124 . |blankSeparate|) (129 . |overbar|) (134 . |message|)
              (139 . -) |RADIX;coerce;$Of;35| (144 . ~=)
              (|Record| (|:| |quotient| 23) (|:| |remainder| 23)) (150 . =)
              (156 . ~=) (|Union| 94 '#1="failed") (|Matrix| $)
              (|Union| $ '"failed") (|InputForm|) (|Pattern| 103)
              (|Pattern| 23) (|Equation| 23) (|List| 89) (|Symbol|) (|List| 91)
              (|Record| (|:| |mat| 95) (|:| |vec| (|Vector| 23))) (|Vector| $)
              (|Matrix| 23) (|List| 8) (|PatternMatchResult| 103 $)
              (|PatternMatchResult| 23 $) (|Factored| 100)
              (|SparseUnivariatePolynomial| $) (|Union| 102 '#1#) (|List| 100)
              (|Float|) (|DoubleFloat|) (|Union| 91 '"failed")
              (|Mapping| 23 23) (|Factored| $)
              (|Record| (|:| |coef1| $) (|:| |coef2| $))
              (|Union| 108 '#2="failed") (|Union| 72 '#2#)
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (|Record| (|:| |coef| 72) (|:| |generator| $))
              (|Record| (|:| |llcm_res| $) (|:| |coeff1| $) (|:| |coeff2| $))
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|PositiveInteger|) (|SingleInteger|) (|HashState|))
           '#(~= 162 |zero?| 168 |wholeRagits| 173 |wholeRadix| 178 |wholePart|
              183 |unitNormal| 188 |unitCanonical| 193 |unit?| 198
              |subtractIfCan| 203 |squareFreePolynomial| 209 |squareFreePart|
              214 |squareFree| 219 |solveLinearPolynomialEquation| 224
              |smaller?| 230 |sizeLess?| 236 |sign| 242 |sample| 247
              |rightRecip| 251 |rightPower| 256 |retractIfCan| 268 |retract|
              288 |rem| 308 |reducedSystem| 314 |recip| 336 |quo| 341
              |principalIdeal| 347 |prime?| 352 |prefixRagits| 357 |positive?|
              362 |patternMatch| 367 |opposite?| 381 |one?| 387 |numerator| 392
              |numer| 397 |nextItem| 402 |negative?| 407 |multiEuclidean| 412
              |min| 418 |max| 424 |map| 430 |leftRecip| 436 |leftPower| 441
              |lcmCoef| 453 |lcm| 459 |latex| 470 |inv| 475 |init| 480
              |hashUpdate!| 484 |hash| 490 |gcdPolynomial| 495 |gcd| 501
              |fractionPart| 512 |fractRagits| 522 |fractRadix| 527 |floor| 533
              |factorSquareFreePolynomial| 538 |factorPolynomial| 543 |factor|
              548 |extendedEuclidean| 553 |exquo| 566 |expressIdealMember| 572
              |eval| 578 |euclideanSize| 618 |elt| 623 |divide| 629
              |differentiate| 635 |denominator| 685 |denom| 690 |cycleRagits|
              695 |convert| 700 |conditionP| 725 |commutator| 730 |coerce| 736
              |charthRoot| 766 |characteristic| 771 |ceiling| 775 |associator|
              780 |associates?| 787 |antiCommutator| 793 |annihilate?| 799
              |abs| 805 ^ 810 |Zero| 828 |One| 832 D 836 >= 886 > 892 = 898 <=
              904 < 910 / 916 - 928 + 939 * 945)
           'NIL
           (CONS
            (|makeByteWordVec2| 25
                                '(0 0 0 1 0 0 0 7 0 0 0 0 0 0 7 0 0 0 0 0 3 4
                                  15 16 0 0 0 0 0 0 0 0 0 0 0 7 0 0 0 0 0 0 0 7
                                  0 7 0 0 0 7 0 0 0 0 0 9 0 0 0 25 11 19 20 0 0
                                  0 0 2 6 10 13 0 0 0 0 0 0 0 0 0 2 5 6 6 8 10
                                  12 13 14 17 18))
            (CONS
             '#(|QuotientFieldCategory&| |Field&| |EuclideanDomain&|
                |PolynomialFactorizationExplicit&| NIL
                |UniqueFactorizationDomain&| |GcdDomain&| NIL NIL
                |FullyLinearlyExplicitOver&| |DifferentialExtension&|
                |DivisionRing&| NIL NIL |OrderedRing&| NIL |Algebra&|
                |Algebra&| |EntireRing&| |Algebra&| NIL NIL
                |PartialDifferentialRing&| |DifferentialRing&| NIL |Rng&| NIL
                |Module&| |Module&| |Module&| NIL NIL NIL NIL
                |NonAssociativeRing&| NIL NIL NIL NIL NIL NIL
                |NonAssociativeRng&| NIL NIL |AbelianGroup&| NIL NIL NIL NIL
                NIL NIL NIL |MagmaWithUnit&| |NonAssociativeSemiRng&|
                |AbelianMonoid&| |OrderedSet&| |FullyEvalableOver&| |Magma&|
                |AbelianSemiGroup&| NIL NIL NIL NIL NIL |RetractableTo&| NIL
                |SetCategory&| |RetractableTo&| NIL |RetractableTo&|
                |Evalable&| NIL NIL NIL NIL NIL NIL NIL |BasicType&| NIL NIL
                NIL NIL NIL |PartialOrder&| NIL |InnerEvalable&|
                |InnerEvalable&| NIL NIL NIL)
             (CONS
              '#((|QuotientFieldCategory| 23) (|Field|) (|EuclideanDomain|)
                 (|PolynomialFactorizationExplicit|) (|PrincipalIdealDomain|)
                 (|UniqueFactorizationDomain|) (|GcdDomain|)
                 (|OrderedIntegralDomain|) (|IntegralDomain|)
                 (|FullyLinearlyExplicitOver| 23) (|DifferentialExtension| 23)
                 (|DivisionRing|) (|CommutativeRing|) (|LeftOreRing|)
                 (|OrderedRing|) (|LinearlyExplicitOver| 23) (|Algebra| 23)
                 (|Algebra| 16) (|EntireRing|) (|Algebra| $$)
                 (|CharacteristicNonZero|) (|CharacteristicZero|)
                 (|PartialDifferentialRing| 91) (|DifferentialRing|) (|Ring|)
                 (|Rng|) (|SemiRing|) (|Module| 23) (|Module| 16) (|Module| $$)
                 (|SemiRng|) (|BiModule| 23 23) (|BiModule| 16 16)
                 (|BiModule| $$ $$) (|NonAssociativeRing|)
                 (|OrderedAbelianGroup|) (|RightModule| 23) (|LeftModule| 23)
                 (|RightModule| 16) (|LeftModule| 16) (|LeftModule| $$)
                 (|NonAssociativeRng|) (|RightModule| $$)
                 (|OrderedCancellationAbelianMonoid|) (|AbelianGroup|)
                 (|OrderedAbelianMonoid|) (|Monoid|) (|NonAssociativeSemiRing|)
                 (|CancellationAbelianMonoid|) (|OrderedAbelianSemiGroup|)
                 (|FullyPatternMatchable| 23) (|SemiGroup|) (|MagmaWithUnit|)
                 (|NonAssociativeSemiRng|) (|AbelianMonoid|) (|OrderedSet|)
                 (|FullyEvalableOver| 23) (|Magma|) (|AbelianSemiGroup|)
                 (|Comparable|) (|StepThrough|) (|PatternMatchable| 103)
                 (|PatternMatchable| 23) (|Patternable| 23)
                 (|RetractableTo| 23) (|CommutativeStar|) (|SetCategory|)
                 (|RetractableTo| 91) (|RealConstant|) (|RetractableTo| 16)
                 (|Evalable| 23) (|Type|) (|CoercibleFrom| 23)
                 (|canonicalsClosed|) (|canonicalUnitNormal|)
                 (|noZeroDivisors|) (|TwoSidedRecip|) (|unitsKnown|)
                 (|BasicType|) (|CoercibleTo| 65) (|CoercibleFrom| 91)
                 (|ConvertibleTo| 86) (|ConvertibleTo| 104)
                 (|ConvertibleTo| 103) (|PartialOrder|) (|CoercibleFrom| 16)
                 (|InnerEvalable| 91 23) (|InnerEvalable| 23 23)
                 (|Eltable| 23 $$) (|ConvertibleTo| 87) (|ConvertibleTo| 88))
              (|makeByteWordVec2| 118
                                  '(2 16 0 0 0 18 2 16 0 0 0 21 2 16 0 23 0 24
                                    2 16 0 0 16 26 2 16 0 0 0 28 2 16 0 23 23
                                    30 2 16 13 0 0 32 2 34 13 0 0 35 1 16 23 0
                                    36 1 16 23 0 38 1 16 0 23 41 0 16 0 44 1 16
                                    0 0 45 1 16 23 0 50 1 16 23 0 52 1 55 0 34
                                    56 1 55 0 34 57 2 55 0 0 0 58 1 23 65 0 66
                                    1 67 23 0 68 2 67 69 0 23 70 1 69 65 0 71 1
                                    65 0 72 73 1 65 0 72 74 1 65 0 0 75 1 65 0
                                    67 76 1 65 0 0 77 2 23 13 0 0 79 2 80 13 0
                                    0 81 2 80 13 0 0 82 2 0 13 0 0 1 1 0 13 0 1
                                    1 0 34 0 54 1 0 0 34 62 1 22 23 0 40 1 0
                                    115 0 1 1 0 0 0 1 1 0 13 0 1 2 0 85 0 0 1 1
                                    1 99 100 1 1 0 0 0 1 1 0 107 0 1 2 1 101
                                    102 100 1 2 24 13 0 0 1 2 0 13 0 0 1 1 7 23
                                    0 1 0 0 0 1 1 0 85 0 1 2 0 0 0 8 1 2 0 0 0
                                    116 1 1 10 48 0 49 1 10 46 0 47 1 2 105 0 1
                                    1 0 48 0 49 1 10 23 0 1 1 10 16 0 1 1 2 91
                                    0 1 1 0 23 0 1 2 0 0 0 0 1 2 21 93 84 94 1
                                    1 21 95 84 1 1 0 95 84 1 2 0 93 84 94 1 1 0
                                    85 0 1 2 0 0 0 0 1 1 0 113 72 1 1 0 13 0 1
                                    1 0 34 0 60 1 7 13 0 1 3 19 97 0 87 97 1 3
                                    20 98 0 88 98 1 2 0 13 0 0 1 1 0 13 0 1 1 0
                                    0 0 1 1 0 23 0 37 1 11 85 0 1 1 7 13 0 1 2
                                    0 110 72 0 1 2 8 0 0 0 1 2 8 0 0 0 1 2 0 0
                                    106 0 1 1 0 85 0 1 2 0 0 0 8 1 2 0 0 0 116
                                    1 2 0 114 0 0 1 1 0 0 72 1 2 0 0 0 0 1 1 0
                                    67 0 1 1 0 0 0 1 0 11 0 1 2 0 118 118 0 1 1
                                    0 117 0 1 2 0 100 100 100 1 1 0 0 72 1 2 0
                                    0 0 0 1 1 22 0 0 1 1 0 16 0 42 1 0 55 0 59
                                    2 0 0 34 34 63 1 23 23 0 53 1 1 99 100 1 1
                                    1 99 100 1 1 0 107 0 1 3 0 109 0 0 0 1 2 0
                                    111 0 0 1 2 0 85 0 0 1 2 0 110 72 0 1 2 13
                                    0 0 89 1 2 13 0 0 90 1 3 13 0 0 34 34 1 3
                                    13 0 0 23 23 1 3 12 0 0 91 23 1 3 12 0 0 92
                                    34 1 1 0 8 0 1 2 14 0 0 23 1 2 0 112 0 0 1
                                    2 16 0 0 8 1 1 16 0 0 11 3 15 0 0 92 96 1 2
                                    15 0 0 92 1 3 15 0 0 91 8 1 2 15 0 0 91 1 3
                                    0 0 0 106 8 1 2 0 0 0 106 1 1 0 0 0 1 1 0
                                    23 0 39 1 0 34 0 61 1 5 86 0 1 1 17 87 0 1
                                    1 18 88 0 1 1 6 103 0 1 1 6 104 0 1 1 26 83
                                    84 1 2 0 0 0 0 1 1 2 0 91 1 1 0 16 0 17 1 0
                                    0 23 43 1 0 0 16 19 1 0 0 0 1 1 0 65 0 78 1
                                    27 85 0 1 0 0 8 9 1 23 23 0 51 3 0 0 0 0 0
                                    1 2 0 13 0 0 1 2 0 0 0 0 1 2 0 13 0 0 1 1 7
                                    0 0 1 2 0 0 0 23 1 2 0 0 0 8 1 2 0 0 0 116
                                    1 0 0 0 10 0 0 0 12 2 16 0 0 8 1 1 16 0 0 1
                                    3 15 0 0 91 8 1 3 15 0 0 92 96 1 2 15 0 0
                                    91 1 2 15 0 0 92 1 3 0 0 0 106 8 1 2 0 0 0
                                    106 1 2 8 13 0 0 1 2 8 13 0 0 1 2 0 13 0 0
                                    14 2 8 13 0 0 1 2 8 13 0 0 33 2 0 0 23 23
                                    31 2 0 0 0 0 29 1 0 0 0 15 2 0 0 0 0 22 2 0
                                    0 0 0 20 2 0 0 0 23 1 2 0 0 23 0 25 2 0 0
                                    16 0 1 2 0 0 0 16 1 2 0 0 8 0 1 2 0 0 0 0
                                    27 2 0 0 116 0 1)))))
           '|lookupComplete|)) 
