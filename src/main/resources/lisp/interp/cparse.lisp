
; )package "BOOT"

(IN-PACKAGE "BOOT")

; DEFVAR($inputStream)

(DEFVAR |$inputStream|)

; DEFVAR($stack)

(DEFVAR |$stack|)

; DEFVAR($stok)

(DEFVAR |$stok|)

; DEFVAR($ttok)

(DEFVAR |$ttok|)

; npParse stream ==
;     $inputStream:local := stream
;     $stack:local       :=nil
;     $stok:local:=nil
;     $ttok:local:=nil
;     npFirstTok()
;     found:=CATCH("TRAPPOINT",npItem())
;     if found="TRAPPED"
;     then
;       ncSoftError(tokPosn $stok,'S2CY0006, [])
;       pfWrong(pfDocument  '"top level syntax error" ,pfListOf nil)
;     else if not null $inputStream
;          then
;           ncSoftError(tokPosn $stok,'S2CY0002,[])
;           pfWrong(pfDocument ['"input stream not exhausted"],pfListOf [])
;          else if null $stack
;               then
;                  ncSoftError(tokPosn $stok,'S2CY0009, [])
;                  pfWrong(pfDocument ['"stack empty"],pfListOf [])
;               else
;                  first $stack

(DEFUN |npParse| (|stream|)
  (PROG (|$ttok| |$stok| |$stack| |$inputStream| |found|)
    (DECLARE (SPECIAL |$ttok| |$stok| |$stack| |$inputStream|))
    (RETURN
     (PROGN
      (SETQ |$inputStream| |stream|)
      (SETQ |$stack| NIL)
      (SETQ |$stok| NIL)
      (SETQ |$ttok| NIL)
      (|npFirstTok|)
      (SETQ |found| (CATCH 'TRAPPOINT (|npItem|)))
      (COND
       ((EQ |found| 'TRAPPED) (|ncSoftError| (|tokPosn| |$stok|) 'S2CY0006 NIL)
        (|pfWrong| (|pfDocument| "top level syntax error") (|pfListOf| NIL)))
       ((NULL (NULL |$inputStream|))
        (|ncSoftError| (|tokPosn| |$stok|) 'S2CY0002 NIL)
        (|pfWrong| (|pfDocument| (LIST "input stream not exhausted"))
         (|pfListOf| NIL)))
       ((NULL |$stack|) (|ncSoftError| (|tokPosn| |$stok|) 'S2CY0009 NIL)
        (|pfWrong| (|pfDocument| (LIST "stack empty")) (|pfListOf| NIL)))
       ('T (CAR |$stack|)))))))

; npItem()==
;      npQualDef() =>
;             npEqKey(";") =>
;                       [a,b]:=npItem1 npPop1 ()
;                       c:=pfEnSequence b
;                       a => npPush c
;                       npPush pfNovalue c
;             npPush pfEnSequence npPop1 ()
;      false

(DEFUN |npItem| ()
  (PROG (|c| |b| |a| |LETTMP#1|)
    (RETURN
     (COND
      ((|npQualDef|)
       (COND
        ((|npEqKey| '|;|)
         (PROGN
          (SETQ |LETTMP#1| (|npItem1| (|npPop1|)))
          (SETQ |a| (CAR |LETTMP#1|))
          (SETQ |b| (CADR |LETTMP#1|))
          (SETQ |c| (|pfEnSequence| |b|))
          (COND (|a| (|npPush| |c|)) (#1='T (|npPush| (|pfNovalue| |c|))))))
        (#1# (|npPush| (|pfEnSequence| (|npPop1|))))))
      (#1# NIL)))))

; npItem1 c==
;      npQualDef() =>
;             npEqKey(";") =>
;                       [a,b]:=npItem1 npPop1 ()
;                       [a,append(c,b)]
;             [true,append (c,npPop1())]
;      [false,c]

(DEFUN |npItem1| (|c|)
  (PROG (|LETTMP#1| |a| |b|)
    (RETURN
     (COND
      ((|npQualDef|)
       (COND
        ((|npEqKey| '|;|)
         (PROGN
          (SETQ |LETTMP#1| (|npItem1| (|npPop1|)))
          (SETQ |a| (CAR |LETTMP#1|))
          (SETQ |b| (CADR |LETTMP#1|))
          (LIST |a| (APPEND |c| |b|))))
        (#1='T (LIST T (APPEND |c| (|npPop1|))))))
      (#1# (LIST NIL |c|))))))

; npFirstTok()==
;       $stok:=
;           if null $inputStream
;           then tokConstruct("ERROR","NOMORE",tokPosn $stok)
;           else first $inputStream
;       $ttok:=tokPart $stok

(DEFUN |npFirstTok| ()
  (PROG ()
    (RETURN
     (PROGN
      (SETQ |$stok|
              (COND
               ((NULL |$inputStream|)
                (|tokConstruct| 'ERROR 'NOMORE (|tokPosn| |$stok|)))
               ('T (CAR |$inputStream|))))
      (SETQ |$ttok| (|tokPart| |$stok|))))))

; npNext() ==
;      $inputStream := rest($inputStream)
;      npFirstTok()

(DEFUN |npNext| ()
  (PROG ()
    (RETURN (PROGN (SETQ |$inputStream| (CDR |$inputStream|)) (|npFirstTok|)))))

; npState()==cons($inputStream,$stack)

(DEFUN |npState| () (PROG () (RETURN (CONS |$inputStream| |$stack|))))

; npRestore(x)==
;       $inputStream := first x
;       npFirstTok()
;       $stack := rest x
;       true

(DEFUN |npRestore| (|x|)
  (PROG ()
    (RETURN
     (PROGN
      (SETQ |$inputStream| (CAR |x|))
      (|npFirstTok|)
      (SETQ |$stack| (CDR |x|))
      T))))

; npPush x==$stack:=CONS(x,$stack)

(DEFUN |npPush| (|x|) (PROG () (RETURN (SETQ |$stack| (CONS |x| |$stack|)))))

; npPushId()==
;    a:=GET($ttok,'INFGENERIC)
;    $ttok:= if a then a else $ttok
;    $stack:=CONS(tokConstruct("id",$ttok,tokPosn $stok),$stack)
;    npNext()

(DEFUN |npPushId| ()
  (PROG (|a|)
    (RETURN
     (PROGN
      (SETQ |a| (GET |$ttok| 'INFGENERIC))
      (SETQ |$ttok| (COND (|a| |a|) ('T |$ttok|)))
      (SETQ |$stack|
              (CONS (|tokConstruct| '|id| |$ttok| (|tokPosn| |$stok|))
                    |$stack|))
      (|npNext|)))))

; npPop1()==
;        a := first $stack
;        $stack := rest $stack
;        a

(DEFUN |npPop1| ()
  (PROG (|a|)
    (RETURN
     (PROGN (SETQ |a| (CAR |$stack|)) (SETQ |$stack| (CDR |$stack|)) |a|))))

; npPop2()==
;        a:=CADR $stack
;        RPLACD($stack,CDDR $stack)
;        a

(DEFUN |npPop2| ()
  (PROG (|a|)
    (RETURN
     (PROGN (SETQ |a| (CADR |$stack|)) (RPLACD |$stack| (CDDR |$stack|)) |a|))))

; npPop3()==
;        a:=CADDR $stack
;        RPLACD(rest $stack, CDDDR $stack)
;        a

(DEFUN |npPop3| ()
  (PROG (|a|)
    (RETURN
     (PROGN
      (SETQ |a| (CADDR |$stack|))
      (RPLACD (CDR |$stack|) (CDDDR |$stack|))
      |a|))))

; npParenthesized f==
;    npParenthesize("(",")",f)

(DEFUN |npParenthesized| (|f|)
  (PROG () (RETURN (|npParenthesize| '|(| '|)| |f|))))

; npParenthesize (open,close,f)==
;     a:=$stok
;     npEqKey open =>
;          APPLY(f,nil) and (npEqKey close or npMissingMate(close,a))=> true
;          npEqKey close  =>  npPush  []
;          npMissingMate(close,a)
;     false

(DEFUN |npParenthesize| (|open| |close| |f|)
  (PROG (|a|)
    (RETURN
     (PROGN
      (SETQ |a| |$stok|)
      (COND
       ((|npEqKey| |open|)
        (COND
         ((AND (APPLY |f| NIL)
               (OR (|npEqKey| |close|) (|npMissingMate| |close| |a|)))
          T)
         ((|npEqKey| |close|) (|npPush| NIL))
         (#1='T (|npMissingMate| |close| |a|))))
       (#1# NIL))))))

; npEnclosed(open,close,fn,f)==
;     a:=$stok
;     npEqKey open =>
;         npEqKey close  => npPush FUNCALL(fn,a,pfTuple pfListOf [])
;         APPLY(f,nil) and (npEqKey close or npMissingMate(close,a))=>
;                    npPush FUNCALL (fn,a,pfEnSequence npPop1())
;         false
;     false

(DEFUN |npEnclosed| (|open| |close| |fn| |f|)
  (PROG (|a|)
    (RETURN
     (PROGN
      (SETQ |a| |$stok|)
      (COND
       ((|npEqKey| |open|)
        (COND
         ((|npEqKey| |close|)
          (|npPush| (FUNCALL |fn| |a| (|pfTuple| (|pfListOf| NIL)))))
         ((AND (APPLY |f| NIL)
               (OR (|npEqKey| |close|) (|npMissingMate| |close| |a|)))
          (|npPush| (FUNCALL |fn| |a| (|pfEnSequence| (|npPop1|)))))
         (#1='T NIL)))
       (#1# NIL))))))

; npParened f ==
;     npEnclosed("(",")",function pfParen,f)

(DEFUN |npParened| (|f|)
  (PROG () (RETURN (|npEnclosed| '|(| '|)| #'|pfParen| |f|))))

; npBracked f ==
;     npEnclosed("[","]",function pfBracket,f)

(DEFUN |npBracked| (|f|)
  (PROG () (RETURN (|npEnclosed| '[ '] #'|pfBracket| |f|))))

; npBraced f ==
;     npEnclosed("{","}",function pfBrace,f)

(DEFUN |npBraced| (|f|) (PROG () (RETURN (|npEnclosed| '{ '} #'|pfBrace| |f|))))

; npBracketed f==
;     npParened f or npBracked f or npBraced f

(DEFUN |npBracketed| (|f|)
  (PROG () (RETURN (OR (|npParened| |f|) (|npBracked| |f|) (|npBraced| |f|)))))

; npPileBracketed f==
;  if npEqKey "SETTAB"
;  then if npEqKey "BACKTAB"
;       then npPush pfNothing()     -- never happens
;       else if APPLY(f,nil) and (npEqKey "BACKTAB" or npMissing "backtab")
;            then npPush pfPile npPop1()
;            else false
;  else false

(DEFUN |npPileBracketed| (|f|)
  (PROG ()
    (RETURN
     (COND
      ((|npEqKey| 'SETTAB)
       (COND ((|npEqKey| 'BACKTAB) (|npPush| (|pfNothing|)))
             ((AND (APPLY |f| NIL)
                   (OR (|npEqKey| 'BACKTAB) (|npMissing| '|backtab|)))
              (|npPush| (|pfPile| (|npPop1|))))
             (#1='T NIL)))
      (#1# NIL)))))

; npListofFun(f,h,g)==
;     if APPLY(f,nil)
;     then
;         if APPLY(h,nil) and (APPLY(f,nil) or npTrap())
;         then
;           a:=$stack
;           $stack:=nil
;           while APPLY(h,nil) and (APPLY(f,nil) or npTrap()) repeat 0
;           $stack:=cons(NREVERSE $stack,a)
;           npPush FUNCALL(g, [npPop3(),npPop2(),:npPop1()])
;         else
;           true
;     else false

(DEFUN |npListofFun| (|f| |h| |g|)
  (PROG (|a|)
    (RETURN
     (COND
      ((APPLY |f| NIL)
       (COND
        ((AND (APPLY |h| NIL) (OR (APPLY |f| NIL) (|npTrap|)))
         (SETQ |a| |$stack|) (SETQ |$stack| NIL)
         ((LAMBDA ()
            (LOOP
             (COND
              ((NOT (AND (APPLY |h| NIL) (OR (APPLY |f| NIL) (|npTrap|))))
               (RETURN NIL))
              (#1='T 0)))))
         (SETQ |$stack| (CONS (NREVERSE |$stack|) |a|))
         (|npPush|
          (FUNCALL |g| (CONS (|npPop3|) (CONS (|npPop2|) (|npPop1|))))))
        (#1# T)))
      (#1# NIL)))))

; npList(f,str1,g)== -- always produces a list, g is applied to it
;     if APPLY(f,nil)
;     then
;         if npEqKey str1 and (npEqKey "BACKSET" or true)
;                        and (APPLY(f,nil) or npTrap())
;         then
;           a:=$stack
;           $stack:=nil
;           while npEqKey str1 and (npEqKey "BACKSET" or true) and
;                              (APPLY(f,nil) or npTrap()) repeat 0
;           $stack:=cons(NREVERSE $stack,a)
;           npPush FUNCALL(g,  [npPop3(),npPop2(),:npPop1()])
;         else
;           npPush FUNCALL(g, [npPop1()])
;     else npPush FUNCALL(g, [])

(DEFUN |npList| (|f| |str1| |g|)
  (PROG (|a|)
    (RETURN
     (COND
      ((APPLY |f| NIL)
       (COND
        ((AND (|npEqKey| |str1|) (OR (|npEqKey| 'BACKSET) T)
              (OR (APPLY |f| NIL) (|npTrap|)))
         (SETQ |a| |$stack|) (SETQ |$stack| NIL)
         ((LAMBDA ()
            (LOOP
             (COND
              ((NOT
                (AND (|npEqKey| |str1|) (OR (|npEqKey| 'BACKSET) T)
                     (OR (APPLY |f| NIL) (|npTrap|))))
               (RETURN NIL))
              (#1='T 0)))))
         (SETQ |$stack| (CONS (NREVERSE |$stack|) |a|))
         (|npPush|
          (FUNCALL |g| (CONS (|npPop3|) (CONS (|npPop2|) (|npPop1|))))))
        (#1# (|npPush| (FUNCALL |g| (LIST (|npPop1|)))))))
      (#1# (|npPush| (FUNCALL |g| NIL)))))))

; $npPParg := nil

(EVAL-WHEN (EVAL LOAD) (SETQ |$npPParg| NIL))

; npPPff() ==
;   FUNCALL $npPParg and npPush [npPop1()]

(DEFUN |npPPff| ()
  (PROG () (RETURN (AND (FUNCALL |$npPParg|) (|npPush| (LIST (|npPop1|)))))))

; npPPf() ==
;   npSemiListing function npPPff

(DEFUN |npPPf| () (PROG () (RETURN (|npSemiListing| #'|npPPff|))))

; npPPg() ==
;   npListAndRecover function npPPf
;     and npPush pfAppend npPop1()

(DEFUN |npPPg| ()
  (PROG ()
    (RETURN
     (AND (|npListAndRecover| #'|npPPf|) (|npPush| (|pfAppend| (|npPop1|)))))))

; npPP(f) ==
;   $npPParg := f
;   npParened function npPPf
;     or npPileBracketed function npPPg and
;       npPush pfEnSequence npPop1()
;         or FUNCALL f

(DEFUN |npPP| (|f|)
  (PROG ()
    (RETURN
     (PROGN
      (SETQ |$npPParg| |f|)
      (OR (|npParened| #'|npPPf|)
          (AND (|npPileBracketed| #'|npPPg|)
               (|npPush| (|pfEnSequence| (|npPop1|))))
          (FUNCALL |f|))))))

; $npPCff := nil

(EVAL-WHEN (EVAL LOAD) (SETQ |$npPCff| NIL))

; npPCff() ==
;   FUNCALL $npPCff and npPush [npPop1()]

(DEFUN |npPCff| ()
  (PROG () (RETURN (AND (FUNCALL |$npPCff|) (|npPush| (LIST (|npPop1|)))))))

; npPCg() ==
;   npListAndRecover function npPCff
;     and npPush pfAppend npPop1()

(DEFUN |npPCg| ()
  (PROG ()
    (RETURN
     (AND (|npListAndRecover| #'|npPCff|) (|npPush| (|pfAppend| (|npPop1|)))))))

; npPC(f) ==
;   $npPCff := f
;   npPileBracketed function npPCg and
;     npPush pfEnSequence npPop1()
;       or FUNCALL f

(DEFUN |npPC| (|f|)
  (PROG ()
    (RETURN
     (PROGN
      (SETQ |$npPCff| |f|)
      (OR
       (AND (|npPileBracketed| #'|npPCg|)
            (|npPush| (|pfEnSequence| (|npPop1|))))
       (FUNCALL |f|))))))

; npAnyNo s==
;      while APPLY(s,nil) repeat 0
;      true

(DEFUN |npAnyNo| (|s|)
  (PROG ()
    (RETURN
     (PROGN
      ((LAMBDA () (LOOP (COND ((NOT (APPLY |s| NIL)) (RETURN NIL)) ('T 0)))))
      T))))

; npAndOr(keyword,p,f)==
;    npEqKey keyword and (APPLY(p,nil) or npTrap())
;              and npPush FUNCALL(f, npPop1())

(DEFUN |npAndOr| (|keyword| |p| |f|)
  (PROG ()
    (RETURN
     (AND (|npEqKey| |keyword|) (OR (APPLY |p| NIL) (|npTrap|))
          (|npPush| (FUNCALL |f| (|npPop1|)))))))

; npRightAssoc(o,p)==
;     a:=npState()
;     if APPLY(p,nil)
;     then
;        while  npInfGeneric o and (npRightAssoc(o,p)
;                or (npPush pfApplication(npPop2(),npPop1());false)) repeat
;              npPush pfInfApplication(npPop2(),npPop2(),npPop1())
;        true
;     else
;        npRestore a
;        false

(DEFUN |npRightAssoc| (|o| |p|)
  (PROG (|a|)
    (RETURN
     (PROGN
      (SETQ |a| (|npState|))
      (COND
       ((APPLY |p| NIL)
        ((LAMBDA ()
           (LOOP
            (COND
             ((NOT
               (AND (|npInfGeneric| |o|)
                    (OR (|npRightAssoc| |o| |p|)
                        (PROGN
                         (|npPush| (|pfApplication| (|npPop2|) (|npPop1|)))
                         NIL))))
              (RETURN NIL))
             (#1='T
              (|npPush|
               (|pfInfApplication| (|npPop2|) (|npPop2|) (|npPop1|))))))))
        T)
       (#1# (|npRestore| |a|) NIL))))))

; npLeftAssoc(operations,parser)==
;     if APPLY(parser,nil)
;     then
;        while npInfGeneric(operations)
;          and (APPLY(parser,nil) or
;               (npPush pfApplication(npPop2(),npPop1());false))
;            repeat
;              npPush pfInfApplication(npPop2(),npPop2(),npPop1())
;        true
;     else false

(DEFUN |npLeftAssoc| (|operations| |parser|)
  (PROG ()
    (RETURN
     (COND
      ((APPLY |parser| NIL)
       ((LAMBDA ()
          (LOOP
           (COND
            ((NOT
              (AND (|npInfGeneric| |operations|)
                   (OR (APPLY |parser| NIL)
                       (PROGN
                        (|npPush| (|pfApplication| (|npPop2|) (|npPop1|)))
                        NIL))))
             (RETURN NIL))
            (#1='T
             (|npPush|
              (|pfInfApplication| (|npPop2|) (|npPop2|) (|npPop1|))))))))
       T)
      (#1# NIL)))))

; npInfixOp()==
;   EQ(CAAR $stok,"key") and
;     GET($ttok,"INFGENERIC") and npPushId()

(DEFUN |npInfixOp| ()
  (PROG ()
    (RETURN
     (AND (EQ (CAAR |$stok|) '|key|) (GET |$ttok| 'INFGENERIC) (|npPushId|)))))

; npInfixOperator()== npInfixOp() or
;         a:=npState()
;         b:=$stok
;         npEqKey "'" and npInfixOp() =>
;                 npPush pfSymb (npPop1 (),tokPosn b)
;         npRestore a
;         npEqKey "BACKQUOTE" and  npInfixOp() =>
;                 a:=npPop1()
;                 npPush tokConstruct("idsy",tokPart a,tokPosn a)
;         npRestore a
;         false

(DEFUN |npInfixOperator| ()
  (PROG (|b| |a|)
    (RETURN
     (OR (|npInfixOp|)
         (PROGN
          (SETQ |a| (|npState|))
          (SETQ |b| |$stok|)
          (COND
           ((AND (|npEqKey| '|'|) (|npInfixOp|))
            (|npPush| (|pfSymb| (|npPop1|) (|tokPosn| |b|))))
           (#1='T
            (PROGN
             (|npRestore| |a|)
             (COND
              ((AND (|npEqKey| 'BACKQUOTE) (|npInfixOp|))
               (PROGN
                (SETQ |a| (|npPop1|))
                (|npPush|
                 (|tokConstruct| '|idsy| (|tokPart| |a|) (|tokPosn| |a|)))))
              (#1# (PROGN (|npRestore| |a|) NIL)))))))))))

; npInfKey s==  EQ(CAAR $stok,"key") and  MEMQ($ttok,s) and npPushId()

(DEFUN |npInfKey| (|s|)
  (PROG ()
    (RETURN (AND (EQ (CAAR |$stok|) '|key|) (MEMQ |$ttok| |s|) (|npPushId|)))))

; npDDInfKey s==
;     npInfKey s or
;         a:=npState()
;         b:=$stok
;         npEqKey "'" and npInfKey s =>
;                  npPush pfSymb (npPop1 () ,tokPosn b)
;         npRestore a
;         npEqKey "BACKQUOTE" and  npInfKey s =>
;                 a:=npPop1()
;                 npPush tokConstruct("idsy",tokPart a,tokPosn a)
;         npRestore a
;         false

(DEFUN |npDDInfKey| (|s|)
  (PROG (|a| |b|)
    (RETURN
     (OR (|npInfKey| |s|)
         (PROGN
          (SETQ |a| (|npState|))
          (SETQ |b| |$stok|)
          (COND
           ((AND (|npEqKey| '|'|) (|npInfKey| |s|))
            (|npPush| (|pfSymb| (|npPop1|) (|tokPosn| |b|))))
           (#1='T
            (PROGN
             (|npRestore| |a|)
             (COND
              ((AND (|npEqKey| 'BACKQUOTE) (|npInfKey| |s|))
               (PROGN
                (SETQ |a| (|npPop1|))
                (|npPush|
                 (|tokConstruct| '|idsy| (|tokPart| |a|) (|tokPosn| |a|)))))
              (#1# (PROGN (|npRestore| |a|) NIL)))))))))))

; npInfGeneric s== npDDInfKey s  and
;                    (npEqKey "BACKSET" or true)

(DEFUN |npInfGeneric| (|s|)
  (PROG () (RETURN (AND (|npDDInfKey| |s|) (OR (|npEqKey| 'BACKSET) T)))))

; npConditional f==
;   if  npEqKey "if" and (npLogical() or npTrap()) and
;                    (npEqKey "BACKSET" or true)
;   then
;            if npEqKey "SETTAB"
;            then if npEqKey "then"
;                 then  (APPLY(f,nil) or npTrap()) and npElse(f)
;                         and npEqKey "BACKTAB"
;                 else  npMissing "then"
;            else if npEqKey "then"
;                 then (APPLY(f,nil) or npTrap()) and npElse(f)
;                 else npMissing "then"
;   else false

(DEFUN |npConditional| (|f|)
  (PROG ()
    (RETURN
     (COND
      ((AND (|npEqKey| '|if|) (OR (|npLogical|) (|npTrap|))
            (OR (|npEqKey| 'BACKSET) T))
       (COND
        ((|npEqKey| 'SETTAB)
         (COND
          ((|npEqKey| '|then|)
           (AND (OR (APPLY |f| NIL) (|npTrap|)) (|npElse| |f|)
                (|npEqKey| 'BACKTAB)))
          (#1='T (|npMissing| '|then|))))
        ((|npEqKey| '|then|)
         (AND (OR (APPLY |f| NIL) (|npTrap|)) (|npElse| |f|)))
        (#1# (|npMissing| '|then|))))
      (#1# NIL)))))

; npElse(f)==
;            a:=npState()
;            if npBacksetElse()
;            then  (APPLY(f,nil) or npTrap()) and
;                  npPush pfIf(npPop3(),npPop2(),npPop1())
;            else
;               npRestore a
;               npPush pfIfThenOnly(npPop2(),npPop1())

(DEFUN |npElse| (|f|)
  (PROG (|a|)
    (RETURN
     (PROGN
      (SETQ |a| (|npState|))
      (COND
       ((|npBacksetElse|)
        (AND (OR (APPLY |f| NIL) (|npTrap|))
             (|npPush| (|pfIf| (|npPop3|) (|npPop2|) (|npPop1|)))))
       ('T (|npRestore| |a|)
        (|npPush| (|pfIfThenOnly| (|npPop2|) (|npPop1|)))))))))

; npBacksetElse()==
;     if npEqKey "BACKSET"
;     then npEqKey "else"
;     else npEqKey "else"

(DEFUN |npBacksetElse| ()
  (PROG ()
    (RETURN
     (COND ((|npEqKey| 'BACKSET) (|npEqKey| '|else|))
           ('T (|npEqKey| '|else|))))))

; npWConditional f==
;     if npConditional f
;     then npPush pfTweakIf npPop1()
;     else false

(DEFUN |npWConditional| (|f|)
  (PROG ()
    (RETURN
     (COND ((|npConditional| |f|) (|npPush| (|pfTweakIf| (|npPop1|))))
           ('T NIL)))))

; npEqPeek s ==  EQ(CAAR $stok,"key") and EQ(s,$ttok)

(DEFUN |npEqPeek| (|s|)
  (PROG () (RETURN (AND (EQ (CAAR |$stok|) '|key|) (EQ |s| |$ttok|)))))

; npEqKey s ==
;     EQ(CAAR $stok,"key") and EQ(s,$ttok) and npNext()

(DEFUN |npEqKey| (|s|)
  (PROG ()
    (RETURN (AND (EQ (CAAR |$stok|) '|key|) (EQ |s| |$ttok|) (|npNext|)))))

; $npTokToNames:= ["~","#","[]","{}", "[||]","{||}"]

(EVAL-WHEN (EVAL LOAD)
  (SETQ |$npTokToNames| (LIST '~ '|#| '[] '{} '|[\|\|]| '|{\|\|}|)))

; npId() ==
;         EQ(CAAR $stok,"id") =>
;                npPush $stok
;                npNext()
;         EQ(CAAR $stok,"key") and MEMQ($ttok,$npTokToNames)=>
;                npPush tokConstruct("id",$ttok,tokPosn $stok)
;                npNext()
;         false

(DEFUN |npId| ()
  (PROG ()
    (RETURN
     (COND ((EQ (CAAR |$stok|) '|id|) (PROGN (|npPush| |$stok|) (|npNext|)))
           ((AND (EQ (CAAR |$stok|) '|key|) (MEMQ |$ttok| |$npTokToNames|))
            (PROGN
             (|npPush| (|tokConstruct| '|id| |$ttok| (|tokPosn| |$stok|)))
             (|npNext|)))
           ('T NIL)))))

; npSymbolVariable()==
;      a:=npState()
;      npEqKey "BACKQUOTE" and  npId()  =>
;           a:=npPop1()
;           npPush tokConstruct("idsy",tokPart a,tokPosn a)
;      npRestore a
;      false

(DEFUN |npSymbolVariable| ()
  (PROG (|a|)
    (RETURN
     (PROGN
      (SETQ |a| (|npState|))
      (COND
       ((AND (|npEqKey| 'BACKQUOTE) (|npId|))
        (PROGN
         (SETQ |a| (|npPop1|))
         (|npPush| (|tokConstruct| '|idsy| (|tokPart| |a|) (|tokPosn| |a|)))))
       ('T (PROGN (|npRestore| |a|) NIL)))))))

; npName()==npId() or npSymbolVariable()

(DEFUN |npName| () (PROG () (RETURN (OR (|npId|) (|npSymbolVariable|)))))

; npConstTok() ==
;      MEMQ(tokType $stok, '(integer string char float command)) =>
;           npPush $stok
;           npNext()
;      npEqPeek "'" =>
;           a:=$stok
;           b:=npState()
;           npNext()
;           if
;               npPrimary1() and npPush pfSymb(npPop1(),tokPosn a)
;           then true
;           else
;             npRestore b
;             false
;      false

(DEFUN |npConstTok| ()
  (PROG (|b| |a|)
    (RETURN
     (COND
      ((MEMQ (|tokType| |$stok|)
             '(|integer| |string| |char| |float| |command|))
       (PROGN (|npPush| |$stok|) (|npNext|)))
      ((|npEqPeek| '|'|)
       (PROGN
        (SETQ |a| |$stok|)
        (SETQ |b| (|npState|))
        (|npNext|)
        (COND
         ((AND (|npPrimary1|) (|npPush| (|pfSymb| (|npPop1|) (|tokPosn| |a|))))
          T)
         (#1='T (|npRestore| |b|) NIL))))
      (#1# NIL)))))

; npPrimary1() ==
;    npEncAp function npAtom1 or
;    npMacro() or
;    npBPileDefinition() or npDefn() or
;    npRule()

(DEFUN |npPrimary1| ()
  (PROG ()
    (RETURN
     (OR (|npEncAp| #'|npAtom1|) (|npMacro|) (|npBPileDefinition|) (|npDefn|)
         (|npRule|)))))

; npPrimary2()== npEncAp function npAtom2 -- or  npBPileDefinition()
;                or npAdd(pfNothing()) or npWith(pfNothing())

(DEFUN |npPrimary2| ()
  (PROG ()
    (RETURN
     (OR (|npEncAp| #'|npAtom2|) (|npAdd| (|pfNothing|))
         (|npWith| (|pfNothing|))))))

; npAtom1()== npPDefinition() or ((npName() or npConstTok() or
;        npDollar() or npBDefinition()) and npFromdom())

(DEFUN |npAtom1| ()
  (PROG ()
    (RETURN
     (OR (|npPDefinition|)
         (AND (OR (|npName|) (|npConstTok|) (|npDollar|) (|npBDefinition|))
              (|npFromdom|))))))

; npAtom2()== (npInfixOperator() or npAmpersand() or npPrefixColon())
;                            and npFromdom()

(DEFUN |npAtom2| ()
  (PROG ()
    (RETURN
     (AND (OR (|npInfixOperator|) (|npAmpersand|) (|npPrefixColon|))
          (|npFromdom|)))))

; npDollar()== npEqPeek "$" and
;    npPush tokConstruct("id","$",tokPosn $stok)
;    npNext()

(DEFUN |npDollar| ()
  (PROG ()
    (RETURN
     (AND (|npEqPeek| '$)
          (PROGN
           (|npPush| (|tokConstruct| '|id| '$ (|tokPosn| |$stok|)))
           (|npNext|))))))

; npPrefixColon()== npEqPeek(":") and
;    npPush tokConstruct("id",":",tokPosn $stok)
;    npNext()

(DEFUN |npPrefixColon| ()
  (PROG ()
    (RETURN
     (AND (|npEqPeek| '|:|)
          (PROGN
           (|npPush| (|tokConstruct| '|id| '|:| (|tokPosn| |$stok|)))
           (|npNext|))))))

; npEncAp(f)== APPLY(f,nil) and npAnyNo function npEncl
;                    and npFromdom()

(DEFUN |npEncAp| (|f|)
  (PROG () (RETURN (AND (APPLY |f| NIL) (|npAnyNo| #'|npEncl|) (|npFromdom|)))))

; npEncl()==  npBDefinition() and npPush pfApplication(npPop2(),npPop1())

(DEFUN |npEncl| ()
  (PROG ()
    (RETURN
     (AND (|npBDefinition|)
          (|npPush| (|pfApplication| (|npPop2|) (|npPop1|)))))))

; npFromdom()==
;   npEqKey "$" and (npApplication() or npTrap())
;       and npFromdom1 npPop1() and npPush pfFromDom(npPop1(),npPop1())
;          or true

(DEFUN |npFromdom| ()
  (PROG ()
    (RETURN
     (OR
      (AND (|npEqKey| '$) (OR (|npApplication|) (|npTrap|))
           (|npFromdom1| (|npPop1|))
           (|npPush| (|pfFromDom| (|npPop1|) (|npPop1|))))
      T))))

; npFromdom1 c==
;   npEqKey "$" and (npApplication() or npTrap())
;     and npFromdom1 npPop1()  and npPush pfFromDom(npPop1(),c)
;         or npPush c

(DEFUN |npFromdom1| (|c|)
  (PROG ()
    (RETURN
     (OR
      (AND (|npEqKey| '$) (OR (|npApplication|) (|npTrap|))
           (|npFromdom1| (|npPop1|)) (|npPush| (|pfFromDom| (|npPop1|) |c|)))
      (|npPush| |c|)))))

; npPrimary()==   npPrimary1() or npPrimary2()

(DEFUN |npPrimary| () (PROG () (RETURN (OR (|npPrimary1|) (|npPrimary2|)))))

; npDotted f== APPLY(f,nil) and npAnyNo function npSelector

(DEFUN |npDotted| (|f|)
  (PROG () (RETURN (AND (APPLY |f| NIL) (|npAnyNo| #'|npSelector|)))))

; npSelector()==
;             npEqKey(".") and (npPrimary() or npTrap()) and
;               npPush(pfApplication(npPop2(),npPop1()))

(DEFUN |npSelector| ()
  (PROG ()
    (RETURN
     (AND (|npEqKey| '|.|) (OR (|npPrimary|) (|npTrap|))
          (|npPush| (|pfApplication| (|npPop2|) (|npPop1|)))))))

; npApplication()==
;    npDotted function npPrimary and
;       (npApplication2() and
;             npPush(pfApplication(npPop2(),npPop1())) or true)

(DEFUN |npApplication| ()
  (PROG ()
    (RETURN
     (AND (|npDotted| #'|npPrimary|)
          (OR
           (AND (|npApplication2|)
                (|npPush| (|pfApplication| (|npPop2|) (|npPop1|))))
           T)))))

; npApplication2()==
;    npDotted function npPrimary1 and
;       (npApplication2() and
;             npPush(pfApplication(npPop2(),npPop1())) or true)

(DEFUN |npApplication2| ()
  (PROG ()
    (RETURN
     (AND (|npDotted| #'|npPrimary1|)
          (OR
           (AND (|npApplication2|)
                (|npPush| (|pfApplication| (|npPop2|) (|npPop1|))))
           T)))))

; npTypedForm1(sy,fn) ==
;      npEqKey sy  and (npType() or npTrap()) and
;         npPush FUNCALL(fn,npPop2(),npPop1())

(DEFUN |npTypedForm1| (|sy| |fn|)
  (PROG ()
    (RETURN
     (AND (|npEqKey| |sy|) (OR (|npType|) (|npTrap|))
          (|npPush| (FUNCALL |fn| (|npPop2|) (|npPop1|)))))))

; npTypedForm(sy,fn) ==
;      npEqKey sy  and (npApplication() or npTrap()) and
;         npPush FUNCALL(fn,npPop2(),npPop1())

(DEFUN |npTypedForm| (|sy| |fn|)
  (PROG ()
    (RETURN
     (AND (|npEqKey| |sy|) (OR (|npApplication|) (|npTrap|))
          (|npPush| (FUNCALL |fn| (|npPop2|) (|npPop1|)))))))

; npRestrict() == npTypedForm("@", function pfRestrict)

(DEFUN |npRestrict| () (PROG () (RETURN (|npTypedForm| '@ #'|pfRestrict|))))

; npCoerceTo() == npTypedForm("::", function pfCoerceto)

(DEFUN |npCoerceTo| () (PROG () (RETURN (|npTypedForm| '|::| #'|pfCoerceto|))))

; npPretend() == npTypedForm("pretend", function pfPretend)

(DEFUN |npPretend| ()
  (PROG () (RETURN (|npTypedForm| '|pretend| #'|pfPretend|))))

; npTypeStyle()==
;     npCoerceTo() or npRestrict() or npPretend()

(DEFUN |npTypeStyle| ()
  (PROG () (RETURN (OR (|npCoerceTo|) (|npRestrict|) (|npPretend|)))))

; npTypified ()==npApplication() and npAnyNo function npTypeStyle

(DEFUN |npTypified| ()
  (PROG () (RETURN (AND (|npApplication|) (|npAnyNo| #'|npTypeStyle|)))))

; npTagged() == npTypedForm1(":", function pfTagged)

(DEFUN |npTagged| () (PROG () (RETURN (|npTypedForm1| '|:| #'|pfTagged|))))

; npColon () == npTypified() and npAnyNo function npTagged

(DEFUN |npColon| ()
  (PROG () (RETURN (AND (|npTypified|) (|npAnyNo| #'|npTagged|)))))

; npPower() == npRightAssoc(["**", "^"], function npColon)

(DEFUN |npPower| ()
  (PROG () (RETURN (|npRightAssoc| (LIST '** '^) #'|npColon|))))

; npProduct()==
;     npLeftAssoc(["*", "/", "\", "SLASHSLASH",
;        "BACKSLASHBACKSLASH", "/\", "\/"], function npPower)

(DEFUN |npProduct| ()
  (PROG ()
    (RETURN
     (|npLeftAssoc|
      (LIST '* '/ '|\\| 'SLASHSLASH 'BACKSLASHBACKSLASH '|/\\| '|\\/|)
      #'|npPower|))))

; npRemainder()==
;     npLeftAssoc(["rem", "quo", "exquo"], function npProduct)

(DEFUN |npRemainder| ()
  (PROG ()
    (RETURN (|npLeftAssoc| (LIST '|rem| '|quo| '|exquo|) #'|npProduct|))))

; npTerm()==
;    npInfGeneric(["-", "+"]) and (npRemainder()
;         and npPush(pfApplication(npPop2(),npPop1())) or true)
;              or npRemainder()

(DEFUN |npTerm| ()
  (PROG ()
    (RETURN
     (OR
      (AND (|npInfGeneric| (LIST '- '+))
           (OR
            (AND (|npRemainder|)
                 (|npPush| (|pfApplication| (|npPop2|) (|npPop1|))))
            T))
      (|npRemainder|)))))

; npSum()==npLeftAssoc(["-", "+"], function npTerm)

(DEFUN |npSum| () (PROG () (RETURN (|npLeftAssoc| (LIST '- '+) #'|npTerm|))))

; npArith()==npLeftAssoc(["mod"], function npSum)

(DEFUN |npArith| () (PROG () (RETURN (|npLeftAssoc| (LIST '|mod|) #'|npSum|))))

; npSegment()==  npEqPeek "SEG"  and npPushId() and npFromdom()

(DEFUN |npSegment| ()
  (PROG () (RETURN (AND (|npEqPeek| 'SEG) (|npPushId|) (|npFromdom|)))))

; npInterval()==
;   npArith() and
;    (npSegment() and (((npEqPeek("|") or npEqPeek("by"))
;       and npPush(pfApplication(npPop1(),npPop1()))) or
;      (npArith() and npPush(pfInfApplication(npPop2(),npPop2(),npPop1())))
;             or npPush(pfApplication(npPop1(),npPop1()))) or true)

(DEFUN |npInterval| ()
  (PROG ()
    (RETURN
     (AND (|npArith|)
          (OR
           (AND (|npSegment|)
                (OR
                 (AND (OR (|npEqPeek| '|\||) (|npEqPeek| '|by|))
                      (|npPush| (|pfApplication| (|npPop1|) (|npPop1|))))
                 (AND (|npArith|)
                      (|npPush|
                       (|pfInfApplication| (|npPop2|) (|npPop2|) (|npPop1|))))
                 (|npPush| (|pfApplication| (|npPop1|) (|npPop1|)))))
           T)))))

; npBy()== npLeftAssoc(["by"], function npInterval)

(DEFUN |npBy| () (PROG () (RETURN (|npLeftAssoc| (LIST '|by|) #'|npInterval|))))

; npAmpersand()==  npEqKey "AMPERSAND" and (npName() or npTrap())

(DEFUN |npAmpersand| ()
  (PROG () (RETURN (AND (|npEqKey| 'AMPERSAND) (OR (|npName|) (|npTrap|))))))

; npAmpersandFrom()== npAmpersand()  and npFromdom()

(DEFUN |npAmpersandFrom| ()
  (PROG () (RETURN (AND (|npAmpersand|) (|npFromdom|)))))

; npSynthetic()==
;     if npBy()
;     then
;        while npAmpersandFrom()  and (npBy() or
;           (npPush pfApplication(npPop2(),npPop1());false)) repeat
;              npPush pfInfApplication(npPop2(),npPop2(),npPop1())
;        true
;     else false

(DEFUN |npSynthetic| ()
  (PROG ()
    (RETURN
     (COND
      ((|npBy|)
       ((LAMBDA ()
          (LOOP
           (COND
            ((NOT
              (AND (|npAmpersandFrom|)
                   (OR (|npBy|)
                       (PROGN
                        (|npPush| (|pfApplication| (|npPop2|) (|npPop1|)))
                        NIL))))
             (RETURN NIL))
            (#1='T
             (|npPush|
              (|pfInfApplication| (|npPop2|) (|npPop2|) (|npPop1|))))))))
       T)
      (#1# NIL)))))

; npRelation()==
;    npLeftAssoc(["=", "~=", "<", "<=", ">", ">=", "<<", ">>"],
;             function npSynthetic)

(DEFUN |npRelation| ()
  (PROG ()
    (RETURN
     (|npLeftAssoc| (LIST '= '~= '< '<= '> '>= '<< '>>) #'|npSynthetic|))))

; npQuiver()  ==    npRightAssoc('(ARROW LARROW),function npRelation)

(DEFUN |npQuiver| ()
  (PROG () (RETURN (|npRightAssoc| '(ARROW LARROW) #'|npRelation|))))

; npDiscrim() ==    npLeftAssoc(["case", "has"], function npQuiver)

(DEFUN |npDiscrim| ()
  (PROG () (RETURN (|npLeftAssoc| (LIST '|case| '|has|) #'|npQuiver|))))

; npDisjand() == npLeftAssoc(["and"], function npDiscrim)

(DEFUN |npDisjand| ()
  (PROG () (RETURN (|npLeftAssoc| (LIST '|and|) #'|npDiscrim|))))

; npLogical() == npLeftAssoc(["or"], function npDisjand)

(DEFUN |npLogical| ()
  (PROG () (RETURN (|npLeftAssoc| (LIST '|or|) #'|npDisjand|))))

; npSuch() == npLeftAssoc(["|"], function npLogical)

(DEFUN |npSuch| ()
  (PROG () (RETURN (|npLeftAssoc| (LIST '|\||) #'|npLogical|))))

; npMatch()   ==  npLeftAssoc(["is", "isnt"], function npSuch)

(DEFUN |npMatch| ()
  (PROG () (RETURN (|npLeftAssoc| (LIST '|is| '|isnt|) #'|npSuch|))))

; npType()    ==  npMatch()  and
;                 a:=npPop1()
;                 npWith(a) or npPush a

(DEFUN |npType| ()
  (PROG (|a|)
    (RETURN
     (AND (|npMatch|)
          (PROGN (SETQ |a| (|npPop1|)) (OR (|npWith| |a|) (|npPush| |a|)))))))

; npADD()    ==   npType() and
;                 a:=npPop1()
;                 npAdd(a) or npPush a

(DEFUN |npADD| ()
  (PROG (|a|)
    (RETURN
     (AND (|npType|)
          (PROGN (SETQ |a| (|npPop1|)) (OR (|npAdd| |a|) (|npPush| |a|)))))))

; npConditionalStatement()==npConditional function npQualifiedDefinition

(DEFUN |npConditionalStatement| ()
  (PROG () (RETURN (|npConditional| #'|npQualifiedDefinition|))))

; npExpress1()==npConditionalStatement() or  npADD()

(DEFUN |npExpress1| ()
  (PROG () (RETURN (OR (|npConditionalStatement|) (|npADD|)))))

; npCommaBackSet()== npEqKey(",") and (npEqKey "BACKSET" or true)

(DEFUN |npCommaBackSet| ()
  (PROG () (RETURN (AND (|npEqKey| '|,|) (OR (|npEqKey| 'BACKSET) T)))))

; npExpress()==
;      npExpress1() and
;         (npIterators() and
;              npPush pfCollect (npPop2(),pfListOf npPop1()) or true)

(DEFUN |npExpress| ()
  (PROG ()
    (RETURN
     (AND (|npExpress1|)
          (OR
           (AND (|npIterators|)
                (|npPush| (|pfCollect| (|npPop2|) (|pfListOf| (|npPop1|)))))
           T)))))

; npZeroOrMore f==
;        APPLY(f,nil)=>
;          a:=$stack
;          $stack:=nil
;          while APPLY(f,nil) repeat 0
;          $stack:=cons(NREVERSE $stack,a)
;          npPush cons(npPop2(),npPop1())
;        npPush nil
;        true

(DEFUN |npZeroOrMore| (|f|)
  (PROG (|a|)
    (RETURN
     (COND
      ((APPLY |f| NIL)
       (PROGN
        (SETQ |a| |$stack|)
        (SETQ |$stack| NIL)
        ((LAMBDA ()
           (LOOP (COND ((NOT (APPLY |f| NIL)) (RETURN NIL)) (#1='T 0)))))
        (SETQ |$stack| (CONS (NREVERSE |$stack|) |a|))
        (|npPush| (CONS (|npPop2|) (|npPop1|)))))
      (#1# (PROGN (|npPush| NIL) T))))))

; npIterators()==
;          npForIn() and npZeroOrMore function npIterator
;              and npPush cons(npPop2(),npPop1())  or
;               npWhile() and (npIterators() and
;                     npPush cons(npPop2(),npPop1()) or npPush [npPop1()])

(DEFUN |npIterators| ()
  (PROG ()
    (RETURN
     (OR
      (AND (|npForIn|) (|npZeroOrMore| #'|npIterator|)
           (|npPush| (CONS (|npPop2|) (|npPop1|))))
      (AND (|npWhile|)
           (OR (AND (|npIterators|) (|npPush| (CONS (|npPop2|) (|npPop1|))))
               (|npPush| (LIST (|npPop1|)))))))))

; npIterator()==   npForIn() or npSuchThat() or npWhile()

(DEFUN |npIterator| ()
  (PROG () (RETURN (OR (|npForIn|) (|npSuchThat|) (|npWhile|)))))

; npStatement()==
;         npExpress() or
;         npLoop() or
;         npIterate() or
;         npReturn() or
;         npBreak() or
;         npFree() or
;         npImport() or
;         npInline() or
;         npLocal() or
;         npExport() or
;         npTyping() or
;         npVoid()

(DEFUN |npStatement| ()
  (PROG ()
    (RETURN
     (OR (|npExpress|) (|npLoop|) (|npIterate|) (|npReturn|) (|npBreak|)
         (|npFree|) (|npImport|) (|npInline|) (|npLocal|) (|npExport|)
         (|npTyping|) (|npVoid|)))))

; npBackTrack(p1,p2,p3)==
;      a:=npState()
;      APPLY(p1,nil) =>
;          npEqPeek p2   =>
;             npRestore a
;             APPLY(p3,nil) or npTrap()
;          true
;      false

(DEFUN |npBackTrack| (|p1| |p2| |p3|)
  (PROG (|a|)
    (RETURN
     (PROGN
      (SETQ |a| (|npState|))
      (COND
       ((APPLY |p1| NIL)
        (COND
         ((|npEqPeek| |p2|)
          (PROGN (|npRestore| |a|) (OR (APPLY |p3| NIL) (|npTrap|))))
         (#1='T T)))
       (#1# NIL))))))

; npMDEF()== npBackTrack(function npStatement, "==>", function npMDEFinition)

(DEFUN |npMDEF| ()
  (PROG () (RETURN (|npBackTrack| #'|npStatement| '==> #'|npMDEFinition|))))

; npMDEFinition() == npPP function npMdef

(DEFUN |npMDEFinition| () (PROG () (RETURN (|npPP| #'|npMdef|))))

; npAssign()== npBackTrack(function npMDEF, ":=", function npAssignment)

(DEFUN |npAssign| ()
  (PROG () (RETURN (|npBackTrack| #'|npMDEF| '|:=| #'|npAssignment|))))

; npAssignment()==
;     npAssignVariable() and
;       (npEqKey(":=") or npTrap()) and
;         (npGives() or npTrap()) and
;            npPush pfAssign (npPop2(),npPop1())

(DEFUN |npAssignment| ()
  (PROG ()
    (RETURN
     (AND (|npAssignVariable|) (OR (|npEqKey| '|:=|) (|npTrap|))
          (OR (|npGives|) (|npTrap|))
          (|npPush| (|pfAssign| (|npPop2|) (|npPop1|)))))))

; npAssignVariableName()==npApplication() and
;       a:=npPop1()
;       if pfId? a
;       then
;          (npPush a and npDecl() or npPush pfTyped(npPop1(),pfNothing()))
;       else npPush a

(DEFUN |npAssignVariableName| ()
  (PROG (|a|)
    (RETURN
     (AND (|npApplication|)
          (PROGN
           (SETQ |a| (|npPop1|))
           (COND
            ((|pfId?| |a|)
             (OR (AND (|npPush| |a|) (|npDecl|))
                 (|npPush| (|pfTyped| (|npPop1|) (|pfNothing|)))))
            ('T (|npPush| |a|))))))))

; npAssignVariable()== npColon() and npPush pfListOf [npPop1()]

(DEFUN |npAssignVariable| ()
  (PROG ()
    (RETURN (AND (|npColon|) (|npPush| (|pfListOf| (LIST (|npPop1|))))))))

; npAssignVariablelist()== npListing function npAssignVariableName

(DEFUN |npAssignVariablelist| ()
  (PROG () (RETURN (|npListing| #'|npAssignVariableName|))))

; npExit()== npBackTrack(function npAssign, "=>", function npPileExit)

(DEFUN |npExit| ()
  (PROG () (RETURN (|npBackTrack| #'|npAssign| '=> #'|npPileExit|))))

; npPileExit()==
;      npAssign() and (npEqKey("=>") or npTrap()) and
;          (npStatement() or npTrap())
;            and npPush pfExit (npPop2(),npPop1())

(DEFUN |npPileExit| ()
  (PROG ()
    (RETURN
     (AND (|npAssign|) (OR (|npEqKey| '=>) (|npTrap|))
          (OR (|npStatement|) (|npTrap|))
          (|npPush| (|pfExit| (|npPop2|) (|npPop1|)))))))

; npGives()== npBackTrack(function npExit, "+->", function npLambda)

(DEFUN |npGives| ()
  (PROG () (RETURN (|npBackTrack| #'|npExit| '+-> #'|npLambda|))))

; npDefinitionOrStatement()==
;             npBackTrack(function npGives, "==", function npDef)

(DEFUN |npDefinitionOrStatement| ()
  (PROG () (RETURN (|npBackTrack| #'|npGives| '== #'|npDef|))))

; npVoid()== npAndOr("DO",function npStatement,function pfNovalue)

(DEFUN |npVoid| ()
  (PROG () (RETURN (|npAndOr| 'DO #'|npStatement| #'|pfNovalue|))))

; npReturn()==
;          npEqKey "return" and
;           (npExpress() or npPush pfNothing()) and
;            (npEqKey "from" and (npName() or npTrap()) and
;               npPush pfReturn (npPop2(),npPop1()) or
;                 npPush pfReturnNoName npPop1())

(DEFUN |npReturn| ()
  (PROG ()
    (RETURN
     (AND (|npEqKey| '|return|) (OR (|npExpress|) (|npPush| (|pfNothing|)))
          (OR
           (AND (|npEqKey| '|from|) (OR (|npName|) (|npTrap|))
                (|npPush| (|pfReturn| (|npPop2|) (|npPop1|))))
           (|npPush| (|pfReturnNoName| (|npPop1|))))))))

; npLoop()==
;      npIterators() and
;       (npCompMissing "repeat" and
;          (npAssign() or npTrap()) and
;             npPush pfLp(npPop2(),npPop1()))
;                 or
;                   npEqKey "repeat" and (npAssign() or npTrap()) and
;                        npPush pfLoop1 npPop1 ()

(DEFUN |npLoop| ()
  (PROG ()
    (RETURN
     (OR
      (AND (|npIterators|) (|npCompMissing| '|repeat|)
           (OR (|npAssign|) (|npTrap|))
           (|npPush| (|pfLp| (|npPop2|) (|npPop1|))))
      (AND (|npEqKey| '|repeat|) (OR (|npAssign|) (|npTrap|))
           (|npPush| (|pfLoop1| (|npPop1|))))))))

; npSuchThat()==npAndOr("|", function npLogical, function pfSuchthat)

(DEFUN |npSuchThat| ()
  (PROG () (RETURN (|npAndOr| '|\|| #'|npLogical| #'|pfSuchthat|))))

; npWhile() == npAndOr("while", function npLogical, function pfWhile)

(DEFUN |npWhile| ()
  (PROG () (RETURN (|npAndOr| '|while| #'|npLogical| #'|pfWhile|))))

; npForIn()==
;   npEqKey "for" and (npVariable() or npTrap()) and (npCompMissing "in")
;       and ((npBy()  or npTrap()) and
;          npPush pfForin(npPop2(),npPop1()))

(DEFUN |npForIn| ()
  (PROG ()
    (RETURN
     (AND (|npEqKey| '|for|) (OR (|npVariable|) (|npTrap|))
          (|npCompMissing| '|in|) (OR (|npBy|) (|npTrap|))
          (|npPush| (|pfForin| (|npPop2|) (|npPop1|)))))))

; npBreak()==
;      npEqKey "break" and  npPush pfBreak pfNothing ()

(DEFUN |npBreak| ()
  (PROG ()
    (RETURN (AND (|npEqKey| '|break|) (|npPush| (|pfBreak| (|pfNothing|)))))))

; npIterate()==
;      npEqKey "ITERATE" and  npPush pfIterate pfNothing ()

(DEFUN |npIterate| ()
  (PROG ()
    (RETURN (AND (|npEqKey| 'ITERATE) (|npPush| (|pfIterate| (|pfNothing|)))))))

; npQualType()==
;      npType() and
;             npPush pfQualType(npPop1(),pfNothing())

(DEFUN |npQualType| ()
  (PROG ()
    (RETURN
     (AND (|npType|) (|npPush| (|pfQualType| (|npPop1|) (|pfNothing|)))))))

; npSQualTypelist()== npListing function npQualType
;                 and npPush pfParts npPop1 ()

(DEFUN |npSQualTypelist| ()
  (PROG ()
    (RETURN
     (AND (|npListing| #'|npQualType|) (|npPush| (|pfParts| (|npPop1|)))))))

; npQualTypelist()== npPC function npSQualTypelist
;                              and npPush pfUnSequence npPop1 ()

(DEFUN |npQualTypelist| ()
  (PROG ()
    (RETURN
     (AND (|npPC| #'|npSQualTypelist|)
          (|npPush| (|pfUnSequence| (|npPop1|)))))))

; npImport() == npAndOr("import", function npQualTypelist, function pfImport)

(DEFUN |npImport| ()
  (PROG () (RETURN (|npAndOr| '|import| #'|npQualTypelist| #'|pfImport|))))

; npInline()==npAndOr("INLINE",function npQualTypelist,function pfInline)

(DEFUN |npInline| ()
  (PROG () (RETURN (|npAndOr| 'INLINE #'|npQualTypelist| #'|pfInline|))))

; npLocalDecl()== npEqKey(":") and (npType() or npTrap()) and
;              npPush pfSpread (pfParts npPop2(),npPop1()) or
;               npPush pfSpread (pfParts npPop1(),pfNothing())

(DEFUN |npLocalDecl| ()
  (PROG ()
    (RETURN
     (OR
      (AND (|npEqKey| '|:|) (OR (|npType|) (|npTrap|))
           (|npPush| (|pfSpread| (|pfParts| (|npPop2|)) (|npPop1|))))
      (|npPush| (|pfSpread| (|pfParts| (|npPop1|)) (|pfNothing|)))))))

; npLocalItem()==npTypeVariable() and  npLocalDecl()

(DEFUN |npLocalItem| ()
  (PROG () (RETURN (AND (|npTypeVariable|) (|npLocalDecl|)))))

; npLocalItemlist()== npPC function npSLocalItem
;                              and npPush pfUnSequence npPop1 ()

(DEFUN |npLocalItemlist| ()
  (PROG ()
    (RETURN
     (AND (|npPC| #'|npSLocalItem|) (|npPush| (|pfUnSequence| (|npPop1|)))))))

; npSLocalItem()== npListing function npLocalItem
;         and npPush  pfAppend pfParts npPop1()

(DEFUN |npSLocalItem| ()
  (PROG ()
    (RETURN
     (AND (|npListing| #'|npLocalItem|)
          (|npPush| (|pfAppend| (|pfParts| (|npPop1|))))))))

; npFree()== npEqKey "FREE" and (npLocalItemlist() or npTrap())
;      and npPush pfFree npPop1()

(DEFUN |npFree| ()
  (PROG ()
    (RETURN
     (AND (|npEqKey| 'FREE) (OR (|npLocalItemlist|) (|npTrap|))
          (|npPush| (|pfFree| (|npPop1|)))))))

; npLocal()== npEqKey "local" and (npLocalItemlist() or npTrap())
;      and npPush pfLocal npPop1()

(DEFUN |npLocal| ()
  (PROG ()
    (RETURN
     (AND (|npEqKey| '|local|) (OR (|npLocalItemlist|) (|npTrap|))
          (|npPush| (|pfLocal| (|npPop1|)))))))

; npExport()== npEqKey "EXPORT" and (npLocalItemlist() or npTrap())
;      and npPush pfExport npPop1()

(DEFUN |npExport| ()
  (PROG ()
    (RETURN
     (AND (|npEqKey| 'EXPORT) (OR (|npLocalItemlist|) (|npTrap|))
          (|npPush| (|pfExport| (|npPop1|)))))))

; npDefn()== npEqKey "DEFN" and  npPP function npDef

(DEFUN |npDefn| ()
  (PROG () (RETURN (AND (|npEqKey| 'DEFN) (|npPP| #'|npDef|)))))

; npMacro()== npEqKey "MACRO" and  npPP function npMdef

(DEFUN |npMacro| ()
  (PROG () (RETURN (AND (|npEqKey| 'MACRO) (|npPP| #'|npMdef|)))))

; npRule()== npEqKey "RULE" and  npPP function npSingleRule

(DEFUN |npRule| ()
  (PROG () (RETURN (AND (|npEqKey| 'RULE) (|npPP| #'|npSingleRule|)))))

; npAdd(extra)==
;      npEqKey "add" and
;        a:=npState()
;        npDefinitionOrStatement() or npTrap()
;        npEqPeek "in" =>
;                npRestore a
;                (npVariable() or npTrap()) and
;                      npCompMissing "in"  and
;                          (npDefinitionOrStatement() or npTrap()) and
;                             npPush pfAdd(npPop2(),npPop1(),extra)
;        npPush pfAdd(pfNothing(),npPop1(),extra)

(DEFUN |npAdd| (|extra|)
  (PROG (|a|)
    (RETURN
     (AND (|npEqKey| '|add|)
          (PROGN
           (SETQ |a| (|npState|))
           (OR (|npDefinitionOrStatement|) (|npTrap|))
           (COND
            ((|npEqPeek| '|in|)
             (PROGN
              (|npRestore| |a|)
              (AND (OR (|npVariable|) (|npTrap|)) (|npCompMissing| '|in|)
                   (OR (|npDefinitionOrStatement|) (|npTrap|))
                   (|npPush| (|pfAdd| (|npPop2|) (|npPop1|) |extra|)))))
            ('T (|npPush| (|pfAdd| (|pfNothing|) (|npPop1|) |extra|)))))))))

; npDefaultValue()==
;       npEqKey "DEFAULT" and
;              (npDefinitionOrStatement() or npTrap())
;          and  npPush [pfAdd(pfNothing(),npPop1(),pfNothing())]

(DEFUN |npDefaultValue| ()
  (PROG ()
    (RETURN
     (AND (|npEqKey| 'DEFAULT) (OR (|npDefinitionOrStatement|) (|npTrap|))
          (|npPush| (LIST (|pfAdd| (|pfNothing|) (|npPop1|) (|pfNothing|))))))))

; npWith(extra)==
;      npEqKey "with" and
;        a:=npState()
;        npCategoryL() or npTrap()
;        npEqPeek "in" =>
;                npRestore a
;                (npVariable() or npTrap()) and
;                      npCompMissing "in"  and
;                           (npCategoryL() or npTrap()) and
;                               npPush pfWith(npPop2(),npPop1(),extra)
;        npPush pfWith(pfNothing(),npPop1(),extra)

(DEFUN |npWith| (|extra|)
  (PROG (|a|)
    (RETURN
     (AND (|npEqKey| '|with|)
          (PROGN
           (SETQ |a| (|npState|))
           (OR (|npCategoryL|) (|npTrap|))
           (COND
            ((|npEqPeek| '|in|)
             (PROGN
              (|npRestore| |a|)
              (AND (OR (|npVariable|) (|npTrap|)) (|npCompMissing| '|in|)
                   (OR (|npCategoryL|) (|npTrap|))
                   (|npPush| (|pfWith| (|npPop2|) (|npPop1|) |extra|)))))
            ('T (|npPush| (|pfWith| (|pfNothing|) (|npPop1|) |extra|)))))))))

; npCategoryL()== npCategory() and npPush pfUnSequence npPop1 ()

(DEFUN |npCategoryL| ()
  (PROG ()
    (RETURN (AND (|npCategory|) (|npPush| (|pfUnSequence| (|npPop1|)))))))

; pfUnSequence x==
;         pfSequence? x =>   pfListOf pfAppend pf0SequenceArgs  x
;         pfListOf x

(DEFUN |pfUnSequence| (|x|)
  (PROG ()
    (RETURN
     (COND
      ((|pfSequence?| |x|) (|pfListOf| (|pfAppend| (|pf0SequenceArgs| |x|))))
      ('T (|pfListOf| |x|))))))

; npCategory()== npPP function npSCategory

(DEFUN |npCategory| () (PROG () (RETURN (|npPP| #'|npSCategory|))))

; npSCategory()==
;   if npWConditional function npCategoryL
;   then  npPush [npPop1()]
;   else
;     if npDefaultValue()
;     then true
;     else
;       a:=npState()
;       if npPrimary()
;       then if npEqPeek(":")
;            then
;               npRestore a
;               npSignature()
;            else
;               npRestore a
;               npApplication() and npPush [pfAttribute (npPop1())]
;                            or npTrap()
;
;       else false

(DEFUN |npSCategory| ()
  (PROG (|a|)
    (RETURN
     (COND ((|npWConditional| #'|npCategoryL|) (|npPush| (LIST (|npPop1|))))
           ((|npDefaultValue|) T)
           (#1='T (SETQ |a| (|npState|))
            (COND
             ((|npPrimary|)
              (COND ((|npEqPeek| '|:|) (|npRestore| |a|) (|npSignature|))
                    (#1# (|npRestore| |a|)
                     (OR
                      (AND (|npApplication|)
                           (|npPush| (LIST (|pfAttribute| (|npPop1|)))))
                      (|npTrap|)))))
             (#1# NIL)))))))

; npSignatureDefinee()==
;    npName() or npInfixOperator() or npPrefixColon()

(DEFUN |npSignatureDefinee| ()
  (PROG () (RETURN (OR (|npName|) (|npInfixOperator|) (|npPrefixColon|)))))

; npSigDecl()== npEqKey(":") and (npType() or npTrap()) and
;            npPush pfSpread (pfParts npPop2(),npPop1())

(DEFUN |npSigDecl| ()
  (PROG ()
    (RETURN
     (AND (|npEqKey| '|:|) (OR (|npType|) (|npTrap|))
          (|npPush| (|pfSpread| (|pfParts| (|npPop2|)) (|npPop1|)))))))

; npSigItem()==npTypeVariable() and  (npSigDecl() or npTrap())

(DEFUN |npSigItem| ()
  (PROG () (RETURN (AND (|npTypeVariable|) (OR (|npSigDecl|) (|npTrap|))))))

; npSigItemlist()== npListing function npSigItem
;         and npPush pfListOf pfAppend pfParts npPop1()

(DEFUN |npSigItemlist| ()
  (PROG ()
    (RETURN
     (AND (|npListing| #'|npSigItem|)
          (|npPush| (|pfListOf| (|pfAppend| (|pfParts| (|npPop1|)))))))))

; npSignature()==
;     npSigItemlist() and
;             npPush pfWDec(pfNothing(),npPop1())

(DEFUN |npSignature| ()
  (PROG ()
    (RETURN
     (AND (|npSigItemlist|) (|npPush| (|pfWDec| (|pfNothing|) (|npPop1|)))))))

; npSemiListing (p)==
;        npListofFun(p,function npSemiBackSet,function pfAppend)

(DEFUN |npSemiListing| (|p|)
  (PROG () (RETURN (|npListofFun| |p| #'|npSemiBackSet| #'|pfAppend|))))

; npSemiBackSet()== npEqKey(";") and (npEqKey "BACKSET" or true)

(DEFUN |npSemiBackSet| ()
  (PROG () (RETURN (AND (|npEqKey| '|;|) (OR (|npEqKey| 'BACKSET) T)))))

; npDecl()== npEqKey(":") and (npType() or npTrap()) and
;            npPush pfTyped (npPop2(),npPop1())

(DEFUN |npDecl| ()
  (PROG ()
    (RETURN
     (AND (|npEqKey| '|:|) (OR (|npType|) (|npTrap|))
          (|npPush| (|pfTyped| (|npPop2|) (|npPop1|)))))))

; npVariableName()==npName() and
;       (npDecl() or npPush pfTyped(npPop1(),pfNothing()))

(DEFUN |npVariableName| ()
  (PROG ()
    (RETURN
     (AND (|npName|)
          (OR (|npDecl|) (|npPush| (|pfTyped| (|npPop1|) (|pfNothing|))))))))

; npVariable()== npParenthesized function npVariablelist or
;       (npVariableName() and npPush pfListOf [npPop1()])

(DEFUN |npVariable| ()
  (PROG ()
    (RETURN
     (OR (|npParenthesized| #'|npVariablelist|)
         (AND (|npVariableName|) (|npPush| (|pfListOf| (LIST (|npPop1|)))))))))

; npVariablelist()== npListing function npVariableName

(DEFUN |npVariablelist| () (PROG () (RETURN (|npListing| #'|npVariableName|))))

; npListing (p)==npList(p, ",", function pfListOf)

(DEFUN |npListing| (|p|) (PROG () (RETURN (|npList| |p| '|,| #'|pfListOf|))))

; npQualified(f)==
;     FUNCALL f =>
;         while npEqKey "where" and (npDefinition() or npTrap()) repeat
;              npPush pfWhere(npPop1(),npPop1())
;         true
;     false

(DEFUN |npQualified| (|f|)
  (PROG ()
    (RETURN
     (COND
      ((FUNCALL |f|)
       (PROGN
        ((LAMBDA ()
           (LOOP
            (COND
             ((NOT (AND (|npEqKey| '|where|) (OR (|npDefinition|) (|npTrap|))))
              (RETURN NIL))
             (#1='T (|npPush| (|pfWhere| (|npPop1|) (|npPop1|))))))))
        T))
      (#1# NIL)))))

; npQualifiedDefinition()==
;        npQualified function npDefinitionOrStatement

(DEFUN |npQualifiedDefinition| ()
  (PROG () (RETURN (|npQualified| #'|npDefinitionOrStatement|))))

; npTuple (p)==
;     npListofFun(p,function npCommaBackSet,function pfTupleListOf)

(DEFUN |npTuple| (|p|)
  (PROG () (RETURN (|npListofFun| |p| #'|npCommaBackSet| #'|pfTupleListOf|))))

; npComma()==  npTuple function npQualifiedDefinition

(DEFUN |npComma| () (PROG () (RETURN (|npTuple| #'|npQualifiedDefinition|))))

; npQualDef()== npComma() and npPush [npPop1()]

(DEFUN |npQualDef| ()
  (PROG () (RETURN (AND (|npComma|) (|npPush| (LIST (|npPop1|)))))))

; npDefinitionlist ()==npSemiListing(function npQualDef)

(DEFUN |npDefinitionlist| () (PROG () (RETURN (|npSemiListing| #'|npQualDef|))))

; npPDefinition ()==
;      npParenthesized function npDefinitionlist and
;                  npPush pfEnSequence npPop1()

(DEFUN |npPDefinition| ()
  (PROG ()
    (RETURN
     (AND (|npParenthesized| #'|npDefinitionlist|)
          (|npPush| (|pfEnSequence| (|npPop1|)))))))

; npBDefinition()== npPDefinition() or
;             npBracketed function npDefinitionlist

(DEFUN |npBDefinition| ()
  (PROG ()
    (RETURN (OR (|npPDefinition|) (|npBracketed| #'|npDefinitionlist|)))))

; npPileDefinitionlist()==
;  npListAndRecover function npDefinitionlist
;     and npPush pfAppend npPop1()

(DEFUN |npPileDefinitionlist| ()
  (PROG ()
    (RETURN
     (AND (|npListAndRecover| #'|npDefinitionlist|)
          (|npPush| (|pfAppend| (|npPop1|)))))))

; npTypeVariable()== npParenthesized function npTypeVariablelist or
;            npSignatureDefinee() and npPush pfListOf [npPop1()]

(DEFUN |npTypeVariable| ()
  (PROG ()
    (RETURN
     (OR (|npParenthesized| #'|npTypeVariablelist|)
         (AND (|npSignatureDefinee|)
              (|npPush| (|pfListOf| (LIST (|npPop1|)))))))))

; npTypeVariablelist()== npListing function npSignatureDefinee

(DEFUN |npTypeVariablelist| ()
  (PROG () (RETURN (|npListing| #'|npSignatureDefinee|))))

; npTyping()==
;       npEqKey "DEFAULT" and  (npDefaultItemlist() or npTrap())
;                 and npPush pfTyping npPop1()

(DEFUN |npTyping| ()
  (PROG ()
    (RETURN
     (AND (|npEqKey| 'DEFAULT) (OR (|npDefaultItemlist|) (|npTrap|))
          (|npPush| (|pfTyping| (|npPop1|)))))))

; npDefaultItemlist()== npPC function npSDefaultItem
;                              and npPush pfUnSequence npPop1 ()

(DEFUN |npDefaultItemlist| ()
  (PROG ()
    (RETURN
     (AND (|npPC| #'|npSDefaultItem|) (|npPush| (|pfUnSequence| (|npPop1|)))))))

; npDefaultDecl()== npEqKey(":") and (npType() or npTrap()) and
;            npPush pfSpread (pfParts npPop2(),npPop1())

(DEFUN |npDefaultDecl| ()
  (PROG ()
    (RETURN
     (AND (|npEqKey| '|:|) (OR (|npType|) (|npTrap|))
          (|npPush| (|pfSpread| (|pfParts| (|npPop2|)) (|npPop1|)))))))

; npDefaultItem()==npTypeVariable() and (npDefaultDecl() or npTrap())

(DEFUN |npDefaultItem| ()
  (PROG () (RETURN (AND (|npTypeVariable|) (OR (|npDefaultDecl|) (|npTrap|))))))

; npSDefaultItem()== npListing function npDefaultItem
;         and npPush pfAppend pfParts npPop1()

(DEFUN |npSDefaultItem| ()
  (PROG ()
    (RETURN
     (AND (|npListing| #'|npDefaultItem|)
          (|npPush| (|pfAppend| (|pfParts| (|npPop1|))))))))

; npBPileDefinition()==
;      npPileBracketed function npPileDefinitionlist
;        and npPush pfSequence pfListOf npPop1 ()

(DEFUN |npBPileDefinition| ()
  (PROG ()
    (RETURN
     (AND (|npPileBracketed| #'|npPileDefinitionlist|)
          (|npPush| (|pfSequence| (|pfListOf| (|npPop1|))))))))

; npLambda()==
;      (npVariable() and
;       ((npLambda() or npTrap()) and
;        npPush pfLam(npPop2(),npPop1()))) or
;          npEqKey("+->") and (npDefinitionOrStatement() or npTrap()) or
;           npEqKey(":") and (npType() or npTrap()) and
;             npEqKey("+->") and (npDefinitionOrStatement() or npTrap())
;                and
;                   npPush pfReturnTyped(npPop2(),npPop1())

(DEFUN |npLambda| ()
  (PROG ()
    (RETURN
     (OR
      (AND (|npVariable|) (OR (|npLambda|) (|npTrap|))
           (|npPush| (|pfLam| (|npPop2|) (|npPop1|))))
      (AND (|npEqKey| '+->) (OR (|npDefinitionOrStatement|) (|npTrap|)))
      (AND (|npEqKey| '|:|) (OR (|npType|) (|npTrap|)) (|npEqKey| '+->)
           (OR (|npDefinitionOrStatement|) (|npTrap|))
           (|npPush| (|pfReturnTyped| (|npPop2|) (|npPop1|))))))))

; npDef()==
;     npMatch() =>
;          [op,arg,rt]:=  pfCheckItOut(npPop1())
;          npDefTail() or npTrap()
;          body:=npPop1()
;          null arg => npPush pfDefinition (op,body)
;          npPush pfDefinition (op,pfPushBody(rt,arg,body))
;     false

(DEFUN |npDef| ()
  (PROG (|body| |rt| |arg| |op| |LETTMP#1|)
    (RETURN
     (COND
      ((|npMatch|)
       (PROGN
        (SETQ |LETTMP#1| (|pfCheckItOut| (|npPop1|)))
        (SETQ |op| (CAR |LETTMP#1|))
        (SETQ |arg| (CADR . #1=(|LETTMP#1|)))
        (SETQ |rt| (CADDR . #1#))
        (OR (|npDefTail|) (|npTrap|))
        (SETQ |body| (|npPop1|))
        (COND ((NULL |arg|) (|npPush| (|pfDefinition| |op| |body|)))
              (#2='T
               (|npPush|
                (|pfDefinition| |op| (|pfPushBody| |rt| |arg| |body|)))))))
      (#2# NIL)))))

; npDefTail()== (npEqKey("==") or npEqKey("==>")) and npDefinitionOrStatement()

(DEFUN |npDefTail| ()
  (PROG ()
    (RETURN
     (AND (OR (|npEqKey| '==) (|npEqKey| '==>)) (|npDefinitionOrStatement|)))))

; npMdef()==
;     npQuiver() =>
;          [op,arg]:=  pfCheckMacroOut(npPop1())
;          npDefTail() or npTrap()
;          body:=npPop1()
;          null arg => npPush pfMacro (op,body)
;          npPush pfMacro (op,pfPushMacroBody(arg,body))
;     false

(DEFUN |npMdef| ()
  (PROG (|body| |arg| |op| |LETTMP#1|)
    (RETURN
     (COND
      ((|npQuiver|)
       (PROGN
        (SETQ |LETTMP#1| (|pfCheckMacroOut| (|npPop1|)))
        (SETQ |op| (CAR |LETTMP#1|))
        (SETQ |arg| (CADR |LETTMP#1|))
        (OR (|npDefTail|) (|npTrap|))
        (SETQ |body| (|npPop1|))
        (COND ((NULL |arg|) (|npPush| (|pfMacro| |op| |body|)))
              (#1='T
               (|npPush| (|pfMacro| |op| (|pfPushMacroBody| |arg| |body|)))))))
      (#1# NIL)))))

; npSingleRule()==
;     npQuiver() =>
;          npDefTail() or npTrap()
;          npPush pfRule (npPop2(),npPop1())
;     false

(DEFUN |npSingleRule| ()
  (PROG ()
    (RETURN
     (COND
      ((|npQuiver|)
       (PROGN
        (OR (|npDefTail|) (|npTrap|))
        (|npPush| (|pfRule| (|npPop2|) (|npPop1|)))))
      ('T NIL)))))

; npDefinitionItem()==
;    npTyping() or
;       npImport()  or
;           a:=npState()
;           npStatement() =>
;                npEqPeek("==") =>
;                   npRestore a
;                   npDef()
;                npRestore a
;                npMacro() or npDefn()
;           npTrap()

(DEFUN |npDefinitionItem| ()
  (PROG (|a|)
    (RETURN
     (OR (|npTyping|) (|npImport|)
         (PROGN
          (SETQ |a| (|npState|))
          (COND
           ((|npStatement|)
            (COND ((|npEqPeek| '==) (PROGN (|npRestore| |a|) (|npDef|)))
                  (#1='T
                   (PROGN (|npRestore| |a|) (OR (|npMacro|) (|npDefn|))))))
           (#1# (|npTrap|))))))))

; npDefinition()== npPP function npDefinitionItem
;             and npPush  pfSequenceToList npPop1 ()

(DEFUN |npDefinition| ()
  (PROG ()
    (RETURN
     (AND (|npPP| #'|npDefinitionItem|)
          (|npPush| (|pfSequenceToList| (|npPop1|)))))))

; pfSequenceToList x==
;         pfSequence? x =>  pfSequenceArgs  x
;         pfListOf [x]

(DEFUN |pfSequenceToList| (|x|)
  (PROG ()
    (RETURN
     (COND ((|pfSequence?| |x|) (|pfSequenceArgs| |x|))
           ('T (|pfListOf| (LIST |x|)))))))
