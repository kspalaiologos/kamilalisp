
; )package "BOOT"

(IN-PACKAGE "BOOT")

; hashCode? x == INTEGERP x

(DEFUN |hashCode?| (|x|) (PROG () (RETURN (INTEGERP |x|))))

; $domainTypeTokens := ['lazyOldAxiomDomain, 'oldAxiomDomain, 'oldAxiomPreCategory,
;            'oldAxiomCategory, 0]

(EVAL-WHEN (EVAL LOAD)
  (SETQ |$domainTypeTokens|
          (LIST '|lazyOldAxiomDomain| '|oldAxiomDomain| '|oldAxiomPreCategory|
                '|oldAxiomCategory| 0)))

; DNameStringID := 0

(EVAL-WHEN (EVAL LOAD) (SETQ |DNameStringID| 0))

; DNameApplyID  := 1

(EVAL-WHEN (EVAL LOAD) (SETQ |DNameApplyID| 1))

; DNameTupleID  := 2

(EVAL-WHEN (EVAL LOAD) (SETQ |DNameTupleID| 2))

; DNameOtherID  := 3

(EVAL-WHEN (EVAL LOAD) (SETQ |DNameOtherID| 3))

; DNameToSExpr1 dname ==
;   NULL dname => error "unexpected domain name"
;   first dname = DNameStringID =>
;     INTERN(CompStrToString rest dname)
;   name0 := DNameToSExpr1 first rest dname
;   args  := rest rest dname
;   name0 = '_-_> =>
;     froms := first args
;     froms := MAPCAR(function DNameToSExpr, rest froms)
;     ret   := first rest args -- a tuple
;     ret   := DNameToSExpr first rest ret -- contents
;     CONS('Mapping, CONS(ret, froms))
;   name0 = 'Union or name0 = 'Record =>
;     sxs := MAPCAR(function DNameToSExpr, rest first args)
;     CONS(name0, sxs)
;   name0 = 'Enumeration =>
;     CONS(name0, MAPCAR(function DNameFixEnum, rest first args))
;   CONS(name0, MAPCAR(function DNameToSExpr, args))

(DEFUN |DNameToSExpr1| (|dname|)
  (PROG (|name0| |args| |froms| |ret| |sxs|)
    (RETURN
     (COND ((NULL |dname|) (|error| '|unexpected domain name|))
           ((EQUAL (CAR |dname|) |DNameStringID|)
            (INTERN (|CompStrToString| (CDR |dname|))))
           (#1='T
            (PROGN
             (SETQ |name0| (|DNameToSExpr1| (CAR (CDR |dname|))))
             (SETQ |args| (CDR (CDR |dname|)))
             (COND
              ((EQ |name0| '->)
               (PROGN
                (SETQ |froms| (CAR |args|))
                (SETQ |froms| (MAPCAR #'|DNameToSExpr| (CDR |froms|)))
                (SETQ |ret| (CAR (CDR |args|)))
                (SETQ |ret| (|DNameToSExpr| (CAR (CDR |ret|))))
                (CONS '|Mapping| (CONS |ret| |froms|))))
              ((OR (EQ |name0| '|Union|) (EQ |name0| '|Record|))
               (PROGN
                (SETQ |sxs| (MAPCAR #'|DNameToSExpr| (CDR (CAR |args|))))
                (CONS |name0| |sxs|)))
              ((EQ |name0| '|Enumeration|)
               (CONS |name0| (MAPCAR #'|DNameFixEnum| (CDR (CAR |args|)))))
              (#1# (CONS |name0| (MAPCAR #'|DNameToSExpr| |args|))))))))))

; DNameToSExpr dname ==
;   first dname = DNameOtherID  =>
;         rest dname
;   sx := DNameToSExpr1 dname
;   CONSP sx => sx
;   LIST sx

(DEFUN |DNameToSExpr| (|dname|)
  (PROG (|sx|)
    (RETURN
     (COND ((EQUAL (CAR |dname|) |DNameOtherID|) (CDR |dname|))
           (#1='T
            (PROGN
             (SETQ |sx| (|DNameToSExpr1| |dname|))
             (COND ((CONSP |sx|) |sx|) (#1# (LIST |sx|)))))))))

; DNameFixEnum arg == CompStrToString rest arg

(DEFUN |DNameFixEnum| (|arg|)
  (PROG () (RETURN (|CompStrToString| (CDR |arg|)))))

; SExprToDName(sexpr, cosigVal) ==
;   -- is it a non-type valued object?
;   NOT cosigVal => [DNameOtherID, :sexpr]
;   if first sexpr = '_: then sexpr := first rest rest sexpr
;   first sexpr = 'Mapping =>
;     args := [SExprToDName(sx, 'T) for sx in rest sexpr]
;     [DNameApplyID,
;          [DNameStringID,: StringToCompStr '"->"],
;               [DNameTupleID, :rest args],
;                  [DNameTupleID, first args]]
;   name0 :=   [DNameStringID, :StringToCompStr SYMBOL_-NAME first sexpr]
;   first sexpr = 'Union or first sexpr = 'Record =>
;     [DNameApplyID, name0,
;         [DNameTupleID, :[ SExprToDName(sx, 'T) for sx in rest sexpr]]]
;   newCosig := rest GETDATABASE(first sexpr, QUOTE COSIG)
;   [DNameApplyID, name0,
;     :MAPCAR(function SExprToDName, rest sexpr, newCosig)]

(DEFUN |SExprToDName| (|sexpr| |cosigVal|)
  (PROG (|args| |name0| |newCosig|)
    (RETURN
     (COND ((NULL |cosigVal|) (CONS |DNameOtherID| |sexpr|))
           (#1='T
            (PROGN
             (COND
              ((EQ (CAR |sexpr|) '|:|)
               (SETQ |sexpr| (CAR (CDR (CDR |sexpr|))))))
             (COND
              ((EQ (CAR |sexpr|) '|Mapping|)
               (PROGN
                (SETQ |args|
                        ((LAMBDA (|bfVar#2| |bfVar#1| |sx|)
                           (LOOP
                            (COND
                             ((OR (ATOM |bfVar#1|)
                                  (PROGN (SETQ |sx| (CAR |bfVar#1|)) NIL))
                              (RETURN (NREVERSE |bfVar#2|)))
                             (#1#
                              (SETQ |bfVar#2|
                                      (CONS (|SExprToDName| |sx| 'T)
                                            |bfVar#2|))))
                            (SETQ |bfVar#1| (CDR |bfVar#1|))))
                         NIL (CDR |sexpr|) NIL))
                (LIST |DNameApplyID|
                      (CONS |DNameStringID| (|StringToCompStr| "->"))
                      (CONS |DNameTupleID| (CDR |args|))
                      (LIST |DNameTupleID| (CAR |args|)))))
              (#1#
               (PROGN
                (SETQ |name0|
                        (CONS |DNameStringID|
                              (|StringToCompStr| (SYMBOL-NAME (CAR |sexpr|)))))
                (COND
                 ((OR (EQ (CAR |sexpr|) '|Union|) (EQ (CAR |sexpr|) '|Record|))
                  (LIST |DNameApplyID| |name0|
                        (CONS |DNameTupleID|
                              ((LAMBDA (|bfVar#4| |bfVar#3| |sx|)
                                 (LOOP
                                  (COND
                                   ((OR (ATOM |bfVar#3|)
                                        (PROGN
                                         (SETQ |sx| (CAR |bfVar#3|))
                                         NIL))
                                    (RETURN (NREVERSE |bfVar#4|)))
                                   (#1#
                                    (SETQ |bfVar#4|
                                            (CONS (|SExprToDName| |sx| 'T)
                                                  |bfVar#4|))))
                                  (SETQ |bfVar#3| (CDR |bfVar#3|))))
                               NIL (CDR |sexpr|) NIL))))
                 (#1#
                  (PROGN
                   (SETQ |newCosig| (CDR (GETDATABASE (CAR |sexpr|) 'COSIG)))
                   (CONS |DNameApplyID|
                         (CONS |name0|
                               (MAPCAR #'|SExprToDName| (CDR |sexpr|)
                                       |newCosig|)))))))))))))))

; StringToCompStr(str) ==
;    CONCATENATE(QUOTE STRING, str, STRING (CODE_-CHAR 0))

(DEFUN |StringToCompStr| (|str|)
  (PROG () (RETURN (CONCATENATE 'STRING |str| (STRING (CODE-CHAR 0))))))

; CompStrToString(str) ==
;    SUBSTRING(str, 0, (LENGTH str - 1))

(DEFUN |CompStrToString| (|str|)
  (PROG () (RETURN (SUBSTRING |str| 0 (- (LENGTH |str|) 1)))))

; runOldAxiomFunctor(:allArgs) ==
;   [:args,env] := allArgs
;   GETDATABASE(env, 'CONSTRUCTORKIND) = 'category =>
;       [$oldAxiomPreCategoryDispatch,: [env, :args]]
;   dom:=APPLY(env, args)
;   makeOldAxiomDispatchDomain dom

(DEFUN |runOldAxiomFunctor| (&REST |allArgs|)
  (PROG (|LETTMP#1| |env| |args| |dom|)
    (RETURN
     (PROGN
      (SETQ |LETTMP#1| (REVERSE |allArgs|))
      (SETQ |env| (CAR |LETTMP#1|))
      (SETQ |args| (NREVERSE (CDR |LETTMP#1|)))
      (COND
       ((EQ (GETDATABASE |env| 'CONSTRUCTORKIND) '|category|)
        (CONS |$oldAxiomPreCategoryDispatch| (CONS |env| |args|)))
       ('T
        (PROGN
         (SETQ |dom| (APPLY |env| |args|))
         (|makeOldAxiomDispatchDomain| |dom|))))))))

; makeLazyOldAxiomDispatchDomain domform ==
;   GETDATABASE(opOf domform, 'CONSTRUCTORKIND) = 'category =>
;       [$oldAxiomPreCategoryDispatch,: domform]
;   dd := [$lazyOldAxiomDomainDispatch, hashTypeForm(domform,0), domform]
;   NCONC(dd,dd) -- installs back pointer to head of domain.
;   dd

(DEFUN |makeLazyOldAxiomDispatchDomain| (|domform|)
  (PROG (|dd|)
    (RETURN
     (COND
      ((EQ (GETDATABASE (|opOf| |domform|) 'CONSTRUCTORKIND) '|category|)
       (CONS |$oldAxiomPreCategoryDispatch| |domform|))
      ('T
       (PROGN
        (SETQ |dd|
                (LIST |$lazyOldAxiomDomainDispatch|
                      (|hashTypeForm| |domform| 0) |domform|))
        (NCONC |dd| |dd|)
        |dd|))))))

; makeOldAxiomDispatchDomain dom ==
;   PAIRP dom => dom
;   [$oldAxiomDomainDispatch,hashTypeForm(dom.0,0),:dom]

(DEFUN |makeOldAxiomDispatchDomain| (|dom|)
  (PROG ()
    (RETURN
     (COND ((CONSP |dom|) |dom|)
           ('T
            (CONS |$oldAxiomDomainDispatch|
                  (CONS (|hashTypeForm| (ELT |dom| 0) 0) |dom|)))))))

; closeOldAxiomFunctor(name) ==
;    [function runOldAxiomFunctor,:SYMBOL_-FUNCTION name]

(DEFUN |closeOldAxiomFunctor| (|name|)
  (PROG () (RETURN (CONS #'|runOldAxiomFunctor| (SYMBOL-FUNCTION |name|)))))

; lazyOldAxiomDomainLookupExport(domenv, self, op, sig, box, skipdefaults, env) ==
;   dom := instantiate domenv
;   SPADCALL(rest dom, self, op, sig, box, skipdefaults, (first dom).3)

(DEFUN |lazyOldAxiomDomainLookupExport|
       (|domenv| |self| |op| |sig| |box| |skipdefaults| |env|)
  (PROG (|dom|)
    (RETURN
     (PROGN
      (SETQ |dom| (|instantiate| |domenv|))
      (SPADCALL (CDR |dom|) |self| |op| |sig| |box| |skipdefaults|
       (ELT (CAR |dom|) 3))))))

; lazyOldAxiomDomainHashCode(domenv, env) == first domenv

(DEFUN |lazyOldAxiomDomainHashCode| (|domenv| |env|)
  (PROG () (RETURN (CAR |domenv|))))

; lazyOldAxiomDomainDevaluate(domenv, env) ==
;   dom := instantiate domenv
;   SPADCALL(rest dom, (first dom).1)

(DEFUN |lazyOldAxiomDomainDevaluate| (|domenv| |env|)
  (PROG (|dom|)
    (RETURN
     (PROGN
      (SETQ |dom| (|instantiate| |domenv|))
      (SPADCALL (CDR |dom|) (ELT (CAR |dom|) 1))))))

; lazyOldAxiomAddChild(domenv, kid, env) ==
;   CONS($lazyOldAxiomDomainDispatch,domenv)

(DEFUN |lazyOldAxiomAddChild| (|domenv| |kid| |env|)
  (PROG () (RETURN (CONS |$lazyOldAxiomDomainDispatch| |domenv|))))

; $lazyOldAxiomDomainDispatch :=
;    VECTOR('lazyOldAxiomDomain,
;           [function lazyOldAxiomDomainDevaluate],
;           [nil],
;           [function lazyOldAxiomDomainLookupExport],
;           [function lazyOldAxiomDomainHashCode],
;           [function lazyOldAxiomAddChild])

(EVAL-WHEN (EVAL LOAD)
  (SETQ |$lazyOldAxiomDomainDispatch|
          (VECTOR '|lazyOldAxiomDomain| (LIST #'|lazyOldAxiomDomainDevaluate|)
                  (LIST NIL) (LIST #'|lazyOldAxiomDomainLookupExport|)
                  (LIST #'|lazyOldAxiomDomainHashCode|)
                  (LIST #'|lazyOldAxiomAddChild|))))

; oldAxiomPreCategoryBuild(catform, dom, env) ==
;    pack := oldAxiomCategoryDefaultPackage(catform, dom)
;    CONS($oldAxiomCategoryDispatch,
;        [catform, hashTypeForm(catform,0), pack, oldAxiomPreCategoryParents(catform,dom), dom])

(DEFUN |oldAxiomPreCategoryBuild| (|catform| |dom| |env|)
  (PROG (|pack|)
    (RETURN
     (PROGN
      (SETQ |pack| (|oldAxiomCategoryDefaultPackage| |catform| |dom|))
      (CONS |$oldAxiomCategoryDispatch|
            (LIST |catform| (|hashTypeForm| |catform| 0) |pack|
                  (|oldAxiomPreCategoryParents| |catform| |dom|) |dom|))))))

; oldAxiomPreCategoryHashCode(catform, env) == hashTypeForm(catform,0)

(DEFUN |oldAxiomPreCategoryHashCode| (|catform| |env|)
  (PROG () (RETURN (|hashTypeForm| |catform| 0))))

; oldAxiomCategoryDefaultPackage(catform, dom) ==
;     hasDefaultPackage opOf catform

(DEFUN |oldAxiomCategoryDefaultPackage| (|catform| |dom|)
  (PROG () (RETURN (|hasDefaultPackage| (|opOf| |catform|)))))

; oldAxiomPreCategoryDevaluate([op,:args], env) ==
;    SExprToDName([op,:devaluateList args], T)

(DEFUN |oldAxiomPreCategoryDevaluate| (|bfVar#5| |env|)
  (PROG (|op| |args|)
    (RETURN
     (PROGN
      (SETQ |op| (CAR |bfVar#5|))
      (SETQ |args| (CDR |bfVar#5|))
      (|SExprToDName| (CONS |op| (|devaluateList| |args|)) T$)))))

; oldAxiomCategoryDevaluate([[op,:args],:.], env) ==
;   SExprToDName([op,:devaluateList args], T)

(DEFUN |oldAxiomCategoryDevaluate| (|bfVar#6| |env|)
  (PROG (|op| |args|)
    (RETURN
     (PROGN
      (SETQ |op| (CAAR . #1=(|bfVar#6|)))
      (SETQ |args| (CDAR . #1#))
      (|SExprToDName| (CONS |op| (|devaluateList| |args|)) T$)))))

; $oldAxiomPreCategoryDispatch :=
;    VECTOR('oldAxiomPreCategory,
;           [function oldAxiomPreCategoryDevaluate],
;           [nil],
;           [nil],
;           [function oldAxiomPreCategoryHashCode],
;           [function oldAxiomPreCategoryBuild],
;           [nil])

(EVAL-WHEN (EVAL LOAD)
  (SETQ |$oldAxiomPreCategoryDispatch|
          (VECTOR '|oldAxiomPreCategory|
                  (LIST #'|oldAxiomPreCategoryDevaluate|) (LIST NIL) (LIST NIL)
                  (LIST #'|oldAxiomPreCategoryHashCode|)
                  (LIST #'|oldAxiomPreCategoryBuild|) (LIST NIL))))

; oldAxiomPreCategoryParents(catform,dom) ==
;   vars := ["$",:rest GETDATABASE(opOf catform, 'CONSTRUCTORFORM)]
;   vals := [dom,:rest catform]
;   -- parents :=  GETDATABASE(opOf catform, 'PARENTS)
;   parents := parentsOf opOf catform
;   -- strip out forms listed both conditionally and unconditionally
;   unconditionalParents := []
;   filteredParents := []
;   for [cat, :pred] in parents repeat
;      if pred = true then
;         unconditionalParents := [cat,:unconditionalParents]
;         filteredParents := [[cat,:pred], :filteredParents]
;   for [cat, :pred] in parents repeat
;      if not pred = true and not member(cat, unconditionalParents) then
;         filteredParents=[[cat,:pred], :filteredParents]
;   PROGV(vars, vals,
;      LIST2VEC [EVAL quoteCatOp cat for [cat,:pred] in filteredParents | EVAL pred])

(DEFUN |oldAxiomPreCategoryParents| (|catform| |dom|)
  (PROG (|vars| |vals| |parents| |unconditionalParents| |filteredParents| |cat|
         |pred|)
    (RETURN
     (PROGN
      (SETQ |vars|
              (CONS '$
                    (CDR (GETDATABASE (|opOf| |catform|) 'CONSTRUCTORFORM))))
      (SETQ |vals| (CONS |dom| (CDR |catform|)))
      (SETQ |parents| (|parentsOf| (|opOf| |catform|)))
      (SETQ |unconditionalParents| NIL)
      (SETQ |filteredParents| NIL)
      ((LAMBDA (|bfVar#8| |bfVar#7|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#8|) (PROGN (SETQ |bfVar#7| (CAR |bfVar#8|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#7|)
                 (PROGN
                  (SETQ |cat| (CAR |bfVar#7|))
                  (SETQ |pred| (CDR |bfVar#7|))
                  #1#)
                 (COND
                  ((EQUAL |pred| T)
                   (SETQ |unconditionalParents|
                           (CONS |cat| |unconditionalParents|))
                   (SETQ |filteredParents|
                           (CONS (CONS |cat| |pred|) |filteredParents|)))))))
          (SETQ |bfVar#8| (CDR |bfVar#8|))))
       |parents| NIL)
      ((LAMBDA (|bfVar#10| |bfVar#9|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#10|)
                (PROGN (SETQ |bfVar#9| (CAR |bfVar#10|)) NIL))
            (RETURN NIL))
           (#1#
            (AND (CONSP |bfVar#9|)
                 (PROGN
                  (SETQ |cat| (CAR |bfVar#9|))
                  (SETQ |pred| (CDR |bfVar#9|))
                  #1#)
                 (COND
                  ((AND (EQUAL (NULL |pred|) T)
                        (NULL (|member| |cat| |unconditionalParents|)))
                   (EQUAL |filteredParents|
                          (CONS (CONS |cat| |pred|) |filteredParents|)))))))
          (SETQ |bfVar#10| (CDR |bfVar#10|))))
       |parents| NIL)
      (PROGV
          |vars|
          |vals|
        (LIST2VEC
         ((LAMBDA (|bfVar#13| |bfVar#12| |bfVar#11|)
            (LOOP
             (COND
              ((OR (ATOM |bfVar#12|)
                   (PROGN (SETQ |bfVar#11| (CAR |bfVar#12|)) NIL))
               (RETURN (NREVERSE |bfVar#13|)))
              (#1#
               (AND (CONSP |bfVar#11|)
                    (PROGN
                     (SETQ |cat| (CAR |bfVar#11|))
                     (SETQ |pred| (CDR |bfVar#11|))
                     #1#)
                    (EVAL |pred|)
                    (SETQ |bfVar#13|
                            (CONS (EVAL (|quoteCatOp| |cat|)) |bfVar#13|)))))
             (SETQ |bfVar#12| (CDR |bfVar#12|))))
          NIL |filteredParents| NIL)))))))

; quoteCatOp cat ==
;    atom cat => MKQ cat
;    ['LIST, MKQ first cat, :rest cat]

(DEFUN |quoteCatOp| (|cat|)
  (PROG ()
    (RETURN
     (COND ((ATOM |cat|) (MKQ |cat|))
           ('T (CONS 'LIST (CONS (MKQ (CAR |cat|)) (CDR |cat|))))))))

; oldAxiomCategoryLookupExport(catenv, self, op, sig, box, env) ==
;    [catform,hash, pack,:.] := catenv
;    opIsHasCat op => if EQL(sig, hash) then [self] else nil
;    NULL(pack) => nil
;    if not VECP pack then
;        pack:=apply(pack, CONS(self, rest catform))
;        RPLACA(CDDR catenv, pack)
;    fun := basicLookup(op, sig, pack, self) => [fun]
;    nil

(DEFUN |oldAxiomCategoryLookupExport| (|catenv| |self| |op| |sig| |box| |env|)
  (PROG (|catform| |hash| |pack| |fun|)
    (RETURN
     (PROGN
      (SETQ |catform| (CAR |catenv|))
      (SETQ |hash| (CADR . #1=(|catenv|)))
      (SETQ |pack| (CADDR . #1#))
      (COND
       ((|opIsHasCat| |op|)
        (COND ((EQL |sig| |hash|) (LIST |self|)) (#2='T NIL)))
       ((NULL |pack|) NIL)
       (#2#
        (PROGN
         (COND
          ((NULL (VECP |pack|))
           (SETQ |pack| (APPLY |pack| (CONS |self| (CDR |catform|))))
           (RPLACA (CDDR |catenv|) |pack|)))
         (COND
          ((SETQ |fun| (|basicLookup| |op| |sig| |pack| |self|)) (LIST |fun|))
          (#2# NIL)))))))))

; oldAxiomCategoryParentCount([.,.,.,parents,.], env) == LENGTH parents

(DEFUN |oldAxiomCategoryParentCount| (|bfVar#14| |env|)
  (PROG (|parents|)
    (RETURN (PROGN (SETQ |parents| (CADDDR |bfVar#14|)) (LENGTH |parents|)))))

; oldAxiomCategoryNthParent([.,.,.,parvec,dom], n, env) ==
;   catform := ELT(parvec, n-1)
;   VECTORP IFCAR catform => catform
;   newcat := oldAxiomPreCategoryBuild(catform,dom,nil)
;   SETELT(parvec, n-1, newcat)
;   newcat

(DEFUN |oldAxiomCategoryNthParent| (|bfVar#15| |n| |env|)
  (PROG (|parvec| |dom| |catform| |newcat|)
    (RETURN
     (PROGN
      (SETQ |parvec| (CADDDR . #1=(|bfVar#15|)))
      (SETQ |dom| (CAR (CDDDDR . #1#)))
      (SETQ |catform| (ELT |parvec| (- |n| 1)))
      (COND ((VECTORP (IFCAR |catform|)) |catform|)
            ('T
             (PROGN
              (SETQ |newcat| (|oldAxiomPreCategoryBuild| |catform| |dom| NIL))
              (SETELT |parvec| (- |n| 1) |newcat|)
              |newcat|)))))))

; oldAxiomCategoryBuild([catform,:.], dom, env) ==
;   oldAxiomPreCategoryBuild(catform,dom, env)

(DEFUN |oldAxiomCategoryBuild| (|bfVar#16| |dom| |env|)
  (PROG (|catform|)
    (RETURN
     (PROGN
      (SETQ |catform| (CAR |bfVar#16|))
      (|oldAxiomPreCategoryBuild| |catform| |dom| |env|)))))

; oldAxiomCategoryHashCode([.,hash,:.], env) == hash

(DEFUN |oldAxiomCategoryHashCode| (|bfVar#17| |env|)
  (PROG (|hash|) (RETURN (PROGN (SETQ |hash| (CADR |bfVar#17|)) |hash|))))

; $oldAxiomCategoryDispatch :=
;    VECTOR('oldAxiomCategory,
;           [function oldAxiomCategoryDevaluate],
;           [nil],
;           [function oldAxiomCategoryLookupExport],
;           [function oldAxiomCategoryHashCode],
;           [function oldAxiomCategoryBuild], -- builder ??
;           [function oldAxiomCategoryParentCount],
;           [function oldAxiomCategoryNthParent]) -- 1 indexed

(EVAL-WHEN (EVAL LOAD)
  (SETQ |$oldAxiomCategoryDispatch|
          (VECTOR '|oldAxiomCategory| (LIST #'|oldAxiomCategoryDevaluate|)
                  (LIST NIL) (LIST #'|oldAxiomCategoryLookupExport|)
                  (LIST #'|oldAxiomCategoryHashCode|)
                  (LIST #'|oldAxiomCategoryBuild|)
                  (LIST #'|oldAxiomCategoryParentCount|)
                  (LIST #'|oldAxiomCategoryNthParent|))))

; instantiate domenv ==
;    -- following is a patch for a bug in runtime.as
;    -- has a lazy dispatch vector with an instantiated domenv
;   VECTORP rest domenv => [$oldAxiomDomainDispatch, :domenv]
;   callForm := CADR domenv
;   oldDom := CDDR domenv
;   [functor,:args] := callForm
; --  if null(fn := GETL(functor,'instantiate)) then
; --     ofn := SYMBOL_-FUNCTION functor
; --     loadFunctor functor
; --     fn := SYMBOL_-FUNCTION functor
; --     SETF(SYMBOL_-FUNCTION functor, ofn)
; --     PUT(functor, 'instantiate, fn)
; --  domvec := APPLY(fn, args)
;   domvec := APPLY(functor, args)
;   RPLACA(oldDom, $oldAxiomDomainDispatch)
;   RPLACD(oldDom, [CADR oldDom,: domvec])
;   oldDom

(DEFUN |instantiate| (|domenv|)
  (PROG (|callForm| |oldDom| |functor| |args| |domvec|)
    (RETURN
     (COND ((VECTORP (CDR |domenv|)) (CONS |$oldAxiomDomainDispatch| |domenv|))
           ('T
            (PROGN
             (SETQ |callForm| (CADR |domenv|))
             (SETQ |oldDom| (CDDR |domenv|))
             (SETQ |functor| (CAR |callForm|))
             (SETQ |args| (CDR |callForm|))
             (SETQ |domvec| (APPLY |functor| |args|))
             (RPLACA |oldDom| |$oldAxiomDomainDispatch|)
             (RPLACD |oldDom| (CONS (CADR |oldDom|) |domvec|))
             |oldDom|))))))

; hashTypeForm([fn,: args], percentHash) ==
;    hashType([fn,:devaluateList args], percentHash)

(DEFUN |hashTypeForm| (|bfVar#18| |percentHash|)
  (PROG (|fn| |args|)
    (RETURN
     (PROGN
      (SETQ |fn| (CAR |bfVar#18|))
      (SETQ |args| (CDR |bfVar#18|))
      (|hashType| (CONS |fn| (|devaluateList| |args|)) |percentHash|)))))

; devaluate(d) ==
;   isDomain d =>
;       -- ?need a shortcut for old domains
;       -- ELT(first d, 0) = 'oldAxiomDomain => ...
;       -- FIXP(ELT(first d, 0)) => d
;       DNameToSExpr(SPADCALL(rest d, (first d).1))
;   not REFVECP d => d
;   greater_SI(QVSIZE d, 5) and QREFELT(d, 3) is ['Category] => QREFELT(d, 0)
;   greater_SI(QVSIZE d, 0) =>
;     d':=QREFELT(d,0)
;     isFunctor d' => d'
;     d
;   d

(DEFUN |devaluate| (|d|)
  (PROG (|ISTMP#1| |d'|)
    (RETURN
     (COND
      ((|isDomain| |d|)
       (|DNameToSExpr| (SPADCALL (CDR |d|) (ELT (CAR |d|) 1))))
      ((NULL (REFVECP |d|)) |d|)
      ((AND (|greater_SI| (QVSIZE |d|) 5)
            (PROGN
             (SETQ |ISTMP#1| (QREFELT |d| 3))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (EQ (CAR |ISTMP#1|) '|Category|))))
       (QREFELT |d| 0))
      ((|greater_SI| (QVSIZE |d|) 0)
       (PROGN
        (SETQ |d'| (QREFELT |d| 0))
        (COND ((|isFunctor| |d'|) |d'|) (#1='T |d|))))
      (#1# |d|)))))

; devaluateList l == [devaluate d for d in l]

(DEFUN |devaluateList| (|l|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#20| |bfVar#19| |d|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#19|) (PROGN (SETQ |d| (CAR |bfVar#19|)) NIL))
           (RETURN (NREVERSE |bfVar#20|)))
          ('T (SETQ |bfVar#20| (CONS (|devaluate| |d|) |bfVar#20|))))
         (SETQ |bfVar#19| (CDR |bfVar#19|))))
      NIL |l| NIL))))

; $hashOp1 := hashString '"1"

(EVAL-WHEN (EVAL LOAD) (SETQ |$hashOp1| (|hashString| "1")))

; $hashOp0 := hashString '"0"

(EVAL-WHEN (EVAL LOAD) (SETQ |$hashOp0| (|hashString| "0")))

; $hashOpApply := hashString '"apply"

(EVAL-WHEN (EVAL LOAD) (SETQ |$hashOpApply| (|hashString| "apply")))

; $hashOpSet := hashString '"set!"

(EVAL-WHEN (EVAL LOAD) (SETQ |$hashOpSet| (|hashString| "set!")))

; $hashSeg := hashString '".."

(EVAL-WHEN (EVAL LOAD) (SETQ |$hashSeg| (|hashString| "..")))

; $hashPercent := hashString '"%"

(EVAL-WHEN (EVAL LOAD) (SETQ |$hashPercent| (|hashString| "%")))

; oldAxiomDomainLookupExport _
;   (domenv, self, op, sig, box, skipdefaults, env) ==
;      domainVec := rest domenv
;      if hashCode? op then
;          EQL(op, $hashOp1) => op := 'One
;          EQL(op, $hashOp0) => op := 'Zero
;          EQL(op, $hashOpApply) => op := 'elt
;          EQL(op, $hashOpSet) => op := "setelt!"
;          EQL(op, $hashSeg) => op := 'SEGMENT
;      constant := nil
;      if hashCode? sig and self and EQL(sig, getDomainHash self) then
;        sig := '($)
;        constant := true
;      val :=
;        skipdefaults =>
;           oldCompLookupNoDefaults(op, sig, domainVec, self)
;        oldCompLookup(op, sig, domainVec, self)
;      null val => val
;      if constant then val := SPADCALL val
;      RPLACA(box, val)
;      box

(DEFUN |oldAxiomDomainLookupExport|
       (|domenv| |self| |op| |sig| |box| |skipdefaults| |env|)
  (PROG (|domainVec| |constant| |val|)
    (RETURN
     (PROGN
      (SETQ |domainVec| (CDR |domenv|))
      (COND
       ((|hashCode?| |op|)
        (COND ((EQL |op| |$hashOp1|) (SETQ |op| '|One|))
              ((EQL |op| |$hashOp0|) (SETQ |op| '|Zero|))
              ((EQL |op| |$hashOpApply|) (SETQ |op| '|elt|))
              ((EQL |op| |$hashOpSet|) (SETQ |op| '|setelt!|))
              ((EQL |op| |$hashSeg|) (SETQ |op| 'SEGMENT)))))
      (SETQ |constant| NIL)
      (COND
       ((AND (|hashCode?| |sig|) |self| (EQL |sig| (|getDomainHash| |self|)))
        (SETQ |sig| '($)) (SETQ |constant| T)))
      (SETQ |val|
              (COND
               (|skipdefaults|
                (|oldCompLookupNoDefaults| |op| |sig| |domainVec| |self|))
               (#1='T (|oldCompLookup| |op| |sig| |domainVec| |self|))))
      (COND ((NULL |val|) |val|)
            (#1#
             (PROGN
              (COND (|constant| (SETQ |val| (SPADCALL |val|))))
              (RPLACA |box| |val|)
              |box|)))))))

; oldAxiomDomainHashCode(domenv, env) == first domenv

(DEFUN |oldAxiomDomainHashCode| (|domenv| |env|)
  (PROG () (RETURN (CAR |domenv|))))

; oldAxiomDomainDevaluate(domenv, env) ==
;    SExprToDName((rest domenv).0, 'T)

(DEFUN |oldAxiomDomainDevaluate| (|domenv| |env|)
  (PROG () (RETURN (|SExprToDName| (ELT (CDR |domenv|) 0) 'T))))

; oldAxiomAddChild(domenv, child, env) == CONS($oldAxiomDomainDispatch, domenv)

(DEFUN |oldAxiomAddChild| (|domenv| |child| |env|)
  (PROG () (RETURN (CONS |$oldAxiomDomainDispatch| |domenv|))))

; $oldAxiomDomainDispatch :=
;    VECTOR('oldAxiomDomain,
;           [function oldAxiomDomainDevaluate],
;           [nil],
;           [function oldAxiomDomainLookupExport],
;           [function oldAxiomDomainHashCode],
;           [function oldAxiomAddChild])

(EVAL-WHEN (EVAL LOAD)
  (SETQ |$oldAxiomDomainDispatch|
          (VECTOR '|oldAxiomDomain| (LIST #'|oldAxiomDomainDevaluate|)
                  (LIST NIL) (LIST #'|oldAxiomDomainLookupExport|)
                  (LIST #'|oldAxiomDomainHashCode|)
                  (LIST #'|oldAxiomAddChild|))))

; isDomain a ==
;   PAIRP a and VECP(first a) and
;     member((first a).0, $domainTypeTokens)

(DEFUN |isDomain| (|a|)
  (PROG ()
    (RETURN
     (AND (CONSP |a|) (VECP (CAR |a|))
          (|member| (ELT (CAR |a|) 0) |$domainTypeTokens|)))))

; NRTcompiledLookup(op,sig,dom) ==
;   if CONTAINED('_#,sig) then
;       sig := [NRTtypeHack t for t in sig]
;   compiledLookupCheck(op,sig,dom)

(DEFUN |NRTcompiledLookup| (|op| |sig| |dom|)
  (PROG ()
    (RETURN
     (PROGN
      (COND
       ((CONTAINED '|#| |sig|)
        (SETQ |sig|
                ((LAMBDA (|bfVar#22| |bfVar#21| |t|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#21|)
                          (PROGN (SETQ |t| (CAR |bfVar#21|)) NIL))
                      (RETURN (NREVERSE |bfVar#22|)))
                     ('T
                      (SETQ |bfVar#22| (CONS (|NRTtypeHack| |t|) |bfVar#22|))))
                    (SETQ |bfVar#21| (CDR |bfVar#21|))))
                 NIL |sig| NIL))))
      (|compiledLookupCheck| |op| |sig| |dom|)))))

; compiledLookup(op, sig, dollar) ==
;   if not isDomain dollar then dollar := NRTevalDomain dollar
;   basicLookup(op, sig, dollar, dollar)

(DEFUN |compiledLookup| (|op| |sig| |dollar|)
  (PROG ()
    (RETURN
     (PROGN
      (COND
       ((NULL (|isDomain| |dollar|))
        (SETQ |dollar| (|NRTevalDomain| |dollar|))))
      (|basicLookup| |op| |sig| |dollar| |dollar|)))))

; HasSignature(domain,[op,sig]) ==
;   compiledLookup(op,sig,domain)

(DEFUN |HasSignature| (|domain| |bfVar#23|)
  (PROG (|op| |sig|)
    (RETURN
     (PROGN
      (SETQ |op| (CAR |bfVar#23|))
      (SETQ |sig| (CADR |bfVar#23|))
      (|compiledLookup| |op| |sig| |domain|)))))

; basicLookup(op,sig,domain,dollar) ==
;   -- FIXME: We should use consistent representation, not hacks
;   -- like this one
;   if op = 0 then op := 'Zero
;   if op = ['Zero] then op := 'Zero
;   if op = 1 then op := 'One
;   if op = ['One] then op := 'One
;   -- Spad case
;   VECP domain =>
;      isNewWorldDomain domain => -- getting ops from yourself (or for defaults)
;         oldCompLookup(op, sig, domain, dollar)
;      -- getting ops from Record or Union
;      lookupInDomainVector(op,sig,domain,dollar)
;   hashPercent :=
;      VECP dollar => hashType(dollar.0,0)
;      hashType(dollar,0)
;   box := [nil]
;   not VECP(dispatch := first domain) => error "bad domain format"
;   lookupFun := dispatch.3
;   dispatch.0 = 0 =>  -- new compiler domain object
;        hashSig :=
;            hashCode? sig => sig
;            opIsHasCat op => hashType(sig, hashPercent)
;            hashType(['Mapping,:sig], hashPercent)
;
;        if SYMBOLP op then
;           op = 'Zero => op := $hashOp0
;           op = 'One => op := $hashOp1
;           op = 'elt => op := $hashOpApply
;           op = "setelt!" => op := $hashOpSet
;           op := hashString SYMBOL_-NAME op
;        val := first SPADCALL(rest domain, dollar, op, hashSig, box, false,
;                                lookupFun) => val
;        hashCode? sig => nil
;        #sig>1 or opIsHasCat op => nil
;        boxval := SPADCALL(rest dollar, dollar, op,
;                          hashType(first sig, hashPercent),
;                           box, false, lookupFun) =>
;            [FUNCTION IDENTITY, :first boxval]
;        nil
;   opIsHasCat op =>
;       HasCategory(domain, sig)
;   if hashCode? op then
;      EQL(op, $hashOp1) => op := 'One
;      EQL(op, $hashOp0) => op := 'Zero
;      EQL(op, $hashOpApply) => op := 'elt
;      EQL(op, $hashOpSet) => op := "setelt!"
;      EQL(op, $hashSeg) => op := 'SEGMENT
;   hashCode? sig and EQL(sig, hashPercent) =>
;       SPADCALL first SPADCALL(rest dollar, dollar, op, '($), box,
;                               false, lookupFun)
;   first SPADCALL(rest dollar, dollar, op, sig, box, false, lookupFun)

(DEFUN |basicLookup| (|op| |sig| |domain| |dollar|)
  (PROG (|hashPercent| |box| |dispatch| |lookupFun| |hashSig| |val| |boxval|)
    (RETURN
     (PROGN
      (COND ((EQL |op| 0) (SETQ |op| '|Zero|)))
      (COND ((EQUAL |op| (LIST '|Zero|)) (SETQ |op| '|Zero|)))
      (COND ((EQL |op| 1) (SETQ |op| '|One|)))
      (COND ((EQUAL |op| (LIST '|One|)) (SETQ |op| '|One|)))
      (COND
       ((VECP |domain|)
        (COND
         ((|isNewWorldDomain| |domain|)
          (|oldCompLookup| |op| |sig| |domain| |dollar|))
         (#1='T (|lookupInDomainVector| |op| |sig| |domain| |dollar|))))
       (#1#
        (PROGN
         (SETQ |hashPercent|
                 (COND ((VECP |dollar|) (|hashType| (ELT |dollar| 0) 0))
                       (#1# (|hashType| |dollar| 0))))
         (SETQ |box| (LIST NIL))
         (COND
          ((NULL (VECP (SETQ |dispatch| (CAR |domain|))))
           (|error| '|bad domain format|))
          (#1#
           (PROGN
            (SETQ |lookupFun| (ELT |dispatch| 3))
            (COND
             ((EQL (ELT |dispatch| 0) 0)
              (PROGN
               (SETQ |hashSig|
                       (COND ((|hashCode?| |sig|) |sig|)
                             ((|opIsHasCat| |op|)
                              (|hashType| |sig| |hashPercent|))
                             (#1#
                              (|hashType| (CONS '|Mapping| |sig|)
                               |hashPercent|))))
               (COND
                ((SYMBOLP |op|)
                 (COND ((EQ |op| '|Zero|) (SETQ |op| |$hashOp0|))
                       ((EQ |op| '|One|) (SETQ |op| |$hashOp1|))
                       ((EQ |op| '|elt|) (SETQ |op| |$hashOpApply|))
                       ((EQ |op| '|setelt!|) (SETQ |op| |$hashOpSet|))
                       (#1# (SETQ |op| (|hashString| (SYMBOL-NAME |op|)))))))
               (COND
                ((SETQ |val|
                         (CAR
                          (SPADCALL (CDR |domain|) |dollar| |op| |hashSig|
                           |box| NIL |lookupFun|)))
                 |val|)
                ((|hashCode?| |sig|) NIL)
                ((OR (< 1 (LENGTH |sig|)) (|opIsHasCat| |op|)) NIL)
                ((SETQ |boxval|
                         (SPADCALL (CDR |dollar|) |dollar| |op|
                          (|hashType| (CAR |sig|) |hashPercent|) |box| NIL
                          |lookupFun|))
                 (CONS #'IDENTITY (CAR |boxval|)))
                (#1# NIL))))
             ((|opIsHasCat| |op|) (|HasCategory| |domain| |sig|))
             (#1#
              (PROGN
               (COND
                ((|hashCode?| |op|)
                 (COND ((EQL |op| |$hashOp1|) (SETQ |op| '|One|))
                       ((EQL |op| |$hashOp0|) (SETQ |op| '|Zero|))
                       ((EQL |op| |$hashOpApply|) (SETQ |op| '|elt|))
                       ((EQL |op| |$hashOpSet|) (SETQ |op| '|setelt!|))
                       ((EQL |op| |$hashSeg|) (SETQ |op| 'SEGMENT)))))
               (COND
                ((AND (|hashCode?| |sig|) (EQL |sig| |hashPercent|))
                 (SPADCALL
                  (CAR
                   (SPADCALL (CDR |dollar|) |dollar| |op| '($) |box| NIL
                    |lookupFun|))))
                (#1#
                 (CAR
                  (SPADCALL (CDR |dollar|) |dollar| |op| |sig| |box| NIL
                   |lookupFun|)))))))))))))))))

; basicLookupCheckDefaults(op,sig,domain,dollar) ==
;   box := [nil]
;   not VECP(dispatch := first dollar) => error "bad domain format"
;   lookupFun := dispatch.3
;   dispatch.0 = 0  =>  -- new compiler domain object
;        hashPercent :=
;           VECP dollar => hashType(dollar.0,0)
;           hashType(dollar,0)
;
;        hashSig :=
;          hashCode? sig => sig
;          hashType( ['Mapping,:sig], hashPercent)
;
;        if SYMBOLP op then op := hashString SYMBOL_-NAME op
;        first SPADCALL(rest dollar, dollar, op, hashSig, box,
;                       not $lookupDefaults, lookupFun)
;   first SPADCALL(rest dollar, dollar, op, sig, box,
;                  not $lookupDefaults, lookupFun)

(DEFUN |basicLookupCheckDefaults| (|op| |sig| |domain| |dollar|)
  (PROG (|box| |dispatch| |lookupFun| |hashPercent| |hashSig|)
    (RETURN
     (PROGN
      (SETQ |box| (LIST NIL))
      (COND
       ((NULL (VECP (SETQ |dispatch| (CAR |dollar|))))
        (|error| '|bad domain format|))
       (#1='T
        (PROGN
         (SETQ |lookupFun| (ELT |dispatch| 3))
         (COND
          ((EQL (ELT |dispatch| 0) 0)
           (PROGN
            (SETQ |hashPercent|
                    (COND ((VECP |dollar|) (|hashType| (ELT |dollar| 0) 0))
                          (#1# (|hashType| |dollar| 0))))
            (SETQ |hashSig|
                    (COND ((|hashCode?| |sig|) |sig|)
                          (#1#
                           (|hashType| (CONS '|Mapping| |sig|)
                            |hashPercent|))))
            (COND
             ((SYMBOLP |op|) (SETQ |op| (|hashString| (SYMBOL-NAME |op|)))))
            (CAR
             (SPADCALL (CDR |dollar|) |dollar| |op| |hashSig| |box|
              (NULL |$lookupDefaults|) |lookupFun|))))
          (#1#
           (CAR
            (SPADCALL (CDR |dollar|) |dollar| |op| |sig| |box|
             (NULL |$lookupDefaults|) |lookupFun|)))))))))))

; $hasCatOpHash := hashString '"%%"

(EVAL-WHEN (EVAL LOAD) (SETQ |$hasCatOpHash| (|hashString| "%%")))

; opIsHasCat op ==
;   hashCode? op => EQL(op, $hasCatOpHash)
;   EQ(op, "%%")

(DEFUN |opIsHasCat| (|op|)
  (PROG ()
    (RETURN
     (COND ((|hashCode?| |op|) (EQL |op| |$hasCatOpHash|))
           ('T (EQ |op| '%%))))))

; oldCompLookup(op, sig, domvec, dollar) ==
;   $lookupDefaults:local := nil
;   u := lookupInDomainVector(op,sig,domvec,dollar) => u
;   $lookupDefaults := true
;   lookupInDomainVector(op,sig,domvec,dollar)

(DEFUN |oldCompLookup| (|op| |sig| |domvec| |dollar|)
  (PROG (|$lookupDefaults| |u|)
    (DECLARE (SPECIAL |$lookupDefaults|))
    (RETURN
     (PROGN
      (SETQ |$lookupDefaults| NIL)
      (COND
       ((SETQ |u| (|lookupInDomainVector| |op| |sig| |domvec| |dollar|)) |u|)
       ('T
        (PROGN
         (SETQ |$lookupDefaults| T)
         (|lookupInDomainVector| |op| |sig| |domvec| |dollar|))))))))

; oldCompLookupNoDefaults(op, sig, domvec, dollar) ==
;   $lookupDefaults:local := nil
;   lookupInDomainVector(op,sig,domvec,dollar)

(DEFUN |oldCompLookupNoDefaults| (|op| |sig| |domvec| |dollar|)
  (PROG (|$lookupDefaults|)
    (DECLARE (SPECIAL |$lookupDefaults|))
    (RETURN
     (PROGN
      (SETQ |$lookupDefaults| NIL)
      (|lookupInDomainVector| |op| |sig| |domvec| |dollar|)))))

; lookupInDomainVector(op,sig,domain,dollar) ==
;   PAIRP domain => basicLookupCheckDefaults(op,sig,domain,domain)
;   slot1 := domain.1
;   SPADCALL(op,sig,dollar,slot1)

(DEFUN |lookupInDomainVector| (|op| |sig| |domain| |dollar|)
  (PROG (|slot1|)
    (RETURN
     (COND
      ((CONSP |domain|)
       (|basicLookupCheckDefaults| |op| |sig| |domain| |domain|))
      ('T
       (PROGN
        (SETQ |slot1| (ELT |domain| 1))
        (SPADCALL |op| |sig| |dollar| |slot1|)))))))

; lookupComplete(op,sig,dollar,env) ==
;    hashCode? sig => hashNewLookupInTable(op,sig,dollar,env,nil)
;    newLookupInTable(op,sig,dollar,env,nil)

(DEFUN |lookupComplete| (|op| |sig| |dollar| |env|)
  (PROG ()
    (RETURN
     (COND
      ((|hashCode?| |sig|)
       (|hashNewLookupInTable| |op| |sig| |dollar| |env| NIL))
      ('T (|newLookupInTable| |op| |sig| |dollar| |env| NIL))))))

; lookupIncomplete(op,sig,dollar,env) ==
;    hashCode? sig => hashNewLookupInTable(op,sig,dollar,env,true)
;    newLookupInTable(op,sig,dollar,env,true)

(DEFUN |lookupIncomplete| (|op| |sig| |dollar| |env|)
  (PROG ()
    (RETURN
     (COND
      ((|hashCode?| |sig|)
       (|hashNewLookupInTable| |op| |sig| |dollar| |env| T))
      ('T (|newLookupInTable| |op| |sig| |dollar| |env| T))))))

; lazyMatchArg2(s,a,dollar,domain,typeFlag) ==
;   if s = '$ then
; --  a = 0 => return true  --needed only if extra call in newGoGet to basicLookup
;     s := devaluate dollar -- calls from HasCategory can have $s
;   INTEGERP a =>
;     not typeFlag => s = domain.a
;     a = 6 and $isDefaultingPackage => s = devaluate dollar
;     VECP (d := domainVal(dollar,domain,a)) =>
;       s = d.0 => true
;       domainArg := ($isDefaultingPackage => domain.6.0; domain.0)
;       IFCAR s = QCAR(d.0) and
;                     lazyMatchArgDollarCheck(s, d.0, dollar.0, domainArg)
;     isDomain d =>
;         dhash:=getDomainHash d
;         dhash =
;            (if hashCode? s then s else hashType(s, dhash))
;     lazyMatch(s,d,dollar,domain)                         --new style
;   a = '$ => s = devaluate dollar
;   a = "$$" => s = devaluate domain
;   STRINGP a =>
;     STRINGP s => a = s
;     s is ['QUOTE,y] and PNAME y = a
;     IDENTP s and PNAME s = a
;   atom a =>  a = s
;   op := opOf a
;   op  = 'NRTEVAL => s = nrtEval(CADR a,domain)
;   op = 'QUOTE => s = CADR a
;   lazyMatch(s,a,dollar,domain)

(DEFUN |lazyMatchArg2| (|s| |a| |dollar| |domain| |typeFlag|)
  (PROG (|d| |domainArg| |dhash| |ISTMP#1| |y| |op|)
    (RETURN
     (PROGN
      (COND ((EQ |s| '$) (SETQ |s| (|devaluate| |dollar|))))
      (COND
       ((INTEGERP |a|)
        (COND ((NULL |typeFlag|) (EQUAL |s| (ELT |domain| |a|)))
              ((AND (EQL |a| 6) |$isDefaultingPackage|)
               (EQUAL |s| (|devaluate| |dollar|)))
              ((VECP (SETQ |d| (|domainVal| |dollar| |domain| |a|)))
               (COND ((EQUAL |s| (ELT |d| 0)) T)
                     (#1='T
                      (PROGN
                       (SETQ |domainArg|
                               (COND
                                (|$isDefaultingPackage|
                                 (ELT (ELT |domain| 6) 0))
                                (#1# (ELT |domain| 0))))
                       (AND (EQUAL (IFCAR |s|) (QCAR (ELT |d| 0)))
                            (|lazyMatchArgDollarCheck| |s| (ELT |d| 0)
                             (ELT |dollar| 0) |domainArg|))))))
              ((|isDomain| |d|)
               (PROGN
                (SETQ |dhash| (|getDomainHash| |d|))
                (EQUAL |dhash|
                       (COND ((|hashCode?| |s|) |s|)
                             (#1# (|hashType| |s| |dhash|))))))
              (#1# (|lazyMatch| |s| |d| |dollar| |domain|))))
       ((EQ |a| '$) (EQUAL |s| (|devaluate| |dollar|)))
       ((EQ |a| '$$) (EQUAL |s| (|devaluate| |domain|)))
       ((STRINGP |a|)
        (COND ((STRINGP |s|) (EQUAL |a| |s|))
              (#1#
               (PROGN
                (AND (CONSP |s|) (EQ (CAR |s|) 'QUOTE)
                     (PROGN
                      (SETQ |ISTMP#1| (CDR |s|))
                      (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                           (PROGN (SETQ |y| (CAR |ISTMP#1|)) #1#)))
                     (EQUAL (PNAME |y|) |a|))
                (AND (IDENTP |s|) (EQUAL (PNAME |s|) |a|))))))
       ((ATOM |a|) (EQUAL |a| |s|))
       (#1#
        (PROGN
         (SETQ |op| (|opOf| |a|))
         (COND ((EQ |op| 'NRTEVAL) (EQUAL |s| (|nrtEval| (CADR |a|) |domain|)))
               ((EQ |op| 'QUOTE) (EQUAL |s| (CADR |a|)))
               (#1# (|lazyMatch| |s| |a| |dollar| |domain|))))))))))

; getOpCode(op,vec,max) ==
; --search Op vector for "op" returning code if found, nil otherwise
;   res := nil
;   hashCode? op =>
;     for i in 0..max by 2 repeat
;       EQL(hashString PNAME QVELT(vec, i), op) => return (res := inc_SI i)
;     res
;   for i in 0..max by 2 repeat
;     EQ(QVELT(vec, i), op) => return (res := inc_SI i)
;   res

(DEFUN |getOpCode| (|op| |vec| |max|)
  (PROG (|res|)
    (RETURN
     (PROGN
      (SETQ |res| NIL)
      (COND
       ((|hashCode?| |op|)
        (PROGN
         ((LAMBDA (|i|)
            (LOOP
             (COND ((> |i| |max|) (RETURN NIL))
                   (#1='T
                    (COND
                     ((EQL (|hashString| (PNAME (QVELT |vec| |i|))) |op|)
                      (IDENTITY (RETURN (SETQ |res| (|inc_SI| |i|))))))))
             (SETQ |i| (+ |i| 2))))
          0)
         |res|))
       (#1#
        (PROGN
         ((LAMBDA (|i|)
            (LOOP
             (COND ((> |i| |max|) (RETURN NIL))
                   (#1#
                    (COND
                     ((EQ (QVELT |vec| |i|) |op|)
                      (IDENTITY (RETURN (SETQ |res| (|inc_SI| |i|))))))))
             (SETQ |i| (+ |i| 2))))
          0)
         |res|)))))))

; hashNewLookupInTable(op,sig,dollar,[domain,opvec],flag) ==
;   opIsHasCat op =>
;       HasCategory(domain, sig)
;   if hashCode? op and EQL(op, $hashOp1) then op := 'One
;   if hashCode? op and EQL(op, $hashOp0) then op := 'Zero
;   hashPercent :=
;     VECP dollar => hashType(dollar.0,0)
;     hashType(dollar,0)
;   if hashCode? sig and EQL(sig, hashPercent) then
;          sig := hashType('(Mapping $), hashPercent)
;   dollar = nil => systemError()
;   $lookupDefaults = true =>
;       -- lookup first in my cats
;       newLookupInCategories(op, sig, domain, dollar, false)
;         or newLookupInAddChain(op, sig, domain, dollar)
;   --fast path when called from newGoGet
;   success := false
;   if $monitorNewWorld then
;     sayLooking(concat('"---->",form2String devaluate domain,
;       '"----> searching op table for:","%l","  "),op,sig,dollar)
;   someMatch := false
;   numvec := getDomainByteVector domain
;   predvec := domain.3
;   max := MAXINDEX opvec
;   k := getOpCode(op,opvec,max) or return
;     flag => newLookupInAddChain(op,sig,domain,dollar)
;     nil
;   maxIndex := MAXINDEX numvec
;   start := ELT(opvec,k)
;   finish :=
;     greater_SI(max, k) => opvec.(add_SI(k, 2))
;     maxIndex
;   if greater_SI(finish, maxIndex) then systemError '"limit too large"
;   success := nil
;   $isDefaultingPackage: local :=
;     -- use special defaulting handler when dollar non-trivial
;     dollar ~= domain and isDefaultPackageForm? devaluate domain
;   while finish > start repeat
;     PROGN
;       i := start
;       numTableArgs :=numvec.i
;       predIndex := numvec.(i := inc_SI i)
;       predIndex ~= 0 and null testBitVector(predvec, predIndex) => nil
;       exportSig :=
;           [newExpandTypeSlot(numvec.(i + j + 1),
;             dollar,domain) for j in 0..numTableArgs]
;       sig ~= hashType(['Mapping,: exportSig],hashPercent) => nil --signifies no match
;       loc := numvec.(i + numTableArgs + 2)
;       loc = 1 => (someMatch := true)
;       loc = 0 =>
;         start := add_SI(start, add_SI(numTableArgs, 4))
;         i := start + 2
;         someMatch := true --mark so that if subsumption fails, look for original
;         subsumptionSig :=
;           [newExpandTypeSlot(numvec.(add_SI(i, j)),
;             dollar,domain) for j in 0..numTableArgs]
;         if $monitorNewWorld then
;           sayBrightly [formatOpSignature(op,sig),'"--?-->",
;             formatOpSignature(op,subsumptionSig)]
;         nil
;       slot := domain.loc
;       null atom slot =>
;         EQ(QCAR slot,FUNCTION newGoGet) => someMatch:=true
;                    --treat as if operation were not there
;         return (success := slot)
;       slot = 'skip =>       --recursive call from above 'replaceGoGetSlot
;         return (success := newLookupInAddChain(op,sig,domain,dollar))
;       systemError '"unexpected format"
;     start := add_SI(start, add_SI(numTableArgs, 4))
;   success ~= 'failed and success =>
;     if $monitorNewWorld then
;         if PAIRP success then
;             sayLooking1(concat('"<----", form2String(first success)),
;                         rest success)
;         else sayLooking1('"<----XXXXX---", success)
;     success
;   subsumptionSig and (u:= basicLookup(op,subsumptionSig,domain,dollar)) => u
;   flag or someMatch => newLookupInAddChain(op,sig,domain,dollar)
;   nil

(DEFUN |hashNewLookupInTable| (|op| |sig| |dollar| |bfVar#26| |flag|)
  (PROG (|$isDefaultingPackage| |u| |slot| |subsumptionSig| |loc| |exportSig|
         |predIndex| |numTableArgs| |i| |finish| |start| |maxIndex| |k| |max|
         |predvec| |numvec| |someMatch| |success| |hashPercent| |opvec|
         |domain|)
    (DECLARE (SPECIAL |$isDefaultingPackage|))
    (RETURN
     (PROGN
      (SETQ |domain| (CAR |bfVar#26|))
      (SETQ |opvec| (CADR |bfVar#26|))
      (COND ((|opIsHasCat| |op|) (|HasCategory| |domain| |sig|))
            (#1='T
             (PROGN
              (COND
               ((AND (|hashCode?| |op|) (EQL |op| |$hashOp1|))
                (SETQ |op| '|One|)))
              (COND
               ((AND (|hashCode?| |op|) (EQL |op| |$hashOp0|))
                (SETQ |op| '|Zero|)))
              (SETQ |hashPercent|
                      (COND ((VECP |dollar|) (|hashType| (ELT |dollar| 0) 0))
                            (#1# (|hashType| |dollar| 0))))
              (COND
               ((AND (|hashCode?| |sig|) (EQL |sig| |hashPercent|))
                (SETQ |sig| (|hashType| '(|Mapping| $) |hashPercent|))))
              (COND ((NULL |dollar|) (|systemError|))
                    ((EQUAL |$lookupDefaults| T)
                     (OR
                      (|newLookupInCategories| |op| |sig| |domain| |dollar|
                       NIL)
                      (|newLookupInAddChain| |op| |sig| |domain| |dollar|)))
                    (#1#
                     (PROGN
                      (SETQ |success| NIL)
                      (COND
                       (|$monitorNewWorld|
                        (|sayLooking|
                         (|concat| "---->"
                          (|form2String| (|devaluate| |domain|))
                          "----> searching op table for:" '|%l| '|  |)
                         |op| |sig| |dollar|)))
                      (SETQ |someMatch| NIL)
                      (SETQ |numvec| (|getDomainByteVector| |domain|))
                      (SETQ |predvec| (ELT |domain| 3))
                      (SETQ |max| (MAXINDEX |opvec|))
                      (SETQ |k|
                              (OR (|getOpCode| |op| |opvec| |max|)
                                  (RETURN
                                   (COND
                                    (|flag|
                                     (|newLookupInAddChain| |op| |sig| |domain|
                                      |dollar|))
                                    (#1# NIL)))))
                      (SETQ |maxIndex| (MAXINDEX |numvec|))
                      (SETQ |start| (ELT |opvec| |k|))
                      (SETQ |finish|
                              (COND
                               ((|greater_SI| |max| |k|)
                                (ELT |opvec| (|add_SI| |k| 2)))
                               (#1# |maxIndex|)))
                      (COND
                       ((|greater_SI| |finish| |maxIndex|)
                        (|systemError| "limit too large")))
                      (SETQ |success| NIL)
                      (SETQ |$isDefaultingPackage|
                              (AND (NOT (EQUAL |dollar| |domain|))
                                   (|isDefaultPackageForm?|
                                    (|devaluate| |domain|))))
                      ((LAMBDA ()
                         (LOOP
                          (COND ((NOT (< |start| |finish|)) (RETURN NIL))
                                (#1#
                                 (PROGN
                                  (PROGN
                                   (SETQ |i| |start|)
                                   (SETQ |numTableArgs| (ELT |numvec| |i|))
                                   (SETQ |predIndex|
                                           (ELT |numvec|
                                                (SETQ |i| (|inc_SI| |i|))))
                                   (COND
                                    ((AND (NOT (EQL |predIndex| 0))
                                          (NULL
                                           (|testBitVector| |predvec|
                                            |predIndex|)))
                                     NIL)
                                    (#1#
                                     (PROGN
                                      (SETQ |exportSig|
                                              ((LAMBDA (|bfVar#24| |j|)
                                                 (LOOP
                                                  (COND
                                                   ((> |j| |numTableArgs|)
                                                    (RETURN
                                                     (NREVERSE |bfVar#24|)))
                                                   (#1#
                                                    (SETQ |bfVar#24|
                                                            (CONS
                                                             (|newExpandTypeSlot|
                                                              (ELT |numvec|
                                                                   (+
                                                                    (+ |i| |j|)
                                                                    1))
                                                              |dollar|
                                                              |domain|)
                                                             |bfVar#24|))))
                                                  (SETQ |j| (+ |j| 1))))
                                               NIL 0))
                                      (COND
                                       ((NOT
                                         (EQUAL |sig|
                                                (|hashType|
                                                 (CONS '|Mapping| |exportSig|)
                                                 |hashPercent|)))
                                        NIL)
                                       (#1#
                                        (PROGN
                                         (SETQ |loc|
                                                 (ELT |numvec|
                                                      (+ (+ |i| |numTableArgs|)
                                                         2)))
                                         (COND
                                          ((EQL |loc| 1) (SETQ |someMatch| T))
                                          ((EQL |loc| 0)
                                           (PROGN
                                            (SETQ |start|
                                                    (|add_SI| |start|
                                                     (|add_SI| |numTableArgs|
                                                      4)))
                                            (SETQ |i| (+ |start| 2))
                                            (SETQ |someMatch| T)
                                            (SETQ |subsumptionSig|
                                                    ((LAMBDA (|bfVar#25| |j|)
                                                       (LOOP
                                                        (COND
                                                         ((> |j|
                                                             |numTableArgs|)
                                                          (RETURN
                                                           (NREVERSE
                                                            |bfVar#25|)))
                                                         (#1#
                                                          (SETQ |bfVar#25|
                                                                  (CONS
                                                                   (|newExpandTypeSlot|
                                                                    (ELT
                                                                     |numvec|
                                                                     (|add_SI|
                                                                      |i| |j|))
                                                                    |dollar|
                                                                    |domain|)
                                                                   |bfVar#25|))))
                                                        (SETQ |j| (+ |j| 1))))
                                                     NIL 0))
                                            (COND
                                             (|$monitorNewWorld|
                                              (|sayBrightly|
                                               (LIST
                                                (|formatOpSignature| |op|
                                                 |sig|)
                                                "--?-->"
                                                (|formatOpSignature| |op|
                                                 |subsumptionSig|)))))
                                            NIL))
                                          (#1#
                                           (PROGN
                                            (SETQ |slot| (ELT |domain| |loc|))
                                            (COND
                                             ((NULL (ATOM |slot|))
                                              (COND
                                               ((EQ (QCAR |slot|) #'|newGoGet|)
                                                (SETQ |someMatch| T))
                                               (#1#
                                                (RETURN
                                                 (SETQ |success| |slot|)))))
                                             ((EQ |slot| '|skip|)
                                              (RETURN
                                               (SETQ |success|
                                                       (|newLookupInAddChain|
                                                        |op| |sig| |domain|
                                                        |dollar|))))
                                             (#1#
                                              (|systemError|
                                               "unexpected format")))))))))))))
                                  (SETQ |start|
                                          (|add_SI| |start|
                                           (|add_SI| |numTableArgs| 4)))))))))
                      (COND
                       ((AND (NOT (EQ |success| '|failed|)) |success|)
                        (PROGN
                         (COND
                          (|$monitorNewWorld|
                           (COND
                            ((CONSP |success|)
                             (|sayLooking1|
                              (|concat| "<----"
                               (|form2String| (CAR |success|)))
                              (CDR |success|)))
                            (#1# (|sayLooking1| "<----XXXXX---" |success|)))))
                         |success|))
                       ((AND |subsumptionSig|
                             (SETQ |u|
                                     (|basicLookup| |op| |subsumptionSig|
                                      |domain| |dollar|)))
                        |u|)
                       ((OR |flag| |someMatch|)
                        (|newLookupInAddChain| |op| |sig| |domain| |dollar|))
                       (#1# NIL))))))))))))

; replaceGoGetSlot env ==
;   [thisDomain,index,:op] := env
;   thisDomainForm := devaluate thisDomain
;   bytevec := getDomainByteVector thisDomain
;   numOfArgs := bytevec.index
;   goGetDomainSlotIndex := bytevec.(index := inc_SI index)
;   goGetDomain :=
;      goGetDomainSlotIndex = 0 => thisDomain
;      thisDomain.goGetDomainSlotIndex
;   if PAIRP goGetDomain and SYMBOLP first goGetDomain then
;      goGetDomain := lazyDomainSet(goGetDomain,thisDomain,goGetDomainSlotIndex)
;   sig :=
;     [newExpandTypeSlot(bytevec.(index := inc_SI index), thisDomain, thisDomain)
;       for i in 0..numOfArgs]
;   thisSlot := bytevec.(inc_SI index)
;   if $monitorNewWorld then
;     sayLooking(concat('"%l","..",form2String thisDomainForm,
;       '" wants",'"%l",'"  "),op,sig,goGetDomain)
;   slot :=  basicLookup(op,sig,goGetDomain,goGetDomain)
;   slot = nil =>
;     $returnNowhereFromGoGet = true =>
;       ['nowhere,:goGetDomain]  --see newGetDomainOpTable
;     sayBrightly concat('"Function: ",formatOpSignature(op,sig),
;       '" is missing from domain: ",form2String goGetDomain.0)
;     keyedSystemError("S2NR0001",[op,sig,goGetDomain.0])
;   if $monitorNewWorld then
;     sayLooking1(['"goget stuffing slot",:bright thisSlot,'"of "],thisDomain)
;   SETELT(thisDomain,thisSlot,slot)
;   if $monitorNewWorld then
;     sayLooking1(concat('"<------", form2String(first slot)), rest slot)
;   slot

(DEFUN |replaceGoGetSlot| (|env|)
  (PROG (|thisDomain| |index| |op| |thisDomainForm| |bytevec| |numOfArgs|
         |goGetDomainSlotIndex| |goGetDomain| |sig| |thisSlot| |slot|)
    (RETURN
     (PROGN
      (SETQ |thisDomain| (CAR |env|))
      (SETQ |index| (CADR . #1=(|env|)))
      (SETQ |op| (CDDR . #1#))
      (SETQ |thisDomainForm| (|devaluate| |thisDomain|))
      (SETQ |bytevec| (|getDomainByteVector| |thisDomain|))
      (SETQ |numOfArgs| (ELT |bytevec| |index|))
      (SETQ |goGetDomainSlotIndex|
              (ELT |bytevec| (SETQ |index| (|inc_SI| |index|))))
      (SETQ |goGetDomain|
              (COND ((EQL |goGetDomainSlotIndex| 0) |thisDomain|)
                    (#2='T (ELT |thisDomain| |goGetDomainSlotIndex|))))
      (COND
       ((AND (CONSP |goGetDomain|) (SYMBOLP (CAR |goGetDomain|)))
        (SETQ |goGetDomain|
                (|lazyDomainSet| |goGetDomain| |thisDomain|
                 |goGetDomainSlotIndex|))))
      (SETQ |sig|
              ((LAMBDA (|bfVar#27| |i|)
                 (LOOP
                  (COND ((> |i| |numOfArgs|) (RETURN (NREVERSE |bfVar#27|)))
                        (#2#
                         (SETQ |bfVar#27|
                                 (CONS
                                  (|newExpandTypeSlot|
                                   (ELT |bytevec|
                                        (SETQ |index| (|inc_SI| |index|)))
                                   |thisDomain| |thisDomain|)
                                  |bfVar#27|))))
                  (SETQ |i| (+ |i| 1))))
               NIL 0))
      (SETQ |thisSlot| (ELT |bytevec| (|inc_SI| |index|)))
      (COND
       (|$monitorNewWorld|
        (|sayLooking|
         (|concat| "%l" '|..| (|form2String| |thisDomainForm|) " wants" "%l"
          "  ")
         |op| |sig| |goGetDomain|)))
      (SETQ |slot| (|basicLookup| |op| |sig| |goGetDomain| |goGetDomain|))
      (COND
       ((NULL |slot|)
        (COND
         ((EQUAL |$returnNowhereFromGoGet| T) (CONS '|nowhere| |goGetDomain|))
         (#2#
          (PROGN
           (|sayBrightly|
            (|concat| "Function: " (|formatOpSignature| |op| |sig|)
             " is missing from domain: "
             (|form2String| (ELT |goGetDomain| 0))))
           (|keyedSystemError| 'S2NR0001
            (LIST |op| |sig| (ELT |goGetDomain| 0)))))))
       (#2#
        (PROGN
         (COND
          (|$monitorNewWorld|
           (|sayLooking1|
            (CONS "goget stuffing slot"
                  (APPEND (|bright| |thisSlot|) (CONS "of " NIL)))
            |thisDomain|)))
         (SETELT |thisDomain| |thisSlot| |slot|)
         (COND
          (|$monitorNewWorld|
           (|sayLooking1| (|concat| "<------" (|form2String| (CAR |slot|)))
            (CDR |slot|))))
         |slot|)))))))

; newHasCategory(domain,catform) ==
;   catform = '(Type) => true
;   slot4 := domain.4
;   auxvec := first slot4
;   catvec := CADR slot4
;   $isDefaultingPackage: local := isDefaultPackageForm? devaluate domain
;   #catvec > 0 and INTEGERP IFCDR catvec.0 =>              --old style
;     BREAK()
;   lazyMatchAssocV(catform,auxvec,catvec,domain)         --new style

(DEFUN |newHasCategory| (|domain| |catform|)
  (PROG (|$isDefaultingPackage| |catvec| |auxvec| |slot4|)
    (DECLARE (SPECIAL |$isDefaultingPackage|))
    (RETURN
     (COND ((EQUAL |catform| '(|Type|)) T)
           (#1='T
            (PROGN
             (SETQ |slot4| (ELT |domain| 4))
             (SETQ |auxvec| (CAR |slot4|))
             (SETQ |catvec| (CADR |slot4|))
             (SETQ |$isDefaultingPackage|
                     (|isDefaultPackageForm?| (|devaluate| |domain|)))
             (COND
              ((AND (< 0 (LENGTH |catvec|))
                    (INTEGERP (IFCDR (ELT |catvec| 0))))
               (BREAK))
              (#1#
               (|lazyMatchAssocV| |catform| |auxvec| |catvec| |domain|)))))))))

; lazyMatchAssocV(x,auxvec,catvec,domain) ==      --new style slot4
;   -- Does not work (triggers type error due to initialization by NIL)
;   -- n : FIXNUM := MAXINDEX catvec
;   n := MAXINDEX catvec
;   -- following call to hashType was missing 2nd arg. 0 added on 3/31/94 by RSS
;   hashCode? x =>
;     percentHash :=
;       VECP domain => hashType(domain.0, 0)
;       getDomainHash domain
;     or/[ELT(auxvec,i) for i in 0..n |
;         x = hashType(newExpandLocalType(QVELT(catvec,i),domain,domain), percentHash)]
;   xop := first x
;   or/[ELT(auxvec,i) for i in 0..n |
;     --xop = first (lazyt := QVELT(catvec,i)) and lazyMatch(x,lazyt,domain,domain)]
;     xop = first (lazyt := getCatForm(catvec, i, domain)) and
;              lazyMatch(x, lazyt, domain, domain)]

(DEFUN |lazyMatchAssocV| (|x| |auxvec| |catvec| |domain|)
  (PROG (|n| |percentHash| |xop| |lazyt|)
    (RETURN
     (PROGN
      (SETQ |n| (MAXINDEX |catvec|))
      (COND
       ((|hashCode?| |x|)
        (PROGN
         (SETQ |percentHash|
                 (COND ((VECP |domain|) (|hashType| (ELT |domain| 0) 0))
                       (#1='T (|getDomainHash| |domain|))))
         ((LAMBDA (|bfVar#28| |i|)
            (LOOP
             (COND ((> |i| |n|) (RETURN |bfVar#28|))
                   (#1#
                    (AND
                     (EQUAL |x|
                            (|hashType|
                             (|newExpandLocalType| (QVELT |catvec| |i|)
                              |domain| |domain|)
                             |percentHash|))
                     (PROGN
                      (SETQ |bfVar#28| (ELT |auxvec| |i|))
                      (COND (|bfVar#28| (RETURN |bfVar#28|)))))))
             (SETQ |i| (+ |i| 1))))
          NIL 0)))
       (#1#
        (PROGN
         (SETQ |xop| (CAR |x|))
         ((LAMBDA (|bfVar#29| |i|)
            (LOOP
             (COND ((> |i| |n|) (RETURN |bfVar#29|))
                   (#1#
                    (AND
                     (EQUAL |xop|
                            (CAR
                             (SETQ |lazyt|
                                     (|getCatForm| |catvec| |i| |domain|))))
                     (|lazyMatch| |x| |lazyt| |domain| |domain|)
                     (PROGN
                      (SETQ |bfVar#29| (ELT |auxvec| |i|))
                      (COND (|bfVar#29| (RETURN |bfVar#29|)))))))
             (SETQ |i| (+ |i| 1))))
          NIL 0))))))))

; getCatForm(catvec, index, domain) ==
;    NUMBERP(form := QVELT(catvec,index)) => domain.form
;    form

(DEFUN |getCatForm| (|catvec| |index| |domain|)
  (PROG (|form|)
    (RETURN
     (COND
      ((NUMBERP (SETQ |form| (QVELT |catvec| |index|))) (ELT |domain| |form|))
      ('T |form|)))))

; has(domain,catform') == HasCategory(domain,catform')

(DEFUN |has| (|domain| |catform'|)
  (PROG () (RETURN (|HasCategory| |domain| |catform'|))))

; HasCategory(domain,catform') ==
;   catform' is ['SIGNATURE,:f] => HasSignature(domain,f)
;   catform' is ['ATTRIBUTE,f] =>
;       BREAK()
;   isDomain domain =>
;      FIXP((first domain).0) =>
;         catform' := devaluate catform'
;         basicLookup("%%",catform',domain,domain)
;      HasCategory(CDDR domain, catform')
;   catform:= devaluate catform'
;   isNewWorldDomain domain => newHasCategory(domain,catform)
;   -- FIXME: handle strings, for example "failed"
;   domain0:=domain.0 -- handles old style domains, Record, Union etc.
;   slot4 := domain.4
;   catlist := slot4.1
;   member(catform,catlist) or
;    opOf(catform) = "Type" or  --temporary hack
;     or/[compareSigEqual(catform,cat,domain0,domain) for cat in catlist]

(DEFUN |HasCategory| (|domain| |catform'|)
  (PROG (|f| |ISTMP#1| |catform| |domain0| |slot4| |catlist|)
    (RETURN
     (COND
      ((AND (CONSP |catform'|) (EQ (CAR |catform'|) 'SIGNATURE)
            (PROGN (SETQ |f| (CDR |catform'|)) #1='T))
       (|HasSignature| |domain| |f|))
      ((AND (CONSP |catform'|) (EQ (CAR |catform'|) 'ATTRIBUTE)
            (PROGN
             (SETQ |ISTMP#1| (CDR |catform'|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |f| (CAR |ISTMP#1|)) #1#))))
       (BREAK))
      ((|isDomain| |domain|)
       (COND
        ((FIXP (ELT (CAR |domain|) 0))
         (PROGN
          (SETQ |catform'| (|devaluate| |catform'|))
          (|basicLookup| '%% |catform'| |domain| |domain|)))
        (#1# (|HasCategory| (CDDR |domain|) |catform'|))))
      (#1#
       (PROGN
        (SETQ |catform| (|devaluate| |catform'|))
        (COND
         ((|isNewWorldDomain| |domain|) (|newHasCategory| |domain| |catform|))
         (#1#
          (PROGN
           (SETQ |domain0| (ELT |domain| 0))
           (SETQ |slot4| (ELT |domain| 4))
           (SETQ |catlist| (ELT |slot4| 1))
           (OR (|member| |catform| |catlist|) (EQ (|opOf| |catform|) '|Type|)
               ((LAMBDA (|bfVar#31| |bfVar#30| |cat|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#30|)
                         (PROGN (SETQ |cat| (CAR |bfVar#30|)) NIL))
                     (RETURN |bfVar#31|))
                    (#1#
                     (PROGN
                      (SETQ |bfVar#31|
                              (|compareSigEqual| |catform| |cat| |domain0|
                               |domain|))
                      (COND (|bfVar#31| (RETURN |bfVar#31|))))))
                   (SETQ |bfVar#30| (CDR |bfVar#30|))))
                NIL |catlist| NIL)))))))))))

; lazyDomainSet(form, thisDomain, slot) ==
;   slotDomain := evalSlotDomain(form,thisDomain)
;   if $monitorNewWorld then
;     sayLooking1(concat(form2String devaluate thisDomain,
;       '" activating lazy slot ",slot,'": "),slotDomain)
; -- name := first form
; --getInfovec name
;   SETELT(thisDomain,slot,slotDomain)

(DEFUN |lazyDomainSet| (|form| |thisDomain| |slot|)
  (PROG (|slotDomain|)
    (RETURN
     (PROGN
      (SETQ |slotDomain| (|evalSlotDomain| |form| |thisDomain|))
      (COND
       (|$monitorNewWorld|
        (|sayLooking1|
         (|concat| (|form2String| (|devaluate| |thisDomain|))
          " activating lazy slot " |slot| ": ")
         |slotDomain|)))
      (SETELT |thisDomain| |slot| |slotDomain|)))))

; evalSlotDomain(u,dollar) ==
;   $returnNowhereFromGoGet: local := false
;   $ : fluid := dollar
;   $lookupDefaults : local := nil -- new world
;   isDomain u => u
;   u = '$ => dollar
;   u = "$$" => dollar
;   FIXP u =>
;     VECP (y := dollar.u) => y
;     isDomain y => y
;     y is ['SETELT,:.] => eval y--lazy domains need to marked; this is dangerous?
;     y is [v,:.] =>
;       VECP v => BREAK()
;       constructor? v or MEMQ(v,'(Record Union Mapping)) =>
;         lazyDomainSet(y,dollar,u)                       --new style has lazyt
;       v = 'QUOTE => first(rest(y))
;       y
;     y
;   u is ['NRTEVAL, y] => eval  y
;   u is ['QUOTE,y] => y
;   u is ['Record,:argl] =>
;      FUNCALL('Record0,[[tag,:evalSlotDomain(dom,dollar)]
;                                  for [.,tag,dom] in argl])
;   u is ['Union,:argl] and first argl is ['_:,.,.] =>
;      APPLY('Union,[['_:,tag,evalSlotDomain(dom,dollar)]
;                                  for [.,tag,dom] in argl])
;   u is ['spadConstant,d,n] =>
;     dom := evalSlotDomain(d,dollar)
;     SPADCALL(dom . n)
;   u is ['ELT,d,n] =>
;     dom := evalSlotDomain(d,dollar)
;     slot := dom . n
;     slot is [=FUNCTION newGoGet,:env] =>
;         replaceGoGetSlot env
;     slot
;   u is [op,:argl] => APPLY(op,[evalSlotDomain(x,dollar) for x in argl])
;   systemErrorHere '"evalSlotDomain"

(DEFUN |evalSlotDomain| (|u| |dollar|)
  (PROG (|$lookupDefaults| $ |$returnNowhereFromGoGet| |op| |env| |slot| |n|
         |d| |ISTMP#3| |dom| |ISTMP#2| |tag| |argl| |ISTMP#1| |v| |y|)
    (DECLARE (SPECIAL |$lookupDefaults| $ |$returnNowhereFromGoGet|))
    (RETURN
     (PROGN
      (SETQ |$returnNowhereFromGoGet| NIL)
      (SETQ $ |dollar|)
      (SETQ |$lookupDefaults| NIL)
      (COND ((|isDomain| |u|) |u|) ((EQ |u| '$) |dollar|)
            ((EQ |u| '$$) |dollar|)
            ((FIXP |u|)
             (COND ((VECP (SETQ |y| (ELT |dollar| |u|))) |y|)
                   ((|isDomain| |y|) |y|)
                   ((AND (CONSP |y|) (EQ (CAR |y|) 'SETELT)) (|eval| |y|))
                   ((AND (CONSP |y|) (PROGN (SETQ |v| (CAR |y|)) #1='T))
                    (COND ((VECP |v|) (BREAK))
                          ((OR (|constructor?| |v|)
                               (MEMQ |v| '(|Record| |Union| |Mapping|)))
                           (|lazyDomainSet| |y| |dollar| |u|))
                          ((EQ |v| 'QUOTE) (CAR (CDR |y|))) (#1# |y|)))
                   (#1# |y|)))
            ((AND (CONSP |u|) (EQ (CAR |u|) 'NRTEVAL)
                  (PROGN
                   (SETQ |ISTMP#1| (CDR |u|))
                   (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                        (PROGN (SETQ |y| (CAR |ISTMP#1|)) #1#))))
             (|eval| |y|))
            ((AND (CONSP |u|) (EQ (CAR |u|) 'QUOTE)
                  (PROGN
                   (SETQ |ISTMP#1| (CDR |u|))
                   (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                        (PROGN (SETQ |y| (CAR |ISTMP#1|)) #1#))))
             |y|)
            ((AND (CONSP |u|) (EQ (CAR |u|) '|Record|)
                  (PROGN (SETQ |argl| (CDR |u|)) #1#))
             (FUNCALL '|Record0|
                      ((LAMBDA (|bfVar#34| |bfVar#33| |bfVar#32|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#33|)
                                (PROGN (SETQ |bfVar#32| (CAR |bfVar#33|)) NIL))
                            (RETURN (NREVERSE |bfVar#34|)))
                           (#1#
                            (AND (CONSP |bfVar#32|)
                                 (PROGN
                                  (SETQ |ISTMP#1| (CDR |bfVar#32|))
                                  (AND (CONSP |ISTMP#1|)
                                       (PROGN
                                        (SETQ |tag| (CAR |ISTMP#1|))
                                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                        (AND (CONSP |ISTMP#2|)
                                             (EQ (CDR |ISTMP#2|) NIL)
                                             (PROGN
                                              (SETQ |dom| (CAR |ISTMP#2|))
                                              #1#)))))
                                 (SETQ |bfVar#34|
                                         (CONS
                                          (CONS |tag|
                                                (|evalSlotDomain| |dom|
                                                 |dollar|))
                                          |bfVar#34|)))))
                          (SETQ |bfVar#33| (CDR |bfVar#33|))))
                       NIL |argl| NIL)))
            ((AND (CONSP |u|) (EQ (CAR |u|) '|Union|)
                  (PROGN (SETQ |argl| (CDR |u|)) #1#)
                  (PROGN
                   (SETQ |ISTMP#1| (CAR |argl|))
                   (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|:|)
                        (PROGN
                         (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                         (AND (CONSP |ISTMP#2|)
                              (PROGN
                               (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                               (AND (CONSP |ISTMP#3|)
                                    (EQ (CDR |ISTMP#3|) NIL))))))))
             (APPLY '|Union|
                    ((LAMBDA (|bfVar#37| |bfVar#36| |bfVar#35|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#36|)
                              (PROGN (SETQ |bfVar#35| (CAR |bfVar#36|)) NIL))
                          (RETURN (NREVERSE |bfVar#37|)))
                         (#1#
                          (AND (CONSP |bfVar#35|)
                               (PROGN
                                (SETQ |ISTMP#1| (CDR |bfVar#35|))
                                (AND (CONSP |ISTMP#1|)
                                     (PROGN
                                      (SETQ |tag| (CAR |ISTMP#1|))
                                      (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                      (AND (CONSP |ISTMP#2|)
                                           (EQ (CDR |ISTMP#2|) NIL)
                                           (PROGN
                                            (SETQ |dom| (CAR |ISTMP#2|))
                                            #1#)))))
                               (SETQ |bfVar#37|
                                       (CONS
                                        (LIST '|:| |tag|
                                              (|evalSlotDomain| |dom|
                                               |dollar|))
                                        |bfVar#37|)))))
                        (SETQ |bfVar#36| (CDR |bfVar#36|))))
                     NIL |argl| NIL)))
            ((AND (CONSP |u|) (EQ (CAR |u|) '|spadConstant|)
                  (PROGN
                   (SETQ |ISTMP#1| (CDR |u|))
                   (AND (CONSP |ISTMP#1|)
                        (PROGN
                         (SETQ |d| (CAR |ISTMP#1|))
                         (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                         (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                              (PROGN (SETQ |n| (CAR |ISTMP#2|)) #1#))))))
             (PROGN
              (SETQ |dom| (|evalSlotDomain| |d| |dollar|))
              (SPADCALL (ELT |dom| |n|))))
            ((AND (CONSP |u|) (EQ (CAR |u|) 'ELT)
                  (PROGN
                   (SETQ |ISTMP#1| (CDR |u|))
                   (AND (CONSP |ISTMP#1|)
                        (PROGN
                         (SETQ |d| (CAR |ISTMP#1|))
                         (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                         (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                              (PROGN (SETQ |n| (CAR |ISTMP#2|)) #1#))))))
             (PROGN
              (SETQ |dom| (|evalSlotDomain| |d| |dollar|))
              (SETQ |slot| (ELT |dom| |n|))
              (COND
               ((AND (CONSP |slot|) (EQUAL (CAR |slot|) #'|newGoGet|)
                     (PROGN (SETQ |env| (CDR |slot|)) #1#))
                (|replaceGoGetSlot| |env|))
               (#1# |slot|))))
            ((AND (CONSP |u|)
                  (PROGN (SETQ |op| (CAR |u|)) (SETQ |argl| (CDR |u|)) #1#))
             (APPLY |op|
                    ((LAMBDA (|bfVar#39| |bfVar#38| |x|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#38|)
                              (PROGN (SETQ |x| (CAR |bfVar#38|)) NIL))
                          (RETURN (NREVERSE |bfVar#39|)))
                         (#1#
                          (SETQ |bfVar#39|
                                  (CONS (|evalSlotDomain| |x| |dollar|)
                                        |bfVar#39|))))
                        (SETQ |bfVar#38| (CDR |bfVar#38|))))
                     NIL |argl| NIL)))
            (#1# (|systemErrorHere| "evalSlotDomain")))))))

; domainEqual(a,b) ==
;   devaluate(a) = devaluate(b)

(DEFUN |domainEqual| (|a| |b|)
  (PROG () (RETURN (EQUAL (|devaluate| |a|) (|devaluate| |b|)))))

; getFunctionFromDomain1(op, dc, target, args) ==
;   -- finds the function op with argument types args in dc
;   -- complains, if no function or ambiguous
;   $reportBottomUpFlag:local:= NIL
;   member(first dc, $nonLisplibDomains) =>
;       throwKeyedMsg("S2IF0002", [first dc])
;   not constructor? first dc =>
;       throwKeyedMsg("S2IF0003", [first dc])
;   p:= findFunctionInDomain(op, dc, target, args, args, NIL, NIL) =>
; --+
;     --sig := [NIL,:args]
;     domain := evalDomain dc
;     for mm in nreverse p until b repeat
;       [[.,:osig],nsig,:.] := mm
;       b := compiledLookup(op,nsig,domain)
;     b or  throwKeyedMsg("S2IS0023",[op,dc])
;   throwKeyedMsg("S2IF0004",[op,dc])

(DEFUN |getFunctionFromDomain1| (|op| |dc| |target| |args|)
  (PROG (|$reportBottomUpFlag| |b| |nsig| |osig| |domain| |p|)
    (DECLARE (SPECIAL |$reportBottomUpFlag|))
    (RETURN
     (PROGN
      (SETQ |$reportBottomUpFlag| NIL)
      (COND
       ((|member| (CAR |dc|) |$nonLisplibDomains|)
        (|throwKeyedMsg| 'S2IF0002 (LIST (CAR |dc|))))
       ((NULL (|constructor?| (CAR |dc|)))
        (|throwKeyedMsg| 'S2IF0003 (LIST (CAR |dc|))))
       ((SETQ |p|
                (|findFunctionInDomain| |op| |dc| |target| |args| |args| NIL
                 NIL))
        (PROGN
         (SETQ |domain| (|evalDomain| |dc|))
         ((LAMBDA (|bfVar#40| |mm| |bfVar#41|)
            (LOOP
             (COND
              ((OR (ATOM |bfVar#40|) (PROGN (SETQ |mm| (CAR |bfVar#40|)) NIL)
                   |bfVar#41|)
               (RETURN NIL))
              (#1='T
               (PROGN
                (SETQ |osig| (CDAR |mm|))
                (SETQ |nsig| (CADR |mm|))
                (SETQ |b| (|compiledLookup| |op| |nsig| |domain|)))))
             (SETQ |bfVar#40| (CDR |bfVar#40|))
             (SETQ |bfVar#41| |b|)))
          (NREVERSE |p|) NIL NIL)
         (OR |b| (|throwKeyedMsg| 'S2IS0023 (LIST |op| |dc|)))))
       (#1# (|throwKeyedMsg| 'S2IF0004 (LIST |op| |dc|))))))))

; getFunctionFromDomain(op, dc, args) ==
;     getFunctionFromDomain1(op, dc, NIL, args)

(DEFUN |getFunctionFromDomain| (|op| |dc| |args|)
  (PROG () (RETURN (|getFunctionFromDomain1| |op| |dc| NIL |args|))))

; devaluateDeeply x ==
;     VECP x => devaluate x
;     atom x => x
;     [devaluateDeeply y for y in x]

(DEFUN |devaluateDeeply| (|x|)
  (PROG ()
    (RETURN
     (COND ((VECP |x|) (|devaluate| |x|)) ((ATOM |x|) |x|)
           (#1='T
            ((LAMBDA (|bfVar#43| |bfVar#42| |y|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#42|)
                      (PROGN (SETQ |y| (CAR |bfVar#42|)) NIL))
                  (RETURN (NREVERSE |bfVar#43|)))
                 (#1#
                  (SETQ |bfVar#43| (CONS (|devaluateDeeply| |y|) |bfVar#43|))))
                (SETQ |bfVar#42| (CDR |bfVar#42|))))
             NIL |x| NIL))))))

; lookupDisplay(op,sig,vectorOrForm,suffix) ==
;     null $NRTmonitorIfTrue => nil
;     prefix := (suffix = '"" => ">"; "<")
;     sayBrightly
;         concat(prefix,formatOpSignature(op,sig),
;             '" from ", prefix2String devaluateDeeply vectorOrForm,suffix)

(DEFUN |lookupDisplay| (|op| |sig| |vectorOrForm| |suffix|)
  (PROG (|prefix|)
    (RETURN
     (COND ((NULL |$NRTmonitorIfTrue|) NIL)
           (#1='T
            (PROGN
             (SETQ |prefix| (COND ((EQUAL |suffix| "") '>) (#1# '<)))
             (|sayBrightly|
              (|concat| |prefix| (|formatOpSignature| |op| |sig|) " from "
               (|prefix2String| (|devaluateDeeply| |vectorOrForm|))
               |suffix|))))))))

; isCategoryPackageName nam ==
;     p := PNAME opOf nam
;     p.(MAXINDEX p) = char '_&

(DEFUN |isCategoryPackageName| (|nam|)
  (PROG (|p|)
    (RETURN
     (PROGN
      (SETQ |p| (PNAME (|opOf| |nam|)))
      (EQUAL (ELT |p| (MAXINDEX |p|)) (|char| '&))))))
