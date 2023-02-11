
; )package "BOOT"

(IN-PACKAGE "BOOT")

; DEFPARAMETER($cacheMessages, 'T)  -- for debugging purposes

(DEFPARAMETER |$cacheMessages| 'T)

; DEFPARAMETER($testingErrorPrefix, '"Daly Bug")

(DEFPARAMETER |$testingErrorPrefix| "Daly Bug")

; DEFPARAMETER($texFormatting, false)

(DEFPARAMETER |$texFormatting| NIL)

; escape_strings(l) ==
;     ATOM(l) => l
;     res := []
;     for s in l repeat
;         if IDENTP s then s := PNAME s
;         res := cons(s, res)
;         not(STRINGP(s)) => "iterate"
;         #s < 1 => "iterate"
;         s.0 = char "%" =>
;             s1 := STRCONC('"\", s)
;             res := cons(s1, rest(res))
;         #s > 1 and s.0 = char "\" and s.1 = char "%" =>
;             res := cons('"\", rest(res))
;             res := cons(s, res)
;         "iterate"
;     NREVERSE(res)

(DEFUN |escape_strings| (|l|)
  (PROG (|res| |s1|)
    (RETURN
     (COND ((ATOM |l|) |l|)
           (#1='T
            (PROGN
             (SETQ |res| NIL)
             ((LAMBDA (|bfVar#1| |s|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#1|) (PROGN (SETQ |s| (CAR |bfVar#1|)) NIL))
                   (RETURN NIL))
                  (#1#
                   (PROGN
                    (COND ((IDENTP |s|) (SETQ |s| (PNAME |s|))))
                    (SETQ |res| (CONS |s| |res|))
                    (COND ((NULL (STRINGP |s|)) '|iterate|)
                          ((< (LENGTH |s|) 1) '|iterate|)
                          ((EQUAL (ELT |s| 0) (|char| '%))
                           (PROGN
                            (SETQ |s1| (STRCONC "\\" |s|))
                            (SETQ |res| (CONS |s1| (CDR |res|)))))
                          ((AND (< 1 (LENGTH |s|))
                                (EQUAL (ELT |s| 0) (|char| '|\\|))
                                (EQUAL (ELT |s| 1) (|char| '%)))
                           (PROGN
                            (SETQ |res| (CONS "\\" (CDR |res|)))
                            (SETQ |res| (CONS |s| |res|))))
                          (#1# '|iterate|)))))
                 (SETQ |bfVar#1| (CDR |bfVar#1|))))
              |l| NIL)
             (NREVERSE |res|)))))))

; string2Words l ==
;   i := 0
;   [w while wordFrom(l,i) is [w,i]]

(DEFUN |string2Words| (|l|)
  (PROG (|i| |ISTMP#1| |w| |ISTMP#2|)
    (RETURN
     (PROGN
      (SETQ |i| 0)
      ((LAMBDA (|bfVar#2|)
         (LOOP
          (COND
           ((NOT
             (PROGN
              (SETQ |ISTMP#1| (|wordFrom| |l| |i|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |w| (CAR |ISTMP#1|))
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                         (PROGN (SETQ |i| (CAR |ISTMP#2|)) #1='T))))))
            (RETURN (NREVERSE |bfVar#2|)))
           (#1# (SETQ |bfVar#2| (CONS |w| |bfVar#2|))))))
       NIL)))))

; wordFrom(l,i) ==
;   maxIndex := MAXINDEX l
;   k := or/[j for j in i..maxIndex | l.j ~= char ('_ ) ] or return nil
;   k0 := k
;   while k <= maxIndex and (c := l.k) ~= char ('_ ) repeat
;     k := k + 1
;   [SUBSEQ(l, k0, k), k + 1]

(DEFUN |wordFrom| (|l| |i|)
  (PROG (|maxIndex| |k| |k0| |c|)
    (RETURN
     (PROGN
      (SETQ |maxIndex| (MAXINDEX |l|))
      (SETQ |k|
              (OR
               ((LAMBDA (|bfVar#3| |j|)
                  (LOOP
                   (COND ((> |j| |maxIndex|) (RETURN |bfVar#3|))
                         (#1='T
                          (AND (NOT (EQUAL (ELT |l| |j|) (|char| '| |)))
                               (PROGN
                                (SETQ |bfVar#3| |j|)
                                (COND (|bfVar#3| (RETURN |bfVar#3|)))))))
                   (SETQ |j| (+ |j| 1))))
                NIL |i|)
               (RETURN NIL)))
      (SETQ |k0| |k|)
      ((LAMBDA ()
         (LOOP
          (COND
           ((NOT
             (AND (NOT (< |maxIndex| |k|))
                  (NOT (EQUAL (SETQ |c| (ELT |l| |k|)) (|char| '| |)))))
            (RETURN NIL))
           (#1# (SETQ |k| (+ |k| 1)))))))
      (LIST (SUBSEQ |l| |k0| |k|) (+ |k| 1))))))

; DEFPARAMETER($msg_hash, nil)

(DEFPARAMETER |$msg_hash| NIL)

; cacheKeyedMsg1(in_file) ==
;     key := nil
;     line := '""
;     msg := '""
;     repeat
;         line := READ_-LINE(in_file, nil, nil)
;         null(line) =>
;             if key then HPUT($msg_hash, key, msg)
;             -- THROW('DONE, nil)
;             return nil
;         #line = 0 => "iterate"
;         line.0 = char('"S") =>
;             if key then HPUT($msg_hash, key, msg)
;             key := INTERN(line, "BOOT")
;             msg := '""
;         msg := CONCAT(msg, line)

(DEFUN |cacheKeyedMsg1| (|in_file|)
  (PROG (|key| |line| |msg|)
    (RETURN
     (PROGN
      (SETQ |key| NIL)
      (SETQ |line| "")
      (SETQ |msg| "")
      ((LAMBDA ()
         (LOOP
          (COND (NIL (RETURN NIL))
                (#1='T
                 (PROGN
                  (SETQ |line| (READ-LINE |in_file| NIL NIL))
                  (COND
                   ((NULL |line|)
                    (PROGN
                     (COND (|key| (HPUT |$msg_hash| |key| |msg|)))
                     (RETURN NIL)))
                   ((EQL (LENGTH |line|) 0) '|iterate|)
                   ((EQUAL (ELT |line| 0) (|char| "S"))
                    (PROGN
                     (COND (|key| (HPUT |$msg_hash| |key| |msg|)))
                     (SETQ |key| (INTERN |line| 'BOOT))
                     (SETQ |msg| "")))
                   (#1# (SETQ |msg| (CONCAT |msg| |line|))))))))))))))

; cacheKeyedMsg(db_name) ==
;     CATCH('DONE, handle_input_file(db_name, function cacheKeyedMsg1, []))

(DEFUN |cacheKeyedMsg| (|db_name|)
  (PROG ()
    (RETURN
     (CATCH 'DONE (|handle_input_file| |db_name| #'|cacheKeyedMsg1| NIL)))))

; getKeyedMsg(key) ==
;     if not($msg_hash) then
;         $msg_hash := MAKE_HASHTABLE('ID)
;         cacheKeyedMsg($defaultMsgDatabaseName)
;     HGET($msg_hash, key)

(DEFUN |getKeyedMsg| (|key|)
  (PROG ()
    (RETURN
     (PROGN
      (COND
       ((NULL |$msg_hash|) (SETQ |$msg_hash| (MAKE_HASHTABLE 'ID))
        (|cacheKeyedMsg| |$defaultMsgDatabaseName|)))
      (HGET |$msg_hash| |key|)))))

; segmentKeyedMsg(msg) == string2Words msg

(DEFUN |segmentKeyedMsg| (|msg|) (PROG () (RETURN (|string2Words| |msg|))))

; segmentedMsgPreprocess x ==
;   ATOM x => x
;   [head,:tail] := x
;   center := rightJust := NIL
;   if head in '(%ceon "%ceon") then center := true
;   if head in '(%rjon "%rjon") then rightJust := true
;   center or rightJust =>
;     -- start collecting terms
;     y := NIL
;     ok := true
;     while tail and ok repeat
;       [t,:tail] := tail
;       t in '(%ceoff "%ceoff" %rjoff "%rjoff") => ok := NIL
;       y := CONS(segmentedMsgPreprocess t,y)
;     head1 := [(center => '"%ce"; '"%rj"),:NREVERSE y]
;     NULL tail => [head1]
;     [head1,:segmentedMsgPreprocess tail]
;   head1 := segmentedMsgPreprocess head
;   tail1 := segmentedMsgPreprocess tail
;   EQ(head,head1) and EQ(tail,tail1) => x
;   [head1,:tail1]

(DEFUN |segmentedMsgPreprocess| (|x|)
  (PROG (|head| |tail| |rightJust| |center| |y| |ok| |LETTMP#1| |t| |head1|
         |tail1|)
    (RETURN
     (COND ((ATOM |x|) |x|)
           (#1='T
            (PROGN
             (SETQ |head| (CAR |x|))
             (SETQ |tail| (CDR |x|))
             (SETQ |center| (SETQ |rightJust| NIL))
             (COND ((|member| |head| '(|%ceon| "%ceon")) (SETQ |center| T)))
             (COND ((|member| |head| '(|%rjon| "%rjon")) (SETQ |rightJust| T)))
             (COND
              ((OR |center| |rightJust|)
               (PROGN
                (SETQ |y| NIL)
                (SETQ |ok| T)
                ((LAMBDA ()
                   (LOOP
                    (COND ((NOT (AND |tail| |ok|)) (RETURN NIL))
                          (#1#
                           (PROGN
                            (SETQ |LETTMP#1| |tail|)
                            (SETQ |t| (CAR |LETTMP#1|))
                            (SETQ |tail| (CDR |LETTMP#1|))
                            (COND
                             ((|member| |t|
                               '(|%ceoff| "%ceoff" |%rjoff| "%rjoff"))
                              (SETQ |ok| NIL))
                             (#1#
                              (SETQ |y|
                                      (CONS (|segmentedMsgPreprocess| |t|)
                                            |y|))))))))))
                (SETQ |head1|
                        (CONS (COND (|center| "%ce") (#1# "%rj"))
                              (NREVERSE |y|)))
                (COND ((NULL |tail|) (LIST |head1|))
                      (#1# (CONS |head1| (|segmentedMsgPreprocess| |tail|))))))
              (#1#
               (PROGN
                (SETQ |head1| (|segmentedMsgPreprocess| |head|))
                (SETQ |tail1| (|segmentedMsgPreprocess| |tail|))
                (COND ((AND (EQ |head| |head1|) (EQ |tail| |tail1|)) |x|)
                      (#1# (CONS |head1| |tail1|))))))))))))

; removeAttributes msg ==
;     --takes a segmented message and returns it with the attributes
;     --separted.
;     first msg ~= '"%atbeg" =>
;         [msg,NIL]
;     attList := []
;     until item = '"%atend" repeat
;         msg     := rest  msg
;         item    := first msg
;         attList := [INTERN item,:attList]
;     msg := rest msg
;     attList := rest attList
;     [msg,attList]

(DEFUN |removeAttributes| (|msg|)
  (PROG (|attList| |item|)
    (RETURN
     (COND ((NOT (EQUAL (CAR |msg|) "%atbeg")) (LIST |msg| NIL))
           (#1='T
            (PROGN
             (SETQ |attList| NIL)
             ((LAMBDA (|bfVar#4|)
                (LOOP
                 (COND (|bfVar#4| (RETURN NIL))
                       (#1#
                        (PROGN
                         (SETQ |msg| (CDR |msg|))
                         (SETQ |item| (CAR |msg|))
                         (SETQ |attList| (CONS (INTERN |item|) |attList|)))))
                 (SETQ |bfVar#4| (EQUAL |item| "%atend"))))
              NIL)
             (SETQ |msg| (CDR |msg|))
             (SETQ |attList| (CDR |attList|))
             (LIST |msg| |attList|)))))))

; substituteSegmentedMsg(msg,args) ==
;   -- this does substitution of the parameters
;   l := NIL
;   nargs := #args
;   for x in segmentedMsgPreprocess msg repeat
;     -- x is a list
;     PAIRP x =>
;       l := cons(substituteSegmentedMsg(x,args),l)
;     c := x.0
;     n := STRINGLENGTH x
;
;     -- x requires parameter substitution
;     (x.0 = char "%") and (n > 1) and (DIGITP x.1) =>
;       a := DIG2FIX x.1
;       arg :=
;         a <= nargs => args.(a-1)
;         '"???"
;       -- now pull out qualifiers
;       q := NIL
;       for i in 2..(n-1) repeat q := cons(x.i,q)
;       -- Note 'f processing must come first.
;       if MEMQ(char 'f,q) then
;           arg :=
;               PAIRP arg => APPLY(first arg, rest arg)
;               arg
;       if MEMQ(char 'm,q) then arg := [['"%m",:arg]]
;       if MEMQ(char 's,q) then arg := [['"%s",:arg]]
;       if MEMQ(char 'p,q) then
;           arg := escape_strings(prefix2String arg)
;       if MEMQ(char 'P,q) then
;           arg := [prefix2String x for x in arg]
;
;       if MEMQ(char 'c,q) then arg := [['"%ce",:arg]]
;       if MEMQ(char 'r,q) then arg := [['"%rj",:arg]]
;
;       if MEMQ(char 'l,q) then l := cons('"%l",l)
;       if MEMQ(char 'b,q) then l := cons('"%b",l)
;       --we splice in arguments that are lists
;       --if y is not specified, then the adding of blanks is
;       --stifled after the first item in the list until the
;       --end of the list. (using %n and %y)
;       l :=
;          PAIRP(arg) =>
;            MEMQ(char 'y, q) or (first arg = '"%y") or ((LENGTH arg) = 1)  =>
;              APPEND(REVERSE arg, l)
;            head := first arg
;            tail := rest arg
;            ['"%y",:APPEND(REVERSE tail, ['"%n",head,:l ]) ]
;          cons(arg,l)
;       if MEMQ(char 'b,q) then l := cons('"%d",l)
;       for ch in '(_. _, _! _: _; _?) repeat
;         if MEMQ(char ch,q) then l := cons(ch,l)
;
;     --x is a plain word
;     l := cons(x,l)
;   addBlanks NREVERSE l

(DEFUN |substituteSegmentedMsg| (|msg| |args|)
  (PROG (|l| |nargs| |c| |n| |a| |arg| |q| |head| |tail|)
    (RETURN
     (PROGN
      (SETQ |l| NIL)
      (SETQ |nargs| (LENGTH |args|))
      ((LAMBDA (|bfVar#5| |x|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#5|) (PROGN (SETQ |x| (CAR |bfVar#5|)) NIL))
            (RETURN NIL))
           (#1='T
            (COND
             ((CONSP |x|)
              (SETQ |l| (CONS (|substituteSegmentedMsg| |x| |args|) |l|)))
             (#1#
              (PROGN
               (SETQ |c| (ELT |x| 0))
               (SETQ |n| (STRINGLENGTH |x|))
               (COND
                ((AND (EQUAL (ELT |x| 0) (|char| '%)) (< 1 |n|)
                      (DIGITP (ELT |x| 1)))
                 (PROGN
                  (SETQ |a| (DIG2FIX (ELT |x| 1)))
                  (SETQ |arg|
                          (COND ((NOT (< |nargs| |a|)) (ELT |args| (- |a| 1)))
                                (#1# "???")))
                  (SETQ |q| NIL)
                  ((LAMBDA (|bfVar#6| |i|)
                     (LOOP
                      (COND ((> |i| |bfVar#6|) (RETURN NIL))
                            (#1# (SETQ |q| (CONS (ELT |x| |i|) |q|))))
                      (SETQ |i| (+ |i| 1))))
                   (- |n| 1) 2)
                  (COND
                   ((MEMQ (|char| '|f|) |q|)
                    (SETQ |arg|
                            (COND
                             ((CONSP |arg|) (APPLY (CAR |arg|) (CDR |arg|)))
                             (#1# |arg|)))))
                  (COND
                   ((MEMQ (|char| '|m|) |q|)
                    (SETQ |arg| (LIST (CONS "%m" |arg|)))))
                  (COND
                   ((MEMQ (|char| '|s|) |q|)
                    (SETQ |arg| (LIST (CONS "%s" |arg|)))))
                  (COND
                   ((MEMQ (|char| '|p|) |q|)
                    (SETQ |arg| (|escape_strings| (|prefix2String| |arg|)))))
                  (COND
                   ((MEMQ (|char| 'P) |q|)
                    (SETQ |arg|
                            ((LAMBDA (|bfVar#8| |bfVar#7| |x|)
                               (LOOP
                                (COND
                                 ((OR (ATOM |bfVar#7|)
                                      (PROGN (SETQ |x| (CAR |bfVar#7|)) NIL))
                                  (RETURN (NREVERSE |bfVar#8|)))
                                 (#1#
                                  (SETQ |bfVar#8|
                                          (CONS (|prefix2String| |x|)
                                                |bfVar#8|))))
                                (SETQ |bfVar#7| (CDR |bfVar#7|))))
                             NIL |arg| NIL))))
                  (COND
                   ((MEMQ (|char| '|c|) |q|)
                    (SETQ |arg| (LIST (CONS "%ce" |arg|)))))
                  (COND
                   ((MEMQ (|char| '|r|) |q|)
                    (SETQ |arg| (LIST (CONS "%rj" |arg|)))))
                  (COND ((MEMQ (|char| '|l|) |q|) (SETQ |l| (CONS "%l" |l|))))
                  (COND ((MEMQ (|char| '|b|) |q|) (SETQ |l| (CONS "%b" |l|))))
                  (SETQ |l|
                          (COND
                           ((CONSP |arg|)
                            (COND
                             ((OR (MEMQ (|char| '|y|) |q|)
                                  (EQUAL (CAR |arg|) "%y")
                                  (EQL (LENGTH |arg|) 1))
                              (APPEND (REVERSE |arg|) |l|))
                             (#1#
                              (PROGN
                               (SETQ |head| (CAR |arg|))
                               (SETQ |tail| (CDR |arg|))
                               (CONS "%y"
                                     (APPEND (REVERSE |tail|)
                                             (CONS "%n"
                                                   (CONS |head| |l|))))))))
                           (#1# (CONS |arg| |l|))))
                  (COND ((MEMQ (|char| '|b|) |q|) (SETQ |l| (CONS "%d" |l|))))
                  ((LAMBDA (|bfVar#9| |ch|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#9|)
                            (PROGN (SETQ |ch| (CAR |bfVar#9|)) NIL))
                        (RETURN NIL))
                       (#1#
                        (COND
                         ((MEMQ (|char| |ch|) |q|)
                          (SETQ |l| (CONS |ch| |l|))))))
                      (SETQ |bfVar#9| (CDR |bfVar#9|))))
                   '(|.| |,| ! |:| |;| ?) NIL)))
                (#1# (SETQ |l| (CONS |x| |l|)))))))))
          (SETQ |bfVar#5| (CDR |bfVar#5|))))
       (|segmentedMsgPreprocess| |msg|) NIL)
      (|addBlanks| (NREVERSE |l|))))))

; addBlanks msg ==
;   -- adds proper blanks
;   null PAIRP msg => msg
;   null msg => msg
;   LENGTH msg = 1 => msg
;   blanksOff := false
;   x := first msg
;   if x = '"%n" then
;     blanksOff := true
;     msg1 := []
;   else
;     msg1 := LIST x
;   blank := '" "
;   for y in rest msg repeat
;     y in '("%n" %n) => blanksOff := true
;     y in '("%y" %y) => blanksOff  := false
;     if noBlankAfterP x or noBlankBeforeP y or blanksOff then
;        msg1 := [y,:msg1]
;     else
;        msg1 := [y,blank,:msg1]
;     x := y
;   NREVERSE msg1

(DEFUN |addBlanks| (|msg|)
  (PROG (|blanksOff| |x| |msg1| |blank|)
    (RETURN
     (COND ((NULL (CONSP |msg|)) |msg|) ((NULL |msg|) |msg|)
           ((EQL (LENGTH |msg|) 1) |msg|)
           (#1='T
            (PROGN
             (SETQ |blanksOff| NIL)
             (SETQ |x| (CAR |msg|))
             (COND ((EQUAL |x| "%n") (SETQ |blanksOff| T) (SETQ |msg1| NIL))
                   (#1# (SETQ |msg1| (LIST |x|))))
             (SETQ |blank| " ")
             ((LAMBDA (|bfVar#10| |y|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#10|)
                       (PROGN (SETQ |y| (CAR |bfVar#10|)) NIL))
                   (RETURN NIL))
                  (#1#
                   (COND ((|member| |y| '("%n" |%n|)) (SETQ |blanksOff| T))
                         ((|member| |y| '("%y" |%y|)) (SETQ |blanksOff| NIL))
                         (#1#
                          (PROGN
                           (COND
                            ((OR (|noBlankAfterP| |x|) (|noBlankBeforeP| |y|)
                                 |blanksOff|)
                             (SETQ |msg1| (CONS |y| |msg1|)))
                            (#1#
                             (SETQ |msg1| (CONS |y| (CONS |blank| |msg1|)))))
                           (SETQ |x| |y|))))))
                 (SETQ |bfVar#10| (CDR |bfVar#10|))))
              (CDR |msg|) NIL)
             (NREVERSE |msg1|)))))))

; DEFPARAMETER($msgdbPrims, '( %b %d %l %i %u %U %n %x %ce %rj "%U" "%b" "%d" "%l" "%i" "%u" "%U" "%n" "%x" "%ce" "%rj"))

(DEFPARAMETER |$msgdbPrims|
  '(|%b| |%d| |%l| |%i| |%u| %U |%n| |%x| |%ce| |%rj| "%U" "%b" "%d" "%l" "%i"
    "%u" "%U" "%n" "%x" "%ce" "%rj"))

; DEFPARAMETER($msgdbPunct, '(_. _, _! _: _; _] _)  "." "," "!" ":" ";" "]" ")"  ))

(DEFPARAMETER |$msgdbPunct|
  '(|.| |,| ! |:| |;| ] |)| "." "," "!" ":" ";" "]" ")"))

; DEFPARAMETER($msgdbNoBlanksBeforeGroup, ['" ", " ", '"%", "%",_
;                             :$msgdbPrims, :$msgdbPunct])

(DEFPARAMETER |$msgdbNoBlanksBeforeGroup|
  (CONS " "
        (CONS '| | (CONS "%" (CONS '% (APPEND |$msgdbPrims| |$msgdbPunct|))))))

; DEFPARAMETER($msgdbListPrims, '(%m %s %ce %rj "%m" "%s" "%ce" "%rj"))

(DEFPARAMETER |$msgdbListPrims| '(|%m| |%s| |%ce| |%rj| "%m" "%s" "%ce" "%rj"))

; noBlankBeforeP word==
;     INTEGERP word => false
;     word in $msgdbNoBlanksBeforeGroup => true
;     if STRINGP word and SIZE word > 1 then
;        word.0 = char '% and word.1 = char 'x => return true
;        word.0 = char " " => return true
;     (PAIRP word) and (first word in $msgdbListPrims) => true
;     false

(DEFUN |noBlankBeforeP| (|word|)
  (PROG ()
    (RETURN
     (COND ((INTEGERP |word|) NIL)
           ((|member| |word| |$msgdbNoBlanksBeforeGroup|) T)
           (#1='T
            (PROGN
             (COND
              ((AND (STRINGP |word|) (< 1 (SIZE |word|)))
               (COND
                ((AND (EQUAL (ELT |word| 0) (|char| '%))
                      (EQUAL (ELT |word| 1) (|char| '|x|)))
                 (RETURN T))
                ((EQUAL (ELT |word| 0) (|char| '| |)) (RETURN T)))))
             (COND
              ((AND (CONSP |word|) (|member| (CAR |word|) |$msgdbListPrims|))
               T)
              (#1# NIL))))))))

; $msgdbPunct := '(_[ _(  "[" "(" )

(EVAL-WHEN (EVAL LOAD) (SETQ |$msgdbPunct| '([ |(| "[" "(")))

; DEFPARAMETER($msgdbNoBlanksAfterGroup, ['" ", " ",'"%" ,"%",_
;                           :$msgdbPrims,:$msgdbPunct])

(DEFPARAMETER |$msgdbNoBlanksAfterGroup|
  (CONS " "
        (CONS '| | (CONS "%" (CONS '% (APPEND |$msgdbPrims| |$msgdbPunct|))))))

; noBlankAfterP word==
;     INTEGERP word => false
;     word in $msgdbNoBlanksAfterGroup => true
;     if STRINGP word and (s := SIZE word) > 1 then
;        word.0 = char '% and word.1 = char 'x => return true
;        word.(s-1) = char " " => return true
;     (PAIRP word) and (first word in $msgdbListPrims) => true
;     false

(DEFUN |noBlankAfterP| (|word|)
  (PROG (|s|)
    (RETURN
     (COND ((INTEGERP |word|) NIL)
           ((|member| |word| |$msgdbNoBlanksAfterGroup|) T)
           (#1='T
            (PROGN
             (COND
              ((AND (STRINGP |word|) (< 1 (SETQ |s| (SIZE |word|))))
               (COND
                ((AND (EQUAL (ELT |word| 0) (|char| '%))
                      (EQUAL (ELT |word| 1) (|char| '|x|)))
                 (RETURN T))
                ((EQUAL (ELT |word| (- |s| 1)) (|char| '| |)) (RETURN T)))))
             (COND
              ((AND (CONSP |word|) (|member| (CAR |word|) |$msgdbListPrims|))
               T)
              (#1# NIL))))))))

; cleanUpSegmentedMsg msg ==
;   -- removes any junk like double blanks
;   -- takes a reversed msg and puts it in the correct order
;   null PAIRP msg => msg
;   blanks := ['" "," "]
;   haveBlank := NIL
;   prims :=
;     '(%b %d %l %i %u %m %ce %rj _
;      "%b" "%d" "%l" "%i" "%m" "%u" "%ce" "%rj")
;   msg1 := NIL
;   for x in msg repeat
;     if haveBlank and ((x in blanks) or (x in prims)) then
;       msg1 := rest msg1
;     msg1 := cons(x,msg1)
;     haveBlank := (x in blanks => true; NIL)
;   msg1

(DEFUN |cleanUpSegmentedMsg| (|msg|)
  (PROG (|blanks| |haveBlank| |prims| |msg1|)
    (RETURN
     (COND ((NULL (CONSP |msg|)) |msg|)
           (#1='T
            (PROGN
             (SETQ |blanks| (LIST " " '| |))
             (SETQ |haveBlank| NIL)
             (SETQ |prims|
                     '(|%b| |%d| |%l| |%i| |%u| |%m| |%ce| |%rj| "%b" "%d" "%l"
                       "%i" "%m" "%u" "%ce" "%rj"))
             (SETQ |msg1| NIL)
             ((LAMBDA (|bfVar#11| |x|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#11|)
                       (PROGN (SETQ |x| (CAR |bfVar#11|)) NIL))
                   (RETURN NIL))
                  (#1#
                   (PROGN
                    (COND
                     ((AND |haveBlank|
                           (OR (|member| |x| |blanks|) (|member| |x| |prims|)))
                      (SETQ |msg1| (CDR |msg1|))))
                    (SETQ |msg1| (CONS |x| |msg1|))
                    (SETQ |haveBlank|
                            (COND ((|member| |x| |blanks|) T) (#1# NIL))))))
                 (SETQ |bfVar#11| (CDR |bfVar#11|))))
              |msg| NIL)
             |msg1|))))))

; operationLink name ==
;   FORMAT(nil, '"\lispLink{\verb!(|oSearch| _"~a_")!}{~a}",
;          name,
;          escapeSpecialChars STRINGIMAGE name)

(DEFUN |operationLink| (|name|)
  (PROG ()
    (RETURN
     (FORMAT NIL "\\lispLink{\\verb!(|oSearch| \"~a\")!}{~a}" |name|
             (|escapeSpecialChars| (STRINGIMAGE |name|))))))

; sayPatternMsg(msg,args) ==
;   ioHook("startPatternMsg", msg, args)
;   msg := segmentKeyedMsg msg
;   msg := substituteSegmentedMsg(msg,args)
;   sayMSG flowSegmentedMsg(msg,$LINELENGTH,3)
;   ioHook("endPatternMsg", msg)

(DEFUN |sayPatternMsg| (|msg| |args|)
  (PROG ()
    (RETURN
     (PROGN
      (|ioHook| '|startPatternMsg| |msg| |args|)
      (SETQ |msg| (|segmentKeyedMsg| |msg|))
      (SETQ |msg| (|substituteSegmentedMsg| |msg| |args|))
      (|sayMSG| (|flowSegmentedMsg| |msg| $LINELENGTH 3))
      (|ioHook| '|endPatternMsg| |msg|)))))

; throwPatternMsg(key,args) ==
;   sayMSG '" "
;   if $testingSystem then sayMSG $testingErrorPrefix
;   sayPatternMsg(key,args)
;   spadThrow()

(DEFUN |throwPatternMsg| (|key| |args|)
  (PROG ()
    (RETURN
     (PROGN
      (|sayMSG| " ")
      (COND (|$testingSystem| (|sayMSG| |$testingErrorPrefix|)))
      (|sayPatternMsg| |key| |args|)
      (|spadThrow|)))))

; say_msg(msg, args) ==
;     ioHook("say_msg", msg, args)
;     say_msg_local(msg, args)
;     ioHook("end_say_msg", msg)

(DEFUN |say_msg| (|msg| |args|)
  (PROG ()
    (RETURN
     (PROGN
      (|ioHook| '|say_msg| |msg| |args|)
      (|say_msg_local| |msg| |args|)
      (|ioHook| '|end_say_msg| |msg|)))))

; throw_msg(msg, args) ==
;     sayMSG '" "
;     if $testingSystem then sayMSG $testingErrorPrefix
;     say_Msg(msg, args)
;     spadThrow()

(DEFUN |throw_msg| (|msg| |args|)
  (PROG ()
    (RETURN
     (PROGN
      (|sayMSG| " ")
      (COND (|$testingSystem| (|sayMSG| |$testingErrorPrefix|)))
      (|say_Msg| |msg| |args|)
      (|spadThrow|)))))

; sayKeyedMsg(key,args) ==
;   $texFormatting: fluid := false
;   ioHook("startKeyedMsg", key, args)
;   say_msg_local(getKeyedMsg key, args)
;   ioHook("endOfKeyedMsg", key)

(DEFUN |sayKeyedMsg| (|key| |args|)
  (PROG (|$texFormatting|)
    (DECLARE (SPECIAL |$texFormatting|))
    (RETURN
     (PROGN
      (SETQ |$texFormatting| NIL)
      (|ioHook| '|startKeyedMsg| |key| |args|)
      (|say_msg_local| (|getKeyedMsg| |key|) |args|)
      (|ioHook| '|endOfKeyedMsg| |key|)))))

; say_msg_local(msg, args) ==
;   msg := segmentKeyedMsg msg
;   msg := substituteSegmentedMsg(msg,args)
;   msg' := flowSegmentedMsg(msg,$LINELENGTH,$MARGIN)
;   if $printMsgsToFile then sayMSG2File msg'
;   sayMSG msg'

(DEFUN |say_msg_local| (|msg| |args|)
  (PROG (|msg'|)
    (RETURN
     (PROGN
      (SETQ |msg| (|segmentKeyedMsg| |msg|))
      (SETQ |msg| (|substituteSegmentedMsg| |msg| |args|))
      (SETQ |msg'| (|flowSegmentedMsg| |msg| $LINELENGTH $MARGIN))
      (COND (|$printMsgsToFile| (|sayMSG2File| |msg'|)))
      (|sayMSG| |msg'|)))))

; throwKeyedErrorMsg(kind,key,args) ==
;   sayMSG '" "
;   if $testingSystem then sayMSG $testingErrorPrefix
;   sayKeyedMsg(key,args)
;   spadThrow()

(DEFUN |throwKeyedErrorMsg| (|kind| |key| |args|)
  (PROG ()
    (RETURN
     (PROGN
      (|sayMSG| " ")
      (COND (|$testingSystem| (|sayMSG| |$testingErrorPrefix|)))
      (|sayKeyedMsg| |key| |args|)
      (|spadThrow|)))))

; throwKeyedMsgSP(key,args,atree) ==
;     if atree and (sp := getSrcPos(atree)) then
;         sayMSG '" "
;         srcPosDisplay(sp)
;     throwKeyedMsg(key,args)

(DEFUN |throwKeyedMsgSP| (|key| |args| |atree|)
  (PROG (|sp|)
    (RETURN
     (PROGN
      (COND
       ((AND |atree| (SETQ |sp| (|getSrcPos| |atree|))) (|sayMSG| " ")
        (|srcPosDisplay| |sp|)))
      (|throwKeyedMsg| |key| |args|)))))

; throwKeyedMsg(key,args) ==
;   throwKeyedMsg1(key, args)

(DEFUN |throwKeyedMsg| (|key| |args|)
  (PROG () (RETURN (|throwKeyedMsg1| |key| |args|))))

; throwKeyedMsg1(key,args) ==
;   sayMSG '" "
;   if $testingSystem then sayMSG $testingErrorPrefix
;   sayKeyedMsg(key,args)
;   spadThrow()

(DEFUN |throwKeyedMsg1| (|key| |args|)
  (PROG ()
    (RETURN
     (PROGN
      (|sayMSG| " ")
      (COND (|$testingSystem| (|sayMSG| |$testingErrorPrefix|)))
      (|sayKeyedMsg| |key| |args|)
      (|spadThrow|)))))

; throwListOfKeyedMsgs(descKey,descArgs,l) ==
;   -- idea is that descKey and descArgs are the message describing
;   -- what the list is about and l is a list of [key,args] messages
;   -- the messages in the list are numbered and should have a %1 as
;   -- the first token in the message text.
;   sayMSG '" "
;   if $testingSystem then sayMSG $testingErrorPrefix
;   sayKeyedMsg(descKey,descArgs)
;   sayMSG '" "
;   for [key,args] in l for i in 1.. repeat
;     n := STRCONC(object2String i,'".")
;     sayKeyedMsg(key,[n,:args])
;   spadThrow()

(DEFUN |throwListOfKeyedMsgs| (|descKey| |descArgs| |l|)
  (PROG (|key| |ISTMP#1| |args| |n|)
    (RETURN
     (PROGN
      (|sayMSG| " ")
      (COND (|$testingSystem| (|sayMSG| |$testingErrorPrefix|)))
      (|sayKeyedMsg| |descKey| |descArgs|)
      (|sayMSG| " ")
      ((LAMBDA (|bfVar#13| |bfVar#12| |i|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#13|)
                (PROGN (SETQ |bfVar#12| (CAR |bfVar#13|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#12|)
                 (PROGN
                  (SETQ |key| (CAR |bfVar#12|))
                  (SETQ |ISTMP#1| (CDR |bfVar#12|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                       (PROGN (SETQ |args| (CAR |ISTMP#1|)) #1#)))
                 (PROGN
                  (SETQ |n| (STRCONC (|object2String| |i|) "."))
                  (|sayKeyedMsg| |key| (CONS |n| |args|))))))
          (SETQ |bfVar#13| (CDR |bfVar#13|))
          (SETQ |i| (+ |i| 1))))
       |l| NIL 1)
      (|spadThrow|)))))

; breakKeyedMsg(key,args) ==
;   BUMPCOMPERRORCOUNT()
;   sayKeyedMsg(key,args)
;   handleLispBreakLoop($BreakMode)

(DEFUN |breakKeyedMsg| (|key| |args|)
  (PROG ()
    (RETURN
     (PROGN
      (BUMPCOMPERRORCOUNT)
      (|sayKeyedMsg| |key| |args|)
      (|handleLispBreakLoop| |$BreakMode|)))))

; keyedSystemError(key,args) ==
;   keyedSystemError1(key, args)

(DEFUN |keyedSystemError| (|key| |args|)
  (PROG () (RETURN (|keyedSystemError1| |key| |args|))))

; keyedSystemError1(key,args) ==
;   sayKeyedMsg("S2GE0000",NIL)
;   breakKeyedMsg(key,args)

(DEFUN |keyedSystemError1| (|key| |args|)
  (PROG ()
    (RETURN
     (PROGN (|sayKeyedMsg| 'S2GE0000 NIL) (|breakKeyedMsg| |key| |args|)))))

; systemErrorHere functionName ==
;   keyedSystemError("S2GE0017",[functionName])

(DEFUN |systemErrorHere| (|functionName|)
  (PROG () (RETURN (|keyedSystemError| 'S2GE0017 (LIST |functionName|)))))

; queryUserKeyedMsg(key,args) ==
;   -- display message and return reply
;   conStream := get_console_input()
;   sayKeyedMsg(key,args)
;   ioHook("startQueryUser")
;   ans := read_line conStream
;   ioHook("endOfQueryUser")
;   ans

(DEFUN |queryUserKeyedMsg| (|key| |args|)
  (PROG (|conStream| |ans|)
    (RETURN
     (PROGN
      (SETQ |conStream| (|get_console_input|))
      (|sayKeyedMsg| |key| |args|)
      (|ioHook| '|startQueryUser|)
      (SETQ |ans| (|read_line| |conStream|))
      (|ioHook| '|endOfQueryUser|)
      |ans|))))

; flowSegmentedMsg(msg, len, offset) ==
;   -- tries to break a sayBrightly-type input msg into multiple
;   -- lines, with offset and given length.
;   -- msgs that are entirely centered or right justified are not flowed
;   msg is [[ce,:.]] and ce in '(%ce "%ce" %rj "%rj") => msg
;
;   -- msgs that are entirely centered are not flowed
;   msg is [[ce, :.]] and ce in '(%ce "%ce") => msg
;
;   potentialMarg := 0
;   actualMarg    := 0
;
;   off := (offset <= 0 => '""; fillerSpaces(offset,'" "))
;   off1:= (offset <= 1 => '""; fillerSpaces(offset-1,'" "))
;   firstLine := true
;
;   PAIRP msg =>
;     lnl := offset
;     if msg is [a,:.] and a in '(%b %d _  "%b" "%d" " ") then
;       nl :=  [off1]
;       lnl := lnl - 1
;     else nl := [off]
;     for f in msg repeat
;       f in '("%l" %l) =>
;         actualMarg := potentialMarg
;         if lnl = 99999 then nl := ['%l,:nl]
;         lnl := 99999
;       PAIRP(f) and first(f) in '("%m" %m '%ce "%ce" %rj "%rj") =>
;         actualMarg := potentialMarg
;         nl := [f,'%l,:nl]
;         lnl := 199999
;       f in '("%i" %i ) =>
;         potentialMarg := potentialMarg + 3
;         nl := [f,:nl]
;       PAIRP(f) and first(f) in '("%t" %t) =>
;         potentialMarg := potentialMarg + rest f
;         nl := [f,:nl]
;       sbl := sayBrightlyLength f
;       tot := lnl + offset + sbl + actualMarg
;       if firstLine then
;         firstLine  := false
;         offset := offset + offset
;         off1   := STRCONC(off, off1)
;         off    := STRCONC(off, off)
;       if (tot <= len) or (sbl = 1 and tot = len) then
;         nl := [f,:nl]
;         lnl := lnl + sbl
;       else
;         f in '(%b %d _  "%b" "%d" " ") =>
;           nl := [f,off1,'%l,:nl]
;           actualMarg := potentialMarg
;           lnl := -1 + offset + sbl
;         nl := [f,off,'%l,:nl]
;         lnl := offset + sbl
;     concat nreverse nl
;   concat('%l,off,msg)

(DEFUN |flowSegmentedMsg| (|msg| |len| |offset|)
  (PROG (|ISTMP#1| |ce| |potentialMarg| |actualMarg| |off| |off1| |firstLine|
         |lnl| |a| |nl| |sbl| |tot|)
    (RETURN
     (COND
      ((AND (CONSP |msg|) (EQ (CDR |msg|) NIL)
            (PROGN
             (SETQ |ISTMP#1| (CAR |msg|))
             (AND (CONSP |ISTMP#1|) (PROGN (SETQ |ce| (CAR |ISTMP#1|)) #1='T)))
            (|member| |ce| '(|%ce| "%ce" |%rj| "%rj")))
       |msg|)
      ((AND (CONSP |msg|) (EQ (CDR |msg|) NIL)
            (PROGN
             (SETQ |ISTMP#1| (CAR |msg|))
             (AND (CONSP |ISTMP#1|) (PROGN (SETQ |ce| (CAR |ISTMP#1|)) #1#)))
            (|member| |ce| '(|%ce| "%ce")))
       |msg|)
      (#1#
       (PROGN
        (SETQ |potentialMarg| 0)
        (SETQ |actualMarg| 0)
        (SETQ |off|
                (COND ((NOT (< 0 |offset|)) "")
                      (#1# (|fillerSpaces| |offset| " "))))
        (SETQ |off1|
                (COND ((NOT (< 1 |offset|)) "")
                      (#1# (|fillerSpaces| (- |offset| 1) " "))))
        (SETQ |firstLine| T)
        (COND
         ((CONSP |msg|)
          (PROGN
           (SETQ |lnl| |offset|)
           (COND
            ((AND (CONSP |msg|) (PROGN (SETQ |a| (CAR |msg|)) #1#)
                  (|member| |a| '(|%b| |%d| | | "%b" "%d" " ")))
             (SETQ |nl| (LIST |off1|)) (SETQ |lnl| (- |lnl| 1)))
            (#1# (SETQ |nl| (LIST |off|))))
           ((LAMBDA (|bfVar#14| |f|)
              (LOOP
               (COND
                ((OR (ATOM |bfVar#14|) (PROGN (SETQ |f| (CAR |bfVar#14|)) NIL))
                 (RETURN NIL))
                (#1#
                 (COND
                  ((|member| |f| '("%l" |%l|))
                   (PROGN
                    (SETQ |actualMarg| |potentialMarg|)
                    (COND ((EQL |lnl| 99999) (SETQ |nl| (CONS '|%l| |nl|))))
                    (SETQ |lnl| 99999)))
                  ((AND (CONSP |f|)
                        (|member| (CAR |f|)
                         '("%m" |%m| '|%ce| "%ce" |%rj| "%rj")))
                   (PROGN
                    (SETQ |actualMarg| |potentialMarg|)
                    (SETQ |nl| (CONS |f| (CONS '|%l| |nl|)))
                    (SETQ |lnl| 199999)))
                  ((|member| |f| '("%i" |%i|))
                   (PROGN
                    (SETQ |potentialMarg| (+ |potentialMarg| 3))
                    (SETQ |nl| (CONS |f| |nl|))))
                  ((AND (CONSP |f|) (|member| (CAR |f|) '("%t" |%t|)))
                   (PROGN
                    (SETQ |potentialMarg| (+ |potentialMarg| (CDR |f|)))
                    (SETQ |nl| (CONS |f| |nl|))))
                  (#1#
                   (PROGN
                    (SETQ |sbl| (|sayBrightlyLength| |f|))
                    (SETQ |tot| (+ (+ (+ |lnl| |offset|) |sbl|) |actualMarg|))
                    (COND
                     (|firstLine| (SETQ |firstLine| NIL)
                      (SETQ |offset| (+ |offset| |offset|))
                      (SETQ |off1| (STRCONC |off| |off1|))
                      (SETQ |off| (STRCONC |off| |off|))))
                    (COND
                     ((OR (NOT (< |len| |tot|))
                          (AND (EQL |sbl| 1) (EQUAL |tot| |len|)))
                      (SETQ |nl| (CONS |f| |nl|)) (SETQ |lnl| (+ |lnl| |sbl|)))
                     ((|member| |f| '(|%b| |%d| | | "%b" "%d" " "))
                      (PROGN
                       (SETQ |nl| (CONS |f| (CONS |off1| (CONS '|%l| |nl|))))
                       (SETQ |actualMarg| |potentialMarg|)
                       (SETQ |lnl| (+ (+ (- 1) |offset|) |sbl|))))
                     (#1#
                      (PROGN
                       (SETQ |nl| (CONS |f| (CONS |off| (CONS '|%l| |nl|))))
                       (SETQ |lnl| (+ |offset| |sbl|))))))))))
               (SETQ |bfVar#14| (CDR |bfVar#14|))))
            |msg| NIL)
           (|concat| (NREVERSE |nl|))))
         (#1# (|concat| '|%l| |off| |msg|)))))))))

; keyedMsgCompFailure(key,args) ==
;   -- Called when compilation fails in such a way that interpret-code
;   --  mode might be of some use.
;   not $useCoerceOrCroak =>   THROW('coerceOrCroaker, 'croaked)
;   if not($Coerce) and  $reportInterpOnly then
;     sayKeyedMsg(key,args)
;     sayKeyedMsg("S2IB0009",NIL)
;   null $compilingMap => THROW('loopCompiler,'tryInterpOnly)
;   THROW('mapCompiler,'tryInterpOnly)

(DEFUN |keyedMsgCompFailure| (|key| |args|)
  (PROG ()
    (RETURN
     (COND ((NULL |$useCoerceOrCroak|) (THROW '|coerceOrCroaker| '|croaked|))
           (#1='T
            (PROGN
             (COND
              ((AND (NULL |$Coerce|) |$reportInterpOnly|)
               (|sayKeyedMsg| |key| |args|) (|sayKeyedMsg| 'S2IB0009 NIL)))
             (COND
              ((NULL |$compilingMap|) (THROW '|loopCompiler| '|tryInterpOnly|))
              (#1# (THROW '|mapCompiler| '|tryInterpOnly|)))))))))

; keyedMsgCompFailureSP(key,args,atree) ==
;   -- Called when compilation fails in such a way that interpret-code
;   --  mode might be of some use.
;   not $useCoerceOrCroak =>   THROW('coerceOrCroaker, 'croaked)
;   if not($Coerce) and  $reportInterpOnly then
;     if atree and (sp := getSrcPos(atree)) then
;         sayMSG '" "
;         srcPosDisplay(sp)
;     sayKeyedMsg(key,args)
;     sayKeyedMsg("S2IB0009",NIL)
;   null $compilingMap => THROW('loopCompiler,'tryInterpOnly)
;   THROW('mapCompiler,'tryInterpOnly)

(DEFUN |keyedMsgCompFailureSP| (|key| |args| |atree|)
  (PROG (|sp|)
    (RETURN
     (COND ((NULL |$useCoerceOrCroak|) (THROW '|coerceOrCroaker| '|croaked|))
           (#1='T
            (PROGN
             (COND
              ((AND (NULL |$Coerce|) |$reportInterpOnly|)
               (COND
                ((AND |atree| (SETQ |sp| (|getSrcPos| |atree|))) (|sayMSG| " ")
                 (|srcPosDisplay| |sp|)))
               (|sayKeyedMsg| |key| |args|) (|sayKeyedMsg| 'S2IB0009 NIL)))
             (COND
              ((NULL |$compilingMap|) (THROW '|loopCompiler| '|tryInterpOnly|))
              (#1# (THROW '|mapCompiler| '|tryInterpOnly|)))))))))

; throwKeyedMsgCannotCoerceWithValue(val,t1,t2) ==
;   val' :=
;      not($genValue) => nil
;      coerceInteractive(mkObj(val,t1),$OutputForm)
;   if not(isWrapped(val')) then val' := nil
;   null (val') =>
;     throwKeyedMsg("S2IC0002",[t1,t2])
;   val' := objValUnwrap(val')
;   throwKeyedMsg("S2IC0003",[t1,t2,val'])

(DEFUN |throwKeyedMsgCannotCoerceWithValue| (|val| |t1| |t2|)
  (PROG (|val'|)
    (RETURN
     (PROGN
      (SETQ |val'|
              (COND ((NULL |$genValue|) NIL)
                    (#1='T
                     (|coerceInteractive| (|mkObj| |val| |t1|)
                      |$OutputForm|))))
      (COND ((NULL (|isWrapped| |val'|)) (SETQ |val'| NIL)))
      (COND ((NULL |val'|) (|throwKeyedMsg| 'S2IC0002 (LIST |t1| |t2|)))
            (#1#
             (PROGN
              (SETQ |val'| (|objValUnwrap| |val'|))
              (|throwKeyedMsg| 'S2IC0003 (LIST |t1| |t2| |val'|)))))))))

; bright x == ['"%b", :(PAIRP(x) and NULL rest LASTNODE x => x; [x]), '"%d"]

(DEFUN |bright| (|x|)
  (PROG ()
    (RETURN
     (CONS "%b"
           (APPEND
            (COND ((AND (CONSP |x|) (NULL (CDR (LASTNODE |x|)))) |x|)
                  ('T (LIST |x|)))
            (CONS "%d" NIL))))))

; mkMessage msg ==
;   msg and (PAIRP msg) and ((first msg) in '(%l "%l"))  and
;     ((last msg) in '(%l "%l")) => concat msg
;   concat('%l,msg,'%l)

(DEFUN |mkMessage| (|msg|)
  (PROG ()
    (RETURN
     (COND
      ((AND |msg| (CONSP |msg|) (|member| (CAR |msg|) '(|%l| "%l"))
            (|member| (|last| |msg|) '(|%l| "%l")))
       (|concat| |msg|))
      ('T (|concat| '|%l| |msg| '|%l|))))))

; sayMessage msg == sayMSG mkMessage msg

(DEFUN |sayMessage| (|msg|) (PROG () (RETURN (|sayMSG| (|mkMessage| |msg|)))))

; sayNewLine() == TERPRI()

(DEFUN |sayNewLine| () (PROG () (RETURN (TERPRI))))

; say_new_line(str) ==
;   -- Note: this function should *always* be used by sayBrightly and
;   -- friends rather than TERPRI
;   TERPRI(str)

(DEFUN |say_new_line| (|str|) (PROG () (RETURN (TERPRI |str|))))

; sayString(x, str) ==
;   -- Note: this function should *always* be used by sayBrightly and
;   -- friends rather than PRINTEXP
;   PRINTEXP(x, str)

(DEFUN |sayString| (|x| |str|) (PROG () (RETURN (PRINTEXP |x| |str|))))

; spadStartUpMsgs() ==
;   -- messages displayed when the system starts up
;   $LINELENGTH < 60 => NIL
;   bar := fillerSpaces($LINELENGTH,specialChar 'hbar)
;   sayKeyedMsg("S2GL0001", [$build_version, $build_date])
;   sayMSG bar
;   sayKeyedMsg("S2GL0018C",NIL)
;   sayKeyedMsg("S2GL0018D",NIL)
;   sayKeyedMsg("S2GL0003B",[$opSysName])
;   sayMSG bar
; --  sayKeyedMsg("S2GL0018A",NIL)
; --  sayKeyedMsg("S2GL0018B",NIL)
; --  sayKeyedMsg("S2GL0003C",NIL)
; --  sayKeyedMsg("S2GL0003A",NIL)
; --  if not $printTimeIfTrue then sayKeyedMsg("S2GL0004",NIL)
; --  if not $printTypeIfTrue then sayKeyedMsg("S2GL0005",NIL)
;   --  if not $displaySetValue then sayKeyedMsg("S2GL0007",NIL)
; --  if not $HiFiAccess then sayKeyedMsg("S2GL0008",NIL)
; --  version()
;   sayMSG " "

(DEFUN |spadStartUpMsgs| ()
  (PROG (|bar|)
    (RETURN
     (COND ((< $LINELENGTH 60) NIL)
           ('T
            (PROGN
             (SETQ |bar| (|fillerSpaces| $LINELENGTH (|specialChar| '|hbar|)))
             (|sayKeyedMsg| 'S2GL0001 (LIST |$build_version| |$build_date|))
             (|sayMSG| |bar|)
             (|sayKeyedMsg| 'S2GL0018C NIL)
             (|sayKeyedMsg| 'S2GL0018D NIL)
             (|sayKeyedMsg| 'S2GL0003B (LIST |$opSysName|))
             (|sayMSG| |bar|)
             (|sayMSG| '| |)))))))

; HELP() == sayKeyedMsg("S2GL0019",NIL)

(DEFUN HELP () (PROG () (RETURN (|sayKeyedMsg| 'S2GL0019 NIL))))

; brightPrint(x, str) ==
;   marg := 0
;   for y in x repeat
;       marg := brightPrint0(y, str, marg)
;   NIL

(DEFUN |brightPrint| (|x| |str|)
  (PROG (|marg|)
    (RETURN
     (PROGN
      (SETQ |marg| 0)
      ((LAMBDA (|bfVar#15| |y|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#15|) (PROGN (SETQ |y| (CAR |bfVar#15|)) NIL))
            (RETURN NIL))
           ('T (SETQ |marg| (|brightPrint0| |y| |str| |marg|))))
          (SETQ |bfVar#15| (CDR |bfVar#15|))))
       |x| NIL)
      NIL))))

; brightPrint0(x, str, marg) ==
;   if IDENTP x then x := PNAME x
;
;   -- if the first character is a backslash and the second is a percent sign,
;   -- don't try to give the token any special interpretation. Just print
;   -- it without the backslash.
;
;   STRINGP x and STRINGLENGTH x > 1 and x.0 = char "\" and x.1 = char "%" =>
;       sayString(SUBSTRING(x, 1, NIL), str)
;       marg
;   x = '"%l" =>
;       say_new_line(str)
;       for i in 1..marg repeat
;           sayString('" ", str)
;       marg
;   x = '"%i" =>
;       marg + 3
;   x = '"%u" =>
;       marg := marg - 3
;       marg < 0 => 0
;       marg
;   x = '"%U" =>
;       0
;   x = '"%" =>
;       sayString('" ", str)
;       marg
;   x = '"%%" =>
;       sayString('"%", str)
;       marg
;   x = '"%b" =>
;       NULL $highlightAllowed =>
;           sayString('" ", str)
;           marg
;       sayString($highlightFontOn, str)
;       marg
;   k := blankIndicator x =>
;       BLANKS(k, str)
;       marg
;   x = '"%d" =>
;       NULL $highlightAllowed =>
;           sayString('" ", str)
;           marg
;       sayString($highlightFontOff, str)
;       marg
;   STRINGP x =>
;       sayString(x, str)
;       marg
;   brightPrintHighlight(x, str, marg)

(DEFUN |brightPrint0| (|x| |str| |marg|)
  (PROG (|k|)
    (RETURN
     (PROGN
      (COND ((IDENTP |x|) (SETQ |x| (PNAME |x|))))
      (COND
       ((AND (STRINGP |x|) (< 1 (STRINGLENGTH |x|))
             (EQUAL (ELT |x| 0) (|char| '|\\|))
             (EQUAL (ELT |x| 1) (|char| '%)))
        (PROGN (|sayString| (SUBSTRING |x| 1 NIL) |str|) |marg|))
       ((EQUAL |x| "%l")
        (PROGN
         (|say_new_line| |str|)
         ((LAMBDA (|i|)
            (LOOP
             (COND ((> |i| |marg|) (RETURN NIL))
                   (#1='T (|sayString| " " |str|)))
             (SETQ |i| (+ |i| 1))))
          1)
         |marg|))
       ((EQUAL |x| "%i") (+ |marg| 3))
       ((EQUAL |x| "%u")
        (PROGN
         (SETQ |marg| (- |marg| 3))
         (COND ((MINUSP |marg|) 0) (#1# |marg|))))
       ((EQUAL |x| "%U") 0)
       ((EQUAL |x| "%") (PROGN (|sayString| " " |str|) |marg|))
       ((EQUAL |x| "%%") (PROGN (|sayString| "%" |str|) |marg|))
       ((EQUAL |x| "%b")
        (COND
         ((NULL |$highlightAllowed|) (PROGN (|sayString| " " |str|) |marg|))
         (#1# (PROGN (|sayString| |$highlightFontOn| |str|) |marg|))))
       ((SETQ |k| (|blankIndicator| |x|)) (PROGN (BLANKS |k| |str|) |marg|))
       ((EQUAL |x| "%d")
        (COND
         ((NULL |$highlightAllowed|) (PROGN (|sayString| " " |str|) |marg|))
         (#1# (PROGN (|sayString| |$highlightFontOff| |str|) |marg|))))
       ((STRINGP |x|) (PROGN (|sayString| |x| |str|) |marg|))
       (#1# (|brightPrintHighlight| |x| |str| |marg|)))))))

; blankIndicator x ==
;   if IDENTP x then x := PNAME x
;   null STRINGP x or MAXINDEX x < 1 => nil
;   x.0 = char '% and x.1 = char 'x =>
;     MAXINDEX x > 1 => PARSE_-INTEGER SUBSTRING(x,2,nil)
;     1
;   nil

(DEFUN |blankIndicator| (|x|)
  (PROG ()
    (RETURN
     (PROGN
      (COND ((IDENTP |x|) (SETQ |x| (PNAME |x|))))
      (COND ((OR (NULL (STRINGP |x|)) (< (MAXINDEX |x|) 1)) NIL)
            ((AND (EQUAL (ELT |x| 0) (|char| '%))
                  (EQUAL (ELT |x| 1) (|char| '|x|)))
             (COND ((< 1 (MAXINDEX |x|)) (PARSE-INTEGER (SUBSTRING |x| 2 NIL)))
                   (#1='T 1)))
            (#1# NIL))))))

; brightPrint1(x, str, marg) ==
;   if x in '(%l "%l") then say_new_line(str)
;   else if STRINGP x then sayString(x, str)
;        else marg := brightPrintHighlight(x, str, marg)
;   marg

(DEFUN |brightPrint1| (|x| |str| |marg|)
  (PROG ()
    (RETURN
     (PROGN
      (COND ((|member| |x| '(|%l| "%l")) (|say_new_line| |str|))
            ((STRINGP |x|) (|sayString| |x| |str|))
            ('T (SETQ |marg| (|brightPrintHighlight| |x| |str| |marg|))))
      |marg|))))

; brightPrintHighlight(x, str, marg) ==
;   IDENTP x =>
;     pn := PNAME x
;     sayString(pn, str)
;     marg
;   -- following line helps find certain bugs that slip through
;   -- also see sayBrightlyLength1
;   VECP x =>
;       sayString('"UNPRINTABLE", str)
;       marg
;   ATOM x =>
;       sayString(object2String(x), str)
;       marg
;   [key,:rst] := x
;   if IDENTP key then key:=PNAME key
;   key = '"%m" =>
;       mathprint rst
;       marg
;   key in '("%p" "%s") =>
;       PRETTYPRIN0(rst, str)
;       marg
;   key = '"%ce" => brightPrintCenter(rst, str, marg)
;   key = '"%rj" => brightPrintRightJustify(rst, str, marg)
;   key = '"%t"  => marg + tabber(rst)
;   sayString('"(", str)
;   marg := brightPrint1(key, str, marg)
;   if EQ(key,'TAGGEDreturn) then
;     rst := [first rst, CADR rst, CADDR rst, '"environment (omitted)"]
;   for y in rst repeat
;     sayString('" ", str)
;     marg := brightPrint1(y, str, marg)
;   if rst and (la := LASTATOM rst) then
;     sayString('" . ", str)
;     marg := brightPrint1(la, str, marg)
;   sayString('")", str)
;   marg

(DEFUN |brightPrintHighlight| (|x| |str| |marg|)
  (PROG (|pn| |key| |rst| |la|)
    (RETURN
     (COND
      ((IDENTP |x|)
       (PROGN (SETQ |pn| (PNAME |x|)) (|sayString| |pn| |str|) |marg|))
      ((VECP |x|) (PROGN (|sayString| "UNPRINTABLE" |str|) |marg|))
      ((ATOM |x|) (PROGN (|sayString| (|object2String| |x|) |str|) |marg|))
      (#1='T
       (PROGN
        (SETQ |key| (CAR |x|))
        (SETQ |rst| (CDR |x|))
        (COND ((IDENTP |key|) (SETQ |key| (PNAME |key|))))
        (COND ((EQUAL |key| "%m") (PROGN (|mathprint| |rst|) |marg|))
              ((|member| |key| '("%p" "%s"))
               (PROGN (PRETTYPRIN0 |rst| |str|) |marg|))
              ((EQUAL |key| "%ce") (|brightPrintCenter| |rst| |str| |marg|))
              ((EQUAL |key| "%rj")
               (|brightPrintRightJustify| |rst| |str| |marg|))
              ((EQUAL |key| "%t") (+ |marg| (|tabber| |rst|)))
              (#1#
               (PROGN
                (|sayString| "(" |str|)
                (SETQ |marg| (|brightPrint1| |key| |str| |marg|))
                (COND
                 ((EQ |key| '|TAGGEDreturn|)
                  (SETQ |rst|
                          (LIST (CAR |rst|) (CADR |rst|) (CADDR |rst|)
                                "environment (omitted)"))))
                ((LAMBDA (|bfVar#16| |y|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#16|)
                          (PROGN (SETQ |y| (CAR |bfVar#16|)) NIL))
                      (RETURN NIL))
                     (#1#
                      (PROGN
                       (|sayString| " " |str|)
                       (SETQ |marg| (|brightPrint1| |y| |str| |marg|)))))
                    (SETQ |bfVar#16| (CDR |bfVar#16|))))
                 |rst| NIL)
                (COND
                 ((AND |rst| (SETQ |la| (LASTATOM |rst|)))
                  (|sayString| " . " |str|)
                  (SETQ |marg| (|brightPrint1| |la| |str| |marg|))))
                (|sayString| ")" |str|)
                |marg|)))))))))

; tabber num ==
;     maxTab := 50
;     num > maxTab => maxTab
;     num

(DEFUN |tabber| (|num|)
  (PROG (|maxTab|)
    (RETURN
     (PROGN
      (SETQ |maxTab| 50)
      (COND ((< |maxTab| |num|) |maxTab|) ('T |num|))))))

; brightPrintCenter(x, str, marg) ==
;   -- centers rst within $LINELENGTH, checking for %l's
;   ATOM x =>
;     x := object2String x
;     wid := STRINGLENGTH x
;     if wid < $LINELENGTH then
;       f := DIVIDE($LINELENGTH - wid,2)
;       x := LIST(fillerSpaces(f.0,'" "),x)
;     for y in x repeat
;         marg := brightPrint0(y, str, marg)
;     marg
;   y := NIL
;   ok := true
;   while x and ok repeat
;     if first(x) in '(%l "%l") then ok := NIL
;     else y := cons(first x, y)
;     x := rest x
;   y := NREVERSE y
;   wid := sayBrightlyLength y
;   if wid < $LINELENGTH then
;     f := DIVIDE($LINELENGTH - wid,2)
;     y := CONS(fillerSpaces(f.0,'" "),y)
;   for z in y repeat
;       marg := brightPrint0(z, str, marg)
;   if x then
;       say_new_line(str)
;       marg := brightPrintCenter(x, str, marg)
;   marg

(DEFUN |brightPrintCenter| (|x| |str| |marg|)
  (PROG (|wid| |f| |y| |ok|)
    (RETURN
     (COND
      ((ATOM |x|)
       (PROGN
        (SETQ |x| (|object2String| |x|))
        (SETQ |wid| (STRINGLENGTH |x|))
        (COND
         ((< |wid| $LINELENGTH) (SETQ |f| (DIVIDE (- $LINELENGTH |wid|) 2))
          (SETQ |x| (LIST (|fillerSpaces| (ELT |f| 0) " ") |x|))))
        ((LAMBDA (|bfVar#17| |y|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#17|) (PROGN (SETQ |y| (CAR |bfVar#17|)) NIL))
              (RETURN NIL))
             (#1='T (SETQ |marg| (|brightPrint0| |y| |str| |marg|))))
            (SETQ |bfVar#17| (CDR |bfVar#17|))))
         |x| NIL)
        |marg|))
      (#1#
       (PROGN
        (SETQ |y| NIL)
        (SETQ |ok| T)
        ((LAMBDA ()
           (LOOP
            (COND ((NOT (AND |x| |ok|)) (RETURN NIL))
                  (#1#
                   (PROGN
                    (COND ((|member| (CAR |x|) '(|%l| "%l")) (SETQ |ok| NIL))
                          (#1# (SETQ |y| (CONS (CAR |x|) |y|))))
                    (SETQ |x| (CDR |x|))))))))
        (SETQ |y| (NREVERSE |y|))
        (SETQ |wid| (|sayBrightlyLength| |y|))
        (COND
         ((< |wid| $LINELENGTH) (SETQ |f| (DIVIDE (- $LINELENGTH |wid|) 2))
          (SETQ |y| (CONS (|fillerSpaces| (ELT |f| 0) " ") |y|))))
        ((LAMBDA (|bfVar#18| |z|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#18|) (PROGN (SETQ |z| (CAR |bfVar#18|)) NIL))
              (RETURN NIL))
             (#1# (SETQ |marg| (|brightPrint0| |z| |str| |marg|))))
            (SETQ |bfVar#18| (CDR |bfVar#18|))))
         |y| NIL)
        (COND
         (|x| (|say_new_line| |str|)
          (SETQ |marg| (|brightPrintCenter| |x| |str| |marg|))))
        |marg|))))))

; brightPrintRightJustify(x, str, marg) ==
;   -- right justifies rst within $LINELENGTH, checking for %l's
;   ATOM x =>
;     x := object2String x
;     wid := STRINGLENGTH x
;     wid < $LINELENGTH =>
;       x := LIST(fillerSpaces($LINELENGTH-wid,'" "),x)
;       for y in x repeat
;           marg := brightPrint0(y, str, marg)
;       marg
;     brightPrint0(x, str, marg)
;   y := NIL
;   ok := true
;   while x and ok repeat
;     if first(x) in '(%l "%l") then ok := NIL
;     else y := cons(first x, y)
;     x := rest x
;   y := NREVERSE y
;   wid := sayBrightlyLength y
;   if wid < $LINELENGTH then
;     y := CONS(fillerSpaces($LINELENGTH-wid,'" "),y)
;   for z in y repeat
;       marg := brightPrint0(z, str, marg)
;   if x then
;     say_new_line(str)
;     marg := brightPrintRightJustify(x, str, marg)
;   marg

(DEFUN |brightPrintRightJustify| (|x| |str| |marg|)
  (PROG (|wid| |y| |ok|)
    (RETURN
     (COND
      ((ATOM |x|)
       (PROGN
        (SETQ |x| (|object2String| |x|))
        (SETQ |wid| (STRINGLENGTH |x|))
        (COND
         ((< |wid| $LINELENGTH)
          (PROGN
           (SETQ |x| (LIST (|fillerSpaces| (- $LINELENGTH |wid|) " ") |x|))
           ((LAMBDA (|bfVar#19| |y|)
              (LOOP
               (COND
                ((OR (ATOM |bfVar#19|) (PROGN (SETQ |y| (CAR |bfVar#19|)) NIL))
                 (RETURN NIL))
                (#1='T (SETQ |marg| (|brightPrint0| |y| |str| |marg|))))
               (SETQ |bfVar#19| (CDR |bfVar#19|))))
            |x| NIL)
           |marg|))
         (#1# (|brightPrint0| |x| |str| |marg|)))))
      (#1#
       (PROGN
        (SETQ |y| NIL)
        (SETQ |ok| T)
        ((LAMBDA ()
           (LOOP
            (COND ((NOT (AND |x| |ok|)) (RETURN NIL))
                  (#1#
                   (PROGN
                    (COND ((|member| (CAR |x|) '(|%l| "%l")) (SETQ |ok| NIL))
                          (#1# (SETQ |y| (CONS (CAR |x|) |y|))))
                    (SETQ |x| (CDR |x|))))))))
        (SETQ |y| (NREVERSE |y|))
        (SETQ |wid| (|sayBrightlyLength| |y|))
        (COND
         ((< |wid| $LINELENGTH)
          (SETQ |y| (CONS (|fillerSpaces| (- $LINELENGTH |wid|) " ") |y|))))
        ((LAMBDA (|bfVar#20| |z|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#20|) (PROGN (SETQ |z| (CAR |bfVar#20|)) NIL))
              (RETURN NIL))
             (#1# (SETQ |marg| (|brightPrint0| |z| |str| |marg|))))
            (SETQ |bfVar#20| (CDR |bfVar#20|))))
         |y| NIL)
        (COND
         (|x| (|say_new_line| |str|)
          (SETQ |marg| (|brightPrintRightJustify| |x| |str| |marg|))))
        |marg|))))))

; sayBrightlyLength l ==
;   null l => 0
;   atom l => sayBrightlyLength1 l
;   sayBrightlyLength1 first l + sayBrightlyLength rest l

(DEFUN |sayBrightlyLength| (|l|)
  (PROG ()
    (RETURN
     (COND ((NULL |l|) 0) ((ATOM |l|) (|sayBrightlyLength1| |l|))
           ('T
            (+ (|sayBrightlyLength1| (CAR |l|))
               (|sayBrightlyLength| (CDR |l|))))))))

; sayBrightlyLength1 x ==
;   member(x,'("%b" "%d" %b %d)) =>
;     NULL $highlightAllowed => 1
;     1
;   member(x,'("%l" %l)) => 0
;   STRINGP x and STRINGLENGTH x > 2 and x.0 = char "%" and x.1 = char "x" =>
;       DIGITP(x.2)
;   STRINGP x => STRINGLENGTH x
;   IDENTP x => STRINGLENGTH PNAME x
;   -- following line helps find certain bugs that slip through
;   -- also see brightPrintHighlight
;   VECP x => STRINGLENGTH '"UNPRINTABLE"
;   ATOM x => STRINGLENGTH STRINGIMAGE x
;   2 + sayBrightlyLength x

(DEFUN |sayBrightlyLength1| (|x|)
  (PROG ()
    (RETURN
     (COND
      ((|member| |x| '("%b" "%d" |%b| |%d|))
       (COND ((NULL |$highlightAllowed|) 1) (#1='T 1)))
      ((|member| |x| '("%l" |%l|)) 0)
      ((AND (STRINGP |x|) (< 2 (STRINGLENGTH |x|))
            (EQUAL (ELT |x| 0) (|char| '%)) (EQUAL (ELT |x| 1) (|char| '|x|)))
       (DIGITP (ELT |x| 2)))
      ((STRINGP |x|) (STRINGLENGTH |x|))
      ((IDENTP |x|) (STRINGLENGTH (PNAME |x|)))
      ((VECP |x|) (STRINGLENGTH "UNPRINTABLE"))
      ((ATOM |x|) (STRINGLENGTH (STRINGIMAGE |x|)))
      (#1# (+ 2 (|sayBrightlyLength| |x|)))))))

; sayAsManyPerLineAsPossible l ==
;   -- it is assumed that l is a list of strings
;   l := [atom2String a for a in l]
;   m := 1 + "MAX"/[SIZE(a) for a in l]
;   -- w will be the field width in which we will display the elements
;   m > $LINELENGTH =>
;     for a in l repeat sayMSG a
;     NIL
;   w := MIN(m + 3,$LINELENGTH)
;   -- p is the number of elements per line
;   p := QUOTIENT($LINELENGTH,w)
;   n := # l
;   str := '""
;   for i in 0..(n-1) repeat
;     [c,:l] := l
;     str := STRCONC(str,c,fillerSpaces(w - #c,'" "))
;     REMAINDER(i+1,p) = 0 => (sayMSG str ; str := '"" )
;   if str ~= '"" then sayMSG str
;   NIL

(DEFUN |sayAsManyPerLineAsPossible| (|l|)
  (PROG (|m| |w| |p| |n| |str| |LETTMP#1| |c|)
    (RETURN
     (PROGN
      (SETQ |l|
              ((LAMBDA (|bfVar#22| |bfVar#21| |a|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#21|)
                        (PROGN (SETQ |a| (CAR |bfVar#21|)) NIL))
                    (RETURN (NREVERSE |bfVar#22|)))
                   (#1='T
                    (SETQ |bfVar#22| (CONS (|atom2String| |a|) |bfVar#22|))))
                  (SETQ |bfVar#21| (CDR |bfVar#21|))))
               NIL |l| NIL))
      (SETQ |m|
              (+ 1
                 ((LAMBDA (|bfVar#24| |bfVar#23| |a|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#23|)
                           (PROGN (SETQ |a| (CAR |bfVar#23|)) NIL))
                       (RETURN |bfVar#24|))
                      (#1# (SETQ |bfVar#24| (MAX |bfVar#24| (SIZE |a|)))))
                     (SETQ |bfVar#23| (CDR |bfVar#23|))))
                  -999999 |l| NIL)))
      (COND
       ((< $LINELENGTH |m|)
        (PROGN
         ((LAMBDA (|bfVar#25| |a|)
            (LOOP
             (COND
              ((OR (ATOM |bfVar#25|) (PROGN (SETQ |a| (CAR |bfVar#25|)) NIL))
               (RETURN NIL))
              (#1# (|sayMSG| |a|)))
             (SETQ |bfVar#25| (CDR |bfVar#25|))))
          |l| NIL)
         NIL))
       (#1#
        (PROGN
         (SETQ |w| (MIN (+ |m| 3) $LINELENGTH))
         (SETQ |p| (QUOTIENT $LINELENGTH |w|))
         (SETQ |n| (LENGTH |l|))
         (SETQ |str| "")
         ((LAMBDA (|bfVar#26| |i|)
            (LOOP
             (COND ((> |i| |bfVar#26|) (RETURN NIL))
                   (#1#
                    (PROGN
                     (SETQ |LETTMP#1| |l|)
                     (SETQ |c| (CAR |LETTMP#1|))
                     (SETQ |l| (CDR |LETTMP#1|))
                     (SETQ |str|
                             (STRCONC |str| |c|
                              (|fillerSpaces| (- |w| (LENGTH |c|)) " ")))
                     (COND
                      ((EQL (REMAINDER (+ |i| 1) |p|) 0)
                       (PROGN (|sayMSG| |str|) (SETQ |str| "")))))))
             (SETQ |i| (+ |i| 1))))
          (- |n| 1) 0)
         (COND ((NOT (EQUAL |str| "")) (|sayMSG| |str|)))
         NIL)))))))

; say2PerLine l == say2PerLineWidth(l, QUOTIENT($LINELENGTH, 2))

(DEFUN |say2PerLine| (|l|)
  (PROG () (RETURN (|say2PerLineWidth| |l| (QUOTIENT $LINELENGTH 2)))))

; say2PerLineWidth(l,n) ==
;   [short,long] := say2Split(l,nil,nil,n)
;   say2PerLineThatFit short
;   for x in long repeat sayLongOperation x
;   sayBrightly '""

(DEFUN |say2PerLineWidth| (|l| |n|)
  (PROG (|LETTMP#1| |short| |long|)
    (RETURN
     (PROGN
      (SETQ |LETTMP#1| (|say2Split| |l| NIL NIL |n|))
      (SETQ |short| (CAR |LETTMP#1|))
      (SETQ |long| (CADR |LETTMP#1|))
      (|say2PerLineThatFit| |short|)
      ((LAMBDA (|bfVar#27| |x|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#27|) (PROGN (SETQ |x| (CAR |bfVar#27|)) NIL))
            (RETURN NIL))
           ('T (|sayLongOperation| |x|)))
          (SETQ |bfVar#27| (CDR |bfVar#27|))))
       |long| NIL)
      (|sayBrightly| "")))))

; say2Split(l,short,long,width) ==
;   l is [x,:l'] =>
;     sayWidth x < width => say2Split(l',[x,:short],long,width)
;     say2Split(l',short,[x,:long],width)
;   [nreverse short,nreverse long]

(DEFUN |say2Split| (|l| |short| |long| |width|)
  (PROG (|x| |l'|)
    (RETURN
     (COND
      ((AND (CONSP |l|)
            (PROGN (SETQ |x| (CAR |l|)) (SETQ |l'| (CDR |l|)) #1='T))
       (COND
        ((< (|sayWidth| |x|) |width|)
         (|say2Split| |l'| (CONS |x| |short|) |long| |width|))
        (#1# (|say2Split| |l'| |short| (CONS |x| |long|) |width|))))
      (#1# (LIST (NREVERSE |short|) (NREVERSE |long|)))))))

; sayLongOperation x ==
;   sayWidth x > $LINELENGTH and (splitListOn(x,"if") is [front,back]) =>
;     sayBrightly front
;     BLANKS (6 + # PNAME front.1)
;     sayBrightly back
;   sayBrightly x

(DEFUN |sayLongOperation| (|x|)
  (PROG (|ISTMP#1| |front| |ISTMP#2| |back|)
    (RETURN
     (COND
      ((AND (< $LINELENGTH (|sayWidth| |x|))
            (PROGN
             (SETQ |ISTMP#1| (|splitListOn| |x| '|if|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |front| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |back| (CAR |ISTMP#2|)) #1='T))))))
       (PROGN
        (|sayBrightly| |front|)
        (BLANKS (+ 6 (LENGTH (PNAME (ELT |front| 1)))))
        (|sayBrightly| |back|)))
      (#1# (|sayBrightly| |x|))))))

; splitListOn(x,key) ==
;   key in x =>
;     while first x ~= key repeat
;       y:= [first x,:y]
;       x:= rest x
;     [nreverse y,x]
;   nil

(DEFUN |splitListOn| (|x| |key|)
  (PROG (|y|)
    (RETURN
     (COND
      ((|member| |key| |x|)
       (PROGN
        ((LAMBDA ()
           (LOOP
            (COND ((EQUAL (CAR |x|) |key|) (RETURN NIL))
                  (#1='T
                   (PROGN
                    (SETQ |y| (CONS (CAR |x|) |y|))
                    (SETQ |x| (CDR |x|))))))))
        (LIST (NREVERSE |y|) |x|)))
      (#1# NIL)))))

; say2PerLineThatFit l ==
;   while l repeat
;     sayBrightlyNT first l
;     sayBrightlyNT
;       fillerSpaces((QUOTIENT($LINELENGTH, 2) - sayDisplayWidth first l), '" ")
;     (l:= rest l) =>
;       sayBrightlyNT first l
;       l:= rest l
;       sayBrightly '""
;     sayBrightly '""

(DEFUN |say2PerLineThatFit| (|l|)
  (PROG ()
    (RETURN
     ((LAMBDA ()
        (LOOP
         (COND ((NOT |l|) (RETURN NIL))
               (#1='T
                (PROGN
                 (|sayBrightlyNT| (CAR |l|))
                 (|sayBrightlyNT|
                  (|fillerSpaces|
                   (- (QUOTIENT $LINELENGTH 2) (|sayDisplayWidth| (CAR |l|)))
                   " "))
                 (COND
                  ((SETQ |l| (CDR |l|))
                   (PROGN
                    (|sayBrightlyNT| (CAR |l|))
                    (SETQ |l| (CDR |l|))
                    (|sayBrightly| "")))
                  (#1# (|sayBrightly| ""))))))))))))

; sayDisplayWidth x ==
;   PAIRP x =>
;     +/[fn y for y in x] where fn y ==
;       y in '(%b %d "%b" "%d") or y=$quadSymbol => 1
;       k := blankIndicator y => k
;       sayDisplayWidth y
;   x = "%%" or x = '"%%" => 1
;   # atom2String x

(DEFUN |sayDisplayWidth| (|x|)
  (PROG ()
    (RETURN
     (COND
      ((CONSP |x|)
       ((LAMBDA (|bfVar#29| |bfVar#28| |y|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#28|) (PROGN (SETQ |y| (CAR |bfVar#28|)) NIL))
             (RETURN |bfVar#29|))
            (#1='T
             (SETQ |bfVar#29| (+ |bfVar#29| (|sayDisplayWidth,fn| |y|)))))
           (SETQ |bfVar#28| (CDR |bfVar#28|))))
        0 |x| NIL))
      ((OR (EQ |x| '%%) (EQUAL |x| "%%")) 1)
      (#1# (LENGTH (|atom2String| |x|)))))))
(DEFUN |sayDisplayWidth,fn| (|y|)
  (PROG (|k|)
    (RETURN
     (COND
      ((OR (|member| |y| '(|%b| |%d| "%b" "%d")) (EQUAL |y| |$quadSymbol|)) 1)
      ((SETQ |k| (|blankIndicator| |y|)) |k|) ('T (|sayDisplayWidth| |y|))))))

; sayWidth x ==
;   atom x => # atom2String x
;   +/[fn y for y in x] where fn y ==
;     sayWidth y

(DEFUN |sayWidth| (|x|)
  (PROG ()
    (RETURN
     (COND ((ATOM |x|) (LENGTH (|atom2String| |x|)))
           (#1='T
            ((LAMBDA (|bfVar#31| |bfVar#30| |y|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#30|)
                      (PROGN (SETQ |y| (CAR |bfVar#30|)) NIL))
                  (RETURN |bfVar#31|))
                 (#1# (SETQ |bfVar#31| (+ |bfVar#31| (|sayWidth,fn| |y|)))))
                (SETQ |bfVar#30| (CDR |bfVar#30|))))
             0 |x| NIL))))))
(DEFUN |sayWidth,fn| (|y|) (PROG () (RETURN (|sayWidth| |y|))))

; pp2Cols(al) ==
;   while al repeat
;     [[abb,:name],:al]:= al
;     ppPair(abb,name)
;     if canFit2ndEntry(name,al) then
;       [[abb,:name],:al]:= al
;       TAB (QUOTIENT($LINELENGTH, 2))
;       ppPair(abb,name)
;     sayNewLine()
;   nil

(DEFUN |pp2Cols| (|al|)
  (PROG (|LETTMP#1| |abb| |name|)
    (RETURN
     (PROGN
      ((LAMBDA ()
         (LOOP
          (COND ((NOT |al|) (RETURN NIL))
                ('T
                 (PROGN
                  (SETQ |LETTMP#1| |al|)
                  (SETQ |abb| (CAAR . #1=(|LETTMP#1|)))
                  (SETQ |name| (CDAR . #1#))
                  (SETQ |al| (CDR |LETTMP#1|))
                  (|ppPair| |abb| |name|)
                  (COND
                   ((|canFit2ndEntry| |name| |al|) (SETQ |LETTMP#1| |al|)
                    (SETQ |abb| (CAAR . #2=(|LETTMP#1|)))
                    (SETQ |name| (CDAR . #2#)) (SETQ |al| (CDR |LETTMP#1|))
                    (TAB (QUOTIENT $LINELENGTH 2)) (|ppPair| |abb| |name|)))
                  (|sayNewLine|)))))))
      NIL))))

; ppPair(abb,name) ==
;     sayBrightlyNT [:bright abb,fillerSpaces(8-entryWidth abb," "),name]

(DEFUN |ppPair| (|abb| |name|)
  (PROG ()
    (RETURN
     (|sayBrightlyNT|
      (APPEND (|bright| |abb|)
              (CONS (|fillerSpaces| (- 8 (|entryWidth| |abb|)) '| |)
                    (CONS |name| NIL)))))))

; canFit2ndEntry(name,al) ==
;   wid := QUOTIENT($LINELENGTH, 2) - 10
;   null al => nil
;   entryWidth name > wid => nil
;   entryWidth CDAR al > wid => nil
;   'T

(DEFUN |canFit2ndEntry| (|name| |al|)
  (PROG (|wid|)
    (RETURN
     (PROGN
      (SETQ |wid| (- (QUOTIENT $LINELENGTH 2) 10))
      (COND ((NULL |al|) NIL) ((< |wid| (|entryWidth| |name|)) NIL)
            ((< |wid| (|entryWidth| (CDAR |al|))) NIL) ('T 'T))))))

; entryWidth x == # atom2String x

(DEFUN |entryWidth| (|x|) (PROG () (RETURN (LENGTH (|atom2String| |x|)))))

; center80 text == centerNoHighlight(text,$LINELENGTH,'" ")

(DEFUN |center80| (|text|)
  (PROG () (RETURN (|centerNoHighlight| |text| $LINELENGTH " "))))

; centerAndHighlight(text,:argList) ==
;   width := IFCAR argList or $LINELENGTH
;   fillchar := IFCAR IFCDR argList or '" "
;   wid := entryWidth text + 2
;   wid >= width - 2 => sayBrightly ['%b,text,'%d]
;   f := DIVIDE(width - wid - 2,2)
;   fill1 := '""
;   for i in 1..(f.0) repeat
;     fill1 := STRCONC(fillchar,fill1)
;   if f.1 = 0 then fill2 := fill1 else fill2 := STRCONC(fillchar,fill1)
;   sayBrightly [fill1,'%b,text,'%d,fill2]
;   nil

(DEFUN |centerAndHighlight| (|text| &REST |argList|)
  (PROG (|width| |fillchar| |wid| |f| |fill1| |fill2|)
    (RETURN
     (PROGN
      (SETQ |width| (OR (IFCAR |argList|) $LINELENGTH))
      (SETQ |fillchar| (OR (IFCAR (IFCDR |argList|)) " "))
      (SETQ |wid| (+ (|entryWidth| |text|) 2))
      (COND
       ((NOT (< |wid| (- |width| 2)))
        (|sayBrightly| (LIST '|%b| |text| '|%d|)))
       (#1='T
        (PROGN
         (SETQ |f| (DIVIDE (- (- |width| |wid|) 2) 2))
         (SETQ |fill1| "")
         ((LAMBDA (|bfVar#32| |i|)
            (LOOP
             (COND ((> |i| |bfVar#32|) (RETURN NIL))
                   (#1# (SETQ |fill1| (STRCONC |fillchar| |fill1|))))
             (SETQ |i| (+ |i| 1))))
          (ELT |f| 0) 1)
         (COND ((EQL (ELT |f| 1) 0) (SETQ |fill2| |fill1|))
               (#1# (SETQ |fill2| (STRCONC |fillchar| |fill1|))))
         (|sayBrightly| (LIST |fill1| '|%b| |text| '|%d| |fill2|))
         NIL)))))))

; centerNoHighlight(text,:argList) == sayBrightly center(text,argList)

(DEFUN |centerNoHighlight| (|text| &REST |argList|)
  (PROG () (RETURN (|sayBrightly| (|center| |text| |argList|)))))

; center(text,argList) ==
;   width := IFCAR argList or $LINELENGTH
;   fillchar := IFCAR IFCDR argList or '" "
;   if (u:= splitSayBrightlyArgument text) then [text,:moreLines]:= u
;   wid := sayBrightlyLength text
;   wid >= width - 2 => sayBrightly text
;   f := DIVIDE(width - wid - 2,2)
;   fill1 := '""
;   for i in 1..(f.0) repeat
;     fill1 := STRCONC(fillchar,fill1)
;   if f.1 = 0 then fill2 := fill1 else fill2 := STRCONC(fillchar,fill1)
;   concat(fill1,text,fill2)

(DEFUN |center| (|text| |argList|)
  (PROG (|width| |fillchar| |u| |moreLines| |wid| |f| |fill1| |fill2|)
    (RETURN
     (PROGN
      (SETQ |width| (OR (IFCAR |argList|) $LINELENGTH))
      (SETQ |fillchar| (OR (IFCAR (IFCDR |argList|)) " "))
      (COND
       ((SETQ |u| (|splitSayBrightlyArgument| |text|)) (SETQ |text| (CAR |u|))
        (SETQ |moreLines| (CDR |u|)) |u|))
      (SETQ |wid| (|sayBrightlyLength| |text|))
      (COND ((NOT (< |wid| (- |width| 2))) (|sayBrightly| |text|))
            (#1='T
             (PROGN
              (SETQ |f| (DIVIDE (- (- |width| |wid|) 2) 2))
              (SETQ |fill1| "")
              ((LAMBDA (|bfVar#33| |i|)
                 (LOOP
                  (COND ((> |i| |bfVar#33|) (RETURN NIL))
                        (#1# (SETQ |fill1| (STRCONC |fillchar| |fill1|))))
                  (SETQ |i| (+ |i| 1))))
               (ELT |f| 0) 1)
              (COND ((EQL (ELT |f| 1) 0) (SETQ |fill2| |fill1|))
                    (#1# (SETQ |fill2| (STRCONC |fillchar| |fill1|))))
              (|concat| |fill1| |text| |fill2|))))))))

; splitSayBrightly u ==
;   width:= 0
;   while u and (width:= width + sayWidth first u) < $LINELENGTH repeat
;     segment:= [first u,:segment]
;     u := rest u
;   null u => NREVERSE segment
;   segment => [:NREVERSE segment,"%l",:splitSayBrightly(u)]
;   u

(DEFUN |splitSayBrightly| (|u|)
  (PROG (|width| |segment|)
    (RETURN
     (PROGN
      (SETQ |width| 0)
      ((LAMBDA ()
         (LOOP
          (COND
           ((NOT
             (AND |u|
                  (< (SETQ |width| (+ |width| (|sayWidth| (CAR |u|))))
                     $LINELENGTH)))
            (RETURN NIL))
           (#1='T
            (PROGN
             (SETQ |segment| (CONS (CAR |u|) |segment|))
             (SETQ |u| (CDR |u|))))))))
      (COND ((NULL |u|) (NREVERSE |segment|))
            (|segment|
             (APPEND (NREVERSE |segment|)
                     (CONS '|%l| (|splitSayBrightly| |u|))))
            (#1# |u|))))))

; splitSayBrightlyArgument u ==
;   atom u => nil
;   while splitListSayBrightly u is [head,:u] repeat result:= [head,:result]
;   result => [:NREVERSE result,u]
;   [u]

(DEFUN |splitSayBrightlyArgument| (|u|)
  (PROG (|ISTMP#1| |head| |result|)
    (RETURN
     (COND ((ATOM |u|) NIL)
           (#1='T
            (PROGN
             ((LAMBDA ()
                (LOOP
                 (COND
                  ((NOT
                    (PROGN
                     (SETQ |ISTMP#1| (|splitListSayBrightly| |u|))
                     (AND (CONSP |ISTMP#1|)
                          (PROGN
                           (SETQ |head| (CAR |ISTMP#1|))
                           (SETQ |u| (CDR |ISTMP#1|))
                           #1#))))
                   (RETURN NIL))
                  (#1# (SETQ |result| (CONS |head| |result|)))))))
             (COND (|result| (APPEND (NREVERSE |result|) (CONS |u| NIL)))
                   (#1# (LIST |u|)))))))))

; splitListSayBrightly u ==
;   for x in tails u repeat
;     y := rest x
;     null y => nil
;     first y = '%l =>
;       RPLACD(x,nil)
;       ans:= [u,:rest y]
;   ans

(DEFUN |splitListSayBrightly| (|u|)
  (PROG (|y| |ans|)
    (RETURN
     (PROGN
      ((LAMBDA (|x|)
         (LOOP
          (COND ((ATOM |x|) (RETURN NIL))
                ('T
                 (PROGN
                  (SETQ |y| (CDR |x|))
                  (COND ((NULL |y|) NIL)
                        ((EQ (CAR |y|) '|%l|)
                         (PROGN
                          (RPLACD |x| NIL)
                          (SETQ |ans| (CONS |u| (CDR |y|)))))))))
          (SETQ |x| (CDR |x|))))
       |u|)
      |ans|))))

; sayBrightlyNT2(x, str) ==
;     NULL(X) => nil
;     $sayBrightlyStream => sayBrightlyNT1(x, $sayBrightlyStream)
;     sayBrightlyNT1(x, str)

(DEFUN |sayBrightlyNT2| (|x| |str|)
  (PROG ()
    (RETURN
     (COND ((NULL X) NIL)
           (|$sayBrightlyStream| (|sayBrightlyNT1| |x| |$sayBrightlyStream|))
           ('T (|sayBrightlyNT1| |x| |str|))))))

; sayBrightlyNT1(x, str) ==
;     if x then
;         ATOM(x) =>
;             brightPrint0(x, str, 0)
;         brightPrint(x, str)

(DEFUN |sayBrightlyNT1| (|x| |str|)
  (PROG ()
    (RETURN
     (COND
      (|x|
       (COND ((ATOM |x|) (|brightPrint0| |x| |str| 0))
             ('T (|brightPrint| |x| |str|))))))))

; sayBrightlyNT(x) == sayBrightlyNT2(x, get_lisp_std_out())

(DEFUN |sayBrightlyNT| (|x|)
  (PROG () (RETURN (|sayBrightlyNT2| |x| (|get_lisp_std_out|)))))

; sayBrightly2(x, str) ==
;     NULL(x) => nil
;     $sayBrightlyStream => sayBrightly1(x, $sayBrightlyStream)
;     sayBrightly1(x, str)

(DEFUN |sayBrightly2| (|x| |str|)
  (PROG ()
    (RETURN
     (COND ((NULL |x|) NIL)
           (|$sayBrightlyStream| (|sayBrightly1| |x| |$sayBrightlyStream|))
           ('T (|sayBrightly1| |x| |str|))))))

; sayBrightly1(x, str) ==
;     if x then
;         sayBrightlyNT1(x, str)
;         TERPRI(str)
;         FORCE_-OUTPUT(str)

(DEFUN |sayBrightly1| (|x| |str|)
  (PROG ()
    (RETURN
     (COND
      (|x| (|sayBrightlyNT1| |x| |str|) (TERPRI |str|) (FORCE-OUTPUT |str|))))))

; sayBrightly(x) == sayBrightly2(x,  get_lisp_std_out())

(DEFUN |sayBrightly| (|x|)
  (PROG () (RETURN (|sayBrightly2| |x| (|get_lisp_std_out|)))))

; sayBrightlyI(x) ==
;     NULL(x) => nil
;     sayBrightly1(x, get_lisp_error_out())

(DEFUN |sayBrightlyI| (|x|)
  (PROG ()
    (RETURN
     (COND ((NULL |x|) NIL) ('T (|sayBrightly1| |x| (|get_lisp_error_out|)))))))

; sayMSGNT(x) == sayBrightlyNT1(x, get_algebra_stream())

(DEFUN |sayMSGNT| (|x|)
  (PROG () (RETURN (|sayBrightlyNT1| |x| (|get_algebra_stream|)))))

; say_simple(x, str) ==
;     if x then
;         if true then
;             ATOM(x) => sayString(x, str)
;             for y in x repeat
;                 sayString(y, str)
;         TERPRI(str)

(DEFUN |say_simple| (|x| |str|)
  (PROG ()
    (RETURN
     (COND
      (|x|
       (COND
        (T
         (COND ((ATOM |x|) (|sayString| |x| |str|))
               (#1='T
                ((LAMBDA (|bfVar#34| |y|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#34|)
                          (PROGN (SETQ |y| (CAR |bfVar#34|)) NIL))
                      (RETURN NIL))
                     (#1# (|sayString| |y| |str|)))
                    (SETQ |bfVar#34| (CDR |bfVar#34|))))
                 |x| NIL)))))
       (TERPRI |str|))))))

; sayHtml(x) == say_simple(x, get_html_stream())

(DEFUN |sayHtml| (|x|)
  (PROG () (RETURN (|say_simple| |x| (|get_html_stream|)))))

; sayMathML(x) == say_simple(x, get_mathml_stream())

(DEFUN |sayMathML| (|x|)
  (PROG () (RETURN (|say_simple| |x| (|get_mathml_stream|)))))

; sayTeX(x) == say_simple(x, get_tex_stream())

(DEFUN |sayTeX| (|x|) (PROG () (RETURN (|say_simple| |x| (|get_tex_stream|)))))

; sayTexmacs(x) == say_simple(x, get_texmacs_stream())

(DEFUN |sayTexmacs| (|x|)
  (PROG () (RETURN (|say_simple| |x| (|get_texmacs_stream|)))))

; saySpadMsg(x) == sayBrightly1(x, get_algebra_stream())

(DEFUN |saySpadMsg| (|x|)
  (PROG () (RETURN (|sayBrightly1| |x| (|get_algebra_stream|)))))

; sayALGEBRA(x) == sayBrightly1(x, get_algebra_stream())

(DEFUN |sayALGEBRA| (|x|)
  (PROG () (RETURN (|sayBrightly1| |x| (|get_algebra_stream|)))))

; sayMSG(x) == sayBrightly1(x, get_algebra_stream())

(DEFUN |sayMSG| (|x|)
  (PROG () (RETURN (|sayBrightly1| |x| (|get_algebra_stream|)))))

; sayFormatted(x) == say_simple(x, get_formatted_stream())

(DEFUN |sayFormatted| (|x|)
  (PROG () (RETURN (|say_simple| |x| (|get_formatted_stream|)))))

; sayMSG2File(msg) ==
;     file := makePathname("spadmsg", "listing")
;     str := MAKE_OUTSTREAM(file)
;     sayBrightly1(msg, str)
;     SHUT(str)

(DEFUN |sayMSG2File| (|msg|)
  (PROG (|file| |str|)
    (RETURN
     (PROGN
      (SETQ |file| (|makePathname| '|spadmsg| '|listing|))
      (SETQ |str| (MAKE_OUTSTREAM |file|))
      (|sayBrightly1| |msg| |str|)
      (SHUT |str|)))))

; $htSpecialChars := ['"_#", '"[", '"]", '"%", '"{", '"}", '"_\",
;                     '"$", '"&", '"^", '"__", '"_~"]

(EVAL-WHEN (EVAL LOAD)
  (SETQ |$htSpecialChars|
          (LIST "#" "[" "]" "%" "{" "}" "\\" "$" "&" "^" "_" "~")))

; $htCharAlist := '(
;   ("$"  . "\%")
;   ("[]" . "\[\]")
;   ("{}" . "\{\}")
;   ("\\" . "\\\\")
;   ("\/" . "\\/" )
;   ("/\" . "/\\" ) )

(EVAL-WHEN (EVAL LOAD)
  (SETQ |$htCharAlist|
          '(("$" . "\\%") ("[]" . "\\[\\]") ("{}" . "\\{\\}")
            ("\\\\" . "\\\\\\\\") ("\\/" . "\\\\/") ("/\\" . "/\\\\"))))

; escapeSpecialChars s ==
;   u := LASSOC(s,$htCharAlist) => u
;   member(s, $htSpecialChars) => STRCONC('"_\", s)
;   s

(DEFUN |escapeSpecialChars| (|s|)
  (PROG (|u|)
    (RETURN
     (COND ((SETQ |u| (LASSOC |s| |$htCharAlist|)) |u|)
           ((|member| |s| |$htSpecialChars|) (STRCONC "\\" |s|)) ('T |s|)))))
