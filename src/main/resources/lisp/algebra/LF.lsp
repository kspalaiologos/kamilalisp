
(SDEFUN |LF;Si;2F;1| ((|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 21) |x| (QREFELT $ 30))) 

(SDEFUN |LF;Ci;2F;2| ((|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 22) |x| (QREFELT $ 30))) 

(SDEFUN |LF;Shi;2F;3| ((|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 23) |x| (QREFELT $ 30))) 

(SDEFUN |LF;Chi;2F;4| ((|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 24) |x| (QREFELT $ 30))) 

(SDEFUN |LF;Ei;2F;5| ((|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 19) |x| (QREFELT $ 30))) 

(SDEFUN |LF;erf;2F;6| ((|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 26) |x| (QREFELT $ 30))) 

(SDEFUN |LF;erfi;2F;7| ((|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 27) |x| (QREFELT $ 30))) 

(SDEFUN |LF;li;2F;8| ((|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 20) |x| (QREFELT $ 30))) 

(SDEFUN |LF;dilog;2F;9| ((|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 25) |x| (QREFELT $ 30))) 

(SDEFUN |LF;fresnelS;2F;10| ((|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 28) |x| (QREFELT $ 30))) 

(SDEFUN |LF;fresnelC;2F;11| ((|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 29) |x| (QREFELT $ 30))) 

(SDEFUN |LF;belong?;BoB;12| ((|op| (|BasicOperator|)) ($ (|Boolean|)))
        (SPADCALL |op| (QREFELT $ 8) (QREFELT $ 43))) 

