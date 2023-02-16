
; )package "BOOT"

(IN-PACKAGE "BOOT")

; dqUnit s==(a:=[s];CONS(a,a))

(DEFUN |dqUnit| (|s|)
  (PROG (|a|) (RETURN (PROGN (SETQ |a| (LIST |s|)) (CONS |a| |a|)))))

; dqAppend(x,y)==
;     if null x
;     then y
;     else if null y
;          then x
;          else
;               RPLACD(CDR x, first y)
;               RPLACD (x,    CDR y)
;               x

(DEFUN |dqAppend| (|x| |y|)
  (PROG ()
    (RETURN
     (COND ((NULL |x|) |y|) ((NULL |y|) |x|)
           ('T (RPLACD (CDR |x|) (CAR |y|)) (RPLACD |x| (CDR |y|)) |x|)))))

; dqConcat ld==
;     if null ld
;     then nil
;     else if null rest ld
;          then first ld
;          else dqAppend(first ld,dqConcat rest ld)

(DEFUN |dqConcat| (|ld|)
  (PROG ()
    (RETURN
     (COND ((NULL |ld|) NIL) ((NULL (CDR |ld|)) (CAR |ld|))
           ('T (|dqAppend| (CAR |ld|) (|dqConcat| (CDR |ld|))))))))

; dqToList s == if null s then nil else first s

(DEFUN |dqToList| (|s|)
  (PROG () (RETURN (COND ((NULL |s|) NIL) ('T (CAR |s|))))))

; pileColumn t == rest tokPosn CAAR t

(DEFUN |pileColumn| (|t|) (PROG () (RETURN (CDR (|tokPosn| (CAAR |t|))))))

; pileComment t== EQ(tokType CAAR t,"negcomment")

(DEFUN |pileComment| (|t|)
  (PROG () (RETURN (EQ (|tokType| (CAAR |t|)) '|negcomment|))))

; pilePlusComment t== EQ(tokType CAAR t,"comment")

(DEFUN |pilePlusComment| (|t|)
  (PROG () (RETURN (EQ (|tokType| (CAAR |t|)) '|comment|))))

; countParens(s, opar, cpar) ==
;    ress := 0
;    for stok in dqToList s repeat
;       t := tokPart stok
;       if EQ(CAAR stok,"key") and EQ(t, opar) then
;           ress := ress + 1
;       if EQ(CAAR stok,"key") and EQ(t, cpar) then
;           ress := ress - 1
;    ress

(DEFUN |countParens| (|s| |opar| |cpar|)
  (PROG (|ress| |t|)
    (RETURN
     (PROGN
      (SETQ |ress| 0)
      ((LAMBDA (|bfVar#1| |stok|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#1|) (PROGN (SETQ |stok| (CAR |bfVar#1|)) NIL))
            (RETURN NIL))
           ('T
            (PROGN
             (SETQ |t| (|tokPart| |stok|))
             (COND
              ((AND (EQ (CAAR |stok|) '|key|) (EQ |t| |opar|))
               (SETQ |ress| (+ |ress| 1))))
             (COND
              ((AND (EQ (CAAR |stok|) '|key|) (EQ |t| |cpar|))
               (SETQ |ress| (- |ress| 1)))))))
          (SETQ |bfVar#1| (CDR |bfVar#1|))))
       (|dqToList| |s|) NIL)
      |ress|))))

; nopile (s, opar, cpar) ==
;    -- SAY("nopile")
;    if npNull s
;    then [false,0,[],s]
;    else
;       [h,t]:=[car s,cdr s]
;       h := car h
;       ress := h
;       balance := countParens(h, opar, cpar)
;       -- SAY("balance = ", balance)
;       while not npNull t and balance > 0 repeat
;          h := car (car t)
;          t := cdr t
;          ress := dqAppend(ress, h)
;          balance := balance + countParens(h, opar, cpar)
;          -- SAY("balance = ", balance)
;       -- SAY("ress=", ress)
;       -- FIXME: we should return a pair [deque, stream], but
;       -- now we return nil instead of a stream
;       cons([[ress]], t)

(DEFUN |nopile| (|s| |opar| |cpar|)
  (PROG (|LETTMP#1| |h| |t| |ress| |balance|)
    (RETURN
     (COND ((|npNull| |s|) (LIST NIL 0 NIL |s|))
           (#1='T (SETQ |LETTMP#1| (LIST (CAR |s|) (CDR |s|)))
            (SETQ |h| (CAR |LETTMP#1|)) (SETQ |t| (CADR |LETTMP#1|))
            (SETQ |h| (CAR |h|)) (SETQ |ress| |h|)
            (SETQ |balance| (|countParens| |h| |opar| |cpar|))
            ((LAMBDA ()
               (LOOP
                (COND
                 ((NOT (AND (NULL (|npNull| |t|)) (< 0 |balance|)))
                  (RETURN NIL))
                 (#1#
                  (PROGN
                   (SETQ |h| (CAR (CAR |t|)))
                   (SETQ |t| (CDR |t|))
                   (SETQ |ress| (|dqAppend| |ress| |h|))
                   (SETQ |balance|
                           (+ |balance|
                              (|countParens| |h| |opar| |cpar|)))))))))
            (CONS (LIST (LIST |ress|)) |t|))))))

; DEFPARAMETER($nopiles, false)

(DEFPARAMETER |$nopiles| NIL)

; setNopiles (t) ==
;     $nopiles := t

(DEFUN |setNopiles| (|t|) (PROG () (RETURN (SETQ |$nopiles| |t|))))

; piles () ==
;     $nopiles := false

(DEFUN |piles| () (PROG () (RETURN (SETQ |$nopiles| NIL))))

; insertpile (s)==
;      $nopiles = "{" => nopile (s, "{", "}")
;      $nopiles = "(" => nopile (s, "(", ")")
;      if npNull s
;      then [false,0,[],s]
;      else
;        [h,t]:=[car s,cdr s]
;        if pilePlusComment h
;        then
;           [h1,t1]:=pilePlusComments s
;           a:=pileTree(-1,t1)
;           cons([pileCforest [:h1,a.2]],a.3)
;        else
;          stream:=CADAR s
;          a:=pileTree(-1,s)
;          cons([[a.2,stream]],a.3)

(DEFUN |insertpile| (|s|)
  (PROG (|LETTMP#1| |h| |t| |h1| |t1| |a| |stream|)
    (RETURN
     (COND ((EQ |$nopiles| '{) (|nopile| |s| '{ '}))
           ((EQ |$nopiles| '|(|) (|nopile| |s| '|(| '|)|))
           (#1='T
            (COND ((|npNull| |s|) (LIST NIL 0 NIL |s|))
                  (#1# (SETQ |LETTMP#1| (LIST (CAR |s|) (CDR |s|)))
                   (SETQ |h| (CAR |LETTMP#1|)) (SETQ |t| (CADR |LETTMP#1|))
                   (COND
                    ((|pilePlusComment| |h|)
                     (SETQ |LETTMP#1| (|pilePlusComments| |s|))
                     (SETQ |h1| (CAR |LETTMP#1|)) (SETQ |t1| (CADR |LETTMP#1|))
                     (SETQ |a| (|pileTree| (- 1) |t1|))
                     (CONS
                      (LIST
                       (|pileCforest| (APPEND |h1| (CONS (ELT |a| 2) NIL))))
                      (ELT |a| 3)))
                    (#1# (SETQ |stream| (CADAR |s|))
                     (SETQ |a| (|pileTree| (- 1) |s|))
                     (CONS (LIST (LIST (ELT |a| 2) |stream|))
                           (ELT |a| 3)))))))))))

; pilePlusComments s==
;       if npNull s
;       then [[],s]
;       else
;        [h,t]:=[car s,cdr s]
;        if pilePlusComment h
;        then
;          [h1,t1]:=pilePlusComments t
;          [cons(h,h1),t1]
;        else [[],s]

(DEFUN |pilePlusComments| (|s|)
  (PROG (|LETTMP#1| |h| |t| |h1| |t1|)
    (RETURN
     (COND ((|npNull| |s|) (LIST NIL |s|))
           (#1='T (SETQ |LETTMP#1| (LIST (CAR |s|) (CDR |s|)))
            (SETQ |h| (CAR |LETTMP#1|)) (SETQ |t| (CADR |LETTMP#1|))
            (COND
             ((|pilePlusComment| |h|)
              (SETQ |LETTMP#1| (|pilePlusComments| |t|))
              (SETQ |h1| (CAR |LETTMP#1|)) (SETQ |t1| (CADR |LETTMP#1|))
              (LIST (CONS |h| |h1|) |t1|))
             (#1# (LIST NIL |s|))))))))

; pileTree(n,s)==
;     if npNull s
;     then [false,n,[],s]
;     else
;         [h,t]:=[car s,cdr s]
;         hh := pileColumn first h
;         if hh > n
;         then pileForests(first h, hh, t)
;         else [false,n,[],s]

(DEFUN |pileTree| (|n| |s|)
  (PROG (|LETTMP#1| |h| |t| |hh|)
    (RETURN
     (COND ((|npNull| |s|) (LIST NIL |n| NIL |s|))
           (#1='T (SETQ |LETTMP#1| (LIST (CAR |s|) (CDR |s|)))
            (SETQ |h| (CAR |LETTMP#1|)) (SETQ |t| (CADR |LETTMP#1|))
            (SETQ |hh| (|pileColumn| (CAR |h|)))
            (COND ((< |n| |hh|) (|pileForests| (CAR |h|) |hh| |t|))
                  (#1# (LIST NIL |n| NIL |s|))))))))

; eqpileTree(n,s)==
;     if npNull s
;     then [false,n,[],s]
;     else
;         [h,t]:=[car s,cdr s]
;         hh := pileColumn first h
;         if hh = n
;         then pileForests(first h, hh, t)
;         else [false,n,[],s]

(DEFUN |eqpileTree| (|n| |s|)
  (PROG (|LETTMP#1| |h| |t| |hh|)
    (RETURN
     (COND ((|npNull| |s|) (LIST NIL |n| NIL |s|))
           (#1='T (SETQ |LETTMP#1| (LIST (CAR |s|) (CDR |s|)))
            (SETQ |h| (CAR |LETTMP#1|)) (SETQ |t| (CADR |LETTMP#1|))
            (SETQ |hh| (|pileColumn| (CAR |h|)))
            (COND ((EQUAL |hh| |n|) (|pileForests| (CAR |h|) |hh| |t|))
                  (#1# (LIST NIL |n| NIL |s|))))))))

; pileForest(n,s)==
;      [b,hh,h,t]:= pileTree(n,s)
;      if b
;      then
;        [h1,t1]:=pileForest1(hh,t)
;        [cons(h,h1),t1]
;      else [[],s]

(DEFUN |pileForest| (|n| |s|)
  (PROG (|LETTMP#1| |b| |hh| |h| |t| |h1| |t1|)
    (RETURN
     (PROGN
      (SETQ |LETTMP#1| (|pileTree| |n| |s|))
      (SETQ |b| (CAR |LETTMP#1|))
      (SETQ |hh| (CADR . #1=(|LETTMP#1|)))
      (SETQ |h| (CADDR . #1#))
      (SETQ |t| (CADDDR . #1#))
      (COND
       (|b| (SETQ |LETTMP#1| (|pileForest1| |hh| |t|))
        (SETQ |h1| (CAR |LETTMP#1|)) (SETQ |t1| (CADR |LETTMP#1|))
        (LIST (CONS |h| |h1|) |t1|))
       ('T (LIST NIL |s|)))))))

; pileForest1(n,s)==
;      [b,n1,h,t]:= eqpileTree(n,s)
;      if b
;      then
;        [h1,t1]:=pileForest1(n,t)
;        [cons(h,h1),t1]
;      else [[],s]

(DEFUN |pileForest1| (|n| |s|)
  (PROG (|LETTMP#1| |b| |n1| |h| |t| |h1| |t1|)
    (RETURN
     (PROGN
      (SETQ |LETTMP#1| (|eqpileTree| |n| |s|))
      (SETQ |b| (CAR |LETTMP#1|))
      (SETQ |n1| (CADR . #1=(|LETTMP#1|)))
      (SETQ |h| (CADDR . #1#))
      (SETQ |t| (CADDDR . #1#))
      (COND
       (|b| (SETQ |LETTMP#1| (|pileForest1| |n| |t|))
        (SETQ |h1| (CAR |LETTMP#1|)) (SETQ |t1| (CADR |LETTMP#1|))
        (LIST (CONS |h| |h1|) |t1|))
       ('T (LIST NIL |s|)))))))

; pileForests(h,n,s)==
;       [h1,t1]:=pileForest(n,s)
;       if npNull h1
;       then [true,n,h,s]
;       else pileForests(pileCtree(h,h1),n,t1)

(DEFUN |pileForests| (|h| |n| |s|)
  (PROG (|LETTMP#1| |h1| |t1|)
    (RETURN
     (PROGN
      (SETQ |LETTMP#1| (|pileForest| |n| |s|))
      (SETQ |h1| (CAR |LETTMP#1|))
      (SETQ |t1| (CADR |LETTMP#1|))
      (COND ((|npNull| |h1|) (LIST T |n| |h| |s|))
            ('T (|pileForests| (|pileCtree| |h| |h1|) |n| |t1|)))))))

; pileCtree(x,y)==dqAppend(x,pileCforest y)

(DEFUN |pileCtree| (|x| |y|)
  (PROG () (RETURN (|dqAppend| |x| (|pileCforest| |y|)))))

; first_tok(t) == CAAR t

(DEFUN |first_tok| (|t|) (PROG () (RETURN (CAAR |t|))))

; last_tok(t) == CADR t

(DEFUN |last_tok| (|t|) (PROG () (RETURN (CADR |t|))))

; pileCforest x==
;    if null x
;    then []
;    else if null cdr x
;         then
;            f:= car x
;            if EQ(tokPart first_tok(f),"if")
;            then enPile f
;            else f
;         else enPile separatePiles x

(DEFUN |pileCforest| (|x|)
  (PROG (|f|)
    (RETURN
     (COND ((NULL |x|) NIL)
           ((NULL (CDR |x|)) (SETQ |f| (CAR |x|))
            (COND ((EQ (|tokPart| (|first_tok| |f|)) '|if|) (|enPile| |f|))
                  (#1='T |f|)))
           (#1# (|enPile| (|separatePiles| |x|)))))))

; firstTokPosn t== tokPosn first_tok(t)

(DEFUN |firstTokPosn| (|t|) (PROG () (RETURN (|tokPosn| (|first_tok| |t|)))))

; lastTokPosn  t== tokPosn last_tok(t)

(DEFUN |lastTokPosn| (|t|) (PROG () (RETURN (|tokPosn| (|last_tok| |t|)))))

; separatePiles x==
;   if null x
;   then []
;   else if null cdr x
;        then car x
;        else
;          a:=car x
;          lta := tokPart(last_tok(a))
;          ftb := tokPart(first_tok(car(cdr x)))
;          EQ(lta, ":") or EQ(lta, ";") or EQ(lta, "(") or
;            EQ(lta, "[") or EQ(lta, "{") or EQ(ftb, "in") or
;              EQ(ftb, "then") or EQ(ftb, "else") or EQ(ftb, ")") or
;                EQ(ftb, "]") or EQ(ftb, "}") =>
;                    dqConcat [a, separatePiles cdr x]
;          semicolon:=dqUnit tokConstruct("key", "BACKSET",lastTokPosn a)
;          dqConcat [a,semicolon,separatePiles cdr x]

(DEFUN |separatePiles| (|x|)
  (PROG (|a| |lta| |ftb| |semicolon|)
    (RETURN
     (COND ((NULL |x|) NIL) ((NULL (CDR |x|)) (CAR |x|))
           (#1='T (SETQ |a| (CAR |x|))
            (SETQ |lta| (|tokPart| (|last_tok| |a|)))
            (SETQ |ftb| (|tokPart| (|first_tok| (CAR (CDR |x|)))))
            (COND
             ((OR (EQ |lta| '|:|) (EQ |lta| '|;|) (EQ |lta| '|(|) (EQ |lta| '[)
                  (EQ |lta| '{) (EQ |ftb| '|in|) (EQ |ftb| '|then|)
                  (EQ |ftb| '|else|) (EQ |ftb| '|)|) (EQ |ftb| '])
                  (EQ |ftb| '}))
              (|dqConcat| (LIST |a| (|separatePiles| (CDR |x|)))))
             (#1#
              (PROGN
               (SETQ |semicolon|
                       (|dqUnit|
                        (|tokConstruct| '|key| 'BACKSET (|lastTokPosn| |a|))))
               (|dqConcat|
                (LIST |a| |semicolon| (|separatePiles| (CDR |x|))))))))))))

; enPile x==
;    dqConcat [dqUnit tokConstruct("key","SETTAB",firstTokPosn x),
;              x, _
;              dqUnit tokConstruct("key","BACKTAB",lastTokPosn  x)]

(DEFUN |enPile| (|x|)
  (PROG ()
    (RETURN
     (|dqConcat|
      (LIST (|dqUnit| (|tokConstruct| '|key| 'SETTAB (|firstTokPosn| |x|))) |x|
            (|dqUnit| (|tokConstruct| '|key| 'BACKTAB (|lastTokPosn| |x|))))))))
