
; )package "BOOT"

(IN-PACKAGE "BOOT")

; DEFPARAMETER($SystemError, 'SystemError)

(DEFPARAMETER |$SystemError| '|SystemError|)

; DEFPARAMETER($UserError, 'UserError)

(DEFPARAMETER |$UserError| '|UserError|)

; DEFPARAMETER($AlgebraError, 'AlgebraError)

(DEFPARAMETER |$AlgebraError| '|AlgebraError|)

; DEFVAR($timedNameStack)

(DEFVAR |$timedNameStack|)

; BUMPCOMPERRORCOUNT() == nil

(DEFUN BUMPCOMPERRORCOUNT () (PROG () (RETURN NIL)))

; argumentDataError(argnum, condit, funname) ==
;   msg := ['"The test",:bright pred2English condit,'"evaluates to",
;     :bright '"false",'%l,'"   for argument",:bright argnum,_
;     '"to the function",:bright funname,'"and this indicates",'%l,_
;     '"   that the argument is not appropriate."]
;   errorSupervisor($AlgebraError,msg)

(DEFUN |argumentDataError| (|argnum| |condit| |funname|)
  (PROG (|msg|)
    (RETURN
     (PROGN
      (SETQ |msg|
              (CONS "The test"
                    (APPEND (|bright| (|pred2English| |condit|))
                            (CONS "evaluates to"
                                  (APPEND (|bright| "false")
                                          (CONS '|%l|
                                                (CONS "   for argument"
                                                      (APPEND
                                                       (|bright| |argnum|)
                                                       (CONS "to the function"
                                                             (APPEND
                                                              (|bright|
                                                               |funname|)
                                                              (CONS
                                                               "and this indicates"
                                                               (CONS '|%l|
                                                                     (CONS
                                                                      "   that the argument is not appropriate."
                                                                      NIL)))))))))))))
      (|errorSupervisor| |$AlgebraError| |msg|)))))

; queryUser msg ==
;   -- display message and return reply
;   sayBrightly msg
;   read_line _*TERMINAL_-IO_*

(DEFUN |queryUser| (|msg|)
  (PROG () (RETURN (PROGN (|sayBrightly| |msg|) (|read_line| *TERMINAL-IO*)))))

; errorSupervisor(errorType,errorMsg) ==
;   $BreakMode = 'trapSpadErrors => THROW('trapSpadErrors, $numericFailure)
;   errorSupervisor1(errorType,errorMsg,$BreakMode)

(DEFUN |errorSupervisor| (|errorType| |errorMsg|)
  (PROG ()
    (RETURN
     (COND
      ((EQ |$BreakMode| '|trapSpadErrors|)
       (THROW '|trapSpadErrors| |$numericFailure|))
      ('T (|errorSupervisor1| |errorType| |errorMsg| |$BreakMode|))))))

; errorSupervisor1(errorType,errorMsg,$BreakMode) ==
;   BUMPCOMPERRORCOUNT()
;   errorLabel :=
;       errorType = $SystemError  => '"System error"
;       errorType = $UserError    => '"Apparent user error"
;       errorType = $AlgebraError =>
;         '"Error detected within library code"
;       STRINGP errorType         => errorType
;       '"Error with unknown classification"
;   msg :=
;     errorMsg is ['mathprint, :.] => errorMsg
;     not PAIRP errorMsg => ['"   ", errorMsg]
;     splitmsg := true
;     if member('%b,errorMsg) then splitmsg := nil
;       else if member('%d,errorMsg) then splitmsg := nil
;            else if member('%l,errorMsg) then splitmsg := nil
;     splitmsg => rest [:['%l, '"   ", u] for u in errorMsg]
;     ['"   ",:errorMsg]
;   sayErrorly(errorLabel, msg)
;   handleLispBreakLoop($BreakMode)

(DEFUN |errorSupervisor1| (|errorType| |errorMsg| |$BreakMode|)
  (DECLARE (SPECIAL |$BreakMode|))
  (PROG (|errorLabel| |splitmsg| |msg|)
    (RETURN
     (PROGN
      (BUMPCOMPERRORCOUNT)
      (SETQ |errorLabel|
              (COND ((EQUAL |errorType| |$SystemError|) "System error")
                    ((EQUAL |errorType| |$UserError|) "Apparent user error")
                    ((EQUAL |errorType| |$AlgebraError|)
                     "Error detected within library code")
                    ((STRINGP |errorType|) |errorType|)
                    (#1='T "Error with unknown classification")))
      (SETQ |msg|
              (COND
               ((AND (CONSP |errorMsg|) (EQ (CAR |errorMsg|) '|mathprint|))
                |errorMsg|)
               ((NULL (CONSP |errorMsg|)) (LIST "   " |errorMsg|))
               (#1#
                (PROGN
                 (SETQ |splitmsg| T)
                 (COND ((|member| '|%b| |errorMsg|) (SETQ |splitmsg| NIL))
                       ((|member| '|%d| |errorMsg|) (SETQ |splitmsg| NIL))
                       ((|member| '|%l| |errorMsg|) (SETQ |splitmsg| NIL)))
                 (COND
                  (|splitmsg|
                   (CDR
                    ((LAMBDA (|bfVar#2| |bfVar#1| |u|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#1|)
                              (PROGN (SETQ |u| (CAR |bfVar#1|)) NIL))
                          (RETURN (NREVERSE |bfVar#2|)))
                         (#1#
                          (SETQ |bfVar#2|
                                  (APPEND (REVERSE (LIST '|%l| "   " |u|))
                                          |bfVar#2|))))
                        (SETQ |bfVar#1| (CDR |bfVar#1|))))
                     NIL |errorMsg| NIL)))
                  (#1# (CONS "   " |errorMsg|)))))))
      (|sayErrorly| |errorLabel| |msg|)
      (|handleLispBreakLoop| |$BreakMode|)))))

; handleLispBreakLoop($BreakMode) ==
;   TERPRI()
;   -- The next line is to try to deal with some reported cases of unwanted
;   -- backtraces appearing, MCD.
;   ENABLE_BACKTRACE(nil)
;   $BreakMode = 'break =>
;     sayBrightly '" "
;     BREAK()
;   $BreakMode = 'query =>
;     gotIt := nil
;     while not gotIt repeat
;       gotIt := true
;       msgQ :=
;        ['%l,'"   You have three options. Enter:",'%l,_
;         '"    ",:bright '"continue",'"  to continue processing,",'%l,_
;         '"    ",:bright '"top     ",'"  to return to top level, or",'%l,_
;         '"    ",:bright '"break   ",'"  to enter a LISP break loop.",'%l,_
;         '%l,'"   Please enter your choice now:"]
;       x := STRING2ID_N(queryUser(msgQ), 1)
;       x :=
;         selectOptionLC(x,'(top break continue),NIL)
;       null x =>
;         sayBrightly bright '"  That was not one of your choices!"
;         gotIt := NIL
;       x = 'top => returnToTopLevel()
;       x = 'break =>
;         $BreakMode := 'break
;         sayBrightly ['"   Enter",:bright '":C",
;             '"when you are ready to continue processing where you ",'%l,_
;             '"   interrupted the system, enter",:bright '"(TOP)",_
;             '"when you wish to return",'%l,'"   to top level.",'%l,'%l]
;         BREAK()
;       sayBrightly
;         '"   Processing will continue where it was interrupted."
;       THROW('SPAD_READER, nil)
;   $BreakMode = 'resume =>
;     returnToReader()
;   $BreakMode = 'throw_reader => THROW('SPAD_READER, nil)
;   $BreakMode = 'quit =>
;     EXIT_-WITH_-STATUS(1)
;   returnToTopLevel()

(DEFUN |handleLispBreakLoop| (|$BreakMode|)
  (DECLARE (SPECIAL |$BreakMode|))
  (PROG (|gotIt| |msgQ| |x|)
    (RETURN
     (PROGN
      (TERPRI)
      (ENABLE_BACKTRACE NIL)
      (COND ((EQ |$BreakMode| '|break|) (PROGN (|sayBrightly| " ") (BREAK)))
            ((EQ |$BreakMode| '|query|)
             (PROGN
              (SETQ |gotIt| NIL)
              ((LAMBDA ()
                 (LOOP
                  (COND (|gotIt| (RETURN NIL))
                        (#1='T
                         (PROGN
                          (SETQ |gotIt| T)
                          (SETQ |msgQ|
                                  (CONS '|%l|
                                        (CONS
                                         "   You have three options. Enter:"
                                         (CONS '|%l|
                                               (CONS "    "
                                                     (APPEND
                                                      (|bright| "continue")
                                                      (CONS
                                                       "  to continue processing,"
                                                       (CONS '|%l|
                                                             (CONS "    "
                                                                   (APPEND
                                                                    (|bright|
                                                                     "top     ")
                                                                    (CONS
                                                                     "  to return to top level, or"
                                                                     (CONS
                                                                      '|%l|
                                                                      (CONS
                                                                       "    "
                                                                       (APPEND
                                                                        (|bright|
                                                                         "break   ")
                                                                        (CONS
                                                                         "  to enter a LISP break loop."
                                                                         (CONS
                                                                          '|%l|
                                                                          (CONS
                                                                           '|%l|
                                                                           (CONS
                                                                            "   Please enter your choice now:"
                                                                            NIL))))))))))))))))))
                          (SETQ |x| (STRING2ID_N (|queryUser| |msgQ|) 1))
                          (SETQ |x|
                                  (|selectOptionLC| |x|
                                   '(|top| |break| |continue|) NIL))
                          (COND
                           ((NULL |x|)
                            (PROGN
                             (|sayBrightly|
                              (|bright| "  That was not one of your choices!"))
                             (SETQ |gotIt| NIL)))
                           ((EQ |x| '|top|) (|returnToTopLevel|))
                           ((EQ |x| '|break|)
                            (PROGN
                             (SETQ |$BreakMode| '|break|)
                             (|sayBrightly|
                              (CONS "   Enter"
                                    (APPEND (|bright| ":C")
                                            (CONS
                                             "when you are ready to continue processing where you "
                                             (CONS '|%l|
                                                   (CONS
                                                    "   interrupted the system, enter"
                                                    (APPEND (|bright| "(TOP)")
                                                            (CONS
                                                             "when you wish to return"
                                                             (CONS '|%l|
                                                                   (CONS
                                                                    "   to top level."
                                                                    (CONS '|%l|
                                                                          (CONS
                                                                           '|%l|
                                                                           NIL))))))))))))
                             (BREAK)))
                           (#1#
                            (PROGN
                             (|sayBrightly|
                              "   Processing will continue where it was interrupted.")
                             (THROW 'SPAD_READER NIL))))))))))))
            ((EQ |$BreakMode| '|resume|) (|returnToReader|))
            ((EQ |$BreakMode| '|throw_reader|) (THROW 'SPAD_READER NIL))
            ((EQ |$BreakMode| '|quit|) (EXIT-WITH-STATUS 1))
            (#1# (|returnToTopLevel|)))))))

; TOP() == returnToTopLevel()

(DEFUN TOP () (PROG () (RETURN (|returnToTopLevel|))))

; returnToTopLevel() ==
;   TOPLEVEL()

(DEFUN |returnToTopLevel| () (PROG () (RETURN (TOPLEVEL))))

; TOPLEVEL() ==
;     THROW('top_level, 'restart)

(DEFUN TOPLEVEL () (PROG () (RETURN (THROW '|top_level| '|restart|))))

; returnToReader() ==
;   not $ReadingFile => returnToTopLevel()
;   sayBrightly ['"   Continuing to read the file...", '%l]
;   THROW('SPAD_READER, nil)

(DEFUN |returnToReader| ()
  (PROG ()
    (RETURN
     (COND ((NULL |$ReadingFile|) (|returnToTopLevel|))
           ('T
            (PROGN
             (|sayBrightly| (LIST "   Continuing to read the file..." '|%l|))
             (THROW 'SPAD_READER NIL)))))))

; sayErrorly(errorLabel, msg) ==
;   sayErrorly1(errorLabel, msg)

(DEFUN |sayErrorly| (|errorLabel| |msg|)
  (PROG () (RETURN (|sayErrorly1| |errorLabel| |msg|))))

; sayErrorly1(errorLabel, msg) ==
;   sayBrightly '" "
;   if $testingSystem then sayMSG $testingErrorPrefix
;   sayBrightly ['"   >> ",errorLabel,'":"]
;   m := msg
;   msg is ['mathprint, mathexpr] =>
;     mathprint mathexpr
;   sayBrightly msg

(DEFUN |sayErrorly1| (|errorLabel| |msg|)
  (PROG (|m| |ISTMP#1| |mathexpr|)
    (RETURN
     (PROGN
      (|sayBrightly| " ")
      (COND (|$testingSystem| (|sayMSG| |$testingErrorPrefix|)))
      (|sayBrightly| (LIST "   >> " |errorLabel| ":"))
      (SETQ |m| |msg|)
      (COND
       ((AND (CONSP |msg|) (EQ (CAR |msg|) '|mathprint|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |msg|))
              (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                   (PROGN (SETQ |mathexpr| (CAR |ISTMP#1|)) #1='T))))
        (|mathprint| |mathexpr|))
       (#1# (|sayBrightly| |msg|)))))))

; systemError(x) == errorSupervisor($SystemError, x)

(DEFUN |systemError| (|x|)
  (PROG () (RETURN (|errorSupervisor| |$SystemError| |x|))))

; userError x == errorSupervisor($UserError,x)

(DEFUN |userError| (|x|)
  (PROG () (RETURN (|errorSupervisor| |$UserError| |x|))))

; error(x) == errorSupervisor($AlgebraError,x)

(DEFUN |error| (|x|) (PROG () (RETURN (|errorSupervisor| |$AlgebraError| |x|))))

; nice_failure_msg(val, branch, umode) ==
;     uname := devaluate(umode)
;     of1 := coerceUn2E(val, uname);
;     str1 := prefix2String(of1);
;     STRCONC(str1,
;             '" of mode ", outputDomainConstructor(umode),
;               '" cannot be coerced to mode ",
;                 outputDomainConstructor(branch))

(DEFUN |nice_failure_msg| (|val| |branch| |umode|)
  (PROG (|uname| |of1| |str1|)
    (RETURN
     (PROGN
      (SETQ |uname| (|devaluate| |umode|))
      (SETQ |of1| (|coerceUn2E| |val| |uname|))
      (SETQ |str1| (|prefix2String| |of1|))
      (STRCONC |str1| " of mode " (|outputDomainConstructor| |umode|)
       " cannot be coerced to mode " (|outputDomainConstructor| |branch|))))))

; check_union_failure_msg(val, branch, umode) ==
;     got_str1 := false
;     CATCH('top_level, CATCH('SPAD_READER, (
;            str1 := nice_failure_msg(val, branch, umode);
;            got_str1 := true)))
;     got_str1 => str1
;     str1 := MAKE_REASONABLE(STRINGIMAGE(val))
;     STRCONC(str1,
;             '" of mode ", STRINGIMAGE(devaluate(umode)),
;               '" cannot be coerced to mode ",
;                 STRINGIMAGE(devaluate(branch)))

(DEFUN |check_union_failure_msg| (|val| |branch| |umode|)
  (PROG (|got_str1| |str1|)
    (RETURN
     (PROGN
      (SETQ |got_str1| NIL)
      (CATCH '|top_level|
        (CATCH 'SPAD_READER
          (PROGN
           (SETQ |str1| (|nice_failure_msg| |val| |branch| |umode|))
           (SETQ |got_str1| T))))
      (COND (|got_str1| |str1|)
            ('T
             (PROGN
              (SETQ |str1| (MAKE_REASONABLE (STRINGIMAGE |val|)))
              (STRCONC |str1| " of mode " (STRINGIMAGE (|devaluate| |umode|))
               " cannot be coerced to mode "
               (STRINGIMAGE (|devaluate| |branch|))))))))))

; coerce_failure_msg(val, submode, mode) ==
;     check_union_failure_msg(val, submode, mode)

(DEFUN |coerce_failure_msg| (|val| |submode| |mode|)
  (PROG () (RETURN (|check_union_failure_msg| |val| |submode| |mode|))))

; IdentityError(op) ==
;     error(["No identity element for reduce of empty list using operation",op])

(DEFUN |IdentityError| (|op|)
  (PROG ()
    (RETURN
     (|error|
      (LIST '|No identity element for reduce of empty list using operation|
            |op|)))))

; throwMessage(:msg) ==
;   if $compilingMap then clearCache $mapName
;   msg' := mkMessage concatList msg
;   sayMSG msg'
;   if $printMsgsToFile then sayMSG2File msg'
;   spadThrow()

(DEFUN |throwMessage| (&REST |msg|)
  (PROG (|msg'|)
    (RETURN
     (PROGN
      (COND (|$compilingMap| (|clearCache| |$mapName|)))
      (SETQ |msg'| (|mkMessage| (|concatList| |msg|)))
      (|sayMSG| |msg'|)
      (COND (|$printMsgsToFile| (|sayMSG2File| |msg'|)))
      (|spadThrow|)))))
