
; )package "BOOT"

(IN-PACKAGE "BOOT")

; lefts u ==
;    [x for x in HKEYS  $has_category_hash | rest x = u]

(DEFUN |lefts| (|u|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#2| |bfVar#1| |x|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#1|) (PROGN (SETQ |x| (CAR |bfVar#1|)) NIL))
           (RETURN (NREVERSE |bfVar#2|)))
          ('T
           (AND (EQUAL (CDR |x|) |u|) (SETQ |bfVar#2| (CONS |x| |bfVar#2|)))))
         (SETQ |bfVar#1| (CDR |bfVar#1|))))
      NIL (HKEYS |$has_category_hash|) NIL))))

; buildLibdb(domainList) ==  --called by make-databases (daase.lisp)
;   $OpLst: local := nil
;   $AttrLst: local := nil
;   $DomLst : local := nil
;   $CatLst : local := nil
;   $PakLst : local := nil
;   $DefLst : local := nil
;   $outStream : local := MAKE_OUTSTREAM('"temp.text")
;   --build local libdb if list of domains is given
;   if null domainList then
;     comments :=
;       '"\spad{Union(A,B,...,C)} is a primitive type in FriCAS used to represent objects of type \spad{A} or of type \spad{B} or...or of type \spad{C}."
;     writedb
;       buildLibdbString ['"dUnion",1,'"x",'"special",'"(A,B,...,C)",'UNION,comments]
;     comments :=
;       '"\spad{Record(a:A,b:B,...,c:C)} is a primitive type in FriCAS used to represent composite objects made up of objects of type \spad{A}, \spad{B},..., \spad{C} which are indexed by _"keys_" (identifiers) \spad{a},\spad{b},...,\spad{c}."
;     writedb
;       buildLibdbString ['"dRecord",1,'"x",'"special",'"(a:A,b:B,...,c:C)",'RECORD,comments]
;     comments :=
;       '"\spad{Mapping(T,S)} is a primitive type in FriCAS used to represent mappings from source type \spad{S} to target type \spad{T}. Similarly, \spad{Mapping(T,A,B)} denotes a mapping from source type \spad{(A,B)} to target type \spad{T}."
;     writedb
;       buildLibdbString ['"dMapping",1,'"x",'"special",'"(T,S)",'MAPPING,comments]
;     comments :=
;       '"\spad{Enumeration(a,b,...,c)} is a primitive type in FriCAS used to represent the object composed of the symbols \spad{a},\spad{b},..., and \spad{c}."
;     writedb
;       buildLibdbString ['"dEnumeration",1,'"x",'"special",'"(a,b,...,c)",'ENUM,comments]
;   $conname: local := nil
;   $conform: local := nil
;   $exposed?:local := nil
;   $doc:     local := nil
;   $kind:    local := nil
;   constructorList := domainList or allConstructors()
;   for con in constructorList repeat
;     writedb buildLibdbConEntry con
;     [., :oplist] := getConstructorExports($conform, false)
;     buildLibOps oplist
;   SHUT $outStream
;   domainList => 'done         --leave new database in temp.text
;   -- FIXME: This is confusing: result is in olibdb.text,
;   -- but this is expected by save_browser_data
;   OBEY '"sort  _"temp.text_"  > _"libdb.text_""
;   RENAME_-FILE('"libdb.text", '"olibdb.text")
;   deleteFile '"temp.text"

(DEFUN |buildLibdb| (|domainList|)
  (PROG (|$kind| |$doc| |$exposed?| |$conform| |$conname| |$outStream|
         |$DefLst| |$PakLst| |$CatLst| |$DomLst| |$AttrLst| |$OpLst| |oplist|
         |LETTMP#1| |constructorList| |comments|)
    (DECLARE
     (SPECIAL |$kind| |$doc| |$exposed?| |$conform| |$conname| |$outStream|
      |$DefLst| |$PakLst| |$CatLst| |$DomLst| |$AttrLst| |$OpLst|))
    (RETURN
     (PROGN
      (SETQ |$OpLst| NIL)
      (SETQ |$AttrLst| NIL)
      (SETQ |$DomLst| NIL)
      (SETQ |$CatLst| NIL)
      (SETQ |$PakLst| NIL)
      (SETQ |$DefLst| NIL)
      (SETQ |$outStream| (MAKE_OUTSTREAM "temp.text"))
      (COND
       ((NULL |domainList|)
        (SETQ |comments|
                "\\spad{Union(A,B,...,C)} is a primitive type in FriCAS used to represent objects of type \\spad{A} or of type \\spad{B} or...or of type \\spad{C}.")
        (|writedb|
         (|buildLibdbString|
          (LIST "dUnion" 1 "x" "special" "(A,B,...,C)" 'UNION |comments|)))
        (SETQ |comments|
                "\\spad{Record(a:A,b:B,...,c:C)} is a primitive type in FriCAS used to represent composite objects made up of objects of type \\spad{A}, \\spad{B},..., \\spad{C} which are indexed by \"keys\" (identifiers) \\spad{a},\\spad{b},...,\\spad{c}.")
        (|writedb|
         (|buildLibdbString|
          (LIST "dRecord" 1 "x" "special" "(a:A,b:B,...,c:C)" 'RECORD
                |comments|)))
        (SETQ |comments|
                "\\spad{Mapping(T,S)} is a primitive type in FriCAS used to represent mappings from source type \\spad{S} to target type \\spad{T}. Similarly, \\spad{Mapping(T,A,B)} denotes a mapping from source type \\spad{(A,B)} to target type \\spad{T}.")
        (|writedb|
         (|buildLibdbString|
          (LIST "dMapping" 1 "x" "special" "(T,S)" 'MAPPING |comments|)))
        (SETQ |comments|
                "\\spad{Enumeration(a,b,...,c)} is a primitive type in FriCAS used to represent the object composed of the symbols \\spad{a},\\spad{b},..., and \\spad{c}.")
        (|writedb|
         (|buildLibdbString|
          (LIST "dEnumeration" 1 "x" "special" "(a,b,...,c)" 'ENUM
                |comments|)))))
      (SETQ |$conname| NIL)
      (SETQ |$conform| NIL)
      (SETQ |$exposed?| NIL)
      (SETQ |$doc| NIL)
      (SETQ |$kind| NIL)
      (SETQ |constructorList| (OR |domainList| (|allConstructors|)))
      ((LAMBDA (|bfVar#3| |con|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#3|) (PROGN (SETQ |con| (CAR |bfVar#3|)) NIL))
            (RETURN NIL))
           (#1='T
            (PROGN
             (|writedb| (|buildLibdbConEntry| |con|))
             (SETQ |LETTMP#1| (|getConstructorExports| |$conform| NIL))
             (SETQ |oplist| (CDR |LETTMP#1|))
             (|buildLibOps| |oplist|))))
          (SETQ |bfVar#3| (CDR |bfVar#3|))))
       |constructorList| NIL)
      (SHUT |$outStream|)
      (COND (|domainList| '|done|)
            (#1#
             (PROGN
              (OBEY "sort  \"temp.text\"  > \"libdb.text\"")
              (RENAME-FILE "libdb.text" "olibdb.text")
              (|deleteFile| "temp.text"))))))))

; buildLibdbConEntry conname ==
;     NULL GETDATABASE(conname, 'CONSTRUCTORMODEMAP) => nil
;     abb:=GETDATABASE(conname,'ABBREVIATION)
;     $conname := conname
;     conform := GETDATABASE(conname,'CONSTRUCTORFORM) or [conname] --hack for Category,..
;     $conform := dbMkForm SUBST('T,"T$",conform)
;     null $conform => nil
;     $exposed? := (isExposedConstructor conname => '"x"; '"n")
;     $doc      := GETDATABASE(conname, 'DOCUMENTATION)
;     pname := PNAME conname
;     kind  := GETDATABASE(conname,'CONSTRUCTORKIND)
;     if kind = 'domain
;       and GETDATABASE(conname,'CONSTRUCTORMODEMAP) is [[.,t,:.],:.]
;        and t is ['CATEGORY,'package,:.] then kind := 'package
;     $kind :=
;       pname.(MAXINDEX pname) = char '_& => 'x
;       DOWNCASE (PNAME kind).0
;     argl := rest $conform
;     conComments :=
;       LASSOC('constructor,$doc) is [[=nil,:r]] => libdbTrim concatWithBlanks r
;       '""
;     argpart:= SUBSTRING(form2HtString ['f,:argl],1,nil)
;     sigpart:= libConstructorSig $conform
;     header := STRCONC($kind,PNAME conname)
;     buildLibdbString [header,#argl,$exposed?,sigpart,argpart,abb,conComments]

(DEFUN |buildLibdbConEntry| (|conname|)
  (PROG (|abb| |conform| |pname| |kind| |ISTMP#1| |ISTMP#2| |ISTMP#3| |t|
         |argl| |r| |conComments| |argpart| |sigpart| |header|)
    (RETURN
     (COND ((NULL (GETDATABASE |conname| 'CONSTRUCTORMODEMAP)) NIL)
           (#1='T
            (PROGN
             (SETQ |abb| (GETDATABASE |conname| 'ABBREVIATION))
             (SETQ |$conname| |conname|)
             (SETQ |conform|
                     (OR (GETDATABASE |conname| 'CONSTRUCTORFORM)
                         (LIST |conname|)))
             (SETQ |$conform| (|dbMkForm| (SUBST 'T 'T$ |conform|)))
             (COND ((NULL |$conform|) NIL)
                   (#1#
                    (PROGN
                     (SETQ |$exposed?|
                             (COND ((|isExposedConstructor| |conname|) "x")
                                   (#1# "n")))
                     (SETQ |$doc| (GETDATABASE |conname| 'DOCUMENTATION))
                     (SETQ |pname| (PNAME |conname|))
                     (SETQ |kind| (GETDATABASE |conname| 'CONSTRUCTORKIND))
                     (COND
                      ((AND (EQ |kind| '|domain|)
                            (PROGN
                             (SETQ |ISTMP#1|
                                     (GETDATABASE |conname|
                                      'CONSTRUCTORMODEMAP))
                             (AND (CONSP |ISTMP#1|)
                                  (PROGN
                                   (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                                   (AND (CONSP |ISTMP#2|)
                                        (PROGN
                                         (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                                         (AND (CONSP |ISTMP#3|)
                                              (PROGN
                                               (SETQ |t| (CAR |ISTMP#3|))
                                               #1#)))))))
                            (CONSP |t|) (EQ (CAR |t|) 'CATEGORY)
                            (PROGN
                             (SETQ |ISTMP#1| (CDR |t|))
                             (AND (CONSP |ISTMP#1|)
                                  (EQ (CAR |ISTMP#1|) '|package|))))
                       (SETQ |kind| '|package|)))
                     (SETQ |$kind|
                             (COND
                              ((EQUAL (ELT |pname| (MAXINDEX |pname|))
                                      (|char| '&))
                               '|x|)
                              (#1# (DOWNCASE (ELT (PNAME |kind|) 0)))))
                     (SETQ |argl| (CDR |$conform|))
                     (SETQ |conComments|
                             (COND
                              ((PROGN
                                (SETQ |ISTMP#1| (LASSOC '|constructor| |$doc|))
                                (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                                     (PROGN
                                      (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                                      (AND (CONSP |ISTMP#2|)
                                           (EQUAL (CAR |ISTMP#2|) NIL)
                                           (PROGN
                                            (SETQ |r| (CDR |ISTMP#2|))
                                            #1#)))))
                               (|libdbTrim| (|concatWithBlanks| |r|)))
                              (#1# "")))
                     (SETQ |argpart|
                             (SUBSTRING (|form2HtString| (CONS '|f| |argl|)) 1
                                        NIL))
                     (SETQ |sigpart| (|libConstructorSig| |$conform|))
                     (SETQ |header| (STRCONC |$kind| (PNAME |conname|)))
                     (|buildLibdbString|
                      (LIST |header| (LENGTH |argl|) |$exposed?| |sigpart|
                            |argpart| |abb| |conComments|)))))))))))

; dbMkForm x == atom x and [x] or x

(DEFUN |dbMkForm| (|x|) (PROG () (RETURN (OR (AND (ATOM |x|) (LIST |x|)) |x|))))

; buildLibdbString [x,:u] ==
;   STRCONC(STRINGIMAGE x,"STRCONC"/[STRCONC('"`",STRINGIMAGE y) for y in u])

(DEFUN |buildLibdbString| (|bfVar#6|)
  (PROG (|x| |u|)
    (RETURN
     (PROGN
      (SETQ |x| (CAR |bfVar#6|))
      (SETQ |u| (CDR |bfVar#6|))
      (STRCONC (STRINGIMAGE |x|)
       ((LAMBDA (|bfVar#5| |bfVar#4| |y|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#4|) (PROGN (SETQ |y| (CAR |bfVar#4|)) NIL))
             (RETURN |bfVar#5|))
            ('T
             (SETQ |bfVar#5|
                     (STRCONC |bfVar#5| (STRCONC "`" (STRINGIMAGE |y|))))))
           (SETQ |bfVar#4| (CDR |bfVar#4|))))
        "" |u| NIL))))))

; libConstructorSig [conname,:argl] ==
;   [[.,:sig],:.] := GETDATABASE(conname,'CONSTRUCTORMODEMAP)
;   formals := TAKE(#argl,$FormalMapVariableList)
;   sig := SUBLISLIS(formals,$TriangleVariableList,sig)
;   keys := [g(f,sig,i) for f in formals for i in 1..] where
;     g(x,u,i) ==  --does x appear in any but i-th element of u?
;       or/[CONTAINED(x,y) for y in u for j in 1.. | j ~= i]
;   sig := fn SUBLISLIS(argl,$FormalMapVariableList,sig) where
;     fn x ==
;       atom x => x
;       x is ['Join,a,:r] => ['Join,fn a,'etc]
;       x is ['CATEGORY,:.] => 'etc
;       [fn y for y in x]
;   sig := [first sig,:[(k => [":",a,s]; s)
;             for a in argl for s in rest sig for k in keys]]
;   sigpart:= form2LispString ['Mapping,:sig]
;   if null ncParseFromString sigpart then
;     sayBrightly ['"Won't parse: ",sigpart]
;   sigpart

(DEFUN |libConstructorSig| (|bfVar#17|)
  (PROG (|conname| |argl| |LETTMP#1| |sig| |formals| |keys| |sigpart|)
    (RETURN
     (PROGN
      (SETQ |conname| (CAR |bfVar#17|))
      (SETQ |argl| (CDR |bfVar#17|))
      (SETQ |LETTMP#1| (GETDATABASE |conname| 'CONSTRUCTORMODEMAP))
      (SETQ |sig| (CDAR |LETTMP#1|))
      (SETQ |formals| (TAKE (LENGTH |argl|) |$FormalMapVariableList|))
      (SETQ |sig| (SUBLISLIS |formals| |$TriangleVariableList| |sig|))
      (SETQ |keys|
              ((LAMBDA (|bfVar#8| |bfVar#7| |f| |i|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#7|)
                        (PROGN (SETQ |f| (CAR |bfVar#7|)) NIL))
                    (RETURN (NREVERSE |bfVar#8|)))
                   (#1='T
                    (SETQ |bfVar#8|
                            (CONS (|libConstructorSig,g| |f| |sig| |i|)
                                  |bfVar#8|))))
                  (SETQ |bfVar#7| (CDR |bfVar#7|))
                  (SETQ |i| (+ |i| 1))))
               NIL |formals| NIL 1))
      (SETQ |sig|
              (|libConstructorSig,fn|
               (SUBLISLIS |argl| |$FormalMapVariableList| |sig|)))
      (SETQ |sig|
              (CONS (CAR |sig|)
                    ((LAMBDA
                         (|bfVar#16| |bfVar#13| |a| |bfVar#14| |s| |bfVar#15|
                          |k|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#13|)
                              (PROGN (SETQ |a| (CAR |bfVar#13|)) NIL)
                              (ATOM |bfVar#14|)
                              (PROGN (SETQ |s| (CAR |bfVar#14|)) NIL)
                              (ATOM |bfVar#15|)
                              (PROGN (SETQ |k| (CAR |bfVar#15|)) NIL))
                          (RETURN (NREVERSE |bfVar#16|)))
                         (#1#
                          (SETQ |bfVar#16|
                                  (CONS
                                   (COND (|k| (LIST '|:| |a| |s|)) (#1# |s|))
                                   |bfVar#16|))))
                        (SETQ |bfVar#13| (CDR |bfVar#13|))
                        (SETQ |bfVar#14| (CDR |bfVar#14|))
                        (SETQ |bfVar#15| (CDR |bfVar#15|))))
                     NIL |argl| NIL (CDR |sig|) NIL |keys| NIL)))
      (SETQ |sigpart| (|form2LispString| (CONS '|Mapping| |sig|)))
      (COND
       ((NULL (|ncParseFromString| |sigpart|))
        (|sayBrightly| (LIST "Won't parse: " |sigpart|))))
      |sigpart|))))
(DEFUN |libConstructorSig,fn| (|x|)
  (PROG (|ISTMP#1| |a| |r|)
    (RETURN
     (COND ((ATOM |x|) |x|)
           ((AND (CONSP |x|) (EQ (CAR |x|) '|Join|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |x|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |a| (CAR |ISTMP#1|))
                        (SETQ |r| (CDR |ISTMP#1|))
                        #1='T))))
            (LIST '|Join| (|libConstructorSig,fn| |a|) '|etc|))
           ((AND (CONSP |x|) (EQ (CAR |x|) 'CATEGORY)) '|etc|)
           (#1#
            ((LAMBDA (|bfVar#12| |bfVar#11| |y|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#11|)
                      (PROGN (SETQ |y| (CAR |bfVar#11|)) NIL))
                  (RETURN (NREVERSE |bfVar#12|)))
                 (#1#
                  (SETQ |bfVar#12|
                          (CONS (|libConstructorSig,fn| |y|) |bfVar#12|))))
                (SETQ |bfVar#11| (CDR |bfVar#11|))))
             NIL |x| NIL))))))
(DEFUN |libConstructorSig,g| (|x| |u| |i|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#10| |bfVar#9| |y| |j|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#9|) (PROGN (SETQ |y| (CAR |bfVar#9|)) NIL))
           (RETURN |bfVar#10|))
          ('T
           (AND (NOT (EQUAL |j| |i|))
                (PROGN
                 (SETQ |bfVar#10| (CONTAINED |x| |y|))
                 (COND (|bfVar#10| (RETURN |bfVar#10|)))))))
         (SETQ |bfVar#9| (CDR |bfVar#9|))
         (SETQ |j| (+ |j| 1))))
      NIL |u| NIL 1))))

; concatWithBlanks r ==
;   r is [head,:tail] =>
;     tail => STRCONC(head,'" ",concatWithBlanks tail)
;     head
;   '""

(DEFUN |concatWithBlanks| (|r|)
  (PROG (|head| |tail|)
    (RETURN
     (COND
      ((AND (CONSP |r|)
            (PROGN (SETQ |head| (CAR |r|)) (SETQ |tail| (CDR |r|)) #1='T))
       (COND (|tail| (STRCONC |head| " " (|concatWithBlanks| |tail|)))
             (#1# |head|)))
      (#1# "")))))

; writedb(u) ==
;   not STRINGP u => nil        --skip if not a string
;   PRINTEXP(u, $outStream)
;   TERPRI $outStream

(DEFUN |writedb| (|u|)
  (PROG ()
    (RETURN
     (COND ((NULL (STRINGP |u|)) NIL)
           ('T (PROGN (PRINTEXP |u| |$outStream|) (TERPRI |$outStream|)))))))

; buildLibOps oplist == for [op,sig,:pred] in oplist repeat buildLibOp(op,sig,pred)

(DEFUN |buildLibOps| (|oplist|)
  (PROG (|op| |ISTMP#1| |sig| |pred|)
    (RETURN
     ((LAMBDA (|bfVar#19| |bfVar#18|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#19|)
               (PROGN (SETQ |bfVar#18| (CAR |bfVar#19|)) NIL))
           (RETURN NIL))
          (#1='T
           (AND (CONSP |bfVar#18|)
                (PROGN
                 (SETQ |op| (CAR |bfVar#18|))
                 (SETQ |ISTMP#1| (CDR |bfVar#18|))
                 (AND (CONSP |ISTMP#1|)
                      (PROGN
                       (SETQ |sig| (CAR |ISTMP#1|))
                       (SETQ |pred| (CDR |ISTMP#1|))
                       #1#)))
                (|buildLibOp| |op| |sig| |pred|))))
         (SETQ |bfVar#19| (CDR |bfVar#19|))))
      |oplist| NIL))))

; buildLibOp(op,sig,pred) ==
; --operations      OKop  \#\sig \conname\pred\comments (K is U or C)
;   nsig := SUBLISLIS(rest $conform,$FormalMapVariableList,sig)
;   pred := SUBLISLIS(rest $conform,$FormalMapVariableList,pred)
;   nsig := SUBST('T,"T$",nsig)   --this ancient artifact causes troubles!
;   pred := SUBST('T,"T$",pred)
;   sigpart:= form2LispString ['Mapping,:nsig]
;   predString := (pred = 'T => '""; form2LispString pred)
;   sop :=
;     (s := STRINGIMAGE op) = '"One" => '"1"
;     s = '"Zero" => '"0"
;     s
;   header := STRCONC('"o",sop)
;   conform:= STRCONC($kind,form2LispString $conform)
;   comments:= libdbTrim concatWithBlanks LASSOC(sig,LASSOC(op,$doc))
;   checkCommentsForBraces('operation,sop,sigpart,comments)
;   writedb
;     buildLibdbString [header,# rest sig,$exposed?,sigpart,conform,predString,comments]

(DEFUN |buildLibOp| (|op| |sig| |pred|)
  (PROG (|nsig| |sigpart| |predString| |s| |sop| |header| |conform| |comments|)
    (RETURN
     (PROGN
      (SETQ |nsig| (SUBLISLIS (CDR |$conform|) |$FormalMapVariableList| |sig|))
      (SETQ |pred|
              (SUBLISLIS (CDR |$conform|) |$FormalMapVariableList| |pred|))
      (SETQ |nsig| (SUBST 'T 'T$ |nsig|))
      (SETQ |pred| (SUBST 'T 'T$ |pred|))
      (SETQ |sigpart| (|form2LispString| (CONS '|Mapping| |nsig|)))
      (SETQ |predString|
              (COND ((EQ |pred| 'T) "") (#1='T (|form2LispString| |pred|))))
      (SETQ |sop|
              (COND ((EQUAL (SETQ |s| (STRINGIMAGE |op|)) "One") "1")
                    ((EQUAL |s| "Zero") "0") (#1# |s|)))
      (SETQ |header| (STRCONC "o" |sop|))
      (SETQ |conform| (STRCONC |$kind| (|form2LispString| |$conform|)))
      (SETQ |comments|
              (|libdbTrim|
               (|concatWithBlanks| (LASSOC |sig| (LASSOC |op| |$doc|)))))
      (|checkCommentsForBraces| '|operation| |sop| |sigpart| |comments|)
      (|writedb|
       (|buildLibdbString|
        (LIST |header| (LENGTH (CDR |sig|)) |$exposed?| |sigpart| |conform|
              |predString| |comments|)))))))

; libdbTrim s ==
;   k := MAXINDEX s
;   k < 0 => s
;   for i in 0..k repeat
;     s.i = $Newline => SETELT(s,i,char '_ )
;   trimString s

(DEFUN |libdbTrim| (|s|)
  (PROG (|k|)
    (RETURN
     (PROGN
      (SETQ |k| (MAXINDEX |s|))
      (COND ((MINUSP |k|) |s|)
            (#1='T
             (PROGN
              ((LAMBDA (|i|)
                 (LOOP
                  (COND ((> |i| |k|) (RETURN NIL))
                        (#1#
                         (COND
                          ((EQUAL (ELT |s| |i|) |$Newline|)
                           (IDENTITY (SETELT |s| |i| (|char| '| |)))))))
                  (SETQ |i| (+ |i| 1))))
               0)
              (|trimString| |s|))))))))

; checkCommentsForBraces(kind,sop,sigpart,comments) ==
;   count := 0
;   for i in 0..MAXINDEX comments repeat
;     c := comments.i
;     c = char '_{ => count := count + 1
;     c = char '_} =>
;       count := count - 1
;       count < 0 => missingLeft := true
;   if count < 0 or missingLeft then
;     tail :=
;       kind = 'attribute => [sop,'"(",sigpart,'")"]
;       [sop,'": ",sigpart]
;     sayBrightly ['"(",$conname,'" documentation) missing left brace--> ",:tail]
;   if count > 0 then
;     sayBrightly ['"(",$conname,'" documentation) missing right brace--> ",:tail]
;   if count ~= 0 or missingLeft then pp comments

(DEFUN |checkCommentsForBraces| (|kind| |sop| |sigpart| |comments|)
  (PROG (|count| |c| |missingLeft| |tail|)
    (RETURN
     (PROGN
      (SETQ |count| 0)
      ((LAMBDA (|bfVar#20| |i|)
         (LOOP
          (COND ((> |i| |bfVar#20|) (RETURN NIL))
                (#1='T
                 (PROGN
                  (SETQ |c| (ELT |comments| |i|))
                  (COND ((EQUAL |c| (|char| '{)) (SETQ |count| (+ |count| 1)))
                        ((EQUAL |c| (|char| '}))
                         (PROGN
                          (SETQ |count| (- |count| 1))
                          (COND
                           ((MINUSP |count|) (SETQ |missingLeft| T)))))))))
          (SETQ |i| (+ |i| 1))))
       (MAXINDEX |comments|) 0)
      (COND
       ((OR (MINUSP |count|) |missingLeft|)
        (SETQ |tail|
                (COND ((EQ |kind| '|attribute|) (LIST |sop| "(" |sigpart| ")"))
                      (#1# (LIST |sop| ": " |sigpart|))))
        (|sayBrightly|
         (CONS "("
               (CONS |$conname|
                     (CONS " documentation) missing left brace--> "
                           |tail|))))))
      (COND
       ((< 0 |count|)
        (|sayBrightly|
         (CONS "("
               (CONS |$conname|
                     (CONS " documentation) missing right brace--> "
                           |tail|))))))
      (COND ((OR (NOT (EQL |count| 0)) |missingLeft|) (|pp| |comments|)))))))

; dbHasExamplePage conname ==
;   sname    := STRINGIMAGE conname
;   abb      := constructor? conname
;   ucname   := UPCASE STRINGIMAGE abb
;   pathname :=STRCONC(getEnv '"FRICAS",'"/share/hypertex/pages/",ucname,'".ht")
;   isExistingFile pathname => INTERN STRCONC(sname,'"XmpPage")
;   nil

(DEFUN |dbHasExamplePage| (|conname|)
  (PROG (|sname| |abb| |ucname| |pathname|)
    (RETURN
     (PROGN
      (SETQ |sname| (STRINGIMAGE |conname|))
      (SETQ |abb| (|constructor?| |conname|))
      (SETQ |ucname| (UPCASE (STRINGIMAGE |abb|)))
      (SETQ |pathname|
              (STRCONC (|getEnv| "FRICAS") "/share/hypertex/pages/" |ucname|
               ".ht"))
      (COND
       ((|isExistingFile| |pathname|) (INTERN (STRCONC |sname| "XmpPage")))
       ('T NIL))))))

; dbReadComments(n) ==
;   n = 0 => '""
;   instream := MAKE_INSTREAM(STRCONC(getEnv('"FRICAS"), '"/algebra/comdb.text"))
;   FILE_-POSITION(instream,n)
;   line := read_line instream
;   k := dbTickIndex(line,1,1)
;   line := SUBSTRING(line,k + 1,nil)
;   while not EOFP instream and (x := read_line instream) and
;     (k := MAXINDEX x) and (j := dbTickIndex(x,1,1)) and (j < k) and
;       x.(j := j + 1) = char '_- and x.(j := j + 1) = char '_- repeat
;         xtralines := [SUBSTRING(x,j + 1,nil),:xtralines]
;   SHUT instream
;   STRCONC(line, "STRCONC"/NREVERSE xtralines)

(DEFUN |dbReadComments| (|n|)
  (PROG (|instream| |line| |k| |x| |j| |xtralines|)
    (RETURN
     (COND ((EQL |n| 0) "")
           (#1='T
            (PROGN
             (SETQ |instream|
                     (MAKE_INSTREAM
                      (STRCONC (|getEnv| "FRICAS") "/algebra/comdb.text")))
             (FILE-POSITION |instream| |n|)
             (SETQ |line| (|read_line| |instream|))
             (SETQ |k| (|dbTickIndex| |line| 1 1))
             (SETQ |line| (SUBSTRING |line| (+ |k| 1) NIL))
             ((LAMBDA ()
                (LOOP
                 (COND
                  ((NOT
                    (AND (NULL (EOFP |instream|))
                         (SETQ |x| (|read_line| |instream|))
                         (SETQ |k| (MAXINDEX |x|))
                         (SETQ |j| (|dbTickIndex| |x| 1 1)) (< |j| |k|)
                         (EQUAL (ELT |x| (SETQ |j| (+ |j| 1))) (|char| '-))
                         (EQUAL (ELT |x| (SETQ |j| (+ |j| 1))) (|char| '-))))
                   (RETURN NIL))
                  (#1#
                   (SETQ |xtralines|
                           (CONS (SUBSTRING |x| (+ |j| 1) NIL)
                                 |xtralines|)))))))
             (SHUT |instream|)
             (STRCONC |line|
              ((LAMBDA (|bfVar#21| |bfVar#23| |bfVar#22|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#23|)
                        (PROGN (SETQ |bfVar#22| (CAR |bfVar#23|)) NIL))
                    (RETURN |bfVar#21|))
                   (#1# (SETQ |bfVar#21| (STRCONC |bfVar#21| |bfVar#22|))))
                  (SETQ |bfVar#23| (CDR |bfVar#23|))))
               "" (NREVERSE |xtralines|) NIL))))))))

; dbSplitLibdb() ==
;   instream := MAKE_INSTREAM('"olibdb.text")
;   outstream := MAKE_OUTSTREAM('"libdb.text")
;   comstream := MAKE_OUTSTREAM('"comdb.text")
;   PRINTEXP(0,    comstream)
;   PRINTEXP($tick,comstream)
;   PRINTEXP('"",  comstream)
;   TERPRI(comstream)
;   while not EOFP instream repeat
;     line := read_line instream
;     outP := FILE_-POSITION outstream
;     comP := FILE_-POSITION comstream
;     [prefix,:comments] := dbSplit(line,6,1)
;     PRINTEXP(prefix,outstream)
;     PRINTEXP($tick ,outstream)
;     null comments =>
;       PRINTEXP(0,outstream)
;       TERPRI(outstream)
;     PRINTEXP(comP,outstream)
;     TERPRI(outstream)
;     PRINTEXP(outP  ,comstream)
;     PRINTEXP($tick ,comstream)
;     PRINTEXP(first comments,comstream)
;     TERPRI(comstream)
;     for c in rest comments repeat
;       PRINTEXP(outP  ,comstream)
;       PRINTEXP($tick ,comstream)
;       PRINTEXP(c, comstream)
;       TERPRI(comstream)
;   SHUT instream
;   SHUT outstream
;   SHUT comstream
;   deleteFile '"olibdb.text"

(DEFUN |dbSplitLibdb| ()
  (PROG (|comments| |prefix| |LETTMP#1| |comP| |outP| |line| |comstream|
         |outstream| |instream|)
    (RETURN
     (PROGN
      (SETQ |instream| (MAKE_INSTREAM "olibdb.text"))
      (SETQ |outstream| (MAKE_OUTSTREAM "libdb.text"))
      (SETQ |comstream| (MAKE_OUTSTREAM "comdb.text"))
      (PRINTEXP 0 |comstream|)
      (PRINTEXP |$tick| |comstream|)
      (PRINTEXP "" |comstream|)
      (TERPRI |comstream|)
      ((LAMBDA ()
         (LOOP
          (COND ((EOFP |instream|) (RETURN NIL))
                (#1='T
                 (PROGN
                  (SETQ |line| (|read_line| |instream|))
                  (SETQ |outP| (FILE-POSITION |outstream|))
                  (SETQ |comP| (FILE-POSITION |comstream|))
                  (SETQ |LETTMP#1| (|dbSplit| |line| 6 1))
                  (SETQ |prefix| (CAR |LETTMP#1|))
                  (SETQ |comments| (CDR |LETTMP#1|))
                  (PRINTEXP |prefix| |outstream|)
                  (PRINTEXP |$tick| |outstream|)
                  (COND
                   ((NULL |comments|)
                    (PROGN (PRINTEXP 0 |outstream|) (TERPRI |outstream|)))
                   (#1#
                    (PROGN
                     (PRINTEXP |comP| |outstream|)
                     (TERPRI |outstream|)
                     (PRINTEXP |outP| |comstream|)
                     (PRINTEXP |$tick| |comstream|)
                     (PRINTEXP (CAR |comments|) |comstream|)
                     (TERPRI |comstream|)
                     ((LAMBDA (|bfVar#24| |c|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#24|)
                               (PROGN (SETQ |c| (CAR |bfVar#24|)) NIL))
                           (RETURN NIL))
                          (#1#
                           (PROGN
                            (PRINTEXP |outP| |comstream|)
                            (PRINTEXP |$tick| |comstream|)
                            (PRINTEXP |c| |comstream|)
                            (TERPRI |comstream|))))
                         (SETQ |bfVar#24| (CDR |bfVar#24|))))
                      (CDR |comments|) NIL))))))))))
      (SHUT |instream|)
      (SHUT |outstream|)
      (SHUT |comstream|)
      (|deleteFile| "olibdb.text")))))

; dbSplit(line,n,k) ==
;   k := charPosition($tick,line,k + 1)
;   n = 1 => [SUBSTRING(line,0,k),:dbSpreadComments(SUBSTRING(line,k + 1,nil),0)]
;   dbSplit(line,n - 1,k)

(DEFUN |dbSplit| (|line| |n| |k|)
  (PROG ()
    (RETURN
     (PROGN
      (SETQ |k| (|charPosition| |$tick| |line| (+ |k| 1)))
      (COND
       ((EQL |n| 1)
        (CONS (SUBSTRING |line| 0 |k|)
              (|dbSpreadComments| (SUBSTRING |line| (+ |k| 1) NIL) 0)))
       ('T (|dbSplit| |line| (- |n| 1) |k|)))))))

; dbSpreadComments(line,n) ==
;   line = '"" => nil
;   k := charPosition(char '_-,line,n + 2)
;   k >= MAXINDEX line => [SUBSTRING(line,n,nil)]
;   line.(k + 1) ~= char '_- =>
;     u := dbSpreadComments(line,k)
;     [STRCONC(SUBSTRING(line,n,k - n),first u),:rest u]
;   [SUBSTRING(line,n,k - n),:dbSpreadComments(SUBSTRING(line,k,nil),0)]

(DEFUN |dbSpreadComments| (|line| |n|)
  (PROG (|k| |u|)
    (RETURN
     (COND ((EQUAL |line| "") NIL)
           (#1='T
            (PROGN
             (SETQ |k| (|charPosition| (|char| '-) |line| (+ |n| 2)))
             (COND
              ((NOT (< |k| (MAXINDEX |line|)))
               (LIST (SUBSTRING |line| |n| NIL)))
              ((NOT (EQUAL (ELT |line| (+ |k| 1)) (|char| '-)))
               (PROGN
                (SETQ |u| (|dbSpreadComments| |line| |k|))
                (CONS (STRCONC (SUBSTRING |line| |n| (- |k| |n|)) (CAR |u|))
                      (CDR |u|))))
              (#1#
               (CONS (SUBSTRING |line| |n| (- |k| |n|))
                     (|dbSpreadComments| (SUBSTRING |line| |k| NIL) 0))))))))))

; buildGloss() ==  --called by buildDatabase (database.boot)
; --starting with gloss.text, build glosskey.text and glossdef.text
;   $constructorName : local := nil
;   $exposeFlag : local := true
;   $outStream : local := MAKE_OUTSTREAM('"temp.text")
;   $x : local := nil
;   $attribute? : local := true     --do not surround first word
;   pathname := '"gloss.text"
;   instream := MAKE_INSTREAM(pathname)
;   keypath  := '"glosskey.text"
;   maybe_delete_file(keypath)
;   outstream := MAKE_OUTSTREAM(keypath)
;   htpath   := '"gloss.ht"
;   maybe_delete_file(htpath)
;   htstream := MAKE_OUTSTREAM(htpath)
;   defpath  := '"glossdef.text"
;   defstream := MAKE_OUTSTREAM(defpath)
;   pairs := getGlossLines instream
;   PRINTEXP('"\begin{page}{GlossaryPage}{G l o s s a r y}\beginscroll\beginmenu",htstream)
;   for [name,:line] in pairs repeat
;     outP  := FILE_-POSITION outstream
;     defP  := FILE_-POSITION defstream
;     lines := spreadGlossText transformAndRecheckComments(name,[line])
;     PRINTEXP(name, outstream)
;     PRINTEXP($tick,outstream)
;     PRINTEXP(defP, outstream)
;     TERPRI(outstream)
; --  PRINTEXP('"\item\newline{\em \menuitemstyle{}}\tab{0}{\em ",htstream)
;     PRINTEXP('"\item\newline{\em \menuitemstyle{}}{\em ",htstream)
;     PRINTEXP(name,        htstream)
;     PRINTEXP('"}\space{}",htstream)
;     TERPRI(htstream)
;     for x in lines repeat
;       PRINTEXP(outP, defstream)
;       PRINTEXP($tick,defstream)
;       PRINTEXP(x,    defstream)
;       TERPRI defstream
;     PRINTEXP("STRCONC"/lines,htstream)
;     TERPRI htstream
;   PRINTEXP('"\endmenu\endscroll",htstream)
;   PRINTEXP('"\lispdownlink{Search}{(|htGloss| _"\stringvalue{pattern}_")} for glossary entry matching \inputstring{pattern}{24}{*}",htstream)
;   PRINTEXP('"\end{page}",htstream)
;   SHUT instream
;   SHUT outstream
;   SHUT defstream
;   SHUT htstream
;   SHUT $outStream

(DEFUN |buildGloss| ()
  (PROG (|$attribute?| |$x| |$outStream| |$exposeFlag| |$constructorName|
         |pathname| |instream| |keypath| |outstream| |htpath| |htstream|
         |defpath| |defstream| |pairs| |name| |line| |outP| |defP| |lines|)
    (DECLARE
     (SPECIAL |$attribute?| |$x| |$outStream| |$exposeFlag|
      |$constructorName|))
    (RETURN
     (PROGN
      (SETQ |$constructorName| NIL)
      (SETQ |$exposeFlag| T)
      (SETQ |$outStream| (MAKE_OUTSTREAM "temp.text"))
      (SETQ |$x| NIL)
      (SETQ |$attribute?| T)
      (SETQ |pathname| "gloss.text")
      (SETQ |instream| (MAKE_INSTREAM |pathname|))
      (SETQ |keypath| "glosskey.text")
      (|maybe_delete_file| |keypath|)
      (SETQ |outstream| (MAKE_OUTSTREAM |keypath|))
      (SETQ |htpath| "gloss.ht")
      (|maybe_delete_file| |htpath|)
      (SETQ |htstream| (MAKE_OUTSTREAM |htpath|))
      (SETQ |defpath| "glossdef.text")
      (SETQ |defstream| (MAKE_OUTSTREAM |defpath|))
      (SETQ |pairs| (|getGlossLines| |instream|))
      (PRINTEXP
       "\\begin{page}{GlossaryPage}{G l o s s a r y}\\beginscroll\\beginmenu"
       |htstream|)
      ((LAMBDA (|bfVar#26| |bfVar#25|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#26|)
                (PROGN (SETQ |bfVar#25| (CAR |bfVar#26|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#25|)
                 (PROGN
                  (SETQ |name| (CAR |bfVar#25|))
                  (SETQ |line| (CDR |bfVar#25|))
                  #1#)
                 (PROGN
                  (SETQ |outP| (FILE-POSITION |outstream|))
                  (SETQ |defP| (FILE-POSITION |defstream|))
                  (SETQ |lines|
                          (|spreadGlossText|
                           (|transformAndRecheckComments| |name|
                            (LIST |line|))))
                  (PRINTEXP |name| |outstream|)
                  (PRINTEXP |$tick| |outstream|)
                  (PRINTEXP |defP| |outstream|)
                  (TERPRI |outstream|)
                  (PRINTEXP "\\item\\newline{\\em \\menuitemstyle{}}{\\em "
                   |htstream|)
                  (PRINTEXP |name| |htstream|)
                  (PRINTEXP "}\\space{}" |htstream|)
                  (TERPRI |htstream|)
                  ((LAMBDA (|bfVar#27| |x|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#27|)
                            (PROGN (SETQ |x| (CAR |bfVar#27|)) NIL))
                        (RETURN NIL))
                       (#1#
                        (PROGN
                         (PRINTEXP |outP| |defstream|)
                         (PRINTEXP |$tick| |defstream|)
                         (PRINTEXP |x| |defstream|)
                         (TERPRI |defstream|))))
                      (SETQ |bfVar#27| (CDR |bfVar#27|))))
                   |lines| NIL)
                  (PRINTEXP
                   ((LAMBDA (|bfVar#28| |bfVar#30| |bfVar#29|)
                      (LOOP
                       (COND
                        ((OR (ATOM |bfVar#30|)
                             (PROGN (SETQ |bfVar#29| (CAR |bfVar#30|)) NIL))
                         (RETURN |bfVar#28|))
                        (#1#
                         (SETQ |bfVar#28| (STRCONC |bfVar#28| |bfVar#29|))))
                       (SETQ |bfVar#30| (CDR |bfVar#30|))))
                    "" |lines| NIL)
                   |htstream|)
                  (TERPRI |htstream|)))))
          (SETQ |bfVar#26| (CDR |bfVar#26|))))
       |pairs| NIL)
      (PRINTEXP "\\endmenu\\endscroll" |htstream|)
      (PRINTEXP
       "\\lispdownlink{Search}{(|htGloss| \"\\stringvalue{pattern}\")} for glossary entry matching \\inputstring{pattern}{24}{*}"
       |htstream|)
      (PRINTEXP "\\end{page}" |htstream|)
      (SHUT |instream|)
      (SHUT |outstream|)
      (SHUT |defstream|)
      (SHUT |htstream|)
      (SHUT |$outStream|)))))

; spreadGlossText(line) ==
; --this function breaks up a line into chunks
; --eventually long line is put into gloss.text as several chunks as follows:
; ----- key1`this is the first chunk
; ----- XXX`and this is the second
; ----- XXX`and this is the third
; ----- key2`and this is the fourth
; --where XXX is the file position of key1
; --this is because grepping will only pick up the first 512 characters
;   line = '"" => nil
;   MAXINDEX line > 500 => [SUBSTRING(line,0,500),:spreadGlossText(SUBSTRING(line,500,nil))]
;   [line]

(DEFUN |spreadGlossText| (|line|)
  (PROG ()
    (RETURN
     (COND ((EQUAL |line| "") NIL)
           ((< 500 (MAXINDEX |line|))
            (CONS (SUBSTRING |line| 0 500)
                  (|spreadGlossText| (SUBSTRING |line| 500 NIL))))
           ('T (LIST |line|))))))

; getGlossLines instream ==
; --instream has text of the form:
; ----- key1`this is the first line
; ----- and this is the second
; ----- key2'and this is the third
; --result is
; ----- key1'this is the first line and this is the second
; ----- key2'and this is the third
;   keys := nil
;   text := nil
;   lastLineHadTick := false
;   while not EOFP instream repeat
;     line := read_line instream
;     #line = 0 => 'skip
;     n := charPosition($tick,line,0)
;     last := IFCAR text
;     n > MAXINDEX line =>  --this line is continuation of previous line; concat it
;       fill :=
;         #last = 0 =>
;           lastLineHadTick => '""
;           '"\blankline "
;         #last > 0 and last.(MAXINDEX last) ~= $charBlank => $charBlank
;         '""
;       lastLineHadTick := false
;       text := [STRCONC(last,fill,line),:rest text]
;     lastLineHadTick := true
;     keys := [SUBSTRING(line,0,n),:keys]
;     text := [SUBSTRING(line,n + 1,nil),:text]
;   ASSOCRIGHT listSort(function GLESSEQP,[[DOWNCASE key,key,:def] for key in keys for def in text])

(DEFUN |getGlossLines| (|instream|)
  (PROG (|keys| |text| |lastLineHadTick| |line| |n| |last| |fill|)
    (RETURN
     (PROGN
      (SETQ |keys| NIL)
      (SETQ |text| NIL)
      (SETQ |lastLineHadTick| NIL)
      ((LAMBDA ()
         (LOOP
          (COND ((EOFP |instream|) (RETURN NIL))
                (#1='T
                 (PROGN
                  (SETQ |line| (|read_line| |instream|))
                  (COND ((EQL (LENGTH |line|) 0) '|skip|)
                        (#1#
                         (PROGN
                          (SETQ |n| (|charPosition| |$tick| |line| 0))
                          (SETQ |last| (IFCAR |text|))
                          (COND
                           ((< (MAXINDEX |line|) |n|)
                            (PROGN
                             (SETQ |fill|
                                     (COND
                                      ((EQL (LENGTH |last|) 0)
                                       (COND (|lastLineHadTick| "")
                                             (#1# "\\blankline ")))
                                      ((AND (< 0 (LENGTH |last|))
                                            (NOT
                                             (EQUAL
                                              (ELT |last| (MAXINDEX |last|))
                                              |$charBlank|)))
                                       |$charBlank|)
                                      (#1# "")))
                             (SETQ |lastLineHadTick| NIL)
                             (SETQ |text|
                                     (CONS (STRCONC |last| |fill| |line|)
                                           (CDR |text|)))))
                           (#1#
                            (PROGN
                             (SETQ |lastLineHadTick| T)
                             (SETQ |keys|
                                     (CONS (SUBSTRING |line| 0 |n|) |keys|))
                             (SETQ |text|
                                     (CONS (SUBSTRING |line| (+ |n| 1) NIL)
                                           |text|))))))))))))))
      (ASSOCRIGHT
       (|listSort| #'GLESSEQP
        ((LAMBDA (|bfVar#33| |bfVar#31| |key| |bfVar#32| |def|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#31|) (PROGN (SETQ |key| (CAR |bfVar#31|)) NIL)
                  (ATOM |bfVar#32|) (PROGN (SETQ |def| (CAR |bfVar#32|)) NIL))
              (RETURN (NREVERSE |bfVar#33|)))
             (#1#
              (SETQ |bfVar#33|
                      (CONS (CONS (DOWNCASE |key|) (CONS |key| |def|))
                            |bfVar#33|))))
            (SETQ |bfVar#31| (CDR |bfVar#31|))
            (SETQ |bfVar#32| (CDR |bfVar#32|))))
         NIL |keys| NIL |text| NIL)))))))

; mkUsersHashTable() ==  --called by make-databases (daase.lisp)
;   $usersTb := MAKE_HASHTABLE('EQUAL)
;   for x in allConstructors() repeat
;     for conform in getImports x repeat
;       name := opOf conform
;       if not MEMQ(name,'(QUOTE)) then
;         HPUT($usersTb,name,insert(x,HGET($usersTb,name)))
;   for k in HKEYS $usersTb repeat
;     HPUT($usersTb,k,listSort(function GLESSEQP,HGET($usersTb,k)))
;   for x in allConstructors() | isDefaultPackageName x repeat
;     HPUT($usersTb,x,getDefaultPackageClients x)
;   $usersTb

(DEFUN |mkUsersHashTable| ()
  (PROG (|name|)
    (RETURN
     (PROGN
      (SETQ |$usersTb| (MAKE_HASHTABLE 'EQUAL))
      ((LAMBDA (|bfVar#34| |x|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#34|) (PROGN (SETQ |x| (CAR |bfVar#34|)) NIL))
            (RETURN NIL))
           (#1='T
            ((LAMBDA (|bfVar#35| |conform|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#35|)
                      (PROGN (SETQ |conform| (CAR |bfVar#35|)) NIL))
                  (RETURN NIL))
                 (#1#
                  (PROGN
                   (SETQ |name| (|opOf| |conform|))
                   (COND
                    ((NULL (MEMQ |name| '(QUOTE)))
                     (HPUT |$usersTb| |name|
                           (|insert| |x| (HGET |$usersTb| |name|))))))))
                (SETQ |bfVar#35| (CDR |bfVar#35|))))
             (|getImports| |x|) NIL)))
          (SETQ |bfVar#34| (CDR |bfVar#34|))))
       (|allConstructors|) NIL)
      ((LAMBDA (|bfVar#36| |k|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#36|) (PROGN (SETQ |k| (CAR |bfVar#36|)) NIL))
            (RETURN NIL))
           (#1#
            (HPUT |$usersTb| |k|
                  (|listSort| #'GLESSEQP (HGET |$usersTb| |k|)))))
          (SETQ |bfVar#36| (CDR |bfVar#36|))))
       (HKEYS |$usersTb|) NIL)
      ((LAMBDA (|bfVar#37| |x|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#37|) (PROGN (SETQ |x| (CAR |bfVar#37|)) NIL))
            (RETURN NIL))
           (#1#
            (AND (|isDefaultPackageName| |x|)
                 (HPUT |$usersTb| |x| (|getDefaultPackageClients| |x|)))))
          (SETQ |bfVar#37| (CDR |bfVar#37|))))
       (|allConstructors|) NIL)
      |$usersTb|))))

; getDefaultPackageClients con ==  --called by mkUsersHashTable
;   catname := INTERN SUBSTRING(s := PNAME con,0,MAXINDEX s)
;   for [catAncestor,:.] in childrenOf([catname]) repeat
;     pakname := INTERN STRCONC(PNAME catAncestor,'"&")
;     if getCDTEntry(pakname,true) then acc := [pakname,:acc]
;     acc := union([CAAR x for x in domainsOf([catAncestor],nil)],acc)
;   listSort(function GLESSEQP,acc)

(DEFUN |getDefaultPackageClients| (|con|)
  (PROG (|s| |catname| |catAncestor| |pakname| |acc|)
    (RETURN
     (PROGN
      (SETQ |catname|
              (INTERN (SUBSTRING (SETQ |s| (PNAME |con|)) 0 (MAXINDEX |s|))))
      ((LAMBDA (|bfVar#39| |bfVar#38|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#39|)
                (PROGN (SETQ |bfVar#38| (CAR |bfVar#39|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#38|)
                 (PROGN (SETQ |catAncestor| (CAR |bfVar#38|)) #1#)
                 (PROGN
                  (SETQ |pakname| (INTERN (STRCONC (PNAME |catAncestor|) "&")))
                  (COND
                   ((|getCDTEntry| |pakname| T)
                    (SETQ |acc| (CONS |pakname| |acc|))))
                  (SETQ |acc|
                          (|union|
                           ((LAMBDA (|bfVar#41| |bfVar#40| |x|)
                              (LOOP
                               (COND
                                ((OR (ATOM |bfVar#40|)
                                     (PROGN (SETQ |x| (CAR |bfVar#40|)) NIL))
                                 (RETURN (NREVERSE |bfVar#41|)))
                                (#1#
                                 (SETQ |bfVar#41|
                                         (CONS (CAAR |x|) |bfVar#41|))))
                               (SETQ |bfVar#40| (CDR |bfVar#40|))))
                            NIL (|domainsOf| (LIST |catAncestor|) NIL) NIL)
                           |acc|))))))
          (SETQ |bfVar#39| (CDR |bfVar#39|))))
       (|childrenOf| (LIST |catname|)) NIL)
      (|listSort| #'GLESSEQP |acc|)))))

; mkDependentsHashTable() == --called by make-databases (database.boot)
;   $depTb := MAKE_HASHTABLE('EQUAL)
;   for nam in allConstructors() repeat
;     for con in getArgumentConstructors nam repeat
;       HPUT($depTb,con,[nam,:HGET($depTb,con)])
;   for k in HKEYS $depTb repeat
;     HPUT($depTb,k,listSort(function GLESSEQP,HGET($depTb,k)))
;   $depTb

(DEFUN |mkDependentsHashTable| ()
  (PROG ()
    (RETURN
     (PROGN
      (SETQ |$depTb| (MAKE_HASHTABLE 'EQUAL))
      ((LAMBDA (|bfVar#42| |nam|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#42|) (PROGN (SETQ |nam| (CAR |bfVar#42|)) NIL))
            (RETURN NIL))
           (#1='T
            ((LAMBDA (|bfVar#43| |con|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#43|)
                      (PROGN (SETQ |con| (CAR |bfVar#43|)) NIL))
                  (RETURN NIL))
                 (#1#
                  (HPUT |$depTb| |con| (CONS |nam| (HGET |$depTb| |con|)))))
                (SETQ |bfVar#43| (CDR |bfVar#43|))))
             (|getArgumentConstructors| |nam|) NIL)))
          (SETQ |bfVar#42| (CDR |bfVar#42|))))
       (|allConstructors|) NIL)
      ((LAMBDA (|bfVar#44| |k|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#44|) (PROGN (SETQ |k| (CAR |bfVar#44|)) NIL))
            (RETURN NIL))
           (#1#
            (HPUT |$depTb| |k| (|listSort| #'GLESSEQP (HGET |$depTb| |k|)))))
          (SETQ |bfVar#44| (CDR |bfVar#44|))))
       (HKEYS |$depTb|) NIL)
      |$depTb|))))

; getArgumentConstructors con == --called by mkDependentsHashTable
;   argtypes := IFCDR IFCAR getConstructorModemap con or return nil
;   fn argtypes where
;     fn(u) == "union"/[gn x for x in u]
;     gn(x) ==
;       atom x => nil
;       x is ['Join,:r] => fn(r)
;       x is ['CATEGORY,:.] => nil
;       constructor? first x => [first x,:fn rest x]
;       fn rest x

(DEFUN |getArgumentConstructors| (|con|)
  (PROG (|argtypes|)
    (RETURN
     (PROGN
      (SETQ |argtypes|
              (OR (IFCDR (IFCAR (|getConstructorModemap| |con|)))
                  (RETURN NIL)))
      (|getArgumentConstructors,fn| |argtypes|)))))
(DEFUN |getArgumentConstructors,fn| (|u|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#46| |bfVar#45| |x|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#45|) (PROGN (SETQ |x| (CAR |bfVar#45|)) NIL))
           (RETURN |bfVar#46|))
          ('T
           (SETQ |bfVar#46|
                   (|union| |bfVar#46| (|getArgumentConstructors,gn| |x|)))))
         (SETQ |bfVar#45| (CDR |bfVar#45|))))
      NIL |u| NIL))))
(DEFUN |getArgumentConstructors,gn| (|x|)
  (PROG (|r|)
    (RETURN
     (COND ((ATOM |x|) NIL)
           ((AND (CONSP |x|) (EQ (CAR |x|) '|Join|)
                 (PROGN (SETQ |r| (CDR |x|)) #1='T))
            (|getArgumentConstructors,fn| |r|))
           ((AND (CONSP |x|) (EQ (CAR |x|) 'CATEGORY)) NIL)
           ((|constructor?| (CAR |x|))
            (CONS (CAR |x|) (|getArgumentConstructors,fn| (CDR |x|))))
           (#1# (|getArgumentConstructors,fn| (CDR |x|)))))))

; getImports conname == --called by mkUsersHashTable
;   conform := GETDATABASE(conname,'CONSTRUCTORFORM)
;   infovec := dbInfovec conname or return nil
;   template := infovec.0
;   u := [import(i,template)
;           for i in 5..(MAXINDEX template) | test]  where
;     test == template.i is [op,:.] and IDENTP op
;               and not MEMQ(op,'(Mapping Union Record Enumeration CONS QUOTE local))
;     import(x,template) ==
;       x is [op,:args] =>
;         op = 'QUOTE or op = 'NRTEVAL => first args
;         op = 'local => first args
;         op = 'Record =>
;           ['Record,:[[":",CADR y,import(CADDR y,template)] for y in args]]
;
; --TTT next three lines: handles some tagged/untagged Union case.
;         op = 'Union=>
;           args is [['_:,:x1],:x2] =>
; --          CAAR args = '_: => -- tagged!
;                ['Union,:[[":",CADR y,import(CADDR y,template)] for y in args]]
;           [op,:[import(y,template) for y in args]]
;
;         [op,:[import(y,template) for y in args]]
;       INTEGERP x => import(template.x,template)
;       x = '$ => '$
;       x = "$$" => "$$"
;       STRINGP x => x
;       systemError '"bad argument in template"
;   listSort(function GLESSEQP,SUBLISLIS(rest conform,$FormalMapVariableList,u))

(DEFUN |getImports| (|conname|)
  (PROG (|conform| |infovec| |template| |ISTMP#1| |op| |u|)
    (RETURN
     (PROGN
      (SETQ |conform| (GETDATABASE |conname| 'CONSTRUCTORFORM))
      (SETQ |infovec| (OR (|dbInfovec| |conname|) (RETURN NIL)))
      (SETQ |template| (ELT |infovec| 0))
      (SETQ |u|
              ((LAMBDA (|bfVar#48| |bfVar#47| |i|)
                 (LOOP
                  (COND ((> |i| |bfVar#47|) (RETURN (NREVERSE |bfVar#48|)))
                        (#1='T
                         (AND
                          (AND
                           (PROGN
                            (SETQ |ISTMP#1| (ELT |template| |i|))
                            (AND (CONSP |ISTMP#1|)
                                 (PROGN (SETQ |op| (CAR |ISTMP#1|)) #1#)))
                           (IDENTP |op|)
                           (NULL
                            (MEMQ |op|
                                  '(|Mapping| |Union| |Record| |Enumeration|
                                    CONS QUOTE |local|))))
                          (SETQ |bfVar#48|
                                  (CONS (|getImports,import| |i| |template|)
                                        |bfVar#48|)))))
                  (SETQ |i| (+ |i| 1))))
               NIL (MAXINDEX |template|) 5))
      (|listSort| #'GLESSEQP
       (SUBLISLIS (CDR |conform|) |$FormalMapVariableList| |u|))))))
(DEFUN |getImports,import| (|x| |template|)
  (PROG (|op| |args| |ISTMP#1| |x1| |x2|)
    (RETURN
     (COND
      ((AND (CONSP |x|)
            (PROGN (SETQ |op| (CAR |x|)) (SETQ |args| (CDR |x|)) #1='T))
       (COND ((OR (EQ |op| 'QUOTE) (EQ |op| 'NRTEVAL)) (CAR |args|))
             ((EQ |op| '|local|) (CAR |args|))
             ((EQ |op| '|Record|)
              (CONS '|Record|
                    ((LAMBDA (|bfVar#50| |bfVar#49| |y|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#49|)
                              (PROGN (SETQ |y| (CAR |bfVar#49|)) NIL))
                          (RETURN (NREVERSE |bfVar#50|)))
                         (#1#
                          (SETQ |bfVar#50|
                                  (CONS
                                   (LIST '|:| (CADR |y|)
                                         (|getImports,import| (CADDR |y|)
                                          |template|))
                                   |bfVar#50|))))
                        (SETQ |bfVar#49| (CDR |bfVar#49|))))
                     NIL |args| NIL)))
             ((EQ |op| '|Union|)
              (COND
               ((AND (CONSP |args|)
                     (PROGN
                      (SETQ |ISTMP#1| (CAR |args|))
                      (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|:|)
                           (PROGN (SETQ |x1| (CDR |ISTMP#1|)) #1#)))
                     (PROGN (SETQ |x2| (CDR |args|)) #1#))
                (CONS '|Union|
                      ((LAMBDA (|bfVar#52| |bfVar#51| |y|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#51|)
                                (PROGN (SETQ |y| (CAR |bfVar#51|)) NIL))
                            (RETURN (NREVERSE |bfVar#52|)))
                           (#1#
                            (SETQ |bfVar#52|
                                    (CONS
                                     (LIST '|:| (CADR |y|)
                                           (|getImports,import| (CADDR |y|)
                                            |template|))
                                     |bfVar#52|))))
                          (SETQ |bfVar#51| (CDR |bfVar#51|))))
                       NIL |args| NIL)))
               (#1#
                (CONS |op|
                      ((LAMBDA (|bfVar#54| |bfVar#53| |y|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#53|)
                                (PROGN (SETQ |y| (CAR |bfVar#53|)) NIL))
                            (RETURN (NREVERSE |bfVar#54|)))
                           (#1#
                            (SETQ |bfVar#54|
                                    (CONS (|getImports,import| |y| |template|)
                                          |bfVar#54|))))
                          (SETQ |bfVar#53| (CDR |bfVar#53|))))
                       NIL |args| NIL)))))
             (#1#
              (CONS |op|
                    ((LAMBDA (|bfVar#56| |bfVar#55| |y|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#55|)
                              (PROGN (SETQ |y| (CAR |bfVar#55|)) NIL))
                          (RETURN (NREVERSE |bfVar#56|)))
                         (#1#
                          (SETQ |bfVar#56|
                                  (CONS (|getImports,import| |y| |template|)
                                        |bfVar#56|))))
                        (SETQ |bfVar#55| (CDR |bfVar#55|))))
                     NIL |args| NIL)))))
      ((INTEGERP |x|) (|getImports,import| (ELT |template| |x|) |template|))
      ((EQ |x| '$) '$) ((EQ |x| '$$) '$$) ((STRINGP |x|) |x|)
      (#1# (|systemError| "bad argument in template"))))))

; getParentsFor(cname,formalParams,constructorCategory) ==
; --called by compDefineFunctor1
;   acc := nil
;   formals := TAKE(#formalParams,$TriangleVariableList)
;   constructorForm := GETDATABASE(cname, 'CONSTRUCTORFORM)
;   for x in folks constructorCategory repeat
;     x := SUBLISLIS(formalParams,formals,x)
;     x := SUBLISLIS(IFCDR constructorForm,formalParams,x)
;     acc := [:explodeIfs x,:acc]
;   NREVERSE acc

(DEFUN |getParentsFor| (|cname| |formalParams| |constructorCategory|)
  (PROG (|acc| |formals| |constructorForm|)
    (RETURN
     (PROGN
      (SETQ |acc| NIL)
      (SETQ |formals| (TAKE (LENGTH |formalParams|) |$TriangleVariableList|))
      (SETQ |constructorForm| (GETDATABASE |cname| 'CONSTRUCTORFORM))
      ((LAMBDA (|bfVar#57| |x|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#57|) (PROGN (SETQ |x| (CAR |bfVar#57|)) NIL))
            (RETURN NIL))
           ('T
            (PROGN
             (SETQ |x| (SUBLISLIS |formalParams| |formals| |x|))
             (SETQ |x|
                     (SUBLISLIS (IFCDR |constructorForm|) |formalParams| |x|))
             (SETQ |acc| (APPEND (|explodeIfs| |x|) |acc|)))))
          (SETQ |bfVar#57| (CDR |bfVar#57|))))
       (|folks| |constructorCategory|) NIL)
      (NREVERSE |acc|)))))

; parentsOf con == --called by kcpPage, ancestorsRecur
;   if null BOUNDP '$parentsCache then SETQ($parentsCache, MAKE_HASHTABLE('ID))
;   HGET($parentsCache,con) or
;     parents := getParentsForDomain con
;     HPUT($parentsCache,con,parents)
;     parents

(DEFUN |parentsOf| (|con|)
  (PROG (|parents|)
    (RETURN
     (PROGN
      (COND
       ((NULL (BOUNDP '|$parentsCache|))
        (SETQ |$parentsCache| (MAKE_HASHTABLE 'ID))))
      (OR (HGET |$parentsCache| |con|)
          (PROGN
           (SETQ |parents| (|getParentsForDomain| |con|))
           (HPUT |$parentsCache| |con| |parents|)
           |parents|))))))

; parentsOfForm [op,:argl] ==
;   parents := parentsOf op
;   null argl or argl = (newArgl := rest GETDATABASE(op,'CONSTRUCTORFORM)) =>
;     parents
;   SUBLISLIS(argl, newArgl, parents)

(DEFUN |parentsOfForm| (|bfVar#58|)
  (PROG (|op| |argl| |parents| |newArgl|)
    (RETURN
     (PROGN
      (SETQ |op| (CAR |bfVar#58|))
      (SETQ |argl| (CDR |bfVar#58|))
      (SETQ |parents| (|parentsOf| |op|))
      (COND
       ((OR (NULL |argl|)
            (EQUAL |argl|
                   (SETQ |newArgl| (CDR (GETDATABASE |op| 'CONSTRUCTORFORM)))))
        |parents|)
       ('T (SUBLISLIS |argl| |newArgl| |parents|)))))))

; getParentsForDomain domname  == --called by parentsOf
;   acc := nil
;   for x in folks GETDATABASE(domname,'CONSTRUCTORCATEGORY) repeat
;     x :=
;       GETDATABASE(domname,'CONSTRUCTORKIND) = 'category =>
;         sublisFormal(IFCDR getConstructorForm domname,x,$TriangleVariableList)
;       sublisFormal(IFCDR getConstructorForm domname,x)
;     acc := [:explodeIfs x,:acc]
;   NREVERSE acc

(DEFUN |getParentsForDomain| (|domname|)
  (PROG (|acc|)
    (RETURN
     (PROGN
      (SETQ |acc| NIL)
      ((LAMBDA (|bfVar#59| |x|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#59|) (PROGN (SETQ |x| (CAR |bfVar#59|)) NIL))
            (RETURN NIL))
           (#1='T
            (PROGN
             (SETQ |x|
                     (COND
                      ((EQ (GETDATABASE |domname| 'CONSTRUCTORKIND)
                           '|category|)
                       (|sublisFormal| (IFCDR (|getConstructorForm| |domname|))
                        |x| |$TriangleVariableList|))
                      (#1#
                       (|sublisFormal| (IFCDR (|getConstructorForm| |domname|))
                        |x|))))
             (SETQ |acc| (APPEND (|explodeIfs| |x|) |acc|)))))
          (SETQ |bfVar#59| (CDR |bfVar#59|))))
       (|folks| (GETDATABASE |domname| 'CONSTRUCTORCATEGORY)) NIL)
      (NREVERSE |acc|)))))

; explodeIfs x == main where  --called by getParents, getParentsForDomain
;   main ==
;     x is ['IF,p,a,b] => fn(p,a,b)
;     [[x,:true]]
;   fn(p,a,b) ==
;     [:"append"/[gn(p,y) for y in a],:"append"/[gn(['NOT,p],y) for y in b]]
;   gn(p,a) ==
;     a is ['IF,q,b,:.] => fn(MKPF([p,q],'AND),b,nil)
;     [[a,:p]]

(DEFUN |explodeIfs| (|x|)
  (PROG (|ISTMP#1| |p| |ISTMP#2| |a| |ISTMP#3| |b|)
    (RETURN
     (COND
      ((AND (CONSP |x|) (EQ (CAR |x|) 'IF)
            (PROGN
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |p| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|)
                        (PROGN
                         (SETQ |a| (CAR |ISTMP#2|))
                         (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                         (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                              (PROGN (SETQ |b| (CAR |ISTMP#3|)) #1='T))))))))
       (|explodeIfs,fn| |p| |a| |b|))
      (#1# (LIST (CONS |x| T)))))))
(DEFUN |explodeIfs,fn| (|p| |a| |b|)
  (PROG ()
    (RETURN
     (APPEND
      ((LAMBDA (|bfVar#61| |bfVar#60| |y|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#60|) (PROGN (SETQ |y| (CAR |bfVar#60|)) NIL))
            (RETURN |bfVar#61|))
           (#1='T
            (SETQ |bfVar#61| (APPEND |bfVar#61| (|explodeIfs,gn| |p| |y|)))))
          (SETQ |bfVar#60| (CDR |bfVar#60|))))
       NIL |a| NIL)
      ((LAMBDA (|bfVar#63| |bfVar#62| |y|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#62|) (PROGN (SETQ |y| (CAR |bfVar#62|)) NIL))
            (RETURN |bfVar#63|))
           (#1#
            (SETQ |bfVar#63|
                    (APPEND |bfVar#63|
                            (|explodeIfs,gn| (LIST 'NOT |p|) |y|)))))
          (SETQ |bfVar#62| (CDR |bfVar#62|))))
       NIL |b| NIL)))))
(DEFUN |explodeIfs,gn| (|p| |a|)
  (PROG (|ISTMP#1| |q| |ISTMP#2| |b|)
    (RETURN
     (COND
      ((AND (CONSP |a|) (EQ (CAR |a|) 'IF)
            (PROGN
             (SETQ |ISTMP#1| (CDR |a|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |q| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|)
                        (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1='T))))))
       (|explodeIfs,fn| (MKPF (LIST |p| |q|) 'AND) |b| NIL))
      (#1# (LIST (CONS |a| |p|)))))))

; folks u == --called by getParents and getParentsForDomain
;   atom u => nil
;   u is [op,:v] and MEMQ(op,'(Join PROGN))
;     or u is ['CATEGORY,a,:v] => "append"/[folks x for x in v]
;   u is ['SIGNATURE,:.] => nil
;   u is ['TYPE,:.] => nil
;   u is ['ATTRIBUTE,a] =>
;     PAIRP a and constructor? opOf a => folks a
;     nil
;   u is ['IF,p,q,r] =>
;     q1 := folks q
;     r1 := folks r
;     q1 or r1 => [['IF,p,q1,r1]]
;     nil
;   [u]

(DEFUN |folks| (|u|)
  (PROG (|op| |v| |ISTMP#1| |a| |p| |ISTMP#2| |q| |ISTMP#3| |r| |q1| |r1|)
    (RETURN
     (COND ((ATOM |u|) NIL)
           ((OR
             (AND (CONSP |u|)
                  (PROGN (SETQ |op| (CAR |u|)) (SETQ |v| (CDR |u|)) #1='T)
                  (MEMQ |op| '(|Join| PROGN)))
             (AND (CONSP |u|) (EQ (CAR |u|) 'CATEGORY)
                  (PROGN
                   (SETQ |ISTMP#1| (CDR |u|))
                   (AND (CONSP |ISTMP#1|)
                        (PROGN
                         (SETQ |a| (CAR |ISTMP#1|))
                         (SETQ |v| (CDR |ISTMP#1|))
                         #1#)))))
            ((LAMBDA (|bfVar#65| |bfVar#64| |x|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#64|)
                      (PROGN (SETQ |x| (CAR |bfVar#64|)) NIL))
                  (RETURN |bfVar#65|))
                 (#1# (SETQ |bfVar#65| (APPEND |bfVar#65| (|folks| |x|)))))
                (SETQ |bfVar#64| (CDR |bfVar#64|))))
             NIL |v| NIL))
           ((AND (CONSP |u|) (EQ (CAR |u|) 'SIGNATURE)) NIL)
           ((AND (CONSP |u|) (EQ (CAR |u|) 'TYPE)) NIL)
           ((AND (CONSP |u|) (EQ (CAR |u|) 'ATTRIBUTE)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |u|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                       (PROGN (SETQ |a| (CAR |ISTMP#1|)) #1#))))
            (COND
             ((AND (CONSP |a|) (|constructor?| (|opOf| |a|))) (|folks| |a|))
             (#1# NIL)))
           ((AND (CONSP |u|) (EQ (CAR |u|) 'IF)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |u|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |p| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|)
                             (PROGN
                              (SETQ |q| (CAR |ISTMP#2|))
                              (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                              (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                                   (PROGN
                                    (SETQ |r| (CAR |ISTMP#3|))
                                    #1#))))))))
            (PROGN
             (SETQ |q1| (|folks| |q|))
             (SETQ |r1| (|folks| |r|))
             (COND ((OR |q1| |r1|) (LIST (LIST 'IF |p| |q1| |r1|)))
                   (#1# NIL))))
           (#1# (LIST |u|))))))

; descendantsOf(conform,domform) ==  --called by kcdPage
;   'category = GETDATABASE((conname := opOf conform),'CONSTRUCTORKIND) =>
;     cats := catsOf(conform,domform)
;     [op,:argl] := conform
;     null argl or argl = (newArgl := rest (GETDATABASE(op,'CONSTRUCTORFORM)))
;         => cats
;     SUBLISLIS(argl, newArgl, cats)
;   'notAvailable

(DEFUN |descendantsOf| (|conform| |domform|)
  (PROG (|conname| |cats| |op| |argl| |newArgl|)
    (RETURN
     (COND
      ((EQ '|category|
           (GETDATABASE (SETQ |conname| (|opOf| |conform|)) 'CONSTRUCTORKIND))
       (PROGN
        (SETQ |cats| (|catsOf| |conform| |domform|))
        (SETQ |op| (CAR |conform|))
        (SETQ |argl| (CDR |conform|))
        (COND
         ((OR (NULL |argl|)
              (EQUAL |argl|
                     (SETQ |newArgl|
                             (CDR (GETDATABASE |op| 'CONSTRUCTORFORM)))))
          |cats|)
         (#1='T (SUBLISLIS |argl| |newArgl| |cats|)))))
      (#1# '|notAvailable|)))))

; childrenOf conform ==
;   [pair for pair in descendantsOf(conform,nil) |
;     childAssoc(conform,parentsOfForm first pair)]

(DEFUN |childrenOf| (|conform|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#67| |bfVar#66| |pair|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#66|) (PROGN (SETQ |pair| (CAR |bfVar#66|)) NIL))
           (RETURN (NREVERSE |bfVar#67|)))
          ('T
           (AND (|childAssoc| |conform| (|parentsOfForm| (CAR |pair|)))
                (SETQ |bfVar#67| (CONS |pair| |bfVar#67|)))))
         (SETQ |bfVar#66| (CDR |bfVar#66|))))
      NIL (|descendantsOf| |conform| NIL) NIL))))

; childAssoc(form,alist) ==
;   null (argl := rest form) => assoc(form, alist)
;   u := assocCar(opOf form, alist) => childArgCheck(argl, rest first u) and u
;   nil

(DEFUN |childAssoc| (|form| |alist|)
  (PROG (|argl| |u|)
    (RETURN
     (COND ((NULL (SETQ |argl| (CDR |form|))) (|assoc| |form| |alist|))
           ((SETQ |u| (|assocCar| (|opOf| |form|) |alist|))
            (AND (|childArgCheck| |argl| (CDR (CAR |u|))) |u|))
           ('T NIL)))))

; assocCar(x, al) == or/[pair for pair in al | x = CAAR pair]

(DEFUN |assocCar| (|x| |al|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#69| |bfVar#68| |pair|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#68|) (PROGN (SETQ |pair| (CAR |bfVar#68|)) NIL))
           (RETURN |bfVar#69|))
          ('T
           (AND (EQUAL |x| (CAAR |pair|))
                (PROGN
                 (SETQ |bfVar#69| |pair|)
                 (COND (|bfVar#69| (RETURN |bfVar#69|)))))))
         (SETQ |bfVar#68| (CDR |bfVar#68|))))
      NIL |al| NIL))))

; childArgCheck(argl, nargl) ==
;   and/[fn for x in argl for y in nargl for i in 0..] where
;     fn ==
;       x = y or constructor? opOf y => true
;       isSharpVar y => i = POSN1(y, $FormalMapVariableList)
;       false

(DEFUN |childArgCheck| (|argl| |nargl|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#72| |bfVar#70| |x| |bfVar#71| |y| |i|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#70|) (PROGN (SETQ |x| (CAR |bfVar#70|)) NIL)
               (ATOM |bfVar#71|) (PROGN (SETQ |y| (CAR |bfVar#71|)) NIL))
           (RETURN |bfVar#72|))
          (#1='T
           (PROGN
            (SETQ |bfVar#72|
                    (COND
                     ((OR (EQUAL |x| |y|) (|constructor?| (|opOf| |y|))) T)
                     ((|isSharpVar| |y|)
                      (EQUAL |i| (POSN1 |y| |$FormalMapVariableList|)))
                     (#1# NIL)))
            (COND ((NOT |bfVar#72|) (RETURN NIL))))))
         (SETQ |bfVar#70| (CDR |bfVar#70|))
         (SETQ |bfVar#71| (CDR |bfVar#71|))
         (SETQ |i| (+ |i| 1))))
      T |argl| NIL |nargl| NIL 0))))

; ancestors_of_cat(conform, domform) ==
;        conname := opOf(conform)
;        alist := GETDATABASE(conname,'ANCESTORS)
;        argl := IFCDR domform or IFCDR conform
;        [pair for [a,:b] in alist | pair] where pair ==
;          left :=  sublisFormal(argl,a)
;          right := sublisFormal(argl,b)
;          if domform then right := simpHasPred right
;          null right => false
;          [left,:right]

(DEFUN |ancestors_of_cat| (|conform| |domform|)
  (PROG (|conname| |alist| |argl| |a| |b| |left| |right|)
    (RETURN
     (PROGN
      (SETQ |conname| (|opOf| |conform|))
      (SETQ |alist| (GETDATABASE |conname| 'ANCESTORS))
      (SETQ |argl| (OR (IFCDR |domform|) (IFCDR |conform|)))
      ((LAMBDA (|bfVar#75| |bfVar#74| |bfVar#73|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#74|)
                (PROGN (SETQ |bfVar#73| (CAR |bfVar#74|)) NIL))
            (RETURN (NREVERSE |bfVar#75|)))
           (#1='T
            (AND (CONSP |bfVar#73|)
                 (PROGN
                  (SETQ |a| (CAR |bfVar#73|))
                  (SETQ |b| (CDR |bfVar#73|))
                  #1#)
                 #2=(PROGN
                     (SETQ |left| (|sublisFormal| |argl| |a|))
                     (SETQ |right| (|sublisFormal| |argl| |b|))
                     (COND (|domform| (SETQ |right| (|simpHasPred| |right|))))
                     (COND ((NULL |right|) NIL) (#1# (CONS |left| |right|))))
                 (SETQ |bfVar#75| (CONS #2# |bfVar#75|)))))
          (SETQ |bfVar#74| (CDR |bfVar#74|))))
       NIL |alist| NIL)))))

; ancestorsOf(conform,domform) ==  --called by kcaPage, originsInOrder,...
;   'category = GETDATABASE((conname := opOf(conform)), 'CONSTRUCTORKIND) =>
;        ancestors_of_cat(conform, domform)
;   computeAncestorsOf(conform,domform)

(DEFUN |ancestorsOf| (|conform| |domform|)
  (PROG (|conname|)
    (RETURN
     (COND
      ((EQ '|category|
           (GETDATABASE (SETQ |conname| (|opOf| |conform|)) 'CONSTRUCTORKIND))
       (|ancestors_of_cat| |conform| |domform|))
      ('T (|computeAncestorsOf| |conform| |domform|))))))

; computeAncestorsOf(conform,domform) ==
;   $done : local := MAKE_HASHTABLE('UEQUAL)
;   $if :   local := MAKE_HASHTABLE('ID)
;   ancestorsRecur(conform,domform,true,true)
;   acc := nil
;   for op in listSort(function GLESSEQP,HKEYS $if) repeat
;     for pair in HGET($if,op) repeat acc := [pair,:acc]
;   NREVERSE acc

(DEFUN |computeAncestorsOf| (|conform| |domform|)
  (PROG (|$if| |$done| |acc|)
    (DECLARE (SPECIAL |$if| |$done|))
    (RETURN
     (PROGN
      (SETQ |$done| (MAKE_HASHTABLE 'UEQUAL))
      (SETQ |$if| (MAKE_HASHTABLE 'ID))
      (|ancestorsRecur| |conform| |domform| T T)
      (SETQ |acc| NIL)
      ((LAMBDA (|bfVar#76| |op|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#76|) (PROGN (SETQ |op| (CAR |bfVar#76|)) NIL))
            (RETURN NIL))
           (#1='T
            ((LAMBDA (|bfVar#77| |pair|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#77|)
                      (PROGN (SETQ |pair| (CAR |bfVar#77|)) NIL))
                  (RETURN NIL))
                 (#1# (SETQ |acc| (CONS |pair| |acc|))))
                (SETQ |bfVar#77| (CDR |bfVar#77|))))
             (HGET |$if| |op|) NIL)))
          (SETQ |bfVar#76| (CDR |bfVar#76|))))
       (|listSort| #'GLESSEQP (HKEYS |$if|)) NIL)
      (NREVERSE |acc|)))))

; ancestorsRecur(conform,domform,pred,firstTime?) == --called by ancestorsOf
;   op      := opOf conform
;   pred = HGET($done,conform) => nil   --skip if already processed
;   parents :=
;     firstTime? and ($insideCategoryIfTrue or $insideFunctorIfTrue) =>
;       $lisplibParents
;     parentsOf op
;   originalConform :=
;     firstTime? and ($insideCategoryIfTrue or $insideFunctorIfTrue) =>
;         $functorForm
;     getConstructorForm op
;   if conform ~= originalConform then
;     parents := SUBLISLIS(IFCDR conform,IFCDR originalConform,parents)
;   for [newform,:p] in parents repeat
;     if domform and rest domform then
;       newdomform := SUBLISLIS(rest domform,rest conform,newform)
;       p          := SUBLISLIS(rest domform,rest conform,p)
;     newPred := quickAnd(pred,p)
;     ancestorsAdd(simpHasPred newPred,newdomform or newform)
;     ancestorsRecur(newform,newdomform,newPred,false)
;   HPUT($done,conform,pred)                  --mark as already processed

(DEFUN |ancestorsRecur| (|conform| |domform| |pred| |firstTime?|)
  (PROG (|op| |parents| |originalConform| |newform| |p| |newdomform| |newPred|)
    (RETURN
     (PROGN
      (SETQ |op| (|opOf| |conform|))
      (COND ((EQUAL |pred| (HGET |$done| |conform|)) NIL)
            (#1='T
             (PROGN
              (SETQ |parents|
                      (COND
                       ((AND |firstTime?|
                             (OR |$insideCategoryIfTrue|
                                 |$insideFunctorIfTrue|))
                        |$lisplibParents|)
                       (#1# (|parentsOf| |op|))))
              (SETQ |originalConform|
                      (COND
                       ((AND |firstTime?|
                             (OR |$insideCategoryIfTrue|
                                 |$insideFunctorIfTrue|))
                        |$functorForm|)
                       (#1# (|getConstructorForm| |op|))))
              (COND
               ((NOT (EQUAL |conform| |originalConform|))
                (SETQ |parents|
                        (SUBLISLIS (IFCDR |conform|) (IFCDR |originalConform|)
                         |parents|))))
              ((LAMBDA (|bfVar#79| |bfVar#78|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#79|)
                        (PROGN (SETQ |bfVar#78| (CAR |bfVar#79|)) NIL))
                    (RETURN NIL))
                   (#1#
                    (AND (CONSP |bfVar#78|)
                         (PROGN
                          (SETQ |newform| (CAR |bfVar#78|))
                          (SETQ |p| (CDR |bfVar#78|))
                          #1#)
                         (PROGN
                          (COND
                           ((AND |domform| (CDR |domform|))
                            (SETQ |newdomform|
                                    (SUBLISLIS (CDR |domform|) (CDR |conform|)
                                     |newform|))
                            (SETQ |p|
                                    (SUBLISLIS (CDR |domform|) (CDR |conform|)
                                     |p|))))
                          (SETQ |newPred| (|quickAnd| |pred| |p|))
                          (|ancestorsAdd| (|simpHasPred| |newPred|)
                           (OR |newdomform| |newform|))
                          (|ancestorsRecur| |newform| |newdomform| |newPred|
                           NIL)))))
                  (SETQ |bfVar#79| (CDR |bfVar#79|))))
               |parents| NIL)
              (HPUT |$done| |conform| |pred|))))))))

; ancestorsAdd(pred,form) == --called by ancestorsRecur
;   null pred => nil
;   op := IFCAR form or form
;   alist := HGET($if,op)
;   existingNode := assoc(form,alist) =>
;     RPLACD(existingNode, quickOr(rest existingNode, pred))
;   HPUT($if,op,[[form,:pred],:alist])

(DEFUN |ancestorsAdd| (|pred| |form|)
  (PROG (|op| |alist| |existingNode|)
    (RETURN
     (COND ((NULL |pred|) NIL)
           (#1='T
            (PROGN
             (SETQ |op| (OR (IFCAR |form|) |form|))
             (SETQ |alist| (HGET |$if| |op|))
             (COND
              ((SETQ |existingNode| (|assoc| |form| |alist|))
               (RPLACD |existingNode| (|quickOr| (CDR |existingNode|) |pred|)))
              (#1# (HPUT |$if| |op| (CONS (CONS |form| |pred|) |alist|))))))))))

; domainsOf(conform, domname) ==
;   conname := opOf conform
;   u := [key for key in HKEYS $has_category_hash
;     | key is [anc,: =conname]]
;   --u is list of pairs (a . b) where b = conname
;   --we sort u then replace each b by the predicate for which this is true
;   s := listSort(function GLESSEQP,COPY u)
;   s := [[first pair, :GETDATABASE(pair, 'HASCATEGORY)] for pair in s]
;   transKCatAlist(conform,domname,listSort(function GLESSEQP,s))

(DEFUN |domainsOf| (|conform| |domname|)
  (PROG (|conname| |anc| |u| |s|)
    (RETURN
     (PROGN
      (SETQ |conname| (|opOf| |conform|))
      (SETQ |u|
              ((LAMBDA (|bfVar#81| |bfVar#80| |key|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#80|)
                        (PROGN (SETQ |key| (CAR |bfVar#80|)) NIL))
                    (RETURN (NREVERSE |bfVar#81|)))
                   (#1='T
                    (AND (CONSP |key|) (PROGN (SETQ |anc| (CAR |key|)) #1#)
                         (EQUAL (CDR |key|) |conname|)
                         (SETQ |bfVar#81| (CONS |key| |bfVar#81|)))))
                  (SETQ |bfVar#80| (CDR |bfVar#80|))))
               NIL (HKEYS |$has_category_hash|) NIL))
      (SETQ |s| (|listSort| #'GLESSEQP (COPY |u|)))
      (SETQ |s|
              ((LAMBDA (|bfVar#83| |bfVar#82| |pair|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#82|)
                        (PROGN (SETQ |pair| (CAR |bfVar#82|)) NIL))
                    (RETURN (NREVERSE |bfVar#83|)))
                   (#1#
                    (SETQ |bfVar#83|
                            (CONS
                             (CONS (CAR |pair|)
                                   (GETDATABASE |pair| 'HASCATEGORY))
                             |bfVar#83|))))
                  (SETQ |bfVar#82| (CDR |bfVar#82|))))
               NIL |s| NIL))
      (|transKCatAlist| |conform| |domname| (|listSort| #'GLESSEQP |s|))))))

; catsOf(conform, domname) ==
;   conname := opOf conform
;   alist := nil
;   for key in allConstructors() repeat
;     for item in GETDATABASE(key,'ANCESTORS) | conname = CAAR item repeat
;       [[op,:args],:pred] := item
;       newItem :=
;         args => [[args,:pred],:LASSOC(key,alist)]
;         pred
;       alist := insertShortAlist(key,newItem,alist)
;   transKCatAlist(conform,domname,listSort(function GLESSEQP,alist))

(DEFUN |catsOf| (|conform| |domname|)
  (PROG (|conname| |alist| |op| |args| |pred| |newItem|)
    (RETURN
     (PROGN
      (SETQ |conname| (|opOf| |conform|))
      (SETQ |alist| NIL)
      ((LAMBDA (|bfVar#84| |key|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#84|) (PROGN (SETQ |key| (CAR |bfVar#84|)) NIL))
            (RETURN NIL))
           (#1='T
            ((LAMBDA (|bfVar#85| |item|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#85|)
                      (PROGN (SETQ |item| (CAR |bfVar#85|)) NIL))
                  (RETURN NIL))
                 (#1#
                  (AND (EQUAL |conname| (CAAR |item|))
                       (PROGN
                        (SETQ |op| (CAAR . #2=(|item|)))
                        (SETQ |args| (CDAR . #2#))
                        (SETQ |pred| (CDR |item|))
                        (SETQ |newItem|
                                (COND
                                 (|args|
                                  (CONS (CONS |args| |pred|)
                                        (LASSOC |key| |alist|)))
                                 (#1# |pred|)))
                        (SETQ |alist|
                                (|insertShortAlist| |key| |newItem|
                                 |alist|))))))
                (SETQ |bfVar#85| (CDR |bfVar#85|))))
             (GETDATABASE |key| 'ANCESTORS) NIL)))
          (SETQ |bfVar#84| (CDR |bfVar#84|))))
       (|allConstructors|) NIL)
      (|transKCatAlist| |conform| |domname| (|listSort| #'GLESSEQP |alist|))))))

; transKCatAlist(conform,domname,s) == main where
;   main ==
;     domname => --accept only exact matches after substitution
;       domargs := rest domname
;       acc := nil
;       rest conform =>
;         for pair in s repeat --pair has form [con,[conargs,:pred],...]]
;           leftForm := getConstructorForm first pair
;           for (ap := [args, :pred]) in rest pair repeat
;             match? :=
;               domargs = args => true
;               HAS_SHARP_VAR args => domargs = sublisFormal(IFCDR domname, args)
;               nil
;             null match? => 'skip
;             npred := sublisFormal(IFCDR leftForm, pred)
;             acc := [[leftForm,:npred],:acc]
;         NREVERSE acc
;       --conform has no arguments so each pair has form [con,:pred]
;       for pair in s repeat
;         leftForm := getConstructorForm first pair or systemError nil
;         RPLACA(pair,leftForm)
;         RPLACD(pair, sublisFormal(IFCDR leftForm, rest pair))
;       s
;     --no domname, so look for special argument combinations
;     acc := nil
;     IFCDR conform =>
;       farglist := TAKE(#rest conform,$FormalMapVariableList)
;       for pair in s repeat --pair has form [con,[conargs,:pred],...]]
;         leftForm := getConstructorForm first pair
;         for (ap := [args, :pred]) in rest pair repeat
;           hasArgsForm? := args ~= farglist
;           npred := sublisFormal(IFCDR leftForm, pred)
;           if hasArgsForm? then
;             subargs := sublisFormal(IFCDR leftForm, args)
;             hpred :=
; --            $hasArgsList => mkHasArgsPred subargs
;               ['hasArgs,:subargs]
;             npred := quickAnd(hpred,npred)
;           acc := [[leftForm,:npred],:acc]
;       NREVERSE acc
;     for pair in s repeat --pair has form [con,:pred]
;       leftForm := getConstructorForm first pair
;       RPLACA(pair,leftForm)
;       RPLACD(pair, sublisFormal(IFCDR leftForm, rest pair))
;     s

(DEFUN |transKCatAlist| (|conform| |domname| |s|)
  (PROG (|domargs| |acc| |leftForm| |args| |pred| |match?| |npred| |farglist|
         |hasArgsForm?| |subargs| |hpred|)
    (RETURN
     (COND
      (|domname|
       (PROGN
        (SETQ |domargs| (CDR |domname|))
        (SETQ |acc| NIL)
        (COND
         ((CDR |conform|)
          (PROGN
           ((LAMBDA (|bfVar#86| |pair|)
              (LOOP
               (COND
                ((OR (ATOM |bfVar#86|)
                     (PROGN (SETQ |pair| (CAR |bfVar#86|)) NIL))
                 (RETURN NIL))
                (#1='T
                 (PROGN
                  (SETQ |leftForm| (|getConstructorForm| (CAR |pair|)))
                  ((LAMBDA (|bfVar#87| |ap|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#87|)
                            (PROGN (SETQ |ap| (CAR |bfVar#87|)) NIL))
                        (RETURN NIL))
                       (#1#
                        (AND (CONSP |ap|)
                             (PROGN
                              (SETQ |args| (CAR |ap|))
                              (SETQ |pred| (CDR |ap|))
                              #1#)
                             (PROGN
                              (SETQ |match?|
                                      (COND ((EQUAL |domargs| |args|) T)
                                            ((HAS_SHARP_VAR |args|)
                                             (EQUAL |domargs|
                                                    (|sublisFormal|
                                                     (IFCDR |domname|)
                                                     |args|)))
                                            (#1# NIL)))
                              (COND ((NULL |match?|) '|skip|)
                                    (#1#
                                     (PROGN
                                      (SETQ |npred|
                                              (|sublisFormal|
                                               (IFCDR |leftForm|) |pred|))
                                      (SETQ |acc|
                                              (CONS (CONS |leftForm| |npred|)
                                                    |acc|)))))))))
                      (SETQ |bfVar#87| (CDR |bfVar#87|))))
                   (CDR |pair|) NIL))))
               (SETQ |bfVar#86| (CDR |bfVar#86|))))
            |s| NIL)
           (NREVERSE |acc|)))
         (#1#
          (PROGN
           ((LAMBDA (|bfVar#88| |pair|)
              (LOOP
               (COND
                ((OR (ATOM |bfVar#88|)
                     (PROGN (SETQ |pair| (CAR |bfVar#88|)) NIL))
                 (RETURN NIL))
                (#1#
                 (PROGN
                  (SETQ |leftForm|
                          (OR (|getConstructorForm| (CAR |pair|))
                              (|systemError| NIL)))
                  (RPLACA |pair| |leftForm|)
                  (RPLACD |pair|
                          (|sublisFormal| (IFCDR |leftForm|) (CDR |pair|))))))
               (SETQ |bfVar#88| (CDR |bfVar#88|))))
            |s| NIL)
           |s|)))))
      (#1#
       (PROGN
        (SETQ |acc| NIL)
        (COND
         ((IFCDR |conform|)
          (PROGN
           (SETQ |farglist|
                   (TAKE (LENGTH (CDR |conform|)) |$FormalMapVariableList|))
           ((LAMBDA (|bfVar#89| |pair|)
              (LOOP
               (COND
                ((OR (ATOM |bfVar#89|)
                     (PROGN (SETQ |pair| (CAR |bfVar#89|)) NIL))
                 (RETURN NIL))
                (#1#
                 (PROGN
                  (SETQ |leftForm| (|getConstructorForm| (CAR |pair|)))
                  ((LAMBDA (|bfVar#90| |ap|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#90|)
                            (PROGN (SETQ |ap| (CAR |bfVar#90|)) NIL))
                        (RETURN NIL))
                       (#1#
                        (AND (CONSP |ap|)
                             (PROGN
                              (SETQ |args| (CAR |ap|))
                              (SETQ |pred| (CDR |ap|))
                              #1#)
                             (PROGN
                              (SETQ |hasArgsForm?|
                                      (NOT (EQUAL |args| |farglist|)))
                              (SETQ |npred|
                                      (|sublisFormal| (IFCDR |leftForm|)
                                       |pred|))
                              (COND
                               (|hasArgsForm?|
                                (SETQ |subargs|
                                        (|sublisFormal| (IFCDR |leftForm|)
                                         |args|))
                                (SETQ |hpred| (CONS '|hasArgs| |subargs|))
                                (SETQ |npred| (|quickAnd| |hpred| |npred|))))
                              (SETQ |acc|
                                      (CONS (CONS |leftForm| |npred|)
                                            |acc|))))))
                      (SETQ |bfVar#90| (CDR |bfVar#90|))))
                   (CDR |pair|) NIL))))
               (SETQ |bfVar#89| (CDR |bfVar#89|))))
            |s| NIL)
           (NREVERSE |acc|)))
         (#1#
          (PROGN
           ((LAMBDA (|bfVar#91| |pair|)
              (LOOP
               (COND
                ((OR (ATOM |bfVar#91|)
                     (PROGN (SETQ |pair| (CAR |bfVar#91|)) NIL))
                 (RETURN NIL))
                (#1#
                 (PROGN
                  (SETQ |leftForm| (|getConstructorForm| (CAR |pair|)))
                  (RPLACA |pair| |leftForm|)
                  (RPLACD |pair|
                          (|sublisFormal| (IFCDR |leftForm|) (CDR |pair|))))))
               (SETQ |bfVar#91| (CDR |bfVar#91|))))
            |s| NIL)
           |s|)))))))))

; mkHasArgsPred subargs ==
; --$hasArgsList gives arguments of original constructor,e.g. LODO(A,M)
; --M is required to be Join(B,...); in looking for the domains of B
; --  we can find that if B has special value C, it can
;   systemError subargs

(DEFUN |mkHasArgsPred| (|subargs|) (PROG () (RETURN (|systemError| |subargs|))))

; sublisFormal(args,exp,:options) == main where
;   main ==  --use only on LIST structures; see also sublisFormalAlist
;     $formals: local := IFCAR options or $FormalMapVariableList
;     null args => exp
;     sublisFormal1(args,exp,#args - 1)
;   sublisFormal1(args,x,n) ==    --[sublisFormal1(args,y) for y in x]
;     x is [.,:.] =>
;       acc := nil
;       y := x
;       while null atom y repeat
;         acc := [sublisFormal1(args,QCAR y,n),:acc]
;         y := QCDR y
;       r := NREVERSE acc
;       if y then
;         nd := LASTNODE r
;         RPLACD(nd,sublisFormal1(args,y,n))
;       r
;     IDENTP x =>
;       j := or/[i for f in $formals for i in 0..n | EQ(f,x)] =>
;           args.j
;       x
;     x

(DEFUN |sublisFormal| (|args| |exp| &REST |options|)
  (PROG (|$formals|)
    (DECLARE (SPECIAL |$formals|))
    (RETURN
     (PROGN
      (SETQ |$formals| (OR (IFCAR |options|) |$FormalMapVariableList|))
      (COND ((NULL |args|) |exp|)
            ('T
             (|sublisFormal,sublisFormal1| |args| |exp|
              (- (LENGTH |args|) 1))))))))
(DEFUN |sublisFormal,sublisFormal1| (|args| |x| |n|)
  (PROG (DOT |acc| |y| |r| |nd| |j|)
    (RETURN
     (COND
      ((AND (CONSP |x|) (PROGN (SETQ DOT (CDR |x|)) #1='T))
       (PROGN
        (SETQ |acc| NIL)
        (SETQ |y| |x|)
        ((LAMBDA ()
           (LOOP
            (COND ((ATOM |y|) (RETURN NIL))
                  (#1#
                   (PROGN
                    (SETQ |acc|
                            (CONS
                             (|sublisFormal,sublisFormal1| |args| (QCAR |y|)
                              |n|)
                             |acc|))
                    (SETQ |y| (QCDR |y|))))))))
        (SETQ |r| (NREVERSE |acc|))
        (COND
         (|y| (SETQ |nd| (LASTNODE |r|))
          (RPLACD |nd| (|sublisFormal,sublisFormal1| |args| |y| |n|))))
        |r|))
      ((IDENTP |x|)
       (COND
        ((SETQ |j|
                 ((LAMBDA (|bfVar#93| |bfVar#92| |f| |i|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#92|)
                           (PROGN (SETQ |f| (CAR |bfVar#92|)) NIL) (> |i| |n|))
                       (RETURN |bfVar#93|))
                      (#1#
                       (AND (EQ |f| |x|)
                            (PROGN
                             (SETQ |bfVar#93| |i|)
                             (COND (|bfVar#93| (RETURN |bfVar#93|)))))))
                     (SETQ |bfVar#92| (CDR |bfVar#92|))
                     (SETQ |i| (+ |i| 1))))
                  NIL |$formals| NIL 0))
         (ELT |args| |j|))
        (#1# |x|)))
      (#1# |x|)))))

; buildDefaultPackageNamesHT() ==
;   $defaultPackageNamesHT := MAKE_HASHTABLE('EQUAL)
;   for nam in allConstructors() | isDefaultPackageName nam repeat
;     HPUT($defaultPackageNamesHT,nam,true)
;   $defaultPackageNamesHT

(DEFUN |buildDefaultPackageNamesHT| ()
  (PROG ()
    (RETURN
     (PROGN
      (SETQ |$defaultPackageNamesHT| (MAKE_HASHTABLE 'EQUAL))
      ((LAMBDA (|bfVar#94| |nam|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#94|) (PROGN (SETQ |nam| (CAR |bfVar#94|)) NIL))
            (RETURN NIL))
           ('T
            (AND (|isDefaultPackageName| |nam|)
                 (HPUT |$defaultPackageNamesHT| |nam| T))))
          (SETQ |bfVar#94| (CDR |bfVar#94|))))
       (|allConstructors|) NIL)
      |$defaultPackageNamesHT|))))

; $defaultPackageNamesHT := buildDefaultPackageNamesHT()

(EVAL-WHEN (EVAL LOAD)
  (SETQ |$defaultPackageNamesHT| (|buildDefaultPackageNamesHT|)))

; extendLocalLibdb conlist ==   --  called by astran
;   not $createLocalLibDb => nil
;   null conlist => nil
;   buildLibdb conlist          --> puts datafile into temp.text
;   $newConstructorList := union(conlist, $newConstructorList)
;   localLibdb := '"libdb.text"
;   not PROBE_-FILE '"libdb.text" =>
;     RENAME_-FILE('"temp.text",'"libdb.text")
;   oldlines := purgeNewConstructorLines(dbReadLines localLibdb, conlist)
;   newlines := dbReadLines '"temp.text"
;   dbWriteLines(MSORT union(oldlines,newlines), '"libdb.text")
;   maybe_delete_file('"temp.text")

(DEFUN |extendLocalLibdb| (|conlist|)
  (PROG (|localLibdb| |oldlines| |newlines|)
    (RETURN
     (COND ((NULL |$createLocalLibDb|) NIL) ((NULL |conlist|) NIL)
           (#1='T
            (PROGN
             (|buildLibdb| |conlist|)
             (SETQ |$newConstructorList|
                     (|union| |conlist| |$newConstructorList|))
             (SETQ |localLibdb| "libdb.text")
             (COND
              ((NULL (PROBE-FILE "libdb.text"))
               (RENAME-FILE "temp.text" "libdb.text"))
              (#1#
               (PROGN
                (SETQ |oldlines|
                        (|purgeNewConstructorLines|
                         (|dbReadLines| |localLibdb|) |conlist|))
                (SETQ |newlines| (|dbReadLines| "temp.text"))
                (|dbWriteLines| (MSORT (|union| |oldlines| |newlines|))
                 "libdb.text")
                (|maybe_delete_file| "temp.text"))))))))))
