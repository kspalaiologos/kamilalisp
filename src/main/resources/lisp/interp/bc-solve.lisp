
; )package "BOOT"

(IN-PACKAGE "BOOT")

; $systemType := nil

(EVAL-WHEN (EVAL LOAD) (SETQ |$systemType| NIL))

; $numberOfEquations := 0

(EVAL-WHEN (EVAL LOAD) (SETQ |$numberOfEquations| 0))

; $solutionMethod := nil

(EVAL-WHEN (EVAL LOAD) (SETQ |$solutionMethod| NIL))

; bcSolve() ==
;   htInitPage('"Solve Basic Command", nil)
;   htMakePage '(
;    (text . "What do you want to solve? ")
;    (text . "\beginmenu")
;    (text . "\item ")
;    (bcLinks ("\menuitemstyle{A System Of Linear Equations}" "" bcLinearSolve linear))
;    (text . "\item ")
;    (bcLinks ("\menuitemstyle{A System of Polynomial Equations}" "" bcSystemSolve  polynomial))
;    (text . "\item ")
;    (bcLinks ("\menuitemstyle{A Single Polynomial Equation}" "" bcSolveSingle onePolynomial))
;    (text . "\endmenu"))
;   htShowPage()

(DEFUN |bcSolve| ()
  (PROG ()
    (RETURN
     (PROGN
      (|htInitPage| "Solve Basic Command" NIL)
      (|htMakePage|
       '((|text| . "What do you want to solve? ") (|text| . "\\beginmenu")
         (|text| . "\\item ")
         (|bcLinks|
          ("\\menuitemstyle{A System Of Linear Equations}" "" |bcLinearSolve|
           |linear|))
         (|text| . "\\item ")
         (|bcLinks|
          ("\\menuitemstyle{A System of Polynomial Equations}" ""
           |bcSystemSolve| |polynomial|))
         (|text| . "\\item ")
         (|bcLinks|
          ("\\menuitemstyle{A Single Polynomial Equation}" "" |bcSolveSingle|
           |onePolynomial|))
         (|text| . "\\endmenu")))
      (|htShowPage|)))))

; bcLinearSolve(p,nn) ==
;   htInitPage('"Basic Solve Command", nil)
;   htMakePage '(
;     (text . "How do you want to enter the equations?")
;     (text . "\beginmenu")
;     (text . "\item ")
;     (text . "\newline ")
;     (bcLinks ("\menuitemstyle{Directly as equations}" "" bcLinearSolveEqns equations))
;     (text . "\item ")
;     (text . "\newline ")
;     (bcLinks ("\menuitemstyle{In matrix form}" "" bcLinearSolveMatrix matrix))
;     (text . "\indentrel{16}\tab{0}")
;     (text . " \spad{AX = B}, where \spad{A} is a matrix of coefficients and \spad{B} is a vector" )
;     (text . "\indentrel{-16}\item ")
;     (text . "\endmenu"))
;   htShowPage()

(DEFUN |bcLinearSolve| (|p| |nn|)
  (PROG ()
    (RETURN
     (PROGN
      (|htInitPage| "Basic Solve Command" NIL)
      (|htMakePage|
       '((|text| . "How do you want to enter the equations?")
         (|text| . "\\beginmenu") (|text| . "\\item ") (|text| . "\\newline ")
         (|bcLinks|
          ("\\menuitemstyle{Directly as equations}" "" |bcLinearSolveEqns|
           |equations|))
         (|text| . "\\item ") (|text| . "\\newline ")
         (|bcLinks|
          ("\\menuitemstyle{In matrix form}" "" |bcLinearSolveMatrix|
           |matrix|))
         (|text| . "\\indentrel{16}\\tab{0}")
         (|text|
          . " \\spad{AX = B}, where \\spad{A} is a matrix of coefficients and \\spad{B} is a vector")
         (|text| . "\\indentrel{-16}\\item ") (|text| . "\\endmenu")))
      (|htShowPage|)))))

; bcLinearSolveEqns(htPage, p) ==
;   htInitPage('"Basic Solve Command", nil)
;   htMakePage '(
;     (domainConditions (isDomain PI (PositiveInteger)))
;     (inputStrings
;       ("Enter the {\em number} of equations:" "" 5 2 numberOfEquations PI)))
;   htMakeDoneButton('"Continue", 'bcLinearSolveEqns1)
;   htShowPage()

(DEFUN |bcLinearSolveEqns| (|htPage| |p|)
  (PROG ()
    (RETURN
     (PROGN
      (|htInitPage| "Basic Solve Command" NIL)
      (|htMakePage|
       '((|domainConditions| (|isDomain| PI (|PositiveInteger|)))
         (|inputStrings|
          ("Enter the {\\em number} of equations:" "" 5 2 |numberOfEquations|
           PI))))
      (|htMakeDoneButton| "Continue" '|bcLinearSolveEqns1|)
      (|htShowPage|)))))

