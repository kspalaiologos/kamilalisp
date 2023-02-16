
(SDEFUN |NUMFMT;replaceD| ((|c| (|Character|)) ($ (|Character|)))
        (COND ((|eql_SI| |c| (|STR_to_CHAR| "D")) (|STR_to_CHAR| "E"))
              ('T |c|))) 

(SDEFUN |NUMFMT;replaced| ((|c| (|Character|)) ($ (|Character|)))
        (COND ((|eql_SI| |c| (|STR_to_CHAR| "d")) (|STR_to_CHAR| "E"))
              ('T |c|))) 

(SDEFUN |NUMFMT;contract| ((|s| (|String|)) ($ (|String|)))
        (SPROG ((|ls| (|List| (|String|))))
               (SEQ
                (LETT |s|
                      (SPADCALL (CONS (|function| |NUMFMT;replaceD|) $) |s|
                                (QREFELT $ 8)))
                (LETT |s|
                      (SPADCALL (CONS (|function| |NUMFMT;replaced|) $) |s|
                                (QREFELT $ 8)))
                (LETT |ls| (SPADCALL |s| (|STR_to_CHAR| " ") (QREFELT $ 11)))
                (EXIT (LETT |s| (SPADCALL |ls| (QREFELT $ 12))))))) 

(SDEFUN |NUMFMT;check| ((|s| (|String|)) ($ (|Boolean|)))
        (COND
         ((NUMBERP (READ-FROM-STRING |s|))
          (COND
           ((SPADCALL (|STR_to_CHAR| "E") |s| (QREFELT $ 14))
            (COND ((SPADCALL (|STR_to_CHAR| ".") |s| (QREFELT $ 14)) 'T)
                  (#1='T NIL)))
           (#1# 'T)))
         (#1# NIL))) 

(SDEFUN |NUMFMT;ScanFloatIgnoreSpaces;SF;5| ((|s| (|String|)) ($ (|Float|)))
        (SPROG ((|res| (|Union| (|Float|) "failed")))
               (SEQ (LETT |res| (SPADCALL |s| (QREFELT $ 21)))
                    (EXIT
                     (COND ((QEQCAR |res| 1) (|error| "Non-numeric value"))
                           ('T (QCDR |res|))))))) 

(SDEFUN |NUMFMT;ScanFloatIgnoreSpacesIfCan;SU;6|
        ((|s| (|String|)) ($ (|Union| (|Float|) "failed")))
        (SPROG
         ((|f| (|Integer|)) (|sCheck| (|SExpression|)) (|sex| (|SExpression|)))
         (SEQ (LETT |s| (|NUMFMT;contract| |s| $))
              (COND ((NULL (|NUMFMT;check| |s| $)) (EXIT (CONS 1 "failed"))))
              (LETT |sex|
                    (|interpret| (|packageTran| (|ncParseFromString| |s|))
                                 NIL))
              (LETT |sCheck|
                    (SPADCALL (SPADCALL |sex| (QREFELT $ 24)) (QREFELT $ 24)))
              (EXIT
               (COND
                ((|BooleanEquality|
                  (SPADCALL |sCheck| (QREFELT $ 19) (QREFELT $ 25)) 'T)
                 (LETT |f|
                       (CONS 0
                             (SPADCALL (SPADCALL |sex| (QREFELT $ 26))
                                       (QREFELT $ 26)))))
                ((|BooleanEquality|
                  (SPADCALL (SPADCALL |sex| (QREFELT $ 26)) (QREFELT $ 27)) 'T)
                 (SEQ (LETT |f| (SPADCALL |sex| (QREFELT $ 26)))
                      (EXIT (CONS 0 (SPADCALL |f| (QREFELT $ 29))))))
                ('T (CONS 1 "failed"))))))) 

(PUT '|NUMFMT;FormatArabic;PiS;7| '|SPADreplace| 'STRINGIMAGE) 

(SDEFUN |NUMFMT;FormatArabic;PiS;7| ((|n| (|PositiveInteger|)) ($ (|String|)))
        (STRINGIMAGE |n|)) 

(SDEFUN |NUMFMT;ScanArabic;SPi;8| ((|s| (|String|)) ($ (|PositiveInteger|)))
        (SPADCALL |s| (QREFELT $ 47))) 

(SDEFUN |NUMFMT;FormatRoman;PiS;9| ((|pn| (|PositiveInteger|)) ($ (|String|)))
        (SPROG
         ((|s| (|String|)) (|mm| (|String|)) (#1=#:G770 NIL) (|j| NIL)
          (#2=#:G769 NIL) (|m0| (|String|)) (|n| (|Integer|)) (|d| (|Integer|))
          (|i| NIL) (#3=#:G754 NIL))
         (SEQ (LETT |n| |pn|) (LETT |d| (+ (REM |n| 10) (QREFELT $ 36)))
              (LETT |n| (QUOTIENT2 |n| 10))
              (LETT |s| (QAREF1 (QREFELT $ 33) |d|))
              (EXIT
               (COND ((ZEROP |n|) |s|)
                     (#4='T
                      (SEQ (LETT |d| (+ (REM |n| 10) (QREFELT $ 37)))
                           (LETT |n| (QUOTIENT2 |n| 10))
                           (LETT |s| (STRCONC (QAREF1 (QREFELT $ 34) |d|) |s|))
                           (EXIT
                            (COND ((ZEROP |n|) |s|)
                                  (#4#
                                   (SEQ
                                    (LETT |d| (+ (REM |n| 10) (QREFELT $ 38)))
                                    (LETT |n| (QUOTIENT2 |n| 10))
                                    (LETT |s|
                                          (STRCONC (QAREF1 (QREFELT $ 35) |d|)
                                                   |s|))
                                    (EXIT
                                     (COND ((ZEROP |n|) |s|)
                                           (#4#
                                            (SEQ (LETT |d| (REM |n| 10))
                                                 (LETT |n| (QUOTIENT2 |n| 10))
                                                 (LETT |s|
                                                       (STRCONC
                                                        (|make_full_CVEC2|
                                                         (PROG1 (LETT #3# |d|)
                                                           (|check_subtype2|
                                                            (>= #3# 0)
                                                            '(|NonNegativeInteger|)
                                                            '(|Integer|) #3#))
                                                         (QREFELT $ 40))
                                                        |s|))
                                                 (EXIT
                                                  (COND ((ZEROP |n|) |s|)
                                                        (#4#
                                                         (SEQ
                                                          (SEQ (LETT |i| 2)
                                                               G190
                                                               (COND
                                                                ((NULL
                                                                  (NULL
                                                                   (ZEROP
                                                                    |n|)))
                                                                 (GO G191)))
                                                               (SEQ
                                                                (LETT |d|
                                                                      (REM |n|
                                                                           10))
                                                                (LETT |n|
                                                                      (QUOTIENT2
                                                                       |n| 10))
                                                                (EXIT
                                                                 (COND
                                                                  ((ZEROP |d|)
                                                                   "iterate")
                                                                  ('T
                                                                   (SEQ
                                                                    (LETT |m0|
                                                                          (STRCONC
                                                                           (|make_full_CVEC2|
                                                                            |i|
                                                                            (QREFELT
                                                                             $
                                                                             41))
                                                                           (STRCONC
                                                                            "I"
                                                                            (|make_full_CVEC2|
                                                                             |i|
                                                                             (QREFELT
                                                                              $
                                                                              42)))))
                                                                    (LETT |mm|
                                                                          (SPADCALL
                                                                           (PROGN
                                                                            (LETT
                                                                             #2#
                                                                             NIL)
                                                                            (SEQ
                                                                             (LETT
                                                                              |j|
                                                                              1)
                                                                             (LETT
                                                                              #1#
                                                                              |d|)
                                                                             G190
                                                                             (COND
                                                                              ((|greater_SI|
                                                                                |j|
                                                                                #1#)
                                                                               (GO
                                                                                G191)))
                                                                             (SEQ
                                                                              (EXIT
                                                                               (LETT
                                                                                #2#
                                                                                (CONS
                                                                                 |m0|
                                                                                 #2#))))
                                                                             (LETT
                                                                              |j|
                                                                              (|inc_SI|
                                                                               |j|))
                                                                             (GO
                                                                              G190)
                                                                             G191
                                                                             (EXIT
                                                                              (NREVERSE
                                                                               #2#))))
                                                                           (QREFELT
                                                                            $
                                                                            12)))
                                                                    (COND
                                                                     ((>
                                                                       (QCSIZE
                                                                        |s|)
                                                                       0)
                                                                      (LETT |s|
                                                                            (STRCONC
                                                                             " "
                                                                             |s|))))
                                                                    (EXIT
                                                                     (LETT |s|
                                                                           (STRCONC
                                                                            |mm|
                                                                            |s|))))))))
                                                               (LETT |i|
                                                                     (|inc_SI|
                                                                      |i|))
                                                               (GO G190) G191
                                                               (EXIT NIL))
                                                          (EXIT
                                                           |s|)))))))))))))))))))) 

(SDEFUN |NUMFMT;ScanRoman;SPi;10| ((|s| (|String|)) ($ (|PositiveInteger|)))
        (SPROG
         ((#1=#:G784 NIL) (|Max| (|Integer|)) (|tot| (|Integer|))
          (|n| (|Integer|)) (#2=#:G787 NIL) (|i| (|Integer|))
          (|c| (|Character|)) (#3=#:G788 NIL) (|k| NIL)
          (|nprens| (|PositiveInteger|)))
         (SEQ (LETT |s| (SPADCALL |s| (QREFELT $ 50))) (LETT |tot| 0)
              (LETT |Max| 0) (LETT |i| (SPADCALL |s| (QREFELT $ 51)))
              (SEQ G190
                   (COND
                    ((NULL (>= |i| (SPADCALL |s| (QREFELT $ 52)))) (GO G191)))
                   (SEQ (LETT |c| (SPADCALL |s| |i| (QREFELT $ 53)))
                        (LETT |i| (- |i| 1))
                        (LETT |n| (QAREF1 (QREFELT $ 39) |c|))
                        (COND
                         ((< |n| 0)
                          (COND
                           ((SPADCALL |c| (QREFELT $ 42) (QREFELT $ 54))
                            (|error|
                             (STRCONC "Improper character in Roman numeral: "
                                      (|make_full_CVEC2| 1 |c|))))
                           ('T
                            (SEQ (LETT |nprens| 1)
                                 (SEQ G190
                                      (COND
                                       ((NULL
                                         (COND
                                          ((|eql_SI| |c| (QREFELT $ 42))
                                           (>= |i|
                                               (SPADCALL |s| (QREFELT $ 52))))
                                          ('T NIL)))
                                        (GO G191)))
                                      (SEQ
                                       (LETT |c|
                                             (SPADCALL |s| |i| (QREFELT $ 53)))
                                       (LETT |i| (- |i| 1))
                                       (EXIT
                                        (COND
                                         ((|eql_SI| |c| (QREFELT $ 42))
                                          (LETT |nprens| (+ |nprens| 1))))))
                                      NIL (GO G190) G191 (EXIT NIL))
                                 (EXIT
                                  (COND
                                   ((SPADCALL |c| (QREFELT $ 43)
                                              (QREFELT $ 54))
                                    (|error| "Improper Roman numeral: (x)"))
                                   ('T
                                    (SEQ
                                     (SEQ (LETT |k| 1) (LETT #3# |nprens|) G190
                                          (COND
                                           ((OR (|greater_SI| |k| #3#)
                                                (NULL
                                                 (>= |i|
                                                     (SPADCALL |s|
                                                               (QREFELT $
                                                                        52)))))
                                            (GO G191)))
                                          (SEQ
                                           (EXIT
                                            (SEQ
                                             (LETT |c|
                                                   (SPADCALL |s| |i|
                                                             (QREFELT $ 53)))
                                             (LETT |i| (- |i| 1))
                                             (EXIT
                                              (COND
                                               ((SPADCALL |c| (QREFELT $ 41)
                                                          (QREFELT $ 54))
                                                (PROGN
                                                 (LETT #2#
                                                       (|error|
                                                        "Improper Roman numeral: unbalanced ')'"))
                                                 (GO #4=#:G776)))))))
                                           #4# (EXIT #2#))
                                          (LETT |k| (|inc_SI| |k|)) (GO G190)
                                          G191 (EXIT NIL))
                                     (EXIT
                                      (LETT |n|
                                            (EXPT 10 (+ |nprens| 2)))))))))))))
                        (EXIT
                         (COND ((< |n| |Max|) (LETT |tot| (- |tot| |n|)))
                               ('T
                                (SEQ (LETT |tot| (+ |tot| |n|))
                                     (EXIT (LETT |Max| |n|)))))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT
               (COND
                ((<= |tot| 0)
                 (|error|
                  (STRCONC "Improper Roman numeral: " (STRINGIMAGE |tot|))))
                ('T
                 (PROG1 (LETT #1# |tot|)
                   (|check_subtype2| (> #1# 0) '(|PositiveInteger|)
                                     '(|Integer|) #1#)))))))) 

(PUT '|NUMFMT;FormatRadix;2IS;11| '|SPADreplace| '|write_to_string_radix|) 

(SDEFUN |NUMFMT;FormatRadix;2IS;11|
        ((|n| (|Integer|)) (|r| (|Integer|)) ($ (|String|)))
        (|write_to_string_radix| |n| |r|)) 

(DECLAIM (NOTINLINE |NumberFormats;|)) 

(DEFUN |NumberFormats| ()
  (SPROG NIL
         (PROG (#1=#:G791)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|NumberFormats|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|NumberFormats|
                             (LIST (CONS NIL (CONS 1 (|NumberFormats;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#) (HREM |$ConstructorCache| '|NumberFormats|)))))))))) 

(DEFUN |NumberFormats;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|NumberFormats|))
          (LETT $ (GETREFV 57))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|NumberFormats| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 19
                    (SPADCALL (SPADCALL "Float" (QREFELT $ 16))
                              (QREFELT $ 18)))
          (QSETREFV $ 33
                    (SPADCALL
                     (LIST #1="" #2="I" "II" "III" "IV" #3="V" "VI" "VII"
                           "VIII" "IX")
                     (QREFELT $ 32)))
          (QSETREFV $ 34
                    (SPADCALL
                     (LIST #1# #4="X" "XX" "XXX" "XL" #5="L" "LX" "LXX" "LXXX"
                           "XC")
                     (QREFELT $ 32)))
          (QSETREFV $ 35
                    (SPADCALL
                     (LIST #1# #6="C" "CC" "CCC" "CD" #7="D" "DC" "DCC" "DCCC"
                           "CM")
                     (QREFELT $ 32)))
          (QSETREFV $ 36 (PROGN (QREFELT $ 33) 0))
          (QSETREFV $ 37 (PROGN (QREFELT $ 34) 0))
          (QSETREFV $ 38 (PROGN (QREFELT $ 35) 0))
          (QSETREFV $ 39 (MAKEARR1 256 -1))
          (QSETAREF1 (QREFELT $ 39) (|STR_to_CHAR| " ") 0)
          (QSETAREF1 (QREFELT $ 39) (|STR_to_CHAR| #2#) 1)
          (QSETAREF1 (QREFELT $ 39) (|STR_to_CHAR| #3#) 5)
          (QSETAREF1 (QREFELT $ 39) (|STR_to_CHAR| #4#) 10)
          (QSETAREF1 (QREFELT $ 39) (|STR_to_CHAR| #5#) 50)
          (QSETAREF1 (QREFELT $ 39) (|STR_to_CHAR| #6#) 100)
          (QSETAREF1 (QREFELT $ 39) (|STR_to_CHAR| #7#) 500)
          (QSETAREF1 (QREFELT $ 39) (|STR_to_CHAR| #8="M") 1000)
          (QSETREFV $ 40 (|STR_to_CHAR| #8#))
          (QSETREFV $ 41 (|STR_to_CHAR| "("))
          (QSETREFV $ 42 (|STR_to_CHAR| ")"))
          (QSETREFV $ 43 (|STR_to_CHAR| #2#))
          $))) 

(MAKEPROP '|NumberFormats| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Mapping| 10 10) (|String|) (0 . |map|)
              (|List| $) (|Character|) (6 . |split|) (12 . |concat|)
              (|Boolean|) (17 . |member?|) (|Symbol|) (23 . |coerce|)
              (|SExpression|) (28 . |convert|) '|sexfloat|
              (|Union| 22 '#1="failed")
              |NUMFMT;ScanFloatIgnoreSpacesIfCan;SU;6| (|Float|)
              |NUMFMT;ScanFloatIgnoreSpaces;SF;5| (33 . |car|) (38 . =)
              (44 . |cdr|) (49 . |integer?|) (|Integer|) (54 . |coerce|)
              (|List| 7) (|PrimitiveArray| 7) (59 . |construct|) '|units|
              '|tens| '|hunds| '|umin| '|tmin| '|hmin| '|romval| '|thou|
              '|plen| '|pren| '|ichar| (|PositiveInteger|)
              |NUMFMT;FormatArabic;PiS;7| (|ScanningUtilities|)
              (64 . |parse_integer|) |NUMFMT;ScanArabic;SPi;8|
              |NUMFMT;FormatRoman;PiS;9| (69 . |upperCase|) (74 . |maxIndex|)
              (79 . |minIndex|) (84 . |elt|) (90 . ~=)
              |NUMFMT;ScanRoman;SPi;10| |NUMFMT;FormatRadix;2IS;11|)
           '#(|ScanRoman| 96 |ScanFloatIgnoreSpacesIfCan| 101
              |ScanFloatIgnoreSpaces| 106 |ScanArabic| 111 |FormatRoman| 116
              |FormatRadix| 121 |FormatArabic| 127)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|FormatArabic|
                                 ((|String|) (|PositiveInteger|)))
                                T)
                              '((|ScanArabic| ((|PositiveInteger|) (|String|)))
                                T)
                              '((|FormatRoman|
                                 ((|String|) (|PositiveInteger|)))
                                T)
                              '((|ScanRoman| ((|PositiveInteger|) (|String|)))
                                T)
                              '((|ScanFloatIgnoreSpaces|
                                 ((|Float|) (|String|)))
                                T)
                              '((|ScanFloatIgnoreSpacesIfCan|
                                 ((|Union| (|Float|) #1#) (|String|)))
                                T)
                              '((|FormatRadix|
                                 ((|String|) (|Integer|) (|Integer|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 56
                                            '(2 7 0 6 0 8 2 7 9 0 10 11 1 7 0 9
                                              12 2 7 13 10 0 14 1 15 0 7 16 1
                                              17 0 15 18 1 17 0 0 24 2 17 13 0
                                              0 25 1 17 0 0 26 1 17 13 0 27 1
                                              22 0 28 29 1 31 0 30 32 1 46 28 7
                                              47 1 7 0 0 50 1 7 28 0 51 1 7 28
                                              0 52 2 7 10 0 28 53 2 10 13 0 0
                                              54 1 0 44 7 55 1 0 20 7 21 1 0 22
                                              7 23 1 0 44 7 48 1 0 7 44 49 2 0
                                              7 28 28 56 1 0 7 44 45)))))
           '|lookupComplete|)) 

(MAKEPROP '|NumberFormats| 'NILADIC T) 
