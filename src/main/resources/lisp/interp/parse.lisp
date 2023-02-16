
; )package "BOOT"

(IN-PACKAGE "BOOT")

; parseTransform x ==
;   $defOp: local:= nil
;   x := SUBST('$, '%, x) -- for new compiler compatibility
;   parseTran x

(DEFUN |parseTransform| (|x|)
  (PROG (|$defOp|)
    (DECLARE (SPECIAL |$defOp|))
    (RETURN
     (PROGN
      (SETQ |$defOp| NIL)
      (SETQ |x| (SUBST '$ '% |x|))
      (|parseTran| |x|)))))

; init_parse_tran() ==
;     for opf in _
;          [["and", "parseAnd"], ["CATEGORY", "parseCategory"], _
;           ["DEF", "parseDEF"], ["exit", "parseExit"], _
;           ["has", "parseHas"], ["IF", "parseIf"], _
;           ["Join", "parseJoin"], ["leave", "parseLeave"], _
;           ["MDEF", "parseMDEF"], ["not", "parseNot"], _
;           ["or", "parseOr"], ["SEGMENT", "parseSegment"], _
;           ["SEQ", "parseSeq"]] repeat
;         MAKEPROP(first(opf), 'parseTran, first(rest(opf)))

(DEFUN |init_parse_tran| ()
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#1| |opf|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#1|) (PROGN (SETQ |opf| (CAR |bfVar#1|)) NIL))
           (RETURN NIL))
          ('T (MAKEPROP (CAR |opf|) '|parseTran| (CAR (CDR |opf|)))))
         (SETQ |bfVar#1| (CDR |bfVar#1|))))
      (LIST (LIST '|and| '|parseAnd|) (LIST 'CATEGORY '|parseCategory|)
            (LIST 'DEF '|parseDEF|) (LIST '|exit| '|parseExit|)
            (LIST '|has| '|parseHas|) (LIST 'IF '|parseIf|)
            (LIST '|Join| '|parseJoin|) (LIST '|leave| '|parseLeave|)
            (LIST 'MDEF '|parseMDEF|) (LIST '|not| '|parseNot|)
            (LIST '|or| '|parseOr|) (LIST 'SEGMENT '|parseSegment|)
            (LIST 'SEQ '|parseSeq|))
      NIL))))

; init_parse_tran()

(EVAL-WHEN (EVAL LOAD) (PROG () (RETURN (|init_parse_tran|))))

