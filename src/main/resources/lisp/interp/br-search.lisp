
; )package "BOOT"

(IN-PACKAGE "BOOT")

; getBrowseDatabase(kind) ==
;     $includeUnexposed? : local := true
;     not member(kind,'("o" "k" "c" "d" "p")) => nil
;     grepConstruct('"*", INTERN kind)

(DEFUN |getBrowseDatabase| (|kind|)
  (PROG (|$includeUnexposed?|)
    (DECLARE (SPECIAL |$includeUnexposed?|))
    (RETURN
     (PROGN
      (SETQ |$includeUnexposed?| T)
      (COND ((NULL (|member| |kind| '("o" "k" "c" "d" "p"))) NIL)
            ('T (|grepConstruct| "*" (INTERN |kind|))))))))

; grepConstruct(s,key,:options) == --key = a o c d p x k (all) . (aok) w (doc)
; --Called from genSearch with key = "." and "w"
; --key = "." means a o c d p x
; --option1 = true means return the result as a file
; --All searches of the database call this function to get relevant lines
; --from libdb.text. Returns either a list of lines (usual case) or else
; --an alist of the form ((kind . <list of lines for that kind>) ...)
;   $localLibdb : local := fnameExists? '"libdb.text" and '"libdb.text"
;   lines := grepConstruct1(s,key)
;   lines is ['error,:.] => lines
;   IFCAR options => grepSplit(lines,key = 'w)    --leave now if a constructor
;   MEMQ(key,'(o a)) => dbScreenForDefaultFunctions lines --kill default lines if a/o
;   lines

(DEFUN |grepConstruct| (|s| |key| &REST |options|)
  (PROG (|$localLibdb| |lines|)
    (DECLARE (SPECIAL |$localLibdb|))
    (RETURN
     (PROGN
      (SETQ |$localLibdb| (AND (|fnameExists?| "libdb.text") "libdb.text"))
      (SETQ |lines| (|grepConstruct1| |s| |key|))
      (COND ((AND (CONSP |lines|) (EQ (CAR |lines|) '|error|)) |lines|)
            ((IFCAR |options|) (|grepSplit| |lines| (EQ |key| '|w|)))
            ((MEMQ |key| '(|o| |a|)) (|dbScreenForDefaultFunctions| |lines|))
            ('T |lines|))))))

; grepConstruct1(s,key) ==
; --returns the name of file (WITHOUT .text.$SPADNUM on the end)
;   $key     : local := key
;   if key = 'k and          --convert 'k to 'y if name contains an "&"
;     or/[s . i = char '_& for i in 0..MAXINDEX s] then key := 'y
;   filter := pmTransFilter STRINGIMAGE s  --parses and-or-not form
;   filter is ['error,:.] => filter        --exit on parser error
;   pattern := mkGrepPattern(filter,key)  --create string to pass to "grep"
;   grepConstructDo(pattern, key)

(DEFUN |grepConstruct1| (|s| |key|)
  (PROG (|$key| |pattern| |filter|)
    (DECLARE (SPECIAL |$key|))
    (RETURN
     (PROGN
      (SETQ |$key| |key|)
      (COND
       ((AND (EQ |key| '|k|)
             ((LAMBDA (|bfVar#2| |bfVar#1| |i|)
                (LOOP
                 (COND ((> |i| |bfVar#1|) (RETURN |bfVar#2|))
                       (#1='T
                        (PROGN
                         (SETQ |bfVar#2| (EQUAL (ELT |s| |i|) (|char| '&)))
                         (COND (|bfVar#2| (RETURN |bfVar#2|))))))
                 (SETQ |i| (+ |i| 1))))
              NIL (MAXINDEX |s|) 0))
        (SETQ |key| '|y|)))
      (SETQ |filter| (|pmTransFilter| (STRINGIMAGE |s|)))
      (COND ((AND (CONSP |filter|) (EQ (CAR |filter|) '|error|)) |filter|)
            (#1#
             (PROGN
              (SETQ |pattern| (|mkGrepPattern| |filter| |key|))
              (|grepConstructDo| |pattern| |key|))))))))

; grepConstructDo(x, key) ==
; --atom x => grepFile(x, key,'i)
;   $localLibdb =>
;     oldLines := purgeNewConstructorLines(grepf(x,key,false),$newConstructorList)
;     newLines := grepf(x,$localLibdb,false)
;     union(oldLines, newLines)
;   grepf(x,key,false)

(DEFUN |grepConstructDo| (|x| |key|)
  (PROG (|oldLines| |newLines|)
    (RETURN
     (COND
      (|$localLibdb|
       (PROGN
        (SETQ |oldLines|
                (|purgeNewConstructorLines| (|grepf| |x| |key| NIL)
                 |$newConstructorList|))
        (SETQ |newLines| (|grepf| |x| |$localLibdb| NIL))
        (|union| |oldLines| |newLines|)))
      ('T (|grepf| |x| |key| NIL))))))

; dbExposed?(line,kind) == -- does line come from an unexposed constructor?
;   conname := INTERN
;     kind = char 'a or kind = char 'o => dbNewConname line --get conname from middle
;     dbName line
;   isExposedConstructor conname

(DEFUN |dbExposed?| (|line| |kind|)
  (PROG (|conname|)
    (RETURN
     (PROGN
      (SETQ |conname|
              (INTERN
               (COND
                ((OR (EQUAL |kind| (|char| '|a|)) (EQUAL |kind| (|char| '|o|)))
                 (|dbNewConname| |line|))
                ('T (|dbName| |line|)))))
      (|isExposedConstructor| |conname|)))))

; dbScreenForDefaultFunctions lines == [x for x in lines | not isDefaultOpAtt x]

(DEFUN |dbScreenForDefaultFunctions| (|lines|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#4| |bfVar#3| |x|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#3|) (PROGN (SETQ |x| (CAR |bfVar#3|)) NIL))
           (RETURN (NREVERSE |bfVar#4|)))
          ('T
           (AND (NULL (|isDefaultOpAtt| |x|))
                (SETQ |bfVar#4| (CONS |x| |bfVar#4|)))))
         (SETQ |bfVar#3| (CDR |bfVar#3|))))
      NIL |lines| NIL))))

; isDefaultOpAtt x == x.(1 + dbTickIndex(x,4,0)) = char 'x

(DEFUN |isDefaultOpAtt| (|x|)
  (PROG ()
    (RETURN (EQUAL (ELT |x| (+ 1 (|dbTickIndex| |x| 4 0))) (|char| '|x|)))))

; grepForAbbrev(s,key) ==
; --checks that filter s is not * and is all uppercase; if so, look for abbrevs
;   u := HGET($lowerCaseConTb,s) => ['Abbreviations,u]    --try cheap test first
;   s := STRINGIMAGE s
;   someLowerCaseChar := false
;   someUpperCaseChar := false
;   for i in 0..MAXINDEX s repeat
;     c := s . i
;     LOWER_-CASE_-P c => return (someLowerCaseChar := true)
;     UPPER_-CASE_-P c => someUpperCaseChar := true
;   someLowerCaseChar or not someUpperCaseChar => false
;   pattern := DOWNCASE s
;   ['Abbreviations ,:[GETDATABASE(x,'CONSTRUCTORFORM)
;     for x in allConstructors() | test]] where test ==
;          not $includeUnexposed? and not isExposedConstructor x => false
;          a := GETDATABASE(x,'ABBREVIATION)
;          match?(pattern,PNAME a) and not HGET($defaultPackageNamesHT,x)

(DEFUN |grepForAbbrev| (|s| |key|)
  (PROG (|u| |someLowerCaseChar| |someUpperCaseChar| |c| |pattern| |a|)
    (RETURN
     (COND
      ((SETQ |u| (HGET |$lowerCaseConTb| |s|)) (LIST '|Abbreviations| |u|))
      (#1='T
       (PROGN
        (SETQ |s| (STRINGIMAGE |s|))
        (SETQ |someLowerCaseChar| NIL)
        (SETQ |someUpperCaseChar| NIL)
        ((LAMBDA (|bfVar#5| |i|)
           (LOOP
            (COND ((> |i| |bfVar#5|) (RETURN NIL))
                  (#1#
                   (PROGN
                    (SETQ |c| (ELT |s| |i|))
                    (COND
                     ((LOWER-CASE-P |c|) (RETURN (SETQ |someLowerCaseChar| T)))
                     ((UPPER-CASE-P |c|) (SETQ |someUpperCaseChar| T))))))
            (SETQ |i| (+ |i| 1))))
         (MAXINDEX |s|) 0)
        (COND ((OR |someLowerCaseChar| (NULL |someUpperCaseChar|)) NIL)
              (#1#
               (PROGN
                (SETQ |pattern| (DOWNCASE |s|))
                (CONS '|Abbreviations|
                      ((LAMBDA (|bfVar#7| |bfVar#6| |x|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#6|)
                                (PROGN (SETQ |x| (CAR |bfVar#6|)) NIL))
                            (RETURN (NREVERSE |bfVar#7|)))
                           (#1#
                            (AND
                             (COND
                              ((AND (NULL |$includeUnexposed?|)
                                    (NULL (|isExposedConstructor| |x|)))
                               NIL)
                              (#1#
                               (PROGN
                                (SETQ |a| (GETDATABASE |x| 'ABBREVIATION))
                                (AND (|match?| |pattern| (PNAME |a|))
                                     (NULL
                                      (HGET |$defaultPackageNamesHT| |x|))))))
                             (SETQ |bfVar#7|
                                     (CONS (GETDATABASE |x| 'CONSTRUCTORFORM)
                                           |bfVar#7|)))))
                          (SETQ |bfVar#6| (CDR |bfVar#6|))))
                       NIL (|allConstructors|) NIL)))))))))))

; applyGrep(x,filename) ==
;   atom x => grepFile(x,filename,'i)
;   $localLibdb =>
;     a := purgeNewConstructorLines(grepf(x,filename,false),$newConstructorList)
;     b := grepf(x,$localLibdb,false)
;     grepCombine(a,b)
;   grepf(x,filename,false)

(DEFUN |applyGrep| (|x| |filename|)
  (PROG (|a| |b|)
    (RETURN
     (COND ((ATOM |x|) (|grepFile| |x| |filename| '|i|))
           (|$localLibdb|
            (PROGN
             (SETQ |a|
                     (|purgeNewConstructorLines| (|grepf| |x| |filename| NIL)
                      |$newConstructorList|))
             (SETQ |b| (|grepf| |x| |$localLibdb| NIL))
             (|grepCombine| |a| |b|)))
           ('T (|grepf| |x| |filename| NIL))))))

; grepCombine(a,b) == MSORT union(a,b)

(DEFUN |grepCombine| (|a| |b|) (PROG () (RETURN (MSORT (|union| |a| |b|)))))

; grepf(pattern,s,not?) ==  --s=sourceFile or list of strings
;   pattern is [op,:argl] =>
;     op = "and" =>
;       while argl is [arg,:argl] repeat
;         s := grepf(arg,s,not?)  -- filter by successive greps
;       s
;     op = "or" =>
;       targetStack := nil
;       "union"/[grepf(arg,s,not?) for arg in argl]
;     op = "not" =>
;       not? => grepf(first argl,s,false)
;       --could be the first time so have to get all of same $key
;       lines := grepf(mkGrepPattern('"*",$key),s,false)
;       grepf(first argl,lines,true)
;     systemError nil
;   option :=
;     not? => 'iv
;     'i
;   source :=
;     LISTP s => dbWriteLines(s, getTempPath 'source)
;     s
;   grepFile(pattern,source,option)

(DEFUN |grepf| (|pattern| |s| |not?|)
  (PROG (|op| |argl| |arg| |targetStack| |lines| |option| |source|)
    (RETURN
     (COND
      ((AND (CONSP |pattern|)
            (PROGN
             (SETQ |op| (CAR |pattern|))
             (SETQ |argl| (CDR |pattern|))
             #1='T))
       (COND
        ((EQ |op| '|and|)
         (PROGN
          ((LAMBDA ()
             (LOOP
              (COND
               ((NOT
                 (AND (CONSP |argl|)
                      (PROGN
                       (SETQ |arg| (CAR |argl|))
                       (SETQ |argl| (CDR |argl|))
                       #1#)))
                (RETURN NIL))
               (#1# (SETQ |s| (|grepf| |arg| |s| |not?|)))))))
          |s|))
        ((EQ |op| '|or|)
         (PROGN
          (SETQ |targetStack| NIL)
          ((LAMBDA (|bfVar#9| |bfVar#8| |arg|)
             (LOOP
              (COND
               ((OR (ATOM |bfVar#8|) (PROGN (SETQ |arg| (CAR |bfVar#8|)) NIL))
                (RETURN |bfVar#9|))
               (#1#
                (SETQ |bfVar#9|
                        (|union| |bfVar#9| (|grepf| |arg| |s| |not?|)))))
              (SETQ |bfVar#8| (CDR |bfVar#8|))))
           NIL |argl| NIL)))
        ((EQ |op| '|not|)
         (COND (|not?| (|grepf| (CAR |argl|) |s| NIL))
               (#1#
                (PROGN
                 (SETQ |lines| (|grepf| (|mkGrepPattern| "*" |$key|) |s| NIL))
                 (|grepf| (CAR |argl|) |lines| T)))))
        (#1# (|systemError| NIL))))
      (#1#
       (PROGN
        (SETQ |option| (COND (|not?| '|iv|) (#1# '|i|)))
        (SETQ |source|
                (COND
                 ((LISTP |s|) (|dbWriteLines| |s| (|getTempPath| '|source|)))
                 (#1# |s|)))
        (|grepFile| |pattern| |source| |option|)))))))

; pmTransFilter s ==
; --result is either a string or (op ..) where op= and,or,not and arg are results
;   if $browseMixedCase = true then s := DOWNCASE s
;   or/[isFilterDelimiter? s.i or s.i = $charUnderscore for i in 0..MAXINDEX s]
;     => (parse := pmParseFromString s) and checkPmParse parse or
;         ['error,'"Illegal search string",'"\vspace{3}\center{{\em Your search string} ",escapeSpecialChars s,'" {\em has incorrect syntax}}"]
;   or/[s . i = char '_* and s.(i + 1) = char '_*
;       and (i=0 or s . (i - 1) ~= char $charUnderscore) for i in 0..(MAXINDEX s - 1)]
;        => ['error,'"Illegal search string",'"\vspace{3}\center{Consecutive {\em *}'s are not allowed in search patterns}"]
;   s

(DEFUN |pmTransFilter| (|s|)
  (PROG (|parse|)
    (RETURN
     (PROGN
      (COND ((EQUAL |$browseMixedCase| T) (SETQ |s| (DOWNCASE |s|))))
      (COND
       (((LAMBDA (|bfVar#11| |bfVar#10| |i|)
           (LOOP
            (COND ((> |i| |bfVar#10|) (RETURN |bfVar#11|))
                  (#1='T
                   (PROGN
                    (SETQ |bfVar#11|
                            (OR (|isFilterDelimiter?| (ELT |s| |i|))
                                (EQUAL (ELT |s| |i|) |$charUnderscore|)))
                    (COND (|bfVar#11| (RETURN |bfVar#11|))))))
            (SETQ |i| (+ |i| 1))))
         NIL (MAXINDEX |s|) 0)
        (OR
         (AND (SETQ |parse| (|pmParseFromString| |s|))
              (|checkPmParse| |parse|))
         (LIST '|error| "Illegal search string"
               "\\vspace{3}\\center{{\\em Your search string} "
               (|escapeSpecialChars| |s|) " {\\em has incorrect syntax}}")))
       (((LAMBDA (|bfVar#13| |bfVar#12| |i|)
           (LOOP
            (COND ((> |i| |bfVar#12|) (RETURN |bfVar#13|))
                  (#1#
                   (PROGN
                    (SETQ |bfVar#13|
                            (AND (EQUAL (ELT |s| |i|) (|char| '*))
                                 (EQUAL (ELT |s| (+ |i| 1)) (|char| '*))
                                 (OR (EQL |i| 0)
                                     (NOT
                                      (EQUAL (ELT |s| (- |i| 1))
                                             (|char| |$charUnderscore|))))))
                    (COND (|bfVar#13| (RETURN |bfVar#13|))))))
            (SETQ |i| (+ |i| 1))))
         NIL (- (MAXINDEX |s|) 1) 0)
        (LIST '|error| "Illegal search string"
              "\\vspace{3}\\center{Consecutive {\\em *}'s are not allowed in search patterns}"))
       (#1# |s|))))))

; checkPmParse parse ==
;   STRINGP parse => parse
;   (fn parse => parse) where fn(u) ==
;     u is [op,:args] =>
;       MEMQ(op,'(and or not)) and and/[checkPmParse x for x in args]
;     STRINGP u => true
;     false
;   nil

(DEFUN |checkPmParse| (|parse|)
  (PROG ()
    (RETURN
     (COND ((STRINGP |parse|) |parse|) ((|checkPmParse,fn| |parse|) |parse|)
           ('T NIL)))))
(DEFUN |checkPmParse,fn| (|u|)
  (PROG (|op| |args|)
    (RETURN
     (COND
      ((AND (CONSP |u|)
            (PROGN (SETQ |op| (CAR |u|)) (SETQ |args| (CDR |u|)) #1='T))
       (AND (MEMQ |op| '(|and| |or| |not|))
            ((LAMBDA (|bfVar#15| |bfVar#14| |x|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#14|)
                      (PROGN (SETQ |x| (CAR |bfVar#14|)) NIL))
                  (RETURN |bfVar#15|))
                 (#1#
                  (PROGN
                   (SETQ |bfVar#15| (|checkPmParse| |x|))
                   (COND ((NOT |bfVar#15|) (RETURN NIL))))))
                (SETQ |bfVar#14| (CDR |bfVar#14|))))
             T |args| NIL)))
      ((STRINGP |u|) T) (#1# NIL)))))

; dnForm x ==
;   STRINGP x => x
;   x is ['not,argl] =>
;     argl is ['or,:orargs]=>
;        ['and, :[dnForm negate u for u in orargs]] where negate s ==
;           s is ['not,argx] => argx
;           ['not,s]
;     argl is ['and,:andargs]=>
;        ['or,:[dnForm negate u for u in andargs]]
;     argl is ['not,notargl]=>
;        dnForm notargl
;     x
;   x is ['or,:argl1] => ['or,:[dnForm u for u in argl1]]
;   x is ['and,:argl2] => ['and,:[dnForm u for u in argl2]]
;   x

(DEFUN |dnForm| (|x|)
  (PROG (|ISTMP#1| |argl| |orargs| |andargs| |notargl| |argl1| |argl2|)
    (RETURN
     (COND ((STRINGP |x|) |x|)
           ((AND (CONSP |x|) (EQ (CAR |x|) '|not|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |x|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                       (PROGN (SETQ |argl| (CAR |ISTMP#1|)) #1='T))))
            (COND
             ((AND (CONSP |argl|) (EQ (CAR |argl|) '|or|)
                   (PROGN (SETQ |orargs| (CDR |argl|)) #1#))
              (CONS '|and|
                    ((LAMBDA (|bfVar#17| |bfVar#16| |u|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#16|)
                              (PROGN (SETQ |u| (CAR |bfVar#16|)) NIL))
                          (RETURN (NREVERSE |bfVar#17|)))
                         (#1#
                          (SETQ |bfVar#17|
                                  (CONS (|dnForm| (|dnForm,negate| |u|))
                                        |bfVar#17|))))
                        (SETQ |bfVar#16| (CDR |bfVar#16|))))
                     NIL |orargs| NIL)))
             ((AND (CONSP |argl|) (EQ (CAR |argl|) '|and|)
                   (PROGN (SETQ |andargs| (CDR |argl|)) #1#))
              (CONS '|or|
                    ((LAMBDA (|bfVar#19| |bfVar#18| |u|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#18|)
                              (PROGN (SETQ |u| (CAR |bfVar#18|)) NIL))
                          (RETURN (NREVERSE |bfVar#19|)))
                         (#1#
                          (SETQ |bfVar#19|
                                  (CONS (|dnForm| (|negate| |u|))
                                        |bfVar#19|))))
                        (SETQ |bfVar#18| (CDR |bfVar#18|))))
                     NIL |andargs| NIL)))
             ((AND (CONSP |argl|) (EQ (CAR |argl|) '|not|)
                   (PROGN
                    (SETQ |ISTMP#1| (CDR |argl|))
                    (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                         (PROGN (SETQ |notargl| (CAR |ISTMP#1|)) #1#))))
              (|dnForm| |notargl|))
             (#1# |x|)))
           ((AND (CONSP |x|) (EQ (CAR |x|) '|or|)
                 (PROGN (SETQ |argl1| (CDR |x|)) #1#))
            (CONS '|or|
                  ((LAMBDA (|bfVar#21| |bfVar#20| |u|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#20|)
                            (PROGN (SETQ |u| (CAR |bfVar#20|)) NIL))
                        (RETURN (NREVERSE |bfVar#21|)))
                       (#1#
                        (SETQ |bfVar#21| (CONS (|dnForm| |u|) |bfVar#21|))))
                      (SETQ |bfVar#20| (CDR |bfVar#20|))))
                   NIL |argl1| NIL)))
           ((AND (CONSP |x|) (EQ (CAR |x|) '|and|)
                 (PROGN (SETQ |argl2| (CDR |x|)) #1#))
            (CONS '|and|
                  ((LAMBDA (|bfVar#23| |bfVar#22| |u|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#22|)
                            (PROGN (SETQ |u| (CAR |bfVar#22|)) NIL))
                        (RETURN (NREVERSE |bfVar#23|)))
                       (#1#
                        (SETQ |bfVar#23| (CONS (|dnForm| |u|) |bfVar#23|))))
                      (SETQ |bfVar#22| (CDR |bfVar#22|))))
                   NIL |argl2| NIL)))
           (#1# |x|)))))
(DEFUN |dnForm,negate| (|s|)
  (PROG (|ISTMP#1| |argx|)
    (RETURN
     (COND
      ((AND (CONSP |s|) (EQ (CAR |s|) '|not|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |s|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |argx| (CAR |ISTMP#1|)) #1='T))))
       |argx|)
      (#1# (LIST '|not| |s|))))))

; pmParseFromString s ==
;   u := ncParseFromString pmPreparse s
;   dnForm flatten u where flatten s ==
;     s is [op,:argl] =>
;       STRINGP op => STRCONC(op,"STRCONC"/[STRCONC('" ",x) for x in argl])
;       [op,:[flatten x for x in argl]]
;     s

(DEFUN |pmParseFromString| (|s|)
  (PROG (|u|)
    (RETURN
     (PROGN
      (SETQ |u| (|ncParseFromString| (|pmPreparse| |s|)))
      (|dnForm| (|pmParseFromString,flatten| |u|))))))
(DEFUN |pmParseFromString,flatten| (|s|)
  (PROG (|op| |argl|)
    (RETURN
     (COND
      ((AND (CONSP |s|)
            (PROGN (SETQ |op| (CAR |s|)) (SETQ |argl| (CDR |s|)) #1='T))
       (COND
        ((STRINGP |op|)
         (STRCONC |op|
          ((LAMBDA (|bfVar#25| |bfVar#24| |x|)
             (LOOP
              (COND
               ((OR (ATOM |bfVar#24|) (PROGN (SETQ |x| (CAR |bfVar#24|)) NIL))
                (RETURN |bfVar#25|))
               (#1# (SETQ |bfVar#25| (STRCONC |bfVar#25| (STRCONC " " |x|)))))
              (SETQ |bfVar#24| (CDR |bfVar#24|))))
           "" |argl| NIL)))
        (#1#
         (CONS |op|
               ((LAMBDA (|bfVar#27| |bfVar#26| |x|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#26|)
                         (PROGN (SETQ |x| (CAR |bfVar#26|)) NIL))
                     (RETURN (NREVERSE |bfVar#27|)))
                    (#1#
                     (SETQ |bfVar#27|
                             (CONS (|pmParseFromString,flatten| |x|)
                                   |bfVar#27|))))
                   (SETQ |bfVar#26| (CDR |bfVar#26|))))
                NIL |argl| NIL)))))
      (#1# |s|)))))

; pmPreparse s == hn fn(s,0,#s) where--stupid insertion of chars to get correct parse
;   hn x == SUBLISLIS('(and or not),'("and" "or" "not"),x)
;   fn(s,n,siz) ==  --main function: s is string, n is origin
;     n = siz => '""
;     i := firstNonDelim(s,n) or return SUBSTRING(s,n,nil)
;     j := firstDelim(s,i + 1) or siz
;     t := gn(s,i,j - 1)
;     middle :=
;       member(t,'("and" "or" "not")) => t
;       --the following 2 lines make commutative("*") parse correctly!!!!
;       t.0 = char '_" => t
;       j < siz - 1 and s.j = char '_( => t
;       STRCONC(char '_",t,char '_")
;     STRCONC(SUBSTRING(s,n,i - n),middle,fn(s,j,siz))
;   gn(s,i,j) ==    --replace each underscore by 4 underscores!
;     n := or/[k for k in i..j | s.k = $charUnderscore] =>
;       STRCONC(SUBSTRING(s,i,n - i + 1),$charUnderscore,gn(s,n + 1,j))
;     SUBSTRING(s,i,j - i + 1)

(DEFUN |pmPreparse| (|s|)
  (PROG () (RETURN (|pmPreparse,hn| (|pmPreparse,fn| |s| 0 (LENGTH |s|))))))
(DEFUN |pmPreparse,hn| (|x|)
  (PROG () (RETURN (SUBLISLIS '(|and| |or| |not|) '("and" "or" "not") |x|))))
(DEFUN |pmPreparse,fn| (|s| |n| |siz|)
  (PROG (|i| |j| |t| |middle|)
    (RETURN
     (COND ((EQUAL |n| |siz|) "")
           (#1='T
            (PROGN
             (SETQ |i|
                     (OR (|firstNonDelim| |s| |n|)
                         (RETURN (SUBSTRING |s| |n| NIL))))
             (SETQ |j| (OR (|firstDelim| |s| (+ |i| 1)) |siz|))
             (SETQ |t| (|pmPreparse,gn| |s| |i| (- |j| 1)))
             (SETQ |middle|
                     (COND ((|member| |t| '("and" "or" "not")) |t|)
                           ((EQUAL (ELT |t| 0) (|char| '|"|)) |t|)
                           ((AND (< |j| (- |siz| 1))
                                 (EQUAL (ELT |s| |j|) (|char| '|(|)))
                            |t|)
                           (#1# (STRCONC (|char| '|"|) |t| (|char| '|"|)))))
             (STRCONC (SUBSTRING |s| |n| (- |i| |n|)) |middle|
              (|pmPreparse,fn| |s| |j| |siz|))))))))
(DEFUN |pmPreparse,gn| (|s| |i| |j|)
  (PROG (|n|)
    (RETURN
     (COND
      ((SETQ |n|
               ((LAMBDA (|bfVar#28| |k|)
                  (LOOP
                   (COND ((> |k| |j|) (RETURN |bfVar#28|))
                         (#1='T
                          (AND (EQUAL (ELT |s| |k|) |$charUnderscore|)
                               (PROGN
                                (SETQ |bfVar#28| |k|)
                                (COND (|bfVar#28| (RETURN |bfVar#28|)))))))
                   (SETQ |k| (+ |k| 1))))
                NIL |i|))
       (STRCONC (SUBSTRING |s| |i| (+ (- |n| |i|) 1)) |$charUnderscore|
        (|pmPreparse,gn| |s| (+ |n| 1) |j|)))
      (#1# (SUBSTRING |s| |i| (+ (- |j| |i|) 1)))))))

; firstNonDelim(s,n) ==  or/[k for k in n..MAXINDEX s | not isFilterDelimiter? s.k]

(DEFUN |firstNonDelim| (|s| |n|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#30| |bfVar#29| |k|)
        (LOOP
         (COND ((> |k| |bfVar#29|) (RETURN |bfVar#30|))
               ('T
                (AND (NULL (|isFilterDelimiter?| (ELT |s| |k|)))
                     (PROGN
                      (SETQ |bfVar#30| |k|)
                      (COND (|bfVar#30| (RETURN |bfVar#30|)))))))
         (SETQ |k| (+ |k| 1))))
      NIL (MAXINDEX |s|) |n|))))

; firstDelim(s,n) ==  or/[k for k in n..MAXINDEX s | isFilterDelimiter? s.k]

(DEFUN |firstDelim| (|s| |n|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#32| |bfVar#31| |k|)
        (LOOP
         (COND ((> |k| |bfVar#31|) (RETURN |bfVar#32|))
               ('T
                (AND (|isFilterDelimiter?| (ELT |s| |k|))
                     (PROGN
                      (SETQ |bfVar#32| |k|)
                      (COND (|bfVar#32| (RETURN |bfVar#32|)))))))
         (SETQ |k| (+ |k| 1))))
      NIL (MAXINDEX |s|) |n|))))

; isFilterDelimiter? c == MEMQ(c,$pmFilterDelimiters)

(DEFUN |isFilterDelimiter?| (|c|)
  (PROG () (RETURN (MEMQ |c| |$pmFilterDelimiters|))))

; grepSplit(lines,doc?) ==
;   if doc? then
;     instream2 := OPEN STRCONC(getEnv '"FRICAS",'"/algebra/libdb.text")
;   cons := atts := doms := nil
;   while lines is [line, :lines] repeat
;     if doc? then
;         N:=PARSE_-INTEGER dbPart(line,1,-1)
;         if NUMBERP N then
;            FILE_-POSITION(instream2,N)
;            line := read_line instream2
;     kind := dbKind line
;     not $includeUnexposed? and not dbExposed?(line,kind) => 'skip
;     (kind = char 'a or kind = char 'o) and isDefaultOpAtt line => 'skip
;     PROGN
;       kind = char 'c => cats := insert(line,cats)
;       kind = char 'd => doms := insert(line,doms)
;       kind = char 'x => defs := insert(line,defs)
;       kind = char 'p => paks := insert(line,paks)
;       kind = char 'a => atts := insert(line,atts)
;       kind = char 'o => ops :=  insert(line,ops)
;       kind = char '_- => 'skip                --for now
;       systemError 'kind
;   if doc? then CLOSE instream2
;   not(atts = []) => BREAK()
;   [
;      -- no attributes
;      -- ['"attribute",:NREVERSE atts],
;      ['"operation",:NREVERSE ops],
;        ['"category",:NREVERSE cats],
;          ['"domain",:NREVERSE doms],
;            ['"package",:NREVERSE paks]
; --           ['"default_ package",:NREVERSE defs]   -- drop defaults
;                ]

(DEFUN |grepSplit| (|lines| |doc?|)
  (PROG (|instream2| |doms| |atts| CONS |line| N |kind| |cats| |defs| |paks|
         |ops|)
    (RETURN
     (PROGN
      (COND
       (|doc?|
        (SETQ |instream2|
                (OPEN (STRCONC (|getEnv| "FRICAS") "/algebra/libdb.text")))))
      (SETQ CONS (SETQ |atts| (SETQ |doms| NIL)))
      ((LAMBDA ()
         (LOOP
          (COND
           ((NOT
             (AND (CONSP |lines|)
                  (PROGN
                   (SETQ |line| (CAR |lines|))
                   (SETQ |lines| (CDR |lines|))
                   #1='T)))
            (RETURN NIL))
           (#1#
            (PROGN
             (COND
              (|doc?| (SETQ N (PARSE-INTEGER (|dbPart| |line| 1 (- 1))))
               (COND
                ((NUMBERP N) (FILE-POSITION |instream2| N)
                 (SETQ |line| (|read_line| |instream2|))))))
             (SETQ |kind| (|dbKind| |line|))
             (COND
              ((AND (NULL |$includeUnexposed?|)
                    (NULL (|dbExposed?| |line| |kind|)))
               '|skip|)
              ((AND
                (OR (EQUAL |kind| (|char| '|a|)) (EQUAL |kind| (|char| '|o|)))
                (|isDefaultOpAtt| |line|))
               '|skip|)
              (#1#
               (COND
                ((EQUAL |kind| (|char| '|c|))
                 (SETQ |cats| (|insert| |line| |cats|)))
                ((EQUAL |kind| (|char| '|d|))
                 (SETQ |doms| (|insert| |line| |doms|)))
                ((EQUAL |kind| (|char| '|x|))
                 (SETQ |defs| (|insert| |line| |defs|)))
                ((EQUAL |kind| (|char| '|p|))
                 (SETQ |paks| (|insert| |line| |paks|)))
                ((EQUAL |kind| (|char| '|a|))
                 (SETQ |atts| (|insert| |line| |atts|)))
                ((EQUAL |kind| (|char| '|o|))
                 (SETQ |ops| (|insert| |line| |ops|)))
                ((EQUAL |kind| (|char| '-)) '|skip|)
                (#1# (|systemError| '|kind|)))))))))))
      (COND (|doc?| (CLOSE |instream2|)))
      (COND ((NULL (NULL |atts|)) (BREAK))
            (#1#
             (LIST (CONS "operation" (NREVERSE |ops|))
                   (CONS "category" (NREVERSE |cats|))
                   (CONS "domain" (NREVERSE |doms|))
                   (CONS "package" (NREVERSE |paks|)))))))))

; mkUpDownPattern s == recurse(s,0,#s) where
;   recurse(s,i,n) ==
;     i = n => '""
;     STRCONC(fixchar(s.i),recurse(s,i + 1,n))
;   fixchar(c) ==
;     ALPHA_-CHAR_-P c =>
;       STRCONC(char '_[,CHAR_-UPCASE c,CHAR_-DOWNCASE c,char '_])
;     c

(DEFUN |mkUpDownPattern| (|s|)
  (PROG () (RETURN (|mkUpDownPattern,recurse| |s| 0 (LENGTH |s|)))))
(DEFUN |mkUpDownPattern,recurse| (|s| |i| |n|)
  (PROG ()
    (RETURN
     (COND ((EQUAL |i| |n|) "")
           ('T
            (STRCONC (|mkUpDownPattern,fixchar| (ELT |s| |i|))
             (|mkUpDownPattern,recurse| |s| (+ |i| 1) |n|)))))))
(DEFUN |mkUpDownPattern,fixchar| (|c|)
  (PROG ()
    (RETURN
     (COND
      ((ALPHA-CHAR-P |c|)
       (STRCONC (|char| '[) (CHAR-UPCASE |c|) (CHAR-DOWNCASE |c|) (|char| '])))
      ('T |c|)))))

; mkGrepPattern(s,key) ==
;   --called by grepConstruct1 and grepf
;   atom s => mkGrepPattern1(s,key)
;   [first s,:[mkGrepPattern(x,key) for x in rest s]]

(DEFUN |mkGrepPattern| (|s| |key|)
  (PROG ()
    (RETURN
     (COND ((ATOM |s|) (|mkGrepPattern1| |s| |key|))
           (#1='T
            (CONS (CAR |s|)
                  ((LAMBDA (|bfVar#34| |bfVar#33| |x|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#33|)
                            (PROGN (SETQ |x| (CAR |bfVar#33|)) NIL))
                        (RETURN (NREVERSE |bfVar#34|)))
                       (#1#
                        (SETQ |bfVar#34|
                                (CONS (|mkGrepPattern| |x| |key|)
                                      |bfVar#34|))))
                      (SETQ |bfVar#33| (CDR |bfVar#33|))))
                   NIL (CDR |s|) NIL)))))))

; mkGrepPattern1(x,:options) == --called by mkGrepPattern (and grepConstructName?)
;   $options : local := options
;   s := STRINGIMAGE x
; --s := DOWNCASE STRINGIMAGE x
;   addOptions remUnderscores addWilds split(g s,char '_*) where
;     addWilds sl ==    --add wild cards (sl is list of parts between *'s)
;       IFCAR sl = '"" => h(IFCDR sl,[$wild1])
;       h(sl,nil)
;     g s  ==    --remove "*"s around pattern for text match
;       not MEMQ('w,$options) => s
;       if s.0 = char '_* then s := SUBSTRING(s,1,nil)
;       if s.(k := MAXINDEX s) = char '_* then s := SUBSTRING(s,0,k)
;       s
;     h(sl,res) == --helper for wild cards
;       sl is [s,:r] => h(r,[$wild1,s,:res])
;       res := rest res
;       if not MEMQ('w,$options) then
;         if first res ~= '"" then res := ['"`",:res]
;         else if res is [.,p,:r] and p = $wild1 then res := r
;       "STRCONC"/NREVERSE res
;     remUnderscores s ==
;       (k := charPosition(char $charUnderscore,s,0)) < MAXINDEX s =>
;         STRCONC(SUBSTRING(s,0,k),'"[",s.(k + 1),'"]",
;                 remUnderscores(SUBSTRING(s,k + 2,nil)))
;       s
;     split(s,char) ==
;       max := MAXINDEX s + 1
;       f := -1
;       [SUBSTRING(s,i,f-i)
;         while ((i := f + 1) <= max) and (f := charPosition(char,s,i))]
;     charPosition(c,t,startpos) ==  --honors underscores
;       n := SIZE t
;       if startpos < 0 or startpos > n then error "index out of range"
;       k:= startpos
;       for i in startpos .. n-1 while c ~= ELT(t,i)
;         or i > startpos and ELT(t,i-1) = '__ repeat  (k := k+1)
;       k
;     addOptions s ==  --add front anchor
;       --options a o c d p x   denote standard items
;       --options w             means  comments
;       --option  t             means  text
;       --option  s             means  signature
;       --option  n             means  number of arguments
;       --option  i             means  predicate
;       --option  none          means  NO PREFIX
;       one := ($options is [x,:$options] and x => x; '"[^x]")
;       tick := '"[^`]*`"
;       one = 'w => s
;       one = 'none => (s = '"`" => '"^."; STRCONC('"^",s))
;       prefix :=
;         one = 't => STRCONC(tick,tick,tick,tick,tick,".*")
;         one = 'n => tick
;         one = 'i => STRCONC(tick,tick,tick,tick)
;         one = 's => STRCONC(tick,tick,tick)
; --      true => '""    ----> never put on following prefixes
;         one = 'k => '"[cdp]"
;         one = 'y => '"[cdpx]"
;         STRINGIMAGE one
;       s = $wild1 => STRCONC('"^",prefix)
;       STRCONC('"^",prefix,s)

(DEFUN |mkGrepPattern1| (|x| &REST |options|)
  (PROG (|$options| |s|)
    (DECLARE (SPECIAL |$options|))
    (RETURN
     (PROGN
      (SETQ |$options| |options|)
      (SETQ |s| (STRINGIMAGE |x|))
      (|mkGrepPattern1,addOptions|
       (|mkGrepPattern1,remUnderscores|
        (|mkGrepPattern1,addWilds|
         (|mkGrepPattern1,split| (|mkGrepPattern1,g| |s|) (|char| '*)))))))))
(DEFUN |mkGrepPattern1,addWilds| (|sl|)
  (PROG ()
    (RETURN
     (COND
      ((EQUAL (IFCAR |sl|) "")
       (|mkGrepPattern1,h| (IFCDR |sl|) (LIST |$wild1|)))
      ('T (|mkGrepPattern1,h| |sl| NIL))))))
(DEFUN |mkGrepPattern1,g| (|s|)
  (PROG (|k|)
    (RETURN
     (COND ((NULL (MEMQ '|w| |$options|)) |s|)
           ('T
            (PROGN
             (COND
              ((EQUAL (ELT |s| 0) (|char| '*))
               (SETQ |s| (SUBSTRING |s| 1 NIL))))
             (COND
              ((EQUAL (ELT |s| (SETQ |k| (MAXINDEX |s|))) (|char| '*))
               (SETQ |s| (SUBSTRING |s| 0 |k|))))
             |s|))))))
(DEFUN |mkGrepPattern1,h| (|sl| |res|)
  (PROG (|s| |r| |ISTMP#1| |p|)
    (RETURN
     (COND
      ((AND (CONSP |sl|)
            (PROGN (SETQ |s| (CAR |sl|)) (SETQ |r| (CDR |sl|)) #1='T))
       (|mkGrepPattern1,h| |r| (CONS |$wild1| (CONS |s| |res|))))
      (#1#
       (PROGN
        (SETQ |res| (CDR |res|))
        (COND
         ((NULL (MEMQ '|w| |$options|))
          (COND ((NOT (EQUAL (CAR |res|) "")) (SETQ |res| (CONS "`" |res|)))
                ((AND (CONSP |res|)
                      (PROGN
                       (SETQ |ISTMP#1| (CDR |res|))
                       (AND (CONSP |ISTMP#1|)
                            (PROGN
                             (SETQ |p| (CAR |ISTMP#1|))
                             (SETQ |r| (CDR |ISTMP#1|))
                             #1#)))
                      (EQUAL |p| |$wild1|))
                 (SETQ |res| |r|)))))
        ((LAMBDA (|bfVar#35| |bfVar#37| |bfVar#36|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#37|)
                  (PROGN (SETQ |bfVar#36| (CAR |bfVar#37|)) NIL))
              (RETURN |bfVar#35|))
             (#1# (SETQ |bfVar#35| (STRCONC |bfVar#35| |bfVar#36|))))
            (SETQ |bfVar#37| (CDR |bfVar#37|))))
         "" (NREVERSE |res|) NIL)))))))
(DEFUN |mkGrepPattern1,remUnderscores| (|s|)
  (PROG (|k|)
    (RETURN
     (COND
      ((<
        (SETQ |k|
                (|mkGrepPattern1,charPosition| (|char| |$charUnderscore|) |s|
                 0))
        (MAXINDEX |s|))
       (STRCONC (SUBSTRING |s| 0 |k|) "[" (ELT |s| (+ |k| 1)) "]"
        (|mkGrepPattern1,remUnderscores| (SUBSTRING |s| (+ |k| 2) NIL))))
      ('T |s|)))))
(DEFUN |mkGrepPattern1,split| (|s| |char|)
  (PROG (|max| |f| |i|)
    (RETURN
     (PROGN
      (SETQ |max| (+ (MAXINDEX |s|) 1))
      (SETQ |f| (- 1))
      ((LAMBDA (|bfVar#38|)
         (LOOP
          (COND
           ((NOT
             (AND (NOT (< |max| (SETQ |i| (+ |f| 1))))
                  (SETQ |f| (|mkGrepPattern1,charPosition| |char| |s| |i|))))
            (RETURN (NREVERSE |bfVar#38|)))
           ('T
            (SETQ |bfVar#38|
                    (CONS (SUBSTRING |s| |i| (- |f| |i|)) |bfVar#38|))))))
       NIL)))))
(DEFUN |mkGrepPattern1,charPosition| (|c| |t| |startpos|)
  (PROG (|n| |k|)
    (RETURN
     (PROGN
      (SETQ |n| (SIZE |t|))
      (COND
       ((OR (MINUSP |startpos|) (< |n| |startpos|))
        (|error| '|index out of range|)))
      (SETQ |k| |startpos|)
      ((LAMBDA (|bfVar#39| |i|)
         (LOOP
          (COND
           ((OR (> |i| |bfVar#39|)
                (NOT
                 (OR (NOT (EQUAL |c| (ELT |t| |i|)))
                     (AND (< |startpos| |i|) (EQ (ELT |t| (- |i| 1)) '_)))))
            (RETURN NIL))
           ('T (SETQ |k| (+ |k| 1))))
          (SETQ |i| (+ |i| 1))))
       (- |n| 1) |startpos|)
      |k|))))
(DEFUN |mkGrepPattern1,addOptions| (|s|)
  (PROG (|x| |one| |tick| |prefix|)
    (RETURN
     (PROGN
      (SETQ |one|
              (COND
               ((AND (CONSP |$options|)
                     (PROGN
                      (SETQ |x| (CAR |$options|))
                      (SETQ |$options| (CDR |$options|))
                      #1='T)
                     |x|)
                |x|)
               (#1# "[^x]")))
      (SETQ |tick| "[^`]*`")
      (COND ((EQ |one| '|w|) |s|)
            ((EQ |one| '|none|)
             (COND ((EQUAL |s| "`") "^.") (#1# (STRCONC "^" |s|))))
            (#1#
             (PROGN
              (SETQ |prefix|
                      (COND
                       ((EQ |one| '|t|)
                        (STRCONC |tick| |tick| |tick| |tick| |tick| '.*))
                       ((EQ |one| '|n|) |tick|)
                       ((EQ |one| '|i|) (STRCONC |tick| |tick| |tick| |tick|))
                       ((EQ |one| '|s|) (STRCONC |tick| |tick| |tick|))
                       ((EQ |one| '|k|) "[cdp]") ((EQ |one| '|y|) "[cdpx]")
                       (#1# (STRINGIMAGE |one|))))
              (COND ((EQUAL |s| |$wild1|) (STRCONC "^" |prefix|))
                    (#1# (STRCONC "^" |prefix| |s|))))))))))

; oPage(a,:b) == --called by \spadfun{opname}
;   oSearch (IFCAR b or a) --always take slow path

(DEFUN |oPage| (|a| &REST |b|)
  (PROG () (RETURN (|oSearch| (OR (IFCAR |b|) |a|)))))

; oPageFrom(opname,conname) == --called by \spadfunFrom{opname}{conname}
;   htPage := htInitPage(nil,nil) --create empty page and fill in needed properties
;   htpSetProperty(htPage,'conform,conform := getConstructorForm conname)
;   htpSetProperty(htPage,'kind,STRINGIMAGE GETDATABASE(conname,'CONSTRUCTORKIND))
;   itemlist := assoc(opname,koOps(conform,nil)) --all operations name "opname"
;   null itemlist => systemError [conform,'" has no operation named ",opname]
;   opAlist := [itemlist]
;   dbShowOperationsFromConform(htPage,'"operation",opAlist)

(DEFUN |oPageFrom| (|opname| |conname|)
  (PROG (|htPage| |conform| |itemlist| |opAlist|)
    (RETURN
     (PROGN
      (SETQ |htPage| (|htInitPage| NIL NIL))
      (|htpSetProperty| |htPage| '|conform|
       (SETQ |conform| (|getConstructorForm| |conname|)))
      (|htpSetProperty| |htPage| '|kind|
       (STRINGIMAGE (GETDATABASE |conname| 'CONSTRUCTORKIND)))
      (SETQ |itemlist| (|assoc| |opname| (|koOps| |conform| NIL)))
      (COND
       ((NULL |itemlist|)
        (|systemError| (LIST |conform| " has no operation named " |opname|)))
       ('T
        (PROGN
         (SETQ |opAlist| (LIST |itemlist|))
         (|dbShowOperationsFromConform| |htPage| "operation" |opAlist|))))))))

; spadType(x) ==  --called by \spadtype{x} from HyperDoc
;   s := PNAME x
;   form := ncParseFromString s or
;             systemError ['"Argument: ",s,'" to spadType won't parse"]
;   if atom form then form := [form]
;   op    := opOf form
;   conPage(op)

(DEFUN |spadType| (|x|)
  (PROG (|s| |form| |op|)
    (RETURN
     (PROGN
      (SETQ |s| (PNAME |x|))
      (SETQ |form|
              (OR (|ncParseFromString| |s|)
                  (|systemError|
                   (LIST "Argument: " |s| " to spadType won't parse"))))
      (COND ((ATOM |form|) (SETQ |form| (LIST |form|))))
      (SETQ |op| (|opOf| |form|))
      (|conPage| |op|)))))

; aokSearch filter ==  genSearch(filter,true)  --"General" from HD (see man0.ht)

(DEFUN |aokSearch| (|filter|) (PROG () (RETURN (|genSearch| |filter| T))))

; genSearch(filter,:options) == --"Complete" from HD (see man0.ht) and aokSearch
; --General + documentation search
;   null (filter := checkFilter filter) => nil  --in case of filter error
;   filter = '"*" => htErrorStar()
;   includeDoc? := not IFCAR options
; --give summaries for how many a o c d p x match filter
;   regSearchAlist := grepConstruct(STRINGIMAGE filter,".",true)
;   regSearchAlist is ['error,:.] => bcErrorPage regSearchAlist
;   key := removeSurroundingStars filter
;   if includeDoc? then
;     docSearchAlist := grepConstruct(key,'w,true)
;     docSearchAlist is ['error,:.] => bcErrorPage docSearchAlist
;     docSearchAlist := [x for x in docSearchAlist | x.0 ~= char 'x]--drop defaults
;   genSearch1(filter,genSearchTran regSearchAlist,genSearchTran docSearchAlist)

(DEFUN |genSearch| (|filter| &REST |options|)
  (PROG (|includeDoc?| |regSearchAlist| |key| |docSearchAlist|)
    (RETURN
     (COND ((NULL (SETQ |filter| (|checkFilter| |filter|))) NIL)
           ((EQUAL |filter| "*") (|htErrorStar|))
           (#1='T
            (PROGN
             (SETQ |includeDoc?| (NULL (IFCAR |options|)))
             (SETQ |regSearchAlist|
                     (|grepConstruct| (STRINGIMAGE |filter|) '|.| T))
             (COND
              ((AND (CONSP |regSearchAlist|)
                    (EQ (CAR |regSearchAlist|) '|error|))
               (|bcErrorPage| |regSearchAlist|))
              (#1#
               (PROGN
                (SETQ |key| (|removeSurroundingStars| |filter|))
                (COND
                 (|includeDoc?|
                  (SETQ |docSearchAlist| (|grepConstruct| |key| '|w| T))
                  (COND
                   ((AND (CONSP |docSearchAlist|)
                         (EQ (CAR |docSearchAlist|) '|error|))
                    (|bcErrorPage| |docSearchAlist|))
                   (#1#
                    (SETQ |docSearchAlist|
                            ((LAMBDA (|bfVar#41| |bfVar#40| |x|)
                               (LOOP
                                (COND
                                 ((OR (ATOM |bfVar#40|)
                                      (PROGN (SETQ |x| (CAR |bfVar#40|)) NIL))
                                  (RETURN (NREVERSE |bfVar#41|)))
                                 (#1#
                                  (AND (NOT (EQUAL (ELT |x| 0) (|char| '|x|)))
                                       (SETQ |bfVar#41|
                                               (CONS |x| |bfVar#41|)))))
                                (SETQ |bfVar#40| (CDR |bfVar#40|))))
                             NIL |docSearchAlist| NIL))))))
                (|genSearch1| |filter| (|genSearchTran| |regSearchAlist|)
                 (|genSearchTran| |docSearchAlist|)))))))))))

; genSearchTran alist == [[x,y,:y] for [x,:y] in alist]

(DEFUN |genSearchTran| (|alist|)
  (PROG (|x| |y|)
    (RETURN
     ((LAMBDA (|bfVar#44| |bfVar#43| |bfVar#42|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#43|)
               (PROGN (SETQ |bfVar#42| (CAR |bfVar#43|)) NIL))
           (RETURN (NREVERSE |bfVar#44|)))
          (#1='T
           (AND (CONSP |bfVar#42|)
                (PROGN
                 (SETQ |x| (CAR |bfVar#42|))
                 (SETQ |y| (CDR |bfVar#42|))
                 #1#)
                (SETQ |bfVar#44|
                        (CONS (CONS |x| (CONS |y| |y|)) |bfVar#44|)))))
         (SETQ |bfVar#43| (CDR |bfVar#43|))))
      NIL |alist| NIL))))

; genSearch1(filter,reg,doc) ==
;   regSearchAlist := searchDropUnexposedLines reg
;   docSearchAlist := searchDropUnexposedLines doc
;   key := removeSurroundingStars filter
;   regCount := searchCount regSearchAlist
;   docCount := searchCount docSearchAlist
;   count := regCount + docCount
;   count = 0 => emptySearchPage('"entry",filter,true)
;   count = 1 =>
;     alist := (regCount = 1 => regSearchAlist; docSearchAlist)
;     showNamedConstruct(or/[x for x in alist | CADR x])
;   summarize? :=
;     docSearchAlist => true
;     nonEmpties := [pair for pair in regSearchAlist | #(CADR pair) > 0]
;     not(nonEmpties is [pair])
;   not summarize? => showNamedConstruct pair
;   -----------generate a summary page---------------------------
;   plural :=
;     $exposedOnlyIfTrue => '"exposed entries match"
;     '"entries match"
;   prefix := pluralSay(count,'"", plural)
;   emfilter := ['"{\em ",escapeSpecialChars STRINGIMAGE filter,'"}"]
;   header := [:prefix,'" ",:emfilter]
;   page := htInitPage(header,nil)
;   htpSetProperty(page,'regSearchAlist,regSearchAlist)
;   htpSetProperty(page,'docSearchAlist,docSearchAlist)
;   htpSetProperty(page,'filter,filter)
;   if docSearchAlist then
;       dbSayItems(['"{\bf Construct Summary:} ",regCount],'"name matches",'"names match")
;   for [kind,:pair] in regSearchAlist for i in 0.. | #(first pair) > 0 repeat
;     bcHt '"\newline{}"
;     htSayStandard '"\tab{2}"
;     genSearchSay(pair,summarize?,kind,i,'showConstruct)
;   if docSearchAlist then
;     dbSayItems(['"\newline{\bf Documentation Summary:} ",docCount],'"mention",'"mentions",'" of {\em ",key,'"}")
;     for [kind,:pair] in docSearchAlist for i in 0.. | #(first pair) > 0 repeat
;       bcHt "\newline{}"
;       htSayStandard '"\tab{2}"
;       genSearchSay(pair,true,kind,i,'showDoc)
;   htShowPageStar()

(DEFUN |genSearch1| (|filter| |reg| |doc|)
  (PROG (|regSearchAlist| |docSearchAlist| |key| |regCount| |docCount| |count|
         |alist| |nonEmpties| |pair| |summarize?| |plural| |prefix| |emfilter|
         |header| |page| |kind|)
    (RETURN
     (PROGN
      (SETQ |regSearchAlist| (|searchDropUnexposedLines| |reg|))
      (SETQ |docSearchAlist| (|searchDropUnexposedLines| |doc|))
      (SETQ |key| (|removeSurroundingStars| |filter|))
      (SETQ |regCount| (|searchCount| |regSearchAlist|))
      (SETQ |docCount| (|searchCount| |docSearchAlist|))
      (SETQ |count| (+ |regCount| |docCount|))
      (COND ((EQL |count| 0) (|emptySearchPage| "entry" |filter| T))
            ((EQL |count| 1)
             (PROGN
              (SETQ |alist|
                      (COND ((EQL |regCount| 1) |regSearchAlist|)
                            (#1='T |docSearchAlist|)))
              (|showNamedConstruct|
               ((LAMBDA (|bfVar#46| |bfVar#45| |x|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#45|)
                         (PROGN (SETQ |x| (CAR |bfVar#45|)) NIL))
                     (RETURN |bfVar#46|))
                    (#1#
                     (AND (CADR |x|)
                          (PROGN
                           (SETQ |bfVar#46| |x|)
                           (COND (|bfVar#46| (RETURN |bfVar#46|)))))))
                   (SETQ |bfVar#45| (CDR |bfVar#45|))))
                NIL |alist| NIL))))
            (#1#
             (PROGN
              (SETQ |summarize?|
                      (COND (|docSearchAlist| T)
                            (#1#
                             (PROGN
                              (SETQ |nonEmpties|
                                      ((LAMBDA (|bfVar#48| |bfVar#47| |pair|)
                                         (LOOP
                                          (COND
                                           ((OR (ATOM |bfVar#47|)
                                                (PROGN
                                                 (SETQ |pair| (CAR |bfVar#47|))
                                                 NIL))
                                            (RETURN (NREVERSE |bfVar#48|)))
                                           (#1#
                                            (AND (< 0 (LENGTH (CADR |pair|)))
                                                 (SETQ |bfVar#48|
                                                         (CONS |pair|
                                                               |bfVar#48|)))))
                                          (SETQ |bfVar#47| (CDR |bfVar#47|))))
                                       NIL |regSearchAlist| NIL))
                              (NULL
                               (AND (CONSP |nonEmpties|)
                                    (EQ (CDR |nonEmpties|) NIL)
                                    (PROGN
                                     (SETQ |pair| (CAR |nonEmpties|))
                                     #1#)))))))
              (COND ((NULL |summarize?|) (|showNamedConstruct| |pair|))
                    (#1#
                     (PROGN
                      (SETQ |plural|
                              (COND
                               (|$exposedOnlyIfTrue| "exposed entries match")
                               (#1# "entries match")))
                      (SETQ |prefix| (|pluralSay| |count| "" |plural|))
                      (SETQ |emfilter|
                              (LIST "{\\em "
                                    (|escapeSpecialChars|
                                     (STRINGIMAGE |filter|))
                                    "}"))
                      (SETQ |header| (APPEND |prefix| (CONS " " |emfilter|)))
                      (SETQ |page| (|htInitPage| |header| NIL))
                      (|htpSetProperty| |page| '|regSearchAlist|
                       |regSearchAlist|)
                      (|htpSetProperty| |page| '|docSearchAlist|
                       |docSearchAlist|)
                      (|htpSetProperty| |page| '|filter| |filter|)
                      (COND
                       (|docSearchAlist|
                        (|dbSayItems|
                         (LIST "{\\bf Construct Summary:} " |regCount|)
                         "name matches" "names match")))
                      ((LAMBDA (|bfVar#50| |bfVar#49| |i|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#50|)
                                (PROGN (SETQ |bfVar#49| (CAR |bfVar#50|)) NIL))
                            (RETURN NIL))
                           (#1#
                            (AND (CONSP |bfVar#49|)
                                 (PROGN
                                  (SETQ |kind| (CAR |bfVar#49|))
                                  (SETQ |pair| (CDR |bfVar#49|))
                                  #1#)
                                 (< 0 (LENGTH (CAR |pair|)))
                                 (PROGN
                                  (|bcHt| "\\newline{}")
                                  (|htSayStandard| "\\tab{2}")
                                  (|genSearchSay| |pair| |summarize?| |kind|
                                   |i| '|showConstruct|)))))
                          (SETQ |bfVar#50| (CDR |bfVar#50|))
                          (SETQ |i| (+ |i| 1))))
                       |regSearchAlist| NIL 0)
                      (COND
                       (|docSearchAlist|
                        (|dbSayItems|
                         (LIST "\\newline{\\bf Documentation Summary:} "
                               |docCount|)
                         "mention" "mentions" " of {\\em " |key| "}")
                        ((LAMBDA (|bfVar#52| |bfVar#51| |i|)
                           (LOOP
                            (COND
                             ((OR (ATOM |bfVar#52|)
                                  (PROGN
                                   (SETQ |bfVar#51| (CAR |bfVar#52|))
                                   NIL))
                              (RETURN NIL))
                             (#1#
                              (AND (CONSP |bfVar#51|)
                                   (PROGN
                                    (SETQ |kind| (CAR |bfVar#51|))
                                    (SETQ |pair| (CDR |bfVar#51|))
                                    #1#)
                                   (< 0 (LENGTH (CAR |pair|)))
                                   (PROGN
                                    (|bcHt| '|\\newline{}|)
                                    (|htSayStandard| "\\tab{2}")
                                    (|genSearchSay| |pair| T |kind| |i|
                                     '|showDoc|)))))
                            (SETQ |bfVar#52| (CDR |bfVar#52|))
                            (SETQ |i| (+ |i| 1))))
                         |docSearchAlist| NIL 0)))
                      (|htShowPageStar|)))))))))))

; searchDropUnexposedLines alist ==
;   [[op,[pred for line in lines | pred],:lines] for [op,.,:lines] in alist] where
;     pred ==
;       not $exposedOnlyIfTrue or dbExposed?(line,dbKind line) => line
;       nil

(DEFUN |searchDropUnexposedLines| (|alist|)
  (PROG (|op| |ISTMP#1| |lines|)
    (RETURN
     ((LAMBDA (|bfVar#57| |bfVar#56| |bfVar#55|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#56|)
               (PROGN (SETQ |bfVar#55| (CAR |bfVar#56|)) NIL))
           (RETURN (NREVERSE |bfVar#57|)))
          (#1='T
           (AND (CONSP |bfVar#55|)
                (PROGN
                 (SETQ |op| (CAR |bfVar#55|))
                 (SETQ |ISTMP#1| (CDR |bfVar#55|))
                 (AND (CONSP |ISTMP#1|)
                      (PROGN (SETQ |lines| (CDR |ISTMP#1|)) #1#)))
                (SETQ |bfVar#57|
                        (CONS
                         (CONS |op|
                               (CONS
                                ((LAMBDA (|bfVar#54| |bfVar#53| |line|)
                                   (LOOP
                                    (COND
                                     ((OR (ATOM |bfVar#53|)
                                          (PROGN
                                           (SETQ |line| (CAR |bfVar#53|))
                                           NIL))
                                      (RETURN (NREVERSE |bfVar#54|)))
                                     (#1#
                                      (AND
                                       #2=(COND
                                           ((OR (NULL |$exposedOnlyIfTrue|)
                                                (|dbExposed?| |line|
                                                 (|dbKind| |line|)))
                                            |line|)
                                           (#1# NIL))
                                       (SETQ |bfVar#54|
                                               (CONS #2# |bfVar#54|)))))
                                    (SETQ |bfVar#53| (CDR |bfVar#53|))))
                                 NIL |lines| NIL)
                                |lines|))
                         |bfVar#57|)))))
         (SETQ |bfVar#56| (CDR |bfVar#56|))))
      NIL |alist| NIL))))

; repeatSearch(htPage,newValue) ==
;   $exposedOnlyIfTrue := newValue
;   filter := htpProperty(htPage,'filter)
;   reg    := htpProperty(htPage,'regSearchAlist)
;   doc    := htpProperty(htPage,'docSearchAlist)
;   reg => genSearch1(filter,reg,doc)
;   docSearch1(filter,doc)

(DEFUN |repeatSearch| (|htPage| |newValue|)
  (PROG (|filter| |reg| |doc|)
    (RETURN
     (PROGN
      (SETQ |$exposedOnlyIfTrue| |newValue|)
      (SETQ |filter| (|htpProperty| |htPage| '|filter|))
      (SETQ |reg| (|htpProperty| |htPage| '|regSearchAlist|))
      (SETQ |doc| (|htpProperty| |htPage| '|docSearchAlist|))
      (COND (|reg| (|genSearch1| |filter| |reg| |doc|))
            ('T (|docSearch1| |filter| |doc|)))))))

; searchCount u == +/[# y for [x,y,:.] in u]

(DEFUN |searchCount| (|u|)
  (PROG (|x| |ISTMP#1| |y|)
    (RETURN
     ((LAMBDA (|bfVar#60| |bfVar#59| |bfVar#58|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#59|)
               (PROGN (SETQ |bfVar#58| (CAR |bfVar#59|)) NIL))
           (RETURN |bfVar#60|))
          (#1='T
           (AND (CONSP |bfVar#58|)
                (PROGN
                 (SETQ |x| (CAR |bfVar#58|))
                 (SETQ |ISTMP#1| (CDR |bfVar#58|))
                 (AND (CONSP |ISTMP#1|)
                      (PROGN (SETQ |y| (CAR |ISTMP#1|)) #1#)))
                (SETQ |bfVar#60| (+ |bfVar#60| (LENGTH |y|))))))
         (SETQ |bfVar#59| (CDR |bfVar#59|))))
      0 |u| NIL))))

; showDoc(htPage,count) ==
;   showIt(htPage,count,htpProperty(htPage,'docSearchAlist))

(DEFUN |showDoc| (|htPage| |count|)
  (PROG ()
    (RETURN
     (|showIt| |htPage| |count| (|htpProperty| |htPage| '|docSearchAlist|)))))

; showConstruct(htPage,count) ==
;   showIt(htPage,count,htpProperty(htPage,'regSearchAlist))

(DEFUN |showConstruct| (|htPage| |count|)
  (PROG ()
    (RETURN
     (|showIt| |htPage| |count| (|htpProperty| |htPage| '|regSearchAlist|)))))

; showIt(htPage,index,searchAlist) ==
;   filter      := htpProperty(htPage,'filter)
;   [relativeIndex,n] := DIVIDE(index,8)
;   relativeIndex = 0 => showNamedConstruct(searchAlist.n)
;   [kind,items,:.] := searchAlist . n
;   for j in 1.. while j < relativeIndex repeat items := rest items
;   firstName := dbName first items --select name then gather all of same name
;   lines := [line for line in items while dbName line = firstName]
;   showNamedConstruct [kind,nil,:lines]

(DEFUN |showIt| (|htPage| |index| |searchAlist|)
  (PROG (|filter| |LETTMP#1| |relativeIndex| |n| |kind| |items| |firstName|
         |lines|)
    (RETURN
     (PROGN
      (SETQ |filter| (|htpProperty| |htPage| '|filter|))
      (SETQ |LETTMP#1| (DIVIDE |index| 8))
      (SETQ |relativeIndex| (CAR |LETTMP#1|))
      (SETQ |n| (CADR |LETTMP#1|))
      (COND
       ((EQL |relativeIndex| 0) (|showNamedConstruct| (ELT |searchAlist| |n|)))
       (#1='T
        (PROGN
         (SETQ |LETTMP#1| (ELT |searchAlist| |n|))
         (SETQ |kind| (CAR |LETTMP#1|))
         (SETQ |items| (CADR |LETTMP#1|))
         ((LAMBDA (|j|)
            (LOOP
             (COND ((NOT (< |j| |relativeIndex|)) (RETURN NIL))
                   (#1# (SETQ |items| (CDR |items|))))
             (SETQ |j| (+ |j| 1))))
          1)
         (SETQ |firstName| (|dbName| (CAR |items|)))
         (SETQ |lines|
                 ((LAMBDA (|bfVar#62| |bfVar#61| |line|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#61|)
                           (PROGN (SETQ |line| (CAR |bfVar#61|)) NIL)
                           (NOT (EQUAL (|dbName| |line|) |firstName|)))
                       (RETURN (NREVERSE |bfVar#62|)))
                      (#1# (SETQ |bfVar#62| (CONS |line| |bfVar#62|))))
                     (SETQ |bfVar#61| (CDR |bfVar#61|))))
                  NIL |items| NIL))
         (|showNamedConstruct| (CONS |kind| (CONS NIL |lines|))))))))))

; showNamedConstruct([kind,.,:lines]) == dbSearch(lines,kind,'"")

(DEFUN |showNamedConstruct| (|bfVar#63|)
  (PROG (|kind| |lines|)
    (RETURN
     (PROGN
      (SETQ |kind| (CAR |bfVar#63|))
      (SETQ |lines| (CDDR |bfVar#63|))
      (|dbSearch| |lines| |kind| "")))))

; genSearchSay(pair,summarize,kind,who,fn) ==
;   [u,:fullLineList] := pair
;   count := #u
;   uniqueCount := genSearchUniqueCount u
;   short := summarize and uniqueCount >= $browseCountThreshold
;   htMakePage
;     [['bcLinks,[menuButton(),'"",'genSearchSayJump,[fullLineList,kind]]]]
;   if count = 0 then htSayList(['"{\em No ", kind, '"} "])
;   else if count = 1 then
;     htSayList(['"{\em 1 ", kind, '"} "])
;   else
;     htSayList(['"{\em ", count, '" ", pluralize kind, '"} "])
;   short => 'done
;   if uniqueCount ~= 1 then
;     htSayStandard '"\indent{4}"
;     htSay '"\newline "
;     htBeginTable()
;   lastid := nil
;   groups := organizeByName u
;   i := 1
;   for group in groups repeat
;     id := dbGetName first group
;     if $includeUnexposed? then
;       exposed? := or/[dbExposed?(item,dbKind item) for item in group]
;     bcHt '"{"
;     if $includeUnexposed? then
;         exposed? => htBlank()
;         htSayUnexposed()
;     htMakePage [['bcLinks, [id,'"",fn,who + 8*i]]]
;     i := i + #group
;     bcHt '"}"
;   if uniqueCount ~= 1 then
;      htEndTable()
;      htSayStandard '"\indent{0}"

(DEFUN |genSearchSay| (|pair| |summarize| |kind| |who| |fn|)
  (PROG (|u| |fullLineList| |count| |uniqueCount| |short| |lastid| |groups| |i|
         |id| |exposed?|)
    (RETURN
     (PROGN
      (SETQ |u| (CAR |pair|))
      (SETQ |fullLineList| (CDR |pair|))
      (SETQ |count| (LENGTH |u|))
      (SETQ |uniqueCount| (|genSearchUniqueCount| |u|))
      (SETQ |short|
              (AND |summarize|
                   (NOT (< |uniqueCount| |$browseCountThreshold|))))
      (|htMakePage|
       (LIST
        (LIST '|bcLinks|
              (LIST (|menuButton|) "" '|genSearchSayJump|
                    (LIST |fullLineList| |kind|)))))
      (COND ((EQL |count| 0) (|htSayList| (LIST "{\\em No " |kind| "} ")))
            ((EQL |count| 1) (|htSayList| (LIST "{\\em 1 " |kind| "} ")))
            (#1='T
             (|htSayList|
              (LIST "{\\em " |count| " " (|pluralize| |kind|) "} "))))
      (COND (|short| '|done|)
            (#1#
             (PROGN
              (COND
               ((NOT (EQL |uniqueCount| 1)) (|htSayStandard| "\\indent{4}")
                (|htSay| "\\newline ") (|htBeginTable|)))
              (SETQ |lastid| NIL)
              (SETQ |groups| (|organizeByName| |u|))
              (SETQ |i| 1)
              ((LAMBDA (|bfVar#64| |group|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#64|)
                        (PROGN (SETQ |group| (CAR |bfVar#64|)) NIL))
                    (RETURN NIL))
                   (#1#
                    (PROGN
                     (SETQ |id| (|dbGetName| (CAR |group|)))
                     (COND
                      (|$includeUnexposed?|
                       (SETQ |exposed?|
                               ((LAMBDA (|bfVar#66| |bfVar#65| |item|)
                                  (LOOP
                                   (COND
                                    ((OR (ATOM |bfVar#65|)
                                         (PROGN
                                          (SETQ |item| (CAR |bfVar#65|))
                                          NIL))
                                     (RETURN |bfVar#66|))
                                    (#1#
                                     (PROGN
                                      (SETQ |bfVar#66|
                                              (|dbExposed?| |item|
                                               (|dbKind| |item|)))
                                      (COND
                                       (|bfVar#66| (RETURN |bfVar#66|))))))
                                   (SETQ |bfVar#65| (CDR |bfVar#65|))))
                                NIL |group| NIL))))
                     (|bcHt| "{")
                     (COND
                      (|$includeUnexposed?|
                       (COND (|exposed?| (|htBlank|))
                             (#1# (|htSayUnexposed|)))))
                     (|htMakePage|
                      (LIST
                       (LIST '|bcLinks|
                             (LIST |id| "" |fn| (+ |who| (* 8 |i|))))))
                     (SETQ |i| (+ |i| (LENGTH |group|)))
                     (|bcHt| "}"))))
                  (SETQ |bfVar#64| (CDR |bfVar#64|))))
               |groups| NIL)
              (COND
               ((NOT (EQL |uniqueCount| 1)) (|htEndTable|)
                (|htSayStandard| "\\indent{0}"))))))))))

; organizeByName u ==
;   [[(u := rest u; x) while u and head = dbName (x := first u)]
;       while u and (head := dbName first u)]

(DEFUN |organizeByName| (|u|)
  (PROG (|head| |x|)
    (RETURN
     ((LAMBDA (|bfVar#68|)
        (LOOP
         (COND
          ((NOT (AND |u| (SETQ |head| (|dbName| (CAR |u|)))))
           (RETURN (NREVERSE |bfVar#68|)))
          (#1='T
           (SETQ |bfVar#68|
                   (CONS
                    ((LAMBDA (|bfVar#67|)
                       (LOOP
                        (COND
                         ((NOT
                           (AND |u|
                                (EQUAL |head|
                                       (|dbName| (SETQ |x| (CAR |u|))))))
                          (RETURN (NREVERSE |bfVar#67|)))
                         (#1#
                          (SETQ |bfVar#67|
                                  (CONS (PROGN (SETQ |u| (CDR |u|)) |x|)
                                        |bfVar#67|))))))
                     NIL)
                    |bfVar#68|))))))
      NIL))))

; genSearchSayJump(htPage,[lines,kind]) ==
;   filter := htpProperty(htPage,'filter)
;   dbSearch(lines,kind,filter)

(DEFUN |genSearchSayJump| (|htPage| |bfVar#69|)
  (PROG (|lines| |kind| |filter|)
    (RETURN
     (PROGN
      (SETQ |lines| (CAR |bfVar#69|))
      (SETQ |kind| (CADR |bfVar#69|))
      (SETQ |filter| (|htpProperty| |htPage| '|filter|))
      (|dbSearch| |lines| |kind| |filter|)))))

; genSearchUniqueCount(u) ==
; --count the unique number of items (if less than $browseCountThreshold)
;   count := 0
;   lastid := nil
;   for item in u while count < $browseCountThreshold repeat
;     id := dbGetName item
;     if id ~= lastid then
;       count := count + 1
;       lastid := id
;   count

(DEFUN |genSearchUniqueCount| (|u|)
  (PROG (|count| |lastid| |id|)
    (RETURN
     (PROGN
      (SETQ |count| 0)
      (SETQ |lastid| NIL)
      ((LAMBDA (|bfVar#70| |item|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#70|) (PROGN (SETQ |item| (CAR |bfVar#70|)) NIL)
                (NOT (< |count| |$browseCountThreshold|)))
            (RETURN NIL))
           ('T
            (PROGN
             (SETQ |id| (|dbGetName| |item|))
             (COND
              ((NOT (EQUAL |id| |lastid|)) (SETQ |count| (+ |count| 1))
               (SETQ |lastid| |id|))))))
          (SETQ |bfVar#70| (CDR |bfVar#70|))))
       |u| NIL)
      |count|))))

; dbGetName line == SUBSTRING(line,1,charPosition($tick,line,1) - 1)

(DEFUN |dbGetName| (|line|)
  (PROG ()
    (RETURN (SUBSTRING |line| 1 (- (|charPosition| |$tick| |line| 1) 1)))))

; pluralSay(count,singular,plural) ==
;     count = 0 => concat('"No ", singular)
;     count = 1 => concat('"1 ", singular)
;     concat(count, '" ", plural)

(DEFUN |pluralSay| (|count| |singular| |plural|)
  (PROG ()
    (RETURN
     (COND ((EQL |count| 0) (|concat| "No " |singular|))
           ((EQL |count| 1) (|concat| "1 " |singular|))
           ('T (|concat| |count| " " |plural|))))))

; docSearch filter ==  --"Documentation" from HD (see man0.ht)
;   null (filter := checkFilter filter) => nil  --in case of filter error
;   filter = '"*" => htErrorStar()
;   key := removeSurroundingStars filter
;   docSearchAlist := grepConstruct(filter,'w,true)
;   docSearchAlist is ['error,:.] => bcErrorPage docSearchAlist
;   docSearchAlist := [x for x in docSearchAlist | x.0 ~= char 'x] --drop defaults
;   docSearch1(filter,genSearchTran docSearchAlist)

(DEFUN |docSearch| (|filter|)
  (PROG (|key| |docSearchAlist|)
    (RETURN
     (COND ((NULL (SETQ |filter| (|checkFilter| |filter|))) NIL)
           ((EQUAL |filter| "*") (|htErrorStar|))
           (#1='T
            (PROGN
             (SETQ |key| (|removeSurroundingStars| |filter|))
             (SETQ |docSearchAlist| (|grepConstruct| |filter| '|w| T))
             (COND
              ((AND (CONSP |docSearchAlist|)
                    (EQ (CAR |docSearchAlist|) '|error|))
               (|bcErrorPage| |docSearchAlist|))
              (#1#
               (PROGN
                (SETQ |docSearchAlist|
                        ((LAMBDA (|bfVar#72| |bfVar#71| |x|)
                           (LOOP
                            (COND
                             ((OR (ATOM |bfVar#71|)
                                  (PROGN (SETQ |x| (CAR |bfVar#71|)) NIL))
                              (RETURN (NREVERSE |bfVar#72|)))
                             (#1#
                              (AND (NOT (EQUAL (ELT |x| 0) (|char| '|x|)))
                                   (SETQ |bfVar#72| (CONS |x| |bfVar#72|)))))
                            (SETQ |bfVar#71| (CDR |bfVar#71|))))
                         NIL |docSearchAlist| NIL))
                (|docSearch1| |filter|
                 (|genSearchTran| |docSearchAlist|)))))))))))

; docSearch1(filter,doc) ==
;   docSearchAlist := searchDropUnexposedLines doc
;   count := searchCount docSearchAlist
;   count = 0 => emptySearchPage('"entry",filter,true)
;   count = 1 => showNamedConstruct(or/[x for x in docSearchAlist | CADR x])
;   prefix := pluralSay(count,'"entry matches",'"entries match")
;   emfilter := ['"{\em ",escapeSpecialChars STRINGIMAGE filter,'"}"]
;   header := [:prefix,'" ",:emfilter]
;   page := htInitPage(header,nil)
;   htpSetProperty(page,'docSearchAlist,docSearchAlist)
;   htpSetProperty(page,'regSearchAlist,nil)
;   htpSetProperty(page,'filter,filter)
;   dbSayItems(['"\newline Documentation Summary: ",count],'"mention",'"mentions",'" of {\em ",filter,'"}")
;   for [kind,:pair] in docSearchAlist for i in 0.. | #(first pair) > 0 repeat
;     bcHt '"\newline{}"
;     htSayStandard '"\tab{2}"
;     genSearchSay(pair,true,kind,i,'showDoc)
;   htShowPageStar()

(DEFUN |docSearch1| (|filter| |doc|)
  (PROG (|docSearchAlist| |count| |prefix| |emfilter| |header| |page| |kind|
         |pair|)
    (RETURN
     (PROGN
      (SETQ |docSearchAlist| (|searchDropUnexposedLines| |doc|))
      (SETQ |count| (|searchCount| |docSearchAlist|))
      (COND ((EQL |count| 0) (|emptySearchPage| "entry" |filter| T))
            ((EQL |count| 1)
             (|showNamedConstruct|
              ((LAMBDA (|bfVar#74| |bfVar#73| |x|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#73|)
                        (PROGN (SETQ |x| (CAR |bfVar#73|)) NIL))
                    (RETURN |bfVar#74|))
                   (#1='T
                    (AND (CADR |x|)
                         (PROGN
                          (SETQ |bfVar#74| |x|)
                          (COND (|bfVar#74| (RETURN |bfVar#74|)))))))
                  (SETQ |bfVar#73| (CDR |bfVar#73|))))
               NIL |docSearchAlist| NIL)))
            (#1#
             (PROGN
              (SETQ |prefix|
                      (|pluralSay| |count| "entry matches" "entries match"))
              (SETQ |emfilter|
                      (LIST "{\\em "
                            (|escapeSpecialChars| (STRINGIMAGE |filter|)) "}"))
              (SETQ |header| (APPEND |prefix| (CONS " " |emfilter|)))
              (SETQ |page| (|htInitPage| |header| NIL))
              (|htpSetProperty| |page| '|docSearchAlist| |docSearchAlist|)
              (|htpSetProperty| |page| '|regSearchAlist| NIL)
              (|htpSetProperty| |page| '|filter| |filter|)
              (|dbSayItems| (LIST "\\newline Documentation Summary: " |count|)
               "mention" "mentions" " of {\\em " |filter| "}")
              ((LAMBDA (|bfVar#76| |bfVar#75| |i|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#76|)
                        (PROGN (SETQ |bfVar#75| (CAR |bfVar#76|)) NIL))
                    (RETURN NIL))
                   (#1#
                    (AND (CONSP |bfVar#75|)
                         (PROGN
                          (SETQ |kind| (CAR |bfVar#75|))
                          (SETQ |pair| (CDR |bfVar#75|))
                          #1#)
                         (< 0 (LENGTH (CAR |pair|)))
                         (PROGN
                          (|bcHt| "\\newline{}")
                          (|htSayStandard| "\\tab{2}")
                          (|genSearchSay| |pair| T |kind| |i| '|showDoc|)))))
                  (SETQ |bfVar#76| (CDR |bfVar#76|))
                  (SETQ |i| (+ |i| 1))))
               |docSearchAlist| NIL 0)
              (|htShowPageStar|))))))))

; removeSurroundingStars filter ==
;   key := STRINGIMAGE filter
;   if key.0 = char '_* then key := SUBSTRING(key,1,nil)
;   if key.(max := MAXINDEX key) = char '_* then key := SUBSTRING(key,0,max)
;   key

(DEFUN |removeSurroundingStars| (|filter|)
  (PROG (|key| |max|)
    (RETURN
     (PROGN
      (SETQ |key| (STRINGIMAGE |filter|))
      (COND
       ((EQUAL (ELT |key| 0) (|char| '*))
        (SETQ |key| (SUBSTRING |key| 1 NIL))))
      (COND
       ((EQUAL (ELT |key| (SETQ |max| (MAXINDEX |key|))) (|char| '*))
        (SETQ |key| (SUBSTRING |key| 0 |max|))))
      |key|))))

; showNamedDoc([kind,:lines],index) ==
;   dbGather(kind,lines,index - 1,true)

(DEFUN |showNamedDoc| (|bfVar#77| |index|)
  (PROG (|kind| |lines|)
    (RETURN
     (PROGN
      (SETQ |kind| (CAR |bfVar#77|))
      (SETQ |lines| (CDR |bfVar#77|))
      (|dbGather| |kind| |lines| (- |index| 1) T)))))

; sayDocMessage message ==
;   htSay('"{\em ")
;   if message is [leftEnd,left,middle,right,rightEnd] then
;     htSayList([leftEnd, left, '"}"])
;     if left ~= '"" and left.(MAXINDEX left) = $blank then htBlank()
;     htSay middle
;     if right ~= '"" and right.0 = $blank then htBlank()
;     htSayList(['"{\em ", right, rightEnd])
;   else
;     htSay message
;   htSay ('"}")

(DEFUN |sayDocMessage| (|message|)
  (PROG (|leftEnd| |ISTMP#1| |left| |ISTMP#2| |middle| |ISTMP#3| |right|
         |ISTMP#4| |rightEnd|)
    (RETURN
     (PROGN
      (|htSay| "{\\em ")
      (COND
       ((AND (CONSP |message|)
             (PROGN
              (SETQ |leftEnd| (CAR |message|))
              (SETQ |ISTMP#1| (CDR |message|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |left| (CAR |ISTMP#1|))
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|)
                         (PROGN
                          (SETQ |middle| (CAR |ISTMP#2|))
                          (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                          (AND (CONSP |ISTMP#3|)
                               (PROGN
                                (SETQ |right| (CAR |ISTMP#3|))
                                (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                                (AND (CONSP |ISTMP#4|) (EQ (CDR |ISTMP#4|) NIL)
                                     (PROGN
                                      (SETQ |rightEnd| (CAR |ISTMP#4|))
                                      #1='T))))))))))
        (|htSayList| (LIST |leftEnd| |left| "}"))
        (COND
         ((AND (NOT (EQUAL |left| ""))
               (EQUAL (ELT |left| (MAXINDEX |left|)) |$blank|))
          (|htBlank|)))
        (|htSay| |middle|)
        (COND
         ((AND (NOT (EQUAL |right| "")) (EQUAL (ELT |right| 0) |$blank|))
          (|htBlank|)))
        (|htSayList| (LIST "{\\em " |right| |rightEnd|)))
       (#1# (|htSay| |message|)))
      (|htSay| "}")))))

; stripOffSegments(s,n) ==
;   progress := true
;   while n > 0 and progress = true repeat
;     n := n - 1
;     k := charPosition(char '_`,s,0)
;     new := SUBSTRING(s,k + 1,nil)
;     #new < #s => s := new
;     progress := false
;   n = 0 => s
;   nil

(DEFUN |stripOffSegments| (|s| |n|)
  (PROG (|progress| |k| |new|)
    (RETURN
     (PROGN
      (SETQ |progress| T)
      ((LAMBDA ()
         (LOOP
          (COND ((NOT (AND (< 0 |n|) (EQUAL |progress| T))) (RETURN NIL))
                (#1='T
                 (PROGN
                  (SETQ |n| (- |n| 1))
                  (SETQ |k| (|charPosition| (|char| '|`|) |s| 0))
                  (SETQ |new| (SUBSTRING |s| (+ |k| 1) NIL))
                  (COND ((< (LENGTH |new|) (LENGTH |s|)) (SETQ |s| |new|))
                        (#1# (SETQ |progress| NIL)))))))))
      (COND ((EQL |n| 0) |s|) (#1# NIL))))))

; replaceTicksBySpaces s ==
;   n := -1
;   max := MAXINDEX s
;   while (n := charPosition(char '_`,s,n + 1)) <= max repeat SETELT(s,n,char '_ )
;   s

(DEFUN |replaceTicksBySpaces| (|s|)
  (PROG (|n| |max|)
    (RETURN
     (PROGN
      (SETQ |n| (- 1))
      (SETQ |max| (MAXINDEX |s|))
      ((LAMBDA ()
         (LOOP
          (COND
           ((< |max| (SETQ |n| (|charPosition| (|char| '|`|) |s| (+ |n| 1))))
            (RETURN NIL))
           ('T (SETELT |s| |n| (|char| '| |)))))))
      |s|))))

; checkFilter filter ==
;   filter := STRINGIMAGE filter
;   filter = '"" => '"*"
;   trimString filter

(DEFUN |checkFilter| (|filter|)
  (PROG ()
    (RETURN
     (PROGN
      (SETQ |filter| (STRINGIMAGE |filter|))
      (COND ((EQUAL |filter| "") "*") ('T (|trimString| |filter|)))))))

; oSearch filter == -- called from HD (man0.ht): operation search
;   opAlist := opPageFastPath filter => opPageFast opAlist
;   key := 'o
;   null (filter := checkFilter filter) => nil  --in case of filter error
;   filter = '"*" => grepSearchQuery('"operation",[filter,key,'"operation",'oSearchGrep])
;   oSearchGrep(filter,key,'"operation")

(DEFUN |oSearch| (|filter|)
  (PROG (|opAlist| |key|)
    (RETURN
     (COND
      ((SETQ |opAlist| (|opPageFastPath| |filter|)) (|opPageFast| |opAlist|))
      (#1='T
       (PROGN
        (SETQ |key| '|o|)
        (COND ((NULL (SETQ |filter| (|checkFilter| |filter|))) NIL)
              ((EQUAL |filter| "*")
               (|grepSearchQuery| "operation"
                (LIST |filter| |key| "operation" '|oSearchGrep|)))
              (#1# (|oSearchGrep| |filter| |key| "operation")))))))))

; oSearchGrep(filter,key,kind) == --called from grepSearchQuery/oSearch
;   dbSearch(grepConstruct(filter,'o),kind,filter)

(DEFUN |oSearchGrep| (|filter| |key| |kind|)
  (PROG ()
    (RETURN (|dbSearch| (|grepConstruct| |filter| '|o|) |kind| |filter|))))

; grepSearchQuery(kind,items) ==
;   page := htInitPage('"Query Page",nil)
;   htpSetProperty(page,'items,items)
;   htQuery(['"{\em Do you want a list of {\em all} ",pluralize kind,'"?\vspace{1}}"],'grepSearchJump,true)
;   htShowPage()

(DEFUN |grepSearchQuery| (|kind| |items|)
  (PROG (|page|)
    (RETURN
     (PROGN
      (SETQ |page| (|htInitPage| "Query Page" NIL))
      (|htpSetProperty| |page| '|items| |items|)
      (|htQuery|
       (LIST "{\\em Do you want a list of {\\em all} " (|pluralize| |kind|)
             "?\\vspace{1}}")
       '|grepSearchJump| T)
      (|htShowPage|)))))

; cSearch filter ==  --called from HD (man0.ht): category search
;    constructorSearch(checkFilter filter,'c,'"category")

(DEFUN |cSearch| (|filter|)
  (PROG ()
    (RETURN (|constructorSearch| (|checkFilter| |filter|) '|c| "category"))))

; dSearch filter ==  --called from HD (man0.ht): domain search
;    constructorSearch(checkFilter filter,'d,'"domain")

(DEFUN |dSearch| (|filter|)
  (PROG ()
    (RETURN (|constructorSearch| (|checkFilter| |filter|) '|d| "domain"))))

; pSearch filter ==  --called from HD (man0.ht): package search
;    constructorSearch(checkFilter filter,'p,'"package")

(DEFUN |pSearch| (|filter|)
  (PROG ()
    (RETURN (|constructorSearch| (|checkFilter| |filter|) '|p| "package"))))

; xSearch filter ==  --called from HD (man0.ht): default package search
;    constructorSearch(checkFilter filter,'x,'"default package")

(DEFUN |xSearch| (|filter|)
  (PROG ()
    (RETURN
     (|constructorSearch| (|checkFilter| |filter|) '|x| "default package"))))

; kSearch filter ==  --called from HD (man0.ht): constructor search (no defaults)
;    constructorSearch(checkFilter filter,'k,'"constructor")

(DEFUN |kSearch| (|filter|)
  (PROG ()
    (RETURN (|constructorSearch| (|checkFilter| |filter|) '|k| "constructor"))))

; ySearch filter == --called from conPage: like kSearch but defaults included
;   constructorSearch(checkFilter filter,'y,'"constructor")

(DEFUN |ySearch| (|filter|)
  (PROG ()
    (RETURN (|constructorSearch| (|checkFilter| |filter|) '|y| "constructor"))))

; constructorSearch(filter,key,kind) ==
;   null filter => nil      --in case of filter error
;   (parse := conSpecialString? filter) => conPage parse
;   pageName := LASSOC(DOWNCASE filter,'(("union" . DomainUnion)("record" . DomainRecord)("mapping" . DomainMapping) ("enumeration" . DomainEnumeration))) =>
;     downlink pageName
;   name := (STRINGP filter => INTERN filter; filter)
;   if u := HGET($lowerCaseConTb,name) then filter := STRINGIMAGE first u
;   line := conPageFastPath DOWNCASE filter =>
;     code := dbKind line
;     newkind :=
;       code = char 'p => '"package"
;       code = char 'd => '"domain"
;       code = char 'c => '"category"
;       nil
;     kind = '"constructor" or kind = newkind => kPage(line, [])
;     page := htInitPage('"Query Page",nil)
;     htpSetProperty(page,'line,line)
;     message :=
;       ['"{\em ",dbName line,'"} is not a {\em ",kind,'"} but a {\em ",
;         newkind,'"}. Would you like to view it?\vspace{1}"]
;     htQuery(message, 'grepConstructorSearch,true)
;     htShowPage()
;   filter = '"*" => grepSearchQuery(kind,[filter,key,kind,'constructorSearchGrep])
;   constructorSearchGrep(filter,key,kind)

(DEFUN |constructorSearch| (|filter| |key| |kind|)
  (PROG (|parse| |pageName| |name| |u| |line| |code| |newkind| |page|
         |message|)
    (RETURN
     (COND ((NULL |filter|) NIL)
           ((SETQ |parse| (|conSpecialString?| |filter|)) (|conPage| |parse|))
           ((SETQ |pageName|
                    (LASSOC (DOWNCASE |filter|)
                     '(("union" . |DomainUnion|) ("record" . |DomainRecord|)
                       ("mapping" . |DomainMapping|)
                       ("enumeration" . |DomainEnumeration|))))
            (|downlink| |pageName|))
           (#1='T
            (PROGN
             (SETQ |name|
                     (COND ((STRINGP |filter|) (INTERN |filter|))
                           (#1# |filter|)))
             (COND
              ((SETQ |u| (HGET |$lowerCaseConTb| |name|))
               (SETQ |filter| (STRINGIMAGE (CAR |u|)))))
             (COND
              ((SETQ |line| (|conPageFastPath| (DOWNCASE |filter|)))
               (PROGN
                (SETQ |code| (|dbKind| |line|))
                (SETQ |newkind|
                        (COND ((EQUAL |code| (|char| '|p|)) "package")
                              ((EQUAL |code| (|char| '|d|)) "domain")
                              ((EQUAL |code| (|char| '|c|)) "category")
                              (#1# NIL)))
                (COND
                 ((OR (EQUAL |kind| "constructor") (EQUAL |kind| |newkind|))
                  (|kPage| |line| NIL))
                 (#1#
                  (PROGN
                   (SETQ |page| (|htInitPage| "Query Page" NIL))
                   (|htpSetProperty| |page| '|line| |line|)
                   (SETQ |message|
                           (LIST "{\\em " (|dbName| |line|) "} is not a {\\em "
                                 |kind| "} but a {\\em " |newkind|
                                 "}. Would you like to view it?\\vspace{1}"))
                   (|htQuery| |message| '|grepConstructorSearch| T)
                   (|htShowPage|))))))
              ((EQUAL |filter| "*")
               (|grepSearchQuery| |kind|
                (LIST |filter| |key| |kind| '|constructorSearchGrep|)))
              (#1# (|constructorSearchGrep| |filter| |key| |kind|)))))))))

; grepConstructorSearch(htPage, yes) == kPage(htpProperty(htPage, 'line), [])

(DEFUN |grepConstructorSearch| (|htPage| |yes|)
  (PROG () (RETURN (|kPage| (|htpProperty| |htPage| '|line|) NIL))))

; conSpecialString?(filter) == conSpecialString2?(filter, false)

(DEFUN |conSpecialString?| (|filter|)
  (PROG () (RETURN (|conSpecialString2?| |filter| NIL))))

; conSpecialString2?(filter, secondTime) ==
;   parse :=
;     words := string2Words filter is [s] => ncParseFromString s
;     and/[not member(x,'("and" "or" "not")) for x in words] => ncParseFromString filter
;     false
;   null parse => nil
;   form := conLowerCaseConTran parse
;   MEMQ(IFCAR form, '(and or not)) or CONTAINED("*", form) => nil
;   filter = '"Mapping" =>nil
;   u := kisValidType form => u
;   secondTime => false
;   u := "STRCONC"/[string2Constructor x for x in dbString2Words filter]
;   conSpecialString2?(u, true)

(DEFUN |conSpecialString2?| (|filter| |secondTime|)
  (PROG (|ISTMP#1| |s| |words| |parse| |form| |u|)
    (RETURN
     (PROGN
      (SETQ |parse|
              (COND
               ((SETQ |words|
                        (PROGN
                         (SETQ |ISTMP#1| (|string2Words| |filter|))
                         (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                              (PROGN (SETQ |s| (CAR |ISTMP#1|)) #1='T))))
                (|ncParseFromString| |s|))
               (((LAMBDA (|bfVar#79| |bfVar#78| |x|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#78|)
                          (PROGN (SETQ |x| (CAR |bfVar#78|)) NIL))
                      (RETURN |bfVar#79|))
                     (#1#
                      (PROGN
                       (SETQ |bfVar#79|
                               (NULL (|member| |x| '("and" "or" "not"))))
                       (COND ((NOT |bfVar#79|) (RETURN NIL))))))
                    (SETQ |bfVar#78| (CDR |bfVar#78|))))
                 T |words| NIL)
                (|ncParseFromString| |filter|))
               (#1# NIL)))
      (COND ((NULL |parse|) NIL)
            (#1#
             (PROGN
              (SETQ |form| (|conLowerCaseConTran| |parse|))
              (COND
               ((OR (MEMQ (IFCAR |form|) '(|and| |or| |not|))
                    (CONTAINED '* |form|))
                NIL)
               ((EQUAL |filter| "Mapping") NIL)
               ((SETQ |u| (|kisValidType| |form|)) |u|) (|secondTime| NIL)
               (#1#
                (PROGN
                 (SETQ |u|
                         ((LAMBDA (|bfVar#81| |bfVar#80| |x|)
                            (LOOP
                             (COND
                              ((OR (ATOM |bfVar#80|)
                                   (PROGN (SETQ |x| (CAR |bfVar#80|)) NIL))
                               (RETURN |bfVar#81|))
                              (#1#
                               (SETQ |bfVar#81|
                                       (STRCONC |bfVar#81|
                                        (|string2Constructor| |x|)))))
                             (SETQ |bfVar#80| (CDR |bfVar#80|))))
                          "" (|dbString2Words| |filter|) NIL))
                 (|conSpecialString2?| |u| T)))))))))))

; dbString2Words l ==
;   i := 0
;   [w while dbWordFrom(l,i) is [w,i]]

(DEFUN |dbString2Words| (|l|)
  (PROG (|i| |ISTMP#1| |w| |ISTMP#2|)
    (RETURN
     (PROGN
      (SETQ |i| 0)
      ((LAMBDA (|bfVar#82|)
         (LOOP
          (COND
           ((NOT
             (PROGN
              (SETQ |ISTMP#1| (|dbWordFrom| |l| |i|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |w| (CAR |ISTMP#1|))
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                         (PROGN (SETQ |i| (CAR |ISTMP#2|)) #1='T))))))
            (RETURN (NREVERSE |bfVar#82|)))
           (#1# (SETQ |bfVar#82| (CONS |w| |bfVar#82|))))))
       NIL)))))

; $dbDelimiters := [char " " , char "(", char ")"]

(EVAL-WHEN (EVAL LOAD)
  (SETQ |$dbDelimiters| (LIST (|char| '| |) (|char| '|(|) (|char| '|)|))))

; dbWordFrom(l,i) ==
;   maxIndex := MAXINDEX l
;   while maxIndex >= i and l.i = char " " repeat i := i + 1
;   if maxIndex >= i and member(l.i, $dbDelimiters) then return [l.i, i + 1]
;   k := or/[j for j in i..maxIndex | not member(l.j, $dbDelimiters)] or return nil
;   buf := '""
;   while k <= maxIndex and not member(c := l.k, $dbDelimiters) repeat
;     ch :=
;       c = char '__   => l.(k := 1+k)  --this may exceed bounds
;       c
;     buf := STRCONC(buf,ch)
;     k := k + 1
;   [buf,k]

(DEFUN |dbWordFrom| (|l| |i|)
  (PROG (|maxIndex| |k| |buf| |c| |ch|)
    (RETURN
     (PROGN
      (SETQ |maxIndex| (MAXINDEX |l|))
      ((LAMBDA ()
         (LOOP
          (COND
           ((NOT
             (AND (NOT (< |maxIndex| |i|))
                  (EQUAL (ELT |l| |i|) (|char| '| |))))
            (RETURN NIL))
           (#1='T (SETQ |i| (+ |i| 1)))))))
      (COND
       ((AND (NOT (< |maxIndex| |i|)) (|member| (ELT |l| |i|) |$dbDelimiters|))
        (RETURN (LIST (ELT |l| |i|) (+ |i| 1)))))
      (SETQ |k|
              (OR
               ((LAMBDA (|bfVar#83| |j|)
                  (LOOP
                   (COND ((> |j| |maxIndex|) (RETURN |bfVar#83|))
                         (#1#
                          (AND (NULL (|member| (ELT |l| |j|) |$dbDelimiters|))
                               (PROGN
                                (SETQ |bfVar#83| |j|)
                                (COND (|bfVar#83| (RETURN |bfVar#83|)))))))
                   (SETQ |j| (+ |j| 1))))
                NIL |i|)
               (RETURN NIL)))
      (SETQ |buf| "")
      ((LAMBDA ()
         (LOOP
          (COND
           ((NOT
             (AND (NOT (< |maxIndex| |k|))
                  (NULL (|member| (SETQ |c| (ELT |l| |k|)) |$dbDelimiters|))))
            (RETURN NIL))
           (#1#
            (PROGN
             (SETQ |ch|
                     (COND
                      ((EQUAL |c| (|char| '_)) (ELT |l| (SETQ |k| (+ 1 |k|))))
                      (#1# |c|)))
             (SETQ |buf| (STRCONC |buf| |ch|))
             (SETQ |k| (+ |k| 1))))))))
      (LIST |buf| |k|)))))

; conLowerCaseConTran x ==
;   IDENTP x => IFCAR HGET($lowerCaseConTb, x) or x
;   atom x   => x
;   [conLowerCaseConTran y for y in x]

(DEFUN |conLowerCaseConTran| (|x|)
  (PROG ()
    (RETURN
     (COND ((IDENTP |x|) (OR (IFCAR (HGET |$lowerCaseConTb| |x|)) |x|))
           ((ATOM |x|) |x|)
           (#1='T
            ((LAMBDA (|bfVar#85| |bfVar#84| |y|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#84|)
                      (PROGN (SETQ |y| (CAR |bfVar#84|)) NIL))
                  (RETURN (NREVERSE |bfVar#85|)))
                 (#1#
                  (SETQ |bfVar#85|
                          (CONS (|conLowerCaseConTran| |y|) |bfVar#85|))))
                (SETQ |bfVar#84| (CDR |bfVar#84|))))
             NIL |x| NIL))))))

; string2Constructor x ==
;   not STRINGP x => x
;   IFCAR HGET($lowerCaseConTb, INTERN DOWNCASE x) or x

(DEFUN |string2Constructor| (|x|)
  (PROG ()
    (RETURN
     (COND ((NULL (STRINGP |x|)) |x|)
           ('T
            (OR (IFCAR (HGET |$lowerCaseConTb| (INTERN (DOWNCASE |x|))))
                |x|))))))

; constructorSearchGrep(filter,key,kind) ==
;   dbSearch(grepConstruct(filter,key),kind,filter)

(DEFUN |constructorSearchGrep| (|filter| |key| |kind|)
  (PROG ()
    (RETURN (|dbSearch| (|grepConstruct| |filter| |key|) |kind| |filter|))))

; grepSearchJump(htPage,yes) ==
;   [filter,key,kind,fn] := htpProperty(htPage,'items)
;   FUNCALL(fn,filter,key,kind)

(DEFUN |grepSearchJump| (|htPage| |yes|)
  (PROG (|LETTMP#1| |filter| |key| |kind| |fn|)
    (RETURN
     (PROGN
      (SETQ |LETTMP#1| (|htpProperty| |htPage| '|items|))
      (SETQ |filter| (CAR |LETTMP#1|))
      (SETQ |key| (CADR . #1=(|LETTMP#1|)))
      (SETQ |kind| (CADDR . #1#))
      (SETQ |fn| (CADDDR . #1#))
      (FUNCALL |fn| |filter| |key| |kind|)))))

; dbSearch(lines,kind,filter) == --called by attribute, operation, constructor search
;   kind = '"attribute" => BREAK()
;   lines is ['error,:.] => bcErrorPage lines
;   null filter => nil      --means filter error
;   lines is ['Abbreviations,:r] => dbSearchAbbrev(lines,kind,filter)
;   if kind = '"operation" then --should not be necessary!!
;     lines := dbScreenForDefaultFunctions lines
;   count := #lines
;   count = 0 => emptySearchPage(kind, filter, false)
;   kind = '"operation" => dbShowOperationLines(kind, lines)
;   dbShowConstructorLines lines

(DEFUN |dbSearch| (|lines| |kind| |filter|)
  (PROG (|r| |count|)
    (RETURN
     (COND ((EQUAL |kind| "attribute") (BREAK))
           ((AND (CONSP |lines|) (EQ (CAR |lines|) '|error|))
            (|bcErrorPage| |lines|))
           ((NULL |filter|) NIL)
           ((AND (CONSP |lines|) (EQ (CAR |lines|) '|Abbreviations|)
                 (PROGN (SETQ |r| (CDR |lines|)) #1='T))
            (|dbSearchAbbrev| |lines| |kind| |filter|))
           (#1#
            (PROGN
             (COND
              ((EQUAL |kind| "operation")
               (SETQ |lines| (|dbScreenForDefaultFunctions| |lines|))))
             (SETQ |count| (LENGTH |lines|))
             (COND ((EQL |count| 0) (|emptySearchPage| |kind| |filter| NIL))
                   ((EQUAL |kind| "operation")
                    (|dbShowOperationLines| |kind| |lines|))
                   (#1# (|dbShowConstructorLines| |lines|)))))))))

; dbSearchAbbrev([.,:conlist],kind,filter) ==
;   null conlist => emptySearchPage('"abbreviation", filter, false)
;   kind := intern kind
;   if kind ~= 'constructor then
;     conlist := [x for x in conlist | LASSOC('kind,IFCDR IFCDR x) = kind]
;   conlist is [[nam,:.]] => conPage DOWNCASE nam
;   cAlist := [[con,:true] for con in conlist]
;   htPage := htInitPage('"",nil)
;   htpSetProperty(htPage,'cAlist,cAlist)
;   htpSetProperty(htPage,'thing,nil)
;   return dbShowCons(htPage,'names)
;   page := htInitPage([#conlist,
;     '" Abbreviations Match {\em ",STRINGIMAGE filter,'"}"],nil)
;   for [nam,abbr,:r] in conlist repeat
;     kind := LASSOC('kind,r)
;     htSayList(['"\newline{\em ", s := STRINGIMAGE abbr])
;     htSayStandard '"\tab{10}"
;     htSay '"}"
;     htSay kind
;     htSayStandard '"\tab{19}"
;     bcCon nam
;   htShowPage()

(DEFUN |dbSearchAbbrev| (|bfVar#92| |kind| |filter|)
  (PROG (|conlist| |ISTMP#1| |nam| |cAlist| |htPage| |page| |abbr| |r| |s|)
    (RETURN
     (PROGN
      (SETQ |conlist| (CDR |bfVar#92|))
      (COND ((NULL |conlist|) (|emptySearchPage| "abbreviation" |filter| NIL))
            (#1='T
             (PROGN
              (SETQ |kind| (|intern| |kind|))
              (COND
               ((NOT (EQ |kind| '|constructor|))
                (SETQ |conlist|
                        ((LAMBDA (|bfVar#87| |bfVar#86| |x|)
                           (LOOP
                            (COND
                             ((OR (ATOM |bfVar#86|)
                                  (PROGN (SETQ |x| (CAR |bfVar#86|)) NIL))
                              (RETURN (NREVERSE |bfVar#87|)))
                             (#1#
                              (AND
                               (EQUAL (LASSOC '|kind| (IFCDR (IFCDR |x|)))
                                      |kind|)
                               (SETQ |bfVar#87| (CONS |x| |bfVar#87|)))))
                            (SETQ |bfVar#86| (CDR |bfVar#86|))))
                         NIL |conlist| NIL))))
              (COND
               ((AND (CONSP |conlist|) (EQ (CDR |conlist|) NIL)
                     (PROGN
                      (SETQ |ISTMP#1| (CAR |conlist|))
                      (AND (CONSP |ISTMP#1|)
                           (PROGN (SETQ |nam| (CAR |ISTMP#1|)) #1#))))
                (|conPage| (DOWNCASE |nam|)))
               (#1#
                (PROGN
                 (SETQ |cAlist|
                         ((LAMBDA (|bfVar#89| |bfVar#88| |con|)
                            (LOOP
                             (COND
                              ((OR (ATOM |bfVar#88|)
                                   (PROGN (SETQ |con| (CAR |bfVar#88|)) NIL))
                               (RETURN (NREVERSE |bfVar#89|)))
                              (#1#
                               (SETQ |bfVar#89|
                                       (CONS (CONS |con| T) |bfVar#89|))))
                             (SETQ |bfVar#88| (CDR |bfVar#88|))))
                          NIL |conlist| NIL))
                 (SETQ |htPage| (|htInitPage| "" NIL))
                 (|htpSetProperty| |htPage| '|cAlist| |cAlist|)
                 (|htpSetProperty| |htPage| '|thing| NIL)
                 (RETURN (|dbShowCons| |htPage| '|names|))
                 (SETQ |page|
                         (|htInitPage|
                          (LIST (LENGTH |conlist|)
                                " Abbreviations Match {\\em "
                                (STRINGIMAGE |filter|) "}")
                          NIL))
                 ((LAMBDA (|bfVar#91| |bfVar#90|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#91|)
                           (PROGN (SETQ |bfVar#90| (CAR |bfVar#91|)) NIL))
                       (RETURN NIL))
                      (#1#
                       (AND (CONSP |bfVar#90|)
                            (PROGN
                             (SETQ |nam| (CAR |bfVar#90|))
                             (SETQ |ISTMP#1| (CDR |bfVar#90|))
                             (AND (CONSP |ISTMP#1|)
                                  (PROGN
                                   (SETQ |abbr| (CAR |ISTMP#1|))
                                   (SETQ |r| (CDR |ISTMP#1|))
                                   #1#)))
                            (PROGN
                             (SETQ |kind| (LASSOC '|kind| |r|))
                             (|htSayList|
                              (LIST "\\newline{\\em "
                                    (SETQ |s| (STRINGIMAGE |abbr|))))
                             (|htSayStandard| "\\tab{10}")
                             (|htSay| "}")
                             (|htSay| |kind|)
                             (|htSayStandard| "\\tab{19}")
                             (|bcCon| |nam|)))))
                     (SETQ |bfVar#91| (CDR |bfVar#91|))))
                  |conlist| NIL)
                 (|htShowPage|)))))))))))

; detailedSearch(filter) ==
;   page := htInitPage('"Detailed Search with Options",nil)
;   filter   := escapeSpecialChars PNAME filter
;   bcHt '"Select what you want to search for, then click on {\em Search} below"
;   bcHt '"\newline{\it Note:} Logical searches using {\em and}, {\em or}, and {\em not} are not permitted here."
;   htSayHrule()
;   htMakePage '(
;     (text . "\newline")
;     (bcRadioButtons which
;       (  "\tab{3}{\em Operations}"
;          ((text . "\newline\space{3}")
;           (text . "name")       (bcStrings (14 "*" opname EM))
;           (text . " \#args")    (bcStrings (1  "*" opnargs EM))
;           (text . " signature") (bcStrings (14 "*" opsig EM))
;           (text . "\vspace{1}\newline "))
;          ops)
;       (  "\tab{3}{\em Constructors}"
;          ((text . "\tab{17}")
;           (bcButtons (1 cats)) (text . " {\em categories} ")
;           (bcButtons (1 doms)) (text . " {\em domains} ")
;           (bcButtons (1 paks)) (text . " {\em packages} ")
;           (bcButtons (1 defs)) (text . " {\em defaults} ")
;           (text . "\newline\tab{3}")
;           (text . "name")   (bcStrings (14 "*" conname EM))
;           (text . " \#args") (bcStrings (1  "*" connargs EM))
;           (text . "signature") (bcStrings (14 "*" consig EM))
;           (text . "\vspace{1}\newline "))
;           cons)
; --      (   "\tab{3}{\em Documentation}"
; --          ((text . "\tab{26}key")
; --           (bcStrings (28 "*" docfilter EM)))
; --          doc)
;                 )
;     (text . "\vspace{1}\newline\center{ ")
;     (bcLinks ("\box{Search}" "" generalSearchDo NIL))
;     (text . "}"))
;   htShowPage()

(DEFUN |detailedSearch| (|filter|)
  (PROG (|page|)
    (RETURN
     (PROGN
      (SETQ |page| (|htInitPage| "Detailed Search with Options" NIL))
      (SETQ |filter| (|escapeSpecialChars| (PNAME |filter|)))
      (|bcHt|
       "Select what you want to search for, then click on {\\em Search} below")
      (|bcHt|
       "\\newline{\\it Note:} Logical searches using {\\em and}, {\\em or}, and {\\em not} are not permitted here.")
      (|htSayHrule|)
      (|htMakePage|
       '((|text| . "\\newline")
         (|bcRadioButtons| |which|
          ("\\tab{3}{\\em Operations}"
           ((|text| . "\\newline\\space{3}") (|text| . "name")
            (|bcStrings| (14 "*" |opname| EM)) (|text| . " \\#args")
            (|bcStrings| (1 "*" |opnargs| EM)) (|text| . " signature")
            (|bcStrings| (14 "*" |opsig| EM))
            (|text| . "\\vspace{1}\\newline "))
           |ops|)
          ("\\tab{3}{\\em Constructors}"
           ((|text| . "\\tab{17}") (|bcButtons| (1 |cats|))
            (|text| . " {\\em categories} ") (|bcButtons| (1 |doms|))
            (|text| . " {\\em domains} ") (|bcButtons| (1 |paks|))
            (|text| . " {\\em packages} ") (|bcButtons| (1 |defs|))
            (|text| . " {\\em defaults} ") (|text| . "\\newline\\tab{3}")
            (|text| . "name") (|bcStrings| (14 "*" |conname| EM))
            (|text| . " \\#args") (|bcStrings| (1 "*" |connargs| EM))
            (|text| . "signature") (|bcStrings| (14 "*" |consig| EM))
            (|text| . "\\vspace{1}\\newline "))
           |cons|))
         (|text| . "\\vspace{1}\\newline\\center{ ")
         (|bcLinks| ("\\box{Search}" "" |generalSearchDo| NIL))
         (|text| . "}")))
      (|htShowPage|)))))

; generalSearchDo(htPage,flag) ==
; --$exposedOnlyIfTrue := (flag => 'T; nil)
;   $htPage := htPage
;   alist := htpInputAreaAlist htPage
;   which := htpButtonValue(htPage,'which)
;   selectors :=
;     which = 'cons => '(conname connargs consig)
;     which = 'ops  => '(opname  opnargs  opsig)
;     BREAK()
;   name := generalSearchString(htPage,selectors.0)
;   nargs:= generalSearchString(htPage,selectors.1)
;   npat := standardizeSignature generalSearchString(htPage,selectors.2)
;   kindCode :=
;     which = 'ops => char 'o
;     which = 'attrs =>
;         BREAK()
;         char 'a
;     acc := '""
;     if htButtonOn?(htPage,'cats) then acc := STRCONC(char 'c,acc)
;     if htButtonOn?(htPage,'doms) then acc := STRCONC(char 'd,acc)
;     if htButtonOn?(htPage,'paks) then acc := STRCONC(char 'p,acc)
;     if htButtonOn?(htPage,'defs) then acc := STRCONC(char 'x,acc)
;     n := #acc
;     n = 0 or n = 4 => '"[cdpx]"
;     n = 1 => acc
;     STRCONC(char '_[,acc,char '_])
;   form := mkDetailedGrepPattern(kindCode,name,nargs,npat)
;   lines := applyGrep(form,'libdb)
;   if MEMQ(which,'(ops attrs)) then lines := dbScreenForDefaultFunctions lines
;   kind :=
;     which = 'cons =>
;       n = 1 =>
;         htButtonOn?(htPage,'cats) => '"category"
;         htButtonOn?(htPage,'doms) => '"domain"
;         htButtonOn?(htPage,'paks) => '"package"
;         '"default package"
;       '"constructor"
;     which = 'ops  => '"operation"
;     BREAK()
;   null lines => emptySearchPage(kind, nil, false)
;   dbSearch(lines,kind,'"filter")

(DEFUN |generalSearchDo| (|htPage| |flag|)
  (PROG (|alist| |which| |selectors| |name| |nargs| |npat| |acc| |n| |kindCode|
         |form| |lines| |kind|)
    (RETURN
     (PROGN
      (SETQ |$htPage| |htPage|)
      (SETQ |alist| (|htpInputAreaAlist| |htPage|))
      (SETQ |which| (|htpButtonValue| |htPage| '|which|))
      (SETQ |selectors|
              (COND ((EQ |which| '|cons|) '(|conname| |connargs| |consig|))
                    ((EQ |which| '|ops|) '(|opname| |opnargs| |opsig|))
                    (#1='T (BREAK))))
      (SETQ |name| (|generalSearchString| |htPage| (ELT |selectors| 0)))
      (SETQ |nargs| (|generalSearchString| |htPage| (ELT |selectors| 1)))
      (SETQ |npat|
              (|standardizeSignature|
               (|generalSearchString| |htPage| (ELT |selectors| 2))))
      (SETQ |kindCode|
              (COND ((EQ |which| '|ops|) (|char| '|o|))
                    ((EQ |which| '|attrs|) (PROGN (BREAK) (|char| '|a|)))
                    (#1#
                     (PROGN
                      (SETQ |acc| "")
                      (COND
                       ((|htButtonOn?| |htPage| '|cats|)
                        (SETQ |acc| (STRCONC (|char| '|c|) |acc|))))
                      (COND
                       ((|htButtonOn?| |htPage| '|doms|)
                        (SETQ |acc| (STRCONC (|char| '|d|) |acc|))))
                      (COND
                       ((|htButtonOn?| |htPage| '|paks|)
                        (SETQ |acc| (STRCONC (|char| '|p|) |acc|))))
                      (COND
                       ((|htButtonOn?| |htPage| '|defs|)
                        (SETQ |acc| (STRCONC (|char| '|x|) |acc|))))
                      (SETQ |n| (LENGTH |acc|))
                      (COND ((OR (EQL |n| 0) (EQL |n| 4)) "[cdpx]")
                            ((EQL |n| 1) |acc|)
                            (#1# (STRCONC (|char| '[) |acc| (|char| ']))))))))
      (SETQ |form| (|mkDetailedGrepPattern| |kindCode| |name| |nargs| |npat|))
      (SETQ |lines| (|applyGrep| |form| '|libdb|))
      (COND
       ((MEMQ |which| '(|ops| |attrs|))
        (SETQ |lines| (|dbScreenForDefaultFunctions| |lines|))))
      (SETQ |kind|
              (COND
               ((EQ |which| '|cons|)
                (COND
                 ((EQL |n| 1)
                  (COND ((|htButtonOn?| |htPage| '|cats|) "category")
                        ((|htButtonOn?| |htPage| '|doms|) "domain")
                        ((|htButtonOn?| |htPage| '|paks|) "package")
                        (#1# "default package")))
                 (#1# "constructor")))
               ((EQ |which| '|ops|) "operation") (#1# (BREAK))))
      (COND ((NULL |lines|) (|emptySearchPage| |kind| NIL NIL))
            (#1# (|dbSearch| |lines| |kind| "filter")))))))

; generalSearchString(htPage,sel) ==
;   string := htpLabelInputString(htPage,sel)
;   string = '"" => '"*"
;   string

(DEFUN |generalSearchString| (|htPage| |sel|)
  (PROG (|string|)
    (RETURN
     (PROGN
      (SETQ |string| (|htpLabelInputString| |htPage| |sel|))
      (COND ((EQUAL |string| "") "*") ('T |string|))))))

; htButtonOn?(htPage,key) ==
;   LASSOC(key,htpInputAreaAlist htPage) is [a,:.] and a = '" t"

(DEFUN |htButtonOn?| (|htPage| |key|)
  (PROG (|ISTMP#1| |a|)
    (RETURN
     (AND
      (PROGN
       (SETQ |ISTMP#1| (LASSOC |key| (|htpInputAreaAlist| |htPage|)))
       (AND (CONSP |ISTMP#1|) (PROGN (SETQ |a| (CAR |ISTMP#1|)) 'T)))
      (EQUAL |a| " t")))))

; mkDetailedGrepPattern(kind,name,nargs,argOrSig) == main where
;   main ==
;     nottick := '"[^`]"
;     name := replaceGrepStar name
;     firstPart := STRCONC(char '_^,kind,name)
;     nargsPart := replaceGrepStar nargs
;     exposedPart := char '_.   --always get exposed/unexposed
;     patPart := replaceGrepStar argOrSig
;     simp STRCONC(conc(firstPart,conc(nargsPart,conc(exposedPart, patPart))),$tick)
;   conc(a,b) ==
;     b = '"[^`]*" or b = char '_. => a
;     STRCONC(a,$tick,b)
;   simp a ==
;     m := MAXINDEX a
;     m > 6 and a.(m-5) = char '_[ and a.(m-4) = char '_^
;       and     a.(m-3) = $tick    and a.(m-2) = char '_]
;           and a.(m-1) = char '_* and a.m = $tick
;             => simp SUBSTRING(a,0,m-5)
;     a

(DEFUN |mkDetailedGrepPattern| (|kind| |name| |nargs| |argOrSig|)
  (PROG (|nottick| |firstPart| |nargsPart| |exposedPart| |patPart|)
    (RETURN
     (PROGN
      (SETQ |nottick| "[^`]")
      (SETQ |name| (|replaceGrepStar| |name|))
      (SETQ |firstPart| (STRCONC (|char| '^) |kind| |name|))
      (SETQ |nargsPart| (|replaceGrepStar| |nargs|))
      (SETQ |exposedPart| (|char| '|.|))
      (SETQ |patPart| (|replaceGrepStar| |argOrSig|))
      (|mkDetailedGrepPattern,simp|
       (STRCONC
        (|mkDetailedGrepPattern,conc| |firstPart|
         (|mkDetailedGrepPattern,conc| |nargsPart|
          (|mkDetailedGrepPattern,conc| |exposedPart| |patPart|)))
        |$tick|))))))
(DEFUN |mkDetailedGrepPattern,conc| (|a| |b|)
  (PROG ()
    (RETURN
     (COND ((OR (EQUAL |b| "[^`]*") (EQUAL |b| (|char| '|.|))) |a|)
           ('T (STRCONC |a| |$tick| |b|))))))
(DEFUN |mkDetailedGrepPattern,simp| (|a|)
  (PROG (|m|)
    (RETURN
     (PROGN
      (SETQ |m| (MAXINDEX |a|))
      (COND
       ((AND (< 6 |m|) (EQUAL (ELT |a| (- |m| 5)) (|char| '[))
             (EQUAL (ELT |a| (- |m| 4)) (|char| '^))
             (EQUAL (ELT |a| (- |m| 3)) |$tick|)
             (EQUAL (ELT |a| (- |m| 2)) (|char| ']))
             (EQUAL (ELT |a| (- |m| 1)) (|char| '*))
             (EQUAL (ELT |a| |m|) |$tick|))
        (|mkDetailedGrepPattern,simp| (SUBSTRING |a| 0 (- |m| 5))))
       ('T |a|))))))

; replaceGrepStar s ==
;   s = "" => s
;   final := MAXINDEX s
;   i := charPosition(char '_*,s,0)
;   i > final => s
;   STRCONC(SUBSTRING(s,0,i),'"[^`]*",replaceGrepStar SUBSTRING(s,i + 1,nil))

(DEFUN |replaceGrepStar| (|s|)
  (PROG (|final| |i|)
    (RETURN
     (COND ((EQ |s| '||) |s|)
           (#1='T
            (PROGN
             (SETQ |final| (MAXINDEX |s|))
             (SETQ |i| (|charPosition| (|char| '*) |s| 0))
             (COND ((< |final| |i|) |s|)
                   (#1#
                    (STRCONC (SUBSTRING |s| 0 |i|) "[^`]*"
                     (|replaceGrepStar| (SUBSTRING |s| (+ |i| 1) NIL)))))))))))

; standardizeSignature(s) == underscoreDollars
;   s.0 = char '_( => s
;   k := STRPOS('"->",s,0,nil) or return s --will fail except perhaps on constants
;   s.(k - 1) = char '_) => STRCONC(char '_(,s)
;   STRCONC(char '_(,SUBSTRING(s,0,k),char '_),SUBSTRING(s,k,nil))

(DEFUN |standardizeSignature| (|s|)
  (PROG (|k|)
    (RETURN
     (|underscoreDollars|
      (COND ((EQUAL (ELT |s| 0) (|char| '|(|)) |s|)
            (#1='T
             (PROGN
              (SETQ |k| (OR (STRPOS "->" |s| 0 NIL) (RETURN |s|)))
              (COND
               ((EQUAL (ELT |s| (- |k| 1)) (|char| '|)|))
                (STRCONC (|char| '|(|) |s|))
               (#1#
                (STRCONC (|char| '|(|) (SUBSTRING |s| 0 |k|) (|char| '|)|)
                 (SUBSTRING |s| |k| NIL)))))))))))

; underscoreDollars(s) == fn(s,0,MAXINDEX s) where
;   fn(s,i,n) ==
;     i > n => '""
;     (m := charPosition(char '_$,s,i)) > n => SUBSTRING(s,i,nil)
;     STRCONC(SUBSTRING(s,i,m - i),'"___$",fn(s,m + 1,n))

(DEFUN |underscoreDollars| (|s|)
  (PROG () (RETURN (|underscoreDollars,fn| |s| 0 (MAXINDEX |s|)))))
(DEFUN |underscoreDollars,fn| (|s| |i| |n|)
  (PROG (|m|)
    (RETURN
     (COND ((< |n| |i|) "")
           ((< |n| (SETQ |m| (|charPosition| (|char| '$) |s| |i|)))
            (SUBSTRING |s| |i| NIL))
           ('T
            (STRCONC (SUBSTRING |s| |i| (- |m| |i|)) "_$"
             (|underscoreDollars,fn| |s| (+ |m| 1) |n|)))))))

; getTempPath kind == mkGrepFile kind

(DEFUN |getTempPath| (|kind|) (PROG () (RETURN (|mkGrepFile| |kind|))))

; dbWriteLines(s, pathname) ==
;   $outStream : local := MAKE_OUTSTREAM(pathname)
;   for x in s repeat writedb x
;   SHUT $outStream
;   pathname

(DEFUN |dbWriteLines| (|s| |pathname|)
  (PROG (|$outStream|)
    (DECLARE (SPECIAL |$outStream|))
    (RETURN
     (PROGN
      (SETQ |$outStream| (MAKE_OUTSTREAM |pathname|))
      ((LAMBDA (|bfVar#93| |x|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#93|) (PROGN (SETQ |x| (CAR |bfVar#93|)) NIL))
            (RETURN NIL))
           ('T (|writedb| |x|)))
          (SETQ |bfVar#93| (CDR |bfVar#93|))))
       |s| NIL)
      (SHUT |$outStream|)
      |pathname|))))

; dbReadLines target == --AIX only--called by grepFile
;   instream := OPEN target
;   lines := [read_line instream while not EOFP instream]
;   CLOSE instream
;   lines

(DEFUN |dbReadLines| (|target|)
  (PROG (|instream| |lines|)
    (RETURN
     (PROGN
      (SETQ |instream| (OPEN |target|))
      (SETQ |lines|
              ((LAMBDA (|bfVar#94|)
                 (LOOP
                  (COND ((EOFP |instream|) (RETURN (NREVERSE |bfVar#94|)))
                        ('T
                         (SETQ |bfVar#94|
                                 (CONS (|read_line| |instream|)
                                       |bfVar#94|))))))
               NIL))
      (CLOSE |instream|)
      |lines|))))

; dbGetCommentOrigin line ==
; --Given a comment line in comdb, returns line in libdb pointing to it
; --Comment lines have format  [dcpxoa]xxxxxx`ccccc... where
; --x's give pointer into libdb, c's are comments
;   firstPart := dbPart(line,1,-1)
;   key := INTERN SUBSTRING(firstPart,0,1)    --extract this and throw away
;   address := SUBSTRING(firstPart, 1, nil)   --address in libdb
;   instream := OPEN grepSource key           --this always returns libdb now
;   FILE_-POSITION(instream,PARSE_-INTEGER address)
;   line := read_line instream
;   CLOSE instream
;   line

(DEFUN |dbGetCommentOrigin| (|line|)
  (PROG (|firstPart| |key| |address| |instream|)
    (RETURN
     (PROGN
      (SETQ |firstPart| (|dbPart| |line| 1 (- 1)))
      (SETQ |key| (INTERN (SUBSTRING |firstPart| 0 1)))
      (SETQ |address| (SUBSTRING |firstPart| 1 NIL))
      (SETQ |instream| (OPEN (|grepSource| |key|)))
      (FILE-POSITION |instream| (PARSE-INTEGER |address|))
      (SETQ |line| (|read_line| |instream|))
      (CLOSE |instream|)
      |line|))))

; grepSource key ==
;   key = 'libdb   => STRCONC($SPADROOT,'"/algebra/libdb.text")
;   key = 'gloss   => STRCONC($SPADROOT,'"/algebra/glosskey.text")
;   key = $localLibdb => $localLibdb
;   mkGrepTextfile
;     MEMQ(key, '(_. a c d k o p x)) => 'libdb
;     'comdb

(DEFUN |grepSource| (|key|)
  (PROG ()
    (RETURN
     (COND ((EQ |key| '|libdb|) (STRCONC $SPADROOT "/algebra/libdb.text"))
           ((EQ |key| '|gloss|) (STRCONC $SPADROOT "/algebra/glosskey.text"))
           ((EQUAL |key| |$localLibdb|) |$localLibdb|)
           (#1='T
            (|mkGrepTextfile|
             (COND ((MEMQ |key| '(|.| |a| |c| |d| |k| |o| |p| |x|)) '|libdb|)
                   (#1# '|comdb|))))))))

; mkGrepTextfile s == STRCONC($SPADROOT,"/algebra/", STRINGIMAGE s, '".text")

(DEFUN |mkGrepTextfile| (|s|)
  (PROG () (RETURN (STRCONC $SPADROOT '|/algebra/| (STRINGIMAGE |s|) ".text"))))

; mkGrepFile s ==  --called to generate a path name for a temporary grep file
;   prefix := '"/tmp/"
;   suffix := getEnv '"SPADNUM"
;   STRCONC(prefix, PNAME s,'".txt.", suffix)

(DEFUN |mkGrepFile| (|s|)
  (PROG (|prefix| |suffix|)
    (RETURN
     (PROGN
      (SETQ |prefix| "/tmp/")
      (SETQ |suffix| (|getEnv| "SPADNUM"))
      (STRCONC |prefix| (PNAME |s|) ".txt." |suffix|)))))

; grepFile(pattern, key, option) ==
;   options := [option]
;   source := grepSource key
;   lines :=
;       not PROBE_-FILE source => NIL
;       target := getTempPath 'target
;       casepart :=
;         MEMQ('iv,options)=> '"-vi"
;         '"-i"
;       command := STRCONC('"grep ", casepart, '" '", pattern, '"' ", source)
;       OBEY STRCONC(command, '" > ",target)
;       dbReadLines target
;       -- deleteFile target
;   dbUnpatchLines lines

(DEFUN |grepFile| (|pattern| |key| |option|)
  (PROG (|options| |source| |target| |casepart| |command| |lines|)
    (RETURN
     (PROGN
      (SETQ |options| (LIST |option|))
      (SETQ |source| (|grepSource| |key|))
      (SETQ |lines|
              (COND ((NULL (PROBE-FILE |source|)) NIL)
                    (#1='T
                     (PROGN
                      (SETQ |target| (|getTempPath| '|target|))
                      (SETQ |casepart|
                              (COND ((MEMQ '|iv| |options|) "-vi") (#1# "-i")))
                      (SETQ |command|
                              (STRCONC "grep " |casepart| " '" |pattern| "' "
                               |source|))
                      (OBEY (STRCONC |command| " > " |target|))
                      (|dbReadLines| |target|)))))
      (|dbUnpatchLines| |lines|)))))

; dbUnpatchLines lines ==  --concatenate long lines together, skip blank lines
;   dash := char '_-
;   acc := nil
;   while lines is [line, :lines] repeat
;     #line = 0 => 'skip     --skip blank lines
;     acc :=
;       line.0 = dash and line.1 = dash =>
;         [STRCONC(first acc,SUBSTRING(line,2,nil)),:rest acc]
;       [line,:acc]
;   -- following call to NREVERSE needed to keep lines properly sorted
;   NREVERSE acc  ------> added by BMT 12/95

(DEFUN |dbUnpatchLines| (|lines|)
  (PROG (|dash| |acc| |line|)
    (RETURN
     (PROGN
      (SETQ |dash| (|char| '-))
      (SETQ |acc| NIL)
      ((LAMBDA ()
         (LOOP
          (COND
           ((NOT
             (AND (CONSP |lines|)
                  (PROGN
                   (SETQ |line| (CAR |lines|))
                   (SETQ |lines| (CDR |lines|))
                   #1='T)))
            (RETURN NIL))
           (#1#
            (COND ((EQL (LENGTH |line|) 0) '|skip|)
                  (#1#
                   (SETQ |acc|
                           (COND
                            ((AND (EQUAL (ELT |line| 0) |dash|)
                                  (EQUAL (ELT |line| 1) |dash|))
                             (CONS
                              (STRCONC (CAR |acc|) (SUBSTRING |line| 2 NIL))
                              (CDR |acc|)))
                            (#1# (CONS |line| |acc|)))))))))))
      (NREVERSE |acc|)))))
