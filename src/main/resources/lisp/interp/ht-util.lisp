
; )package "BOOT"

(IN-PACKAGE "BOOT")

; $bcParseOnly := true

(EVAL-WHEN (EVAL LOAD) (SETQ |$bcParseOnly| T))

; $htLineList := nil

(EVAL-WHEN (EVAL LOAD) (SETQ |$htLineList| NIL))

; $curPage := nil

(EVAL-WHEN (EVAL LOAD) (SETQ |$curPage| NIL))

; $activePageList := nil

(EVAL-WHEN (EVAL LOAD) (SETQ |$activePageList| NIL))

; htpDestroyPage(pageName) ==
;   pageName in $activePageList =>
;     SET(pageName, nil)
;     $activePageList := NREMOVE($activePageList, pageName)

(DEFUN |htpDestroyPage| (|pageName|)
  (PROG ()
    (RETURN
     (COND
      ((|member| |pageName| |$activePageList|)
       (IDENTITY
        (PROGN
         (SET |pageName| NIL)
         (SETQ |$activePageList| (NREMOVE |$activePageList| |pageName|)))))))))

; htpName htPage ==
; -- GENSYM whose value is the page
;   ELT(htPage, 0)

(DEFUN |htpName| (|htPage|) (PROG () (RETURN (ELT |htPage| 0))))

; htpSetName(htPage, val) ==
;   SETELT(htPage, 0, val)

(DEFUN |htpSetName| (|htPage| |val|)
  (PROG () (RETURN (SETELT |htPage| 0 |val|))))

; htpDomainConditions htPage ==
; -- List of Domain conditions
;   ELT(htPage, 1)

(DEFUN |htpDomainConditions| (|htPage|) (PROG () (RETURN (ELT |htPage| 1))))

; htpSetDomainConditions(htPage, val) ==
;   SETELT(htPage, 1, val)

(DEFUN |htpSetDomainConditions| (|htPage| |val|)
  (PROG () (RETURN (SETELT |htPage| 1 |val|))))

; htpDomainVariableAlist htPage ==
; -- alist of pattern variables and conditions
;   ELT(htPage, 2)

(DEFUN |htpDomainVariableAlist| (|htPage|) (PROG () (RETURN (ELT |htPage| 2))))

; htpSetDomainVariableAlist(htPage, val) ==
;   SETELT(htPage, 2, val)

(DEFUN |htpSetDomainVariableAlist| (|htPage| |val|)
  (PROG () (RETURN (SETELT |htPage| 2 |val|))))

; htpDomainPvarSubstList htPage ==
; -- alist of user pattern variables to system vars
;   ELT(htPage, 3)

(DEFUN |htpDomainPvarSubstList| (|htPage|) (PROG () (RETURN (ELT |htPage| 3))))

; htpSetDomainPvarSubstList(htPage, val) ==
;   SETELT(htPage, 3, val)

(DEFUN |htpSetDomainPvarSubstList| (|htPage| |val|)
  (PROG () (RETURN (SETELT |htPage| 3 |val|))))

; htpRadioButtonAlist htPage ==
; -- alist of radio button group names and labels
;   ELT(htPage, 4)

(DEFUN |htpRadioButtonAlist| (|htPage|) (PROG () (RETURN (ELT |htPage| 4))))

; htpButtonValue(htPage, groupName) ==
;   for buttonName in LASSOC(groupName, htpRadioButtonAlist htPage) repeat
;     (stripSpaces htpLabelInputString(htPage, buttonName)) = '"t" =>
;       return buttonName

(DEFUN |htpButtonValue| (|htPage| |groupName|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#1| |buttonName|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#1|)
               (PROGN (SETQ |buttonName| (CAR |bfVar#1|)) NIL))
           (RETURN NIL))
          ('T
           (COND
            ((EQUAL
              (|stripSpaces| (|htpLabelInputString| |htPage| |buttonName|))
              "t")
             (IDENTITY (RETURN |buttonName|))))))
         (SETQ |bfVar#1| (CDR |bfVar#1|))))
      (LASSOC |groupName| (|htpRadioButtonAlist| |htPage|)) NIL))))

; htpSetRadioButtonAlist(htPage, val) ==
;   SETELT(htPage, 4, val)

(DEFUN |htpSetRadioButtonAlist| (|htPage| |val|)
  (PROG () (RETURN (SETELT |htPage| 4 |val|))))

; htpInputAreaAlist htPage ==
; -- Alist of input-area labels, and default values
;   ELT(htPage, 5)

(DEFUN |htpInputAreaAlist| (|htPage|) (PROG () (RETURN (ELT |htPage| 5))))

; htpSetInputAreaAlist(htPage, val) ==
;   SETELT(htPage, 5, val)

(DEFUN |htpSetInputAreaAlist| (|htPage| |val|)
  (PROG () (RETURN (SETELT |htPage| 5 |val|))))

; htpPropertyList htPage ==
; -- Association list of user-defined properties
;   ELT(htPage, 6)

(DEFUN |htpPropertyList| (|htPage|) (PROG () (RETURN (ELT |htPage| 6))))

; htpProperty(htPage, propName) ==
;   LASSOC(propName, ELT(htPage, 6))

(DEFUN |htpProperty| (|htPage| |propName|)
  (PROG () (RETURN (LASSOC |propName| (ELT |htPage| 6)))))

; htpSetProperty(htPage, propName, val) ==
;   pair := assoc(propName, ELT(htPage, 6))
;   pair => RPLACD(pair, val)
;   SETELT(htPage, 6, [[propName, :val], :ELT(htPage, 6)])

(DEFUN |htpSetProperty| (|htPage| |propName| |val|)
  (PROG (|pair|)
    (RETURN
     (PROGN
      (SETQ |pair| (|assoc| |propName| (ELT |htPage| 6)))
      (COND (|pair| (RPLACD |pair| |val|))
            ('T
             (SETELT |htPage| 6
              (CONS (CONS |propName| |val|) (ELT |htPage| 6)))))))))

; htpLabelInputString(htPage, label) ==
; -- value user typed as input string on page
;   props := LASSOC(label, htpInputAreaAlist htPage)
;   props and STRINGP (s := ELT(props,0)) =>
;     s = '"" => s
;     trimString s
;   nil

