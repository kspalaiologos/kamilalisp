
(SDEFUN |UTSCAT-;zero?;SB;1| ((|x| (S)) ($ (|Boolean|)))
        (SPROG ((|coefs| (|Stream| |Coef|)))
               (SEQ
                (COND
                 ((SPADCALL (LETT |coefs| (SPADCALL |x| (QREFELT $ 9)))
                            (QREFELT $ 11))
                  'T)
                 ('T
                  (SEQ
                   (COND
                    ((SPADCALL (SPADCALL |coefs| (QREFELT $ 12))
                               (QREFELT $ 13))
                     (COND
                      ((SPADCALL (SPADCALL |coefs| (QREFELT $ 14))
                                 (QREFELT $ 11))
                       (EXIT 'T)))))
                   (EXIT NIL))))))) 

(PUT '|UTSCAT-;factorials?| '|SPADreplace| '(XLAM NIL NIL)) 

(SDEFUN |UTSCAT-;factorials?| (($ (|Boolean|))) NIL) 

(SDEFUN |UTSCAT-;termOutput|
        ((|k| (|Integer|)) (|c| (|Coef|)) (|vv| (|OutputForm|))
         ($ (|OutputForm|)))
        (SPROG ((|mon| (|OutputForm|)))
               (SEQ
                (COND ((EQL |k| 0) (SPADCALL |c| (QREFELT $ 19)))
                      (#1='T
                       (SEQ
                        (LETT |mon|
                              (COND ((EQL |k| 1) |vv|)
                                    (#1#
                                     (SPADCALL |vv|
                                               (SPADCALL |k| (QREFELT $ 23))
                                               (QREFELT $ 24)))))
                        (EXIT
                         (COND
                          ((SPADCALL |c| (|spadConstant| $ 21) (QREFELT $ 25))
                           |mon|)
                          ((SPADCALL |c|
                                     (SPADCALL (|spadConstant| $ 21)
                                               (QREFELT $ 26))
                                     (QREFELT $ 25))
                           (SPADCALL |mon| (QREFELT $ 27)))
                          (#1#
                           (SPADCALL (SPADCALL |c| (QREFELT $ 19)) |mon|
                                     (QREFELT $ 28))))))))))) 

(PUT '|UTSCAT-;showAll?| '|SPADreplace| '(XLAM NIL |$streamsShowAll|)) 

(SDEFUN |UTSCAT-;showAll?| (($ (|Boolean|))) |$streamsShowAll|) 

(SDEFUN |UTSCAT-;coerce;SOf;5| ((|p| (S)) ($ (|OutputForm|)))
        (SPROG
         ((|l| (|List| (|OutputForm|))) (|uu| (|Stream| |Coef|))
          (|uu1| (|Stream| |Coef|)) (|n| NIL) (#1=#:G770 NIL)
          (|count| (|NonNegativeInteger|)) (|vv| (|OutputForm|))
          (|cen| (|Coef|)) (|var| (|Symbol|)))
         (SEQ
          (COND
           ((SPADCALL (LETT |uu| (SPADCALL |p| (QREFELT $ 9))) (QREFELT $ 11))
            (SPADCALL (|spadConstant| $ 17) (QREFELT $ 19)))
           (#2='T
            (SEQ (LETT |var| (SPADCALL |p| (QREFELT $ 30)))
                 (LETT |cen| (SPADCALL |p| (QREFELT $ 31)))
                 (LETT |vv|
                       (COND
                        ((SPADCALL |cen| (QREFELT $ 13))
                         (SPADCALL |var| (QREFELT $ 32)))
                        (#2#
                         (SPADCALL
                          (SPADCALL (SPADCALL |var| (QREFELT $ 32))
                                    (SPADCALL |cen| (QREFELT $ 19))
                                    (QREFELT $ 33))
                          (QREFELT $ 34)))))
                 (LETT |count| |$streamCount|) (LETT |l| NIL)
                 (SEQ (LETT |n| 0) (LETT #1# |count|) G190
                      (COND
                       ((OR (|greater_SI| |n| #1#)
                            (NULL (NULL (SPADCALL |uu| (QREFELT $ 11)))))
                        (GO G191)))
                      (SEQ
                       (COND
                        ((SPADCALL (SPADCALL |uu| (QREFELT $ 12))
                                   (|spadConstant| $ 17) (QREFELT $ 35))
                         (LETT |l|
                               (CONS
                                (|UTSCAT-;termOutput| |n|
                                 (SPADCALL |uu| (QREFELT $ 12)) |vv| $)
                                |l|))))
                       (EXIT (LETT |uu| (SPADCALL |uu| (QREFELT $ 14)))))
                      (LETT |n| (|inc_SI| |n|)) (GO G190) G191 (EXIT NIL))
                 (COND
                  ((|UTSCAT-;showAll?| $)
                   (SEQ (LETT |uu1| |uu|)
                        (EXIT
                         (SEQ (LETT |n| (+ |count| 1)) G190
                              (COND
                               ((NULL
                                 (COND
                                  ((SPADCALL |uu| (QREFELT $ 36))
                                   (NULL
                                    (SPADCALL |uu1|
                                              (SPADCALL |uu| (QREFELT $ 14))
                                              (QREFELT $ 37))))
                                  ('T NIL)))
                                (GO G191)))
                              (SEQ
                               (COND
                                ((SPADCALL (SPADCALL |uu| (QREFELT $ 12))
                                           (|spadConstant| $ 17)
                                           (QREFELT $ 35))
                                 (LETT |l|
                                       (CONS
                                        (|UTSCAT-;termOutput| |n|
                                         (SPADCALL |uu| (QREFELT $ 12)) |vv| $)
                                        |l|))))
                               (COND
                                ((ODDP |n|)
                                 (LETT |uu1| (SPADCALL |uu1| (QREFELT $ 14)))))
                               (EXIT
                                (LETT |uu| (SPADCALL |uu| (QREFELT $ 14)))))
                              (LETT |n| (+ |n| 1)) (GO G190) G191
                              (EXIT NIL))))))
                 (LETT |l|
                       (COND ((SPADCALL |uu| (QREFELT $ 38)) |l|)
                             (#2#
                              (SEQ
                               (COND
                                ((SPADCALL |uu| (SPADCALL |uu| (QREFELT $ 14))
                                           (QREFELT $ 37))
                                 (COND
                                  ((SPADCALL (SPADCALL |uu| (QREFELT $ 12))
                                             (|spadConstant| $ 17)
                                             (QREFELT $ 25))
                                   (EXIT |l|)))))
                               (EXIT
                                (CONS
                                 (SPADCALL (SPADCALL 'O (QREFELT $ 32))
                                           (LIST
                                            (SPADCALL |vv|
                                                      (SPADCALL |n|
                                                                (QREFELT $ 40))
                                                      (QREFELT $ 24)))
                                           (QREFELT $ 42))
                                 |l|))))))
                 (EXIT
                  (COND
                   ((NULL |l|) (SPADCALL (|spadConstant| $ 17) (QREFELT $ 19)))
                   (#2#
                    (SPADCALL (ELT $ 43) (NREVERSE |l|) (QREFELT $ 46))))))))))) 

(SDEFUN |UTSCAT-;^;SCoefS;6| ((|x| (S)) (|r| (|Coef|)) ($ (S)))
        (SPADCALL (SPADCALL |r| (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 49))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;^;3S;7| ((|x| (S)) (|y| (S)) ($ (S)))
        (SPADCALL
         (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (SPADCALL |y| (QREFELT $ 9))
                   (QREFELT $ 53))
         (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;^;SFS;8| ((|x| (S)) (|r| (|Fraction| (|Integer|))) ($ (S)))
        (SPADCALL (SPADCALL |r| (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 56))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;exp;2S;9| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 58))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;log;2S;10| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 60))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;sin;2S;11| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 62))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;cos;2S;12| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 64))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;tan;2S;13| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 66))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;cot;2S;14| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 68))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;sec;2S;15| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 70))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;csc;2S;16| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 72))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;asin;2S;17| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 74))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;acos;2S;18| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 76))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;atan;2S;19| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 78))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;acot;2S;20| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 80))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;asec;2S;21| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 82))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;acsc;2S;22| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 84))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;sinh;2S;23| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 86))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;cosh;2S;24| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 88))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;tanh;2S;25| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 90))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;coth;2S;26| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 92))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;sech;2S;27| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 94))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;csch;2S;28| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 96))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;asinh;2S;29| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 98))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;acosh;2S;30| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 100))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;atanh;2S;31| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 102))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;acoth;2S;32| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 104))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;asech;2S;33| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 106))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;acsch;2S;34| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 108))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;^;3S;35| ((|x| (S)) (|y| (S)) ($ (S)))
        (SPADCALL
         (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (SPADCALL |y| (QREFELT $ 9))
                   (QREFELT $ 111))
         (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;^;SFS;36| ((|x| (S)) (|r| (|Fraction| (|Integer|))) ($ (S)))
        (SPROG
         ((|ratPow| (|Stream| |Coef|)) (|onePlusX| (|Stream| |Coef|))
          (|coefs| (|Stream| |Coef|)))
         (SEQ (LETT |coefs| (SPADCALL |x| (QREFELT $ 9)))
              (EXIT
               (COND
                ((SPADCALL |coefs| (QREFELT $ 11))
                 (COND ((SPADCALL |r| (QREFELT $ 112)) (|spadConstant| $ 16))
                       ((SPADCALL |r| (QREFELT $ 113))
                        (|error| "0^0 undefined"))
                       ('T (|error| "0 raised to a negative power"))))
                ((NULL
                  (SPADCALL (SPADCALL |coefs| (QREFELT $ 12))
                            (|spadConstant| $ 21) (QREFELT $ 25)))
                 (|error| "^: constant coefficient should be 1"))
                ('T
                 (SEQ
                  (LETT |coefs|
                        (SPADCALL (|spadConstant| $ 17)
                                  (SPADCALL |coefs| (QREFELT $ 14))
                                  (QREFELT $ 114)))
                  (LETT |onePlusX|
                        (SPADCALL
                         (SPADCALL (|spadConstant| $ 21) 0 (QREFELT $ 115))
                         (SPADCALL (|spadConstant| $ 21) 1 (QREFELT $ 115))
                         (QREFELT $ 116)))
                  (LETT |ratPow| (SPADCALL |r| |onePlusX| (QREFELT $ 56)))
                  (EXIT
                   (SPADCALL (SPADCALL |ratPow| |coefs| (QREFELT $ 117))
                             (QREFELT $ 50)))))))))) 

(SDEFUN |UTSCAT-;exp;2S;37| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 118))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;log;2S;38| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 119))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;sin;2S;39| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 120))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;cos;2S;40| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 121))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;tan;2S;41| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 122))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;cot;2S;42| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 123))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;sec;2S;43| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 124))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;csc;2S;44| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 125))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;asin;2S;45| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 126))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;acos;2S;46| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 127))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;atan;2S;47| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 128))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;acot;2S;48| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 129))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;asec;2S;49| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 130))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;acsc;2S;50| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 131))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;sinh;2S;51| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 132))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;cosh;2S;52| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 133))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;tanh;2S;53| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 134))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;coth;2S;54| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 135))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;sech;2S;55| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 136))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;csch;2S;56| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 137))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;asinh;2S;57| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 138))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;acosh;2S;58| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 139))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;atanh;2S;59| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 140))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;acoth;2S;60| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 141))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;asech;2S;61| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 142))
                  (QREFELT $ 50))) 

