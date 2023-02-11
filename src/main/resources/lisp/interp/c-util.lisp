
; )package "BOOT"

(IN-PACKAGE "BOOT")

; level(:l) ==
;   null l => same()
;   l is [n] and INTEGERP n => displayComp ($level:= n)
;   SAY '"Correct format: (level n) where n is the level you want to go to"

(DEFUN |level| (&REST |l|)
  (PROG (|n|)
    (RETURN
     (COND ((NULL |l|) (|same|))
           ((AND (CONSP |l|) (EQ (CDR |l|) NIL)
                 (PROGN (SETQ |n| (CAR |l|)) #1='T) (INTEGERP |n|))
            (|displayComp| (SETQ |$level| |n|)))
           (#1#
            (SAY
             "Correct format: (level n) where n is the level you want to go to"))))))

; up() == displayComp ($level:= $level-1)

(DEFUN |up| ()
  (PROG () (RETURN (|displayComp| (SETQ |$level| (- |$level| 1))))))

; same() == displayComp $level

(DEFUN |same| () (PROG () (RETURN (|displayComp| |$level|))))

; down() == displayComp ($level:= $level+1)

(DEFUN |down| ()
  (PROG () (RETURN (|displayComp| (SETQ |$level| (+ |$level| 1))))))

; displaySemanticErrors() ==
;   n:= #($semanticErrorStack:= REMDUP $semanticErrorStack)
;   n=0 => nil
;   l:= NREVERSE $semanticErrorStack
;   $semanticErrorStack:= nil
;   sayBrightly bright '"  Semantic Errors:"
;   displaySemanticError(l,CUROUTSTREAM)
;   sayBrightly '" "
;   displayWarnings()

(DEFUN |displaySemanticErrors| ()
  (PROG (|l| |n|)
    (RETURN
     (PROGN
      (SETQ |n|
              (LENGTH
               (SETQ |$semanticErrorStack| (REMDUP |$semanticErrorStack|))))
      (COND ((EQL |n| 0) NIL)
            ('T
             (PROGN
              (SETQ |l| (NREVERSE |$semanticErrorStack|))
              (SETQ |$semanticErrorStack| NIL)
              (|sayBrightly| (|bright| "  Semantic Errors:"))
              (|displaySemanticError| |l| CUROUTSTREAM)
              (|sayBrightly| " ")
              (|displayWarnings|))))))))

; displaySemanticError(l,stream) ==
;   for x in l for i in 1.. repeat
;     sayBrightly2(['"      [", i, '"] ", :first x], stream)

(DEFUN |displaySemanticError| (|l| |stream|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#1| |x| |i|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#1|) (PROGN (SETQ |x| (CAR |bfVar#1|)) NIL))
           (RETURN NIL))
          ('T
           (|sayBrightly2| (CONS "      [" (CONS |i| (CONS "] " (CAR |x|))))
            |stream|)))
         (SETQ |bfVar#1| (CDR |bfVar#1|))
         (SETQ |i| (+ |i| 1))))
      |l| NIL 1))))

; displayWarnings() ==
;   n:= #($warningStack:= REMDUP $warningStack)
;   n=0 => nil
;   sayBrightly bright '"  Warnings:"
;   l := NREVERSE $warningStack
;   displayWarning(l,CUROUTSTREAM)
;   $warningStack:= nil
;   sayBrightly '" "

(DEFUN |displayWarnings| ()
  (PROG (|l| |n|)
    (RETURN
     (PROGN
      (SETQ |n| (LENGTH (SETQ |$warningStack| (REMDUP |$warningStack|))))
      (COND ((EQL |n| 0) NIL)
            ('T
             (PROGN
              (|sayBrightly| (|bright| "  Warnings:"))
              (SETQ |l| (NREVERSE |$warningStack|))
              (|displayWarning| |l| CUROUTSTREAM)
              (SETQ |$warningStack| NIL)
              (|sayBrightly| " "))))))))

; displayWarning(l,stream) ==
;   for x in l for i in 1.. repeat
;     sayBrightly2(['"      [", i, '"] ", :x], stream)

(DEFUN |displayWarning| (|l| |stream|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#2| |x| |i|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#2|) (PROGN (SETQ |x| (CAR |bfVar#2|)) NIL))
           (RETURN NIL))
          ('T
           (|sayBrightly2| (CONS "      [" (CONS |i| (CONS "] " |x|)))
            |stream|)))
         (SETQ |bfVar#2| (CDR |bfVar#2|))
         (SETQ |i| (+ |i| 1))))
      |l| NIL 1))))

; displayComp level ==
;   $bright:= " << "
;   $dim:= " >> "
;   if $insideCapsuleFunctionIfTrue=true then
;     sayBrightly ['"error in function",'%b,$op,'%d,'%l]
;   --mathprint removeZeroOne mkErrorExpr level
;   pp removeZeroOne mkErrorExpr level
;   sayBrightly ['"****** level",'%b,level,'%d,'" ******"]
;   [$x, $m, $f, $exitModeStack] := $s.(level - 1)
;   ($X:=$x;$M:=$m;$F:=$f)
;   SAY("$x:= ",$x)
;   SAY("$m:= ",$m)
;   SAY "$f:="
;   limited_print1_stdout($f)
;   nil

