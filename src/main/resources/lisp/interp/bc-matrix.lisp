
; )package "BOOT"

(IN-PACKAGE "BOOT")

; bcMatrix() ==  bcReadMatrix nil

(DEFUN |bcMatrix| () (PROG () (RETURN (|bcReadMatrix| NIL))))

; bcReadMatrix exitFunctionOrNil ==
;   page := htInitPage('"Matrix Basic Command", nil)
;   htpSetProperty(page,'exitFunction,exitFunctionOrNil)
;   htMakePage
;    '((domainConditions
;      (isDomain PI (PositiveInteger)))
;     (text . "Enter the size of the matrix:")
;     (inputStrings
;      ("Number of {\em rows}:\space{3}" "" 5 2 rows PI)
;      ("Number of {\em columns}: " "" 5 2 cols PI))
;     (text . "\blankline ")
;     (text . "How would you like to enter the matrix?")
;     (text . "\beginmenu")
;     (text . "\item ")
;     (bcLinks ("\menuitemstyle{By entering individual entries}" "" bcInputExplicitMatrix  explicit))
;     (text . "\item ")
;     (bcLinks ("\menuitemstyle{By formula}" "" bcInputMatrixByFormula formula))
;     (text . "\endmenu"))
;   htShowPage()

(DEFUN |bcReadMatrix| (|exitFunctionOrNil|)
  (PROG (|page|)
    (RETURN
     (PROGN
      (SETQ |page| (|htInitPage| "Matrix Basic Command" NIL))
      (|htpSetProperty| |page| '|exitFunction| |exitFunctionOrNil|)
      (|htMakePage|
       '((|domainConditions| (|isDomain| PI (|PositiveInteger|)))
         (|text| . "Enter the size of the matrix:")
         (|inputStrings| ("Number of {\\em rows}:\\space{3}" "" 5 2 |rows| PI)
          ("Number of {\\em columns}: " "" 5 2 |cols| PI))
         (|text| . "\\blankline ")
         (|text| . "How would you like to enter the matrix?")
         (|text| . "\\beginmenu") (|text| . "\\item ")
         (|bcLinks|
          ("\\menuitemstyle{By entering individual entries}" ""
           |bcInputExplicitMatrix| |explicit|))
         (|text| . "\\item ")
         (|bcLinks|
          ("\\menuitemstyle{By formula}" "" |bcInputMatrixByFormula|
           |formula|))
         (|text| . "\\endmenu")))
      (|htShowPage|)))))

