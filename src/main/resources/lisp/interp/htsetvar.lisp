
; )package "BOOT"

(IN-PACKAGE "BOOT")

; htsv() ==
;   startHTPage(50)
;   htSetVars()

(DEFUN |htsv| () (PROG () (RETURN (PROGN (|startHTPage| 50) (|htSetVars|)))))

; htSetVars() ==
;   $path := nil
;   $lastTree := nil
;   if 0 ~= LASTATOM $setOptions then htMarkTree($setOptions,0)
;   htShowSetTree($setOptions)

(DEFUN |htSetVars| ()
  (PROG ()
    (RETURN
     (PROGN
      (SETQ |$path| NIL)
      (SETQ |$lastTree| NIL)
      (COND
       ((NOT (EQL 0 (LASTATOM |$setOptions|))) (|htMarkTree| |$setOptions| 0)))
      (|htShowSetTree| |$setOptions|)))))

; htShowSetTree(setTree) ==
;   $path := TAKE(- LASTATOM setTree,$path)
;   page := htInitPage(mkSetTitle(),nil)
;   htpSetProperty(page, 'setTree, setTree)
;   links := nil
;   maxWidth1 := maxWidth2 := 0
;   for setData in setTree repeat
;     satisfiesUserLevel setData.setLevel =>
;       okList := [setData,:okList]
;       maxWidth1 := MAX(# PNAME setData.setName,maxWidth1)
;       maxWidth2 := MAX(htShowCount STRINGIMAGE setData.setLabel,maxWidth2)
;   maxWidth1 := MAX(9,maxWidth1)
;   maxWidth2 := MAX(41,maxWidth2)
;   tabset1 := STRINGIMAGE (maxWidth1)
;   tabset2 := STRINGIMAGE (maxWidth2 + maxWidth1 - 1)
;   htSayList(['"\tab{2}\newline Variable\tab{",
;     STRINGIMAGE (maxWidth1 + QUOTIENT(maxWidth2, 3)),
;      '"}Description\tab{",STRINGIMAGE(maxWidth2 + maxWidth1 + 2),
;       '"}Value\newline\beginitems "])
;   for setData in REVERSE okList repeat
;       htSay '"\item"
;       label := STRCONC('"\menuitemstyle{",setData.setName,'"}")
;       links := [label,[['text,'"\tab{",tabset1,'"}",setData.setLabel,'"\tab{",tabset2,'"}{\em ",htShowSetTreeValue setData,'"}"]],
;                 'htShowSetPage, setData.setName]
;       htMakePage [['bcLispLinks, links,'options,'(indent . 0)]]
;   htSay '"\enditems"
;   htShowPage()

(DEFUN |htShowSetTree| (|setTree|)
  (PROG (|page| |links| |maxWidth2| |maxWidth1| |okList| |tabset1| |tabset2|
         |label|)
    (RETURN
     (PROGN
      (SETQ |$path| (TAKE (- (LASTATOM |setTree|)) |$path|))
      (SETQ |page| (|htInitPage| (|mkSetTitle|) NIL))
      (|htpSetProperty| |page| '|setTree| |setTree|)
      (SETQ |links| NIL)
      (SETQ |maxWidth1| (SETQ |maxWidth2| 0))
      ((LAMBDA (|bfVar#1| |setData|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#1|) (PROGN (SETQ |setData| (CAR |bfVar#1|)) NIL))
            (RETURN NIL))
           (#1='T
            (COND
             ((|satisfiesUserLevel| (ELT |setData| 2))
              (IDENTITY
               (PROGN
                (SETQ |okList| (CONS |setData| |okList|))
                (SETQ |maxWidth1|
                        (MAX (LENGTH (PNAME (ELT |setData| 0))) |maxWidth1|))
                (SETQ |maxWidth2|
                        (MAX (|htShowCount| (STRINGIMAGE (ELT |setData| 1)))
                             |maxWidth2|))))))))
          (SETQ |bfVar#1| (CDR |bfVar#1|))))
       |setTree| NIL)
      (SETQ |maxWidth1| (MAX 9 |maxWidth1|))
      (SETQ |maxWidth2| (MAX 41 |maxWidth2|))
      (SETQ |tabset1| (STRINGIMAGE |maxWidth1|))
      (SETQ |tabset2| (STRINGIMAGE (- (+ |maxWidth2| |maxWidth1|) 1)))
      (|htSayList|
       (LIST "\\tab{2}\\newline Variable\\tab{"
             (STRINGIMAGE (+ |maxWidth1| (QUOTIENT |maxWidth2| 3)))
             "}Description\\tab{"
             (STRINGIMAGE (+ (+ |maxWidth2| |maxWidth1|) 2))
             "}Value\\newline\\beginitems "))
      ((LAMBDA (|bfVar#2| |setData|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#2|) (PROGN (SETQ |setData| (CAR |bfVar#2|)) NIL))
            (RETURN NIL))
           (#1#
            (PROGN
             (|htSay| "\\item")
             (SETQ |label| (STRCONC "\\menuitemstyle{" (ELT |setData| 0) "}"))
             (SETQ |links|
                     (LIST |label|
                           (LIST
                            (LIST '|text| "\\tab{" |tabset1| "}"
                                  (ELT |setData| 1) "\\tab{" |tabset2|
                                  "}{\\em " (|htShowSetTreeValue| |setData|)
                                  "}"))
                           '|htShowSetPage| (ELT |setData| 0)))
             (|htMakePage|
              (LIST
               (LIST '|bcLispLinks| |links| '|options| '(|indent| . 0)))))))
          (SETQ |bfVar#2| (CDR |bfVar#2|))))
       (REVERSE |okList|) NIL)
      (|htSay| "\\enditems")
      (|htShowPage|)))))

; htShowCount s == --# discounting {\em .. }
;   m := #s
;   m < 8 => m - 1
;   i := 0
;   count := 0
;   while i < m - 7 repeat
;     s.i = char '_{ and  s.(i+1) = char '_\ and s.(i+2) = char 'e
;       and s.(i+3) = char 'm => i := i + 6     --discount {\em }
;     i := i + 1
;     count := count + 1
;   count + (m - i)

(DEFUN |htShowCount| (|s|)
  (PROG (|m| |i| |count|)
    (RETURN
     (PROGN
      (SETQ |m| (LENGTH |s|))
      (COND ((< |m| 8) (- |m| 1))
            (#1='T
             (PROGN
              (SETQ |i| 0)
              (SETQ |count| 0)
              ((LAMBDA ()
                 (LOOP
                  (COND ((NOT (< |i| (- |m| 7))) (RETURN NIL))
                        (#1#
                         (COND
                          ((AND (EQUAL (ELT |s| |i|) (|char| '{))
                                (EQUAL (ELT |s| (+ |i| 1)) (|char| '|\\|))
                                (EQUAL (ELT |s| (+ |i| 2)) (|char| '|e|))
                                (EQUAL (ELT |s| (+ |i| 3)) (|char| '|m|)))
                           (SETQ |i| (+ |i| 6)))
                          (#1#
                           (PROGN
                            (SETQ |i| (+ |i| 1))
                            (SETQ |count| (+ |count| 1))))))))))
              (+ |count| (- |m| |i|)))))))))

; htShowSetTreeValue(setData) ==
;   st := setData.setType
;   st = 'FUNCTION => object2String FUNCALL(setData.setVar,"%display%")
;   st = 'INTEGER  => object2String eval setData.setVar
;   st = 'STRING  => object2String eval setData.setVar
;   st = 'LITERALS =>
;     object2String translateTrueFalse2YesNo eval setData.setVar
;   st = 'TREE     => '"..."
;   systemError()

(DEFUN |htShowSetTreeValue| (|setData|)
  (PROG (|st|)
    (RETURN
     (PROGN
      (SETQ |st| (ELT |setData| 3))
      (COND
       ((EQ |st| 'FUNCTION)
        (|object2String| (FUNCALL (ELT |setData| 4) '|%display%|)))
       ((EQ |st| 'INTEGER) (|object2String| (|eval| (ELT |setData| 4))))
       ((EQ |st| 'STRING) (|object2String| (|eval| (ELT |setData| 4))))
       ((EQ |st| 'LITERALS)
        (|object2String|
         (|translateTrueFalse2YesNo| (|eval| (ELT |setData| 4)))))
       ((EQ |st| 'TREE) "...") ('T (|systemError|)))))))

; mkSetTitle() == STRCONC('"Command {\em )set ",listOfStrings2String $path,'"}")

(DEFUN |mkSetTitle| ()
  (PROG ()
    (RETURN
     (STRCONC "Command {\\em )set " (|listOfStrings2String| |$path|) "}"))))

; listOfStrings2String u ==
;   null u => '""
;   STRCONC(listOfStrings2String rest u,'" ",stringize first u)

(DEFUN |listOfStrings2String| (|u|)
  (PROG ()
    (RETURN
     (COND ((NULL |u|) "")
           ('T
            (STRCONC (|listOfStrings2String| (CDR |u|)) " "
             (|stringize| (CAR |u|))))))))

; htShowSetPage(htPage, branch) ==
;   setTree := htpProperty(htPage, 'setTree)
;   $path := [branch,:TAKE(- LASTATOM setTree,$path)]
;   setData := assoc(branch, setTree)
;   null setData =>
;     systemError('"No Set Data")
;   st := setData.setType
;   st = 'FUNCTION => htShowFunctionPage(htPage, setData)
;   st = 'INTEGER  =>  htShowIntegerPage(htPage,setData)
;   st = 'LITERALS => htShowLiteralsPage(htPage, setData)
;   st = 'TREE     => htShowSetTree(setData.setLeaf)
;
;   st = 'STRING   =>  -- have to add this
;      htSetNotAvailable(htPage,'")set compiler")
;
;   systemError '"Unknown data type"

(DEFUN |htShowSetPage| (|htPage| |branch|)
  (PROG (|setTree| |setData| |st|)
    (RETURN
     (PROGN
      (SETQ |setTree| (|htpProperty| |htPage| '|setTree|))
      (SETQ |$path| (CONS |branch| (TAKE (- (LASTATOM |setTree|)) |$path|)))
      (SETQ |setData| (|assoc| |branch| |setTree|))
      (COND ((NULL |setData|) (|systemError| "No Set Data"))
            (#1='T
             (PROGN
              (SETQ |st| (ELT |setData| 3))
              (COND
               ((EQ |st| 'FUNCTION) (|htShowFunctionPage| |htPage| |setData|))
               ((EQ |st| 'INTEGER) (|htShowIntegerPage| |htPage| |setData|))
               ((EQ |st| 'LITERALS) (|htShowLiteralsPage| |htPage| |setData|))
               ((EQ |st| 'TREE) (|htShowSetTree| (ELT |setData| 5)))
               ((EQ |st| 'STRING)
                (|htSetNotAvailable| |htPage| ")set compiler"))
               (#1# (|systemError| "Unknown data type"))))))))))

; htShowLiteralsPage(htPage, setData) ==
;   htSetLiterals(htPage,setData.setName,setData.setLabel,
;                 setData.setVar,setData.setLeaf,'htSetLiteral)

(DEFUN |htShowLiteralsPage| (|htPage| |setData|)
  (PROG ()
    (RETURN
     (|htSetLiterals| |htPage| (ELT |setData| 0) (ELT |setData| 1)
      (ELT |setData| 4) (ELT |setData| 5) '|htSetLiteral|))))

; htSetLiterals(htPage,name,message,variable,values,functionToCall) ==
;   page := htInitPage('"Set Command", htpPropertyList htPage)
;   htpSetProperty(page, 'variable, variable)
;   bcHt ['"\centerline{Set {\em ", name, '"}}\newline"]
;   bcHt ['"{\em Description: } ", message, '"\newline\vspace{1} "]
;   bcHt '"Select one of the following: \newline\tab{3} "
;   links := [[STRCONC('"",STRINGIMAGE opt), '"\newline\tab{3}", functionToCall, opt] for opt in values]
;   htMakePage [['bcLispLinks, :links]]
;   bcHt ["\indent{0}\newline\vspace{1} The current setting is: {\em ",
;         translateTrueFalse2YesNo EVAL variable, '"} "]
;   htShowPage()

(DEFUN |htSetLiterals|
       (|htPage| |name| |message| |variable| |values| |functionToCall|)
  (PROG (|page| |links|)
    (RETURN
     (PROGN
      (SETQ |page| (|htInitPage| "Set Command" (|htpPropertyList| |htPage|)))
      (|htpSetProperty| |page| '|variable| |variable|)
      (|bcHt| (LIST "\\centerline{Set {\\em " |name| "}}\\newline"))
      (|bcHt| (LIST "{\\em Description: } " |message| "\\newline\\vspace{1} "))
      (|bcHt| "Select one of the following: \\newline\\tab{3} ")
      (SETQ |links|
              ((LAMBDA (|bfVar#4| |bfVar#3| |opt|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#3|)
                        (PROGN (SETQ |opt| (CAR |bfVar#3|)) NIL))
                    (RETURN (NREVERSE |bfVar#4|)))
                   ('T
                    (SETQ |bfVar#4|
                            (CONS
                             (LIST (STRCONC "" (STRINGIMAGE |opt|))
                                   "\\newline\\tab{3}" |functionToCall| |opt|)
                             |bfVar#4|))))
                  (SETQ |bfVar#3| (CDR |bfVar#3|))))
               NIL |values| NIL))
      (|htMakePage| (LIST (CONS '|bcLispLinks| |links|)))
      (|bcHt|
       (LIST '|\\indent{0}\\newline\\vspace{1} The current setting is: {\\em |
             (|translateTrueFalse2YesNo| (EVAL |variable|)) "} "))
      (|htShowPage|)))))

; htSetLiteral(htPage, val) ==
;   htInitPage('"Set Command", nil)
;   SET(htpProperty(htPage, 'variable), translateYesNo2TrueFalse val)
;   htKill(htPage,val)

(DEFUN |htSetLiteral| (|htPage| |val|)
  (PROG ()
    (RETURN
     (PROGN
      (|htInitPage| "Set Command" NIL)
      (SET (|htpProperty| |htPage| '|variable|)
           (|translateYesNo2TrueFalse| |val|))
      (|htKill| |htPage| |val|)))))

; htShowIntegerPage(htPage, setData) ==
;   page := htInitPage(mkSetTitle(), htpPropertyList htPage)
;   htpSetProperty(page, 'variable, setData.setVar)
;   bcHt ['"\centerline{Set {\em ", setData.setName, '"}}\newline"]
;   message := setData.setLabel
;   bcHt ['"{\em Description: } ", message, '"\newline\vspace{1} "]
;   [$htInitial,$htFinal] := setData.setLeaf
;   if $htFinal = $htInitial + 1
;     then
;       bcHt '"Enter the integer {\em "
;       bcHt stringize $htInitial
;       bcHt '"} or {\em "
;       bcHt stringize $htFinal
;       bcHt '"}:"
;     else if null $htFinal then
;       bcHt '"Enter an integer greater than {\em "
;       bcHt stringize ($htInitial - 1)
;       bcHt '"}:"
;     else
;       bcHt '"Enter an integer between {\em "
;       bcHt stringize $htInitial
;       bcHt '"} and {\em "
;       bcHt stringize $htFinal
;       bcHt '"}:"
;   htMakePage [
;     '(domainConditions (Satisfies S chkRange)),
;       ['bcStrings,[5,eval setData.setVar,'value,'S]]]
;   htSetvarDoneButton('"Select to Set Value",'htSetInteger)
;   htShowPage()

(DEFUN |htShowIntegerPage| (|htPage| |setData|)
  (PROG (|page| |message| |LETTMP#1|)
    (RETURN
     (PROGN
      (SETQ |page| (|htInitPage| (|mkSetTitle|) (|htpPropertyList| |htPage|)))
      (|htpSetProperty| |page| '|variable| (ELT |setData| 4))
      (|bcHt| (LIST "\\centerline{Set {\\em " (ELT |setData| 0) "}}\\newline"))
      (SETQ |message| (ELT |setData| 1))
      (|bcHt| (LIST "{\\em Description: } " |message| "\\newline\\vspace{1} "))
      (SETQ |LETTMP#1| (ELT |setData| 5))
      (SETQ |$htInitial| (CAR |LETTMP#1|))
      (SETQ |$htFinal| (CADR |LETTMP#1|))
      (COND
       ((EQUAL |$htFinal| (+ |$htInitial| 1))
        (|bcHt| "Enter the integer {\\em ") (|bcHt| (|stringize| |$htInitial|))
        (|bcHt| "} or {\\em ") (|bcHt| (|stringize| |$htFinal|)) (|bcHt| "}:"))
       ((NULL |$htFinal|) (|bcHt| "Enter an integer greater than {\\em ")
        (|bcHt| (|stringize| (- |$htInitial| 1))) (|bcHt| "}:"))
       ('T (|bcHt| "Enter an integer between {\\em ")
        (|bcHt| (|stringize| |$htInitial|)) (|bcHt| "} and {\\em ")
        (|bcHt| (|stringize| |$htFinal|)) (|bcHt| "}:")))
      (|htMakePage|
       (LIST '(|domainConditions| (|Satisfies| S |chkRange|))
             (LIST '|bcStrings|
                   (LIST 5 (|eval| (ELT |setData| 4)) '|value| 'S))))
      (|htSetvarDoneButton| "Select to Set Value" '|htSetInteger|)
      (|htShowPage|)))))

; htSetInteger(htPage) ==
;   htInitPage(mkSetTitle(), nil)
;   val := chkRange htpLabelInputString(htPage,'value)
;   not INTEGERP val =>
;     errorPage(htPage,['"Value Error",nil,'"\vspace{3}\centerline{{\em ",val,'"}}\vspace{2}\newline\centerline{Click on \UpBitmap{} to re-enter value}"])
;   SET(htpProperty(htPage, 'variable), val)
;   htKill(htPage,val)

(DEFUN |htSetInteger| (|htPage|)
  (PROG (|val|)
    (RETURN
     (PROGN
      (|htInitPage| (|mkSetTitle|) NIL)
      (SETQ |val| (|chkRange| (|htpLabelInputString| |htPage| '|value|)))
      (COND
       ((NULL (INTEGERP |val|))
        (|errorPage| |htPage|
         (LIST "Value Error" NIL "\\vspace{3}\\centerline{{\\em " |val|
               "}}\\vspace{2}\\newline\\centerline{Click on \\UpBitmap{} to re-enter value}")))
       ('T
        (PROGN
         (SET (|htpProperty| |htPage| '|variable|) |val|)
         (|htKill| |htPage| |val|))))))))

; htShowFunctionPage(htPage,setData) ==
;   fn := setData.setDef => FUNCALL(fn,htPage)
;   htpSetProperty(htPage,'setData,setData)
;   htpSetProperty(htPage,'parts, setData.setLeaf)
;   htShowFunctionPageContinued(htPage)

(DEFUN |htShowFunctionPage| (|htPage| |setData|)
  (PROG (|fn|)
    (RETURN
     (COND ((SETQ |fn| (ELT |setData| 6)) (FUNCALL |fn| |htPage|))
           ('T
            (PROGN
             (|htpSetProperty| |htPage| '|setData| |setData|)
             (|htpSetProperty| |htPage| '|parts| (ELT |setData| 5))
             (|htShowFunctionPageContinued| |htPage|)))))))

; htShowFunctionPageContinued(htPage) ==
;   parts := htpProperty(htPage,'parts)
;   setData := htpProperty(htPage,'setData)
;   [[phrase,kind,variable,checker,initValue,:.],:restParts] := parts
;   htpSetProperty(htPage, 'variable, variable)
;   htpSetProperty(htPage, 'checker, checker)
;   htpSetProperty(htPage, 'parts, restParts)
;   kind = 'LITERALS => htSetLiterals(htPage,setData.setName,
;                                     phrase,variable,checker,'htFunctionSetLiteral)
;   page := htInitPage(mkSetTitle(), htpPropertyList htPage)
;   bcHt ['"\centerline{Set {\em ", setData.setName, '"}}\newline"]
;   bcHt ['"{\em Description: } ", setData.setLabel, '"\newline\vspace{1} "]
;   currentValue := EVAL variable
;   htMakePage
;     [ ['domainConditions, ['Satisfies,'S,checker]],
;       ['text,:phrase],
;         ['inputStrings,
;           [ '"", '"", 60, currentValue, 'value, 'S]]]
;   htSetvarDoneButton('"Select To Set Value",'htSetFunCommand)
;   htShowPage()

(DEFUN |htShowFunctionPageContinued| (|htPage|)
  (PROG (|parts| |setData| |phrase| |kind| |variable| |checker| |initValue|
         |restParts| |page| |currentValue|)
    (RETURN
     (PROGN
      (SETQ |parts| (|htpProperty| |htPage| '|parts|))
      (SETQ |setData| (|htpProperty| |htPage| '|setData|))
      (SETQ |phrase| (CAAR . #1=(|parts|)))
      (SETQ |kind| (CADAR . #1#))
      (SETQ |variable| (CADDAR . #1#))
      (SETQ |checker| (CAR #2=(CDDDAR . #1#)))
      (SETQ |initValue| (CADR #2#))
      (SETQ |restParts| (CDR |parts|))
      (|htpSetProperty| |htPage| '|variable| |variable|)
      (|htpSetProperty| |htPage| '|checker| |checker|)
      (|htpSetProperty| |htPage| '|parts| |restParts|)
      (COND
       ((EQ |kind| 'LITERALS)
        (|htSetLiterals| |htPage| (ELT |setData| 0) |phrase| |variable|
         |checker| '|htFunctionSetLiteral|))
       ('T
        (PROGN
         (SETQ |page|
                 (|htInitPage| (|mkSetTitle|) (|htpPropertyList| |htPage|)))
         (|bcHt|
          (LIST "\\centerline{Set {\\em " (ELT |setData| 0) "}}\\newline"))
         (|bcHt|
          (LIST "{\\em Description: } " (ELT |setData| 1)
                "\\newline\\vspace{1} "))
         (SETQ |currentValue| (EVAL |variable|))
         (|htMakePage|
          (LIST (LIST '|domainConditions| (LIST '|Satisfies| 'S |checker|))
                (CONS '|text| |phrase|)
                (LIST '|inputStrings|
                      (LIST "" "" 60 |currentValue| '|value| 'S))))
         (|htSetvarDoneButton| "Select To Set Value" '|htSetFunCommand|)
         (|htShowPage|))))))))

; htSetvarDoneButton(message, func) ==
;   bcHt '"\newline\vspace{1}\centerline{"
;
;   if message = '"Select to Set Value" or message = '"Select to Set Values"  then
;     bchtMakeButton('"\lisplink",'"\ControlBitmap{ClickToSet}", func)
;   else
;     bchtMakeButton('"\lisplink",CONCAT('"\fbox{", message, '"}"), func)
;
;   bcHt '"} "

(DEFUN |htSetvarDoneButton| (|message| |func|)
  (PROG ()
    (RETURN
     (PROGN
      (|bcHt| "\\newline\\vspace{1}\\centerline{")
      (COND
       ((OR (EQUAL |message| "Select to Set Value")
            (EQUAL |message| "Select to Set Values"))
        (|bchtMakeButton| "\\lisplink" "\\ControlBitmap{ClickToSet}" |func|))
       ('T
        (|bchtMakeButton| "\\lisplink" (CONCAT "\\fbox{" |message| "}")
         |func|)))
      (|bcHt| "} ")))))

; htFunctionSetLiteral(htPage, val) ==
;   htInitPage('"Set Command", nil)
;   SET(htpProperty(htPage, 'variable), translateYesNo2TrueFalse val)
;   htSetFunCommandContinue(htPage,val)

(DEFUN |htFunctionSetLiteral| (|htPage| |val|)
  (PROG ()
    (RETURN
     (PROGN
      (|htInitPage| "Set Command" NIL)
      (SET (|htpProperty| |htPage| '|variable|)
           (|translateYesNo2TrueFalse| |val|))
      (|htSetFunCommandContinue| |htPage| |val|)))))

; htSetFunCommand(htPage) ==
;   variable := htpProperty(htPage,'variable)
;   checker := htpProperty(htPage,'checker)
;   value := htCheck(checker,htpLabelInputString(htPage,'value))
;   SET(variable,value) --kill this later
;   htSetFunCommandContinue(htPage,value)

(DEFUN |htSetFunCommand| (|htPage|)
  (PROG (|variable| |checker| |value|)
    (RETURN
     (PROGN
      (SETQ |variable| (|htpProperty| |htPage| '|variable|))
      (SETQ |checker| (|htpProperty| |htPage| '|checker|))
      (SETQ |value|
              (|htCheck| |checker| (|htpLabelInputString| |htPage| '|value|)))
      (SET |variable| |value|)
      (|htSetFunCommandContinue| |htPage| |value|)))))

; htSetFunCommandContinue(htPage,value) ==
;   parts := htpProperty(htPage,'parts)
;   continue :=
;     null parts => false
;     parts is [['break,predicate],:restParts] => eval predicate
;     true
;   continue =>
;     htpSetProperty(htPage,'parts,restParts)
;     htShowFunctionPageContinued(htPage)
;   htKill(htPage,value)

(DEFUN |htSetFunCommandContinue| (|htPage| |value|)
  (PROG (|parts| |ISTMP#1| |ISTMP#2| |predicate| |restParts| |continue|)
    (RETURN
     (PROGN
      (SETQ |parts| (|htpProperty| |htPage| '|parts|))
      (SETQ |continue|
              (COND ((NULL |parts|) NIL)
                    ((AND (CONSP |parts|)
                          (PROGN
                           (SETQ |ISTMP#1| (CAR |parts|))
                           (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|break|)
                                (PROGN
                                 (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                 (AND (CONSP |ISTMP#2|)
                                      (EQ (CDR |ISTMP#2|) NIL)
                                      (PROGN
                                       (SETQ |predicate| (CAR |ISTMP#2|))
                                       #1='T)))))
                          (PROGN (SETQ |restParts| (CDR |parts|)) #1#))
                     (|eval| |predicate|))
                    (#1# T)))
      (COND
       (|continue|
        (PROGN
         (|htpSetProperty| |htPage| '|parts| |restParts|)
         (|htShowFunctionPageContinued| |htPage|)))
       (#1# (|htKill| |htPage| |value|)))))))

; htKill(htPage,value) ==
;   htInitPage('"System Command", nil)
;   string := STRCONC('"{\em )set ",listOfStrings2String [value,:$path],'"}")
;   htMakePage [
;      '(text
;         "{Here is the FriCAS system command you could have issued:}"
;             "\vspace{2}\newline\centerline{\tt"),
;       ['text,:string]]
;   htMakePage '((text . "}\vspace{1}\newline\rm"))
;   htSay '"\vspace{2}{Select \  \UpButton{} \  to go back.}"
;   htSay '"\newline{Select \  \ExitButton{QuitPage} \  to remove this window.}"
;   htProcessDoitButton ['"Press to Remove Page",'"",'htDoNothing]
;   htShowPage()

(DEFUN |htKill| (|htPage| |value|)
  (PROG (|string|)
    (RETURN
     (PROGN
      (|htInitPage| "System Command" NIL)
      (SETQ |string|
              (STRCONC "{\\em )set "
               (|listOfStrings2String| (CONS |value| |$path|)) "}"))
      (|htMakePage|
       (LIST
        '(|text| "{Here is the FriCAS system command you could have issued:}"
          "\\vspace{2}\\newline\\centerline{\\tt")
        (CONS '|text| |string|)))
      (|htMakePage| '((|text| . "}\\vspace{1}\\newline\\rm")))
      (|htSay| "\\vspace{2}{Select \\  \\UpButton{} \\  to go back.}")
      (|htSay|
       "\\newline{Select \\  \\ExitButton{QuitPage} \\  to remove this window.}")
      (|htProcessDoitButton| (LIST "Press to Remove Page" "" '|htDoNothing|))
      (|htShowPage|)))))

; htSetNotAvailable(htPage,whatToType) ==
;   page := htInitPage('"Unavailable Set Command", htpPropertyList htPage)
;   htInitPage('"Unavailable System Command", nil)
;   string := STRCONC('"{\em ",whatToType,'"}")
;   htMakePage [
;      '(text "\vspace{1}\newline"
;         "{Sorry, but this system command is not available through HyperDoc. Please directly issue this command in a FriCAS window for more information:}"
;             "\vspace{2}\newline\centerline{\tt"),
;       ['text,:string]]
;   htMakePage '((text . "}\vspace{1}\newline"))
;   htProcessDoitButton ['"Press to Remove Page",'"",'htDoNothing]
;   htShowPage()

(DEFUN |htSetNotAvailable| (|htPage| |whatToType|)
  (PROG (|page| |string|)
    (RETURN
     (PROGN
      (SETQ |page|
              (|htInitPage| "Unavailable Set Command"
               (|htpPropertyList| |htPage|)))
      (|htInitPage| "Unavailable System Command" NIL)
      (SETQ |string| (STRCONC "{\\em " |whatToType| "}"))
      (|htMakePage|
       (LIST
        '(|text| "\\vspace{1}\\newline"
          "{Sorry, but this system command is not available through HyperDoc. Please directly issue this command in a FriCAS window for more information:}"
          "\\vspace{2}\\newline\\centerline{\\tt")
        (CONS '|text| |string|)))
      (|htMakePage| '((|text| . "}\\vspace{1}\\newline")))
      (|htProcessDoitButton| (LIST "Press to Remove Page" "" '|htDoNothing|))
      (|htShowPage|)))))

; htDoNothing(htPage,command) == nil

(DEFUN |htDoNothing| (|htPage| |command|) (PROG () (RETURN NIL)))

; htCheck(checker,value) ==
;   PAIRP checker => htCheckList(checker,parseWord value)
;   FUNCALL(checker,value)

(DEFUN |htCheck| (|checker| |value|)
  (PROG ()
    (RETURN
     (COND ((CONSP |checker|) (|htCheckList| |checker| (|parseWord| |value|)))
           ('T (FUNCALL |checker| |value|))))))

; parseWord x ==
;   STRINGP x =>
;     and/[DIGITP x.i for i in 0..MAXINDEX x] => PARSE_-INTEGER x
;     INTERN x
;   x

(DEFUN |parseWord| (|x|)
  (PROG ()
    (RETURN
     (COND
      ((STRINGP |x|)
       (COND
        (((LAMBDA (|bfVar#6| |bfVar#5| |i|)
            (LOOP
             (COND ((> |i| |bfVar#5|) (RETURN |bfVar#6|))
                   (#1='T
                    (PROGN
                     (SETQ |bfVar#6| (DIGITP (ELT |x| |i|)))
                     (COND ((NOT |bfVar#6|) (RETURN NIL))))))
             (SETQ |i| (+ |i| 1))))
          T (MAXINDEX |x|) 0)
         (PARSE-INTEGER |x|))
        (#1# (INTERN |x|))))
      (#1# |x|)))))

; htCheckList(checker,value) ==
;   if value in '(y ye yes Y YE YES) then value := 'yes
;   if value in '(n no N NO) then value := 'no
;   checker is [n,m] and INTEGERP n =>
;     m = n + 1 =>
;       value in checker => value
;       n
;     null m =>
;       INTEGERP value and value >= n => value
;       n
;     INTEGERP m =>
;       INTEGERP value and value >= n and value <= m => value
;       n
;   value in checker => value
;   first checker

(DEFUN |htCheckList| (|checker| |value|)
  (PROG (|n| |ISTMP#1| |m|)
    (RETURN
     (PROGN
      (COND
       ((|member| |value| '(|y| |ye| |yes| Y YE YES)) (SETQ |value| '|yes|)))
      (COND ((|member| |value| '(|n| |no| N NO)) (SETQ |value| '|no|)))
      (COND
       ((AND (CONSP |checker|)
             (PROGN
              (SETQ |n| (CAR |checker|))
              (SETQ |ISTMP#1| (CDR |checker|))
              (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                   (PROGN (SETQ |m| (CAR |ISTMP#1|)) #1='T)))
             (INTEGERP |n|))
        (COND
         ((EQUAL |m| (+ |n| 1))
          (COND ((|member| |value| |checker|) |value|) (#1# |n|)))
         ((NULL |m|)
          (COND ((AND (INTEGERP |value|) (NOT (< |value| |n|))) |value|)
                (#1# |n|)))
         ((INTEGERP |m|)
          (COND
           ((AND (INTEGERP |value|) (NOT (< |value| |n|))
                 (NOT (< |m| |value|)))
            |value|)
           (#1# |n|)))))
       ((|member| |value| |checker|) |value|) (#1# (CAR |checker|)))))))

; translateYesNoToTrueFalse x ==
;   x = 'yes => true
;   x = 'no => false
;   x

(DEFUN |translateYesNoToTrueFalse| (|x|)
  (PROG () (RETURN (COND ((EQ |x| '|yes|) T) ((EQ |x| '|no|) NIL) ('T |x|)))))

; chkNameList x ==
;   u := bcString2ListWords x
;   parsedNames := [ncParseFromString x for x in u]
;   and/[IDENTP x for x in parsedNames] => parsedNames
;   '"Please enter a list of identifiers separated by blanks"

(DEFUN |chkNameList| (|x|)
  (PROG (|u| |parsedNames|)
    (RETURN
     (PROGN
      (SETQ |u| (|bcString2ListWords| |x|))
      (SETQ |parsedNames|
              ((LAMBDA (|bfVar#8| |bfVar#7| |x|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#7|)
                        (PROGN (SETQ |x| (CAR |bfVar#7|)) NIL))
                    (RETURN (NREVERSE |bfVar#8|)))
                   (#1='T
                    (SETQ |bfVar#8|
                            (CONS (|ncParseFromString| |x|) |bfVar#8|))))
                  (SETQ |bfVar#7| (CDR |bfVar#7|))))
               NIL |u| NIL))
      (COND
       (((LAMBDA (|bfVar#10| |bfVar#9| |x|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#9|) (PROGN (SETQ |x| (CAR |bfVar#9|)) NIL))
              (RETURN |bfVar#10|))
             (#1#
              (PROGN
               (SETQ |bfVar#10| (IDENTP |x|))
               (COND ((NOT |bfVar#10|) (RETURN NIL))))))
            (SETQ |bfVar#9| (CDR |bfVar#9|))))
         T |parsedNames| NIL)
        |parsedNames|)
       (#1# "Please enter a list of identifiers separated by blanks"))))))

; chkPosInteger s ==
;   (u := parseOnly s) and INTEGERP u and u > 0 => u
;   '"Please enter a positive integer"

(DEFUN |chkPosInteger| (|s|)
  (PROG (|u|)
    (RETURN
     (COND ((AND (SETQ |u| (|parseOnly| |s|)) (INTEGERP |u|) (< 0 |u|)) |u|)
           ('T "Please enter a positive integer")))))

; chkOutputFileName s ==
;   bcString2WordList s in '(CONSOLE console) => 'console
;   chkDirectory s

(DEFUN |chkOutputFileName| (|s|)
  (PROG ()
    (RETURN
     (COND
      ((|member| (|bcString2WordList| |s|) '(CONSOLE |console|)) '|console|)
      ('T (|chkDirectory| |s|))))))

; chkDirectory s == s

(DEFUN |chkDirectory| (|s|) (PROG () (RETURN |s|)))

; chkNonNegativeInteger s ==
;   (u := ncParseFromString s) and INTEGERP u and u >= 0 => u
;   '"Please enter a non-negative integer"

(DEFUN |chkNonNegativeInteger| (|s|)
  (PROG (|u|)
    (RETURN
     (COND
      ((AND (SETQ |u| (|ncParseFromString| |s|)) (INTEGERP |u|)
            (NOT (MINUSP |u|)))
       |u|)
      ('T "Please enter a non-negative integer")))))

; chkRange s ==
;   (u := ncParseFromString s) and INTEGERP u
;     and u >= $htInitial and (NULL $htFinal or u <= $htFinal)
;       => u
;   null $htFinal =>
;     STRCONC('"Please enter an integer greater than ",stringize ($htInitial - 1))
;   STRCONC('"Please enter an integer between ",stringize $htInitial,'" and ",
;             stringize $htFinal)

(DEFUN |chkRange| (|s|)
  (PROG (|u|)
    (RETURN
     (COND
      ((AND (SETQ |u| (|ncParseFromString| |s|)) (INTEGERP |u|)
            (NOT (< |u| |$htInitial|))
            (OR (NULL |$htFinal|) (NOT (< |$htFinal| |u|))))
       |u|)
      ((NULL |$htFinal|)
       (STRCONC "Please enter an integer greater than "
        (|stringize| (- |$htInitial| 1))))
      ('T
       (STRCONC "Please enter an integer between " (|stringize| |$htInitial|)
        " and " (|stringize| |$htFinal|)))))))

; chkAllNonNegativeInteger s ==
;   (u := ncParseFromString s) and u in '(a al all A AL ALL) and 'ALL
;     or chkNonNegativeInteger s
;        or '"Please enter {\em all} or a non-negative integer"

(DEFUN |chkAllNonNegativeInteger| (|s|)
  (PROG (|u|)
    (RETURN
     (OR
      (AND (SETQ |u| (|ncParseFromString| |s|))
           (|member| |u| '(|a| |al| |all| A AL ALL)) 'ALL)
      (|chkNonNegativeInteger| |s|)
      "Please enter {\\em all} or a non-negative integer"))))

; htMakePathKey path ==
;   null path => systemError '"path is not set"
;   INTERN fn(PNAME first path,rest path) where
;     fn(a,b) ==
;       null b => a
;       fn(STRCONC(a,'".",PNAME first b),rest b)

(DEFUN |htMakePathKey| (|path|)
  (PROG ()
    (RETURN
     (COND ((NULL |path|) (|systemError| "path is not set"))
           ('T
            (INTERN (|htMakePathKey,fn| (PNAME (CAR |path|)) (CDR |path|))))))))
(DEFUN |htMakePathKey,fn| (|a| |b|)
  (PROG ()
    (RETURN
     (COND ((NULL |b|) |a|)
           ('T
            (|htMakePathKey,fn| (STRCONC |a| "." (PNAME (CAR |b|)))
             (CDR |b|)))))))

; htMarkTree(tree,n) ==
;   RPLACD(LASTTAIL tree,n)
;   for branch in tree repeat
;     branch.3 = 'TREE => htMarkTree(branch.5,n + 1)

(DEFUN |htMarkTree| (|tree| |n|)
  (PROG ()
    (RETURN
     (PROGN
      (RPLACD (LASTTAIL |tree|) |n|)
      ((LAMBDA (|bfVar#11| |branch|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#11|) (PROGN (SETQ |branch| (CAR |bfVar#11|)) NIL))
            (RETURN NIL))
           ('T
            (COND
             ((EQ (ELT |branch| 3) 'TREE)
              (IDENTITY (|htMarkTree| (ELT |branch| 5) (+ |n| 1)))))))
          (SETQ |bfVar#11| (CDR |bfVar#11|))))
       |tree| NIL)))))

; htSetHistory htPage ==
;   msg := "when the history facility is on (yes), results of computations are saved in memory"
;   data := ['history,msg,'history,'LITERALS,'$HiFiAccess,'(on off yes no)]
;   htShowLiteralsPage(htPage,data)

(DEFUN |htSetHistory| (|htPage|)
  (PROG (|msg| |data|)
    (RETURN
     (PROGN
      (SETQ |msg|
              '|when the history facility is on (yes), results of computations are saved in memory|)
      (SETQ |data|
              (LIST '|history| |msg| '|history| 'LITERALS '|$HiFiAccess|
                    '(|on| |off| |yes| |no|)))
      (|htShowLiteralsPage| |htPage| |data|)))))

; htSetOutputLibrary htPage ==
;   htSetNotAvailable(htPage,'")set compiler output")

(DEFUN |htSetOutputLibrary| (|htPage|)
  (PROG () (RETURN (|htSetNotAvailable| |htPage| ")set compiler output"))))

; htSetInputLibrary htPage ==
;   htSetNotAvailable(htPage,'")set compiler input")

(DEFUN |htSetInputLibrary| (|htPage|)
  (PROG () (RETURN (|htSetNotAvailable| |htPage| ")set compiler input"))))

; htSetExpose htPage ==
;   htSetNotAvailable(htPage,'")set expose")

(DEFUN |htSetExpose| (|htPage|)
  (PROG () (RETURN (|htSetNotAvailable| |htPage| ")set expose"))))

; htSetKernelProtect htPage ==
;  htSetNotAvailable(htPage,'")set kernel protect")

(DEFUN |htSetKernelProtect| (|htPage|)
  (PROG () (RETURN (|htSetNotAvailable| |htPage| ")set kernel protect"))))

; htSetKernelWarn htPage ==
;  htSetNotAvailable(htPage,'")set kernel warn")

(DEFUN |htSetKernelWarn| (|htPage|)
  (PROG () (RETURN (|htSetNotAvailable| |htPage| ")set kernel warn"))))

; htSetOutputCharacters htPage ==
;   htSetNotAvailable(htPage,'")set output characters")

(DEFUN |htSetOutputCharacters| (|htPage|)
  (PROG () (RETURN (|htSetNotAvailable| |htPage| ")set output characters"))))

; htSetLinkerArgs htPage ==
;   htSetNotAvailable(htPage,'")set fortran calling linker")

(DEFUN |htSetLinkerArgs| (|htPage|)
  (PROG ()
    (RETURN (|htSetNotAvailable| |htPage| ")set fortran calling linker"))))

; htSetCache(htPage,:options) ==
;   $path := '(functions cache)
;   htPage := htInitPage(mkSetTitle(),nil)
;   $valueList := nil
;   htMakePage '(
;    (text
;     "Use this system command to cause the FriCAS interpreter to `remember' "
;     "past values of interpreter functions. "
;     "To remember a past value of a function, the interpreter "
;     "sets up a {\em cache} for that function based on argument values. "
;     "When a value is cached for a given argument value, its value is gotten "
;     "from the cache and not recomputed. Caching can often save much "
;     "computing time, particularly with recursive functions or functions that "
;     "are expensive to compute and that are called repeatedly "
;     "with the same argument."
;     "\vspace{1}\newline ")
;    (domainConditions (Satisfies S chkNameList))
;    (text
;       "Enter below a list of interpreter functions you would like specially cached. "
;       "Use the name {\em all} to give a default setting for all "
;       "interpreter functions. "
;       "\vspace{1}\newline "
;       "Enter {\em all} or a list of names (separate names by blanks):")
;    (inputStrings ("" "" 60 "all" names S))
;    (doneButton "Push to enter names" htCacheAddChoice))
;   htShowPage()

(DEFUN |htSetCache| (|htPage| &REST |options|)
  (PROG ()
    (RETURN
     (PROGN
      (SETQ |$path| '(|functions| |cache|))
      (SETQ |htPage| (|htInitPage| (|mkSetTitle|) NIL))
      (SETQ |$valueList| NIL)
      (|htMakePage|
       '((|text|
          "Use this system command to cause the FriCAS interpreter to `remember' "
          "past values of interpreter functions. "
          "To remember a past value of a function, the interpreter "
          "sets up a {\\em cache} for that function based on argument values. "
          "When a value is cached for a given argument value, its value is gotten "
          "from the cache and not recomputed. Caching can often save much "
          "computing time, particularly with recursive functions or functions that "
          "are expensive to compute and that are called repeatedly "
          "with the same argument." "\\vspace{1}\\newline ")
         (|domainConditions| (|Satisfies| S |chkNameList|))
         (|text|
          "Enter below a list of interpreter functions you would like specially cached. "
          "Use the name {\\em all} to give a default setting for all "
          "interpreter functions. " "\\vspace{1}\\newline "
          "Enter {\\em all} or a list of names (separate names by blanks):")
         (|inputStrings| ("" "" 60 "all" |names| S))
         (|doneButton| "Push to enter names" |htCacheAddChoice|)))
      (|htShowPage|)))))

; htCacheAddChoice htPage ==
;   names := bcString2WordList htpLabelInputString(htPage,'names)
;   $valueList := [listOfStrings2String names,:$valueList]
;   null names => htCacheAddQuery()
;   null rest names => htCacheOne names
;   page := htInitPage(mkSetTitle(),nil)
;   htpSetProperty(page,'names,names)
;   htMakePage '(
;     (domainConditions (Satisfies ALLPI chkAllPositiveInteger))
;     (text
;       "For each function, enter below a {\em cache length}, a positive integer. "
;       "This number tells how many past values will "
;       "be cached. "
;       "A cache length of {\em 0} means the function won't be cached. "
;       "To cache all past values, "
;       "enter {\em all}."
;       "\vspace{1}\newline "
;       "For each function name, enter {\em all} or a positive integer:"))
;   for i in 1.. for name in names repeat htMakePage [
;       ['inputStrings,
;         [STRCONC('"Function {\em ",name,'"} will cache"),
;           '"values",5,10,htMakeLabel('"c",i),'ALLPI]]]
;   htSetvarDoneButton('"Select to Set Values",'htCacheSet)
;   htShowPage()

(DEFUN |htCacheAddChoice| (|htPage|)
  (PROG (|names| |page|)
    (RETURN
     (PROGN
      (SETQ |names|
              (|bcString2WordList| (|htpLabelInputString| |htPage| '|names|)))
      (SETQ |$valueList| (CONS (|listOfStrings2String| |names|) |$valueList|))
      (COND ((NULL |names|) (|htCacheAddQuery|))
            ((NULL (CDR |names|)) (|htCacheOne| |names|))
            (#1='T
             (PROGN
              (SETQ |page| (|htInitPage| (|mkSetTitle|) NIL))
              (|htpSetProperty| |page| '|names| |names|)
              (|htMakePage|
               '((|domainConditions|
                  (|Satisfies| ALLPI |chkAllPositiveInteger|))
                 (|text|
                  "For each function, enter below a {\\em cache length}, a positive integer. "
                  "This number tells how many past values will " "be cached. "
                  "A cache length of {\\em 0} means the function won't be cached. "
                  "To cache all past values, " "enter {\\em all}."
                  "\\vspace{1}\\newline "
                  "For each function name, enter {\\em all} or a positive integer:")))
              ((LAMBDA (|i| |bfVar#12| |name|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#12|)
                        (PROGN (SETQ |name| (CAR |bfVar#12|)) NIL))
                    (RETURN NIL))
                   (#1#
                    (|htMakePage|
                     (LIST
                      (LIST '|inputStrings|
                            (LIST
                             (STRCONC "Function {\\em " |name| "} will cache")
                             "values" 5 10 (|htMakeLabel| "c" |i|) 'ALLPI))))))
                  (SETQ |i| (+ |i| 1))
                  (SETQ |bfVar#12| (CDR |bfVar#12|))))
               1 |names| NIL)
              (|htSetvarDoneButton| "Select to Set Values" '|htCacheSet|)
              (|htShowPage|))))))))

; htMakeLabel(prefix,i) == INTERN STRCONC(prefix,stringize i)

(DEFUN |htMakeLabel| (|prefix| |i|)
  (PROG () (RETURN (INTERN (STRCONC |prefix| (|stringize| |i|))))))

; htCacheSet htPage ==
;   names := htpProperty(htPage,'names)
;   for i in 1.. for name in names repeat
;     num := chkAllNonNegativeInteger
;              htpLabelInputString(htPage,htMakeLabel('"c",i))
;     $cacheAlist := ADDASSOC(INTERN name,num,$cacheAlist)
;   if (n := LASSOC('all,$cacheAlist)) then
;     $cacheCount := n
;     $cacheAlist := deleteAssoc('all,$cacheAlist)
;   htInitPage('"Cache Summary",nil)
;   bcHt '"In general, interpreter functions "
;   bcHt
;     $cacheCount = 0 => "will {\em not} be cached."
;     bcHt '"cache "
;     htAllOrNum $cacheCount
;     '"} values."
;   bcHt '"\vspace{1}\newline "
;   if $cacheAlist then
; --    bcHt '" However, \indent{3}"
;     for [name,:val] in $cacheAlist | val ~= $cacheCount repeat
;       bcHt '"\newline function {\em "
;       bcHt stringize name
;       bcHt '"} will cache "
;       htAllOrNum val
;       bcHt '"} values"
;   htProcessDoitButton ['"Press to Remove Page",'"",'htDoNothing]
;   htShowPage()

(DEFUN |htCacheSet| (|htPage|)
  (PROG (|names| |num| |n| |name| |val|)
    (RETURN
     (PROGN
      (SETQ |names| (|htpProperty| |htPage| '|names|))
      ((LAMBDA (|i| |bfVar#13| |name|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#13|) (PROGN (SETQ |name| (CAR |bfVar#13|)) NIL))
            (RETURN NIL))
           (#1='T
            (PROGN
             (SETQ |num|
                     (|chkAllNonNegativeInteger|
                      (|htpLabelInputString| |htPage|
                       (|htMakeLabel| "c" |i|))))
             (SETQ |$cacheAlist|
                     (ADDASSOC (INTERN |name|) |num| |$cacheAlist|)))))
          (SETQ |i| (+ |i| 1))
          (SETQ |bfVar#13| (CDR |bfVar#13|))))
       1 |names| NIL)
      (COND
       ((SETQ |n| (LASSOC '|all| |$cacheAlist|)) (SETQ |$cacheCount| |n|)
        (SETQ |$cacheAlist| (|deleteAssoc| '|all| |$cacheAlist|))))
      (|htInitPage| "Cache Summary" NIL)
      (|bcHt| "In general, interpreter functions ")
      (|bcHt|
       (COND ((EQL |$cacheCount| 0) '|will {\\em not} be cached.|)
             (#1#
              (PROGN
               (|bcHt| "cache ")
               (|htAllOrNum| |$cacheCount|)
               "} values."))))
      (|bcHt| "\\vspace{1}\\newline ")
      (COND
       (|$cacheAlist|
        ((LAMBDA (|bfVar#15| |bfVar#14|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#15|)
                  (PROGN (SETQ |bfVar#14| (CAR |bfVar#15|)) NIL))
              (RETURN NIL))
             (#1#
              (AND (CONSP |bfVar#14|)
                   (PROGN
                    (SETQ |name| (CAR |bfVar#14|))
                    (SETQ |val| (CDR |bfVar#14|))
                    #1#)
                   (NOT (EQUAL |val| |$cacheCount|))
                   (PROGN
                    (|bcHt| "\\newline function {\\em ")
                    (|bcHt| (|stringize| |name|))
                    (|bcHt| "} will cache ")
                    (|htAllOrNum| |val|)
                    (|bcHt| "} values")))))
            (SETQ |bfVar#15| (CDR |bfVar#15|))))
         |$cacheAlist| NIL)))
      (|htProcessDoitButton| (LIST "Press to Remove Page" "" '|htDoNothing|))
      (|htShowPage|)))))

; htAllOrNum val == bcHt
;   val = 'all => '"{\em all"
;   val = 0 => '"{\em no"
;   STRCONC('"the last {\em ",stringize val)

(DEFUN |htAllOrNum| (|val|)
  (PROG ()
    (RETURN
     (|bcHt|
      (COND ((EQ |val| '|all|) "{\\em all") ((EQL |val| 0) "{\\em no")
            ('T (STRCONC "the last {\\em " (|stringize| |val|))))))))

; htCacheOne names ==
;   page := htInitPage(mkSetTitle(),nil)
;   htpSetProperty(page,'names,names)
;   htMakePage '(
;     (domainConditions (Satisfies ALLPI chkAllPositiveInteger))
;     (text
;       "Enter below a {\em cache length}, a positive integer. "
;       "This number tells how many past values will "
;       "be cached. To cache all past values, "
;       "enter {\em all}."
;       "\vspace{1}\newline ")
;     (inputStrings
;       ("Enter {\em all} or a positive integer:"
;        "" 5 10 c1 ALLPI)))
;   htSetvarDoneButton('"Select to Set Value",'htCacheSet)
;   htShowPage()

(DEFUN |htCacheOne| (|names|)
  (PROG (|page|)
    (RETURN
     (PROGN
      (SETQ |page| (|htInitPage| (|mkSetTitle|) NIL))
      (|htpSetProperty| |page| '|names| |names|)
      (|htMakePage|
       '((|domainConditions| (|Satisfies| ALLPI |chkAllPositiveInteger|))
         (|text| "Enter below a {\\em cache length}, a positive integer. "
          "This number tells how many past values will "
          "be cached. To cache all past values, " "enter {\\em all}."
          "\\vspace{1}\\newline ")
         (|inputStrings|
          ("Enter {\\em all} or a positive integer:" "" 5 10 |c1| ALLPI))))
      (|htSetvarDoneButton| "Select to Set Value" '|htCacheSet|)
      (|htShowPage|)))))