(SDEFUN |UTSCAT-;acsch;2S;62| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 143))
                  (QREFELT $ 50))) 

(DECLAIM (NOTINLINE |UnivariateTaylorSeriesCategory&;|)) 

(DEFUN |UnivariateTaylorSeriesCategory&| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|UnivariateTaylorSeriesCategory&| DV$1 DV$2))
          (LETT $ (GETREFV 145))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#2|
                                                             '(|Field|))))))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|testBitVector| |pv$| 1)
            (QSETREFV $ 51
                      (CONS (|dispatchFunction| |UTSCAT-;^;SCoefS;6|) $))))
          (COND
           ((|HasCategory| |#2| '(|Algebra| (|Fraction| (|Integer|))))
            (COND
             ((|HasCategory| |#2| '(|CommutativeRing|))
              (PROGN
               (QSETREFV $ 54 (CONS (|dispatchFunction| |UTSCAT-;^;3S;7|) $))
               (QSETREFV $ 57 (CONS (|dispatchFunction| |UTSCAT-;^;SFS;8|) $))
               (QSETREFV $ 59 (CONS (|dispatchFunction| |UTSCAT-;exp;2S;9|) $))
               (QSETREFV $ 61
                         (CONS (|dispatchFunction| |UTSCAT-;log;2S;10|) $))
               (QSETREFV $ 63
                         (CONS (|dispatchFunction| |UTSCAT-;sin;2S;11|) $))
               (QSETREFV $ 65
                         (CONS (|dispatchFunction| |UTSCAT-;cos;2S;12|) $))
               (QSETREFV $ 67
                         (CONS (|dispatchFunction| |UTSCAT-;tan;2S;13|) $))
               (QSETREFV $ 69
                         (CONS (|dispatchFunction| |UTSCAT-;cot;2S;14|) $))
               (QSETREFV $ 71
                         (CONS (|dispatchFunction| |UTSCAT-;sec;2S;15|) $))
               (QSETREFV $ 73
                         (CONS (|dispatchFunction| |UTSCAT-;csc;2S;16|) $))
               (QSETREFV $ 75
                         (CONS (|dispatchFunction| |UTSCAT-;asin;2S;17|) $))
               (QSETREFV $ 77
                         (CONS (|dispatchFunction| |UTSCAT-;acos;2S;18|) $))
               (QSETREFV $ 79
                         (CONS (|dispatchFunction| |UTSCAT-;atan;2S;19|) $))
               (QSETREFV $ 81
                         (CONS (|dispatchFunction| |UTSCAT-;acot;2S;20|) $))
               (QSETREFV $ 83
                         (CONS (|dispatchFunction| |UTSCAT-;asec;2S;21|) $))
               (QSETREFV $ 85
                         (CONS (|dispatchFunction| |UTSCAT-;acsc;2S;22|) $))
               (QSETREFV $ 87
                         (CONS (|dispatchFunction| |UTSCAT-;sinh;2S;23|) $))
               (QSETREFV $ 89
                         (CONS (|dispatchFunction| |UTSCAT-;cosh;2S;24|) $))
               (QSETREFV $ 91
                         (CONS (|dispatchFunction| |UTSCAT-;tanh;2S;25|) $))
               (QSETREFV $ 93
                         (CONS (|dispatchFunction| |UTSCAT-;coth;2S;26|) $))
               (QSETREFV $ 95
                         (CONS (|dispatchFunction| |UTSCAT-;sech;2S;27|) $))
               (QSETREFV $ 97
                         (CONS (|dispatchFunction| |UTSCAT-;csch;2S;28|) $))
               (QSETREFV $ 99
                         (CONS (|dispatchFunction| |UTSCAT-;asinh;2S;29|) $))
               (QSETREFV $ 101
                         (CONS (|dispatchFunction| |UTSCAT-;acosh;2S;30|) $))
               (QSETREFV $ 103
                         (CONS (|dispatchFunction| |UTSCAT-;atanh;2S;31|) $))
               (QSETREFV $ 105
                         (CONS (|dispatchFunction| |UTSCAT-;acoth;2S;32|) $))
               (QSETREFV $ 107
                         (CONS (|dispatchFunction| |UTSCAT-;asech;2S;33|) $))
               (QSETREFV $ 109
                         (CONS (|dispatchFunction| |UTSCAT-;acsch;2S;34|) $))))
             ('T
              (PROGN
               (QSETREFV $ 54 (CONS (|dispatchFunction| |UTSCAT-;^;3S;35|) $))
               (QSETREFV $ 57 (CONS (|dispatchFunction| |UTSCAT-;^;SFS;36|) $))
               (QSETREFV $ 59
                         (CONS (|dispatchFunction| |UTSCAT-;exp;2S;37|) $))
               (QSETREFV $ 61
                         (CONS (|dispatchFunction| |UTSCAT-;log;2S;38|) $))
               (QSETREFV $ 63
                         (CONS (|dispatchFunction| |UTSCAT-;sin;2S;39|) $))
               (QSETREFV $ 65
                         (CONS (|dispatchFunction| |UTSCAT-;cos;2S;40|) $))
               (QSETREFV $ 67
                         (CONS (|dispatchFunction| |UTSCAT-;tan;2S;41|) $))
               (QSETREFV $ 69
                         (CONS (|dispatchFunction| |UTSCAT-;cot;2S;42|) $))
               (QSETREFV $ 71
                         (CONS (|dispatchFunction| |UTSCAT-;sec;2S;43|) $))
               (QSETREFV $ 73
                         (CONS (|dispatchFunction| |UTSCAT-;csc;2S;44|) $))
               (QSETREFV $ 75
                         (CONS (|dispatchFunction| |UTSCAT-;asin;2S;45|) $))
               (QSETREFV $ 77
                         (CONS (|dispatchFunction| |UTSCAT-;acos;2S;46|) $))
               (QSETREFV $ 79
                         (CONS (|dispatchFunction| |UTSCAT-;atan;2S;47|) $))
               (QSETREFV $ 81
                         (CONS (|dispatchFunction| |UTSCAT-;acot;2S;48|) $))
               (QSETREFV $ 83
                         (CONS (|dispatchFunction| |UTSCAT-;asec;2S;49|) $))
               (QSETREFV $ 85
                         (CONS (|dispatchFunction| |UTSCAT-;acsc;2S;50|) $))
               (QSETREFV $ 87
                         (CONS (|dispatchFunction| |UTSCAT-;sinh;2S;51|) $))
               (QSETREFV $ 89
                         (CONS (|dispatchFunction| |UTSCAT-;cosh;2S;52|) $))
               (QSETREFV $ 91
                         (CONS (|dispatchFunction| |UTSCAT-;tanh;2S;53|) $))
               (QSETREFV $ 93
                         (CONS (|dispatchFunction| |UTSCAT-;coth;2S;54|) $))
               (QSETREFV $ 95
                         (CONS (|dispatchFunction| |UTSCAT-;sech;2S;55|) $))
               (QSETREFV $ 97
                         (CONS (|dispatchFunction| |UTSCAT-;csch;2S;56|) $))
               (QSETREFV $ 99
                         (CONS (|dispatchFunction| |UTSCAT-;asinh;2S;57|) $))
               (QSETREFV $ 101
                         (CONS (|dispatchFunction| |UTSCAT-;acosh;2S;58|) $))
               (QSETREFV $ 103
                         (CONS (|dispatchFunction| |UTSCAT-;atanh;2S;59|) $))
               (QSETREFV $ 105
                         (CONS (|dispatchFunction| |UTSCAT-;acoth;2S;60|) $))
               (QSETREFV $ 107
                         (CONS (|dispatchFunction| |UTSCAT-;asech;2S;61|) $))
               (QSETREFV $ 109
                         (CONS (|dispatchFunction| |UTSCAT-;acsch;2S;62|)
                               $)))))))
          $))) 

