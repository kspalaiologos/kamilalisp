
; )package "BOOT"

(IN-PACKAGE "BOOT")

; DEFPARAMETER($prev_line_number, 0)

(DEFPARAMETER |$prev_line_number| 0)

; DEFPARAMETER($curent_line_number, 0)

(DEFPARAMETER |$curent_line_number| 0)

; DEFPARAMETER($prev_line, nil)

(DEFPARAMETER |$prev_line| NIL)

; DEFPARAMETER($curent_line, nil)

(DEFPARAMETER |$curent_line| NIL)

; DEFPARAMETER($compiler_InteractiveFrame,
;              addBinding('$DomainsInScope,
;                     [["FLUID", :true],
;                       ["special", :(COPY_-TREE $InitialDomainsInScope)]],
;                     addBinding('$Information, nil,
;                                 makeInitialModemapFrame())))

(DEFPARAMETER |$compiler_InteractiveFrame|
  (|addBinding| '|$DomainsInScope|
   (LIST (CONS 'FLUID T)
         (CONS '|special| (COPY-TREE |$InitialDomainsInScope|)))
   (|addBinding| '|$Information| NIL (|makeInitialModemapFrame|))))

; make_BF(mant, expo) == [$BFtag, mant, expo]

(DEFUN |make_BF| (|mant| |expo|)
  (PROG () (RETURN (LIST |$BFtag| |mant| |expo|))))

; make_float(int, frac, fraclen, expo) ==
;     frac = 0 => make_BF(int, expo)
;     make_BF(int*EXPT(10, fraclen) + frac, expo - fraclen)

(DEFUN |make_float| (|int| |frac| |fraclen| |expo|)
  (PROG ()
    (RETURN
     (COND ((EQL |frac| 0) (|make_BF| |int| |expo|))
           ('T
            (|make_BF| (+ (* |int| (EXPT 10 |fraclen|)) |frac|)
             (- |expo| |fraclen|)))))))

; current_line_number() ==
;     tok := current_token()
;     tok =>
;          pos := TOKEN_-LINE_NUM(tok)
;          pos and INTEGERP(pos) => pos
;          nil
;     nil

(DEFUN |current_line_number| ()
  (PROG (|pos| |tok|)
    (RETURN
     (PROGN
      (SETQ |tok| (|current_token|))
      (COND
       (|tok|
        (PROGN
         (SETQ |pos| (TOKEN-LINE_NUM |tok|))
         (COND ((AND |pos| (INTEGERP |pos|)) |pos|) (#1='T NIL))))
       (#1# NIL))))))

; current_token_is_nonblank() ==
;     tok := current_token()
;     tok => TOKEN_-NONBLANK(tok)
;     nil

(DEFUN |current_token_is_nonblank| ()
  (PROG (|tok|)
    (RETURN
     (PROGN
      (SETQ |tok| (|current_token|))
      (COND (|tok| (TOKEN-NONBLANK |tok|)) ('T NIL))))))

; spad_syntax_error(wanted, parsing) ==
;     FORMAT(true, '"******** Spad syntax error detected ********")
;     if wanted then
;         FORMAT(true, '"~&Expected: ~S~%", wanted)
;     if $prev_line then
;         FORMAT(true, '"~&The prior line was:~%~%~5D> ~A~%~%",
;            $prev_line_number, $prev_line)
;     if $curent_line then
;         FORMAT(true, '"~&The current line is:~%~%~5D> ~A~%~%",
;            $curent_line_number, $curent_line)
;     TOKEN_-STACK_-SHOW()
;     THROW('SPAD_READER, nil)

(DEFUN |spad_syntax_error| (|wanted| |parsing|)
  (PROG ()
    (RETURN
     (PROGN
      (FORMAT T "******** Spad syntax error detected ********")
      (COND (|wanted| (FORMAT T "~&Expected: ~S~%" |wanted|)))
      (COND
       (|$prev_line|
        (FORMAT T "~&The prior line was:~%~%~5D> ~A~%~%" |$prev_line_number|
                |$prev_line|)))
      (COND
       (|$curent_line|
        (FORMAT T "~&The current line is:~%~%~5D> ~A~%~%" |$curent_line_number|
                |$curent_line|)))
      (TOKEN-STACK-SHOW)
      (THROW 'SPAD_READER NIL)))))

; fakeloopInclude(name, n) ==
;     handle_input_file(name, function fakeloopInclude0, [name, n])

(DEFUN |fakeloopInclude| (|name| |n|)
  (PROG ()
    (RETURN
     (|handle_input_file| |name| #'|fakeloopInclude0| (LIST |name| |n|)))))

; DEFPARAMETER($COMBLOCKLIST, nil)

(DEFPARAMETER $COMBLOCKLIST NIL)

; DEFPARAMETER($docList, nil)

(DEFPARAMETER |$docList| NIL)

; DEFVAR($spad_scanner, false)

(DEFVAR |$spad_scanner| NIL)

; DEFVAR($restore_list, nil)

(DEFVAR |$restore_list| NIL)

; DEFVAR($compiler_output_stream, nil)

(DEFVAR |$compiler_output_stream| NIL)

; DEFPARAMETER($file_apply, nil)

(DEFPARAMETER |$file_apply| NIL)

; output_lisp_form(form) ==
;     if $file_apply then FUNCALL($file_apply, form, form)

(DEFUN |output_lisp_form| (|form|)
  (PROG ()
    (RETURN (COND (|$file_apply| (FUNCALL |$file_apply| |form| |form|))))))

; output_lisp_defparameter(x, y) ==
;     form := ['DEFPARAMETER, x, ["QUOTE", y]]
;     output_lisp_form(form)
;     EVAL(form)

(DEFUN |output_lisp_defparameter| (|x| |y|)
  (PROG (|form|)
    (RETURN
     (PROGN
      (SETQ |form| (LIST 'DEFPARAMETER |x| (LIST 'QUOTE |y|)))
      (|output_lisp_form| |form|)
      (EVAL |form|)))))

; print_defun(name, body) ==
;     print_full2(body, $compiler_output_stream)

(DEFUN |print_defun| (|name| |body|)
  (PROG () (RETURN (|print_full2| |body| |$compiler_output_stream|))))

; DEFVAR($nopiles, false)

(DEFVAR |$nopiles| NIL)

; spadCompile(name) == spadCompile1(name, $nopiles)

(DEFUN |spadCompile| (|name|)
  (PROG () (RETURN (|spadCompile1| |name| |$nopiles|))))

; spadCompile1(name, pile_mode) ==
;     $nopiles : local := pile_mode
;     $comp370_apply : local := FUNCTION print_defun
;     $file_apply : local := FUNCTION print_defun
;     _*EOF_* : local := false
;     $edit_file : local := name
;     $InteractiveMode : local := false
;     $spad_scanner : local := true
;     $COMBLOCKLIST : local := nil
;     $docList : local := nil
;     $curent_line_number := 0
;     $prev_line := nil
;     $InteractiveFrame : local := $compiler_InteractiveFrame
;     $MacroTable := MAKE_HASHTABLE('EQUAL)
;     $restore_list := nil
;     $ncMsgList : local := nil
;     a := ncloopIncFileName name
;     res := fakeloopInclude(name, nil)
;     if not($ncMsgList = nil) then
;         processMsgList($ncMsgList, nil)
;     true

(DEFUN |spadCompile1| (|name| |pile_mode|)
  (PROG (|$ncMsgList| |$InteractiveFrame| |$docList| $COMBLOCKLIST
         |$spad_scanner| |$InteractiveMode| |$edit_file| *EOF* |$file_apply|
         |$comp370_apply| |$nopiles| |res| |a|)
    (DECLARE
     (SPECIAL |$ncMsgList| |$InteractiveFrame| |$docList| $COMBLOCKLIST
      |$spad_scanner| |$InteractiveMode| |$edit_file| *EOF* |$file_apply|
      |$comp370_apply| |$nopiles|))
    (RETURN
     (PROGN
      (SETQ |$nopiles| |pile_mode|)
      (SETQ |$comp370_apply| #'|print_defun|)
      (SETQ |$file_apply| #'|print_defun|)
      (SETQ *EOF* NIL)
      (SETQ |$edit_file| |name|)
      (SETQ |$InteractiveMode| NIL)
      (SETQ |$spad_scanner| T)
      (SETQ $COMBLOCKLIST NIL)
      (SETQ |$docList| NIL)
      (SETQ |$curent_line_number| 0)
      (SETQ |$prev_line| NIL)
      (SETQ |$InteractiveFrame| |$compiler_InteractiveFrame|)
      (SETQ |$MacroTable| (MAKE_HASHTABLE 'EQUAL))
      (SETQ |$restore_list| NIL)
      (SETQ |$ncMsgList| NIL)
      (SETQ |a| (|ncloopIncFileName| |name|))
      (SETQ |res| (|fakeloopInclude| |name| NIL))
      (COND ((NULL (NULL |$ncMsgList|)) (|processMsgList| |$ncMsgList| NIL)))
      T))))

; DEFPARAMETER($toklst, nil)

(DEFPARAMETER |$toklst| NIL)

; $trans_table := [["id", "IDENTIFIER"], ["key", "KEYWORD"], _
;                   ["string", "SPADSTRING"], ["char", "SPADSTRING"], _
;                   ["integer", "NUMBER"], ["float", "SPADFLOAT"]]

(EVAL-WHEN (EVAL LOAD)
  (SETQ |$trans_table|
          (LIST (LIST '|id| 'IDENTIFIER) (LIST '|key| 'KEYWORD)
                (LIST '|string| 'SPADSTRING) (LIST '|char| 'SPADSTRING)
                (LIST '|integer| 'NUMBER) (LIST '|float| 'SPADFLOAT))))

; $trans_key := [ _
;                 ["ARROW", "->"], _
;                 ["SEG", ".."], _
;                 ["BACKSET", ";"]]

(EVAL-WHEN (EVAL LOAD)
  (SETQ |$trans_key|
          (LIST (LIST 'ARROW '->) (LIST 'SEG '|..|) (LIST 'BACKSET '|;|))))

; $trans_key_id := [ _
;                 ["break", "break"], _
;                 ["ITERATE", "iterate"], _
;                 ["DEFAULT", "default"], _
;                 ["RULE", "rule"] _
;                 ]

(EVAL-WHEN (EVAL LOAD)
  (SETQ |$trans_key_id|
          (LIST (LIST '|break| '|break|) (LIST 'ITERATE '|iterate|)
                (LIST 'DEFAULT '|default|) (LIST 'RULE '|rule|))))

; $expression_nostarters := [ "ARROW", "BACKSET", ":=", ":", _
;     ",", "==", "=>", "+->", "==>", ";",
;     "has", "is", "pretend", "where", ")"]

(EVAL-WHEN (EVAL LOAD)
  (SETQ |$expression_nostarters|
          (LIST 'ARROW 'BACKSET '|:=| '|:| '|,| '== '=> '+-> '==> '|;| '|has|
                '|is| '|pretend| '|where| '|)|)))

; starts_expression?(sym, type) ==
;     type ~= "key" => true
;     MEMBER(sym, $expression_nostarters) => false
;     true

(DEFUN |starts_expression?| (|sym| |type|)
  (PROG ()
    (RETURN
     (COND ((NOT (EQ |type| '|key|)) T)
           ((MEMBER |sym| |$expression_nostarters|) NIL) ('T T)))))

; DEFVAR($paren_level)

(DEFVAR |$paren_level|)

; DEFVAR($settab_level)

(DEFVAR |$settab_level|)

; DEFVAR($tab_states)

(DEFVAR |$tab_states|)

; DEFVAR($ignored_tab)

(DEFVAR |$ignored_tab|)

; DEFVAR($maybe_insert_semi)

(DEFVAR |$maybe_insert_semi|)

; ntokreader(token) ==
;     nonblank_flag := nil
;     if $toklst then
;         tok1 := first $toklst
;         $toklst := rest $toklst
;         type1 := first(tok1)
;         sym := tok1.1
;         pos := tok1.4
;         line_info := first(rest(pos))
;         line_no := first(rest(rest(line_info)))
;         char_no := rest(rest(pos))
;         $maybe_insert_semi and starts_expression?(sym, type) =>
;             $toklst := cons(tok1, $toklst)
;             $maybe_insert_semi := false
;             token_install(";", "KEYWORD", false, line_no, char_no, token)
;         $maybe_insert_semi := false
;         if not($curent_line_number = line_no) then
;             $prev_line := $curent_line
;             $prev_line_number := $curent_line_number
;             $curent_line := line_info.1
;             $curent_line_number := line_no
;         if type1 = "integer" and STRINGP(sym) then
;             sym := READ_-FROM_-STRING(sym)
;         if type1 = "float" then
;             mant_i := READ_-FROM_-STRING(first(sym))
;             exp := READ_-FROM_-STRING(sym.2)
;             mant_fl := #(sym.1)
;             mant_f := READ_-FROM_-STRING(sym.1)
;             sym := make_float(mant_i, mant_f, mant_fl, exp)
;         if sym = "(" and type1 = "key" and tok1.3 = "nonblank" then
;             nonblank_flag := true
;         type := ASSQ(type1, $trans_table)
;         greater_SI($paren_level, 0) and type1 = "key" and _
;           sym in ["BACKSET", "BACKTAB", "SETTAB"] =>
;             if sym = "SETTAB" then
;                 $settab_level := inc_SI($settab_level)
;             if sym = "BACKTAB" then
;                 $settab_level := dec_SI($settab_level)
;             ntokreader(token)
;         greater_SI($settab_level, 0) and type1 = "key" and sym = "BACKTAB" =>
;             $settab_level := dec_SI($settab_level)
;             ntokreader(token)
;         -- Fix bad piles
;         if type1 = "key" and sym = "BACKSET" and $toklst then
;             ntok1 := first $toklst
;             ntype1 := first(ntok1)
;             nsym := ntok1.1
;             if ntype1 = "key" and nsym in ["then", "else"] then
;                 return ntokreader(token)
;         if type1 = "key" and sym = "SETTAB" and $toklst then
;             ntok1 := first $toklst
;             ntype1 := first(ntok1)
;             nsym := ntok1.1
;             if ntype1 = "key" and nsym in ["then", "else",
;                   ",", ";"] then
;                 PUSH($ignored_tab, $tab_states)
;                 $ignored_tab := true
;                 return ntokreader(token)
;             else
;                 PUSH($ignored_tab, $tab_states)
;                 $ignored_tab := false
;         if type1 = "key" and sym = "BACKSET" and $ignored_tab then
;             return ntokreader(token)
;         if type1 = "key" and sym = "BACKTAB" then
;             $ignored_tab0 := $ignored_tab
;             $ignored_tab := POP($tab_states)
;             if $ignored_tab0 then
;                 return ntokreader(token)
;         if type then
;             type := type.1
;         else
;             SAY([sym, type1])
;         if type1 = "key" then
;             sym = "(" =>
;                 $paren_level := inc_SI($paren_level)
;             sym = ")" =>
;                 $paren_level := dec_SI($paren_level)
;             sym = "#1" => type := "ARGUMENT-DESIGNATOR"
;             $maybe_insert_semi := sym = "}"
;             sym1 := ASSQ(sym, $trans_key)
;             sym2 := ASSQ(sym, $trans_key_id)
;             if sym2 then
;                 type := "IDENTIFIER"
;                 sym1 := sym2
;             sym :=
;                 sym1 => sym1.1
;                 sym
;         token_install(sym, type, nonblank_flag, line_no, char_no, token)
;     else
;         token_install(nil, "*EOF", nil, nil, 0, token)

(DEFUN |ntokreader| (|token|)
  (PROG (|nonblank_flag| |tok1| |type1| |sym| |pos| |line_info| |line_no|
         |char_no| |mant_i| |exp| |mant_fl| |mant_f| |type| |ntok1| |ntype1|
         |nsym| |sym1| |sym2|)
    (RETURN
     (PROGN
      (SETQ |nonblank_flag| NIL)
      (COND
       (|$toklst| (SETQ |tok1| (CAR |$toklst|))
        (SETQ |$toklst| (CDR |$toklst|)) (SETQ |type1| (CAR |tok1|))
        (SETQ |sym| (ELT |tok1| 1)) (SETQ |pos| (ELT |tok1| 4))
        (SETQ |line_info| (CAR (CDR |pos|)))
        (SETQ |line_no| (CAR (CDR (CDR |line_info|))))
        (SETQ |char_no| (CDR (CDR |pos|)))
        (COND
         ((AND |$maybe_insert_semi| (|starts_expression?| |sym| |type|))
          (PROGN
           (SETQ |$toklst| (CONS |tok1| |$toklst|))
           (SETQ |$maybe_insert_semi| NIL)
           (|token_install| '|;| 'KEYWORD NIL |line_no| |char_no| |token|)))
         (#1='T
          (PROGN
           (SETQ |$maybe_insert_semi| NIL)
           (COND
            ((NULL (EQUAL |$curent_line_number| |line_no|))
             (SETQ |$prev_line| |$curent_line|)
             (SETQ |$prev_line_number| |$curent_line_number|)
             (SETQ |$curent_line| (ELT |line_info| 1))
             (SETQ |$curent_line_number| |line_no|)))
           (COND
            ((AND (EQ |type1| '|integer|) (STRINGP |sym|))
             (SETQ |sym| (READ-FROM-STRING |sym|))))
           (COND
            ((EQ |type1| '|float|)
             (SETQ |mant_i| (READ-FROM-STRING (CAR |sym|)))
             (SETQ |exp| (READ-FROM-STRING (ELT |sym| 2)))
             (SETQ |mant_fl| (LENGTH (ELT |sym| 1)))
             (SETQ |mant_f| (READ-FROM-STRING (ELT |sym| 1)))
             (SETQ |sym| (|make_float| |mant_i| |mant_f| |mant_fl| |exp|))))
           (COND
            ((AND (EQ |sym| '|(|) (EQ |type1| '|key|)
                  (EQ (ELT |tok1| 3) '|nonblank|))
             (SETQ |nonblank_flag| T)))
           (SETQ |type| (ASSQ |type1| |$trans_table|))
           (COND
            ((AND (|greater_SI| |$paren_level| 0) (EQ |type1| '|key|)
                  (|member| |sym| (LIST 'BACKSET 'BACKTAB 'SETTAB)))
             (PROGN
              (COND
               ((EQ |sym| 'SETTAB)
                (SETQ |$settab_level| (|inc_SI| |$settab_level|))))
              (COND
               ((EQ |sym| 'BACKTAB)
                (SETQ |$settab_level| (|dec_SI| |$settab_level|))))
              (|ntokreader| |token|)))
            ((AND (|greater_SI| |$settab_level| 0) (EQ |type1| '|key|)
                  (EQ |sym| 'BACKTAB))
             (PROGN
              (SETQ |$settab_level| (|dec_SI| |$settab_level|))
              (|ntokreader| |token|)))
            (#1#
             (PROGN
              (COND
               ((AND (EQ |type1| '|key|) (EQ |sym| 'BACKSET) |$toklst|)
                (SETQ |ntok1| (CAR |$toklst|)) (SETQ |ntype1| (CAR |ntok1|))
                (SETQ |nsym| (ELT |ntok1| 1))
                (COND
                 ((AND (EQ |ntype1| '|key|)
                       (|member| |nsym| (LIST '|then| '|else|)))
                  (RETURN (|ntokreader| |token|))))))
              (COND
               ((AND (EQ |type1| '|key|) (EQ |sym| 'SETTAB) |$toklst|)
                (SETQ |ntok1| (CAR |$toklst|)) (SETQ |ntype1| (CAR |ntok1|))
                (SETQ |nsym| (ELT |ntok1| 1))
                (COND
                 ((AND (EQ |ntype1| '|key|)
                       (|member| |nsym| (LIST '|then| '|else| '|,| '|;|)))
                  (PUSH |$ignored_tab| |$tab_states|) (SETQ |$ignored_tab| T)
                  (RETURN (|ntokreader| |token|)))
                 (#1# (PUSH |$ignored_tab| |$tab_states|)
                  (SETQ |$ignored_tab| NIL)))))
              (COND
               ((AND (EQ |type1| '|key|) (EQ |sym| 'BACKSET) |$ignored_tab|)
                (RETURN (|ntokreader| |token|))))
              (COND
               ((AND (EQ |type1| '|key|) (EQ |sym| 'BACKTAB))
                (SETQ |$ignored_tab0| |$ignored_tab|)
                (SETQ |$ignored_tab| (POP |$tab_states|))
                (COND (|$ignored_tab0| (RETURN (|ntokreader| |token|))))))
              (COND (|type| (SETQ |type| (ELT |type| 1)))
                    (#1# (SAY (LIST |sym| |type1|))))
              (COND
               ((EQ |type1| '|key|)
                (COND
                 ((EQ |sym| '|(|)
                  (SETQ |$paren_level| (|inc_SI| |$paren_level|)))
                 ((EQ |sym| '|)|)
                  (SETQ |$paren_level| (|dec_SI| |$paren_level|)))
                 ((EQ |sym| '|#1|) (SETQ |type| 'ARGUMENT-DESIGNATOR))
                 (#1#
                  (PROGN
                   (SETQ |$maybe_insert_semi| (EQ |sym| '}))
                   (SETQ |sym1| (ASSQ |sym| |$trans_key|))
                   (SETQ |sym2| (ASSQ |sym| |$trans_key_id|))
                   (COND
                    (|sym2| (SETQ |type| 'IDENTIFIER) (SETQ |sym1| |sym2|)))
                   (SETQ |sym| (COND (|sym1| (ELT |sym1| 1)) (#1# |sym|))))))))
              (|token_install| |sym| |type| |nonblank_flag| |line_no| |char_no|
               |token|))))))))
       (#1# (|token_install| NIL '*EOF NIL NIL 0 |token|)))))))

; fakeloopInclude0(st, name, n) ==
;     $lines : local := incStream(st, name)
;     fakeloopProcess(n,
;       next(function insertpile,
;         next(function lineoftoks,$lines)))
;     nil

(DEFUN |fakeloopInclude0| (|st| |name| |n|)
  (PROG (|$lines|)
    (DECLARE (SPECIAL |$lines|))
    (RETURN
     (PROGN
      (SETQ |$lines| (|incStream| |st| |name|))
      (|fakeloopProcess| |n|
       (|next| #'|insertpile| (|next| #'|lineoftoks| |$lines|)))
      NIL))))

; fakeloopProcess1(tok_list) ==
;     $toklst := tok_list
;     $paren_level := 0
;     $settab_level := 0
;     $tab_states := nil
;     $ignored_tab := false
;     $ignorable_backset := false
;     $maybe_insert_semi := false
;     $docList := nil
;     finish_comment()
;     TOKEN_-STACK_-CLEAR()
;     parse_new_expr()
;     parseout := pop_stack_1()
;     if parseout then S_process(parseout)
;     nil

(DEFUN |fakeloopProcess1| (|tok_list|)
  (PROG (|parseout|)
    (RETURN
     (PROGN
      (SETQ |$toklst| |tok_list|)
      (SETQ |$paren_level| 0)
      (SETQ |$settab_level| 0)
      (SETQ |$tab_states| NIL)
      (SETQ |$ignored_tab| NIL)
      (SETQ |$ignorable_backset| NIL)
      (SETQ |$maybe_insert_semi| NIL)
      (SETQ |$docList| NIL)
      (|finish_comment|)
      (TOKEN-STACK-CLEAR)
      (|parse_new_expr|)
      (SETQ |parseout| (|pop_stack_1|))
      (COND (|parseout| (|S_process| |parseout|)))
      NIL))))

; processSymbol(s) ==
;     sym1 := first s
;     pos := first(rest(sym1))
;     npos := rest rest pos
;     rest rest sym1 => [first sym1, rest s, npos, "nonblank", pos]
;     [first sym1, rest s, npos, false, pos]

(DEFUN |processSymbol| (|s|)
  (PROG (|sym1| |pos| |npos|)
    (RETURN
     (PROGN
      (SETQ |sym1| (CAR |s|))
      (SETQ |pos| (CAR (CDR |sym1|)))
      (SETQ |npos| (CDR (CDR |pos|)))
      (COND
       ((CDR (CDR |sym1|))
        (LIST (CAR |sym1|) (CDR |s|) |npos| '|nonblank| |pos|))
       ('T (LIST (CAR |sym1|) (CDR |s|) |npos| NIL |pos|)))))))

; processCommand(line) ==
;     cl := rest(line)
;     InterpExecuteSpadSystemCommand(cl)

(DEFUN |processCommand| (|line|)
  (PROG (|cl|)
    (RETURN
     (PROGN (SETQ |cl| (CDR |line|)) (|InterpExecuteSpadSystemCommand| |cl|)))))

; fakeloopProcess(n, s) ==
;     StreamNull s => nil
;     lp := first s
;     line := first first lp
;     kind := first first first line
;     kind = "command" =>
;         processCommand(first(line))
;         fakeloopProcess(n, rest s)
;     nline := [processSymbol(sym) for sym in line]
;     fakeloopProcess1(nline)
;     fakeloopProcess(n, rest s)

(DEFUN |fakeloopProcess| (|n| |s|)
  (PROG (|lp| |line| |kind| |nline|)
    (RETURN
     (COND ((|StreamNull| |s|) NIL)
           (#1='T
            (PROGN
             (SETQ |lp| (CAR |s|))
             (SETQ |line| (CAR (CAR |lp|)))
             (SETQ |kind| (CAR (CAR (CAR |line|))))
             (COND
              ((EQ |kind| '|command|)
               (PROGN
                (|processCommand| (CAR |line|))
                (|fakeloopProcess| |n| (CDR |s|))))
              (#1#
               (PROGN
                (SETQ |nline|
                        ((LAMBDA (|bfVar#2| |bfVar#1| |sym|)
                           (LOOP
                            (COND
                             ((OR (ATOM |bfVar#1|)
                                  (PROGN (SETQ |sym| (CAR |bfVar#1|)) NIL))
                              (RETURN (NREVERSE |bfVar#2|)))
                             (#1#
                              (SETQ |bfVar#2|
                                      (CONS (|processSymbol| |sym|)
                                            |bfVar#2|))))
                            (SETQ |bfVar#1| (CDR |bfVar#1|))))
                         NIL |line| NIL))
                (|fakeloopProcess1| |nline|)
                (|fakeloopProcess| |n| (CDR |s|)))))))))))
