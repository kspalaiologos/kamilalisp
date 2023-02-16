
; )package "BOOT"

(IN-PACKAGE "BOOT")

; bcDrawIt2(ind,a,b) == STRCONC('"{}",ind,'"=",a,'"{}..",b,'"{}")

(DEFUN |bcDrawIt2| (|ind| |a| |b|)
  (PROG () (RETURN (STRCONC "{}" |ind| "=" |a| "{}.." |b| "{}"))))

; bcIndefiniteIntegrate() ==
;   htInitPage("Indefinite Integration Basic Command",nil)
;   htMakePage '(
;      (domainConditions
;        (isDomain EM $EmptyMode)
;        (isDomain S (String))
;        (isDomain SY (Symbol)))
;      (text . "\newline ")
;      (text . "\menuitemstyle{}\tab{2}")
;      (text . "Enter the {\em function} you would like to integrate:")
;      (text . "\newline\tab{2} ")
;      (bcStrings (45 "1/(x^2 + 6)" integrand EM))
;      (text . "\blankline")
;      (text . "\newline ")
;      (text . "\menuitemstyle{}\tab{2}")
;      (text . "Enter the {\em variable of integration}:")
;      (text . "\tab{37}")
;      (bcStrings (10 x symbol SY))
;      (doneButton "Continue" bcIndefiniteIntegrateGen))
;   htShowPage()

(DEFUN |bcIndefiniteIntegrate| ()
  (PROG ()
    (RETURN
     (PROGN
      (|htInitPage| '|Indefinite Integration Basic Command| NIL)
      (|htMakePage|
       '((|domainConditions| (|isDomain| EM |$EmptyMode|)
          (|isDomain| S (|String|)) (|isDomain| SY (|Symbol|)))
         (|text| . "\\newline ") (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text| . "Enter the {\\em function} you would like to integrate:")
         (|text| . "\\newline\\tab{2} ")
         (|bcStrings| (45 "1/(x^2 + 6)" |integrand| EM))
         (|text| . "\\blankline") (|text| . "\\newline ")
         (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text| . "Enter the {\\em variable of integration}:")
         (|text| . "\\tab{37}") (|bcStrings| (10 |x| |symbol| SY))
         (|doneButton| "Continue" |bcIndefiniteIntegrateGen|)))
      (|htShowPage|)))))

