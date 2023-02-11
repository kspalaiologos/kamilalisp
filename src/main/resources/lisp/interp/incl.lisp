
; )package "BOOT"

(IN-PACKAGE "BOOT")

; %id a     == [FUNCTION IDENTITY, a]

(DEFUN |%id| (|a|) (PROG () (RETURN (LIST #'IDENTITY |a|))))

; %origin x ==
;     [function porigin, x]

(DEFUN |%origin| (|x|) (PROG () (RETURN (LIST #'|porigin| |x|))))

; porigin x == x

(DEFUN |porigin| (|x|) (PROG () (RETURN |x|)))

; ppos p ==
;     pfNoPosition? p => ['"no position"]
;     pfImmediate? p  => ['"console"]
;     cpos := pfCharPosn p
;     lpos := pfLinePosn p
;     org  := porigin pfFileName p
;     [org,'" ",'"line",'" ",lpos]

(DEFUN |ppos| (|p|)
  (PROG (|cpos| |lpos| |org|)
    (RETURN
     (COND ((|pfNoPosition?| |p|) (LIST "no position"))
           ((|pfImmediate?| |p|) (LIST "console"))
           ('T
            (PROGN
             (SETQ |cpos| (|pfCharPosn| |p|))
             (SETQ |lpos| (|pfLinePosn| |p|))
             (SETQ |org| (|porigin| (|pfFileName| |p|)))
             (LIST |org| " " "line" " " |lpos|)))))))

; incStringStream s==
;    incRenumber incLude(0,incRgen s,0,['"strings"] ,[Top])

(DEFUN |incStringStream| (|s|)
  (PROG ()
    (RETURN
     (|incRenumber|
      (|incLude| 0 (|incRgen| |s|) 0 (LIST "strings") (LIST |Top|))))))

; incFile fn==
;    incRenumber incLude(0,incRgen OPEN fn,0,[fn],[Top])

(DEFUN |incFile| (|fn|)
  (PROG ()
    (RETURN
     (|incRenumber|
      (|incLude| 0 (|incRgen| (OPEN |fn|)) 0 (LIST |fn|) (LIST |Top|))))))

; incStream(st, fn) ==
;    incRenumber incLude(0,incRgen st,0,[fn],[Top])

(DEFUN |incStream| (|st| |fn|)
  (PROG ()
    (RETURN
     (|incRenumber|
      (|incLude| 0 (|incRgen| |st|) 0 (LIST |fn|) (LIST |Top|))))))

; incFileInput    fn == incRgen  MAKE_INSTREAM(fn)

(DEFUN |incFileInput| (|fn|)
  (PROG () (RETURN (|incRgen| (MAKE_INSTREAM |fn|)))))

; incLine(eb, str, gno, lno, ufo) ==
;             ln := lnCreate(eb,str,gno,lno,ufo)
;             CONS(CONS(ln,1), str)

(DEFUN |incLine| (|eb| |str| |gno| |lno| |ufo|)
  (PROG (|ln|)
    (RETURN
     (PROGN
      (SETQ |ln| (|lnCreate| |eb| |str| |gno| |lno| |ufo|))
      (CONS (CONS |ln| 1) |str|)))))

; incPos f == first f

(DEFUN |incPos| (|f|) (PROG () (RETURN (CAR |f|))))

; incRenumberItem(f, i) ==
;             l := CAAR f
;             lnSetGlobalNum(l, i)
;             f

(DEFUN |incRenumberItem| (|f| |i|)
  (PROG (|l|)
    (RETURN (PROGN (SETQ |l| (CAAR |f|)) (|lnSetGlobalNum| |l| |i|) |f|))))

; incRenumberLine(xl, gno) ==
;             l := incRenumberItem(xl.0, gno)
;             incHandleMessage xl
;             l

(DEFUN |incRenumberLine| (|xl| |gno|)
  (PROG (|l|)
    (RETURN
     (PROGN
      (SETQ |l| (|incRenumberItem| (ELT |xl| 0) |gno|))
      (|incHandleMessage| |xl|)
      |l|))))

; incRenumber ssx == incZip (function incRenumberLine, ssx, incIgen 0)

(DEFUN |incRenumber| (|ssx|)
  (PROG () (RETURN (|incZip| #'|incRenumberLine| |ssx| (|incIgen| 0)))))

; incPrefix?(prefix, start, whole) ==
;             #prefix > #whole-start => false
;             good:=true
;             for i in 0..#prefix-1 for j in start.. while good repeat
;                 good:= prefix.i = whole.j
;             good

(DEFUN |incPrefix?| (|prefix| |start| |whole|)
  (PROG (|good|)
    (RETURN
     (COND ((< (- (LENGTH |whole|) |start|) (LENGTH |prefix|)) NIL)
           (#1='T
            (PROGN
             (SETQ |good| T)
             ((LAMBDA (|bfVar#1| |i| |j|)
                (LOOP
                 (COND ((OR (> |i| |bfVar#1|) (NOT |good|)) (RETURN NIL))
                       (#1#
                        (SETQ |good|
                                (EQUAL (ELT |prefix| |i|) (ELT |whole| |j|)))))
                 (SETQ |i| (+ |i| 1))
                 (SETQ |j| (+ |j| 1))))
              (- (LENGTH |prefix|) 1) 0 |start|)
             |good|))))))

; incCommand?(s) == #s > 1 and s.0 = char ")" and not (s.1 = char " ")

(DEFUN |incCommand?| (|s|)
  (PROG ()
    (RETURN
     (AND (< 1 (LENGTH |s|)) (EQUAL (ELT |s| 0) (|char| '|)|))
          (NULL (EQUAL (ELT |s| 1) (|char| '| |)))))))

; incCommands :=
;             ['"say"    , _
;              '"include", _
;              '"fin"    , _
;              '"assert" , _
;              '"if"     , _
;              '"elseif" , _
;              '"else"   , _
;              '"endif" ]

(EVAL-WHEN (EVAL LOAD)
  (SETQ |incCommands|
          (LIST "say" "include" "fin" "assert" "if" "elseif" "else" "endif")))

; incClassify(s) ==
;             not incCommand? s => [false,0, '""]
;             i := 1; n := #s
;             while i < n and s.i = char " " repeat i := i + 1
;             i >= n => [true,0,'"other"]
;             eb := (i = 1 => 0; i)
;             bad:=true
;             for p in incCommands while bad repeat
;                 incPrefix?(p, i, s) =>
;                     bad:=false
;                     p1 :=p
;             if bad then [true,0,'"other"] else [true,eb,p1]

(DEFUN |incClassify| (|s|)
  (PROG (|i| |n| |eb| |bad| |p1|)
    (RETURN
     (COND ((NULL (|incCommand?| |s|)) (LIST NIL 0 ""))
           (#1='T
            (PROGN
             (SETQ |i| 1)
             (SETQ |n| (LENGTH |s|))
             ((LAMBDA ()
                (LOOP
                 (COND
                  ((NOT (AND (< |i| |n|) (EQUAL (ELT |s| |i|) (|char| '| |))))
                   (RETURN NIL))
                  (#1# (SETQ |i| (+ |i| 1)))))))
             (COND ((NOT (< |i| |n|)) (LIST T 0 "other"))
                   (#1#
                    (PROGN
                     (SETQ |eb| (COND ((EQL |i| 1) 0) (#1# |i|)))
                     (SETQ |bad| T)
                     ((LAMBDA (|bfVar#2| |p|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#2|)
                               (PROGN (SETQ |p| (CAR |bfVar#2|)) NIL)
                               (NOT |bad|))
                           (RETURN NIL))
                          (#1#
                           (COND
                            ((|incPrefix?| |p| |i| |s|)
                             (IDENTITY
                              (PROGN (SETQ |bad| NIL) (SETQ |p1| |p|)))))))
                         (SETQ |bfVar#2| (CDR |bfVar#2|))))
                      |incCommands| NIL)
                     (COND (|bad| (LIST T 0 "other"))
                           (#1# (LIST T |eb| |p1|))))))))))))

; incCommandTail(s, info) ==
;             start := (info.1 = 0 => 1; info.1)
;             incDrop(start+#info.2+1, s)

(DEFUN |incCommandTail| (|s| |info|)
  (PROG (|start|)
    (RETURN
     (PROGN
      (SETQ |start| (COND ((EQL (ELT |info| 1) 0) 1) ('T (ELT |info| 1))))
      (|incDrop| (+ (+ |start| (LENGTH (ELT |info| 2))) 1) |s|)))))

; incDrop(n, b) ==
;             n >= #b => ""
;             SUBSTRING(b,n,nil)

(DEFUN |incDrop| (|n| |b|)
  (PROG ()
    (RETURN
     (COND ((NOT (< |n| (LENGTH |b|))) '||) ('T (SUBSTRING |b| |n| NIL))))))

; inclFname(s, info) == incFileName incCommandTail(s, info)

(DEFUN |inclFname| (|s| |info|)
  (PROG () (RETURN (|incFileName| (|incCommandTail| |s| |info|)))))

; incBiteOff x ==
;           n:=STRPOSL('" ",x,0,true)-- first nonspace
;           if null n
;           then false -- all spaces
;           else
;              n1:=STRPOSL ('" ",x,n,nil)
;              if null n1 -- all nonspaces
;              then [SUBSTRING(x,n,nil),'""]
;              else [SUBSTRING(x,n,n1-n),SUBSTRING(x,n1,nil)]

(DEFUN |incBiteOff| (|x|)
  (PROG (|n| |n1|)
    (RETURN
     (PROGN
      (SETQ |n| (STRPOSL " " |x| 0 T))
      (COND ((NULL |n|) NIL)
            (#1='T (SETQ |n1| (STRPOSL " " |x| |n| NIL))
             (COND ((NULL |n1|) (LIST (SUBSTRING |x| |n| NIL) ""))
                   (#1#
                    (LIST (SUBSTRING |x| |n| (- |n1| |n|))
                          (SUBSTRING |x| |n1| NIL))))))))))

; incTrunc (n,x)==
;      if #x>n
;      then SUBSTRING(x,0,n)
;      else x

(DEFUN |incTrunc| (|n| |x|)
  (PROG ()
    (RETURN (COND ((< |n| (LENGTH |x|)) (SUBSTRING |x| 0 |n|)) ('T |x|)))))

; incFileName x == first incBiteOff x

(DEFUN |incFileName| (|x|) (PROG () (RETURN (CAR (|incBiteOff| |x|)))))

; fileNameStrings fn==[PNAME(fn.0),PNAME(fn.1),PNAME(fn.2)]

(DEFUN |fileNameStrings| (|fn|)
  (PROG ()
    (RETURN
     (LIST (PNAME (ELT |fn| 0)) (PNAME (ELT |fn| 1)) (PNAME (ELT |fn| 2))))))

; ifCond(s, info) ==
;     word := INTERN DROPTRAILINGBLANKS(incCommandTail(s, info))
;     member(word, $inclAssertions)

(DEFUN |ifCond| (|s| |info|)
  (PROG (|word|)
    (RETURN
     (PROGN
      (SETQ |word| (INTERN (DROPTRAILINGBLANKS (|incCommandTail| |s| |info|))))
      (|member| |word| |$inclAssertions|)))))

; assertCond(s, info) ==
;     word := INTERN DROPTRAILINGBLANKS(incCommandTail(s, info))
;     if not member(word, $inclAssertions) then
;         $inclAssertions := [word, :$inclAssertions]

(DEFUN |assertCond| (|s| |info|)
  (PROG (|word|)
    (RETURN
     (PROGN
      (SETQ |word| (INTERN (DROPTRAILINGBLANKS (|incCommandTail| |s| |info|))))
      (COND
       ((NULL (|member| |word| |$inclAssertions|))
        (SETQ |$inclAssertions| (CONS |word| |$inclAssertions|))))))))

; incActive?(fn,ufos)==MEMBER(fn,ufos)

(DEFUN |incActive?| (|fn| |ufos|) (PROG () (RETURN (MEMBER |fn| |ufos|))))

; Top            := 01

(EVAL-WHEN (EVAL LOAD) (SETQ |Top| 1))

; IfSkipToEnd    := 10

(EVAL-WHEN (EVAL LOAD) (SETQ |IfSkipToEnd| 10))

; IfKeepPart     := 11

(EVAL-WHEN (EVAL LOAD) (SETQ |IfKeepPart| 11))

; IfSkipPart     := 12

(EVAL-WHEN (EVAL LOAD) (SETQ |IfSkipPart| 12))

; ElseifSkipToEnd:= 20

(EVAL-WHEN (EVAL LOAD) (SETQ |ElseifSkipToEnd| 20))

; ElseifKeepPart := 21

(EVAL-WHEN (EVAL LOAD) (SETQ |ElseifKeepPart| 21))

; ElseifSkipPart := 22

(EVAL-WHEN (EVAL LOAD) (SETQ |ElseifSkipPart| 22))

; ElseSkipToEnd  := 30

(EVAL-WHEN (EVAL LOAD) (SETQ |ElseSkipToEnd| 30))

; ElseKeepPart   := 31

(EVAL-WHEN (EVAL LOAD) (SETQ |ElseKeepPart| 31))

; Continuation   := 41

(EVAL-WHEN (EVAL LOAD) (SETQ |Continuation| 41))

; Top?     (st) == QUOTIENT(st,10) = 0

(DEFUN |Top?| (|st|) (PROG () (RETURN (EQL (QUOTIENT |st| 10) 0))))

; If?      (st) == QUOTIENT(st,10) = 1

(DEFUN |If?| (|st|) (PROG () (RETURN (EQL (QUOTIENT |st| 10) 1))))

; Elseif?  (st) == QUOTIENT(st,10) = 2

(DEFUN |Elseif?| (|st|) (PROG () (RETURN (EQL (QUOTIENT |st| 10) 2))))

; Else?    (st) == QUOTIENT(st,10) = 3

(DEFUN |Else?| (|st|) (PROG () (RETURN (EQL (QUOTIENT |st| 10) 3))))

; SkipEnd? (st) == REMAINDER(st,10) = 0

(DEFUN |SkipEnd?| (|st|) (PROG () (RETURN (EQL (REMAINDER |st| 10) 0))))

; KeepPart?(st) == REMAINDER(st,10) = 1

(DEFUN |KeepPart?| (|st|) (PROG () (RETURN (EQL (REMAINDER |st| 10) 1))))

; SkipPart?(st) == REMAINDER(st,10) = 2

(DEFUN |SkipPart?| (|st|) (PROG () (RETURN (EQL (REMAINDER |st| 10) 2))))

; Skipping?(st) == not KeepPart? st

(DEFUN |Skipping?| (|st|) (PROG () (RETURN (NULL (|KeepPart?| |st|)))))

; incHandleMessage(xl) ==
;           xl.1.1 = "none" =>
;               0
;           xl.1.1 = "error" =>
;               inclHandleError(incPos xl.0, xl.1.0)
;           xl.1.1 = "warning" =>
;               inclHandleWarning(incPos xl.0, xl.1.0)
;           xl.1.1 = "say" =>
;               inclHandleSay(incPos xl.0, xl.1.0)
;           inclHandleBug(incPos xl.0, xl.1.0)

(DEFUN |incHandleMessage| (|xl|)
  (PROG ()
    (RETURN
     (COND ((EQ (ELT (ELT |xl| 1) 1) '|none|) 0)
           ((EQ (ELT (ELT |xl| 1) 1) '|error|)
            (|inclHandleError| (|incPos| (ELT |xl| 0)) (ELT (ELT |xl| 1) 0)))
           ((EQ (ELT (ELT |xl| 1) 1) '|warning|)
            (|inclHandleWarning| (|incPos| (ELT |xl| 0)) (ELT (ELT |xl| 1) 0)))
           ((EQ (ELT (ELT |xl| 1) 1) '|say|)
            (|inclHandleSay| (|incPos| (ELT |xl| 0)) (ELT (ELT |xl| 1) 0)))
           ('T
            (|inclHandleBug| (|incPos| (ELT |xl| 0)) (ELT (ELT |xl| 1) 0)))))))

; xlOK(eb, str, lno, ufo)  ==
;                 [incLine(eb, str, -1, lno, ufo), [NIL, "none"]]

(DEFUN |xlOK| (|eb| |str| |lno| |ufo|)
  (PROG ()
    (RETURN
     (LIST (|incLine| |eb| |str| (- 1) |lno| |ufo|) (LIST NIL '|none|)))))

; xlOK1(eb, str,str1, lno, ufo)  ==
;                 [incLine1(eb, str,str1, -1, lno, ufo), [NIL, "none"]]

(DEFUN |xlOK1| (|eb| |str| |str1| |lno| |ufo|)
  (PROG ()
    (RETURN
     (LIST (|incLine1| |eb| |str| |str1| (- 1) |lno| |ufo|)
           (LIST NIL '|none|)))))

; incLine1(eb, str,str1, gno, lno, ufo) ==
;             ln := lnCreate(eb,str,gno,lno,ufo)
;             CONS(CONS(ln,1), str1)

(DEFUN |incLine1| (|eb| |str| |str1| |gno| |lno| |ufo|)
  (PROG (|ln|)
    (RETURN
     (PROGN
      (SETQ |ln| (|lnCreate| |eb| |str| |gno| |lno| |ufo|))
      (CONS (CONS |ln| 1) |str1|)))))

; xlSkip(eb, str, lno, ufo) ==
;         str := CONCAT('"-- Omitting:", str)
;         [incLine(eb, str, -1, lno, ufo), [NIL, "none"]]

(DEFUN |xlSkip| (|eb| |str| |lno| |ufo|)
  (PROG ()
    (RETURN
     (PROGN
      (SETQ |str| (CONCAT "-- Omitting:" |str|))
      (LIST (|incLine| |eb| |str| (- 1) |lno| |ufo|) (LIST NIL '|none|))))))

; xlMsg(eb, str, lno, ufo, mess) ==
;                 [incLine(eb, str, -1, lno, ufo), mess]

(DEFUN |xlMsg| (|eb| |str| |lno| |ufo| |mess|)
  (PROG () (RETURN (LIST (|incLine| |eb| |str| (- 1) |lno| |ufo|) |mess|))))

; xlPrematureEOF(eb, str, lno, ufos) ==
;           xlMsg(eb, str, lno,ufos.0,
;               [inclmsgPrematureEOF(ufos.0),"error"])

(DEFUN |xlPrematureEOF| (|eb| |str| |lno| |ufos|)
  (PROG ()
    (RETURN
     (|xlMsg| |eb| |str| |lno| (ELT |ufos| 0)
      (LIST (|inclmsgPrematureEOF| (ELT |ufos| 0)) '|error|)))))

; xlPrematureFin(eb, str, lno, ufos) ==
;           xlMsg(eb, str, lno,ufos.0,
;               [inclmsgPrematureFin(ufos.0),"error"])

(DEFUN |xlPrematureFin| (|eb| |str| |lno| |ufos|)
  (PROG ()
    (RETURN
     (|xlMsg| |eb| |str| |lno| (ELT |ufos| 0)
      (LIST (|inclmsgPrematureFin| (ELT |ufos| 0)) '|error|)))))

; xlFileCycle(eb, str, lno, ufos, fn) ==
;           xlMsg(eb, str, lno,ufos.0,
;               [inclmsgFileCycle(ufos,fn),"error"])

(DEFUN |xlFileCycle| (|eb| |str| |lno| |ufos| |fn|)
  (PROG ()
    (RETURN
     (|xlMsg| |eb| |str| |lno| (ELT |ufos| 0)
      (LIST (|inclmsgFileCycle| |ufos| |fn|) '|error|)))))

; xlNoFile(eb, str, lno, ufos) ==
;           xlMsg(eb, str, lno,ufos.0,
;               [inclmsgNoFile(), "error"])

(DEFUN |xlNoFile| (|eb| |str| |lno| |ufos|)
  (PROG ()
    (RETURN
     (|xlMsg| |eb| |str| |lno| (ELT |ufos| 0)
      (LIST (|inclmsgNoFile|) '|error|)))))

; xlCannotRead(eb, str, lno, ufos, fn) ==
;           xlMsg(eb, str, lno,ufos.0,
;               [inclmsgCannotRead(fn), "error"])

(DEFUN |xlCannotRead| (|eb| |str| |lno| |ufos| |fn|)
  (PROG ()
    (RETURN
     (|xlMsg| |eb| |str| |lno| (ELT |ufos| 0)
      (LIST (|inclmsgCannotRead| |fn|) '|error|)))))

; xlSkippingFin(eb, str, lno, ufos) ==
;           xlMsg(eb, str, lno,ufos.0,
;               [inclmsgFinSkipped(),"warning"])

(DEFUN |xlSkippingFin| (|eb| |str| |lno| |ufos|)
  (PROG ()
    (RETURN
     (|xlMsg| |eb| |str| |lno| (ELT |ufos| 0)
      (LIST (|inclmsgFinSkipped|) '|warning|)))))

; xlIfBug(eb, str, lno, ufos) ==
;           xlMsg(eb, str, lno,ufos.0,
;               [inclmsgIfBug(), "bug"])

(DEFUN |xlIfBug| (|eb| |str| |lno| |ufos|)
  (PROG ()
    (RETURN
     (|xlMsg| |eb| |str| |lno| (ELT |ufos| 0) (LIST (|inclmsgIfBug|) '|bug|)))))

; xlCmdBug(eb, str, lno, ufos) ==
;           xlMsg(eb, str, lno,ufos.0,
;               [inclmsgCmdBug(), "bug"])

(DEFUN |xlCmdBug| (|eb| |str| |lno| |ufos|)
  (PROG ()
    (RETURN
     (|xlMsg| |eb| |str| |lno| (ELT |ufos| 0)
      (LIST (|inclmsgCmdBug|) '|bug|)))))

; xlSay(eb, str, lno, ufos, x) ==
;           xlMsg(eb, str, lno,ufos.0,
;               [inclmsgSay(x), "say"])

(DEFUN |xlSay| (|eb| |str| |lno| |ufos| |x|)
  (PROG ()
    (RETURN
     (|xlMsg| |eb| |str| |lno| (ELT |ufos| 0)
      (LIST (|inclmsgSay| |x|) '|say|)))))

; xlIfSyntax(eb, str, lno,ufos,info,sts) ==
;           st := sts.0
;           found := info.2
;           context :=
;               Top? st  => "not in an )if...)endif"
;               Else? st => "after an )else"
;               "but can't figure out where"
;           xlMsg(eb, str, lno, ufos.0,
;                [inclmsgIfSyntax(ufos.0,found,context), "error"])

(DEFUN |xlIfSyntax| (|eb| |str| |lno| |ufos| |info| |sts|)
  (PROG (|st| |found| |context|)
    (RETURN
     (PROGN
      (SETQ |st| (ELT |sts| 0))
      (SETQ |found| (ELT |info| 2))
      (SETQ |context|
              (COND ((|Top?| |st|) '|not in an )if...)endif|)
                    ((|Else?| |st|) '|after an )else|)
                    ('T '|but can't figure out where|)))
      (|xlMsg| |eb| |str| |lno| (ELT |ufos| 0)
       (LIST (|inclmsgIfSyntax| (ELT |ufos| 0) |found| |context|) '|error|))))))

; incLude(eb, ss, ln, ufos, states) ==
;        Delay(function incLude1,[eb, ss, ln, ufos, states])

(DEFUN |incLude| (|eb| |ss| |ln| |ufos| |states|)
  (PROG ()
    (RETURN (|Delay| #'|incLude1| (LIST |eb| |ss| |ln| |ufos| |states|)))))

; Rest s ==> incLude(eb, rest ss, lno, ufos, states)

(DEFMACRO |Rest| (|bfVar#3|)
  (PROG ()
    (RETURN
     (SUBLIS (LIST (CONS '|bfVar#3| |bfVar#3|))
             '(|incLude| |eb| (CDR |ss|) |lno| |ufos| |states|)))))

; incLude1 (:z) ==
;             [eb, ss, ln, ufos, states]:=z
;             lno       := ln+1
;             state     := states.0
;
;             StreamNull ss =>
;                 not Top? state =>
;                     cons(xlPrematureEOF(eb,
;                      '")--premature end",  lno,ufos), StreamNil)
;                 StreamNil
;
;             str  :=  EXPAND_TABS(first(ss))
;             has_cont :=
;                 (nn := #str) < 1 => false
;                 str.(nn - 1) = char('"__")
;
;             state = Continuation =>
;                 rs :=
;                     has_cont => Rest(s)
;                     incLude(eb, rest ss, lno, ufos, rest(states))
;                 Skipping?(states.1) => cons(xlSkip(eb,str,lno,ufos.0), rs)
;                 cons(xlOK(eb, str, lno, ufos.0), rs)
;
;             info :=  incClassify str
;
;             not info.0 =>
;                 rs :=
;                     has_cont => incLude(eb, rest ss, lno, ufos,
;                                         cons(Continuation, states))
;                     Rest(s)
;                 Skipping? state => cons(xlSkip(eb,str,lno,ufos.0), rs)
;                 cons(xlOK(eb, str, lno, ufos.0), rs)
;
;             info.2 = '"other" =>
;                 Skipping? state => cons(xlSkip(eb,str,lno,ufos.0), Rest s)
;                 cons(xlOK1(eb, str,CONCAT('")command",str), lno, ufos.0),
;                                           Rest s)
;
;             info.2 = '"say" =>
;                 Skipping? state => cons(xlSkip(eb,str,lno,ufos.0), Rest s)
;                 str := incCommandTail(str, info)
;                 cons(xlSay(eb, str, lno, ufos, str),
;                      cons(xlOK(eb,str,lno,ufos.0), Rest s))
;
;             info.2 = '"include" =>
;                 Skipping? state =>
;                      cons(xlSkip(eb,str,lno,ufos.0), Rest s)
;                 fn1 := inclFname(str, info)
;                 not fn1 =>
;                     cons(xlNoFile(eb, str, lno, ufos), Rest s)
;                 not PROBE_-FILE fn1 =>
;                     cons(xlCannotRead(eb, str, lno,ufos,fn1),Rest s)
;                 incActive?(fn1,ufos) =>
;                     cons(xlFileCycle (eb, str, lno,ufos,fn1),Rest s)
;                 Includee  :=
;                   incLude(eb+info.1,incFileInput fn1,0,
;                             cons(fn1,ufos), cons(Top,states))
;                 cons(
;                     xlOK(eb,str,lno,ufos.0),
;                           incAppend(Includee, Rest s))
;
;             info.2 = '"fin" =>
;                 Skipping? state =>
;                     cons(xlSkippingFin(eb, str, lno,ufos), Rest s)
;                 not Top? state  =>
;                     cons(xlPrematureFin(eb, str, lno,ufos), StreamNil)
;                 cons(xlOK(eb,str,lno,ufos.0), StreamNil)
;
;             info.2 = '"assert" =>
;                 Skipping? state =>
;                     cons(xlSkippingFin(eb, str, lno,ufos), Rest s)
;                 assertCond(str, info)
;                 cons(xlOK(eb,str,lno,ufos.0), incAppend(Includee, Rest s))
;
;             info.2 = '"if" =>
;                 s1 :=
;                     Skipping? state => IfSkipToEnd
;                     if ifCond(str,info) then IfKeepPart else IfSkipPart
;                 cons(xlOK(eb,str,lno,ufos.0),
;                       incLude(eb, rest ss, lno, ufos, cons(s1, states)))
;             info.2 = '"elseif" =>
;                 not If? state and not Elseif? state =>
;                     cons(xlIfSyntax(eb, str,lno,ufos,info,states),
;                             StreamNil)
;
;                 if SkipEnd? state or KeepPart? state or SkipPart? state
;                 then
;                      s1:=if SkipPart? state
;                          then
;                             pred := ifCond(str,info)
;                             if pred
;                             then ElseifKeepPart
;                             else ElseifSkipPart
;                          else ElseifSkipToEnd
;                      cons(xlOK(eb,str,lno,ufos.0),
;                         incLude(eb, rest ss, lno, ufos, cons(s1, rest states)))
;                 else
;                     cons(xlIfBug(eb, str, lno,ufos), StreamNil)
;
;             info.2 = '"else" =>
;                 not If? state and not Elseif? state =>
;                     cons(xlIfSyntax(eb, str,lno,ufos,info,states),
;                            StreamNil)
;                 if SkipEnd? state or KeepPart? state or SkipPart? state
;                 then
;                       s1 :=if SkipPart? state
;                            then ElseKeepPart
;                            else ElseSkipToEnd
;                       cons(xlOK(eb,str,lno,ufos.0),
;                         incLude(eb, rest ss, lno, ufos, cons(s1, rest states)))
;                 else
;                     cons(xlIfBug(eb, str, lno,ufos), StreamNil)
;
;             info.2 = '"endif" =>
;                 Top? state =>
;                     cons(xlIfSyntax(eb, str,lno,ufos,info,states),
;                         StreamNil)
;                 cons(xlOK(eb,str,lno,ufos.0),
;                          incLude(eb, rest ss, lno, ufos, rest states))
;
;             cons(xlCmdBug(eb, str, lno,ufos), StreamNil)

(DEFUN |incLude1| (&REST |z|)
  (PROG (|eb| |ss| |ln| |ufos| |states| |lno| |state| |str| |nn| |has_cont|
         |rs| |info| |fn1| |Includee| |s1| |pred|)
    (RETURN
     (PROGN
      (SETQ |eb| (CAR |z|))
      (SETQ |ss| (CADR . #1=(|z|)))
      (SETQ |ln| (CADDR . #1#))
      (SETQ |ufos| (CADDDR . #1#))
      (SETQ |states| (CAR (CDDDDR . #1#)))
      (SETQ |lno| (+ |ln| 1))
      (SETQ |state| (ELT |states| 0))
      (COND
       ((|StreamNull| |ss|)
        (COND
         ((NULL (|Top?| |state|))
          (CONS (|xlPrematureEOF| |eb| ")--premature end" |lno| |ufos|)
                |StreamNil|))
         (#2='T |StreamNil|)))
       (#2#
        (PROGN
         (SETQ |str| (EXPAND_TABS (CAR |ss|)))
         (SETQ |has_cont|
                 (COND ((< (SETQ |nn| (LENGTH |str|)) 1) NIL)
                       (#2# (EQUAL (ELT |str| (- |nn| 1)) (|char| "_")))))
         (COND
          ((EQUAL |state| |Continuation|)
           (PROGN
            (SETQ |rs|
                    (COND (|has_cont| (|Rest| |s|))
                          (#2#
                           (|incLude| |eb| (CDR |ss|) |lno| |ufos|
                            (CDR |states|)))))
            (COND
             ((|Skipping?| (ELT |states| 1))
              (CONS (|xlSkip| |eb| |str| |lno| (ELT |ufos| 0)) |rs|))
             (#2# (CONS (|xlOK| |eb| |str| |lno| (ELT |ufos| 0)) |rs|)))))
          (#2#
           (PROGN
            (SETQ |info| (|incClassify| |str|))
            (COND
             ((NULL (ELT |info| 0))
              (PROGN
               (SETQ |rs|
                       (COND
                        (|has_cont|
                         (|incLude| |eb| (CDR |ss|) |lno| |ufos|
                          (CONS |Continuation| |states|)))
                        (#2# (|Rest| |s|))))
               (COND
                ((|Skipping?| |state|)
                 (CONS (|xlSkip| |eb| |str| |lno| (ELT |ufos| 0)) |rs|))
                (#2# (CONS (|xlOK| |eb| |str| |lno| (ELT |ufos| 0)) |rs|)))))
             ((EQUAL (ELT |info| 2) "other")
              (COND
               ((|Skipping?| |state|)
                (CONS (|xlSkip| |eb| |str| |lno| (ELT |ufos| 0)) (|Rest| |s|)))
               (#2#
                (CONS
                 (|xlOK1| |eb| |str| (CONCAT ")command" |str|) |lno|
                  (ELT |ufos| 0))
                 (|Rest| |s|)))))
             ((EQUAL (ELT |info| 2) "say")
              (COND
               ((|Skipping?| |state|)
                (CONS (|xlSkip| |eb| |str| |lno| (ELT |ufos| 0)) (|Rest| |s|)))
               (#2#
                (PROGN
                 (SETQ |str| (|incCommandTail| |str| |info|))
                 (CONS (|xlSay| |eb| |str| |lno| |ufos| |str|)
                       (CONS (|xlOK| |eb| |str| |lno| (ELT |ufos| 0))
                             (|Rest| |s|)))))))
             ((EQUAL (ELT |info| 2) "include")
              (COND
               ((|Skipping?| |state|)
                (CONS (|xlSkip| |eb| |str| |lno| (ELT |ufos| 0)) (|Rest| |s|)))
               (#2#
                (PROGN
                 (SETQ |fn1| (|inclFname| |str| |info|))
                 (COND
                  ((NULL |fn1|)
                   (CONS (|xlNoFile| |eb| |str| |lno| |ufos|) (|Rest| |s|)))
                  ((NULL (PROBE-FILE |fn1|))
                   (CONS (|xlCannotRead| |eb| |str| |lno| |ufos| |fn1|)
                         (|Rest| |s|)))
                  ((|incActive?| |fn1| |ufos|)
                   (CONS (|xlFileCycle| |eb| |str| |lno| |ufos| |fn1|)
                         (|Rest| |s|)))
                  (#2#
                   (PROGN
                    (SETQ |Includee|
                            (|incLude| (+ |eb| (ELT |info| 1))
                             (|incFileInput| |fn1|) 0 (CONS |fn1| |ufos|)
                             (CONS |Top| |states|)))
                    (CONS (|xlOK| |eb| |str| |lno| (ELT |ufos| 0))
                          (|incAppend| |Includee| (|Rest| |s|))))))))))
             ((EQUAL (ELT |info| 2) "fin")
              (COND
               ((|Skipping?| |state|)
                (CONS (|xlSkippingFin| |eb| |str| |lno| |ufos|) (|Rest| |s|)))
               ((NULL (|Top?| |state|))
                (CONS (|xlPrematureFin| |eb| |str| |lno| |ufos|) |StreamNil|))
               (#2#
                (CONS (|xlOK| |eb| |str| |lno| (ELT |ufos| 0)) |StreamNil|))))
             ((EQUAL (ELT |info| 2) "assert")
              (COND
               ((|Skipping?| |state|)
                (CONS (|xlSkippingFin| |eb| |str| |lno| |ufos|) (|Rest| |s|)))
               (#2#
                (PROGN
                 (|assertCond| |str| |info|)
                 (CONS (|xlOK| |eb| |str| |lno| (ELT |ufos| 0))
                       (|incAppend| |Includee| (|Rest| |s|)))))))
             ((EQUAL (ELT |info| 2) "if")
              (PROGN
               (SETQ |s1|
                       (COND ((|Skipping?| |state|) |IfSkipToEnd|)
                             (#2#
                              (COND ((|ifCond| |str| |info|) |IfKeepPart|)
                                    (#2# |IfSkipPart|)))))
               (CONS (|xlOK| |eb| |str| |lno| (ELT |ufos| 0))
                     (|incLude| |eb| (CDR |ss|) |lno| |ufos|
                      (CONS |s1| |states|)))))
             ((EQUAL (ELT |info| 2) "elseif")
              (COND
               ((AND (NULL (|If?| |state|)) (NULL (|Elseif?| |state|)))
                (CONS (|xlIfSyntax| |eb| |str| |lno| |ufos| |info| |states|)
                      |StreamNil|))
               (#2#
                (COND
                 ((OR (|SkipEnd?| |state|) (|KeepPart?| |state|)
                      (|SkipPart?| |state|))
                  (SETQ |s1|
                          (COND
                           ((|SkipPart?| |state|)
                            (SETQ |pred| (|ifCond| |str| |info|))
                            (COND (|pred| |ElseifKeepPart|)
                                  (#2# |ElseifSkipPart|)))
                           (#2# |ElseifSkipToEnd|)))
                  (CONS (|xlOK| |eb| |str| |lno| (ELT |ufos| 0))
                        (|incLude| |eb| (CDR |ss|) |lno| |ufos|
                         (CONS |s1| (CDR |states|)))))
                 (#2#
                  (CONS (|xlIfBug| |eb| |str| |lno| |ufos|) |StreamNil|))))))
             ((EQUAL (ELT |info| 2) "else")
              (COND
               ((AND (NULL (|If?| |state|)) (NULL (|Elseif?| |state|)))
                (CONS (|xlIfSyntax| |eb| |str| |lno| |ufos| |info| |states|)
                      |StreamNil|))
               (#2#
                (COND
                 ((OR (|SkipEnd?| |state|) (|KeepPart?| |state|)
                      (|SkipPart?| |state|))
                  (SETQ |s1|
                          (COND ((|SkipPart?| |state|) |ElseKeepPart|)
                                (#2# |ElseSkipToEnd|)))
                  (CONS (|xlOK| |eb| |str| |lno| (ELT |ufos| 0))
                        (|incLude| |eb| (CDR |ss|) |lno| |ufos|
                         (CONS |s1| (CDR |states|)))))
                 (#2#
                  (CONS (|xlIfBug| |eb| |str| |lno| |ufos|) |StreamNil|))))))
             ((EQUAL (ELT |info| 2) "endif")
              (COND
               ((|Top?| |state|)
                (CONS (|xlIfSyntax| |eb| |str| |lno| |ufos| |info| |states|)
                      |StreamNil|))
               (#2#
                (CONS (|xlOK| |eb| |str| |lno| (ELT |ufos| 0))
                      (|incLude| |eb| (CDR |ss|) |lno| |ufos|
                       (CDR |states|))))))
             (#2#
              (CONS (|xlCmdBug| |eb| |str| |lno| |ufos|)
                    |StreamNil|)))))))))))))

; inclHandleError(pos, [key, args]) ==
;     ncSoftError(pos, key, args)

(DEFUN |inclHandleError| (|pos| |bfVar#4|)
  (PROG (|key| |args|)
    (RETURN
     (PROGN
      (SETQ |key| (CAR |bfVar#4|))
      (SETQ |args| (CADR |bfVar#4|))
      (|ncSoftError| |pos| |key| |args|)))))

; inclHandleWarning(pos, [key, args]) ==
;     ncSoftError(pos, key,args)

(DEFUN |inclHandleWarning| (|pos| |bfVar#5|)
  (PROG (|key| |args|)
    (RETURN
     (PROGN
      (SETQ |key| (CAR |bfVar#5|))
      (SETQ |args| (CADR |bfVar#5|))
      (|ncSoftError| |pos| |key| |args|)))))

; inclHandleBug(pos, [key, args]) ==
;     ncBug(key, args)

(DEFUN |inclHandleBug| (|pos| |bfVar#6|)
  (PROG (|key| |args|)
    (RETURN
     (PROGN
      (SETQ |key| (CAR |bfVar#6|))
      (SETQ |args| (CADR |bfVar#6|))
      (|ncBug| |key| |args|)))))

; inclHandleSay(pos, [key, args]) ==
;     ncSoftError(pos, key, args)

(DEFUN |inclHandleSay| (|pos| |bfVar#7|)
  (PROG (|key| |args|)
    (RETURN
     (PROGN
      (SETQ |key| (CAR |bfVar#7|))
      (SETQ |args| (CADR |bfVar#7|))
      (|ncSoftError| |pos| |key| |args|)))))

; inclmsgSay str  ==
;     ['S2CI0001, [%id str]]

(DEFUN |inclmsgSay| (|str|)
  (PROG () (RETURN (LIST 'S2CI0001 (LIST (|%id| |str|))))))

; inclmsgPrematureEOF ufo  ==
;     ['S2CI0002, [%origin ufo]]

(DEFUN |inclmsgPrematureEOF| (|ufo|)
  (PROG () (RETURN (LIST 'S2CI0002 (LIST (|%origin| |ufo|))))))

; inclmsgPrematureFin ufo  ==
;     ['S2CI0003, [%origin ufo]]

(DEFUN |inclmsgPrematureFin| (|ufo|)
  (PROG () (RETURN (LIST 'S2CI0003 (LIST (|%origin| |ufo|))))))

; inclmsgFileCycle(ufos,fn) ==
;     flist := [porigin n for n in reverse ufos]
;     f1    := porigin fn
;     cycle := [:[:[n,'"==>"] for n in flist], f1]
;     ['S2CI0004, [%id cycle, %id f1]]

(DEFUN |inclmsgFileCycle| (|ufos| |fn|)
  (PROG (|flist| |f1| |cycle|)
    (RETURN
     (PROGN
      (SETQ |flist|
              ((LAMBDA (|bfVar#9| |bfVar#8| |n|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#8|)
                        (PROGN (SETQ |n| (CAR |bfVar#8|)) NIL))
                    (RETURN (NREVERSE |bfVar#9|)))
                   (#1='T (SETQ |bfVar#9| (CONS (|porigin| |n|) |bfVar#9|))))
                  (SETQ |bfVar#8| (CDR |bfVar#8|))))
               NIL (REVERSE |ufos|) NIL))
      (SETQ |f1| (|porigin| |fn|))
      (SETQ |cycle|
              (APPEND
               ((LAMBDA (|bfVar#11| |bfVar#10| |n|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#10|)
                         (PROGN (SETQ |n| (CAR |bfVar#10|)) NIL))
                     (RETURN (NREVERSE |bfVar#11|)))
                    (#1#
                     (SETQ |bfVar#11|
                             (APPEND (REVERSE (LIST |n| "==>")) |bfVar#11|))))
                   (SETQ |bfVar#10| (CDR |bfVar#10|))))
                NIL |flist| NIL)
               (CONS |f1| NIL)))
      (LIST 'S2CI0004 (LIST (|%id| |cycle|) (|%id| |f1|)))))))

; inclmsgFinSkipped() ==
;     ['S2CI0008, []]

(DEFUN |inclmsgFinSkipped| () (PROG () (RETURN (LIST 'S2CI0008 NIL))))

; inclmsgIfSyntax(ufo,found,context) ==
;     found := CONCAT('")", found)
;     ['S2CI0009, [%id found, %id context, %origin ufo]]

(DEFUN |inclmsgIfSyntax| (|ufo| |found| |context|)
  (PROG ()
    (RETURN
     (PROGN
      (SETQ |found| (CONCAT ")" |found|))
      (LIST 'S2CI0009
            (LIST (|%id| |found|) (|%id| |context|) (|%origin| |ufo|)))))))

; inclmsgNoFile() ==
;     ['S2CI0010, []]

(DEFUN |inclmsgNoFile| () (PROG () (RETURN (LIST 'S2CI0010 NIL))))

; inclmsgCannotRead fn ==
;     ['S2CI0011, [fn]]

(DEFUN |inclmsgCannotRead| (|fn|)
  (PROG () (RETURN (LIST 'S2CI0011 (LIST |fn|)))))

; inclmsgIfBug() ==
;     ['S2CB0002, []]

(DEFUN |inclmsgIfBug| () (PROG () (RETURN (LIST 'S2CB0002 NIL))))

; inclmsgCmdBug() ==
;     ['S2CB0003, []]

(DEFUN |inclmsgCmdBug| () (PROG () (RETURN (LIST 'S2CB0003 NIL))))