; parseTran x ==
;   atom x => parseAtom x
;   [op, :argl] := x
;   u := (op is ['Sel, ., x] => x; op)
;   SYMBOLP(u) and (fn := GET(u, 'parseTran)) =>
;       if op ~= u then SAY(["parseTran op ~= u", op, u])
;       FUNCALL(fn, argl)
;   [parseTran op, :parseTranList argl]

(DEFUN |parseTran| (|x|)
  (PROG (|op| |argl| |ISTMP#1| |ISTMP#2| |u| |fn|)
    (RETURN
     (COND ((ATOM |x|) (|parseAtom| |x|))
           (#1='T
            (PROGN
             (SETQ |op| (CAR |x|))
             (SETQ |argl| (CDR |x|))
             (SETQ |u|
                     (COND
                      ((AND (CONSP |op|) (EQ (CAR |op|) '|Sel|)
                            (PROGN
                             (SETQ |ISTMP#1| (CDR |op|))
                             (AND (CONSP |ISTMP#1|)
                                  (PROGN
                                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                   (AND (CONSP |ISTMP#2|)
                                        (EQ (CDR |ISTMP#2|) NIL)
                                        (PROGN
                                         (SETQ |x| (CAR |ISTMP#2|))
                                         #1#))))))
                       |x|)
                      (#1# |op|)))
             (COND
              ((AND (SYMBOLP |u|) (SETQ |fn| (GET |u| '|parseTran|)))
               (PROGN
                (COND
                 ((NOT (EQUAL |op| |u|))
                  (SAY (LIST '|parseTran op ~= u| |op| |u|))))
                (FUNCALL |fn| |argl|)))
              (#1# (CONS (|parseTran| |op|) (|parseTranList| |argl|))))))))))

; parseAtom x ==
;  -- next line for compatibility with new compiler
;   x = 'break => parseLeave ['$NoValue]
;   x

(DEFUN |parseAtom| (|x|)
  (PROG ()
    (RETURN
     (COND ((EQ |x| '|break|) (|parseLeave| (LIST '|$NoValue|))) ('T |x|)))))

; parseTranList l == [parseTran(y) for y in l]

(DEFUN |parseTranList| (|l|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#3| |bfVar#2| |y|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#2|) (PROGN (SETQ |y| (CAR |bfVar#2|)) NIL))
           (RETURN (NREVERSE |bfVar#3|)))
          ('T (SETQ |bfVar#3| (CONS (|parseTran| |y|) |bfVar#3|))))
         (SETQ |bfVar#2| (CDR |bfVar#2|))))
      NIL |l| NIL))))

; parseHas [x,y] ==
;   mkand [['has,x,u] for u in fn y] where
;     mkand x ==
;       x is [a] => a
;       ["and",:x]
;     fn y ==
;       y is [":" ,op,['Mapping,:map]] =>
;          op:= (STRINGP op => INTERN op; op)
;          [['SIGNATURE,op,map]]
;       y is ['Join,:u] => "append"/[fn z for z in u]
;       y is ['CATEGORY,:u] => "append"/[fn z for z in u]
;       y is ['SIGNATURE,:.] => [y]
;       [makeNonAtomic y]

(DEFUN |parseHas| (|bfVar#10|)
  (PROG (|x| |y|)
    (RETURN
     (PROGN
      (SETQ |x| (CAR |bfVar#10|))
      (SETQ |y| (CADR |bfVar#10|))
      (|parseHas,mkand|
       ((LAMBDA (|bfVar#5| |bfVar#4| |u|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#4|) (PROGN (SETQ |u| (CAR |bfVar#4|)) NIL))
             (RETURN (NREVERSE |bfVar#5|)))
            ('T (SETQ |bfVar#5| (CONS (LIST '|has| |x| |u|) |bfVar#5|))))
           (SETQ |bfVar#4| (CDR |bfVar#4|))))
        NIL (|parseHas,fn| |y|) NIL))))))
(DEFUN |parseHas,mkand| (|x|)
  (PROG (|a|)
    (RETURN
     (COND
      ((AND (CONSP |x|) (EQ (CDR |x|) NIL) (PROGN (SETQ |a| (CAR |x|)) #1='T))
       |a|)
      (#1# (CONS '|and| |x|))))))
(DEFUN |parseHas,fn| (|y|)
  (PROG (|ISTMP#1| |op| |ISTMP#2| |ISTMP#3| |map| |u|)
    (RETURN
     (COND
      ((AND (CONSP |y|) (EQ (CAR |y|) '|:|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |y|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |op| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN
                         (SETQ |ISTMP#3| (CAR |ISTMP#2|))
                         (AND (CONSP |ISTMP#3|) (EQ (CAR |ISTMP#3|) '|Mapping|)
                              (PROGN (SETQ |map| (CDR |ISTMP#3|)) #1='T))))))))
       (PROGN
        (SETQ |op| (COND ((STRINGP |op|) (INTERN |op|)) (#1# |op|)))
        (LIST (LIST 'SIGNATURE |op| |map|))))
      ((AND (CONSP |y|) (EQ (CAR |y|) '|Join|)
            (PROGN (SETQ |u| (CDR |y|)) #1#))
       ((LAMBDA (|bfVar#7| |bfVar#6| |z|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#6|) (PROGN (SETQ |z| (CAR |bfVar#6|)) NIL))
             (RETURN |bfVar#7|))
            (#1# (SETQ |bfVar#7| (APPEND |bfVar#7| (|parseHas,fn| |z|)))))
           (SETQ |bfVar#6| (CDR |bfVar#6|))))
        NIL |u| NIL))
      ((AND (CONSP |y|) (EQ (CAR |y|) 'CATEGORY)
            (PROGN (SETQ |u| (CDR |y|)) #1#))
       ((LAMBDA (|bfVar#9| |bfVar#8| |z|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#8|) (PROGN (SETQ |z| (CAR |bfVar#8|)) NIL))
             (RETURN |bfVar#9|))
            (#1# (SETQ |bfVar#9| (APPEND |bfVar#9| (|parseHas,fn| |z|)))))
           (SETQ |bfVar#8| (CDR |bfVar#8|))))
        NIL |u| NIL))
      ((AND (CONSP |y|) (EQ (CAR |y|) 'SIGNATURE)) (LIST |y|))
      (#1# (LIST (|makeNonAtomic| |y|)))))))

; parseDEF [lhs, tList, body] ==
;   setDefOp lhs
;   ['DEF, parseLhs lhs, parseTranList tList, parseTran(body)]

(DEFUN |parseDEF| (|bfVar#11|)
  (PROG (|lhs| |tList| |body|)
    (RETURN
     (PROGN
      (SETQ |lhs| (CAR |bfVar#11|))
      (SETQ |tList| (CADR . #1=(|bfVar#11|)))
      (SETQ |body| (CADDR . #1#))
      (|setDefOp| |lhs|)
      (LIST 'DEF (|parseLhs| |lhs|) (|parseTranList| |tList|)
            (|parseTran| |body|))))))

; parseLhs x ==
;   atom x => parseTran x
;   atom first x => [parseTran first x, :[parseTran y for y in rest x]]
;   parseTran x

(DEFUN |parseLhs| (|x|)
  (PROG ()
    (RETURN
     (COND ((ATOM |x|) (|parseTran| |x|))
           ((ATOM (CAR |x|))
            (CONS (|parseTran| (CAR |x|))
                  ((LAMBDA (|bfVar#13| |bfVar#12| |y|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#12|)
                            (PROGN (SETQ |y| (CAR |bfVar#12|)) NIL))
                        (RETURN (NREVERSE |bfVar#13|)))
                       (#1='T
                        (SETQ |bfVar#13| (CONS (|parseTran| |y|) |bfVar#13|))))
                      (SETQ |bfVar#12| (CDR |bfVar#12|))))
                   NIL (CDR |x|) NIL)))
           (#1# (|parseTran| |x|))))))

; parseMDEF [lhs, tList, body] ==
;   ['MDEF, parseTran lhs, parseTranList tList, parseTran(body)]

(DEFUN |parseMDEF| (|bfVar#14|)
  (PROG (|lhs| |tList| |body|)
    (RETURN
     (PROGN
      (SETQ |lhs| (CAR |bfVar#14|))
      (SETQ |tList| (CADR . #1=(|bfVar#14|)))
      (SETQ |body| (CADDR . #1#))
      (LIST 'MDEF (|parseTran| |lhs|) (|parseTranList| |tList|)
            (|parseTran| |body|))))))

; parseCategory x ==
;   l:= parseTranList x
;   -- Needed only for error messages in interpreter
;   key :=
;     CONTAINED("$",l) => "domain"
;     'package
;   ['CATEGORY,key,:l]

(DEFUN |parseCategory| (|x|)
  (PROG (|l| |key|)
    (RETURN
     (PROGN
      (SETQ |l| (|parseTranList| |x|))
      (SETQ |key| (COND ((CONTAINED '$ |l|) '|domain|) ('T '|package|)))
      (CONS 'CATEGORY (CONS |key| |l|))))))

; parseAnd u ==
;   null u => 'true
;   null rest u => first u
;   parseIf [parseTran first u,parseAnd rest u,"false"]

(DEFUN |parseAnd| (|u|)
  (PROG ()
    (RETURN
     (COND ((NULL |u|) '|true|) ((NULL (CDR |u|)) (CAR |u|))
           ('T
            (|parseIf|
             (LIST (|parseTran| (CAR |u|)) (|parseAnd| (CDR |u|))
                   '|false|)))))))

; parseOr u ==
;   null u => 'false
;   null rest u => first u
;   (x:= parseTran first u) is ['not,y] => parseIf [y,parseOr rest u,'true]
;   true => parseIf [x,'true,parseOr rest u]

(DEFUN |parseOr| (|u|)
  (PROG (|x| |ISTMP#1| |ISTMP#2| |y|)
    (RETURN
     (COND ((NULL |u|) '|false|) ((NULL (CDR |u|)) (CAR |u|))
           ((PROGN
             (SETQ |ISTMP#1| (SETQ |x| (|parseTran| (CAR |u|))))
             (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|not|)
                  (PROGN
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |y| (CAR |ISTMP#2|)) 'T)))))
            (|parseIf| (LIST |y| (|parseOr| (CDR |u|)) '|true|)))
           (T (|parseIf| (LIST |x| '|true| (|parseOr| (CDR |u|)))))))))

; parseNot u ==
;   parseTran ['IF,first u,:'(false true)]

(DEFUN |parseNot| (|u|)
  (PROG ()
    (RETURN (|parseTran| (CONS 'IF (CONS (CAR |u|) '(|false| |true|)))))))

; parseExit [a,:b] ==
;   --  note: I wanted to convert 1s to 0s here to facilitate indexing in
;   --   comp code; unfortunately, parseTran-ning is sometimes done more
;   --   than once so that the count can be decremented more than once
;   a:= parseTran a
;   b:= parseTran b
;   b =>
;     null INTEGERP a =>
;       (MOAN('"first arg ",a,'" for exit must be integer"); ['exit,1,a])
;     ['exit,a,:b]
;   ['exit,1,a]

(DEFUN |parseExit| (|bfVar#15|)
  (PROG (|a| |b|)
    (RETURN
     (PROGN
      (SETQ |a| (CAR |bfVar#15|))
      (SETQ |b| (CDR |bfVar#15|))
      (SETQ |a| (|parseTran| |a|))
      (SETQ |b| (|parseTran| |b|))
      (COND
       (|b|
        (COND
         ((NULL (INTEGERP |a|))
          (PROGN
           (MOAN "first arg " |a| " for exit must be integer")
           (LIST '|exit| 1 |a|)))
         (#1='T (CONS '|exit| (CONS |a| |b|)))))
       (#1# (LIST '|exit| 1 |a|)))))))

; parseLeave [a] ==
;   a:= parseTran a
;   ['leave,1,a]

(DEFUN |parseLeave| (|bfVar#16|)
  (PROG (|a|)
    (RETURN
     (PROGN
      (SETQ |a| (CAR |bfVar#16|))
      (SETQ |a| (|parseTran| |a|))
      (LIST '|leave| 1 |a|)))))

; parseJoin l ==
;   ['Join,:fn parseTranList l] where
;     fn l ==
;       null l => nil
;       l is [['Join,:x],:y] => [:x,:fn y]
;       [first l,:fn rest l]

(DEFUN |parseJoin| (|l|)
  (PROG () (RETURN (CONS '|Join| (|parseJoin,fn| (|parseTranList| |l|))))))
(DEFUN |parseJoin,fn| (|l|)
  (PROG (|ISTMP#1| |x| |y|)
    (RETURN
     (COND ((NULL |l|) NIL)
           ((AND (CONSP |l|)
                 (PROGN
                  (SETQ |ISTMP#1| (CAR |l|))
                  (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|Join|)
                       (PROGN (SETQ |x| (CDR |ISTMP#1|)) #1='T)))
                 (PROGN (SETQ |y| (CDR |l|)) #1#))
            (APPEND |x| (|parseJoin,fn| |y|)))
           (#1# (CONS (CAR |l|) (|parseJoin,fn| (CDR |l|))))))))

; parseSegment p ==
;   p is [a,b] =>
;     b => ['SEGMENT,parseTran a, parseTran b]
;     ['SEGMENT,parseTran a]
;   ['SEGMENT,:p]

(DEFUN |parseSegment| (|p|)
  (PROG (|a| |ISTMP#1| |b|)
    (RETURN
     (COND
      ((AND (CONSP |p|)
            (PROGN
             (SETQ |a| (CAR |p|))
             (SETQ |ISTMP#1| (CDR |p|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |b| (CAR |ISTMP#1|)) #1='T))))
       (COND (|b| (LIST 'SEGMENT (|parseTran| |a|) (|parseTran| |b|)))
             (#1# (LIST 'SEGMENT (|parseTran| |a|)))))
      (#1# (CONS 'SEGMENT |p|))))))

; parseIf t ==
;   t isnt [p,a,b] => t
;   ifTran(parseTran p,parseTran a,parseTran b) where
;     ifTran(p,a,b) ==
;       p = 'true  => a
;       p = 'false => b
;       p is ['not,p'] => ifTran(p',b,a)
;       p is ['IF,p',a',b'] => ifTran(p',ifTran(a',COPY a,COPY b),ifTran(b',a,b))
;       p is ['SEQ,:l,['exit,1,p']] =>
;         ['SEQ,:l,['exit,1,ifTran(p',incExitLevel a,incExitLevel b)]]
;          --this assumes that l has no exits
;       a is ['IF, =p,a',.] => ['IF,p,a',b]
;       b is ['IF, =p,.,b'] => ['IF,p,a,b']
;       makeSimplePredicateOrNil p is ['SEQ,:s,['exit,1,val]] =>
;         parseTran ['SEQ,:s,['exit,1,incExitLevel ['IF,val,a,b]]]
;       ['IF,p,a,b]

(DEFUN |parseIf| (|t|)
  (PROG (|p| |ISTMP#1| |a| |ISTMP#2| |b|)
    (RETURN
     (COND
      ((NOT
        (AND (CONSP |t|)
             (PROGN
              (SETQ |p| (CAR |t|))
              (SETQ |ISTMP#1| (CDR |t|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |a| (CAR |ISTMP#1|))
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                         (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1='T)))))))
       |t|)
      (#1#
       (|parseIf,ifTran| (|parseTran| |p|) (|parseTran| |a|)
        (|parseTran| |b|)))))))
(DEFUN |parseIf,ifTran| (|p| |a| |b|)
  (PROG (|ISTMP#1| |p'| |ISTMP#2| |a'| |ISTMP#3| |b'| |ISTMP#4| |ISTMP#5| |l|
         |ISTMP#6| |val| |s|)
    (RETURN
     (COND ((EQ |p| '|true|) |a|) ((EQ |p| '|false|) |b|)
           ((AND (CONSP |p|) (EQ (CAR |p|) '|not|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |p|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                       (PROGN (SETQ |p'| (CAR |ISTMP#1|)) #1='T))))
            (|parseIf,ifTran| |p'| |b| |a|))
           ((AND (CONSP |p|) (EQ (CAR |p|) 'IF)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |p|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |p'| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|)
                             (PROGN
                              (SETQ |a'| (CAR |ISTMP#2|))
                              (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                              (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                                   (PROGN
                                    (SETQ |b'| (CAR |ISTMP#3|))
                                    #1#))))))))
            (|parseIf,ifTran| |p'|
             (|parseIf,ifTran| |a'| (COPY |a|) (COPY |b|))
             (|parseIf,ifTran| |b'| |a| |b|)))
           ((AND (CONSP |p|) (EQ (CAR |p|) 'SEQ)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |p|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN (SETQ |ISTMP#2| (REVERSE |ISTMP#1|)) #1#)
                       (CONSP |ISTMP#2|)
                       (PROGN
                        (SETQ |ISTMP#3| (CAR |ISTMP#2|))
                        (AND (CONSP |ISTMP#3|) (EQ (CAR |ISTMP#3|) '|exit|)
                             (PROGN
                              (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                              (AND (CONSP |ISTMP#4|) (EQUAL (CAR |ISTMP#4|) 1)
                                   (PROGN
                                    (SETQ |ISTMP#5| (CDR |ISTMP#4|))
                                    (AND (CONSP |ISTMP#5|)
                                         (EQ (CDR |ISTMP#5|) NIL)
                                         (PROGN
                                          (SETQ |p'| (CAR |ISTMP#5|))
                                          #1#)))))))
                       (PROGN (SETQ |l| (CDR |ISTMP#2|)) #1#)
                       (PROGN (SETQ |l| (NREVERSE |l|)) #1#))))
            (CONS 'SEQ
                  (APPEND |l|
                          (CONS
                           (LIST '|exit| 1
                                 (|parseIf,ifTran| |p'| (|incExitLevel| |a|)
                                  (|incExitLevel| |b|)))
                           NIL))))
           ((AND (CONSP |a|) (EQ (CAR |a|) 'IF)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |a|))
                  (AND (CONSP |ISTMP#1|) (EQUAL (CAR |ISTMP#1|) |p|)
                       (PROGN
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|)
                             (PROGN
                              (SETQ |a'| (CAR |ISTMP#2|))
                              (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                              (AND (CONSP |ISTMP#3|)
                                   (EQ (CDR |ISTMP#3|) NIL))))))))
            (LIST 'IF |p| |a'| |b|))
           ((AND (CONSP |b|) (EQ (CAR |b|) 'IF)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |b|))
                  (AND (CONSP |ISTMP#1|) (EQUAL (CAR |ISTMP#1|) |p|)
                       (PROGN
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|)
                             (PROGN
                              (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                              (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                                   (PROGN
                                    (SETQ |b'| (CAR |ISTMP#3|))
                                    #1#))))))))
            (LIST 'IF |p| |a| |b'|))
           ((PROGN
             (SETQ |ISTMP#1| (|makeSimplePredicateOrNil| |p|))
             (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) 'SEQ)
                  (PROGN
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|)
                        (PROGN (SETQ |ISTMP#3| (REVERSE |ISTMP#2|)) #1#)
                        (CONSP |ISTMP#3|)
                        (PROGN
                         (SETQ |ISTMP#4| (CAR |ISTMP#3|))
                         (AND (CONSP |ISTMP#4|) (EQ (CAR |ISTMP#4|) '|exit|)
                              (PROGN
                               (SETQ |ISTMP#5| (CDR |ISTMP#4|))
                               (AND (CONSP |ISTMP#5|) (EQUAL (CAR |ISTMP#5|) 1)
                                    (PROGN
                                     (SETQ |ISTMP#6| (CDR |ISTMP#5|))
                                     (AND (CONSP |ISTMP#6|)
                                          (EQ (CDR |ISTMP#6|) NIL)
                                          (PROGN
                                           (SETQ |val| (CAR |ISTMP#6|))
                                           #1#)))))))
                        (PROGN (SETQ |s| (CDR |ISTMP#3|)) #1#)
                        (PROGN (SETQ |s| (NREVERSE |s|)) #1#)))))
            (|parseTran|
             (CONS 'SEQ
                   (APPEND |s|
                           (CONS
                            (LIST '|exit| 1
                                  (|incExitLevel| (LIST 'IF |val| |a| |b|)))
                            NIL)))))
           (#1# (LIST 'IF |p| |a| |b|))))))

; makeSimplePredicateOrNil p ==
;   isSimple p => nil
;   u:= isAlmostSimple p => u
;   true => wrapSEQExit [[":=", [":", g := GENSYM(), ["Boolean"]], p], g]

(DEFUN |makeSimplePredicateOrNil| (|p|)
  (PROG (|u| |g|)
    (RETURN
     (COND ((|isSimple| |p|) NIL) ((SETQ |u| (|isAlmostSimple| |p|)) |u|)
           (T
            (|wrapSEQExit|
             (LIST
              (LIST '|:=| (LIST '|:| (SETQ |g| (GENSYM)) (LIST '|Boolean|))
                    |p|)
              |g|)))))))

; parseSeq l ==
;   not (l is [:.,['exit,:.]]) =>
;     postError ['"   Invalid ending to block: ",last l]
;   transSeq(parseTranList(l))

(DEFUN |parseSeq| (|l|)
  (PROG (|ISTMP#1| |ISTMP#2|)
    (RETURN
     (COND
      ((NULL
        (AND (CONSP |l|) (PROGN (SETQ |ISTMP#1| (REVERSE |l|)) #1='T)
             (CONSP |ISTMP#1|)
             (PROGN
              (SETQ |ISTMP#2| (CAR |ISTMP#1|))
              (AND (CONSP |ISTMP#2|) (EQ (CAR |ISTMP#2|) '|exit|)))))
       (|postError| (LIST "   Invalid ending to block: " (|last| |l|))))
      (#1# (|transSeq| (|parseTranList| |l|)))))))

; transSeq l ==
;   null l => nil
;   null rest l => decExitLevel first l
;   [item,:tail]:= l
;   item is ['SEQ,:l,['exit,1,['IF,p,['exit, =2,q],'noBranch]]] and
;     (and/[x is [":=", :.] for x in l]) =>
;       ['SEQ,:[decExitLevel x for x in l],['exit,1,['IF,decExitLevel p,
;         decExitLevel q,transSeq tail]]]
;   item is ['IF,a,['exit,1,b],'noBranch] =>
;     ['IF,decExitLevel a,decExitLevel b,transSeq tail]
;   item is ['IF,a,'noBranch,['exit,1,b]] =>
;     ['IF,decExitLevel a,transSeq tail,decExitLevel b]
;   (y:= transSeq tail) is ['SEQ,:s] => ['SEQ,item,:s]
;   ['SEQ,item,['exit,1,incExitLevel y]]

(DEFUN |transSeq| (|l|)
  (PROG (|item| |tail| |ISTMP#1| |ISTMP#2| |ISTMP#3| |ISTMP#4| |ISTMP#5|
         |ISTMP#6| |ISTMP#7| |p| |ISTMP#8| |ISTMP#9| |ISTMP#10| |ISTMP#11| |q|
         |ISTMP#12| |a| |b| |y| |s|)
    (RETURN
     (COND ((NULL |l|) NIL) ((NULL (CDR |l|)) (|decExitLevel| (CAR |l|)))
           (#1='T
            (PROGN
             (SETQ |item| (CAR |l|))
             (SETQ |tail| (CDR |l|))
             (COND
              ((AND (CONSP |item|) (EQ (CAR |item|) 'SEQ)
                    (PROGN
                     (SETQ |ISTMP#1| (CDR |item|))
                     (AND (CONSP |ISTMP#1|)
                          (PROGN (SETQ |ISTMP#2| (REVERSE |ISTMP#1|)) #1#)
                          (CONSP |ISTMP#2|)
                          (PROGN
                           (SETQ |ISTMP#3| (CAR |ISTMP#2|))
                           (AND (CONSP |ISTMP#3|) (EQ (CAR |ISTMP#3|) '|exit|)
                                (PROGN
                                 (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                                 (AND (CONSP |ISTMP#4|)
                                      (EQUAL (CAR |ISTMP#4|) 1)
                                      (PROGN
                                       (SETQ |ISTMP#5| (CDR |ISTMP#4|))
                                       (AND (CONSP |ISTMP#5|)
                                            (EQ (CDR |ISTMP#5|) NIL)
                                            (PROGN
                                             (SETQ |ISTMP#6| (CAR |ISTMP#5|))
                                             (AND (CONSP |ISTMP#6|)
                                                  (EQ (CAR |ISTMP#6|) 'IF)
                                                  (PROGN
                                                   (SETQ |ISTMP#7|
                                                           (CDR |ISTMP#6|))
                                                   (AND (CONSP |ISTMP#7|)
                                                        (PROGN
                                                         (SETQ |p|
                                                                 (CAR
                                                                  |ISTMP#7|))
                                                         (SETQ |ISTMP#8|
                                                                 (CDR
                                                                  |ISTMP#7|))
                                                         (AND (CONSP |ISTMP#8|)
                                                              (PROGN
                                                               (SETQ |ISTMP#9|
                                                                       (CAR
                                                                        |ISTMP#8|))
                                                               (AND
                                                                (CONSP
                                                                 |ISTMP#9|)
                                                                (EQ
                                                                 (CAR
                                                                  |ISTMP#9|)
                                                                 '|exit|)
                                                                (PROGN
                                                                 (SETQ |ISTMP#10|
                                                                         (CDR
                                                                          |ISTMP#9|))
                                                                 (AND
                                                                  (CONSP
                                                                   |ISTMP#10|)
                                                                  (EQUAL
                                                                   (CAR
                                                                    |ISTMP#10|)
                                                                   2)
                                                                  (PROGN
                                                                   (SETQ |ISTMP#11|
                                                                           (CDR
                                                                            |ISTMP#10|))
                                                                   (AND
                                                                    (CONSP
                                                                     |ISTMP#11|)
                                                                    (EQ
                                                                     (CDR
                                                                      |ISTMP#11|)
                                                                     NIL)
                                                                    (PROGN
                                                                     (SETQ |q|
                                                                             (CAR
                                                                              |ISTMP#11|))
                                                                     #1#)))))))
                                                              (PROGN
                                                               (SETQ |ISTMP#12|
                                                                       (CDR
                                                                        |ISTMP#8|))
                                                               (AND
                                                                (CONSP
                                                                 |ISTMP#12|)
                                                                (EQ
                                                                 (CDR
                                                                  |ISTMP#12|)
                                                                 NIL)
                                                                (EQ
                                                                 (CAR
                                                                  |ISTMP#12|)
                                                                 '|noBranch|)))))))))))))))
                          (PROGN (SETQ |l| (CDR |ISTMP#2|)) #1#)
                          (PROGN (SETQ |l| (NREVERSE |l|)) #1#)))
                    ((LAMBDA (|bfVar#18| |bfVar#17| |x|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#17|)
                              (PROGN (SETQ |x| (CAR |bfVar#17|)) NIL))
                          (RETURN |bfVar#18|))
                         (#1#
                          (PROGN
                           (SETQ |bfVar#18|
                                   (AND (CONSP |x|) (EQ (CAR |x|) '|:=|)))
                           (COND ((NOT |bfVar#18|) (RETURN NIL))))))
                        (SETQ |bfVar#17| (CDR |bfVar#17|))))
                     T |l| NIL))
               (CONS 'SEQ
                     (APPEND
                      ((LAMBDA (|bfVar#20| |bfVar#19| |x|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#19|)
                                (PROGN (SETQ |x| (CAR |bfVar#19|)) NIL))
                            (RETURN (NREVERSE |bfVar#20|)))
                           (#1#
                            (SETQ |bfVar#20|
                                    (CONS (|decExitLevel| |x|) |bfVar#20|))))
                          (SETQ |bfVar#19| (CDR |bfVar#19|))))
                       NIL |l| NIL)
                      (CONS
                       (LIST '|exit| 1
                             (LIST 'IF (|decExitLevel| |p|)
                                   (|decExitLevel| |q|) (|transSeq| |tail|)))
                       NIL))))
              ((AND (CONSP |item|) (EQ (CAR |item|) 'IF)
                    (PROGN
                     (SETQ |ISTMP#1| (CDR |item|))
                     (AND (CONSP |ISTMP#1|)
                          (PROGN
                           (SETQ |a| (CAR |ISTMP#1|))
                           (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                           (AND (CONSP |ISTMP#2|)
                                (PROGN
                                 (SETQ |ISTMP#3| (CAR |ISTMP#2|))
                                 (AND (CONSP |ISTMP#3|)
                                      (EQ (CAR |ISTMP#3|) '|exit|)
                                      (PROGN
                                       (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                                       (AND (CONSP |ISTMP#4|)
                                            (EQUAL (CAR |ISTMP#4|) 1)
                                            (PROGN
                                             (SETQ |ISTMP#5| (CDR |ISTMP#4|))
                                             (AND (CONSP |ISTMP#5|)
                                                  (EQ (CDR |ISTMP#5|) NIL)
                                                  (PROGN
                                                   (SETQ |b| (CAR |ISTMP#5|))
                                                   #1#)))))))
                                (PROGN
                                 (SETQ |ISTMP#6| (CDR |ISTMP#2|))
                                 (AND (CONSP |ISTMP#6|)
                                      (EQ (CDR |ISTMP#6|) NIL)
                                      (EQ (CAR |ISTMP#6|) '|noBranch|))))))))
               (LIST 'IF (|decExitLevel| |a|) (|decExitLevel| |b|)
                     (|transSeq| |tail|)))
              ((AND (CONSP |item|) (EQ (CAR |item|) 'IF)
                    (PROGN
                     (SETQ |ISTMP#1| (CDR |item|))
                     (AND (CONSP |ISTMP#1|)
                          (PROGN
                           (SETQ |a| (CAR |ISTMP#1|))
                           (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                           (AND (CONSP |ISTMP#2|)
                                (EQ (CAR |ISTMP#2|) '|noBranch|)
                                (PROGN
                                 (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                                 (AND (CONSP |ISTMP#3|)
                                      (EQ (CDR |ISTMP#3|) NIL)
                                      (PROGN
                                       (SETQ |ISTMP#4| (CAR |ISTMP#3|))
                                       (AND (CONSP |ISTMP#4|)
                                            (EQ (CAR |ISTMP#4|) '|exit|)
                                            (PROGN
                                             (SETQ |ISTMP#5| (CDR |ISTMP#4|))
                                             (AND (CONSP |ISTMP#5|)
                                                  (EQUAL (CAR |ISTMP#5|) 1)
                                                  (PROGN
                                                   (SETQ |ISTMP#6|
                                                           (CDR |ISTMP#5|))
                                                   (AND (CONSP |ISTMP#6|)
                                                        (EQ (CDR |ISTMP#6|)
                                                            NIL)
                                                        (PROGN
                                                         (SETQ |b|
                                                                 (CAR
                                                                  |ISTMP#6|))
                                                         #1#))))))))))))))
               (LIST 'IF (|decExitLevel| |a|) (|transSeq| |tail|)
                     (|decExitLevel| |b|)))
              ((PROGN
                (SETQ |ISTMP#1| (SETQ |y| (|transSeq| |tail|)))
                (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) 'SEQ)
                     (PROGN (SETQ |s| (CDR |ISTMP#1|)) #1#)))
               (CONS 'SEQ (CONS |item| |s|)))
              (#1#
               (LIST 'SEQ |item| (LIST '|exit| 1 (|incExitLevel| |y|)))))))))))
