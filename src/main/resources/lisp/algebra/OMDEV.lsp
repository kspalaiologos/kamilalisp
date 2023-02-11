
(PUT '|OMDEV;OMopenFile;2SOme$;1| '|SPADreplace| 'OM-OPENFILEDEV) 

(SDEFUN |OMDEV;OMopenFile;2SOme$;1|
        ((|fname| (|String|)) (|fmode| (|String|)) (|enc| (|OpenMathEncoding|))
         ($ ($)))
        (OM-OPENFILEDEV |fname| |fmode| |enc|)) 

(PUT '|OMDEV;OMopenString;SOme$;2| '|SPADreplace| 'OM-OPENSTRINGDEV) 

(SDEFUN |OMDEV;OMopenString;SOme$;2|
        ((|str| (|String|)) (|enc| (|OpenMathEncoding|)) ($ ($)))
        (OM-OPENSTRINGDEV |str| |enc|)) 

(PUT '|OMDEV;OMclose;$V;3| '|SPADreplace| 'OM-CLOSEDEV) 

(SDEFUN |OMDEV;OMclose;$V;3| ((|dev| ($)) ($ (|Void|))) (OM-CLOSEDEV |dev|)) 

(PUT '|OMDEV;OMsetEncoding;$OmeV;4| '|SPADreplace| 'OM-SETDEVENCODING) 

(SDEFUN |OMDEV;OMsetEncoding;$OmeV;4|
        ((|dev| ($)) (|enc| (|OpenMathEncoding|)) ($ (|Void|)))
        (OM-SETDEVENCODING |dev| |enc|)) 

(PUT '|OMDEV;OMputApp;$V;5| '|SPADreplace| 'OM-PUTAPP) 

(SDEFUN |OMDEV;OMputApp;$V;5| ((|dev| ($)) ($ (|Void|))) (OM-PUTAPP |dev|)) 

(PUT '|OMDEV;OMputAtp;$V;6| '|SPADreplace| 'OM-PUTATP) 

(SDEFUN |OMDEV;OMputAtp;$V;6| ((|dev| ($)) ($ (|Void|))) (OM-PUTATP |dev|)) 

(PUT '|OMDEV;OMputAttr;$V;7| '|SPADreplace| 'OM-PUTATTR) 

(SDEFUN |OMDEV;OMputAttr;$V;7| ((|dev| ($)) ($ (|Void|))) (OM-PUTATTR |dev|)) 

(PUT '|OMDEV;OMputBind;$V;8| '|SPADreplace| 'OM-PUTBIND) 

(SDEFUN |OMDEV;OMputBind;$V;8| ((|dev| ($)) ($ (|Void|))) (OM-PUTBIND |dev|)) 

(PUT '|OMDEV;OMputBVar;$V;9| '|SPADreplace| 'OM-PUTBVAR) 

(SDEFUN |OMDEV;OMputBVar;$V;9| ((|dev| ($)) ($ (|Void|))) (OM-PUTBVAR |dev|)) 

(PUT '|OMDEV;OMputError;$V;10| '|SPADreplace| 'OM-PUTERROR) 

(SDEFUN |OMDEV;OMputError;$V;10| ((|dev| ($)) ($ (|Void|))) (OM-PUTERROR |dev|)) 

(PUT '|OMDEV;OMputObject;$V;11| '|SPADreplace| 'OM-PUTOBJECT) 

(SDEFUN |OMDEV;OMputObject;$V;11| ((|dev| ($)) ($ (|Void|)))
        (OM-PUTOBJECT |dev|)) 

(PUT '|OMDEV;OMputEndApp;$V;12| '|SPADreplace| 'OM-PUTENDAPP) 

(SDEFUN |OMDEV;OMputEndApp;$V;12| ((|dev| ($)) ($ (|Void|)))
        (OM-PUTENDAPP |dev|)) 

(PUT '|OMDEV;OMputEndAtp;$V;13| '|SPADreplace| 'OM-PUTENDATP) 

(SDEFUN |OMDEV;OMputEndAtp;$V;13| ((|dev| ($)) ($ (|Void|)))
        (OM-PUTENDATP |dev|)) 

(PUT '|OMDEV;OMputEndAttr;$V;14| '|SPADreplace| 'OM-PUTENDATTR) 

(SDEFUN |OMDEV;OMputEndAttr;$V;14| ((|dev| ($)) ($ (|Void|)))
        (OM-PUTENDATTR |dev|)) 

(PUT '|OMDEV;OMputEndBind;$V;15| '|SPADreplace| 'OM-PUTENDBIND) 

(SDEFUN |OMDEV;OMputEndBind;$V;15| ((|dev| ($)) ($ (|Void|)))
        (OM-PUTENDBIND |dev|)) 

(PUT '|OMDEV;OMputEndBVar;$V;16| '|SPADreplace| 'OM-PUTENDBVAR) 

(SDEFUN |OMDEV;OMputEndBVar;$V;16| ((|dev| ($)) ($ (|Void|)))
        (OM-PUTENDBVAR |dev|)) 

(PUT '|OMDEV;OMputEndError;$V;17| '|SPADreplace| 'OM-PUTENDERROR) 

(SDEFUN |OMDEV;OMputEndError;$V;17| ((|dev| ($)) ($ (|Void|)))
        (OM-PUTENDERROR |dev|)) 

(PUT '|OMDEV;OMputEndObject;$V;18| '|SPADreplace| 'OM-PUTENDOBJECT) 

(SDEFUN |OMDEV;OMputEndObject;$V;18| ((|dev| ($)) ($ (|Void|)))
        (OM-PUTENDOBJECT |dev|)) 

(PUT '|OMDEV;OMputInteger;$IV;19| '|SPADreplace| 'OM-PUTINT) 

(SDEFUN |OMDEV;OMputInteger;$IV;19|
        ((|dev| ($)) (|i| (|Integer|)) ($ (|Void|))) (OM-PUTINT |dev| |i|)) 

(PUT '|OMDEV;OMputFloat;$DfV;20| '|SPADreplace| 'OM-PUTFLOAT) 

(SDEFUN |OMDEV;OMputFloat;$DfV;20|
        ((|dev| ($)) (|f| (|DoubleFloat|)) ($ (|Void|)))
        (OM-PUTFLOAT |dev| |f|)) 

(PUT '|OMDEV;OMputVariable;$SV;21| '|SPADreplace| 'OM-PUTVAR) 

(SDEFUN |OMDEV;OMputVariable;$SV;21|
        ((|dev| ($)) (|v| (|Symbol|)) ($ (|Void|))) (OM-PUTVAR |dev| |v|)) 

(PUT '|OMDEV;OMputString;$SV;22| '|SPADreplace| 'OM-PUTSTRING) 

(SDEFUN |OMDEV;OMputString;$SV;22| ((|dev| ($)) (|s| (|String|)) ($ (|Void|)))
        (OM-PUTSTRING |dev| |s|)) 

(PUT '|OMDEV;OMputSymbol;$2SV;23| '|SPADreplace| 'OM-PUTSYMBOL) 

(SDEFUN |OMDEV;OMputSymbol;$2SV;23|
        ((|dev| ($)) (|cd| (|String|)) (|nm| (|String|)) ($ (|Void|)))
        (OM-PUTSYMBOL |dev| |cd| |nm|)) 

(PUT '|OMDEV;OMgetApp;$V;24| '|SPADreplace| 'OM-GETAPP) 

(SDEFUN |OMDEV;OMgetApp;$V;24| ((|dev| ($)) ($ (|Void|))) (OM-GETAPP |dev|)) 

(PUT '|OMDEV;OMgetAtp;$V;25| '|SPADreplace| 'OM-GETATP) 

(SDEFUN |OMDEV;OMgetAtp;$V;25| ((|dev| ($)) ($ (|Void|))) (OM-GETATP |dev|)) 

(PUT '|OMDEV;OMgetAttr;$V;26| '|SPADreplace| 'OM-GETATTR) 

(SDEFUN |OMDEV;OMgetAttr;$V;26| ((|dev| ($)) ($ (|Void|))) (OM-GETATTR |dev|)) 

(PUT '|OMDEV;OMgetBind;$V;27| '|SPADreplace| 'OM-GETBIND) 

(SDEFUN |OMDEV;OMgetBind;$V;27| ((|dev| ($)) ($ (|Void|))) (OM-GETBIND |dev|)) 

(PUT '|OMDEV;OMgetBVar;$V;28| '|SPADreplace| 'OM-GETBVAR) 

(SDEFUN |OMDEV;OMgetBVar;$V;28| ((|dev| ($)) ($ (|Void|))) (OM-GETBVAR |dev|)) 

(PUT '|OMDEV;OMgetError;$V;29| '|SPADreplace| 'OM-GETERROR) 

(SDEFUN |OMDEV;OMgetError;$V;29| ((|dev| ($)) ($ (|Void|))) (OM-GETERROR |dev|)) 

(PUT '|OMDEV;OMgetObject;$V;30| '|SPADreplace| 'OM-GETOBJECT) 

(SDEFUN |OMDEV;OMgetObject;$V;30| ((|dev| ($)) ($ (|Void|)))
        (OM-GETOBJECT |dev|)) 

(PUT '|OMDEV;OMgetEndApp;$V;31| '|SPADreplace| 'OM-GETENDAPP) 

(SDEFUN |OMDEV;OMgetEndApp;$V;31| ((|dev| ($)) ($ (|Void|)))
        (OM-GETENDAPP |dev|)) 

(PUT '|OMDEV;OMgetEndAtp;$V;32| '|SPADreplace| 'OM-GETENDATP) 

(SDEFUN |OMDEV;OMgetEndAtp;$V;32| ((|dev| ($)) ($ (|Void|)))
        (OM-GETENDATP |dev|)) 

(PUT '|OMDEV;OMgetEndAttr;$V;33| '|SPADreplace| 'OM-GETENDATTR) 

(SDEFUN |OMDEV;OMgetEndAttr;$V;33| ((|dev| ($)) ($ (|Void|)))
        (OM-GETENDATTR |dev|)) 

(PUT '|OMDEV;OMgetEndBind;$V;34| '|SPADreplace| 'OM-GETENDBIND) 

(SDEFUN |OMDEV;OMgetEndBind;$V;34| ((|dev| ($)) ($ (|Void|)))
        (OM-GETENDBIND |dev|)) 

(PUT '|OMDEV;OMgetEndBVar;$V;35| '|SPADreplace| 'OM-GETENDBVAR) 

(SDEFUN |OMDEV;OMgetEndBVar;$V;35| ((|dev| ($)) ($ (|Void|)))
        (OM-GETENDBVAR |dev|)) 

(PUT '|OMDEV;OMgetEndError;$V;36| '|SPADreplace| 'OM-GETENDERROR) 

(SDEFUN |OMDEV;OMgetEndError;$V;36| ((|dev| ($)) ($ (|Void|)))
        (OM-GETENDERROR |dev|)) 

(PUT '|OMDEV;OMgetEndObject;$V;37| '|SPADreplace| 'OM-GETENDOBJECT) 

(SDEFUN |OMDEV;OMgetEndObject;$V;37| ((|dev| ($)) ($ (|Void|)))
        (OM-GETENDOBJECT |dev|)) 

(PUT '|OMDEV;OMgetInteger;$I;38| '|SPADreplace| 'OM-GETINT) 

(SDEFUN |OMDEV;OMgetInteger;$I;38| ((|dev| ($)) ($ (|Integer|)))
        (OM-GETINT |dev|)) 

(PUT '|OMDEV;OMgetFloat;$Df;39| '|SPADreplace| 'OM-GETFLOAT) 

(SDEFUN |OMDEV;OMgetFloat;$Df;39| ((|dev| ($)) ($ (|DoubleFloat|)))
        (OM-GETFLOAT |dev|)) 

(PUT '|OMDEV;OMgetVariable;$S;40| '|SPADreplace| 'OM-GETVAR) 

(SDEFUN |OMDEV;OMgetVariable;$S;40| ((|dev| ($)) ($ (|Symbol|)))
        (OM-GETVAR |dev|)) 

(PUT '|OMDEV;OMgetString;$S;41| '|SPADreplace| 'OM-GETSTRING) 

(SDEFUN |OMDEV;OMgetString;$S;41| ((|dev| ($)) ($ (|String|)))
        (OM-GETSTRING |dev|)) 

(PUT '|OMDEV;OMgetSymbol;$R;42| '|SPADreplace| 'OM-GETSYMBOL) 

(SDEFUN |OMDEV;OMgetSymbol;$R;42|
        ((|dev| ($))
         ($ (|Record| (|:| |cd| (|String|)) (|:| |name| (|String|)))))
        (OM-GETSYMBOL |dev|)) 

(PUT '|OMDEV;OMgetType;$S;43| '|SPADreplace| 'OM-GETTYPE) 

(SDEFUN |OMDEV;OMgetType;$S;43| ((|dev| ($)) ($ (|Symbol|))) (OM-GETTYPE |dev|)) 

(DECLAIM (NOTINLINE |OpenMathDevice;|)) 

(DEFUN |OpenMathDevice| ()
  (SPROG NIL
         (PROG (#1=#:G741)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|OpenMathDevice|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|OpenMathDevice|
                             (LIST (CONS NIL (CONS 1 (|OpenMathDevice;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|OpenMathDevice|)))))))))) 

(DEFUN |OpenMathDevice;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|OpenMathDevice|))
          (LETT $ (GETREFV 56))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|OpenMathDevice| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|OpenMathDevice| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|String|) (|OpenMathEncoding|)
              |OMDEV;OMopenFile;2SOme$;1| |OMDEV;OMopenString;SOme$;2| (|Void|)
              |OMDEV;OMclose;$V;3| |OMDEV;OMsetEncoding;$OmeV;4|
              |OMDEV;OMputApp;$V;5| |OMDEV;OMputAtp;$V;6|
              |OMDEV;OMputAttr;$V;7| |OMDEV;OMputBind;$V;8|
              |OMDEV;OMputBVar;$V;9| |OMDEV;OMputError;$V;10|
              |OMDEV;OMputObject;$V;11| |OMDEV;OMputEndApp;$V;12|
              |OMDEV;OMputEndAtp;$V;13| |OMDEV;OMputEndAttr;$V;14|
              |OMDEV;OMputEndBind;$V;15| |OMDEV;OMputEndBVar;$V;16|
              |OMDEV;OMputEndError;$V;17| |OMDEV;OMputEndObject;$V;18|
              (|Integer|) |OMDEV;OMputInteger;$IV;19| (|DoubleFloat|)
              |OMDEV;OMputFloat;$DfV;20| (|Symbol|)
              |OMDEV;OMputVariable;$SV;21| |OMDEV;OMputString;$SV;22|
              |OMDEV;OMputSymbol;$2SV;23| |OMDEV;OMgetApp;$V;24|
              |OMDEV;OMgetAtp;$V;25| |OMDEV;OMgetAttr;$V;26|
              |OMDEV;OMgetBind;$V;27| |OMDEV;OMgetBVar;$V;28|
              |OMDEV;OMgetError;$V;29| |OMDEV;OMgetObject;$V;30|
              |OMDEV;OMgetEndApp;$V;31| |OMDEV;OMgetEndAtp;$V;32|
              |OMDEV;OMgetEndAttr;$V;33| |OMDEV;OMgetEndBind;$V;34|
              |OMDEV;OMgetEndBVar;$V;35| |OMDEV;OMgetEndError;$V;36|
              |OMDEV;OMgetEndObject;$V;37| |OMDEV;OMgetInteger;$I;38|
              |OMDEV;OMgetFloat;$Df;39| |OMDEV;OMgetVariable;$S;40|
              |OMDEV;OMgetString;$S;41| (|Record| (|:| |cd| 6) (|:| |name| 6))
              |OMDEV;OMgetSymbol;$R;42| |OMDEV;OMgetType;$S;43|)
           '#(|OMsetEncoding| 0 |OMputVariable| 6 |OMputSymbol| 12
              |OMputString| 19 |OMputObject| 25 |OMputInteger| 30 |OMputFloat|
              36 |OMputError| 42 |OMputEndObject| 47 |OMputEndError| 52
              |OMputEndBind| 57 |OMputEndBVar| 62 |OMputEndAttr| 67
              |OMputEndAtp| 72 |OMputEndApp| 77 |OMputBind| 82 |OMputBVar| 87
              |OMputAttr| 92 |OMputAtp| 97 |OMputApp| 102 |OMopenString| 107
              |OMopenFile| 113 |OMgetVariable| 120 |OMgetType| 125
              |OMgetSymbol| 130 |OMgetString| 135 |OMgetObject| 140
              |OMgetInteger| 145 |OMgetFloat| 150 |OMgetError| 155
              |OMgetEndObject| 160 |OMgetEndError| 165 |OMgetEndBind| 170
              |OMgetEndBVar| 175 |OMgetEndAttr| 180 |OMgetEndAtp| 185
              |OMgetEndApp| 190 |OMgetBind| 195 |OMgetBVar| 200 |OMgetAttr| 205
              |OMgetAtp| 210 |OMgetApp| 215 |OMclose| 220)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|OMopenFile|
                                 ($$ (|String|) (|String|)
                                  (|OpenMathEncoding|)))
                                T)
                              '((|OMopenString|
                                 ($$ (|String|) (|OpenMathEncoding|)))
                                T)
                              '((|OMclose| ((|Void|) $$)) T)
                              '((|OMsetEncoding|
                                 ((|Void|) $$ (|OpenMathEncoding|)))
                                T)
                              '((|OMputApp| ((|Void|) $$)) T)
                              '((|OMputAtp| ((|Void|) $$)) T)
                              '((|OMputAttr| ((|Void|) $$)) T)
                              '((|OMputBind| ((|Void|) $$)) T)
                              '((|OMputBVar| ((|Void|) $$)) T)
                              '((|OMputError| ((|Void|) $$)) T)
                              '((|OMputObject| ((|Void|) $$)) T)
                              '((|OMputEndApp| ((|Void|) $$)) T)
                              '((|OMputEndAtp| ((|Void|) $$)) T)
                              '((|OMputEndAttr| ((|Void|) $$)) T)
                              '((|OMputEndBind| ((|Void|) $$)) T)
                              '((|OMputEndBVar| ((|Void|) $$)) T)
                              '((|OMputEndError| ((|Void|) $$)) T)
                              '((|OMputEndObject| ((|Void|) $$)) T)
                              '((|OMputInteger| ((|Void|) $$ (|Integer|))) T)
                              '((|OMputFloat| ((|Void|) $$ (|DoubleFloat|))) T)
                              '((|OMputVariable| ((|Void|) $$ (|Symbol|))) T)
                              '((|OMputString| ((|Void|) $$ (|String|))) T)
                              '((|OMputSymbol|
                                 ((|Void|) $$ (|String|) (|String|)))
                                T)
                              '((|OMgetApp| ((|Void|) $$)) T)
                              '((|OMgetAtp| ((|Void|) $$)) T)
                              '((|OMgetAttr| ((|Void|) $$)) T)
                              '((|OMgetBind| ((|Void|) $$)) T)
                              '((|OMgetBVar| ((|Void|) $$)) T)
                              '((|OMgetError| ((|Void|) $$)) T)
                              '((|OMgetObject| ((|Void|) $$)) T)
                              '((|OMgetEndApp| ((|Void|) $$)) T)
                              '((|OMgetEndAtp| ((|Void|) $$)) T)
                              '((|OMgetEndAttr| ((|Void|) $$)) T)
                              '((|OMgetEndBind| ((|Void|) $$)) T)
                              '((|OMgetEndBVar| ((|Void|) $$)) T)
                              '((|OMgetEndError| ((|Void|) $$)) T)
                              '((|OMgetEndObject| ((|Void|) $$)) T)
                              '((|OMgetInteger| ((|Integer|) $$)) T)
                              '((|OMgetFloat| ((|DoubleFloat|) $$)) T)
                              '((|OMgetVariable| ((|Symbol|) $$)) T)
                              '((|OMgetString| ((|String|) $$)) T)
                              '((|OMgetSymbol|
                                 ((|Record| (|:| |cd| (|String|))
                                            (|:| |name| (|String|)))
                                  $$))
                                T)
                              '((|OMgetType| ((|Symbol|) $$)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 55
                                            '(2 0 10 0 7 12 2 0 10 0 31 32 3 0
                                              10 0 6 6 34 2 0 10 0 6 33 1 0 10
                                              0 19 2 0 10 0 27 28 2 0 10 0 29
                                              30 1 0 10 0 18 1 0 10 0 26 1 0 10
                                              0 25 1 0 10 0 23 1 0 10 0 24 1 0
                                              10 0 22 1 0 10 0 21 1 0 10 0 20 1
                                              0 10 0 16 1 0 10 0 17 1 0 10 0 15
                                              1 0 10 0 14 1 0 10 0 13 2 0 0 6 7
                                              9 3 0 0 6 6 7 8 1 0 31 0 51 1 0
                                              31 0 55 1 0 53 0 54 1 0 6 0 52 1
                                              0 10 0 41 1 0 27 0 49 1 0 29 0 50
                                              1 0 10 0 40 1 0 10 0 48 1 0 10 0
                                              47 1 0 10 0 45 1 0 10 0 46 1 0 10
                                              0 44 1 0 10 0 43 1 0 10 0 42 1 0
                                              10 0 38 1 0 10 0 39 1 0 10 0 37 1
                                              0 10 0 36 1 0 10 0 35 1 0 10 0
                                              11)))))
           '|lookupComplete|)) 

(MAKEPROP '|OpenMathDevice| 'NILADIC T) 
