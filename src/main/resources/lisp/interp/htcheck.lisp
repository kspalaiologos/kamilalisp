
; )package "BOOT"

(IN-PACKAGE "BOOT")

; $primitiveHtCommands := '(
;   ("\ContinueButton"     . 1)
;   ("\andexample"         . 1)
;   ("\autobutt" .    0)
;   ("\autobuttons".  0)
;   ("\begin"  .      1)
;   ("\beginscroll".  0)
;   ("\bound"  .      1)
;   ("\fbox"    .      1)
;   ("\centerline" .      1)
;   ("\downlink" .    2)
;   ("\em"     .      0)
;   ("\end"    .      1)
;   ("\endscroll"  .  0)
;   ("\example"            . 1)
;   ("\free"   .      1)
;   ("\graphpaste" .  1)
;   ("\helppage" .    1)
;   ("\htbmdir"            . 0)
;   ("\htbmfile"   .  1)
;   ("\indent" .      1)
;   ("\inputbitmap"        . 1)
;   ("\inputstring" . 3)
;   ("\item"   .      0)
;   ("\keyword"            . 1)
;   ("\link"               . 2)
;   ("\lispdownlink"       . 2)
;   ("\lispmemolink"       . 2)
;   ("\lispwindowlink"     . 2)
;   ("\menudownlink"       . 2)
;   ("\menuitemstyle"      . 1)
;   ("\menulink"           . 2)
;   ("\menulispdownlink"   . 2)
;   ("\menulispmemolink"   . 2)
;   ("\menulispwindowlink" . 2)
;   ("\menumemolink"       . 2)
;   ("\menuwindowlink"     . 2)
;   ("\newline" .     0)
;   ("\radioboxes" .  3)
;   ("\space"  .      1)
;   ("\spadcommand" . 1)
;   ("\stringvalue" . 1)
;   ("\tab"    .      1)
;   ("\table"              . 1)
;   ("\vspace" .      1)
;   ("\windowlink"         . 2))

(EVAL-WHEN (EVAL LOAD)
  (SETQ |$primitiveHtCommands|
          '(("\\ContinueButton" . 1) ("\\andexample" . 1) ("\\autobutt" . 0)
            ("\\autobuttons" . 0) ("\\begin" . 1) ("\\beginscroll" . 0)
            ("\\bound" . 1) ("\\fbox" . 1) ("\\centerline" . 1)
            ("\\downlink" . 2) ("\\em" . 0) ("\\end" . 1) ("\\endscroll" . 0)
            ("\\example" . 1) ("\\free" . 1) ("\\graphpaste" . 1)
            ("\\helppage" . 1) ("\\htbmdir" . 0) ("\\htbmfile" . 1)
            ("\\indent" . 1) ("\\inputbitmap" . 1) ("\\inputstring" . 3)
            ("\\item" . 0) ("\\keyword" . 1) ("\\link" . 2)
            ("\\lispdownlink" . 2) ("\\lispmemolink" . 2)
            ("\\lispwindowlink" . 2) ("\\menudownlink" . 2)
            ("\\menuitemstyle" . 1) ("\\menulink" . 2)
            ("\\menulispdownlink" . 2) ("\\menulispmemolink" . 2)
            ("\\menulispwindowlink" . 2) ("\\menumemolink" . 2)
            ("\\menuwindowlink" . 2) ("\\newline" . 0) ("\\radioboxes" . 3)
            ("\\space" . 1) ("\\spadcommand" . 1) ("\\stringvalue" . 1)
            ("\\tab" . 1) ("\\table" . 1) ("\\vspace" . 1)
            ("\\windowlink" . 2))))

