
; )package "BOOT"

(IN-PACKAGE "BOOT")

; htSayConstructor(key, u) ==
;   u is ['CATEGORY,kind,:r] =>
;     htSayList(['"a ", kind, '" "])
;     htSayExplicitExports(r)
;   key = 'is =>
;     htSay '"the domain "
;     bcConform(u,true)
;   htSay
;     key = 'is => '"the domain "
;     kind := GETDATABASE(opOf u,'CONSTRUCTORKIND)
;     kind = 'domain => '"an element of "
;     '"a domain of "
;   u is ['Join,:middle,r] =>
;     rest middle =>
;       htSay '"categories "
;       bcConform(first middle,true)
;       for x in rest middle repeat
;         htSay '", "
;         bcConform(x,true)
;       r is ['CATEGORY,.,:r] =>
;         htSay '" and "
;         htSayExplicitExports(r)
;       htSay '" and "
;       bcConform(r,true)
;     htSay '"category "
;     bcConform(first middle,true)
;     r is ['CATEGORY,.,:r] =>
;      htSay '" "
;      htSayExplicitExports(r)
;     htSay '" and "
;     bcConform(r,true)
;   htSayList([kind, '" "])
;   bcConform(u, true)

(DEFUN |htSayConstructor| (|key| |u|)
  (PROG (|ISTMP#1| |kind| |r| |ISTMP#2| |middle|)
    (RETURN
     (COND
      ((AND (CONSP |u|) (EQ (CAR |u|) 'CATEGORY)
            (PROGN
             (SETQ |ISTMP#1| (CDR |u|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |kind| (CAR |ISTMP#1|))
                   (SETQ |r| (CDR |ISTMP#1|))
                   #1='T))))
       (PROGN
        (|htSayList| (LIST "a " |kind| " "))
        (|htSayExplicitExports| |r|)))
      ((EQ |key| '|is|) (PROGN (|htSay| "the domain ") (|bcConform| |u| T)))
      (#1#
       (PROGN
        (|htSay|
         (COND ((EQ |key| '|is|) "the domain ")
               (#1#
                (PROGN
                 (SETQ |kind| (GETDATABASE (|opOf| |u|) 'CONSTRUCTORKIND))
                 (COND ((EQ |kind| '|domain|) "an element of ")
                       (#1# "a domain of "))))))
        (COND
         ((AND (CONSP |u|) (EQ (CAR |u|) '|Join|)
               (PROGN
                (SETQ |ISTMP#1| (CDR |u|))
                (AND (CONSP |ISTMP#1|)
                     (PROGN (SETQ |ISTMP#2| (REVERSE |ISTMP#1|)) #1#)
                     (CONSP |ISTMP#2|)
                     (PROGN
                      (SETQ |r| (CAR |ISTMP#2|))
                      (SETQ |middle| (CDR |ISTMP#2|))
                      #1#)
                     (PROGN (SETQ |middle| (NREVERSE |middle|)) #1#))))
          (COND
           ((CDR |middle|)
            (PROGN
             (|htSay| "categories ")
             (|bcConform| (CAR |middle|) T)
             ((LAMBDA (|bfVar#1| |x|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#1|) (PROGN (SETQ |x| (CAR |bfVar#1|)) NIL))
                   (RETURN NIL))
                  (#1# (PROGN (|htSay| ", ") (|bcConform| |x| T))))
                 (SETQ |bfVar#1| (CDR |bfVar#1|))))
              (CDR |middle|) NIL)
             (COND
              ((AND (CONSP |r|) (EQ (CAR |r|) 'CATEGORY)
                    (PROGN
                     (SETQ |ISTMP#1| (CDR |r|))
                     (AND (CONSP |ISTMP#1|)
                          (PROGN (SETQ |r| (CDR |ISTMP#1|)) #1#))))
               (PROGN (|htSay| " and ") (|htSayExplicitExports| |r|)))
              (#1# (PROGN (|htSay| " and ") (|bcConform| |r| T))))))
           (#1#
            (PROGN
             (|htSay| "category ")
             (|bcConform| (CAR |middle|) T)
             (COND
              ((AND (CONSP |r|) (EQ (CAR |r|) 'CATEGORY)
                    (PROGN
                     (SETQ |ISTMP#1| (CDR |r|))
                     (AND (CONSP |ISTMP#1|)
                          (PROGN (SETQ |r| (CDR |ISTMP#1|)) #1#))))
               (PROGN (|htSay| " ") (|htSayExplicitExports| |r|)))
              (#1# (PROGN (|htSay| " and ") (|bcConform| |r| T))))))))
         (#1#
          (PROGN (|htSayList| (LIST |kind| " ")) (|bcConform| |u| T))))))))))

; htSayExplicitExports r ==
;   htSay '"with explicit exports"
;   $displayReturnValue => nil
;   htSay '":"
;   for x in r repeat
;     htSay '"\newline "
;     x is ['SIGNATURE,op,sig] =>
;       ops := escapeSpecialChars STRINGIMAGE op
;       htMakePage [['bcLinks,[ops,'"",'oPage,ops]]]
;       htSay '": "
;       bcConform ['Mapping,:sig]
;     x is ['ATTRIBUTE, a] => BREAK()
;     x is ['IF,:.] =>
;       htSay('"{\em if ...}")
;     systemError()

(DEFUN |htSayExplicitExports| (|r|)
  (PROG (|ISTMP#1| |op| |ISTMP#2| |sig| |ops| |a|)
    (RETURN
     (PROGN
      (|htSay| "with explicit exports")
      (COND (|$displayReturnValue| NIL)
            (#1='T
             (PROGN
              (|htSay| ":")
              ((LAMBDA (|bfVar#2| |x|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#2|)
                        (PROGN (SETQ |x| (CAR |bfVar#2|)) NIL))
                    (RETURN NIL))
                   (#1#
                    (PROGN
                     (|htSay| "\\newline ")
                     (COND
                      ((AND (CONSP |x|) (EQ (CAR |x|) 'SIGNATURE)
                            (PROGN
                             (SETQ |ISTMP#1| (CDR |x|))
                             (AND (CONSP |ISTMP#1|)
                                  (PROGN
                                   (SETQ |op| (CAR |ISTMP#1|))
                                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                   (AND (CONSP |ISTMP#2|)
                                        (EQ (CDR |ISTMP#2|) NIL)
                                        (PROGN
                                         (SETQ |sig| (CAR |ISTMP#2|))
                                         #1#))))))
                       (PROGN
                        (SETQ |ops| (|escapeSpecialChars| (STRINGIMAGE |op|)))
                        (|htMakePage|
                         (LIST
                          (LIST '|bcLinks| (LIST |ops| "" '|oPage| |ops|))))
                        (|htSay| ": ")
                        (|bcConform| (CONS '|Mapping| |sig|))))
                      ((AND (CONSP |x|) (EQ (CAR |x|) 'ATTRIBUTE)
                            (PROGN
                             (SETQ |ISTMP#1| (CDR |x|))
                             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                                  (PROGN (SETQ |a| (CAR |ISTMP#1|)) #1#))))
                       (BREAK))
                      ((AND (CONSP |x|) (EQ (CAR |x|) 'IF))
                       (|htSay| "{\\em if ...}"))
                      (#1# (|systemError|))))))
                  (SETQ |bfVar#2| (CDR |bfVar#2|))))
               |r| NIL))))))))

; displayBreakIntoAnds pred ==
;   pred is [op,:u] and member(op,'(and AND)) => u
;   [pred]

(DEFUN |displayBreakIntoAnds| (|pred|)
  (PROG (|op| |u|)
    (RETURN
     (COND
      ((AND (CONSP |pred|)
            (PROGN (SETQ |op| (CAR |pred|)) (SETQ |u| (CDR |pred|)) #1='T)
            (|member| |op| '(|and| AND)))
       |u|)
      (#1# (LIST |pred|))))))

; htSayValue t ==
;   t is ['Mapping,target,:source] =>
;       htSay('"a function from ")
;       htSayTuple source
;       htSay '" to "
;       htSayArgument target
;   t = '(Category) => htSay('"a category")
;   t is [op,:.] and MEMQ(op,'(Join CATEGORY)) or constructor? opOf t =>
;     htSayConstructor(nil,t)
;   htSay('"an element of domain ")
;   htSayArgument t                            --continue for operations

(DEFUN |htSayValue| (|t|)
  (PROG (|ISTMP#1| |target| |source| |op|)
    (RETURN
     (COND
      ((AND (CONSP |t|) (EQ (CAR |t|) '|Mapping|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |t|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |target| (CAR |ISTMP#1|))
                   (SETQ |source| (CDR |ISTMP#1|))
                   #1='T))))
       (PROGN
        (|htSay| "a function from ")
        (|htSayTuple| |source|)
        (|htSay| " to ")
        (|htSayArgument| |target|)))
      ((EQUAL |t| '(|Category|)) (|htSay| "a category"))
      ((OR
        (AND (CONSP |t|) (PROGN (SETQ |op| (CAR |t|)) #1#)
             (MEMQ |op| '(|Join| CATEGORY)))
        (|constructor?| (|opOf| |t|)))
       (|htSayConstructor| NIL |t|))
      (#1# (PROGN (|htSay| "an element of domain ") (|htSayArgument| |t|)))))))

; htSayArgument t == --called only for operations not for constructors
;   null $signature => htSay ['"{\em ",t,'"}"]
;   MEMQ(t, '(_$ _%)) =>
;     $conkind = '"category" and $conlength > 20 =>
;       $generalSearch? => htSay '"{\em D} of the origin category"
;       addWhereList("$",'is,nil)
;       htSayStandard '"{\em $}"
;     htSayStandard '"{\em $}"
;   not IDENTP t => bcConform(t,true)
;   k := position(t,$conargs)
;   if k > -1 then
;     typeOfArg := (rest $signature).k
;     addWhereList(t,'member,typeOfArg)
;   htSayList(['"{\em ", t, '"}"])

(DEFUN |htSayArgument| (|t|)
  (PROG (|k| |typeOfArg|)
    (RETURN
     (COND ((NULL |$signature|) (|htSay| (LIST "{\\em " |t| "}")))
           ((MEMQ |t| '($ %))
            (COND
             ((AND (EQUAL |$conkind| "category") (< 20 |$conlength|))
              (COND
               (|$generalSearch?| (|htSay| "{\\em D} of the origin category"))
               (#1='T
                (PROGN
                 (|addWhereList| '$ '|is| NIL)
                 (|htSayStandard| "{\\em $}")))))
             (#1# (|htSayStandard| "{\\em $}"))))
           ((NULL (IDENTP |t|)) (|bcConform| |t| T))
           (#1#
            (PROGN
             (SETQ |k| (|position| |t| |$conargs|))
             (COND
              ((< (- 1) |k|) (SETQ |typeOfArg| (ELT (CDR |$signature|) |k|))
               (|addWhereList| |t| '|member| |typeOfArg|)))
             (|htSayList| (LIST "{\\em " |t| "}"))))))))

; addWhereList(id,kind,typ) ==
;   $whereList := insert([id,kind,:typ],$whereList)

(DEFUN |addWhereList| (|id| |kind| |typ|)
  (PROG ()
    (RETURN
     (SETQ |$whereList|
             (|insert| (CONS |id| (CONS |kind| |typ|)) |$whereList|)))))

; htSayTuple t ==
;   null t => htSay '"()"
;   null rest t => htSayArgument first t
;   htSay '"("
;   htSayArgument first t
;   for d in rest t repeat
;     htSay '","
;     htSayArgument d
;   htSay '")"

(DEFUN |htSayTuple| (|t|)
  (PROG ()
    (RETURN
     (COND ((NULL |t|) (|htSay| "()"))
           ((NULL (CDR |t|)) (|htSayArgument| (CAR |t|)))
           (#1='T
            (PROGN
             (|htSay| "(")
             (|htSayArgument| (CAR |t|))
             ((LAMBDA (|bfVar#3| |d|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#3|) (PROGN (SETQ |d| (CAR |bfVar#3|)) NIL))
                   (RETURN NIL))
                  (#1# (PROGN (|htSay| ",") (|htSayArgument| |d|))))
                 (SETQ |bfVar#3| (CDR |bfVar#3|))))
              (CDR |t|) NIL)
             (|htSay| ")")))))))

; dbGetDisplayFormForOp(op,sig,doc) ==
;   dbGetFormFromDocumentation(op,sig,doc) or dbGetContrivedForm(op,sig)

(DEFUN |dbGetDisplayFormForOp| (|op| |sig| |doc|)
  (PROG ()
    (RETURN
     (OR (|dbGetFormFromDocumentation| |op| |sig| |doc|)
         (|dbGetContrivedForm| |op| |sig|)))))

; dbGetFormFromDocumentation(op,sig,x) ==
;   $ncMsgList : local := nil
;   $newcompErrorCount : local := 0
;   doc := (STRINGP x => x; first x)
;   STRINGP doc and
;      (stringPrefix?('"\spad{",doc) and (k := 6) or
;        stringPrefix?('"\s{",doc) and (k := 3)) =>
;     n := charPosition($charRbrace,doc,k)
;     s := SUBSTRING(doc,k,n - k)
;     parse := ncParseFromString s
;     parse is [=op,:.] and #parse = #sig => parse
;   nil

(DEFUN |dbGetFormFromDocumentation| (|op| |sig| |x|)
  (PROG (|$newcompErrorCount| |$ncMsgList| |parse| |s| |n| |k| |doc|)
    (DECLARE (SPECIAL |$newcompErrorCount| |$ncMsgList|))
    (RETURN
     (PROGN
      (SETQ |$ncMsgList| NIL)
      (SETQ |$newcompErrorCount| 0)
      (SETQ |doc| (COND ((STRINGP |x|) |x|) (#1='T (CAR |x|))))
      (COND
       ((AND (STRINGP |doc|)
             (OR (AND (|stringPrefix?| "\\spad{" |doc|) (SETQ |k| 6))
                 (AND (|stringPrefix?| "\\s{" |doc|) (SETQ |k| 3))))
        (PROGN
         (SETQ |n| (|charPosition| |$charRbrace| |doc| |k|))
         (SETQ |s| (SUBSTRING |doc| |k| (- |n| |k|)))
         (SETQ |parse| (|ncParseFromString| |s|))
         (COND
          ((AND (CONSP |parse|) (EQUAL (CAR |parse|) |op|)
                (EQL (LENGTH |parse|) (LENGTH |sig|)))
           |parse|))))
       (#1# NIL))))))

; dbMakeContrivedForm(op, sig) ==
;   $chooseDownCaseOfType : local := false
;   $NumberList : local := '(i j k l m n i1 j1 k1 l1 m1 n1 i2 j2 k2 l2 m2 n2 i3 j3 k3 l3 m3 n3 i4 j4 k4 l4 m4 n4 )
;   $ElementList: local := '(x y z u v w x1 y1 z1 u1 v1 w1 x2 y2 z2 u2 v2 w2 x3 y3 z3 u3 v3 w3 x4 y4 z4 u4 v4 w4 )
;   $FunctionList:local := '(f g h d e F G H)
;   $DomainList:  local := '(R S D E T A B C M N P Q U V W)
;   dbGetContrivedForm(op,sig)

(DEFUN |dbMakeContrivedForm| (|op| |sig|)
  (PROG (|$DomainList| |$FunctionList| |$ElementList| |$NumberList|
         |$chooseDownCaseOfType|)
    (DECLARE
     (SPECIAL |$DomainList| |$FunctionList| |$ElementList| |$NumberList|
      |$chooseDownCaseOfType|))
    (RETURN
     (PROGN
      (SETQ |$chooseDownCaseOfType| NIL)
      (SETQ |$NumberList|
              '(|i| |j| |k| |l| |m| |n| |i1| |j1| |k1| |l1| |m1| |n1| |i2| |j2|
                |k2| |l2| |m2| |n2| |i3| |j3| |k3| |l3| |m3| |n3| |i4| |j4|
                |k4| |l4| |m4| |n4|))
      (SETQ |$ElementList|
              '(|x| |y| |z| |u| |v| |w| |x1| |y1| |z1| |u1| |v1| |w1| |x2| |y2|
                |z2| |u2| |v2| |w2| |x3| |y3| |z3| |u3| |v3| |w3| |x4| |y4|
                |z4| |u4| |v4| |w4|))
      (SETQ |$FunctionList| '(|f| |g| |h| |d| |e| F G H))
      (SETQ |$DomainList| '(R S D E T A B C M N P Q U V W))
      (|dbGetContrivedForm| |op| |sig|)))))

; dbGetContrivedForm(op,sig) ==
;   op = '"0" => [0]
;   op = '"1" => [1]
;   [op,:[dbChooseOperandName s for s in rest sig]]

(DEFUN |dbGetContrivedForm| (|op| |sig|)
  (PROG ()
    (RETURN
     (COND ((EQUAL |op| "0") (LIST 0)) ((EQUAL |op| "1") (LIST 1))
           (#1='T
            (CONS |op|
                  ((LAMBDA (|bfVar#5| |bfVar#4| |s|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#4|)
                            (PROGN (SETQ |s| (CAR |bfVar#4|)) NIL))
                        (RETURN (NREVERSE |bfVar#5|)))
                       (#1#
                        (SETQ |bfVar#5|
                                (CONS (|dbChooseOperandName| |s|) |bfVar#5|))))
                      (SETQ |bfVar#4| (CDR |bfVar#4|))))
                   NIL (CDR |sig|) NIL)))))))

; dbChooseOperandName(typ) ==
;   typ is ['Mapping,:.] =>
;     x := first $FunctionList
;     $FunctionList := rest $FunctionList
;     x
;   name := opOf typ
;   kind :=
;     name = "$" => 'domain
;     GETDATABASE(name,'CONSTRUCTORKIND)
;   s := PNAME opOf typ
;   kind ~= 'category =>
;     anySubstring?('"Integer",s,0) or anySubstring?('"Number",s,0) =>
;       x := first $NumberList
;       $NumberList := rest $NumberList
;       x
;     x :=
;       $chooseDownCaseOfType =>
;         y := DOWNCASE typ
;         x :=
;           member(y,$ElementList) => y
;           first $ElementList
;       first $ElementList
;     $ElementList := delete(x,$ElementList)
;     x
;   x := first $DomainList
;   $DomainList := rest $DomainList
;   x

(DEFUN |dbChooseOperandName| (|typ|)
  (PROG (|x| |name| |kind| |s| |y|)
    (RETURN
     (COND
      ((AND (CONSP |typ|) (EQ (CAR |typ|) '|Mapping|))
       (PROGN
        (SETQ |x| (CAR |$FunctionList|))
        (SETQ |$FunctionList| (CDR |$FunctionList|))
        |x|))
      (#1='T
       (PROGN
        (SETQ |name| (|opOf| |typ|))
        (SETQ |kind|
                (COND ((EQ |name| '$) '|domain|)
                      (#1# (GETDATABASE |name| 'CONSTRUCTORKIND))))
        (SETQ |s| (PNAME (|opOf| |typ|)))
        (COND
         ((NOT (EQ |kind| '|category|))
          (COND
           ((OR (|anySubstring?| "Integer" |s| 0)
                (|anySubstring?| "Number" |s| 0))
            (PROGN
             (SETQ |x| (CAR |$NumberList|))
             (SETQ |$NumberList| (CDR |$NumberList|))
             |x|))
           (#1#
            (PROGN
             (SETQ |x|
                     (COND
                      (|$chooseDownCaseOfType|
                       (PROGN
                        (SETQ |y| (DOWNCASE |typ|))
                        (SETQ |x|
                                (COND ((|member| |y| |$ElementList|) |y|)
                                      (#1# (CAR |$ElementList|))))))
                      (#1# (CAR |$ElementList|))))
             (SETQ |$ElementList| (|delete| |x| |$ElementList|))
             |x|))))
         (#1#
          (PROGN
           (SETQ |x| (CAR |$DomainList|))
           (SETQ |$DomainList| (CDR |$DomainList|))
           |x|)))))))))

; getSubstSigIfPossible sig ==
;   getSubstSignature sig or sig

(DEFUN |getSubstSigIfPossible| (|sig|)
  (PROG () (RETURN (OR (|getSubstSignature| |sig|) |sig|))))

; fullSubstitute(x,y,z) ==  --substitutes deeply: x for y in list z
;   z = y => x
;   atom z => z
;   [fullSubstitute(x,y,u) for u in z]

(DEFUN |fullSubstitute| (|x| |y| |z|)
  (PROG ()
    (RETURN
     (COND ((EQUAL |z| |y|) |x|) ((ATOM |z|) |z|)
           (#1='T
            ((LAMBDA (|bfVar#7| |bfVar#6| |u|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#6|) (PROGN (SETQ |u| (CAR |bfVar#6|)) NIL))
                  (RETURN (NREVERSE |bfVar#7|)))
                 (#1#
                  (SETQ |bfVar#7|
                          (CONS (|fullSubstitute| |x| |y| |u|) |bfVar#7|))))
                (SETQ |bfVar#6| (CDR |bfVar#6|))))
             NIL |z| NIL))))))

; getSubstCandidates sig ==
;   candidates := nil
;   for x in sig for i in 1.. | x is [.,.,:.] repeat
;     getSubstQualify(x,i,sig) => candidates := getSubstInsert(x,candidates)
;     y := or/[getSubstQualify(y,i,sig) for y in rest x | y is [.,.,:.]] =>
;       candidates := insert(y,candidates)
;   candidates

(DEFUN |getSubstCandidates| (|sig|)
  (PROG (|candidates| |ISTMP#1| DOT |y|)
    (RETURN
     (PROGN
      (SETQ |candidates| NIL)
      ((LAMBDA (|bfVar#8| |x| |i|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#8|) (PROGN (SETQ |x| (CAR |bfVar#8|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |x|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |x|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN (SETQ DOT (CDR |ISTMP#1|)) #1#)))
                 (COND
                  ((|getSubstQualify| |x| |i| |sig|)
                   (SETQ |candidates| (|getSubstInsert| |x| |candidates|)))
                  ((SETQ |y|
                           ((LAMBDA (|bfVar#10| |bfVar#9| |y|)
                              (LOOP
                               (COND
                                ((OR (ATOM |bfVar#9|)
                                     (PROGN (SETQ |y| (CAR |bfVar#9|)) NIL))
                                 (RETURN |bfVar#10|))
                                (#1#
                                 (AND (CONSP |y|)
                                      (PROGN
                                       (SETQ |ISTMP#1| (CDR |y|))
                                       (AND (CONSP |ISTMP#1|)
                                            (PROGN
                                             (SETQ DOT (CDR |ISTMP#1|))
                                             #1#)))
                                      (PROGN
                                       (SETQ |bfVar#10|
                                               (|getSubstQualify| |y| |i|
                                                |sig|))
                                       (COND
                                        (|bfVar#10| (RETURN |bfVar#10|)))))))
                               (SETQ |bfVar#9| (CDR |bfVar#9|))))
                            NIL (CDR |x|) NIL))
                   (SETQ |candidates| (|insert| |y| |candidates|)))))))
          (SETQ |bfVar#8| (CDR |bfVar#8|))
          (SETQ |i| (+ |i| 1))))
       |sig| NIL 1)
      |candidates|))))

; getSubstSignature sig ==
;     candidates := getSubstCandidates sig
;     null candidates => nil
;     D := first $DomainList
;     $DomainList := rest $DomainList
;     winner := first candidates
;     newsig := fullSubstitute(D,winner,sig)
;     sig :=
;       null rest candidates => newsig
;       count := NUMOFNODES newsig
;       for x in rest candidates repeat
;         trial := fullSubstitute(D,x,sig)
;         trialCount := NUMOFNODES trial
;         trialCount < count =>
;           newsig := trial
;           count  := trialCount
;           winner := x
;       newsig
;     addWhereList(D,'is,winner)
;     newsig

(DEFUN |getSubstSignature| (|sig|)
  (PROG (|candidates| D |winner| |newsig| |count| |trial| |trialCount|)
    (RETURN
     (PROGN
      (SETQ |candidates| (|getSubstCandidates| |sig|))
      (COND ((NULL |candidates|) NIL)
            (#1='T
             (PROGN
              (SETQ D (CAR |$DomainList|))
              (SETQ |$DomainList| (CDR |$DomainList|))
              (SETQ |winner| (CAR |candidates|))
              (SETQ |newsig| (|fullSubstitute| D |winner| |sig|))
              (SETQ |sig|
                      (COND ((NULL (CDR |candidates|)) |newsig|)
                            (#1#
                             (PROGN
                              (SETQ |count| (NUMOFNODES |newsig|))
                              ((LAMBDA (|bfVar#11| |x|)
                                 (LOOP
                                  (COND
                                   ((OR (ATOM |bfVar#11|)
                                        (PROGN
                                         (SETQ |x| (CAR |bfVar#11|))
                                         NIL))
                                    (RETURN NIL))
                                   (#1#
                                    (PROGN
                                     (SETQ |trial|
                                             (|fullSubstitute| D |x| |sig|))
                                     (SETQ |trialCount| (NUMOFNODES |trial|))
                                     (COND
                                      ((< |trialCount| |count|)
                                       (PROGN
                                        (SETQ |newsig| |trial|)
                                        (SETQ |count| |trialCount|)
                                        (SETQ |winner| |x|)))))))
                                  (SETQ |bfVar#11| (CDR |bfVar#11|))))
                               (CDR |candidates|) NIL)
                              |newsig|))))
              (|addWhereList| D '|is| |winner|)
              |newsig|)))))))

; getSubstQualify(x,i,sig) ==
;     or/[CONTAINED(x,y) for y in sig for j in 1.. | j ~= i] => x
;     false

(DEFUN |getSubstQualify| (|x| |i| |sig|)
  (PROG ()
    (RETURN
     (COND
      (((LAMBDA (|bfVar#13| |bfVar#12| |y| |j|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#12|) (PROGN (SETQ |y| (CAR |bfVar#12|)) NIL))
             (RETURN |bfVar#13|))
            (#1='T
             (AND (NOT (EQUAL |j| |i|))
                  (PROGN
                   (SETQ |bfVar#13| (CONTAINED |x| |y|))
                   (COND (|bfVar#13| (RETURN |bfVar#13|)))))))
           (SETQ |bfVar#12| (CDR |bfVar#12|))
           (SETQ |j| (+ |j| 1))))
        NIL |sig| NIL 1)
       |x|)
      (#1# NIL)))))

; getSubstInsert(x,candidates) ==
;     return insert(x,candidates)
;     null candidates => [x]
;     or/[CONTAINED(x,y) for y in candidates] => candidates
;     y := or/[CONTAINED(y, x) for y in candidates] =>
;         substitute(x, y, candidates)
;     candidates

(DEFUN |getSubstInsert| (|x| |candidates|)
  (PROG (|y|)
    (RETURN
     (PROGN
      (RETURN (|insert| |x| |candidates|))
      (COND ((NULL |candidates|) (LIST |x|))
            (((LAMBDA (|bfVar#15| |bfVar#14| |y|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#14|)
                       (PROGN (SETQ |y| (CAR |bfVar#14|)) NIL))
                   (RETURN |bfVar#15|))
                  (#1='T
                   (PROGN
                    (SETQ |bfVar#15| (CONTAINED |x| |y|))
                    (COND (|bfVar#15| (RETURN |bfVar#15|))))))
                 (SETQ |bfVar#14| (CDR |bfVar#14|))))
              NIL |candidates| NIL)
             |candidates|)
            ((SETQ |y|
                     ((LAMBDA (|bfVar#17| |bfVar#16| |y|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#16|)
                               (PROGN (SETQ |y| (CAR |bfVar#16|)) NIL))
                           (RETURN |bfVar#17|))
                          (#1#
                           (PROGN
                            (SETQ |bfVar#17| (CONTAINED |y| |x|))
                            (COND (|bfVar#17| (RETURN |bfVar#17|))))))
                         (SETQ |bfVar#16| (CDR |bfVar#16|))))
                      NIL |candidates| NIL))
             (|substitute| |x| |y| |candidates|))
            (#1# |candidates|))))))

; whoUsesOperation(htPage,which,key) ==  --see dbPresentOps
;   key = 'filter => koaPageFilterByName(htPage,'whoUsesOperation)
;   opAlist := htpProperty(htPage,'opAlist)
;   conform := htpProperty(htPage,'conform)
;   conargs := rest conform
;   opl := nil
;   for [op,:alist] in opAlist repeat
;     for [sig,:.] in alist repeat
;       opl := [[op,:SUBLISLIS($FormalMapVariableList,rest conform,sig)],:opl]
;   opl := NREVERSE opl
;   u := whoUses(opl,conform)
;   prefix := pluralSay(#u,'"constructor uses",'"constructors use")
;   suffix :=
;     opAlist is [[op1,.]] =>
;       ['" operation {\em ",escapeSpecialChars STRINGIMAGE op1,'":",form2HtString ['Mapping,:sig],'"}"]
;     ['" these operations"]
;   page := htInitPage([:prefix,:suffix],htCopyProplist htPage)
;   nopAlist := nil
;   for [name,:opsigList] in u repeat
;     for opsig in opsigList repeat
;       sofar    := LASSOC(opsig,nopAlist)
;       nopAlist := insertAlist(opsig,[name,:LASSOC(opsig,nopAlist)],nopAlist)
;   usedList := nil
;   for [pair := [op,:sig],:namelist] in nopAlist repeat
;     ops := escapeSpecialChars STRINGIMAGE op
;     usedList := [pair,:usedList]
;     htSayList(['"Users of {\em ", ops, '": "])
;     bcConform ['Mapping,:sublisFormal(conargs,sig)]
;     htSay('"}\newline")
;     bcConTable listSort(function GLESSEQP,REMDUP namelist)
;   noOneUses := SETDIFFERENCE(opl,usedList)
;   if #noOneUses > 0 then
;     htSay('"No constructor uses the ")
;     htSay
;       #noOneUses = 1 => '"operation: "
;       [#noOneUses,'" operations:"]
;     htSay '"\newline "
;     for [op,:sig] in noOneUses repeat
;       htSayList(['"\tab{2}{\em ", escapeSpecialChars STRINGIMAGE op, '": "])
;       bcConform ['Mapping,:sublisFormal(conargs,sig)]
;       htSay('"}\newline")
;   htSayStandard '"\endscroll "
;   dbPresentOps(page,which,'usage)
;   htShowPageNoScroll()

(DEFUN |whoUsesOperation| (|htPage| |which| |key|)
  (PROG (|opAlist| |conform| |conargs| |opl| |op| |alist| |sig| |u| |prefix|
         |ISTMP#1| |op1| |ISTMP#2| |suffix| |page| |nopAlist| |name|
         |opsigList| |sofar| |usedList| |pair| |namelist| |ops| |noOneUses|)
    (RETURN
     (COND
      ((EQ |key| '|filter|)
       (|koaPageFilterByName| |htPage| '|whoUsesOperation|))
      (#1='T
       (PROGN
        (SETQ |opAlist| (|htpProperty| |htPage| '|opAlist|))
        (SETQ |conform| (|htpProperty| |htPage| '|conform|))
        (SETQ |conargs| (CDR |conform|))
        (SETQ |opl| NIL)
        ((LAMBDA (|bfVar#19| |bfVar#18|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#19|)
                  (PROGN (SETQ |bfVar#18| (CAR |bfVar#19|)) NIL))
              (RETURN NIL))
             (#1#
              (AND (CONSP |bfVar#18|)
                   (PROGN
                    (SETQ |op| (CAR |bfVar#18|))
                    (SETQ |alist| (CDR |bfVar#18|))
                    #1#)
                   ((LAMBDA (|bfVar#21| |bfVar#20|)
                      (LOOP
                       (COND
                        ((OR (ATOM |bfVar#21|)
                             (PROGN (SETQ |bfVar#20| (CAR |bfVar#21|)) NIL))
                         (RETURN NIL))
                        (#1#
                         (AND (CONSP |bfVar#20|)
                              (PROGN (SETQ |sig| (CAR |bfVar#20|)) #1#)
                              (SETQ |opl|
                                      (CONS
                                       (CONS |op|
                                             (SUBLISLIS
                                              |$FormalMapVariableList|
                                              (CDR |conform|) |sig|))
                                       |opl|)))))
                       (SETQ |bfVar#21| (CDR |bfVar#21|))))
                    |alist| NIL))))
            (SETQ |bfVar#19| (CDR |bfVar#19|))))
         |opAlist| NIL)
        (SETQ |opl| (NREVERSE |opl|))
        (SETQ |u| (|whoUses| |opl| |conform|))
        (SETQ |prefix|
                (|pluralSay| (LENGTH |u|) "constructor uses"
                 "constructors use"))
        (SETQ |suffix|
                (COND
                 ((AND (CONSP |opAlist|) (EQ (CDR |opAlist|) NIL)
                       (PROGN
                        (SETQ |ISTMP#1| (CAR |opAlist|))
                        (AND (CONSP |ISTMP#1|)
                             (PROGN
                              (SETQ |op1| (CAR |ISTMP#1|))
                              (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                              (AND (CONSP |ISTMP#2|)
                                   (EQ (CDR |ISTMP#2|) NIL))))))
                  (LIST " operation {\\em "
                        (|escapeSpecialChars| (STRINGIMAGE |op1|)) ":"
                        (|form2HtString| (CONS '|Mapping| |sig|)) "}"))
                 (#1# (LIST " these operations"))))
        (SETQ |page|
                (|htInitPage| (APPEND |prefix| |suffix|)
                 (|htCopyProplist| |htPage|)))
        (SETQ |nopAlist| NIL)
        ((LAMBDA (|bfVar#23| |bfVar#22|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#23|)
                  (PROGN (SETQ |bfVar#22| (CAR |bfVar#23|)) NIL))
              (RETURN NIL))
             (#1#
              (AND (CONSP |bfVar#22|)
                   (PROGN
                    (SETQ |name| (CAR |bfVar#22|))
                    (SETQ |opsigList| (CDR |bfVar#22|))
                    #1#)
                   ((LAMBDA (|bfVar#24| |opsig|)
                      (LOOP
                       (COND
                        ((OR (ATOM |bfVar#24|)
                             (PROGN (SETQ |opsig| (CAR |bfVar#24|)) NIL))
                         (RETURN NIL))
                        (#1#
                         (PROGN
                          (SETQ |sofar| (LASSOC |opsig| |nopAlist|))
                          (SETQ |nopAlist|
                                  (|insertAlist| |opsig|
                                   (CONS |name| (LASSOC |opsig| |nopAlist|))
                                   |nopAlist|)))))
                       (SETQ |bfVar#24| (CDR |bfVar#24|))))
                    |opsigList| NIL))))
            (SETQ |bfVar#23| (CDR |bfVar#23|))))
         |u| NIL)
        (SETQ |usedList| NIL)
        ((LAMBDA (|bfVar#26| |bfVar#25|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#26|)
                  (PROGN (SETQ |bfVar#25| (CAR |bfVar#26|)) NIL))
              (RETURN NIL))
             (#1#
              (AND (CONSP |bfVar#25|)
                   (PROGN
                    (SETQ |ISTMP#1| #2=(CAR |bfVar#25|))
                    (AND (CONSP |ISTMP#1|)
                         (PROGN
                          (SETQ |op| (CAR |ISTMP#1|))
                          (SETQ |sig| (CDR |ISTMP#1|))
                          #1#)))
                   (PROGN (SETQ |pair| #2#) #1#)
                   (PROGN (SETQ |namelist| (CDR |bfVar#25|)) #1#)
                   (PROGN
                    (SETQ |ops| (|escapeSpecialChars| (STRINGIMAGE |op|)))
                    (SETQ |usedList| (CONS |pair| |usedList|))
                    (|htSayList| (LIST "Users of {\\em " |ops| ": "))
                    (|bcConform|
                     (CONS '|Mapping| (|sublisFormal| |conargs| |sig|)))
                    (|htSay| "}\\newline")
                    (|bcConTable|
                     (|listSort| #'GLESSEQP (REMDUP |namelist|)))))))
            (SETQ |bfVar#26| (CDR |bfVar#26|))))
         |nopAlist| NIL)
        (SETQ |noOneUses| (SETDIFFERENCE |opl| |usedList|))
        (COND
         ((< 0 (LENGTH |noOneUses|)) (|htSay| "No constructor uses the ")
          (|htSay|
           (COND ((EQL (LENGTH |noOneUses|) 1) "operation: ")
                 (#1# (LIST (LENGTH |noOneUses|) " operations:"))))
          (|htSay| "\\newline ")
          ((LAMBDA (|bfVar#28| |bfVar#27|)
             (LOOP
              (COND
               ((OR (ATOM |bfVar#28|)
                    (PROGN (SETQ |bfVar#27| (CAR |bfVar#28|)) NIL))
                (RETURN NIL))
               (#1#
                (AND (CONSP |bfVar#27|)
                     (PROGN
                      (SETQ |op| (CAR |bfVar#27|))
                      (SETQ |sig| (CDR |bfVar#27|))
                      #1#)
                     (PROGN
                      (|htSayList|
                       (LIST "\\tab{2}{\\em "
                             (|escapeSpecialChars| (STRINGIMAGE |op|)) ": "))
                      (|bcConform|
                       (CONS '|Mapping| (|sublisFormal| |conargs| |sig|)))
                      (|htSay| "}\\newline")))))
              (SETQ |bfVar#28| (CDR |bfVar#28|))))
           |noOneUses| NIL)))
        (|htSayStandard| "\\endscroll ")
        (|dbPresentOps| |page| |which| '|usage|)
        (|htShowPageNoScroll|)))))))

; whoUses(opSigList,conform) ==
;   opList := REMDUP ASSOCLEFT opSigList
;   numOfArgsList := REMDUP [-1 + #sig for [.,:sig] in opSigList]
;   acc  := nil
;   $conname : local := first conform
;   domList := getUsersOfConstructor $conname
;   for name in domList repeat
;     $infovec : local := dbInfovec name
;     null $infovec => 'skip           --category
;     template := $infovec . 0
;     numvec := getCodeVector1($infovec)
;     opacc := nil
;     for i in 7..MAXINDEX template repeat
;       item := template . i
;       item isnt [n,:op] or not MEMQ(op,opList) => 'skip
;       index := n
;       numOfArgs := numvec . index
;       null member(numOfArgs,numOfArgsList) => 'skip
;       whereNumber := numvec.(index := index + 1)
;       template . whereNumber isnt [= $conname,:.] => 'skip
;       signumList := dcSig(numvec,index + 1,numOfArgs)
;       opsig := or/[pair for (pair := [op1,:sig]) in opSigList |
;                    op1 = op and whoUsesMatch?(signumList,sig,nil)]
;       if opsig then opacc := [opsig,:opacc]
;     if opacc then acc := [[name,:opacc],:acc]
;   acc

(DEFUN |whoUses| (|opSigList| |conform|)
  (PROG (|$infovec| |$conname| |opsig| |op1| |signumList| |ISTMP#1|
         |whereNumber| |numOfArgs| |index| |op| |n| |item| |opacc| |numvec|
         |template| |domList| |acc| |numOfArgsList| |sig| |opList|)
    (DECLARE (SPECIAL |$infovec| |$conname|))
    (RETURN
     (PROGN
      (SETQ |opList| (REMDUP (ASSOCLEFT |opSigList|)))
      (SETQ |numOfArgsList|
              (REMDUP
               ((LAMBDA (|bfVar#31| |bfVar#30| |bfVar#29|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#30|)
                         (PROGN (SETQ |bfVar#29| (CAR |bfVar#30|)) NIL))
                     (RETURN (NREVERSE |bfVar#31|)))
                    (#1='T
                     (AND (CONSP |bfVar#29|)
                          (PROGN (SETQ |sig| (CDR |bfVar#29|)) #1#)
                          (SETQ |bfVar#31|
                                  (CONS (+ (- 1) (LENGTH |sig|))
                                        |bfVar#31|)))))
                   (SETQ |bfVar#30| (CDR |bfVar#30|))))
                NIL |opSigList| NIL)))
      (SETQ |acc| NIL)
      (SETQ |$conname| (CAR |conform|))
      (SETQ |domList| (|getUsersOfConstructor| |$conname|))
      ((LAMBDA (|bfVar#32| |name|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#32|) (PROGN (SETQ |name| (CAR |bfVar#32|)) NIL))
            (RETURN NIL))
           (#1#
            (PROGN
             (SETQ |$infovec| (|dbInfovec| |name|))
             (COND ((NULL |$infovec|) '|skip|)
                   (#1#
                    (PROGN
                     (SETQ |template| (ELT |$infovec| 0))
                     (SETQ |numvec| (|getCodeVector1| |$infovec|))
                     (SETQ |opacc| NIL)
                     ((LAMBDA (|bfVar#33| |i|)
                        (LOOP
                         (COND ((> |i| |bfVar#33|) (RETURN NIL))
                               (#1#
                                (PROGN
                                 (SETQ |item| (ELT |template| |i|))
                                 (COND
                                  ((OR
                                    (NOT
                                     (AND (CONSP |item|)
                                          (PROGN
                                           (SETQ |n| (CAR |item|))
                                           (SETQ |op| (CDR |item|))
                                           #1#)))
                                    (NULL (MEMQ |op| |opList|)))
                                   '|skip|)
                                  (#1#
                                   (PROGN
                                    (SETQ |index| |n|)
                                    (SETQ |numOfArgs| (ELT |numvec| |index|))
                                    (COND
                                     ((NULL
                                       (|member| |numOfArgs| |numOfArgsList|))
                                      '|skip|)
                                     (#1#
                                      (PROGN
                                       (SETQ |whereNumber|
                                               (ELT |numvec|
                                                    (SETQ |index|
                                                            (+ |index| 1))))
                                       (COND
                                        ((NOT
                                          (PROGN
                                           (SETQ |ISTMP#1|
                                                   (ELT |template|
                                                        |whereNumber|))
                                           (AND (CONSP |ISTMP#1|)
                                                (EQUAL (CAR |ISTMP#1|)
                                                       |$conname|))))
                                         '|skip|)
                                        (#1#
                                         (PROGN
                                          (SETQ |signumList|
                                                  (|dcSig| |numvec|
                                                   (+ |index| 1) |numOfArgs|))
                                          (SETQ |opsig|
                                                  ((LAMBDA
                                                       (|bfVar#35| |bfVar#34|
                                                        |pair|)
                                                     (LOOP
                                                      (COND
                                                       ((OR (ATOM |bfVar#34|)
                                                            (PROGN
                                                             (SETQ |pair|
                                                                     (CAR
                                                                      |bfVar#34|))
                                                             NIL))
                                                        (RETURN |bfVar#35|))
                                                       (#1#
                                                        (AND (CONSP |pair|)
                                                             (PROGN
                                                              (SETQ |op1|
                                                                      (CAR
                                                                       |pair|))
                                                              (SETQ |sig|
                                                                      (CDR
                                                                       |pair|))
                                                              #1#)
                                                             (EQUAL |op1| |op|)
                                                             (|whoUsesMatch?|
                                                              |signumList|
                                                              |sig| NIL)
                                                             (PROGN
                                                              (SETQ |bfVar#35|
                                                                      |pair|)
                                                              (COND
                                                               (|bfVar#35|
                                                                (RETURN
                                                                 |bfVar#35|)))))))
                                                      (SETQ |bfVar#34|
                                                              (CDR
                                                               |bfVar#34|))))
                                                   NIL |opSigList| NIL))
                                          (COND
                                           (|opsig|
                                            (SETQ |opacc|
                                                    (CONS |opsig|
                                                          |opacc|))))))))))))))))
                         (SETQ |i| (+ |i| 1))))
                      (MAXINDEX |template|) 7)
                     (COND
                      (|opacc|
                       (SETQ |acc| (CONS (CONS |name| |opacc|) |acc|))))))))))
          (SETQ |bfVar#32| (CDR |bfVar#32|))))
       |domList| NIL)
      |acc|))))

; whoUsesMatch?(signumList,sig,al) ==
;   #signumList = #sig and whoUsesMatch1?(signumList,sig,al)

(DEFUN |whoUsesMatch?| (|signumList| |sig| |al|)
  (PROG ()
    (RETURN
     (AND (EQL (LENGTH |signumList|) (LENGTH |sig|))
          (|whoUsesMatch1?| |signumList| |sig| |al|)))))

; whoUsesMatch1?(signumList,sig,al) ==
;   signumList is [subject,:r] and sig is [pattern,:s] =>
;     x := LASSOC(pattern,al) =>
;       x = subject => whoUsesMatch1?(r,s,al)
;       false
;     pattern = '_$ =>
;       subject is [= $conname,:.] => whoUsesMatch1?(r,s,[['_$,:subject],:al])
;       false
;     whoUsesMatch1?(r,s,[[pattern,:subject],:al])
;   true

(DEFUN |whoUsesMatch1?| (|signumList| |sig| |al|)
  (PROG (|subject| |r| |pattern| |s| |x|)
    (RETURN
     (COND
      ((AND (CONSP |signumList|)
            (PROGN
             (SETQ |subject| (CAR |signumList|))
             (SETQ |r| (CDR |signumList|))
             #1='T)
            (CONSP |sig|)
            (PROGN (SETQ |pattern| (CAR |sig|)) (SETQ |s| (CDR |sig|)) #1#))
       (COND
        ((SETQ |x| (LASSOC |pattern| |al|))
         (COND ((EQUAL |x| |subject|) (|whoUsesMatch1?| |r| |s| |al|))
               (#1# NIL)))
        ((EQ |pattern| '$)
         (COND
          ((AND (CONSP |subject|) (EQUAL (CAR |subject|) |$conname|))
           (|whoUsesMatch1?| |r| |s| (CONS (CONS '$ |subject|) |al|)))
          (#1# NIL)))
        (#1#
         (|whoUsesMatch1?| |r| |s| (CONS (CONS |pattern| |subject|) |al|)))))
      (#1# T)))))

; koOps(conform, domname) == main where
; --returns alist of form ((op (sig . pred) ...) ...)
;   main ==
;     $packageItem: local := nil
;     ours := fn(conform, domname)
;     listSort(function GLESSEQP,trim ours)
;   trim u == [pair for pair in u | IFCDR pair]
;   fn(conform,domname) ==
;     conform := domname or conform
;     [conname,:args] := conform
;     subargs: local := args
;     ----------> new <------------------
;     u := koCatOps(conform,domname) => u
; --    'category = GETDATABASE(conname,'CONSTRUCTORKIND) =>
; --        koCatOps(conform,domname)
;     asharpConstructorName? opOf conform => nil
;     ----------> new <------------------
;     $infovec: local := dbInfovec conname--------> removed 94/10/24
;     exposureTail :=
;       null $packageItem => '(NIL NIL)
;       isExposedConstructor opOf conform => [conform,:'(T)]
;       [conform,:'(NIL)]
;     for [op,:u] in getOperationAlistFromLisplib conname repeat
;       op1 := zeroOneConvert op
;       acc :=
;           [[op1, :[[sig, npred, :exposureTail]
;                     for [sig, slot, pred, key, :.] in sublisFormal(subargs,u)
;                    | npred := simpHasPred(pred)]], :acc]
;     acc
;   merge(alist,alist1) == --alist1 takes precedence
;     for [op,:al] in alist1 repeat
;       u := LASSOC(op,alist) =>
;         for [sig,:item] in al | not LASSOC(sig,u) repeat
;           u := insertAlist(sig,item,u)
;         alist := insertAlist(op,u,DELASC(op,alist)) --add the merge of two alists
;       alist := insertAlist(op,al,alist)  --add the whole inner alist
;     alist

(DEFUN |koOps| (|conform| |domname|)
  (PROG (|$packageItem| |ours|)
    (DECLARE (SPECIAL |$packageItem|))
    (RETURN
     (PROGN
      (SETQ |$packageItem| NIL)
      (SETQ |ours| (|koOps,fn| |conform| |domname|))
      (|listSort| #'GLESSEQP (|koOps,trim| |ours|))))))
(DEFUN |koOps,trim| (|u|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#37| |bfVar#36| |pair|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#36|) (PROGN (SETQ |pair| (CAR |bfVar#36|)) NIL))
           (RETURN (NREVERSE |bfVar#37|)))
          ('T (AND (IFCDR |pair|) (SETQ |bfVar#37| (CONS |pair| |bfVar#37|)))))
         (SETQ |bfVar#36| (CDR |bfVar#36|))))
      NIL |u| NIL))))
(DEFUN |koOps,fn| (|conform| |domname|)
  (PROG (|$infovec| |subargs| |acc| |npred| |key| |ISTMP#3| |pred| |ISTMP#2|
         |slot| |ISTMP#1| |sig| |op1| |op| |exposureTail| |u| |args| |conname|)
    (DECLARE (SPECIAL |$infovec| |subargs|))
    (RETURN
     (PROGN
      (SETQ |conform| (OR |domname| |conform|))
      (SETQ |conname| (CAR |conform|))
      (SETQ |args| (CDR |conform|))
      (SETQ |subargs| |args|)
      (COND ((SETQ |u| (|koCatOps| |conform| |domname|)) |u|)
            ((|asharpConstructorName?| (|opOf| |conform|)) NIL)
            (#1='T
             (PROGN
              (SETQ |$infovec| (|dbInfovec| |conname|))
              (SETQ |exposureTail|
                      (COND ((NULL |$packageItem|) '(NIL NIL))
                            ((|isExposedConstructor| (|opOf| |conform|))
                             (CONS |conform| '(T)))
                            (#1# (CONS |conform| '(NIL)))))
              ((LAMBDA (|bfVar#39| |bfVar#38|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#39|)
                        (PROGN (SETQ |bfVar#38| (CAR |bfVar#39|)) NIL))
                    (RETURN NIL))
                   (#1#
                    (AND (CONSP |bfVar#38|)
                         (PROGN
                          (SETQ |op| (CAR |bfVar#38|))
                          (SETQ |u| (CDR |bfVar#38|))
                          #1#)
                         (PROGN
                          (SETQ |op1| (|zeroOneConvert| |op|))
                          (SETQ |acc|
                                  (CONS
                                   (CONS |op1|
                                         ((LAMBDA
                                              (|bfVar#42| |bfVar#41|
                                               |bfVar#40|)
                                            (LOOP
                                             (COND
                                              ((OR (ATOM |bfVar#41|)
                                                   (PROGN
                                                    (SETQ |bfVar#40|
                                                            (CAR |bfVar#41|))
                                                    NIL))
                                               (RETURN (NREVERSE |bfVar#42|)))
                                              (#1#
                                               (AND (CONSP |bfVar#40|)
                                                    (PROGN
                                                     (SETQ |sig|
                                                             (CAR |bfVar#40|))
                                                     (SETQ |ISTMP#1|
                                                             (CDR |bfVar#40|))
                                                     (AND (CONSP |ISTMP#1|)
                                                          (PROGN
                                                           (SETQ |slot|
                                                                   (CAR
                                                                    |ISTMP#1|))
                                                           (SETQ |ISTMP#2|
                                                                   (CDR
                                                                    |ISTMP#1|))
                                                           (AND
                                                            (CONSP |ISTMP#2|)
                                                            (PROGN
                                                             (SETQ |pred|
                                                                     (CAR
                                                                      |ISTMP#2|))
                                                             (SETQ |ISTMP#3|
                                                                     (CDR
                                                                      |ISTMP#2|))
                                                             (AND
                                                              (CONSP |ISTMP#3|)
                                                              (PROGN
                                                               (SETQ |key|
                                                                       (CAR
                                                                        |ISTMP#3|))
                                                               #1#)))))))
                                                    (SETQ |npred|
                                                            (|simpHasPred|
                                                             |pred|))
                                                    (SETQ |bfVar#42|
                                                            (CONS
                                                             (CONS |sig|
                                                                   (CONS
                                                                    |npred|
                                                                    |exposureTail|))
                                                             |bfVar#42|)))))
                                             (SETQ |bfVar#41|
                                                     (CDR |bfVar#41|))))
                                          NIL (|sublisFormal| |subargs| |u|)
                                          NIL))
                                   |acc|))))))
                  (SETQ |bfVar#39| (CDR |bfVar#39|))))
               (|getOperationAlistFromLisplib| |conname|) NIL)
              |acc|)))))))
(DEFUN |koOps,merge| (|alist| |alist1|)
  (PROG (|op| |al| |u| |sig| |item|)
    (RETURN
     (PROGN
      ((LAMBDA (|bfVar#44| |bfVar#43|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#44|)
                (PROGN (SETQ |bfVar#43| (CAR |bfVar#44|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#43|)
                 (PROGN
                  (SETQ |op| (CAR |bfVar#43|))
                  (SETQ |al| (CDR |bfVar#43|))
                  #1#)
                 (COND
                  ((SETQ |u| (LASSOC |op| |alist|))
                   (PROGN
                    ((LAMBDA (|bfVar#46| |bfVar#45|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#46|)
                              (PROGN (SETQ |bfVar#45| (CAR |bfVar#46|)) NIL))
                          (RETURN NIL))
                         (#1#
                          (AND (CONSP |bfVar#45|)
                               (PROGN
                                (SETQ |sig| (CAR |bfVar#45|))
                                (SETQ |item| (CDR |bfVar#45|))
                                #1#)
                               (NULL (LASSOC |sig| |u|))
                               (SETQ |u| (|insertAlist| |sig| |item| |u|)))))
                        (SETQ |bfVar#46| (CDR |bfVar#46|))))
                     |al| NIL)
                    (SETQ |alist|
                            (|insertAlist| |op| |u| (DELASC |op| |alist|)))))
                  (#1# (SETQ |alist| (|insertAlist| |op| |al| |alist|)))))))
          (SETQ |bfVar#44| (CDR |bfVar#44|))))
       |alist1| NIL)
      |alist|))))

; zeroOneConvert x ==
;   x = 'Zero => 0
;   x = 'One  => 1
;   x

(DEFUN |zeroOneConvert| (|x|)
  (PROG () (RETURN (COND ((EQ |x| '|Zero|) 0) ((EQ |x| '|One|) 1) ('T |x|)))))

; kFormatSlotDomain x == fn formatSlotDomain x where fn x ==
;   atom x => x
;   (op := first x) = '_$ => '_$
;   op = 'local => CADR x
;   op = ":" => [":",CADR x,fn CADDR x]
;   MEMQ(op,$Primitives) or constructor? op =>
;     [fn y for y in x]
;   INTEGERP op => op
;   op = 'QUOTE and atom CADR x => CADR x
;   x

(DEFUN |kFormatSlotDomain| (|x|)
  (PROG () (RETURN (|kFormatSlotDomain,fn| (|formatSlotDomain| |x|)))))
(DEFUN |kFormatSlotDomain,fn| (|x|)
  (PROG (|op|)
    (RETURN
     (COND ((ATOM |x|) |x|) ((EQ (SETQ |op| (CAR |x|)) '$) '$)
           ((EQ |op| '|local|) (CADR |x|))
           ((EQ |op| '|:|)
            (LIST '|:| (CADR |x|) (|kFormatSlotDomain,fn| (CADDR |x|))))
           ((OR (MEMQ |op| |$Primitives|) (|constructor?| |op|))
            ((LAMBDA (|bfVar#48| |bfVar#47| |y|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#47|)
                      (PROGN (SETQ |y| (CAR |bfVar#47|)) NIL))
                  (RETURN (NREVERSE |bfVar#48|)))
                 (#1='T
                  (SETQ |bfVar#48|
                          (CONS (|kFormatSlotDomain,fn| |y|) |bfVar#48|))))
                (SETQ |bfVar#47| (CDR |bfVar#47|))))
             NIL |x| NIL))
           ((INTEGERP |op|) |op|)
           ((AND (EQ |op| 'QUOTE) (ATOM (CADR |x|))) (CADR |x|)) (#1# |x|)))))

; koCatOps(conform,domname) ==
;   conname := opOf conform
;   oplist := REVERSE GETDATABASE(conname,'OPERATIONALIST)
;   oplist := sublisFormal(IFCDR domname or IFCDR conform ,oplist)
;   --check below for INTEGERP key to avoid subsumed signatures
;   [[zeroOneConvert op,:nalist] for [op,:alist] in oplist | nalist := koCatOps1(alist)]

(DEFUN |koCatOps| (|conform| |domname|)
  (PROG (|conname| |oplist| |op| |alist| |nalist|)
    (RETURN
     (PROGN
      (SETQ |conname| (|opOf| |conform|))
      (SETQ |oplist| (REVERSE (GETDATABASE |conname| 'OPERATIONALIST)))
      (SETQ |oplist|
              (|sublisFormal| (OR (IFCDR |domname|) (IFCDR |conform|))
               |oplist|))
      ((LAMBDA (|bfVar#51| |bfVar#50| |bfVar#49|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#50|)
                (PROGN (SETQ |bfVar#49| (CAR |bfVar#50|)) NIL))
            (RETURN (NREVERSE |bfVar#51|)))
           (#1='T
            (AND (CONSP |bfVar#49|)
                 (PROGN
                  (SETQ |op| (CAR |bfVar#49|))
                  (SETQ |alist| (CDR |bfVar#49|))
                  #1#)
                 (SETQ |nalist| (|koCatOps1| |alist|))
                 (SETQ |bfVar#51|
                         (CONS (CONS (|zeroOneConvert| |op|) |nalist|)
                               |bfVar#51|)))))
          (SETQ |bfVar#50| (CDR |bfVar#50|))))
       NIL |oplist| NIL)))))

; koCatOps1 alist == [x for item in alist | x := pair] where
;   pair ==
;     [sig,:r] := item
;     null r => [sig,true]
;     [key,:options] := r
;     null (pred := IFCAR options) =>
;       IFCAR IFCDR options = 'ASCONST => [sig,'ASCONST]
;       [sig,true]
;     npred := simpHasPred pred => [sig,npred]
;     false

(DEFUN |koCatOps1| (|alist|)
  (PROG (|sig| |r| |key| |options| |pred| |npred| |x|)
    (RETURN
     ((LAMBDA (|bfVar#53| |bfVar#52| |item|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#52|) (PROGN (SETQ |item| (CAR |bfVar#52|)) NIL))
           (RETURN (NREVERSE |bfVar#53|)))
          (#1='T
           (AND
            (SETQ |x|
                    (PROGN
                     (SETQ |sig| (CAR |item|))
                     (SETQ |r| (CDR |item|))
                     (COND ((NULL |r|) (LIST |sig| T))
                           (#1#
                            (PROGN
                             (SETQ |key| (CAR |r|))
                             (SETQ |options| (CDR |r|))
                             (COND
                              ((NULL (SETQ |pred| (IFCAR |options|)))
                               (COND
                                ((EQ (IFCAR (IFCDR |options|)) 'ASCONST)
                                 (LIST |sig| 'ASCONST))
                                (#1# (LIST |sig| T))))
                              ((SETQ |npred| (|simpHasPred| |pred|))
                               (LIST |sig| |npred|))
                              (#1# NIL)))))))
            (SETQ |bfVar#53| (CONS |x| |bfVar#53|)))))
         (SETQ |bfVar#52| (CDR |bfVar#52|))))
      NIL |alist| NIL))))

; koCatAttrs(catform,domname) ==
;   $if : local := MAKE_HASHTABLE('ID)
;   catname   := opOf catform
;   koCatAttrsAdd(domname or catform,true)
;   ancestors := ancestorsOf(catform,domname)
;   for [conform,:pred] in ancestors repeat koCatAttrsAdd(conform,pred)
;   hashTable2Alist $if

(DEFUN |koCatAttrs| (|catform| |domname|)
  (PROG (|$if| |pred| |conform| |ancestors| |catname|)
    (DECLARE (SPECIAL |$if|))
    (RETURN
     (PROGN
      (SETQ |$if| (MAKE_HASHTABLE 'ID))
      (SETQ |catname| (|opOf| |catform|))
      (|koCatAttrsAdd| (OR |domname| |catform|) T)
      (SETQ |ancestors| (|ancestorsOf| |catform| |domname|))
      ((LAMBDA (|bfVar#55| |bfVar#54|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#55|)
                (PROGN (SETQ |bfVar#54| (CAR |bfVar#55|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#54|)
                 (PROGN
                  (SETQ |conform| (CAR |bfVar#54|))
                  (SETQ |pred| (CDR |bfVar#54|))
                  #1#)
                 (|koCatAttrsAdd| |conform| |pred|))))
          (SETQ |bfVar#55| (CDR |bfVar#55|))))
       |ancestors| NIL)
      (|hashTable2Alist| |$if|)))))

; hashTable2Alist tb ==
;   [[op,:HGET(tb,op)] for op in listSort(function GLESSEQP,HKEYS $if)]

(DEFUN |hashTable2Alist| (|tb|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#57| |bfVar#56| |op|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#56|) (PROGN (SETQ |op| (CAR |bfVar#56|)) NIL))
           (RETURN (NREVERSE |bfVar#57|)))
          ('T
           (SETQ |bfVar#57| (CONS (CONS |op| (HGET |tb| |op|)) |bfVar#57|))))
         (SETQ |bfVar#56| (CDR |bfVar#56|))))
      NIL (|listSort| #'GLESSEQP (HKEYS |$if|)) NIL))))

; koCatAttrsAdd(catform,pred) ==
;   for [name, argl, :p] in first getConstructorExports(catform, false) repeat
;     npred  := quickAnd(pred,p)
;     exists := HGET($if,name)
;     if existingPred := LASSOC(argl,exists) then npred := quickOr(npred,existingPred)
;     if not MEMQ(name,'(nil nothing)) then HPUT($if,name,[[argl,simpHasPred npred],:exists])

(DEFUN |koCatAttrsAdd| (|catform| |pred|)
  (PROG (|name| |ISTMP#1| |argl| |p| |npred| |exists| |existingPred|)
    (RETURN
     ((LAMBDA (|bfVar#59| |bfVar#58|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#59|)
               (PROGN (SETQ |bfVar#58| (CAR |bfVar#59|)) NIL))
           (RETURN NIL))
          (#1='T
           (AND (CONSP |bfVar#58|)
                (PROGN
                 (SETQ |name| (CAR |bfVar#58|))
                 (SETQ |ISTMP#1| (CDR |bfVar#58|))
                 (AND (CONSP |ISTMP#1|)
                      (PROGN
                       (SETQ |argl| (CAR |ISTMP#1|))
                       (SETQ |p| (CDR |ISTMP#1|))
                       #1#)))
                (PROGN
                 (SETQ |npred| (|quickAnd| |pred| |p|))
                 (SETQ |exists| (HGET |$if| |name|))
                 (COND
                  ((SETQ |existingPred| (LASSOC |argl| |exists|))
                   (SETQ |npred| (|quickOr| |npred| |existingPred|))))
                 (COND
                  ((NULL (MEMQ |name| '(|nil| |nothing|)))
                   (HPUT |$if| |name|
                         (CONS (LIST |argl| (|simpHasPred| |npred|))
                               |exists|))))))))
         (SETQ |bfVar#59| (CDR |bfVar#59|))))
      (CAR (|getConstructorExports| |catform| NIL)) NIL))))

; koaPageFilterByCategory(htPage,calledFrom) ==
;   opAlist := htpProperty(htPage,'opAlist)
;   which   := htpProperty(htPage,'which)
;   page := htInitPageNoScroll(htCopyProplist htPage,
;              dbHeading(opAlist,which,htpProperty(htPage,'heading)))
;   htSay('"Select a category ancestor below or ")
;   htMakePage [['bcLispLinks,['"filter",'"on:",calledFrom,'filter]]]
;   htMakePage [['bcStrings, [13,'"",'filter,'EM]]]
;   htSay('"\beginscroll ")
;   conform := htpProperty(htPage,'conform)
;   domname := htpProperty(htPage,'domname)
;   ancestors := ASSOCLEFT ancestorsOf(conform,domname)
;   htpSetProperty(page,'ancestors,listSort(function GLESSEQP,ancestors))
;   bcNameCountTable(ancestors, 'form2HtString, 'koaPageFilterByCategory1)
;   htShowPage()

(DEFUN |koaPageFilterByCategory| (|htPage| |calledFrom|)
  (PROG (|opAlist| |which| |page| |conform| |domname| |ancestors|)
    (RETURN
     (PROGN
      (SETQ |opAlist| (|htpProperty| |htPage| '|opAlist|))
      (SETQ |which| (|htpProperty| |htPage| '|which|))
      (SETQ |page|
              (|htInitPageNoScroll| (|htCopyProplist| |htPage|)
               (|dbHeading| |opAlist| |which|
                (|htpProperty| |htPage| '|heading|))))
      (|htSay| "Select a category ancestor below or ")
      (|htMakePage|
       (LIST
        (LIST '|bcLispLinks| (LIST "filter" "on:" |calledFrom| '|filter|))))
      (|htMakePage| (LIST (LIST '|bcStrings| (LIST 13 "" '|filter| 'EM))))
      (|htSay| "\\beginscroll ")
      (SETQ |conform| (|htpProperty| |htPage| '|conform|))
      (SETQ |domname| (|htpProperty| |htPage| '|domname|))
      (SETQ |ancestors| (ASSOCLEFT (|ancestorsOf| |conform| |domname|)))
      (|htpSetProperty| |page| '|ancestors|
       (|listSort| #'GLESSEQP |ancestors|))
      (|bcNameCountTable| |ancestors| '|form2HtString|
       '|koaPageFilterByCategory1|)
      (|htShowPage|)))))

; dbHeading(items, which, heading) ==
;   count := +/[#(rest x) for x in items]
;   capwhich := capitalize which
;   prefix :=
;     count < 2 =>
;       pluralSay(count,capwhich,nil)
;     pluralSay(count,nil,pluralize capwhich)
;   [:prefix,'" for ",:heading]

(DEFUN |dbHeading| (|items| |which| |heading|)
  (PROG (|count| |capwhich| |prefix|)
    (RETURN
     (PROGN
      (SETQ |count|
              ((LAMBDA (|bfVar#61| |bfVar#60| |x|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#60|)
                        (PROGN (SETQ |x| (CAR |bfVar#60|)) NIL))
                    (RETURN |bfVar#61|))
                   (#1='T (SETQ |bfVar#61| (+ |bfVar#61| (LENGTH (CDR |x|))))))
                  (SETQ |bfVar#60| (CDR |bfVar#60|))))
               0 |items| NIL))
      (SETQ |capwhich| (|capitalize| |which|))
      (SETQ |prefix|
              (COND ((< |count| 2) (|pluralSay| |count| |capwhich| NIL))
                    (#1# (|pluralSay| |count| NIL (|pluralize| |capwhich|)))))
      (APPEND |prefix| (CONS " for " |heading|))))))

; koaPageFilterByCategory1(htPage,i) ==
;   ancestor := (htpProperty(htPage, 'ancestors)) . i
;   ancestorList := [ancestor,:ASSOCLEFT ancestorsOf(ancestor,nil)]
;   newOpAlist := nil
;   which    := htpProperty(htPage,'which)
;   opAlist  := htpProperty(htPage,'opAlist)
;   domname  := htpProperty(htPage,'domname)
;   conform  := htpProperty(htPage,'conform)
;   heading  := htpProperty(htPage,'heading)
;   docTable := dbDocTable(domname or conform)
;   for [op,:alist] in opAlist repeat
;     nalist := [[origin,:item] for item in alist | split]
;       where split ==
;         [sig,pred,:aux] := item
;         u := dbGetDocTable(op,sig,docTable,which,aux)
;         origin := IFCAR u
;         true
;     for [origin,:item] in nalist | origin repeat
;       member(origin,ancestorList) =>
;         newEntry   := [item,:LASSOC(op,newOpAlist)]
;         newOpAlist := insertAlist(op,newEntry,newOpAlist)
;   falist := nil
;   for [op,:alist] in newOpAlist repeat
;     falist := [[op,:NREVERSE alist],:falist]
;   htpSetProperty(htPage,'fromcat,['" from category {\sf ",form2HtString ancestor,'"}"])
;   dbShowOperationsFromConform(htPage,which,falist)

(DEFUN |koaPageFilterByCategory1| (|htPage| |i|)
  (PROG (|ancestor| |ancestorList| |newOpAlist| |which| |opAlist| |domname|
         |conform| |heading| |docTable| |op| |alist| |sig| |pred| |aux| |u|
         |origin| |nalist| |item| |newEntry| |falist|)
    (RETURN
     (PROGN
      (SETQ |ancestor| (ELT (|htpProperty| |htPage| '|ancestors|) |i|))
      (SETQ |ancestorList|
              (CONS |ancestor| (ASSOCLEFT (|ancestorsOf| |ancestor| NIL))))
      (SETQ |newOpAlist| NIL)
      (SETQ |which| (|htpProperty| |htPage| '|which|))
      (SETQ |opAlist| (|htpProperty| |htPage| '|opAlist|))
      (SETQ |domname| (|htpProperty| |htPage| '|domname|))
      (SETQ |conform| (|htpProperty| |htPage| '|conform|))
      (SETQ |heading| (|htpProperty| |htPage| '|heading|))
      (SETQ |docTable| (|dbDocTable| (OR |domname| |conform|)))
      ((LAMBDA (|bfVar#63| |bfVar#62|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#63|)
                (PROGN (SETQ |bfVar#62| (CAR |bfVar#63|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#62|)
                 (PROGN
                  (SETQ |op| (CAR |bfVar#62|))
                  (SETQ |alist| (CDR |bfVar#62|))
                  #1#)
                 (PROGN
                  (SETQ |nalist|
                          ((LAMBDA (|bfVar#65| |bfVar#64| |item|)
                             (LOOP
                              (COND
                               ((OR (ATOM |bfVar#64|)
                                    (PROGN (SETQ |item| (CAR |bfVar#64|)) NIL))
                                (RETURN (NREVERSE |bfVar#65|)))
                               (#1#
                                (AND
                                 (PROGN
                                  (SETQ |sig| (CAR |item|))
                                  (SETQ |pred| (CADR |item|))
                                  (SETQ |aux| (CDDR |item|))
                                  (SETQ |u|
                                          (|dbGetDocTable| |op| |sig|
                                           |docTable| |which| |aux|))
                                  (SETQ |origin| (IFCAR |u|))
                                  T)
                                 (SETQ |bfVar#65|
                                         (CONS (CONS |origin| |item|)
                                               |bfVar#65|)))))
                              (SETQ |bfVar#64| (CDR |bfVar#64|))))
                           NIL |alist| NIL))
                  ((LAMBDA (|bfVar#67| |bfVar#66|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#67|)
                            (PROGN (SETQ |bfVar#66| (CAR |bfVar#67|)) NIL))
                        (RETURN NIL))
                       (#1#
                        (AND (CONSP |bfVar#66|)
                             (PROGN
                              (SETQ |origin| (CAR |bfVar#66|))
                              (SETQ |item| (CDR |bfVar#66|))
                              #1#)
                             |origin|
                             (COND
                              ((|member| |origin| |ancestorList|)
                               (IDENTITY
                                (PROGN
                                 (SETQ |newEntry|
                                         (CONS |item|
                                               (LASSOC |op| |newOpAlist|)))
                                 (SETQ |newOpAlist|
                                         (|insertAlist| |op| |newEntry|
                                          |newOpAlist|)))))))))
                      (SETQ |bfVar#67| (CDR |bfVar#67|))))
                   |nalist| NIL)))))
          (SETQ |bfVar#63| (CDR |bfVar#63|))))
       |opAlist| NIL)
      (SETQ |falist| NIL)
      ((LAMBDA (|bfVar#69| |bfVar#68|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#69|)
                (PROGN (SETQ |bfVar#68| (CAR |bfVar#69|)) NIL))
            (RETURN NIL))
           (#1#
            (AND (CONSP |bfVar#68|)
                 (PROGN
                  (SETQ |op| (CAR |bfVar#68|))
                  (SETQ |alist| (CDR |bfVar#68|))
                  #1#)
                 (SETQ |falist|
                         (CONS (CONS |op| (NREVERSE |alist|)) |falist|)))))
          (SETQ |bfVar#69| (CDR |bfVar#69|))))
       |newOpAlist| NIL)
      (|htpSetProperty| |htPage| '|fromcat|
       (LIST " from category {\\sf " (|form2HtString| |ancestor|) "}"))
      (|dbShowOperationsFromConform| |htPage| |which| |falist|)))))

; opPageFast opAlist == --called by oSearch
;   htPage := htInitPage(nil,nil)
;   htpSetProperty(htPage,'opAlist,opAlist)
;   htpSetProperty(htPage,'expandOperations,'lists)
;   which := '"operation"
;   dbShowOp1(htPage,opAlist,which,'names)

(DEFUN |opPageFast| (|opAlist|)
  (PROG (|htPage| |which|)
    (RETURN
     (PROGN
      (SETQ |htPage| (|htInitPage| NIL NIL))
      (|htpSetProperty| |htPage| '|opAlist| |opAlist|)
      (|htpSetProperty| |htPage| '|expandOperations| '|lists|)
      (SETQ |which| "operation")
      (|dbShowOp1| |htPage| |opAlist| |which| '|names|)))))

; opPageFastPath opstring ==
; --return nil
;   x := STRINGIMAGE opstring
;   charPosition(char '_*,x,0) < #x => nil     --quit if name has * in it
;   op := (STRINGP x => INTERN x; x)
;   mmList := getAllModemapsFromDatabase(op,nil) or return nil
;   opAlist := [[op,:[item for mm in mmList]]] where item ==
;     [predList, origin, sig] := modemap2Sig(op, mm)
;     predicate := predList and MKPF(predList,'AND)
;     exposed? := isExposedConstructor opOf origin
;     [sig, predicate, origin, exposed?]
;   opAlist

(DEFUN |opPageFastPath| (|opstring|)
  (PROG (|x| |op| |mmList| |LETTMP#1| |predList| |origin| |sig| |predicate|
         |exposed?| |opAlist|)
    (RETURN
     (PROGN
      (SETQ |x| (STRINGIMAGE |opstring|))
      (COND ((< (|charPosition| (|char| '*) |x| 0) (LENGTH |x|)) NIL)
            (#1='T
             (PROGN
              (SETQ |op| (COND ((STRINGP |x|) (INTERN |x|)) (#1# |x|)))
              (SETQ |mmList|
                      (OR (|getAllModemapsFromDatabase| |op| NIL)
                          (RETURN NIL)))
              (SETQ |opAlist|
                      (LIST
                       (CONS |op|
                             ((LAMBDA (|bfVar#71| |bfVar#70| |mm|)
                                (LOOP
                                 (COND
                                  ((OR (ATOM |bfVar#70|)
                                       (PROGN
                                        (SETQ |mm| (CAR |bfVar#70|))
                                        NIL))
                                   (RETURN (NREVERSE |bfVar#71|)))
                                  (#1#
                                   (SETQ |bfVar#71|
                                           (CONS
                                            (PROGN
                                             (SETQ |LETTMP#1|
                                                     (|modemap2Sig| |op| |mm|))
                                             (SETQ |predList| (CAR |LETTMP#1|))
                                             (SETQ |origin| (CADR |LETTMP#1|))
                                             (SETQ |sig| (CADDR |LETTMP#1|))
                                             (SETQ |predicate|
                                                     (AND |predList|
                                                          (MKPF |predList|
                                                           'AND)))
                                             (SETQ |exposed?|
                                                     (|isExposedConstructor|
                                                      (|opOf| |origin|)))
                                             (LIST |sig| |predicate| |origin|
                                                   |exposed?|))
                                            |bfVar#71|))))
                                 (SETQ |bfVar#70| (CDR |bfVar#70|))))
                              NIL |mmList| NIL))))
              |opAlist|)))))))

; modemap2Sig(op,mm) ==
;   [dcSig, conds] := mm
;   [dc, :sig] := dcSig
;   partial? :=
;     conds is ['partial,:r] => conds := r
;     false
;   condlist := modemap2SigConds conds
;   [origin, vlist, flist] := getDcForm(dc, condlist) or return nil
;   subcondlist := SUBLISLIS(flist, vlist, condlist)
;   [predList,vlist, flist] := getSigSubst(subcondlist, nil, vlist, flist)
;   if partial? then
;       target := sig.0
;       ntarget := ['Union, target, '"failed"]
;       sig := substitute(ntarget, target, sig)
;   alist := findSubstitutionOrder? pairlis(vlist, flist) or systemError()
;   predList := substInOrder(alist, predList)
;   nsig := substInOrder(alist, sig)
;   if hasPatternVar nsig or hasPatternVar predList then
;     pp '"--------------"
;     pp op
;     pp predList
;     pp nsig
;     pp mm
; --pause nsig
;   [predList, origin, substitute("%", origin, nsig)]

(DEFUN |modemap2Sig| (|op| |mm|)
  (PROG (|dcSig| |conds| |dc| |sig| |r| |partial?| |condlist| |LETTMP#1|
         |origin| |vlist| |flist| |subcondlist| |predList| |target| |ntarget|
         |alist| |nsig|)
    (RETURN
     (PROGN
      (SETQ |dcSig| (CAR |mm|))
      (SETQ |conds| (CADR |mm|))
      (SETQ |dc| (CAR |dcSig|))
      (SETQ |sig| (CDR |dcSig|))
      (SETQ |partial?|
              (COND
               ((AND (CONSP |conds|) (EQ (CAR |conds|) '|partial|)
                     (PROGN (SETQ |r| (CDR |conds|)) #1='T))
                (SETQ |conds| |r|))
               (#1# NIL)))
      (SETQ |condlist| (|modemap2SigConds| |conds|))
      (SETQ |LETTMP#1| (OR (|getDcForm| |dc| |condlist|) (RETURN NIL)))
      (SETQ |origin| (CAR |LETTMP#1|))
      (SETQ |vlist| (CADR . #2=(|LETTMP#1|)))
      (SETQ |flist| (CADDR . #2#))
      (SETQ |subcondlist| (SUBLISLIS |flist| |vlist| |condlist|))
      (SETQ |LETTMP#1| (|getSigSubst| |subcondlist| NIL |vlist| |flist|))
      (SETQ |predList| (CAR |LETTMP#1|))
      (SETQ |vlist| (CADR . #3=(|LETTMP#1|)))
      (SETQ |flist| (CADDR . #3#))
      (COND
       (|partial?| (SETQ |target| (ELT |sig| 0))
        (SETQ |ntarget| (LIST '|Union| |target| "failed"))
        (SETQ |sig| (|substitute| |ntarget| |target| |sig|))))
      (SETQ |alist|
              (OR (|findSubstitutionOrder?| (|pairlis| |vlist| |flist|))
                  (|systemError|)))
      (SETQ |predList| (|substInOrder| |alist| |predList|))
      (SETQ |nsig| (|substInOrder| |alist| |sig|))
      (COND
       ((OR (|hasPatternVar| |nsig|) (|hasPatternVar| |predList|))
        (|pp| "--------------") (|pp| |op|) (|pp| |predList|) (|pp| |nsig|)
        (|pp| |mm|)))
      (LIST |predList| |origin| (|substitute| '% |origin| |nsig|))))))

; modemap2SigConds conds ==
;   conds is ['OR,:r] => modemap2SigConds first r
;   conds is ['AND,:r] => r
;   [conds]

(DEFUN |modemap2SigConds| (|conds|)
  (PROG (|r|)
    (RETURN
     (COND
      ((AND (CONSP |conds|) (EQ (CAR |conds|) 'OR)
            (PROGN (SETQ |r| (CDR |conds|)) #1='T))
       (|modemap2SigConds| (CAR |r|)))
      ((AND (CONSP |conds|) (EQ (CAR |conds|) 'AND)
            (PROGN (SETQ |r| (CDR |conds|)) #1#))
       |r|)
      (#1# (LIST |conds|))))))

; hasPatternVar x ==
;   IDENTP x and (x ~= "**") => isPatternVar x
;   atom x => false
;   or/[hasPatternVar y for y in x]

(DEFUN |hasPatternVar| (|x|)
  (PROG ()
    (RETURN
     (COND ((AND (IDENTP |x|) (NOT (EQ |x| '**))) (|isPatternVar| |x|))
           ((ATOM |x|) NIL)
           (#1='T
            ((LAMBDA (|bfVar#73| |bfVar#72| |y|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#72|)
                      (PROGN (SETQ |y| (CAR |bfVar#72|)) NIL))
                  (RETURN |bfVar#73|))
                 (#1#
                  (PROGN
                   (SETQ |bfVar#73| (|hasPatternVar| |y|))
                   (COND (|bfVar#73| (RETURN |bfVar#73|))))))
                (SETQ |bfVar#72| (CDR |bfVar#72|))))
             NIL |x| NIL))))))

; getDcForm(dc, condlist) ==
;   -- FIXME: normally first condition on *1 gives origin, but not
;   -- always.  In particular, if we get category with no operations
;   -- than this is clearly wrong, so try next (happens with attributes).
;   -- We should make this reliable.
;   candidates := [x for x in condlist | x is [k,=dc,:.]
;                  and MEMQ(k, '(ofCategory isDomain))]
;   null(candidates) => nil
;   [ofWord,id,cform] := first(candidates)
;   if #candidates > 1 and ofWord = 'ofCategory and _
;        null(GETDATABASE(opOf cform, 'MODEMAPS)) then
;      [ofWord,id,cform] := first(rest(candidates))
;   conform := getConstructorForm opOf cform
;   ofWord = 'ofCategory =>
;     [conform, ["*1", :rest cform], ["%", :rest conform]]
;   ofWord = 'isDomain =>
;     [conform, ["*1", :rest cform], ["%", :rest conform]]
;   systemError()

(DEFUN |getDcForm| (|dc| |condlist|)
  (PROG (|k| |ISTMP#1| |candidates| |LETTMP#1| |ofWord| |id| |cform| |conform|)
    (RETURN
     (PROGN
      (SETQ |candidates|
              ((LAMBDA (|bfVar#75| |bfVar#74| |x|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#74|)
                        (PROGN (SETQ |x| (CAR |bfVar#74|)) NIL))
                    (RETURN (NREVERSE |bfVar#75|)))
                   (#1='T
                    (AND (CONSP |x|)
                         (PROGN
                          (SETQ |k| (CAR |x|))
                          (SETQ |ISTMP#1| (CDR |x|))
                          (AND (CONSP |ISTMP#1|) (EQUAL (CAR |ISTMP#1|) |dc|)))
                         (MEMQ |k| '(|ofCategory| |isDomain|))
                         (SETQ |bfVar#75| (CONS |x| |bfVar#75|)))))
                  (SETQ |bfVar#74| (CDR |bfVar#74|))))
               NIL |condlist| NIL))
      (COND ((NULL |candidates|) NIL)
            (#1#
             (PROGN
              (SETQ |LETTMP#1| (CAR |candidates|))
              (SETQ |ofWord| (CAR |LETTMP#1|))
              (SETQ |id| (CADR . #2=(|LETTMP#1|)))
              (SETQ |cform| (CADDR . #2#))
              (COND
               ((AND (< 1 (LENGTH |candidates|)) (EQ |ofWord| '|ofCategory|)
                     (NULL (GETDATABASE (|opOf| |cform|) 'MODEMAPS)))
                (SETQ |LETTMP#1| (CAR (CDR |candidates|)))
                (SETQ |ofWord| (CAR |LETTMP#1|))
                (SETQ |id| (CADR . #3=(|LETTMP#1|)))
                (SETQ |cform| (CADDR . #3#)) |LETTMP#1|))
              (SETQ |conform| (|getConstructorForm| (|opOf| |cform|)))
              (COND
               ((EQ |ofWord| '|ofCategory|)
                (LIST |conform| (CONS '*1 (CDR |cform|))
                      (CONS '% (CDR |conform|))))
               ((EQ |ofWord| '|isDomain|)
                (LIST |conform| (CONS '*1 (CDR |cform|))
                      (CONS '% (CDR |conform|))))
               (#1# (|systemError|))))))))))

; getSigSubst(u, pl, vl, fl) ==
;   u is [item, :r] =>
;     item is ['AND,:s] =>
;        [pl, vl, fl] := getSigSubst(s, pl, vl, fl)
;        getSigSubst(r, pl, vl, fl)
;     [key, v, f] := item
;     key = 'isDomain => getSigSubst(r, pl, [v, :vl], [f, :fl])
;     key = 'ofCategory => getSigSubst(r, pl, [$Dmarker, :vl], [f, :fl])
;     key = 'ofType    => getSigSubst(r, pl, vl, fl)
;     key = 'has => getSigSubst(r, [item, :pl], vl, fl)
;     key = 'not => getSigSubst(r, [item, :pl], vl, fl)
;     systemError()
;   [pl, vl, fl]

(DEFUN |getSigSubst| (|u| |pl| |vl| |fl|)
  (PROG (|item| |r| |s| |LETTMP#1| |key| |v| |f|)
    (RETURN
     (COND
      ((AND (CONSP |u|)
            (PROGN (SETQ |item| (CAR |u|)) (SETQ |r| (CDR |u|)) #1='T))
       (COND
        ((AND (CONSP |item|) (EQ (CAR |item|) 'AND)
              (PROGN (SETQ |s| (CDR |item|)) #1#))
         (PROGN
          (SETQ |LETTMP#1| (|getSigSubst| |s| |pl| |vl| |fl|))
          (SETQ |pl| (CAR |LETTMP#1|))
          (SETQ |vl| (CADR . #2=(|LETTMP#1|)))
          (SETQ |fl| (CADDR . #2#))
          (|getSigSubst| |r| |pl| |vl| |fl|)))
        (#1#
         (PROGN
          (SETQ |key| (CAR |item|))
          (SETQ |v| (CADR . #3=(|item|)))
          (SETQ |f| (CADDR . #3#))
          (COND
           ((EQ |key| '|isDomain|)
            (|getSigSubst| |r| |pl| (CONS |v| |vl|) (CONS |f| |fl|)))
           ((EQ |key| '|ofCategory|)
            (|getSigSubst| |r| |pl| (CONS |$Dmarker| |vl|) (CONS |f| |fl|)))
           ((EQ |key| '|ofType|) (|getSigSubst| |r| |pl| |vl| |fl|))
           ((EQ |key| '|has|) (|getSigSubst| |r| (CONS |item| |pl|) |vl| |fl|))
           ((EQ |key| '|not|) (|getSigSubst| |r| (CONS |item| |pl|) |vl| |fl|))
           (#1# (|systemError|)))))))
      (#1# (LIST |pl| |vl| |fl|))))))

; pairlis(u,v) ==
;   null u or null v => nil
;   [[first u,:first v],:pairlis(rest u, rest v)]

(DEFUN |pairlis| (|u| |v|)
  (PROG ()
    (RETURN
     (COND ((OR (NULL |u|) (NULL |v|)) NIL)
           ('T
            (CONS (CONS (CAR |u|) (CAR |v|))
                  (|pairlis| (CDR |u|) (CDR |v|))))))))