; bcIndefiniteIntegrateGen htPage ==
;   integrand := htpLabelInputString(htPage,'integrand)
;   var := htpLabelInputString(htPage,'symbol)
;   bcGen STRCONC('"integrate(",integrand,'",",var,")")

(DEFUN |bcIndefiniteIntegrateGen| (|htPage|)
  (PROG (|integrand| |var|)
    (RETURN
     (PROGN
      (SETQ |integrand| (|htpLabelInputString| |htPage| '|integrand|))
      (SETQ |var| (|htpLabelInputString| |htPage| '|symbol|))
      (|bcGen| (STRCONC "integrate(" |integrand| "," |var| '|)|))))))

; bcDefiniteIntegrate() ==
;   htInitPage("Definite Integration Basic Command",nil)
;   htMakePage '(
;      (domainConditions
;        (isDomain EM $EmptyMode)
;        (isDomain S (String))
;        (isDomain SY (Symbol)))
;      (text . "\newline ")
;      (text . "\menuitemstyle{}\tab{2}")
;      (text . "Enter the {\em function} you would like to integrate:")
;      (text . "\newline\tab{2} ")
;      (bcStrings (45 "1/(x^2 + 6)" integrand EM))
;      (text . "\blankline")
;      (text . "\newline ")
;      (text . "\menuitemstyle{}\tab{2}")
;      (text . "Enter the {\em variable of integration}:")
;      (text . "\tab{37}")
;      (bcStrings (10 x symbol SY))
;      (text . "\blankline")
;      (text . "\newline ")
;      (text . "\menuitemstyle{}\tab{2}")
;      (text . "\newline Enter {\em lower limit}:")
;      (radioButtons fromButton
;        ("" "Minus infinity" minusInfinity)
;        (""  (
;          (text . "A finite point:\tab{15}")
;          (bcStrings (10 0 from EM . bcOptional))) fromPoint))
;      (text . "\blankline")
;      (text . "\newline ")
;      (text . "\menuitemstyle{}\tab{2}")
;      (text . "\indent{2}\newline Enter {\em upper limit}:")
;      (radioButtons toButton
;        ("" "Plus infinity" plusInfinity)
;        ("" (
;          (text "A finite point:\tab{15}")
;          (bcStrings (10 y to EM . bcOptional))) toPoint))
;      (doneButton "Continue" bcDefiniteIntegrateGen))
;   htShowPage()

(DEFUN |bcDefiniteIntegrate| ()
  (PROG ()
    (RETURN
     (PROGN
      (|htInitPage| '|Definite Integration Basic Command| NIL)
      (|htMakePage|
       '((|domainConditions| (|isDomain| EM |$EmptyMode|)
          (|isDomain| S (|String|)) (|isDomain| SY (|Symbol|)))
         (|text| . "\\newline ") (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text| . "Enter the {\\em function} you would like to integrate:")
         (|text| . "\\newline\\tab{2} ")
         (|bcStrings| (45 "1/(x^2 + 6)" |integrand| EM))
         (|text| . "\\blankline") (|text| . "\\newline ")
         (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text| . "Enter the {\\em variable of integration}:")
         (|text| . "\\tab{37}") (|bcStrings| (10 |x| |symbol| SY))
         (|text| . "\\blankline") (|text| . "\\newline ")
         (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text| . "\\newline Enter {\\em lower limit}:")
         (|radioButtons| |fromButton| ("" "Minus infinity" |minusInfinity|)
          (""
           ((|text| . "A finite point:\\tab{15}")
            (|bcStrings| (10 0 |from| EM . |bcOptional|)))
           |fromPoint|))
         (|text| . "\\blankline") (|text| . "\\newline ")
         (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text| . "\\indent{2}\\newline Enter {\\em upper limit}:")
         (|radioButtons| |toButton| ("" "Plus infinity" |plusInfinity|)
          (""
           ((|text| "A finite point:\\tab{15}")
            (|bcStrings| (10 |y| |to| EM . |bcOptional|)))
           |toPoint|))
         (|doneButton| "Continue" |bcDefiniteIntegrateGen|)))
      (|htShowPage|)))))

; bcDefiniteIntegrateGen htPage ==
;   integrand := htpLabelInputString(htPage,'integrand)
;   var := htpLabelInputString(htPage,'symbol)
;   lowerLimit :=
;     htpButtonValue(htPage,'fromButton) = 'fromPoint =>
;       htpLabelInputString(htPage,'from)
;     '"%minusInfinity"
;   upperLimit :=
;     htpButtonValue(htPage,'toButton) = 'toPoint =>
;       htpLabelInputString(htPage,'to)
;     '"%plusInfinity"
;   varpart := STRCONC(var,'" = ",lowerLimit,'"..",upperLimit)
;   bcGen
;    STRCONC('"integrate(",integrand,'",",varpart,'")")

(DEFUN |bcDefiniteIntegrateGen| (|htPage|)
  (PROG (|integrand| |var| |lowerLimit| |upperLimit| |varpart|)
    (RETURN
     (PROGN
      (SETQ |integrand| (|htpLabelInputString| |htPage| '|integrand|))
      (SETQ |var| (|htpLabelInputString| |htPage| '|symbol|))
      (SETQ |lowerLimit|
              (COND
               ((EQ (|htpButtonValue| |htPage| '|fromButton|) '|fromPoint|)
                (|htpLabelInputString| |htPage| '|from|))
               (#1='T "%minusInfinity")))
      (SETQ |upperLimit|
              (COND
               ((EQ (|htpButtonValue| |htPage| '|toButton|) '|toPoint|)
                (|htpLabelInputString| |htPage| '|to|))
               (#1# "%plusInfinity")))
      (SETQ |varpart| (STRCONC |var| " = " |lowerLimit| ".." |upperLimit|))
      (|bcGen| (STRCONC "integrate(" |integrand| "," |varpart| ")"))))))

; bcSum() ==
;   htInitPage("Sum Basic Command",nil)
;   htMakePage '(
;     (domainConditions
;        (isDomain EM $EmptyMode)
;        (isDomain S (String))
;        (isDomain SY (Symbol)))
;     (text . "\newline ")
;     (text . "\menuitemstyle{}\tab{2}")
;     (text . "Enter the {\em function} you would like to sum:")
;     (text . "\newline\tab{2} ")
;     (bcStrings (44 "i^3" summand EM))
;     (text . "\blankline ")
;     (text . "\newline ")
;     (text . "\menuitemstyle{}\tab{2}")
;     (text . "Enter the {\em summation index}:")
;     (text . "\tab{36}")
;     (bcStrings (10 i index SY))
;     (text . "\blankline ")
;     (text . "\newline ")
;     (text . "\menuitemstyle{}\tab{2}")
;     (text . "Enter the limits of the sum:")
;     (text . "\newline\tab{10}{\em From:}")
;     (bcStrings (10 1 first S))
;     (text . "\tab{32}{\em To:}")
;     (text . "\tab{36}")
;     (bcStrings (10  n  last S))
;     (doneButton "Continue" bcSumGen))
;   htShowPage()

(DEFUN |bcSum| ()
  (PROG ()
    (RETURN
     (PROGN
      (|htInitPage| '|Sum Basic Command| NIL)
      (|htMakePage|
       '((|domainConditions| (|isDomain| EM |$EmptyMode|)
          (|isDomain| S (|String|)) (|isDomain| SY (|Symbol|)))
         (|text| . "\\newline ") (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text| . "Enter the {\\em function} you would like to sum:")
         (|text| . "\\newline\\tab{2} ") (|bcStrings| (44 "i^3" |summand| EM))
         (|text| . "\\blankline ") (|text| . "\\newline ")
         (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text| . "Enter the {\\em summation index}:") (|text| . "\\tab{36}")
         (|bcStrings| (10 |i| |index| SY)) (|text| . "\\blankline ")
         (|text| . "\\newline ") (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text| . "Enter the limits of the sum:")
         (|text| . "\\newline\\tab{10}{\\em From:}")
         (|bcStrings| (10 1 |first| S)) (|text| . "\\tab{32}{\\em To:}")
         (|text| . "\\tab{36}") (|bcStrings| (10 |n| |last| S))
         (|doneButton| "Continue" |bcSumGen|)))
      (|htShowPage|)))))

; bcSumGen htPage ==
;   mand := htpLabelInputString(htPage,'summand)
;   index := htpLabelInputString(htPage,'index)
;   first := htpLabelInputString(htPage,'first)
;   last := htpLabelInputString(htPage,'last)
;   bcGen STRCONC('"sum(",mand,'",",index,'" = ",first,'"..",last,'")")

(DEFUN |bcSumGen| (|htPage|)
  (PROG (|mand| |index| CAR |last|)
    (RETURN
     (PROGN
      (SETQ |mand| (|htpLabelInputString| |htPage| '|summand|))
      (SETQ |index| (|htpLabelInputString| |htPage| '|index|))
      (SETQ CAR (|htpLabelInputString| |htPage| '|first|))
      (SETQ |last| (|htpLabelInputString| |htPage| '|last|))
      (|bcGen|
       (STRCONC "sum(" |mand| "," |index| " = " CAR ".." |last| ")"))))))

; bcProduct() ==
;   htInitPage("Product Basic Command",nil)
;   htMakePage '(
;     (domainConditions
;        (isDomain EM $EmptyMode)
;        (isDomain S (String))
;        (isDomain SY (Symbol)))
;     (text . "Enter the {\em function} you would like to compute the product of:")
;     (inputStrings ("" "" 45 "i^2" mand EM))
;     (text . "\vspace{1}\newline")
;     (inputStrings ("Enter the {\em index of the product}:" "" 5 i index SY))
;     (text . "\vspace{1}\newline Enter the limits of the index:")
;     (inputStrings
;       ("\newline{\em From:}" "" 10 "1" first  EM)
;       ("{\em To:}\space{2}" "" 10  "n" last   EM))
;     (doneButton "Continue" bcProductGen))
;   htShowPage()

(DEFUN |bcProduct| ()
  (PROG ()
    (RETURN
     (PROGN
      (|htInitPage| '|Product Basic Command| NIL)
      (|htMakePage|
       '((|domainConditions| (|isDomain| EM |$EmptyMode|)
          (|isDomain| S (|String|)) (|isDomain| SY (|Symbol|)))
         (|text|
          . "Enter the {\\em function} you would like to compute the product of:")
         (|inputStrings| ("" "" 45 "i^2" |mand| EM))
         (|text| . "\\vspace{1}\\newline")
         (|inputStrings|
          ("Enter the {\\em index of the product}:" "" 5 |i| |index| SY))
         (|text| . "\\vspace{1}\\newline Enter the limits of the index:")
         (|inputStrings| ("\\newline{\\em From:}" "" 10 "1" |first| EM)
          ("{\\em To:}\\space{2}" "" 10 "n" |last| EM))
         (|doneButton| "Continue" |bcProductGen|)))
      (|htShowPage|)))))

; bcProductGen htPage ==
;   mand := htpLabelInputString(htPage,'mand)
;   index := htpLabelInputString(htPage,'index)
;   first := htpLabelInputString(htPage,'first)
;   last := htpLabelInputString(htPage,'last)
;   bcGen STRCONC('"product(",mand,'",",index,'",",first,'",",last,'")")

(DEFUN |bcProductGen| (|htPage|)
  (PROG (|mand| |index| CAR |last|)
    (RETURN
     (PROGN
      (SETQ |mand| (|htpLabelInputString| |htPage| '|mand|))
      (SETQ |index| (|htpLabelInputString| |htPage| '|index|))
      (SETQ CAR (|htpLabelInputString| |htPage| '|first|))
      (SETQ |last| (|htpLabelInputString| |htPage| '|last|))
      (|bcGen|
       (STRCONC "product(" |mand| "," |index| "," CAR "," |last| ")"))))))

; bcDifferentiate() ==
;   htInitPage("Differentiate Basic Command",nil)
;   htMakePage '(
;     (domainConditions
;        (isDomain EM $EmptyMode)
;        (isDomain S (String))
;        (isDomain SY (Symbol)))
;     (text . "\newline ")
;     (text . "\menuitemstyle{}\tab{2}")
;     (text . "Enter the {\em function} you want to differentiate:")
;     (text . "\newline\tab{2} ")
;     (bcStrings (55 "sin(x*y)" diffand EM))
;     (text . "\blankline")
;     (text . "\newline ")
;     (text . "\menuitemstyle{}\tab{2}")
;     (text . "\newline List the {\em variables} you want to differentiate with respect to:")
;     (text . "\newline\tab{2} ")
;     (bcStrings (55 "x y" variables S . quoteString))
;     (text . "\blankline")
;     (text . "\newline ")
;     (text . "\menuitemstyle{}\tab{2}")
;     (text . "\newline List the number of {\em times} you want to differentiate with respect to each variable (leave blank if once for each):")
;     (text . "\newline\tab{2} ")
;     (bcStrings (55 "1 2" times S . quoteString)))
;   htMakeDoneButton('"Continue", 'bcDifferentiateGen)
;   htShowPage()

(DEFUN |bcDifferentiate| ()
  (PROG ()
    (RETURN
     (PROGN
      (|htInitPage| '|Differentiate Basic Command| NIL)
      (|htMakePage|
       '((|domainConditions| (|isDomain| EM |$EmptyMode|)
          (|isDomain| S (|String|)) (|isDomain| SY (|Symbol|)))
         (|text| . "\\newline ") (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text| . "Enter the {\\em function} you want to differentiate:")
         (|text| . "\\newline\\tab{2} ")
         (|bcStrings| (55 "sin(x*y)" |diffand| EM)) (|text| . "\\blankline")
         (|text| . "\\newline ") (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text|
          . "\\newline List the {\\em variables} you want to differentiate with respect to:")
         (|text| . "\\newline\\tab{2} ")
         (|bcStrings| (55 "x y" |variables| S . |quoteString|))
         (|text| . "\\blankline") (|text| . "\\newline ")
         (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text|
          . "\\newline List the number of {\\em times} you want to differentiate with respect to each variable (leave blank if once for each):")
         (|text| . "\\newline\\tab{2} ")
         (|bcStrings| (55 "1 2" |times| S . |quoteString|))))
      (|htMakeDoneButton| "Continue" '|bcDifferentiateGen|)
      (|htShowPage|)))))

; bcDifferentiateGen htPage ==
;   mand := htpLabelInputString(htPage,'diffand)
;   varlist := bcString2WordList htpLabelInputString(htPage,'variables)
;   indexList := bcString2WordList htpLabelInputString(htPage,'times)
;   varpart :=
;     #varlist > 1 => bcwords2liststring varlist
;     first varlist
;   indexpart :=
;     null indexList => nil
;     null rest indexList => first indexList
;     #indexList = #varlist => bcwords2liststring indexList
;     bcError '"You must say how many times you want to differentiate with respect to each variable---or leave that entry blank"
;   lastPart :=
;     indexpart => STRCONC('",",indexpart,'")")
;     '")"
;   bcGen STRCONC('"differentiate(",mand,'",",varpart,lastPart)

(DEFUN |bcDifferentiateGen| (|htPage|)
  (PROG (|mand| |varlist| |indexList| |varpart| |indexpart| |lastPart|)
    (RETURN
     (PROGN
      (SETQ |mand| (|htpLabelInputString| |htPage| '|diffand|))
      (SETQ |varlist|
              (|bcString2WordList|
               (|htpLabelInputString| |htPage| '|variables|)))
      (SETQ |indexList|
              (|bcString2WordList| (|htpLabelInputString| |htPage| '|times|)))
      (SETQ |varpart|
              (COND ((< 1 (LENGTH |varlist|)) (|bcwords2liststring| |varlist|))
                    (#1='T (CAR |varlist|))))
      (SETQ |indexpart|
              (COND ((NULL |indexList|) NIL)
                    ((NULL (CDR |indexList|)) (CAR |indexList|))
                    ((EQL (LENGTH |indexList|) (LENGTH |varlist|))
                     (|bcwords2liststring| |indexList|))
                    (#1#
                     (|bcError|
                      "You must say how many times you want to differentiate with respect to each variable---or leave that entry blank"))))
      (SETQ |lastPart|
              (COND (|indexpart| (STRCONC "," |indexpart| ")")) (#1# ")")))
      (|bcGen| (STRCONC "differentiate(" |mand| "," |varpart| |lastPart|))))))

; bcDraw() ==
;   htInitPage('"Draw Basic Command",nil)
;   bcHt '"What would you like to draw?"
;   bcHt '"\newline\centerline{{\em Two Dimensional Plots}}\newline"
;   bcHt '"\lispdownlink{A function of one variable}{(|bcDraw2Dfun|)}"
;   bcHt '"\space{2}y = f(x)\newline"
;   bcHt '"\lispdownlink{A parametrically defined curve}{(|bcDraw2Dpar|)}"
;   bcHt '"\space{2}(x(t), y(t))\newline"
;   bcHt '"\lispdownlink{A solution to a polynomial equation}{(|bcDraw2DSolve|)}"
;   bcHt '"\space{2} p(x,y) = 0\newline"
;   bcHt '"\vspace{1}\newline "
;   bcHt '"\centerline{{\em Three Dimensional Surfaces}}\newline\newline"
;   bcHt '"\lispdownlink{A function of two variables}{(|bcDraw3Dfun|)}"
;   bcHt '"\space{2} z = f(x,y)\newline"
;   bcHt '"\lispdownlink{A parametrically defined tube}{(|bcDraw3Dpar|)}"
;   bcHt '"\space{2}(x(t), y(t), z(t))\newline"
;   bcHt '"\lispdownlink{A parameterically defined surface}{(|bcDraw3Dpar1|)}"
;   bcHt '"\space{2}(x(u,v), y(u,v), z(u,v))\newline"
;   htShowPage()

(DEFUN |bcDraw| ()
  (PROG ()
    (RETURN
     (PROGN
      (|htInitPage| "Draw Basic Command" NIL)
      (|bcHt| "What would you like to draw?")
      (|bcHt| "\\newline\\centerline{{\\em Two Dimensional Plots}}\\newline")
      (|bcHt| "\\lispdownlink{A function of one variable}{(|bcDraw2Dfun|)}")
      (|bcHt| "\\space{2}y = f(x)\\newline")
      (|bcHt|
       "\\lispdownlink{A parametrically defined curve}{(|bcDraw2Dpar|)}")
      (|bcHt| "\\space{2}(x(t), y(t))\\newline")
      (|bcHt|
       "\\lispdownlink{A solution to a polynomial equation}{(|bcDraw2DSolve|)}")
      (|bcHt| "\\space{2} p(x,y) = 0\\newline")
      (|bcHt| "\\vspace{1}\\newline ")
      (|bcHt|
       "\\centerline{{\\em Three Dimensional Surfaces}}\\newline\\newline")
      (|bcHt| "\\lispdownlink{A function of two variables}{(|bcDraw3Dfun|)}")
      (|bcHt| "\\space{2} z = f(x,y)\\newline")
      (|bcHt| "\\lispdownlink{A parametrically defined tube}{(|bcDraw3Dpar|)}")
      (|bcHt| "\\space{2}(x(t), y(t), z(t))\\newline")
      (|bcHt|
       "\\lispdownlink{A parameterically defined surface}{(|bcDraw3Dpar1|)}")
      (|bcHt| "\\space{2}(x(u,v), y(u,v), z(u,v))\\newline")
      (|htShowPage|)))))

; bcDraw2Dfun() ==
;   htInitPage('"Draw Basic Command",nil)
;   htMakePage '(
;     (domainConditions
;        (isDomain EM $EmptyMode)
;        (isDomain F (Float))
;        (isDomain SY (Symbol)))
;     (text
;       "\centerline{Drawing {\em y = f(x)}}\newline "
;       "\centerline{where {\em y} is the dependent variable and}\newline "
;       "\centerline{where {\em x} is the independent variable}\vspace{1}\newline "
;       "\menuitemstyle{}\tab{2}What {\em function} f would you like to draw?\newline\tab{2}")
;     (bcStrings (55 "x*cos(x)" function EM))
;     (text . "\vspace{1}\newline\menuitemstyle{}\tab{2}Enter {\em dependent} variable:")
;     (bcStrings (6 y dependent SY))
;     (text . "\newline\vspace{1}\newline ")
;     (text . "\menuitemstyle{}\tab{2}Enter {\em independent} variable and {\em range}:\newline\tab{2} ")
;     (text . "{\em Variable:}")
;     (bcStrings (6 x ind SY))
;     (text . "ranges {\em from:}")
;     (bcStrings (9 0 from1 F))
;     (text . "{\em to:}")
;     (bcStrings (9 30 to1 F))
;     (text
;       "\indent{0}\vspace{1}\newline\menuitemstyle{}\tab{2} "
;       "Optionally enter a {\em title} for your curve:"
;       )
;     (bcStrings (15 "y = x*cos(x)" title S))
;     (text . "\indent{0}")
;     (doneButton "Continue" bcDraw2DfunGen)
;     (text . "{}"))
;   htShowPage()

(DEFUN |bcDraw2Dfun| ()
  (PROG ()
    (RETURN
     (PROGN
      (|htInitPage| "Draw Basic Command" NIL)
      (|htMakePage|
       '((|domainConditions| (|isDomain| EM |$EmptyMode|)
          (|isDomain| F (|Float|)) (|isDomain| SY (|Symbol|)))
         (|text| "\\centerline{Drawing {\\em y = f(x)}}\\newline "
          "\\centerline{where {\\em y} is the dependent variable and}\\newline "
          "\\centerline{where {\\em x} is the independent variable}\\vspace{1}\\newline "
          "\\menuitemstyle{}\\tab{2}What {\\em function} f would you like to draw?\\newline\\tab{2}")
         (|bcStrings| (55 "x*cos(x)" |function| EM))
         (|text|
          . "\\vspace{1}\\newline\\menuitemstyle{}\\tab{2}Enter {\\em dependent} variable:")
         (|bcStrings| (6 |y| |dependent| SY))
         (|text| . "\\newline\\vspace{1}\\newline ")
         (|text|
          . "\\menuitemstyle{}\\tab{2}Enter {\\em independent} variable and {\\em range}:\\newline\\tab{2} ")
         (|text| . "{\\em Variable:}") (|bcStrings| (6 |x| |ind| SY))
         (|text| . "ranges {\\em from:}") (|bcStrings| (9 0 |from1| F))
         (|text| . "{\\em to:}") (|bcStrings| (9 30 |to1| F))
         (|text| "\\indent{0}\\vspace{1}\\newline\\menuitemstyle{}\\tab{2} "
          "Optionally enter a {\\em title} for your curve:")
         (|bcStrings| (15 "y = x*cos(x)" |title| S)) (|text| . "\\indent{0}")
         (|doneButton| "Continue" |bcDraw2DfunGen|) (|text| . "{}")))
      (|htShowPage|)))))

; bcDraw2DfunGen htPage ==
;   fun := htpLabelInputString(htPage,'function)
;   dep := htpLabelInputString(htPage,'dependent)
;   ind := htpLabelInputString(htPage,'ind)
;   from1 := htpLabelInputString(htPage,'from1)
;   to1 := htpLabelInputString(htPage,'to1)
;   title := htpLabelInputString(htPage,'title)
;   if (title ~= '"") then
;     titlePart := STRCONC('"{}",'"title ==_"",title,'"_"")
;     bcFinish('"draw",fun,bcDrawIt2(ind,from1,to1),titlePart)
;   else
;     bcFinish('"draw",fun,bcDrawIt2(ind,from1,to1))

(DEFUN |bcDraw2DfunGen| (|htPage|)
  (PROG (|fun| |dep| |ind| |from1| |to1| |title| |titlePart|)
    (RETURN
     (PROGN
      (SETQ |fun| (|htpLabelInputString| |htPage| '|function|))
      (SETQ |dep| (|htpLabelInputString| |htPage| '|dependent|))
      (SETQ |ind| (|htpLabelInputString| |htPage| '|ind|))
      (SETQ |from1| (|htpLabelInputString| |htPage| '|from1|))
      (SETQ |to1| (|htpLabelInputString| |htPage| '|to1|))
      (SETQ |title| (|htpLabelInputString| |htPage| '|title|))
      (COND
       ((NOT (EQUAL |title| ""))
        (SETQ |titlePart| (STRCONC "{}" "title ==\"" |title| "\""))
        (|bcFinish| "draw" |fun| (|bcDrawIt2| |ind| |from1| |to1|)
         |titlePart|))
       ('T (|bcFinish| "draw" |fun| (|bcDrawIt2| |ind| |from1| |to1|))))))))

; bcDraw2Dpar() ==
;   htInitPage('"Draw Basic Command",nil)
;   htMakePage '(
;     (domainConditions
;        (isDomain EM $EmptyMode)
;        (isDomain F (Float))
;        (isDomain SY (Symbol)))
;     (text
;       "\centerline{Drawing a parametrically defined curve:}\newline "
;       "\centerline{{\em ( f1(t), f2(t) )}}\newline "
;       "\centerline{in terms of two functions {\em f1} and {\em f2}}"
;       "\centerline{and an independent variable {\em t}}\vspace{1}\newline"
;       "\menuitemstyle{}\tab{2}Enter the two {\em functions:}")
;     (text . "\newline\tab{2}{\em Function 1:}")
;     (bcStrings (44 "-9*sin(4*t/5)" function1 EM))
;     (text . "\newline\tab{2}{\em Function 2:}")
;     (bcStrings (44 "8*sin(t)" function2 EM))
;     (text ."\vspace{1}\newline\menuitemstyle{}\tab{2}Enter {\em independent} variable and range:\newline\tab{2} ")
;     (text . "{\em Variable:}")
;     (bcStrings (6 t ind SY))
;     (text . "ranges {\em from:}")
;     (bcStrings (9 "-5*\%pi" from1 F))
;     (text . "{\em to:}")
;     (bcStrings (9 "5*\%pi" to1 F))
;     (text
;       "\vspace{1}\newline\menuitemstyle{}\tab{2}"
;       "Optionally enter a {\em title} for your curve:")
;     (bcStrings (15 "Lissajous" title S))
;     (text . "\indent{0}")
;     (doneButton "Continue" bcDraw2DparGen))
;   htShowPage()

(DEFUN |bcDraw2Dpar| ()
  (PROG ()
    (RETURN
     (PROGN
      (|htInitPage| "Draw Basic Command" NIL)
      (|htMakePage|
       '((|domainConditions| (|isDomain| EM |$EmptyMode|)
          (|isDomain| F (|Float|)) (|isDomain| SY (|Symbol|)))
         (|text|
          "\\centerline{Drawing a parametrically defined curve:}\\newline "
          "\\centerline{{\\em ( f1(t), f2(t) )}}\\newline "
          "\\centerline{in terms of two functions {\\em f1} and {\\em f2}}"
          "\\centerline{and an independent variable {\\em t}}\\vspace{1}\\newline"
          "\\menuitemstyle{}\\tab{2}Enter the two {\\em functions:}")
         (|text| . "\\newline\\tab{2}{\\em Function 1:}")
         (|bcStrings| (44 "-9*sin(4*t/5)" |function1| EM))
         (|text| . "\\newline\\tab{2}{\\em Function 2:}")
         (|bcStrings| (44 "8*sin(t)" |function2| EM))
         (|text|
          . "\\vspace{1}\\newline\\menuitemstyle{}\\tab{2}Enter {\\em independent} variable and range:\\newline\\tab{2} ")
         (|text| . "{\\em Variable:}") (|bcStrings| (6 |t| |ind| SY))
         (|text| . "ranges {\\em from:}")
         (|bcStrings| (9 "-5*\\%pi" |from1| F)) (|text| . "{\\em to:}")
         (|bcStrings| (9 "5*\\%pi" |to1| F))
         (|text| "\\vspace{1}\\newline\\menuitemstyle{}\\tab{2}"
          "Optionally enter a {\\em title} for your curve:")
         (|bcStrings| (15 "Lissajous" |title| S)) (|text| . "\\indent{0}")
         (|doneButton| "Continue" |bcDraw2DparGen|)))
      (|htShowPage|)))))

; bcDraw2DparGen htPage ==
;   fun1 := htpLabelInputString(htPage,'function1)
;   fun2 := htpLabelInputString(htPage,'function2)
;   ind := htpLabelInputString(htPage,'ind)
;   from1 := htpLabelInputString(htPage,'from1)
;   to1 := htpLabelInputString(htPage,'to1)
;   title := htpLabelInputString(htPage,'title)
;   curvePart := STRCONC('"curve(",'"{}",fun1,'",{}",fun2,'")")
;   if (title ~= '"") then
;     titlePart := (title = '"" => nil; STRCONC('"{}",'"title ==_"",title,'"_""))
;     bcFinish('"draw",curvePart,bcDrawIt2(ind,from1,to1),titlePart)
;   else
;     bcFinish('"draw",curvePart,bcDrawIt2(ind,from1,to1))

(DEFUN |bcDraw2DparGen| (|htPage|)
  (PROG (|fun1| |fun2| |ind| |from1| |to1| |title| |curvePart| |titlePart|)
    (RETURN
     (PROGN
      (SETQ |fun1| (|htpLabelInputString| |htPage| '|function1|))
      (SETQ |fun2| (|htpLabelInputString| |htPage| '|function2|))
      (SETQ |ind| (|htpLabelInputString| |htPage| '|ind|))
      (SETQ |from1| (|htpLabelInputString| |htPage| '|from1|))
      (SETQ |to1| (|htpLabelInputString| |htPage| '|to1|))
      (SETQ |title| (|htpLabelInputString| |htPage| '|title|))
      (SETQ |curvePart| (STRCONC "curve(" "{}" |fun1| ",{}" |fun2| ")"))
      (COND
       ((NOT (EQUAL |title| ""))
        (SETQ |titlePart|
                (COND ((EQUAL |title| "") NIL)
                      (#1='T (STRCONC "{}" "title ==\"" |title| "\""))))
        (|bcFinish| "draw" |curvePart| (|bcDrawIt2| |ind| |from1| |to1|)
         |titlePart|))
       (#1#
        (|bcFinish| "draw" |curvePart| (|bcDrawIt2| |ind| |from1| |to1|))))))))

; bcDraw2DSolve() ==
;   htInitPage('"Draw Basic Command",nil)
;   htMakePage '(
;     (domainConditions
;        (isDomain EM $EmptyMode)
;        (isDomain F (Float))
;        (isDomain SY (Symbol)))
;     (text
;       "\centerline{Plotting the solution to {\em p(x,y) = 0}, where} "
;       "\centerline{{\em p} is a polynomial in two variables {\em x} and {\em y}}"
;       "\vspace{1}\newline\menuitemstyle{}\tab{2}Enter the {\em polynomial} p:"
;       "\newline\tab{2}")
;     (bcStrings (40 "y^2+7*x*y-(x^3+16*x)" function EM))
;     (text . "\vspace{1}\newline\menuitemstyle{}\tab{2}Enter the {\em variables}:")
;     (text . "\newline\tab{2}{\em Variable 1:} ")
;     (bcStrings (4 x independent1 SY))
;     (text . "ranges {\em from:}")
;     (bcStrings (9 -15 from1 F))
;     (text . "{\em to:}")
;     (bcStrings (9 10 to1 F))
;     (text . "\newline\tab{2}{\em Variable 2:} ")
;     (bcStrings (4 y independent2 SY))
;     (text . "ranges {\em from:}")
;     (bcStrings (9 -10 from2 F))
;     (text . "{\em to:}")
;     (bcStrings (9 50 to2 F))
;     (text
;       "\indent{0}\vspace{1}\newline\menuitemstyle{}\tab{2} "
;       "Optionally enter a {\em title} for your curve:")
;     (bcStrings (15 "" title S))
;     (text . "\indent{0}"))
;   htMakeDoneButton('"Continue",'bcDraw2DSolveGen)
;   htShowPage()

(DEFUN |bcDraw2DSolve| ()
  (PROG ()
    (RETURN
     (PROGN
      (|htInitPage| "Draw Basic Command" NIL)
      (|htMakePage|
       '((|domainConditions| (|isDomain| EM |$EmptyMode|)
          (|isDomain| F (|Float|)) (|isDomain| SY (|Symbol|)))
         (|text|
          "\\centerline{Plotting the solution to {\\em p(x,y) = 0}, where} "
          "\\centerline{{\\em p} is a polynomial in two variables {\\em x} and {\\em y}}"
          "\\vspace{1}\\newline\\menuitemstyle{}\\tab{2}Enter the {\\em polynomial} p:"
          "\\newline\\tab{2}")
         (|bcStrings| (40 "y^2+7*x*y-(x^3+16*x)" |function| EM))
         (|text|
          . "\\vspace{1}\\newline\\menuitemstyle{}\\tab{2}Enter the {\\em variables}:")
         (|text| . "\\newline\\tab{2}{\\em Variable 1:} ")
         (|bcStrings| (4 |x| |independent1| SY))
         (|text| . "ranges {\\em from:}") (|bcStrings| (9 -15 |from1| F))
         (|text| . "{\\em to:}") (|bcStrings| (9 10 |to1| F))
         (|text| . "\\newline\\tab{2}{\\em Variable 2:} ")
         (|bcStrings| (4 |y| |independent2| SY))
         (|text| . "ranges {\\em from:}") (|bcStrings| (9 -10 |from2| F))
         (|text| . "{\\em to:}") (|bcStrings| (9 50 |to2| F))
         (|text| "\\indent{0}\\vspace{1}\\newline\\menuitemstyle{}\\tab{2} "
          "Optionally enter a {\\em title} for your curve:")
         (|bcStrings| (15 "" |title| S)) (|text| . "\\indent{0}")))
      (|htMakeDoneButton| "Continue" '|bcDraw2DSolveGen|)
      (|htShowPage|)))))

; bcDraw2DSolveGen htPage ==
;   fun := htpLabelInputString(htPage,'function)
;   ind1 := htpLabelInputString(htPage,'independent1)
;   from1 := htpLabelInputString(htPage,'from1)
;   to1 := htpLabelInputString(htPage,'to1)
;   ind2 := htpLabelInputString(htPage,'independent2)
;   from2 := htpLabelInputString(htPage,'from2)
;   to2 := htpLabelInputString(htPage,'to2)
;   title := htpLabelInputString(htPage,'title)
;   clipPart := STRCONC('"{}",'"range==[{}",from1,'"..",to1,",{}",from2,'"..",to2,'"]")
;   if (title ~= '"") then
;     titlePart := (title = '"" => nil; STRCONC('"{}",'"title ==_"",title,'"_""))
;     bcFinish('"draw",STRCONC(fun,'" = 0 "),ind1,ind2,clipPart,titlePart)
;   else
;     bcFinish('"draw",STRCONC(fun,'" = 0 "),ind1,ind2,clipPart)

(DEFUN |bcDraw2DSolveGen| (|htPage|)
  (PROG (|fun| |ind1| |from1| |to1| |ind2| |from2| |to2| |title| |clipPart|
         |titlePart|)
    (RETURN
     (PROGN
      (SETQ |fun| (|htpLabelInputString| |htPage| '|function|))
      (SETQ |ind1| (|htpLabelInputString| |htPage| '|independent1|))
      (SETQ |from1| (|htpLabelInputString| |htPage| '|from1|))
      (SETQ |to1| (|htpLabelInputString| |htPage| '|to1|))
      (SETQ |ind2| (|htpLabelInputString| |htPage| '|independent2|))
      (SETQ |from2| (|htpLabelInputString| |htPage| '|from2|))
      (SETQ |to2| (|htpLabelInputString| |htPage| '|to2|))
      (SETQ |title| (|htpLabelInputString| |htPage| '|title|))
      (SETQ |clipPart|
              (STRCONC "{}" "range==[{}" |from1| ".." |to1| '|,{}| |from2| ".."
               |to2| "]"))
      (COND
       ((NOT (EQUAL |title| ""))
        (SETQ |titlePart|
                (COND ((EQUAL |title| "") NIL)
                      (#1='T (STRCONC "{}" "title ==\"" |title| "\""))))
        (|bcFinish| "draw" (STRCONC |fun| " = 0 ") |ind1| |ind2| |clipPart|
         |titlePart|))
       (#1#
        (|bcFinish| "draw" (STRCONC |fun| " = 0 ") |ind1| |ind2|
         |clipPart|)))))))

; bcDraw3Dfun() ==
;   htInitPage('"Three Dimensional Draw Basic Command",nil)
;   htMakePage '(
;     (domainConditions
;        (isDomain EM $EmptyMode)
;        (isDomain F (Float))
;        (isDomain SY (Symbol)))
;     (text
;       "\centerline{Drawing {\em z = f(x,y)}}\newline "
;       "\centerline{where {\em z} is the dependent variable and}\newline "
;       "\centerline{where {\em x, y} are the independent variables}\vspace{1}\newline\menuitemstyle{}\tab{2} "
;       "What {\em function} f which you like to draw?\newline\tab{2}")
;     (bcStrings (55 "exp(cos(x-y)-sin(x*y))-2" function EM))
;     (text . "\newline\menuitemstyle{}\tab{2}Enter {\em dependent} variable:")
;     (bcStrings (6 z dependent SY))
;     (text
;       "\vspace{1}\newline\menuitemstyle{}\tab{2}"
;       "Enter {\em independent} variables and ranges:\newline\tab{2} "
;       "{\em Variable:}")
;     (bcStrings (6 x independent1 SY))
;     (text . "ranges {\em from:}")
;     (bcStrings (9 -5 from1 F))
;     (text . "{\em to:}")
;     (bcStrings (9 5 to1 F))
;     (text . "\newline\tab{2}{\em Variable:}")
;     (bcStrings (6 y independent2 SY))
;     (text . "ranges {\em from:}")
;     (bcStrings (9 -5 from2 F))
;     (text . "{\em to:}")
;     (bcStrings (9 5 to2 F))
;     (text
;       "\indent{0}\vspace{1}\newline\menuitemstyle{}\tab{2} "
;       "Optionally enter a {\em title} for your surface:")
;     (bcStrings (15 "" title S))
;     (text . "\indent{0}")
;     (doneButton "Continue" bcDraw3DfunGen))
;   htShowPage()

(DEFUN |bcDraw3Dfun| ()
  (PROG ()
    (RETURN
     (PROGN
      (|htInitPage| "Three Dimensional Draw Basic Command" NIL)
      (|htMakePage|
       '((|domainConditions| (|isDomain| EM |$EmptyMode|)
          (|isDomain| F (|Float|)) (|isDomain| SY (|Symbol|)))
         (|text| "\\centerline{Drawing {\\em z = f(x,y)}}\\newline "
          "\\centerline{where {\\em z} is the dependent variable and}\\newline "
          "\\centerline{where {\\em x, y} are the independent variables}\\vspace{1}\\newline\\menuitemstyle{}\\tab{2} "
          "What {\\em function} f which you like to draw?\\newline\\tab{2}")
         (|bcStrings| (55 "exp(cos(x-y)-sin(x*y))-2" |function| EM))
         (|text|
          . "\\newline\\menuitemstyle{}\\tab{2}Enter {\\em dependent} variable:")
         (|bcStrings| (6 |z| |dependent| SY))
         (|text| "\\vspace{1}\\newline\\menuitemstyle{}\\tab{2}"
          "Enter {\\em independent} variables and ranges:\\newline\\tab{2} "
          "{\\em Variable:}")
         (|bcStrings| (6 |x| |independent1| SY))
         (|text| . "ranges {\\em from:}") (|bcStrings| (9 -5 |from1| F))
         (|text| . "{\\em to:}") (|bcStrings| (9 5 |to1| F))
         (|text| . "\\newline\\tab{2}{\\em Variable:}")
         (|bcStrings| (6 |y| |independent2| SY))
         (|text| . "ranges {\\em from:}") (|bcStrings| (9 -5 |from2| F))
         (|text| . "{\\em to:}") (|bcStrings| (9 5 |to2| F))
         (|text| "\\indent{0}\\vspace{1}\\newline\\menuitemstyle{}\\tab{2} "
          "Optionally enter a {\\em title} for your surface:")
         (|bcStrings| (15 "" |title| S)) (|text| . "\\indent{0}")
         (|doneButton| "Continue" |bcDraw3DfunGen|)))
      (|htShowPage|)))))

; bcDraw3DfunGen htPage ==
;   fun := htpLabelInputString(htPage,'function)
;   dep := htpLabelInputString(htPage,'dependent)
;   ind1 := htpLabelInputString(htPage,'independent1)
;   from1 := htpLabelInputString(htPage,'from1)
;   to1 := htpLabelInputString(htPage,'to1)
;   ind2 := htpLabelInputString(htPage,'independent2)
;   from2 := htpLabelInputString(htPage,'from2)
;   to2 := htpLabelInputString(htPage,'to2)
;   title := htpLabelInputString(htPage,'title)
;   if (title ~= '"") then
;     titlePart := (title = '"" => nil;STRCONC('"{}",'"title ==_"",title,'"_""))
;     bcFinish('"draw",fun,bcDrawIt2(ind1,from1,to1),bcDrawIt2(ind2,from2,to2),titlePart)
;   else
;     bcFinish('"draw",fun,bcDrawIt2(ind1,from1,to1),bcDrawIt2(ind2,from2,to2))

(DEFUN |bcDraw3DfunGen| (|htPage|)
  (PROG (|fun| |dep| |ind1| |from1| |to1| |ind2| |from2| |to2| |title|
         |titlePart|)
    (RETURN
     (PROGN
      (SETQ |fun| (|htpLabelInputString| |htPage| '|function|))
      (SETQ |dep| (|htpLabelInputString| |htPage| '|dependent|))
      (SETQ |ind1| (|htpLabelInputString| |htPage| '|independent1|))
      (SETQ |from1| (|htpLabelInputString| |htPage| '|from1|))
      (SETQ |to1| (|htpLabelInputString| |htPage| '|to1|))
      (SETQ |ind2| (|htpLabelInputString| |htPage| '|independent2|))
      (SETQ |from2| (|htpLabelInputString| |htPage| '|from2|))
      (SETQ |to2| (|htpLabelInputString| |htPage| '|to2|))
      (SETQ |title| (|htpLabelInputString| |htPage| '|title|))
      (COND
       ((NOT (EQUAL |title| ""))
        (SETQ |titlePart|
                (COND ((EQUAL |title| "") NIL)
                      (#1='T (STRCONC "{}" "title ==\"" |title| "\""))))
        (|bcFinish| "draw" |fun| (|bcDrawIt2| |ind1| |from1| |to1|)
         (|bcDrawIt2| |ind2| |from2| |to2|) |titlePart|))
       (#1#
        (|bcFinish| "draw" |fun| (|bcDrawIt2| |ind1| |from1| |to1|)
         (|bcDrawIt2| |ind2| |from2| |to2|))))))))

; bcDraw3Dpar() ==
;   htInitPage('"Draw Basic Command",nil)
;   htMakePage '(
;     (domainConditions
;        (isDomain EM $EmptyMode)
;        (isDomain F (Float))
;        (isDomain SY (Symbol)))
;     (text
;       "\centerline{Drawing a parametrically defined curve:"
;       "{\em ( f1(t), f2(t), f3(t) )}}\newline "
;       "\centerline{in terms of three functions {\em f1}, {\em f2}, and {\em f3}}\newline "
;       "\centerline{and an independent variable {\em t}}\vspace{1}\newline\menuitemstyle{}\tab{2} "
;       "Enter the three {\em functions} of the independent variable:")
;     (text . "\newline\tab{2}{\em Function f1:}")
;     (bcStrings (42 "1.3*cos(2*t)*cos(4*t) + sin(4*t)*cos(t)" function1 EM))
;     (text . "\newline\tab{2}{\em Function f2:}")
;     (bcStrings  (42 "1.3*sin(2*t)*cos(4*t) - sin(4*t)*sin(t)" function2 EM))
;     (text . "\newline\tab{2}{\em Function f3:}")
;     (bcStrings  (42 "2.5*cos(4*t)" function3 EM))
;     (text ."\vspace{1}\newline\menuitemstyle{}\tab{2}Enter {\em independent} variable and range:\newline\tab{2} ")
;     (text ."{\em Variable:}")
;     (bcStrings (6 t ind SY))
;     (text . "ranges {\em from:}")
;     (bcStrings (9 0 from1 F))
;     (text "{\em to:}")
;     (bcStrings (9 "4*\%pi" to1 F))
;     (text
;       "\indent{0}\vspace{1}\newline\menuitemstyle{}\tab{2} "
;       "Optionally enter a {\em title} for your surface:")
;     (bcStrings (15 "knot" title S))
;     (text . "\indent{0}")
;     (doneButton "Continue" bcDraw3DparGen))
;   htShowPage()

(DEFUN |bcDraw3Dpar| ()
  (PROG ()
    (RETURN
     (PROGN
      (|htInitPage| "Draw Basic Command" NIL)
      (|htMakePage|
       '((|domainConditions| (|isDomain| EM |$EmptyMode|)
          (|isDomain| F (|Float|)) (|isDomain| SY (|Symbol|)))
         (|text| "\\centerline{Drawing a parametrically defined curve:"
          "{\\em ( f1(t), f2(t), f3(t) )}}\\newline "
          "\\centerline{in terms of three functions {\\em f1}, {\\em f2}, and {\\em f3}}\\newline "
          "\\centerline{and an independent variable {\\em t}}\\vspace{1}\\newline\\menuitemstyle{}\\tab{2} "
          "Enter the three {\\em functions} of the independent variable:")
         (|text| . "\\newline\\tab{2}{\\em Function f1:}")
         (|bcStrings|
          (42 "1.3*cos(2*t)*cos(4*t) + sin(4*t)*cos(t)" |function1| EM))
         (|text| . "\\newline\\tab{2}{\\em Function f2:}")
         (|bcStrings|
          (42 "1.3*sin(2*t)*cos(4*t) - sin(4*t)*sin(t)" |function2| EM))
         (|text| . "\\newline\\tab{2}{\\em Function f3:}")
         (|bcStrings| (42 "2.5*cos(4*t)" |function3| EM))
         (|text|
          . "\\vspace{1}\\newline\\menuitemstyle{}\\tab{2}Enter {\\em independent} variable and range:\\newline\\tab{2} ")
         (|text| . "{\\em Variable:}") (|bcStrings| (6 |t| |ind| SY))
         (|text| . "ranges {\\em from:}") (|bcStrings| (9 0 |from1| F))
         (|text| "{\\em to:}") (|bcStrings| (9 "4*\\%pi" |to1| F))
         (|text| "\\indent{0}\\vspace{1}\\newline\\menuitemstyle{}\\tab{2} "
          "Optionally enter a {\\em title} for your surface:")
         (|bcStrings| (15 "knot" |title| S)) (|text| . "\\indent{0}")
         (|doneButton| "Continue" |bcDraw3DparGen|)))
      (|htShowPage|)))))

; bcDraw3DparGen htPage ==
;   fun1 := htpLabelInputString(htPage,'function1)
;   fun2 := htpLabelInputString(htPage,'function2)
;   fun3 := htpLabelInputString(htPage,'function3)
;   ind := htpLabelInputString(htPage,'ind)
;   from1 := htpLabelInputString(htPage,'from1)
;   to1 := htpLabelInputString(htPage,'to1)
;   title := htpLabelInputString(htPage,'title)
;   curvePart := STRCONC('"curve(",'"{}",fun1,'",{}",fun2,'",{}",fun3,'")")
;   tubePart := '"{}tubeRadius==.25,{}tubePoints==16"
;   if (title ~= '"") then
;     titlePart := (title = '"" => nil; STRCONC('"{}",'"title ==_"",title,'"_""))
;     bcFinish('"draw",curvePart,bcDrawIt2(ind,from1,to1),tubePart,titlePart)
;   else
;     bcFinish('"draw",curvePart,bcDrawIt2(ind,from1,to1),tubePart)

(DEFUN |bcDraw3DparGen| (|htPage|)
  (PROG (|fun1| |fun2| |fun3| |ind| |from1| |to1| |title| |curvePart|
         |tubePart| |titlePart|)
    (RETURN
     (PROGN
      (SETQ |fun1| (|htpLabelInputString| |htPage| '|function1|))
      (SETQ |fun2| (|htpLabelInputString| |htPage| '|function2|))
      (SETQ |fun3| (|htpLabelInputString| |htPage| '|function3|))
      (SETQ |ind| (|htpLabelInputString| |htPage| '|ind|))
      (SETQ |from1| (|htpLabelInputString| |htPage| '|from1|))
      (SETQ |to1| (|htpLabelInputString| |htPage| '|to1|))
      (SETQ |title| (|htpLabelInputString| |htPage| '|title|))
      (SETQ |curvePart|
              (STRCONC "curve(" "{}" |fun1| ",{}" |fun2| ",{}" |fun3| ")"))
      (SETQ |tubePart| "{}tubeRadius==.25,{}tubePoints==16")
      (COND
       ((NOT (EQUAL |title| ""))
        (SETQ |titlePart|
                (COND ((EQUAL |title| "") NIL)
                      (#1='T (STRCONC "{}" "title ==\"" |title| "\""))))
        (|bcFinish| "draw" |curvePart| (|bcDrawIt2| |ind| |from1| |to1|)
         |tubePart| |titlePart|))
       (#1#
        (|bcFinish| "draw" |curvePart| (|bcDrawIt2| |ind| |from1| |to1|)
         |tubePart|)))))))

; bcDraw3Dpar1() ==
;   htInitPage('"Draw Basic Command",nil)
;   htMakePage '(
;     (domainConditions
;        (isDomain EM $EmptyMode)
;        (isDomain F (Float))
;        (isDomain SY (Symbol)))
;     (text
;       "\centerline{Drawing a parametrically defined surface:}\newline "
;       "\centerline{{\em ( f1(u,v), f2(u,v), f3(u,v) )}}\newline "
;       "\centerline{in terms of three functions {\em f1}, {\em f2}, and {\em f3}}\newline "
;       "\centerline{and two independent variables {\em u} and {\em v}}\vspace{1}\newline\menuitemstyle{}\tab{2}"
;       "Enter the three {\em functions} of the independent variables:")
;     (text . "\newline\tab{2}")
;     (text . "{\em Function f1:}")
;     (bcStrings (43 "u*sin(v)" function1 EM))
;     (text . "\newline\tab{2}")
;     (text . "{\em Function f2:}")
;     (bcStrings (43 "v*cos(u)" function2 EM))
;     (text . "\newline\tab{2}")
;     (text . "{\em Function f3:}")
;     (bcStrings (43 "u*cos(v)" function3 EM))
;     (text . "\newline\menuitemstyle{}\tab{2}Enter independent {\em variables} and ranges:")
;     (text . "\newline\tab{2}")
;     (text . "{\em Variable 1:}")
;     (bcStrings (5 u ind1 SY))
;     (text . "ranges {\em from:}")
;     (bcStrings (9 "-\%pi" from1 F))
;     (text . "{\em to:}")
;     (bcStrings (9 "\%pi" to1 F))
;     (text . "\newline\tab{2}")
;     (text . "{\em Variable 2:}")
;     (bcStrings (5 v ind2 SY))
;     (text . "ranges {\em from:}")
;     (bcStrings (9 "-\%pi/2" from2 F))
;     (text . "{\em to:}")
;     (bcStrings (9 "\%pi/2" to2 F))
;     (text
;       "\indent{0}\newline\menuitemstyle{}\tab{2} "
;       "Optionally enter a {\em title} for your surface:")
;     (bcStrings (15 "surface" title S))
;     (text . "\indent{0}"))
;   htMakeDoneButton ('"Continue",'bcDraw3Dpar1Gen)
;   htShowPage()

(DEFUN |bcDraw3Dpar1| ()
  (PROG ()
    (RETURN
     (PROGN
      (|htInitPage| "Draw Basic Command" NIL)
      (|htMakePage|
       '((|domainConditions| (|isDomain| EM |$EmptyMode|)
          (|isDomain| F (|Float|)) (|isDomain| SY (|Symbol|)))
         (|text|
          "\\centerline{Drawing a parametrically defined surface:}\\newline "
          "\\centerline{{\\em ( f1(u,v), f2(u,v), f3(u,v) )}}\\newline "
          "\\centerline{in terms of three functions {\\em f1}, {\\em f2}, and {\\em f3}}\\newline "
          "\\centerline{and two independent variables {\\em u} and {\\em v}}\\vspace{1}\\newline\\menuitemstyle{}\\tab{2}"
          "Enter the three {\\em functions} of the independent variables:")
         (|text| . "\\newline\\tab{2}") (|text| . "{\\em Function f1:}")
         (|bcStrings| (43 "u*sin(v)" |function1| EM))
         (|text| . "\\newline\\tab{2}") (|text| . "{\\em Function f2:}")
         (|bcStrings| (43 "v*cos(u)" |function2| EM))
         (|text| . "\\newline\\tab{2}") (|text| . "{\\em Function f3:}")
         (|bcStrings| (43 "u*cos(v)" |function3| EM))
         (|text|
          . "\\newline\\menuitemstyle{}\\tab{2}Enter independent {\\em variables} and ranges:")
         (|text| . "\\newline\\tab{2}") (|text| . "{\\em Variable 1:}")
         (|bcStrings| (5 |u| |ind1| SY)) (|text| . "ranges {\\em from:}")
         (|bcStrings| (9 "-\\%pi" |from1| F)) (|text| . "{\\em to:}")
         (|bcStrings| (9 "\\%pi" |to1| F)) (|text| . "\\newline\\tab{2}")
         (|text| . "{\\em Variable 2:}") (|bcStrings| (5 |v| |ind2| SY))
         (|text| . "ranges {\\em from:}")
         (|bcStrings| (9 "-\\%pi/2" |from2| F)) (|text| . "{\\em to:}")
         (|bcStrings| (9 "\\%pi/2" |to2| F))
         (|text| "\\indent{0}\\newline\\menuitemstyle{}\\tab{2} "
          "Optionally enter a {\\em title} for your surface:")
         (|bcStrings| (15 "surface" |title| S)) (|text| . "\\indent{0}")))
      (|htMakeDoneButton| "Continue" '|bcDraw3Dpar1Gen|)
      (|htShowPage|)))))

; bcDraw3Dpar1Gen htPage ==
;   fun1 := htpLabelInputString(htPage,'function1)
;   fun2 := htpLabelInputString(htPage,'function2)
;   fun3 := htpLabelInputString(htPage,'function3)
;   ind1 := htpLabelInputString(htPage,'ind1)
;   from1 := htpLabelInputString(htPage,'from1)
;   to1 := htpLabelInputString(htPage,'to1)
;   ind2 := htpLabelInputString(htPage,'ind2)
;   from2 := htpLabelInputString(htPage,'from2)
;   to2 := htpLabelInputString(htPage,'to2)
;   title := htpLabelInputString(htPage,'title)
;   r1 := bcDrawIt2(ind1,from1,to1)
;   r2 := bcDrawIt2(ind2,from2,to2)
;   surfacePart := STRCONC('"surface(",'"{}",fun1,'",{}",fun2,'",{}",fun3,'")")
;   if (title ~= '"") then
;     titlePart := (title = '"" => nil; STRCONC('"{}",'"title ==_"",title,'"_""))
;     bcFinish('"draw",surfacePart,r1,r2,titlePart)
;   else
;     bcFinish('"draw",surfacePart,r1,r2)

(DEFUN |bcDraw3Dpar1Gen| (|htPage|)
  (PROG (|fun1| |fun2| |fun3| |ind1| |from1| |to1| |ind2| |from2| |to2| |title|
         |r1| |r2| |surfacePart| |titlePart|)
    (RETURN
     (PROGN
      (SETQ |fun1| (|htpLabelInputString| |htPage| '|function1|))
      (SETQ |fun2| (|htpLabelInputString| |htPage| '|function2|))
      (SETQ |fun3| (|htpLabelInputString| |htPage| '|function3|))
      (SETQ |ind1| (|htpLabelInputString| |htPage| '|ind1|))
      (SETQ |from1| (|htpLabelInputString| |htPage| '|from1|))
      (SETQ |to1| (|htpLabelInputString| |htPage| '|to1|))
      (SETQ |ind2| (|htpLabelInputString| |htPage| '|ind2|))
      (SETQ |from2| (|htpLabelInputString| |htPage| '|from2|))
      (SETQ |to2| (|htpLabelInputString| |htPage| '|to2|))
      (SETQ |title| (|htpLabelInputString| |htPage| '|title|))
      (SETQ |r1| (|bcDrawIt2| |ind1| |from1| |to1|))
      (SETQ |r2| (|bcDrawIt2| |ind2| |from2| |to2|))
      (SETQ |surfacePart|
              (STRCONC "surface(" "{}" |fun1| ",{}" |fun2| ",{}" |fun3| ")"))
      (COND
       ((NOT (EQUAL |title| ""))
        (SETQ |titlePart|
                (COND ((EQUAL |title| "") NIL)
                      (#1='T (STRCONC "{}" "title ==\"" |title| "\""))))
        (|bcFinish| "draw" |surfacePart| |r1| |r2| |titlePart|))
       (#1# (|bcFinish| "draw" |surfacePart| |r1| |r2|)))))))

; bcSeries() ==
;   htInitPage('"Series Basic Command",nil)
;   htMakePage '(
;     (domainConditions
;        (isDomain EM $EmptyMode)
;        (isDomain S (String))
;        (isDomain SY (Symbol)))
;    (text .  "Create a series by: ")
;    (text . "\beginmenu")
;    (text . "\item ")
;    (bcLinks ("\menuitemstyle{Expansion}" "" bcSeriesExpansion NILl))
;    (text . "\tab{11}Expand a function in a series around a point")
;    (text . "\item ")
;    (bcLinks ("\menuitemstyle{Formula}"  "" bcSeriesByFormula NIL))
;    (text . "\tab{11}Give a formula for the {\em i}'th coefficient")
;    (text . "\endmenu"))
;   htShowPage()

(DEFUN |bcSeries| ()
  (PROG ()
    (RETURN
     (PROGN
      (|htInitPage| "Series Basic Command" NIL)
      (|htMakePage|
       '((|domainConditions| (|isDomain| EM |$EmptyMode|)
          (|isDomain| S (|String|)) (|isDomain| SY (|Symbol|)))
         (|text| . "Create a series by: ") (|text| . "\\beginmenu")
         (|text| . "\\item ")
         (|bcLinks|
          ("\\menuitemstyle{Expansion}" "" |bcSeriesExpansion| |NILl|))
         (|text| . "\\tab{11}Expand a function in a series around a point")
         (|text| . "\\item ")
         (|bcLinks| ("\\menuitemstyle{Formula}" "" |bcSeriesByFormula| NIL))
         (|text| . "\\tab{11}Give a formula for the {\\em i}'th coefficient")
         (|text| . "\\endmenu")))
      (|htShowPage|)))))

; bcSeriesExpansion(a,b) ==
;   htInitPage('"Series Expansion Basic Command",nil)
;   htMakePage '(
;     (domainConditions
;        (isDomain EM $EmptyMode)
;        (isDomain EEM (Expression $EmptyMode))
;        (isDomain S (String))
;        (isDomain SY (Symbol)))
;     (text . "\newline ")
;     (text . "\menuitemstyle{}\tab{2}")
;     (text . "Enter the {\em function} you want to expand in a power series")
;     (text . "\newline\tab{2} ")
;     (bcStrings (55 "log(cot(x))" function EM))
;     (text . "\blankline ")
;     (text . "\newline ")
;     (text . "\menuitemstyle{}\tab{2}")
;     (text . "Enter the {\em power series variable}")
;     (text . "\tab{49}")
;     (bcStrings (8 x variable SY))
;     (text . "\blankline ")
;     (text . "\newline ")
;     (text . "\menuitemstyle{}\tab{2}")
;     (text . "Enter the {\em point} about which you want to expand")
;     (text . "\tab{49}")
;     (bcStrings (8 "\%pi/2" point EM)))
;   htMakeDoneButton('"Continue",'bcSeriesExpansionGen)
;   htShowPage()

(DEFUN |bcSeriesExpansion| (|a| |b|)
  (PROG ()
    (RETURN
     (PROGN
      (|htInitPage| "Series Expansion Basic Command" NIL)
      (|htMakePage|
       '((|domainConditions| (|isDomain| EM |$EmptyMode|)
          (|isDomain| EEM (|Expression| |$EmptyMode|))
          (|isDomain| S (|String|)) (|isDomain| SY (|Symbol|)))
         (|text| . "\\newline ") (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text|
          . "Enter the {\\em function} you want to expand in a power series")
         (|text| . "\\newline\\tab{2} ")
         (|bcStrings| (55 "log(cot(x))" |function| EM))
         (|text| . "\\blankline ") (|text| . "\\newline ")
         (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text| . "Enter the {\\em power series variable}")
         (|text| . "\\tab{49}") (|bcStrings| (8 |x| |variable| SY))
         (|text| . "\\blankline ") (|text| . "\\newline ")
         (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text| . "Enter the {\\em point} about which you want to expand")
         (|text| . "\\tab{49}") (|bcStrings| (8 "\\%pi/2" |point| EM))))
      (|htMakeDoneButton| "Continue" '|bcSeriesExpansionGen|)
      (|htShowPage|)))))

; bcSeriesExpansionGen htPage ==
;   fun := htpLabelInputString(htPage,'function)
;   var := htpLabelInputString(htPage,'variable)
;   point := htpLabelInputString(htPage,'point)
;   bcFinish("series",fun,STRCONC(var,'" = ",point))

(DEFUN |bcSeriesExpansionGen| (|htPage|)
  (PROG (|fun| |var| |point|)
    (RETURN
     (PROGN
      (SETQ |fun| (|htpLabelInputString| |htPage| '|function|))
      (SETQ |var| (|htpLabelInputString| |htPage| '|variable|))
      (SETQ |point| (|htpLabelInputString| |htPage| '|point|))
      (|bcFinish| '|series| |fun| (STRCONC |var| " = " |point|))))))

; bcSeriesByFormula(a,b) ==
;   htInitPage('"Power Series Basic Command",nil)
;   htMakePage '(
;     (text . "Select the kind of power series you want to create:")
;     (text . "\beginmenu")
;     (text . "\item ")
;     (bcLinks ("\menuitemstyle{Taylor Series}" "" bcTaylorSeries taylor))
;     (text . "\newline Series where the exponent ranges over the integers from a {\em non-negative integer} value to plus infinity by an arbitrary {\em positive integer} step size")
;     (text . "\item ")
;     (bcLinks ("\menuitemstyle{Laurent Series}" "" bcLaurentSeries laurent))
;     (text . "\newline Series where the exponent ranges from an arbitrary {\em integer} value to plus infinity by an arbitrary {\em positive integer} step size")
;     (text . "\item ")
;     (bcLinks ("\menuitemstyle{Puiseux Series}" "" bcPuiseuxSeries puiseux))
;     (text . "\newline Series where the exponent ranges from an arbitrary {\em rational value} to plus infinity by an arbitrary {\em positive rational number} step size")
;     (text . "\endmenu"))
;   htShowPage()

(DEFUN |bcSeriesByFormula| (|a| |b|)
  (PROG ()
    (RETURN
     (PROGN
      (|htInitPage| "Power Series Basic Command" NIL)
      (|htMakePage|
       '((|text| . "Select the kind of power series you want to create:")
         (|text| . "\\beginmenu") (|text| . "\\item ")
         (|bcLinks|
          ("\\menuitemstyle{Taylor Series}" "" |bcTaylorSeries| |taylor|))
         (|text|
          . "\\newline Series where the exponent ranges over the integers from a {\\em non-negative integer} value to plus infinity by an arbitrary {\\em positive integer} step size")
         (|text| . "\\item ")
         (|bcLinks|
          ("\\menuitemstyle{Laurent Series}" "" |bcLaurentSeries| |laurent|))
         (|text|
          . "\\newline Series where the exponent ranges from an arbitrary {\\em integer} value to plus infinity by an arbitrary {\\em positive integer} step size")
         (|text| . "\\item ")
         (|bcLinks|
          ("\\menuitemstyle{Puiseux Series}" "" |bcPuiseuxSeries| |puiseux|))
         (|text|
          . "\\newline Series where the exponent ranges from an arbitrary {\\em rational value} to plus infinity by an arbitrary {\\em positive rational number} step size")
         (|text| . "\\endmenu")))
      (|htShowPage|)))))

; bcTaylorSeries(a,b) ==
;   htInitPage('"Taylor Series Basic Command",nil)
;   htMakePage '(
;     (domainConditions
;        (isDomain EM $EmptyMode)
;        (isDomain EEM (Expression $EmptyMode))
;        (isDomain S (String))
;        (isDomain SY (Symbol)))
;     (text . "\menuitemstyle{}\tab{2}")
;     (text . "Enter the formula for the general coefficient of the series")
;     (text . "\newline\tab{2} ")
;     (bcStrings (55 "1/factorial(i)" formula EM))
;     (text . "\blankline ")
;     (text . "\menuitemstyle{}\tab{2}")
;     (text . "Enter the {\em index variable} for your formula")
;     (text . "\tab{49}")
;     (bcStrings (8 i index SY))
;     (text . "\newline ")
;     (text . "\menuitemstyle{}\tab{2}")
;     (text . "Enter the {\em power series variable}")
;     (text . "\tab{49}")
;     (bcStrings (8 x variable SY))
;     (text . "\newline ")
;     (text . "\menuitemstyle{}\tab{2}")
;     (text . "Enter the {\em point} about which you want to expand")
;     (text . "\tab{49}")
;     (bcStrings (8 0 point EM))
;     (text . "\blankline ")
;     (text ."For Taylor Series, the exponent of the power series variable ranges  from an {\em initial value}, an arbitrary non-negative integer, to plus infinity; the {\em step size} is any positive integer.")
;     (text . "\blankline ")
;     (text . "\newline ")
;     (text . "\menuitemstyle{}\tab{2}")
;     (text . "Enter the {\em initial value} of the index (an integer)")
;     (text . "\tab{49}")
;     (bcStrings (8 "0" min I))
;     (text . "\newline ")
;     (text . "\menuitemstyle{}\tab{2}")
;     (text . "Enter the {\em step size} (a positive integer)")
;     (text . "\tab{49}")
;     (bcStrings (8 "1" step PI))
;     (doneButton "Continue" bcTaylorSeriesGen))
;   htShowPage()

(DEFUN |bcTaylorSeries| (|a| |b|)
  (PROG ()
    (RETURN
     (PROGN
      (|htInitPage| "Taylor Series Basic Command" NIL)
      (|htMakePage|
       '((|domainConditions| (|isDomain| EM |$EmptyMode|)
          (|isDomain| EEM (|Expression| |$EmptyMode|))
          (|isDomain| S (|String|)) (|isDomain| SY (|Symbol|)))
         (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text|
          . "Enter the formula for the general coefficient of the series")
         (|text| . "\\newline\\tab{2} ")
         (|bcStrings| (55 "1/factorial(i)" |formula| EM))
         (|text| . "\\blankline ") (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text| . "Enter the {\\em index variable} for your formula")
         (|text| . "\\tab{49}") (|bcStrings| (8 |i| |index| SY))
         (|text| . "\\newline ") (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text| . "Enter the {\\em power series variable}")
         (|text| . "\\tab{49}") (|bcStrings| (8 |x| |variable| SY))
         (|text| . "\\newline ") (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text| . "Enter the {\\em point} about which you want to expand")
         (|text| . "\\tab{49}") (|bcStrings| (8 0 |point| EM))
         (|text| . "\\blankline ")
         (|text|
          . "For Taylor Series, the exponent of the power series variable ranges  from an {\\em initial value}, an arbitrary non-negative integer, to plus infinity; the {\\em step size} is any positive integer.")
         (|text| . "\\blankline ") (|text| . "\\newline ")
         (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text| . "Enter the {\\em initial value} of the index (an integer)")
         (|text| . "\\tab{49}") (|bcStrings| (8 "0" |min| I))
         (|text| . "\\newline ") (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text| . "Enter the {\\em step size} (a positive integer)")
         (|text| . "\\tab{49}") (|bcStrings| (8 "1" |step| PI))
         (|doneButton| "Continue" |bcTaylorSeriesGen|)))
      (|htShowPage|)))))

; bcSeriesByFormulaGen htPage == bcNotReady()

(DEFUN |bcSeriesByFormulaGen| (|htPage|) (PROG () (RETURN (|bcNotReady|))))

; bcLaurentSeries(a,b) ==
;   htInitPage('"Laurent Series Basic Command",nil)
;   htMakePage '(
;     (domainConditions
;        (isDomain EM $EmptyMode)
;        (isDomain EEM (Expression $EmptyMode))
;        (isDomain S (String))
;        (isDomain I (Integer))
;        (isDomain PI (PositiveInteger))
;        (isDomain SY (Symbol)))
;     (text . "\newline ")
;     (text . "\menuitemstyle{}\tab{2}")
;     (text . "Enter the formula for the general coefficient of the series")
;     (text . "\newline\tab{2} ")
;     (bcStrings (55 "(-1)^(n - 1)/(n + 2)" formula EM))
;     (text . "\vspace{1}\newline ")
;     (text . "\menuitemstyle{}\tab{2}")
;     (text . "Enter the {\em index variable} for your formula")
;     (text . "\tab{49}")
;     (bcStrings (8 n index SY))
;     (text . "\newline ")
;     (text . "\menuitemstyle{}\tab{2}")
;     (text . "Enter the {\em power series variable}")
;     (text . "\tab{49}")
;     (bcStrings (8 x variable SY))
;     (text . "\newline ")
;     (text . "\menuitemstyle{}\tab{2}")
;     (text . "Enter the {\em point} about which you want to expand")
;     (text . "\tab{49}")
;     (bcStrings (8 0 point F))
;     (text . "\blankline")
;     (text . "\newline For Laurent Series, the exponent of the power series variable ranges from an {\em initial value}, an arbitrary integer value, to plus infinity; the {\em step size} is any positive integer.")
;     (text . "\blankline")
;     (text . "\menuitemstyle{}\tab{2}")
;     (text . "Enter the {\em initial value} of the index (an integer)")
;     (text . "\tab{49}")
;     (bcStrings (8 "-1" min I))
;     (text . "\newline ")
;     (text . "\menuitemstyle{}\tab{2}")
;     (text . "Enter the {\em step size} (a positive integer)")
;     (text . "\tab{49}")
;     (bcStrings (8 "1" step PI))
;     (doneButton "Continue" bcLaurentSeriesGen))
;   htShowPage()

(DEFUN |bcLaurentSeries| (|a| |b|)
  (PROG ()
    (RETURN
     (PROGN
      (|htInitPage| "Laurent Series Basic Command" NIL)
      (|htMakePage|
       '((|domainConditions| (|isDomain| EM |$EmptyMode|)
          (|isDomain| EEM (|Expression| |$EmptyMode|))
          (|isDomain| S (|String|)) (|isDomain| I (|Integer|))
          (|isDomain| PI (|PositiveInteger|)) (|isDomain| SY (|Symbol|)))
         (|text| . "\\newline ") (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text|
          . "Enter the formula for the general coefficient of the series")
         (|text| . "\\newline\\tab{2} ")
         (|bcStrings| (55 "(-1)^(n - 1)/(n + 2)" |formula| EM))
         (|text| . "\\vspace{1}\\newline ")
         (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text| . "Enter the {\\em index variable} for your formula")
         (|text| . "\\tab{49}") (|bcStrings| (8 |n| |index| SY))
         (|text| . "\\newline ") (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text| . "Enter the {\\em power series variable}")
         (|text| . "\\tab{49}") (|bcStrings| (8 |x| |variable| SY))
         (|text| . "\\newline ") (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text| . "Enter the {\\em point} about which you want to expand")
         (|text| . "\\tab{49}") (|bcStrings| (8 0 |point| F))
         (|text| . "\\blankline")
         (|text|
          . "\\newline For Laurent Series, the exponent of the power series variable ranges from an {\\em initial value}, an arbitrary integer value, to plus infinity; the {\\em step size} is any positive integer.")
         (|text| . "\\blankline") (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text| . "Enter the {\\em initial value} of the index (an integer)")
         (|text| . "\\tab{49}") (|bcStrings| (8 "-1" |min| I))
         (|text| . "\\newline ") (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text| . "Enter the {\\em step size} (a positive integer)")
         (|text| . "\\tab{49}") (|bcStrings| (8 "1" |step| PI))
         (|doneButton| "Continue" |bcLaurentSeriesGen|)))
      (|htShowPage|)))))

; bcPuiseuxSeries(a,b) ==
;   htInitPage('"Puiseux Series Basic Command",nil)
;   htMakePage '(
;     (domainConditions
;        (isDomain EM $EmptyMode)
;        (isDomain EEM (Expression $EmptyMode))
;        (isDomain S (String))
;        (isDomain I (Integer))
;        (isDomain PI (PositiveInteger))
;        (isDOmain RN (Fraction (Integer)))
;        (isDomain SY (Symbol)))
;     (text . "\newline ")
;     (text . "\menuitemstyle{}\tab{2}")
;     (text ."Enter the {\em formula} for the general coefficient of the series")
;     (text . "\newline\tab{2} ")
;     (bcStrings(55 "(-1)^((3*n - 4)/6)/factorial(n - 1/3)" formula EM))
;     (text . "\vspace{1}\newline ")
;     (text . "\menuitemstyle{}\tab{2}")
;     (text . "Enter the {\em index variable} for your formula")
;     (text . "\tab{49}")
;     (bcStrings (8 n index SY))
;     (text . "\newline ")
;     (text . "\menuitemstyle{}\tab{2}")
;     (text . "Enter the {\em power series variable}")
;     (text . "\tab{49}")
;     (bcStrings (8 x variable SY))
;     (text . "\newline ")
;     (text . "\menuitemstyle{}\tab{2}")
;     (text . "Enter the {\em point} about which you want to expand")
;     (text . "\tab{49}")
;     (bcStrings (8 0 point F))
;     (text . "\blankline ")
;     (text . "For Puiseux Series, the exponent of the power series variable ranges from an {\em initial value}, an arbitrary rational number, to plus infinity; the {\em step size} is an any positive rational number.")
;     (text . "\blankline ")
;     (text . "\newline ")
;     (text . "\menuitemstyle{}\tab{2}")
;     (text . "Enter the {\em initial value} of index (a rational number)")
;     (text . "\tab{51}")
;     (bcStrings (6 "4/3" min RN))
;     (text . "\newline ")
;     (text . "\menuitemstyle{}\tab{2}")
;     (text . "Enter the {\em step size} (a positive rational number)")
;     (text . "\tab{51}")
;     (bcStrings (6 "2" step RN))
;     (doneButton "Continue" bcPuiseuxSeriesGen))
;   htShowPage()

(DEFUN |bcPuiseuxSeries| (|a| |b|)
  (PROG ()
    (RETURN
     (PROGN
      (|htInitPage| "Puiseux Series Basic Command" NIL)
      (|htMakePage|
       '((|domainConditions| (|isDomain| EM |$EmptyMode|)
          (|isDomain| EEM (|Expression| |$EmptyMode|))
          (|isDomain| S (|String|)) (|isDomain| I (|Integer|))
          (|isDomain| PI (|PositiveInteger|))
          (|isDOmain| RN (|Fraction| (|Integer|))) (|isDomain| SY (|Symbol|)))
         (|text| . "\\newline ") (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text|
          . "Enter the {\\em formula} for the general coefficient of the series")
         (|text| . "\\newline\\tab{2} ")
         (|bcStrings|
          (55 "(-1)^((3*n - 4)/6)/factorial(n - 1/3)" |formula| EM))
         (|text| . "\\vspace{1}\\newline ")
         (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text| . "Enter the {\\em index variable} for your formula")
         (|text| . "\\tab{49}") (|bcStrings| (8 |n| |index| SY))
         (|text| . "\\newline ") (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text| . "Enter the {\\em power series variable}")
         (|text| . "\\tab{49}") (|bcStrings| (8 |x| |variable| SY))
         (|text| . "\\newline ") (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text| . "Enter the {\\em point} about which you want to expand")
         (|text| . "\\tab{49}") (|bcStrings| (8 0 |point| F))
         (|text| . "\\blankline ")
         (|text|
          . "For Puiseux Series, the exponent of the power series variable ranges from an {\\em initial value}, an arbitrary rational number, to plus infinity; the {\\em step size} is an any positive rational number.")
         (|text| . "\\blankline ") (|text| . "\\newline ")
         (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text|
          . "Enter the {\\em initial value} of index (a rational number)")
         (|text| . "\\tab{51}") (|bcStrings| (6 "4/3" |min| RN))
         (|text| . "\\newline ") (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text| . "Enter the {\\em step size} (a positive rational number)")
         (|text| . "\\tab{51}") (|bcStrings| (6 "2" |step| RN))
         (|doneButton| "Continue" |bcPuiseuxSeriesGen|)))
      (|htShowPage|)))))

; bcTaylorSeriesGen htPage == bcSeriesGen(htPage)

(DEFUN |bcTaylorSeriesGen| (|htPage|)
  (PROG () (RETURN (|bcSeriesGen| |htPage|))))

; bcLaurentSeriesGen htPage ==
;   bcSeriesGen(htPage)

(DEFUN |bcLaurentSeriesGen| (|htPage|)
  (PROG () (RETURN (|bcSeriesGen| |htPage|))))

; bcPuiseuxSeriesGen htPage ==
;   bcSeriesGen(htPage)

(DEFUN |bcPuiseuxSeriesGen| (|htPage|)
  (PROG () (RETURN (|bcSeriesGen| |htPage|))))

; bcSeriesGen(htPage) ==
;   step:= htpLabelInputString(htPage,'step)
;   min := htpLabelInputString(htPage,'min)
;   formula := htpLabelInputString(htPage,'formula)
;   index   := htpLabelInputString(htPage,'index)
;   var := htpLabelInputString(htPage,'variable)
;   point := htpLabelInputString(htPage,'point)
;   varPart := STRCONC(var,'" = ",point)
;   minPart := STRCONC(min,'"..")
;   bcFinish('"series",STRCONC(index,'" +-> ",formula),varPart,minPart,step)

(DEFUN |bcSeriesGen| (|htPage|)
  (PROG (|step| |min| |formula| |index| |var| |point| |varPart| |minPart|)
    (RETURN
     (PROGN
      (SETQ |step| (|htpLabelInputString| |htPage| '|step|))
      (SETQ |min| (|htpLabelInputString| |htPage| '|min|))
      (SETQ |formula| (|htpLabelInputString| |htPage| '|formula|))
      (SETQ |index| (|htpLabelInputString| |htPage| '|index|))
      (SETQ |var| (|htpLabelInputString| |htPage| '|variable|))
      (SETQ |point| (|htpLabelInputString| |htPage| '|point|))
      (SETQ |varPart| (STRCONC |var| " = " |point|))
      (SETQ |minPart| (STRCONC |min| ".."))
      (|bcFinish| "series" (STRCONC |index| " +-> " |formula|) |varPart|
       |minPart| |step|)))))

; bcLimit() ==
;   htInitPage('"Limit Basic Command",nil)
;   htMakePage '(
;    (domainConditions
;        (isDomain EM $EmptyMode)
;        (isDomain S (String))
;        (isDomain SY (Symbol)))
;    (text . "What kind of limit do you want to compute? ")
;    (text . "\blankline ")
;    (text . "\beginmenu")
;    (text . "\item ")
;    (bcLinks ("\menuitemstyle{A real limit?}" "" bcRealLimit real))
;    (text . "\indentrel{17}\tab{0}")
;    (text . "The limit as the variable approaches a {\em real} value along the real axis")
;    (text . "\indentrel{-17}")
;    (text . "\item ")
;    (text . "\blankline ")
;    (bcLinks ("\menuitemstyle{A complex limit?}" "" bcComplexLimit complex))
;    (text . "\indentrel{17}\tab{0}")
;    (text . "The limit as the variable approaches a {\em complex} value along any path in the complex plane")
;    (text . "\indentrel{-17}")
;    (text . "\endmenu")
;     )
;   htShowPage()

(DEFUN |bcLimit| ()
  (PROG ()
    (RETURN
     (PROGN
      (|htInitPage| "Limit Basic Command" NIL)
      (|htMakePage|
       '((|domainConditions| (|isDomain| EM |$EmptyMode|)
          (|isDomain| S (|String|)) (|isDomain| SY (|Symbol|)))
         (|text| . "What kind of limit do you want to compute? ")
         (|text| . "\\blankline ") (|text| . "\\beginmenu")
         (|text| . "\\item ")
         (|bcLinks| ("\\menuitemstyle{A real limit?}" "" |bcRealLimit| |real|))
         (|text| . "\\indentrel{17}\\tab{0}")
         (|text|
          . "The limit as the variable approaches a {\\em real} value along the real axis")
         (|text| . "\\indentrel{-17}") (|text| . "\\item ")
         (|text| . "\\blankline ")
         (|bcLinks|
          ("\\menuitemstyle{A complex limit?}" "" |bcComplexLimit| |complex|))
         (|text| . "\\indentrel{17}\\tab{0}")
         (|text|
          . "The limit as the variable approaches a {\\em complex} value along any path in the complex plane")
         (|text| . "\\indentrel{-17}") (|text| . "\\endmenu")))
      (|htShowPage|)))))

; bcRealLimit(a,b) ==
;   htInitPage('"Real Limit Basic Command",nil)
;   htMakePage '(
;     (domainConditions
;        (isDomain EM $EmptyMode)
;        (isDomain S (String))
;        (isDomain F (Float))
;        (isDomain SY (Symbol)))
;     (text . "\newline ")
;     (text . "\menuitemstyle{}\tab{2}")
;     (text . "Enter the {\em function} you want to compute the limit of:")
;     (text . "\newline\tab{2} ")
;     (bcStrings (45 "x*sin(1/x)" expression EM))
;     (text . "\blankline")
;     (text . "\newline ")
;     (text . "\menuitemstyle{}\tab{2}")
;     (text . "Enter the name of the {\em variable}: ")
;     (text . "\tab{41}")
;     (bcStrings (6 x variable SY))
;     (text . "\blankline")
;     (text . "\newline ")
;     (text . "\menuitemstyle{}\tab{2}")
;     (text . "Compute the limit at")
;     (radioButtons location
;       ("A finite point:" (
;         (text . "\tab{33}")
;         (bcStrings (6 0 point F))) finitePoint)
;       ("Plus infinity" "" plusInfinity)
;       ("Minus infinity" "" minusInfinity))
;     (doneButton "Continue" bcRealLimitGen))
;   htShowPage()

(DEFUN |bcRealLimit| (|a| |b|)
  (PROG ()
    (RETURN
     (PROGN
      (|htInitPage| "Real Limit Basic Command" NIL)
      (|htMakePage|
       '((|domainConditions| (|isDomain| EM |$EmptyMode|)
          (|isDomain| S (|String|)) (|isDomain| F (|Float|))
          (|isDomain| SY (|Symbol|)))
         (|text| . "\\newline ") (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text|
          . "Enter the {\\em function} you want to compute the limit of:")
         (|text| . "\\newline\\tab{2} ")
         (|bcStrings| (45 "x*sin(1/x)" |expression| EM))
         (|text| . "\\blankline") (|text| . "\\newline ")
         (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text| . "Enter the name of the {\\em variable}: ")
         (|text| . "\\tab{41}") (|bcStrings| (6 |x| |variable| SY))
         (|text| . "\\blankline") (|text| . "\\newline ")
         (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text| . "Compute the limit at")
         (|radioButtons| |location|
          ("A finite point:"
           ((|text| . "\\tab{33}") (|bcStrings| (6 0 |point| F)))
           |finitePoint|)
          ("Plus infinity" "" |plusInfinity|)
          ("Minus infinity" "" |minusInfinity|))
         (|doneButton| "Continue" |bcRealLimitGen|)))
      (|htShowPage|)))))

; bcRealLimitGen htPage ==
;   (p := htpButtonValue(htPage,'location)) ~= 'finitePoint =>
;     fun := htpLabelInputString(htPage,'expression)
;     var := htpLabelInputString(htPage,'variable)
;     loc :=
;       p = 'plusInfinity => '"%plusInfinity"
;       '"%minusInfinity"
;     bcFinish('"limit",fun,STRCONC(var,'" = ",loc))
;   page := htInitPage('"Real Limit Basic Command",nil)
;   htMakePage '(
;     (text . "Compute the limit")
;     (lispLinks
;        ("\menuitemstyle{From both directions}" "" bcRealLimitGen1 both)
;        ("\menuitemstyle{From the right}" "" bcRealLimitGen1 right)
;        ("\menuitemstyle{From the left}" "" bcRealLimitGen1 left)))
;   htpSetProperty(page,'fun,htpLabelInputString(htPage,'expression))
;   htpSetProperty(page,'var,htpLabelInputString(htPage,'variable))
;   htpSetProperty(page,'loc,htpLabelInputString(htPage,'point))
;   htShowPage()

(DEFUN |bcRealLimitGen| (|htPage|)
  (PROG (|p| |fun| |var| |loc| |page|)
    (RETURN
     (COND
      ((NOT
        (EQ (SETQ |p| (|htpButtonValue| |htPage| '|location|)) '|finitePoint|))
       (PROGN
        (SETQ |fun| (|htpLabelInputString| |htPage| '|expression|))
        (SETQ |var| (|htpLabelInputString| |htPage| '|variable|))
        (SETQ |loc|
                (COND ((EQ |p| '|plusInfinity|) "%plusInfinity")
                      (#1='T "%minusInfinity")))
        (|bcFinish| "limit" |fun| (STRCONC |var| " = " |loc|))))
      (#1#
       (PROGN
        (SETQ |page| (|htInitPage| "Real Limit Basic Command" NIL))
        (|htMakePage|
         '((|text| . "Compute the limit")
           (|lispLinks|
            ("\\menuitemstyle{From both directions}" "" |bcRealLimitGen1|
             |both|)
            ("\\menuitemstyle{From the right}" "" |bcRealLimitGen1| |right|)
            ("\\menuitemstyle{From the left}" "" |bcRealLimitGen1| |left|))))
        (|htpSetProperty| |page| '|fun|
         (|htpLabelInputString| |htPage| '|expression|))
        (|htpSetProperty| |page| '|var|
         (|htpLabelInputString| |htPage| '|variable|))
        (|htpSetProperty| |page| '|loc|
         (|htpLabelInputString| |htPage| '|point|))
        (|htShowPage|)))))))

; bcRealLimitGen1(htPage,key) ==
;   direction :=
;     key = 'right => '"_"right_""
;     key = 'left => '"_"left_""
;     nil
;   fun := htpProperty(htPage,'fun)
;   var := htpProperty(htPage,'var)
;   loc := htpProperty(htPage,'loc)
;   varPart := STRCONC(var,'" = ",loc)
;   bcFinish('"limit",fun,varPart,direction)

(DEFUN |bcRealLimitGen1| (|htPage| |key|)
  (PROG (|direction| |fun| |var| |loc| |varPart|)
    (RETURN
     (PROGN
      (SETQ |direction|
              (COND ((EQ |key| '|right|) "\"right\"")
                    ((EQ |key| '|left|) "\"left\"") ('T NIL)))
      (SETQ |fun| (|htpProperty| |htPage| '|fun|))
      (SETQ |var| (|htpProperty| |htPage| '|var|))
      (SETQ |loc| (|htpProperty| |htPage| '|loc|))
      (SETQ |varPart| (STRCONC |var| " = " |loc|))
      (|bcFinish| "limit" |fun| |varPart| |direction|)))))

; bcComplexLimit(a,b) ==
;   htInitPage('"Complex Limit Basic Command",nil)
;   htMakePage '(
;     (domainConditions
;         (isDomain EM $EmptyMode)
;        (isDomain S (String))
;        (isDomain F (Float))
;        (isDomain SY (Symbol)))
;     (text . "\newline ")
;     (text . "\menuitemstyle{}\tab{2}")
;     (text . "Enter the {\em function} you want to compute the limit of:")
;     (text . "\newline\tab{2} ")
;     (bcStrings (40 "sin(a*x)/tan(b*x)" expression EM))
;     (text . "\blankline ")
;     (text . "\newline ")
;     (text . "\menuitemstyle{}\tab{2}")
;     (text . "Enter the name of the {\em variable}: ")
;     (text . "\tab{37}")
;     (bcStrings (5 x variable SY))
;     (text . "\blankline ")
;     (text . "\newline ")
;     (text . "\menuitemstyle{}\tab{2}")
;     (text . "Compute the limit at")
;     (radioButtons location
;       ("A finite point:" (
;        (text . "\newline\space{0}Real part:\space{3}")
;        (bcStrings (20 0 real F))
;        (text . "\newline Complex part:")
;        (bcStrings (20 0 complex F))) finitePoint)
;       ("Complex infinity" "" complexInfinity))
;      (doneButton "Continue" bcComplexLimitGen))
;   htShowPage()

(DEFUN |bcComplexLimit| (|a| |b|)
  (PROG ()
    (RETURN
     (PROGN
      (|htInitPage| "Complex Limit Basic Command" NIL)
      (|htMakePage|
       '((|domainConditions| (|isDomain| EM |$EmptyMode|)
          (|isDomain| S (|String|)) (|isDomain| F (|Float|))
          (|isDomain| SY (|Symbol|)))
         (|text| . "\\newline ") (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text|
          . "Enter the {\\em function} you want to compute the limit of:")
         (|text| . "\\newline\\tab{2} ")
         (|bcStrings| (40 "sin(a*x)/tan(b*x)" |expression| EM))
         (|text| . "\\blankline ") (|text| . "\\newline ")
         (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text| . "Enter the name of the {\\em variable}: ")
         (|text| . "\\tab{37}") (|bcStrings| (5 |x| |variable| SY))
         (|text| . "\\blankline ") (|text| . "\\newline ")
         (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text| . "Compute the limit at")
         (|radioButtons| |location|
          ("A finite point:"
           ((|text| . "\\newline\\space{0}Real part:\\space{3}")
            (|bcStrings| (20 0 |real| F)) (|text| . "\\newline Complex part:")
            (|bcStrings| (20 0 |complex| F)))
           |finitePoint|)
          ("Complex infinity" "" |complexInfinity|))
         (|doneButton| "Continue" |bcComplexLimitGen|)))
      (|htShowPage|)))))

; bcComplexLimitGen htPage ==
;   fun := htpLabelInputString(htPage,'expression)
;   var := htpLabelInputString(htPage,'variable)
;   loc :=
;     (p := htpButtonValue(htPage,'location)) = 'finitePoint =>
;       real := htpLabelInputString(htPage,'real)
;       comp := htpLabelInputString(htPage,'complex)
;       complexPart :=
;         comp = '"0" => '""
;         comp = '"1" => '"%i"
;         STRCONC(comp,'"*%i")
;       real = '"0" =>
;         complexPart = '"" => "0"
;         complexPart
;       complexPart = '"" => real
;       STRCONC(real,'" + ",complexPart)
;     '"%infinity"
;   varPart := STRCONC(var,'" = ",loc)
;   bcFinish('"complexLimit",fun,varPart)

(DEFUN |bcComplexLimitGen| (|htPage|)
  (PROG (|fun| |var| |p| |real| |comp| |complexPart| |loc| |varPart|)
    (RETURN
     (PROGN
      (SETQ |fun| (|htpLabelInputString| |htPage| '|expression|))
      (SETQ |var| (|htpLabelInputString| |htPage| '|variable|))
      (SETQ |loc|
              (COND
               ((EQ (SETQ |p| (|htpButtonValue| |htPage| '|location|))
                    '|finitePoint|)
                (PROGN
                 (SETQ |real| (|htpLabelInputString| |htPage| '|real|))
                 (SETQ |comp| (|htpLabelInputString| |htPage| '|complex|))
                 (SETQ |complexPart|
                         (COND ((EQUAL |comp| "0") "")
                               ((EQUAL |comp| "1") "%i")
                               (#1='T (STRCONC |comp| "*%i"))))
                 (COND
                  ((EQUAL |real| "0")
                   (COND ((EQUAL |complexPart| "") '|0|) (#1# |complexPart|)))
                  ((EQUAL |complexPart| "") |real|)
                  (#1# (STRCONC |real| " + " |complexPart|)))))
               (#1# "%infinity")))
      (SETQ |varPart| (STRCONC |var| " = " |loc|))
      (|bcFinish| "complexLimit" |fun| |varPart|)))))