(DEFUN |htpLabelInputString| (|htPage| |label|)
  (PROG (|props| |s|)
    (RETURN
     (PROGN
      (SETQ |props| (LASSOC |label| (|htpInputAreaAlist| |htPage|)))
      (COND
       ((AND |props| (STRINGP (SETQ |s| (ELT |props| 0))))
        (COND ((EQUAL |s| "") |s|) (#1='T (|trimString| |s|))))
       (#1# NIL))))))

; htpLabelFilteredInputString(htPage, label) ==
; -- value user typed as input string on page
;   props := LASSOC(label, htpInputAreaAlist htPage)
;   props =>
;     #props > 5 and ELT(props, 6) =>
;       FUNCALL(SYMBOL_-FUNCTION ELT(props, 6), ELT(props, 0))
;     replacePercentByDollar ELT(props, 0)
;   nil

(DEFUN |htpLabelFilteredInputString| (|htPage| |label|)
  (PROG (|props|)
    (RETURN
     (PROGN
      (SETQ |props| (LASSOC |label| (|htpInputAreaAlist| |htPage|)))
      (COND
       (|props|
        (COND
         ((AND (< 5 (LENGTH |props|)) (ELT |props| 6))
          (FUNCALL (SYMBOL-FUNCTION (ELT |props| 6)) (ELT |props| 0)))
         (#1='T (|replacePercentByDollar| (ELT |props| 0)))))
       (#1# NIL))))))

; replacePercentByDollar s == fn(s,0,MAXINDEX s) where
;   fn(s,i,n) ==
;     i > n => '""
;     (m := charPosition(char "%",s,i)) > n => SUBSTRING(s,i,nil)
;     STRCONC(SUBSTRING(s,i,m - i),'"$",fn(s,m + 1,n))

(DEFUN |replacePercentByDollar| (|s|)
  (PROG () (RETURN (|replacePercentByDollar,fn| |s| 0 (MAXINDEX |s|)))))
(DEFUN |replacePercentByDollar,fn| (|s| |i| |n|)
  (PROG (|m|)
    (RETURN
     (COND ((< |n| |i|) "")
           ((< |n| (SETQ |m| (|charPosition| (|char| '%) |s| |i|)))
            (SUBSTRING |s| |i| NIL))
           ('T
            (STRCONC (SUBSTRING |s| |i| (- |m| |i|)) "$"
             (|replacePercentByDollar,fn| |s| (+ |m| 1) |n|)))))))

; htpLabelSpadValue(htPage, label) ==
; -- Scratchpad value of parsed and evaled inputString, as (type . value)
;   props := LASSOC(label, htpInputAreaAlist htPage)
;   props => ELT(props, 1)
;   nil

(DEFUN |htpLabelSpadValue| (|htPage| |label|)
  (PROG (|props|)
    (RETURN
     (PROGN
      (SETQ |props| (LASSOC |label| (|htpInputAreaAlist| |htPage|)))
      (COND (|props| (ELT |props| 1)) ('T NIL))))))

; htpSetLabelSpadValue(htPage, label, val) ==
; -- value user typed as input string on page
;   props := LASSOC(label, htpInputAreaAlist htPage)
;   props => SETELT(props, 1, val)
;   nil

(DEFUN |htpSetLabelSpadValue| (|htPage| |label| |val|)
  (PROG (|props|)
    (RETURN
     (PROGN
      (SETQ |props| (LASSOC |label| (|htpInputAreaAlist| |htPage|)))
      (COND (|props| (SETELT |props| 1 |val|)) ('T NIL))))))

; htpLabelErrorMsg(htPage, label) ==
; -- error message associated with input area
;   props := LASSOC(label, htpInputAreaAlist htPage)
;   props => ELT(props, 2)
;   nil

(DEFUN |htpLabelErrorMsg| (|htPage| |label|)
  (PROG (|props|)
    (RETURN
     (PROGN
      (SETQ |props| (LASSOC |label| (|htpInputAreaAlist| |htPage|)))
      (COND (|props| (ELT |props| 2)) ('T NIL))))))

; htpSetLabelErrorMsg(htPage, label, val) ==
; -- error message associated with input area
;   props := LASSOC(label, htpInputAreaAlist htPage)
;   props => SETELT(props, 2, val)
;   nil

(DEFUN |htpSetLabelErrorMsg| (|htPage| |label| |val|)
  (PROG (|props|)
    (RETURN
     (PROGN
      (SETQ |props| (LASSOC |label| (|htpInputAreaAlist| |htPage|)))
      (COND (|props| (SETELT |props| 2 |val|)) ('T NIL))))))

; htpLabelType(htPage, label) ==
; -- either 'string or 'button
;   props := LASSOC(label, htpInputAreaAlist htPage)
;   props => ELT(props, 3)
;   nil

(DEFUN |htpLabelType| (|htPage| |label|)
  (PROG (|props|)
    (RETURN
     (PROGN
      (SETQ |props| (LASSOC |label| (|htpInputAreaAlist| |htPage|)))
      (COND (|props| (ELT |props| 3)) ('T NIL))))))

; htpLabelDefault(htPage, label) ==
; -- default value for the input area
;   msg := htpLabelInputString(htPage, label) =>
;     msg = '"t" => 1
;     msg = '"nil" => 0
;     msg
;   props := LASSOC(label, htpInputAreaAlist htPage)
;   props =>
;     ELT(props, 4)
;   nil

(DEFUN |htpLabelDefault| (|htPage| |label|)
  (PROG (|msg| |props|)
    (RETURN
     (COND
      ((SETQ |msg| (|htpLabelInputString| |htPage| |label|))
       (COND ((EQUAL |msg| "t") 1) ((EQUAL |msg| "nil") 0) (#1='T |msg|)))
      (#1#
       (PROGN
        (SETQ |props| (LASSOC |label| (|htpInputAreaAlist| |htPage|)))
        (COND (|props| (ELT |props| 4)) (#1# NIL))))))))

; htpLabelSpadType(htPage, label) ==
; -- pattern variable for target domain for input area
;   props := LASSOC(label, htpInputAreaAlist htPage)
;   props => ELT(props, 5)
;   nil

(DEFUN |htpLabelSpadType| (|htPage| |label|)
  (PROG (|props|)
    (RETURN
     (PROGN
      (SETQ |props| (LASSOC |label| (|htpInputAreaAlist| |htPage|)))
      (COND (|props| (ELT |props| 5)) ('T NIL))))))

; htpLabelFilter(htPage, label) ==
; -- string to string mapping applied to input area strings before parsing
;   props := LASSOC(label, htpInputAreaAlist htPage)
;   props => ELT(props, 6)
;   nil

(DEFUN |htpLabelFilter| (|htPage| |label|)
  (PROG (|props|)
    (RETURN
     (PROGN
      (SETQ |props| (LASSOC |label| (|htpInputAreaAlist| |htPage|)))
      (COND (|props| (ELT |props| 6)) ('T NIL))))))

; htpPageDescription htPage ==
; -- a list of all the commands issued to create the basic-command page
;   ELT(htPage, 7)

(DEFUN |htpPageDescription| (|htPage|) (PROG () (RETURN (ELT |htPage| 7))))

; htpSetPageDescription(htPage, pageDescription) ==
;   SETELT(htPage, 7, pageDescription)

(DEFUN |htpSetPageDescription| (|htPage| |pageDescription|)
  (PROG () (RETURN (SETELT |htPage| 7 |pageDescription|))))

; iht line ==
; -- issue a single hyperteTeX line, or a group of lines
;   $newPage => nil
;   PAIRP line =>
;     $htLineList := NCONC(nreverse mapStringize COPY_-LIST line, $htLineList)
;   $htLineList := [basicStringize line, :$htLineList]

(DEFUN |iht| (|line|)
  (PROG ()
    (RETURN
     (COND (|$newPage| NIL)
           ((CONSP |line|)
            (SETQ |$htLineList|
                    (NCONC (NREVERSE (|mapStringize| (COPY-LIST |line|)))
                           |$htLineList|)))
           ('T
            (SETQ |$htLineList|
                    (CONS (|basicStringize| |line|) |$htLineList|)))))))

; bcIssueHt line ==
;   PAIRP line => htMakePage1 line
;   iht line

(DEFUN |bcIssueHt| (|line|)
  (PROG ()
    (RETURN
     (COND ((CONSP |line|) (|htMakePage1| |line|)) ('T (|iht| |line|))))))

; mapStringize l ==
;   ATOM l => l
;   RPLACA(l, basicStringize first l)
;   RPLACD(l, mapStringize rest l)
;   l

(DEFUN |mapStringize| (|l|)
  (PROG ()
    (RETURN
     (COND ((ATOM |l|) |l|)
           ('T
            (PROGN
             (RPLACA |l| (|basicStringize| (CAR |l|)))
             (RPLACD |l| (|mapStringize| (CDR |l|)))
             |l|))))))

; basicStringize s ==
;   STRINGP s =>
;     s = '"\$"      => '"\%"
;     s = '"{\em $}" => '"{\em \%}"
;     s
;   s = '_$ => '"\%"
;   PRINC_-TO_-STRING s

(DEFUN |basicStringize| (|s|)
  (PROG ()
    (RETURN
     (COND
      ((STRINGP |s|)
       (COND ((EQUAL |s| "\\$") "\\%") ((EQUAL |s| "{\\em $}") "{\\em \\%}")
             (#1='T |s|)))
      ((EQ |s| '$) "\\%") (#1# (PRINC-TO-STRING |s|))))))

; stringize s ==
;   STRINGP s => s
;   PRINC_-TO_-STRING s

(DEFUN |stringize| (|s|)
  (PROG () (RETURN (COND ((STRINGP |s|) |s|) ('T (PRINC-TO-STRING |s|))))))

; htQuote s ==
; -- wrap quotes around a piece of hyperTeX
;   iht '"_""
;   iht s
;   iht '"_""

(DEFUN |htQuote| (|s|)
  (PROG () (RETURN (PROGN (|iht| "\"") (|iht| |s|) (|iht| "\"")))))

; htProcessToggleButtons buttons ==
;   iht '"\newline\indent{5}\beginitems "
;   for [message, info, defaultValue, buttonName] in buttons repeat
;     if NULL LASSOC(buttonName, htpInputAreaAlist $curPage) then
;       setUpDefault(buttonName, ['button, defaultValue])
;     iht ['"\item{\em\inputbox[", htpLabelDefault($curPage, buttonName), '"]{",
;          buttonName, '"}{\htbmfile{pick}}{\htbmfile{unpick}}\space{}"]
;     bcIssueHt message
;     iht '"\space{}}"
;     bcIssueHt info
;   iht '"\enditems\indent{0} "

(DEFUN |htProcessToggleButtons| (|buttons|)
  (PROG (|message| |ISTMP#1| |info| |ISTMP#2| |defaultValue| |ISTMP#3|
         |buttonName|)
    (RETURN
     (PROGN
      (|iht| "\\newline\\indent{5}\\beginitems ")
      ((LAMBDA (|bfVar#3| |bfVar#2|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#3|) (PROGN (SETQ |bfVar#2| (CAR |bfVar#3|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#2|)
                 (PROGN
                  (SETQ |message| (CAR |bfVar#2|))
                  (SETQ |ISTMP#1| (CDR |bfVar#2|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |info| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|)
                             (PROGN
                              (SETQ |defaultValue| (CAR |ISTMP#2|))
                              (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                              (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                                   (PROGN
                                    (SETQ |buttonName| (CAR |ISTMP#3|))
                                    #1#)))))))
                 (PROGN
                  (COND
                   ((NULL
                     (LASSOC |buttonName| (|htpInputAreaAlist| |$curPage|)))
                    (|setUpDefault| |buttonName|
                     (LIST '|button| |defaultValue|))))
                  (|iht|
                   (LIST "\\item{\\em\\inputbox["
                         (|htpLabelDefault| |$curPage| |buttonName|) "]{"
                         |buttonName|
                         "}{\\htbmfile{pick}}{\\htbmfile{unpick}}\\space{}"))
                  (|bcIssueHt| |message|)
                  (|iht| "\\space{}}")
                  (|bcIssueHt| |info|)))))
          (SETQ |bfVar#3| (CDR |bfVar#3|))))
       |buttons| NIL)
      (|iht| "\\enditems\\indent{0} ")))))

; htProcessBcButtons buttons ==
;   for [defaultValue, buttonName] in buttons repeat
;     if NULL LASSOC(buttonName, htpInputAreaAlist $curPage) then
;       setUpDefault(buttonName, ['button, defaultValue])
;     k := htpLabelDefault($curPage,buttonName)
;     k = 0 => iht ['"\off{",buttonName,'"}"]
;     k = 1 => iht ['"\on{", buttonName,'"}"]
;     iht ['"\inputbox[", htpLabelDefault($curPage, buttonName), '"]{",
;          buttonName, '"}{\htbmfile{pick}}{\htbmfile{unpick}}"]

(DEFUN |htProcessBcButtons| (|buttons|)
  (PROG (|defaultValue| |ISTMP#1| |buttonName| |k|)
    (RETURN
     ((LAMBDA (|bfVar#5| |bfVar#4|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#5|) (PROGN (SETQ |bfVar#4| (CAR |bfVar#5|)) NIL))
           (RETURN NIL))
          (#1='T
           (AND (CONSP |bfVar#4|)
                (PROGN
                 (SETQ |defaultValue| (CAR |bfVar#4|))
                 (SETQ |ISTMP#1| (CDR |bfVar#4|))
                 (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                      (PROGN (SETQ |buttonName| (CAR |ISTMP#1|)) #1#)))
                (PROGN
                 (COND
                  ((NULL
                    (LASSOC |buttonName| (|htpInputAreaAlist| |$curPage|)))
                   (|setUpDefault| |buttonName|
                    (LIST '|button| |defaultValue|))))
                 (SETQ |k| (|htpLabelDefault| |$curPage| |buttonName|))
                 (COND ((EQL |k| 0) (|iht| (LIST "\\off{" |buttonName| "}")))
                       ((EQL |k| 1) (|iht| (LIST "\\on{" |buttonName| "}")))
                       (#1#
                        (|iht|
                         (LIST "\\inputbox["
                               (|htpLabelDefault| |$curPage| |buttonName|) "]{"
                               |buttonName|
                               "}{\\htbmfile{pick}}{\\htbmfile{unpick}}"))))))))
         (SETQ |bfVar#5| (CDR |bfVar#5|))))
      |buttons| NIL))))

; bcSadFaces() ==
;   '"\space{1}{\em\htbitmap{error}\htbitmap{error}\htbitmap{error}}"

(DEFUN |bcSadFaces| ()
  (PROG ()
    (RETURN
     "\\space{1}{\\em\\htbitmap{error}\\htbitmap{error}\\htbitmap{error}}")))

; htLispLinks(links,:option) ==
;   [links,options] := beforeAfter('options,links)
;   indent := LASSOC('indent,options) or 5
;   iht '"\newline\indent{"
;   iht stringize indent
;   iht '"}\beginitems"
;   for [message, info, func, :value] in links repeat
;     iht '"\item["
;     call := (IFCAR option => '"\lispmemolink"; '"\lispdownlink")
;     htMakeButton(call,message, mkCurryFun(func, value))
;     iht ['"]\space{}"]
;     bcIssueHt info
;   iht '"\enditems\indent{0} "

(DEFUN |htLispLinks| (|links| &REST |option|)
  (PROG (|LETTMP#1| |options| |indent| |message| |ISTMP#1| |info| |ISTMP#2|
         |func| |value| |call|)
    (RETURN
     (PROGN
      (SETQ |LETTMP#1| (|beforeAfter| '|options| |links|))
      (SETQ |links| (CAR |LETTMP#1|))
      (SETQ |options| (CADR |LETTMP#1|))
      (SETQ |indent| (OR (LASSOC '|indent| |options|) 5))
      (|iht| "\\newline\\indent{")
      (|iht| (|stringize| |indent|))
      (|iht| "}\\beginitems")
      ((LAMBDA (|bfVar#7| |bfVar#6|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#7|) (PROGN (SETQ |bfVar#6| (CAR |bfVar#7|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#6|)
                 (PROGN
                  (SETQ |message| (CAR |bfVar#6|))
                  (SETQ |ISTMP#1| (CDR |bfVar#6|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |info| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|)
                             (PROGN
                              (SETQ |func| (CAR |ISTMP#2|))
                              (SETQ |value| (CDR |ISTMP#2|))
                              #1#)))))
                 (PROGN
                  (|iht| "\\item[")
                  (SETQ |call|
                          (COND ((IFCAR |option|) "\\lispmemolink")
                                (#1# "\\lispdownlink")))
                  (|htMakeButton| |call| |message|
                   (|mkCurryFun| |func| |value|))
                  (|iht| (LIST "]\\space{}"))
                  (|bcIssueHt| |info|)))))
          (SETQ |bfVar#7| (CDR |bfVar#7|))))
       |links| NIL)
      (|iht| "\\enditems\\indent{0} ")))))

; htLispMemoLinks(links) == htLispLinks(links,true)

(DEFUN |htLispMemoLinks| (|links|) (PROG () (RETURN (|htLispLinks| |links| T))))

; beforeAfter(x,u) == [[y for [y,:r] in tails u while x ~= y],r]

(DEFUN |beforeAfter| (|x| |u|)
  (PROG (|y| |r|)
    (RETURN
     (LIST
      ((LAMBDA (|bfVar#9| |bfVar#8|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#8|) (EQUAL |x| |y|))
            (RETURN (NREVERSE |bfVar#9|)))
           (#1='T
            (AND (CONSP |bfVar#8|)
                 (PROGN
                  (SETQ |y| (CAR |bfVar#8|))
                  (SETQ |r| (CDR |bfVar#8|))
                  #1#)
                 (SETQ |bfVar#9| (CONS |y| |bfVar#9|)))))
          (SETQ |bfVar#8| (CDR |bfVar#8|))))
       NIL |u|)
      |r|))))

; mkCurryFun(fun, val) ==
;   name := GENTEMP()
;   code :=
;     ['DEFUN, name, '(arg), ['APPLY, MKQ fun, ['CONS, 'arg, MKQ val]]]
;   EVAL code
;   name

(DEFUN |mkCurryFun| (|fun| |val|)
  (PROG (|name| |code|)
    (RETURN
     (PROGN
      (SETQ |name| (GENTEMP))
      (SETQ |code|
              (LIST 'DEFUN |name| '(|arg|)
                    (LIST 'APPLY (MKQ |fun|) (LIST 'CONS '|arg| (MKQ |val|)))))
      (EVAL |code|)
      |name|))))

; htRadioButtons [groupName, :buttons] ==
;   htpSetRadioButtonAlist($curPage, [[groupName, :buttonNames buttons],
;                                     : htpRadioButtonAlist $curPage])
;   boxesName := GENTEMP()
;   iht ['"\newline\indent{5}\radioboxes{", boxesName,
;      '"}{\htbmfile{pick}}{\htbmfile{unpick}}\beginitems "]
;   defaultValue := '"1"
;   for [message, info, buttonName] in buttons repeat
;     if NULL LASSOC(buttonName, htpInputAreaAlist $curPage) then
;       setUpDefault(buttonName, ['button, defaultValue])
;       defaultValue := '"0"
;     iht ['"\item{\em\radiobox[", htpLabelDefault($curPage, buttonName), '"]{",
;          buttonName, '"}{",boxesName, '"}\space{}"]
;     bcIssueHt message
;     iht '"\space{}}"
;     bcIssueHt info
;   iht '"\enditems\indent{0} "

(DEFUN |htRadioButtons| (|bfVar#12|)
  (PROG (|groupName| |buttons| |boxesName| |defaultValue| |message| |ISTMP#1|
         |info| |ISTMP#2| |buttonName|)
    (RETURN
     (PROGN
      (SETQ |groupName| (CAR |bfVar#12|))
      (SETQ |buttons| (CDR |bfVar#12|))
      (|htpSetRadioButtonAlist| |$curPage|
       (CONS (CONS |groupName| (|buttonNames| |buttons|))
             (|htpRadioButtonAlist| |$curPage|)))
      (SETQ |boxesName| (GENTEMP))
      (|iht|
       (LIST "\\newline\\indent{5}\\radioboxes{" |boxesName|
             "}{\\htbmfile{pick}}{\\htbmfile{unpick}}\\beginitems "))
      (SETQ |defaultValue| "1")
      ((LAMBDA (|bfVar#11| |bfVar#10|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#11|)
                (PROGN (SETQ |bfVar#10| (CAR |bfVar#11|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#10|)
                 (PROGN
                  (SETQ |message| (CAR |bfVar#10|))
                  (SETQ |ISTMP#1| (CDR |bfVar#10|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |info| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN
                              (SETQ |buttonName| (CAR |ISTMP#2|))
                              #1#)))))
                 (PROGN
                  (COND
                   ((NULL
                     (LASSOC |buttonName| (|htpInputAreaAlist| |$curPage|)))
                    (|setUpDefault| |buttonName|
                     (LIST '|button| |defaultValue|))
                    (SETQ |defaultValue| "0")))
                  (|iht|
                   (LIST "\\item{\\em\\radiobox["
                         (|htpLabelDefault| |$curPage| |buttonName|) "]{"
                         |buttonName| "}{" |boxesName| "}\\space{}"))
                  (|bcIssueHt| |message|)
                  (|iht| "\\space{}}")
                  (|bcIssueHt| |info|)))))
          (SETQ |bfVar#11| (CDR |bfVar#11|))))
       |buttons| NIL)
      (|iht| "\\enditems\\indent{0} ")))))

; htBcRadioButtons [groupName, :buttons] ==
;   htpSetRadioButtonAlist($curPage, [[groupName, :buttonNames buttons],
;                                     : htpRadioButtonAlist $curPage])
;   boxesName := GENTEMP()
;   iht ['"\radioboxes{", boxesName,
;      '"}{\htbmfile{pick}}{\htbmfile{unpick}} "]
;   defaultValue := '"1"
;   for [message, info, buttonName] in buttons repeat
;     if NULL LASSOC(buttonName, htpInputAreaAlist $curPage) then
;       setUpDefault(buttonName, ['button, defaultValue])
;       defaultValue := '"0"
;     iht ['"{\em\radiobox[", htpLabelDefault($curPage, buttonName), '"]{",
;          buttonName, '"}{",boxesName, '"}"]
;     bcIssueHt message
;     iht '"\space{}}"
;     bcIssueHt info

(DEFUN |htBcRadioButtons| (|bfVar#15|)
  (PROG (|groupName| |buttons| |boxesName| |defaultValue| |message| |ISTMP#1|
         |info| |ISTMP#2| |buttonName|)
    (RETURN
     (PROGN
      (SETQ |groupName| (CAR |bfVar#15|))
      (SETQ |buttons| (CDR |bfVar#15|))
      (|htpSetRadioButtonAlist| |$curPage|
       (CONS (CONS |groupName| (|buttonNames| |buttons|))
             (|htpRadioButtonAlist| |$curPage|)))
      (SETQ |boxesName| (GENTEMP))
      (|iht|
       (LIST "\\radioboxes{" |boxesName|
             "}{\\htbmfile{pick}}{\\htbmfile{unpick}} "))
      (SETQ |defaultValue| "1")
      ((LAMBDA (|bfVar#14| |bfVar#13|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#14|)
                (PROGN (SETQ |bfVar#13| (CAR |bfVar#14|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#13|)
                 (PROGN
                  (SETQ |message| (CAR |bfVar#13|))
                  (SETQ |ISTMP#1| (CDR |bfVar#13|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |info| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN
                              (SETQ |buttonName| (CAR |ISTMP#2|))
                              #1#)))))
                 (PROGN
                  (COND
                   ((NULL
                     (LASSOC |buttonName| (|htpInputAreaAlist| |$curPage|)))
                    (|setUpDefault| |buttonName|
                     (LIST '|button| |defaultValue|))
                    (SETQ |defaultValue| "0")))
                  (|iht|
                   (LIST "{\\em\\radiobox["
                         (|htpLabelDefault| |$curPage| |buttonName|) "]{"
                         |buttonName| "}{" |boxesName| "}"))
                  (|bcIssueHt| |message|)
                  (|iht| "\\space{}}")
                  (|bcIssueHt| |info|)))))
          (SETQ |bfVar#14| (CDR |bfVar#14|))))
       |buttons| NIL)))))

; buttonNames buttons ==
;   [buttonName for [.,., buttonName] in buttons]

(DEFUN |buttonNames| (|buttons|)
  (PROG (|ISTMP#1| |ISTMP#2| |buttonName|)
    (RETURN
     ((LAMBDA (|bfVar#18| |bfVar#17| |bfVar#16|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#17|)
               (PROGN (SETQ |bfVar#16| (CAR |bfVar#17|)) NIL))
           (RETURN (NREVERSE |bfVar#18|)))
          (#1='T
           (AND (CONSP |bfVar#16|)
                (PROGN
                 (SETQ |ISTMP#1| (CDR |bfVar#16|))
                 (AND (CONSP |ISTMP#1|)
                      (PROGN
                       (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                       (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                            (PROGN (SETQ |buttonName| (CAR |ISTMP#2|)) #1#)))))
                (SETQ |bfVar#18| (CONS |buttonName| |bfVar#18|)))))
         (SETQ |bfVar#17| (CDR |bfVar#17|))))
      NIL |buttons| NIL))))

; htInputStrings strings ==
;   iht '"\newline\indent{5}\beginitems "
;   for [mess1, mess2, numChars, default, stringName, spadType, :filter]
;    in strings repeat
;     if NULL LASSOC(stringName, htpInputAreaAlist $curPage) then
;       setUpDefault(stringName, ['string, default, spadType, filter])
;     if htpLabelErrorMsg($curPage, stringName) then
;       iht ['"\centerline{{\em ", htpLabelErrorMsg($curPage, stringName), '"}}"]
;
;       mess2 := CONCAT(mess2, bcSadFaces())
;       htpSetLabelErrorMsg($curPage, stringName, nil)
;     iht '"\item "
;     bcIssueHt mess1
;     iht ['"\inputstring{", stringName, '"}{",
;          numChars, '"}{", htpLabelDefault($curPage,stringName), '"} "]
;     bcIssueHt mess2
;   iht '"\enditems\indent{0}\newline "

(DEFUN |htInputStrings| (|strings|)
  (PROG (|mess1| |ISTMP#1| |mess2| |ISTMP#2| |numChars| |ISTMP#3| |default|
         |ISTMP#4| |stringName| |ISTMP#5| |spadType| |filter|)
    (RETURN
     (PROGN
      (|iht| "\\newline\\indent{5}\\beginitems ")
      ((LAMBDA (|bfVar#20| |bfVar#19|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#20|)
                (PROGN (SETQ |bfVar#19| (CAR |bfVar#20|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#19|)
                 (PROGN
                  (SETQ |mess1| (CAR |bfVar#19|))
                  (SETQ |ISTMP#1| (CDR |bfVar#19|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |mess2| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|)
                             (PROGN
                              (SETQ |numChars| (CAR |ISTMP#2|))
                              (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                              (AND (CONSP |ISTMP#3|)
                                   (PROGN
                                    (SETQ |default| (CAR |ISTMP#3|))
                                    (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                                    (AND (CONSP |ISTMP#4|)
                                         (PROGN
                                          (SETQ |stringName| (CAR |ISTMP#4|))
                                          (SETQ |ISTMP#5| (CDR |ISTMP#4|))
                                          (AND (CONSP |ISTMP#5|)
                                               (PROGN
                                                (SETQ |spadType|
                                                        (CAR |ISTMP#5|))
                                                (SETQ |filter| (CDR |ISTMP#5|))
                                                #1#)))))))))))
                 (PROGN
                  (COND
                   ((NULL
                     (LASSOC |stringName| (|htpInputAreaAlist| |$curPage|)))
                    (|setUpDefault| |stringName|
                     (LIST '|string| |default| |spadType| |filter|))))
                  (COND
                   ((|htpLabelErrorMsg| |$curPage| |stringName|)
                    (|iht|
                     (LIST "\\centerline{{\\em "
                           (|htpLabelErrorMsg| |$curPage| |stringName|) "}}"))
                    (SETQ |mess2| (CONCAT |mess2| (|bcSadFaces|)))
                    (|htpSetLabelErrorMsg| |$curPage| |stringName| NIL)))
                  (|iht| "\\item ")
                  (|bcIssueHt| |mess1|)
                  (|iht|
                   (LIST "\\inputstring{" |stringName| "}{" |numChars| "}{"
                         (|htpLabelDefault| |$curPage| |stringName|) "} "))
                  (|bcIssueHt| |mess2|)))))
          (SETQ |bfVar#20| (CDR |bfVar#20|))))
       |strings| NIL)
      (|iht| "\\enditems\\indent{0}\\newline ")))))

; htProcessDomainConditions condList ==
;   htpSetDomainConditions($curPage, renamePatternVariables condList)
;   htpSetDomainVariableAlist($curPage, computeDomainVariableAlist())

(DEFUN |htProcessDomainConditions| (|condList|)
  (PROG ()
    (RETURN
     (PROGN
      (|htpSetDomainConditions| |$curPage|
       (|renamePatternVariables| |condList|))
      (|htpSetDomainVariableAlist| |$curPage|
       (|computeDomainVariableAlist|))))))

; renamePatternVariables condList ==
;   htpSetDomainPvarSubstList($curPage,
;     renamePatternVariables1(condList, nil, $PatternVariableList))
;   substFromAlist(condList, htpDomainPvarSubstList $curPage)

(DEFUN |renamePatternVariables| (|condList|)
  (PROG ()
    (RETURN
     (PROGN
      (|htpSetDomainPvarSubstList| |$curPage|
       (|renamePatternVariables1| |condList| NIL |$PatternVariableList|))
      (|substFromAlist| |condList| (|htpDomainPvarSubstList| |$curPage|))))))

; renamePatternVariables1(condList, substList, patVars) ==
;   null condList => substList
;   [cond, :restConds] := condList
;   cond is ['isDomain, pv, pattern] or cond is ['ofCategory, pv, pattern]
;     or cond is ['Satisfies, pv, cond] =>
;       if pv = $EmptyMode then nsubst := substList
;       else nsubst := [[pv, :car patVars], :substList]
;       renamePatternVariables1(restConds, nsubst, rest patVars)
;   substList

(DEFUN |renamePatternVariables1| (|condList| |substList| |patVars|)
  (PROG (|cond| |restConds| |ISTMP#1| |pv| |ISTMP#2| |pattern| |nsubst|)
    (RETURN
     (COND ((NULL |condList|) |substList|)
           (#1='T
            (PROGN
             (SETQ |cond| (CAR |condList|))
             (SETQ |restConds| (CDR |condList|))
             (COND
              ((OR
                (AND (CONSP |cond|) (EQ (CAR |cond|) '|isDomain|)
                     (PROGN
                      (SETQ |ISTMP#1| (CDR |cond|))
                      (AND (CONSP |ISTMP#1|)
                           (PROGN
                            (SETQ |pv| (CAR |ISTMP#1|))
                            (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                            (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                 (PROGN
                                  (SETQ |pattern| (CAR |ISTMP#2|))
                                  #1#))))))
                (AND (CONSP |cond|) (EQ (CAR |cond|) '|ofCategory|)
                     (PROGN
                      (SETQ |ISTMP#1| (CDR |cond|))
                      (AND (CONSP |ISTMP#1|)
                           (PROGN
                            (SETQ |pv| (CAR |ISTMP#1|))
                            (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                            (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                 (PROGN
                                  (SETQ |pattern| (CAR |ISTMP#2|))
                                  #1#))))))
                (AND (CONSP |cond|) (EQ (CAR |cond|) '|Satisfies|)
                     (PROGN
                      (SETQ |ISTMP#1| (CDR |cond|))
                      (AND (CONSP |ISTMP#1|)
                           (PROGN
                            (SETQ |pv| (CAR |ISTMP#1|))
                            (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                            (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                 (PROGN
                                  (SETQ |cond| (CAR |ISTMP#2|))
                                  #1#)))))))
               (PROGN
                (COND ((EQUAL |pv| |$EmptyMode|) (SETQ |nsubst| |substList|))
                      (#1#
                       (SETQ |nsubst|
                               (CONS (CONS |pv| (CAR |patVars|))
                                     |substList|))))
                (|renamePatternVariables1| |restConds| |nsubst|
                 (CDR |patVars|))))
              (#1# |substList|))))))))

; substFromAlist(l, substAlist) ==
;   for [pvar, :replace] in substAlist repeat
;     l := substitute(replace, pvar, l)
;   l

(DEFUN |substFromAlist| (|l| |substAlist|)
  (PROG (|pvar| |replace|)
    (RETURN
     (PROGN
      ((LAMBDA (|bfVar#22| |bfVar#21|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#22|)
                (PROGN (SETQ |bfVar#21| (CAR |bfVar#22|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#21|)
                 (PROGN
                  (SETQ |pvar| (CAR |bfVar#21|))
                  (SETQ |replace| (CDR |bfVar#21|))
                  #1#)
                 (SETQ |l| (|substitute| |replace| |pvar| |l|)))))
          (SETQ |bfVar#22| (CDR |bfVar#22|))))
       |substAlist| NIL)
      |l|))))

; computeDomainVariableAlist() ==
;   [[pvar, :pvarCondList pvar] for [., :pvar] in
;     htpDomainPvarSubstList $curPage]

(DEFUN |computeDomainVariableAlist| ()
  (PROG (|pvar|)
    (RETURN
     ((LAMBDA (|bfVar#25| |bfVar#24| |bfVar#23|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#24|)
               (PROGN (SETQ |bfVar#23| (CAR |bfVar#24|)) NIL))
           (RETURN (NREVERSE |bfVar#25|)))
          (#1='T
           (AND (CONSP |bfVar#23|) (PROGN (SETQ |pvar| (CDR |bfVar#23|)) #1#)
                (SETQ |bfVar#25|
                        (CONS (CONS |pvar| (|pvarCondList| |pvar|))
                              |bfVar#25|)))))
         (SETQ |bfVar#24| (CDR |bfVar#24|))))
      NIL (|htpDomainPvarSubstList| |$curPage|) NIL))))

; pvarCondList pvar ==
;   nreverse pvarCondList1([pvar], nil, htpDomainConditions $curPage)

(DEFUN |pvarCondList| (|pvar|)
  (PROG ()
    (RETURN
     (NREVERSE
      (|pvarCondList1| (LIST |pvar|) NIL (|htpDomainConditions| |$curPage|))))))

; pvarCondList1(pvarList, activeConds, condList) ==
;   null condList => activeConds
;   [cond, : restConds] := condList
;   cond is [., pv, pattern] and pv in pvarList =>
;     pvarCondList1(nconc(pvarList, pvarsOfPattern pattern),
;                   [cond, :activeConds], restConds)
;   pvarCondList1(pvarList, activeConds, restConds)

(DEFUN |pvarCondList1| (|pvarList| |activeConds| |condList|)
  (PROG (|cond| |restConds| |ISTMP#1| |pv| |ISTMP#2| |pattern|)
    (RETURN
     (COND ((NULL |condList|) |activeConds|)
           (#1='T
            (PROGN
             (SETQ |cond| (CAR |condList|))
             (SETQ |restConds| (CDR |condList|))
             (COND
              ((AND (CONSP |cond|)
                    (PROGN
                     (SETQ |ISTMP#1| (CDR |cond|))
                     (AND (CONSP |ISTMP#1|)
                          (PROGN
                           (SETQ |pv| (CAR |ISTMP#1|))
                           (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                           (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                (PROGN
                                 (SETQ |pattern| (CAR |ISTMP#2|))
                                 #1#)))))
                    (|member| |pv| |pvarList|))
               (|pvarCondList1| (NCONC |pvarList| (|pvarsOfPattern| |pattern|))
                (CONS |cond| |activeConds|) |restConds|))
              (#1#
               (|pvarCondList1| |pvarList| |activeConds| |restConds|)))))))))

; pvarsOfPattern pattern ==
;   NULL LISTP pattern => nil
;   [pvar for pvar in rest pattern | pvar in $PatternVariableList]

(DEFUN |pvarsOfPattern| (|pattern|)
  (PROG ()
    (RETURN
     (COND ((NULL (LISTP |pattern|)) NIL)
           (#1='T
            ((LAMBDA (|bfVar#27| |bfVar#26| |pvar|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#26|)
                      (PROGN (SETQ |pvar| (CAR |bfVar#26|)) NIL))
                  (RETURN (NREVERSE |bfVar#27|)))
                 (#1#
                  (AND (|member| |pvar| |$PatternVariableList|)
                       (SETQ |bfVar#27| (CONS |pvar| |bfVar#27|)))))
                (SETQ |bfVar#26| (CDR |bfVar#26|))))
             NIL (CDR |pattern|) NIL))))))

; htMakeTemplates(templateList, numLabels) ==
;   templateList := [templateParts template for template in templateList]
;   [[substLabel(i, template) for template in templateList]
;     for i in 1..numLabels] where substLabel(i, template) ==
;       PAIRP template =>
;         INTERN CONCAT(first template, PRINC_-TO_-STRING i, rest template)
;       template

(DEFUN |htMakeTemplates| (|templateList| |numLabels|)
  (PROG ()
    (RETURN
     (PROGN
      (SETQ |templateList|
              ((LAMBDA (|bfVar#29| |bfVar#28| |template|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#28|)
                        (PROGN (SETQ |template| (CAR |bfVar#28|)) NIL))
                    (RETURN (NREVERSE |bfVar#29|)))
                   (#1='T
                    (SETQ |bfVar#29|
                            (CONS (|templateParts| |template|) |bfVar#29|))))
                  (SETQ |bfVar#28| (CDR |bfVar#28|))))
               NIL |templateList| NIL))
      ((LAMBDA (|bfVar#32| |i|)
         (LOOP
          (COND ((> |i| |numLabels|) (RETURN (NREVERSE |bfVar#32|)))
                (#1#
                 (SETQ |bfVar#32|
                         (CONS
                          ((LAMBDA (|bfVar#31| |bfVar#30| |template|)
                             (LOOP
                              (COND
                               ((OR (ATOM |bfVar#30|)
                                    (PROGN
                                     (SETQ |template| (CAR |bfVar#30|))
                                     NIL))
                                (RETURN (NREVERSE |bfVar#31|)))
                               (#1#
                                (SETQ |bfVar#31|
                                        (CONS
                                         (|htMakeTemplates,substLabel| |i|
                                          |template|)
                                         |bfVar#31|))))
                              (SETQ |bfVar#30| (CDR |bfVar#30|))))
                           NIL |templateList| NIL)
                          |bfVar#32|))))
          (SETQ |i| (+ |i| 1))))
       NIL 1)))))
(DEFUN |htMakeTemplates,substLabel| (|i| |template|)
  (PROG ()
    (RETURN
     (COND
      ((CONSP |template|)
       (INTERN
        (CONCAT (CAR |template|) (PRINC-TO-STRING |i|) (CDR |template|))))
      ('T |template|)))))

; templateParts template ==
;   NULL STRINGP template => template
;   i := SEARCH('"%l", template)
;   null i => template
;   [SUBSEQ(template, 0, i), : SUBSEQ(template, i+2)]

(DEFUN |templateParts| (|template|)
  (PROG (|i|)
    (RETURN
     (COND ((NULL (STRINGP |template|)) |template|)
           (#1='T
            (PROGN
             (SETQ |i| (SEARCH "%l" |template|))
             (COND ((NULL |i|) |template|)
                   (#1#
                    (CONS (SUBSEQ |template| 0 |i|)
                          (SUBSEQ |template| (+ |i| 2)))))))))))

; htMakeDoneButton(message, func) ==
;   bcHt '"\newline\vspace{1}\centerline{"
;   if message = '"Continue" then
;     bchtMakeButton('"\lispdownlink", "\ContinueBitmap", func)
;   else
;     bchtMakeButton('"\lispdownlink",CONCAT('"\box{", message, '"}"), func)
;   bcHt '"} "

(DEFUN |htMakeDoneButton| (|message| |func|)
  (PROG ()
    (RETURN
     (PROGN
      (|bcHt| "\\newline\\vspace{1}\\centerline{")
      (COND
       ((EQUAL |message| "Continue")
        (|bchtMakeButton| "\\lispdownlink" '|\\ContinueBitmap| |func|))
       ('T
        (|bchtMakeButton| "\\lispdownlink" (CONCAT "\\box{" |message| "}")
         |func|)))
      (|bcHt| "} ")))))

; htProcessDoneButton [label , func] ==
;   iht '"\newline\vspace{1}\centerline{"
;
;   if label = '"Continue" then
;     htMakeButton('"\lispdownlink", "\ContinueBitmap", func)
;   else if label = '"Push to enter names" then
;     htMakeButton('"\lispdownlink",'"\ControlBitmap{ClickToSet}", func)
;   else
;     htMakeButton('"\lispdownlink", CONCAT('"\box{", label, '"}"), func)
;
;   iht '"} "

(DEFUN |htProcessDoneButton| (|bfVar#33|)
  (PROG (|label| |func|)
    (RETURN
     (PROGN
      (SETQ |label| (CAR |bfVar#33|))
      (SETQ |func| (CADR |bfVar#33|))
      (|iht| "\\newline\\vspace{1}\\centerline{")
      (COND
       ((EQUAL |label| "Continue")
        (|htMakeButton| "\\lispdownlink" '|\\ContinueBitmap| |func|))
       ((EQUAL |label| "Push to enter names")
        (|htMakeButton| "\\lispdownlink" "\\ControlBitmap{ClickToSet}" |func|))
       ('T
        (|htMakeButton| "\\lispdownlink" (CONCAT "\\box{" |label| "}")
         |func|)))
      (|iht| "} ")))))

; bchtMakeButton(htCommand, message, func) ==
;   bcHt [htCommand, '"{", message,
;        '"}{(|htDoneButton| '|", func, '"| (PROGN "]
;   for [id, ., ., ., type, :.] in htpInputAreaAlist $curPage repeat
;     bcHt ['"(|htpSetLabelInputString| ", htpName $curPage, '"'|", id, '"| "]
;     if type = 'string then
;       bcHt ['"_"\stringvalue{", id, '"}_""]
;     else
;       bcHt ['"_"\boxvalue{", id, '"}_""]
;     bcHt '") "
;   bcHt [htpName $curPage, '"))} "]

(DEFUN |bchtMakeButton| (|htCommand| |message| |func|)
  (PROG (|id| |ISTMP#1| |ISTMP#2| |ISTMP#3| |ISTMP#4| |type|)
    (RETURN
     (PROGN
      (|bcHt|
       (LIST |htCommand| "{" |message| "}{(|htDoneButton| '|" |func|
             "| (PROGN "))
      ((LAMBDA (|bfVar#35| |bfVar#34|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#35|)
                (PROGN (SETQ |bfVar#34| (CAR |bfVar#35|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#34|)
                 (PROGN
                  (SETQ |id| (CAR |bfVar#34|))
                  (SETQ |ISTMP#1| (CDR |bfVar#34|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|)
                             (PROGN
                              (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                              (AND (CONSP |ISTMP#3|)
                                   (PROGN
                                    (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                                    (AND (CONSP |ISTMP#4|)
                                         (PROGN
                                          (SETQ |type| (CAR |ISTMP#4|))
                                          #1#)))))))))
                 (PROGN
                  (|bcHt|
                   (LIST "(|htpSetLabelInputString| " (|htpName| |$curPage|)
                         "'|" |id| "| "))
                  (COND
                   ((EQ |type| '|string|)
                    (|bcHt| (LIST "\"\\stringvalue{" |id| "}\"")))
                   (#1# (|bcHt| (LIST "\"\\boxvalue{" |id| "}\""))))
                  (|bcHt| ") ")))))
          (SETQ |bfVar#35| (CDR |bfVar#35|))))
       (|htpInputAreaAlist| |$curPage|) NIL)
      (|bcHt| (LIST (|htpName| |$curPage|) "))} "))))))

; htProcessDoitButton [label, command, func] ==
;   fun := mkCurryFun(func, [command])
;   iht '"\newline\vspace{1}\centerline{"
;   htMakeButton('"\lispcommand", CONCAT('"\box{", label, '"}"), fun)
;   iht '"} "
;   iht '"\vspace{2}{Select \  \UpButton{} \  to go back one page.}"
;   iht '"\newline{Select \  \ExitButton{QuitPage} \  to remove this window.}"

(DEFUN |htProcessDoitButton| (|bfVar#36|)
  (PROG (|label| |command| |func| |fun|)
    (RETURN
     (PROGN
      (SETQ |label| (CAR |bfVar#36|))
      (SETQ |command| (CADR . #1=(|bfVar#36|)))
      (SETQ |func| (CADDR . #1#))
      (SETQ |fun| (|mkCurryFun| |func| (LIST |command|)))
      (|iht| "\\newline\\vspace{1}\\centerline{")
      (|htMakeButton| "\\lispcommand" (CONCAT "\\box{" |label| "}") |fun|)
      (|iht| "} ")
      (|iht| "\\vspace{2}{Select \\  \\UpButton{} \\  to go back one page.}")
      (|iht|
       "\\newline{Select \\  \\ExitButton{QuitPage} \\  to remove this window.}")))))

; htMakeDoitButton(label, command) ==
;   -- use bitmap button if just plain old "Do It"
;   if label = '"Do It" then
;     bcHt '"\newline\vspace{1}\centerline{\lispcommand{\DoItBitmap}{(|doDoitButton| "
;   else
;     bcHt ['"\newline\vspace{1}\centerline{\lispcommand{\box{", label,
;        '"}}{(|doDoitButton| "]
;   bcHt htpName $curPage
;   bcHt ['" _"", htEscapeString command, '"_""]
;   bcHt '")}}"
;
;   bcHt '"\vspace{2}{Select \  \UpButton{} \  to go back one page.}"
;   bcHt '"\newline{Select \  \ExitButton{QuitPage} \  to remove this window.}"

(DEFUN |htMakeDoitButton| (|label| |command|)
  (PROG ()
    (RETURN
     (PROGN
      (COND
       ((EQUAL |label| "Do It")
        (|bcHt|
         "\\newline\\vspace{1}\\centerline{\\lispcommand{\\DoItBitmap}{(|doDoitButton| "))
       ('T
        (|bcHt|
         (LIST "\\newline\\vspace{1}\\centerline{\\lispcommand{\\box{" |label|
               "}}{(|doDoitButton| "))))
      (|bcHt| (|htpName| |$curPage|))
      (|bcHt| (LIST " \"" (|htEscapeString| |command|) "\""))
      (|bcHt| ")}}")
      (|bcHt| "\\vspace{2}{Select \\  \\UpButton{} \\  to go back one page.}")
      (|bcHt|
       "\\newline{Select \\  \\ExitButton{QuitPage} \\  to remove this window.}")))))

; doDoitButton(htPage, command) ==
;   executeInterpreterCommand command

(DEFUN |doDoitButton| (|htPage| |command|)
  (PROG () (RETURN (|executeInterpreterCommand| |command|))))

; executeInterpreterCommand command ==
;   PRINC command
;   TERPRI()
;   setCurrentLine(command)
;   CATCH('SPAD_READER, parseAndInterpret command)
; --  MRX I'm not sure whether I should call ioHook("startPrompt")/ioHook("endOfPrompt") here
;   princPrompt()
;   FORCE_-OUTPUT()

(DEFUN |executeInterpreterCommand| (|command|)
  (PROG ()
    (RETURN
     (PROGN
      (PRINC |command|)
      (TERPRI)
      (|setCurrentLine| |command|)
      (CATCH 'SPAD_READER (|parseAndInterpret| |command|))
      (|princPrompt|)
      (FORCE-OUTPUT)))))

; typeCheckInputAreas htPage ==
;   -- This needs to be severely beefed up
;   errorCondition := false
;   for entry in htpInputAreaAlist htPage
;    | entry is [stringName, ., ., ., 'string, ., spadType, filter] repeat
;     condList :=
;       LASSOC(LASSOC(spadType,htpDomainPvarSubstList htPage),
;              htpDomainVariableAlist htPage)
;     string := htpLabelFilteredInputString(htPage, stringName)
;     $bcParseOnly =>
;       null ncParseFromString string =>
;         htpSetLabelErrorMsg(htPage, '"Syntax Error", '"Syntax Error")
;       nil
;     val := checkCondition(htpLabelInputString(htPage, stringName),
;                           string, condList)
;     STRINGP val =>
;       errorCondition := true
;       htpSetLabelErrorMsg(htPage, stringName, val)
;     htpSetLabelSpadValue(htPage, stringName, val)
;   errorCondition

(DEFUN |typeCheckInputAreas| (|htPage|)
  (PROG (|errorCondition| |stringName| |ISTMP#1| |ISTMP#2| |ISTMP#3| |ISTMP#4|
         |ISTMP#5| |ISTMP#6| |spadType| |ISTMP#7| |filter| |condList| |string|
         |val|)
    (RETURN
     (PROGN
      (SETQ |errorCondition| NIL)
      ((LAMBDA (|bfVar#37| |entry|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#37|) (PROGN (SETQ |entry| (CAR |bfVar#37|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |entry|)
                 (PROGN
                  (SETQ |stringName| (CAR |entry|))
                  (SETQ |ISTMP#1| (CDR |entry|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|)
                             (PROGN
                              (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                              (AND (CONSP |ISTMP#3|)
                                   (PROGN
                                    (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                                    (AND (CONSP |ISTMP#4|)
                                         (EQ (CAR |ISTMP#4|) '|string|)
                                         (PROGN
                                          (SETQ |ISTMP#5| (CDR |ISTMP#4|))
                                          (AND (CONSP |ISTMP#5|)
                                               (PROGN
                                                (SETQ |ISTMP#6|
                                                        (CDR |ISTMP#5|))
                                                (AND (CONSP |ISTMP#6|)
                                                     (PROGN
                                                      (SETQ |spadType|
                                                              (CAR |ISTMP#6|))
                                                      (SETQ |ISTMP#7|
                                                              (CDR |ISTMP#6|))
                                                      (AND (CONSP |ISTMP#7|)
                                                           (EQ (CDR |ISTMP#7|)
                                                               NIL)
                                                           (PROGN
                                                            (SETQ |filter|
                                                                    (CAR
                                                                     |ISTMP#7|))
                                                            #1#)))))))))))))))
                 (PROGN
                  (SETQ |condList|
                          (LASSOC
                           (LASSOC |spadType|
                            (|htpDomainPvarSubstList| |htPage|))
                           (|htpDomainVariableAlist| |htPage|)))
                  (SETQ |string|
                          (|htpLabelFilteredInputString| |htPage|
                           |stringName|))
                  (COND
                   (|$bcParseOnly|
                    (COND
                     ((NULL (|ncParseFromString| |string|))
                      (|htpSetLabelErrorMsg| |htPage| "Syntax Error"
                       "Syntax Error"))
                     (#1# NIL)))
                   (#1#
                    (PROGN
                     (SETQ |val|
                             (|checkCondition|
                              (|htpLabelInputString| |htPage| |stringName|)
                              |string| |condList|))
                     (COND
                      ((STRINGP |val|)
                       (PROGN
                        (SETQ |errorCondition| T)
                        (|htpSetLabelErrorMsg| |htPage| |stringName| |val|)))
                      (#1#
                       (|htpSetLabelSpadValue| |htPage| |stringName|
                        |val|))))))))))
          (SETQ |bfVar#37| (CDR |bfVar#37|))))
       (|htpInputAreaAlist| |htPage|) NIL)
      |errorCondition|))))

; checkCondition(s1, string, condList) ==
;   condList is [['Satisfies, pvar, pred]] =>
;     val := FUNCALL(pred, string)
;     STRINGP val => val
;     ['(String), :wrap s1]
;   condList isnt [['isDomain, pvar, pattern]] =>
;     systemError '"currently invalid domain condition"
;   pattern is '(String) => ['(String), :wrap s1]
;   val := parseAndEval string
;   STRINGP val =>
;     val = '"Syntax Error " => '"Error: Syntax Error "
;     condErrorMsg pattern
;   [type, : data] := val
;   newType := CATCH('SPAD_READER, resolveTM(type, pattern))
;   null newType =>
;     condErrorMsg pattern
;   coerceInt(val, newType)

(DEFUN |checkCondition| (|s1| |string| |condList|)
  (PROG (|ISTMP#1| |ISTMP#2| |pvar| |ISTMP#3| |pred| |val| |pattern| |type|
         |data| |newType|)
    (RETURN
     (COND
      ((AND (CONSP |condList|) (EQ (CDR |condList|) NIL)
            (PROGN
             (SETQ |ISTMP#1| (CAR |condList|))
             (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|Satisfies|)
                  (PROGN
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|)
                        (PROGN
                         (SETQ |pvar| (CAR |ISTMP#2|))
                         (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                         (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                              (PROGN
                               (SETQ |pred| (CAR |ISTMP#3|))
                               #1='T))))))))
       (PROGN
        (SETQ |val| (FUNCALL |pred| |string|))
        (COND ((STRINGP |val|) |val|) (#1# (CONS '(|String|) (|wrap| |s1|))))))
      ((NOT
        (AND (CONSP |condList|) (EQ (CDR |condList|) NIL)
             (PROGN
              (SETQ |ISTMP#1| (CAR |condList|))
              (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|isDomain|)
                   (PROGN
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|)
                         (PROGN
                          (SETQ |pvar| (CAR |ISTMP#2|))
                          (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                          (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                               (PROGN
                                (SETQ |pattern| (CAR |ISTMP#3|))
                                #1#)))))))))
       (|systemError| "currently invalid domain condition"))
      ((EQUAL |pattern| '(|String|)) (CONS '(|String|) (|wrap| |s1|)))
      (#1#
       (PROGN
        (SETQ |val| (|parseAndEval| |string|))
        (COND
         ((STRINGP |val|)
          (COND ((EQUAL |val| "Syntax Error ") "Error: Syntax Error ")
                (#1# (|condErrorMsg| |pattern|))))
         (#1#
          (PROGN
           (SETQ |type| (CAR |val|))
           (SETQ |data| (CDR |val|))
           (SETQ |newType| (CATCH 'SPAD_READER (|resolveTM| |type| |pattern|)))
           (COND ((NULL |newType|) (|condErrorMsg| |pattern|))
                 (#1# (|coerceInt| |val| |newType|))))))))))))

; condErrorMsg type ==
;   typeString := form2String type
;   if PAIRP typeString then typeString := concatenateStringList(typeString)
;   CONCAT('"Error: Could not make your input into a ", typeString)

(DEFUN |condErrorMsg| (|type|)
  (PROG (|typeString|)
    (RETURN
     (PROGN
      (SETQ |typeString| (|form2String| |type|))
      (COND
       ((CONSP |typeString|)
        (SETQ |typeString| (|concatenateStringList| |typeString|))))
      (CONCAT "Error: Could not make your input into a " |typeString|)))))

; parseAndEval string ==
;   $InteractiveMode :fluid := true
;   $e:fluid := $InteractiveFrame
;   $QuietCommand:local := true
;   parseAndEval1 string

(DEFUN |parseAndEval| (|string|)
  (PROG (|$QuietCommand| |$e| |$InteractiveMode|)
    (DECLARE (SPECIAL |$QuietCommand| |$e| |$InteractiveMode|))
    (RETURN
     (PROGN
      (SETQ |$InteractiveMode| T)
      (SETQ |$e| |$InteractiveFrame|)
      (SETQ |$QuietCommand| T)
      (|parseAndEval1| |string|)))))

; parseAndEval1 string ==
;   syntaxError := false
;   pform :=
;       v := applyWithOutputToString('ncParseFromString, [string])
;       CAR v => CAR v
;       syntaxError := true
;       CDR v
;   syntaxError =>
;      '"Syntax Error "
;   pform =>
;     val := applyWithOutputToString('processInteractive, [pform, nil])
;     CAR val => CAR val
;     '"Type Analysis Error"
;   nil

(DEFUN |parseAndEval1| (|string|)
  (PROG (|syntaxError| |v| |pform| |val|)
    (RETURN
     (PROGN
      (SETQ |syntaxError| NIL)
      (SETQ |pform|
              (PROGN
               (SETQ |v|
                       (|applyWithOutputToString| '|ncParseFromString|
                        (LIST |string|)))
               (COND ((CAR |v|) (CAR |v|))
                     (#1='T (PROGN (SETQ |syntaxError| T) (CDR |v|))))))
      (COND (|syntaxError| "Syntax Error ")
            (|pform|
             (PROGN
              (SETQ |val|
                      (|applyWithOutputToString| '|processInteractive|
                       (LIST |pform| NIL)))
              (COND ((CAR |val|) (CAR |val|)) (#1# "Type Analysis Error"))))
            (#1# NIL))))))

; bracketString string == CONCAT('"[",string,'"]")

(DEFUN |bracketString| (|string|) (PROG () (RETURN (CONCAT "[" |string| "]"))))

; quoteString string == CONCAT('"_"", string, '"_"")

(DEFUN |quoteString| (|string|) (PROG () (RETURN (CONCAT "\"" |string| "\""))))

; $funnyQuote := char 127

(EVAL-WHEN (EVAL LOAD) (SETQ |$funnyQuote| (|char| 127)))

; $funnyBacks := char 128

(EVAL-WHEN (EVAL LOAD) (SETQ |$funnyBacks| (|char| 128)))

; htEscapeString str ==
;   str := SUBSTITUTE($funnyQuote, char '_", str)
;   SUBSTITUTE($funnyBacks, char '_\, str)

(DEFUN |htEscapeString| (|str|)
  (PROG ()
    (RETURN
     (PROGN
      (SETQ |str| (SUBSTITUTE |$funnyQuote| (|char| '|"|) |str|))
      (SUBSTITUTE |$funnyBacks| (|char| '|\\|) |str|)))))

; unescapeStringsInForm form ==
;   STRINGP form =>
;     str := NSUBSTITUTE(char '_", $funnyQuote, form)
;     NSUBSTITUTE(char '_\, $funnyBacks, str)
;   CONSP form =>
;     unescapeStringsInForm first form
;     unescapeStringsInForm rest form
;     form
;   form

(DEFUN |unescapeStringsInForm| (|form|)
  (PROG (|str|)
    (RETURN
     (COND
      ((STRINGP |form|)
       (PROGN
        (SETQ |str| (NSUBSTITUTE (|char| '|"|) |$funnyQuote| |form|))
        (NSUBSTITUTE (|char| '|\\|) |$funnyBacks| |str|)))
      ((CONSP |form|)
       (PROGN
        (|unescapeStringsInForm| (CAR |form|))
        (|unescapeStringsInForm| (CDR |form|))
        |form|))
      ('T |form|)))))