(SDEFUN |LF;isi| ((|x| (F)) ($ (F)))
        (COND ((SPADCALL |x| (QREFELT $ 45)) (|spadConstant| $ 46))
              ('T (SPADCALL (QREFELT $ 21) |x| (QREFELT $ 47))))) 

(SDEFUN |LF;ici| ((|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 22) |x| (QREFELT $ 47))) 

(SDEFUN |LF;ishi| ((|x| (F)) ($ (F)))
        (COND ((SPADCALL |x| (QREFELT $ 45)) (|spadConstant| $ 46))
              ('T (SPADCALL (QREFELT $ 23) |x| (QREFELT $ 47))))) 

(SDEFUN |LF;ichi| ((|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 24) |x| (QREFELT $ 47))) 

(SDEFUN |LF;ierf| ((|x| (F)) ($ (F)))
        (COND ((SPADCALL |x| (QREFELT $ 45)) (|spadConstant| $ 46))
              ('T (SPADCALL (QREFELT $ 26) |x| (QREFELT $ 47))))) 

(SDEFUN |LF;ierfi| ((|x| (F)) ($ (F)))
        (COND ((SPADCALL |x| (QREFELT $ 45)) (|spadConstant| $ 46))
              ('T (SPADCALL (QREFELT $ 27) |x| (QREFELT $ 47))))) 

(SDEFUN |LF;ili2| ((|x| (F)) ($ (F)))
        (COND
         ((SPADCALL |x| (|spadConstant| $ 49) (QREFELT $ 50))
          (|spadConstant| $ 46))
         ('T (SPADCALL (QREFELT $ 25) |x| (QREFELT $ 47))))) 

(SDEFUN |LF;ifis| ((|x| (F)) ($ (F)))
        (COND ((SPADCALL |x| (QREFELT $ 45)) (|spadConstant| $ 46))
              ('T (SPADCALL (QREFELT $ 28) |x| (QREFELT $ 47))))) 

(SDEFUN |LF;ific| ((|x| (F)) ($ (F)))
        (COND ((SPADCALL |x| (QREFELT $ 45)) (|spadConstant| $ 46))
              ('T (SPADCALL (QREFELT $ 29) |x| (QREFELT $ 47))))) 

(SDEFUN |LF;integrand| ((|l| (|List| F)) ($ (F)))
        (SPADCALL (|SPADfirst| |l|)
                  (SPADCALL (SPADCALL |l| (QREFELT $ 52)) (QREFELT $ 54))
                  (SPADCALL |l| (QREFELT $ 55)) (QREFELT $ 56))) 

(SDEFUN |LF;integral;FSF;23| ((|f| (F)) (|x| (|Symbol|)) ($ (F)))
        (SPROG ((|k| (|Kernel| F)))
               (SPADCALL (QREFELT $ 16)
                         (LIST
                          (SPADCALL |f|
                                    (LETT |k| (SPADCALL |x| (QREFELT $ 58)))
                                    (QREFELT $ 12) (QREFELT $ 56))
                          (QREFELT $ 12) (SPADCALL |k| (QREFELT $ 59)))
                         (QREFELT $ 61)))) 

(SDEFUN |LF;iint| ((|l| (|List| F)) ($ (F)))
        (COND
         ((SPADCALL (|SPADfirst| |l|) (QREFELT $ 45)) (|spadConstant| $ 46))
         ('T (SPADCALL (QREFELT $ 16) |l| (QREFELT $ 63))))) 

(SDEFUN |LF;ddint| ((|l| (|List| F)) ($ (|OutputForm|)))
        (SPADCALL
         (SPADCALL (SPADCALL (|LF;integrand| |l| $) (QREFELT $ 65))
                   (SPADCALL (SPADCALL '|d| (QREFELT $ 66))
                             (SPADCALL (SPADCALL |l| (QREFELT $ 55))
                                       (QREFELT $ 65))
                             (QREFELT $ 67))
                   (QREFELT $ 68))
         (SPADCALL (SPADCALL (CDR |l|) (QREFELT $ 55)) (QREFELT $ 65))
         (SPADCALL (SPADCALL (CDR (CDR |l|)) (QREFELT $ 55)) (QREFELT $ 65))
         (QREFELT $ 69))) 

(SDEFUN |LF;eqint| ((|k1| (|Kernel| F)) (|k2| (|Kernel| F)) ($ (|Boolean|)))
        (SPROG
         ((|res| (|Boolean|)) (#1=#:G776 NIL) (|a2| #2=(|List| F)) (|a1| #2#))
         (SEQ
          (EXIT
           (SEQ (LETT |a1| (SPADCALL |k1| (QREFELT $ 70)))
                (LETT |a2| (SPADCALL |k2| (QREFELT $ 70)))
                (LETT |res|
                      (SPADCALL (SPADCALL |k1| (QREFELT $ 71))
                                (SPADCALL |k2| (QREFELT $ 71)) (QREFELT $ 72)))
                (COND ((NULL |res|) (PROGN (LETT #1# |res|) (GO #3=#:G775))))
                (LETT |res| (SPADCALL |a1| |a2| (QREFELT $ 73)))
                (COND (|res| (PROGN (LETT #1# |res|) (GO #3#))))
                (EXIT
                 (LETT |res|
                       (COND
                        ((SPADCALL (SPADCALL |a1| 3 (QREFELT $ 75))
                                   (SPADCALL |a2| 3 (QREFELT $ 75))
                                   (QREFELT $ 50))
                         (SPADCALL
                          (SPADCALL (SPADCALL |a1| 1 (QREFELT $ 75))
                                    (LIST
                                     (SPADCALL (SPADCALL |a1| 2 (QREFELT $ 75))
                                               (QREFELT $ 54)))
                                    (LIST (SPADCALL |a2| 2 (QREFELT $ 75)))
                                    (QREFELT $ 77))
                          (SPADCALL |a2| 1 (QREFELT $ 75)) (QREFELT $ 50)))
                        ('T NIL))))))
          #3# (EXIT #1#)))) 

(SDEFUN |LF;dvint| ((|l| (|List| F)) (|x| (|Symbol|)) ($ (F)))
        (SPADCALL
         (SPADCALL (SPADCALL (SPADCALL |l| (QREFELT $ 55)) |x| (QREFELT $ 78))
                   (|LF;integrand| |l| $) (QREFELT $ 79))
         (SPADCALL (QREFELT $ 16)
                   (LIST (SPADCALL (|SPADfirst| |l|) |x| (QREFELT $ 78))
                         (SPADCALL |l| (QREFELT $ 52))
                         (SPADCALL |l| (QREFELT $ 55)))
                   (QREFELT $ 61))
         (QREFELT $ 80))) 

(SDEFUN |LF;iiint| ((|l| (|List| F)) ($ (F)))
        (SPROG
         ((|lval| (|List| F)) (|n| (|NonNegativeInteger|))
          (|nu| (|Union| (|NonNegativeInteger|) "failed")))
         (SEQ (LETT |nu| (SPADCALL (LENGTH |l|) 2 (QREFELT $ 83)))
              (EXIT
               (COND ((QEQCAR |nu| 1) (|error| "impossible"))
                     (#1='T
                      (SEQ (LETT |n| (QCDR |nu|))
                           (LETT |lval| (SPADCALL |l| |n| (QREFELT $ 84)))
                           (EXIT
                            (COND
                             ((SPADCALL (ELT $ 45) |lval| (QREFELT $ 86))
                              (|spadConstant| $ 46))
                             (#1#
                              (SPADCALL (QREFELT $ 17) |l|
                                        (QREFELT $ 63)))))))))))) 

(SDEFUN |LF;dviint| ((|l| (|List| F)) (|v| (|Symbol|)) ($ (F)))
        (SPROG
         ((|m| (|Integer|)) (|lv| (|List| (|Symbol|))) (#1=#:G798 NIL)
          (|vf| NIL) (#2=#:G797 NIL) (|lvf| (|List| F))
          (|n| (|NonNegativeInteger|))
          (|nu| (|Union| (|NonNegativeInteger|) "failed")))
         (SEQ (LETT |nu| (SPADCALL (LENGTH |l|) 2 (QREFELT $ 83)))
              (EXIT
               (COND ((QEQCAR |nu| 1) (|error| "impossible"))
                     (#3='T
                      (SEQ (LETT |n| (QCDR |nu|))
                           (LETT |lvf| (SPADCALL |l| |n| (QREFELT $ 87)))
                           (LETT |lv|
                                 (PROGN
                                  (LETT #2# NIL)
                                  (SEQ (LETT |vf| NIL) (LETT #1# |lvf|) G190
                                       (COND
                                        ((OR (ATOM #1#)
                                             (PROGN (LETT |vf| (CAR #1#)) NIL))
                                         (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (LETT #2#
                                               (CONS
                                                (SPADCALL |vf| (QREFELT $ 88))
                                                #2#))))
                                       (LETT #1# (CDR #1#)) (GO G190) G191
                                       (EXIT (NREVERSE #2#)))))
                           (LETT |m| (SPADCALL |v| |lv| (QREFELT $ 90)))
                           (EXIT
                            (COND ((EQL |m| 0) (|spadConstant| $ 46))
                                  (#3#
                                   (SPADCALL |l| (+ |n| |m|)
                                             (QREFELT $ 75)))))))))))) 

(SDEFUN |LF;dvdint| ((|l| (|List| F)) (|x| (|Symbol|)) ($ (F)))
        (SPROG
         ((|g| (F)) (|f| (F)) (|h| (F)) (|k| (|Kernel| F)) (|d| (F)) (|y| (F)))
         (SEQ
          (COND
           ((EQUAL |x|
                   (SPADCALL (LETT |y| (SPADCALL |l| (QREFELT $ 55)))
                             (QREFELT $ 88)))
            (|spadConstant| $ 46))
           ('T
            (SEQ
             (LETT |k|
                   (SPADCALL (LETT |d| (SPADCALL |l| (QREFELT $ 52)))
                             (QREFELT $ 54)))
             (EXIT
              (SPADCALL
               (SPADCALL
                (SPADCALL
                 (SPADCALL (LETT |h| (SPADCALL (CDR (CDR |l|)) (QREFELT $ 55)))
                           |x| (QREFELT $ 78))
                 (SPADCALL (LETT |f| (|SPADfirst| |l|)) |k| |h| (QREFELT $ 56))
                 (QREFELT $ 79))
                (SPADCALL
                 (SPADCALL (LETT |g| (SPADCALL (CDR |l|) (QREFELT $ 55))) |x|
                           (QREFELT $ 78))
                 (SPADCALL |f| |k| |g| (QREFELT $ 56)) (QREFELT $ 79))
                (QREFELT $ 92))
               (SPADCALL (QREFELT $ 18)
                         (LIST (SPADCALL |f| |x| (QREFELT $ 78)) |d| |y| |g|
                               |h|)
                         (QREFELT $ 61))
               (QREFELT $ 80))))))))) 

(SDEFUN |LF;integral;FSbF;31| ((|f| (F)) (|s| (|SegmentBinding| F)) ($ (F)))
        (SPROG ((|x| (|Kernel| F)))
               (SEQ
                (LETT |x|
                      (SPADCALL (SPADCALL |s| (QREFELT $ 94)) (QREFELT $ 58)))
                (EXIT
                 (SPADCALL (QREFELT $ 18)
                           (LIST
                            (SPADCALL |f| |x| (QREFELT $ 12) (QREFELT $ 56))
                            (QREFELT $ 12) (SPADCALL |x| (QREFELT $ 59))
                            (SPADCALL (SPADCALL |s| (QREFELT $ 96))
                                      (QREFELT $ 97))
                            (SPADCALL (SPADCALL |s| (QREFELT $ 96))
                                      (QREFELT $ 98)))
                           (QREFELT $ 61)))))) 

(SDEFUN |LF;ili| ((|x| (F)) ($ (F)))
        (COND
         ((SPADCALL |x| (|spadConstant| $ 49) (QREFELT $ 50))
          (|error| "Invalid argument"))
         ((SPADCALL |x| '|exp| (QREFELT $ 100))
          (SPADCALL
           (|SPADfirst|
            (SPADCALL (SPADCALL |x| (QREFELT $ 54)) (QREFELT $ 70)))
           (QREFELT $ 35)))
         ('T (SPADCALL (QREFELT $ 20) |x| (QREFELT $ 47))))) 

(SDEFUN |LF;iei| ((|x| (F)) ($ (F)))
        (COND
         ((SPADCALL |x| (|spadConstant| $ 46) (QREFELT $ 50))
          (|error| "Invalid argument"))
         ((SPADCALL |x| '|log| (QREFELT $ 100))
          (SPADCALL
           (|SPADfirst|
            (SPADCALL (SPADCALL |x| (QREFELT $ 54)) (QREFELT $ 70)))
           (QREFELT $ 38)))
         ('T (SPADCALL (QREFELT $ 19) |x| (QREFELT $ 47))))) 

(SDEFUN |LF;operator;2Bo;34| ((|op| (|BasicOperator|)) ($ (|BasicOperator|)))
        (COND ((SPADCALL |op| '|integral| (QREFELT $ 101)) (QREFELT $ 16))
              ((SPADCALL |op| '|%iint| (QREFELT $ 101)) (QREFELT $ 17))
              ((SPADCALL |op| '|%defint| (QREFELT $ 101)) (QREFELT $ 18))
              ((SPADCALL |op| '|Ei| (QREFELT $ 101)) (QREFELT $ 19))
              ((SPADCALL |op| '|Si| (QREFELT $ 101)) (QREFELT $ 21))
              ((SPADCALL |op| '|Ci| (QREFELT $ 101)) (QREFELT $ 22))
              ((SPADCALL |op| '|Shi| (QREFELT $ 101)) (QREFELT $ 23))
              ((SPADCALL |op| '|Chi| (QREFELT $ 101)) (QREFELT $ 24))
              ((SPADCALL |op| '|li| (QREFELT $ 101)) (QREFELT $ 20))
              ((SPADCALL |op| '|erf| (QREFELT $ 101)) (QREFELT $ 26))
              ((SPADCALL |op| '|erfi| (QREFELT $ 101)) (QREFELT $ 27))
              ((SPADCALL |op| '|dilog| (QREFELT $ 101)) (QREFELT $ 25))
              ((SPADCALL |op| '|fresnelC| (QREFELT $ 101)) (QREFELT $ 29))
              ((SPADCALL |op| '|fresnelS| (QREFELT $ 101)) (QREFELT $ 28))
              ('T (|error| "Not a Liouvillian operator")))) 

(SDEFUN |LF;pint| ((|l| (|List| (|InputForm|))) ($ (|InputForm|)))
        (SPADCALL (CONS (SPADCALL '|integral| (QREFELT $ 127)) |l|)
                  (QREFELT $ 128))) 

(SDEFUN |LF;inint| ((|l| (|List| F)) ($ (|InputForm|)))
        (SPROG ((|r2| (|InputForm|)))
               (SEQ
                (LETT |r2|
                      (SPADCALL
                       (LIST (SPADCALL '|::| (QREFELT $ 127))
                             (SPADCALL (SPADCALL |l| (QREFELT $ 55))
                                       (QREFELT $ 129))
                             (SPADCALL '|Symbol| (QREFELT $ 127)))
                       (QREFELT $ 128)))
                (EXIT
                 (|LF;pint|
                  (LIST (SPADCALL (|LF;integrand| |l| $) (QREFELT $ 129)) |r2|)
                  $))))) 

(SDEFUN |LF;indint| ((|l| (|List| F)) ($ (|InputForm|)))
        (|LF;pint|
         (LIST (SPADCALL (|LF;integrand| |l| $) (QREFELT $ 129))
               (SPADCALL
                (CONS (SPADCALL '= (QREFELT $ 127))
                      (LIST
                       (SPADCALL (SPADCALL |l| (QREFELT $ 55)) (QREFELT $ 129))
                       (SPADCALL
                        (CONS (SPADCALL 'SEGMENT (QREFELT $ 127))
                              (LIST
                               (SPADCALL (SPADCALL (CDR |l|) (QREFELT $ 55))
                                         (QREFELT $ 129))
                               (SPADCALL
                                (SPADCALL (CDR (CDR |l|)) (QREFELT $ 55))
                                (QREFELT $ 129))))
                        (QREFELT $ 128))))
                (QREFELT $ 128)))
         $)) 

(DECLAIM (NOTINLINE |LiouvillianFunction;|)) 

(DEFUN |LiouvillianFunction| (&REST #1=#:G899)
  (SPROG NIL
         (PROG (#2=#:G900)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|LiouvillianFunction|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |LiouvillianFunction;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|LiouvillianFunction|)))))))))) 

(DEFUN |LiouvillianFunction;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|LiouvillianFunction| DV$1 DV$2))
          (LETT $ (GETREFV 130))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|LiouvillianFunction|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 8 '|prim|)
          (QSETREFV $ 12 (SPADCALL (SPADCALL (QREFELT $ 10)) (QREFELT $ 11)))
          (QSETREFV $ 16 (SPADCALL '|integral| (QREFELT $ 15)))
          (QSETREFV $ 17 (SPADCALL '|%iint| (QREFELT $ 15)))
          (QSETREFV $ 18 (SPADCALL '|%defint| (QREFELT $ 15)))
          (QSETREFV $ 19 (SPADCALL '|Ei| (QREFELT $ 15)))
          (QSETREFV $ 20 (SPADCALL '|li| (QREFELT $ 15)))
          (QSETREFV $ 21 (SPADCALL '|Si| (QREFELT $ 15)))
          (QSETREFV $ 22 (SPADCALL '|Ci| (QREFELT $ 15)))
          (QSETREFV $ 23 (SPADCALL '|Shi| (QREFELT $ 15)))
          (QSETREFV $ 24 (SPADCALL '|Chi| (QREFELT $ 15)))
          (QSETREFV $ 25 (SPADCALL '|dilog| (QREFELT $ 15)))
          (QSETREFV $ 26 (SPADCALL '|erf| (QREFELT $ 15)))
          (QSETREFV $ 27 (SPADCALL '|erfi| (QREFELT $ 15)))
          (QSETREFV $ 28 (SPADCALL '|fresnelS| (QREFELT $ 15)))
          (QSETREFV $ 29 (SPADCALL '|fresnelC| (QREFELT $ 15)))
          (SPADCALL (QREFELT $ 19) (CONS (|function| |LF;iei|) $)
                    (QREFELT $ 105))
          (SPADCALL (QREFELT $ 20) (CONS (|function| |LF;ili|) $)
                    (QREFELT $ 105))
          (SPADCALL (QREFELT $ 21) (CONS (|function| |LF;isi|) $)
                    (QREFELT $ 105))
          (SPADCALL (QREFELT $ 22) (CONS (|function| |LF;ici|) $)
                    (QREFELT $ 105))
          (SPADCALL (QREFELT $ 23) (CONS (|function| |LF;ishi|) $)
                    (QREFELT $ 105))
          (SPADCALL (QREFELT $ 24) (CONS (|function| |LF;ichi|) $)
                    (QREFELT $ 105))
          (SPADCALL (QREFELT $ 26) (CONS (|function| |LF;ierf|) $)
                    (QREFELT $ 105))
          (SPADCALL (QREFELT $ 27) (CONS (|function| |LF;ierfi|) $)
                    (QREFELT $ 105))
          (SPADCALL (QREFELT $ 25) (CONS (|function| |LF;ili2|) $)
                    (QREFELT $ 105))
          (SPADCALL (QREFELT $ 28) (CONS (|function| |LF;ifis|) $)
                    (QREFELT $ 105))
          (SPADCALL (QREFELT $ 29) (CONS (|function| |LF;ific|) $)
                    (QREFELT $ 105))
          (SPADCALL (QREFELT $ 16) (CONS (|function| |LF;iint|) $)
                    (QREFELT $ 107))
          (SPADCALL (QREFELT $ 17) (CONS (|function| |LF;iiint|) $)
                    (QREFELT $ 107))
          (SPADCALL (QREFELT $ 21) (CONS #'|LiouvillianFunction!0| $)
                    (QREFELT $ 110))
          (SPADCALL (QREFELT $ 22) (CONS #'|LiouvillianFunction!1| $)
                    (QREFELT $ 110))
          (SPADCALL (QREFELT $ 23) (CONS #'|LiouvillianFunction!2| $)
                    (QREFELT $ 110))
          (SPADCALL (QREFELT $ 24) (CONS #'|LiouvillianFunction!3| $)
                    (QREFELT $ 110))
          (SPADCALL (QREFELT $ 19) (CONS #'|LiouvillianFunction!4| $)
                    (QREFELT $ 110))
          (SPADCALL (QREFELT $ 20) (CONS #'|LiouvillianFunction!5| $)
                    (QREFELT $ 110))
          (SPADCALL (QREFELT $ 26) (CONS #'|LiouvillianFunction!6| $)
                    (QREFELT $ 110))
          (SPADCALL (QREFELT $ 27) (CONS #'|LiouvillianFunction!7| $)
                    (QREFELT $ 110))
          (SPADCALL (QREFELT $ 25) (CONS #'|LiouvillianFunction!8| $)
                    (QREFELT $ 110))
          (SPADCALL (QREFELT $ 28) (CONS #'|LiouvillianFunction!9| $)
                    (QREFELT $ 110))
          (SPADCALL (QREFELT $ 29) (CONS #'|LiouvillianFunction!10| $)
                    (QREFELT $ 110))
          (SPADCALL (QREFELT $ 16) '|%specialEqual|
                    (CONS (|function| |LF;eqint|) $) (QREFELT $ 125))
          (SPADCALL (QREFELT $ 16) '|%specialDiff|
                    (CONS (|function| |LF;dvint|) $) (QREFELT $ 125))
          (SPADCALL (QREFELT $ 17) '|%specialDiff|
                    (CONS (|function| |LF;dviint|) $) (QREFELT $ 125))
          (SPADCALL (QREFELT $ 18) '|%specialDiff|
                    (CONS (|function| |LF;dvdint|) $) (QREFELT $ 125))
          (SPADCALL (QREFELT $ 18) '|%specialDisp|
                    (CONS (|function| |LF;ddint|) $) (QREFELT $ 125))
          (COND
           ((|HasCategory| |#1| '(|ConvertibleTo| (|InputForm|)))
            (PROGN
             (SPADCALL (QREFELT $ 16) '|%specialInput|
                       (CONS (|function| |LF;inint|) $) (QREFELT $ 125))
             (SPADCALL (QREFELT $ 18) '|%specialInput|
                       (CONS (|function| |LF;indint|) $) (QREFELT $ 125)))))
          $))) 

(DEFUN |LiouvillianFunction!10| (|z1| $)
  (SPADCALL
   (SPADCALL
    (SPADCALL (SPADCALL (QREFELT $ 121)) (SPADCALL |z1| 2 (QREFELT $ 118))
              (QREFELT $ 79))
    (SPADCALL 2 (QREFELT $ 123)) (QREFELT $ 109))
   (QREFELT $ 111))) 

(DEFUN |LiouvillianFunction!9| (|z1| $)
  (SPADCALL
   (SPADCALL
    (SPADCALL (SPADCALL (QREFELT $ 121)) (SPADCALL |z1| 2 (QREFELT $ 118))
              (QREFELT $ 79))
    (SPADCALL 2 (QREFELT $ 123)) (QREFELT $ 109))
   (QREFELT $ 108))) 

(DEFUN |LiouvillianFunction!8| (|z1| $)
  (SPADCALL (SPADCALL |z1| (QREFELT $ 115))
            (SPADCALL (|spadConstant| $ 49) |z1| (QREFELT $ 92))
            (QREFELT $ 109))) 

(DEFUN |LiouvillianFunction!7| (|z1| $)
  (SPADCALL
   (SPADCALL 2 (SPADCALL (SPADCALL |z1| 2 (QREFELT $ 118)) (QREFELT $ 114))
             (QREFELT $ 120))
   (SPADCALL (SPADCALL (QREFELT $ 121)) (QREFELT $ 122)) (QREFELT $ 109))) 

(DEFUN |LiouvillianFunction!6| (|z1| $)
  (SPADCALL
   (SPADCALL 2
             (SPADCALL
              (SPADCALL (SPADCALL |z1| 2 (QREFELT $ 118)) (QREFELT $ 119))
              (QREFELT $ 114))
             (QREFELT $ 120))
   (SPADCALL (SPADCALL (QREFELT $ 121)) (QREFELT $ 122)) (QREFELT $ 109))) 

(DEFUN |LiouvillianFunction!5| (|z1| $)
  (SPADCALL (SPADCALL |z1| (QREFELT $ 115)) (QREFELT $ 116))) 

(DEFUN |LiouvillianFunction!4| (|z1| $)
  (SPADCALL (SPADCALL |z1| (QREFELT $ 114)) |z1| (QREFELT $ 109))) 

(DEFUN |LiouvillianFunction!3| (|z1| $)
  (SPADCALL (SPADCALL |z1| (QREFELT $ 113)) |z1| (QREFELT $ 109))) 

(DEFUN |LiouvillianFunction!2| (|z1| $)
  (SPADCALL (SPADCALL |z1| (QREFELT $ 112)) |z1| (QREFELT $ 109))) 

(DEFUN |LiouvillianFunction!1| (|z1| $)
  (SPADCALL (SPADCALL |z1| (QREFELT $ 111)) |z1| (QREFELT $ 109))) 

(DEFUN |LiouvillianFunction!0| (|z1| $)
  (SPADCALL (SPADCALL |z1| (QREFELT $ 108)) |z1| (QREFELT $ 109))) 

(MAKEPROP '|LiouvillianFunction| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) 'PRIM
              (|Symbol|) (0 . |new|) (4 . |coerce|) '|dummy| (|BasicOperator|)
              (|CommonOperators|) (9 . |operator|) '|opint| '|opiint| '|opdint|
              '|opei| '|opli| '|opsi| '|opci| '|opshi| '|opchi| '|opli2|
              '|operf| '|operfi| '|opfis| '|opfic| (14 . |elt|) |LF;Si;2F;1|
              |LF;Ci;2F;2| |LF;Shi;2F;3| |LF;Chi;2F;4| |LF;Ei;2F;5|
              |LF;erf;2F;6| |LF;erfi;2F;7| |LF;li;2F;8| |LF;dilog;2F;9|
              |LF;fresnelS;2F;10| |LF;fresnelC;2F;11| (|Boolean|) (20 . |has?|)
              |LF;belong?;BoB;12| (26 . |zero?|) (31 . |Zero|) (35 . |kernel|)
              (41 . |One|) (45 . |One|) (49 . =) (|List| 7) (55 . |second|)
              (|Kernel| $) (60 . |retract|) (65 . |third|) (70 . |eval|)
              (|Kernel| 7) (77 . |kernel|) (82 . |coerce|) (|List| $)
              (87 . |elt|) |LF;integral;FSF;23| (93 . |kernel|) (|OutputForm|)
              (99 . |coerce|) (104 . |coerce|) (109 . |hconcat|) (115 . *)
              (121 . |int|) (128 . |argument|) (133 . |operator|) (138 . =)
              (144 . =) (|Integer|) (150 . |elt|) (|List| 53) (156 . |subst|)
              (163 . |differentiate|) (169 . *) (175 . +) (|Union| $ '"failed")
              (|NonNegativeInteger|) (181 . |exquo|) (187 . |rest|)
              (|Mapping| 42 7) (193 . |every?|) (199 . |first|)
              (205 . |retract|) (|List| 9) (210 . |position|) (216 . |Zero|)
              (220 . -) (|SegmentBinding| 7) (226 . |variable|) (|Segment| 7)
              (231 . |segment|) (236 . |low|) (241 . |high|)
              |LF;integral;FSbF;31| (246 . |is?|) (252 . |is?|)
              |LF;operator;2Bo;34| (|Mapping| 7 7)
              (|BasicOperatorFunctions1| 7) (258 . |evaluate|) (|Mapping| 7 51)
              (264 . |evaluate|) (270 . |sin|) (275 . /) (281 . |derivative|)
              (287 . |cos|) (292 . |sinh|) (297 . |cosh|) (302 . |exp|)
              (307 . |log|) (312 . |inv|) (|PositiveInteger|) (317 . ^)
              (323 . -) (328 . *) (334 . |pi|) (338 . |sqrt|) (343 . |coerce|)
              (|None|) (348 . |setProperty|) (|InputForm|) (355 . |convert|)
              (360 . |convert|) (365 . |convert|))
           '#(|operator| 370 |li| 375 |integral| 380 |fresnelS| 392 |fresnelC|
              397 |erfi| 402 |erf| 407 |dilog| 412 |belong?| 417 |Si| 422 |Shi|
              427 |Ei| 432 |Ci| 437 |Chi| 442)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|belong?| ((|Boolean|) (|BasicOperator|))) T)
                              '((|operator|
                                 ((|BasicOperator|) (|BasicOperator|)))
                                T)
                              '((|Ei| (|#2| |#2|)) T) '((|Si| (|#2| |#2|)) T)
                              '((|Ci| (|#2| |#2|)) T) '((|Shi| (|#2| |#2|)) T)
                              '((|Chi| (|#2| |#2|)) T) '((|li| (|#2| |#2|)) T)
                              '((|erf| (|#2| |#2|)) T)
                              '((|erfi| (|#2| |#2|)) T)
                              '((|dilog| (|#2| |#2|)) T)
                              '((|fresnelS| (|#2| |#2|)) T)
                              '((|fresnelC| (|#2| |#2|)) T)
                              '((|integral| (|#2| |#2| (|Symbol|))) T)
                              '((|integral|
                                 (|#2| |#2| (|SegmentBinding| |#2|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 129
                                            '(0 9 0 10 1 7 0 9 11 1 14 13 9 15
                                              2 7 0 13 0 30 2 13 42 0 9 43 1 7
                                              42 0 45 0 7 0 46 2 7 0 13 0 47 0
                                              6 0 48 0 7 0 49 2 7 42 0 0 50 1
                                              51 7 0 52 1 7 53 0 54 1 51 7 0 55
                                              3 7 0 0 53 0 56 1 57 0 9 58 1 7 0
                                              53 59 2 7 0 13 60 61 2 7 0 13 60
                                              63 1 7 64 0 65 1 9 64 0 66 2 64 0
                                              0 0 67 2 64 0 0 0 68 3 64 0 0 0 0
                                              69 1 57 51 0 70 1 57 13 0 71 2 13
                                              42 0 0 72 2 51 42 0 0 73 2 51 7 0
                                              74 75 3 7 0 0 76 60 77 2 7 0 0 9
                                              78 2 7 0 0 0 79 2 7 0 0 0 80 2 82
                                              81 0 0 83 2 51 0 0 82 84 2 51 42
                                              85 0 86 2 51 0 0 82 87 1 7 9 0 88
                                              2 89 74 9 0 90 0 6 0 91 2 7 0 0 0
                                              92 1 93 9 0 94 1 93 95 0 96 1 95
                                              7 0 97 1 95 7 0 98 2 7 42 0 9 100
                                              2 13 42 0 9 101 2 104 13 13 103
                                              105 2 104 13 13 106 107 1 7 0 0
                                              108 2 7 0 0 0 109 2 104 13 13 103
                                              110 1 7 0 0 111 1 7 0 0 112 1 7 0
                                              0 113 1 7 0 0 114 1 7 0 0 115 1 7
                                              0 0 116 2 7 0 0 117 118 1 7 0 0
                                              119 2 7 0 117 0 120 0 7 0 121 1 7
                                              0 0 122 1 7 0 74 123 3 13 0 0 9
                                              124 125 1 9 126 0 127 1 126 0 60
                                              128 1 7 126 0 129 1 0 13 13 102 1
                                              0 7 7 38 2 0 7 7 93 99 2 0 7 7 9
                                              62 1 0 7 7 40 1 0 7 7 41 1 0 7 7
                                              37 1 0 7 7 36 1 0 7 7 39 1 0 42
                                              13 44 1 0 7 7 31 1 0 7 7 33 1 0 7
                                              7 35 1 0 7 7 32 1 0 7 7 34)))))
           '|lookupComplete|)) 