; bcSystemSolve(htPage, p) ==
;   htInitPage('"Basic Solve Command", nil)
;   htMakePage '(
;     (domainConditions (isDomain PI (PositiveInteger)))
;     (inputStrings
;       ("Enter the {\em number} of equations:" "" 5 2 numberOfEquations PI)))
;   htMakeDoneButton('"Continue", 'bcSystemSolveEqns1)
;   htShowPage()

(DEFUN |bcSystemSolve| (|htPage| |p|)
  (PROG ()
    (RETURN
     (PROGN
      (|htInitPage| "Basic Solve Command" NIL)
      (|htMakePage|
       '((|domainConditions| (|isDomain| PI (|PositiveInteger|)))
         (|inputStrings|
          ("Enter the {\\em number} of equations:" "" 5 2 |numberOfEquations|
           PI))))
      (|htMakeDoneButton| "Continue" '|bcSystemSolveEqns1|)
      (|htShowPage|)))))

; bcSolveSingle(htPage,p) ==
;   htpSetProperty(htPage,'systemType, 'onePolynomial)
;   htpSetProperty(htPage,'exitFunction,'bcInputSolveInfo)
;   bcInputEquations(htPage,'exact)

(DEFUN |bcSolveSingle| (|htPage| |p|)
  (PROG ()
    (RETURN
     (PROGN
      (|htpSetProperty| |htPage| '|systemType| '|onePolynomial|)
      (|htpSetProperty| |htPage| '|exitFunction| '|bcInputSolveInfo|)
      (|bcInputEquations| |htPage| '|exact|)))))

; bcSystemSolveEqns1 htPage ==
;   htpSetProperty(htPage,'systemType,'polynomial)
;   htpSetProperty(htPage,'exitFunction,'bcInputSolveInfo)
;   bcInputEquations(htPage,'exact)

(DEFUN |bcSystemSolveEqns1| (|htPage|)
  (PROG ()
    (RETURN
     (PROGN
      (|htpSetProperty| |htPage| '|systemType| '|polynomial|)
      (|htpSetProperty| |htPage| '|exitFunction| '|bcInputSolveInfo|)
      (|bcInputEquations| |htPage| '|exact|)))))

; bcLinearSolveEqns1 htPage ==
;   htpSetProperty(htPage,'systemType,'linear)
;   htpSetProperty(htPage,'exitFunction,'bcLinearSolveEqnsGen)
;   bcInputEquations(htPage,'exact)

(DEFUN |bcLinearSolveEqns1| (|htPage|)
  (PROG ()
    (RETURN
     (PROGN
      (|htpSetProperty| |htPage| '|systemType| '|linear|)
      (|htpSetProperty| |htPage| '|exitFunction| '|bcLinearSolveEqnsGen|)
      (|bcInputEquations| |htPage| '|exact|)))))

; bcInputSolveInfo htPage ==
;   page := htInitPage('"Solve Basic Command", htpPropertyList htPage)
;   htpSetProperty(page,'numberOfEquations,htpProperty(htPage,'numberOfEquations))
;   htpSetProperty(page,'inputArea,htpInputAreaAlist htPage)
;   htMakePage '(
;    (domainConditions (isDomain PI (PositiveInteger)))
;    (text . "What would you like?")
;    (text . "\beginmenu")
;    (text . "\item ")
;    (bcLinks ("\menuitemstyle{Exact Solutions}" "" bcSolveEquations exact))
;    (text . "\indentrel{18}\tab{0} ")
;    (text . "Solutions expressed in terms of {\em roots} of irreducible polynomials")
;    (text . "\indentrel{-18}")
;    (text . "\item ")
;    (bcLinks ("\menuitemstyle{Numeric Solutions}" "" bcSolveEquationsNumerically numeric))
;    (text . "\indentrel{18}\tab{0} ")
;    (text . "Solutions expressed in terms of approximate real or complex {\em numbers}")
;    (text . "\indentrel{-18}")
;    (text . "\item ")
;    (bcLinks ("\menuitemstyle{Radical Solutions}" "" bcSolveEquations radical))
;    (text . "\indentrel{18}\tab{0} ")
;    (text . "Solutions expressed in terms of {\em radicals} if it is possible")
;    (text . "\indentrel{-18}")
;    (text . "\endmenu"))
;   htShowPage()

(DEFUN |bcInputSolveInfo| (|htPage|)
  (PROG (|page|)
    (RETURN
     (PROGN
      (SETQ |page|
              (|htInitPage| "Solve Basic Command"
               (|htpPropertyList| |htPage|)))
      (|htpSetProperty| |page| '|numberOfEquations|
       (|htpProperty| |htPage| '|numberOfEquations|))
      (|htpSetProperty| |page| '|inputArea| (|htpInputAreaAlist| |htPage|))
      (|htMakePage|
       '((|domainConditions| (|isDomain| PI (|PositiveInteger|)))
         (|text| . "What would you like?") (|text| . "\\beginmenu")
         (|text| . "\\item ")
         (|bcLinks|
          ("\\menuitemstyle{Exact Solutions}" "" |bcSolveEquations| |exact|))
         (|text| . "\\indentrel{18}\\tab{0} ")
         (|text|
          . "Solutions expressed in terms of {\\em roots} of irreducible polynomials")
         (|text| . "\\indentrel{-18}") (|text| . "\\item ")
         (|bcLinks|
          ("\\menuitemstyle{Numeric Solutions}" ""
           |bcSolveEquationsNumerically| |numeric|))
         (|text| . "\\indentrel{18}\\tab{0} ")
         (|text|
          . "Solutions expressed in terms of approximate real or complex {\\em numbers}")
         (|text| . "\\indentrel{-18}") (|text| . "\\item ")
         (|bcLinks|
          ("\\menuitemstyle{Radical Solutions}" "" |bcSolveEquations|
           |radical|))
         (|text| . "\\indentrel{18}\\tab{0} ")
         (|text|
          . "Solutions expressed in terms of {\\em radicals} if it is possible")
         (|text| . "\\indentrel{-18}") (|text| . "\\endmenu")))
      (|htShowPage|)))))

; bcInputEquations(htPage,solutionMethod) ==
;   numEqs :=
;     htpProperty(htPage, 'systemType) = 'onePolynomial => 1
;     $bcParseOnly => PARSE_-INTEGER htpLabelInputString(htPage,'numberOfEquations)
;     objValUnwrap htpLabelSpadValue(htPage, 'numberOfEquations)
;   linearPred := htpProperty(htPage,'systemType) = 'linear
;   labelList :=
;     numEqs = 1 => '(
;       (bcStrings (42 "x^2+1" l1 P))
;       (text . " = ")
;       (bcStrings (6 0 r1 P)))
;     "append"/[f(i,numEqs,linearPred) for i in 1..numEqs] where f(i,n,linearp) ==
;       spacer := (i > 99 => 0; i > 9 => 1; 2)
;       prefix := STRCONC('"\newline\tab{2}{\em Equation ",STRINGIMAGE i,'":}")
;       prefix := STRCONC(prefix,'"\space{",STRINGIMAGE spacer,'"}")
;       lnam := INTERN STRCONC('"l",STRINGIMAGE i)
;       rnam := INTERN STRCONC('"r",STRINGIMAGE i)
;       var:=
;         linearp => bcMakeLinearEquations(i,n)
;         bcMakeEquations(i,n)
;       [['text,:prefix],['bcStrings,[30,var,lnam,'P]],'(text . " = "),['bcStrings,[5,"0",rnam,'P]]]
;   equationPart := [
;      '(domainConditions
;         (isDomain P (Polynomial $EmptyMode))
;          (isDomain S (String))
;           (isDomain PI (PositiveInteger))),
;             :labelList]
;   page := htInitPage('"Solve Basic Command", htpPropertyList htPage)
;   htpSetProperty(page, 'numberOfEquations, numEqs)
;   htpSetProperty(page, 'solutionMethod,solutionMethod)
;   htSay '"\newline\menuitemstyle{}\tab{2}"
;   htSay
;     numEqs = 1 => '"Enter the {\em Equation}:"
;     '"Enter the {\em Equations}:"
;   htSay '"\newline\tab{2}"
;   htMakePage equationPart
;   bcHt '"\blankline "
;   htSay '"\newline\menuitemstyle{}\tab{2}"
;   htMakePage
;     numEqs = 1 =>  '(
;       (text ."Enter the {\em unknown} (leave blank if implied): ")
;       (text . "\tab{48}")
;       (bcStrings (6 "x" unknowns S . quoteString)))
;     ['(text . "Enter the unknowns (leave blank if implied):"),
;      '(text . "\tab{44}"),
;       ['bcStrings, [10,bcMakeUnknowns(numEqs),'unknowns,'P]]]
;   htMakeDoneButton('"Continue", 'bcInputEquationsEnd)
;   htShowPage()

(DEFUN |bcInputEquations| (|htPage| |solutionMethod|)
  (PROG (|numEqs| |linearPred| |labelList| |equationPart| |page|)
    (RETURN
     (PROGN
      (SETQ |numEqs|
              (COND
               ((EQ (|htpProperty| |htPage| '|systemType|) '|onePolynomial|) 1)
               (|$bcParseOnly|
                (PARSE-INTEGER
                 (|htpLabelInputString| |htPage| '|numberOfEquations|)))
               (#1='T
                (|objValUnwrap|
                 (|htpLabelSpadValue| |htPage| '|numberOfEquations|)))))
      (SETQ |linearPred| (EQ (|htpProperty| |htPage| '|systemType|) '|linear|))
      (SETQ |labelList|
              (COND
               ((EQL |numEqs| 1)
                '((|bcStrings| (42 "x^2+1" |l1| P)) (|text| . " = ")
                  (|bcStrings| (6 0 |r1| P))))
               (#1#
                ((LAMBDA (|bfVar#1| |i|)
                   (LOOP
                    (COND ((> |i| |numEqs|) (RETURN |bfVar#1|))
                          (#1#
                           (SETQ |bfVar#1|
                                   (APPEND |bfVar#1|
                                           (|bcInputEquations,f| |i| |numEqs|
                                            |linearPred|)))))
                    (SETQ |i| (+ |i| 1))))
                 NIL 1))))
      (SETQ |equationPart|
              (CONS
               '(|domainConditions| (|isDomain| P (|Polynomial| |$EmptyMode|))
                 (|isDomain| S (|String|)) (|isDomain| PI (|PositiveInteger|)))
               |labelList|))
      (SETQ |page|
              (|htInitPage| "Solve Basic Command"
               (|htpPropertyList| |htPage|)))
      (|htpSetProperty| |page| '|numberOfEquations| |numEqs|)
      (|htpSetProperty| |page| '|solutionMethod| |solutionMethod|)
      (|htSay| "\\newline\\menuitemstyle{}\\tab{2}")
      (|htSay|
       (COND ((EQL |numEqs| 1) "Enter the {\\em Equation}:")
             (#1# "Enter the {\\em Equations}:")))
      (|htSay| "\\newline\\tab{2}")
      (|htMakePage| |equationPart|)
      (|bcHt| "\\blankline ")
      (|htSay| "\\newline\\menuitemstyle{}\\tab{2}")
      (|htMakePage|
       (COND
        ((EQL |numEqs| 1)
         '((|text| . "Enter the {\\em unknown} (leave blank if implied): ")
           (|text| . "\\tab{48}")
           (|bcStrings| (6 "x" |unknowns| S . |quoteString|))))
        (#1#
         (LIST '(|text| . "Enter the unknowns (leave blank if implied):")
               '(|text| . "\\tab{44}")
               (LIST '|bcStrings|
                     (LIST 10 (|bcMakeUnknowns| |numEqs|) '|unknowns| 'P))))))
      (|htMakeDoneButton| "Continue" '|bcInputEquationsEnd|)
      (|htShowPage|)))))
(DEFUN |bcInputEquations,f| (|i| |n| |linearp|)
  (PROG (|spacer| |prefix| |lnam| |rnam| |var|)
    (RETURN
     (PROGN
      (SETQ |spacer| (COND ((< 99 |i|) 0) ((< 9 |i|) 1) (#1='T 2)))
      (SETQ |prefix|
              (STRCONC "\\newline\\tab{2}{\\em Equation " (STRINGIMAGE |i|)
               ":}"))
      (SETQ |prefix| (STRCONC |prefix| "\\space{" (STRINGIMAGE |spacer|) "}"))
      (SETQ |lnam| (INTERN (STRCONC "l" (STRINGIMAGE |i|))))
      (SETQ |rnam| (INTERN (STRCONC "r" (STRINGIMAGE |i|))))
      (SETQ |var|
              (COND (|linearp| (|bcMakeLinearEquations| |i| |n|))
                    (#1# (|bcMakeEquations| |i| |n|))))
      (LIST (CONS '|text| |prefix|)
            (LIST '|bcStrings| (LIST 30 |var| |lnam| 'P)) '(|text| . " = ")
            (LIST '|bcStrings| (LIST 5 '|0| |rnam| 'P)))))))

; bcCreateVariableString(i) ==
;    STRCONC('"x",STRINGIMAGE i)

(DEFUN |bcCreateVariableString| (|i|)
  (PROG () (RETURN (STRCONC "x" (STRINGIMAGE |i|)))))

; bcMakeUnknowns(number)==
;    concatenateStringList([STRCONC(bcCreateVariableString(i)," ")
;                             for i in 1..number])

(DEFUN |bcMakeUnknowns| (|number|)
  (PROG ()
    (RETURN
     (|concatenateStringList|
      ((LAMBDA (|bfVar#2| |i|)
         (LOOP
          (COND ((> |i| |number|) (RETURN (NREVERSE |bfVar#2|)))
                ('T
                 (SETQ |bfVar#2|
                         (CONS (STRCONC (|bcCreateVariableString| |i|) '| |)
                               |bfVar#2|))))
          (SETQ |i| (+ |i| 1))))
       NIL 1)))))

; bcMakeEquations(i,number)==
;    number =1 => STRCONC(bcCreateVariableString(1),"^2+1")
;    bcCreateVariableString(i)
;    STRCONC(
;      STRCONC(
;       concatenateStringList([STRCONC(bcCreateVariableString(j),"+")
;                                for j in 1..number]),"1"),
;         STRCONC("-2*",STRCONC(bcCreateVariableString(i),"^2")))

(DEFUN |bcMakeEquations| (|i| |number|)
  (PROG ()
    (RETURN
     (COND ((EQL |number| 1) (STRCONC (|bcCreateVariableString| 1) '|^2+1|))
           (#1='T
            (PROGN
             (|bcCreateVariableString| |i|)
             (STRCONC
              (STRCONC
               (|concatenateStringList|
                ((LAMBDA (|bfVar#3| |j|)
                   (LOOP
                    (COND ((> |j| |number|) (RETURN (NREVERSE |bfVar#3|)))
                          (#1#
                           (SETQ |bfVar#3|
                                   (CONS
                                    (STRCONC (|bcCreateVariableString| |j|) '+)
                                    |bfVar#3|))))
                    (SETQ |j| (+ |j| 1))))
                 NIL 1))
               '|1|)
              (STRCONC '-2*
               (STRCONC (|bcCreateVariableString| |i|) '|^2|)))))))))

; bcMakeLinearEquations(i,number)==
;    number = 1 => bcCreateVariableString(1)
;    number = 2 =>
;         i=1 => STRCONC(bcCreateVariableString(1),STRCONC("+",bcCreateVariableString(2)))
;         STRCONC(bcCreateVariableString(1),STRCONC("-",bcCreateVariableString(2)))
;    STRCONC(
;      STRCONC(
;       concatenateStringList([STRCONC(bcCreateVariableString(j),"+")
;                                for j in 1..number]),"1"),
;         STRCONC("-2*",bcCreateVariableString(i)))

(DEFUN |bcMakeLinearEquations| (|i| |number|)
  (PROG ()
    (RETURN
     (COND ((EQL |number| 1) (|bcCreateVariableString| 1))
           ((EQL |number| 2)
            (COND
             ((EQL |i| 1)
              (STRCONC (|bcCreateVariableString| 1)
               (STRCONC '+ (|bcCreateVariableString| 2))))
             (#1='T
              (STRCONC (|bcCreateVariableString| 1)
               (STRCONC '- (|bcCreateVariableString| 2))))))
           (#1#
            (STRCONC
             (STRCONC
              (|concatenateStringList|
               ((LAMBDA (|bfVar#4| |j|)
                  (LOOP
                   (COND ((> |j| |number|) (RETURN (NREVERSE |bfVar#4|)))
                         (#1#
                          (SETQ |bfVar#4|
                                  (CONS
                                   (STRCONC (|bcCreateVariableString| |j|) '+)
                                   |bfVar#4|))))
                   (SETQ |j| (+ |j| 1))))
                NIL 1))
              '|1|)
             (STRCONC '-2* (|bcCreateVariableString| |i|))))))))

; bcInputEquationsEnd htPage ==
;   fun := htpProperty(htPage, 'exitFunction) => FUNCALL(fun,htPage)
;   systemError nil

(DEFUN |bcInputEquationsEnd| (|htPage|)
  (PROG (|fun|)
    (RETURN
     (COND
      ((SETQ |fun| (|htpProperty| |htPage| '|exitFunction|))
       (FUNCALL |fun| |htPage|))
      ('T (|systemError| NIL))))))

; bcSolveEquationsNumerically(htPage,p) ==
;   page := htInitPage('"Solve Basic Command", htpPropertyList htPage)
;   htMakePage '(
;     (text . "What would you like?")
;     (radioButtons choice
;       ("Real roots expressed as rational numbers" "" rr)
;       ("Real roots expressed as floats" "" rf)
;       ("Complex roots expressed as rational numbers" "" cr)
;       ("Complex roots expressed as floats" "" cf))
;       (text . "\vspace{1}\newline")
;       (inputStrings
;         ("Enter the number of desired {\em digits} of accuracy" "" 5 20 acc PI)))
;   htMakeDoneButton('"Continue", 'bcSolveNumerically1)
;   htShowPage()

(DEFUN |bcSolveEquationsNumerically| (|htPage| |p|)
  (PROG (|page|)
    (RETURN
     (PROGN
      (SETQ |page|
              (|htInitPage| "Solve Basic Command"
               (|htpPropertyList| |htPage|)))
      (|htMakePage|
       '((|text| . "What would you like?")
         (|radioButtons| |choice|
          ("Real roots expressed as rational numbers" "" |rr|)
          ("Real roots expressed as floats" "" |rf|)
          ("Complex roots expressed as rational numbers" "" |cr|)
          ("Complex roots expressed as floats" "" |cf|))
         (|text| . "\\vspace{1}\\newline")
         (|inputStrings|
          ("Enter the number of desired {\\em digits} of accuracy" "" 5 20
           |acc| PI))))
      (|htMakeDoneButton| "Continue" '|bcSolveNumerically1|)
      (|htShowPage|)))))

; bcSolveNumerically1(htPage) ==
;  bcSolveEquations(htPage,'numeric)

(DEFUN |bcSolveNumerically1| (|htPage|)
  (PROG () (RETURN (|bcSolveEquations| |htPage| '|numeric|))))

; bcSolveEquations(htPage,solutionMethod) ==
;   if solutionMethod = 'numeric then
;     digits := htpLabelInputString(htPage,'acc)
;     kind := htpButtonValue(htPage,'choice)
;     accString :=
;       kind in '(rf cf) => STRCONC('"1.e-",digits)
;       STRCONC('"1/10^",digits)
;   alist := htpProperty(htPage,'inputArea)
;   [[.,varpart,:.],:r] := alist
;   varlist := bcString2WordList varpart
;   varString := (rest varlist => bcwords2liststring varlist; first varlist)
;   eqnString := bcGenEquations r
;   solutionMethod = 'numeric =>
;     name :=
;       kind in '(rf rr) => '"solve"
;       '"complexSolve"
;     bcFinish(name,eqnString,accString)
;   name :=
;     solutionMethod = 'radical => '"radicalSolve"
;     '"solve"
;   bcFinish(name,eqnString,varString,accString)

(DEFUN |bcSolveEquations| (|htPage| |solutionMethod|)
  (PROG (|digits| |kind| |accString| |alist| |varpart| |r| |varlist|
         |varString| |eqnString| |name|)
    (RETURN
     (PROGN
      (COND
       ((EQ |solutionMethod| '|numeric|)
        (SETQ |digits| (|htpLabelInputString| |htPage| '|acc|))
        (SETQ |kind| (|htpButtonValue| |htPage| '|choice|))
        (SETQ |accString|
                (COND
                 ((|member| |kind| '(|rf| |cf|)) (STRCONC "1.e-" |digits|))
                 (#1='T (STRCONC "1/10^" |digits|))))))
      (SETQ |alist| (|htpProperty| |htPage| '|inputArea|))
      (SETQ |varpart| (CADAR |alist|))
      (SETQ |r| (CDR |alist|))
      (SETQ |varlist| (|bcString2WordList| |varpart|))
      (SETQ |varString|
              (COND ((CDR |varlist|) (|bcwords2liststring| |varlist|))
                    (#1# (CAR |varlist|))))
      (SETQ |eqnString| (|bcGenEquations| |r|))
      (COND
       ((EQ |solutionMethod| '|numeric|)
        (PROGN
         (SETQ |name|
                 (COND ((|member| |kind| '(|rf| |rr|)) "solve")
                       (#1# "complexSolve")))
         (|bcFinish| |name| |eqnString| |accString|)))
       (#1#
        (PROGN
         (SETQ |name|
                 (COND ((EQ |solutionMethod| '|radical|) "radicalSolve")
                       (#1# "solve")))
         (|bcFinish| |name| |eqnString| |varString| |accString|))))))))

; bcLinearSolveMatrix(htPage,junk) ==
;   bcReadMatrix 'bcLinearSolveMatrix1

(DEFUN |bcLinearSolveMatrix| (|htPage| |junk|)
  (PROG () (RETURN (|bcReadMatrix| '|bcLinearSolveMatrix1|))))

; bcLinearSolveMatrix1 htPage ==
;   page := htInitPage('"Linear Solve Basic Command",htpPropertyList htPage)
;   htpSetProperty(page,'matrix,bcLinearExtractMatrix htPage)
;   htMakePage '(
;     (text . "The right side vector B is:")
;     (lispLinks
;       ("Zero:" "the system is homogeneous" bcLinearSolveMatrixHomo homo)
;       ("Not zero:" "the system is not homogeneous" bcLinearSolveMatrixInhomo nothomo)))
;   htShowPage()

(DEFUN |bcLinearSolveMatrix1| (|htPage|)
  (PROG (|page|)
    (RETURN
     (PROGN
      (SETQ |page|
              (|htInitPage| "Linear Solve Basic Command"
               (|htpPropertyList| |htPage|)))
      (|htpSetProperty| |page| '|matrix| (|bcLinearExtractMatrix| |htPage|))
      (|htMakePage|
       '((|text| . "The right side vector B is:")
         (|lispLinks|
          ("Zero:" "the system is homogeneous" |bcLinearSolveMatrixHomo|
           |homo|)
          ("Not zero:" "the system is not homogeneous"
           |bcLinearSolveMatrixInhomo| |nothomo|))))
      (|htShowPage|)))))

; bcLinearExtractMatrix htPage == REVERSE htpInputAreaAlist htPage

(DEFUN |bcLinearExtractMatrix| (|htPage|)
  (PROG () (RETURN (REVERSE (|htpInputAreaAlist| |htPage|)))))

; bcLinearSolveMatrixInhomo(htPage,junk) ==
;   nrows := htpProperty(htPage,'nrows)
;   ncols := htpProperty(htPage,'ncols)
;   labelList :=
;     [f(i) for i in 1..ncols] where f(i) ==
;       spacer := (i > 99 => 0; i > 9 => 1; 2)
;       prefix := STRCONC('"{\em Coefficient ",STRINGIMAGE i,'":}")
;       if spacer ~= 0 then
;         prefix := STRCONC(prefix,'"\space{",STRINGIMAGE spacer,'"}")
;       name := INTERN STRCONC('"c",STRINGIMAGE i)
;       [prefix,"",30, 0,name, 'P]
;   page := htInitPage('"Linear Solve Basic Command",htpPropertyList htPage)
;   htpSetProperty(page,'matrix,htpProperty(htPage,'matrix))
;   htpSetProperty(page,'nrows,nrows)
;   htpSetProperty(page,'ncols,ncols)
;   htMakePage [
;    '(domainConditions (isDomain P (Polynomial $EmptyMode))),
;     '(text . "Enter the right side vector B:"),
;         ['inputStrings, :labelList],
;           '(text . "\vspace{1}\newline Do you want:" ),
;              '(lispLinks
;                  ("All the solutions?" "" bcLinearSolveMatrixInhomoGen all)
;                   ("A particular solution?" "" bcLinearSolveMatrixInhomoGen particular))]
;   htShowPage()

(DEFUN |bcLinearSolveMatrixInhomo| (|htPage| |junk|)
  (PROG (|nrows| |ncols| |labelList| |page|)
    (RETURN
     (PROGN
      (SETQ |nrows| (|htpProperty| |htPage| '|nrows|))
      (SETQ |ncols| (|htpProperty| |htPage| '|ncols|))
      (SETQ |labelList|
              ((LAMBDA (|bfVar#5| |i|)
                 (LOOP
                  (COND ((> |i| |ncols|) (RETURN (NREVERSE |bfVar#5|)))
                        ('T
                         (SETQ |bfVar#5|
                                 (CONS (|bcLinearSolveMatrixInhomo,f| |i|)
                                       |bfVar#5|))))
                  (SETQ |i| (+ |i| 1))))
               NIL 1))
      (SETQ |page|
              (|htInitPage| "Linear Solve Basic Command"
               (|htpPropertyList| |htPage|)))
      (|htpSetProperty| |page| '|matrix| (|htpProperty| |htPage| '|matrix|))
      (|htpSetProperty| |page| '|nrows| |nrows|)
      (|htpSetProperty| |page| '|ncols| |ncols|)
      (|htMakePage|
       (LIST '(|domainConditions| (|isDomain| P (|Polynomial| |$EmptyMode|)))
             '(|text| . "Enter the right side vector B:")
             (CONS '|inputStrings| |labelList|)
             '(|text| . "\\vspace{1}\\newline Do you want:")
             '(|lispLinks|
               ("All the solutions?" "" |bcLinearSolveMatrixInhomoGen| |all|)
               ("A particular solution?" "" |bcLinearSolveMatrixInhomoGen|
                |particular|))))
      (|htShowPage|)))))
(DEFUN |bcLinearSolveMatrixInhomo,f| (|i|)
  (PROG (|spacer| |prefix| |name|)
    (RETURN
     (PROGN
      (SETQ |spacer| (COND ((< 99 |i|) 0) ((< 9 |i|) 1) ('T 2)))
      (SETQ |prefix| (STRCONC "{\\em Coefficient " (STRINGIMAGE |i|) ":}"))
      (COND
       ((NOT (EQL |spacer| 0))
        (SETQ |prefix|
                (STRCONC |prefix| "\\space{" (STRINGIMAGE |spacer|) "}"))))
      (SETQ |name| (INTERN (STRCONC "c" (STRINGIMAGE |i|))))
      (LIST |prefix| '|| 30 0 |name| 'P)))))

; bcLinearSolveMatrixInhomoGen(htPage,key) ==  bcLinearMatrixGen(htPage,key)

(DEFUN |bcLinearSolveMatrixInhomoGen| (|htPage| |key|)
  (PROG () (RETURN (|bcLinearMatrixGen| |htPage| |key|))))

; bcLinearSolveMatrixHomo(htPage,key) == bcLinearMatrixGen(htPage,'homo)

(DEFUN |bcLinearSolveMatrixHomo| (|htPage| |key|)
  (PROG () (RETURN (|bcLinearMatrixGen| |htPage| '|homo|))))

; bcLinearMatrixGen(htPage,key) ==
;   matform := bcMatrixGen htPage
;   key = 'homo => bcFinish('"nullSpace",matform)
;   vector := [x.1 for x in REVERSE htpInputAreaAlist htPage]
;   vecform := bcVectorGen vector
;   form := bcMkFunction('"solve",matform,[vecform])
;   bcGen
;     key = 'particular => STRCONC(form,'".particular")
;     form

(DEFUN |bcLinearMatrixGen| (|htPage| |key|)
  (PROG (|matform| |vector| |vecform| |form|)
    (RETURN
     (PROGN
      (SETQ |matform| (|bcMatrixGen| |htPage|))
      (COND ((EQ |key| '|homo|) (|bcFinish| "nullSpace" |matform|))
            (#1='T
             (PROGN
              (SETQ |vector|
                      ((LAMBDA (|bfVar#7| |bfVar#6| |x|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#6|)
                                (PROGN (SETQ |x| (CAR |bfVar#6|)) NIL))
                            (RETURN (NREVERSE |bfVar#7|)))
                           (#1# (SETQ |bfVar#7| (CONS (ELT |x| 1) |bfVar#7|))))
                          (SETQ |bfVar#6| (CDR |bfVar#6|))))
                       NIL (REVERSE (|htpInputAreaAlist| |htPage|)) NIL))
              (SETQ |vecform| (|bcVectorGen| |vector|))
              (SETQ |form| (|bcMkFunction| "solve" |matform| (LIST |vecform|)))
              (|bcGen|
               (COND ((EQ |key| '|particular|) (STRCONC |form| ".particular"))
                     (#1# |form|))))))))))

; linearFinalRequest(nhh,mat,vect) ==
;   sayBrightly '"Do you want more information on the meaning of the output"
;   sayBrightly '"   (1) no "
;   sayBrightly '"   (2) yes "
;   tt := bcQueryInteger(1,2,true)
;   tt=1 => sayBrightly '"Bye Bye"
;   tt=2 => explainLinear(nhh)

(DEFUN |linearFinalRequest| (|nhh| |mat| |vect|)
  (PROG (|tt|)
    (RETURN
     (PROGN
      (|sayBrightly|
       "Do you want more information on the meaning of the output")
      (|sayBrightly| "   (1) no ")
      (|sayBrightly| "   (2) yes ")
      (SETQ |tt| (|bcQueryInteger| 1 2 T))
      (COND ((EQL |tt| 1) (|sayBrightly| "Bye Bye"))
            ((EQL |tt| 2) (|explainLinear| |nhh|)))))))

; explainLinear(flag) ==
;   flag="notHomogeneous" =>
;    '("solve returns a particular solution and a basis for"
;      "the vector space of solutions for the homogeneous part."
;      "The particular solution is _"failed_" if one cannot be found.")
;   flag= "homogeneous" =>
;     '("solve returns a basis for"
;       "the vector space of solutions for the homogeneous part")
;   systemError nil

(DEFUN |explainLinear| (|flag|)
  (PROG ()
    (RETURN
     (COND
      ((EQ |flag| '|notHomogeneous|)
       '("solve returns a particular solution and a basis for"
         "the vector space of solutions for the homogeneous part."
         "The particular solution is \"failed\" if one cannot be found."))
      ((EQ |flag| '|homogeneous|)
       '("solve returns a basis for"
         "the vector space of solutions for the homogeneous part"))
      ('T (|systemError| NIL))))))

; finalExactRequest(equations,unknowns) ==
;   sayBrightly '"Do you like:"
;   sayBrightly '"   (1) the solutions how they are displayed"
;   sayBrightly '"   (2) to get ????"
;   sayBrightly '"   (3) more information on the meaning of the output"
;   tt := bcQueryInteger(1,3,true)
;   tt=1 => sayBrightly '"Bye Bye"
;   tt=2 => moreExactSolution(equations,unknowns,flag)
;   tt=3 => explainExact(equations,unknowns)

(DEFUN |finalExactRequest| (|equations| |unknowns|)
  (PROG (|tt|)
    (RETURN
     (PROGN
      (|sayBrightly| "Do you like:")
      (|sayBrightly| "   (1) the solutions how they are displayed")
      (|sayBrightly| "   (2) to get ????")
      (|sayBrightly| "   (3) more information on the meaning of the output")
      (SETQ |tt| (|bcQueryInteger| 1 3 T))
      (COND ((EQL |tt| 1) (|sayBrightly| "Bye Bye"))
            ((EQL |tt| 2) (|moreExactSolution| |equations| |unknowns| |flag|))
            ((EQL |tt| 3) (|explainExact| |equations| |unknowns|)))))))

; bcLinearSolveEqnsGen htPage ==
;   alist := htpInputAreaAlist htPage
;   if vars := htpLabelInputString(htPage,'unknowns) then
;     varlist := bcString2WordList vars
;     varString := (rest varlist => bcwords2liststring varlist; first varlist)
;     alist := rest alist  --know these are first on the list
;   eqnString := bcGenEquations alist
;   bcFinish('"solve",eqnString,varString)

(DEFUN |bcLinearSolveEqnsGen| (|htPage|)
  (PROG (|alist| |vars| |varlist| |varString| |eqnString|)
    (RETURN
     (PROGN
      (SETQ |alist| (|htpInputAreaAlist| |htPage|))
      (COND
       ((SETQ |vars| (|htpLabelInputString| |htPage| '|unknowns|))
        (SETQ |varlist| (|bcString2WordList| |vars|))
        (SETQ |varString|
                (COND ((CDR |varlist|) (|bcwords2liststring| |varlist|))
                      ('T (CAR |varlist|))))
        (SETQ |alist| (CDR |alist|))))
      (SETQ |eqnString| (|bcGenEquations| |alist|))
      (|bcFinish| "solve" |eqnString| |varString|)))))

; bcGenEquations alist ==
;   y := alist
;   while y repeat
;     right := (first y).1
;     y := rest y
;     left := (first y).1
;     y := rest y
;     eqnlist := [STRCONC(left,'" = ",right),:eqnlist]
;   rest eqnlist => bcwords2liststring eqnlist
;   first eqnlist

(DEFUN |bcGenEquations| (|alist|)
  (PROG (|y| |right| |left| |eqnlist|)
    (RETURN
     (PROGN
      (SETQ |y| |alist|)
      ((LAMBDA ()
         (LOOP
          (COND ((NOT |y|) (RETURN NIL))
                (#1='T
                 (PROGN
                  (SETQ |right| (ELT (CAR |y|) 1))
                  (SETQ |y| (CDR |y|))
                  (SETQ |left| (ELT (CAR |y|) 1))
                  (SETQ |y| (CDR |y|))
                  (SETQ |eqnlist|
                          (CONS (STRCONC |left| " = " |right|)
                                |eqnlist|))))))))
      (COND ((CDR |eqnlist|) (|bcwords2liststring| |eqnlist|))
            (#1# (CAR |eqnlist|)))))))