(DEFUN |displayComp| (|level|)
  (PROG (|LETTMP#1|)
    (RETURN
     (PROGN
      (SETQ |$bright| '| << |)
      (SETQ |$dim| '| >> |)
      (COND
       ((EQUAL |$insideCapsuleFunctionIfTrue| T)
        (|sayBrightly| (LIST "error in function" '|%b| |$op| '|%d| '|%l|))))
      (|pp| (|removeZeroOne| (|mkErrorExpr| |level|)))
      (|sayBrightly| (LIST "****** level" '|%b| |level| '|%d| " ******"))
      (SETQ |LETTMP#1| (ELT |$s| (- |level| 1)))
      (SETQ |$x| (CAR |LETTMP#1|))
      (SETQ |$m| (CADR . #1=(|LETTMP#1|)))
      (SETQ |$f| (CADDR . #1#))
      (SETQ |$exitModeStack| (CADDDR . #1#))
      (SETQ $X |$x|)
      (SETQ $M |$m|)
      (SETQ $F |$f|)
      (SAY '|$x:= | |$x|)
      (SAY '|$m:= | |$m|)
      (SAY '|$f:=|)
      (|limited_print1_stdout| |$f|)
      NIL))))

; mkErrorExpr level ==
;   bracket ASSOCLEFT DROP(level-#$s,$s) where
;     bracket l ==
;       #l<2 => l
;       l is [a,b] =>
;         highlight(b,a) where
;           highlight(b,a) ==
;             atom b =>
;               substitute(var,b,a) where
;                 var:= INTERN STRCONC(STRINGIMAGE $bright,STRINGIMAGE b,STRINGIMAGE $dim)
;             highlight1(b,a) where
;               highlight1(b,a) ==
;                 atom a => a
;                 a is [ =b,:c] => [$bright,b,$dim,:c]
;                 [highlight1(b,first a),:highlight1(b,rest a)]
;       substitute(bracket rest l,first rest l,first l)

(DEFUN |mkErrorExpr| (|level|)
  (PROG ()
    (RETURN
     (|mkErrorExpr,bracket|
      (ASSOCLEFT (DROP (- |level| (LENGTH |$s|)) |$s|))))))
(DEFUN |mkErrorExpr,bracket| (|l|)
  (PROG (|a| |ISTMP#1| |b|)
    (RETURN
     (COND ((< (LENGTH |l|) 2) |l|)
           ((AND (CONSP |l|)
                 (PROGN
                  (SETQ |a| (CAR |l|))
                  (SETQ |ISTMP#1| (CDR |l|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                       (PROGN (SETQ |b| (CAR |ISTMP#1|)) #1='T))))
            (|mkErrorExpr,highlight| |b| |a|))
           (#1#
            (|substitute| (|mkErrorExpr,bracket| (CDR |l|)) (CAR (CDR |l|))
             (CAR |l|)))))))
(DEFUN |mkErrorExpr,highlight| (|b| |a|)
  (PROG (|var|)
    (RETURN
     (COND
      ((ATOM |b|)
       (PROGN
        (SETQ |var|
                (INTERN
                 (STRCONC (STRINGIMAGE |$bright|) (STRINGIMAGE |b|)
                  (STRINGIMAGE |$dim|))))
        (|substitute| |var| |b| |a|)))
      ('T (|mkErrorExpr,highlight1| |b| |a|))))))
(DEFUN |mkErrorExpr,highlight1| (|b| |a|)
  (PROG (|c|)
    (RETURN
     (COND ((ATOM |a|) |a|)
           ((AND (CONSP |a|) (EQUAL (CAR |a|) |b|)
                 (PROGN (SETQ |c| (CDR |a|)) #1='T))
            (CONS |$bright| (CONS |b| (CONS |$dim| |c|))))
           (#1#
            (CONS (|mkErrorExpr,highlight1| |b| (CAR |a|))
                  (|mkErrorExpr,highlight1| |b| (CDR |a|))))))))

; errorRef s == stackWarning ['%b,s,'%d,'"has no value"]

(DEFUN |errorRef| (|s|)
  (PROG () (RETURN (|stackWarning| (LIST '|%b| |s| '|%d| "has no value")))))

; unErrorRef s == unStackWarning ['%b,s,'%d,'"has no value"]

(DEFUN |unErrorRef| (|s|)
  (PROG () (RETURN (|unStackWarning| (LIST '|%b| |s| '|%d| "has no value")))))

; consProplistOf(var,proplist,prop,val) ==
;   semchkProplist(var, proplist, prop)
;   $InteractiveMode and (u:= assoc(prop,proplist)) =>
;     RPLACD(u,val)
;     proplist
;   [[prop,:val],:proplist]

(DEFUN |consProplistOf| (|var| |proplist| |prop| |val|)
  (PROG (|u|)
    (RETURN
     (PROGN
      (|semchkProplist| |var| |proplist| |prop|)
      (COND
       ((AND |$InteractiveMode| (SETQ |u| (|assoc| |prop| |proplist|)))
        (PROGN (RPLACD |u| |val|) |proplist|))
       ('T (CONS (CONS |prop| |val|) |proplist|)))))))

; warnLiteral x ==
;   stackSemanticError(['%b,x,'%d,
;     '"is BOTH a variable and a literal"],nil)

(DEFUN |warnLiteral| (|x|)
  (PROG ()
    (RETURN
     (|stackSemanticError|
      (LIST '|%b| |x| '|%d| "is BOTH a variable and a literal") NIL))))

; intersectionEnvironment(e,e') ==
;   ce:= makeCommonEnvironment(e,e')
;   ic := intersectionContour(deltaContour(e, ce), deltaContour(e', ce), ce)
;   e'':= (ic => addContour(ic,ce); ce)

(DEFUN |intersectionEnvironment| (|e| |e'|)
  (PROG (|ce| |ic| |e''|)
    (RETURN
     (PROGN
      (SETQ |ce| (|makeCommonEnvironment| |e| |e'|))
      (SETQ |ic|
              (|intersectionContour| (|deltaContour| |e| |ce|)
               (|deltaContour| |e'| |ce|) |ce|))
      (SETQ |e''| (COND (|ic| (|addContour| |ic| |ce|)) ('T |ce|)))))))

; deltaContour([il1, :el],[il2, :el']) ==
;   not el=el' => systemError '"deltaContour" --a cop out for now
;   n1 := #il1
;   n2 := #il2
;   dl := []
;   for i in 1..(n1 - n2) repeat
;       dl := cons(first(il1), dl)
;       il1 := rest(il1)
;   c1 := first(il1)
;   c2 := first(il2)
;   rest(il1) ~= rest(il2) => systemError '"deltaContour 2" --a cop out for now
;   cd := [first x for x in tails c1 while (x~=c2)]
;   dl := cons(cd, dl)
;   res0 := []
;   for l in dl repeat
;       res0 := APPEND(l, res0)
;   res := eliminateDuplicatePropertyLists res0 where
;     eliminateDuplicatePropertyLists contour ==
;       contour is [[x,:.],:contour'] =>
;         LASSOC(x,contour') =>
;                                --save some CONSing if possible
;           [first contour,:DELLASOS(x,eliminateDuplicatePropertyLists contour')]
;         [first contour,:eliminateDuplicatePropertyLists contour']
;       nil
;   res

(DEFUN |deltaContour| (|bfVar#6| |bfVar#7|)
  (PROG (|il2| |el'| |il1| |el| |n1| |n2| |dl| |c1| |c2| |cd| |res0| |res|)
    (RETURN
     (PROGN
      (SETQ |il2| (CAR |bfVar#7|))
      (SETQ |el'| (CDR |bfVar#7|))
      (SETQ |il1| (CAR |bfVar#6|))
      (SETQ |el| (CDR |bfVar#6|))
      (COND ((EQUAL (NULL |el|) |el'|) (|systemError| "deltaContour"))
            (#1='T
             (PROGN
              (SETQ |n1| (LENGTH |il1|))
              (SETQ |n2| (LENGTH |il2|))
              (SETQ |dl| NIL)
              ((LAMBDA (|bfVar#3| |i|)
                 (LOOP
                  (COND ((> |i| |bfVar#3|) (RETURN NIL))
                        (#1#
                         (PROGN
                          (SETQ |dl| (CONS (CAR |il1|) |dl|))
                          (SETQ |il1| (CDR |il1|)))))
                  (SETQ |i| (+ |i| 1))))
               (- |n1| |n2|) 1)
              (SETQ |c1| (CAR |il1|))
              (SETQ |c2| (CAR |il2|))
              (COND
               ((NOT (EQUAL (CDR |il1|) (CDR |il2|)))
                (|systemError| "deltaContour 2"))
               (#1#
                (PROGN
                 (SETQ |cd|
                         ((LAMBDA (|bfVar#4| |x|)
                            (LOOP
                             (COND
                              ((OR (ATOM |x|) (EQUAL |x| |c2|))
                               (RETURN (NREVERSE |bfVar#4|)))
                              (#1#
                               (SETQ |bfVar#4| (CONS (CAR |x|) |bfVar#4|))))
                             (SETQ |x| (CDR |x|))))
                          NIL |c1|))
                 (SETQ |dl| (CONS |cd| |dl|))
                 (SETQ |res0| NIL)
                 ((LAMBDA (|bfVar#5| |l|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#5|)
                           (PROGN (SETQ |l| (CAR |bfVar#5|)) NIL))
                       (RETURN NIL))
                      (#1# (SETQ |res0| (APPEND |l| |res0|))))
                     (SETQ |bfVar#5| (CDR |bfVar#5|))))
                  |dl| NIL)
                 (SETQ |res|
                         (|deltaContour,eliminateDuplicatePropertyLists|
                          |res0|))
                 |res|))))))))))
(DEFUN |deltaContour,eliminateDuplicatePropertyLists| (|contour|)
  (PROG (|ISTMP#1| |x| |contour'|)
    (RETURN
     (COND
      ((AND (CONSP |contour|)
            (PROGN
             (SETQ |ISTMP#1| (CAR |contour|))
             (AND (CONSP |ISTMP#1|) (PROGN (SETQ |x| (CAR |ISTMP#1|)) #1='T)))
            (PROGN (SETQ |contour'| (CDR |contour|)) #1#))
       (COND
        ((LASSOC |x| |contour'|)
         (CONS (CAR |contour|)
               (DELLASOS |x|
                (|deltaContour,eliminateDuplicatePropertyLists| |contour'|))))
        (#1#
         (CONS (CAR |contour|)
               (|deltaContour,eliminateDuplicatePropertyLists| |contour'|)))))
      (#1# NIL)))))

; intersectionContour(c, c', ce) ==
;   $var: local := nil
;   computeIntersection(c, c', ce) where
;     computeIntersection(c, c', ce) ==
;       varlist:= REMDUP ASSOCLEFT c
;       varlist':= REMDUP ASSOCLEFT c'
;       interVars:= intersection(varlist,varlist')
;       unionVars:= union(varlist,varlist')
;       diffVars:= setDifference(unionVars,interVars)
;       modeAssoc := buildModeAssoc(diffVars, c, c', ce)
;       [:modeAssoc,:
;         [[x,:proplist]
;           for [x,:y] in c | member(x,interVars) and
;             (proplist := interProplist(y, LASSOC($var := x, c'), ce))]]
;     interProplist(p, p', ce) ==
;                             --p is new proplist; p' is old one
;         [:modeCompare(p, p', ce), :[pair' for pair in p |
;                (pair' := compare(pair, p', ce))]]
;     buildModeAssoc(varlist, c, c', ce) ==
;       [[x, :mp] for x in varlist |
;           (mp := modeCompare(LASSOC(x, c), LASSOC(x, c'), ce))]
;     compare(pair is [prop,:val], p', ce) ==
;       --1. if the property-value pair are identical, accept it immediately
;       pair=(pair':= assoc(prop,p')) => pair
;       --2. if property="value" and modes are unifiable, give intersection
;       --       property="value" but value=genSomeVariable)()
;       (val':= IFCDR pair') and prop = "value" and
;         (m:= unifiable(val.mode, val'.mode, ce)) =>
;             ["value",genSomeVariable(), m, nil]
;             --this tells us that an undeclared variable received
;             --two different values but with identical modes
;       --3. property="mode" is covered by modeCompare
;       prop="mode" => nil
;     modeCompare(p, p', ce) ==
;       pair:= assoc("mode",p) =>
;         pair':= assoc("mode",p') =>
;           m'' := unifiable(rest pair, rest pair', ce) => LIST ["mode", :m'']
;           stackSemanticError(['%b,$var,'%d,"has two modes: "],nil)
;        --stackWarning ("mode for",'%b,$var,'%d,"introduced conditionally")
;         LIST ["conditionalmode",:rest pair]
;         --LIST pair
;        --stackWarning ("mode for",'%b,$var,'%d,"introduced conditionally")
;       pair':= assoc("mode",p') => LIST ["conditionalmode",:rest pair']
;         --LIST pair'
;     unifiable(m1, m2, ce) ==
;       m1=m2 => m1
;         --we may need to add code to coerce up to tagged unions
;         --but this can not be done here, but should be done by compIf
;       m:=
;         m1 is ["Union",:.] =>
;           m2 is ["Union", :.] => ["Union", :set_sum(rest m1, rest m2)]
;           ["Union", :set_sum(rest m1, [m2])]
;         m2 is ["Union",:.] => ["Union", :set_sum(rest m2, [m1])]
;         ["Union",m1,m2]
;       for u in getDomainsInScope ce repeat
;         if u is ["Union",:u'] and (and/[member(v,u') for v in rest m]) then
;           return m

(DEFUN |intersectionContour| (|c| |c'| |ce|)
  (PROG (|$var|)
    (DECLARE (SPECIAL |$var|))
    (RETURN
     (PROGN
      (SETQ |$var| NIL)
      (|intersectionContour,computeIntersection| |c| |c'| |ce|)))))
(DEFUN |intersectionContour,computeIntersection| (|c| |c'| |ce|)
  (PROG (|varlist| |varlist'| |interVars| |unionVars| |diffVars| |modeAssoc|
         |x| |y| |proplist|)
    (RETURN
     (PROGN
      (SETQ |varlist| (REMDUP (ASSOCLEFT |c|)))
      (SETQ |varlist'| (REMDUP (ASSOCLEFT |c'|)))
      (SETQ |interVars| (|intersection| |varlist| |varlist'|))
      (SETQ |unionVars| (|union| |varlist| |varlist'|))
      (SETQ |diffVars| (SETDIFFERENCE |unionVars| |interVars|))
      (SETQ |modeAssoc|
              (|intersectionContour,buildModeAssoc| |diffVars| |c| |c'| |ce|))
      (APPEND |modeAssoc|
              ((LAMBDA (|bfVar#10| |bfVar#9| |bfVar#8|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#9|)
                        (PROGN (SETQ |bfVar#8| (CAR |bfVar#9|)) NIL))
                    (RETURN (NREVERSE |bfVar#10|)))
                   (#1='T
                    (AND (CONSP |bfVar#8|)
                         (PROGN
                          (SETQ |x| (CAR |bfVar#8|))
                          (SETQ |y| (CDR |bfVar#8|))
                          #1#)
                         (|member| |x| |interVars|)
                         (SETQ |proplist|
                                 (|intersectionContour,interProplist| |y|
                                  (LASSOC (SETQ |$var| |x|) |c'|) |ce|))
                         (SETQ |bfVar#10|
                                 (CONS (CONS |x| |proplist|) |bfVar#10|)))))
                  (SETQ |bfVar#9| (CDR |bfVar#9|))))
               NIL |c| NIL))))))
(DEFUN |intersectionContour,interProplist| (|p| |p'| |ce|)
  (PROG (|pair'|)
    (RETURN
     (APPEND (|intersectionContour,modeCompare| |p| |p'| |ce|)
             ((LAMBDA (|bfVar#12| |bfVar#11| |pair|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#11|)
                       (PROGN (SETQ |pair| (CAR |bfVar#11|)) NIL))
                   (RETURN (NREVERSE |bfVar#12|)))
                  ('T
                   (AND
                    (SETQ |pair'|
                            (|intersectionContour,compare| |pair| |p'| |ce|))
                    (SETQ |bfVar#12| (CONS |pair'| |bfVar#12|)))))
                 (SETQ |bfVar#11| (CDR |bfVar#11|))))
              NIL |p| NIL)))))
(DEFUN |intersectionContour,buildModeAssoc| (|varlist| |c| |c'| |ce|)
  (PROG (|mp|)
    (RETURN
     ((LAMBDA (|bfVar#14| |bfVar#13| |x|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#13|) (PROGN (SETQ |x| (CAR |bfVar#13|)) NIL))
           (RETURN (NREVERSE |bfVar#14|)))
          ('T
           (AND
            (SETQ |mp|
                    (|intersectionContour,modeCompare| (LASSOC |x| |c|)
                     (LASSOC |x| |c'|) |ce|))
            (SETQ |bfVar#14| (CONS (CONS |x| |mp|) |bfVar#14|)))))
         (SETQ |bfVar#13| (CDR |bfVar#13|))))
      NIL |varlist| NIL))))
(DEFUN |intersectionContour,compare| (|pair| |p'| |ce|)
  (PROG (|prop| |val| |pair'| |val'| |m|)
    (RETURN
     (PROGN
      (SETQ |prop| (CAR |pair|))
      (SETQ |val| (CDR |pair|))
      (COND ((EQUAL |pair| (SETQ |pair'| (|assoc| |prop| |p'|))) |pair|)
            ((AND (SETQ |val'| (IFCDR |pair'|)) (EQ |prop| '|value|)
                  (SETQ |m|
                          (|intersectionContour,unifiable| (CADR |val|)
                           (CADR |val'|) |ce|)))
             (LIST '|value| (|genSomeVariable|) |m| NIL))
            ((EQ |prop| '|mode|) NIL))))))
(DEFUN |intersectionContour,modeCompare| (|p| |p'| |ce|)
  (PROG (|pair| |pair'| |m''|)
    (RETURN
     (COND
      ((SETQ |pair| (|assoc| '|mode| |p|))
       (COND
        ((SETQ |pair'| (|assoc| '|mode| |p'|))
         (COND
          ((SETQ |m''|
                   (|intersectionContour,unifiable| (CDR |pair|) (CDR |pair'|)
                    |ce|))
           (LIST (CONS '|mode| |m''|)))
          (#1='T
           (|stackSemanticError| (LIST '|%b| |$var| '|%d| '|has two modes: |)
            NIL))))
        (#1# (LIST (CONS '|conditionalmode| (CDR |pair|))))))
      ((SETQ |pair'| (|assoc| '|mode| |p'|))
       (LIST (CONS '|conditionalmode| (CDR |pair'|))))))))
(DEFUN |intersectionContour,unifiable| (|m1| |m2| |ce|)
  (PROG (|m| |u'|)
    (RETURN
     (COND ((EQUAL |m1| |m2|) |m1|)
           (#1='T
            (PROGN
             (SETQ |m|
                     (COND
                      ((AND (CONSP |m1|) (EQ (CAR |m1|) '|Union|))
                       (COND
                        ((AND (CONSP |m2|) (EQ (CAR |m2|) '|Union|))
                         (CONS '|Union| (|set_sum| (CDR |m1|) (CDR |m2|))))
                        (#1#
                         (CONS '|Union| (|set_sum| (CDR |m1|) (LIST |m2|))))))
                      ((AND (CONSP |m2|) (EQ (CAR |m2|) '|Union|))
                       (CONS '|Union| (|set_sum| (CDR |m2|) (LIST |m1|))))
                      (#1# (LIST '|Union| |m1| |m2|))))
             ((LAMBDA (|bfVar#15| |u|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#15|)
                       (PROGN (SETQ |u| (CAR |bfVar#15|)) NIL))
                   (RETURN NIL))
                  (#1#
                   (COND
                    ((AND (CONSP |u|) (EQ (CAR |u|) '|Union|)
                          (PROGN (SETQ |u'| (CDR |u|)) #1#)
                          ((LAMBDA (|bfVar#17| |bfVar#16| |v|)
                             (LOOP
                              (COND
                               ((OR (ATOM |bfVar#16|)
                                    (PROGN (SETQ |v| (CAR |bfVar#16|)) NIL))
                                (RETURN |bfVar#17|))
                               (#1#
                                (PROGN
                                 (SETQ |bfVar#17| (|member| |v| |u'|))
                                 (COND ((NOT |bfVar#17|) (RETURN NIL))))))
                              (SETQ |bfVar#16| (CDR |bfVar#16|))))
                           T (CDR |m|) NIL))
                     (RETURN |m|)))))
                 (SETQ |bfVar#15| (CDR |bfVar#15|))))
              (|getDomainsInScope| |ce|) NIL)))))))

; addContour(c,E is [cur,:tail]) ==
;   [NCONC(fn(c,E),cur),:tail] where
;     fn(c,e) ==
;         for [x,:proplist] in c repeat
;            fn1(x,proplist,getProplist(x,e)) where
;               fn1(x,p,ee) ==
;                 for pv in p repeat fn3(x,pv,ee) where
;                  fn3(x,pv,e) ==
;                    [p,:v]:=pv
;                    if member(x,$getPutTrace) then
;                      pp([x,"has",pv])
;                    if p="conditionalmode" then
;                      RPLACA(pv,"mode")
;                      --check for conflicts with earlier mode
;                      if vv:=LASSOC("mode",e) then
;                         if v ~=vv then
;                           stackWarning ["The conditional modes ",
;                                      v," and ",vv," conflict"]
;         LIST c

(DEFUN |addContour| (|c| E)
  (PROG (|cur| |tail|)
    (RETURN
     (PROGN
      (SETQ |cur| (CAR E))
      (SETQ |tail| (CDR E))
      (CONS (NCONC (|addContour,fn| |c| E) |cur|) |tail|)))))
(DEFUN |addContour,fn| (|c| |e|)
  (PROG (|x| |proplist|)
    (RETURN
     (PROGN
      ((LAMBDA (|bfVar#19| |bfVar#18|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#19|)
                (PROGN (SETQ |bfVar#18| (CAR |bfVar#19|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#18|)
                 (PROGN
                  (SETQ |x| (CAR |bfVar#18|))
                  (SETQ |proplist| (CDR |bfVar#18|))
                  #1#)
                 (|addContour,fn1| |x| |proplist| (|getProplist| |x| |e|)))))
          (SETQ |bfVar#19| (CDR |bfVar#19|))))
       |c| NIL)
      (LIST |c|)))))
(DEFUN |addContour,fn1| (|x| |p| |ee|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#20| |pv|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#20|) (PROGN (SETQ |pv| (CAR |bfVar#20|)) NIL))
           (RETURN NIL))
          ('T (|addContour,fn3| |x| |pv| |ee|)))
         (SETQ |bfVar#20| (CDR |bfVar#20|))))
      |p| NIL))))
(DEFUN |addContour,fn3| (|x| |pv| |e|)
  (PROG (|p| |v| |vv|)
    (RETURN
     (PROGN
      (SETQ |p| (CAR |pv|))
      (SETQ |v| (CDR |pv|))
      (COND ((|member| |x| |$getPutTrace|) (|pp| (LIST |x| '|has| |pv|))))
      (COND
       ((EQ |p| '|conditionalmode|) (RPLACA |pv| '|mode|)
        (COND
         ((SETQ |vv| (LASSOC '|mode| |e|))
          (COND
           ((NOT (EQUAL |v| |vv|))
            (|stackWarning|
             (LIST '|The conditional modes | |v| '| and | |vv|
                   '| conflict|))))))))))))

; makeCommonEnvironment(e,e') ==
;   interE makeSameLength(e,e') where  --$ie:=
;     interE [e,e'] ==
;       rest e=rest e' => [interLocalE makeSameLength(first e,first e'),:rest e]
;       interE [rest e,rest e']
;     interLocalE [le,le'] ==
;       rest le=rest le' =>
;         [interC makeSameLength(first le,first le'),:rest le]
;       interLocalE [rest le,rest le']
;     interC [c,c'] ==
;       c=c' => c
;       interC [rest c,rest c']
;     makeSameLength(x,y) ==
;       fn(x,y,#x,#y) where
;         fn(x,y,nx,ny) ==
;           nx>ny => fn(rest x,y,nx-1,ny)
;           nx<ny => fn(x,rest y,nx,ny-1)
;           [x,y]

(DEFUN |makeCommonEnvironment| (|e| |e'|)
  (PROG ()
    (RETURN
     (|makeCommonEnvironment,interE|
      (|makeCommonEnvironment,makeSameLength| |e| |e'|)))))
(DEFUN |makeCommonEnvironment,interE| (|bfVar#21|)
  (PROG (|e| |e'|)
    (RETURN
     (PROGN
      (SETQ |e| (CAR |bfVar#21|))
      (SETQ |e'| (CADR |bfVar#21|))
      (COND
       ((EQUAL (CDR |e|) (CDR |e'|))
        (CONS
         (|makeCommonEnvironment,interLocalE|
          (|makeCommonEnvironment,makeSameLength| (CAR |e|) (CAR |e'|)))
         (CDR |e|)))
       ('T (|makeCommonEnvironment,interE| (LIST (CDR |e|) (CDR |e'|)))))))))
(DEFUN |makeCommonEnvironment,interLocalE| (|bfVar#22|)
  (PROG (|le| |le'|)
    (RETURN
     (PROGN
      (SETQ |le| (CAR |bfVar#22|))
      (SETQ |le'| (CADR |bfVar#22|))
      (COND
       ((EQUAL (CDR |le|) (CDR |le'|))
        (CONS
         (|makeCommonEnvironment,interC|
          (|makeCommonEnvironment,makeSameLength| (CAR |le|) (CAR |le'|)))
         (CDR |le|)))
       ('T
        (|makeCommonEnvironment,interLocalE|
         (LIST (CDR |le|) (CDR |le'|)))))))))
(DEFUN |makeCommonEnvironment,interC| (|bfVar#23|)
  (PROG (|c| |c'|)
    (RETURN
     (PROGN
      (SETQ |c| (CAR |bfVar#23|))
      (SETQ |c'| (CADR |bfVar#23|))
      (COND ((EQUAL |c| |c'|) |c|)
            ('T
             (|makeCommonEnvironment,interC| (LIST (CDR |c|) (CDR |c'|)))))))))
(DEFUN |makeCommonEnvironment,makeSameLength| (|x| |y|)
  (PROG ()
    (RETURN (|makeCommonEnvironment,fn| |x| |y| (LENGTH |x|) (LENGTH |y|)))))
(DEFUN |makeCommonEnvironment,fn| (|x| |y| |nx| |ny|)
  (PROG ()
    (RETURN
     (COND
      ((< |ny| |nx|)
       (|makeCommonEnvironment,fn| (CDR |x|) |y| (- |nx| 1) |ny|))
      ((< |nx| |ny|)
       (|makeCommonEnvironment,fn| |x| (CDR |y|) |nx| (- |ny| 1)))
      ('T (LIST |x| |y|))))))

; printEnv E ==
;   for x in E for i in 1.. repeat
;     for y in x for j in 1.. repeat
;       SAY('"******CONTOUR ",j,'", LEVEL ",i,'":******")
;       for z in y repeat
;         TERPRI()
;         SAY("Properties Of: ",first z)
;         for u in rest z repeat
;           PRIN0 first u
;           printString ": "
;           PRETTYPRINT tran(rest u,first u) where
;             tran(val,prop) ==
;               prop="value" => DROP(-1,val)
;               val

(DEFUN |printEnv| (E)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#24| |x| |i|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#24|) (PROGN (SETQ |x| (CAR |bfVar#24|)) NIL))
           (RETURN NIL))
          (#1='T
           ((LAMBDA (|bfVar#25| |y| |j|)
              (LOOP
               (COND
                ((OR (ATOM |bfVar#25|) (PROGN (SETQ |y| (CAR |bfVar#25|)) NIL))
                 (RETURN NIL))
                (#1#
                 (PROGN
                  (SAY "******CONTOUR " |j| ", LEVEL " |i| ":******")
                  ((LAMBDA (|bfVar#26| |z|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#26|)
                            (PROGN (SETQ |z| (CAR |bfVar#26|)) NIL))
                        (RETURN NIL))
                       (#1#
                        (PROGN
                         (TERPRI)
                         (SAY '|Properties Of: | (CAR |z|))
                         ((LAMBDA (|bfVar#27| |u|)
                            (LOOP
                             (COND
                              ((OR (ATOM |bfVar#27|)
                                   (PROGN (SETQ |u| (CAR |bfVar#27|)) NIL))
                               (RETURN NIL))
                              (#1#
                               (PROGN
                                (PRIN0 (CAR |u|))
                                (|printString| '|: |)
                                (PRETTYPRINT
                                 (|printEnv,tran| (CDR |u|) (CAR |u|))))))
                             (SETQ |bfVar#27| (CDR |bfVar#27|))))
                          (CDR |z|) NIL))))
                      (SETQ |bfVar#26| (CDR |bfVar#26|))))
                   |y| NIL))))
               (SETQ |bfVar#25| (CDR |bfVar#25|))
               (SETQ |j| (+ |j| 1))))
            |x| NIL 1)))
         (SETQ |bfVar#24| (CDR |bfVar#24|))
         (SETQ |i| (+ |i| 1))))
      E NIL 1))))
(DEFUN |printEnv,tran| (|val| |prop|)
  (PROG ()
    (RETURN (COND ((EQ |prop| '|value|) (DROP (- 1) |val|)) ('T |val|)))))

; prEnv E ==
;   for x in E for i in 1.. repeat
;     for y in x for j in 1.. repeat
;       SAY('"******CONTOUR ",j,'", LEVEL ",i,'":******")
;       for z in y | not LASSOC("modemap",rest z) repeat
;         TERPRI()
;         SAY("Properties Of: ",first z)
;         for u in rest z repeat
;           PRIN0 first u
;           printString ": "
;           PRETTYPRINT tran(rest u,first u) where
;             tran(val,prop) ==
;               prop="value" => DROP(-1,val)
;               val

(DEFUN |prEnv| (E)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#28| |x| |i|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#28|) (PROGN (SETQ |x| (CAR |bfVar#28|)) NIL))
           (RETURN NIL))
          (#1='T
           ((LAMBDA (|bfVar#29| |y| |j|)
              (LOOP
               (COND
                ((OR (ATOM |bfVar#29|) (PROGN (SETQ |y| (CAR |bfVar#29|)) NIL))
                 (RETURN NIL))
                (#1#
                 (PROGN
                  (SAY "******CONTOUR " |j| ", LEVEL " |i| ":******")
                  ((LAMBDA (|bfVar#30| |z|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#30|)
                            (PROGN (SETQ |z| (CAR |bfVar#30|)) NIL))
                        (RETURN NIL))
                       (#1#
                        (AND (NULL (LASSOC '|modemap| (CDR |z|)))
                             (PROGN
                              (TERPRI)
                              (SAY '|Properties Of: | (CAR |z|))
                              ((LAMBDA (|bfVar#31| |u|)
                                 (LOOP
                                  (COND
                                   ((OR (ATOM |bfVar#31|)
                                        (PROGN
                                         (SETQ |u| (CAR |bfVar#31|))
                                         NIL))
                                    (RETURN NIL))
                                   (#1#
                                    (PROGN
                                     (PRIN0 (CAR |u|))
                                     (|printString| '|: |)
                                     (PRETTYPRINT
                                      (|prEnv,tran| (CDR |u|) (CAR |u|))))))
                                  (SETQ |bfVar#31| (CDR |bfVar#31|))))
                               (CDR |z|) NIL)))))
                      (SETQ |bfVar#30| (CDR |bfVar#30|))))
                   |y| NIL))))
               (SETQ |bfVar#29| (CDR |bfVar#29|))
               (SETQ |j| (+ |j| 1))))
            |x| NIL 1)))
         (SETQ |bfVar#28| (CDR |bfVar#28|))
         (SETQ |i| (+ |i| 1))))
      E NIL 1))))
(DEFUN |prEnv,tran| (|val| |prop|)
  (PROG ()
    (RETURN (COND ((EQ |prop| '|value|) (DROP (- 1) |val|)) ('T |val|)))))

; prModemaps E ==
;   listOfOperatorsSeenSoFar:= nil
;   for x in E for i in 1.. repeat
;     for y in x for j in 1.. repeat
;       for z in y | null member(first z,listOfOperatorsSeenSoFar) and
;         (modemap:= LASSOC("modemap",rest z)) repeat
;           listOfOperatorsSeenSoFar:= [first z,:listOfOperatorsSeenSoFar]
;           TERPRI()
;           PRIN0 first z
;           printString ": "
;           PRETTYPRINT modemap

(DEFUN |prModemaps| (E)
  (PROG (|listOfOperatorsSeenSoFar| |modemap|)
    (RETURN
     (PROGN
      (SETQ |listOfOperatorsSeenSoFar| NIL)
      ((LAMBDA (|bfVar#32| |x| |i|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#32|) (PROGN (SETQ |x| (CAR |bfVar#32|)) NIL))
            (RETURN NIL))
           (#1='T
            ((LAMBDA (|bfVar#33| |y| |j|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#33|)
                      (PROGN (SETQ |y| (CAR |bfVar#33|)) NIL))
                  (RETURN NIL))
                 (#1#
                  ((LAMBDA (|bfVar#34| |z|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#34|)
                            (PROGN (SETQ |z| (CAR |bfVar#34|)) NIL))
                        (RETURN NIL))
                       (#1#
                        (AND
                         (NULL (|member| (CAR |z|) |listOfOperatorsSeenSoFar|))
                         (SETQ |modemap| (LASSOC '|modemap| (CDR |z|)))
                         (PROGN
                          (SETQ |listOfOperatorsSeenSoFar|
                                  (CONS (CAR |z|) |listOfOperatorsSeenSoFar|))
                          (TERPRI)
                          (PRIN0 (CAR |z|))
                          (|printString| '|: |)
                          (PRETTYPRINT |modemap|)))))
                      (SETQ |bfVar#34| (CDR |bfVar#34|))))
                   |y| NIL)))
                (SETQ |bfVar#33| (CDR |bfVar#33|))
                (SETQ |j| (+ |j| 1))))
             |x| NIL 1)))
          (SETQ |bfVar#32| (CDR |bfVar#32|))
          (SETQ |i| (+ |i| 1))))
       E NIL 1)))))

; prTriple T ==
;    SAY '"Code:"
;    pp T.0
;    SAY '"Mode:"
;    pp T.1

(DEFUN |prTriple| (T$)
  (PROG ()
    (RETURN
     (PROGN (SAY "Code:") (|pp| (ELT T$ 0)) (SAY "Mode:") (|pp| (ELT T$ 1))))))

; TrimCF() ==
;   new:= nil
;   old:= CAAR $CategoryFrame
;   for u in old repeat
;     if not ASSQ(first u,new) then
;       uold:= rest u
;       unew:= nil
;       for v in uold repeat if not ASSQ(first v,unew) then unew:= [v,:unew]
;       new:= [[first u,:NREVERSE unew],:new]
;   $CategoryFrame:= [[NREVERSE new]]
;   nil

(DEFUN |TrimCF| ()
  (PROG (|unew| |uold| |old| |new|)
    (RETURN
     (PROGN
      (SETQ |new| NIL)
      (SETQ |old| (CAAR |$CategoryFrame|))
      ((LAMBDA (|bfVar#35| |u|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#35|) (PROGN (SETQ |u| (CAR |bfVar#35|)) NIL))
            (RETURN NIL))
           (#1='T
            (COND
             ((NULL (ASSQ (CAR |u|) |new|)) (SETQ |uold| (CDR |u|))
              (SETQ |unew| NIL)
              ((LAMBDA (|bfVar#36| |v|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#36|)
                        (PROGN (SETQ |v| (CAR |bfVar#36|)) NIL))
                    (RETURN NIL))
                   (#1#
                    (COND
                     ((NULL (ASSQ (CAR |v|) |unew|))
                      (SETQ |unew| (CONS |v| |unew|))))))
                  (SETQ |bfVar#36| (CDR |bfVar#36|))))
               |uold| NIL)
              (SETQ |new| (CONS (CONS (CAR |u|) (NREVERSE |unew|)) |new|))))))
          (SETQ |bfVar#35| (CDR |bfVar#35|))))
       |old| NIL)
      (SETQ |$CategoryFrame| (LIST (LIST (NREVERSE |new|))))
      NIL))))

; isConstantId(name,e) ==
;   IDENTP name =>
;     pl:= getProplist(name,e) =>
;       (LASSOC("value",pl) or LASSOC("mode",pl) => false; true)
;     true
;   false

(DEFUN |isConstantId| (|name| |e|)
  (PROG (|pl|)
    (RETURN
     (COND
      ((IDENTP |name|)
       (COND
        ((SETQ |pl| (|getProplist| |name| |e|))
         (COND ((OR (LASSOC '|value| |pl|) (LASSOC '|mode| |pl|)) NIL)
               (#1='T T)))
        (#1# T)))
      (#1# NIL)))))

; isFalse() == nil

(DEFUN |isFalse| () (PROG () (RETURN NIL)))

; isFluid s == SYMBOLP(s) and #(n := PNAME(s)) > 0 and "$" = n.0

(DEFUN |isFluid| (|s|)
  (PROG (|n|)
    (RETURN
     (AND (SYMBOLP |s|) (< 0 (LENGTH (SETQ |n| (PNAME |s|))))
          (EQ '$ (ELT |n| 0))))))

; isFunction(x,e) ==
;     get(x, "modemap", e) or GETL(x, "comp_special") or x = "case"
;       or getmode(x, e) is ["Mapping", :.]

(DEFUN |isFunction| (|x| |e|)
  (PROG (|ISTMP#1|)
    (RETURN
     (OR (|get| |x| '|modemap| |e|) (GETL |x| '|comp_special|) (EQ |x| '|case|)
         (PROGN
          (SETQ |ISTMP#1| (|getmode| |x| |e|))
          (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|Mapping|)))))))

; isLiteral(x,e) == get(x,"isLiteral",e)

(DEFUN |isLiteral| (|x| |e|) (PROG () (RETURN (|get| |x| '|isLiteral| |e|))))

; makeLiteral(x,e) == put(x,"isLiteral","true",e)

(DEFUN |makeLiteral| (|x| |e|)
  (PROG () (RETURN (|put| |x| '|isLiteral| '|true| |e|))))

; isSomeDomainVariable s ==
;   IDENTP s and #(x:= PNAME s)>2 and x.(0)="#" and x.(1)="#"

(DEFUN |isSomeDomainVariable| (|s|)
  (PROG (|x|)
    (RETURN
     (AND (IDENTP |s|) (< 2 (LENGTH (SETQ |x| (PNAME |s|))))
          (EQ (ELT |x| 0) '|#|) (EQ (ELT |x| 1) '|#|)))))

; is_integer_subset(s, t) ==
;     t = "Integer" =>
;         s = "PositiveInteger" => [">", "*", 0]
;         s = "NonNegativeInteger" => [">=", "*", 0]
;         s = "SingleInteger" => ["SINTP", "*"]
;     t = "NonNegativeInteger" and s = "PositiveInteger" => [">", "*", 0]
;     false

(DEFUN |is_integer_subset| (|s| |t|)
  (PROG ()
    (RETURN
     (COND
      ((EQ |t| '|Integer|)
       (COND ((EQ |s| '|PositiveInteger|) (LIST '> '* 0))
             ((EQ |s| '|NonNegativeInteger|) (LIST '>= '* 0))
             ((EQ |s| '|SingleInteger|) (LIST 'SINTP '*))))
      ((AND (EQ |t| '|NonNegativeInteger|) (EQ |s| '|PositiveInteger|))
       (LIST '> '* 0))
      ('T NIL)))))

; isSubset(x,y,e) ==
;   x = "$" and y = "Rep" or x = y or is_integer_subset(opOf(x), opOf(y)) or
;       LASSOC(opOf(x), get(opOf(y), "SubDomain", e)) or
;         opOf(y)='Type

(DEFUN |isSubset| (|x| |y| |e|)
  (PROG ()
    (RETURN
     (OR (AND (EQ |x| '$) (EQ |y| '|Rep|)) (EQUAL |x| |y|)
         (|is_integer_subset| (|opOf| |x|) (|opOf| |y|))
         (LASSOC (|opOf| |x|) (|get| (|opOf| |y|) '|SubDomain| |e|))
         (EQ (|opOf| |y|) '|Type|)))))

; isDomainInScope(domain,e) ==
;   domainList:= getDomainsInScope e
;   atom domain =>
;     MEMQ(domain,domainList) => true
;     not IDENTP domain or isSomeDomainVariable domain => true
;     false
;   (name:= first domain)="Category" => true
;   ASSQ(name,domainList) => true
; --   null rest domain or domainMember(domain,domainList) => true
; --   false
;   isFunctor name => false
;   true --is not a functor

(DEFUN |isDomainInScope| (|domain| |e|)
  (PROG (|domainList| |name|)
    (RETURN
     (PROGN
      (SETQ |domainList| (|getDomainsInScope| |e|))
      (COND
       ((ATOM |domain|)
        (COND ((MEMQ |domain| |domainList|) T)
              ((OR (NULL (IDENTP |domain|)) (|isSomeDomainVariable| |domain|))
               T)
              (#1='T NIL)))
       ((EQ (SETQ |name| (CAR |domain|)) '|Category|) T)
       ((ASSQ |name| |domainList|) T) ((|isFunctor| |name|) NIL) (#1# T))))))

; isSymbol x == IDENTP x

(DEFUN |isSymbol| (|x|) (PROG () (RETURN (IDENTP |x|))))

; isSimple x ==
;   atom x => true
;   x is [op,:argl] and
;     isSideEffectFree op and (and/[isSimple y for y in argl])

(DEFUN |isSimple| (|x|)
  (PROG (|op| |argl|)
    (RETURN
     (COND ((ATOM |x|) T)
           (#1='T
            (AND (CONSP |x|)
                 (PROGN (SETQ |op| (CAR |x|)) (SETQ |argl| (CDR |x|)) #1#)
                 (|isSideEffectFree| |op|)
                 ((LAMBDA (|bfVar#38| |bfVar#37| |y|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#37|)
                           (PROGN (SETQ |y| (CAR |bfVar#37|)) NIL))
                       (RETURN |bfVar#38|))
                      (#1#
                       (PROGN
                        (SETQ |bfVar#38| (|isSimple| |y|))
                        (COND ((NOT |bfVar#38|) (RETURN NIL))))))
                     (SETQ |bfVar#37| (CDR |bfVar#37|))))
                  T |argl| NIL)))))))

; isSideEffectFree op ==
;   constructor? op or member(op,$SideEffectFreeFunctionList) or
;     op is ["Sel", ., op'] and isSideEffectFree op'

(DEFUN |isSideEffectFree| (|op|)
  (PROG (|ISTMP#1| |ISTMP#2| |op'|)
    (RETURN
     (OR (|constructor?| |op|) (|member| |op| |$SideEffectFreeFunctionList|)
         (AND (CONSP |op|) (EQ (CAR |op|) '|Sel|)
              (PROGN
               (SETQ |ISTMP#1| (CDR |op|))
               (AND (CONSP |ISTMP#1|)
                    (PROGN
                     (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                     (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                          (PROGN (SETQ |op'| (CAR |ISTMP#2|)) 'T)))))
              (|isSideEffectFree| |op'|))))))

; isAlmostSimple x ==
;   --returns (<new predicate> . <list of assignments>) or nil
;   $assignmentList: local --$assigmentList is only used in this function
;   transform:=
;     fn x where
;       fn x ==
;         atom x or null rest x => x
;         [op,y,:l]:= x
;         op="has" => x
;         op="is" => x
;         op = ":=" =>
;           IDENTP y => (setAssignment LIST x; y)
;           true => (setAssignment [[":=", g := genVariable(), :l],
;                                   [":=", y, g]]; g)
;         isSideEffectFree op => [op, :mapInto(rest x, function fn)]
;         true => $assignmentList:= "failed"
;       setAssignment x ==
;         $assignmentList="failed" => nil
;         $assignmentList:= [:$assignmentList,:x]
;   $assignmentList="failed" => nil
;   wrapSEQExit [:$assignmentList,transform]

(DEFUN |isAlmostSimple| (|x|)
  (PROG (|$assignmentList| |transform|)
    (DECLARE (SPECIAL |$assignmentList|))
    (RETURN
     (PROGN
      (SETQ |$assignmentList| NIL)
      (SETQ |transform| (|isAlmostSimple,fn| |x|))
      (COND ((EQ |$assignmentList| '|failed|) NIL)
            ('T
             (|wrapSEQExit|
              (APPEND |$assignmentList| (CONS |transform| NIL)))))))))
(DEFUN |isAlmostSimple,fn| (|x|)
  (PROG (|op| |y| |l| |g|)
    (RETURN
     (COND ((OR (ATOM |x|) (NULL (CDR |x|))) |x|)
           ('T
            (PROGN
             (SETQ |op| (CAR |x|))
             (SETQ |y| (CADR |x|))
             (SETQ |l| (CDDR |x|))
             (COND ((EQ |op| '|has|) |x|) ((EQ |op| '|is|) |x|)
                   ((EQ |op| '|:=|)
                    (COND
                     ((IDENTP |y|)
                      (PROGN (|isAlmostSimple,setAssignment| (LIST |x|)) |y|))
                     (T
                      (PROGN
                       (|isAlmostSimple,setAssignment|
                        (LIST
                         (CONS '|:=| (CONS (SETQ |g| (|genVariable|)) |l|))
                         (LIST '|:=| |y| |g|)))
                       |g|))))
                   ((|isSideEffectFree| |op|)
                    (CONS |op| (|mapInto| (CDR |x|) #'|isAlmostSimple,fn|)))
                   (T (SETQ |$assignmentList| '|failed|)))))))))
(DEFUN |isAlmostSimple,setAssignment| (|x|)
  (PROG ()
    (RETURN
     (COND ((EQ |$assignmentList| '|failed|) NIL)
           ('T (SETQ |$assignmentList| (APPEND |$assignmentList| |x|)))))))

; incExitLevel u ==
;   adjExitLevel(u,1,1)
;   u

(DEFUN |incExitLevel| (|u|)
  (PROG () (RETURN (PROGN (|adjExitLevel| |u| 1 1) |u|))))

; decExitLevel u ==
;   (adjExitLevel(u,1,-1); removeExit0 u) where
;     removeExit0 x ==
;       atom x => x
;       x is ["exit",0,u] => removeExit0 u
;       [removeExit0 first x,:removeExit0 rest x]

(DEFUN |decExitLevel| (|u|)
  (PROG ()
    (RETURN
     (PROGN (|adjExitLevel| |u| 1 (- 1)) (|decExitLevel,removeExit0| |u|)))))
(DEFUN |decExitLevel,removeExit0| (|x|)
  (PROG (|ISTMP#1| |ISTMP#2| |u|)
    (RETURN
     (COND ((ATOM |x|) |x|)
           ((AND (CONSP |x|) (EQ (CAR |x|) '|exit|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |x|))
                  (AND (CONSP |ISTMP#1|) (EQUAL (CAR |ISTMP#1|) 0)
                       (PROGN
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |u| (CAR |ISTMP#2|)) #1='T))))))
            (|decExitLevel,removeExit0| |u|))
           (#1#
            (CONS (|decExitLevel,removeExit0| (CAR |x|))
                  (|decExitLevel,removeExit0| (CDR |x|))))))))

; adjExitLevel(x,seqnum,inc) ==
;   atom x => x
;   x is [op,:l] and MEMQ(op,'(SEQ REPEAT COLLECT)) =>
;     for u in l repeat adjExitLevel(u,seqnum+1,inc)
;   x is ["exit",n,u] =>
;     (adjExitLevel(u,seqnum,inc); seqnum>n => x; rplac(CADR x,n+inc))
;   x is [op,:l] => for u in l repeat adjExitLevel(u,seqnum,inc)

(DEFUN |adjExitLevel| (|x| |seqnum| |inc|)
  (PROG (|op| |l| |ISTMP#1| |n| |ISTMP#2| |u|)
    (RETURN
     (COND ((ATOM |x|) |x|)
           ((AND (CONSP |x|)
                 (PROGN (SETQ |op| (CAR |x|)) (SETQ |l| (CDR |x|)) #1='T)
                 (MEMQ |op| '(SEQ REPEAT COLLECT)))
            ((LAMBDA (|bfVar#39| |u|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#39|)
                      (PROGN (SETQ |u| (CAR |bfVar#39|)) NIL))
                  (RETURN NIL))
                 (#1# (|adjExitLevel| |u| (+ |seqnum| 1) |inc|)))
                (SETQ |bfVar#39| (CDR |bfVar#39|))))
             |l| NIL))
           ((AND (CONSP |x|) (EQ (CAR |x|) '|exit|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |x|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |n| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |u| (CAR |ISTMP#2|)) #1#))))))
            (PROGN
             (|adjExitLevel| |u| |seqnum| |inc|)
             (COND ((< |n| |seqnum|) |x|)
                   (#1# (|rplac| (CADR |x|) (+ |n| |inc|))))))
           ((AND (CONSP |x|)
                 (PROGN (SETQ |op| (CAR |x|)) (SETQ |l| (CDR |x|)) #1#))
            ((LAMBDA (|bfVar#40| |u|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#40|)
                      (PROGN (SETQ |u| (CAR |bfVar#40|)) NIL))
                  (RETURN NIL))
                 (#1# (|adjExitLevel| |u| |seqnum| |inc|)))
                (SETQ |bfVar#40| (CDR |bfVar#40|))))
             |l| NIL))))))

; wrapSEQExit l ==
;   null rest l => first l
;   [:c,x]:= [incExitLevel u for u in l]
;   ["SEQ",:c,["exit",1,x]]

(DEFUN |wrapSEQExit| (|l|)
  (PROG (|LETTMP#1| |LETTMP#2| |x| |c|)
    (RETURN
     (COND ((NULL (CDR |l|)) (CAR |l|))
           (#1='T
            (PROGN
             (SETQ |LETTMP#1|
                     ((LAMBDA (|bfVar#42| |bfVar#41| |u|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#41|)
                               (PROGN (SETQ |u| (CAR |bfVar#41|)) NIL))
                           (RETURN (NREVERSE |bfVar#42|)))
                          (#1#
                           (SETQ |bfVar#42|
                                   (CONS (|incExitLevel| |u|) |bfVar#42|))))
                         (SETQ |bfVar#41| (CDR |bfVar#41|))))
                      NIL |l| NIL))
             (SETQ |LETTMP#2| (REVERSE |LETTMP#1|))
             (SETQ |x| (CAR |LETTMP#2|))
             (SETQ |c| (NREVERSE (CDR |LETTMP#2|)))
             (CONS 'SEQ (APPEND |c| (CONS (LIST '|exit| 1 |x|) NIL)))))))))

; removeEnv t == [t.expr,t.mode,$EmptyEnvironment]  -- t is a triple

(DEFUN |removeEnv| (|t|)
  (PROG () (RETURN (LIST (CAR |t|) (CADR |t|) |$EmptyEnvironment|))))

; makeNonAtomic x ==
;   atom x => [x]
;   x

(DEFUN |makeNonAtomic| (|x|)
  (PROG () (RETURN (COND ((ATOM |x|) (LIST |x|)) ('T |x|)))))

; flatten(l,key) ==
;   null l => nil
;   first l is [k,:r] and k=key => [:r,:flatten(rest l,key)]
;   [first l,:flatten(rest l,key)]

(DEFUN |flatten| (|l| |key|)
  (PROG (|ISTMP#1| |k| |r|)
    (RETURN
     (COND ((NULL |l|) NIL)
           ((AND
             (PROGN
              (SETQ |ISTMP#1| (CAR |l|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |k| (CAR |ISTMP#1|))
                    (SETQ |r| (CDR |ISTMP#1|))
                    #1='T)))
             (EQUAL |k| |key|))
            (APPEND |r| (|flatten| (CDR |l|) |key|)))
           (#1# (CONS (CAR |l|) (|flatten| (CDR |l|) |key|)))))))

; genDomainVar() ==
;   $Index:= $Index+1
;   INTERNL1('"#D", STRINGIMAGE($Index))

(DEFUN |genDomainVar| ()
  (PROG ()
    (RETURN
     (PROGN
      (SETQ |$Index| (+ |$Index| 1))
      (INTERNL1 "#D" (STRINGIMAGE |$Index|))))))

; genVariable() ==
;   INTERNL1('"#G", STRINGIMAGE($genSDVar := $genSDVar + 1))

(DEFUN |genVariable| ()
  (PROG ()
    (RETURN
     (INTERNL1 "#G" (STRINGIMAGE (SETQ |$genSDVar| (+ |$genSDVar| 1)))))))

; genSomeVariable() ==
;   INTERNL1('"##", STRINGIMAGE($genSDVar := $genSDVar + 1))

(DEFUN |genSomeVariable| ()
  (PROG ()
    (RETURN
     (INTERNL1 "##" (STRINGIMAGE (SETQ |$genSDVar| (+ |$genSDVar| 1)))))))

; listOfIdentifiersIn x ==
;   IDENTP x => [x]
;   x is [op,:l] => REMDUP ("append"/[listOfIdentifiersIn y for y in l])
;   nil

(DEFUN |listOfIdentifiersIn| (|x|)
  (PROG (|op| |l|)
    (RETURN
     (COND ((IDENTP |x|) (LIST |x|))
           ((AND (CONSP |x|)
                 (PROGN (SETQ |op| (CAR |x|)) (SETQ |l| (CDR |x|)) #1='T))
            (REMDUP
             ((LAMBDA (|bfVar#44| |bfVar#43| |y|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#43|)
                       (PROGN (SETQ |y| (CAR |bfVar#43|)) NIL))
                   (RETURN |bfVar#44|))
                  (#1#
                   (SETQ |bfVar#44|
                           (APPEND |bfVar#44| (|listOfIdentifiersIn| |y|)))))
                 (SETQ |bfVar#43| (CDR |bfVar#43|))))
              NIL |l| NIL)))
           (#1# NIL)))))

; mapInto(x,fn) == [FUNCALL(fn,y) for y in x]

(DEFUN |mapInto| (|x| |fn|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#46| |bfVar#45| |y|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#45|) (PROGN (SETQ |y| (CAR |bfVar#45|)) NIL))
           (RETURN (NREVERSE |bfVar#46|)))
          ('T (SETQ |bfVar#46| (CONS (FUNCALL |fn| |y|) |bfVar#46|))))
         (SETQ |bfVar#45| (CDR |bfVar#45|))))
      NIL |x| NIL))))

; numOfOccurencesOf(x,y) ==
;   fn(x,y,0) where
;     fn(x,y,n) ==
;       null y => 0
;       x=y => n+1
;       atom y => n
;       fn(x,first y,n)+fn(x,rest y,n)

(DEFUN |numOfOccurencesOf| (|x| |y|)
  (PROG () (RETURN (|numOfOccurencesOf,fn| |x| |y| 0))))
(DEFUN |numOfOccurencesOf,fn| (|x| |y| |n|)
  (PROG ()
    (RETURN
     (COND ((NULL |y|) 0) ((EQUAL |x| |y|) (+ |n| 1)) ((ATOM |y|) |n|)
           ('T
            (+ (|numOfOccurencesOf,fn| |x| (CAR |y|) |n|)
               (|numOfOccurencesOf,fn| |x| (CDR |y|) |n|)))))))

; compilerMessage x ==
;   $PrintCompilerMessageIfTrue => APPLY("SAY",x)

(DEFUN |compilerMessage| (|x|)
  (PROG ()
    (RETURN
     (COND (|$PrintCompilerMessageIfTrue| (IDENTITY (APPLY 'SAY |x|)))))))

; printDashedLine() ==
;   SAY
;    '"--------------------------------------------------------------------------"

(DEFUN |printDashedLine| ()
  (PROG ()
    (RETURN
     (SAY
      "--------------------------------------------------------------------------"))))

; stackSemanticError(msg,expr) ==
;   if $insideCapsuleFunctionIfTrue then msg:= [$op,": ",:msg]
;   if atom msg then msg:= LIST msg
;   entry:= [msg,expr]
;   if not member(entry,$semanticErrorStack) then $semanticErrorStack:=
;     [entry,:$semanticErrorStack]
;   $scanIfTrue and $insideCapsuleFunctionIfTrue=true and #$semanticErrorStack-
;     $initCapsuleErrorCount>3 => THROW("compCapsuleBody",nil)
;   nil

(DEFUN |stackSemanticError| (|msg| |expr|)
  (PROG (|entry|)
    (RETURN
     (PROGN
      (COND
       (|$insideCapsuleFunctionIfTrue|
        (SETQ |msg| (CONS |$op| (CONS '|: | |msg|)))))
      (COND ((ATOM |msg|) (SETQ |msg| (LIST |msg|))))
      (SETQ |entry| (LIST |msg| |expr|))
      (COND
       ((NULL (|member| |entry| |$semanticErrorStack|))
        (SETQ |$semanticErrorStack| (CONS |entry| |$semanticErrorStack|))))
      (COND
       ((AND |$scanIfTrue| (EQUAL |$insideCapsuleFunctionIfTrue| T)
             (< 3 (- (LENGTH |$semanticErrorStack|) |$initCapsuleErrorCount|)))
        (THROW '|compCapsuleBody| NIL))
       ('T NIL))))))

; stackWarning msg ==
;   if $insideCapsuleFunctionIfTrue then msg:= [$op,": ",:msg]
;   if not member(msg,$warningStack) then $warningStack:= [msg,:$warningStack]
;   nil

(DEFUN |stackWarning| (|msg|)
  (PROG ()
    (RETURN
     (PROGN
      (COND
       (|$insideCapsuleFunctionIfTrue|
        (SETQ |msg| (CONS |$op| (CONS '|: | |msg|)))))
      (COND
       ((NULL (|member| |msg| |$warningStack|))
        (SETQ |$warningStack| (CONS |msg| |$warningStack|))))
      NIL))))

; unStackWarning msg ==
;   if $insideCapsuleFunctionIfTrue then msg:= [$op,": ",:msg]
;   $warningStack:= EFFACE(msg,$warningStack)
;   nil

(DEFUN |unStackWarning| (|msg|)
  (PROG ()
    (RETURN
     (PROGN
      (COND
       (|$insideCapsuleFunctionIfTrue|
        (SETQ |msg| (CONS |$op| (CONS '|: | |msg|)))))
      (SETQ |$warningStack| (EFFACE |msg| |$warningStack|))
      NIL))))

; stackMessage msg ==
;   $compErrorMessageStack:= [msg,:$compErrorMessageStack]
;   nil

(DEFUN |stackMessage| (|msg|)
  (PROG ()
    (RETURN
     (PROGN
      (SETQ |$compErrorMessageStack| (CONS |msg| |$compErrorMessageStack|))
      NIL))))

; stackMessageIfNone msg ==
;   --used in situations such as compForm where the earliest message is wanted
;   if null $compErrorMessageStack then $compErrorMessageStack:=
;     [msg,:$compErrorMessageStack]
;   nil

(DEFUN |stackMessageIfNone| (|msg|)
  (PROG ()
    (RETURN
     (PROGN
      (COND
       ((NULL |$compErrorMessageStack|)
        (SETQ |$compErrorMessageStack| (CONS |msg| |$compErrorMessageStack|))))
      NIL))))

; stackAndThrow msg ==
;   $compErrorMessageStack:= [msg,:$compErrorMessageStack]
;   THROW("compOrCroak",nil)

(DEFUN |stackAndThrow| (|msg|)
  (PROG ()
    (RETURN
     (PROGN
      (SETQ |$compErrorMessageStack| (CONS |msg| |$compErrorMessageStack|))
      (THROW '|compOrCroak| NIL)))))

; printString x == PRINTEXP (STRINGP x => x; PNAME x)

(DEFUN |printString| (|x|)
  (PROG () (RETURN (PRINTEXP (COND ((STRINGP |x|) |x|) ('T (PNAME |x|)))))))

; printAny x == if atom x then printString x else PRIN0 x

(DEFUN |printAny| (|x|)
  (PROG () (RETURN (COND ((ATOM |x|) (|printString| |x|)) ('T (PRIN0 |x|))))))

; printSignature(before,op,[target,:argSigList]) ==
;   printString before
;   printString op
;   printString ": _("
;   if argSigList then
;     printAny first argSigList
;     for m in rest argSigList repeat (printString ","; printAny m)
;   printString "_) -> "
;   printAny target
;   TERPRI()

(DEFUN |printSignature| (|before| |op| |bfVar#48|)
  (PROG (|target| |argSigList|)
    (RETURN
     (PROGN
      (SETQ |target| (CAR |bfVar#48|))
      (SETQ |argSigList| (CDR |bfVar#48|))
      (|printString| |before|)
      (|printString| |op|)
      (|printString| '|: (|)
      (COND
       (|argSigList| (|printAny| (CAR |argSigList|))
        ((LAMBDA (|bfVar#47| |m|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#47|) (PROGN (SETQ |m| (CAR |bfVar#47|)) NIL))
              (RETURN NIL))
             ('T (PROGN (|printString| '|,|) (|printAny| |m|))))
            (SETQ |bfVar#47| (CDR |bfVar#47|))))
         (CDR |argSigList|) NIL)))
      (|printString| '|) -> |)
      (|printAny| |target|)
      (TERPRI)))))

; pmatch(s,p) == pmatchWithSl(s,p,"ok")

(DEFUN |pmatch| (|s| |p|) (PROG () (RETURN (|pmatchWithSl| |s| |p| '|ok|))))

; pmatchWithSl(s,p,al) ==
;   s=$EmptyMode => nil
;   s=p => al
;   v:= assoc(p,al) => s=rest v or al
;   MEMQ(p,$PatternVariableList) => [[p,:s],:al]
;   null atom p and null atom s and (al':= pmatchWithSl(first s,first p,al)) and
;     pmatchWithSl(rest s,rest p,al')

(DEFUN |pmatchWithSl| (|s| |p| |al|)
  (PROG (|v| |al'|)
    (RETURN
     (COND ((EQUAL |s| |$EmptyMode|) NIL) ((EQUAL |s| |p|) |al|)
           ((SETQ |v| (|assoc| |p| |al|)) (OR (EQUAL |s| (CDR |v|)) |al|))
           ((MEMQ |p| |$PatternVariableList|) (CONS (CONS |p| |s|) |al|))
           ('T
            (AND (NULL (ATOM |p|)) (NULL (ATOM |s|))
                 (SETQ |al'| (|pmatchWithSl| (CAR |s|) (CAR |p|) |al|))
                 (|pmatchWithSl| (CDR |s|) (CDR |p|) |al'|)))))))

; elapsedTime() ==
;   currentTime := get_run_time()
;   elapsedSeconds:= (currentTime-$previousTime)*1.0/$timerTicksPerSecond
;   $previousTime:= currentTime
;   elapsedSeconds

(DEFUN |elapsedTime| ()
  (PROG (|elapsedSeconds| |currentTime|)
    (RETURN
     (PROGN
      (SETQ |currentTime| (|get_run_time|))
      (SETQ |elapsedSeconds|
              (/ (* (- |currentTime| |$previousTime|) 1.0)
                 |$timerTicksPerSecond|))
      (SETQ |$previousTime| |currentTime|)
      |elapsedSeconds|))))

; addStats([a,b],[c,d]) == [a+c,b+d]

(DEFUN |addStats| (|bfVar#49| |bfVar#50|)
  (PROG (|c| |d| |a| |b|)
    (RETURN
     (PROGN
      (SETQ |c| (CAR |bfVar#50|))
      (SETQ |d| (CADR |bfVar#50|))
      (SETQ |a| (CAR |bfVar#49|))
      (SETQ |b| (CADR |bfVar#49|))
      (LIST (+ |a| |c|) (+ |b| |d|))))))

; printStats [byteCount,elapsedSeconds] ==
;   timeString := normalizeStatAndStringify elapsedSeconds
;   if byteCount = 0 then SAY('"Time: ",timeString,'" SEC.") else
;     SAY('"Size: ",byteCount,'" BYTES     Time: ",timeString,'" SEC.")
;   TERPRI()
;   nil

(DEFUN |printStats| (|bfVar#51|)
  (PROG (|byteCount| |elapsedSeconds| |timeString|)
    (RETURN
     (PROGN
      (SETQ |byteCount| (CAR |bfVar#51|))
      (SETQ |elapsedSeconds| (CADR |bfVar#51|))
      (SETQ |timeString| (|normalizeStatAndStringify| |elapsedSeconds|))
      (COND ((EQL |byteCount| 0) (SAY "Time: " |timeString| " SEC."))
            ('T
             (SAY "Size: " |byteCount| " BYTES     Time: " |timeString|
              " SEC.")))
      (TERPRI)
      NIL))))

; extendsCategoryForm(domain, form, form', e) ==
;   --is domain of category form also of category form'?
;   --domain is only used for ensuring that X being a Ring means that it
;   --satisfies (Algebra X)
;   form=form' => true
;   form=$Category => nil
;   form' = $Category => nil
;   form' is ["Join", :l] => and/[extendsCategoryForm(domain, form, x, e)
;                                 for x in l]
;   form' is ["CATEGORY",.,:l] =>
;     and/[extendsCategoryForm(domain, form, x, e) for x in l]
;   form is ["Join", :l] => or/[extendsCategoryForm(domain, x, form', e)
;                               for x in l]
;   form is ["CATEGORY",.,:l] =>
;     member(form',l) or
;       stackWarning ["not known that ",form'," is of mode ",form] or true
;   isCategoryForm(form) =>
;           --Constructs the associated vector
;     formVec := (compMakeCategoryObject(form, e)).expr
;             --Must be e to pick up locally bound domains
;     form' is ["SIGNATURE",op,args,:.] =>
;         assoc([op,args],formVec.(1)) or
;             assoc(SUBSTQ(domain,"$",[op,args]),
;                   SUBSTQ(domain,"$",formVec.(1)))
;     form' is ["ATTRIBUTE",at] => BREAK()
;     form' is ["IF",:.] => true --temporary hack so comp won't fail
;     -- Are we dealing with an Aldor category?  If so use the "has" function ...
;     # formVec = 1 => newHasTest(form,form')
;     catvlist:= formVec.4
;     member(form',first catvlist) or
;      member(form',SUBSTQ(domain,"$",first catvlist)) or
;       (or/
;         [extendsCategoryForm(domain, SUBSTQ(domain, "$", cat), form', e)
;           for [cat,:.] in CADR catvlist])
;   nil

(DEFUN |extendsCategoryForm| (|domain| |form| |form'| |e|)
  (PROG (|l| |ISTMP#1| |formVec| |op| |ISTMP#2| |args| |at| |catvlist| |cat|)
    (RETURN
     (COND ((EQUAL |form| |form'|) T) ((EQUAL |form| |$Category|) NIL)
           ((EQUAL |form'| |$Category|) NIL)
           ((AND (CONSP |form'|) (EQ (CAR |form'|) '|Join|)
                 (PROGN (SETQ |l| (CDR |form'|)) #1='T))
            ((LAMBDA (|bfVar#53| |bfVar#52| |x|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#52|)
                      (PROGN (SETQ |x| (CAR |bfVar#52|)) NIL))
                  (RETURN |bfVar#53|))
                 (#1#
                  (PROGN
                   (SETQ |bfVar#53|
                           (|extendsCategoryForm| |domain| |form| |x| |e|))
                   (COND ((NOT |bfVar#53|) (RETURN NIL))))))
                (SETQ |bfVar#52| (CDR |bfVar#52|))))
             T |l| NIL))
           ((AND (CONSP |form'|) (EQ (CAR |form'|) 'CATEGORY)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |form'|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN (SETQ |l| (CDR |ISTMP#1|)) #1#))))
            ((LAMBDA (|bfVar#55| |bfVar#54| |x|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#54|)
                      (PROGN (SETQ |x| (CAR |bfVar#54|)) NIL))
                  (RETURN |bfVar#55|))
                 (#1#
                  (PROGN
                   (SETQ |bfVar#55|
                           (|extendsCategoryForm| |domain| |form| |x| |e|))
                   (COND ((NOT |bfVar#55|) (RETURN NIL))))))
                (SETQ |bfVar#54| (CDR |bfVar#54|))))
             T |l| NIL))
           ((AND (CONSP |form|) (EQ (CAR |form|) '|Join|)
                 (PROGN (SETQ |l| (CDR |form|)) #1#))
            ((LAMBDA (|bfVar#57| |bfVar#56| |x|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#56|)
                      (PROGN (SETQ |x| (CAR |bfVar#56|)) NIL))
                  (RETURN |bfVar#57|))
                 (#1#
                  (PROGN
                   (SETQ |bfVar#57|
                           (|extendsCategoryForm| |domain| |x| |form'| |e|))
                   (COND (|bfVar#57| (RETURN |bfVar#57|))))))
                (SETQ |bfVar#56| (CDR |bfVar#56|))))
             NIL |l| NIL))
           ((AND (CONSP |form|) (EQ (CAR |form|) 'CATEGORY)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |form|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN (SETQ |l| (CDR |ISTMP#1|)) #1#))))
            (OR (|member| |form'| |l|)
                (|stackWarning|
                 (LIST '|not known that | |form'| '| is of mode | |form|))
                T))
           ((|isCategoryForm| |form|)
            (PROGN
             (SETQ |formVec| (CAR (|compMakeCategoryObject| |form| |e|)))
             (COND
              ((AND (CONSP |form'|) (EQ (CAR |form'|) 'SIGNATURE)
                    (PROGN
                     (SETQ |ISTMP#1| (CDR |form'|))
                     (AND (CONSP |ISTMP#1|)
                          (PROGN
                           (SETQ |op| (CAR |ISTMP#1|))
                           (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                           (AND (CONSP |ISTMP#2|)
                                (PROGN (SETQ |args| (CAR |ISTMP#2|)) #1#))))))
               (OR (|assoc| (LIST |op| |args|) (ELT |formVec| 1))
                   (|assoc| (SUBSTQ |domain| '$ (LIST |op| |args|))
                    (SUBSTQ |domain| '$ (ELT |formVec| 1)))))
              ((AND (CONSP |form'|) (EQ (CAR |form'|) 'ATTRIBUTE)
                    (PROGN
                     (SETQ |ISTMP#1| (CDR |form'|))
                     (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                          (PROGN (SETQ |at| (CAR |ISTMP#1|)) #1#))))
               (BREAK))
              ((AND (CONSP |form'|) (EQ (CAR |form'|) 'IF)) T)
              ((EQL (LENGTH |formVec|) 1) (|newHasTest| |form| |form'|))
              (#1#
               (PROGN
                (SETQ |catvlist| (ELT |formVec| 4))
                (OR (|member| |form'| (CAR |catvlist|))
                    (|member| |form'| (SUBSTQ |domain| '$ (CAR |catvlist|)))
                    ((LAMBDA (|bfVar#60| |bfVar#59| |bfVar#58|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#59|)
                              (PROGN (SETQ |bfVar#58| (CAR |bfVar#59|)) NIL))
                          (RETURN |bfVar#60|))
                         (#1#
                          (AND (CONSP |bfVar#58|)
                               (PROGN (SETQ |cat| (CAR |bfVar#58|)) #1#)
                               (PROGN
                                (SETQ |bfVar#60|
                                        (|extendsCategoryForm| |domain|
                                         (SUBSTQ |domain| '$ |cat|) |form'|
                                         |e|))
                                (COND (|bfVar#60| (RETURN |bfVar#60|)))))))
                        (SETQ |bfVar#59| (CDR |bfVar#59|))))
                     NIL (CADR |catvlist|) NIL)))))))
           (#1# NIL)))))

; getmode(x,e) ==
;   prop:=getProplist(x,e)
;   u := QLASSQ("value", prop) => u.mode
;   QLASSQ("mode", prop)

(DEFUN |getmode| (|x| |e|)
  (PROG (|prop| |u|)
    (RETURN
     (PROGN
      (SETQ |prop| (|getProplist| |x| |e|))
      (COND ((SETQ |u| (QLASSQ '|value| |prop|)) (CADR |u|))
            ('T (QLASSQ '|mode| |prop|)))))))

; getmodeOrMapping(x,e) ==
;   u:= getmode(x,e) => u
;   (u:= get(x,"modemap",e)) is [[[.,:map],.],:.] => ["Mapping",:map]
;   nil

(DEFUN |getmodeOrMapping| (|x| |e|)
  (PROG (|u| |ISTMP#1| |ISTMP#2| |ISTMP#3| |map| |ISTMP#4|)
    (RETURN
     (COND ((SETQ |u| (|getmode| |x| |e|)) |u|)
           ((PROGN
             (SETQ |ISTMP#1| (SETQ |u| (|get| |x| '|modemap| |e|)))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|)
                        (PROGN
                         (SETQ |ISTMP#3| (CAR |ISTMP#2|))
                         (AND (CONSP |ISTMP#3|)
                              (PROGN (SETQ |map| (CDR |ISTMP#3|)) #1='T)))
                        (PROGN
                         (SETQ |ISTMP#4| (CDR |ISTMP#2|))
                         (AND (CONSP |ISTMP#4|) (EQ (CDR |ISTMP#4|) NIL)))))))
            (CONS '|Mapping| |map|))
           (#1# NIL)))))

; substituteOp(op',op,x) ==
;   atom x => x
;   [(op=(f:= first x) => op'; f),:[substituteOp(op',op,y) for y in rest x]]

(DEFUN |substituteOp| (|op'| |op| |x|)
  (PROG (|f|)
    (RETURN
     (COND ((ATOM |x|) |x|)
           (#1='T
            (CONS (COND ((EQUAL |op| (SETQ |f| (CAR |x|))) |op'|) (#1# |f|))
                  ((LAMBDA (|bfVar#62| |bfVar#61| |y|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#61|)
                            (PROGN (SETQ |y| (CAR |bfVar#61|)) NIL))
                        (RETURN (NREVERSE |bfVar#62|)))
                       (#1#
                        (SETQ |bfVar#62|
                                (CONS (|substituteOp| |op'| |op| |y|)
                                      |bfVar#62|))))
                      (SETQ |bfVar#61| (CDR |bfVar#61|))))
                   NIL (CDR |x|) NIL)))))))

; sublis_vec(p, e) ==
;   LIST2REFVEC [suba(p, e.i) for i in 0..MAXINDEX e] where
;     suba(p,e) ==
;       STRINGP e => e
;       atom e => (y:= ASSQ(e,p) => rest y; e)
;       u:= suba(p,QCAR e)
;       v:= suba(p,QCDR e)
;       EQ(QCAR e,u) and EQ(QCDR e,v) => e
;       [u,:v]

(DEFUN |sublis_vec| (|p| |e|)
  (PROG ()
    (RETURN
     (LIST2REFVEC
      ((LAMBDA (|bfVar#64| |bfVar#63| |i|)
         (LOOP
          (COND ((> |i| |bfVar#63|) (RETURN (NREVERSE |bfVar#64|)))
                ('T
                 (SETQ |bfVar#64|
                         (CONS (|sublis_vec,suba| |p| (ELT |e| |i|))
                               |bfVar#64|))))
          (SETQ |i| (+ |i| 1))))
       NIL (MAXINDEX |e|) 0)))))
(DEFUN |sublis_vec,suba| (|p| |e|)
  (PROG (|y| |u| |v|)
    (RETURN
     (COND ((STRINGP |e|) |e|)
           ((ATOM |e|)
            (COND ((SETQ |y| (ASSQ |e| |p|)) (CDR |y|)) (#1='T |e|)))
           (#1#
            (PROGN
             (SETQ |u| (|sublis_vec,suba| |p| (QCAR |e|)))
             (SETQ |v| (|sublis_vec,suba| |p| (QCDR |e|)))
             (COND ((AND (EQ (QCAR |e|) |u|) (EQ (QCDR |e|) |v|)) |e|)
                   (#1# (CONS |u| |v|)))))))))

; subst_in_cat(fp, ap, cv) ==
;     pp := MAPCAR(FUNCTION CONS, fp, ap)
;     sublis_vec(pp, cv)

(DEFUN |subst_in_cat| (|fp| |ap| |cv|)
  (PROG (|pp|)
    (RETURN
     (PROGN (SETQ |pp| (MAPCAR #'CONS |fp| |ap|)) (|sublis_vec| |pp| |cv|)))))

; _?MODEMAPS x == _?modemaps x

(DEFUN ?MODEMAPS (|x|) (PROG () (RETURN (|?modemaps| |x|))))

; _?modemaps x ==
;   env:=
;     $insideCapsuleFunctionIfTrue=true => $CapsuleModemapFrame
;     $f
;   x="all" => displayModemaps env
;   -- displayOpModemaps(x,old2NewModemaps get(x,"modemap",env))
;   displayOpModemaps(x,get(x,"modemap",env))

(DEFUN |?modemaps| (|x|)
  (PROG (|env|)
    (RETURN
     (PROGN
      (SETQ |env|
              (COND
               ((EQUAL |$insideCapsuleFunctionIfTrue| T)
                |$CapsuleModemapFrame|)
               (#1='T |$f|)))
      (COND ((EQ |x| '|all|) (|displayModemaps| |env|))
            (#1# (|displayOpModemaps| |x| (|get| |x| '|modemap| |env|))))))))

; old2NewModemaps x ==
; --  [[dcSig,pred] for [dcSig,[pred,:.],:.] in x]
;   x is [dcSig,[pred,:.],:.]  =>  [dcSig,pred]
;   x

(DEFUN |old2NewModemaps| (|x|)
  (PROG (|dcSig| |ISTMP#1| |ISTMP#2| |pred|)
    (RETURN
     (COND
      ((AND (CONSP |x|)
            (PROGN
             (SETQ |dcSig| (CAR |x|))
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|)
                        (PROGN (SETQ |pred| (CAR |ISTMP#2|)) #1='T))))))
       (LIST |dcSig| |pred|))
      (#1# |x|)))))

; traceUp() ==
;   atom $x => sayBrightly "$x is an atom"
;   for y in rest $x repeat
;     u:= comp(y,$EmptyMode,$f) =>
;       sayBrightly [y,'" ==> mode",'%b,u.mode,'%d]
;     sayBrightly [y,'" does not compile"]

(DEFUN |traceUp| ()
  (PROG (|u|)
    (RETURN
     (COND ((ATOM |$x|) (|sayBrightly| '|$x is an atom|))
           (#1='T
            ((LAMBDA (|bfVar#65| |y|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#65|)
                      (PROGN (SETQ |y| (CAR |bfVar#65|)) NIL))
                  (RETURN NIL))
                 (#1#
                  (COND
                   ((SETQ |u| (|comp| |y| |$EmptyMode| |$f|))
                    (|sayBrightly|
                     (LIST |y| " ==> mode" '|%b| (CADR |u|) '|%d|)))
                   (#1# (|sayBrightly| (LIST |y| " does not compile"))))))
                (SETQ |bfVar#65| (CDR |bfVar#65|))))
             (CDR |$x|) NIL))))))

; _?m x ==
;   u:= comp(x,$EmptyMode,$f) => u.mode
;   nil

(DEFUN |?m| (|x|)
  (PROG (|u|)
    (RETURN
     (COND ((SETQ |u| (|comp| |x| |$EmptyMode| |$f|)) (CADR |u|)) ('T NIL)))))

; traceDown() ==
;   mmList:= getFormModemaps($x,$f) =>
;     for mm in mmList repeat if u:= qModemap mm then return u
;   sayBrightly "no modemaps for $x"

(DEFUN |traceDown| ()
  (PROG (|u| |mmList|)
    (RETURN
     (COND
      ((SETQ |mmList| (|getFormModemaps| |$x| |$f|))
       ((LAMBDA (|bfVar#66| |mm|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#66|) (PROGN (SETQ |mm| (CAR |bfVar#66|)) NIL))
             (RETURN NIL))
            (#1='T (COND ((SETQ |u| (|qModemap| |mm|)) (RETURN |u|)))))
           (SETQ |bfVar#66| (CDR |bfVar#66|))))
        |mmList| NIL))
      (#1# (|sayBrightly| '|no modemaps for $x|))))))

; qModemap mm ==
;   sayBrightly ['%b,"modemap",'%d,:formatModemap mm]
;   [[dc,target,:sl],[pred,:.]]:= mm
;   and/[qArg(a,m) for a in rest $x for m in sl] => target
;   sayBrightly ['%b,"fails",'%d,'%l]

(DEFUN |qModemap| (|mm|)
  (PROG (|dc| |target| |sl| |pred|)
    (RETURN
     (PROGN
      (|sayBrightly|
       (CONS '|%b| (CONS '|modemap| (CONS '|%d| (|formatModemap| |mm|)))))
      (SETQ |dc| (CAAR . #1=(|mm|)))
      (SETQ |target| (CADAR . #1#))
      (SETQ |sl| (CDDAR . #1#))
      (SETQ |pred| (CAADR |mm|))
      (COND
       (((LAMBDA (|bfVar#69| |bfVar#67| |a| |bfVar#68| |m|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#67|) (PROGN (SETQ |a| (CAR |bfVar#67|)) NIL)
                  (ATOM |bfVar#68|) (PROGN (SETQ |m| (CAR |bfVar#68|)) NIL))
              (RETURN |bfVar#69|))
             (#2='T
              (PROGN
               (SETQ |bfVar#69| (|qArg| |a| |m|))
               (COND ((NOT |bfVar#69|) (RETURN NIL))))))
            (SETQ |bfVar#67| (CDR |bfVar#67|))
            (SETQ |bfVar#68| (CDR |bfVar#68|))))
         T (CDR |$x|) NIL |sl| NIL)
        |target|)
       (#2# (|sayBrightly| (LIST '|%b| '|fails| '|%d| '|%l|))))))))

; qArg(a,m) ==
;   yesOrNo:=
;     u:= comp(a,m,$f) => "yes"
;     "no"
;   sayBrightly [a," --> ",m,'%b,yesOrNo,'%d]
;   yesOrNo="yes"

(DEFUN |qArg| (|a| |m|)
  (PROG (|u| |yesOrNo|)
    (RETURN
     (PROGN
      (SETQ |yesOrNo|
              (COND ((SETQ |u| (|comp| |a| |m| |$f|)) '|yes|) ('T '|no|)))
      (|sayBrightly| (LIST |a| '| --> | |m| '|%b| |yesOrNo| '|%d|))
      (EQ |yesOrNo| '|yes|)))))

; _?comp x ==
;   msg:=
;     u:= comp(x,$EmptyMode,$f) =>
;       [MAKESTRING "compiles to mode",'%b,u.mode,'%d]
;     nil
;   sayBrightly msg

(DEFUN |?comp| (|x|)
  (PROG (|u| |msg|)
    (RETURN
     (PROGN
      (SETQ |msg|
              (COND
               ((SETQ |u| (|comp| |x| |$EmptyMode| |$f|))
                (LIST (MAKESTRING '|compiles to mode|) '|%b| (CADR |u|) '|%d|))
               ('T NIL)))
      (|sayBrightly| |msg|)))))

; _?domains() == pp getDomainsInScope $f

(DEFUN |?domains| () (PROG () (RETURN (|pp| (|getDomainsInScope| |$f|)))))

; _?mode x == displayProplist(x,[["mode",:getmode(x,$f)]])

(DEFUN |?mode| (|x|)
  (PROG ()
    (RETURN
     (|displayProplist| |x| (LIST (CONS '|mode| (|getmode| |x| |$f|)))))))

; _?properties x == displayProplist(x,getProplist(x,$f))

(DEFUN |?properties| (|x|)
  (PROG () (RETURN (|displayProplist| |x| (|getProplist| |x| |$f|)))))

; _?value x == displayProplist(x,[["value",:get(x,"value",$f)]])

(DEFUN |?value| (|x|)
  (PROG ()
    (RETURN
     (|displayProplist| |x| (LIST (CONS '|value| (|get| |x| '|value| |$f|)))))))

; displayProplist(x,alist) ==
;   sayBrightly ["properties of",'%b,x,'%d,":"]
;   fn alist where
;     fn alist ==
;       alist is [[prop,:val],:l] =>
;         if prop="value" then val:= [val.expr,val.mode,'"..."]
;         sayBrightly ["   ",'%b,prop,'%d,": ",val]
;         fn deleteAssoc(prop,l)

(DEFUN |displayProplist| (|x| |alist|)
  (PROG ()
    (RETURN
     (PROGN
      (|sayBrightly| (LIST '|properties of| '|%b| |x| '|%d| '|:|))
      (|displayProplist,fn| |alist|)))))
(DEFUN |displayProplist,fn| (|alist|)
  (PROG (|ISTMP#1| |prop| |val| |l|)
    (RETURN
     (COND
      ((AND (CONSP |alist|)
            (PROGN
             (SETQ |ISTMP#1| (CAR |alist|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |prop| (CAR |ISTMP#1|))
                   (SETQ |val| (CDR |ISTMP#1|))
                   #1='T)))
            (PROGN (SETQ |l| (CDR |alist|)) #1#))
       (IDENTITY
        (PROGN
         (COND
          ((EQ |prop| '|value|)
           (SETQ |val| (LIST (CAR |val|) (CADR |val|) "..."))))
         (|sayBrightly| (LIST '|   | '|%b| |prop| '|%d| '|: | |val|))
         (|displayProplist,fn| (|deleteAssoc| |prop| |l|)))))))))

; displayModemaps E ==
;   listOfOperatorsSeenSoFar:= nil
;   for x in E for i in 1.. repeat
;     for y in x for j in 1.. repeat
;       for z in y | null member(first z,listOfOperatorsSeenSoFar) and
;         (modemaps:= LASSOC("modemap",rest z)) repeat
;           listOfOperatorsSeenSoFar:= [first z,:listOfOperatorsSeenSoFar]
;           displayOpModemaps(first z,modemaps)

(DEFUN |displayModemaps| (E)
  (PROG (|listOfOperatorsSeenSoFar| |modemaps|)
    (RETURN
     (PROGN
      (SETQ |listOfOperatorsSeenSoFar| NIL)
      ((LAMBDA (|bfVar#70| |x| |i|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#70|) (PROGN (SETQ |x| (CAR |bfVar#70|)) NIL))
            (RETURN NIL))
           (#1='T
            ((LAMBDA (|bfVar#71| |y| |j|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#71|)
                      (PROGN (SETQ |y| (CAR |bfVar#71|)) NIL))
                  (RETURN NIL))
                 (#1#
                  ((LAMBDA (|bfVar#72| |z|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#72|)
                            (PROGN (SETQ |z| (CAR |bfVar#72|)) NIL))
                        (RETURN NIL))
                       (#1#
                        (AND
                         (NULL (|member| (CAR |z|) |listOfOperatorsSeenSoFar|))
                         (SETQ |modemaps| (LASSOC '|modemap| (CDR |z|)))
                         (PROGN
                          (SETQ |listOfOperatorsSeenSoFar|
                                  (CONS (CAR |z|) |listOfOperatorsSeenSoFar|))
                          (|displayOpModemaps| (CAR |z|) |modemaps|)))))
                      (SETQ |bfVar#72| (CDR |bfVar#72|))))
                   |y| NIL)))
                (SETQ |bfVar#71| (CDR |bfVar#71|))
                (SETQ |j| (+ |j| 1))))
             |x| NIL 1)))
          (SETQ |bfVar#70| (CDR |bfVar#70|))
          (SETQ |i| (+ |i| 1))))
       E NIL 1)))))
