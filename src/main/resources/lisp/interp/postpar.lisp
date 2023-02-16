
; )package "BOOT"

(IN-PACKAGE "BOOT")

; postTransform y ==
;   $insidePostCategoryIfTrue : local := nil
;   x:= y
;   u:= postTran x
;   if u is ["@Tuple", :l, [":", y, t]] and (and/[IDENTP x for x in l]) then
;       u := [":", ['LISTOF, :l, y], t]
;   postTransformCheck u
;   u

(DEFUN |postTransform| (|y|)
  (PROG (|$insidePostCategoryIfTrue| |l| |t| |ISTMP#5| |ISTMP#4| |ISTMP#3|
         |ISTMP#2| |ISTMP#1| |u| |x|)
    (DECLARE (SPECIAL |$insidePostCategoryIfTrue|))
    (RETURN
     (PROGN
      (SETQ |$insidePostCategoryIfTrue| NIL)
      (SETQ |x| |y|)
      (SETQ |u| (|postTran| |x|))
      (COND
       ((AND (CONSP |u|) (EQ (CAR |u|) '|@Tuple|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |u|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN (SETQ |ISTMP#2| (REVERSE |ISTMP#1|)) #1='T)
                   (CONSP |ISTMP#2|)
                   (PROGN
                    (SETQ |ISTMP#3| (CAR |ISTMP#2|))
                    (AND (CONSP |ISTMP#3|) (EQ (CAR |ISTMP#3|) '|:|)
                         (PROGN
                          (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                          (AND (CONSP |ISTMP#4|)
                               (PROGN
                                (SETQ |y| (CAR |ISTMP#4|))
                                (SETQ |ISTMP#5| (CDR |ISTMP#4|))
                                (AND (CONSP |ISTMP#5|) (EQ (CDR |ISTMP#5|) NIL)
                                     (PROGN
                                      (SETQ |t| (CAR |ISTMP#5|))
                                      #1#)))))))
                   (PROGN (SETQ |l| (CDR |ISTMP#2|)) #1#)
                   (PROGN (SETQ |l| (NREVERSE |l|)) #1#)))
             ((LAMBDA (|bfVar#2| |bfVar#1| |x|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#1|) (PROGN (SETQ |x| (CAR |bfVar#1|)) NIL))
                   (RETURN |bfVar#2|))
                  (#1#
                   (PROGN
                    (SETQ |bfVar#2| (IDENTP |x|))
                    (COND ((NOT |bfVar#2|) (RETURN NIL))))))
                 (SETQ |bfVar#1| (CDR |bfVar#1|))))
              T |l| NIL))
        (SETQ |u| (LIST '|:| (CONS 'LISTOF (APPEND |l| (CONS |y| NIL))) |t|))))
      (|postTransformCheck| |u|)
      |u|))))

; displayPreCompilationErrors() ==
;   n:= #($postStack:= REMDUP NREVERSE $postStack)
;   n=0 => nil
;   errors:=
;     1<n => '"errors"
;     '"error"
;   heading:=
;         $topOp ~= '$topOp => ['"   ",$topOp,'" has"]
;         ['"   You have"]
;   sayBrightly [:heading, '%b, n, '%d, '"precompilation ", errors, '":"]
;   if 1<n then
;     (for x in $postStack for i in 1.. repeat sayMath ['"   ",i,'"_) ",:x])
;     else sayMath ['"    ",:first $postStack]
;   TERPRI()

(DEFUN |displayPreCompilationErrors| ()
  (PROG (|heading| |errors| |n|)
    (RETURN
     (PROGN
      (SETQ |n| (LENGTH (SETQ |$postStack| (REMDUP (NREVERSE |$postStack|)))))
      (COND ((EQL |n| 0) NIL)
            (#1='T
             (PROGN
              (SETQ |errors| (COND ((< 1 |n|) "errors") (#1# "error")))
              (SETQ |heading|
                      (COND
                       ((NOT (EQ |$topOp| '|$topOp|))
                        (LIST "   " |$topOp| " has"))
                       (#1# (LIST "   You have"))))
              (|sayBrightly|
               (APPEND |heading|
                       (CONS '|%b|
                             (CONS |n|
                                   (CONS '|%d|
                                         (CONS "precompilation "
                                               (CONS |errors|
                                                     (CONS ":" NIL))))))))
              (COND
               ((< 1 |n|)
                ((LAMBDA (|bfVar#3| |x| |i|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#3|)
                          (PROGN (SETQ |x| (CAR |bfVar#3|)) NIL))
                      (RETURN NIL))
                     (#1# (|sayMath| (CONS "   " (CONS |i| (CONS ") " |x|))))))
                    (SETQ |bfVar#3| (CDR |bfVar#3|))
                    (SETQ |i| (+ |i| 1))))
                 |$postStack| NIL 1))
               (#1# (|sayMath| (CONS "    " (CAR |$postStack|)))))
              (TERPRI))))))))

; postTran x ==
;   atom x =>
;     postAtom x
;   op := first x
;   op = "with" => postWith(x)
;   op = "/" => postSlash(x)
;   op = "construct" => postConstruct(x)
;   op = "QUOTE" => postQUOTE(x)
;   op = "COLLECT" => postCollect(x)
;   op = ":BF:" => postBigFloat(x)
;   -- the infix operator version of in
;   op = "in" => postin(x)
;   -- the iterator form of in
;   op = "IN" => postIn(x)
;   op = "REPEAT" => postRepeat(x)
;   op = "add" => postAdd(x)
;   op = "Reduce" => postReduce(x)
;   op = "," => postComma(x)
;   op = ";" => postSemiColon(x)
;   op = "where" => postWhere(x)
;   op = "if" => postIf(x)
;   op = "Join" => postJoin(x)
;   op = "Signature" => postSignature(x)
;   op = "CATEGORY" => postCategory(x)
;   op = "==" => postDef(x)
;   op = "==>" => postMDef(x)
;   op = "->" => postMapping(x)
;   op = "=>" => postExit(x)
;   op = "@Tuple" => postTuple(x)
;   op is ['Sel, a, b] =>
;     u:= postTran [b,:rest x]
;     [postTran op,:rest u]
;   postForm x

(DEFUN |postTran| (|x|)
  (PROG (|op| |ISTMP#1| |a| |ISTMP#2| |b| |u|)
    (RETURN
     (COND ((ATOM |x|) (|postAtom| |x|))
           (#1='T
            (PROGN
             (SETQ |op| (CAR |x|))
             (COND ((EQ |op| '|with|) (|postWith| |x|))
                   ((EQ |op| '/) (|postSlash| |x|))
                   ((EQ |op| '|construct|) (|postConstruct| |x|))
                   ((EQ |op| 'QUOTE) (|postQUOTE| |x|))
                   ((EQ |op| 'COLLECT) (|postCollect| |x|))
                   ((EQ |op| '|:BF:|) (|postBigFloat| |x|))
                   ((EQ |op| '|in|) (|postin| |x|))
                   ((EQ |op| 'IN) (|postIn| |x|))
                   ((EQ |op| 'REPEAT) (|postRepeat| |x|))
                   ((EQ |op| '|add|) (|postAdd| |x|))
                   ((EQ |op| '|Reduce|) (|postReduce| |x|))
                   ((EQ |op| '|,|) (|postComma| |x|))
                   ((EQ |op| '|;|) (|postSemiColon| |x|))
                   ((EQ |op| '|where|) (|postWhere| |x|))
                   ((EQ |op| '|if|) (|postIf| |x|))
                   ((EQ |op| '|Join|) (|postJoin| |x|))
                   ((EQ |op| '|Signature|) (|postSignature| |x|))
                   ((EQ |op| 'CATEGORY) (|postCategory| |x|))
                   ((EQ |op| '==) (|postDef| |x|))
                   ((EQ |op| '==>) (|postMDef| |x|))
                   ((EQ |op| '->) (|postMapping| |x|))
                   ((EQ |op| '=>) (|postExit| |x|))
                   ((EQ |op| '|@Tuple|) (|postTuple| |x|))
                   ((AND (CONSP |op|) (EQ (CAR |op|) '|Sel|)
                         (PROGN
                          (SETQ |ISTMP#1| (CDR |op|))
                          (AND (CONSP |ISTMP#1|)
                               (PROGN
                                (SETQ |a| (CAR |ISTMP#1|))
                                (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                     (PROGN
                                      (SETQ |b| (CAR |ISTMP#2|))
                                      #1#))))))
                    (PROGN
                     (SETQ |u| (|postTran| (CONS |b| (CDR |x|))))
                     (CONS (|postTran| |op|) (CDR |u|))))
                   (#1# (|postForm| |x|)))))))))

; postTranList x == [postTran y for y in x]

(DEFUN |postTranList| (|x|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#5| |bfVar#4| |y|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#4|) (PROGN (SETQ |y| (CAR |bfVar#4|)) NIL))
           (RETURN (NREVERSE |bfVar#5|)))
          ('T (SETQ |bfVar#5| (CONS (|postTran| |y|) |bfVar#5|))))
         (SETQ |bfVar#4| (CDR |bfVar#4|))))
      NIL |x| NIL))))

; postBigFloat x ==
;   [.,mant, expon] := x
;   postTran [["Sel", '(Float), 'float], [",", [",", mant, expon], 10]]

(DEFUN |postBigFloat| (|x|)
  (PROG (|mant| |expon|)
    (RETURN
     (PROGN
      (SETQ |mant| (CADR . #1=(|x|)))
      (SETQ |expon| (CADDR . #1#))
      (|postTran|
       (LIST (LIST '|Sel| '(|Float|) '|float|)
             (LIST '|,| (LIST '|,| |mant| |expon|) 10)))))))

; postAdd ['add,a,:b] ==
;   null b => postCapsule a
;   ['add,postTran a,postCapsule first b]

(DEFUN |postAdd| (|bfVar#6|)
  (PROG (|a| |b|)
    (RETURN
     (PROGN
      (SETQ |a| (CADR . #1=(|bfVar#6|)))
      (SETQ |b| (CDDR . #1#))
      (COND ((NULL |b|) (|postCapsule| |a|))
            ('T (LIST '|add| (|postTran| |a|) (|postCapsule| (CAR |b|)))))))))

; checkWarning msg == postError concat('"Parsing error: ",msg)

(DEFUN |checkWarning| (|msg|)
  (PROG () (RETURN (|postError| (|concat| "Parsing error: " |msg|)))))

; checkWarningIndentation() ==
;   checkWarning ['"Apparent indentation error following",:bright "add"]

(DEFUN |checkWarningIndentation| ()
  (PROG ()
    (RETURN
     (|checkWarning|
      (CONS "Apparent indentation error following" (|bright| '|add|))))))

; postCapsule x ==
;   x isnt [op,:.] => checkWarningIndentation()
;   op = ";" => ['CAPSULE,:postBlockItemList postFlatten(x,";")]
;   op = "if" or INTEGERP op or op = "==" => ['CAPSULE, postBlockItem x]
;   checkWarningIndentation()

(DEFUN |postCapsule| (|x|)
  (PROG (|op|)
    (RETURN
     (COND
      ((NOT (AND (CONSP |x|) (PROGN (SETQ |op| (CAR |x|)) #1='T)))
       (|checkWarningIndentation|))
      ((EQ |op| '|;|)
       (CONS 'CAPSULE (|postBlockItemList| (|postFlatten| |x| '|;|))))
      ((OR (EQ |op| '|if|) (INTEGERP |op|) (EQ |op| '==))
       (LIST 'CAPSULE (|postBlockItem| |x|)))
      (#1# (|checkWarningIndentation|))))))

; postQUOTE x == x

(DEFUN |postQUOTE| (|x|) (PROG () (RETURN |x|)))

; postConstruct u ==
;   u is ['construct,b] =>
;     a:= (b is [",",:.] => comma2Tuple b; b)
;     a is ['SEGMENT,p,q] => ['construct,postTranSegment(p,q)]
;     a is ["@Tuple", :l] =>
;       or/[x is [":",y] for x in l] => postMakeCons l
;       or/[x is ['SEGMENT,:.] for x in l] => tuple2List l
;       ['construct,:postTranList l]
;     ['construct,postTran a]
;   u

(DEFUN |postConstruct| (|u|)
  (PROG (|ISTMP#1| |b| |a| |p| |ISTMP#2| |q| |l| |y|)
    (RETURN
     (COND
      ((AND (CONSP |u|) (EQ (CAR |u|) '|construct|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |u|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |b| (CAR |ISTMP#1|)) #1='T))))
       (PROGN
        (SETQ |a|
                (COND
                 ((AND (CONSP |b|) (EQ (CAR |b|) '|,|)) (|comma2Tuple| |b|))
                 (#1# |b|)))
        (COND
         ((AND (CONSP |a|) (EQ (CAR |a|) 'SEGMENT)
               (PROGN
                (SETQ |ISTMP#1| (CDR |a|))
                (AND (CONSP |ISTMP#1|)
                     (PROGN
                      (SETQ |p| (CAR |ISTMP#1|))
                      (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                      (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                           (PROGN (SETQ |q| (CAR |ISTMP#2|)) #1#))))))
          (LIST '|construct| (|postTranSegment| |p| |q|)))
         ((AND (CONSP |a|) (EQ (CAR |a|) '|@Tuple|)
               (PROGN (SETQ |l| (CDR |a|)) #1#))
          (COND
           (((LAMBDA (|bfVar#8| |bfVar#7| |x|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#7|) (PROGN (SETQ |x| (CAR |bfVar#7|)) NIL))
                  (RETURN |bfVar#8|))
                 (#1#
                  (PROGN
                   (SETQ |bfVar#8|
                           (AND (CONSP |x|) (EQ (CAR |x|) '|:|)
                                (PROGN
                                 (SETQ |ISTMP#1| (CDR |x|))
                                 (AND (CONSP |ISTMP#1|)
                                      (EQ (CDR |ISTMP#1|) NIL)
                                      (PROGN
                                       (SETQ |y| (CAR |ISTMP#1|))
                                       #1#)))))
                   (COND (|bfVar#8| (RETURN |bfVar#8|))))))
                (SETQ |bfVar#7| (CDR |bfVar#7|))))
             NIL |l| NIL)
            (|postMakeCons| |l|))
           (((LAMBDA (|bfVar#10| |bfVar#9| |x|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#9|) (PROGN (SETQ |x| (CAR |bfVar#9|)) NIL))
                  (RETURN |bfVar#10|))
                 (#1#
                  (PROGN
                   (SETQ |bfVar#10| (AND (CONSP |x|) (EQ (CAR |x|) 'SEGMENT)))
                   (COND (|bfVar#10| (RETURN |bfVar#10|))))))
                (SETQ |bfVar#9| (CDR |bfVar#9|))))
             NIL |l| NIL)
            (|tuple2List| |l|))
           (#1# (CONS '|construct| (|postTranList| |l|)))))
         (#1# (LIST '|construct| (|postTran| |a|))))))
      (#1# |u|)))))

; postError msg ==
;   xmsg:=
;     BOUNDP("$defOp") => [$defOp, '": " , :msg]
;     msg
;   $postStack:= [xmsg,:$postStack]
;   nil

(DEFUN |postError| (|msg|)
  (PROG (|xmsg|)
    (RETURN
     (PROGN
      (SETQ |xmsg|
              (COND ((BOUNDP '|$defOp|) (CONS |$defOp| (CONS ": " |msg|)))
                    ('T |msg|)))
      (SETQ |$postStack| (CONS |xmsg| |$postStack|))
      NIL))))

; postMakeCons l ==
;   null l => ["empty"]
;   l is [[":",a],:l'] =>
;     l' => ['append,postTran a,postMakeCons l']
;     postTran a
;   ['cons,postTran first l,postMakeCons rest l]

(DEFUN |postMakeCons| (|l|)
  (PROG (|ISTMP#1| |ISTMP#2| |a| |l'|)
    (RETURN
     (COND ((NULL |l|) (LIST '|empty|))
           ((AND (CONSP |l|)
                 (PROGN
                  (SETQ |ISTMP#1| (CAR |l|))
                  (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|:|)
                       (PROGN
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |a| (CAR |ISTMP#2|)) #1='T)))))
                 (PROGN (SETQ |l'| (CDR |l|)) #1#))
            (COND
             (|l'| (LIST '|append| (|postTran| |a|) (|postMakeCons| |l'|)))
             (#1# (|postTran| |a|))))
           (#1#
            (LIST '|cons| (|postTran| (CAR |l|))
                  (|postMakeCons| (CDR |l|))))))))

; postAtom x ==
;   x=0 => '(Zero)
;   x=1 => '(One)
;   EQ(x,'T) => 'T_$ -- rename T in spad code to T$
;   IDENTP x and GETDATABASE(x,'NILADIC) => LIST x
;   x

(DEFUN |postAtom| (|x|)
  (PROG ()
    (RETURN
     (COND ((EQL |x| 0) '(|Zero|)) ((EQL |x| 1) '(|One|)) ((EQ |x| 'T) 'T$)
           ((AND (IDENTP |x|) (GETDATABASE |x| 'NILADIC)) (LIST |x|))
           ('T |x|)))))

; postBlockItemList l == [postBlockItem x for x in l]

(DEFUN |postBlockItemList| (|l|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#12| |bfVar#11| |x|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#11|) (PROGN (SETQ |x| (CAR |bfVar#11|)) NIL))
           (RETURN (NREVERSE |bfVar#12|)))
          ('T (SETQ |bfVar#12| (CONS (|postBlockItem| |x|) |bfVar#12|))))
         (SETQ |bfVar#11| (CDR |bfVar#11|))))
      NIL |l| NIL))))

; postBlockItem x ==
;   x:= postTran x
;   x is ["@Tuple", :l, [":", y, t]] and (and/[IDENTP x for x in l]) =>
;     [":",['LISTOF,:l,y],t]
;   x

(DEFUN |postBlockItem| (|x|)
  (PROG (|ISTMP#1| |ISTMP#2| |ISTMP#3| |ISTMP#4| |y| |ISTMP#5| |t| |l|)
    (RETURN
     (PROGN
      (SETQ |x| (|postTran| |x|))
      (COND
       ((AND (CONSP |x|) (EQ (CAR |x|) '|@Tuple|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |x|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN (SETQ |ISTMP#2| (REVERSE |ISTMP#1|)) #1='T)
                   (CONSP |ISTMP#2|)
                   (PROGN
                    (SETQ |ISTMP#3| (CAR |ISTMP#2|))
                    (AND (CONSP |ISTMP#3|) (EQ (CAR |ISTMP#3|) '|:|)
                         (PROGN
                          (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                          (AND (CONSP |ISTMP#4|)
                               (PROGN
                                (SETQ |y| (CAR |ISTMP#4|))
                                (SETQ |ISTMP#5| (CDR |ISTMP#4|))
                                (AND (CONSP |ISTMP#5|) (EQ (CDR |ISTMP#5|) NIL)
                                     (PROGN
                                      (SETQ |t| (CAR |ISTMP#5|))
                                      #1#)))))))
                   (PROGN (SETQ |l| (CDR |ISTMP#2|)) #1#)
                   (PROGN (SETQ |l| (NREVERSE |l|)) #1#)))
             ((LAMBDA (|bfVar#14| |bfVar#13| |x|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#13|)
                       (PROGN (SETQ |x| (CAR |bfVar#13|)) NIL))
                   (RETURN |bfVar#14|))
                  (#1#
                   (PROGN
                    (SETQ |bfVar#14| (IDENTP |x|))
                    (COND ((NOT |bfVar#14|) (RETURN NIL))))))
                 (SETQ |bfVar#13| (CDR |bfVar#13|))))
              T |l| NIL))
        (LIST '|:| (CONS 'LISTOF (APPEND |l| (CONS |y| NIL))) |t|))
       (#1# |x|))))))

; postCategory (u is ['CATEGORY,:l]) ==
;   --RDJ: ugh_ please -- someone take away need for PROGN as soon as possible
;   null l => u
;   op :=
;     $insidePostCategoryIfTrue = true => 'PROGN
;     'CATEGORY
;   [op,:[fn x for x in l]] where fn x ==
;     $insidePostCategoryIfTrue: local := true
;     postTran x

(DEFUN |postCategory| (|u|)
  (PROG (|l| |op|)
    (RETURN
     (PROGN
      (SETQ |l| (CDR |u|))
      (COND ((NULL |l|) |u|)
            (#1='T
             (PROGN
              (SETQ |op|
                      (COND ((EQUAL |$insidePostCategoryIfTrue| T) 'PROGN)
                            (#1# 'CATEGORY)))
              (CONS |op|
                    ((LAMBDA (|bfVar#16| |bfVar#15| |x|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#15|)
                              (PROGN (SETQ |x| (CAR |bfVar#15|)) NIL))
                          (RETURN (NREVERSE |bfVar#16|)))
                         (#1#
                          (SETQ |bfVar#16|
                                  (CONS (|postCategory,fn| |x|) |bfVar#16|))))
                        (SETQ |bfVar#15| (CDR |bfVar#15|))))
                     NIL |l| NIL)))))))))
(DEFUN |postCategory,fn| (|x|)
  (PROG (|$insidePostCategoryIfTrue|)
    (DECLARE (SPECIAL |$insidePostCategoryIfTrue|))
    (RETURN (PROGN (SETQ |$insidePostCategoryIfTrue| T) (|postTran| |x|)))))

; postComma u == postTuple comma2Tuple u

(DEFUN |postComma| (|u|) (PROG () (RETURN (|postTuple| (|comma2Tuple| |u|)))))

; comma2Tuple u == ["@Tuple", :postFlatten(u, ",")]

(DEFUN |comma2Tuple| (|u|)
  (PROG () (RETURN (CONS '|@Tuple| (|postFlatten| |u| '|,|)))))

; postDef [defOp,lhs,rhs] ==
; --+
;   lhs is ["macro",name] => postMDef ["==>",name,rhs]
;
;   recordHeaderDocumentation nil
;   if $maxSignatureLineNumber ~= 0 then
;     $docList := [['constructor,:$headerDocumentation],:$docList]
;     $maxSignatureLineNumber := 0
;     --reset this for next constructor; see recordDocumentation
;   lhs:= postTran lhs
;   [form,targetType]:=
;     lhs is [":",:.] => rest lhs
;     [lhs,nil]
;   if atom form then form := [form]
;   newLhs:= [(x is [":",a,.] => a; x) for x in form]
;   argTypeList:=
;     [(x is [":",.,t] => t; nil) for x in rest form]
;   typeList:= [targetType,:argTypeList]
;   trhs :=
;       rhs is ["=>", a, b] => ['IF,postTran a, postTran b, 'noBranch]
;       postTran rhs
;   ['DEF, newLhs, typeList, trhs]

(DEFUN |postDef| (|bfVar#21|)
  (PROG (|defOp| |lhs| |rhs| |ISTMP#1| |name| |LETTMP#1| |form| |targetType|
         |a| |ISTMP#2| |newLhs| |t| |argTypeList| |typeList| |b| |trhs|)
    (RETURN
     (PROGN
      (SETQ |defOp| (CAR |bfVar#21|))
      (SETQ |lhs| (CADR . #1=(|bfVar#21|)))
      (SETQ |rhs| (CADDR . #1#))
      (COND
       ((AND (CONSP |lhs|) (EQ (CAR |lhs|) '|macro|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |lhs|))
              (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                   (PROGN (SETQ |name| (CAR |ISTMP#1|)) #2='T))))
        (|postMDef| (LIST '==> |name| |rhs|)))
       (#2#
        (PROGN
         (|recordHeaderDocumentation| NIL)
         (COND
          ((NOT (EQL |$maxSignatureLineNumber| 0))
           (SETQ |$docList|
                   (CONS (CONS '|constructor| |$headerDocumentation|)
                         |$docList|))
           (SETQ |$maxSignatureLineNumber| 0)))
         (SETQ |lhs| (|postTran| |lhs|))
         (SETQ |LETTMP#1|
                 (COND ((AND (CONSP |lhs|) (EQ (CAR |lhs|) '|:|)) (CDR |lhs|))
                       (#2# (LIST |lhs| NIL))))
         (SETQ |form| (CAR |LETTMP#1|))
         (SETQ |targetType| (CADR |LETTMP#1|))
         (COND ((ATOM |form|) (SETQ |form| (LIST |form|))))
         (SETQ |newLhs|
                 ((LAMBDA (|bfVar#18| |bfVar#17| |x|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#17|)
                           (PROGN (SETQ |x| (CAR |bfVar#17|)) NIL))
                       (RETURN (NREVERSE |bfVar#18|)))
                      (#2#
                       (SETQ |bfVar#18|
                               (CONS
                                (COND
                                 ((AND (CONSP |x|) (EQ (CAR |x|) '|:|)
                                       (PROGN
                                        (SETQ |ISTMP#1| (CDR |x|))
                                        (AND (CONSP |ISTMP#1|)
                                             (PROGN
                                              (SETQ |a| (CAR |ISTMP#1|))
                                              (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                              (AND (CONSP |ISTMP#2|)
                                                   (EQ (CDR |ISTMP#2|)
                                                       NIL))))))
                                  |a|)
                                 (#2# |x|))
                                |bfVar#18|))))
                     (SETQ |bfVar#17| (CDR |bfVar#17|))))
                  NIL |form| NIL))
         (SETQ |argTypeList|
                 ((LAMBDA (|bfVar#20| |bfVar#19| |x|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#19|)
                           (PROGN (SETQ |x| (CAR |bfVar#19|)) NIL))
                       (RETURN (NREVERSE |bfVar#20|)))
                      (#2#
                       (SETQ |bfVar#20|
                               (CONS
                                (COND
                                 ((AND (CONSP |x|) (EQ (CAR |x|) '|:|)
                                       (PROGN
                                        (SETQ |ISTMP#1| (CDR |x|))
                                        (AND (CONSP |ISTMP#1|)
                                             (PROGN
                                              (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                              (AND (CONSP |ISTMP#2|)
                                                   (EQ (CDR |ISTMP#2|) NIL)
                                                   (PROGN
                                                    (SETQ |t| (CAR |ISTMP#2|))
                                                    #2#))))))
                                  |t|)
                                 (#2# NIL))
                                |bfVar#20|))))
                     (SETQ |bfVar#19| (CDR |bfVar#19|))))
                  NIL (CDR |form|) NIL))
         (SETQ |typeList| (CONS |targetType| |argTypeList|))
         (SETQ |trhs|
                 (COND
                  ((AND (CONSP |rhs|) (EQ (CAR |rhs|) '=>)
                        (PROGN
                         (SETQ |ISTMP#1| (CDR |rhs|))
                         (AND (CONSP |ISTMP#1|)
                              (PROGN
                               (SETQ |a| (CAR |ISTMP#1|))
                               (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                               (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                    (PROGN (SETQ |b| (CAR |ISTMP#2|)) #2#))))))
                   (LIST 'IF (|postTran| |a|) (|postTran| |b|) '|noBranch|))
                  (#2# (|postTran| |rhs|))))
         (LIST 'DEF |newLhs| |typeList| |trhs|))))))))

; postMDef(t) ==
;   [.,lhs,rhs] := t
;   lhs := postTran lhs
;   [form,targetType]:=
;     lhs is [":",:.] => rest lhs
;     [lhs,nil]
;   form:=
;     atom form => LIST form
;     form
;   newLhs:= [(x is [":",a,:.] => a; x) for x in form]
;   typeList:= [targetType,:[(x is [":",.,t] => t; nil) for x in rest form]]
;   ['MDEF, newLhs, typeList, postTran rhs]

(DEFUN |postMDef| (|t|)
  (PROG (|lhs| |rhs| |LETTMP#1| |form| |targetType| |ISTMP#1| |a| |newLhs|
         |ISTMP#2| |typeList|)
    (RETURN
     (PROGN
      (SETQ |lhs| (CADR . #1=(|t|)))
      (SETQ |rhs| (CADDR . #1#))
      (SETQ |lhs| (|postTran| |lhs|))
      (SETQ |LETTMP#1|
              (COND ((AND (CONSP |lhs|) (EQ (CAR |lhs|) '|:|)) (CDR |lhs|))
                    (#2='T (LIST |lhs| NIL))))
      (SETQ |form| (CAR |LETTMP#1|))
      (SETQ |targetType| (CADR |LETTMP#1|))
      (SETQ |form| (COND ((ATOM |form|) (LIST |form|)) (#2# |form|)))
      (SETQ |newLhs|
              ((LAMBDA (|bfVar#23| |bfVar#22| |x|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#22|)
                        (PROGN (SETQ |x| (CAR |bfVar#22|)) NIL))
                    (RETURN (NREVERSE |bfVar#23|)))
                   (#2#
                    (SETQ |bfVar#23|
                            (CONS
                             (COND
                              ((AND (CONSP |x|) (EQ (CAR |x|) '|:|)
                                    (PROGN
                                     (SETQ |ISTMP#1| (CDR |x|))
                                     (AND (CONSP |ISTMP#1|)
                                          (PROGN
                                           (SETQ |a| (CAR |ISTMP#1|))
                                           #2#))))
                               |a|)
                              (#2# |x|))
                             |bfVar#23|))))
                  (SETQ |bfVar#22| (CDR |bfVar#22|))))
               NIL |form| NIL))
      (SETQ |typeList|
              (CONS |targetType|
                    ((LAMBDA (|bfVar#25| |bfVar#24| |x|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#24|)
                              (PROGN (SETQ |x| (CAR |bfVar#24|)) NIL))
                          (RETURN (NREVERSE |bfVar#25|)))
                         (#2#
                          (SETQ |bfVar#25|
                                  (CONS
                                   (COND
                                    ((AND (CONSP |x|) (EQ (CAR |x|) '|:|)
                                          (PROGN
                                           (SETQ |ISTMP#1| (CDR |x|))
                                           (AND (CONSP |ISTMP#1|)
                                                (PROGN
                                                 (SETQ |ISTMP#2|
                                                         (CDR |ISTMP#1|))
                                                 (AND (CONSP |ISTMP#2|)
                                                      (EQ (CDR |ISTMP#2|) NIL)
                                                      (PROGN
                                                       (SETQ |t|
                                                               (CAR |ISTMP#2|))
                                                       #2#))))))
                                     |t|)
                                    (#2# NIL))
                                   |bfVar#25|))))
                        (SETQ |bfVar#24| (CDR |bfVar#24|))))
                     NIL (CDR |form|) NIL)))
      (LIST 'MDEF |newLhs| |typeList| (|postTran| |rhs|))))))

; postExit ["=>",a,b] == ['IF,postTran a,['exit,postTran b],'noBranch]

(DEFUN |postExit| (|bfVar#26|)
  (PROG (|a| |b|)
    (RETURN
     (PROGN
      (SETQ |a| (CADR . #1=(|bfVar#26|)))
      (SETQ |b| (CADDR . #1#))
      (LIST 'IF (|postTran| |a|) (LIST '|exit| (|postTran| |b|))
            '|noBranch|)))))

; postFlatten(x,op) ==
;   x is [ =op,a,b] => [:postFlatten(a,op),:postFlatten(b,op)]
;   LIST x

(DEFUN |postFlatten| (|x| |op|)
  (PROG (|ISTMP#1| |a| |ISTMP#2| |b|)
    (RETURN
     (COND
      ((AND (CONSP |x|) (EQUAL (CAR |x|) |op|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |a| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1='T))))))
       (APPEND (|postFlatten| |a| |op|) (|postFlatten| |b| |op|)))
      (#1# (LIST |x|))))))

; postForm (u is [op,:argl]) ==
;   x:=
;     atom op =>
;       argl':= postTranList argl
;       [op,:argl']
;     u:= postTranList u
;     if u is [["@Tuple", :.], :.] then
;       postError ['"  ",:bright u,
;         '"is illegal because tuples cannot be applied!",'%l,
;           '"   Did you misuse infix dot?"]
;     u
;   x is [., ["@Tuple", :y]] => [first x, :y]
;   x

(DEFUN |postForm| (|u|)
  (PROG (|op| |argl| |argl'| |ISTMP#1| |x| |ISTMP#2| |y|)
    (RETURN
     (PROGN
      (SETQ |op| (CAR |u|))
      (SETQ |argl| (CDR |u|))
      (SETQ |x|
              (COND
               ((ATOM |op|)
                (PROGN
                 (SETQ |argl'| (|postTranList| |argl|))
                 (CONS |op| |argl'|)))
               (#1='T
                (PROGN
                 (SETQ |u| (|postTranList| |u|))
                 (COND
                  ((AND (CONSP |u|)
                        (PROGN
                         (SETQ |ISTMP#1| (CAR |u|))
                         (AND (CONSP |ISTMP#1|)
                              (EQ (CAR |ISTMP#1|) '|@Tuple|))))
                   (|postError|
                    (CONS "  "
                          (APPEND (|bright| |u|)
                                  (CONS
                                   "is illegal because tuples cannot be applied!"
                                   (CONS '|%l|
                                         (CONS "   Did you misuse infix dot?"
                                               NIL))))))))
                 |u|))))
      (COND
       ((AND (CONSP |x|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |x|))
              (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                   (PROGN
                    (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|) (EQ (CAR |ISTMP#2|) '|@Tuple|)
                         (PROGN (SETQ |y| (CDR |ISTMP#2|)) #1#))))))
        (CONS (CAR |x|) |y|))
       (#1# |x|))))))

; postIf t ==
;   t isnt ["if",:l] => t
;   ['IF, :[(null(x := postTran x) => 'noBranch; x)
;     for x in l]]

(DEFUN |postIf| (|t|)
  (PROG (|l|)
    (RETURN
     (COND
      ((NOT
        (AND (CONSP |t|) (EQ (CAR |t|) '|if|)
             (PROGN (SETQ |l| (CDR |t|)) #1='T)))
       |t|)
      (#1#
       (CONS 'IF
             ((LAMBDA (|bfVar#28| |bfVar#27| |x|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#27|)
                       (PROGN (SETQ |x| (CAR |bfVar#27|)) NIL))
                   (RETURN (NREVERSE |bfVar#28|)))
                  (#1#
                   (SETQ |bfVar#28|
                           (CONS
                            (COND
                             ((NULL (SETQ |x| (|postTran| |x|))) '|noBranch|)
                             (#1# |x|))
                            |bfVar#28|))))
                 (SETQ |bfVar#27| (CDR |bfVar#27|))))
              NIL |l| NIL)))))))

; postJoin ['Join,a,:l] ==
;   a:= postTran a
;   l:= postTranList l
;   if l is [b] and b is [name, :.] and MEMQ(name, ["ATTRIBUTE", "SIGNATURE"])
;   then l := LIST(['CATEGORY, b])
;   al:=
;     a is ["@Tuple", :c] => c
;     LIST a
;   ['Join,:al,:l]

(DEFUN |postJoin| (|bfVar#29|)
  (PROG (|a| |l| |b| |name| |c| |al|)
    (RETURN
     (PROGN
      (SETQ |a| (CADR . #1=(|bfVar#29|)))
      (SETQ |l| (CDDR . #1#))
      (SETQ |a| (|postTran| |a|))
      (SETQ |l| (|postTranList| |l|))
      (COND
       ((AND (CONSP |l|) (EQ (CDR |l|) NIL) (PROGN (SETQ |b| (CAR |l|)) #2='T)
             (CONSP |b|) (PROGN (SETQ |name| (CAR |b|)) #2#)
             (MEMQ |name| (LIST 'ATTRIBUTE 'SIGNATURE)))
        (SETQ |l| (LIST (LIST 'CATEGORY |b|)))))
      (SETQ |al|
              (COND
               ((AND (CONSP |a|) (EQ (CAR |a|) '|@Tuple|)
                     (PROGN (SETQ |c| (CDR |a|)) #2#))
                |c|)
               (#2# (LIST |a|))))
      (CONS '|Join| (APPEND |al| |l|))))))

; postMapping u  ==
;   u isnt ["->",source,target] => u
;   ['Mapping,postTran target,:unTuple postTran source]

(DEFUN |postMapping| (|u|)
  (PROG (|ISTMP#1| |source| |ISTMP#2| |target|)
    (RETURN
     (COND
      ((NOT
        (AND (CONSP |u|) (EQ (CAR |u|) '->)
             (PROGN
              (SETQ |ISTMP#1| (CDR |u|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |source| (CAR |ISTMP#1|))
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                         (PROGN (SETQ |target| (CAR |ISTMP#2|)) #1='T)))))))
       |u|)
      (#1#
       (CONS '|Mapping|
             (CONS (|postTran| |target|)
                   (|unTuple| (|postTran| |source|)))))))))

; postRepeat ['REPEAT,:m,x] == ['REPEAT,:postIteratorList m,postTran x]

(DEFUN |postRepeat| (|bfVar#30|)
  (PROG (|LETTMP#1| |x| |m|)
    (RETURN
     (PROGN
      (SETQ |LETTMP#1| (REVERSE (CDR |bfVar#30|)))
      (SETQ |x| (CAR |LETTMP#1|))
      (SETQ |m| (NREVERSE (CDR |LETTMP#1|)))
      (CONS 'REPEAT
            (APPEND (|postIteratorList| |m|) (CONS (|postTran| |x|) NIL)))))))

; postSEGMENT ['SEGMENT,a,b] ==
;   key:= [a,'"..",:(b => [b]; nil)]
;   postError ['"   Improper placement of segment",:bright key]

(DEFUN |postSEGMENT| (|bfVar#31|)
  (PROG (|a| |b| |key|)
    (RETURN
     (PROGN
      (SETQ |a| (CADR . #1=(|bfVar#31|)))
      (SETQ |b| (CADDR . #1#))
      (SETQ |key| (CONS |a| (CONS ".." (COND (|b| (LIST |b|)) ('T NIL)))))
      (|postError|
       (CONS "   Improper placement of segment" (|bright| |key|)))))))

; postCollect [constructOp,:m,x] ==
;   x is [['Sel, D, 'construct], :y] =>
;     postCollect [['Sel, D, 'COLLECT], :m, ['construct, :y]]
;   itl:= postIteratorList m
;   x:= (x is ['construct,r] => r; x)  --added 84/8/31
;   y:= postTran x
;   finish(constructOp,itl,y) where
;     finish(op,itl,y) ==
;       y is [":",a] => ['REDUCE,'append,0,[op,:itl,a]]
;       y is ["@Tuple", :l] =>
;         newBody:=
;           or/[x is [":",y] for x in l] => postMakeCons l
;           or/[x is ['SEGMENT,:.] for x in l] => tuple2List l
;           ['construct,:postTranList l]
;         ['REDUCE,'append,0,[op,:itl,newBody]]
;       [op,:itl,y]

(DEFUN |postCollect| (|bfVar#36|)
  (PROG (|constructOp| |LETTMP#1| |x| |m| |ISTMP#1| |ISTMP#2| D |ISTMP#3| |y|
         |itl| |r|)
    (RETURN
     (PROGN
      (SETQ |constructOp| (CAR |bfVar#36|))
      (SETQ |LETTMP#1| (REVERSE (CDR |bfVar#36|)))
      (SETQ |x| (CAR |LETTMP#1|))
      (SETQ |m| (NREVERSE (CDR |LETTMP#1|)))
      (COND
       ((AND (CONSP |x|)
             (PROGN
              (SETQ |ISTMP#1| (CAR |x|))
              (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|Sel|)
                   (PROGN
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|)
                         (PROGN
                          (SETQ D (CAR |ISTMP#2|))
                          (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                          (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                               (EQ (CAR |ISTMP#3|) '|construct|)))))))
             (PROGN (SETQ |y| (CDR |x|)) #1='T))
        (|postCollect|
         (CONS (LIST '|Sel| D 'COLLECT)
               (APPEND |m| (CONS (CONS '|construct| |y|) NIL)))))
       (#1#
        (PROGN
         (SETQ |itl| (|postIteratorList| |m|))
         (SETQ |x|
                 (COND
                  ((AND (CONSP |x|) (EQ (CAR |x|) '|construct|)
                        (PROGN
                         (SETQ |ISTMP#1| (CDR |x|))
                         (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                              (PROGN (SETQ |r| (CAR |ISTMP#1|)) #1#))))
                   |r|)
                  (#1# |x|)))
         (SETQ |y| (|postTran| |x|))
         (|postCollect,finish| |constructOp| |itl| |y|))))))))
(DEFUN |postCollect,finish| (|op| |itl| |y|)
  (PROG (|ISTMP#1| |a| |l| |newBody|)
    (RETURN
     (COND
      ((AND (CONSP |y|) (EQ (CAR |y|) '|:|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |y|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |a| (CAR |ISTMP#1|)) #1='T))))
       (LIST 'REDUCE '|append| 0 (CONS |op| (APPEND |itl| (CONS |a| NIL)))))
      ((AND (CONSP |y|) (EQ (CAR |y|) '|@Tuple|)
            (PROGN (SETQ |l| (CDR |y|)) #1#))
       (PROGN
        (SETQ |newBody|
                (COND
                 (((LAMBDA (|bfVar#33| |bfVar#32| |x|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#32|)
                            (PROGN (SETQ |x| (CAR |bfVar#32|)) NIL))
                        (RETURN |bfVar#33|))
                       (#1#
                        (PROGN
                         (SETQ |bfVar#33|
                                 (AND (CONSP |x|) (EQ (CAR |x|) '|:|)
                                      (PROGN
                                       (SETQ |ISTMP#1| (CDR |x|))
                                       (AND (CONSP |ISTMP#1|)
                                            (EQ (CDR |ISTMP#1|) NIL)
                                            (PROGN
                                             (SETQ |y| (CAR |ISTMP#1|))
                                             #1#)))))
                         (COND (|bfVar#33| (RETURN |bfVar#33|))))))
                      (SETQ |bfVar#32| (CDR |bfVar#32|))))
                   NIL |l| NIL)
                  (|postMakeCons| |l|))
                 (((LAMBDA (|bfVar#35| |bfVar#34| |x|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#34|)
                            (PROGN (SETQ |x| (CAR |bfVar#34|)) NIL))
                        (RETURN |bfVar#35|))
                       (#1#
                        (PROGN
                         (SETQ |bfVar#35|
                                 (AND (CONSP |x|) (EQ (CAR |x|) 'SEGMENT)))
                         (COND (|bfVar#35| (RETURN |bfVar#35|))))))
                      (SETQ |bfVar#34| (CDR |bfVar#34|))))
                   NIL |l| NIL)
                  (|tuple2List| |l|))
                 (#1# (CONS '|construct| (|postTranList| |l|)))))
        (LIST 'REDUCE '|append| 0
              (CONS |op| (APPEND |itl| (CONS |newBody| NIL))))))
      (#1# (CONS |op| (APPEND |itl| (CONS |y| NIL))))))))

; postIteratorList x ==
;   x is [p,:l] =>
;     (p:= postTran p) is ['IN,y,u] =>
;       u is ["|",a,b] => [['IN,y,postInSeq a],["|",b],:postIteratorList l]
;       [['IN,y,postInSeq u],:postIteratorList l]
;     p is  ['INBY, y, u, v] =>
;       u is ["|",a,b] =>
;           [['INBY, y, postInSeq a, v], ["|",b], :postIteratorList l]
;       [['INBY, y, u, v], :postIteratorList l]
;     [p,:postIteratorList l]
;   x

(DEFUN |postIteratorList| (|x|)
  (PROG (|p| |l| |ISTMP#1| |ISTMP#2| |y| |ISTMP#3| |u| |a| |b| |v|)
    (RETURN
     (COND
      ((AND (CONSP |x|)
            (PROGN (SETQ |p| (CAR |x|)) (SETQ |l| (CDR |x|)) #1='T))
       (COND
        ((PROGN
          (SETQ |ISTMP#1| (SETQ |p| (|postTran| |p|)))
          (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) 'IN)
               (PROGN
                (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                (AND (CONSP |ISTMP#2|)
                     (PROGN
                      (SETQ |y| (CAR |ISTMP#2|))
                      (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                      (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                           (PROGN (SETQ |u| (CAR |ISTMP#3|)) #1#)))))))
         (COND
          ((AND (CONSP |u|) (EQ (CAR |u|) '|\||)
                (PROGN
                 (SETQ |ISTMP#1| (CDR |u|))
                 (AND (CONSP |ISTMP#1|)
                      (PROGN
                       (SETQ |a| (CAR |ISTMP#1|))
                       (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                       (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                            (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1#))))))
           (CONS (LIST 'IN |y| (|postInSeq| |a|))
                 (CONS (LIST '|\|| |b|) (|postIteratorList| |l|))))
          (#1#
           (CONS (LIST 'IN |y| (|postInSeq| |u|)) (|postIteratorList| |l|)))))
        ((AND (CONSP |p|) (EQ (CAR |p|) 'INBY)
              (PROGN
               (SETQ |ISTMP#1| (CDR |p|))
               (AND (CONSP |ISTMP#1|)
                    (PROGN
                     (SETQ |y| (CAR |ISTMP#1|))
                     (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                     (AND (CONSP |ISTMP#2|)
                          (PROGN
                           (SETQ |u| (CAR |ISTMP#2|))
                           (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                           (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                                (PROGN (SETQ |v| (CAR |ISTMP#3|)) #1#))))))))
         (COND
          ((AND (CONSP |u|) (EQ (CAR |u|) '|\||)
                (PROGN
                 (SETQ |ISTMP#1| (CDR |u|))
                 (AND (CONSP |ISTMP#1|)
                      (PROGN
                       (SETQ |a| (CAR |ISTMP#1|))
                       (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                       (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                            (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1#))))))
           (CONS (LIST 'INBY |y| (|postInSeq| |a|) |v|)
                 (CONS (LIST '|\|| |b|) (|postIteratorList| |l|))))
          (#1# (CONS (LIST 'INBY |y| |u| |v|) (|postIteratorList| |l|)))))
        (#1# (CONS |p| (|postIteratorList| |l|)))))
      (#1# |x|)))))

; postin arg ==
;   arg isnt ["in",i,seq] => systemErrorHere '"postin"
;   ["in",postTran i, postInSeq seq]

(DEFUN |postin| (|arg|)
  (PROG (|ISTMP#1| |i| |ISTMP#2| |seq|)
    (RETURN
     (COND
      ((NOT
        (AND (CONSP |arg|) (EQ (CAR |arg|) '|in|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |arg|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |i| (CAR |ISTMP#1|))
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                         (PROGN (SETQ |seq| (CAR |ISTMP#2|)) #1='T)))))))
       (|systemErrorHere| "postin"))
      (#1# (LIST '|in| (|postTran| |i|) (|postInSeq| |seq|)))))))

; postIn arg ==
;   arg isnt ['IN,i,seq] => systemErrorHere '"postIn"
;   ['IN,postTran i,postInSeq seq]

(DEFUN |postIn| (|arg|)
  (PROG (|ISTMP#1| |i| |ISTMP#2| |seq|)
    (RETURN
     (COND
      ((NOT
        (AND (CONSP |arg|) (EQ (CAR |arg|) 'IN)
             (PROGN
              (SETQ |ISTMP#1| (CDR |arg|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |i| (CAR |ISTMP#1|))
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                         (PROGN (SETQ |seq| (CAR |ISTMP#2|)) #1='T)))))))
       (|systemErrorHere| "postIn"))
      (#1# (LIST 'IN (|postTran| |i|) (|postInSeq| |seq|)))))))

; postInSeq seq ==
;   seq is ['SEGMENT,p,q] => postTranSegment(p,q)
;   seq is ["@Tuple", :l] => tuple2List l
;   postTran seq

(DEFUN |postInSeq| (|seq|)
  (PROG (|ISTMP#1| |p| |ISTMP#2| |q| |l|)
    (RETURN
     (COND
      ((AND (CONSP |seq|) (EQ (CAR |seq|) 'SEGMENT)
            (PROGN
             (SETQ |ISTMP#1| (CDR |seq|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |p| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |q| (CAR |ISTMP#2|)) #1='T))))))
       (|postTranSegment| |p| |q|))
      ((AND (CONSP |seq|) (EQ (CAR |seq|) '|@Tuple|)
            (PROGN (SETQ |l| (CDR |seq|)) #1#))
       (|tuple2List| |l|))
      (#1# (|postTran| |seq|))))))

; postTranSegment(p,q) == ['SEGMENT,postTran p,(q => postTran q; nil)]

(DEFUN |postTranSegment| (|p| |q|)
  (PROG ()
    (RETURN
     (LIST 'SEGMENT (|postTran| |p|) (COND (|q| (|postTran| |q|)) ('T NIL))))))

; tuple2List l ==
;   l is [a,:l'] =>
;     u:= tuple2List l'
;     null u => ['construct,postTran a]
;     ["cons", postTran a, u]
;   nil

(DEFUN |tuple2List| (|l|)
  (PROG (|a| |l'| |u|)
    (RETURN
     (COND
      ((AND (CONSP |l|)
            (PROGN (SETQ |a| (CAR |l|)) (SETQ |l'| (CDR |l|)) #1='T))
       (PROGN
        (SETQ |u| (|tuple2List| |l'|))
        (COND ((NULL |u|) (LIST '|construct| (|postTran| |a|)))
              (#1# (LIST '|cons| (|postTran| |a|) |u|)))))
      (#1# NIL)))))

; postReduce ['Reduce,op,expr] ==
;   expr is ['COLLECT, :.] =>
;     ['REDUCE,op,0,postTran expr]
;   postReduce ['Reduce,op,['COLLECT,['IN,g:= GENSYM(),expr],
;     ['construct,  g]]]

(DEFUN |postReduce| (|bfVar#37|)
  (PROG (|op| |expr| |g|)
    (RETURN
     (PROGN
      (SETQ |op| (CADR . #1=(|bfVar#37|)))
      (SETQ |expr| (CADDR . #1#))
      (COND
       ((AND (CONSP |expr|) (EQ (CAR |expr|) 'COLLECT))
        (LIST 'REDUCE |op| 0 (|postTran| |expr|)))
       ('T
        (|postReduce|
         (LIST '|Reduce| |op|
               (LIST 'COLLECT (LIST 'IN (SETQ |g| (GENSYM)) |expr|)
                     (LIST '|construct| |g|))))))))))

; postFlattenLeft(x,op) ==--
;   x is [ =op,a,b] => [:postFlattenLeft(a,op),b]
;   [x]

(DEFUN |postFlattenLeft| (|x| |op|)
  (PROG (|ISTMP#1| |a| |ISTMP#2| |b|)
    (RETURN
     (COND
      ((AND (CONSP |x|) (EQUAL (CAR |x|) |op|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |a| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1='T))))))
       (APPEND (|postFlattenLeft| |a| |op|) (CONS |b| NIL)))
      (#1# (LIST |x|))))))

; postSemiColon u ==
;     [:l, x] := postFlattenLeft(u, ";")
;     ['SEQ, :postBlockItemList l, ["exit", postTran x]]

(DEFUN |postSemiColon| (|u|)
  (PROG (|LETTMP#1| |LETTMP#2| |x| |l|)
    (RETURN
     (PROGN
      (SETQ |LETTMP#1| (|postFlattenLeft| |u| '|;|))
      (SETQ |LETTMP#2| (REVERSE |LETTMP#1|))
      (SETQ |x| (CAR |LETTMP#2|))
      (SETQ |l| (NREVERSE (CDR |LETTMP#2|)))
      (CONS 'SEQ
            (APPEND (|postBlockItemList| |l|)
                    (CONS (LIST '|exit| (|postTran| |x|)) NIL)))))))

; postSignature1(op, sig) ==
;     sig1 := postType sig
;     op := postAtom (STRINGP op => INTERN op; op)
;     sig is ["->",:.] =>
;         ["SIGNATURE",op,:removeSuperfluousMapping killColons sig1]
;     ["SIGNATURE", op, killColons sig1, "constant"]

(DEFUN |postSignature1| (|op| |sig|)
  (PROG (|sig1|)
    (RETURN
     (PROGN
      (SETQ |sig1| (|postType| |sig|))
      (SETQ |op|
              (|postAtom| (COND ((STRINGP |op|) (INTERN |op|)) (#1='T |op|))))
      (COND
       ((AND (CONSP |sig|) (EQ (CAR |sig|) '->))
        (CONS 'SIGNATURE
              (CONS |op| (|removeSuperfluousMapping| (|killColons| |sig1|)))))
       (#1# (LIST 'SIGNATURE |op| (|killColons| |sig1|) '|constant|)))))))

; postSignature ['Signature, op, sig, doc] ==
;     res1 := postSignature1(op, sig)
;     if res1 then record_on_docList(rest res1, doc)
;     res1

(DEFUN |postSignature| (|bfVar#38|)
  (PROG (|op| |sig| |doc| |res1|)
    (RETURN
     (PROGN
      (SETQ |op| (CADR . #1=(|bfVar#38|)))
      (SETQ |sig| (CADDR . #1#))
      (SETQ |doc| (CADDDR . #1#))
      (SETQ |res1| (|postSignature1| |op| |sig|))
      (COND (|res1| (|record_on_docList| (CDR |res1|) |doc|)))
      |res1|))))

; killColons x ==
;   atom x => x
;   x is ['Record,:.] => x
;   x is ['Union,:.] => x
;   x is [":",.,y] => killColons y
;   [killColons first x,:killColons rest x]

(DEFUN |killColons| (|x|)
  (PROG (|ISTMP#1| |ISTMP#2| |y|)
    (RETURN
     (COND ((ATOM |x|) |x|) ((AND (CONSP |x|) (EQ (CAR |x|) '|Record|)) |x|)
           ((AND (CONSP |x|) (EQ (CAR |x|) '|Union|)) |x|)
           ((AND (CONSP |x|) (EQ (CAR |x|) '|:|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |x|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |y| (CAR |ISTMP#2|)) #1='T))))))
            (|killColons| |y|))
           (#1# (CONS (|killColons| (CAR |x|)) (|killColons| (CDR |x|))))))))

; postSlash ['_/,a,b] ==
;   STRINGP a => postTran ['Reduce,INTERN a,b]
;   ['_/,postTran a,postTran b]

(DEFUN |postSlash| (|bfVar#39|)
  (PROG (|a| |b|)
    (RETURN
     (PROGN
      (SETQ |a| (CADR . #1=(|bfVar#39|)))
      (SETQ |b| (CADDR . #1#))
      (COND ((STRINGP |a|) (|postTran| (LIST '|Reduce| (INTERN |a|) |b|)))
            ('T (LIST '/ (|postTran| |a|) (|postTran| |b|))))))))

; removeSuperfluousMapping sig1 ==
;   --get rid of this asap
;   sig1 is [x,:y] and x is ['Mapping,:.] => [rest x,:y]
;   sig1

(DEFUN |removeSuperfluousMapping| (|sig1|)
  (PROG (|x| |y|)
    (RETURN
     (COND
      ((AND (CONSP |sig1|)
            (PROGN (SETQ |x| (CAR |sig1|)) (SETQ |y| (CDR |sig1|)) #1='T)
            (CONSP |x|) (EQ (CAR |x|) '|Mapping|))
       (CONS (CDR |x|) |y|))
      (#1# |sig1|)))))

; postType typ ==
;   typ is ["->",source,target] =>
;     source="constant" => [LIST postTran target,"constant"]
;     LIST ['Mapping,postTran target,:unTuple postTran source]
;   typ is ["->",target] => LIST ['Mapping,postTran target]
;   LIST postTran typ

(DEFUN |postType| (|typ|)
  (PROG (|ISTMP#1| |source| |ISTMP#2| |target|)
    (RETURN
     (COND
      ((AND (CONSP |typ|) (EQ (CAR |typ|) '->)
            (PROGN
             (SETQ |ISTMP#1| (CDR |typ|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |source| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |target| (CAR |ISTMP#2|)) #1='T))))))
       (COND
        ((EQ |source| '|constant|)
         (LIST (LIST (|postTran| |target|)) '|constant|))
        (#1#
         (LIST
          (CONS '|Mapping|
                (CONS (|postTran| |target|)
                      (|unTuple| (|postTran| |source|))))))))
      ((AND (CONSP |typ|) (EQ (CAR |typ|) '->)
            (PROGN
             (SETQ |ISTMP#1| (CDR |typ|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |target| (CAR |ISTMP#1|)) #1#))))
       (LIST (LIST '|Mapping| (|postTran| |target|))))
      (#1# (LIST (|postTran| |typ|)))))))

; postTuple u ==
;   u is ["@Tuple"] => u
;   u is ["@Tuple", :l, a] => (["@Tuple", :postTranList rest u])

(DEFUN |postTuple| (|u|)
  (PROG (|ISTMP#1| |ISTMP#2| |a| |l|)
    (RETURN
     (COND ((AND (CONSP |u|) (EQ (CDR |u|) NIL) (EQ (CAR |u|) '|@Tuple|)) |u|)
           ((AND (CONSP |u|) (EQ (CAR |u|) '|@Tuple|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |u|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN (SETQ |ISTMP#2| (REVERSE |ISTMP#1|)) #1='T)
                       (CONSP |ISTMP#2|)
                       (PROGN
                        (SETQ |a| (CAR |ISTMP#2|))
                        (SETQ |l| (CDR |ISTMP#2|))
                        #1#)
                       (PROGN (SETQ |l| (NREVERSE |l|)) #1#))))
            (CONS '|@Tuple| (|postTranList| (CDR |u|))))))))

; postWhere ["where",a,b] ==
;     ["where", postTran a, postTran b]

(DEFUN |postWhere| (|bfVar#40|)
  (PROG (|a| |b|)
    (RETURN
     (PROGN
      (SETQ |a| (CADR . #1=(|bfVar#40|)))
      (SETQ |b| (CADDR . #1#))
      (LIST '|where| (|postTran| |a|) (|postTran| |b|))))))

; postWith ["with",a] ==
;   $insidePostCategoryIfTrue: local := true
;   a:= postTran a
;   a is [op, :.] and MEMQ(op, ["ATTRIBUTE", "SIGNATURE", "IF"]) =>
;       ['CATEGORY, a]
;   a is ['PROGN,:b] => ['CATEGORY,:b]
;   a

(DEFUN |postWith| (|bfVar#41|)
  (PROG (|$insidePostCategoryIfTrue| |b| |op| |a|)
    (DECLARE (SPECIAL |$insidePostCategoryIfTrue|))
    (RETURN
     (PROGN
      (SETQ |a| (CADR |bfVar#41|))
      (SETQ |$insidePostCategoryIfTrue| T)
      (SETQ |a| (|postTran| |a|))
      (COND
       ((AND (CONSP |a|) (PROGN (SETQ |op| (CAR |a|)) #1='T)
             (MEMQ |op| (LIST 'ATTRIBUTE 'SIGNATURE 'IF)))
        (LIST 'CATEGORY |a|))
       ((AND (CONSP |a|) (EQ (CAR |a|) 'PROGN)
             (PROGN (SETQ |b| (CDR |a|)) #1#))
        (CONS 'CATEGORY |b|))
       (#1# |a|))))))

; postTransformCheck x ==
;   $defOp: local:= nil
;   postcheck x

(DEFUN |postTransformCheck| (|x|)
  (PROG (|$defOp|)
    (DECLARE (SPECIAL |$defOp|))
    (RETURN (PROGN (SETQ |$defOp| NIL) (|postcheck| |x|)))))

; postcheck x ==
;   atom x => nil
;   x is ['DEF,form,[target,:.],:.] =>
;     setDefOp form
;     nil
;   x is ['QUOTE,:.] => nil
;   postcheck first x
;   postcheck rest x

(DEFUN |postcheck| (|x|)
  (PROG (|ISTMP#1| |form| |ISTMP#2| |ISTMP#3| |target|)
    (RETURN
     (COND ((ATOM |x|) NIL)
           ((AND (CONSP |x|) (EQ (CAR |x|) 'DEF)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |x|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |form| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|)
                             (PROGN
                              (SETQ |ISTMP#3| (CAR |ISTMP#2|))
                              (AND (CONSP |ISTMP#3|)
                                   (PROGN
                                    (SETQ |target| (CAR |ISTMP#3|))
                                    #1='T))))))))
            (PROGN (|setDefOp| |form|) NIL))
           ((AND (CONSP |x|) (EQ (CAR |x|) 'QUOTE)) NIL)
           (#1# (PROGN (|postcheck| (CAR |x|)) (|postcheck| (CDR |x|))))))))

; setDefOp f ==
;   if f is [":",g,:.] then f := g
;   f := (atom f => f; first f)
;   if $topOp then $defOp:= f else $topOp:= f

(DEFUN |setDefOp| (|f|)
  (PROG (|ISTMP#1| |g|)
    (RETURN
     (PROGN
      (COND
       ((AND (CONSP |f|) (EQ (CAR |f|) '|:|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |f|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN (SETQ |g| (CAR |ISTMP#1|)) #1='T))))
        (SETQ |f| |g|)))
      (SETQ |f| (COND ((ATOM |f|) |f|) (#1# (CAR |f|))))
      (COND (|$topOp| (SETQ |$defOp| |f|)) (#1# (SETQ |$topOp| |f|)))))))

; unTuple x ==
;   x is ["@Tuple", :y] => y
;   LIST x

(DEFUN |unTuple| (|x|)
  (PROG (|y|)
    (RETURN
     (COND
      ((AND (CONSP |x|) (EQ (CAR |x|) '|@Tuple|)
            (PROGN (SETQ |y| (CDR |x|)) #1='T))
       |y|)
      (#1# (LIST |x|))))))
