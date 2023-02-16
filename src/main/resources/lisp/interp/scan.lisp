
; )package "BOOT"

(IN-PACKAGE "BOOT")

; SPACE_CHAR       := STR_ELT('"    ", 0)

(EVAL-WHEN (EVAL LOAD) (SETQ SPACE_CHAR (STR_ELT "    " 0)))

; PAGE_CTL    := 12

(EVAL-WHEN (EVAL LOAD) (SETQ PAGE_CTL 12))

; ESCAPE      := STR_ELT('"__  ", 0)

(EVAL-WHEN (EVAL LOAD) (SETQ ESCAPE (STR_ELT "_  " 0)))

; STRING_CHAR := STR_ELT('"_"  ", 0)

(EVAL-WHEN (EVAL LOAD) (SETQ STRING_CHAR (STR_ELT "\"  " 0)))

; PLUSCOMMENT := STR_ELT('"+   ", 0)

(EVAL-WHEN (EVAL LOAD) (SETQ PLUSCOMMENT (STR_ELT "+   " 0)))

; MINUSCOMMENT:= STR_ELT('"-   ", 0)

(EVAL-WHEN (EVAL LOAD) (SETQ MINUSCOMMENT (STR_ELT "-   " 0)))

; RADIX_CHAR  := STR_ELT('"r   ", 0)

(EVAL-WHEN (EVAL LOAD) (SETQ RADIX_CHAR (STR_ELT "r   " 0)))

; DOT         := STR_ELT('".   ", 0)

(EVAL-WHEN (EVAL LOAD) (SETQ DOT (STR_ELT ".   " 0)))

; EXPONENT1   := STR_ELT('"E   ", 0)

(EVAL-WHEN (EVAL LOAD) (SETQ EXPONENT1 (STR_ELT "E   " 0)))

; EXPONENT2   := STR_ELT('"e   ", 0)

(EVAL-WHEN (EVAL LOAD) (SETQ EXPONENT2 (STR_ELT "e   " 0)))

; CLOSEPAREN  := STR_ELT('")   ", 0)

(EVAL-WHEN (EVAL LOAD) (SETQ CLOSEPAREN (STR_ELT ")   " 0)))

; CLOSEANGLE  := STR_ELT('">   ", 0)

(EVAL-WHEN (EVAL LOAD) (SETQ CLOSEANGLE (STR_ELT ">   " 0)))

; QUESTION    := STR_ELT('"?   ", 0)

(EVAL-WHEN (EVAL LOAD) (SETQ QUESTION (STR_ELT "?   " 0)))

; scanKeyWords := [ _
;            ['"add",      "add"], _
;            ['"and",      "and"], _
;            ['"break",   "break"], _
;            ['"by",        "by"], _
;            ['"case",     "case"], _
;            ['"catch",  "catch"], _
;            ['"default",  "DEFAULT" ],_
;            ['"define",  "DEFN" ],_
;            ['"do",        "DO"],_
;            ['"else",    "else"], _
;            ['"exquo",   "exquo"], _
;            ['"export","EXPORT" ],_
;            ['"finally", "finally"], _
;            ['"for",      "for"], _
;            ['"free",    "FREE" ],_
;            ['"from",    "from"], _
;            ['"generate", "generate"], _
;            ['"goto",    "goto"], _
;            ['"has",      "has"], _
;            ['"if",       "if"], _
;            ['"import", "import"], _
;            ['"in", "in"], _
;            ['"inline", "INLINE" ],_
;            ['"is", "is"], _
;            ['"isnt", "isnt"], _
;            ['"iterate", "ITERATE"],_
;            ['"local", "local"], _
;            ['"macro", "MACRO" ],_
;            ['"mod", "mod"], _
;            ['"not", "not"], _
;            ['"or", "or"], _
;            ['"pretend", "pretend"], _
;            ['"quo", "quo"], _
;            ['"rem", "rem"], _
;            ['"repeat", "repeat"],_
;            ['"return", "return"],_
;            ['"rule","RULE" ],_
;            ['"then", "then"],_
;            ['"try", "try"], _
;            ['"until", "until"], _
;            ['"where", "where"], _
;            ['"while", "while"],_
;            ['"with", "with"], _
;            ['"yield", "yield"], _
;            ['"|",  "|"], _
;            ['".",  "."], _
;            ['"::", "::"], _
;            ['":",  ":"], _
;            ['":-","COLONDASH" ],_
;            ['"@",  "@"], _
;            ['"@@","ATAT" ],_
;            ['",", ","],_
;            ['";",  ";"],_
;            ['"**", "**"], _
;            ['"*",  "*"],_
;            ['"+",  "+"], _
;            ['"-",  "-"], _
;            ['"<",  "<"], _
;            ['">",  ">"], _
;            ['"<=", "<="], _
;            ['">=", ">="], _
;            ['"=",  "="], _
;            ['"~=", "~="], _
;            ['"~", "~"], _
;            ['"^",  "^" ], _
;            ['"..","SEG" ],_
;            ['"#","#" ],_
;            ['"#1", "#1" ],_
;            ['"&","AMPERSAND" ],_
;            ['"$","$" ],_
;            ['"/",  "/"], _
;            ['"\",  "\"], _
;            ['"//","SLASHSLASH" ],_
;            ['"\\","BACKSLASHBACKSLASH" ],_
;            ['"/\", "/\"], _
;            ['"\/", "\/"], _
;            ['"=>", "=>"], _
;            ['":=", ":="], _
;            ['"==", "=="], _
;            ['"==>", "==>"],_
;            ['"->","ARROW" ],_
;            ['"<-","LARROW" ],_
;            ['"+->", "+->"], _
;            ['"(","(" ],_
;            ['")",")" ],_
;            ['"(|","(|" ],_
;            ['"|)","|)" ],_
;            ['"[","[" ],_
;            ['"]","]" ],_
;            ['"[__]","[]" ],_
;            ['"{","{" ],_
;            ['"}","}" ],_
;            ['"{__}","{}" ],_
;            ['"[|","[|" ],_
;            ['"|]","|]" ],_
;            ['"[|__|]","[||]" ],_
;            ['"{|","{|" ],_
;            ['"|}","|}" ],_
;            ['"{|__|}","{||}" ],_
;            ['"<<", "<<"], _
;            ['">>", ">>"], _
;            ['"'", "'" ],_
;            ['"`", "BACKQUOTE" ]_
;                           ]

(EVAL-WHEN (EVAL LOAD)
  (SETQ |scanKeyWords|
          (LIST (LIST "add" '|add|) (LIST "and" '|and|) (LIST "break" '|break|)
                (LIST "by" '|by|) (LIST "case" '|case|) (LIST "catch" '|catch|)
                (LIST "default" 'DEFAULT) (LIST "define" 'DEFN) (LIST "do" 'DO)
                (LIST "else" '|else|) (LIST "exquo" '|exquo|)
                (LIST "export" 'EXPORT) (LIST "finally" '|finally|)
                (LIST "for" '|for|) (LIST "free" 'FREE) (LIST "from" '|from|)
                (LIST "generate" '|generate|) (LIST "goto" '|goto|)
                (LIST "has" '|has|) (LIST "if" '|if|) (LIST "import" '|import|)
                (LIST "in" '|in|) (LIST "inline" 'INLINE) (LIST "is" '|is|)
                (LIST "isnt" '|isnt|) (LIST "iterate" 'ITERATE)
                (LIST "local" '|local|) (LIST "macro" 'MACRO)
                (LIST "mod" '|mod|) (LIST "not" '|not|) (LIST "or" '|or|)
                (LIST "pretend" '|pretend|) (LIST "quo" '|quo|)
                (LIST "rem" '|rem|) (LIST "repeat" '|repeat|)
                (LIST "return" '|return|) (LIST "rule" 'RULE)
                (LIST "then" '|then|) (LIST "try" '|try|)
                (LIST "until" '|until|) (LIST "where" '|where|)
                (LIST "while" '|while|) (LIST "with" '|with|)
                (LIST "yield" '|yield|) (LIST "|" '|\||) (LIST "." '|.|)
                (LIST "::" '|::|) (LIST ":" '|:|) (LIST ":-" 'COLONDASH)
                (LIST "@" '@) (LIST "@@" 'ATAT) (LIST "," '|,|) (LIST ";" '|;|)
                (LIST "**" '**) (LIST "*" '*) (LIST "+" '+) (LIST "-" '-)
                (LIST "<" '<) (LIST ">" '>) (LIST "<=" '<=) (LIST ">=" '>=)
                (LIST "=" '=) (LIST "~=" '~=) (LIST "~" '~) (LIST "^" '^)
                (LIST ".." 'SEG) (LIST "#" '|#|) (LIST "#1" '|#1|)
                (LIST "&" 'AMPERSAND) (LIST "$" '$) (LIST "/" '/)
                (LIST "\\" '|\\|) (LIST "//" 'SLASHSLASH)
                (LIST "\\\\" 'BACKSLASHBACKSLASH) (LIST "/\\" '|/\\|)
                (LIST "\\/" '|\\/|) (LIST "=>" '=>) (LIST ":=" '|:=|)
                (LIST "==" '==) (LIST "==>" '==>) (LIST "->" 'ARROW)
                (LIST "<-" 'LARROW) (LIST "+->" '+->) (LIST "(" '|(|)
                (LIST ")" '|)|) (LIST "(|" '|(\||) (LIST "|)" '|\|)|)
                (LIST "[" '[) (LIST "]" ']) (LIST "[_]" '[]) (LIST "{" '{)
                (LIST "}" '}) (LIST "{_}" '{}) (LIST "[|" '|[\||)
                (LIST "|]" '|\|]|) (LIST "[|_|]" '|[\|\|]|) (LIST "{|" '|{\||)
                (LIST "|}" '|\|}|) (LIST "{|_|}" '|{\|\|}|) (LIST "<<" '<<)
                (LIST ">>" '>>) (LIST "'" '|'|) (LIST "`" 'BACKQUOTE))))

; scanKeyTableCons()==
;    KeyTable := MAKE_HASHTABLE("EQUAL")
;    for st in scanKeyWords repeat
;       HPUT(KeyTable, first st, CADR st)
;    KeyTable

(DEFUN |scanKeyTableCons| ()
  (PROG (|KeyTable|)
    (RETURN
     (PROGN
      (SETQ |KeyTable| (MAKE_HASHTABLE 'EQUAL))
      ((LAMBDA (|bfVar#1| |st|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#1|) (PROGN (SETQ |st| (CAR |bfVar#1|)) NIL))
            (RETURN NIL))
           ('T (HPUT |KeyTable| (CAR |st|) (CADR |st|))))
          (SETQ |bfVar#1| (CDR |bfVar#1|))))
       |scanKeyWords| NIL)
      |KeyTable|))))

; scanInsert(s,d) ==
;       l := #s
;       h := STR_ELT(s, 0)
;       u := ELT(d,h)
;       n := #u
;       k:=0
;       while l <= #(ELT(u,k)) repeat
;           k:=k+1
;       v := MAKE_VEC(n + 1)
;       for i in 0..k-1 repeat QSETVELT(v, i, ELT(u, i))
;       QSETVELT(v, k, s)
;       for i in k..n-1 repeat QSETVELT(v, i + 1, ELT(u, i))
;       QSETVELT(d, h, v)
;       s

(DEFUN |scanInsert| (|s| |d|)
  (PROG (|l| |h| |u| |n| |k| |v|)
    (RETURN
     (PROGN
      (SETQ |l| (LENGTH |s|))
      (SETQ |h| (STR_ELT |s| 0))
      (SETQ |u| (ELT |d| |h|))
      (SETQ |n| (LENGTH |u|))
      (SETQ |k| 0)
      ((LAMBDA ()
         (LOOP
          (COND ((< (LENGTH (ELT |u| |k|)) |l|) (RETURN NIL))
                (#1='T (SETQ |k| (+ |k| 1)))))))
      (SETQ |v| (MAKE_VEC (+ |n| 1)))
      ((LAMBDA (|bfVar#2| |i|)
         (LOOP
          (COND ((> |i| |bfVar#2|) (RETURN NIL))
                (#1# (QSETVELT |v| |i| (ELT |u| |i|))))
          (SETQ |i| (+ |i| 1))))
       (- |k| 1) 0)
      (QSETVELT |v| |k| |s|)
      ((LAMBDA (|bfVar#3| |i|)
         (LOOP
          (COND ((> |i| |bfVar#3|) (RETURN NIL))
                (#1# (QSETVELT |v| (+ |i| 1) (ELT |u| |i|))))
          (SETQ |i| (+ |i| 1))))
       (- |n| 1) |k|)
      (QSETVELT |d| |h| |v|)
      |s|))))

; scanDictCons()==
;       l:= HKEYS scanKeyTable
;       d :=
;           a := MAKE_VEC(256)
;           b := MAKE_VEC(1)
;           QSETVELT(b, 0, make_full_CVEC(0))
;           for i in 0..255 repeat QSETVELT(a, i, b)
;           a
;       for s in l repeat scanInsert(s,d)
;       d

(DEFUN |scanDictCons| ()
  (PROG (|d| |b| |a| |l|)
    (RETURN
     (PROGN
      (SETQ |l| (HKEYS |scanKeyTable|))
      (SETQ |d|
              (PROGN
               (SETQ |a| (MAKE_VEC 256))
               (SETQ |b| (MAKE_VEC 1))
               (QSETVELT |b| 0 (|make_full_CVEC| 0))
               ((LAMBDA (|i|)
                  (LOOP
                   (COND ((> |i| 255) (RETURN NIL))
                         (#1='T (QSETVELT |a| |i| |b|)))
                   (SETQ |i| (+ |i| 1))))
                0)
               |a|))
      ((LAMBDA (|bfVar#4| |s|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#4|) (PROGN (SETQ |s| (CAR |bfVar#4|)) NIL))
            (RETURN NIL))
           (#1# (|scanInsert| |s| |d|)))
          (SETQ |bfVar#4| (CDR |bfVar#4|))))
       |l| NIL)
      |d|))))

; scanPunCons()==
;     listing := HKEYS scanKeyTable
;     a := make_BVEC(256, 0)
;     for i in 0..255 repeat SETELT_BVEC(a, i, 0)
;     for k in listing repeat
;        if not startsId? k.0 then
;            SETELT_BVEC(a, STR_ELT(k, 0), 1)
;     a

(DEFUN |scanPunCons| ()
  (PROG (|a| |listing|)
    (RETURN
     (PROGN
      (SETQ |listing| (HKEYS |scanKeyTable|))
      (SETQ |a| (|make_BVEC| 256 0))
      ((LAMBDA (|i|)
         (LOOP
          (COND ((> |i| 255) (RETURN NIL)) (#1='T (SETELT_BVEC |a| |i| 0)))
          (SETQ |i| (+ |i| 1))))
       0)
      ((LAMBDA (|bfVar#5| |k|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#5|) (PROGN (SETQ |k| (CAR |bfVar#5|)) NIL))
            (RETURN NIL))
           (#1#
            (COND
             ((NULL (|startsId?| (ELT |k| 0)))
              (SETELT_BVEC |a| (STR_ELT |k| 0) 1)))))
          (SETQ |bfVar#5| (CDR |bfVar#5|))))
       |listing| NIL)
      |a|))))

; scanKeyTable:=scanKeyTableCons()

(EVAL-WHEN (EVAL LOAD) (SETQ |scanKeyTable| (|scanKeyTableCons|)))

; scanDict:=scanDictCons()

(EVAL-WHEN (EVAL LOAD) (SETQ |scanDict| (|scanDictCons|)))

; scanPun:=scanPunCons()

(EVAL-WHEN (EVAL LOAD) (SETQ |scanPun| (|scanPunCons|)))

; for i in   [ _
;    ["=",   "="], _
;    ["*",   "*"], _
;    ["has",      "has"], _
;    ["case",     "case"], _
;    ["exquo",    "exquo"], _
;    ["rem",      "rem"], _
;    ["mod", "mod"], _
;    ["quo",      "quo"], _
;    ["/",   "/"], _
;    ["\",   "\"], _
;    ["SLASHSLASH"    ,"//"], _
;    ["BACKSLASHBACKSLASH","\\"], _
;    ["/\",  "/\"], _
;    ["\/",  "\/"], _
;    ["**",  "**"], _
;    ["^",   "^"], _
;    ["+",   "+"], _
;    ["-",   "-"], _
;    ["<",   "<"], _
;    [">",   ">"], _
;    ["<<",  "<<"], _
;    [">>",  ">>"], _
;    ["<=",  "<="], _
;    [">=",  ">="], _
;    ["~=",  "~="], _
;    ["by",       "by"], _
;    ["ARROW"       ,"->"], _
;    ["LARROW"       ,"<-"], _
;    ["|",   "|"], _
;    ["SEG"       ,".."] _
;     ] repeat MAKEPROP(first i, 'INFGENERIC, CADR i)

(EVAL-WHEN (EVAL LOAD)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#6| |i|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#6|) (PROGN (SETQ |i| (CAR |bfVar#6|)) NIL))
           (RETURN NIL))
          ('T (MAKEPROP (CAR |i|) 'INFGENERIC (CADR |i|))))
         (SETQ |bfVar#6| (CDR |bfVar#6|))))
      (LIST (LIST '= '=) (LIST '* '*) (LIST '|has| '|has|)
            (LIST '|case| '|case|) (LIST '|exquo| '|exquo|)
            (LIST '|rem| '|rem|) (LIST '|mod| '|mod|) (LIST '|quo| '|quo|)
            (LIST '/ '/) (LIST '|\\| '|\\|) (LIST 'SLASHSLASH '//)
            (LIST 'BACKSLASHBACKSLASH '|\\\\|) (LIST '|/\\| '|/\\|)
            (LIST '|\\/| '|\\/|) (LIST '** '**) (LIST '^ '^) (LIST '+ '+)
            (LIST '- '-) (LIST '< '<) (LIST '> '>) (LIST '<< '<<)
            (LIST '>> '>>) (LIST '<= '<=) (LIST '>= '>=) (LIST '~= '~=)
            (LIST '|by| '|by|) (LIST 'ARROW '->) (LIST 'LARROW '<-)
            (LIST '|\|| '|\||) (LIST 'SEG '|..|))
      NIL))))

; is_white?(c) == c = SPACE_CHAR or c = PAGE_CTL

(DEFUN |is_white?| (|c|)
  (PROG () (RETURN (OR (EQUAL |c| SPACE_CHAR) (EQUAL |c| PAGE_CTL)))))

; skip_whitespace(ln, n) ==
;     l := #ln
;     while n < l and is_white?(STR_ELT(ln, n)) repeat
;         n := n + 1
;     n

(DEFUN |skip_whitespace| (|ln| |n|)
  (PROG (|l|)
    (RETURN
     (PROGN
      (SETQ |l| (LENGTH |ln|))
      ((LAMBDA ()
         (LOOP
          (COND
           ((NOT (AND (< |n| |l|) (|is_white?| (STR_ELT |ln| |n|))))
            (RETURN NIL))
           ('T (SETQ |n| (+ |n| 1)))))))
      |n|))))

; DEFVAR($f)

(DEFVAR |$f|)

; DEFVAR($floatok)

(DEFVAR |$floatok|)

; DEFVAR($linepos)

(DEFVAR |$linepos|)

; DEFVAR($ln)

(DEFVAR |$ln|)

; DEFVAR($n)

(DEFVAR |$n|)

; DEFVAR($r)

(DEFVAR |$r|)

; DEFVAR($sz)

(DEFVAR |$sz|)

; DEFPARAMETER($was_nonblank, false)

(DEFPARAMETER |$was_nonblank| NIL)

; DEFVAR($comment_indent, 0)

(DEFVAR |$comment_indent| 0)

; DEFVAR($current_comment_block, nil)

(DEFVAR |$current_comment_block| NIL)

; DEFVAR($comment_line)

(DEFVAR |$comment_line|)

; DEFVAR($last_nonempty_linepos, nil)

(DEFVAR |$last_nonempty_linepos| NIL)

; DEFVAR($spad_scanner, false)

(DEFVAR |$spad_scanner| NIL)

; finish_comment() ==
;     NULL($current_comment_block) => nil
;     pos :=
;         $comment_indent = 0 => $comment_line
;         first(rest(rest($last_nonempty_linepos)))
;     PUSH([pos, :NREVERSE($current_comment_block)], $COMBLOCKLIST)
;     $current_comment_block := nil

(DEFUN |finish_comment| ()
  (PROG (|pos|)
    (RETURN
     (COND ((NULL |$current_comment_block|) NIL)
           (#1='T
            (PROGN
             (SETQ |pos|
                     (COND ((EQL |$comment_indent| 0) |$comment_line|)
                           (#1# (CAR (CDR (CDR |$last_nonempty_linepos|))))))
             (PUSH (CONS |pos| (NREVERSE |$current_comment_block|))
                   $COMBLOCKLIST)
             (SETQ |$current_comment_block| NIL)))))))

; scanIgnoreLine(ln,n)==
;     if n = $sz then
;         false
;     else
;        fst := STR_ELT(ln, 0)
;        if EQ(fst, CLOSEPAREN) and ($sz > 1) and
;            not(is_white?(STR_ELT(ln, 1)))
;        then if incPrefix?('"command",1,ln)
;             then true
;             else nil
;        else n

(DEFUN |scanIgnoreLine| (|ln| |n|)
  (PROG (|fst|)
    (RETURN
     (COND ((EQUAL |n| |$sz|) NIL)
           (#1='T (SETQ |fst| (STR_ELT |ln| 0))
            (COND
             ((AND (EQ |fst| CLOSEPAREN) (< 1 |$sz|)
                   (NULL (|is_white?| (STR_ELT |ln| 1))))
              (COND ((|incPrefix?| "command" 1 |ln|) T) (#1# NIL)))
             (#1# |n|)))))))

; nextline(s)==
;      if npNull s
;      then false
;      else
;        $f:= first s
;        $r:= rest s
;        $ln := rest $f
;        $linepos:=CAAR $f
;        $n := skip_whitespace($ln, 0) -- spaces at beginning
;        $sz :=# $ln
;        true

(DEFUN |nextline| (|s|)
  (PROG ()
    (RETURN
     (COND ((|npNull| |s|) NIL)
           ('T (SETQ |$f| (CAR |s|)) (SETQ |$r| (CDR |s|))
            (SETQ |$ln| (CDR |$f|)) (SETQ |$linepos| (CAAR |$f|))
            (SETQ |$n| (|skip_whitespace| |$ln| 0)) (SETQ |$sz| (LENGTH |$ln|))
            T)))))

; lineoftoks(s)==
;    $f: local:=nil
;    $r:local :=nil
;    $ln:local :=nil
;    $linepos:local:=nil
;    $n:local:=nil
;    $sz:local := nil
;    $floatok:local:=true
;    $was_nonblank := false
;    not nextline s => CONS(nil,nil)
;    if null scanIgnoreLine($ln,$n) -- line of spaces or starts ) or >
;    then cons(nil,$r)
;    else
;       toks:=[]
;       a:= incPrefix?('"command",1,$ln)
;       a =>
;            $ln := SUBSTRING($ln, 8, nil)
;            b := dqUnit constoken($ln, $linepos, ["command", $ln], 0)
;            cons([[b, s]], $r)
;
;       while $n<$sz repeat
;           tok := scanToken()
;           if tok and $spad_scanner then finish_comment()
;           toks:=dqAppend(toks, tok)
;       if null toks
;       then cons([],$r)
;       else
;           $last_nonempty_linepos := $linepos
;           cons([[toks,s]],$r)

(DEFUN |lineoftoks| (|s|)
  (PROG (|$floatok| |$sz| |$n| |$linepos| |$ln| |$r| |$f| |tok| |b| |a| |toks|)
    (DECLARE (SPECIAL |$floatok| |$sz| |$n| |$linepos| |$ln| |$r| |$f|))
    (RETURN
     (PROGN
      (SETQ |$f| NIL)
      (SETQ |$r| NIL)
      (SETQ |$ln| NIL)
      (SETQ |$linepos| NIL)
      (SETQ |$n| NIL)
      (SETQ |$sz| NIL)
      (SETQ |$floatok| T)
      (SETQ |$was_nonblank| NIL)
      (COND ((NULL (|nextline| |s|)) (CONS NIL NIL))
            (#1='T
             (COND ((NULL (|scanIgnoreLine| |$ln| |$n|)) (CONS NIL |$r|))
                   (#1# (SETQ |toks| NIL)
                    (SETQ |a| (|incPrefix?| "command" 1 |$ln|))
                    (COND
                     (|a|
                      (PROGN
                       (SETQ |$ln| (SUBSTRING |$ln| 8 NIL))
                       (SETQ |b|
                               (|dqUnit|
                                (|constoken| |$ln| |$linepos|
                                 (LIST '|command| |$ln|) 0)))
                       (CONS (LIST (LIST |b| |s|)) |$r|)))
                     (#1#
                      (PROGN
                       ((LAMBDA ()
                          (LOOP
                           (COND ((NOT (< |$n| |$sz|)) (RETURN NIL))
                                 (#1#
                                  (PROGN
                                   (SETQ |tok| (|scanToken|))
                                   (COND
                                    ((AND |tok| |$spad_scanner|)
                                     (|finish_comment|)))
                                   (SETQ |toks|
                                           (|dqAppend| |toks| |tok|))))))))
                       (COND ((NULL |toks|) (CONS NIL |$r|))
                             (#1# (SETQ |$last_nonempty_linepos| |$linepos|)
                              (CONS (LIST (LIST |toks| |s|)) |$r|))))))))))))))

; scanToken () ==
;       ln:=$ln
;       c := STR_ELT($ln, $n)
;       linepos:=$linepos
;       n:=$n
;       ch:=$ln.$n
;       b:=
;             startsComment?()          =>
;                            scanComment()
;                            []
;             startsNegComment?()       =>
;                            scanNegComment()
;                            []
;             c= QUESTION               =>
;                                $n:=$n+1
;                                lfid '"?"
;             punctuation? c            => scanPunct ()
;             startsId? ch              => scanWord  (false)
;             is_white?(c)              =>
;                            scanSpace ()
;                            $was_nonblank := false
;                            []
;             c = STRING_CHAR           => scanString ()
;             digit? ch                 => scanNumber ()
;             c=ESCAPE                  => scanEscape()
;             scanError ()
;       null b => nil
;       nb := $was_nonblank and b.0 = "key" and b.1 = "("
;       $was_nonblank := true
;       dqUnit constoken1(ln, linepos, b, n + lnExtraBlanks linepos, nb)

(DEFUN |scanToken| ()
  (PROG (|nb| |b| |ch| |n| |linepos| |c| |ln|)
    (RETURN
     (PROGN
      (SETQ |ln| |$ln|)
      (SETQ |c| (STR_ELT |$ln| |$n|))
      (SETQ |linepos| |$linepos|)
      (SETQ |n| |$n|)
      (SETQ |ch| (ELT |$ln| |$n|))
      (SETQ |b|
              (COND ((|startsComment?|) (PROGN (|scanComment|) NIL))
                    ((|startsNegComment?|) (PROGN (|scanNegComment|) NIL))
                    ((EQUAL |c| QUESTION)
                     (PROGN (SETQ |$n| (+ |$n| 1)) (|lfid| "?")))
                    ((|punctuation?| |c|) (|scanPunct|))
                    ((|startsId?| |ch|) (|scanWord| NIL))
                    ((|is_white?| |c|)
                     (PROGN (|scanSpace|) (SETQ |$was_nonblank| NIL) NIL))
                    ((EQUAL |c| STRING_CHAR) (|scanString|))
                    ((|digit?| |ch|) (|scanNumber|))
                    ((EQUAL |c| ESCAPE) (|scanEscape|)) (#1='T (|scanError|))))
      (COND ((NULL |b|) NIL)
            (#1#
             (PROGN
              (SETQ |nb|
                      (AND |$was_nonblank| (EQ (ELT |b| 0) '|key|)
                           (EQ (ELT |b| 1) '|(|)))
              (SETQ |$was_nonblank| T)
              (|dqUnit|
               (|constoken1| |ln| |linepos| |b|
                (+ |n| (|lnExtraBlanks| |linepos|)) |nb|)))))))))

; DEFPARAMETER($boot_package, FIND_-PACKAGE('"BOOT"))

(DEFPARAMETER |$boot_package| (FIND-PACKAGE "BOOT"))

; lfid x== ["id", INTERN(x, $boot_package)]

(DEFUN |lfid| (|x|)
  (PROG () (RETURN (LIST '|id| (INTERN |x| |$boot_package|)))))

; lfkey x==["key",keyword x]

(DEFUN |lfkey| (|x|) (PROG () (RETURN (LIST '|key| (|keyword| |x|)))))

; lfinteger x == ["integer", x]

(DEFUN |lfinteger| (|x|) (PROG () (RETURN (LIST '|integer| |x|))))

; lfrinteger (r,x)==["integer",CONCAT (r,CONCAT('"r",x))]

(DEFUN |lfrinteger| (|r| |x|)
  (PROG () (RETURN (LIST '|integer| (CONCAT |r| (CONCAT "r" |x|))))))

; lffloat(a, w, e) == ["float", [a, w, e]]

(DEFUN |lffloat| (|a| |w| |e|)
  (PROG () (RETURN (LIST '|float| (LIST |a| |w| |e|)))))

; lfstring x==if #x=1 then ["char",x] else ["string",x]

(DEFUN |lfstring| (|x|)
  (PROG ()
    (RETURN
     (COND ((EQL (LENGTH |x|) 1) (LIST '|char| |x|))
           ('T (LIST '|string| |x|))))))

; lfcomment (n, lp, x) == ["comment", x]

(DEFUN |lfcomment| (|n| |lp| |x|) (PROG () (RETURN (LIST '|comment| |x|))))

; lfnegcomment x== ["negcomment", x]

(DEFUN |lfnegcomment| (|x|) (PROG () (RETURN (LIST '|negcomment| |x|))))

; lferror x==["error",x]

(DEFUN |lferror| (|x|) (PROG () (RETURN (LIST '|error| |x|))))

; lfspaces x==["spaces",x]

(DEFUN |lfspaces| (|x|) (PROG () (RETURN (LIST '|spaces| |x|))))

; constoken1(ln, lp, b, n, nb) ==
; --  [b.0,b.1,cons(lp,n)]
;        a:=cons(b.0,b.1)
;        if nb then ncPutQ(a, "nonblank", true)
;        ncPutQ(a,"posn",cons(lp,n))
;        a

(DEFUN |constoken1| (|ln| |lp| |b| |n| |nb|)
  (PROG (|a|)
    (RETURN
     (PROGN
      (SETQ |a| (CONS (ELT |b| 0) (ELT |b| 1)))
      (COND (|nb| (|ncPutQ| |a| '|nonblank| T)))
      (|ncPutQ| |a| '|posn| (CONS |lp| |n|))
      |a|))))

; constoken(ln, lp, b, n) == constoken1(ln, lp, b, n, false)

(DEFUN |constoken| (|ln| |lp| |b| |n|)
  (PROG () (RETURN (|constoken1| |ln| |lp| |b| |n| NIL))))

; scanEscape()==
;          $n:=$n+1
;          a:=scanEsc()
;          if a then scanWord true else nil

(DEFUN |scanEscape| ()
  (PROG (|a|)
    (RETURN
     (PROGN
      (SETQ |$n| (+ |$n| 1))
      (SETQ |a| (|scanEsc|))
      (COND (|a| (|scanWord| T)) ('T NIL))))))

; scanEsc()==
;      if $n>=$sz
;      then if nextline($r)
;           then
;              $n := 0
;              false
;           else false
;      else
;          true

(DEFUN |scanEsc| ()
  (PROG ()
    (RETURN
     (COND
      ((NOT (< |$n| |$sz|))
       (COND ((|nextline| |$r|) (SETQ |$n| 0) NIL) (#1='T NIL)))
      (#1# T)))))

; checkEsc()==
;     if STR_ELT($ln, $sz - 1) = ESCAPE then scanEsc()

(DEFUN |checkEsc| ()
  (PROG ()
    (RETURN (COND ((EQUAL (STR_ELT |$ln| (- |$sz| 1)) ESCAPE) (|scanEsc|))))))

; startsComment?()==
;     if $n<$sz
;     then
;          if STR_ELT($ln, $n) = PLUSCOMMENT then
;             www:=$n+1
;             if www>=$sz
;             then false
;             else STR_ELT($ln, www) = PLUSCOMMENT
;          else false
;     else false

(DEFUN |startsComment?| ()
  (PROG (|www|)
    (RETURN
     (COND
      ((< |$n| |$sz|)
       (COND
        ((EQUAL (STR_ELT |$ln| |$n|) PLUSCOMMENT) (SETQ |www| (+ |$n| 1))
         (COND ((NOT (< |www| |$sz|)) NIL)
               (#1='T (EQUAL (STR_ELT |$ln| |www|) PLUSCOMMENT))))
        (#1# NIL)))
      (#1# NIL)))))

; startsNegComment?()==
;     if $n< $sz
;     then
;          if STR_ELT($ln, $n) = MINUSCOMMENT then
;             www:=$n+1
;             if www>=$sz
;             then false
;             else STR_ELT($ln, www) = MINUSCOMMENT
;          else false
;     else false

(DEFUN |startsNegComment?| ()
  (PROG (|www|)
    (RETURN
     (COND
      ((< |$n| |$sz|)
       (COND
        ((EQUAL (STR_ELT |$ln| |$n|) MINUSCOMMENT) (SETQ |www| (+ |$n| 1))
         (COND ((NOT (< |www| |$sz|)) NIL)
               (#1='T (EQUAL (STR_ELT |$ln| |www|) MINUSCOMMENT))))
        (#1# NIL)))
      (#1# NIL)))))

; scanNegComment()==
;       n:=$n
;       $n:=$sz
;       res := lfnegcomment SUBSTRING($ln,n,nil)
;       checkEsc()
;       res

(DEFUN |scanNegComment| ()
  (PROG (|res| |n|)
    (RETURN
     (PROGN
      (SETQ |n| |$n|)
      (SETQ |$n| |$sz|)
      (SETQ |res| (|lfnegcomment| (SUBSTRING |$ln| |n| NIL)))
      (|checkEsc|)
      |res|))))

; scanComment()==
;       n:=$n
;       $n:=$sz
;       c_str := SUBSTRING($ln,n,nil)
;       if $spad_scanner then
;           if not(n = $comment_indent) then
;               finish_comment()
;           $comment_line := first(rest(rest($linepos)))
;           $comment_indent := n
;           PUSH(CONCAT(make_full_CVEC(n), c_str), $current_comment_block)
;       res := lfcomment(n, $linepos, c_str)
;       checkEsc()
;       res

(DEFUN |scanComment| ()
  (PROG (|res| |c_str| |n|)
    (RETURN
     (PROGN
      (SETQ |n| |$n|)
      (SETQ |$n| |$sz|)
      (SETQ |c_str| (SUBSTRING |$ln| |n| NIL))
      (COND
       (|$spad_scanner|
        (COND ((NULL (EQUAL |n| |$comment_indent|)) (|finish_comment|)))
        (SETQ |$comment_line| (CAR (CDR (CDR |$linepos|))))
        (SETQ |$comment_indent| |n|)
        (PUSH (CONCAT (|make_full_CVEC| |n|) |c_str|)
              |$current_comment_block|)))
      (SETQ |res| (|lfcomment| |n| |$linepos| |c_str|))
      (|checkEsc|)
      |res|))))

; scanPunct()==
;             sss:=subMatch($ln,$n)
;             a:= # sss
;             if a=0
;             then
;                scanError()
;             else
;                $n:=$n+a
;                scanKeyTr sss

(DEFUN |scanPunct| ()
  (PROG (|a| |sss|)
    (RETURN
     (PROGN
      (SETQ |sss| (|subMatch| |$ln| |$n|))
      (SETQ |a| (LENGTH |sss|))
      (COND ((EQL |a| 0) (|scanError|))
            ('T (SETQ |$n| (+ |$n| |a|)) (|scanKeyTr| |sss|)))))))

; scanKeyTr w==
;        if EQ(keyword w, ".")
;        then if $floatok
;             then scanPossFloat(w)
;             else lfkey w
;        else
;             $floatok:=not scanCloser? w
;             lfkey w

(DEFUN |scanKeyTr| (|w|)
  (PROG ()
    (RETURN
     (COND
      ((EQ (|keyword| |w|) '|.|)
       (COND (|$floatok| (|scanPossFloat| |w|)) (#1='T (|lfkey| |w|))))
      (#1# (SETQ |$floatok| (NULL (|scanCloser?| |w|))) (|lfkey| |w|))))))

; scanPossFloat (w)==
;      if $n>=$sz or not digit? $ln.$n
;      then lfkey w
;      else
;        w:=spleI(function digit?)
;        scanExponent('"0",w)

(DEFUN |scanPossFloat| (|w|)
  (PROG ()
    (RETURN
     (COND
      ((OR (NOT (< |$n| |$sz|)) (NULL (|digit?| (ELT |$ln| |$n|))))
       (|lfkey| |w|))
      ('T (SETQ |w| (|spleI| #'|digit?|)) (|scanExponent| "0" |w|))))))

; scanCloser:=[")","}","]","|)","|}","|]"]

(EVAL-WHEN (EVAL LOAD)
  (SETQ |scanCloser| (LIST '|)| '} '] '|\|)| '|\|}| '|\|]|)))

; scanCloser? w== MEMQ(keyword w,scanCloser)

(DEFUN |scanCloser?| (|w|)
  (PROG () (RETURN (MEMQ (|keyword| |w|) |scanCloser|))))

; scanSpace()==
;            n:=$n
;            $n := skip_whitespace($ln, $n)
;            $floatok:=true
;            lfspaces ($n-n)

(DEFUN |scanSpace| ()
  (PROG (|n|)
    (RETURN
     (PROGN
      (SETQ |n| |$n|)
      (SETQ |$n| (|skip_whitespace| |$ln| |$n|))
      (SETQ |$floatok| T)
      (|lfspaces| (- |$n| |n|))))))

; e_concat(s1, s2) ==
;     #s2 = 0 => s1
;     idChar?(s2.0) => CONCAT(s1, "__", s2)
;     CONCAT(s1, s2)

(DEFUN |e_concat| (|s1| |s2|)
  (PROG ()
    (RETURN
     (COND ((EQL (LENGTH |s2|) 0) |s1|)
           ((|idChar?| (ELT |s2| 0)) (CONCAT |s1| '_ |s2|))
           ('T (CONCAT |s1| |s2|))))))

; scanString()==
;             $n:=$n+1
;             $floatok:=false
;             lfstring scanS ()

(DEFUN |scanString| ()
  (PROG ()
    (RETURN
     (PROGN
      (SETQ |$n| (+ |$n| 1))
      (SETQ |$floatok| NIL)
      (|lfstring| (|scanS|))))))

; scanS()==
;    if $n>=$sz
;    then
;      ncSoftError(cons($linepos,lnExtraBlanks $linepos+$n),"S2CN0001",[])
;      '""
;    else
;            n:=$n
;            strsym :=STRPOS ('"_"",$ln,$n,nil) or $sz
;            escsym:=STRPOS ('"__"
;                           ,$ln,$n,nil)  or $sz
;            mn:=MIN(strsym,escsym)
;            if mn=$sz
;            then
;                  $n:=$sz
;                  ncSoftError(cons($linepos,lnExtraBlanks $linepos+$n),
;                          "S2CN0001",[])
;                  SUBSTRING($ln,n,nil)
;            else if mn=strsym
;                 then
;                    $n:=mn+1
;                    SUBSTRING($ln,n,mn-n)
;                 else     --escape is found first
;                   str:=SUBSTRING($ln,n,mn-n)-- before escape
;                   $n:=mn+1
;                   a:=scanEsc() -- case of end of line when false
;                   not(a) => CONCAT(str, scanS())
;                   ec := $ln.$n
;                   $n := $n + 1
;                   e_concat(str, CONCAT(ec, scanS()))

(DEFUN |scanS| ()
  (PROG (|ec| |a| |str| |mn| |escsym| |strsym| |n|)
    (RETURN
     (COND
      ((NOT (< |$n| |$sz|))
       (|ncSoftError| (CONS |$linepos| (+ (|lnExtraBlanks| |$linepos|) |$n|))
        'S2CN0001 NIL)
       "")
      (#1='T (SETQ |n| |$n|)
       (SETQ |strsym| (OR (STRPOS "\"" |$ln| |$n| NIL) |$sz|))
       (SETQ |escsym| (OR (STRPOS "_" |$ln| |$n| NIL) |$sz|))
       (SETQ |mn| (MIN |strsym| |escsym|))
       (COND
        ((EQUAL |mn| |$sz|) (SETQ |$n| |$sz|)
         (|ncSoftError| (CONS |$linepos| (+ (|lnExtraBlanks| |$linepos|) |$n|))
          'S2CN0001 NIL)
         (SUBSTRING |$ln| |n| NIL))
        ((EQUAL |mn| |strsym|) (SETQ |$n| (+ |mn| 1))
         (SUBSTRING |$ln| |n| (- |mn| |n|)))
        (#1# (SETQ |str| (SUBSTRING |$ln| |n| (- |mn| |n|)))
         (SETQ |$n| (+ |mn| 1)) (SETQ |a| (|scanEsc|))
         (COND ((NULL |a|) (CONCAT |str| (|scanS|)))
               (#1#
                (PROGN
                 (SETQ |ec| (ELT |$ln| |$n|))
                 (SETQ |$n| (+ |$n| 1))
                 (|e_concat| |str| (CONCAT |ec| (|scanS|)))))))))))))

; posend(line,n)==
;      while n<#line and idChar? line.n repeat n:=n+1
;      n

(DEFUN |posend| (|line| |n|)
  (PROG ()
    (RETURN
     (PROGN
      ((LAMBDA ()
         (LOOP
          (COND
           ((NOT (AND (< |n| (LENGTH |line|)) (|idChar?| (ELT |line| |n|))))
            (RETURN NIL))
           ('T (SETQ |n| (+ |n| 1)))))))
      |n|))))

; digit? x== DIGITP x

(DEFUN |digit?| (|x|) (PROG () (RETURN (DIGITP |x|))))

; scanW(b)==             -- starts pointing to first char
;        n1:=$n         -- store starting character position
;        $n := inc_SI($n)          -- the first character is not tested
;        l:=$sz
;        endid:=posend($ln,$n)
;        if endid = l or STR_ELT($ln, endid) ~= ESCAPE then
;            -- not escaped
;            $n:=endid
;            [b, SUBSTRING($ln, n1, sub_SI(endid, n1))] -- l overflows
;        else -- escape and endid~=l
;            str:=SUBSTRING($ln,n1,endid-n1)
;            $n:=endid+1
;            a:=scanEsc()
;            bb:=if a -- escape nonspace
;                then scanW(true)
;                else
;                   if $n>=$sz
;                   then [b,'""]
;                   else
;                     if idChar?($ln.$n)
;                     then scanW(b)
;                     else [b,'""]
;            [bb.0 or b, e_concat(str, bb.1)]

(DEFUN |scanW| (|b|)
  (PROG (|n1| |l| |endid| |str| |a| |bb|)
    (RETURN
     (PROGN
      (SETQ |n1| |$n|)
      (SETQ |$n| (|inc_SI| |$n|))
      (SETQ |l| |$sz|)
      (SETQ |endid| (|posend| |$ln| |$n|))
      (COND
       ((OR (EQUAL |endid| |l|) (NOT (EQUAL (STR_ELT |$ln| |endid|) ESCAPE)))
        (SETQ |$n| |endid|)
        (LIST |b| (SUBSTRING |$ln| |n1| (|sub_SI| |endid| |n1|))))
       (#1='T (SETQ |str| (SUBSTRING |$ln| |n1| (- |endid| |n1|)))
        (SETQ |$n| (+ |endid| 1)) (SETQ |a| (|scanEsc|))
        (SETQ |bb|
                (COND (|a| (|scanW| T)) ((NOT (< |$n| |$sz|)) (LIST |b| ""))
                      ((|idChar?| (ELT |$ln| |$n|)) (|scanW| |b|))
                      (#1# (LIST |b| ""))))
        (LIST (OR (ELT |bb| 0) |b|) (|e_concat| |str| (ELT |bb| 1)))))))))

; scanWord(esp) ==
;           aaa:=scanW(false)
;           w:=aaa.1
;           $floatok:=false
;           if esp or aaa.0
;           then lfid w
;           else if (keyword? w and ($spad_scanner or w ~= '"not"))
;                then
;                   $floatok:=true
;                   lfkey w
;                else lfid  w

(DEFUN |scanWord| (|esp|)
  (PROG (|aaa| |w|)
    (RETURN
     (PROGN
      (SETQ |aaa| (|scanW| NIL))
      (SETQ |w| (ELT |aaa| 1))
      (SETQ |$floatok| NIL)
      (COND ((OR |esp| (ELT |aaa| 0)) (|lfid| |w|))
            ((AND (|keyword?| |w|)
                  (OR |$spad_scanner| (NOT (EQUAL |w| "not"))))
             (SETQ |$floatok| T) (|lfkey| |w|))
            ('T (|lfid| |w|)))))))

; spleI(dig)==spleI1(dig,false)

(DEFUN |spleI| (|dig|) (PROG () (RETURN (|spleI1| |dig| NIL))))

; spleI1(dig,zro) ==
;        n:=$n
;        l:= $sz
;        while $n<l and FUNCALL(dig,($ln.$n)) repeat $n:=$n+1
;        if $n = l or STR_ELT($ln, $n) ~= ESCAPE
;        then if n=$n and zro
;             then '"0"
;             else SUBSTRING($ln,n,$n-n)
;        else  -- escaped
;              str:=SUBSTRING($ln,n,$n-n)
;              $n:=$n+1
;              a:=scanEsc()
;              bb:=spleI1(dig,zro)-- escape, anyno spaces are ignored
;              CONCAT(str,bb)

(DEFUN |spleI1| (|dig| |zro|)
  (PROG (|n| |l| |str| |a| |bb|)
    (RETURN
     (PROGN
      (SETQ |n| |$n|)
      (SETQ |l| |$sz|)
      ((LAMBDA ()
         (LOOP
          (COND
           ((NOT (AND (< |$n| |l|) (FUNCALL |dig| (ELT |$ln| |$n|))))
            (RETURN NIL))
           (#1='T (SETQ |$n| (+ |$n| 1)))))))
      (COND
       ((OR (EQUAL |$n| |l|) (NOT (EQUAL (STR_ELT |$ln| |$n|) ESCAPE)))
        (COND ((AND (EQUAL |n| |$n|) |zro|) "0")
              (#1# (SUBSTRING |$ln| |n| (- |$n| |n|)))))
       (#1# (SETQ |str| (SUBSTRING |$ln| |n| (- |$n| |n|)))
        (SETQ |$n| (+ |$n| 1)) (SETQ |a| (|scanEsc|))
        (SETQ |bb| (|spleI1| |dig| |zro|)) (CONCAT |str| |bb|)))))))

; scanCheckRadix(r,w)==
;        ns:=#w
;        ns = 0 =>
;             ncSoftError([$linepos, :lnExtraBlanks $linepos+$n], "S2CN0004", [])
;        done:=false
;        for i in 0..ns-1  repeat
;          a:=rdigit? w.i
;          if null a or a>=r
;          then  ncSoftError(cons($linepos,lnExtraBlanks $linepos+$n-ns+i),
;                     "S2CN0002", [w.i])

(DEFUN |scanCheckRadix| (|r| |w|)
  (PROG (|ns| |done| |a|)
    (RETURN
     (PROGN
      (SETQ |ns| (LENGTH |w|))
      (COND
       ((EQL |ns| 0)
        (|ncSoftError| (CONS |$linepos| (+ (|lnExtraBlanks| |$linepos|) |$n|))
         'S2CN0004 NIL))
       (#1='T
        (PROGN
         (SETQ |done| NIL)
         ((LAMBDA (|bfVar#7| |i|)
            (LOOP
             (COND ((> |i| |bfVar#7|) (RETURN NIL))
                   (#1#
                    (PROGN
                     (SETQ |a| (|rdigit?| (ELT |w| |i|)))
                     (COND
                      ((OR (NULL |a|) (NOT (< |a| |r|)))
                       (|ncSoftError|
                        (CONS |$linepos|
                              (+ (- (+ (|lnExtraBlanks| |$linepos|) |$n|) |ns|)
                                 |i|))
                        'S2CN0002 (LIST (ELT |w| |i|))))))))
             (SETQ |i| (+ |i| 1))))
          (- |ns| 1) 0))))))))

; scanNumber() ==
;        a := spleI(function digit?)
;        if $n>=$sz
;        then lfinteger a
;        else
;          if STR_ELT($ln, $n) ~= RADIX_CHAR then
;            if $floatok and STR_ELT($ln, $n) = DOT then
;              n:=$n
;              $n:=$n+1
;              if  $n<$sz and STR_ELT($ln, $n) = DOT then
;                $n:=n
;                lfinteger a
;              else
;                w:=spleI1(function digit?,true)
;                scanExponent(a,w)
;            else lfinteger a
;          else
;              $n:=$n+1
;              w:=spleI1(function rdigit?, false)
;              scanCheckRadix(PARSE_-INTEGER a,w)
;              if $n>=$sz
;              then
;                 lfrinteger(a,w)
;              else if STR_ELT($ln, $n) = DOT then
;                     n:=$n
;                     $n:=$n+1
;                     if  $n < $sz and STR_ELT($ln, $n) = DOT then
;                        $n:=n
;                        lfrinteger(a,w)
;                     else
;                     --$n:=$n+1
;                       v:=spleI1(function rdigit?, false)
;                       scanCheckRadix(PARSE_-INTEGER a,v)
;                       scanExponent(CONCAT(a,'"r",w),v)
;                   else lfrinteger(a,w)

(DEFUN |scanNumber| ()
  (PROG (|v| |w| |n| |a|)
    (RETURN
     (PROGN
      (SETQ |a| (|spleI| #'|digit?|))
      (COND ((NOT (< |$n| |$sz|)) (|lfinteger| |a|))
            ((NOT (EQUAL (STR_ELT |$ln| |$n|) RADIX_CHAR))
             (COND
              ((AND |$floatok| (EQUAL (STR_ELT |$ln| |$n|) DOT))
               (SETQ |n| |$n|) (SETQ |$n| (+ |$n| 1))
               (COND
                ((AND (< |$n| |$sz|) (EQUAL (STR_ELT |$ln| |$n|) DOT))
                 (SETQ |$n| |n|) (|lfinteger| |a|))
                (#1='T (SETQ |w| (|spleI1| #'|digit?| T))
                 (|scanExponent| |a| |w|))))
              (#1# (|lfinteger| |a|))))
            (#1# (SETQ |$n| (+ |$n| 1)) (SETQ |w| (|spleI1| #'|rdigit?| NIL))
             (|scanCheckRadix| (PARSE-INTEGER |a|) |w|)
             (COND ((NOT (< |$n| |$sz|)) (|lfrinteger| |a| |w|))
                   ((EQUAL (STR_ELT |$ln| |$n|) DOT) (SETQ |n| |$n|)
                    (SETQ |$n| (+ |$n| 1))
                    (COND
                     ((AND (< |$n| |$sz|) (EQUAL (STR_ELT |$ln| |$n|) DOT))
                      (SETQ |$n| |n|) (|lfrinteger| |a| |w|))
                     (#1# (SETQ |v| (|spleI1| #'|rdigit?| NIL))
                      (|scanCheckRadix| (PARSE-INTEGER |a|) |v|)
                      (|scanExponent| (CONCAT |a| "r" |w|) |v|))))
                   (#1# (|lfrinteger| |a| |w|)))))))))

; scanExponent(a,w)==
;      if $n>=$sz
;      then lffloat(a,w,'"0")
;      else
;         n:=$n
;         c := STR_ELT($ln, $n)
;         if c=EXPONENT1 or c=EXPONENT2
;         then
;            $n:=$n+1
;            if $n>=$sz
;            then
;              $n:=n
;              lffloat(a,w,'"0")
;            else if digit?($ln.$n)
;                 then
;                   e:=spleI(function digit?)
;                   lffloat(a,w,e)
;                 else
;                   c1 := STR_ELT($ln, $n)
;                   if c1=PLUSCOMMENT or c1=MINUSCOMMENT
;                   then
;                     $n:=$n+1
;                     if $n>=$sz
;                     then
;                       $n:=n
;                       lffloat(a,w,'"0")
;                     else
;                       if digit?($ln.$n)
;                       then
;                         e:=spleI(function digit?)
;                         lffloat(a,w,
;                           (if c1=MINUSCOMMENT then CONCAT('"-",e)else e))
;                       else
;                         $n:=n
;                         lffloat(a,w,'"0")
;         else lffloat(a,w,'"0")

(DEFUN |scanExponent| (|a| |w|)
  (PROG (|n| |c| |e| |c1|)
    (RETURN
     (COND ((NOT (< |$n| |$sz|)) (|lffloat| |a| |w| "0"))
           (#1='T (SETQ |n| |$n|) (SETQ |c| (STR_ELT |$ln| |$n|))
            (COND
             ((OR (EQUAL |c| EXPONENT1) (EQUAL |c| EXPONENT2))
              (SETQ |$n| (+ |$n| 1))
              (COND
               ((NOT (< |$n| |$sz|)) (SETQ |$n| |n|) (|lffloat| |a| |w| "0"))
               ((|digit?| (ELT |$ln| |$n|)) (SETQ |e| (|spleI| #'|digit?|))
                (|lffloat| |a| |w| |e|))
               (#1# (SETQ |c1| (STR_ELT |$ln| |$n|))
                (COND
                 ((OR (EQUAL |c1| PLUSCOMMENT) (EQUAL |c1| MINUSCOMMENT))
                  (SETQ |$n| (+ |$n| 1))
                  (COND
                   ((NOT (< |$n| |$sz|)) (SETQ |$n| |n|)
                    (|lffloat| |a| |w| "0"))
                   ((|digit?| (ELT |$ln| |$n|)) (SETQ |e| (|spleI| #'|digit?|))
                    (|lffloat| |a| |w|
                     (COND ((EQUAL |c1| MINUSCOMMENT) (CONCAT "-" |e|))
                           (#1# |e|))))
                   (#1# (SETQ |$n| |n|) (|lffloat| |a| |w| "0"))))))))
             (#1# (|lffloat| |a| |w| "0"))))))))

; rdigit? x==
;    STRPOS(x,'"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ",0,nil)

(DEFUN |rdigit?| (|x|)
  (PROG () (RETURN (STRPOS |x| "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ" 0 NIL))))

; scanError()==
;       n:=$n
;       $n:=$n+1
;       ncSoftError(cons($linepos,lnExtraBlanks $linepos+$n),
;          "S2CN0003",[$ln.n])
;       lferror ($ln.n)

(DEFUN |scanError| ()
  (PROG (|n|)
    (RETURN
     (PROGN
      (SETQ |n| |$n|)
      (SETQ |$n| (+ |$n| 1))
      (|ncSoftError| (CONS |$linepos| (+ (|lnExtraBlanks| |$linepos|) |$n|))
       'S2CN0003 (LIST (ELT |$ln| |n|)))
      (|lferror| (ELT |$ln| |n|))))))

; keyword st   == HGET(scanKeyTable,st)

(DEFUN |keyword| (|st|) (PROG () (RETURN (HGET |scanKeyTable| |st|))))

; keyword? st  ==  not null HGET(scanKeyTable,st)

(DEFUN |keyword?| (|st|)
  (PROG () (RETURN (NULL (NULL (HGET |scanKeyTable| |st|))))))

; subMatch(l,i)==substringMatch(l,scanDict,i)

(DEFUN |subMatch| (|l| |i|)
  (PROG () (RETURN (|substringMatch| |l| |scanDict| |i|))))

; substringMatch (l,d,i)==
;        h := STR_ELT(l, i)
;        u:=ELT(d,h)
;        ll:=SIZE l
;        done:=false
;        s1:='""
;        for j in 0.. SIZE u - 1 while not done repeat
;           s:=ELT(u,j)
;           ls:=SIZE s
;           done:=if ls+i > ll
;                 then false
;                 else
;                  eql:= true
;                  for k in 1..ls-1 while eql repeat
;                     eql := EQL(STR_ELT(s, k), STR_ELT(l, k + i))
;                  if eql
;                  then
;                    s1:=s
;                    true
;                  else false
;        s1

(DEFUN |substringMatch| (|l| |d| |i|)
  (PROG (|h| |u| |ll| |done| |s1| |s| |ls| |eql|)
    (RETURN
     (PROGN
      (SETQ |h| (STR_ELT |l| |i|))
      (SETQ |u| (ELT |d| |h|))
      (SETQ |ll| (SIZE |l|))
      (SETQ |done| NIL)
      (SETQ |s1| "")
      ((LAMBDA (|bfVar#8| |j|)
         (LOOP
          (COND ((OR (> |j| |bfVar#8|) |done|) (RETURN NIL))
                (#1='T
                 (PROGN
                  (SETQ |s| (ELT |u| |j|))
                  (SETQ |ls| (SIZE |s|))
                  (SETQ |done|
                          (COND ((< |ll| (+ |ls| |i|)) NIL)
                                (#1# (SETQ |eql| T)
                                 ((LAMBDA (|bfVar#9| |k|)
                                    (LOOP
                                     (COND
                                      ((OR (> |k| |bfVar#9|) (NOT |eql|))
                                       (RETURN NIL))
                                      (#1#
                                       (SETQ |eql|
                                               (EQL (STR_ELT |s| |k|)
                                                    (STR_ELT |l|
                                                             (+ |k| |i|))))))
                                     (SETQ |k| (+ |k| 1))))
                                  (- |ls| 1) 1)
                                 (COND (|eql| (SETQ |s1| |s|) T)
                                       (#1# NIL))))))))
          (SETQ |j| (+ |j| 1))))
       (- (SIZE |u|) 1) 0)
      |s1|))))

; punctuation? c == c < 256 and ELT_BVEC(scanPun, c) = 1

(DEFUN |punctuation?| (|c|)
  (PROG () (RETURN (AND (< |c| 256) (EQL (ELT_BVEC |scanPun| |c|) 1)))))