(MAKEPROP '|UnivariateTaylorSeriesCategory&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|Stream| 7) (0 . |coefficients|) (|Boolean|) (5 . |empty?|)
              (10 . |frst|) (15 . |zero?|) (20 . |rst|) |UTSCAT-;zero?;SB;1|
              (25 . |Zero|) (29 . |Zero|) (|OutputForm|) (33 . |coerce|)
              (38 . |One|) (42 . |One|) (|Integer|) (46 . |coerce|) (51 . ^)
              (57 . =) (63 . -) (68 . -) (73 . *) (|Symbol|) (79 . |variable|)
              (84 . |center|) (89 . |coerce|) (94 . -) (100 . |paren|)
              (105 . ~=) (111 . |explicitEntries?|) (116 . |eq?|)
              (122 . |explicitlyEmpty?|) (|NonNegativeInteger|)
              (127 . |coerce|) (|List| $) (132 . |prefix|) (138 . +)
              (|Mapping| 18 18 18) (|List| 18) (144 . |reduce|)
              |UTSCAT-;coerce;SOf;5| (|StreamTaylorSeriesOperations| 7)
              (150 . |power|) (156 . |series|) (161 . ^)
              (|StreamTranscendentalFunctions| 7) (167 . ^) (173 . ^)
              (|Fraction| 22) (179 . |powern|) (185 . ^) (191 . |exp|)
              (196 . |exp|) (201 . |log|) (206 . |log|) (211 . |sin|)
              (216 . |sin|) (221 . |cos|) (226 . |cos|) (231 . |tan|)
              (236 . |tan|) (241 . |cot|) (246 . |cot|) (251 . |sec|)
              (256 . |sec|) (261 . |csc|) (266 . |csc|) (271 . |asin|)
              (276 . |asin|) (281 . |acos|) (286 . |acos|) (291 . |atan|)
              (296 . |atan|) (301 . |acot|) (306 . |acot|) (311 . |asec|)
              (316 . |asec|) (321 . |acsc|) (326 . |acsc|) (331 . |sinh|)
              (336 . |sinh|) (341 . |cosh|) (346 . |cosh|) (351 . |tanh|)
              (356 . |tanh|) (361 . |coth|) (366 . |coth|) (371 . |sech|)
              (376 . |sech|) (381 . |csch|) (386 . |csch|) (391 . |asinh|)
              (396 . |asinh|) (401 . |acosh|) (406 . |acosh|) (411 . |atanh|)
              (416 . |atanh|) (421 . |acoth|) (426 . |acoth|) (431 . |asech|)
              (436 . |asech|) (441 . |acsch|) (446 . |acsch|)
              (|StreamTranscendentalFunctionsNonCommutative| 7) (451 . ^)
              (457 . |positive?|) (462 . |zero?|) (467 . |concat|)
              (473 . |monom|) (479 . +) (485 . |compose|) (491 . |exp|)
              (496 . |log|) (501 . |sin|) (506 . |cos|) (511 . |tan|)
              (516 . |cot|) (521 . |sec|) (526 . |csc|) (531 . |asin|)
              (536 . |acos|) (541 . |atan|) (546 . |acot|) (551 . |asec|)
              (556 . |acsc|) (561 . |sinh|) (566 . |cosh|) (571 . |tanh|)
              (576 . |coth|) (581 . |sech|) (586 . |csch|) (591 . |asinh|)
              (596 . |acosh|) (601 . |atanh|) (606 . |acoth|) (611 . |asech|)
              (616 . |acsch|) (|PositiveInteger|))
           '#(|zero?| 621 |tanh| 626 |tan| 631 |sinh| 636 |sin| 641 |sech| 646
              |sec| 651 |log| 656 |exp| 661 |csch| 666 |csc| 671 |coth| 676
              |cot| 681 |cosh| 686 |cos| 691 |coerce| 696 |atanh| 701 |atan|
              706 |asinh| 711 |asin| 716 |asech| 721 |asec| 726 |acsch| 731
              |acsc| 736 |acoth| 741 |acot| 746 |acosh| 751 |acos| 756 ^ 761)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((^ (|#1| |#1| |#2|)) T)
                                   '((^ (|#1| |#1| (|Fraction| (|Integer|))))
                                     T)
                                   '((|tan| (|#1| |#1|)) T)
                                   '((|sin| (|#1| |#1|)) T)
                                   '((|sec| (|#1| |#1|)) T)
                                   '((|csc| (|#1| |#1|)) T)
                                   '((|cot| (|#1| |#1|)) T)
                                   '((|cos| (|#1| |#1|)) T)
                                   '((|acos| (|#1| |#1|)) T)
                                   '((|acot| (|#1| |#1|)) T)
                                   '((|acsc| (|#1| |#1|)) T)
                                   '((|asec| (|#1| |#1|)) T)
                                   '((|asin| (|#1| |#1|)) T)
                                   '((|atan| (|#1| |#1|)) T)
                                   '((|cosh| (|#1| |#1|)) T)
                                   '((|coth| (|#1| |#1|)) T)
                                   '((|csch| (|#1| |#1|)) T)
                                   '((|sech| (|#1| |#1|)) T)
                                   '((|sinh| (|#1| |#1|)) T)
                                   '((|tanh| (|#1| |#1|)) T)
                                   '((|acosh| (|#1| |#1|)) T)
                                   '((|acoth| (|#1| |#1|)) T)
                                   '((|acsch| (|#1| |#1|)) T)
                                   '((|asech| (|#1| |#1|)) T)
                                   '((|asinh| (|#1| |#1|)) T)
                                   '((|atanh| (|#1| |#1|)) T)
                                   '((|log| (|#1| |#1|)) T)
                                   '((|exp| (|#1| |#1|)) T)
                                   '((^ (|#1| |#1| |#1|)) T)
                                   '((|zero?| ((|Boolean|) |#1|)) T)
                                   '((^ (|#1| |#1| (|NonNegativeInteger|))) T)
                                   '((|coerce| (|#1| (|Integer|))) T)
                                   '((|coerce| (|#1| |#1|)) T)
                                   '((|coerce| (|#1| |#2|)) T)
                                   '((|coerce| (|#1| (|Fraction| (|Integer|))))
                                     T)
                                   '((^ (|#1| |#1| (|PositiveInteger|))) T)
                                   '((|coerce| ((|OutputForm|) |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 143
                                            '(1 6 8 0 9 1 8 10 0 11 1 8 7 0 12
                                              1 7 10 0 13 1 8 0 0 14 0 6 0 16 0
                                              7 0 17 1 7 18 0 19 0 6 0 20 0 7 0
                                              21 1 22 18 0 23 2 18 0 0 0 24 2 7
                                              10 0 0 25 1 7 0 0 26 1 18 0 0 27
                                              2 18 0 0 0 28 1 6 29 0 30 1 6 7 0
                                              31 1 29 18 0 32 2 18 0 0 0 33 1
                                              18 0 0 34 2 7 10 0 0 35 1 8 10 0
                                              36 2 8 10 0 0 37 1 8 10 0 38 1 39
                                              18 0 40 2 18 0 0 41 42 2 18 0 0 0
                                              43 2 45 18 44 0 46 2 48 8 7 8 49
                                              1 6 0 8 50 2 0 0 0 7 51 2 52 8 8
                                              8 53 2 0 0 0 0 54 2 48 8 55 8 56
                                              2 0 0 0 55 57 1 52 8 8 58 1 0 0 0
                                              59 1 52 8 8 60 1 0 0 0 61 1 52 8
                                              8 62 1 0 0 0 63 1 52 8 8 64 1 0 0
                                              0 65 1 52 8 8 66 1 0 0 0 67 1 52
                                              8 8 68 1 0 0 0 69 1 52 8 8 70 1 0
                                              0 0 71 1 52 8 8 72 1 0 0 0 73 1
                                              52 8 8 74 1 0 0 0 75 1 52 8 8 76
                                              1 0 0 0 77 1 52 8 8 78 1 0 0 0 79
                                              1 52 8 8 80 1 0 0 0 81 1 52 8 8
                                              82 1 0 0 0 83 1 52 8 8 84 1 0 0 0
                                              85 1 52 8 8 86 1 0 0 0 87 1 52 8
                                              8 88 1 0 0 0 89 1 52 8 8 90 1 0 0
                                              0 91 1 52 8 8 92 1 0 0 0 93 1 52
                                              8 8 94 1 0 0 0 95 1 52 8 8 96 1 0
                                              0 0 97 1 52 8 8 98 1 0 0 0 99 1
                                              52 8 8 100 1 0 0 0 101 1 52 8 8
                                              102 1 0 0 0 103 1 52 8 8 104 1 0
                                              0 0 105 1 52 8 8 106 1 0 0 0 107
                                              1 52 8 8 108 1 0 0 0 109 2 110 8
                                              8 8 111 1 55 10 0 112 1 55 10 0
                                              113 2 8 0 7 0 114 2 48 8 7 22 115
                                              2 48 8 8 8 116 2 48 8 8 8 117 1
                                              110 8 8 118 1 110 8 8 119 1 110 8
                                              8 120 1 110 8 8 121 1 110 8 8 122
                                              1 110 8 8 123 1 110 8 8 124 1 110
                                              8 8 125 1 110 8 8 126 1 110 8 8
                                              127 1 110 8 8 128 1 110 8 8 129 1
                                              110 8 8 130 1 110 8 8 131 1 110 8
                                              8 132 1 110 8 8 133 1 110 8 8 134
                                              1 110 8 8 135 1 110 8 8 136 1 110
                                              8 8 137 1 110 8 8 138 1 110 8 8
                                              139 1 110 8 8 140 1 110 8 8 141 1
                                              110 8 8 142 1 110 8 8 143 1 0 10
                                              0 15 1 0 0 0 91 1 0 0 0 67 1 0 0
                                              0 87 1 0 0 0 63 1 0 0 0 95 1 0 0
                                              0 71 1 0 0 0 61 1 0 0 0 59 1 0 0
                                              0 97 1 0 0 0 73 1 0 0 0 93 1 0 0
                                              0 69 1 0 0 0 89 1 0 0 0 65 1 0 18
                                              0 47 1 0 0 0 103 1 0 0 0 79 1 0 0
                                              0 99 1 0 0 0 75 1 0 0 0 107 1 0 0
                                              0 83 1 0 0 0 109 1 0 0 0 85 1 0 0
                                              0 105 1 0 0 0 81 1 0 0 0 101 1 0
                                              0 0 77 2 0 0 0 55 57 2 0 0 0 7 51
                                              2 0 0 0 0 54)))))
           '|lookupComplete|)) 
