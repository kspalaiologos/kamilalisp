
(SDEFUN |STTFNC;exp;2S;1| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG ((|expx| (|Stream| |Coef|)))
               (SEQ
                (COND
                 ((SPADCALL |z| (QREFELT $ 12))
                  (SPADCALL (|spadConstant| $ 13) (QREFELT $ 15)))
                 ((SPADCALL (SPADCALL |z| (QREFELT $ 16)) (|spadConstant| $ 17)
                            (QREFELT $ 18))
                  (SEQ
                   (LETT |expx|
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 13) 1 (QREFELT $ 20))
                          (QREFELT $ 22)))
                   (EXIT (SPADCALL |expx| |z| (QREFELT $ 23)))))
                 ('T (|error| (STRCONC "exp: " (QREFELT $ 7)))))))) 

(SDEFUN |STTFNC;log;2S;2| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG ((|log1PlusX| (|Stream| |Coef|)))
               (SEQ
                (COND
                 ((OR (SPADCALL |z| (QREFELT $ 12))
                      (NULL
                       (SPADCALL (SPADCALL |z| (QREFELT $ 16))
                                 (|spadConstant| $ 13) (QREFELT $ 18))))
                  (|error| (STRCONC "log: " (QREFELT $ 8))))
                 ('T
                  (SEQ
                   (LETT |log1PlusX|
                         (SPADCALL
                          (SPADCALL
                           (SPADCALL (|spadConstant| $ 13) 0 (QREFELT $ 20))
                           (SPADCALL (|spadConstant| $ 13) 1 (QREFELT $ 20))
                           (QREFELT $ 25))
                          (QREFELT $ 26)))
                   (EXIT
                    (SPADCALL |log1PlusX|
                              (SPADCALL |z|
                                        (SPADCALL (|spadConstant| $ 13) 0
                                                  (QREFELT $ 20))
                                        (QREFELT $ 27))
                              (QREFELT $ 23))))))))) 

(SDEFUN |STTFNC;^;3S;3|
        ((|z1| (|Stream| |Coef|)) (|z2| (|Stream| |Coef|))
         ($ (|Stream| |Coef|)))
        (SPADCALL (SPADCALL (SPADCALL |z1| (QREFELT $ 28)) |z2| (QREFELT $ 29))
                  (QREFELT $ 24))) 

