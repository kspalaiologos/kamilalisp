
; )package "BOOT"

(IN-PACKAGE "BOOT")

; MKQ(X) ==
;     NUMBERP(X) => X
;     ['QUOTE, X]

(DEFUN MKQ (X) (PROG () (RETURN (COND ((NUMBERP X) X) ('T (LIST 'QUOTE X))))))

; INTERNL1(a, b) == INTERN(CONCAT(a, b))

(DEFUN INTERNL1 (|a| |b|) (PROG () (RETURN (INTERN (CONCAT |a| |b|)))))

; $GENNO := 0

(EVAL-WHEN (EVAL LOAD) (SETQ $GENNO 0))

; GENVAR() ==
;     INTERNL1('"$", STRINGIMAGE($GENNO := $GENNO + 1))

(DEFUN GENVAR ()
  (PROG () (RETURN (INTERNL1 "$" (STRINGIMAGE (SETQ $GENNO (+ $GENNO 1)))))))

; contained_eq(x, y) ==
;     ATOM(y) => EQ(x, y)
;     contained_eq(x, first(y)) or contained_eq(x, rest(y))

(DEFUN |contained_eq| (|x| |y|)
  (PROG ()
    (RETURN
     (COND ((ATOM |y|) (EQ |x| |y|))
           ('T
            (OR (|contained_eq| |x| (CAR |y|))
                (|contained_eq| |x| (CDR |y|))))))))

; contained_equal(x, y) ==
;     x = y => true
;     ATOM(y) => false
;     contained_equal(x, first(y)) or contained_equal(x, rest(y))

(DEFUN |contained_equal| (|x| |y|)
  (PROG ()
    (RETURN
     (COND ((EQUAL |x| |y|) T) ((ATOM |y|) NIL)
           ('T
            (OR (|contained_equal| |x| (CAR |y|))
                (|contained_equal| |x| (CDR |y|))))))))

; CONTAINED(x, y) ==
;     SYMBOLP(x) => contained_eq(x, y)
;     contained_equal(x, y)

(DEFUN CONTAINED (|x| |y|)
  (PROG ()
    (RETURN
     (COND ((SYMBOLP |x|) (|contained_eq| |x| |y|))
           ('T (|contained_equal| |x| |y|))))))

; ELEMN(l, n, def_val) ==
;     for i in 1..(n - 1) repeat
;         NULL(l) => return def_val
;         l := rest(l)
;     NULL(l) => def_val
;     first(l)

(DEFUN ELEMN (|l| |n| |def_val|)
  (PROG ()
    (RETURN
     (PROGN
      ((LAMBDA (|bfVar#1| |i|)
         (LOOP
          (COND ((> |i| |bfVar#1|) (RETURN NIL))
                (#1='T
                 (COND ((NULL |l|) (RETURN |def_val|))
                       (#1# (SETQ |l| (CDR |l|))))))
          (SETQ |i| (+ |i| 1))))
       (- |n| 1) 1)
      (COND ((NULL |l|) |def_val|) (#1# (CAR |l|)))))))

; LISTOFATOMS1(l, rl) ==
;     NULL(l) => rl
;     ATOM(l) => CONS(l, rl)
;     rl := LISTOFATOMS1(first(l), rl)
;     LISTOFATOMS1(rest(l), rl)

(DEFUN LISTOFATOMS1 (|l| |rl|)
  (PROG ()
    (RETURN
     (COND ((NULL |l|) |rl|) ((ATOM |l|) (CONS |l| |rl|))
           ('T
            (PROGN
             (SETQ |rl| (LISTOFATOMS1 (CAR |l|) |rl|))
             (LISTOFATOMS1 (CDR |l|) |rl|)))))))

; LISTOFATOMS(l) == NREVERSE(LISTOFATOMS1(l, []))

(DEFUN LISTOFATOMS (|l|) (PROG () (RETURN (NREVERSE (LISTOFATOMS1 |l| NIL)))))

; Identity x == x

(DEFUN |Identity| (|x|) (PROG () (RETURN |x|)))

; length1? l == PAIRP l and not PAIRP QCDR l

(DEFUN |length1?| (|l|)
  (PROG () (RETURN (AND (CONSP |l|) (NULL (CONSP (QCDR |l|)))))))

; length2? l == PAIRP l and PAIRP (l := QCDR l) and not PAIRP QCDR l

(DEFUN |length2?| (|l|)
  (PROG ()
    (RETURN
     (AND (CONSP |l|) (CONSP (SETQ |l| (QCDR |l|)))
          (NULL (CONSP (QCDR |l|)))))))

; pairList(u,v) == [[x,:y] for x in u for y in v]

(DEFUN |pairList| (|u| |v|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#4| |bfVar#2| |x| |bfVar#3| |y|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#2|) (PROGN (SETQ |x| (CAR |bfVar#2|)) NIL)
               (ATOM |bfVar#3|) (PROGN (SETQ |y| (CAR |bfVar#3|)) NIL))
           (RETURN (NREVERSE |bfVar#4|)))
          ('T (SETQ |bfVar#4| (CONS (CONS |x| |y|) |bfVar#4|))))
         (SETQ |bfVar#2| (CDR |bfVar#2|))
         (SETQ |bfVar#3| (CDR |bfVar#3|))))
      NIL |u| NIL |v| NIL))))

; concatenateStringList(l) ==
;     ll := 0
;     for s in l repeat ll := ll + LENGTH(s)
;     result := MAKE_-STRING(ll)
;     ll := 0
;     for s in l repeat
;         replaceString(result, s, ll)
;         ll := ll + LENGTH(s)
;     result

(DEFUN |concatenateStringList| (|l|)
  (PROG (|ll| |result|)
    (RETURN
     (PROGN
      (SETQ |ll| 0)
      ((LAMBDA (|bfVar#5| |s|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#5|) (PROGN (SETQ |s| (CAR |bfVar#5|)) NIL))
            (RETURN NIL))
           (#1='T (SETQ |ll| (+ |ll| (LENGTH |s|)))))
          (SETQ |bfVar#5| (CDR |bfVar#5|))))
       |l| NIL)
      (SETQ |result| (MAKE-STRING |ll|))
      (SETQ |ll| 0)
      ((LAMBDA (|bfVar#6| |s|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#6|) (PROGN (SETQ |s| (CAR |bfVar#6|)) NIL))
            (RETURN NIL))
           (#1#
            (PROGN
             (|replaceString| |result| |s| |ll|)
             (SETQ |ll| (+ |ll| (LENGTH |s|))))))
          (SETQ |bfVar#6| (CDR |bfVar#6|))))
       |l| NIL)
      |result|))))

; GETL(op, prop) == op and SYMBOLP(op) and GET(op, prop)

(DEFUN GETL (|op| |prop|)
  (PROG () (RETURN (AND |op| (SYMBOLP |op|) (GET |op| |prop|)))))

; GETALIST(alist,prop) == CDR assoc(prop,alist)

(DEFUN GETALIST (|alist| |prop|)
  (PROG () (RETURN (CDR (|assoc| |prop| |alist|)))))

; PUTALIST(alist,prop,val) ==
;   null alist => [[prop,:val]]
;   pair := assoc(prop,alist) =>
;     CDR pair = val => alist
;     -- else we fall over Lucid's read-only storage feature again
;     QRPLACD(pair,val)
;     alist
;   QRPLACD(LASTNODE alist,[[prop,:val]])
;   alist

(DEFUN PUTALIST (|alist| |prop| |val|)
  (PROG (|pair|)
    (RETURN
     (COND ((NULL |alist|) (LIST (CONS |prop| |val|)))
           ((SETQ |pair| (|assoc| |prop| |alist|))
            (COND ((EQUAL (CDR |pair|) |val|) |alist|)
                  (#1='T (PROGN (QRPLACD |pair| |val|) |alist|))))
           (#1#
            (PROGN
             (QRPLACD (LASTNODE |alist|) (LIST (CONS |prop| |val|)))
             |alist|))))))

; REMALIST(alist,prop) ==
;   null alist => alist
;   alist is [[ =prop,:.],:r] =>
;     null r => NIL
;     QRPLACA(alist,CAR r)
;     QRPLACD(alist,CDR r)
;     alist
;   null rest alist => alist
;   l := alist
;   ok := true
;   while ok repeat
;     [.,[p,:.],:r] := l
;     p = prop =>
;       ok := NIL
;       QRPLACD(l,r)
;     if null (l := QCDR l) or null rest l then ok := NIL
;   alist

(DEFUN REMALIST (|alist| |prop|)
  (PROG (|ISTMP#1| |r| |l| |ok| |p|)
    (RETURN
     (COND ((NULL |alist|) |alist|)
           ((AND (CONSP |alist|)
                 (PROGN
                  (SETQ |ISTMP#1| (CAR |alist|))
                  (AND (CONSP |ISTMP#1|) (EQUAL (CAR |ISTMP#1|) |prop|)))
                 (PROGN (SETQ |r| (CDR |alist|)) #1='T))
            (COND ((NULL |r|) NIL)
                  (#1#
                   (PROGN
                    (QRPLACA |alist| (CAR |r|))
                    (QRPLACD |alist| (CDR |r|))
                    |alist|))))
           ((NULL (CDR |alist|)) |alist|)
           (#1#
            (PROGN
             (SETQ |l| |alist|)
             (SETQ |ok| T)
             ((LAMBDA ()
                (LOOP
                 (COND ((NOT |ok|) (RETURN NIL))
                       (#1#
                        (PROGN
                         (SETQ |p| (CAADR . #2=(|l|)))
                         (SETQ |r| (CDDR . #2#))
                         (COND
                          ((EQUAL |p| |prop|)
                           (PROGN (SETQ |ok| NIL) (QRPLACD |l| |r|)))
                          (#1#
                           (COND
                            ((OR (NULL (SETQ |l| (QCDR |l|))) (NULL (CDR |l|)))
                             (SETQ |ok| NIL)))))))))))
             |alist|))))))

; deleteAssoc(x,y) ==
;   y is [[a,:.],:y'] =>
;    a=x => deleteAssoc(x,y')
;    [first y,:deleteAssoc(x,y')]
;   y

(DEFUN |deleteAssoc| (|x| |y|)
  (PROG (|ISTMP#1| |a| |y'|)
    (RETURN
     (COND
      ((AND (CONSP |y|)
            (PROGN
             (SETQ |ISTMP#1| (CAR |y|))
             (AND (CONSP |ISTMP#1|) (PROGN (SETQ |a| (CAR |ISTMP#1|)) #1='T)))
            (PROGN (SETQ |y'| (CDR |y|)) #1#))
       (COND ((EQUAL |a| |x|) (|deleteAssoc| |x| |y'|))
             (#1# (CONS (CAR |y|) (|deleteAssoc| |x| |y'|)))))
      (#1# |y|)))))

; insertWOC(x,y) ==
;   null y => [x]
;   (fn(x,y); y) where fn(x,y is [h,:t]) ==
;     x=h => nil
;     null t =>
;       RPLACD(y,[h,:t])
;       RPLACA(y,x)
;     fn(x,t)

(DEFUN |insertWOC| (|x| |y|)
  (PROG ()
    (RETURN
     (COND ((NULL |y|) (LIST |x|)) ('T (PROGN (|insertWOC,fn| |x| |y|) |y|))))))
(DEFUN |insertWOC,fn| (|x| |y|)
  (PROG (|h| |t|)
    (RETURN
     (PROGN
      (SETQ |h| (CAR |y|))
      (SETQ |t| (CDR |y|))
      (COND ((EQUAL |x| |h|) NIL)
            ((NULL |t|) (PROGN (RPLACD |y| (CONS |h| |t|)) (RPLACA |y| |x|)))
            ('T (|insertWOC,fn| |x| |t|)))))))

; fillerSpaces(n, charPart) ==
;   n <= 0 => '""
;   make_full_CVEC2(n, charPart)

(DEFUN |fillerSpaces| (|n| |charPart|)
  (PROG ()
    (RETURN
     (COND ((NOT (< 0 |n|)) "") ('T (|make_full_CVEC2| |n| |charPart|))))))

; centerString(text,width,fillchar) ==
;   wid := entryWidth text
;   wid >= width => text
;   f := DIVIDE(width - wid,2)
;   fill1 := ""
;   for i in 1..(f.0) repeat
;     fill1 := STRCONC(fillchar,fill1)
;   fill2:= fill1
;   if f.1 ~= 0 then fill1 := STRCONC(fillchar,fill1)
;   [fill1,text,fill2]

(DEFUN |centerString| (|text| |width| |fillchar|)
  (PROG (|wid| |f| |fill1| |fill2|)
    (RETURN
     (PROGN
      (SETQ |wid| (|entryWidth| |text|))
      (COND ((NOT (< |wid| |width|)) |text|)
            (#1='T
             (PROGN
              (SETQ |f| (DIVIDE (- |width| |wid|) 2))
              (SETQ |fill1| '||)
              ((LAMBDA (|bfVar#7| |i|)
                 (LOOP
                  (COND ((> |i| |bfVar#7|) (RETURN NIL))
                        (#1# (SETQ |fill1| (STRCONC |fillchar| |fill1|))))
                  (SETQ |i| (+ |i| 1))))
               (ELT |f| 0) 1)
              (SETQ |fill2| |fill1|)
              (COND
               ((NOT (EQL (ELT |f| 1) 0))
                (SETQ |fill1| (STRCONC |fillchar| |fill1|))))
              (LIST |fill1| |text| |fill2|))))))))

; stringPrefix?(pref,str) ==
;   -- sees if the first #pref letters of str are pref
;   -- replaces STRINGPREFIXP
;   null (STRINGP(pref) and STRINGP(str)) => NIL
;   (lp := QCSIZE pref) = 0 => true
;   lp > QCSIZE str => NIL
;   ok := true
;   i := 0
;   while ok and (i < lp) repeat
;     not EQL(SCHAR(pref,i),SCHAR(str,i)) => ok := NIL
;     i := i + 1
;   ok

(DEFUN |stringPrefix?| (|pref| |str|)
  (PROG (|lp| |ok| |i|)
    (RETURN
     (COND ((NULL (AND (STRINGP |pref|) (STRINGP |str|))) NIL)
           ((EQL (SETQ |lp| (QCSIZE |pref|)) 0) T)
           ((< (QCSIZE |str|) |lp|) NIL)
           (#1='T
            (PROGN
             (SETQ |ok| T)
             (SETQ |i| 0)
             ((LAMBDA ()
                (LOOP
                 (COND ((NOT (AND |ok| (< |i| |lp|))) (RETURN NIL))
                       (#1#
                        (COND
                         ((NULL (EQL (SCHAR |pref| |i|) (SCHAR |str| |i|)))
                          (SETQ |ok| NIL))
                         (#1# (SETQ |i| (+ |i| 1)))))))))
             |ok|))))))

; dropLeadingBlanks str ==
;   str := object2String str
;   l := QCSIZE str
;   nb := NIL
;   i := 0
;   while (i < l) and not nb repeat
;     if SCHAR(str,i) ~= SCHAR('" ",0) then nb := i
;     else i := i + 1
;   nb = 0 => str
;   nb => SUBSTRING(str,nb,NIL)
;   '""

(DEFUN |dropLeadingBlanks| (|str|)
  (PROG (|l| |nb| |i|)
    (RETURN
     (PROGN
      (SETQ |str| (|object2String| |str|))
      (SETQ |l| (QCSIZE |str|))
      (SETQ |nb| NIL)
      (SETQ |i| 0)
      ((LAMBDA ()
         (LOOP
          (COND ((NOT (AND (< |i| |l|) (NULL |nb|))) (RETURN NIL))
                (#1='T
                 (COND
                  ((NOT (EQUAL (SCHAR |str| |i|) (SCHAR " " 0)))
                   (SETQ |nb| |i|))
                  (#1# (SETQ |i| (+ |i| 1)))))))))
      (COND ((EQL |nb| 0) |str|) (|nb| (SUBSTRING |str| |nb| NIL)) (#1# ""))))))

; concat(:l) == concatList l

(DEFUN |concat| (&REST |l|) (PROG () (RETURN (|concatList| |l|))))

; concatList [x,:y] ==
;   null y => x
;   null x => concatList y
;   concat1(x,concatList y)

(DEFUN |concatList| (|bfVar#8|)
  (PROG (|x| |y|)
    (RETURN
     (PROGN
      (SETQ |x| (CAR |bfVar#8|))
      (SETQ |y| (CDR |bfVar#8|))
      (COND ((NULL |y|) |x|) ((NULL |x|) (|concatList| |y|))
            ('T (|concat1| |x| (|concatList| |y|))))))))

; concat1(x,y) ==
;   null x => y
;   atom x => (null y => x; atom y => [x,y]; [x,:y])
;   null y => x
;   atom y => [:x,y]
;   [:x,:y]

(DEFUN |concat1| (|x| |y|)
  (PROG ()
    (RETURN
     (COND ((NULL |x|) |y|)
           ((ATOM |x|)
            (COND ((NULL |y|) |x|) ((ATOM |y|) (LIST |x| |y|))
                  (#1='T (CONS |x| |y|))))
           ((NULL |y|) |x|) ((ATOM |y|) (APPEND |x| (CONS |y| NIL)))
           (#1# (APPEND |x| |y|))))))

; freeOfSharpVars x ==
;   atom x => not isSharpVarWithNum x
;   freeOfSharpVars first x and freeOfSharpVars rest x

(DEFUN |freeOfSharpVars| (|x|)
  (PROG ()
    (RETURN
     (COND ((ATOM |x|) (NULL (|isSharpVarWithNum| |x|)))
           ('T
            (AND (|freeOfSharpVars| (CAR |x|))
                 (|freeOfSharpVars| (CDR |x|))))))))

; listOfSharpVars x ==
;   atom x => (isSharpVarWithNum x => LIST x; nil)
;   union(listOfSharpVars first x,listOfSharpVars rest x)

(DEFUN |listOfSharpVars| (|x|)
  (PROG ()
    (RETURN
     (COND
      ((ATOM |x|) (COND ((|isSharpVarWithNum| |x|) (LIST |x|)) (#1='T NIL)))
      (#1#
       (|union| (|listOfSharpVars| (CAR |x|))
        (|listOfSharpVars| (CDR |x|))))))))

; listOfPatternIds x ==
;   isPatternVar x => [x]
;   atom x => nil
;   x is ['QUOTE,:.] => nil
;   UNIONQ(listOfPatternIds first x,listOfPatternIds rest x)

(DEFUN |listOfPatternIds| (|x|)
  (PROG ()
    (RETURN
     (COND ((|isPatternVar| |x|) (LIST |x|)) ((ATOM |x|) NIL)
           ((AND (CONSP |x|) (EQ (CAR |x|) 'QUOTE)) NIL)
           ('T
            (UNIONQ (|listOfPatternIds| (CAR |x|))
             (|listOfPatternIds| (CDR |x|))))))))

; isPatternVar v ==
;   -- a pattern variable consists of a star followed by a star or digit(s)
;   IDENTP(v) and MEMQ(v,'(_*_* _*1 _*2 _*3 _*4 _*5 _*6 _*7 _*8 _*9 _*10
;     _*11 _*12 _*13 _*14 _*15 _*16 _*17 _*18 _*19 _*20)) and true

(DEFUN |isPatternVar| (|v|)
  (PROG ()
    (RETURN
     (AND (IDENTP |v|)
          (MEMQ |v|
                '(** *1 *2 *3 *4 *5 *6 *7 *8 *9 *10 *11 *12 *13 *14 *15 *16 *17
                  *18 *19 *20))
          T))))

; removeZeroOne x ==
;   -- replace all occurrences of (Zero) and (One) with
;   -- 0 and 1
;   x = $Zero => 0
;   x = $One => 1
;   atom x => x
;   [removeZeroOne first x,:removeZeroOne rest x]

(DEFUN |removeZeroOne| (|x|)
  (PROG ()
    (RETURN
     (COND ((EQUAL |x| |$Zero|) 0) ((EQUAL |x| |$One|) 1) ((ATOM |x|) |x|)
           ('T
            (CONS (|removeZeroOne| (CAR |x|)) (|removeZeroOne| (CDR |x|))))))))

; removeZeroOneDestructively t ==
;   -- replace all occurrences of (Zero) and (One) with
;   -- 0 and 1 destructively
;   t = $Zero => 0
;   t = $One => 1
;   atom t => t
;   RPLNODE(t,removeZeroOneDestructively first t,
;     removeZeroOneDestructively rest t)

(DEFUN |removeZeroOneDestructively| (|t|)
  (PROG ()
    (RETURN
     (COND ((EQUAL |t| |$Zero|) 0) ((EQUAL |t| |$One|) 1) ((ATOM |t|) |t|)
           ('T
            (RPLNODE |t| (|removeZeroOneDestructively| (CAR |t|))
             (|removeZeroOneDestructively| (CDR |t|))))))))

; listSort(pred,list,:optional) ==
;    NOT functionp pred => error "listSort: first arg must be a function"
;    NOT LISTP list => error "listSort: second argument must be a list"
;    NULL optional => mergeSort(pred,function Identity,list,LENGTH list)
;    key := CAR optional
;    NOT functionp key => error "listSort: last arg must be a function"
;    mergeSort(pred,key,list,LENGTH list)

(DEFUN |listSort| (|pred| LIST &REST |optional|)
  (PROG (|key|)
    (RETURN
     (COND
      ((NULL (|functionp| |pred|))
       (|error| '|listSort: first arg must be a function|))
      ((NULL (LISTP LIST))
       (|error| '|listSort: second argument must be a list|))
      ((NULL |optional|) (|mergeSort| |pred| #'|Identity| LIST (LENGTH LIST)))
      (#1='T
       (PROGN
        (SETQ |key| (CAR |optional|))
        (COND
         ((NULL (|functionp| |key|))
          (|error| '|listSort: last arg must be a function|))
         (#1# (|mergeSort| |pred| |key| LIST (LENGTH LIST))))))))))

; MSORT list == listSort(function GLESSEQP, COPY_-LIST list)

(DEFUN MSORT (LIST) (PROG () (RETURN (|listSort| #'GLESSEQP (COPY-LIST LIST)))))

; NMSORT list == listSort(function GLESSEQP, list)

(DEFUN NMSORT (LIST) (PROG () (RETURN (|listSort| #'GLESSEQP LIST))))

; orderList l == listSort(function _?ORDER, COPY_-LIST l)

(DEFUN |orderList| (|l|)
  (PROG () (RETURN (|listSort| #'?ORDER (COPY-LIST |l|)))))

; mergeInPlace(f,g,p,q) ==
;    -- merge the two sorted lists p and q
;    if NULL p then return p
;    if NULL q then return q
;    if FUNCALL(f,FUNCALL(g, QCAR p),FUNCALL(g, QCAR q))
;    then (r := t := p; p := QCDR p)
;    else (r := t := q; q := QCDR q)
;    while not NULL p and not NULL q repeat
;       if FUNCALL(f,FUNCALL(g,QCAR p),FUNCALL(g,QCAR q))
;       then (QRPLACD(t,p); t := p; p := QCDR p)
;       else (QRPLACD(t,q); t := q; q := QCDR q)
;    if NULL p then QRPLACD(t,q) else QRPLACD(t,p)
;    r

(DEFUN |mergeInPlace| (|f| |g| |p| |q|)
  (PROG (|t| |r|)
    (RETURN
     (PROGN
      (COND ((NULL |p|) (RETURN |p|)))
      (COND ((NULL |q|) (RETURN |q|)))
      (COND
       ((FUNCALL |f| (FUNCALL |g| (QCAR |p|)) (FUNCALL |g| (QCAR |q|)))
        (SETQ |r| (SETQ |t| |p|)) (SETQ |p| (QCDR |p|)))
       (#1='T (SETQ |r| (SETQ |t| |q|)) (SETQ |q| (QCDR |q|))))
      ((LAMBDA ()
         (LOOP
          (COND ((NOT (AND (NULL (NULL |p|)) (NULL (NULL |q|)))) (RETURN NIL))
                (#1#
                 (COND
                  ((FUNCALL |f| (FUNCALL |g| (QCAR |p|))
                            (FUNCALL |g| (QCAR |q|)))
                   (QRPLACD |t| |p|) (SETQ |t| |p|) (SETQ |p| (QCDR |p|)))
                  (#1# (QRPLACD |t| |q|) (SETQ |t| |q|)
                   (SETQ |q| (QCDR |q|)))))))))
      (COND ((NULL |p|) (QRPLACD |t| |q|)) (#1# (QRPLACD |t| |p|)))
      |r|))))

; mergeSort(f,g,p,n) ==
;    if eql_SI(n, 2) and
;         FUNCALL(f, FUNCALL(g, QCADR p), FUNCALL(g, QCAR p)) then
;       t := p
;       p := QCDR p
;       QRPLACD(p,t)
;       QRPLACD(t,NIL)
;    if less_SI(n, 3) then return p
;    -- split the list p into p and q of equal length
;    l := quo_SI(n, 2)
;    t := p
;    for i in 1..l-1 repeat t := QCDR t
;    q := rest t
;    QRPLACD(t,NIL)
;    p := mergeSort(f,g,p,l)
;    q := mergeSort(f, g, q, sub_SI(n, l))
;    mergeInPlace(f,g,p,q)

(DEFUN |mergeSort| (|f| |g| |p| |n|)
  (PROG (|t| |l| |q|)
    (RETURN
     (PROGN
      (COND
       ((AND (|eql_SI| |n| 2)
             (FUNCALL |f| (FUNCALL |g| (QCADR |p|)) (FUNCALL |g| (QCAR |p|))))
        (SETQ |t| |p|) (SETQ |p| (QCDR |p|)) (QRPLACD |p| |t|)
        (QRPLACD |t| NIL)))
      (COND ((|less_SI| |n| 3) (RETURN |p|)))
      (SETQ |l| (|quo_SI| |n| 2))
      (SETQ |t| |p|)
      ((LAMBDA (|bfVar#9| |i|)
         (LOOP
          (COND ((> |i| |bfVar#9|) (RETURN NIL)) ('T (SETQ |t| (QCDR |t|))))
          (SETQ |i| (+ |i| 1))))
       (- |l| 1) 1)
      (SETQ |q| (CDR |t|))
      (QRPLACD |t| NIL)
      (SETQ |p| (|mergeSort| |f| |g| |p| |l|))
      (SETQ |q| (|mergeSort| |f| |g| |q| (|sub_SI| |n| |l|)))
      (|mergeInPlace| |f| |g| |p| |q|)))))

; throw_to_reader() == THROW('SPAD_READER, nil)

(DEFUN |throw_to_reader| () (PROG () (RETURN (THROW 'SPAD_READER NIL))))

; spadThrow() ==
;   if $interpOnly and $mapName then
;     putHist($mapName,'localModemap, nil, $e)
;   $BreakMode = 'throw_reader => throw_to_reader()
;   handleLispBreakLoop($BreakMode)

(DEFUN |spadThrow| ()
  (PROG ()
    (RETURN
     (PROGN
      (COND
       ((AND |$interpOnly| |$mapName|)
        (|putHist| |$mapName| '|localModemap| NIL |$e|)))
      (COND ((EQ |$BreakMode| '|throw_reader|) (|throw_to_reader|))
            ('T (|handleLispBreakLoop| |$BreakMode|)))))))

; spadThrowBrightly x ==
;   sayBrightly x
;   spadThrow()

(DEFUN |spadThrowBrightly| (|x|)
  (PROG () (RETURN (PROGN (|sayBrightly| |x|) (|spadThrow|)))))

; formatUnabbreviatedSig sig ==
;   null sig => ["() -> ()"]
;   [target,:args] := sig
;   target := formatUnabbreviated target
;   null args => ['"() -> ",:target]
;   null rest args => [:formatUnabbreviated QCAR args,'" -> ",:target]
;   args := formatUnabbreviatedTuple args
;   ['"(",:args,'") -> ",:target]

(DEFUN |formatUnabbreviatedSig| (|sig|)
  (PROG (|target| |args|)
    (RETURN
     (COND ((NULL |sig|) (LIST '|() -> ()|))
           (#1='T
            (PROGN
             (SETQ |target| (CAR |sig|))
             (SETQ |args| (CDR |sig|))
             (SETQ |target| (|formatUnabbreviated| |target|))
             (COND ((NULL |args|) (CONS "() -> " |target|))
                   ((NULL (CDR |args|))
                    (APPEND (|formatUnabbreviated| (QCAR |args|))
                            (CONS " -> " |target|)))
                   (#1#
                    (PROGN
                     (SETQ |args| (|formatUnabbreviatedTuple| |args|))
                     (CONS "(" (APPEND |args| (CONS ") -> " |target|))))))))))))

; formatUnabbreviatedTuple t ==
;   -- t is a list of types
;   null t => t
;   atom t => [t]
;   t0 := formatUnabbreviated QCAR t
;   null rest t => t0
;   [:t0,'",",:formatUnabbreviatedTuple QCDR t]

(DEFUN |formatUnabbreviatedTuple| (|t|)
  (PROG (|t0|)
    (RETURN
     (COND ((NULL |t|) |t|) ((ATOM |t|) (LIST |t|))
           (#1='T
            (PROGN
             (SETQ |t0| (|formatUnabbreviated| (QCAR |t|)))
             (COND ((NULL (CDR |t|)) |t0|)
                   (#1#
                    (APPEND |t0|
                            (CONS ","
                                  (|formatUnabbreviatedTuple|
                                   (QCDR |t|))))))))))))

; formatUnabbreviated t ==
;   atom t =>
;     [t]
;   null t =>
;     ['"()"]
;   t is [p,sel,arg] and p in '(_: ":") =>
;     [sel,'": ",:formatUnabbreviated arg]
;   t is ['Union,:args] =>
;     ['Union,'"(",:formatUnabbreviatedTuple args,'")"]
;   t is ['Mapping,:args] =>
;     formatUnabbreviatedSig args
;   t is ['Record,:args] =>
;     ['Record,'"(",:formatUnabbreviatedTuple args,'")"]
;   t is [arg] =>
;     t
;   t is [arg,arg1] =>
;     [arg,'" ",:formatUnabbreviated arg1]
;   t is [arg,:args] =>
;     [arg,'"(",:formatUnabbreviatedTuple args,'")"]
;   t

(DEFUN |formatUnabbreviated| (|t|)
  (PROG (|p| |ISTMP#1| |sel| |ISTMP#2| |arg| |args| |arg1|)
    (RETURN
     (COND ((ATOM |t|) (LIST |t|)) ((NULL |t|) (LIST "()"))
           ((AND (CONSP |t|)
                 (PROGN
                  (SETQ |p| (CAR |t|))
                  (SETQ |ISTMP#1| (CDR |t|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |sel| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |arg| (CAR |ISTMP#2|)) #1='T)))))
                 (|member| |p| '(|:| ":")))
            (CONS |sel| (CONS ": " (|formatUnabbreviated| |arg|))))
           ((AND (CONSP |t|) (EQ (CAR |t|) '|Union|)
                 (PROGN (SETQ |args| (CDR |t|)) #1#))
            (CONS '|Union|
                  (CONS "("
                        (APPEND (|formatUnabbreviatedTuple| |args|)
                                (CONS ")" NIL)))))
           ((AND (CONSP |t|) (EQ (CAR |t|) '|Mapping|)
                 (PROGN (SETQ |args| (CDR |t|)) #1#))
            (|formatUnabbreviatedSig| |args|))
           ((AND (CONSP |t|) (EQ (CAR |t|) '|Record|)
                 (PROGN (SETQ |args| (CDR |t|)) #1#))
            (CONS '|Record|
                  (CONS "("
                        (APPEND (|formatUnabbreviatedTuple| |args|)
                                (CONS ")" NIL)))))
           ((AND (CONSP |t|) (EQ (CDR |t|) NIL)
                 (PROGN (SETQ |arg| (CAR |t|)) #1#))
            |t|)
           ((AND (CONSP |t|)
                 (PROGN
                  (SETQ |arg| (CAR |t|))
                  (SETQ |ISTMP#1| (CDR |t|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                       (PROGN (SETQ |arg1| (CAR |ISTMP#1|)) #1#))))
            (CONS |arg| (CONS " " (|formatUnabbreviated| |arg1|))))
           ((AND (CONSP |t|)
                 (PROGN (SETQ |arg| (CAR |t|)) (SETQ |args| (CDR |t|)) #1#))
            (CONS |arg|
                  (CONS "("
                        (APPEND (|formatUnabbreviatedTuple| |args|)
                                (CONS ")" NIL)))))
           (#1# |t|)))))

; sublisNQ(al,e) ==
;   atom al => e
;   fn(al,e) where fn(al,e) ==
;     atom e =>
;       for x in al repeat
;         EQ(first x,e) => return (e := rest x)
;       e
;     EQ(a := first e,'QUOTE) => e
;     u := fn(al,a)
;     v := fn(al,rest e)
;     EQ(a,u) and EQ(rest e,v) => e
;     [u,:v]

(DEFUN |sublisNQ| (|al| |e|)
  (PROG () (RETURN (COND ((ATOM |al|) |e|) ('T (|sublisNQ,fn| |al| |e|))))))
(DEFUN |sublisNQ,fn| (|al| |e|)
  (PROG (|a| |u| |v|)
    (RETURN
     (COND
      ((ATOM |e|)
       (PROGN
        ((LAMBDA (|bfVar#10| |x|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#10|) (PROGN (SETQ |x| (CAR |bfVar#10|)) NIL))
              (RETURN NIL))
             (#1='T
              (COND
               ((EQ (CAR |x|) |e|) (IDENTITY (RETURN (SETQ |e| (CDR |x|))))))))
            (SETQ |bfVar#10| (CDR |bfVar#10|))))
         |al| NIL)
        |e|))
      ((EQ (SETQ |a| (CAR |e|)) 'QUOTE) |e|)
      (#1#
       (PROGN
        (SETQ |u| (|sublisNQ,fn| |al| |a|))
        (SETQ |v| (|sublisNQ,fn| |al| (CDR |e|)))
        (COND ((AND (EQ |a| |u|) (EQ (CDR |e|) |v|)) |e|)
              (#1# (CONS |u| |v|)))))))))

; opOf x ==
;   atom x => x
;   first x

(DEFUN |opOf| (|x|) (PROG () (RETURN (COND ((ATOM |x|) |x|) ('T (CAR |x|))))))

; getProplist(x,E) ==
;   not atom x => getProplist(first x,E)
;   u:= search(x,E) => u
;   (pl:=search(x,$CategoryFrame)) =>
;     pl

(DEFUN |getProplist| (|x| E)
  (PROG (|u| |pl|)
    (RETURN
     (COND ((NULL (ATOM |x|)) (|getProplist| (CAR |x|) E))
           ((SETQ |u| (|search| |x| E)) |u|)
           ((SETQ |pl| (|search| |x| |$CategoryFrame|)) |pl|)))))

; search(x,e is [curEnv,:tailEnv]) ==
;   tailEnv =>
;     BREAK()
;   searchCurrentEnv(x,curEnv)

(DEFUN |search| (|x| |e|)
  (PROG (|curEnv| |tailEnv|)
    (RETURN
     (PROGN
      (SETQ |curEnv| (CAR |e|))
      (SETQ |tailEnv| (CDR |e|))
      (COND (|tailEnv| (BREAK)) ('T (|searchCurrentEnv| |x| |curEnv|)))))))

; searchCurrentEnv(x,currentEnv) ==
;   for contour in currentEnv repeat
;     if u:= ASSQ(x,contour) then return (signal:= u)
;   IFCDR signal

(DEFUN |searchCurrentEnv| (|x| |currentEnv|)
  (PROG (|u| |signal|)
    (RETURN
     (PROGN
      ((LAMBDA (|bfVar#11| |contour|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#11|)
                (PROGN (SETQ |contour| (CAR |bfVar#11|)) NIL))
            (RETURN NIL))
           ('T
            (COND
             ((SETQ |u| (ASSQ |x| |contour|)) (RETURN (SETQ |signal| |u|))))))
          (SETQ |bfVar#11| (CDR |bfVar#11|))))
       |currentEnv| NIL)
      (IFCDR |signal|)))))

; augProplist(proplist,prop,val) ==
;   $InteractiveMode => augProplistInteractive(proplist,prop,val)
;   while (proplist is [[ =prop,:.],:proplist']) repeat proplist:= proplist'
;   val=(u:= LASSOC(prop,proplist)) => proplist
;   null val =>
;     null u => proplist
;     DELLASOS(prop,proplist)
;   [[prop,:val],:proplist]

(DEFUN |augProplist| (|proplist| |prop| |val|)
  (PROG (|ISTMP#1| |proplist'| |u|)
    (RETURN
     (COND
      (|$InteractiveMode| (|augProplistInteractive| |proplist| |prop| |val|))
      (#1='T
       (PROGN
        ((LAMBDA ()
           (LOOP
            (COND
             ((NOT
               (AND (CONSP |proplist|)
                    (PROGN
                     (SETQ |ISTMP#1| (CAR |proplist|))
                     (AND (CONSP |ISTMP#1|) (EQUAL (CAR |ISTMP#1|) |prop|)))
                    (PROGN (SETQ |proplist'| (CDR |proplist|)) #1#)))
              (RETURN NIL))
             (#1# (SETQ |proplist| |proplist'|))))))
        (COND ((EQUAL |val| (SETQ |u| (LASSOC |prop| |proplist|))) |proplist|)
              ((NULL |val|)
               (COND ((NULL |u|) |proplist|)
                     (#1# (DELLASOS |prop| |proplist|))))
              (#1# (CONS (CONS |prop| |val|) |proplist|)))))))))

; augProplistOf(var,prop,val,e) ==
;   proplist:= getProplist(var,e)
;   semchkProplist(var, proplist, prop)
;   augProplist(proplist,prop,val)

(DEFUN |augProplistOf| (|var| |prop| |val| |e|)
  (PROG (|proplist|)
    (RETURN
     (PROGN
      (SETQ |proplist| (|getProplist| |var| |e|))
      (|semchkProplist| |var| |proplist| |prop|)
      (|augProplist| |proplist| |prop| |val|)))))

; semchkProplist(x, proplist, prop) ==
;   prop="isLiteral" =>
;     LASSOC("value",proplist) or LASSOC("mode",proplist) => warnLiteral x
;   MEMQ(prop,'(mode value)) =>
;     LASSOC("isLiteral",proplist) => warnLiteral x

(DEFUN |semchkProplist| (|x| |proplist| |prop|)
  (PROG ()
    (RETURN
     (COND
      ((EQ |prop| '|isLiteral|)
       (COND
        ((OR (LASSOC '|value| |proplist|) (LASSOC '|mode| |proplist|))
         (IDENTITY (|warnLiteral| |x|)))))
      ((MEMQ |prop| '(|mode| |value|))
       (COND
        ((LASSOC '|isLiteral| |proplist|) (IDENTITY (|warnLiteral| |x|)))))))))

; DEFPARAMETER($envHashTable, nil)

(DEFPARAMETER |$envHashTable| NIL)

; addBinding(var,proplist,e is [[curContour,:tailContour],:tailEnv]) ==
;   EQ(proplist,getProplist(var,e)) => e
;   if $envHashTable then
;     for u in proplist repeat
;       HPUT($envHashTable, [var, CAR u], true)
;   $InteractiveMode => addBindingInteractive(var,proplist,e)
;   if curContour is [[ =var,:.],:.] then curContour:= rest curContour
;                  --Previous line should save some space
;   [[[lx,:curContour],:tailContour],:tailEnv] where lx:= [var,:proplist]

(DEFUN |addBinding| (|var| |proplist| |e|)
  (PROG (|curContour| |tailContour| |tailEnv| |ISTMP#1| |lx|)
    (RETURN
     (PROGN
      (SETQ |curContour| (CAAR . #1=(|e|)))
      (SETQ |tailContour| (CDAR . #1#))
      (SETQ |tailEnv| (CDR |e|))
      (COND ((EQ |proplist| (|getProplist| |var| |e|)) |e|)
            (#2='T
             (PROGN
              (COND
               (|$envHashTable|
                ((LAMBDA (|bfVar#12| |u|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#12|)
                          (PROGN (SETQ |u| (CAR |bfVar#12|)) NIL))
                      (RETURN NIL))
                     (#2# (HPUT |$envHashTable| (LIST |var| (CAR |u|)) T)))
                    (SETQ |bfVar#12| (CDR |bfVar#12|))))
                 |proplist| NIL)))
              (COND
               (|$InteractiveMode|
                (|addBindingInteractive| |var| |proplist| |e|))
               (#2#
                (PROGN
                 (COND
                  ((AND (CONSP |curContour|)
                        (PROGN
                         (SETQ |ISTMP#1| (CAR |curContour|))
                         (AND (CONSP |ISTMP#1|)
                              (EQUAL (CAR |ISTMP#1|) |var|))))
                   (SETQ |curContour| (CDR |curContour|))))
                 (SETQ |lx| (CONS |var| |proplist|))
                 (CONS (CONS (CONS |lx| |curContour|) |tailContour|)
                       |tailEnv|)))))))))))

; position(x,l) ==
;   posn(x,l,0) where
;     posn(x,l,n) ==
;       null l => -1
;       x=first l => n
;       posn(x,rest l,n+1)

(DEFUN |position| (|x| |l|) (PROG () (RETURN (|position,posn| |x| |l| 0))))
(DEFUN |position,posn| (|x| |l| |n|)
  (PROG ()
    (RETURN
     (COND ((NULL |l|) (- 1)) ((EQUAL |x| (CAR |l|)) |n|)
           ('T (|position,posn| |x| (CDR |l|) (+ |n| 1)))))))

; insert(x,y) ==
;   member(x,y) => y
;   [x,:y]

(DEFUN |insert| (|x| |y|)
  (PROG () (RETURN (COND ((|member| |x| |y|) |y|) ('T (CONS |x| |y|))))))

; after(u,v) ==
;   r:= u
;   for x in u for y in v repeat r:= rest r
;   r

(DEFUN |after| (|u| |v|)
  (PROG (|r|)
    (RETURN
     (PROGN
      (SETQ |r| |u|)
      ((LAMBDA (|bfVar#13| |x| |bfVar#14| |y|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#13|) (PROGN (SETQ |x| (CAR |bfVar#13|)) NIL)
                (ATOM |bfVar#14|) (PROGN (SETQ |y| (CAR |bfVar#14|)) NIL))
            (RETURN NIL))
           ('T (SETQ |r| (CDR |r|))))
          (SETQ |bfVar#13| (CDR |bfVar#13|))
          (SETQ |bfVar#14| (CDR |bfVar#14|))))
       |u| NIL |v| NIL)
      |r|))))

; $blank := char ('_ )

(EVAL-WHEN (EVAL LOAD) (SETQ |$blank| (|char| '| |)))

; trimString s ==
;   leftTrim rightTrim s

(DEFUN |trimString| (|s|) (PROG () (RETURN (|leftTrim| (|rightTrim| |s|)))))

; leftTrim s ==
;   k := MAXINDEX s
;   k < 0 => s
;   s.0 = $blank =>
;     for i in 0..k while s.i = $blank repeat (j := i)
;     SUBSTRING(s,j + 1,nil)
;   s

(DEFUN |leftTrim| (|s|)
  (PROG (|k| |j|)
    (RETURN
     (PROGN
      (SETQ |k| (MAXINDEX |s|))
      (COND ((MINUSP |k|) |s|)
            ((EQUAL (ELT |s| 0) |$blank|)
             (PROGN
              ((LAMBDA (|i|)
                 (LOOP
                  (COND
                   ((OR (> |i| |k|) (NOT (EQUAL (ELT |s| |i|) |$blank|)))
                    (RETURN NIL))
                   (#1='T (SETQ |j| |i|)))
                  (SETQ |i| (+ |i| 1))))
               0)
              (SUBSTRING |s| (+ |j| 1) NIL)))
            (#1# |s|))))))

; rightTrim s ==  -- assumed a non-empty string
;   k := MAXINDEX s
;   k < 0 => s
;   s.k = $blank =>
;     for i in k..0 by -1 while s.i = $blank repeat (j := i)
;     SUBSTRING(s,0,j)
;   s

(DEFUN |rightTrim| (|s|)
  (PROG (|k| |j|)
    (RETURN
     (PROGN
      (SETQ |k| (MAXINDEX |s|))
      (COND ((MINUSP |k|) |s|)
            ((EQUAL (ELT |s| |k|) |$blank|)
             (PROGN
              ((LAMBDA (|bfVar#15| |i|)
                 (LOOP
                  (COND
                   ((OR (COND ((MINUSP |bfVar#15|) (< |i| 0)) (T (> |i| 0)))
                        (NOT (EQUAL (ELT |s| |i|) |$blank|)))
                    (RETURN NIL))
                   (#1='T (SETQ |j| |i|)))
                  (SETQ |i| (+ |i| |bfVar#15|))))
               (- 1) |k|)
              (SUBSTRING |s| 0 |j|)))
            (#1# |s|))))))

; pp x ==
;   PRETTYPRINT x
;   nil

(DEFUN |pp| (|x|) (PROG () (RETURN (PROGN (PRETTYPRINT |x|) NIL))))

; quickAnd(a,b) ==
;   a = true => b
;   b = true => a
;   a = false or b = false => false
;   simpBool ['AND,a,b]

(DEFUN |quickAnd| (|a| |b|)
  (PROG ()
    (RETURN
     (COND ((EQUAL |a| T) |b|) ((EQUAL |b| T) |a|)
           ((OR (NULL |a|) (NULL |b|)) NIL)
           ('T (|simpBool| (LIST 'AND |a| |b|)))))))

; quickOr(a,b) ==
;   a = true or b = true => true
;   b = false => a
;   a = false => b
;   simpCatPredicate simpBool ['OR,a,b]

(DEFUN |quickOr| (|a| |b|)
  (PROG ()
    (RETURN
     (COND ((OR (EQUAL |a| T) (EQUAL |b| T)) T) ((NULL |b|) |a|)
           ((NULL |a|) |b|)
           ('T (|simpCatPredicate| (|simpBool| (LIST 'OR |a| |b|))))))))

; intern x ==
;   STRINGP x =>
;     DIGITP x.0 => string2Integer x
;     INTERN x
;   x

(DEFUN |intern| (|x|)
  (PROG ()
    (RETURN
     (COND
      ((STRINGP |x|)
       (COND ((DIGITP (ELT |x| 0)) (|string2Integer| |x|))
             (#1='T (INTERN |x|))))
      (#1# |x|)))))

; $htHash      := MAKE_HASHTABLE('EQUAL)

(EVAL-WHEN (EVAL LOAD) (SETQ |$htHash| (MAKE_HASHTABLE 'EQUAL)))

; $glossHash   := MAKE_HASHTABLE('EQUAL)

(EVAL-WHEN (EVAL LOAD) (SETQ |$glossHash| (MAKE_HASHTABLE 'EQUAL)))

; $lispHash    := MAKE_HASHTABLE('EQUAL)

(EVAL-WHEN (EVAL LOAD) (SETQ |$lispHash| (MAKE_HASHTABLE 'EQUAL)))

; $sysHash     := MAKE_HASHTABLE('EQUAL)

(EVAL-WHEN (EVAL LOAD) (SETQ |$sysHash| (MAKE_HASHTABLE 'EQUAL)))

; $htSystemCommands := '(
;  (boot . development) clear display (fin . development) edit help
;  frame history load quit read set show synonym system
;  trace what )

(EVAL-WHEN (EVAL LOAD)
  (SETQ |$htSystemCommands|
          '((|boot| . |development|) |clear| |display| (|fin| . |development|)
            |edit| |help| |frame| |history| |load| |quit| |read| |set| |show|
            |synonym| |system| |trace| |what|)))

; $currentSysList := [opOf x for x in $htSystemCommands] --see ht-root

(EVAL-WHEN (EVAL LOAD)
  (SETQ |$currentSysList|
          ((LAMBDA (|bfVar#17| |bfVar#16| |x|)
             (LOOP
              (COND
               ((OR (ATOM |bfVar#16|) (PROGN (SETQ |x| (CAR |bfVar#16|)) NIL))
                (RETURN (NREVERSE |bfVar#17|)))
               ('T (SETQ |bfVar#17| (CONS (|opOf| |x|) |bfVar#17|))))
              (SETQ |bfVar#16| (CDR |bfVar#16|))))
           NIL |$htSystemCommands| NIL)))

; $outStream   := nil

(EVAL-WHEN (EVAL LOAD) (SETQ |$outStream| NIL))

; $recheckingFlag    := false     --see transformAndRecheckComments

(EVAL-WHEN (EVAL LOAD) (SETQ |$recheckingFlag| NIL))

; $exposeFlag        := false     --if true, messages go to $outStream

(EVAL-WHEN (EVAL LOAD) (SETQ |$exposeFlag| NIL))

; $exposeFlagHeading := false     --see htcheck.boot

(EVAL-WHEN (EVAL LOAD) (SETQ |$exposeFlagHeading| NIL))

; $checkingXmptex? := false       --see htcheck.boot

(EVAL-WHEN (EVAL LOAD) (SETQ |$checkingXmptex?| NIL))

; $exposeDocHeading:= nil         --see htcheck.boot

(EVAL-WHEN (EVAL LOAD) (SETQ |$exposeDocHeading| NIL))

; $charPlus := char '_+

(EVAL-WHEN (EVAL LOAD) (SETQ |$charPlus| (|char| '+)))

; $charBlank:= (char '_ )

(EVAL-WHEN (EVAL LOAD) (SETQ |$charBlank| (|char| '| |)))

; $charLbrace:= char '_{

(EVAL-WHEN (EVAL LOAD) (SETQ |$charLbrace| (|char| '{)))

; $charRbrace:= char '_}

(EVAL-WHEN (EVAL LOAD) (SETQ |$charRbrace| (|char| '})))

; $charBack := char '_\

(EVAL-WHEN (EVAL LOAD) (SETQ |$charBack| (|char| '|\\|)))

; $charDash := char '_-

(EVAL-WHEN (EVAL LOAD) (SETQ |$charDash| (|char| '-)))

; $charTab            := CODE_-CHAR(9)

(EVAL-WHEN (EVAL LOAD) (SETQ |$charTab| (CODE-CHAR 9)))

; $charNewline        := CODE_-CHAR(10)

(EVAL-WHEN (EVAL LOAD) (SETQ |$charNewline| (CODE-CHAR 10)))

; $charFauxNewline    := CODE_-CHAR(25)

(EVAL-WHEN (EVAL LOAD) (SETQ |$charFauxNewline| (CODE-CHAR 25)))

; $stringNewline      := PNAME CODE_-CHAR(10)

(EVAL-WHEN (EVAL LOAD) (SETQ |$stringNewline| (PNAME (CODE-CHAR 10))))

; $stringFauxNewline  := PNAME CODE_-CHAR(25)

(EVAL-WHEN (EVAL LOAD) (SETQ |$stringFauxNewline| (PNAME (CODE-CHAR 25))))

; $charExclusions := [char 'a, char 'A]

(EVAL-WHEN (EVAL LOAD)
  (SETQ |$charExclusions| (LIST (|char| '|a|) (|char| 'A))))

; $charQuote := char '_'

(EVAL-WHEN (EVAL LOAD) (SETQ |$charQuote| (|char| '|'|)))

; $charSemiColon := char '_;

(EVAL-WHEN (EVAL LOAD) (SETQ |$charSemiColon| (|char| '|;|)))

; $charComma     := char '_,

(EVAL-WHEN (EVAL LOAD) (SETQ |$charComma| (|char| '|,|)))

; $charPeriod    := char '_.

(EVAL-WHEN (EVAL LOAD) (SETQ |$charPeriod| (|char| '|.|)))

; $checkPrenAlist := [[char '_(,:char '_)],[char '_{,:char '_}],[char '_[,:char '_]]]

(EVAL-WHEN (EVAL LOAD)
  (SETQ |$checkPrenAlist|
          (LIST (CONS (|char| '|(|) (|char| '|)|))
                (CONS (|char| '{) (|char| '})) (CONS (|char| '[) (|char| '])))))

; $charEscapeList:= [char '_%,char '_#,$charBack]

(EVAL-WHEN (EVAL LOAD)
  (SETQ |$charEscapeList| (LIST (|char| '%) (|char| '|#|) |$charBack|)))

; $charIdentifierEndings := [char '__, char '_!, char '_?]

(EVAL-WHEN (EVAL LOAD)
  (SETQ |$charIdentifierEndings| (LIST (|char| '_) (|char| '!) (|char| '?))))

; $charSplitList := [$charComma,$charPeriod,char '_[, char '_],$charLbrace, $charRbrace, char '_(, char '_), char '_$, char '_%]

(EVAL-WHEN (EVAL LOAD)
  (SETQ |$charSplitList|
          (LIST |$charComma| |$charPeriod| (|char| '[) (|char| '])
                |$charLbrace| |$charRbrace| (|char| '|(|) (|char| '|)|)
                (|char| '$) (|char| '%))))

; $charDelimiters := [$charBlank, char '_(, char '_), $charBack]

(EVAL-WHEN (EVAL LOAD)
  (SETQ |$charDelimiters|
          (LIST |$charBlank| (|char| '|(|) (|char| '|)|) |$charBack|)))

; $HTspadmacros := '("\spadtype" "\spadcommand" "\spadop" "\spadfun" "\spadatt" "\spadsyscom" "\spad" "\s")

(EVAL-WHEN (EVAL LOAD)
  (SETQ |$HTspadmacros|
          '("\\spadtype" "\\spadcommand" "\\spadop" "\\spadfun" "\\spadatt"
            "\\spadsyscom" "\\spad" "\\s")))

; $HTmacs := [
;   ['"\beginmenu",$charRbrace,'"menu",$charLbrace,'"\begin"],
;    ['"\endmenu",$charRbrace,'"menu",$charLbrace,'"\end"],
;      ['"\beginitems",$charRbrace,'"items",$charLbrace,'"\begin"],
;        ['"\enditems",$charRbrace,'"items",$charLbrace,'"\end"],
;          ['"\beginscroll",$charRbrace,'"scroll",$charLbrace,'"\begin"],
;            ['"\endscroll",$charRbrace,'"scroll",$charLbrace,'"\end"]]

(EVAL-WHEN (EVAL LOAD)
  (SETQ |$HTmacs|
          (LIST
           (LIST "\\beginmenu" |$charRbrace| "menu" |$charLbrace| "\\begin")
           (LIST "\\endmenu" |$charRbrace| "menu" |$charLbrace| "\\end")
           (LIST "\\beginitems" |$charRbrace| "items" |$charLbrace| "\\begin")
           (LIST "\\enditems" |$charRbrace| "items" |$charLbrace| "\\end")
           (LIST "\\beginscroll" |$charRbrace| "scroll" |$charLbrace|
                 "\\begin")
           (LIST "\\endscroll" |$charRbrace| "scroll" |$charLbrace| "\\end"))))

; $HTlinks := '(
;   "\downlink"
;   "\menulink"
;   "\menudownlink"
;   "\menuwindowlink"
;   "\menumemolink")

(EVAL-WHEN (EVAL LOAD)
  (SETQ |$HTlinks|
          '("\\downlink" "\\menulink" "\\menudownlink" "\\menuwindowlink"
            "\\menumemolink")))

; $HTlisplinks := '(
;   "\lispdownlink"
;   "\menulispdownlink"
;   "\menulispwindowlink"
;   "\menulispmemolink"
;   "\lispwindowlink"
;   "\lispmemolink")

(EVAL-WHEN (EVAL LOAD)
  (SETQ |$HTlisplinks|
          '("\\lispdownlink" "\\menulispdownlink" "\\menulispwindowlink"
            "\\menulispmemolink" "\\lispwindowlink" "\\lispmemolink")))

; $beginEndList := '(
;   "page"
;   "items"
;   "menu"
;   "scroll"
;   "verbatim"
;   "detail")

(EVAL-WHEN (EVAL LOAD)
  (SETQ |$beginEndList| '("page" "items" "menu" "scroll" "verbatim" "detail")))

; isDefaultPackageName x == (s := PNAME x).(MAXINDEX s) = char '_&

(DEFUN |isDefaultPackageName| (|x|)
  (PROG (|s|)
    (RETURN (EQUAL (ELT (SETQ |s| (PNAME |x|)) (MAXINDEX |s|)) (|char| '&)))))

; wrap x ==
;   isWrapped x => x
;   ['WRAPPED,:x]

(DEFUN |wrap| (|x|)
  (PROG () (RETURN (COND ((|isWrapped| |x|) |x|) ('T (CONS 'WRAPPED |x|))))))

; isWrapped x == x is ['WRAPPED,:.] or NUMBERP x or FLOATP x or STRINGP x

(DEFUN |isWrapped| (|x|)
  (PROG ()
    (RETURN
     (OR (AND (CONSP |x|) (EQ (CAR |x|) 'WRAPPED)) (NUMBERP |x|) (FLOATP |x|)
         (STRINGP |x|)))))

; unwrap x ==
;   NUMBERP x or FLOATP x or STRINGP x => x
;   x is ["WRAPPED",:y] => y
;   x

(DEFUN |unwrap| (|x|)
  (PROG (|y|)
    (RETURN
     (COND ((OR (NUMBERP |x|) (FLOATP |x|) (STRINGP |x|)) |x|)
           ((AND (CONSP |x|) (EQ (CAR |x|) 'WRAPPED)
                 (PROGN (SETQ |y| (CDR |x|)) #1='T))
            |y|)
           (#1# |x|)))))

; wrapped2Quote x ==
;   x is ["WRAPPED",:y] => MKQ y
;   x

(DEFUN |wrapped2Quote| (|x|)
  (PROG (|y|)
    (RETURN
     (COND
      ((AND (CONSP |x|) (EQ (CAR |x|) 'WRAPPED)
            (PROGN (SETQ |y| (CDR |x|)) #1='T))
       (MKQ |y|))
      (#1# |x|)))))

; quote2Wrapped x ==
;   x is ['QUOTE,y] => wrap y
;   x

(DEFUN |quote2Wrapped| (|x|)
  (PROG (|ISTMP#1| |y|)
    (RETURN
     (COND
      ((AND (CONSP |x|) (EQ (CAR |x|) 'QUOTE)
            (PROGN
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |y| (CAR |ISTMP#1|)) #1='T))))
       (|wrap| |y|))
      (#1# |x|)))))

; removeQuote x ==
;   x is ["QUOTE",y] => y
;   x

(DEFUN |removeQuote| (|x|)
  (PROG (|ISTMP#1| |y|)
    (RETURN
     (COND
      ((AND (CONSP |x|) (EQ (CAR |x|) 'QUOTE)
            (PROGN
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |y| (CAR |ISTMP#1|)) #1='T))))
       |y|)
      (#1# |x|)))))

; spadPrompt() ==
;   SAY '"   FriCAS"
;   sayNewLine()

(DEFUN |spadPrompt| ()
  (PROG () (RETURN (PROGN (SAY "   FriCAS") (|sayNewLine|)))))

; princPrompt() ==
;   ioHook("startPrompt")
;   PRINC MKPROMPT()
;   ioHook("endOfPrompt")

(DEFUN |princPrompt| ()
  (PROG ()
    (RETURN
     (PROGN
      (|ioHook| '|startPrompt|)
      (PRINC (MKPROMPT))
      (|ioHook| '|endOfPrompt|)))))

; MKPROMPT() ==
;   $inputPromptType = 'none    => '""
;   $inputPromptType = 'plain   => '"-> "
;   $inputPromptType = 'step    =>
;     STRCONC('"(",STRINGIMAGE $IOindex,'") -> ")
;   $inputPromptType = 'frame   =>
;     STRCONC(STRINGIMAGE $interpreterFrameName,
;       '" (",STRINGIMAGE $IOindex,'") -> ")
;   STRCONC(STRINGIMAGE $interpreterFrameName,
;    '" [", SUBSTRING(CURRENTTIME(),8,NIL),'"] [",
;     STRINGIMAGE $IOindex, '"] -> ")

(DEFUN MKPROMPT ()
  (PROG ()
    (RETURN
     (COND ((EQ |$inputPromptType| '|none|) "")
           ((EQ |$inputPromptType| '|plain|) "-> ")
           ((EQ |$inputPromptType| '|step|)
            (STRCONC "(" (STRINGIMAGE |$IOindex|) ") -> "))
           ((EQ |$inputPromptType| '|frame|)
            (STRCONC (STRINGIMAGE |$interpreterFrameName|) " ("
             (STRINGIMAGE |$IOindex|) ") -> "))
           ('T
            (STRCONC (STRINGIMAGE |$interpreterFrameName|) " ["
             (SUBSTRING (CURRENTTIME) 8 NIL) "] [" (STRINGIMAGE |$IOindex|)
             "] -> "))))))

; isSubDomain(d1,d2) ==
;   -- d1 and d2 are different domains
;   subDomainList := '(Integer NonNegativeInteger PositiveInteger)
;   ATOM d1 or ATOM d2 => nil
;   l := MEMQ(first d2, subDomainList) =>
;     MEMQ(first d1, rest l)
;   nil

(DEFUN |isSubDomain| (|d1| |d2|)
  (PROG (|subDomainList| |l|)
    (RETURN
     (PROGN
      (SETQ |subDomainList|
              '(|Integer| |NonNegativeInteger| |PositiveInteger|))
      (COND ((OR (ATOM |d1|) (ATOM |d2|)) NIL)
            ((SETQ |l| (MEMQ (CAR |d2|) |subDomainList|))
             (MEMQ (CAR |d1|) (CDR |l|)))
            ('T NIL))))))

; Undef(:u) ==
;   u':= last u
;   [[domain,slot],op,sig]:= u'
;   domain':=eval mkEvalable domain
;   not EQ(first ELT(domain', slot), Undef) =>
;   -- OK - the function is now defined
;     [:u'',.]:=u
;     if $reportBottomUpFlag then
;       sayMessage concat ['"   Retrospective determination of slot",'%b,
;         slot,'%d,'"of",'%b,:prefix2String domain,'%d]
;     APPLY(first ELT(domain', slot), [:u'', rest ELT(domain', slot)])
;   throwKeyedMsg("S2IF0008",[formatOpSignature(op,sig),domain])

(DEFUN |Undef| (&REST |u|)
  (PROG (|u'| |domain| |slot| |op| |sig| |domain'| |LETTMP#1| |u''|)
    (RETURN
     (PROGN
      (SETQ |u'| (|last| |u|))
      (SETQ |domain| (CAAR . #1=(|u'|)))
      (SETQ |slot| (CADAR . #1#))
      (SETQ |op| (CADR . #2=(|u'|)))
      (SETQ |sig| (CADDR . #2#))
      (SETQ |domain'| (|eval| (|mkEvalable| |domain|)))
      (COND
       ((NULL (EQ (CAR (ELT |domain'| |slot|)) |Undef|))
        (PROGN
         (SETQ |LETTMP#1| (REVERSE |u|))
         (SETQ |u''| (NREVERSE (CDR |LETTMP#1|)))
         (COND
          (|$reportBottomUpFlag|
           (|sayMessage|
            (|concat|
             (CONS "   Retrospective determination of slot"
                   (CONS '|%b|
                         (CONS |slot|
                               (CONS '|%d|
                                     (CONS "of"
                                           (CONS '|%b|
                                                 (APPEND
                                                  (|prefix2String| |domain|)
                                                  (CONS '|%d| NIL))))))))))))
         (APPLY (CAR (ELT |domain'| |slot|))
                (APPEND |u''| (CONS (CDR (ELT |domain'| |slot|)) NIL)))))
       ('T
        (|throwKeyedMsg| 'S2IF0008
         (LIST (|formatOpSignature| |op| |sig|) |domain|))))))))

; TruthP x ==
;     --True if x is a predicate that's always true
;   x is nil => nil
;   x=true => true
;   x is ['QUOTE,:.] => true
;   nil

(DEFUN |TruthP| (|x|)
  (PROG ()
    (RETURN
     (COND ((NULL |x|) NIL) ((EQUAL |x| T) T)
           ((AND (CONSP |x|) (EQ (CAR |x|) 'QUOTE)) T) ('T NIL)))))