; bcInputMatrixByFormula(htPage,junk) ==
;   page := htInitPage('"Basic Matrix Command", htpPropertyList htPage)
;   htMakePage '(
;     (domainConditions
;       (isDomain S (Symbol))
;       (isDomain FE (Expression (Integer))))
;     (text . "\menuitemstyle{}\tab{2}")
;     (text . "Enter the {\em row variable}: ")
;     (text . "\tab{36}")
;     (bcStrings (6 i rowVar S))
;     (text . "\blankline ")
;     (text . "\newline ")
;     (text . "\menuitemstyle{}\tab{2}")
;     (text . "Enter the {\em column variable}: ")
;     (text . "\tab{36}")
;     (bcStrings (6 j colVar S))
;     (text . "\blankline ")
;     (text . "\newline ")
;     (text . "\menuitemstyle{}\tab{2}")
;     (text .  "Enter the general {\em formula} for the entries:")
;     (text . "\newline\tab{2} ")
;     (bcStrings (40 "1/(x - i - j - 1)" formula FE)))
;   htMakeDoneButton('"Continue", 'bcInputMatrixByFormulaGen)
;   nrows :=
;     null $bcParseOnly => objValUnwrap htpLabelSpadValue(htPage,'rows)
;     PARSE_-INTEGER htpLabelInputString(htPage,'rows)
;   ncols :=
;     null $bcParseOnly => objValUnwrap htpLabelSpadValue(htPage,'cols)
;     PARSE_-INTEGER htpLabelInputString(htPage,'cols)
;   htpSetProperty(page, 'nrows, nrows)
;   htpSetProperty(page, 'ncols, ncols)
;   htShowPage()

(DEFUN |bcInputMatrixByFormula| (|htPage| |junk|)
  (PROG (|page| |nrows| |ncols|)
    (RETURN
     (PROGN
      (SETQ |page|
              (|htInitPage| "Basic Matrix Command"
               (|htpPropertyList| |htPage|)))
      (|htMakePage|
       '((|domainConditions| (|isDomain| S (|Symbol|))
          (|isDomain| FE (|Expression| (|Integer|))))
         (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text| . "Enter the {\\em row variable}: ") (|text| . "\\tab{36}")
         (|bcStrings| (6 |i| |rowVar| S)) (|text| . "\\blankline ")
         (|text| . "\\newline ") (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text| . "Enter the {\\em column variable}: ") (|text| . "\\tab{36}")
         (|bcStrings| (6 |j| |colVar| S)) (|text| . "\\blankline ")
         (|text| . "\\newline ") (|text| . "\\menuitemstyle{}\\tab{2}")
         (|text| . "Enter the general {\\em formula} for the entries:")
         (|text| . "\\newline\\tab{2} ")
         (|bcStrings| (40 "1/(x - i - j - 1)" |formula| FE))))
      (|htMakeDoneButton| "Continue" '|bcInputMatrixByFormulaGen|)
      (SETQ |nrows|
              (COND
               ((NULL |$bcParseOnly|)
                (|objValUnwrap| (|htpLabelSpadValue| |htPage| '|rows|)))
               (#1='T
                (PARSE-INTEGER (|htpLabelInputString| |htPage| '|rows|)))))
      (SETQ |ncols|
              (COND
               ((NULL |$bcParseOnly|)
                (|objValUnwrap| (|htpLabelSpadValue| |htPage| '|cols|)))
               (#1# (PARSE-INTEGER (|htpLabelInputString| |htPage| '|cols|)))))
      (|htpSetProperty| |page| '|nrows| |nrows|)
      (|htpSetProperty| |page| '|ncols| |ncols|)
      (|htShowPage|)))))

; bcInputMatrixByFormulaGen htPage ==
;   fun :=  htpProperty(htPage,'exitFunction) => FUNCALL(fun, htPage)
;   formula := htpLabelInputString(htPage,'formula)
;   rowVar := htpLabelInputString(htPage,'rowVar)
;   colVar := htpLabelInputString(htPage,'colVar)
;   nrows := htpProperty(htPage,'nrows)
;   ncols := htpProperty(htPage,'ncols)
;   bcGen STRCONC('"matrix([[",formula,'" for ",colVar,'" in 1..",
;     STRINGIMAGE ncols,'"] for ",rowVar,'" in 1..",STRINGIMAGE nrows,'"])")

(DEFUN |bcInputMatrixByFormulaGen| (|htPage|)
  (PROG (|fun| |formula| |rowVar| |colVar| |nrows| |ncols|)
    (RETURN
     (COND
      ((SETQ |fun| (|htpProperty| |htPage| '|exitFunction|))
       (FUNCALL |fun| |htPage|))
      ('T
       (PROGN
        (SETQ |formula| (|htpLabelInputString| |htPage| '|formula|))
        (SETQ |rowVar| (|htpLabelInputString| |htPage| '|rowVar|))
        (SETQ |colVar| (|htpLabelInputString| |htPage| '|colVar|))
        (SETQ |nrows| (|htpProperty| |htPage| '|nrows|))
        (SETQ |ncols| (|htpProperty| |htPage| '|ncols|))
        (|bcGen|
         (STRCONC "matrix([[" |formula| " for " |colVar| " in 1.."
          (STRINGIMAGE |ncols|) "] for " |rowVar| " in 1.."
          (STRINGIMAGE |nrows|) "])"))))))))

; bcInputExplicitMatrix(htPage,junk) ==
;   nrows :=
;     null $bcParseOnly => objValUnwrap htpLabelSpadValue(htPage,'rows)
;     PARSE_-INTEGER htpLabelInputString(htPage,'rows)
;   ncols :=
;     null $bcParseOnly => objValUnwrap htpLabelSpadValue(htPage,'cols)
;     PARSE_-INTEGER htpLabelInputString(htPage,'cols)
;   cond := nil
;   k := 0
;   wrows := # STRINGIMAGE nrows
;   wcols := # STRINGIMAGE ncols
;   labelList :=
;     "append"/[[f for j in 1..ncols] for i in 1..nrows] where f ==
;       rowpart := STRCONC('"{\em Row",htStringPad(i,wrows))
;       colpart := STRCONC('", Column",htStringPad(j,wcols),'":}\space{2}")
;       prefix := STRCONC(rowpart,colpart)
;  --     name := INTERN STRCONC(htMkName('"row",i),htMkName('"col",j))
;       name := INTERN STRINGIMAGE (k := k + 1)
;       [prefix,'"",30, 0,name,'P]
;   labelList :=
;     [['domainConditions, '(isDomain P (Polynomial $EmptyMode)), cond],
;      ['inputStrings, :labelList] ]
;   page := htInitPage('"Solve Basic Command", htpPropertyList htPage)
;   bcHt '"Enter the entries of the matrix:"
;   htMakePage labelList
;   htMakeDoneButton('"Continue", 'bcGenExplicitMatrix)
;   htpSetProperty(page,'nrows,nrows)
;   htpSetProperty(page,'ncols,ncols)
;   htShowPage()

(DEFUN |bcInputExplicitMatrix| (|htPage| |junk|)
  (PROG (|nrows| |ncols| |cond| |k| |wrows| |wcols| |rowpart| |colpart|
         |prefix| |name| |labelList| |page|)
    (RETURN
     (PROGN
      (SETQ |nrows|
              (COND
               ((NULL |$bcParseOnly|)
                (|objValUnwrap| (|htpLabelSpadValue| |htPage| '|rows|)))
               (#1='T
                (PARSE-INTEGER (|htpLabelInputString| |htPage| '|rows|)))))
      (SETQ |ncols|
              (COND
               ((NULL |$bcParseOnly|)
                (|objValUnwrap| (|htpLabelSpadValue| |htPage| '|cols|)))
               (#1# (PARSE-INTEGER (|htpLabelInputString| |htPage| '|cols|)))))
      (SETQ |cond| NIL)
      (SETQ |k| 0)
      (SETQ |wrows| (LENGTH (STRINGIMAGE |nrows|)))
      (SETQ |wcols| (LENGTH (STRINGIMAGE |ncols|)))
      (SETQ |labelList|
              ((LAMBDA (|bfVar#2| |i|)
                 (LOOP
                  (COND ((> |i| |nrows|) (RETURN |bfVar#2|))
                        (#1#
                         (SETQ |bfVar#2|
                                 (APPEND |bfVar#2|
                                         ((LAMBDA (|bfVar#1| |j|)
                                            (LOOP
                                             (COND
                                              ((> |j| |ncols|)
                                               (RETURN (NREVERSE |bfVar#1|)))
                                              (#1#
                                               (SETQ |bfVar#1|
                                                       (CONS
                                                        (PROGN
                                                         (SETQ |rowpart|
                                                                 (STRCONC
                                                                  "{\\em Row"
                                                                  (|htStringPad|
                                                                   |i|
                                                                   |wrows|)))
                                                         (SETQ |colpart|
                                                                 (STRCONC
                                                                  ", Column"
                                                                  (|htStringPad|
                                                                   |j| |wcols|)
                                                                  ":}\\space{2}"))
                                                         (SETQ |prefix|
                                                                 (STRCONC
                                                                  |rowpart|
                                                                  |colpart|))
                                                         (SETQ |name|
                                                                 (INTERN
                                                                  (STRINGIMAGE
                                                                   (SETQ |k|
                                                                           (+
                                                                            |k|
                                                                            1)))))
                                                         (LIST |prefix| "" 30 0
                                                               |name| 'P))
                                                        |bfVar#1|))))
                                             (SETQ |j| (+ |j| 1))))
                                          NIL 1)))))
                  (SETQ |i| (+ |i| 1))))
               NIL 1))
      (SETQ |labelList|
              (LIST
               (LIST '|domainConditions|
                     '(|isDomain| P (|Polynomial| |$EmptyMode|)) |cond|)
               (CONS '|inputStrings| |labelList|)))
      (SETQ |page|
              (|htInitPage| "Solve Basic Command"
               (|htpPropertyList| |htPage|)))
      (|bcHt| "Enter the entries of the matrix:")
      (|htMakePage| |labelList|)
      (|htMakeDoneButton| "Continue" '|bcGenExplicitMatrix|)
      (|htpSetProperty| |page| '|nrows| |nrows|)
      (|htpSetProperty| |page| '|ncols| |ncols|)
      (|htShowPage|)))))

; bcGenExplicitMatrix htPage ==
;   htpSetProperty(htPage,'matrix,htpInputAreaAlist htPage)
;   fun :=  htpProperty(htPage,'exitFunction) => FUNCALL(fun, htPage)
;   bcGen bcMatrixGen htPage

(DEFUN |bcGenExplicitMatrix| (|htPage|)
  (PROG (|fun|)
    (RETURN
     (PROGN
      (|htpSetProperty| |htPage| '|matrix| (|htpInputAreaAlist| |htPage|))
      (COND
       ((SETQ |fun| (|htpProperty| |htPage| '|exitFunction|))
        (FUNCALL |fun| |htPage|))
       ('T (|bcGen| (|bcMatrixGen| |htPage|))))))))

; bcMatrixGen htPage ==
;   nrows := htpProperty(htPage,'nrows)
;   ncols := htpProperty(htPage,'ncols)
;   mat := htpProperty(htPage,'matrix)
;   formula := LASSOC('formula,mat) =>
;     formula := formula.0
;     rowVar := (LASSOC('rowVar, mat)).0
;     colVar := (LASSOC('colVar, mat)).0
;     STRCONC('"matrix([[",formula,'" for ",colVar,'" in 1..",
;       STRINGIMAGE ncols,'"] for ",rowVar,'" in 1..",STRINGIMAGE nrows,'"])")
;   mat := htpProperty(htPage,'matrix) =>
;     mat := REVERSE mat
;     k := -1
;     matform := [[mat.(k := k + 1).1
;       for j in 0..(ncols-1)] for i in 0..(nrows-1)]
;     matstring := bcwords2liststring [bcwords2liststring x for x in matform]
;     STRCONC('"matrix(",matstring,'")")
;   systemError nil

(DEFUN |bcMatrixGen| (|htPage|)
  (PROG (|nrows| |ncols| |mat| |formula| |rowVar| |colVar| |k| |matform|
         |matstring|)
    (RETURN
     (PROGN
      (SETQ |nrows| (|htpProperty| |htPage| '|nrows|))
      (SETQ |ncols| (|htpProperty| |htPage| '|ncols|))
      (SETQ |mat| (|htpProperty| |htPage| '|matrix|))
      (COND
       ((SETQ |formula| (LASSOC '|formula| |mat|))
        (PROGN
         (SETQ |formula| (ELT |formula| 0))
         (SETQ |rowVar| (ELT (LASSOC '|rowVar| |mat|) 0))
         (SETQ |colVar| (ELT (LASSOC '|colVar| |mat|) 0))
         (STRCONC "matrix([[" |formula| " for " |colVar| " in 1.."
          (STRINGIMAGE |ncols|) "] for " |rowVar| " in 1.."
          (STRINGIMAGE |nrows|) "])")))
       ((SETQ |mat| (|htpProperty| |htPage| '|matrix|))
        (PROGN
         (SETQ |mat| (REVERSE |mat|))
         (SETQ |k| (- 1))
         (SETQ |matform|
                 ((LAMBDA (|bfVar#6| |bfVar#5| |i|)
                    (LOOP
                     (COND ((> |i| |bfVar#5|) (RETURN (NREVERSE |bfVar#6|)))
                           (#1='T
                            (SETQ |bfVar#6|
                                    (CONS
                                     ((LAMBDA (|bfVar#4| |bfVar#3| |j|)
                                        (LOOP
                                         (COND
                                          ((> |j| |bfVar#3|)
                                           (RETURN (NREVERSE |bfVar#4|)))
                                          (#1#
                                           (SETQ |bfVar#4|
                                                   (CONS
                                                    (ELT
                                                     (ELT |mat|
                                                          (SETQ |k| (+ |k| 1)))
                                                     1)
                                                    |bfVar#4|))))
                                         (SETQ |j| (+ |j| 1))))
                                      NIL (- |ncols| 1) 0)
                                     |bfVar#6|))))
                     (SETQ |i| (+ |i| 1))))
                  NIL (- |nrows| 1) 0))
         (SETQ |matstring|
                 (|bcwords2liststring|
                  ((LAMBDA (|bfVar#8| |bfVar#7| |x|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#7|)
                            (PROGN (SETQ |x| (CAR |bfVar#7|)) NIL))
                        (RETURN (NREVERSE |bfVar#8|)))
                       (#1#
                        (SETQ |bfVar#8|
                                (CONS (|bcwords2liststring| |x|) |bfVar#8|))))
                      (SETQ |bfVar#7| (CDR |bfVar#7|))))
                   NIL |matform| NIL)))
         (STRCONC "matrix(" |matstring| ")")))
       (#1# (|systemError| NIL)))))))
