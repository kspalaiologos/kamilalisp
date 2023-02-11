
; )package "BOOT"

(IN-PACKAGE "BOOT")

; ncTag x ==
;    not PAIRP x => ncBug('S2CB0031,[])
;    x := QCAR x
;    IDENTP x => x
;    not PAIRP x => ncBug('S2CB0031,[])
;    QCAR x

(DEFUN |ncTag| (|x|)
  (PROG ()
    (RETURN
     (COND ((NULL (CONSP |x|)) (|ncBug| 'S2CB0031 NIL))
           (#1='T
            (PROGN
             (SETQ |x| (QCAR |x|))
             (COND ((IDENTP |x|) |x|)
                   ((NULL (CONSP |x|)) (|ncBug| 'S2CB0031 NIL))
                   (#1# (QCAR |x|)))))))))

; ncAlist x ==
;    not PAIRP x => ncBug('S2CB0031,[])
;    x := QCAR x
;    IDENTP x => NIL
;    not PAIRP x => ncBug('S2CB0031,[])
;    QCDR x

(DEFUN |ncAlist| (|x|)
  (PROG ()
    (RETURN
     (COND ((NULL (CONSP |x|)) (|ncBug| 'S2CB0031 NIL))
           (#1='T
            (PROGN
             (SETQ |x| (QCAR |x|))
             (COND ((IDENTP |x|) NIL)
                   ((NULL (CONSP |x|)) (|ncBug| 'S2CB0031 NIL))
                   (#1# (QCDR |x|)))))))))

; ncEltQ(x,k) ==
;    r := ASSQ(k,ncAlist x)
;    NULL r => ncBug ('S2CB0007,[k])
;    rest r

(DEFUN |ncEltQ| (|x| |k|)
  (PROG (|r|)
    (RETURN
     (PROGN
      (SETQ |r| (ASSQ |k| (|ncAlist| |x|)))
      (COND ((NULL |r|) (|ncBug| 'S2CB0007 (LIST |k|))) ('T (CDR |r|)))))))

; ncPutQ(x,k,v) ==
;    LISTP k =>
;       for key in k for val in v repeat ncPutQ(x,key,val)
;       v
;    r := ASSQ(k,ncAlist x)
;    if NULL r then
;       r := CONS( CONS(k,v), ncAlist x)
;       RPLACA(x,CONS(ncTag x,r))
;    else
;       RPLACD(r,v)
;    v

(DEFUN |ncPutQ| (|x| |k| |v|)
  (PROG (|r|)
    (RETURN
     (COND
      ((LISTP |k|)
       (PROGN
        ((LAMBDA (|bfVar#1| |key| |bfVar#2| |val|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#1|) (PROGN (SETQ |key| (CAR |bfVar#1|)) NIL)
                  (ATOM |bfVar#2|) (PROGN (SETQ |val| (CAR |bfVar#2|)) NIL))
              (RETURN NIL))
             (#1='T (|ncPutQ| |x| |key| |val|)))
            (SETQ |bfVar#1| (CDR |bfVar#1|))
            (SETQ |bfVar#2| (CDR |bfVar#2|))))
         |k| NIL |v| NIL)
        |v|))
      (#1#
       (PROGN
        (SETQ |r| (ASSQ |k| (|ncAlist| |x|)))
        (COND
         ((NULL |r|) (SETQ |r| (CONS (CONS |k| |v|) (|ncAlist| |x|)))
          (RPLACA |x| (CONS (|ncTag| |x|) |r|)))
         (#1# (RPLACD |r| |v|)))
        |v|))))))

; tokConstruct(hd,tok,:pos)==
;          a:=cons(hd,tok)
;          IFCAR pos =>
;              pfNoPosition? first pos => a
;              ncPutQ(a, "posn", first pos)
;              a
;          a

(DEFUN |tokConstruct| (|hd| |tok| &REST |pos|)
  (PROG (|a|)
    (RETURN
     (PROGN
      (SETQ |a| (CONS |hd| |tok|))
      (COND
       ((IFCAR |pos|)
        (COND ((|pfNoPosition?| (CAR |pos|)) |a|)
              (#1='T (PROGN (|ncPutQ| |a| '|posn| (CAR |pos|)) |a|))))
       (#1# |a|))))))

; tokType x== ncTag x

(DEFUN |tokType| (|x|) (PROG () (RETURN (|ncTag| |x|))))

; tokPart x == rest x

(DEFUN |tokPart| (|x|) (PROG () (RETURN (CDR |x|))))

; tokPosn x==
;      a:= ASSQ("posn",ncAlist x)
;      if a then rest a else pfNoPosition()

(DEFUN |tokPosn| (|x|)
  (PROG (|a|)
    (RETURN
     (PROGN
      (SETQ |a| (ASSQ '|posn| (|ncAlist| |x|)))
      (COND (|a| (CDR |a|)) ('T (|pfNoPosition|)))))))

; pfAbSynOp form ==
;     hd := first form
;     IFCAR hd or hd

(DEFUN |pfAbSynOp| (|form|)
  (PROG (|hd|)
    (RETURN (PROGN (SETQ |hd| (CAR |form|)) (OR (IFCAR |hd|) |hd|)))))

; pfAbSynOp?(form, op) ==
;     hd := first form
;     EQ(hd, op) or EQCAR(hd, op)

(DEFUN |pfAbSynOp?| (|form| |op|)
  (PROG (|hd|)
    (RETURN
     (PROGN (SETQ |hd| (CAR |form|)) (OR (EQ |hd| |op|) (EQCAR |hd| |op|))))))

; pfLeaf? form ==
;   MEMQ(pfAbSynOp form,
;        '(id idsy symbol string char float expression integer
;           Document error))

(DEFUN |pfLeaf?| (|form|)
  (PROG ()
    (RETURN
     (MEMQ (|pfAbSynOp| |form|)
           '(|id| |idsy| |symbol| |string| |char| |float| |expression|
             |integer| |Document| |error|)))))

; pfLeaf(x,y,:z)      == tokConstruct(x,y, IFCAR z or pfNoPosition())

(DEFUN |pfLeaf| (|x| |y| &REST |z|)
  (PROG () (RETURN (|tokConstruct| |x| |y| (OR (IFCAR |z|) (|pfNoPosition|))))))

; pfLeafToken form    == tokPart form

(DEFUN |pfLeafToken| (|form|) (PROG () (RETURN (|tokPart| |form|))))

; pfLeafPosition form == tokPosn form

(DEFUN |pfLeafPosition| (|form|) (PROG () (RETURN (|tokPosn| |form|))))

; pfTree(x,y)         == CONS(x,y)       -- was ==>

(DEFUN |pfTree| (|x| |y|) (PROG () (RETURN (CONS |x| |y|))))

; pfParts  form       == rest form       -- was ==>

(DEFUN |pfParts| (|form|) (PROG () (RETURN (CDR |form|))))

; pfFirst  form       == CADR form       -- was ==>

(DEFUN |pfFirst| (|form|) (PROG () (RETURN (CADR |form|))))

; pfSecond form       == CADDR form       -- was ==>

(DEFUN |pfSecond| (|form|) (PROG () (RETURN (CADDR |form|))))

; pfListOf x          == pfTree('listOf,x)

(DEFUN |pfListOf| (|x|) (PROG () (RETURN (|pfTree| '|listOf| |x|))))

; pfListOf? x         == pfAbSynOp?(x,'listOf)

(DEFUN |pfListOf?| (|x|) (PROG () (RETURN (|pfAbSynOp?| |x| '|listOf|))))

; pfAppend list       == APPLY(function APPEND,list)

(DEFUN |pfAppend| (LIST) (PROG () (RETURN (APPLY #'APPEND LIST))))

; pfNothing ()        == pfTree('nothing, [])

(DEFUN |pfNothing| () (PROG () (RETURN (|pfTree| '|nothing| NIL))))

; pfNothing? form     == pfAbSynOp?(form, 'nothing)

(DEFUN |pfNothing?| (|form|)
  (PROG () (RETURN (|pfAbSynOp?| |form| '|nothing|))))

; pfSemiColon(pfbody) == pfTree('SemiColon, [pfbody])

(DEFUN |pfSemiColon| (|pfbody|)
  (PROG () (RETURN (|pfTree| '|SemiColon| (LIST |pfbody|)))))

; pfSemiColon?(pf)    == pfAbSynOp? (pf, 'SemiColon)

(DEFUN |pfSemiColon?| (|pf|)
  (PROG () (RETURN (|pfAbSynOp?| |pf| '|SemiColon|))))

; pfSemiColonBody pf   == CADR pf       -- was ==>

(DEFUN |pfSemiColonBody| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfId(expr)               == pfLeaf('id, expr)

(DEFUN |pfId| (|expr|) (PROG () (RETURN (|pfLeaf| '|id| |expr|))))

; pfIdPos(expr,pos)        == pfLeaf('id,expr,pos)

(DEFUN |pfIdPos| (|expr| |pos|)
  (PROG () (RETURN (|pfLeaf| '|id| |expr| |pos|))))

; pfId? form               ==
;         pfAbSynOp?(form,'id) or pfAbSynOp?(form,'idsy)

(DEFUN |pfId?| (|form|)
  (PROG ()
    (RETURN (OR (|pfAbSynOp?| |form| '|id|) (|pfAbSynOp?| |form| '|idsy|)))))

; pfSymbolVariable? form   == pfAbSynOp?(form,'idsy)

(DEFUN |pfSymbolVariable?| (|form|)
  (PROG () (RETURN (|pfAbSynOp?| |form| '|idsy|))))

; pfIdSymbol form          == tokPart form

(DEFUN |pfIdSymbol| (|form|) (PROG () (RETURN (|tokPart| |form|))))

; pfDocument strings       == pfLeaf('Document, strings)

(DEFUN |pfDocument| (|strings|)
  (PROG () (RETURN (|pfLeaf| '|Document| |strings|))))

; pfDocument? form         == pfAbSynOp?(form, 'Document)

(DEFUN |pfDocument?| (|form|)
  (PROG () (RETURN (|pfAbSynOp?| |form| '|Document|))))

; pfDocumentText form      == tokPart form

(DEFUN |pfDocumentText| (|form|) (PROG () (RETURN (|tokPart| |form|))))

; pfLiteral? form ==
;       MEMQ(pfAbSynOp form,'(integer symbol expression
;                     one zero char string float))

(DEFUN |pfLiteral?| (|form|)
  (PROG ()
    (RETURN
     (MEMQ (|pfAbSynOp| |form|)
           '(|integer| |symbol| |expression| |one| |zero| |char| |string|
             |float|)))))

; pfLiteralClass form      == pfAbSynOp form

(DEFUN |pfLiteralClass| (|form|) (PROG () (RETURN (|pfAbSynOp| |form|))))

; pfLiteralString form     == tokPart form

(DEFUN |pfLiteralString| (|form|) (PROG () (RETURN (|tokPart| |form|))))

; pfStringConstString form     == tokPart form

(DEFUN |pfStringConstString| (|form|) (PROG () (RETURN (|tokPart| |form|))))

; pfExpression(expr, :optpos) ==
;                pfLeaf("expression", expr, IFCAR optpos)

(DEFUN |pfExpression| (|expr| &REST |optpos|)
  (PROG () (RETURN (|pfLeaf| '|expression| |expr| (IFCAR |optpos|)))))

; pfExpression? form          == pfAbSynOp?(form, 'expression)

(DEFUN |pfExpression?| (|form|)
  (PROG () (RETURN (|pfAbSynOp?| |form| '|expression|))))

; pfSymbol(expr, :optpos) ==
;                pfLeaf("symbol", expr, IFCAR optpos)

(DEFUN |pfSymbol| (|expr| &REST |optpos|)
  (PROG () (RETURN (|pfLeaf| '|symbol| |expr| (IFCAR |optpos|)))))

; pfSymb(expr, :optpos) ==
;          if pfLeaf? expr
;          then pfSymbol(tokPart expr,IFCAR optpos)
;          else pfExpression(pfSexpr expr,IFCAR optpos)

(DEFUN |pfSymb| (|expr| &REST |optpos|)
  (PROG ()
    (RETURN
     (COND
      ((|pfLeaf?| |expr|) (|pfSymbol| (|tokPart| |expr|) (IFCAR |optpos|)))
      ('T (|pfExpression| (|pfSexpr| |expr|) (IFCAR |optpos|)))))))

; pfSymbol? form          == pfAbSynOp?(form, 'symbol)

(DEFUN |pfSymbol?| (|form|) (PROG () (RETURN (|pfAbSynOp?| |form| '|symbol|))))

; pfSymbolSymbol form     == tokPart form

(DEFUN |pfSymbolSymbol| (|form|) (PROG () (RETURN (|tokPart| |form|))))

; pfWDec(doc,name)   == [pfWDeclare(i,doc) for i in pfParts name]

(DEFUN |pfWDec| (|doc| |name|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#4| |bfVar#3| |i|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#3|) (PROGN (SETQ |i| (CAR |bfVar#3|)) NIL))
           (RETURN (NREVERSE |bfVar#4|)))
          ('T (SETQ |bfVar#4| (CONS (|pfWDeclare| |i| |doc|) |bfVar#4|))))
         (SETQ |bfVar#3| (CDR |bfVar#3|))))
      NIL (|pfParts| |name|) NIL))))

; pfTweakIf form==
;     a:=pfIfElse form
;     b:=if pfNothing? a then pfListOf [] else a
;     pfTree('WIf,[pfIfCond form,pfIfThen form,b])

(DEFUN |pfTweakIf| (|form|)
  (PROG (|a| |b|)
    (RETURN
     (PROGN
      (SETQ |a| (|pfIfElse| |form|))
      (SETQ |b| (COND ((|pfNothing?| |a|) (|pfListOf| NIL)) ('T |a|)))
      (|pfTree| '|WIf| (LIST (|pfIfCond| |form|) (|pfIfThen| |form|) |b|))))))

; pfInfApplication(op,left,right)==
;    EQ(pfIdSymbol op,"and")=> pfAnd (left,right)
;    EQ(pfIdSymbol op, "or")=> pfOr (left,right)
;    pfApplication(op,pfTuple pfListOf [left,right])

(DEFUN |pfInfApplication| (|op| |left| |right|)
  (PROG ()
    (RETURN
     (COND ((EQ (|pfIdSymbol| |op|) '|and|) (|pfAnd| |left| |right|))
           ((EQ (|pfIdSymbol| |op|) '|or|) (|pfOr| |left| |right|))
           ('T
            (|pfApplication| |op|
             (|pfTuple| (|pfListOf| (LIST |left| |right|)))))))))

; pfAnd(pfleft, pfright) == pfTree('And, [pfleft, pfright])

(DEFUN |pfAnd| (|pfleft| |pfright|)
  (PROG () (RETURN (|pfTree| '|And| (LIST |pfleft| |pfright|)))))

; pfAnd?(pf) == pfAbSynOp? (pf, 'And)

(DEFUN |pfAnd?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|And|))))

; pfAndLeft pf == CADR pf       -- was ==>

(DEFUN |pfAndLeft| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfAndRight pf == CADDR pf       -- was ==>

(DEFUN |pfAndRight| (|pf|) (PROG () (RETURN (CADDR |pf|))))

; pfOr(pfleft, pfright) == pfTree('Or, [pfleft, pfright])

(DEFUN |pfOr| (|pfleft| |pfright|)
  (PROG () (RETURN (|pfTree| '|Or| (LIST |pfleft| |pfright|)))))

; pfOr?(pf) == pfAbSynOp? (pf, 'Or)

(DEFUN |pfOr?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|Or|))))

; pfOrLeft pf == CADR pf       -- was ==>

(DEFUN |pfOrLeft| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfOrRight pf == CADDR pf       -- was ==>

(DEFUN |pfOrRight| (|pf|) (PROG () (RETURN (CADDR |pf|))))

; pfNot(arg) == pfTree('Not, [arg])

(DEFUN |pfNot| (|arg|) (PROG () (RETURN (|pfTree| '|Not| (LIST |arg|)))))

; pfNot?(pf) == pfAbSynOp? (pf, 'Not)

(DEFUN |pfNot?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|Not|))))

; pfNotArg pf == CADR pf       -- was ==>

(DEFUN |pfNotArg| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfEnSequence a==
;            if null a
;            then  pfTuple pfListOf a
;            else if null cdr a
;                 then  car a
;                 else  pfSequence pfListOf a

(DEFUN |pfEnSequence| (|a|)
  (PROG ()
    (RETURN
     (COND ((NULL |a|) (|pfTuple| (|pfListOf| |a|)))
           ((NULL (CDR |a|)) (CAR |a|)) ('T (|pfSequence| (|pfListOf| |a|)))))))

; pfFromDom(dom,expr)==
;     if pfApplication? expr
;     then pfApplication(pfFromdom(pfApplicationOp expr,dom),
;                        pfApplicationArg expr)
;     else pfFromdom(expr,dom)

(DEFUN |pfFromDom| (|dom| |expr|)
  (PROG ()
    (RETURN
     (COND
      ((|pfApplication?| |expr|)
       (|pfApplication| (|pfFromdom| (|pfApplicationOp| |expr|) |dom|)
        (|pfApplicationArg| |expr|)))
      ('T (|pfFromdom| |expr| |dom|))))))

; pfReturnTyped(type,body)==pfTree('returntyped,[type,body])

(DEFUN |pfReturnTyped| (|type| |body|)
  (PROG () (RETURN (|pfTree| '|returntyped| (LIST |type| |body|)))))

; pfLam(variable,body)==-- called from parser
;     rets:= if pfAbSynOp?(body,'returntyped)
;            then pfFirst body
;            else pfNothing ()
;     bdy:= if pfAbSynOp?(body,'returntyped) then pfSecond body else body
;     pfLambda(variable,rets,bdy)

(DEFUN |pfLam| (|variable| |body|)
  (PROG (|rets| |bdy|)
    (RETURN
     (PROGN
      (SETQ |rets|
              (COND ((|pfAbSynOp?| |body| '|returntyped|) (|pfFirst| |body|))
                    (#1='T (|pfNothing|))))
      (SETQ |bdy|
              (COND ((|pfAbSynOp?| |body| '|returntyped|) (|pfSecond| |body|))
                    (#1# |body|)))
      (|pfLambda| |variable| |rets| |bdy|)))))

; pfIfThenOnly(pred,first)==pfIf(pred,first,pfNothing())

(DEFUN |pfIfThenOnly| (|pred| CAR)
  (PROG () (RETURN (|pfIf| |pred| CAR (|pfNothing|)))))

; pfLp(iterators,body)==
;        pfLoop pfListOf [:iterators,pfDo body]

(DEFUN |pfLp| (|iterators| |body|)
  (PROG ()
    (RETURN
     (|pfLoop| (|pfListOf| (APPEND |iterators| (CONS (|pfDo| |body|) NIL)))))))

; pfLoop1 body == pfLoop pfListOf [pfDo body]

(DEFUN |pfLoop1| (|body|)
  (PROG () (RETURN (|pfLoop| (|pfListOf| (LIST (|pfDo| |body|)))))))

; pfExitNoCond value== pfExit(pfNothing(),value)

(DEFUN |pfExitNoCond| (|value|)
  (PROG () (RETURN (|pfExit| (|pfNothing|) |value|))))

; pfReturnNoName(value)==pfReturn(value,pfNothing())

(DEFUN |pfReturnNoName| (|value|)
  (PROG () (RETURN (|pfReturn| |value| (|pfNothing|)))))

; pfBrace(a,part)==pfApplication(pfIdPos( "{}",tokPosn a),part)

(DEFUN |pfBrace| (|a| |part|)
  (PROG () (RETURN (|pfApplication| (|pfIdPos| '{} (|tokPosn| |a|)) |part|))))

; pfBracket(a,part) ==  pfApplication(pfIdPos( "[]",tokPosn a),part)

(DEFUN |pfBracket| (|a| |part|)
  (PROG () (RETURN (|pfApplication| (|pfIdPos| '[] (|tokPosn| |a|)) |part|))))

; pfParen(a,part)==part

(DEFUN |pfParen| (|a| |part|) (PROG () (RETURN |part|)))

; pfPile(part)==part

(DEFUN |pfPile| (|part|) (PROG () (RETURN |part|)))

; pfSpread(l,t)==  [pfTyped(i,t) for i in l]

(DEFUN |pfSpread| (|l| |t|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#6| |bfVar#5| |i|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#5|) (PROGN (SETQ |i| (CAR |bfVar#5|)) NIL))
           (RETURN (NREVERSE |bfVar#6|)))
          ('T (SETQ |bfVar#6| (CONS (|pfTyped| |i| |t|) |bfVar#6|))))
         (SETQ |bfVar#5| (CDR |bfVar#5|))))
      NIL |l| NIL))))

; pfTupleList form== pfParts pfTupleParts form

(DEFUN |pfTupleList| (|form|)
  (PROG () (RETURN (|pfParts| (|pfTupleParts| |form|)))))

; pfExpr? pf ==
;      pfAdd? pf or _
;      pfApplication? pf or _
;      pfAssign? pf or _
;      pfCoerceto? pf or _
;      pfCollect? pf or _
;      pfComDefinition? pf or _
;      pfDeclPart? pf or _
;      pfExit? pf or _
;      pfExport? pf or _
;      pfFree? pf or _
;      pfFromdom? pf or _
;      pfId? pf or _
;      pfIf? pf or _
;      pfInline? pf or _
;      pfIterate? pf or _
;      pfLambda? pf or _
;      pfBreak? pf or _
;      pfLiteral? pf or _
;      pfLocal? pf or _
;      pfLoop? pf or _
;      pfMLambda? pf or _
;      pfPretend? pf or _
;      pfRestrict? pf or _
;      pfReturn? pf or _
;      pfTagged? pf or _
;      pfTuple? pf or _
;      pfWhere? pf or _
;      pfWith? pf

(DEFUN |pfExpr?| (|pf|)
  (PROG ()
    (RETURN
     (OR (|pfAdd?| |pf|) (|pfApplication?| |pf|) (|pfAssign?| |pf|)
         (|pfCoerceto?| |pf|) (|pfCollect?| |pf|) (|pfComDefinition?| |pf|)
         (|pfDeclPart?| |pf|) (|pfExit?| |pf|) (|pfExport?| |pf|)
         (|pfFree?| |pf|) (|pfFromdom?| |pf|) (|pfId?| |pf|) (|pfIf?| |pf|)
         (|pfInline?| |pf|) (|pfIterate?| |pf|) (|pfLambda?| |pf|)
         (|pfBreak?| |pf|) (|pfLiteral?| |pf|) (|pfLocal?| |pf|)
         (|pfLoop?| |pf|) (|pfMLambda?| |pf|) (|pfPretend?| |pf|)
         (|pfRestrict?| |pf|) (|pfReturn?| |pf|) (|pfTagged?| |pf|)
         (|pfTuple?| |pf|) (|pfWhere?| |pf|) (|pfWith?| |pf|)))))

; pfDeclPart? pf ==
;      pfTyping? pf or _
;      pfImport? pf or _
;      pfDefinition? pf or _
;      pfSequence? pf or _
;      pfDWhere? pf or _
;      pfMacro? pf

(DEFUN |pfDeclPart?| (|pf|)
  (PROG ()
    (RETURN
     (OR (|pfTyping?| |pf|) (|pfImport?| |pf|) (|pfDefinition?| |pf|)
         (|pfSequence?| |pf|) (|pfDWhere?| |pf|) (|pfMacro?| |pf|)))))

; pfWrong(pfwhy, pfrubble) == pfTree('Wrong, [pfwhy, pfrubble])

(DEFUN |pfWrong| (|pfwhy| |pfrubble|)
  (PROG () (RETURN (|pfTree| '|Wrong| (LIST |pfwhy| |pfrubble|)))))

; pfWrong?(pf) == pfAbSynOp? (pf, 'Wrong)

(DEFUN |pfWrong?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|Wrong|))))

; pfWrongWhy pf == CADR pf       -- was ==>

(DEFUN |pfWrongWhy| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfWrongRubble pf == CADDR pf       -- was ==>

(DEFUN |pfWrongRubble| (|pf|) (PROG () (RETURN (CADDR |pf|))))

; pf0WrongRubble pf == pfParts pfWrongRubble pf

(DEFUN |pf0WrongRubble| (|pf|)
  (PROG () (RETURN (|pfParts| (|pfWrongRubble| |pf|)))))

; pfAdd(pfbase, pfaddin,:addon) ==
;     lhs := if addon
;            then first addon
;            else pfNothing()
;     pfTree('Add, [pfbase, pfaddin,lhs])

(DEFUN |pfAdd| (|pfbase| |pfaddin| &REST |addon|)
  (PROG (|lhs|)
    (RETURN
     (PROGN
      (SETQ |lhs| (COND (|addon| (CAR |addon|)) ('T (|pfNothing|))))
      (|pfTree| '|Add| (LIST |pfbase| |pfaddin| |lhs|))))))

; pfAdd?(pf) == pfAbSynOp? (pf, 'Add)

(DEFUN |pfAdd?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|Add|))))

; pfAddBase pf == CADR pf       -- was ==>

(DEFUN |pfAddBase| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfAddAddin pf == CADDR pf       -- was ==>

(DEFUN |pfAddAddin| (|pf|) (PROG () (RETURN (CADDR |pf|))))

; pfAddAddon pf == CADDDR pf       -- was ==>

(DEFUN |pfAddAddon| (|pf|) (PROG () (RETURN (CADDDR |pf|))))

; pf0AddBase pf == pfParts pfAddBase pf

(DEFUN |pf0AddBase| (|pf|) (PROG () (RETURN (|pfParts| (|pfAddBase| |pf|)))))

; pfDWhere(pfcontext, pfexpr) == pfTree('DWhere, [pfcontext, pfexpr])

(DEFUN |pfDWhere| (|pfcontext| |pfexpr|)
  (PROG () (RETURN (|pfTree| '|DWhere| (LIST |pfcontext| |pfexpr|)))))

; pfDWhere?(pf) == pfAbSynOp? (pf, 'DWhere)

(DEFUN |pfDWhere?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|DWhere|))))

; pfDWhereContext pf == CADR pf       -- was ==>

(DEFUN |pfDWhereContext| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfDWhereExpr pf == CADDR pf       -- was ==>

(DEFUN |pfDWhereExpr| (|pf|) (PROG () (RETURN (CADDR |pf|))))

; pfWith(pfbase, pfwithin,pfwithon) ==
;          pfTree('With, [pfbase, pfwithin,pfwithon])

(DEFUN |pfWith| (|pfbase| |pfwithin| |pfwithon|)
  (PROG () (RETURN (|pfTree| '|With| (LIST |pfbase| |pfwithin| |pfwithon|)))))

; pfWith?(pf) == pfAbSynOp? (pf, 'With)

(DEFUN |pfWith?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|With|))))

; pfWithBase pf == CADR pf       -- was ==>

(DEFUN |pfWithBase| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfWithWithin pf == CADDR pf       -- was ==>

(DEFUN |pfWithWithin| (|pf|) (PROG () (RETURN (CADDR |pf|))))

; pfWithWithon pf == CADDDR pf       -- was ==>

(DEFUN |pfWithWithon| (|pf|) (PROG () (RETURN (CADDDR |pf|))))

; pf0WithBase pf == pfParts pfWithBase pf

(DEFUN |pf0WithBase| (|pf|) (PROG () (RETURN (|pfParts| (|pfWithBase| |pf|)))))

; pf0WithWithin pf == pfParts pfWithWithin pf

(DEFUN |pf0WithWithin| (|pf|)
  (PROG () (RETURN (|pfParts| (|pfWithWithin| |pf|)))))

; pfWIf(pfcond, pfthen, pfelse) == pfTree('WIf, [pfcond, pfthen, pfelse])

(DEFUN |pfWIf| (|pfcond| |pfthen| |pfelse|)
  (PROG () (RETURN (|pfTree| '|WIf| (LIST |pfcond| |pfthen| |pfelse|)))))

; pfWIf?(pf) == pfAbSynOp? (pf, 'WIf)

(DEFUN |pfWIf?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|WIf|))))

; pfWIfCond pf == CADR pf       -- was ==>

(DEFUN |pfWIfCond| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfWIfThen pf == CADDR pf       -- was ==>

(DEFUN |pfWIfThen| (|pf|) (PROG () (RETURN (CADDR |pf|))))

; pfWIfElse pf == CADDDR pf       -- was ==>

(DEFUN |pfWIfElse| (|pf|) (PROG () (RETURN (CADDDR |pf|))))

; pfWDeclare(pfsignature, pfdoc) == pfTree('WDeclare, [pfsignature, _
; pfdoc])

(DEFUN |pfWDeclare| (|pfsignature| |pfdoc|)
  (PROG () (RETURN (|pfTree| '|WDeclare| (LIST |pfsignature| |pfdoc|)))))

; pfWDeclare?(pf) == pfAbSynOp? (pf, 'WDeclare)

(DEFUN |pfWDeclare?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|WDeclare|))))

; pfWDeclareSignature pf == CADR pf       -- was ==>

(DEFUN |pfWDeclareSignature| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfWDeclareDoc pf == CADDR pf       -- was ==>

(DEFUN |pfWDeclareDoc| (|pf|) (PROG () (RETURN (CADDR |pf|))))

; pfAttribute(pfexpr) == pfTree('Attribute, [pfexpr])

(DEFUN |pfAttribute| (|pfexpr|)
  (PROG () (RETURN (|pfTree| '|Attribute| (LIST |pfexpr|)))))

; pfAttribute?(pf) == pfAbSynOp? (pf, 'Attribute)

(DEFUN |pfAttribute?| (|pf|)
  (PROG () (RETURN (|pfAbSynOp?| |pf| '|Attribute|))))

; pfAttributeExpr pf == CADR pf       -- was ==>

(DEFUN |pfAttributeExpr| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfTyped(pfid, pftype) == pfTree('Typed, [pfid, pftype])

(DEFUN |pfTyped| (|pfid| |pftype|)
  (PROG () (RETURN (|pfTree| '|Typed| (LIST |pfid| |pftype|)))))

; pfTyped?(pf) == pfAbSynOp? (pf, 'Typed)

(DEFUN |pfTyped?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|Typed|))))

; pfTypedId pf == CADR pf       -- was ==>

(DEFUN |pfTypedId| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfTypedType pf == CADDR pf       -- was ==>

(DEFUN |pfTypedType| (|pf|) (PROG () (RETURN (CADDR |pf|))))

; pfApplication(pfop, pfarg) ==
;         pfTree('Application, [pfop, pfarg])

(DEFUN |pfApplication| (|pfop| |pfarg|)
  (PROG () (RETURN (|pfTree| '|Application| (LIST |pfop| |pfarg|)))))

; pfApplication?(pf) == pfAbSynOp? (pf, 'Application)

(DEFUN |pfApplication?| (|pf|)
  (PROG () (RETURN (|pfAbSynOp?| |pf| '|Application|))))

; pfApplicationOp pf == CADR pf       -- was ==>

(DEFUN |pfApplicationOp| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfApplicationArg pf == CADDR pf       -- was ==>

(DEFUN |pfApplicationArg| (|pf|) (PROG () (RETURN (CADDR |pf|))))

; pfTupleListOf(pfparts) == pfTuple pfListOf pfparts

(DEFUN |pfTupleListOf| (|pfparts|)
  (PROG () (RETURN (|pfTuple| (|pfListOf| |pfparts|)))))

; pfTuple(pfparts) == pfTree('Tuple, [pfparts])

(DEFUN |pfTuple| (|pfparts|)
  (PROG () (RETURN (|pfTree| '|Tuple| (LIST |pfparts|)))))

; pfTuple?(pf) == pfAbSynOp? (pf, 'Tuple)

(DEFUN |pfTuple?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|Tuple|))))

; pfTupleParts pf == CADR pf       -- was ==>

(DEFUN |pfTupleParts| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pf0TupleParts pf == pfParts pfTupleParts pf

(DEFUN |pf0TupleParts| (|pf|)
  (PROG () (RETURN (|pfParts| (|pfTupleParts| |pf|)))))

; pfTagged(pftag, pfexpr) == pfTree('Tagged, [pftag, pfexpr])

(DEFUN |pfTagged| (|pftag| |pfexpr|)
  (PROG () (RETURN (|pfTree| '|Tagged| (LIST |pftag| |pfexpr|)))))

; pfTagged?(pf) == pfAbSynOp? (pf, 'Tagged)

(DEFUN |pfTagged?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|Tagged|))))

; pfTaggedTag pf == CADR pf       -- was ==>

(DEFUN |pfTaggedTag| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfTaggedExpr pf == CADDR pf       -- was ==>

(DEFUN |pfTaggedExpr| (|pf|) (PROG () (RETURN (CADDR |pf|))))

; pfPretend(pfexpr, pftype) == pfTree('Pretend, [pfexpr, pftype])

(DEFUN |pfPretend| (|pfexpr| |pftype|)
  (PROG () (RETURN (|pfTree| '|Pretend| (LIST |pfexpr| |pftype|)))))

; pfPretend?(pf) == pfAbSynOp? (pf, 'Pretend)

(DEFUN |pfPretend?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|Pretend|))))

; pfPretendExpr pf == CADR pf       -- was ==>

(DEFUN |pfPretendExpr| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfPretendType pf == CADDR pf       -- was ==>

(DEFUN |pfPretendType| (|pf|) (PROG () (RETURN (CADDR |pf|))))

; pfRestrict(pfexpr, pftype) == pfTree('Restrict, [pfexpr, pftype])

(DEFUN |pfRestrict| (|pfexpr| |pftype|)
  (PROG () (RETURN (|pfTree| '|Restrict| (LIST |pfexpr| |pftype|)))))

; pfRestrict?(pf) == pfAbSynOp? (pf, 'Restrict)

(DEFUN |pfRestrict?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|Restrict|))))

; pfRestrictExpr pf == CADR pf       -- was ==>

(DEFUN |pfRestrictExpr| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfRestrictType pf == CADDR pf       -- was ==>

(DEFUN |pfRestrictType| (|pf|) (PROG () (RETURN (CADDR |pf|))))

; pfCoerceto(pfexpr, pftype) == pfTree('Coerceto, [pfexpr, pftype])

(DEFUN |pfCoerceto| (|pfexpr| |pftype|)
  (PROG () (RETURN (|pfTree| '|Coerceto| (LIST |pfexpr| |pftype|)))))

; pfCoerceto?(pf) == pfAbSynOp? (pf, 'Coerceto)

(DEFUN |pfCoerceto?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|Coerceto|))))

; pfCoercetoExpr pf == CADR pf       -- was ==>

(DEFUN |pfCoercetoExpr| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfCoercetoType pf == CADDR pf       -- was ==>

(DEFUN |pfCoercetoType| (|pf|) (PROG () (RETURN (CADDR |pf|))))

; pfFromdom(pfwhat, pfdomain) == pfTree('Fromdom, [pfwhat, pfdomain])

(DEFUN |pfFromdom| (|pfwhat| |pfdomain|)
  (PROG () (RETURN (|pfTree| '|Fromdom| (LIST |pfwhat| |pfdomain|)))))

; pfFromdom?(pf) == pfAbSynOp? (pf, 'Fromdom)

(DEFUN |pfFromdom?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|Fromdom|))))

; pfFromdomWhat pf == CADR pf       -- was ==>

(DEFUN |pfFromdomWhat| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfFromdomDomain pf == CADDR pf       -- was ==>

(DEFUN |pfFromdomDomain| (|pf|) (PROG () (RETURN (CADDR |pf|))))

; pfLambda(pfargs, pfrets, pfbody) == pfTree('Lambda, [pfargs, pfrets, _
; pfbody])

(DEFUN |pfLambda| (|pfargs| |pfrets| |pfbody|)
  (PROG () (RETURN (|pfTree| '|Lambda| (LIST |pfargs| |pfrets| |pfbody|)))))

; pfLambda?(pf) == pfAbSynOp? (pf, 'Lambda)

(DEFUN |pfLambda?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|Lambda|))))

; pfLambdaArgs pf == CADR pf       -- was ==>

(DEFUN |pfLambdaArgs| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfLambdaRets pf == CADDR pf       -- was ==>

(DEFUN |pfLambdaRets| (|pf|) (PROG () (RETURN (CADDR |pf|))))

; pfLambdaBody pf == CADDDR pf       -- was ==>

(DEFUN |pfLambdaBody| (|pf|) (PROG () (RETURN (CADDDR |pf|))))

; pf0LambdaArgs pf == pfParts pfLambdaArgs pf

(DEFUN |pf0LambdaArgs| (|pf|)
  (PROG () (RETURN (|pfParts| (|pfLambdaArgs| |pf|)))))

; pfFix pf== pfApplication(pfId "Y",pf)

(DEFUN |pfFix| (|pf|) (PROG () (RETURN (|pfApplication| (|pfId| 'Y) |pf|))))

; pfMLambda(pfargs, pfbody) == pfTree('MLambda, [pfargs, pfbody])

(DEFUN |pfMLambda| (|pfargs| |pfbody|)
  (PROG () (RETURN (|pfTree| '|MLambda| (LIST |pfargs| |pfbody|)))))

; pfMLambda?(pf) == pfAbSynOp? (pf, 'MLambda)

(DEFUN |pfMLambda?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|MLambda|))))

; pfMLambdaArgs pf == CADR pf       -- was ==>

(DEFUN |pfMLambdaArgs| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfMLambdaBody pf == CADDR pf       -- was ==>

(DEFUN |pfMLambdaBody| (|pf|) (PROG () (RETURN (CADDR |pf|))))

; pf0MLambdaArgs pf == pfParts pfMLambdaArgs pf

(DEFUN |pf0MLambdaArgs| (|pf|)
  (PROG () (RETURN (|pfParts| (|pfMLambdaArgs| |pf|)))))

; pfWhere(pfcontext, pfexpr) == pfTree('Where, [pfcontext, pfexpr])

(DEFUN |pfWhere| (|pfcontext| |pfexpr|)
  (PROG () (RETURN (|pfTree| '|Where| (LIST |pfcontext| |pfexpr|)))))

; pfWhere?(pf) == pfAbSynOp? (pf, 'Where)

(DEFUN |pfWhere?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|Where|))))

; pfWhereContext pf == CADR pf       -- was ==>

(DEFUN |pfWhereContext| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfWhereExpr pf == CADDR pf       -- was ==>

(DEFUN |pfWhereExpr| (|pf|) (PROG () (RETURN (CADDR |pf|))))

; pf0WhereContext pf == pfParts pfWhereContext pf

(DEFUN |pf0WhereContext| (|pf|)
  (PROG () (RETURN (|pfParts| (|pfWhereContext| |pf|)))))

; pfIf(pfcond, pfthen, pfelse) == pfTree('If, [pfcond, pfthen, pfelse])

(DEFUN |pfIf| (|pfcond| |pfthen| |pfelse|)
  (PROG () (RETURN (|pfTree| '|If| (LIST |pfcond| |pfthen| |pfelse|)))))

; pfIf?(pf) == pfAbSynOp? (pf, 'If)

(DEFUN |pfIf?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|If|))))

; pfIfCond pf == CADR pf       -- was ==>

(DEFUN |pfIfCond| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfIfThen pf == CADDR pf       -- was ==>

(DEFUN |pfIfThen| (|pf|) (PROG () (RETURN (CADDR |pf|))))

; pfIfElse pf == CADDDR pf       -- was ==>

(DEFUN |pfIfElse| (|pf|) (PROG () (RETURN (CADDDR |pf|))))

; pfSequence(pfargs) == pfTree('Sequence, [pfargs])

(DEFUN |pfSequence| (|pfargs|)
  (PROG () (RETURN (|pfTree| '|Sequence| (LIST |pfargs|)))))

; pfSequence?(pf) == pfAbSynOp? (pf, 'Sequence)

(DEFUN |pfSequence?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|Sequence|))))

; pfSequenceArgs pf == CADR pf       -- was ==>

(DEFUN |pfSequenceArgs| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pf0SequenceArgs pf == pfParts pfSequenceArgs pf

(DEFUN |pf0SequenceArgs| (|pf|)
  (PROG () (RETURN (|pfParts| (|pfSequenceArgs| |pf|)))))

; pfNovalue(pfexpr) == pfTree('Novalue, [pfexpr])

(DEFUN |pfNovalue| (|pfexpr|)
  (PROG () (RETURN (|pfTree| '|Novalue| (LIST |pfexpr|)))))

; pfNovalue?(pf) == pfAbSynOp? (pf, 'Novalue)

(DEFUN |pfNovalue?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|Novalue|))))

; pfNovalueExpr pf == CADR pf       -- was ==>

(DEFUN |pfNovalueExpr| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfLoop(pfiterators) == pfTree('Loop, [pfiterators])

(DEFUN |pfLoop| (|pfiterators|)
  (PROG () (RETURN (|pfTree| '|Loop| (LIST |pfiterators|)))))

; pfLoop?(pf) == pfAbSynOp? (pf, 'Loop)

(DEFUN |pfLoop?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|Loop|))))

; pfLoopIterators pf == CADR pf       -- was ==>

(DEFUN |pfLoopIterators| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pf0LoopIterators pf == pfParts pfLoopIterators pf

(DEFUN |pf0LoopIterators| (|pf|)
  (PROG () (RETURN (|pfParts| (|pfLoopIterators| |pf|)))))

; pfCollect(pfbody, pfiterators) == pfTree('Collect, [pfbody, _
; pfiterators])

(DEFUN |pfCollect| (|pfbody| |pfiterators|)
  (PROG () (RETURN (|pfTree| '|Collect| (LIST |pfbody| |pfiterators|)))))

; pfCollect?(pf) == pfAbSynOp? (pf, 'Collect)

(DEFUN |pfCollect?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|Collect|))))

; pfCollectBody pf == CADR pf       -- was ==>

(DEFUN |pfCollectBody| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfCollectIterators pf == CADDR pf       -- was ==>

(DEFUN |pfCollectIterators| (|pf|) (PROG () (RETURN (CADDR |pf|))))

; pf0CollectIterators pf == pfParts pfCollectIterators pf

(DEFUN |pf0CollectIterators| (|pf|)
  (PROG () (RETURN (|pfParts| (|pfCollectIterators| |pf|)))))

; pfForin(pflhs, pfwhole) == pfTree('Forin, [pflhs, pfwhole])

(DEFUN |pfForin| (|pflhs| |pfwhole|)
  (PROG () (RETURN (|pfTree| '|Forin| (LIST |pflhs| |pfwhole|)))))

; pfForin?(pf) == pfAbSynOp? (pf, 'Forin)

(DEFUN |pfForin?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|Forin|))))

; pfForinLhs pf == CADR pf       -- was ==>

(DEFUN |pfForinLhs| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfForinWhole pf == CADDR pf       -- was ==>

(DEFUN |pfForinWhole| (|pf|) (PROG () (RETURN (CADDR |pf|))))

; pf0ForinLhs pf == pfParts pfForinLhs pf

(DEFUN |pf0ForinLhs| (|pf|) (PROG () (RETURN (|pfParts| (|pfForinLhs| |pf|)))))

; pfWhile(pfcond) == pfTree('While, [pfcond])

(DEFUN |pfWhile| (|pfcond|)
  (PROG () (RETURN (|pfTree| '|While| (LIST |pfcond|)))))

; pfWhile?(pf) == pfAbSynOp? (pf, 'While)

(DEFUN |pfWhile?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|While|))))

; pfWhileCond pf == CADR pf       -- was ==>

(DEFUN |pfWhileCond| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfSuchthat(pfcond) == pfTree('Suchthat, [pfcond])

(DEFUN |pfSuchthat| (|pfcond|)
  (PROG () (RETURN (|pfTree| '|Suchthat| (LIST |pfcond|)))))

; pfSuchthat?(pf) == pfAbSynOp? (pf, 'Suchthat)

(DEFUN |pfSuchthat?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|Suchthat|))))

; pfSuchthatCond pf == CADR pf       -- was ==>

(DEFUN |pfSuchthatCond| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfDo(pfbody) == pfTree('Do, [pfbody])

(DEFUN |pfDo| (|pfbody|) (PROG () (RETURN (|pfTree| '|Do| (LIST |pfbody|)))))

; pfDo?(pf) == pfAbSynOp? (pf, 'Do)

(DEFUN |pfDo?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|Do|))))

; pfDoBody pf == CADR pf       -- was ==>

(DEFUN |pfDoBody| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfIterate(pffrom) == pfTree('Iterate, [pffrom])

(DEFUN |pfIterate| (|pffrom|)
  (PROG () (RETURN (|pfTree| '|Iterate| (LIST |pffrom|)))))

; pfIterate?(pf) == pfAbSynOp? (pf, 'Iterate)

(DEFUN |pfIterate?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|Iterate|))))

; pfIterateFrom pf == CADR pf       -- was ==>

(DEFUN |pfIterateFrom| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfBreak(pffrom) == pfTree('Break, [pffrom])

(DEFUN |pfBreak| (|pffrom|)
  (PROG () (RETURN (|pfTree| '|Break| (LIST |pffrom|)))))

; pfBreak?(pf) == pfAbSynOp? (pf, 'Break)

(DEFUN |pfBreak?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|Break|))))

; pfBreakFrom pf == CADR pf       -- was ==>

(DEFUN |pfBreakFrom| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfReturn(pfexpr, pffrom) == pfTree('Return, [pfexpr, pffrom])

(DEFUN |pfReturn| (|pfexpr| |pffrom|)
  (PROG () (RETURN (|pfTree| '|Return| (LIST |pfexpr| |pffrom|)))))

; pfReturn?(pf) == pfAbSynOp? (pf, 'Return)

(DEFUN |pfReturn?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|Return|))))

; pfReturnExpr pf == CADR pf       -- was ==>

(DEFUN |pfReturnExpr| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfReturnFrom pf == CADDR pf       -- was ==>

(DEFUN |pfReturnFrom| (|pf|) (PROG () (RETURN (CADDR |pf|))))

; pfExit(pfcond, pfexpr) == pfTree('Exit, [pfcond, pfexpr])

(DEFUN |pfExit| (|pfcond| |pfexpr|)
  (PROG () (RETURN (|pfTree| '|Exit| (LIST |pfcond| |pfexpr|)))))

; pfExit?(pf) == pfAbSynOp? (pf, 'Exit)

(DEFUN |pfExit?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|Exit|))))

; pfExitCond pf == CADR pf       -- was ==>

(DEFUN |pfExitCond| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfExitExpr pf == CADDR pf       -- was ==>

(DEFUN |pfExitExpr| (|pf|) (PROG () (RETURN (CADDR |pf|))))

; pfMacro(pflhs, pfrhs) == pfTree('Macro, [pflhs, pfrhs])

(DEFUN |pfMacro| (|pflhs| |pfrhs|)
  (PROG () (RETURN (|pfTree| '|Macro| (LIST |pflhs| |pfrhs|)))))

; pfMacro?(pf) == pfAbSynOp? (pf, 'Macro)

(DEFUN |pfMacro?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|Macro|))))

; pfMacroLhs pf == CADR pf       -- was ==>

(DEFUN |pfMacroLhs| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfMacroRhs pf == CADDR pf       -- was ==>

(DEFUN |pfMacroRhs| (|pf|) (PROG () (RETURN (CADDR |pf|))))

; pfDefinition(pflhsitems, pfrhs) == pfTree('Definition, [pflhsitems, pfrhs])

(DEFUN |pfDefinition| (|pflhsitems| |pfrhs|)
  (PROG () (RETURN (|pfTree| '|Definition| (LIST |pflhsitems| |pfrhs|)))))

; pfDefinition?(pf) == pfAbSynOp? (pf, 'Definition)

(DEFUN |pfDefinition?| (|pf|)
  (PROG () (RETURN (|pfAbSynOp?| |pf| '|Definition|))))

; pfDefinitionLhsItems pf == CADR pf       -- was ==>

(DEFUN |pfDefinitionLhsItems| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfDefinitionRhs pf == CADDR pf       -- was ==>

(DEFUN |pfDefinitionRhs| (|pf|) (PROG () (RETURN (CADDR |pf|))))

; pf0DefinitionLhsItems pf == pfParts pfDefinitionLhsItems pf

(DEFUN |pf0DefinitionLhsItems| (|pf|)
  (PROG () (RETURN (|pfParts| (|pfDefinitionLhsItems| |pf|)))))

; pfRule(pflhsitems, pfrhs) == pfTree('Rule, [pflhsitems, _
; pfrhs])

(DEFUN |pfRule| (|pflhsitems| |pfrhs|)
  (PROG () (RETURN (|pfTree| '|Rule| (LIST |pflhsitems| |pfrhs|)))))

; pfRule?(pf) == pfAbSynOp? (pf, 'Rule)

(DEFUN |pfRule?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|Rule|))))

; pfRuleLhsItems pf == CADR pf       -- was ==>

(DEFUN |pfRuleLhsItems| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfRuleRhs pf == CADDR pf       -- was ==>

(DEFUN |pfRuleRhs| (|pf|) (PROG () (RETURN (CADDR |pf|))))

; pfComDefinition(pfdoc, pfdef) == pfTree('ComDefinition, [pfdoc, pfdef] )

(DEFUN |pfComDefinition| (|pfdoc| |pfdef|)
  (PROG () (RETURN (|pfTree| '|ComDefinition| (LIST |pfdoc| |pfdef|)))))

; pfComDefinition?(pf) == pfAbSynOp? (pf, 'ComDefinition)

(DEFUN |pfComDefinition?| (|pf|)
  (PROG () (RETURN (|pfAbSynOp?| |pf| '|ComDefinition|))))

; pfComDefinitionDoc pf == CADR pf       -- was ==>

(DEFUN |pfComDefinitionDoc| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfComDefinitionDef pf == CADDR pf       -- was ==>

(DEFUN |pfComDefinitionDef| (|pf|) (PROG () (RETURN (CADDR |pf|))))

; pfDefinitionSequenceArgs pf == CADR pf       -- was ==>

(DEFUN |pfDefinitionSequenceArgs| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfExportDef pf == CADR pf       -- was ==>

(DEFUN |pfExportDef| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfAssign(pflhsitems, pfrhs) == pfTree('Assign, [pflhsitems, pfrhs])

(DEFUN |pfAssign| (|pflhsitems| |pfrhs|)
  (PROG () (RETURN (|pfTree| '|Assign| (LIST |pflhsitems| |pfrhs|)))))

; pfAssign?(pf) == pfAbSynOp? (pf, 'Assign)

(DEFUN |pfAssign?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|Assign|))))

; pfAssignLhsItems pf == CADR pf       -- was ==>

(DEFUN |pfAssignLhsItems| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfAssignRhs pf == CADDR pf       -- was ==>

(DEFUN |pfAssignRhs| (|pf|) (PROG () (RETURN (CADDR |pf|))))

; pf0AssignLhsItems pf == pfParts pfAssignLhsItems pf

(DEFUN |pf0AssignLhsItems| (|pf|)
  (PROG () (RETURN (|pfParts| (|pfAssignLhsItems| |pf|)))))

; pfTyping(pfitems) == pfTree('Typing, [pfitems])

(DEFUN |pfTyping| (|pfitems|)
  (PROG () (RETURN (|pfTree| '|Typing| (LIST |pfitems|)))))

; pfTyping?(pf) == pfAbSynOp? (pf, 'Typing)

(DEFUN |pfTyping?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|Typing|))))

; pfTypingItems pf == CADR pf       -- was ==>

(DEFUN |pfTypingItems| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pf0TypingItems pf == pfParts pfTypingItems pf

(DEFUN |pf0TypingItems| (|pf|)
  (PROG () (RETURN (|pfParts| (|pfTypingItems| |pf|)))))

; pfExport(pfitems) == pfTree('Export, [pfitems])

(DEFUN |pfExport| (|pfitems|)
  (PROG () (RETURN (|pfTree| '|Export| (LIST |pfitems|)))))

; pfExport?(pf) == pfAbSynOp? (pf, 'Export)

(DEFUN |pfExport?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|Export|))))

; pfExportItems pf == CADR pf       -- was ==>

(DEFUN |pfExportItems| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pf0ExportItems pf == pfParts pfExportItems pf

(DEFUN |pf0ExportItems| (|pf|)
  (PROG () (RETURN (|pfParts| (|pfExportItems| |pf|)))))

; pfLocal(pfitems) == pfTree('Local, [pfitems])

(DEFUN |pfLocal| (|pfitems|)
  (PROG () (RETURN (|pfTree| '|Local| (LIST |pfitems|)))))

; pfLocal?(pf) == pfAbSynOp? (pf, 'Local)

(DEFUN |pfLocal?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|Local|))))

; pfLocalItems pf == CADR pf       -- was ==>

(DEFUN |pfLocalItems| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pf0LocalItems pf == pfParts pfLocalItems pf

(DEFUN |pf0LocalItems| (|pf|)
  (PROG () (RETURN (|pfParts| (|pfLocalItems| |pf|)))))

; pfFree(pfitems) == pfTree('Free, [pfitems])

(DEFUN |pfFree| (|pfitems|)
  (PROG () (RETURN (|pfTree| '|Free| (LIST |pfitems|)))))

; pfFree?(pf) == pfAbSynOp? (pf, 'Free)

(DEFUN |pfFree?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|Free|))))

; pfFreeItems pf == CADR pf       -- was ==>

(DEFUN |pfFreeItems| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pf0FreeItems pf == pfParts pfFreeItems pf

(DEFUN |pf0FreeItems| (|pf|)
  (PROG () (RETURN (|pfParts| (|pfFreeItems| |pf|)))))

; pfImport(pfitems) == pfTree('Import, [pfitems])

(DEFUN |pfImport| (|pfitems|)
  (PROG () (RETURN (|pfTree| '|Import| (LIST |pfitems|)))))

; pfImport?(pf) == pfAbSynOp? (pf, 'Import)

(DEFUN |pfImport?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|Import|))))

; pfImportItems pf == CADR pf       -- was ==>

(DEFUN |pfImportItems| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pf0ImportItems pf == pfParts pfImportItems pf

(DEFUN |pf0ImportItems| (|pf|)
  (PROG () (RETURN (|pfParts| (|pfImportItems| |pf|)))))

; pfInline(pfitems) == pfTree('Inline, [pfitems])

(DEFUN |pfInline| (|pfitems|)
  (PROG () (RETURN (|pfTree| '|Inline| (LIST |pfitems|)))))

; pfInline?(pf) == pfAbSynOp? (pf, 'Inline)

(DEFUN |pfInline?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|Inline|))))

; pfInlineItems pf == CADR pf       -- was ==>

(DEFUN |pfInlineItems| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfQualType(pftype, pfqual) == pfTree('QualType, [pftype, pfqual])

(DEFUN |pfQualType| (|pftype| |pfqual|)
  (PROG () (RETURN (|pfTree| '|QualType| (LIST |pftype| |pfqual|)))))

; pfQualType?(pf) == pfAbSynOp? (pf, 'QualType)

(DEFUN |pfQualType?| (|pf|) (PROG () (RETURN (|pfAbSynOp?| |pf| '|QualType|))))

; pfQualTypeType pf == CADR pf       -- was ==>

(DEFUN |pfQualTypeType| (|pf|) (PROG () (RETURN (CADR |pf|))))

; pfQualTypeQual pf == CADDR pf       -- was ==>

(DEFUN |pfQualTypeQual| (|pf|) (PROG () (RETURN (CADDR |pf|))))

; pfSuch(x,y)== pfInfApplication(pfId "|",x,y)

(DEFUN |pfSuch| (|x| |y|)
  (PROG () (RETURN (|pfInfApplication| (|pfId| '|\||) |x| |y|))))

; pfTaggedToTyped x==
;   rt:=if pfTagged? x then pfTaggedExpr x else pfNothing()
;   form:= if pfTagged? x then pfTaggedTag x else x
;   not pfId? form =>
;       a:=pfId GENSYM()
;       pfTyped(pfSuch(a,
;            pfInfApplication (pfId "=", a,form)),rt)
;   pfTyped(form,rt)

(DEFUN |pfTaggedToTyped| (|x|)
  (PROG (|rt| |form| |a|)
    (RETURN
     (PROGN
      (SETQ |rt|
              (COND ((|pfTagged?| |x|) (|pfTaggedExpr| |x|))
                    (#1='T (|pfNothing|))))
      (SETQ |form| (COND ((|pfTagged?| |x|) (|pfTaggedTag| |x|)) (#1# |x|)))
      (COND
       ((NULL (|pfId?| |form|))
        (PROGN
         (SETQ |a| (|pfId| (GENSYM)))
         (|pfTyped| (|pfSuch| |a| (|pfInfApplication| (|pfId| '=) |a| |form|))
          |rt|)))
       (#1# (|pfTyped| |form| |rt|)))))))

; pfTaggedToTyped1 x==
;     pfCollect1? x => pfCollectVariable1 x
;     pfDefinition? x => pfTyped(x,pfNothing())
;     pfTaggedToTyped x

(DEFUN |pfTaggedToTyped1| (|x|)
  (PROG ()
    (RETURN
     (COND ((|pfCollect1?| |x|) (|pfCollectVariable1| |x|))
           ((|pfDefinition?| |x|) (|pfTyped| |x| (|pfNothing|)))
           ('T (|pfTaggedToTyped| |x|))))))

; pfCollectVariable1 x==
;       a := pfApplicationArg x
;       var:=first pf0TupleParts a
;       id:=pfTaggedToTyped var
;       pfTyped(pfSuch(pfTypedId id,CADR pf0TupleParts a),
;               pfTypedType id)

(DEFUN |pfCollectVariable1| (|x|)
  (PROG (|a| |var| |id|)
    (RETURN
     (PROGN
      (SETQ |a| (|pfApplicationArg| |x|))
      (SETQ |var| (CAR (|pf0TupleParts| |a|)))
      (SETQ |id| (|pfTaggedToTyped| |var|))
      (|pfTyped| (|pfSuch| (|pfTypedId| |id|) (CADR (|pf0TupleParts| |a|)))
       (|pfTypedType| |id|))))))

; pfPushBody(t,args,body)==
;         if null args
;         then  body
;         else if null rest args
;               then  pfLambda(first args,t,body)
;               else
;                  pfLambda(first args,pfNothing(),
;                      pfPushBody(t,rest args,body))

(DEFUN |pfPushBody| (|t| |args| |body|)
  (PROG ()
    (RETURN
     (COND ((NULL |args|) |body|)
           ((NULL (CDR |args|)) (|pfLambda| (CAR |args|) |t| |body|))
           ('T
            (|pfLambda| (CAR |args|) (|pfNothing|)
             (|pfPushBody| |t| (CDR |args|) |body|)))))))

; pfCheckItOut x ==
;   rt:=if pfTagged? x then pfTaggedExpr x else pfNothing()
;   form:= if pfTagged? x then pfTaggedTag x else x
;   pfId? form => [pfListOf [pfTyped(form,rt)],nil,rt]
;   pfCollect1? form =>
;                 [pfListOf [pfCollectVariable1 form],nil,rt]
;   pfTuple? form =>
;        [pfListOf [pfTaggedToTyped i for i in pf0TupleParts form],nil,rt]
;   pfDefinition? form =>
;        [pfListOf [pfTyped(form,pfNothing())],nil,rt]
;   pfApplication? form =>
;           ls:=pfFlattenApp form
;           op:= pfTaggedToTyped1 first ls
;           args:=[pfTransformArg i for i in rest ls]
;           [pfListOf [op],args,rt]
;   npTrapForm form

(DEFUN |pfCheckItOut| (|x|)
  (PROG (|rt| |form| |ls| |op| |args|)
    (RETURN
     (PROGN
      (SETQ |rt|
              (COND ((|pfTagged?| |x|) (|pfTaggedExpr| |x|))
                    (#1='T (|pfNothing|))))
      (SETQ |form| (COND ((|pfTagged?| |x|) (|pfTaggedTag| |x|)) (#1# |x|)))
      (COND
       ((|pfId?| |form|)
        (LIST (|pfListOf| (LIST (|pfTyped| |form| |rt|))) NIL |rt|))
       ((|pfCollect1?| |form|)
        (LIST (|pfListOf| (LIST (|pfCollectVariable1| |form|))) NIL |rt|))
       ((|pfTuple?| |form|)
        (LIST
         (|pfListOf|
          ((LAMBDA (|bfVar#8| |bfVar#7| |i|)
             (LOOP
              (COND
               ((OR (ATOM |bfVar#7|) (PROGN (SETQ |i| (CAR |bfVar#7|)) NIL))
                (RETURN (NREVERSE |bfVar#8|)))
               (#1# (SETQ |bfVar#8| (CONS (|pfTaggedToTyped| |i|) |bfVar#8|))))
              (SETQ |bfVar#7| (CDR |bfVar#7|))))
           NIL (|pf0TupleParts| |form|) NIL))
         NIL |rt|))
       ((|pfDefinition?| |form|)
        (LIST (|pfListOf| (LIST (|pfTyped| |form| (|pfNothing|)))) NIL |rt|))
       ((|pfApplication?| |form|)
        (PROGN
         (SETQ |ls| (|pfFlattenApp| |form|))
         (SETQ |op| (|pfTaggedToTyped1| (CAR |ls|)))
         (SETQ |args|
                 ((LAMBDA (|bfVar#10| |bfVar#9| |i|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#9|)
                           (PROGN (SETQ |i| (CAR |bfVar#9|)) NIL))
                       (RETURN (NREVERSE |bfVar#10|)))
                      (#1#
                       (SETQ |bfVar#10|
                               (CONS (|pfTransformArg| |i|) |bfVar#10|))))
                     (SETQ |bfVar#9| (CDR |bfVar#9|))))
                  NIL (CDR |ls|) NIL))
         (LIST (|pfListOf| (LIST |op|)) |args| |rt|)))
       (#1# (|npTrapForm| |form|)))))))

; pfCollect1? x==
;         pfApplication? x =>
;               a:=pfApplicationOp x
;               pfId? a => pfIdSymbol a = "|"
;               false
;         false

(DEFUN |pfCollect1?| (|x|)
  (PROG (|a|)
    (RETURN
     (COND
      ((|pfApplication?| |x|)
       (PROGN
        (SETQ |a| (|pfApplicationOp| |x|))
        (COND ((|pfId?| |a|) (EQ (|pfIdSymbol| |a|) '|\||)) (#1='T NIL))))
      (#1# NIL)))))

; pfTransformArg  args==
;           argl:= if pfTuple? args then pf0TupleParts args else [args]
;           pfListOf [pfTaggedToTyped1 i for i in argl]

(DEFUN |pfTransformArg| (|args|)
  (PROG (|argl|)
    (RETURN
     (PROGN
      (SETQ |argl|
              (COND ((|pfTuple?| |args|) (|pf0TupleParts| |args|))
                    (#1='T (LIST |args|))))
      (|pfListOf|
       ((LAMBDA (|bfVar#12| |bfVar#11| |i|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#11|) (PROGN (SETQ |i| (CAR |bfVar#11|)) NIL))
             (RETURN (NREVERSE |bfVar#12|)))
            (#1# (SETQ |bfVar#12| (CONS (|pfTaggedToTyped1| |i|) |bfVar#12|))))
           (SETQ |bfVar#11| (CDR |bfVar#11|))))
        NIL |argl| NIL))))))

; pfCheckMacroOut form ==
;   pfId? form => [form,nil]
;   pfApplication? form =>
;           ls:=pfFlattenApp form
;           op:= pfCheckId first ls
;           args:=[pfCheckArg i for i in rest ls]
;           [op,args]
;   npTrapForm form

(DEFUN |pfCheckMacroOut| (|form|)
  (PROG (|ls| |op| |args|)
    (RETURN
     (COND ((|pfId?| |form|) (LIST |form| NIL))
           ((|pfApplication?| |form|)
            (PROGN
             (SETQ |ls| (|pfFlattenApp| |form|))
             (SETQ |op| (|pfCheckId| (CAR |ls|)))
             (SETQ |args|
                     ((LAMBDA (|bfVar#14| |bfVar#13| |i|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#13|)
                               (PROGN (SETQ |i| (CAR |bfVar#13|)) NIL))
                           (RETURN (NREVERSE |bfVar#14|)))
                          (#1='T
                           (SETQ |bfVar#14|
                                   (CONS (|pfCheckArg| |i|) |bfVar#14|))))
                         (SETQ |bfVar#13| (CDR |bfVar#13|))))
                      NIL (CDR |ls|) NIL))
             (LIST |op| |args|)))
           (#1# (|npTrapForm| |form|))))))

; pfCheckArg args==
;           argl:= if pfTuple? args then pf0TupleParts args else [args]
;           pfListOf [pfCheckId i for i in argl]

(DEFUN |pfCheckArg| (|args|)
  (PROG (|argl|)
    (RETURN
     (PROGN
      (SETQ |argl|
              (COND ((|pfTuple?| |args|) (|pf0TupleParts| |args|))
                    (#1='T (LIST |args|))))
      (|pfListOf|
       ((LAMBDA (|bfVar#16| |bfVar#15| |i|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#15|) (PROGN (SETQ |i| (CAR |bfVar#15|)) NIL))
             (RETURN (NREVERSE |bfVar#16|)))
            (#1# (SETQ |bfVar#16| (CONS (|pfCheckId| |i|) |bfVar#16|))))
           (SETQ |bfVar#15| (CDR |bfVar#15|))))
        NIL |argl| NIL))))))

; pfCheckId form==   if not pfId? form then npTrapForm(form) else form

(DEFUN |pfCheckId| (|form|)
  (PROG ()
    (RETURN
     (COND ((NULL (|pfId?| |form|)) (|npTrapForm| |form|)) ('T |form|)))))

; pfPushMacroBody(args,body)==
;     null args =>   body
;     pfMLambda(first args,pfPushMacroBody(rest args,body))

(DEFUN |pfPushMacroBody| (|args| |body|)
  (PROG ()
    (RETURN
     (COND ((NULL |args|) |body|)
           ('T
            (|pfMLambda| (CAR |args|)
             (|pfPushMacroBody| (CDR |args|) |body|)))))))

; pfFlattenApp x==
;    pfApplication? x=>
;              pfCollect1? x =>[ x ]
;              append (pfFlattenApp pfApplicationOp x,
;                         pfFlattenApp pfApplicationArg x)
;    [x]

(DEFUN |pfFlattenApp| (|x|)
  (PROG ()
    (RETURN
     (COND
      ((|pfApplication?| |x|)
       (COND ((|pfCollect1?| |x|) (LIST |x|))
             (#1='T
              (APPEND (|pfFlattenApp| (|pfApplicationOp| |x|))
                      (|pfFlattenApp| (|pfApplicationArg| |x|))))))
      (#1# (LIST |x|))))))

; pfSexpr pform ==
;     strip pform where
;          strip pform ==
;             pfId? pform       => pfIdSymbol pform
;             pfLiteral?  pform => pfLiteralString pform
;             pfLeaf? pform     => tokPart pform
;
;             pfApplication? pform =>
;                 args :=
;                     a := pfApplicationArg pform
;                     if pfTuple? a then pf0TupleParts a else [a]
;                 [strip p for p in cons(pfApplicationOp pform, args)]
;
;             cons(pfAbSynOp pform, [strip p for p in pfParts pform])

(DEFUN |pfSexpr| (|pform|) (PROG () (RETURN (|pfSexpr,strip| |pform|))))
(DEFUN |pfSexpr,strip| (|pform|)
  (PROG (|a| |args|)
    (RETURN
     (COND ((|pfId?| |pform|) (|pfIdSymbol| |pform|))
           ((|pfLiteral?| |pform|) (|pfLiteralString| |pform|))
           ((|pfLeaf?| |pform|) (|tokPart| |pform|))
           ((|pfApplication?| |pform|)
            (PROGN
             (SETQ |args|
                     (PROGN
                      (SETQ |a| (|pfApplicationArg| |pform|))
                      (COND ((|pfTuple?| |a|) (|pf0TupleParts| |a|))
                            (#1='T (LIST |a|)))))
             ((LAMBDA (|bfVar#18| |bfVar#17| |p|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#17|)
                       (PROGN (SETQ |p| (CAR |bfVar#17|)) NIL))
                   (RETURN (NREVERSE |bfVar#18|)))
                  (#1#
                   (SETQ |bfVar#18| (CONS (|pfSexpr,strip| |p|) |bfVar#18|))))
                 (SETQ |bfVar#17| (CDR |bfVar#17|))))
              NIL (CONS (|pfApplicationOp| |pform|) |args|) NIL)))
           (#1#
            (CONS (|pfAbSynOp| |pform|)
                  ((LAMBDA (|bfVar#20| |bfVar#19| |p|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#19|)
                            (PROGN (SETQ |p| (CAR |bfVar#19|)) NIL))
                        (RETURN (NREVERSE |bfVar#20|)))
                       (#1#
                        (SETQ |bfVar#20|
                                (CONS (|pfSexpr,strip| |p|) |bfVar#20|))))
                      (SETQ |bfVar#19| (CDR |bfVar#19|))))
                   NIL (|pfParts| |pform|) NIL)))))))

; pfCopyWithPos( pform , pos ) ==
;     pfLeaf? pform =>         pfLeaf( pfAbSynOp pform , tokPart pform , pos )
;     pfTree( pfAbSynOp pform , [ pfCopyWithPos( p , pos ) for p in pfParts pform ] )

(DEFUN |pfCopyWithPos| (|pform| |pos|)
  (PROG ()
    (RETURN
     (COND
      ((|pfLeaf?| |pform|)
       (|pfLeaf| (|pfAbSynOp| |pform|) (|tokPart| |pform|) |pos|))
      (#1='T
       (|pfTree| (|pfAbSynOp| |pform|)
        ((LAMBDA (|bfVar#22| |bfVar#21| |p|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#21|) (PROGN (SETQ |p| (CAR |bfVar#21|)) NIL))
              (RETURN (NREVERSE |bfVar#22|)))
             (#1#
              (SETQ |bfVar#22| (CONS (|pfCopyWithPos| |p| |pos|) |bfVar#22|))))
            (SETQ |bfVar#21| (CDR |bfVar#21|))))
         NIL (|pfParts| |pform|) NIL)))))))

; pfMapParts(f, pform) ==
;     pfLeaf? pform => pform
;     parts0 := pfParts pform
;     parts1 := [FUNCALL(f, p) for p in parts0]
;     -- Return the original if no changes.
;     same := true
;     for p0 in parts0 for p1 in parts1 while same repeat same := EQ(p0,p1)
;     same => pform
;     pfTree(pfAbSynOp pform, parts1)

(DEFUN |pfMapParts| (|f| |pform|)
  (PROG (|parts0| |parts1| |same|)
    (RETURN
     (COND ((|pfLeaf?| |pform|) |pform|)
           (#1='T
            (PROGN
             (SETQ |parts0| (|pfParts| |pform|))
             (SETQ |parts1|
                     ((LAMBDA (|bfVar#24| |bfVar#23| |p|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#23|)
                               (PROGN (SETQ |p| (CAR |bfVar#23|)) NIL))
                           (RETURN (NREVERSE |bfVar#24|)))
                          (#1#
                           (SETQ |bfVar#24|
                                   (CONS (FUNCALL |f| |p|) |bfVar#24|))))
                         (SETQ |bfVar#23| (CDR |bfVar#23|))))
                      NIL |parts0| NIL))
             (SETQ |same| T)
             ((LAMBDA (|bfVar#25| |p0| |bfVar#26| |p1|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#25|)
                       (PROGN (SETQ |p0| (CAR |bfVar#25|)) NIL)
                       (ATOM |bfVar#26|)
                       (PROGN (SETQ |p1| (CAR |bfVar#26|)) NIL) (NOT |same|))
                   (RETURN NIL))
                  (#1# (SETQ |same| (EQ |p0| |p1|))))
                 (SETQ |bfVar#25| (CDR |bfVar#25|))
                 (SETQ |bfVar#26| (CDR |bfVar#26|))))
              |parts0| NIL |parts1| NIL)
             (COND (|same| |pform|)
                   (#1# (|pfTree| (|pfAbSynOp| |pform|) |parts1|)))))))))

; pf0ApplicationArgs pform ==
;     arg := pfApplicationArg pform
;     pf0FlattenSyntacticTuple arg

(DEFUN |pf0ApplicationArgs| (|pform|)
  (PROG (|arg|)
    (RETURN
     (PROGN
      (SETQ |arg| (|pfApplicationArg| |pform|))
      (|pf0FlattenSyntacticTuple| |arg|)))))

; pf0FlattenSyntacticTuple pform ==
;     not pfTuple? pform => [pform]
;     [:pf0FlattenSyntacticTuple p for p in pf0TupleParts pform]

(DEFUN |pf0FlattenSyntacticTuple| (|pform|)
  (PROG ()
    (RETURN
     (COND ((NULL (|pfTuple?| |pform|)) (LIST |pform|))
           (#1='T
            ((LAMBDA (|bfVar#28| |bfVar#27| |p|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#27|)
                      (PROGN (SETQ |p| (CAR |bfVar#27|)) NIL))
                  (RETURN (NREVERSE |bfVar#28|)))
                 (#1#
                  (SETQ |bfVar#28|
                          (APPEND (REVERSE (|pf0FlattenSyntacticTuple| |p|))
                                  |bfVar#28|))))
                (SETQ |bfVar#27| (CDR |bfVar#27|))))
             NIL (|pf0TupleParts| |pform|) NIL))))))