(SDEFUN |STTFNC;sin;2S;4| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG ((|sinx| (|Stream| |Coef|)))
               (SEQ
                (COND
                 ((SPADCALL |z| (QREFELT $ 12))
                  (SPADCALL (|spadConstant| $ 17) (QREFELT $ 15)))
                 ((SPADCALL (SPADCALL |z| (QREFELT $ 16)) (|spadConstant| $ 17)
                            (QREFELT $ 18))
                  (SEQ
                   (LETT |sinx|
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 13) 1 (QREFELT $ 20))
                          (QREFELT $ 31)))
                   (EXIT (SPADCALL |sinx| |z| (QREFELT $ 23)))))
                 ('T (|error| (STRCONC "sin: " (QREFELT $ 7)))))))) 

(SDEFUN |STTFNC;cos;2S;5| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG ((|cosx| (|Stream| |Coef|)))
               (SEQ
                (COND
                 ((SPADCALL |z| (QREFELT $ 12))
                  (SPADCALL (|spadConstant| $ 13) (QREFELT $ 15)))
                 ((SPADCALL (SPADCALL |z| (QREFELT $ 16)) (|spadConstant| $ 17)
                            (QREFELT $ 18))
                  (SEQ
                   (LETT |cosx|
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 13) 1 (QREFELT $ 20))
                          (QREFELT $ 33)))
                   (EXIT (SPADCALL |cosx| |z| (QREFELT $ 23)))))
                 ('T (|error| (STRCONC "cos: " (QREFELT $ 7)))))))) 

(SDEFUN |STTFNC;tan;2S;6| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG ((|tanx| (|Stream| |Coef|)))
               (SEQ
                (COND
                 ((SPADCALL |z| (QREFELT $ 12))
                  (SPADCALL (|spadConstant| $ 17) (QREFELT $ 15)))
                 ((SPADCALL (SPADCALL |z| (QREFELT $ 16)) (|spadConstant| $ 17)
                            (QREFELT $ 18))
                  (SEQ
                   (LETT |tanx|
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 13) 1 (QREFELT $ 20))
                          (QREFELT $ 35)))
                   (EXIT (SPADCALL |tanx| |z| (QREFELT $ 23)))))
                 ('T (|error| (STRCONC "tan: " (QREFELT $ 7)))))))) 

(SDEFUN |STTFNC;cot;2S;7| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (COND
         ((SPADCALL |z| (QREFELT $ 12)) (|error| "cot: cot(0) is undefined"))
         ((SPADCALL (SPADCALL |z| (QREFELT $ 16)) (|spadConstant| $ 17)
                    (QREFELT $ 18))
          (|error| (STRCONC "cot: " (QREFELT $ 9))))
         ('T (|error| (STRCONC "cot: " (QREFELT $ 7)))))) 

(SDEFUN |STTFNC;sec;2S;8| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG ((|secx| (|Stream| |Coef|)))
               (SEQ
                (COND
                 ((SPADCALL |z| (QREFELT $ 12))
                  (SPADCALL (|spadConstant| $ 13) (QREFELT $ 15)))
                 ((SPADCALL (SPADCALL |z| (QREFELT $ 16)) (|spadConstant| $ 17)
                            (QREFELT $ 18))
                  (SEQ
                   (LETT |secx|
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 13) 1 (QREFELT $ 20))
                          (QREFELT $ 38)))
                   (EXIT (SPADCALL |secx| |z| (QREFELT $ 23)))))
                 ('T (|error| (STRCONC "sec: " (QREFELT $ 7)))))))) 

(SDEFUN |STTFNC;csc;2S;9| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (COND
         ((SPADCALL |z| (QREFELT $ 12)) (|error| "csc: csc(0) is undefined"))
         ((SPADCALL (SPADCALL |z| (QREFELT $ 16)) (|spadConstant| $ 17)
                    (QREFELT $ 18))
          (|error| (STRCONC "csc: " (QREFELT $ 9))))
         ('T (|error| (STRCONC "csc: " (QREFELT $ 7)))))) 

(SDEFUN |STTFNC;asin;2S;10| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG ((|asinx| (|Stream| |Coef|)))
               (SEQ
                (COND
                 ((SPADCALL |z| (QREFELT $ 12))
                  (SPADCALL (|spadConstant| $ 17) (QREFELT $ 15)))
                 ((SPADCALL (SPADCALL |z| (QREFELT $ 16)) (|spadConstant| $ 17)
                            (QREFELT $ 18))
                  (SEQ
                   (LETT |asinx|
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 13) 1 (QREFELT $ 20))
                          (QREFELT $ 41)))
                   (EXIT (SPADCALL |asinx| |z| (QREFELT $ 23)))))
                 ('T (|error| (STRCONC "asin: " (QREFELT $ 7)))))))) 

(SDEFUN |STTFNC;atan;2S;11| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG ((|atanx| (|Stream| |Coef|)))
               (SEQ
                (COND
                 ((SPADCALL |z| (QREFELT $ 12))
                  (SPADCALL (|spadConstant| $ 17) (QREFELT $ 15)))
                 ((SPADCALL (SPADCALL |z| (QREFELT $ 16)) (|spadConstant| $ 17)
                            (QREFELT $ 18))
                  (SEQ
                   (LETT |atanx|
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 13) 1 (QREFELT $ 20))
                          (QREFELT $ 43)))
                   (EXIT (SPADCALL |atanx| |z| (QREFELT $ 23)))))
                 ('T (|error| (STRCONC "atan: " (QREFELT $ 7)))))))) 

(PUT '|STTFNC;acos;2S;12| '|SPADreplace|
     '(XLAM (|z|) (|error| "acos: acos undefined on this coefficient domain"))) 

(SDEFUN |STTFNC;acos;2S;12| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (|error| "acos: acos undefined on this coefficient domain")) 

(PUT '|STTFNC;acot;2S;13| '|SPADreplace|
     '(XLAM (|z|) (|error| "acot: acot undefined on this coefficient domain"))) 

(SDEFUN |STTFNC;acot;2S;13| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (|error| "acot: acot undefined on this coefficient domain")) 

(PUT '|STTFNC;asec;2S;14| '|SPADreplace|
     '(XLAM (|z|) (|error| "asec: asec undefined on this coefficient domain"))) 

(SDEFUN |STTFNC;asec;2S;14| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (|error| "asec: asec undefined on this coefficient domain")) 

(PUT '|STTFNC;acsc;2S;15| '|SPADreplace|
     '(XLAM (|z|) (|error| "acsc: acsc undefined on this coefficient domain"))) 

(SDEFUN |STTFNC;acsc;2S;15| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (|error| "acsc: acsc undefined on this coefficient domain")) 

(SDEFUN |STTFNC;sinh;2S;16| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG ((|sinhx| (|Stream| |Coef|)))
               (SEQ
                (COND
                 ((SPADCALL |z| (QREFELT $ 12))
                  (SPADCALL (|spadConstant| $ 17) (QREFELT $ 15)))
                 ((SPADCALL (SPADCALL |z| (QREFELT $ 16)) (|spadConstant| $ 17)
                            (QREFELT $ 18))
                  (SEQ
                   (LETT |sinhx|
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 13) 1 (QREFELT $ 20))
                          (QREFELT $ 49)))
                   (EXIT (SPADCALL |sinhx| |z| (QREFELT $ 23)))))
                 ('T (|error| (STRCONC "sinh: " (QREFELT $ 7)))))))) 

(SDEFUN |STTFNC;cosh;2S;17| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG ((|coshx| (|Stream| |Coef|)))
               (SEQ
                (COND
                 ((SPADCALL |z| (QREFELT $ 12))
                  (SPADCALL (|spadConstant| $ 13) (QREFELT $ 15)))
                 ((SPADCALL (SPADCALL |z| (QREFELT $ 16)) (|spadConstant| $ 17)
                            (QREFELT $ 18))
                  (SEQ
                   (LETT |coshx|
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 13) 1 (QREFELT $ 20))
                          (QREFELT $ 51)))
                   (EXIT (SPADCALL |coshx| |z| (QREFELT $ 23)))))
                 ('T (|error| (STRCONC "cosh: " (QREFELT $ 7)))))))) 

(SDEFUN |STTFNC;tanh;2S;18| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG ((|tanhx| (|Stream| |Coef|)))
               (SEQ
                (COND
                 ((SPADCALL |z| (QREFELT $ 12))
                  (SPADCALL (|spadConstant| $ 17) (QREFELT $ 15)))
                 ((SPADCALL (SPADCALL |z| (QREFELT $ 16)) (|spadConstant| $ 17)
                            (QREFELT $ 18))
                  (SEQ
                   (LETT |tanhx|
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 13) 1 (QREFELT $ 20))
                          (QREFELT $ 53)))
                   (EXIT (SPADCALL |tanhx| |z| (QREFELT $ 23)))))
                 ('T (|error| (STRCONC "tanh: " (QREFELT $ 7)))))))) 

(SDEFUN |STTFNC;coth;2S;19| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (COND
         ((SPADCALL |z| (QREFELT $ 12)) (|error| "coth: coth(0) is undefined"))
         ((SPADCALL (SPADCALL |z| (QREFELT $ 16)) (|spadConstant| $ 17)
                    (QREFELT $ 18))
          (|error| (STRCONC "coth: " (QREFELT $ 9))))
         ('T (|error| (STRCONC "coth: " (QREFELT $ 7)))))) 

(SDEFUN |STTFNC;sech;2S;20| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG ((|sechx| (|Stream| |Coef|)))
               (SEQ
                (COND
                 ((SPADCALL |z| (QREFELT $ 12))
                  (SPADCALL (|spadConstant| $ 13) (QREFELT $ 15)))
                 ((SPADCALL (SPADCALL |z| (QREFELT $ 16)) (|spadConstant| $ 17)
                            (QREFELT $ 18))
                  (SEQ
                   (LETT |sechx|
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 13) 1 (QREFELT $ 20))
                          (QREFELT $ 56)))
                   (EXIT (SPADCALL |sechx| |z| (QREFELT $ 23)))))
                 ('T (|error| (STRCONC "sech: " (QREFELT $ 7)))))))) 

(SDEFUN |STTFNC;csch;2S;21| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (COND
         ((SPADCALL |z| (QREFELT $ 12)) (|error| "csch: csch(0) is undefined"))
         ((SPADCALL (SPADCALL |z| (QREFELT $ 16)) (|spadConstant| $ 17)
                    (QREFELT $ 18))
          (|error| (STRCONC "csch: " (QREFELT $ 9))))
         ('T (|error| (STRCONC "csch: " (QREFELT $ 7)))))) 

(SDEFUN |STTFNC;asinh;2S;22| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG ((|asinhx| (|Stream| |Coef|)))
               (SEQ
                (COND
                 ((SPADCALL |z| (QREFELT $ 12))
                  (SPADCALL (|spadConstant| $ 17) (QREFELT $ 15)))
                 ((SPADCALL (SPADCALL |z| (QREFELT $ 16)) (|spadConstant| $ 17)
                            (QREFELT $ 18))
                  (SEQ
                   (LETT |asinhx|
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 13) 1 (QREFELT $ 20))
                          (QREFELT $ 59)))
                   (EXIT (SPADCALL |asinhx| |z| (QREFELT $ 23)))))
                 ('T (|error| (STRCONC "asinh: " (QREFELT $ 7)))))))) 

(SDEFUN |STTFNC;atanh;2S;23| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG ((|atanhx| (|Stream| |Coef|)))
               (SEQ
                (COND
                 ((SPADCALL |z| (QREFELT $ 12))
                  (SPADCALL (|spadConstant| $ 17) (QREFELT $ 15)))
                 ((SPADCALL (SPADCALL |z| (QREFELT $ 16)) (|spadConstant| $ 17)
                            (QREFELT $ 18))
                  (SEQ
                   (LETT |atanhx|
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 13) 1 (QREFELT $ 20))
                          (QREFELT $ 61)))
                   (EXIT (SPADCALL |atanhx| |z| (QREFELT $ 23)))))
                 ('T (|error| (STRCONC "atanh: " (QREFELT $ 7)))))))) 

(PUT '|STTFNC;acosh;2S;24| '|SPADreplace|
     '(XLAM (|z|)
       (|error| "acosh: acosh undefined on this coefficient domain"))) 

(SDEFUN |STTFNC;acosh;2S;24| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (|error| "acosh: acosh undefined on this coefficient domain")) 

(PUT '|STTFNC;acoth;2S;25| '|SPADreplace|
     '(XLAM (|z|)
       (|error| "acoth: acoth undefined on this coefficient domain"))) 

(SDEFUN |STTFNC;acoth;2S;25| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (|error| "acoth: acoth undefined on this coefficient domain")) 

(PUT '|STTFNC;asech;2S;26| '|SPADreplace|
     '(XLAM (|z|)
       (|error| "asech: asech undefined on this coefficient domain"))) 

(SDEFUN |STTFNC;asech;2S;26| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (|error| "asech: asech undefined on this coefficient domain")) 

(PUT '|STTFNC;acsch;2S;27| '|SPADreplace|
     '(XLAM (|z|)
       (|error| "acsch: acsch undefined on this coefficient domain"))) 

(SDEFUN |STTFNC;acsch;2S;27| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (|error| "acsch: acsch undefined on this coefficient domain")) 

(DECLAIM (NOTINLINE |StreamTranscendentalFunctionsNonCommutative;|)) 

(DEFUN |StreamTranscendentalFunctionsNonCommutative| (#1=#:G807)
  (SPROG NIL
         (PROG (#2=#:G808)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|StreamTranscendentalFunctionsNonCommutative|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|StreamTranscendentalFunctionsNonCommutative;| #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|StreamTranscendentalFunctionsNonCommutative|)))))))))) 

(DEFUN |StreamTranscendentalFunctionsNonCommutative;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$|
                (LIST '|StreamTranscendentalFunctionsNonCommutative| DV$1))
          (LETT $ (GETREFV 67))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache|
                      '|StreamTranscendentalFunctionsNonCommutative|
                      (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7 "series must have constant coefficient zero")
          (QSETREFV $ 8 "series must have constant coefficient one")
          (QSETREFV $ 9 "series expansion has terms of negative degree")
          $))) 

(MAKEPROP '|StreamTranscendentalFunctionsNonCommutative| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) 'ZERO 'ONE 'NPOWERS
              (|Boolean|) (|Stream| 6) (0 . |empty?|) (5 . |One|)
              (|StreamTaylorSeriesOperations| 6) (9 . |coerce|) (14 . |frst|)
              (19 . |Zero|) (23 . =) (|Integer|) (29 . |monom|)
              (|StreamTranscendentalFunctions| 6) (35 . |exp|) (40 . |compose|)
              |STTFNC;exp;2S;1| (46 . +) (52 . |log|) (57 . -)
              |STTFNC;log;2S;2| (63 . *) |STTFNC;^;3S;3| (69 . |sin|)
              |STTFNC;sin;2S;4| (74 . |cos|) |STTFNC;cos;2S;5| (79 . |tan|)
              |STTFNC;tan;2S;6| |STTFNC;cot;2S;7| (84 . |sec|)
              |STTFNC;sec;2S;8| |STTFNC;csc;2S;9| (89 . |asin|)
              |STTFNC;asin;2S;10| (94 . |atan|) |STTFNC;atan;2S;11|
              |STTFNC;acos;2S;12| |STTFNC;acot;2S;13| |STTFNC;asec;2S;14|
              |STTFNC;acsc;2S;15| (99 . |sinh|) |STTFNC;sinh;2S;16|
              (104 . |cosh|) |STTFNC;cosh;2S;17| (109 . |tanh|)
              |STTFNC;tanh;2S;18| |STTFNC;coth;2S;19| (114 . |sech|)
              |STTFNC;sech;2S;20| |STTFNC;csch;2S;21| (119 . |asinh|)
              |STTFNC;asinh;2S;22| (124 . |atanh|) |STTFNC;atanh;2S;23|
              |STTFNC;acosh;2S;24| |STTFNC;acoth;2S;25| |STTFNC;asech;2S;26|
              |STTFNC;acsch;2S;27|)
           '#(|tanh| 129 |tan| 134 |sinh| 139 |sin| 144 |sech| 149 |sec| 154
              |log| 159 |exp| 164 |csch| 169 |csc| 174 |coth| 179 |cot| 184
              |cosh| 189 |cos| 194 |atanh| 199 |atan| 204 |asinh| 209 |asin|
              214 |asech| 219 |asec| 224 |acsch| 229 |acsc| 234 |acoth| 239
              |acot| 244 |acosh| 249 |acos| 254 ^ 259)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|exp| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|log| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((^
                                 ((|Stream| |#1|) (|Stream| |#1|)
                                  (|Stream| |#1|)))
                                T)
                              '((|sin| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|cos| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|tan| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|cot| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|sec| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|csc| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|asin| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|acos| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|atan| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|acot| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|asec| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|acsc| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|sinh| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|cosh| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|tanh| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|coth| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|sech| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|csch| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|asinh| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|acosh| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|atanh| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|acoth| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|asech| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|acsch| ((|Stream| |#1|) (|Stream| |#1|))) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 66
                                            '(1 11 10 0 12 0 6 0 13 1 14 11 6
                                              15 1 11 6 0 16 0 6 0 17 2 6 10 0
                                              0 18 2 14 11 6 19 20 1 21 11 11
                                              22 2 14 11 11 11 23 2 14 11 11 11
                                              25 1 21 11 11 26 2 14 11 11 11 27
                                              2 14 11 11 11 29 1 21 11 11 31 1
                                              21 11 11 33 1 21 11 11 35 1 21 11
                                              11 38 1 21 11 11 41 1 21 11 11 43
                                              1 21 11 11 49 1 21 11 11 51 1 21
                                              11 11 53 1 21 11 11 56 1 21 11 11
                                              59 1 21 11 11 61 1 0 11 11 54 1 0
                                              11 11 36 1 0 11 11 50 1 0 11 11
                                              32 1 0 11 11 57 1 0 11 11 39 1 0
                                              11 11 28 1 0 11 11 24 1 0 11 11
                                              58 1 0 11 11 40 1 0 11 11 55 1 0
                                              11 11 37 1 0 11 11 52 1 0 11 11
                                              34 1 0 11 11 62 1 0 11 11 44 1 0
                                              11 11 60 1 0 11 11 42 1 0 11 11
                                              65 1 0 11 11 47 1 0 11 11 66 1 0
                                              11 11 48 1 0 11 11 64 1 0 11 11
                                              46 1 0 11 11 63 1 0 11 11 45 2 0
                                              11 11 11 30)))))
           '|lookupComplete|)) 
