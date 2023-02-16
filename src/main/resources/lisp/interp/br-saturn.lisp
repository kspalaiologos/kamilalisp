
; )package "BOOT"

(IN-PACKAGE "BOOT")

; $atLeastOneUnexposed := false

(EVAL-WHEN (EVAL LOAD) (SETQ |$atLeastOneUnexposed| NIL))

; page() == $curPage

(DEFUN |page| () (PROG () (RETURN |$curPage|)))

; htSay(x) ==
;     bcHt(x)

(DEFUN |htSay| (|x|) (PROG () (RETURN (|bcHt| |x|))))

; htSayCold x ==
;   htSay '"\lispLink{}{"
;   htSay x
;   htSay '"}"

(DEFUN |htSayCold| (|x|)
  (PROG ()
    (RETURN (PROGN (|htSay| "\\lispLink{}{") (|htSay| |x|) (|htSay| "}")))))

; htSayStandard(x) ==  --do AT MOST for $standard
;     bcHt(x)

(DEFUN |htSayStandard| (|x|) (PROG () (RETURN (|bcHt| |x|))))

; htSayStandardList(lx) ==
;     htSayList(lx)

(DEFUN |htSayStandardList| (|lx|) (PROG () (RETURN (|htSayList| |lx|))))

; htSayList(lx) ==
;   for x in lx repeat bcHt(x)

(DEFUN |htSayList| (|lx|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#1| |x|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#1|) (PROGN (SETQ |x| (CAR |bfVar#1|)) NIL))
           (RETURN NIL))
          ('T (|bcHt| |x|)))
         (SETQ |bfVar#1| (CDR |bfVar#1|))))
      |lx| NIL))))