; buildHtMacroTable() ==
;   $htMacroTable := MAKE_HASHTABLE('UEQUAL)
;   fn := CONCAT(getEnv '"FRICAS", '"/share/hypertex/pages/util.ht")
;   if PROBE_-FILE(fn) then
;     instream := MAKE_INSTREAM(fn)
;     while not EOFP instream repeat
;       line := read_line instream
;       getHtMacroItem line is [string,:numOfArgs] =>
;         HPUT($htMacroTable,string,numOfArgs)
;     for [s,:n] in $primitiveHtCommands repeat HPUT($htMacroTable,s,n)
;     SHUT instream
;   else
;     sayBrightly '"Warning: HyperTeX macro table not found"
;   $htMacroTable

(DEFUN |buildHtMacroTable| ()
  (PROG (|n| |s| |numOfArgs| |string| |ISTMP#1| |line| |instream| |fn|)
    (RETURN
     (PROGN
      (SETQ |$htMacroTable| (MAKE_HASHTABLE 'UEQUAL))
      (SETQ |fn| (CONCAT (|getEnv| "FRICAS") "/share/hypertex/pages/util.ht"))
      (COND
       ((PROBE-FILE |fn|) (SETQ |instream| (MAKE_INSTREAM |fn|))
        ((LAMBDA ()
           (LOOP
            (COND ((EOFP |instream|) (RETURN NIL))
                  (#1='T
                   (PROGN
                    (SETQ |line| (|read_line| |instream|))
                    (COND
                     ((PROGN
                       (SETQ |ISTMP#1| (|getHtMacroItem| |line|))
                       (AND (CONSP |ISTMP#1|)
                            (PROGN
                             (SETQ |string| (CAR |ISTMP#1|))
                             (SETQ |numOfArgs| (CDR |ISTMP#1|))
                             #1#)))
                      (HPUT |$htMacroTable| |string| |numOfArgs|)))))))))
        ((LAMBDA (|bfVar#2| |bfVar#1|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#2|)
                  (PROGN (SETQ |bfVar#1| (CAR |bfVar#2|)) NIL))
              (RETURN NIL))
             (#1#
              (AND (CONSP |bfVar#1|)
                   (PROGN
                    (SETQ |s| (CAR |bfVar#1|))
                    (SETQ |n| (CDR |bfVar#1|))
                    #1#)
                   (HPUT |$htMacroTable| |s| |n|))))
            (SETQ |bfVar#2| (CDR |bfVar#2|))))
         |$primitiveHtCommands| NIL)
        (SHUT |instream|))
       (#1# (|sayBrightly| "Warning: HyperTeX macro table not found")))
      |$htMacroTable|))))

; getHtMacroItem line ==
;   null stringPrefix?('"\newcommand{",line) => nil
;   k := charPosition(char '_},line,11)
;   command := SUBSTRING(line,12,k - 12)
;   numOfArgs :=
;     m := #line
;     i := charPosition(char '_[,line,k)
;     i = m => 0
;     j := charPosition(char '_],line,i + 1)
;     digitString := SUBSTRING(line,i + 1,j - i - 1)
;     and/[DIGITP digitString.i for i in 0..MAXINDEX digitString]
;       => PARSE_-INTEGER digitString
;     return nil
;   [command,:numOfArgs]

(DEFUN |getHtMacroItem| (|line|)
  (PROG (|k| |command| |m| |i| |j| |digitString| |numOfArgs|)
    (RETURN
     (COND ((NULL (|stringPrefix?| "\\newcommand{" |line|)) NIL)
           (#1='T
            (PROGN
             (SETQ |k| (|charPosition| (|char| '}) |line| 11))
             (SETQ |command| (SUBSTRING |line| 12 (- |k| 12)))
             (SETQ |numOfArgs|
                     (PROGN
                      (SETQ |m| (LENGTH |line|))
                      (SETQ |i| (|charPosition| (|char| '[) |line| |k|))
                      (COND ((EQUAL |i| |m|) 0)
                            (#1#
                             (PROGN
                              (SETQ |j|
                                      (|charPosition| (|char| ']) |line|
                                       (+ |i| 1)))
                              (SETQ |digitString|
                                      (SUBSTRING |line| (+ |i| 1)
                                                 (- (- |j| |i|) 1)))
                              (COND
                               (((LAMBDA (|bfVar#4| |bfVar#3| |i|)
                                   (LOOP
                                    (COND
                                     ((> |i| |bfVar#3|) (RETURN |bfVar#4|))
                                     (#1#
                                      (PROGN
                                       (SETQ |bfVar#4|
                                               (DIGITP
                                                (ELT |digitString| |i|)))
                                       (COND ((NOT |bfVar#4|) (RETURN NIL))))))
                                    (SETQ |i| (+ |i| 1))))
                                 T (MAXINDEX |digitString|) 0)
                                (PARSE-INTEGER |digitString|))
                               (#1# (RETURN NIL))))))))
             (CONS |command| |numOfArgs|)))))))

; spadSysChoose(tree,form) ==     --tree is ((word . tree) ..)
;   null form => true
;   null tree => false
;   lookupOn :=
;     form is [key,arg] => key
;     form
;   newTree := LASSOC(lookupOn,tree) => spadSysBranch(newTree,IFCAR IFCDR form)
;   false

(DEFUN |spadSysChoose| (|tree| |form|)
  (PROG (|key| |ISTMP#1| |arg| |lookupOn| |newTree|)
    (RETURN
     (COND ((NULL |form|) T) ((NULL |tree|) NIL)
           (#1='T
            (PROGN
             (SETQ |lookupOn|
                     (COND
                      ((AND (CONSP |form|)
                            (PROGN
                             (SETQ |key| (CAR |form|))
                             (SETQ |ISTMP#1| (CDR |form|))
                             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                                  (PROGN (SETQ |arg| (CAR |ISTMP#1|)) #1#))))
                       |key|)
                      (#1# |form|)))
             (COND
              ((SETQ |newTree| (LASSOC |lookupOn| |tree|))
               (|spadSysBranch| |newTree| (IFCAR (IFCDR |form|))))
              (#1# NIL))))))))

; spadSysBranch(tree,arg) ==  --tree is (msg kind TREEorSomethingElse ...)
;   null arg => true
;   kind := tree.2
;   kind = 'TREE => spadSysChoose(tree.4,arg)
;   kind = 'LITERALS => member(arg,tree.4)
;   kind = 'INTEGER  => INTEGERP arg
;   kind = 'FUNCTION => atom arg
;   systemError '"unknown tree branch"

(DEFUN |spadSysBranch| (|tree| |arg|)
  (PROG (|kind|)
    (RETURN
     (COND ((NULL |arg|) T)
           (#1='T
            (PROGN
             (SETQ |kind| (ELT |tree| 2))
             (COND ((EQ |kind| 'TREE) (|spadSysChoose| (ELT |tree| 4) |arg|))
                   ((EQ |kind| 'LITERALS) (|member| |arg| (ELT |tree| 4)))
                   ((EQ |kind| 'INTEGER) (INTEGERP |arg|))
                   ((EQ |kind| 'FUNCTION) (ATOM |arg|))
                   (#1# (|systemError| "unknown tree branch")))))))))

; buildHtMacroTable()

(EVAL-WHEN (EVAL LOAD) (PROG () (RETURN (|buildHtMacroTable|))))