; bcHt line ==
;   $newPage =>  --this path affects both saturn and old lines
;     text :=
;       PAIRP line => [['text, :line]]
;       STRINGP line => line
;       [['text, line]]
;     htpAddToPageDescription($curPage, text)
;   PAIRP line =>
;     $htLineList := NCONC(nreverse mapStringize COPY_-LIST line, $htLineList)
;   $htLineList := [basicStringize line, :$htLineList]

(DEFUN |bcHt| (|line|)
  (PROG (|text|)
    (RETURN
     (COND
      (|$newPage|
       (PROGN
        (SETQ |text|
                (COND ((CONSP |line|) (LIST (CONS '|text| |line|)))
                      ((STRINGP |line|) |line|)
                      (#1='T (LIST (LIST '|text| |line|)))))
        (|htpAddToPageDescription| |$curPage| |text|)))
      ((CONSP |line|)
       (SETQ |$htLineList|
               (NCONC (NREVERSE (|mapStringize| (COPY-LIST |line|)))
                      |$htLineList|)))
      (#1#
       (SETQ |$htLineList| (CONS (|basicStringize| |line|) |$htLineList|)))))))

; htShowPage() ==
; -- show the page which has been computed
;   htSayStandard '"\endscroll"
;   htShowPageNoScroll()

(DEFUN |htShowPage| ()
  (PROG ()
    (RETURN (PROGN (|htSayStandard| "\\endscroll") (|htShowPageNoScroll|)))))

; htShowPageNoScroll() ==
; -- show the page which has been computed
;   htSayStandard '"\autobuttons"
;   htpSetPageDescription($curPage, nreverse htpPageDescription $curPage)
;   $newPage := false
;   $htLineList := nil
;   htMakePage htpPageDescription $curPage
;   if $htLineList then line := concatenateStringList(nreverse $htLineList)
;   issueHTStandard line
;   endHTPage()

(DEFUN |htShowPageNoScroll| ()
  (PROG (|line|)
    (RETURN
     (PROGN
      (|htSayStandard| "\\autobuttons")
      (|htpSetPageDescription| |$curPage|
       (NREVERSE (|htpPageDescription| |$curPage|)))
      (SETQ |$newPage| NIL)
      (SETQ |$htLineList| NIL)
      (|htMakePage| (|htpPageDescription| |$curPage|))
      (COND
       (|$htLineList|
        (SETQ |line| (|concatenateStringList| (NREVERSE |$htLineList|)))))
      (|issueHTStandard| |line|)
      (|endHTPage|)))))

; issueHTStandard line == --called by htMakePageNoScroll and htMakeErrorPage
;     sockSendInt($MenuServer, $SendLine)
;     sockSendString($MenuServer, line)

(DEFUN |issueHTStandard| (|line|)
  (PROG ()
    (RETURN
     (PROGN
      (|sockSendInt| |$MenuServer| |$SendLine|)
      (|sockSendString| |$MenuServer| |line|)))))

; htMakeErrorPage htPage ==
;   $newPage := false
;   $htLineList := nil
;   $curPage := htPage
;   htMakePage htpPageDescription htPage
;   line := concatenateStringList(nreverse $htLineList)
;   issueHT line
;   endHTPage()

(DEFUN |htMakeErrorPage| (|htPage|)
  (PROG (|line|)
    (RETURN
     (PROGN
      (SETQ |$newPage| NIL)
      (SETQ |$htLineList| NIL)
      (SETQ |$curPage| |htPage|)
      (|htMakePage| (|htpPageDescription| |htPage|))
      (SETQ |line| (|concatenateStringList| (NREVERSE |$htLineList|)))
      (|issueHT| |line|)
      (|endHTPage|)))))

; htMakePage itemList ==
;   if $newPage then
;      htpAddToPageDescription($curPage, itemList)
;   htMakePage1 itemList

(DEFUN |htMakePage| (|itemList|)
  (PROG ()
    (RETURN
     (PROGN
      (COND (|$newPage| (|htpAddToPageDescription| |$curPage| |itemList|)))
      (|htMakePage1| |itemList|)))))

; htMakePage1 itemList ==
; -- make a page given the description in itemList
;   for u in itemList repeat
;     itemType := 'text
;     items :=
;       STRINGP u => u
;       ATOM u => STRINGIMAGE u
;       STRINGP first u => u
;       u is ['text, :s] => s
;       itemType := first u
;       rest u
;     itemType = 'text              => iht items
;     itemType = 'lispLinks         => htLispLinks items
;     itemType = 'lispmemoLinks     => htLispMemoLinks items
;     itemType = 'bcLinks           => htBcLinks(items)
;     itemType = 'bcLispLinks       => htBcLispLinks items           --->
;     itemType = 'radioButtons      => htRadioButtons items
;     itemType = 'bcRadioButtons    => htBcRadioButtons items
;     itemType = 'inputStrings      => htInputStrings items
;     itemType = 'domainConditions  => htProcessDomainConditions items
;     itemType = 'bcStrings         => htProcessBcStrings items
;     itemType = 'toggleButtons     => htProcessToggleButtons items
;     itemType = 'bcButtons         => htProcessBcButtons items
;     itemType = 'doneButton        => htProcessDoneButton items
;     itemType = 'doitButton        => htProcessDoitButton items
;     systemError '"unexpected branch"

(DEFUN |htMakePage1| (|itemList|)
  (PROG (|itemType| |s| |items|)
    (RETURN
     ((LAMBDA (|bfVar#2| |u|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#2|) (PROGN (SETQ |u| (CAR |bfVar#2|)) NIL))
           (RETURN NIL))
          (#1='T
           (PROGN
            (SETQ |itemType| '|text|)
            (SETQ |items|
                    (COND ((STRINGP |u|) |u|) ((ATOM |u|) (STRINGIMAGE |u|))
                          ((STRINGP (CAR |u|)) |u|)
                          ((AND (CONSP |u|) (EQ (CAR |u|) '|text|)
                                (PROGN (SETQ |s| (CDR |u|)) #1#))
                           |s|)
                          (#1# (PROGN (SETQ |itemType| (CAR |u|)) (CDR |u|)))))
            (COND ((EQ |itemType| '|text|) (|iht| |items|))
                  ((EQ |itemType| '|lispLinks|) (|htLispLinks| |items|))
                  ((EQ |itemType| '|lispmemoLinks|)
                   (|htLispMemoLinks| |items|))
                  ((EQ |itemType| '|bcLinks|) (|htBcLinks| |items|))
                  ((EQ |itemType| '|bcLispLinks|) (|htBcLispLinks| |items|))
                  ((EQ |itemType| '|radioButtons|) (|htRadioButtons| |items|))
                  ((EQ |itemType| '|bcRadioButtons|)
                   (|htBcRadioButtons| |items|))
                  ((EQ |itemType| '|inputStrings|) (|htInputStrings| |items|))
                  ((EQ |itemType| '|domainConditions|)
                   (|htProcessDomainConditions| |items|))
                  ((EQ |itemType| '|bcStrings|) (|htProcessBcStrings| |items|))
                  ((EQ |itemType| '|toggleButtons|)
                   (|htProcessToggleButtons| |items|))
                  ((EQ |itemType| '|bcButtons|) (|htProcessBcButtons| |items|))
                  ((EQ |itemType| '|doneButton|)
                   (|htProcessDoneButton| |items|))
                  ((EQ |itemType| '|doitButton|)
                   (|htProcessDoitButton| |items|))
                  (#1# (|systemError| "unexpected branch"))))))
         (SETQ |bfVar#2| (CDR |bfVar#2|))))
      |itemList| NIL))))

; menuButton() == '"\menuitemstyle{}"

(DEFUN |menuButton| () (PROG () (RETURN "\\menuitemstyle{}")))

; endHTPage() ==
;     sockSendInt($MenuServer, $EndOfPage)

(DEFUN |endHTPage| ()
  (PROG () (RETURN (|sockSendInt| |$MenuServer| |$EndOfPage|))))

; htSayHrule() == bcHt
;   '"\horizontalline{}\newline{}"

(DEFUN |htSayHrule| ()
  (PROG () (RETURN (|bcHt| "\\horizontalline{}\\newline{}"))))

; htpAddInputAreaProp(htPage, label, prop) ==
;   SETELT(htPage, 5, [[label, nil, nil, nil, :prop], :ELT(htPage, 5)])

(DEFUN |htpAddInputAreaProp| (|htPage| |label| |prop|)
  (PROG ()
    (RETURN
     (SETELT |htPage| 5
      (CONS (CONS |label| (CONS NIL (CONS NIL (CONS NIL |prop|))))
            (ELT |htPage| 5))))))

; htpSetLabelInputString(htPage, label, val) ==
;   -- value user typed as input string on page
;   props := LASSOC(label, htpInputAreaAlist htPage)
;   props => SETELT(props, 0, STRINGIMAGE val)
;   nil

(DEFUN |htpSetLabelInputString| (|htPage| |label| |val|)
  (PROG (|props|)
    (RETURN
     (PROGN
      (SETQ |props| (LASSOC |label| (|htpInputAreaAlist| |htPage|)))
      (COND (|props| (SETELT |props| 0 (STRINGIMAGE |val|))) ('T NIL))))))

; htDoneButton(func, htPage, :optionalArgs) ==
; ------> Handle argument values passed from page if present
;   if optionalArgs then
;     htpSetInputAreaAlist(htPage, first optionalArgs)
;   typeCheckInputAreas htPage =>
;     htMakeErrorPage htPage
;   NULL FBOUNDP func =>
;     systemError ['"unknown function", func]
;   FUNCALL(SYMBOL_-FUNCTION func, htPage)

(DEFUN |htDoneButton| (|func| |htPage| &REST |optionalArgs|)
  (PROG ()
    (RETURN
     (PROGN
      (COND
       (|optionalArgs| (|htpSetInputAreaAlist| |htPage| (CAR |optionalArgs|))))
      (COND ((|typeCheckInputAreas| |htPage|) (|htMakeErrorPage| |htPage|))
            ((NULL (FBOUNDP |func|))
             (|systemError| (LIST "unknown function" |func|)))
            ('T (FUNCALL (SYMBOL-FUNCTION |func|) |htPage|)))))))

; htBcLinks(links) ==
;   [links,options] := beforeAfter('options,links)
;   for [message, info, func, :value] in links repeat
;     link := '"\lispdownlink"
;     htMakeButton(link, message, mkCurryFun(func, value))
;     bcIssueHt info

(DEFUN |htBcLinks| (|links|)
  (PROG (|LETTMP#1| |options| |message| |ISTMP#1| |info| |ISTMP#2| |func|
         |value| |link|)
    (RETURN
     (PROGN
      (SETQ |LETTMP#1| (|beforeAfter| '|options| |links|))
      (SETQ |links| (CAR |LETTMP#1|))
      (SETQ |options| (CADR |LETTMP#1|))
      ((LAMBDA (|bfVar#4| |bfVar#3|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#4|) (PROGN (SETQ |bfVar#3| (CAR |bfVar#4|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#3|)
                 (PROGN
                  (SETQ |message| (CAR |bfVar#3|))
                  (SETQ |ISTMP#1| (CDR |bfVar#3|))
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
                  (SETQ |link| "\\lispdownlink")
                  (|htMakeButton| |link| |message|
                   (|mkCurryFun| |func| |value|))
                  (|bcIssueHt| |info|)))))
          (SETQ |bfVar#4| (CDR |bfVar#4|))))
       |links| NIL)))))

; htBcLispLinks links ==
;   [links,options] := beforeAfter('options,links)
;   for [message, info, func, :value] in links repeat
;     link :=
;       '"\lisplink"
;     htMakeButton(link ,message, mkCurryFun(func, value))
;     bcIssueHt info

(DEFUN |htBcLispLinks| (|links|)
  (PROG (|LETTMP#1| |options| |message| |ISTMP#1| |info| |ISTMP#2| |func|
         |value| |link|)
    (RETURN
     (PROGN
      (SETQ |LETTMP#1| (|beforeAfter| '|options| |links|))
      (SETQ |links| (CAR |LETTMP#1|))
      (SETQ |options| (CADR |LETTMP#1|))
      ((LAMBDA (|bfVar#6| |bfVar#5|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#6|) (PROGN (SETQ |bfVar#5| (CAR |bfVar#6|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#5|)
                 (PROGN
                  (SETQ |message| (CAR |bfVar#5|))
                  (SETQ |ISTMP#1| (CDR |bfVar#5|))
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
                  (SETQ |link| "\\lisplink")
                  (|htMakeButton| |link| |message|
                   (|mkCurryFun| |func| |value|))
                  (|bcIssueHt| |info|)))))
          (SETQ |bfVar#6| (CDR |bfVar#6|))))
       |links| NIL)))))

; htMakeButton(htCommand, message, func) ==
;   iht [htCommand, '"{"]
;   bcIssueHt message
;   iht ['"}{(|htDoneButton| '|", func, '"| (PROGN "]
;   for [id, ., ., ., type, :.] in htpInputAreaAlist $curPage repeat
;     iht ['"(|htpSetLabelInputString| ", htpName $curPage, '"'|", id, '"| "]
;     if type = 'string then
;       iht ['"_"\stringvalue{", id, '"}_""]
;     else
;       iht ['"_"\boxvalue{", id, '"}_""]
;     iht '") "
;   iht [htpName $curPage, '"))}"]

(DEFUN |htMakeButton| (|htCommand| |message| |func|)
  (PROG (|id| |ISTMP#1| |ISTMP#2| |ISTMP#3| |ISTMP#4| |type|)
    (RETURN
     (PROGN
      (|iht| (LIST |htCommand| "{"))
      (|bcIssueHt| |message|)
      (|iht| (LIST "}{(|htDoneButton| '|" |func| "| (PROGN "))
      ((LAMBDA (|bfVar#8| |bfVar#7|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#8|) (PROGN (SETQ |bfVar#7| (CAR |bfVar#8|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#7|)
                 (PROGN
                  (SETQ |id| (CAR |bfVar#7|))
                  (SETQ |ISTMP#1| (CDR |bfVar#7|))
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
                  (|iht|
                   (LIST "(|htpSetLabelInputString| " (|htpName| |$curPage|)
                         "'|" |id| "| "))
                  (COND
                   ((EQ |type| '|string|)
                    (|iht| (LIST "\"\\stringvalue{" |id| "}\"")))
                   (#1# (|iht| (LIST "\"\\boxvalue{" |id| "}\""))))
                  (|iht| ") ")))))
          (SETQ |bfVar#8| (CDR |bfVar#8|))))
       (|htpInputAreaAlist| |$curPage|) NIL)
      (|iht| (LIST (|htpName| |$curPage|) "))}"))))))

; htpAddToPageDescription(htPage, pageDescrip) ==
;   newDescript :=
;     STRINGP pageDescrip => [pageDescrip, :ELT(htPage, 7)]
;     nconc(nreverse COPY_-LIST pageDescrip, ELT(htPage, 7))
;   SETELT(htPage, 7, newDescript)

(DEFUN |htpAddToPageDescription| (|htPage| |pageDescrip|)
  (PROG (|newDescript|)
    (RETURN
     (PROGN
      (SETQ |newDescript|
              (COND
               ((STRINGP |pageDescrip|) (CONS |pageDescrip| (ELT |htPage| 7)))
               ('T
                (NCONC (NREVERSE (COPY-LIST |pageDescrip|))
                       (ELT |htPage| 7)))))
      (SETELT |htPage| 7 |newDescript|)))))

; htProcessBcStrings strings ==
;   for [numChars, default, stringName, spadType, :filter] in strings repeat
;     mess2 := '""
;     if NULL LASSOC(stringName, htpInputAreaAlist page()) then
;       setUpDefault(stringName, ['string, default, spadType, filter])
;     if htpLabelErrorMsg(page(), stringName) then
;       iht ['"\centerline{{\em ", htpLabelErrorMsg(page(), stringName), '"}}"]
;       mess2 := CONCAT(mess2, bcSadFaces())
;       htpSetLabelErrorMsg(page(), stringName, nil)
;     iht ['"\inputstring{", stringName, '"}{",
;          numChars, '"}{", htpLabelDefault(page(),stringName), '"} ", mess2]

(DEFUN |htProcessBcStrings| (|strings|)
  (PROG (|numChars| |ISTMP#1| |default| |ISTMP#2| |stringName| |ISTMP#3|
         |spadType| |filter| |mess2|)
    (RETURN
     ((LAMBDA (|bfVar#10| |bfVar#9|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#10|) (PROGN (SETQ |bfVar#9| (CAR |bfVar#10|)) NIL))
           (RETURN NIL))
          (#1='T
           (AND (CONSP |bfVar#9|)
                (PROGN
                 (SETQ |numChars| (CAR |bfVar#9|))
                 (SETQ |ISTMP#1| (CDR |bfVar#9|))
                 (AND (CONSP |ISTMP#1|)
                      (PROGN
                       (SETQ |default| (CAR |ISTMP#1|))
                       (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                       (AND (CONSP |ISTMP#2|)
                            (PROGN
                             (SETQ |stringName| (CAR |ISTMP#2|))
                             (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                             (AND (CONSP |ISTMP#3|)
                                  (PROGN
                                   (SETQ |spadType| (CAR |ISTMP#3|))
                                   (SETQ |filter| (CDR |ISTMP#3|))
                                   #1#)))))))
                (PROGN
                 (SETQ |mess2| "")
                 (COND
                  ((NULL (LASSOC |stringName| (|htpInputAreaAlist| (|page|))))
                   (|setUpDefault| |stringName|
                    (LIST '|string| |default| |spadType| |filter|))))
                 (COND
                  ((|htpLabelErrorMsg| (|page|) |stringName|)
                   (|iht|
                    (LIST "\\centerline{{\\em "
                          (|htpLabelErrorMsg| (|page|) |stringName|) "}}"))
                   (SETQ |mess2| (CONCAT |mess2| (|bcSadFaces|)))
                   (|htpSetLabelErrorMsg| (|page|) |stringName| NIL)))
                 (|iht|
                  (LIST "\\inputstring{" |stringName| "}{" |numChars| "}{"
                        (|htpLabelDefault| (|page|) |stringName|) "} "
                        |mess2|))))))
         (SETQ |bfVar#10| (CDR |bfVar#10|))))
      |strings| NIL))))

; setUpDefault(name, props) ==
;   htpAddInputAreaProp(page(), name, props)

(DEFUN |setUpDefault| (|name| |props|)
  (PROG () (RETURN (|htpAddInputAreaProp| (|page|) |name| |props|))))

; htInitPage(title, propList) ==
; -- start defining a hyperTeX page
;     page := htInitPageNoScroll(propList, title)
;     htSayStandard '"\beginscroll "
;     page

(DEFUN |htInitPage| (|title| |propList|)
  (PROG (|page|)
    (RETURN
     (PROGN
      (SETQ |page| (|htInitPageNoScroll| |propList| |title|))
      (|htSayStandard| "\\beginscroll ")
      |page|))))

; htInitPageNoScroll(propList, title) ==
; --start defining a hyperTeX page
;     page := htInitPageNoHeading(propList)
;     htSayStandard ['"\begin{page}{", htpName page, '"}{"]
;     htSay title
;     htSayStandard '"} "
;     page

(DEFUN |htInitPageNoScroll| (|propList| |title|)
  (PROG (|page|)
    (RETURN
     (PROGN
      (SETQ |page| (|htInitPageNoHeading| |propList|))
      (|htSayStandard| (LIST "\\begin{page}{" (|htpName| |page|) "}{"))
      (|htSay| |title|)
      (|htSayStandard| "} ")
      |page|))))

; htInitPageNoHeading(propList) ==
; --start defining a hyperTeX page
;   $atLeastOneUnexposed := nil
;   page := htpMakeEmptyPage(propList)
;   $curPage := page
;   $newPage := true
;   $htLineList := nil
;   page

(DEFUN |htInitPageNoHeading| (|propList|)
  (PROG (|page|)
    (RETURN
     (PROGN
      (SETQ |$atLeastOneUnexposed| NIL)
      (SETQ |page| (|htpMakeEmptyPage| |propList|))
      (SETQ |$curPage| |page|)
      (SETQ |$newPage| T)
      (SETQ |$htLineList| NIL)
      |page|))))

; htpMakeEmptyPage(propList) ==
;   name := GENTEMP()
;   $activePageList := [name, :$activePageList]
;   SET(name, val := VECTOR(name, nil, nil, nil, nil, nil, propList, nil))
;   val

(DEFUN |htpMakeEmptyPage| (|propList|)
  (PROG (|name| |val|)
    (RETURN
     (PROGN
      (SETQ |name| (GENTEMP))
      (SETQ |$activePageList| (CONS |name| |$activePageList|))
      (SET |name|
           (SETQ |val| (VECTOR |name| NIL NIL NIL NIL NIL |propList| NIL)))
      |val|))))

; kPage(line, options) == --any cat, dom, package, default package
; --constructors    Cname\#\E\sig \args   \abb \comments (C is C, D, P, X)
;   parts := dbXParts(line,7,1)
;   [kind,name,nargs,xflag,sig,args,abbrev,comments] := parts
;   form := IFCAR options
;   isFile := null kind
;   kind := kind or '"package"
;   RPLACA(parts,kind)
;   conform         := mkConform(kind,name,args)
;   conname         := opOf conform
;   capitalKind     := capitalize kind
;   signature       := ncParseFromString sig
;   constrings      :=
;     IFCDR form => dbConformGenUnder form
;     [STRCONC(name,args)]
;   emString        := ['"{\sf ",:constrings,'"}"]
;   heading := [capitalKind,'" ",:emString]
;   if not isExposedConstructor conname then heading := ['"Unexposed ",:heading]
;   if name=abbrev then abbrev := asyAbbreviation(conname,nargs)
;   page := htInitPageNoHeading(nil)
;   htAddHeading heading
;   htSayStandard("\beginscroll ")
;   htpSetProperty(page,'isFile,true)
;   htpSetProperty(page,'parts,parts)
;   htpSetProperty(page,'heading,heading)
;   htpSetProperty(page,'kind,kind)
;   if asharpConstructorName? conname then
;     htpSetProperty(page,'isAsharpConstructor,true)
;   htpSetProperty(page,'conform,conform)
;   htpSetProperty(page,'signature,signature)
;   ---what follows is stuff from kiPage with domain = nil
;   $conformsAreDomains := nil
;   dbShowConsDoc1(page,conform,nil)
;   if kind ~= 'category and nargs > 0 then addParameterTemplates(page,conform)
;   if $atLeastOneUnexposed then htSay '"\newline{}{\em *} = unexposed"
;   htSayStandard("\endscroll ")
;   kPageContextMenu page
;   htShowPageNoScroll()

(DEFUN |kPage| (|line| |options|)
  (PROG (|parts| |kind| |name| |nargs| |xflag| |sig| |args| |abbrev| |comments|
         |form| |isFile| |conform| |conname| |capitalKind| |signature|
         |constrings| |emString| |heading| |page|)
    (RETURN
     (PROGN
      (SETQ |parts| (|dbXParts| |line| 7 1))
      (SETQ |kind| (CAR |parts|))
      (SETQ |name| (CADR . #1=(|parts|)))
      (SETQ |nargs| (CADDR . #1#))
      (SETQ |xflag| (CADDDR . #1#))
      (SETQ |sig| (CAR #2=(CDDDDR . #1#)))
      (SETQ |args| (CADR . #3=(#2#)))
      (SETQ |abbrev| (CADDR . #3#))
      (SETQ |comments| (CADDDR . #3#))
      (SETQ |form| (IFCAR |options|))
      (SETQ |isFile| (NULL |kind|))
      (SETQ |kind| (OR |kind| "package"))
      (RPLACA |parts| |kind|)
      (SETQ |conform| (|mkConform| |kind| |name| |args|))
      (SETQ |conname| (|opOf| |conform|))
      (SETQ |capitalKind| (|capitalize| |kind|))
      (SETQ |signature| (|ncParseFromString| |sig|))
      (SETQ |constrings|
              (COND ((IFCDR |form|) (|dbConformGenUnder| |form|))
                    ('T (LIST (STRCONC |name| |args|)))))
      (SETQ |emString| (CONS "{\\sf " (APPEND |constrings| (CONS "}" NIL))))
      (SETQ |heading| (CONS |capitalKind| (CONS " " |emString|)))
      (COND
       ((NULL (|isExposedConstructor| |conname|))
        (SETQ |heading| (CONS "Unexposed " |heading|))))
      (COND
       ((EQUAL |name| |abbrev|)
        (SETQ |abbrev| (|asyAbbreviation| |conname| |nargs|))))
      (SETQ |page| (|htInitPageNoHeading| NIL))
      (|htAddHeading| |heading|)
      (|htSayStandard| '|\\beginscroll |)
      (|htpSetProperty| |page| '|isFile| T)
      (|htpSetProperty| |page| '|parts| |parts|)
      (|htpSetProperty| |page| '|heading| |heading|)
      (|htpSetProperty| |page| '|kind| |kind|)
      (COND
       ((|asharpConstructorName?| |conname|)
        (|htpSetProperty| |page| '|isAsharpConstructor| T)))
      (|htpSetProperty| |page| '|conform| |conform|)
      (|htpSetProperty| |page| '|signature| |signature|)
      (SETQ |$conformsAreDomains| NIL)
      (|dbShowConsDoc1| |page| |conform| NIL)
      (COND
       ((AND (NOT (EQ |kind| '|category|)) (< 0 |nargs|))
        (|addParameterTemplates| |page| |conform|)))
      (COND
       (|$atLeastOneUnexposed| (|htSay| "\\newline{}{\\em *} = unexposed")))
      (|htSayStandard| '|\\endscroll |)
      (|kPageContextMenu| |page|)
      (|htShowPageNoScroll|)))))

; kPageContextMenu page ==
;   [kind,name,nargs,xpart,sig,args,abbrev,comments] := htpProperty(page,'parts)
;   conform := htpProperty(page,'conform)
;   conname := opOf conform
;   htBeginTable()
;   htSay '"{"
;   htMakePage [['bcLinks,['Ancestors,'"",'kcaPage,nil]]]
;   if kind = '"category" then
;     htSay '"}{"
;     htMakePage [['bcLinks,['Children,'"",'kccPage,nil]]]
;   if not asharpConstructorName? conname then
;     htSay '"}{"
;     htMakePage [['bcLinks,['Dependents,'"",'kcdePage,nil]]]
;   if kind = '"category" then
;     htSay '"}{"
;     htMakePage [['bcLinks,['Descendents,'"",'kcdPage,nil]]]
;   if kind = '"category" then
;     htSay '"}{"
;     if not asharpConstructorName? conname then
;       htMakePage [['bcLinks,['Domains,'"",'kcdoPage,nil]]]
;     else htSay '"{\em Domains}"
;   htSay '"}{"
;   if kind ~= '"category" and (pathname := dbHasExamplePage conname)
;     then htMakePage [['bcLinks,['Examples,'"",'kxPage,pathname]]]
;     else htSay '"{\em Examples}"
;   htSay '"}{"
;   htMakePage [['bcLinks,['Exports,'"",'kePage,nil]]]
;   htSay '"}{"
;   htMakePage [['bcLinks,['Operations,'"",'koPage,'"operation"]]]
;   htSay '"}{"
;   htMakePage [['bcLinks,['Parents,'"",'kcpPage,'"operation"]]]
;   if kind ~= '"category" then
;     htSay '"}{"
;     if not asharpConstructorName? conname
;     then  htMakePage [['bcLinks,["Search Path",'"",'ksPage,nil]]]
;     else htSay '"{\em Search Path}"
;   if kind ~= '"category" then
;     htSay '"}{"
;     htMakePage [['bcLinks,['Users,'"",'kcuPage,nil]]]
;     htSay '"}{"
;     htMakePage [['bcLinks,['Uses,'"",'kcnPage,nil]]]
;   htSay '"}"
;   htEndTable()

(DEFUN |kPageContextMenu| (|page|)
  (PROG (|LETTMP#1| |kind| |name| |nargs| |xpart| |sig| |args| |abbrev|
         |comments| |conform| |conname| |pathname|)
    (RETURN
     (PROGN
      (SETQ |LETTMP#1| (|htpProperty| |page| '|parts|))
      (SETQ |kind| (CAR |LETTMP#1|))
      (SETQ |name| (CADR . #1=(|LETTMP#1|)))
      (SETQ |nargs| (CADDR . #1#))
      (SETQ |xpart| (CADDDR . #1#))
      (SETQ |sig| (CAR #2=(CDDDDR . #1#)))
      (SETQ |args| (CADR . #3=(#2#)))
      (SETQ |abbrev| (CADDR . #3#))
      (SETQ |comments| (CADDDR . #3#))
      (SETQ |conform| (|htpProperty| |page| '|conform|))
      (SETQ |conname| (|opOf| |conform|))
      (|htBeginTable|)
      (|htSay| "{")
      (|htMakePage|
       (LIST (LIST '|bcLinks| (LIST '|Ancestors| "" '|kcaPage| NIL))))
      (COND
       ((EQUAL |kind| "category") (|htSay| "}{")
        (|htMakePage|
         (LIST (LIST '|bcLinks| (LIST '|Children| "" '|kccPage| NIL))))))
      (COND
       ((NULL (|asharpConstructorName?| |conname|)) (|htSay| "}{")
        (|htMakePage|
         (LIST (LIST '|bcLinks| (LIST '|Dependents| "" '|kcdePage| NIL))))))
      (COND
       ((EQUAL |kind| "category") (|htSay| "}{")
        (|htMakePage|
         (LIST (LIST '|bcLinks| (LIST '|Descendents| "" '|kcdPage| NIL))))))
      (COND
       ((EQUAL |kind| "category") (|htSay| "}{")
        (COND
         ((NULL (|asharpConstructorName?| |conname|))
          (|htMakePage|
           (LIST (LIST '|bcLinks| (LIST '|Domains| "" '|kcdoPage| NIL)))))
         (#4='T (|htSay| "{\\em Domains}")))))
      (|htSay| "}{")
      (COND
       ((AND (NOT (EQUAL |kind| "category"))
             (SETQ |pathname| (|dbHasExamplePage| |conname|)))
        (|htMakePage|
         (LIST (LIST '|bcLinks| (LIST '|Examples| "" '|kxPage| |pathname|)))))
       (#4# (|htSay| "{\\em Examples}")))
      (|htSay| "}{")
      (|htMakePage|
       (LIST (LIST '|bcLinks| (LIST '|Exports| "" '|kePage| NIL))))
      (|htSay| "}{")
      (|htMakePage|
       (LIST (LIST '|bcLinks| (LIST '|Operations| "" '|koPage| "operation"))))
      (|htSay| "}{")
      (|htMakePage|
       (LIST (LIST '|bcLinks| (LIST '|Parents| "" '|kcpPage| "operation"))))
      (COND
       ((NOT (EQUAL |kind| "category")) (|htSay| "}{")
        (COND
         ((NULL (|asharpConstructorName?| |conname|))
          (|htMakePage|
           (LIST (LIST '|bcLinks| (LIST '|Search Path| "" '|ksPage| NIL)))))
         (#4# (|htSay| "{\\em Search Path}")))))
      (COND
       ((NOT (EQUAL |kind| "category")) (|htSay| "}{")
        (|htMakePage|
         (LIST (LIST '|bcLinks| (LIST '|Users| "" '|kcuPage| NIL))))
        (|htSay| "}{")
        (|htMakePage|
         (LIST (LIST '|bcLinks| (LIST '|Uses| "" '|kcnPage| NIL))))))
      (|htSay| "}")
      (|htEndTable|)))))

; dbPresentCons(htPage,kind,:exclusions) ==
;   htpSetProperty(htPage,'exclusion,first exclusions)
;   cAlist := htpProperty(htPage,'cAlist)
;   empty? := null cAlist
;   one?   := null rest cAlist
;   one? := empty? or one?
;   exposedUnexposedFlag := $includeUnexposed? --used to be star?       4/92
;   star?  := true     --always include information on exposed/unexposed   4/92
;   htBeginTable()
;   htSay '"{"
;   if one? or member('abbrs,exclusions)
;     then htSay '"{\em Abbreviations}"
;     else htMakePage [['bcLispLinks,['"Abbreviations",'"",'dbShowCons,'abbrs]]]
;   htSay '"}{"
;   if one? or member('conditions, exclusions) or
;         and/[rest x = true for x in cAlist]
;     then htSay '"{\em Conditions}"
;     else htMakePage [['bcLispLinks,['"Conditions",'"",'dbShowCons,'conditions]]]
;   htSay '"}{"
;   if empty? or member('documentation,exclusions)
;     then htSay '"{\em Descriptions}"
;     else htMakePage [['bcLispLinks,['"Descriptions",'"",'dbShowCons,'documentation]]]
;   htSay '"}{"
;   if one? or null rest cAlist
;     then htSay '"{\em Filter}"
;     else htMakePage
;       [['bcLinks,['"Filter",'"",'htFilterPage,['dbShowCons,'filter]]]]
;   htSay '"}{"
;   if one? or member('kinds,exclusions) or kind ~= 'constructor
;     then htSay '"{\em Kinds}"
;     else htMakePage [['bcLispLinks,['"Kinds",'"",'dbShowCons,'kinds]]]
;   htSay '"}{"
;   if one? or member('names,exclusions)
;     then htSay '"{\em Names}"
;     else htMakePage [['bcLispLinks,['"Names",'"",'dbShowCons,'names]]]
;   htSay '"}{"
;   if one? or member('parameters, exclusions) or not(or/[CDAR x for x in cAlist])
;     then htSay '"{\em Parameters}"
;     else htMakePage [['bcLispLinks,['"Parameters",'"",'dbShowCons,'parameters]]]
;   htSay '"}{"
;   if $exposedOnlyIfTrue
;     then
;       htMakePage([['bcLinks, ['"Unexposed Also", '"", 'dbShowCons,
;                               'exposureOff]]])
;     else
;       if one?
;       then htSay '"{\em Exposed Only}"
;       else htMakePage [['bcLinks,['"Exposed Only",'"",'dbShowCons,'exposureOn]]]
;   htSay '"}"
;   htEndTable()

(DEFUN |dbPresentCons| (|htPage| |kind| &REST |exclusions|)
  (PROG (|cAlist| |empty?| |one?| |exposedUnexposedFlag| |star?|)
    (RETURN
     (PROGN
      (|htpSetProperty| |htPage| '|exclusion| (CAR |exclusions|))
      (SETQ |cAlist| (|htpProperty| |htPage| '|cAlist|))
      (SETQ |empty?| (NULL |cAlist|))
      (SETQ |one?| (NULL (CDR |cAlist|)))
      (SETQ |one?| (OR |empty?| |one?|))
      (SETQ |exposedUnexposedFlag| |$includeUnexposed?|)
      (SETQ |star?| T)
      (|htBeginTable|)
      (|htSay| "{")
      (COND
       ((OR |one?| (|member| '|abbrs| |exclusions|))
        (|htSay| "{\\em Abbreviations}"))
       (#1='T
        (|htMakePage|
         (LIST
          (LIST '|bcLispLinks|
                (LIST "Abbreviations" "" '|dbShowCons| '|abbrs|))))))
      (|htSay| "}{")
      (COND
       ((OR |one?| (|member| '|conditions| |exclusions|)
            ((LAMBDA (|bfVar#12| |bfVar#11| |x|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#11|)
                      (PROGN (SETQ |x| (CAR |bfVar#11|)) NIL))
                  (RETURN |bfVar#12|))
                 (#1#
                  (PROGN
                   (SETQ |bfVar#12| (EQUAL (CDR |x|) T))
                   (COND ((NOT |bfVar#12|) (RETURN NIL))))))
                (SETQ |bfVar#11| (CDR |bfVar#11|))))
             T |cAlist| NIL))
        (|htSay| "{\\em Conditions}"))
       (#1#
        (|htMakePage|
         (LIST
          (LIST '|bcLispLinks|
                (LIST "Conditions" "" '|dbShowCons| '|conditions|))))))
      (|htSay| "}{")
      (COND
       ((OR |empty?| (|member| '|documentation| |exclusions|))
        (|htSay| "{\\em Descriptions}"))
       (#1#
        (|htMakePage|
         (LIST
          (LIST '|bcLispLinks|
                (LIST "Descriptions" "" '|dbShowCons| '|documentation|))))))
      (|htSay| "}{")
      (COND ((OR |one?| (NULL (CDR |cAlist|))) (|htSay| "{\\em Filter}"))
            (#1#
             (|htMakePage|
              (LIST
               (LIST '|bcLinks|
                     (LIST "Filter" "" '|htFilterPage|
                           (LIST '|dbShowCons| '|filter|)))))))
      (|htSay| "}{")
      (COND
       ((OR |one?| (|member| '|kinds| |exclusions|)
            (NOT (EQ |kind| '|constructor|)))
        (|htSay| "{\\em Kinds}"))
       (#1#
        (|htMakePage|
         (LIST
          (LIST '|bcLispLinks| (LIST "Kinds" "" '|dbShowCons| '|kinds|))))))
      (|htSay| "}{")
      (COND
       ((OR |one?| (|member| '|names| |exclusions|)) (|htSay| "{\\em Names}"))
       (#1#
        (|htMakePage|
         (LIST
          (LIST '|bcLispLinks| (LIST "Names" "" '|dbShowCons| '|names|))))))
      (|htSay| "}{")
      (COND
       ((OR |one?| (|member| '|parameters| |exclusions|)
            (NULL
             ((LAMBDA (|bfVar#14| |bfVar#13| |x|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#13|)
                       (PROGN (SETQ |x| (CAR |bfVar#13|)) NIL))
                   (RETURN |bfVar#14|))
                  (#1#
                   (PROGN
                    (SETQ |bfVar#14| (CDAR |x|))
                    (COND (|bfVar#14| (RETURN |bfVar#14|))))))
                 (SETQ |bfVar#13| (CDR |bfVar#13|))))
              NIL |cAlist| NIL)))
        (|htSay| "{\\em Parameters}"))
       (#1#
        (|htMakePage|
         (LIST
          (LIST '|bcLispLinks|
                (LIST "Parameters" "" '|dbShowCons| '|parameters|))))))
      (|htSay| "}{")
      (COND
       (|$exposedOnlyIfTrue|
        (|htMakePage|
         (LIST
          (LIST '|bcLinks|
                (LIST "Unexposed Also" "" '|dbShowCons| '|exposureOff|)))))
       (|one?| (|htSay| "{\\em Exposed Only}"))
       (#1#
        (|htMakePage|
         (LIST
          (LIST '|bcLinks|
                (LIST "Exposed Only" "" '|dbShowCons| '|exposureOn|))))))
      (|htSay| "}")
      (|htEndTable|)))))

; htFilterPage(htPage,args) ==
;   htInitPage("Filter String",htCopyProplist htPage)
;   htSay "\centerline{Enter filter string (use {\em *} for wild card):}"
;   htSay '"\centerline{"
;   htMakePage [['bcStrings, [50,'"",'filter,'EM]]]
;   htSay '"}\vspace{1}\centerline{"
;   htMakePage [['bcLispLinks,['"\fbox{Filter}",'"",:args]]]
;   htSay '"}"
;   htShowPage()

(DEFUN |htFilterPage| (|htPage| |args|)
  (PROG ()
    (RETURN
     (PROGN
      (|htInitPage| '|Filter String| (|htCopyProplist| |htPage|))
      (|htSay|
       '|\\centerline{Enter filter string (use {\\em *} for wild card):}|)
      (|htSay| "\\centerline{")
      (|htMakePage| (LIST (LIST '|bcStrings| (LIST 50 "" '|filter| 'EM))))
      (|htSay| "}\\vspace{1}\\centerline{")
      (|htMakePage|
       (LIST (LIST '|bcLispLinks| (CONS "\\fbox{Filter}" (CONS "" |args|)))))
      (|htSay| "}")
      (|htShowPage|)))))

; dbShowConsKinds cAlist ==
;   cats := doms := paks := defs := nil
;   for x in cAlist repeat
;     op := CAAR x
;     kind := dbConstructorKind op
;     kind  = 'category => cats := [x,:cats]
;     kind = 'domain    => doms := [x,:doms]
;     kind = 'package   => paks := [x,:paks]
;     defs := [x,:defs]
;   lists := [NREVERSE cats,NREVERSE doms,NREVERSE paks,NREVERSE defs]
;   htBeginMenu 'description
;   htSayStandard '"\indent{1}"
;   kinds := +/[1 for x in lists | #x > 0]
;   for kind in '("category" "domain" "package" "default package") for x in lists | #x > 0 repeat
;     htSayStandard '"\item"
;     if kinds = 1
;        then htSay menuButton()
;        else htMakePage
;          [['bcLinks,[menuButton(),'"",'dbShowConsKindsFilter,[kind,x]]]]
;     htSayStandard '"\tab{1}"
;     htSayList(['"{\em ", c := #x, '" "])
;     htSay(c > 1 => pluralize kind; kind)
;     htSay '":}"
;     bcConTable REMDUP [CAAR y for y in x]
;   htEndMenu 'description
;   htSayStandard '"\indent{0}"

(DEFUN |dbShowConsKinds| (|cAlist|)
  (PROG (|defs| |paks| |doms| |cats| |op| |kind| |lists| |kinds| |c|)
    (RETURN
     (PROGN
      (SETQ |cats| (SETQ |doms| (SETQ |paks| (SETQ |defs| NIL))))
      ((LAMBDA (|bfVar#15| |x|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#15|) (PROGN (SETQ |x| (CAR |bfVar#15|)) NIL))
            (RETURN NIL))
           (#1='T
            (PROGN
             (SETQ |op| (CAAR |x|))
             (SETQ |kind| (|dbConstructorKind| |op|))
             (COND ((EQ |kind| '|category|) (SETQ |cats| (CONS |x| |cats|)))
                   ((EQ |kind| '|domain|) (SETQ |doms| (CONS |x| |doms|)))
                   ((EQ |kind| '|package|) (SETQ |paks| (CONS |x| |paks|)))
                   (#1# (SETQ |defs| (CONS |x| |defs|)))))))
          (SETQ |bfVar#15| (CDR |bfVar#15|))))
       |cAlist| NIL)
      (SETQ |lists|
              (LIST (NREVERSE |cats|) (NREVERSE |doms|) (NREVERSE |paks|)
                    (NREVERSE |defs|)))
      (|htBeginMenu| '|description|)
      (|htSayStandard| "\\indent{1}")
      (SETQ |kinds|
              ((LAMBDA (|bfVar#17| |bfVar#16| |x|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#16|)
                        (PROGN (SETQ |x| (CAR |bfVar#16|)) NIL))
                    (RETURN |bfVar#17|))
                   (#1#
                    (AND (< 0 (LENGTH |x|))
                         (SETQ |bfVar#17| (+ |bfVar#17| 1)))))
                  (SETQ |bfVar#16| (CDR |bfVar#16|))))
               0 |lists| NIL))
      ((LAMBDA (|bfVar#18| |kind| |bfVar#19| |x|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#18|) (PROGN (SETQ |kind| (CAR |bfVar#18|)) NIL)
                (ATOM |bfVar#19|) (PROGN (SETQ |x| (CAR |bfVar#19|)) NIL))
            (RETURN NIL))
           (#1#
            (AND (< 0 (LENGTH |x|))
                 (PROGN
                  (|htSayStandard| "\\item")
                  (COND ((EQL |kinds| 1) (|htSay| (|menuButton|)))
                        (#1#
                         (|htMakePage|
                          (LIST
                           (LIST '|bcLinks|
                                 (LIST (|menuButton|) ""
                                       '|dbShowConsKindsFilter|
                                       (LIST |kind| |x|)))))))
                  (|htSayStandard| "\\tab{1}")
                  (|htSayList| (LIST "{\\em " (SETQ |c| (LENGTH |x|)) " "))
                  (|htSay|
                   (COND ((< 1 |c|) (|pluralize| |kind|)) (#1# |kind|)))
                  (|htSay| ":}")
                  (|bcConTable|
                   (REMDUP
                    ((LAMBDA (|bfVar#21| |bfVar#20| |y|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#20|)
                              (PROGN (SETQ |y| (CAR |bfVar#20|)) NIL))
                          (RETURN (NREVERSE |bfVar#21|)))
                         (#1# (SETQ |bfVar#21| (CONS (CAAR |y|) |bfVar#21|))))
                        (SETQ |bfVar#20| (CDR |bfVar#20|))))
                     NIL |x| NIL)))))))
          (SETQ |bfVar#18| (CDR |bfVar#18|))
          (SETQ |bfVar#19| (CDR |bfVar#19|))))
       '("category" "domain" "package" "default package") NIL |lists| NIL)
      (|htEndMenu| '|description|)
      (|htSayStandard| "\\indent{0}")))))

; addParameterTemplates(page, conform) ==
; ---------------> from kPage <-----------------------
;   parlist := [STRINGIMAGE par for par in rest conform]
;   manuelsCode? := "MAX"/[#s for s in parlist] > 10
;   w := (manuelsCode? => 55; 23)
;   htSay '"Optional argument value"
;   htSay
;     rest parlist => '"s:"
;     '":"
;   odd := false
;   for parname in $PatternVariableList for par in rest conform repeat
;     htSayStandard (odd or manuelsCode? => "\newline";"\tab{29}")
;     odd := not odd
;     argstring :=
;       $conArgstrings is [a,:r] => ($conArgstrings := r; a)
;       '""
;     htMakePage [['text,'"{\em ",par,'"} = "],
;         ['bcStrings,[w - #STRINGIMAGE par,argstring,parname,'EM]]]

(DEFUN |addParameterTemplates| (|page| |conform|)
  (PROG (|parlist| |manuelsCode?| |w| |odd| |a| |r| |argstring|)
    (RETURN
     (PROGN
      (SETQ |parlist|
              ((LAMBDA (|bfVar#23| |bfVar#22| |par|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#22|)
                        (PROGN (SETQ |par| (CAR |bfVar#22|)) NIL))
                    (RETURN (NREVERSE |bfVar#23|)))
                   (#1='T
                    (SETQ |bfVar#23| (CONS (STRINGIMAGE |par|) |bfVar#23|))))
                  (SETQ |bfVar#22| (CDR |bfVar#22|))))
               NIL (CDR |conform|) NIL))
      (SETQ |manuelsCode?|
              (< 10
                 ((LAMBDA (|bfVar#25| |bfVar#24| |s|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#24|)
                           (PROGN (SETQ |s| (CAR |bfVar#24|)) NIL))
                       (RETURN |bfVar#25|))
                      (#1# (SETQ |bfVar#25| (MAX |bfVar#25| (LENGTH |s|)))))
                     (SETQ |bfVar#24| (CDR |bfVar#24|))))
                  -999999 |parlist| NIL)))
      (SETQ |w| (COND (|manuelsCode?| 55) (#1# 23)))
      (|htSay| "Optional argument value")
      (|htSay| (COND ((CDR |parlist|) "s:") (#1# ":")))
      (SETQ |odd| NIL)
      ((LAMBDA (|bfVar#26| |parname| |bfVar#27| |par|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#26|) (PROGN (SETQ |parname| (CAR |bfVar#26|)) NIL)
                (ATOM |bfVar#27|) (PROGN (SETQ |par| (CAR |bfVar#27|)) NIL))
            (RETURN NIL))
           (#1#
            (PROGN
             (|htSayStandard|
              (COND ((OR |odd| |manuelsCode?|) '|\\newline|)
                    (#1# '|\\tab{29}|)))
             (SETQ |odd| (NULL |odd|))
             (SETQ |argstring|
                     (COND
                      ((AND (CONSP |$conArgstrings|)
                            (PROGN
                             (SETQ |a| (CAR |$conArgstrings|))
                             (SETQ |r| (CDR |$conArgstrings|))
                             #1#))
                       (PROGN (SETQ |$conArgstrings| |r|) |a|))
                      (#1# "")))
             (|htMakePage|
              (LIST (LIST '|text| "{\\em " |par| "} = ")
                    (LIST '|bcStrings|
                          (LIST (- |w| (LENGTH (STRINGIMAGE |par|)))
                                |argstring| |parname| 'EM)))))))
          (SETQ |bfVar#26| (CDR |bfVar#26|))
          (SETQ |bfVar#27| (CDR |bfVar#27|))))
       |$PatternVariableList| NIL (CDR |conform|) NIL)))))

; kPageArgs([op,:args],[.,.,:source]) ==
;   firstTime := true
;   coSig := rest GETDATABASE(op,'COSIG)
;   for x in args for t in source for pred in coSig repeat
;     if firstTime then firstTime := false
;                  else
;                    htSayStandard '", and"
;     htSayStandard '"\newline "
;     typeForm := (t is [":",.,t1] => t1; t)
;     if pred = true
;       then htMakePage [['bcLinks,[x,'"",'kArgPage,x]]]
;       else htSayList(['"{\em ", x, '"}"])
;     htSayStandardList(['"\tab{", STRINGIMAGE( # PNAME x), '"}, "])
;     htSay
;       pred => '"a domain of category "
;       '"an element of the domain "
;     bcConform(typeForm,true)

(DEFUN |kPageArgs| (|bfVar#31| |bfVar#32|)
  (PROG (|source| |op| |args| |firstTime| |coSig| |ISTMP#1| |ISTMP#2| |t1|
         |typeForm|)
    (RETURN
     (PROGN
      (SETQ |source| (CDDR |bfVar#32|))
      (SETQ |op| (CAR |bfVar#31|))
      (SETQ |args| (CDR |bfVar#31|))
      (SETQ |firstTime| T)
      (SETQ |coSig| (CDR (GETDATABASE |op| 'COSIG)))
      ((LAMBDA (|bfVar#28| |x| |bfVar#29| |t| |bfVar#30| |pred|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#28|) (PROGN (SETQ |x| (CAR |bfVar#28|)) NIL)
                (ATOM |bfVar#29|) (PROGN (SETQ |t| (CAR |bfVar#29|)) NIL)
                (ATOM |bfVar#30|) (PROGN (SETQ |pred| (CAR |bfVar#30|)) NIL))
            (RETURN NIL))
           (#1='T
            (PROGN
             (COND (|firstTime| (SETQ |firstTime| NIL))
                   (#1# (|htSayStandard| ", and")))
             (|htSayStandard| "\\newline ")
             (SETQ |typeForm|
                     (COND
                      ((AND (CONSP |t|) (EQ (CAR |t|) '|:|)
                            (PROGN
                             (SETQ |ISTMP#1| (CDR |t|))
                             (AND (CONSP |ISTMP#1|)
                                  (PROGN
                                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                   (AND (CONSP |ISTMP#2|)
                                        (EQ (CDR |ISTMP#2|) NIL)
                                        (PROGN
                                         (SETQ |t1| (CAR |ISTMP#2|))
                                         #1#))))))
                       |t1|)
                      (#1# |t|)))
             (COND
              ((EQUAL |pred| T)
               (|htMakePage|
                (LIST (LIST '|bcLinks| (LIST |x| "" '|kArgPage| |x|)))))
              (#1# (|htSayList| (LIST "{\\em " |x| "}"))))
             (|htSayStandardList|
              (LIST "\\tab{" (STRINGIMAGE (LENGTH (PNAME |x|))) "}, "))
             (|htSay|
              (COND (|pred| "a domain of category ")
                    (#1# "an element of the domain ")))
             (|bcConform| |typeForm| T))))
          (SETQ |bfVar#28| (CDR |bfVar#28|))
          (SETQ |bfVar#29| (CDR |bfVar#29|))
          (SETQ |bfVar#30| (CDR |bfVar#30|))))
       |args| NIL |source| NIL |coSig| NIL)))))

; dbConform form ==
; --one button for the main constructor page of a type
;   ["\conf{",:form2StringList opOf form,'"}{",:form2Fence dbOuttran form,'"}"]

(DEFUN |dbConform| (|form|)
  (PROG ()
    (RETURN
     (CONS '|\\conf{|
           (APPEND (|form2StringList| (|opOf| |form|))
                   (CONS "}{"
                         (APPEND (|form2Fence| (|dbOuttran| |form|))
                                 (CONS "}" NIL))))))))

; htTab s == htSayStandardList(['"\tab{", s, '"}"])

(DEFUN |htTab| (|s|)
  (PROG () (RETURN (|htSayStandardList| (LIST "\\tab{" |s| "}")))))

; dbGatherThenShow(htPage,opAlist,which,data,constructorIfTrue,word,fn) ==
;   which ~= '"operation" => BREAK()
;   single? := null rest data
;   htBeginMenu 'description
;   bincount := 0
;   for [thing,exposeFlag,:items] in data repeat
;     htSayStandard ('"\item")
;     if single? then htSay(menuButton())
;     else
;       htMakePage
;         [['bcLinks,[menuButton(),'"",'dbShowOps,which,bincount]]]
;       button := mkButtonBox (1 + bincount)
;     htSay '"{\em "
;     htSay
;       thing = 'nowhere => '"implemented nowhere"
;       thing = 'constant => '"constant"
;       thing = '_$ => '"by the domain"
;       INTEGERP thing => '"unexported"
;       constructorIfTrue =>
;         htSay word
;         atom thing => '" an unknown constructor"
;         '""
;       atom thing => '"unconditional"
;       '""
;     htSay '"}"
;     if null atom thing then
;       if constructorIfTrue then
;           htSayList(['" {\em ", dbShowKind thing, '"}"])
;       htSay '" "
;       FUNCALL(fn,thing)
;     htSay('":\newline ")
;     dbShowOpSigList(which,items,(1 + bincount) * 8192)
;     bincount := bincount + 1
;   htEndMenu 'description

(DEFUN |dbGatherThenShow|
       (|htPage| |opAlist| |which| |data| |constructorIfTrue| |word| |fn|)
  (PROG (|single?| |bincount| |thing| |ISTMP#1| |exposeFlag| |items| |button|)
    (RETURN
     (COND ((NOT (EQUAL |which| "operation")) (BREAK))
           (#1='T
            (PROGN
             (SETQ |single?| (NULL (CDR |data|)))
             (|htBeginMenu| '|description|)
             (SETQ |bincount| 0)
             ((LAMBDA (|bfVar#34| |bfVar#33|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#34|)
                       (PROGN (SETQ |bfVar#33| (CAR |bfVar#34|)) NIL))
                   (RETURN NIL))
                  (#1#
                   (AND (CONSP |bfVar#33|)
                        (PROGN
                         (SETQ |thing| (CAR |bfVar#33|))
                         (SETQ |ISTMP#1| (CDR |bfVar#33|))
                         (AND (CONSP |ISTMP#1|)
                              (PROGN
                               (SETQ |exposeFlag| (CAR |ISTMP#1|))
                               (SETQ |items| (CDR |ISTMP#1|))
                               #1#)))
                        (PROGN
                         (|htSayStandard| "\\item")
                         (COND (|single?| (|htSay| (|menuButton|)))
                               (#1#
                                (|htMakePage|
                                 (LIST
                                  (LIST '|bcLinks|
                                        (LIST (|menuButton|) "" '|dbShowOps|
                                              |which| |bincount|))))
                                (SETQ |button|
                                        (|mkButtonBox| (+ 1 |bincount|)))))
                         (|htSay| "{\\em ")
                         (|htSay|
                          (COND ((EQ |thing| '|nowhere|) "implemented nowhere")
                                ((EQ |thing| '|constant|) "constant")
                                ((EQ |thing| '$) "by the domain")
                                ((INTEGERP |thing|) "unexported")
                                (|constructorIfTrue|
                                 (PROGN
                                  (|htSay| |word|)
                                  (COND
                                   ((ATOM |thing|) " an unknown constructor")
                                   (#1# ""))))
                                ((ATOM |thing|) "unconditional") (#1# "")))
                         (|htSay| "}")
                         (COND
                          ((NULL (ATOM |thing|))
                           (COND
                            (|constructorIfTrue|
                             (|htSayList|
                              (LIST " {\\em " (|dbShowKind| |thing|) "}"))))
                           (|htSay| " ") (FUNCALL |fn| |thing|)))
                         (|htSay| ":\\newline ")
                         (|dbShowOpSigList| |which| |items|
                          (* (+ 1 |bincount|) 8192))
                         (SETQ |bincount| (+ |bincount| 1))))))
                 (SETQ |bfVar#34| (CDR |bfVar#34|))))
              |data| NIL)
             (|htEndMenu| '|description|)))))))

; dbPresentOps(htPage, which, exclusion) ==
;   which ~= '"operation" => BREAK()
;   exclusions := [exclusion]
;   asharp? := htpProperty(htPage,'isAsharpConstructor)
;   fromConPage? := (conname := opOf htpProperty(htPage,'conform))
;   usage? := nil
;   star? := not fromConPage? or which = '"package operation"
;   implementation? := not asharp? and
;     $UserLevel = 'development and $conformsAreDomains --and not $includeUnexposed?
;   rightmost? := star? or (implementation? and not $includeUnexposed?)
;   if INTEGERP first exclusions then exclusions := ['documentation]
;   htpSetProperty(htPage,'exclusion,first exclusions)
;   opAlist :=
;     which = '"operation" => htpProperty(htPage,'opAlist)
;     htpProperty(htPage,'attrAlist)
;   empty? := null opAlist
;   one?   := opAlist is [entry] and 2 = #entry
;   one? := empty? or one?
;   htBeginTable()
;   htSay '"{"
;   if one? or member('conditions,exclusions)
;                  or (htpProperty(htPage,'condition?) = 'no)
;       then htSay '"{\em Conditions}"
;       else htMakePage [['bcLispLinks,['"Conditions",'"",'dbShowOps,which,'conditions]]]
;   htSay '"}{"
;   if empty? or member('documentation,exclusions)
;     then htSay '"{\em Descriptions}"
;     else htMakePage [['bcLispLinks,['"Descriptions",'"",'dbShowOps,which,'documentation]]]
;   htSay '"}{"
;   if null IFCDR opAlist
;     then htSay '"{\em Filter}"
;     else htMakePage [['bcLinks,['"Filter ",'"",'htFilterPage,['dbShowOps,which,'filter]]]]
;   htSay '"}{"
;   if one? or member('names,exclusions) or null IFCDR opAlist
;     then htSay '"{\em Names}"
;     else htMakePage [['bcLispLinks,['"Names",'"",'dbShowOps,which,'names]]]
;   if not star? then
;     htSay '"}{"
;     which = '"attribute" => BREAK()
;     if not(implementation?) or member('implementation, exclusions) or
;       ((conname := opOf htpProperty(htPage,'conform))
;         and GETDATABASE(conname,'CONSTRUCTORKIND) = 'category)
;     then htSay '"{\em Implementations}"
;     else htMakePage
;       [['bcLispLinks,['"Implementations",'"",'dbShowOps,which,'implementation]]]
;   htSay '"}{"
;   if one? or member('origins,exclusions)
;     then htSay '"{\em Origins}"
;     else htMakePage [['bcLispLinks,['"Origins",'"",'dbShowOps,which,'origins]]]
;   htSay '"}{"
;   if one? or member('parameters,exclusions) --also test for some parameter
;       or not dbDoesOneOpHaveParameters? opAlist
;     then htSay '"{\em Parameters}"
;     else htMakePage [['bcLispLinks,['"Parameters",'"",'dbShowOps,which,'parameters]]]
;   htSay '"}{"
;   which = '"attribute" => BREAK()
;   if one? or member('signatures, exclusions)
;       then htSay '"{\em Signatures}"
;       else htMakePage [['bcLispLinks,['"Signatures",'"",'dbShowOps,which,'signatures]]]
;   htSay '"}"
;   if star? then
;     htSay '"{"
;     if $exposedOnlyIfTrue
;     then
;          htMakePage([['bcLinks, ['"Unexposed Also", '"", 'dbShowOps,
;                                  which, 'exposureOff]]])
;     else if one?
;          then htSay '"{\em Exposed Only}"
;          else htMakePage [['bcLinks,['"Exposed Only",'"",'dbShowOps, which,'exposureOn]]]
;     htSay '"}"
;   htEndTable()

(DEFUN |dbPresentOps| (|htPage| |which| |exclusion|)
  (PROG (|exclusions| |asharp?| |conname| |fromConPage?| |usage?| |star?|
         |implementation?| |rightmost?| |opAlist| |empty?| |entry| |one?|)
    (RETURN
     (COND ((NOT (EQUAL |which| "operation")) (BREAK))
           (#1='T
            (PROGN
             (SETQ |exclusions| (LIST |exclusion|))
             (SETQ |asharp?| (|htpProperty| |htPage| '|isAsharpConstructor|))
             (SETQ |fromConPage?|
                     (SETQ |conname|
                             (|opOf| (|htpProperty| |htPage| '|conform|))))
             (SETQ |usage?| NIL)
             (SETQ |star?|
                     (OR (NULL |fromConPage?|)
                         (EQUAL |which| "package operation")))
             (SETQ |implementation?|
                     (AND (NULL |asharp?|) (EQ |$UserLevel| '|development|)
                          |$conformsAreDomains|))
             (SETQ |rightmost?|
                     (OR |star?|
                         (AND |implementation?| (NULL |$includeUnexposed?|))))
             (COND
              ((INTEGERP (CAR |exclusions|))
               (SETQ |exclusions| (LIST '|documentation|))))
             (|htpSetProperty| |htPage| '|exclusion| (CAR |exclusions|))
             (SETQ |opAlist|
                     (COND
                      ((EQUAL |which| "operation")
                       (|htpProperty| |htPage| '|opAlist|))
                      (#1# (|htpProperty| |htPage| '|attrAlist|))))
             (SETQ |empty?| (NULL |opAlist|))
             (SETQ |one?|
                     (AND (CONSP |opAlist|) (EQ (CDR |opAlist|) NIL)
                          (PROGN (SETQ |entry| (CAR |opAlist|)) #1#)
                          (EQL 2 (LENGTH |entry|))))
             (SETQ |one?| (OR |empty?| |one?|))
             (|htBeginTable|)
             (|htSay| "{")
             (COND
              ((OR |one?| (|member| '|conditions| |exclusions|)
                   (EQ (|htpProperty| |htPage| '|condition?|) '|no|))
               (|htSay| "{\\em Conditions}"))
              (#1#
               (|htMakePage|
                (LIST
                 (LIST '|bcLispLinks|
                       (LIST "Conditions" "" '|dbShowOps| |which|
                             '|conditions|))))))
             (|htSay| "}{")
             (COND
              ((OR |empty?| (|member| '|documentation| |exclusions|))
               (|htSay| "{\\em Descriptions}"))
              (#1#
               (|htMakePage|
                (LIST
                 (LIST '|bcLispLinks|
                       (LIST "Descriptions" "" '|dbShowOps| |which|
                             '|documentation|))))))
             (|htSay| "}{")
             (COND ((NULL (IFCDR |opAlist|)) (|htSay| "{\\em Filter}"))
                   (#1#
                    (|htMakePage|
                     (LIST
                      (LIST '|bcLinks|
                            (LIST "Filter " "" '|htFilterPage|
                                  (LIST '|dbShowOps| |which| '|filter|)))))))
             (|htSay| "}{")
             (COND
              ((OR |one?| (|member| '|names| |exclusions|)
                   (NULL (IFCDR |opAlist|)))
               (|htSay| "{\\em Names}"))
              (#1#
               (|htMakePage|
                (LIST
                 (LIST '|bcLispLinks|
                       (LIST "Names" "" '|dbShowOps| |which| '|names|))))))
             (COND
              ((NULL |star?|) (|htSay| "}{")
               (COND ((EQUAL |which| "attribute") (BREAK))
                     (#1#
                      (COND
                       ((OR (NULL |implementation?|)
                            (|member| '|implementation| |exclusions|)
                            (AND
                             (SETQ |conname|
                                     (|opOf|
                                      (|htpProperty| |htPage| '|conform|)))
                             (EQ (GETDATABASE |conname| 'CONSTRUCTORKIND)
                                 '|category|)))
                        (|htSay| "{\\em Implementations}"))
                       (#1#
                        (|htMakePage|
                         (LIST
                          (LIST '|bcLispLinks|
                                (LIST "Implementations" "" '|dbShowOps| |which|
                                      '|implementation|))))))))))
             (|htSay| "}{")
             (COND
              ((OR |one?| (|member| '|origins| |exclusions|))
               (|htSay| "{\\em Origins}"))
              (#1#
               (|htMakePage|
                (LIST
                 (LIST '|bcLispLinks|
                       (LIST "Origins" "" '|dbShowOps| |which| '|origins|))))))
             (|htSay| "}{")
             (COND
              ((OR |one?| (|member| '|parameters| |exclusions|)
                   (NULL (|dbDoesOneOpHaveParameters?| |opAlist|)))
               (|htSay| "{\\em Parameters}"))
              (#1#
               (|htMakePage|
                (LIST
                 (LIST '|bcLispLinks|
                       (LIST "Parameters" "" '|dbShowOps| |which|
                             '|parameters|))))))
             (|htSay| "}{")
             (COND ((EQUAL |which| "attribute") (BREAK))
                   (#1#
                    (PROGN
                     (COND
                      ((OR |one?| (|member| '|signatures| |exclusions|))
                       (|htSay| "{\\em Signatures}"))
                      (#1#
                       (|htMakePage|
                        (LIST
                         (LIST '|bcLispLinks|
                               (LIST "Signatures" "" '|dbShowOps| |which|
                                     '|signatures|))))))
                     (|htSay| "}")
                     (COND
                      (|star?| (|htSay| "{")
                       (COND
                        (|$exposedOnlyIfTrue|
                         (|htMakePage|
                          (LIST
                           (LIST '|bcLinks|
                                 (LIST "Unexposed Also" "" '|dbShowOps| |which|
                                       '|exposureOff|)))))
                        (|one?| (|htSay| "{\\em Exposed Only}"))
                        (#1#
                         (|htMakePage|
                          (LIST
                           (LIST '|bcLinks|
                                 (LIST "Exposed Only" "" '|dbShowOps| |which|
                                       '|exposureOn|))))))
                       (|htSay| "}")))
                     (|htEndTable|))))))))))

; htShowPageStar() ==
;   htSayStandard '"\endscroll "
;   if $exposedOnlyIfTrue then
;     htMakePage [['bcLinks,['"Unexposed Also",'"",'repeatSearch,NIL]]]
;   else
;     htMakePage [['bcLinks,['"Exposed Only",'"",'repeatSearch,'T]]]
;   htShowPageNoScroll()

(DEFUN |htShowPageStar| ()
  (PROG ()
    (RETURN
     (PROGN
      (|htSayStandard| "\\endscroll ")
      (COND
       (|$exposedOnlyIfTrue|
        (|htMakePage|
         (LIST
          (LIST '|bcLinks| (LIST "Unexposed Also" "" '|repeatSearch| NIL)))))
       ('T
        (|htMakePage|
         (LIST
          (LIST '|bcLinks| (LIST "Exposed Only" "" '|repeatSearch| 'T))))))
      (|htShowPageNoScroll|)))))

; displayDomainOp(htPage,which,origin,op,sig,predicate,
;                 doc,index,chooseFn,unexposed?,$generalSearch?) ==
;   $chooseDownCaseOfType : local := true   --see dbGetContrivedForm
;   $whereList  : local := nil
;   $NumberList : local := '(i j k l m n i1 j1 k1 l1 m1 n1 i2 j2 k2 l2 m2 n2 i3 j3 k3 l3 m3 n3 i4 j4 k4 l4 m4 n4 )
;   $ElementList: local := '(x y z u v w x1 y1 z1 u1 v1 w1 x2 y2 z2 u2 v2 w2 x3 y3 z3 u3 v3 w3 x4 y4 z4 u4 v4 w4 )
;   $FunctionList:local := '(f g h d e F G H)
;   $DomainList:  local := '(D R S E T A B C M N P Q U V W)
;   exactlyOneOpSig     := null index
;   conform   := htpProperty(htPage,'domname) or htpProperty(htPage,'conform)
;                  or origin
;   if $generalSearch? then $DomainList := rest $DomainList
;   opform :=
;     which = '"attribute" => BREAK()
;     which = '"constructor" => origin
;     dbGetDisplayFormForOp(op,sig,doc)
;   htSayStandard('"\newline")
;   -----------------------------------------------------------
;   if exactlyOneOpSig
;     then htSay menuButton()
;     else htMakePage
;       [['bcLinks,[menuButton(),'"",chooseFn,which,index]]]
;   htSayStandard '"\tab{2}"
;   op   := IFCAR opform
;   args := IFCDR opform
;   ops := escapeSpecialChars STRINGIMAGE op
;   n := #sig
;   do
;     n = 2 and GETL(op, 'Nud) =>
;         htSayList([ops, '" {\em ", quickForm2HtString IFCAR args, '"}"])
;     n = 3 and GETL(op, 'Led) =>
;         htSayList(['"{\em ", quickForm2HtString IFCAR args, '"} ", ops,
;               '" {\em ", quickForm2HtString IFCAR IFCDR args, '"}"])
;     if unexposed? and $includeUnexposed? then
;       htSayUnexposed()
;     htSay(ops)
;     predicate='ASCONST or GETDATABASE(op,'NILADIC) or member(op,'(0 1)) => 'skip
;     which = '"attribute" => BREAK()
;     htSay('"(")
;     if IFCAR args then
;         htSayList(['"{\em ", quickForm2HtString IFCAR args, '"}"])
;     for x in IFCDR args repeat
;         htSayList(['",{\em ", quickForm2HtString x, '"}"])
;     htSay('")")
;   -----------prepare to print description---------------------
;   constring := form2HtString conform
;   conname   := first conform
;   $conkind   : local := htpProperty(htPage,'kind) -- a string e.g. "category"
;                           or STRINGIMAGE GETDATABASE(conname,'CONSTRUCTORKIND)
;   $conlength : local := #constring
;   $conform   : local := conform
;   $conargs   : local := rest conform
;   if which = '"operation" then
;     $signature : local :=
;       MEMQ(conname,$Primitives) => nil
;       CDAR getConstructorModemap conname
;     --RDJ: this next line is necessary until compiler bug is fixed
;     --that forgets to substitute #variables for t#variables;
;     --check the signature for SegmentExpansionCategory, e.g.
;     tvarlist := TAKE(# $conargs,$TriangleVariableList)
;     $signature := SUBLISLIS($FormalMapVariableList,tvarlist,$signature)
;   which = '"attribute" => BREAK()
;   $sig :=
;     which = '"constructor" => sig
;     $conkind ~= '"package" => sig
;     symbolsUsed := [x for x in rest conform | IDENTP x]
;     $DomainList := SETDIFFERENCE($DomainList,symbolsUsed)
;     getSubstSigIfPossible sig
;   -----------------------------------------------------------
;   if member(which,'("operation" "constructor")) then
;     $displayReturnValue: local := nil
;     if args then
;       htSayStandard('"\newline\tab{2}{\em Arguments:}")
;       coSig := IFCDR GETDATABASE(op, 'COSIG)  --check if op is constructor
;       for a in args for t in rest $sig repeat
;             htSayIndentRel2(15, true)
;             position := IFCAR relatives
;             relatives := IFCDR relatives
;             if IFCAR coSig and t ~= '(Type)
;               then htMakePage [['bcLinks,[a,'"",'kArgPage,a]]]
;               else htSayList(['"{\em ", form2HtString(a), '"}"])
;             htSay ", "
;             coSig := IFCDR coSig
;             htSayValue t
;             htSayIndentRel2(-15, true)
;             htSayStandard('"\newline ")
;     if first $sig then
;       $displayReturnValue := true
;       htSayStandard('"\newline\tab{2}")
;       htSay '"{\em Returns:}"
;       htSayIndentRel2(15, true)
;       htSayValue first $sig
;       htSayIndentRel2(-15, true)
;   -----------------------------------------------------------
;   if origin and ($generalSearch? or origin ~= conform) and op~=opOf origin then
;     htSayStandard('"\newline\tab{2}{\em Origin:}")
;     htSayIndentRel(15)
;     if not isExposedConstructor opOf origin and $includeUnexposed?
;        then htSayUnexposed()
;     bcConform(origin,true)
;     htSayIndentRel(-15)
;   -----------------------------------------------------------
;   if not MEMQ(predicate,'(T ASCONST)) then
;     pred := sublisFormal(IFCDR conform, predicate)
;     count := #pred
;     htSayStandard('"\newline\tab{2}{\em Conditions:}")
;     for p in displayBreakIntoAnds SUBST($conform,"$",pred) repeat
;       htSayIndentRel2(15, count > 1)
;       bcPred(p,$conform,true)
;       htSayIndentRel2(-15, count > 1)
;       htSayStandard('"\newline ")
;   -----------------------------------------------------------
;   if $whereList then
;     count := #$whereList
;     htSayStandard('"\newline\tab{2}{\em Where:}")
;     if assoc("$",$whereList) then
;       htSayIndentRel2(15, true)
;       htSayStandard '"{\em \$} is "
;       htSay
;         $conkind = '"category" => '"of category "
;         '"the domain "
;       bcConform(conform,true,true)
;       htSayIndentRel2(-15, true)
;     for [d,key,:t] in $whereList | d ~= "$" repeat
;       htSayIndentRel2(15, count > 1)
;       htSayList(["{\em ", d, "} is "])
;       htSayConstructor(key, sublisFormal(IFCDR conform, t))
;       htSayIndentRel2(-15, count > 1)
;   -----------------------------------------------------------
;   if doc and (doc ~= '"" and (doc isnt [d] or d ~= '"")) then
;     htSayStandard('"\newline\tab{2}{\em Description:}")
;     htSayIndentRel(15)
;     if doc = $charFauxNewline then htSay $charNewline
;     else
;        ndoc:=
;           -- we are confused whether doc is a string or a list of strings
;           CONSP doc =>  [SUBSTITUTE($charNewline, $charFauxNewline, i) for i in doc]
;           SUBSTITUTE($charNewline, $charFauxNewline,doc)
;        htSay ndoc
;     htSayIndentRel(-15)
;   --------> print abbr and source file for constructors <---------
;   if which = '"constructor" then
;     if (abbr := GETDATABASE(conname,'ABBREVIATION)) then
;       htSayStandard('"\tab{2}{\em Abbreviation:}")
;       htSayIndentRel(15)
;       htSay abbr
;       htSayIndentRel(-15)
;       htSayStandard('"\newline{}")
;     htSayStandard('"\tab{2}{\em Source File:}")
;     htSayIndentRel(15)
;     htSaySourceFile conname
;     htSayIndentRel(-15)

(DEFUN |displayDomainOp|
       (|htPage| |which| |origin| |op| |sig| |predicate| |doc| |index|
        |chooseFn| |unexposed?| |$generalSearch?|)
  (DECLARE (SPECIAL |$generalSearch?|))
  (PROG (|$displayReturnValue| |$signature| |$conargs| |$conform| |$conlength|
         |$conkind| |$DomainList| |$FunctionList| |$ElementList| |$NumberList|
         |$whereList| |$chooseDownCaseOfType| |abbr| |ndoc| |t| |key| |ISTMP#1|
         |d| |count| |pred| |relatives| |position| |coSig| |symbolsUsed|
         |tvarlist| |conname| |constring| |n| |ops| |args| |opform| |conform|
         |exactlyOneOpSig|)
    (DECLARE
     (SPECIAL |$displayReturnValue| |$signature| |$conargs| |$conform|
      |$conlength| |$conkind| |$DomainList| |$FunctionList| |$ElementList|
      |$NumberList| |$whereList| |$chooseDownCaseOfType|))
    (RETURN
     (PROGN
      (SETQ |$chooseDownCaseOfType| T)
      (SETQ |$whereList| NIL)
      (SETQ |$NumberList|
              '(|i| |j| |k| |l| |m| |n| |i1| |j1| |k1| |l1| |m1| |n1| |i2| |j2|
                |k2| |l2| |m2| |n2| |i3| |j3| |k3| |l3| |m3| |n3| |i4| |j4|
                |k4| |l4| |m4| |n4|))
      (SETQ |$ElementList|
              '(|x| |y| |z| |u| |v| |w| |x1| |y1| |z1| |u1| |v1| |w1| |x2| |y2|
                |z2| |u2| |v2| |w2| |x3| |y3| |z3| |u3| |v3| |w3| |x4| |y4|
                |z4| |u4| |v4| |w4|))
      (SETQ |$FunctionList| '(|f| |g| |h| |d| |e| F G H))
      (SETQ |$DomainList| '(D R S E T A B C M N P Q U V W))
      (SETQ |exactlyOneOpSig| (NULL |index|))
      (SETQ |conform|
              (OR (|htpProperty| |htPage| '|domname|)
                  (|htpProperty| |htPage| '|conform|) |origin|))
      (COND (|$generalSearch?| (SETQ |$DomainList| (CDR |$DomainList|))))
      (SETQ |opform|
              (COND ((EQUAL |which| "attribute") (BREAK))
                    ((EQUAL |which| "constructor") |origin|)
                    (#1='T (|dbGetDisplayFormForOp| |op| |sig| |doc|))))
      (|htSayStandard| "\\newline")
      (COND (|exactlyOneOpSig| (|htSay| (|menuButton|)))
            (#1#
             (|htMakePage|
              (LIST
               (LIST '|bcLinks|
                     (LIST (|menuButton|) "" |chooseFn| |which| |index|))))))
      (|htSayStandard| "\\tab{2}")
      (SETQ |op| (IFCAR |opform|))
      (SETQ |args| (IFCDR |opform|))
      (SETQ |ops| (|escapeSpecialChars| (STRINGIMAGE |op|)))
      (SETQ |n| (LENGTH |sig|))
      (|do|
       (COND
        ((AND (EQL |n| 2) (GETL |op| '|Nud|))
         (|htSayList|
          (LIST |ops| " {\\em " (|quickForm2HtString| (IFCAR |args|)) "}")))
        ((AND (EQL |n| 3) (GETL |op| '|Led|))
         (|htSayList|
          (LIST "{\\em " (|quickForm2HtString| (IFCAR |args|)) "} " |ops|
                " {\\em " (|quickForm2HtString| (IFCAR (IFCDR |args|))) "}")))
        (#1#
         (PROGN
          (COND ((AND |unexposed?| |$includeUnexposed?|) (|htSayUnexposed|)))
          (|htSay| |ops|)
          (COND
           ((OR (EQ |predicate| 'ASCONST) (GETDATABASE |op| 'NILADIC)
                (|member| |op| '(0 1)))
            '|skip|)
           ((EQUAL |which| "attribute") (BREAK))
           (#1#
            (PROGN
             (|htSay| "(")
             (COND
              ((IFCAR |args|)
               (|htSayList|
                (LIST "{\\em " (|quickForm2HtString| (IFCAR |args|)) "}"))))
             ((LAMBDA (|bfVar#35| |x|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#35|)
                       (PROGN (SETQ |x| (CAR |bfVar#35|)) NIL))
                   (RETURN NIL))
                  (#1#
                   (|htSayList|
                    (LIST ",{\\em " (|quickForm2HtString| |x|) "}"))))
                 (SETQ |bfVar#35| (CDR |bfVar#35|))))
              (IFCDR |args|) NIL)
             (|htSay| ")"))))))))
      (SETQ |constring| (|form2HtString| |conform|))
      (SETQ |conname| (CAR |conform|))
      (SETQ |$conkind|
              (OR (|htpProperty| |htPage| '|kind|)
                  (STRINGIMAGE (GETDATABASE |conname| 'CONSTRUCTORKIND))))
      (SETQ |$conlength| (LENGTH |constring|))
      (SETQ |$conform| |conform|)
      (SETQ |$conargs| (CDR |conform|))
      (COND
       ((EQUAL |which| "operation")
        (SETQ |$signature|
                (COND ((MEMQ |conname| |$Primitives|) NIL)
                      (#1# (CDAR (|getConstructorModemap| |conname|)))))
        (SETQ |tvarlist| (TAKE (LENGTH |$conargs|) |$TriangleVariableList|))
        (SETQ |$signature|
                (SUBLISLIS |$FormalMapVariableList| |tvarlist| |$signature|))))
      (COND ((EQUAL |which| "attribute") (BREAK))
            (#1#
             (PROGN
              (SETQ |$sig|
                      (COND ((EQUAL |which| "constructor") |sig|)
                            ((NOT (EQUAL |$conkind| "package")) |sig|)
                            (#1#
                             (PROGN
                              (SETQ |symbolsUsed|
                                      ((LAMBDA (|bfVar#37| |bfVar#36| |x|)
                                         (LOOP
                                          (COND
                                           ((OR (ATOM |bfVar#36|)
                                                (PROGN
                                                 (SETQ |x| (CAR |bfVar#36|))
                                                 NIL))
                                            (RETURN (NREVERSE |bfVar#37|)))
                                           (#1#
                                            (AND (IDENTP |x|)
                                                 (SETQ |bfVar#37|
                                                         (CONS |x|
                                                               |bfVar#37|)))))
                                          (SETQ |bfVar#36| (CDR |bfVar#36|))))
                                       NIL (CDR |conform|) NIL))
                              (SETQ |$DomainList|
                                      (SETDIFFERENCE |$DomainList|
                                                     |symbolsUsed|))
                              (|getSubstSigIfPossible| |sig|)))))
              (COND
               ((|member| |which| '("operation" "constructor"))
                (SETQ |$displayReturnValue| NIL)
                (COND
                 (|args| (|htSayStandard| "\\newline\\tab{2}{\\em Arguments:}")
                  (SETQ |coSig| (IFCDR (GETDATABASE |op| 'COSIG)))
                  ((LAMBDA (|bfVar#38| |a| |bfVar#39| |t|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#38|)
                            (PROGN (SETQ |a| (CAR |bfVar#38|)) NIL)
                            (ATOM |bfVar#39|)
                            (PROGN (SETQ |t| (CAR |bfVar#39|)) NIL))
                        (RETURN NIL))
                       (#1#
                        (PROGN
                         (|htSayIndentRel2| 15 T)
                         (SETQ |position| (IFCAR |relatives|))
                         (SETQ |relatives| (IFCDR |relatives|))
                         (COND
                          ((AND (IFCAR |coSig|) (NOT (EQUAL |t| '(|Type|))))
                           (|htMakePage|
                            (LIST
                             (LIST '|bcLinks| (LIST |a| "" '|kArgPage| |a|)))))
                          (#1#
                           (|htSayList|
                            (LIST "{\\em " (|form2HtString| |a|) "}"))))
                         (|htSay| '|, |)
                         (SETQ |coSig| (IFCDR |coSig|))
                         (|htSayValue| |t|)
                         (|htSayIndentRel2| (- 15) T)
                         (|htSayStandard| "\\newline "))))
                      (SETQ |bfVar#38| (CDR |bfVar#38|))
                      (SETQ |bfVar#39| (CDR |bfVar#39|))))
                   |args| NIL (CDR |$sig|) NIL)))
                (COND
                 ((CAR |$sig|) (SETQ |$displayReturnValue| T)
                  (|htSayStandard| "\\newline\\tab{2}")
                  (|htSay| "{\\em Returns:}") (|htSayIndentRel2| 15 T)
                  (|htSayValue| (CAR |$sig|)) (|htSayIndentRel2| (- 15) T)))))
              (COND
               ((AND |origin|
                     (OR |$generalSearch?| (NOT (EQUAL |origin| |conform|)))
                     (NOT (EQUAL |op| (|opOf| |origin|))))
                (|htSayStandard| "\\newline\\tab{2}{\\em Origin:}")
                (|htSayIndentRel| 15)
                (COND
                 ((AND (NULL (|isExposedConstructor| (|opOf| |origin|)))
                       |$includeUnexposed?|)
                  (|htSayUnexposed|)))
                (|bcConform| |origin| T) (|htSayIndentRel| (- 15))))
              (COND
               ((NULL (MEMQ |predicate| '(T ASCONST)))
                (SETQ |pred| (|sublisFormal| (IFCDR |conform|) |predicate|))
                (SETQ |count| (LENGTH |pred|))
                (|htSayStandard| "\\newline\\tab{2}{\\em Conditions:}")
                ((LAMBDA (|bfVar#40| |p|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#40|)
                          (PROGN (SETQ |p| (CAR |bfVar#40|)) NIL))
                      (RETURN NIL))
                     (#1#
                      (PROGN
                       (|htSayIndentRel2| 15 (< 1 |count|))
                       (|bcPred| |p| |$conform| T)
                       (|htSayIndentRel2| (- 15) (< 1 |count|))
                       (|htSayStandard| "\\newline "))))
                    (SETQ |bfVar#40| (CDR |bfVar#40|))))
                 (|displayBreakIntoAnds| (SUBST |$conform| '$ |pred|)) NIL)))
              (COND
               (|$whereList| (SETQ |count| (LENGTH |$whereList|))
                (|htSayStandard| "\\newline\\tab{2}{\\em Where:}")
                (COND
                 ((|assoc| '$ |$whereList|) (|htSayIndentRel2| 15 T)
                  (|htSayStandard| "{\\em \\$} is ")
                  (|htSay|
                   (COND ((EQUAL |$conkind| "category") "of category ")
                         (#1# "the domain ")))
                  (|bcConform| |conform| T T) (|htSayIndentRel2| (- 15) T)))
                ((LAMBDA (|bfVar#42| |bfVar#41|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#42|)
                          (PROGN (SETQ |bfVar#41| (CAR |bfVar#42|)) NIL))
                      (RETURN NIL))
                     (#1#
                      (AND (CONSP |bfVar#41|)
                           (PROGN
                            (SETQ |d| (CAR |bfVar#41|))
                            (SETQ |ISTMP#1| (CDR |bfVar#41|))
                            (AND (CONSP |ISTMP#1|)
                                 (PROGN
                                  (SETQ |key| (CAR |ISTMP#1|))
                                  (SETQ |t| (CDR |ISTMP#1|))
                                  #1#)))
                           (NOT (EQ |d| '$))
                           (PROGN
                            (|htSayIndentRel2| 15 (< 1 |count|))
                            (|htSayList| (LIST '|{\\em | |d| '|} is |))
                            (|htSayConstructor| |key|
                             (|sublisFormal| (IFCDR |conform|) |t|))
                            (|htSayIndentRel2| (- 15) (< 1 |count|))))))
                    (SETQ |bfVar#42| (CDR |bfVar#42|))))
                 |$whereList| NIL)))
              (COND
               ((AND |doc| (NOT (EQUAL |doc| ""))
                     (OR
                      (NOT
                       (AND (CONSP |doc|) (EQ (CDR |doc|) NIL)
                            (PROGN (SETQ |d| (CAR |doc|)) #1#)))
                      (NOT (EQUAL |d| ""))))
                (|htSayStandard| "\\newline\\tab{2}{\\em Description:}")
                (|htSayIndentRel| 15)
                (COND
                 ((EQUAL |doc| |$charFauxNewline|) (|htSay| |$charNewline|))
                 (#1#
                  (SETQ |ndoc|
                          (COND
                           ((CONSP |doc|)
                            ((LAMBDA (|bfVar#44| |bfVar#43| |i|)
                               (LOOP
                                (COND
                                 ((OR (ATOM |bfVar#43|)
                                      (PROGN (SETQ |i| (CAR |bfVar#43|)) NIL))
                                  (RETURN (NREVERSE |bfVar#44|)))
                                 (#1#
                                  (SETQ |bfVar#44|
                                          (CONS
                                           (SUBSTITUTE |$charNewline|
                                                       |$charFauxNewline| |i|)
                                           |bfVar#44|))))
                                (SETQ |bfVar#43| (CDR |bfVar#43|))))
                             NIL |doc| NIL))
                           (#1#
                            (SUBSTITUTE |$charNewline| |$charFauxNewline|
                                        |doc|))))
                  (|htSay| |ndoc|)))
                (|htSayIndentRel| (- 15))))
              (COND
               ((EQUAL |which| "constructor")
                (COND
                 ((SETQ |abbr| (GETDATABASE |conname| 'ABBREVIATION))
                  (|htSayStandard| "\\tab{2}{\\em Abbreviation:}")
                  (|htSayIndentRel| 15) (|htSay| |abbr|)
                  (|htSayIndentRel| (- 15)) (|htSayStandard| "\\newline{}")))
                (|htSayStandard| "\\tab{2}{\\em Source File:}")
                (|htSayIndentRel| 15) (|htSaySourceFile| |conname|)
                (|htSayIndentRel| (- 15)))))))))))

; htSaySourceFile conname ==
;   sourceFileName := (GETDATABASE(conname,'SOURCEFILE) or '"none")
;   filename :=  extractFileNameFromPath sourceFileName
;   htMakePage [['text,'"\unixcommand{",filename,'"}{_\$FRICAS/lib/SPADEDIT ",
;               sourceFileName, '" ", conname, '"}"]]

(DEFUN |htSaySourceFile| (|conname|)
  (PROG (|sourceFileName| |filename|)
    (RETURN
     (PROGN
      (SETQ |sourceFileName| (OR (GETDATABASE |conname| 'SOURCEFILE) "none"))
      (SETQ |filename| (|extractFileNameFromPath| |sourceFileName|))
      (|htMakePage|
       (LIST
        (LIST '|text| "\\unixcommand{" |filename| "}{\\$FRICAS/lib/SPADEDIT "
              |sourceFileName| " " |conname| "}")))))))

; htSayIndentRel(n) == htSayIndentRel2(n, false)

(DEFUN |htSayIndentRel| (|n|) (PROG () (RETURN (|htSayIndentRel2| |n| NIL))))

; htSayIndentRel2(n, flag) ==
;   m := ABS n
;   if flag then m := m + 2
;   htSayStandard
;     n > 0 =>
;       flag => ['"\indent{",STRINGIMAGE m,'"}\tab{-2}"]
;       ['"\indent{",STRINGIMAGE m,'"}\tab{0}"]
;     n < 0 => ['"\indent{0}\newline "]

(DEFUN |htSayIndentRel2| (|n| |flag|)
  (PROG (|m|)
    (RETURN
     (PROGN
      (SETQ |m| (ABS |n|))
      (COND (|flag| (SETQ |m| (+ |m| 2))))
      (|htSayStandard|
       (COND
        ((< 0 |n|)
         (COND (|flag| (LIST "\\indent{" (STRINGIMAGE |m|) "}\\tab{-2}"))
               ('T (LIST "\\indent{" (STRINGIMAGE |m|) "}\\tab{0}"))))
        ((MINUSP |n|) (LIST "\\indent{0}\\newline "))))))))

; htSayUnexposed() ==
;   htSay '"{\em *}"
;   $atLeastOneUnexposed := true

(DEFUN |htSayUnexposed| ()
  (PROG ()
    (RETURN (PROGN (|htSay| "{\\em *}") (SETQ |$atLeastOneUnexposed| T)))))

; htBeginTable() ==
;   htSayStandard '"\table{"

(DEFUN |htBeginTable| () (PROG () (RETURN (|htSayStandard| "\\table{"))))

; htEndTable() ==
;   htSayStandard '"}"

(DEFUN |htEndTable| () (PROG () (RETURN (|htSayStandard| "}"))))

; htBeginMenu(kind) ==
;   htSayStandard '"\beginmenu "

(DEFUN |htBeginMenu| (|kind|)
  (PROG () (RETURN (|htSayStandard| "\\beginmenu "))))

; htEndMenu(kind) ==
;   htSayStandard '"\endmenu "

(DEFUN |htEndMenu| (|kind|) (PROG () (RETURN (|htSayStandard| "\\endmenu "))))

; htSayConstructorName(nameShown, name) ==
;     htSayStandard ["\lispdownlink{",nameShown,'"}{(|conPage| '|",name,'"|)}"]

(DEFUN |htSayConstructorName| (|nameShown| |name|)
  (PROG ()
    (RETURN
     (|htSayStandard|
      (LIST '|\\lispdownlink{| |nameShown| "}{(|conPage| '|" |name| "|)}")))))

; htAddHeading(title) ==
;   htNewPage title
;   page()

(DEFUN |htAddHeading| (|title|)
  (PROG () (RETURN (PROGN (|htNewPage| |title|) (|page|)))))

; htNewPage title ==
;     htSayStandardList(['"\begin{page}{", htpName $curPage, '"}{"])
;     htSayStandard title
;     htSayStandard '"}"

(DEFUN |htNewPage| (|title|)
  (PROG ()
    (RETURN
     (PROGN
      (|htSayStandardList| (LIST "\\begin{page}{" (|htpName| |$curPage|) "}{"))
      (|htSayStandard| |title|)
      (|htSayStandard| "}")))))

; htBlank() ==
;     htSayStandard '"\space{1}"

(DEFUN |htBlank| () (PROG () (RETURN (|htSayStandard| "\\space{1}"))))

; htBlanks(n) ==
;     htSayStandard STRCONC('"\space{",STRINGIMAGE n,'"}")

(DEFUN |htBlanks| (|n|)
  (PROG ()
    (RETURN (|htSayStandard| (STRCONC "\\space{" (STRINGIMAGE |n|) "}")))))

; unTab s ==
;   STRINGP s => unTab1 s
;   atom s => s
;   [unTab1 first s, :rest s]

(DEFUN |unTab| (|s|)
  (PROG ()
    (RETURN
     (COND ((STRINGP |s|) (|unTab1| |s|)) ((ATOM |s|) |s|)
           ('T (CONS (|unTab1| (CAR |s|)) (CDR |s|)))))))

; unTab1 s ==
;   STRING_<('"\tab{", s) = 5 and (k := charPosition(char '_}, s, 4)) =>
;       SUBSTRING(s, k + 1, nil)
;   s

(DEFUN |unTab1| (|s|)
  (PROG (|k|)
    (RETURN
     (COND
      ((AND (EQL (STRING< "\\tab{" |s|) 5)
            (SETQ |k| (|charPosition| (|char| '}) |s| 4)))
       (SUBSTRING |s| (+ |k| 1) NIL))
      ('T |s|)))))

; satBreak() ==
;   htSayStandard '"\item "

(DEFUN |satBreak| () (PROG () (RETURN (|htSayStandard| "\\item "))))

; htBigSkip() ==
;   htSayStandard '"\vspace{1}\newline "

(DEFUN |htBigSkip| ()
  (PROG () (RETURN (|htSayStandard| "\\vspace{1}\\newline "))))

; satDownLink(s,code) ==
;   htSayStandard '"\lispdownlink{"
;   htSayStandard s
;   htSayStandard '"}{"
;   htSayStandard code
;   htSayStandard '"}"

(DEFUN |satDownLink| (|s| |code|)
  (PROG ()
    (RETURN
     (PROGN
      (|htSayStandard| "\\lispdownlink{")
      (|htSayStandard| |s|)
      (|htSayStandard| "}{")
      (|htSayStandard| |code|)
      (|htSayStandard| "}")))))

; satTypeDownLink(s,code) ==
;   htSayStandard '"\lispdownlink{"
;   htSayStandard s
;   htSayStandard '"}{"
;   htSayStandard code
;   htSayStandard '"}"

(DEFUN |satTypeDownLink| (|s| |code|)
  (PROG ()
    (RETURN
     (PROGN
      (|htSayStandard| "\\lispdownlink{")
      (|htSayStandard| |s|)
      (|htSayStandard| "}{")
      (|htSayStandard| |code|)
      (|htSayStandard| "}")))))

; mkButtonBox n == STRCONC('"\buttonbox{", STRINGIMAGE n, '"}")

(DEFUN |mkButtonBox| (|n|)
  (PROG () (RETURN (STRCONC "\\buttonbox{" (STRINGIMAGE |n|) "}"))))

; purgeNewConstructorLines(lines, conlist) ==
;   [x for x in lines | not screenLocalLine(x, conlist)]

(DEFUN |purgeNewConstructorLines| (|lines| |conlist|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#46| |bfVar#45| |x|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#45|) (PROGN (SETQ |x| (CAR |bfVar#45|)) NIL))
           (RETURN (NREVERSE |bfVar#46|)))
          ('T
           (AND (NULL (|screenLocalLine| |x| |conlist|))
                (SETQ |bfVar#46| (CONS |x| |bfVar#46|)))))
         (SETQ |bfVar#45| (CDR |bfVar#45|))))
      NIL |lines| NIL))))

; screenLocalLine(line, conlist) ==
;   k := dbKind line
;   con := INTERN
;     k = char 'o or k = char 'a =>
;       s := dbPart(line,5,1)
;       k := charPosition(char '_(,s,1)
;       SUBSTRING(s,1,k - 1)
;     dbName line
;   MEMQ(con, conlist)

(DEFUN |screenLocalLine| (|line| |conlist|)
  (PROG (|k| |s| |con|)
    (RETURN
     (PROGN
      (SETQ |k| (|dbKind| |line|))
      (SETQ |con|
              (INTERN
               (COND
                ((OR (EQUAL |k| (|char| '|o|)) (EQUAL |k| (|char| '|a|)))
                 (PROGN
                  (SETQ |s| (|dbPart| |line| 5 1))
                  (SETQ |k| (|charPosition| (|char| '|(|) |s| 1))
                  (SUBSTRING |s| 1 (- |k| 1))))
                ('T (|dbName| |line|)))))
      (MEMQ |con| |conlist|)))))

; purgeLocalLibdb() ==   --called by the user through a clear command?
;   $newConstructorList := nil
;   deleteFile '"libdb.text"

(DEFUN |purgeLocalLibdb| ()
  (PROG ()
    (RETURN
     (PROGN (SETQ |$newConstructorList| NIL) (|deleteFile| "libdb.text")))))
