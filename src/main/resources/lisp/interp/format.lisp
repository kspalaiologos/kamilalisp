
; )package "BOOT"

(IN-PACKAGE "BOOT")

; sayModemap m ==
;   -- sayMSG formatModemap displayTranModemap m
;   sayMSG formatModemap old2NewModemaps displayTranModemap m

(DEFUN |sayModemap| (|m|)
  (PROG ()
    (RETURN
     (|sayMSG|
      (|formatModemap| (|old2NewModemaps| (|displayTranModemap| |m|)))))))

; sayModemapWithNumber(m,n) ==
;   msg := reverse cleanUpSegmentedMsg reverse ["%i","%i",'" ",
;     STRCONC(lbrkSch(),object2String n,rbrkSch()),
;       :formatModemap displayTranModemap m,"%u","%u"]
;   sayMSG flowSegmentedMsg(reverse msg,$LINELENGTH,3)

(DEFUN |sayModemapWithNumber| (|m| |n|)
  (PROG (|msg|)
    (RETURN
     (PROGN
      (SETQ |msg|
              (REVERSE
               (|cleanUpSegmentedMsg|
                (REVERSE
                 (CONS '|%i|
                       (CONS '|%i|
                             (CONS " "
                                   (CONS
                                    (STRCONC (|lbrkSch|) (|object2String| |n|)
                                     (|rbrkSch|))
                                    (APPEND
                                     (|formatModemap|
                                      (|displayTranModemap| |m|))
                                     (CONS '|%u| (CONS '|%u| NIL)))))))))))
      (|sayMSG| (|flowSegmentedMsg| (REVERSE |msg|) $LINELENGTH 3))))))

; displayOpModemaps(op,modemaps) ==
;   TERPRI()
;   count:= #modemaps
;   phrase:= (count=1 => 'modemap;'modemaps)
;   sayMSG ['%b,count,'%d,phrase,'" for",'%b,op,'%d,'":"]
;   for modemap in modemaps repeat sayModemap modemap

(DEFUN |displayOpModemaps| (|op| |modemaps|)
  (PROG (|count| |phrase|)
    (RETURN
     (PROGN
      (TERPRI)
      (SETQ |count| (LENGTH |modemaps|))
      (SETQ |phrase| (COND ((EQL |count| 1) '|modemap|) (#1='T '|modemaps|)))
      (|sayMSG|
       (LIST '|%b| |count| '|%d| |phrase| " for" '|%b| |op| '|%d| ":"))
      ((LAMBDA (|bfVar#1| |modemap|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#1|) (PROGN (SETQ |modemap| (CAR |bfVar#1|)) NIL))
            (RETURN NIL))
           (#1# (|sayModemap| |modemap|)))
          (SETQ |bfVar#1| (CDR |bfVar#1|))))
       |modemaps| NIL)))))

; displayTranModemap (mm is [[x,:sig],[pred,:y],:z]) ==
;   -- The next 8 lines are a HACK to deal with the "partial" definition
;   -- JHD/RSS
;   if pred is ['partial,:pred'] then
;     [b,:c]:=sig
;     sig:=[['Union,b,'"failed"],:c]
;     mm:=[[x,:sig],[pred',:y],:z]
;   else if pred = 'partial then
;     [b,:c]:=sig
;     sig:=[['Union,b,'"failed"],:c]
;     mm:=[[x,:sig],y,:z]
;   mm' := EQSUBSTLIST('(m n p q r s t i j k l),
;     MSORT listOfPredOfTypePatternIds pred,mm)
;   EQSUBSTLIST('(D D1 D2 D3 D4 D5 D6 D7 D8 D9 D10 D11 D12 D13 D14),
;     MSORT listOfPatternIds [sig,[pred,:y]],mm')

(DEFUN |displayTranModemap| (|mm|)
  (PROG (|x| |sig| |pred| |y| |z| |pred'| |b| |c| |mm'|)
    (RETURN
     (PROGN
      (SETQ |x| (CAAR . #1=(|mm|)))
      (SETQ |sig| (CDAR . #1#))
      (SETQ |pred| (CAADR . #2=(|mm|)))
      (SETQ |y| (CDADR . #2#))
      (SETQ |z| (CDDR . #2#))
      (COND
       ((AND (CONSP |pred|) (EQ (CAR |pred|) '|partial|)
             (PROGN (SETQ |pred'| (CDR |pred|)) 'T))
        (SETQ |b| (CAR |sig|)) (SETQ |c| (CDR |sig|))
        (SETQ |sig| (CONS (LIST '|Union| |b| "failed") |c|))
        (SETQ |mm| (CONS (CONS |x| |sig|) (CONS (CONS |pred'| |y|) |z|))))
       ((EQ |pred| '|partial|) (SETQ |b| (CAR |sig|)) (SETQ |c| (CDR |sig|))
        (SETQ |sig| (CONS (LIST '|Union| |b| "failed") |c|))
        (SETQ |mm| (CONS (CONS |x| |sig|) (CONS |y| |z|)))))
      (SETQ |mm'|
              (EQSUBSTLIST '(|m| |n| |p| |q| |r| |s| |t| |i| |j| |k| |l|)
               (MSORT (|listOfPredOfTypePatternIds| |pred|)) |mm|))
      (EQSUBSTLIST '(D D1 D2 D3 D4 D5 D6 D7 D8 D9 D10 D11 D12 D13 D14)
       (MSORT (|listOfPatternIds| (LIST |sig| (CONS |pred| |y|)))) |mm'|)))))

; listOfPredOfTypePatternIds p ==
;   p is ['AND,:lp] or p is ['OR,:lp] =>
;     UNIONQ([:listOfPredOfTypePatternIds p1 for p1 in lp],NIL)
;   p is [op,a,.] and op = 'ofType =>
;     isPatternVar a => [a]
;     nil
;   nil

(DEFUN |listOfPredOfTypePatternIds| (|p|)
  (PROG (|lp| |op| |ISTMP#1| |a| |ISTMP#2|)
    (RETURN
     (COND
      ((OR
        (AND (CONSP |p|) (EQ (CAR |p|) 'AND)
             (PROGN (SETQ |lp| (CDR |p|)) #1='T))
        (AND (CONSP |p|) (EQ (CAR |p|) 'OR) (PROGN (SETQ |lp| (CDR |p|)) #1#)))
       (UNIONQ
        ((LAMBDA (|bfVar#3| |bfVar#2| |p1|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#2|) (PROGN (SETQ |p1| (CAR |bfVar#2|)) NIL))
              (RETURN (NREVERSE |bfVar#3|)))
             (#1#
              (SETQ |bfVar#3|
                      (APPEND (REVERSE (|listOfPredOfTypePatternIds| |p1|))
                              |bfVar#3|))))
            (SETQ |bfVar#2| (CDR |bfVar#2|))))
         NIL |lp| NIL)
        NIL))
      ((AND (CONSP |p|)
            (PROGN
             (SETQ |op| (CAR |p|))
             (SETQ |ISTMP#1| (CDR |p|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |a| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)))))
            (EQ |op| '|ofType|))
       (COND ((|isPatternVar| |a|) (LIST |a|)) (#1# NIL)))
      (#1# NIL)))))

; removeIsDomains pred ==
;   pred is ['isDomain,a,b] => true
;   pred is ['AND,:predl] =>
;     MKPF([x for x in predl | x isnt ['isDomain,:.]],'AND)
;   pred

(DEFUN |removeIsDomains| (|pred|)
  (PROG (|ISTMP#1| |a| |ISTMP#2| |b| |predl|)
    (RETURN
     (COND
      ((AND (CONSP |pred|) (EQ (CAR |pred|) '|isDomain|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |pred|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |a| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1='T))))))
       T)
      ((AND (CONSP |pred|) (EQ (CAR |pred|) 'AND)
            (PROGN (SETQ |predl| (CDR |pred|)) #1#))
       (MKPF
        ((LAMBDA (|bfVar#5| |bfVar#4| |x|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#4|) (PROGN (SETQ |x| (CAR |bfVar#4|)) NIL))
              (RETURN (NREVERSE |bfVar#5|)))
             (#1#
              (AND (NOT (AND (CONSP |x|) (EQ (CAR |x|) '|isDomain|)))
                   (SETQ |bfVar#5| (CONS |x| |bfVar#5|)))))
            (SETQ |bfVar#4| (CDR |bfVar#4|))))
         NIL |predl| NIL)
        'AND))
      (#1# |pred|)))))

; canRemoveIsDomain? pred ==
;   -- returns nil OR an alist for substitutions of domains ordered so that
;   -- after substituting for each pair in turn, no left-hand names remain
;   alist :=
;     pred is ['isDomain,a,b] => [[a,:b],:alist]
;     pred is ['AND,:predl] =>
;       [[a,:b] for pred in predl | pred is ['isDomain,a,b]]
;   findSubstitutionOrder? alist

(DEFUN |canRemoveIsDomain?| (|pred|)
  (PROG (|ISTMP#1| |a| |ISTMP#2| |b| |predl| |alist|)
    (RETURN
     (PROGN
      (SETQ |alist|
              (COND
               ((AND (CONSP |pred|) (EQ (CAR |pred|) '|isDomain|)
                     (PROGN
                      (SETQ |ISTMP#1| (CDR |pred|))
                      (AND (CONSP |ISTMP#1|)
                           (PROGN
                            (SETQ |a| (CAR |ISTMP#1|))
                            (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                            (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                 (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1='T))))))
                (CONS (CONS |a| |b|) |alist|))
               ((AND (CONSP |pred|) (EQ (CAR |pred|) 'AND)
                     (PROGN (SETQ |predl| (CDR |pred|)) #1#))
                ((LAMBDA (|bfVar#7| |bfVar#6| |pred|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#6|)
                          (PROGN (SETQ |pred| (CAR |bfVar#6|)) NIL))
                      (RETURN (NREVERSE |bfVar#7|)))
                     (#1#
                      (AND (CONSP |pred|) (EQ (CAR |pred|) '|isDomain|)
                           (PROGN
                            (SETQ |ISTMP#1| (CDR |pred|))
                            (AND (CONSP |ISTMP#1|)
                                 (PROGN
                                  (SETQ |a| (CAR |ISTMP#1|))
                                  (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                  (AND (CONSP |ISTMP#2|)
                                       (EQ (CDR |ISTMP#2|) NIL)
                                       (PROGN
                                        (SETQ |b| (CAR |ISTMP#2|))
                                        #1#)))))
                           (SETQ |bfVar#7| (CONS (CONS |a| |b|) |bfVar#7|)))))
                    (SETQ |bfVar#6| (CDR |bfVar#6|))))
                 NIL |predl| NIL))))
      (|findSubstitutionOrder?| |alist|)))))

; findSubstitutionOrder? alist == fn(alist,nil) where
;   -- returns NIL or an appropriate substitution order
;   fn(alist,res) ==
;     null alist => NREVERSE res
;     choice := or/[x for (x:=[a,:b]) in alist | null containedRight(a,alist)] =>
;       fn(delete(choice,alist),[choice,:res])
;     nil

(DEFUN |findSubstitutionOrder?| (|alist|)
  (PROG () (RETURN (|findSubstitutionOrder?,fn| |alist| NIL))))
(DEFUN |findSubstitutionOrder?,fn| (|alist| |res|)
  (PROG (|a| |b| |choice|)
    (RETURN
     (COND ((NULL |alist|) (NREVERSE |res|))
           ((SETQ |choice|
                    ((LAMBDA (|bfVar#9| |bfVar#8| |x|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#8|)
                              (PROGN (SETQ |x| (CAR |bfVar#8|)) NIL))
                          (RETURN |bfVar#9|))
                         (#1='T
                          (AND (CONSP |x|)
                               (PROGN
                                (SETQ |a| (CAR |x|))
                                (SETQ |b| (CDR |x|))
                                #1#)
                               (NULL (|containedRight| |a| |alist|))
                               (PROGN
                                (SETQ |bfVar#9| |x|)
                                (COND (|bfVar#9| (RETURN |bfVar#9|)))))))
                        (SETQ |bfVar#8| (CDR |bfVar#8|))))
                     NIL |alist| NIL))
            (|findSubstitutionOrder?,fn| (|delete| |choice| |alist|)
             (CONS |choice| |res|)))
           (#1# NIL)))))

; containedRight(x,alist)== or/[CONTAINED(x,y) for [.,:y] in alist]

(DEFUN |containedRight| (|x| |alist|)
  (PROG (|y|)
    (RETURN
     ((LAMBDA (|bfVar#12| |bfVar#11| |bfVar#10|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#11|)
               (PROGN (SETQ |bfVar#10| (CAR |bfVar#11|)) NIL))
           (RETURN |bfVar#12|))
          (#1='T
           (AND (CONSP |bfVar#10|) (PROGN (SETQ |y| (CDR |bfVar#10|)) #1#)
                (PROGN
                 (SETQ |bfVar#12| (CONTAINED |x| |y|))
                 (COND (|bfVar#12| (RETURN |bfVar#12|)))))))
         (SETQ |bfVar#11| (CDR |bfVar#11|))))
      NIL |alist| NIL))))

; DEFPARAMETER($Dmarker, "<Dmarker>")

(DEFPARAMETER |$Dmarker| '|<Dmarker>|)

; removeIsDomainD pred ==
;   pred is ['isDomain, =$Dmarker, D] =>
;     [D,nil]
;   pred is ['AND,:preds] =>
;     D := nil
;     for p in preds while not D repeat
;       p is ['isDomain, =$Dmarker, D1] =>
;         D := D1
;         npreds := delete(['isDomain, $Dmarker, D1], preds)
;     D =>
;       1 = #npreds => [D,first npreds]
;       [D,['AND,:npreds]]
;     nil
;   nil

(DEFUN |removeIsDomainD| (|pred|)
  (PROG (|ISTMP#1| |ISTMP#2| D |preds| D1 |npreds|)
    (RETURN
     (COND
      ((AND (CONSP |pred|) (EQ (CAR |pred|) '|isDomain|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |pred|))
             (AND (CONSP |ISTMP#1|) (EQUAL (CAR |ISTMP#1|) |$Dmarker|)
                  (PROGN
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ D (CAR |ISTMP#2|)) #1='T))))))
       (LIST D NIL))
      ((AND (CONSP |pred|) (EQ (CAR |pred|) 'AND)
            (PROGN (SETQ |preds| (CDR |pred|)) #1#))
       (PROGN
        (SETQ D NIL)
        ((LAMBDA (|bfVar#13| |p|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#13|) (PROGN (SETQ |p| (CAR |bfVar#13|)) NIL) D)
              (RETURN NIL))
             (#1#
              (COND
               ((AND (CONSP |p|) (EQ (CAR |p|) '|isDomain|)
                     (PROGN
                      (SETQ |ISTMP#1| (CDR |p|))
                      (AND (CONSP |ISTMP#1|) (EQUAL (CAR |ISTMP#1|) |$Dmarker|)
                           (PROGN
                            (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                            (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                 (PROGN (SETQ D1 (CAR |ISTMP#2|)) #1#))))))
                (IDENTITY
                 (PROGN
                  (SETQ D D1)
                  (SETQ |npreds|
                          (|delete| (LIST '|isDomain| |$Dmarker| D1)
                           |preds|))))))))
            (SETQ |bfVar#13| (CDR |bfVar#13|))))
         |preds| NIL)
        (COND
         (D
          (COND ((EQL 1 (LENGTH |npreds|)) (LIST D (CAR |npreds|)))
                (#1# (LIST D (CONS 'AND |npreds|)))))
         (#1# NIL))))
      (#1# NIL)))))

; formatModemap modemap ==
;   [[dc,target,:sl],pred,:.]:= modemap
;   if alist := canRemoveIsDomain? pred then
;     dc:= substInOrder(alist,dc)
;     pred:= substInOrder(alist,removeIsDomains pred)
;     target:= substInOrder(alist,target)
;     sl:= substInOrder(alist,sl)
;   else if removeIsDomainD pred is [D,npred] then
;     pred := SUBST(D, $Dmarker, npred)
;     target := SUBST(D, $Dmarker, target)
;     sl := SUBST(D, $Dmarker, sl)
;   predPart:= formatIf pred
;   targetPart:= prefix2String target
;   argTypeList:=
;     null sl => nil
;     concat(prefix2String first sl,fn(rest sl)) where
;       fn l ==
;         null l => nil
;         concat(",",prefix2String first l,fn rest l)
;   argPart:=
;     #sl<2 => argTypeList
;     ['"_(",:argTypeList,'"_)"]
;   fromPart:=
;     if dc = $Dmarker and D
;       then concat('%b,'"from",'%d,prefix2String D)
;       else concat('%b,'"from",'%d,prefix2String dc)
;   firstPart:= concat('" ",argPart,'" -> ",targetPart)
;   sayWidth firstPart + sayWidth fromPart > 74 => --allow 5 spaces for " [n]"
;     fromPart:= concat('" ",fromPart)
;     secondPart :=
;       sayWidth fromPart + sayWidth predPart < 75 =>
;         concat(fromPart,predPart)
;       concat(fromPart,'%l,predPart)
;     concat(firstPart,'%l,secondPart)
;   firstPart:= concat(firstPart,fromPart)
;   sayWidth firstPart + sayWidth predPart < 80 =>
;     concat(firstPart,predPart)
;   concat(firstPart,'%l,predPart)

(DEFUN |formatModemap| (|modemap|)
  (PROG (|dc| |target| |sl| |pred| |alist| |ISTMP#1| D |ISTMP#2| |npred|
         |predPart| |targetPart| |argTypeList| |argPart| |fromPart| |firstPart|
         |secondPart|)
    (RETURN
     (PROGN
      (SETQ |dc| (CAAR . #1=(|modemap|)))
      (SETQ |target| (CADAR . #1#))
      (SETQ |sl| (CDDAR . #1#))
      (SETQ |pred| (CADR |modemap|))
      (COND
       ((SETQ |alist| (|canRemoveIsDomain?| |pred|))
        (SETQ |dc| (|substInOrder| |alist| |dc|))
        (SETQ |pred| (|substInOrder| |alist| (|removeIsDomains| |pred|)))
        (SETQ |target| (|substInOrder| |alist| |target|))
        (SETQ |sl| (|substInOrder| |alist| |sl|)))
       ((PROGN
         (SETQ |ISTMP#1| (|removeIsDomainD| |pred|))
         (AND (CONSP |ISTMP#1|)
              (PROGN
               (SETQ D (CAR |ISTMP#1|))
               (SETQ |ISTMP#2| (CDR |ISTMP#1|))
               (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                    (PROGN (SETQ |npred| (CAR |ISTMP#2|)) #2='T)))))
        (SETQ |pred| (SUBST D |$Dmarker| |npred|))
        (SETQ |target| (SUBST D |$Dmarker| |target|))
        (SETQ |sl| (SUBST D |$Dmarker| |sl|))))
      (SETQ |predPart| (|formatIf| |pred|))
      (SETQ |targetPart| (|prefix2String| |target|))
      (SETQ |argTypeList|
              (COND ((NULL |sl|) NIL)
                    (#2#
                     (|concat| (|prefix2String| (CAR |sl|))
                      (|formatModemap,fn| (CDR |sl|))))))
      (SETQ |argPart|
              (COND ((< (LENGTH |sl|) 2) |argTypeList|)
                    (#2# (CONS "(" (APPEND |argTypeList| (CONS ")" NIL))))))
      (SETQ |fromPart|
              (COND
               ((AND (EQUAL |dc| |$Dmarker|) D)
                (|concat| '|%b| "from" '|%d| (|prefix2String| D)))
               (#2# (|concat| '|%b| "from" '|%d| (|prefix2String| |dc|)))))
      (SETQ |firstPart| (|concat| " " |argPart| " -> " |targetPart|))
      (COND
       ((< 74 (+ (|sayWidth| |firstPart|) (|sayWidth| |fromPart|)))
        (PROGN
         (SETQ |fromPart| (|concat| " " |fromPart|))
         (SETQ |secondPart|
                 (COND
                  ((< (+ (|sayWidth| |fromPart|) (|sayWidth| |predPart|)) 75)
                   (|concat| |fromPart| |predPart|))
                  (#2# (|concat| |fromPart| '|%l| |predPart|))))
         (|concat| |firstPart| '|%l| |secondPart|)))
       (#2#
        (PROGN
         (SETQ |firstPart| (|concat| |firstPart| |fromPart|))
         (COND
          ((< (+ (|sayWidth| |firstPart|) (|sayWidth| |predPart|)) 80)
           (|concat| |firstPart| |predPart|))
          (#2# (|concat| |firstPart| '|%l| |predPart|))))))))))
(DEFUN |formatModemap,fn| (|l|)
  (PROG ()
    (RETURN
     (COND ((NULL |l|) NIL)
           ('T
            (|concat| '|,| (|prefix2String| (CAR |l|))
             (|formatModemap,fn| (CDR |l|))))))))

; substInOrder(alist,x) ==
;   alist is [[a, :b], :y] => substInOrder(y, substitute(b, a, x))
;   x

(DEFUN |substInOrder| (|alist| |x|)
  (PROG (|ISTMP#1| |a| |b| |y|)
    (RETURN
     (COND
      ((AND (CONSP |alist|)
            (PROGN
             (SETQ |ISTMP#1| (CAR |alist|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |a| (CAR |ISTMP#1|))
                   (SETQ |b| (CDR |ISTMP#1|))
                   #1='T)))
            (PROGN (SETQ |y| (CDR |alist|)) #1#))
       (|substInOrder| |y| (|substitute| |b| |a| |x|)))
      (#1# |x|)))))

; sayMms(op, mms, label) ==
;     m := # mms
;     sayMSG
;         m = 1 =>
;             ['"There is one", :bright label, '"function called",
;               :bright op, '":"]
;         ['"There are ", m, :bright label, '"functions called",
;             :bright op, '":"]
;     for mm in mms for i in 1.. repeat
;         sayModemapWithNumber(mm, i)

(DEFUN |sayMms| (|op| |mms| |label|)
  (PROG (|m|)
    (RETURN
     (PROGN
      (SETQ |m| (LENGTH |mms|))
      (|sayMSG|
       (COND
        ((EQL |m| 1)
         (CONS "There is one"
               (APPEND (|bright| |label|)
                       (CONS "function called"
                             (APPEND (|bright| |op|) (CONS ":" NIL))))))
        (#1='T
         (CONS "There are "
               (CONS |m|
                     (APPEND (|bright| |label|)
                             (CONS "functions called"
                                   (APPEND (|bright| |op|)
                                           (CONS ":" NIL)))))))))
      ((LAMBDA (|bfVar#14| |mm| |i|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#14|) (PROGN (SETQ |mm| (CAR |bfVar#14|)) NIL))
            (RETURN NIL))
           (#1# (|sayModemapWithNumber| |mm| |i|)))
          (SETQ |bfVar#14| (CDR |bfVar#14|))
          (SETQ |i| (+ |i| 1))))
       |mms| NIL 1)))))

; reportOpSymbol op1 ==
;   op := (STRINGP op1 => INTERN op1; op1)
;   modemaps := getAllModemapsFromDatabase(op,nil)
;   null modemaps =>
;     ok := true
;     sayKeyedMsg("S2IF0010",[op1])
;     if SIZE PNAME op1 < 3 then
;       x := UPCASE queryUserKeyedMsg("S2IZ0060",[op1])
;       null MEMQ(STRING2ID_N(x, 1),'(Y YES)) =>
;         ok := nil
;         sayKeyedMsg("S2IZ0061",[op1])
;     ok => apropos [op1]
;   sayNewLine()
;   -- filter modemaps on whether they are exposed
;   mmsE := mmsU := NIL
;   for mm in modemaps repeat
;     isFreeFunctionFromMm(mm) or isExposedConstructor getDomainFromMm(mm) => mmsE := [mm,:mmsE]
;     mmsU := [mm,:mmsU]
;   if mmsE then
;     sayMms(op, mmsE, '"exposed")
;   if mmsU then
;     if mmsE then sayNewLine()
;     sayMms(op,mmsU,'"unexposed")
;   nil

(DEFUN |reportOpSymbol| (|op1|)
  (PROG (|op| |modemaps| |ok| |x| |mmsU| |mmsE|)
    (RETURN
     (PROGN
      (SETQ |op| (COND ((STRINGP |op1|) (INTERN |op1|)) (#1='T |op1|)))
      (SETQ |modemaps| (|getAllModemapsFromDatabase| |op| NIL))
      (COND
       ((NULL |modemaps|)
        (PROGN
         (SETQ |ok| T)
         (|sayKeyedMsg| 'S2IF0010 (LIST |op1|))
         (COND
          ((< (SIZE (PNAME |op1|)) 3)
           (SETQ |x| (UPCASE (|queryUserKeyedMsg| 'S2IZ0060 (LIST |op1|))))
           (COND
            ((NULL (MEMQ (STRING2ID_N |x| 1) '(Y YES)))
             (PROGN (SETQ |ok| NIL) (|sayKeyedMsg| 'S2IZ0061 (LIST |op1|)))))))
         (COND (|ok| (|apropos| (LIST |op1|))))))
       (#1#
        (PROGN
         (|sayNewLine|)
         (SETQ |mmsE| (SETQ |mmsU| NIL))
         ((LAMBDA (|bfVar#15| |mm|)
            (LOOP
             (COND
              ((OR (ATOM |bfVar#15|) (PROGN (SETQ |mm| (CAR |bfVar#15|)) NIL))
               (RETURN NIL))
              (#1#
               (COND
                ((OR (|isFreeFunctionFromMm| |mm|)
                     (|isExposedConstructor| (|getDomainFromMm| |mm|)))
                 (SETQ |mmsE| (CONS |mm| |mmsE|)))
                (#1# (SETQ |mmsU| (CONS |mm| |mmsU|))))))
             (SETQ |bfVar#15| (CDR |bfVar#15|))))
          |modemaps| NIL)
         (COND (|mmsE| (|sayMms| |op| |mmsE| "exposed")))
         (COND
          (|mmsU| (COND (|mmsE| (|sayNewLine|)))
           (|sayMms| |op| |mmsU| "unexposed")))
         NIL)))))))

; formatOpType (form:=[op,:argl]) ==
;   null argl => unabbrev op
;   form2String [unabbrev op, :argl]

(DEFUN |formatOpType| (|form|)
  (PROG (|op| |argl|)
    (RETURN
     (PROGN
      (SETQ |op| (CAR |form|))
      (SETQ |argl| (CDR |form|))
      (COND ((NULL |argl|) (|unabbrev| |op|))
            ('T (|form2String| (CONS (|unabbrev| |op|) |argl|))))))))

; formatOperationAlistEntry (entry:= [op,:modemaps]) ==
;   -- alist has entries of the form: ((op sig) . pred)
;   -- opsig on this list => op is defined only when the predicate is true
;   ans:= nil
;   for [sig,.,:predtail] in modemaps repeat
;     pred := (predtail is [p,:.] => p; 'T)
;     -- operation is always defined
;     ans :=
;       [concat(formatOpSignature(op,sig),formatIf pred),:ans]
;   ans

(DEFUN |formatOperationAlistEntry| (|entry|)
  (PROG (|op| |modemaps| |ans| |sig| |ISTMP#1| |predtail| |p| |pred|)
    (RETURN
     (PROGN
      (SETQ |op| (CAR |entry|))
      (SETQ |modemaps| (CDR |entry|))
      (SETQ |ans| NIL)
      ((LAMBDA (|bfVar#17| |bfVar#16|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#17|)
                (PROGN (SETQ |bfVar#16| (CAR |bfVar#17|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#16|)
                 (PROGN
                  (SETQ |sig| (CAR |bfVar#16|))
                  (SETQ |ISTMP#1| (CDR |bfVar#16|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN (SETQ |predtail| (CDR |ISTMP#1|)) #1#)))
                 (PROGN
                  (SETQ |pred|
                          (COND
                           ((AND (CONSP |predtail|)
                                 (PROGN (SETQ |p| (CAR |predtail|)) #1#))
                            |p|)
                           (#1# 'T)))
                  (SETQ |ans|
                          (CONS
                           (|concat| (|formatOpSignature| |op| |sig|)
                            (|formatIf| |pred|))
                           |ans|))))))
          (SETQ |bfVar#17| (CDR |bfVar#17|))))
       |modemaps| NIL)
      |ans|))))

; formatOperation([[op, sig], :.]) ==
;     formatOpSignature(op,sig)

(DEFUN |formatOperation| (|bfVar#18|)
  (PROG (|op| |sig|)
    (RETURN
     (PROGN
      (SETQ |op| (CAAR . #1=(|bfVar#18|)))
      (SETQ |sig| (CADAR . #1#))
      (|formatOpSignature| |op| |sig|)))))

; formatOperationWithPred([[op,sig],pred,.]) ==
;     concat(formatOpSignature(op, sig), formatIf pred)

(DEFUN |formatOperationWithPred| (|bfVar#19|)
  (PROG (|op| |sig| |pred|)
    (RETURN
     (PROGN
      (SETQ |op| (CAAR . #1=(|bfVar#19|)))
      (SETQ |sig| (CADAR . #1#))
      (SETQ |pred| (CADR |bfVar#19|))
      (|concat| (|formatOpSignature| |op| |sig|) (|formatIf| |pred|))))))

; formatOpSignature(op,sig) ==
;   concat('%b,formatOpSymbol(op,sig),'%d,": ",formatSignature sig)

(DEFUN |formatOpSignature| (|op| |sig|)
  (PROG ()
    (RETURN
     (|concat| '|%b| (|formatOpSymbol| |op| |sig|) '|%d| '|: |
      (|formatSignature| |sig|)))))

; formatOpConstant op ==
;   concat('%b,formatOpSymbol(op,'($)),'%d,'": constant")

(DEFUN |formatOpConstant| (|op|)
  (PROG ()
    (RETURN (|concat| '|%b| (|formatOpSymbol| |op| '($)) '|%d| ": constant"))))

; formatOpSymbol(op,sig) ==
;   if op = 'Zero then op := "0"
;   else if op = 'One then op := "1"
;   null sig => op
;   quad := specialChar 'quad
;   n := #sig
;   (op = 'elt) and (n = 3) =>
;     (CADR(sig) = '_$) =>
;       STRINGP (sel := CADDR(sig)) =>
;         [quad,".",sel]
;       [quad,".",quad]
;     op
;   STRINGP op or GETL(op,"Led") or GETL(op,"Nud") =>
;     n = 3 =>
;       if op = 'SEGMENT then op := '".."
;       op = "in" => [quad, '" ", op, '" ", quad]
; -- stop exquo from being displayed as infix (since it is not accepted
; -- as such by the interpreter)
;       op = 'exquo => op
;       [quad,op,quad]
;     n = 2 =>
;       not GETL(op,"Nud") => [quad,op]
;       [op,quad]
;     op
;   op

(DEFUN |formatOpSymbol| (|op| |sig|)
  (PROG (|quad| |n| |sel|)
    (RETURN
     (PROGN
      (COND ((EQ |op| '|Zero|) (SETQ |op| '|0|))
            ((EQ |op| '|One|) (SETQ |op| '|1|)))
      (COND ((NULL |sig|) |op|)
            (#1='T
             (PROGN
              (SETQ |quad| (|specialChar| '|quad|))
              (SETQ |n| (LENGTH |sig|))
              (COND
               ((AND (EQ |op| '|elt|) (EQL |n| 3))
                (COND
                 ((EQ (CADR |sig|) '$)
                  (COND
                   ((STRINGP (SETQ |sel| (CADDR |sig|)))
                    (LIST |quad| '|.| |sel|))
                   (#1# (LIST |quad| '|.| |quad|))))
                 (#1# |op|)))
               ((OR (STRINGP |op|) (GETL |op| '|Led|) (GETL |op| '|Nud|))
                (COND
                 ((EQL |n| 3)
                  (PROGN
                   (COND ((EQ |op| 'SEGMENT) (SETQ |op| "..")))
                   (COND ((EQ |op| '|in|) (LIST |quad| " " |op| " " |quad|))
                         ((EQ |op| '|exquo|) |op|)
                         (#1# (LIST |quad| |op| |quad|)))))
                 ((EQL |n| 2)
                  (COND ((NULL (GETL |op| '|Nud|)) (LIST |quad| |op|))
                        (#1# (LIST |op| |quad|))))
                 (#1# |op|)))
               (#1# |op|)))))))))

; dollarPercentTran x ==
;     -- Translate $ to %. We actually return %% so that the message
;     -- printer will display a single %
;     x is [y,:z] =>
;         y1 := dollarPercentTran y
;         z1 := dollarPercentTran z
;         EQ(y, y1) and EQ(z, z1) => x
;         [y1, :z1]
;     x = "$" or x = '"$" => "%%"
;     x

(DEFUN |dollarPercentTran| (|x|)
  (PROG (|y| |z| |y1| |z1|)
    (RETURN
     (COND
      ((AND (CONSP |x|)
            (PROGN (SETQ |y| (CAR |x|)) (SETQ |z| (CDR |x|)) #1='T))
       (PROGN
        (SETQ |y1| (|dollarPercentTran| |y|))
        (SETQ |z1| (|dollarPercentTran| |z|))
        (COND ((AND (EQ |y| |y1|) (EQ |z| |z1|)) |x|) (#1# (CONS |y1| |z1|)))))
      ((OR (EQ |x| '$) (EQUAL |x| "$")) '%%) (#1# |x|)))))

; formatSignature sig ==
;   formatSignature0 sig

(DEFUN |formatSignature| (|sig|) (PROG () (RETURN (|formatSignature0| |sig|))))

; formatSignatureArgs sml ==
;   formatSignatureArgs0 sml

(DEFUN |formatSignatureArgs| (|sml|)
  (PROG () (RETURN (|formatSignatureArgs0| |sml|))))

; formatSignature0 sig ==
;   null sig => "() -> ()"
;   INTEGERP sig => '"hashcode"
;   [tm,:sml] := sig
;   sourcePart:= formatSignatureArgs0 sml
;   targetPart:= prefix2String0 tm
;   dollarPercentTran concat(sourcePart,concat(" -> ",targetPart))

(DEFUN |formatSignature0| (|sig|)
  (PROG (|tm| |sml| |sourcePart| |targetPart|)
    (RETURN
     (COND ((NULL |sig|) '|() -> ()|) ((INTEGERP |sig|) "hashcode")
           ('T
            (PROGN
             (SETQ |tm| (CAR |sig|))
             (SETQ |sml| (CDR |sig|))
             (SETQ |sourcePart| (|formatSignatureArgs0| |sml|))
             (SETQ |targetPart| (|prefix2String0| |tm|))
             (|dollarPercentTran|
              (|concat| |sourcePart| (|concat| '| -> | |targetPart|)))))))))

; formatSignatureArgs0(sml) ==
; -- formats the arguments of a signature
;   null sml => ["_(_)"]
;   null rest sml => prefix2String0 first sml
;   argList:= prefix2String0 first sml
;   for m in rest sml repeat
;     argList:= concat(argList,concat(", ",prefix2String0 m))
;   concat("_(",concat(argList,"_)"))

(DEFUN |formatSignatureArgs0| (|sml|)
  (PROG (|argList|)
    (RETURN
     (COND ((NULL |sml|) (LIST '|()|))
           ((NULL (CDR |sml|)) (|prefix2String0| (CAR |sml|)))
           (#1='T
            (PROGN
             (SETQ |argList| (|prefix2String0| (CAR |sml|)))
             ((LAMBDA (|bfVar#20| |m|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#20|)
                       (PROGN (SETQ |m| (CAR |bfVar#20|)) NIL))
                   (RETURN NIL))
                  (#1#
                   (SETQ |argList|
                           (|concat| |argList|
                            (|concat| '|, | (|prefix2String0| |m|))))))
                 (SETQ |bfVar#20| (CDR |bfVar#20|))))
              (CDR |sml|) NIL)
             (|concat| '|(| (|concat| |argList| '|)|))))))))

; expr2String x ==
;   atom (u:= prefix2String0 x) => u
;   "STRCONC"/[atom2String y for y in u]

(DEFUN |expr2String| (|x|)
  (PROG (|u|)
    (RETURN
     (COND ((ATOM (SETQ |u| (|prefix2String0| |x|))) |u|)
           (#1='T
            ((LAMBDA (|bfVar#22| |bfVar#21| |y|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#21|)
                      (PROGN (SETQ |y| (CAR |bfVar#21|)) NIL))
                  (RETURN |bfVar#22|))
                 (#1#
                  (SETQ |bfVar#22| (STRCONC |bfVar#22| (|atom2String| |y|)))))
                (SETQ |bfVar#21| (CDR |bfVar#21|))))
             "" |u| NIL))))))

; prefix2String form ==
;   form2StringLocal form

(DEFUN |prefix2String| (|form|) (PROG () (RETURN (|form2StringLocal| |form|))))

; prefix2String0 form ==
;   form2StringLocal form

(DEFUN |prefix2String0| (|form|) (PROG () (RETURN (|form2StringLocal| |form|))))

; form2StringWithWhere u ==
;   $permitWhere : local := true
;   $whereList: local := nil
;   s:= form2String u
;   $whereList => concat(s,'%b,'"where",'%d,"%i",$whereList,"%u")
;   s

(DEFUN |form2StringWithWhere| (|u|)
  (PROG (|$whereList| |$permitWhere| |s|)
    (DECLARE (SPECIAL |$whereList| |$permitWhere|))
    (RETURN
     (PROGN
      (SETQ |$permitWhere| T)
      (SETQ |$whereList| NIL)
      (SETQ |s| (|form2String| |u|))
      (COND
       (|$whereList|
        (|concat| |s| '|%b| "where" '|%d| '|%i| |$whereList| '|%u|))
       ('T |s|))))))

; form2StringWithPrens form ==
;   null (argl := rest form) => [first form]
;   null rest argl => [first form,"(",first argl,")"]
;   form2String form

(DEFUN |form2StringWithPrens| (|form|)
  (PROG (|argl|)
    (RETURN
     (COND ((NULL (SETQ |argl| (CDR |form|))) (LIST (CAR |form|)))
           ((NULL (CDR |argl|)) (LIST (CAR |form|) '|(| (CAR |argl|) '|)|))
           ('T (|form2String| |form|))))))

; formString u ==
;   x := form2String u
;   atom x => STRINGIMAGE x
;   "STRCONC"/[STRINGIMAGE y for y in x]

(DEFUN |formString| (|u|)
  (PROG (|x|)
    (RETURN
     (PROGN
      (SETQ |x| (|form2String| |u|))
      (COND ((ATOM |x|) (STRINGIMAGE |x|))
            (#1='T
             ((LAMBDA (|bfVar#24| |bfVar#23| |y|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#23|)
                       (PROGN (SETQ |y| (CAR |bfVar#23|)) NIL))
                   (RETURN |bfVar#24|))
                  (#1#
                   (SETQ |bfVar#24| (STRCONC |bfVar#24| (STRINGIMAGE |y|)))))
                 (SETQ |bfVar#23| (CDR |bfVar#23|))))
              "" |x| NIL)))))))

; DEFPARAMETER($from_unparse, false)

(DEFPARAMETER |$from_unparse| NIL)

; unparseInputForm u ==
;   $InteractiveMode: local := false
;   $from_unparse : local := true
;   form2StringLocal u

(DEFUN |unparseInputForm| (|u|)
  (PROG (|$from_unparse| |$InteractiveMode|)
    (DECLARE (SPECIAL |$from_unparse| |$InteractiveMode|))
    (RETURN
     (PROGN
      (SETQ |$InteractiveMode| NIL)
      (SETQ |$from_unparse| T)
      (|form2StringLocal| |u|)))))

; form2String u ==
;   form2StringLocal u

(DEFUN |form2String| (|u|) (PROG () (RETURN (|form2StringLocal| |u|))))

; form2StringLocal u ==
;   $NRTmonitorIfTrue : local := nil
;   form2String1 u

(DEFUN |form2StringLocal| (|u|)
  (PROG (|$NRTmonitorIfTrue|)
    (DECLARE (SPECIAL |$NRTmonitorIfTrue|))
    (RETURN (PROGN (SETQ |$NRTmonitorIfTrue| NIL) (|form2String1| |u|)))))

; constructorName con ==
;   $abbreviateTypes => abbreviate con
;   con

(DEFUN |constructorName| (|con|)
  (PROG ()
    (RETURN (COND (|$abbreviateTypes| (|abbreviate| |con|)) ('T |con|)))))

; DEFPARAMETER($justUnparseType, false)

(DEFPARAMETER |$justUnparseType| NIL)

; form2String1 u ==
;   ATOM u =>
;     u=$EmptyMode or u=$quadSymbol => formWrapId specialChar 'quad
;     IDENTP u =>
;       constructor? u => app2StringWrap(formWrapId u, [u])
;       u
;     SUBRP u => formWrapId BPINAME u
;     STRINGP u => formWrapId u
;     WRITE_-TO_-STRING formWrapId u
;   u1 := u
;   op := first u
;   argl := rest u
;   op='Join or op= 'mkCategory => formJoin1(op,argl)
;   $InteractiveMode and (u:= constructor? op) =>
;     null argl => app2StringWrap(formWrapId constructorName op, u1)
;     op = "NTuple"  => [ form2String1 first argl, "*"]
;     op = "Map"     => ["(",:formatSignature0 [argl.1,argl.0],")"]
;     op = 'Record => record2String(argl)
;     $justUnparseType or null(conSig := getConstructorSignature op) =>
;       application2String(constructorName op,[form2String1(a) for a in argl], u1)
;     ml := rest conSig
;     if not freeOfSharpVars ml then
;       ml:=SUBLIS([[pvar,:val] for pvar in $FormalMapVariableList
;         for val in argl], ml)
;     argl:= formArguments2String(argl,ml)
;       -- extra null check to handle mutable domain hack.
;     null argl => constructorName op
;     application2String(constructorName op,argl, u1)
;   op = "Mapping" => ["(",:formatSignature argl,")"]
;   op = "Record" => record2String(argl)
;   op = 'Union  =>
;     application2String(op,[form2String1 x for x in argl], u1)
;   op = ":" =>
;       null argl => [ '":" ]
;       null rest argl => [ '":", form2String1 first argl ]
;       formDecl2String(argl.0,argl.1)
;   op = "#" and PAIRP argl and LISTP first argl =>
;     STRINGIMAGE SIZE first argl
;   op = 'Join => formJoin2String argl
;   op = "ATTRIBUTE" => form2String1 first argl
;   op='Zero => 0
;   op='One => 1
;   op = 'AGGLST => tuple2String [form2String1 x for x in argl]
;   op = 'BRACKET =>
;     argl' := form2String1 first argl
;     ["[",:(atom argl' => [argl']; argl'),"]"]
;   op = 'SUB => sub_to_string(argl)
;   op = 'SUPERSUB => sub_to_string(argl)
;   op = "SIGNATURE" =>
;      [operation,sig] := argl
;      concat(operation,": ",formatSignature sig)
;   op = 'COLLECT => formCollect2String argl
;   op = 'construct =>
;     concat(lbrkSch(),
;            tuple2String [form2String1 x for x in argl],rbrkSch())
;   op = "MATRIX" => matrix2String argl
;   u1 is ["ROOT", arg1] =>
;      concat("sqrt(", appOrParen(arg1),")")
;   u1 is ["ROOT", arg1, arg2] =>
;      concat("nthRoot(", appOrParen(arg1),",",appOrParen(arg2),")")
;      --concat(appOrParen(arg1), '"^", appOrParen(["OVER",1,arg2]))
;   u1 is ["$elt", t, f] =>
;      concat(form2String1 f, '"$", form2String1 t)
;   #argl = 2 and (isBinaryInfix op or op = "::" or op = '"::"_
;      or op = "@" or op = '"@" or op = "pretend" or op = '"pretend"_
;      or op = "OVER" or op = '"OVER") =>
;           binop2String [op,:argl]
;   application2String(op,[form2String1 x for x in argl], u1)

(DEFUN |form2String1| (|u|)
  (PROG (|u1| |op| |argl| |conSig| |ml| |argl'| |operation| |sig| |ISTMP#1|
         |arg1| |ISTMP#2| |arg2| |t| |f|)
    (RETURN
     (COND
      ((ATOM |u|)
       (COND
        ((OR (EQUAL |u| |$EmptyMode|) (EQUAL |u| |$quadSymbol|))
         (|formWrapId| (|specialChar| '|quad|)))
        ((IDENTP |u|)
         (COND
          ((|constructor?| |u|)
           (|app2StringWrap| (|formWrapId| |u|) (LIST |u|)))
          (#1='T |u|)))
        ((SUBRP |u|) (|formWrapId| (BPINAME |u|)))
        ((STRINGP |u|) (|formWrapId| |u|))
        (#1# (WRITE-TO-STRING (|formWrapId| |u|)))))
      (#1#
       (PROGN
        (SETQ |u1| |u|)
        (SETQ |op| (CAR |u|))
        (SETQ |argl| (CDR |u|))
        (COND
         ((OR (EQ |op| '|Join|) (EQ |op| '|mkCategory|))
          (|formJoin1| |op| |argl|))
         ((AND |$InteractiveMode| (SETQ |u| (|constructor?| |op|)))
          (COND
           ((NULL |argl|)
            (|app2StringWrap| (|formWrapId| (|constructorName| |op|)) |u1|))
           ((EQ |op| '|NTuple|) (LIST (|form2String1| (CAR |argl|)) '*))
           ((EQ |op| '|Map|)
            (CONS '|(|
                  (APPEND
                   (|formatSignature0| (LIST (ELT |argl| 1) (ELT |argl| 0)))
                   (CONS '|)| NIL))))
           ((EQ |op| '|Record|) (|record2String| |argl|))
           ((OR |$justUnparseType|
                (NULL (SETQ |conSig| (|getConstructorSignature| |op|))))
            (|application2String| (|constructorName| |op|)
             ((LAMBDA (|bfVar#26| |bfVar#25| |a|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#25|)
                       (PROGN (SETQ |a| (CAR |bfVar#25|)) NIL))
                   (RETURN (NREVERSE |bfVar#26|)))
                  (#1#
                   (SETQ |bfVar#26| (CONS (|form2String1| |a|) |bfVar#26|))))
                 (SETQ |bfVar#25| (CDR |bfVar#25|))))
              NIL |argl| NIL)
             |u1|))
           (#1#
            (PROGN
             (SETQ |ml| (CDR |conSig|))
             (COND
              ((NULL (|freeOfSharpVars| |ml|))
               (SETQ |ml|
                       (SUBLIS
                        ((LAMBDA
                             (|bfVar#29| |bfVar#27| |pvar| |bfVar#28| |val|)
                           (LOOP
                            (COND
                             ((OR (ATOM |bfVar#27|)
                                  (PROGN (SETQ |pvar| (CAR |bfVar#27|)) NIL)
                                  (ATOM |bfVar#28|)
                                  (PROGN (SETQ |val| (CAR |bfVar#28|)) NIL))
                              (RETURN (NREVERSE |bfVar#29|)))
                             (#1#
                              (SETQ |bfVar#29|
                                      (CONS (CONS |pvar| |val|) |bfVar#29|))))
                            (SETQ |bfVar#27| (CDR |bfVar#27|))
                            (SETQ |bfVar#28| (CDR |bfVar#28|))))
                         NIL |$FormalMapVariableList| NIL |argl| NIL)
                        |ml|))))
             (SETQ |argl| (|formArguments2String| |argl| |ml|))
             (COND ((NULL |argl|) (|constructorName| |op|))
                   (#1#
                    (|application2String| (|constructorName| |op|) |argl|
                     |u1|)))))))
         ((EQ |op| '|Mapping|)
          (CONS '|(| (APPEND (|formatSignature| |argl|) (CONS '|)| NIL))))
         ((EQ |op| '|Record|) (|record2String| |argl|))
         ((EQ |op| '|Union|)
          (|application2String| |op|
           ((LAMBDA (|bfVar#31| |bfVar#30| |x|)
              (LOOP
               (COND
                ((OR (ATOM |bfVar#30|) (PROGN (SETQ |x| (CAR |bfVar#30|)) NIL))
                 (RETURN (NREVERSE |bfVar#31|)))
                (#1# (SETQ |bfVar#31| (CONS (|form2String1| |x|) |bfVar#31|))))
               (SETQ |bfVar#30| (CDR |bfVar#30|))))
            NIL |argl| NIL)
           |u1|))
         ((EQ |op| '|:|)
          (COND ((NULL |argl|) (LIST ":"))
                ((NULL (CDR |argl|)) (LIST ":" (|form2String1| (CAR |argl|))))
                (#1# (|formDecl2String| (ELT |argl| 0) (ELT |argl| 1)))))
         ((AND (EQ |op| '|#|) (CONSP |argl|) (LISTP (CAR |argl|)))
          (STRINGIMAGE (SIZE (CAR |argl|))))
         ((EQ |op| '|Join|) (|formJoin2String| |argl|))
         ((EQ |op| 'ATTRIBUTE) (|form2String1| (CAR |argl|)))
         ((EQ |op| '|Zero|) 0) ((EQ |op| '|One|) 1)
         ((EQ |op| 'AGGLST)
          (|tuple2String|
           ((LAMBDA (|bfVar#33| |bfVar#32| |x|)
              (LOOP
               (COND
                ((OR (ATOM |bfVar#32|) (PROGN (SETQ |x| (CAR |bfVar#32|)) NIL))
                 (RETURN (NREVERSE |bfVar#33|)))
                (#1# (SETQ |bfVar#33| (CONS (|form2String1| |x|) |bfVar#33|))))
               (SETQ |bfVar#32| (CDR |bfVar#32|))))
            NIL |argl| NIL)))
         ((EQ |op| 'BRACKET)
          (PROGN
           (SETQ |argl'| (|form2String1| (CAR |argl|)))
           (CONS '[
                 (APPEND (COND ((ATOM |argl'|) (LIST |argl'|)) (#1# |argl'|))
                         (CONS '] NIL)))))
         ((EQ |op| 'SUB) (|sub_to_string| |argl|))
         ((EQ |op| 'SUPERSUB) (|sub_to_string| |argl|))
         ((EQ |op| 'SIGNATURE)
          (PROGN
           (SETQ |operation| (CAR |argl|))
           (SETQ |sig| (CADR |argl|))
           (|concat| |operation| '|: | (|formatSignature| |sig|))))
         ((EQ |op| 'COLLECT) (|formCollect2String| |argl|))
         ((EQ |op| '|construct|)
          (|concat| (|lbrkSch|)
           (|tuple2String|
            ((LAMBDA (|bfVar#35| |bfVar#34| |x|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#34|)
                      (PROGN (SETQ |x| (CAR |bfVar#34|)) NIL))
                  (RETURN (NREVERSE |bfVar#35|)))
                 (#1#
                  (SETQ |bfVar#35| (CONS (|form2String1| |x|) |bfVar#35|))))
                (SETQ |bfVar#34| (CDR |bfVar#34|))))
             NIL |argl| NIL))
           (|rbrkSch|)))
         ((EQ |op| 'MATRIX) (|matrix2String| |argl|))
         ((AND (CONSP |u1|) (EQ (CAR |u1|) 'ROOT)
               (PROGN
                (SETQ |ISTMP#1| (CDR |u1|))
                (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                     (PROGN (SETQ |arg1| (CAR |ISTMP#1|)) #1#))))
          (|concat| '|sqrt(| (|appOrParen| |arg1|) '|)|))
         ((AND (CONSP |u1|) (EQ (CAR |u1|) 'ROOT)
               (PROGN
                (SETQ |ISTMP#1| (CDR |u1|))
                (AND (CONSP |ISTMP#1|)
                     (PROGN
                      (SETQ |arg1| (CAR |ISTMP#1|))
                      (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                      (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                           (PROGN (SETQ |arg2| (CAR |ISTMP#2|)) #1#))))))
          (|concat| '|nthRoot(| (|appOrParen| |arg1|) '|,|
           (|appOrParen| |arg2|) '|)|))
         ((AND (CONSP |u1|) (EQ (CAR |u1|) '|$elt|)
               (PROGN
                (SETQ |ISTMP#1| (CDR |u1|))
                (AND (CONSP |ISTMP#1|)
                     (PROGN
                      (SETQ |t| (CAR |ISTMP#1|))
                      (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                      (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                           (PROGN (SETQ |f| (CAR |ISTMP#2|)) #1#))))))
          (|concat| (|form2String1| |f|) "$" (|form2String1| |t|)))
         ((AND (EQL (LENGTH |argl|) 2)
               (OR (|isBinaryInfix| |op|) (EQ |op| '|::|) (EQUAL |op| "::")
                   (EQ |op| '@) (EQUAL |op| "@") (EQ |op| '|pretend|)
                   (EQUAL |op| "pretend") (EQ |op| 'OVER) (EQUAL |op| "OVER")))
          (|binop2String| (CONS |op| |argl|)))
         (#1#
          (|application2String| |op|
           ((LAMBDA (|bfVar#37| |bfVar#36| |x|)
              (LOOP
               (COND
                ((OR (ATOM |bfVar#36|) (PROGN (SETQ |x| (CAR |bfVar#36|)) NIL))
                 (RETURN (NREVERSE |bfVar#37|)))
                (#1# (SETQ |bfVar#37| (CONS (|form2String1| |x|) |bfVar#37|))))
               (SETQ |bfVar#36| (CDR |bfVar#36|))))
            NIL |argl| NIL)
           |u1|)))))))))

; matrix2String x ==
;   concat(lbrkSch(),
;     tuple2String [outtranRow ri for ri in rest(x)],rbrkSch()) where
;       outtranRow x ==
;         concat(lbrkSch(),
;           tuple2String [form2String1 ei for ei in rest(x)], rbrkSch())

(DEFUN |matrix2String| (|x|)
  (PROG ()
    (RETURN
     (|concat| (|lbrkSch|)
      (|tuple2String|
       ((LAMBDA (|bfVar#39| |bfVar#38| |ri|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#38|) (PROGN (SETQ |ri| (CAR |bfVar#38|)) NIL))
             (RETURN (NREVERSE |bfVar#39|)))
            ('T
             (SETQ |bfVar#39|
                     (CONS (|matrix2String,outtranRow| |ri|) |bfVar#39|))))
           (SETQ |bfVar#38| (CDR |bfVar#38|))))
        NIL (CDR |x|) NIL))
      (|rbrkSch|)))))
(DEFUN |matrix2String,outtranRow| (|x|)
  (PROG ()
    (RETURN
     (|concat| (|lbrkSch|)
      (|tuple2String|
       ((LAMBDA (|bfVar#41| |bfVar#40| |ei|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#40|) (PROGN (SETQ |ei| (CAR |bfVar#40|)) NIL))
             (RETURN (NREVERSE |bfVar#41|)))
            ('T (SETQ |bfVar#41| (CONS (|form2String1| |ei|) |bfVar#41|))))
           (SETQ |bfVar#40| (CDR |bfVar#40|))))
        NIL (CDR |x|) NIL))
      (|rbrkSch|)))))

; binop2String x ==
;     $curExpr : local := x
;     x is ["=", arg1, arg2] or x is ['"=", arg1, arg2] =>
;         concat(sumOrParen(arg1), '"=", sumOrParen(arg2))
;     sumOrParen(x)

(DEFUN |binop2String| (|x|)
  (PROG (|$curExpr| |arg2| |ISTMP#2| |arg1| |ISTMP#1|)
    (DECLARE (SPECIAL |$curExpr|))
    (RETURN
     (PROGN
      (SETQ |$curExpr| |x|)
      (COND
       ((OR
         (AND (CONSP |x|) (EQ (CAR |x|) '=)
              (PROGN
               (SETQ |ISTMP#1| (CDR |x|))
               (AND (CONSP |ISTMP#1|)
                    (PROGN
                     (SETQ |arg1| (CAR |ISTMP#1|))
                     (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                     (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                          (PROGN (SETQ |arg2| (CAR |ISTMP#2|)) #1='T))))))
         (AND (CONSP |x|) (EQUAL (CAR |x|) '"=")
              (PROGN
               (SETQ |ISTMP#1| (CDR |x|))
               (AND (CONSP |ISTMP#1|)
                    (PROGN
                     (SETQ |arg1| (CAR |ISTMP#1|))
                     (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                     (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                          (PROGN (SETQ |arg2| (CAR |ISTMP#2|)) #1#)))))))
        (|concat| (|sumOrParen| |arg1|) "=" (|sumOrParen| |arg2|)))
       (#1# (|sumOrParen| |x|)))))))

; sumOrParen(x) ==
;    x is [op, arg1, arg2] =>
;        op = "+" or op = '"+" =>
;            concat(sumOrParen(arg1), '"+", productOrParen(arg2))
;        op = "-" or op = '"-" =>
;            concat(sumOrParen(arg1), '"-", productOrParen(arg2))
;        op = "/" or op = '"/" or op = "OVER" or op = '"OVER" =>
;            concat(appOrParen(arg1), '"/", appOrParen(arg2))
;        productOrParen(x)
;    productOrParen(x)

(DEFUN |sumOrParen| (|x|)
  (PROG (|op| |ISTMP#1| |arg1| |ISTMP#2| |arg2|)
    (RETURN
     (COND
      ((AND (CONSP |x|)
            (PROGN
             (SETQ |op| (CAR |x|))
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |arg1| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |arg2| (CAR |ISTMP#2|)) #1='T))))))
       (COND
        ((OR (EQ |op| '+) (EQUAL |op| "+"))
         (|concat| (|sumOrParen| |arg1|) "+" (|productOrParen| |arg2|)))
        ((OR (EQ |op| '-) (EQUAL |op| "-"))
         (|concat| (|sumOrParen| |arg1|) "-" (|productOrParen| |arg2|)))
        ((OR (EQ |op| '/) (EQUAL |op| "/") (EQ |op| 'OVER) (EQUAL |op| "OVER"))
         (|concat| (|appOrParen| |arg1|) "/" (|appOrParen| |arg2|)))
        (#1# (|productOrParen| |x|))))
      (#1# (|productOrParen| |x|))))))

; productOrParen(x) ==
;    x is [op, arg1, arg2] =>
;        op = "*" or op ='"*" =>
;            concat(productOrParen(arg1), '"*",  powerOrParen(arg2))
;        powerOrParen(x)
;    powerOrParen(x)

(DEFUN |productOrParen| (|x|)
  (PROG (|op| |ISTMP#1| |arg1| |ISTMP#2| |arg2|)
    (RETURN
     (COND
      ((AND (CONSP |x|)
            (PROGN
             (SETQ |op| (CAR |x|))
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |arg1| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |arg2| (CAR |ISTMP#2|)) #1='T))))))
       (COND
        ((OR (EQ |op| '*) (EQUAL |op| "*"))
         (|concat| (|productOrParen| |arg1|) "*" (|powerOrParen| |arg2|)))
        (#1# (|powerOrParen| |x|))))
      (#1# (|powerOrParen| |x|))))))

; powerOrParen(x) ==
;    x is [op, arg1, arg2] =>
;       op = "**" or op = '"**" or op = "^" or op = '"^"  =>
;            concat(coerceOrParen(arg1), '"^", coerceOrParen(arg2))
;       coerceOrParen(x)
;    coerceOrParen(x)

(DEFUN |powerOrParen| (|x|)
  (PROG (|op| |ISTMP#1| |arg1| |ISTMP#2| |arg2|)
    (RETURN
     (COND
      ((AND (CONSP |x|)
            (PROGN
             (SETQ |op| (CAR |x|))
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |arg1| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |arg2| (CAR |ISTMP#2|)) #1='T))))))
       (COND
        ((OR (EQ |op| '**) (EQUAL |op| "**") (EQ |op| '^) (EQUAL |op| "^"))
         (|concat| (|coerceOrParen| |arg1|) "^" (|coerceOrParen| |arg2|)))
        (#1# (|coerceOrParen| |x|))))
      (#1# (|coerceOrParen| |x|))))))

; coerceOrParen(x) ==
;    x is [op, arg1, arg2] =>
;       op = "::" or op = '"::" =>
;            concat(coerceOrParen(arg1), '"::", appOrParen(arg2))
;       op = "@" or op = '"@" =>
;            concat(coerceOrParen(arg1), '"@", appOrParen(arg2))
;       op = "pretend" or op = '"pretend" =>
;            concat(coerceOrParen(arg1), '" ", '"pretend", '" ",_
;                    appOrParen(arg2))
;       appOrParen(x)
;    appOrParen(x)

(DEFUN |coerceOrParen| (|x|)
  (PROG (|op| |ISTMP#1| |arg1| |ISTMP#2| |arg2|)
    (RETURN
     (COND
      ((AND (CONSP |x|)
            (PROGN
             (SETQ |op| (CAR |x|))
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |arg1| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |arg2| (CAR |ISTMP#2|)) #1='T))))))
       (COND
        ((OR (EQ |op| '|::|) (EQUAL |op| "::"))
         (|concat| (|coerceOrParen| |arg1|) "::" (|appOrParen| |arg2|)))
        ((OR (EQ |op| '@) (EQUAL |op| "@"))
         (|concat| (|coerceOrParen| |arg1|) "@" (|appOrParen| |arg2|)))
        ((OR (EQ |op| '|pretend|) (EQUAL |op| "pretend"))
         (|concat| (|coerceOrParen| |arg1|) " " "pretend" " "
          (|appOrParen| |arg2|)))
        (#1# (|appOrParen| |x|))))
      (#1# (|appOrParen| |x|))))))

; appOrParen(x) ==
;    SYMBOLP(x) => formWrapId x
;    INTEGERP(x) =>
;        x >=0 => WRITE_-TO_-STRING x
;        concat('"(",WRITE_-TO_-STRING x,'")")
;    -- Kludge to avoid extra parentheses printing a SparseUnivariatePolynomial
;    x = '"?" => formWrapId x
;    ATOM(x) => concat('"(", form2String1(x), '")")
;    [op, :argl] := x
;    (op = "-" or op = '"-") and #argl = 1 =>
;        concat('"(", '"-", appOrParen(first argl), '")")
;    EQ(x, $curExpr) => BREAK()
;    op is ["$elt", f, t] =>
;        form2String1 x
;    -- Put parenthesis around anything special
;    not(SYMBOLP op) or GET(op, "Led") or GET(op, "Nud")_
;      or op= 'mkCategory or op = "SEGMENT" _
;      or op = 'construct or op = 'COLLECT or op = "SIGNATURE"_
;      or op = 'BRACKET or op = 'AGGLST or op = "ATTRIBUTE"_
;      or op = "#" =>
;         concat('"(", form2String1(x), '")")
;    op = "Zero" => '"0"
;    op = "One" => '"1"
;    form2String1 x

(DEFUN |appOrParen| (|x|)
  (PROG (|op| |argl| |ISTMP#1| |f| |ISTMP#2| |t|)
    (RETURN
     (COND ((SYMBOLP |x|) (|formWrapId| |x|))
           ((INTEGERP |x|)
            (COND ((NOT (MINUSP |x|)) (WRITE-TO-STRING |x|))
                  (#1='T (|concat| "(" (WRITE-TO-STRING |x|) ")"))))
           ((EQUAL |x| "?") (|formWrapId| |x|))
           ((ATOM |x|) (|concat| "(" (|form2String1| |x|) ")"))
           (#1#
            (PROGN
             (SETQ |op| (CAR |x|))
             (SETQ |argl| (CDR |x|))
             (COND
              ((AND (OR (EQ |op| '-) (EQUAL |op| "-")) (EQL (LENGTH |argl|) 1))
               (|concat| "(" "-" (|appOrParen| (CAR |argl|)) ")"))
              ((EQ |x| |$curExpr|) (BREAK))
              ((AND (CONSP |op|) (EQ (CAR |op|) '|$elt|)
                    (PROGN
                     (SETQ |ISTMP#1| (CDR |op|))
                     (AND (CONSP |ISTMP#1|)
                          (PROGN
                           (SETQ |f| (CAR |ISTMP#1|))
                           (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                           (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                (PROGN (SETQ |t| (CAR |ISTMP#2|)) #1#))))))
               (|form2String1| |x|))
              ((OR (NULL (SYMBOLP |op|)) (GET |op| '|Led|) (GET |op| '|Nud|)
                   (EQ |op| '|mkCategory|) (EQ |op| 'SEGMENT)
                   (EQ |op| '|construct|) (EQ |op| 'COLLECT)
                   (EQ |op| 'SIGNATURE) (EQ |op| 'BRACKET) (EQ |op| 'AGGLST)
                   (EQ |op| 'ATTRIBUTE) (EQ |op| '|#|))
               (|concat| "(" (|form2String1| |x|) ")"))
              ((EQ |op| '|Zero|) "0") ((EQ |op| '|One|) "1")
              (#1# (|form2String1| |x|)))))))))

; formWrapId id == id

(DEFUN |formWrapId| (|id|) (PROG () (RETURN |id|)))

; formArguments2String(argl,ml) == [fn(x,m) for x in argl for m in ml] where
;   fn(x,m) ==
;     x=$EmptyMode or x=$quadSymbol => specialChar 'quad
;     STRINGP(x) or IDENTP(x) => x
;     x is [ ='_:,:.] => form2String1 x
;     x is ["QUOTE", y] =>
;         m = $Symbol and SYMBOLP(y) => y
;         form2String1 x
;     isValidType(m) and PAIRP(m) and
;       (GETDATABASE(first(m),'CONSTRUCTORKIND) = 'domain) =>
;         (x' := coerceInteractive(objNewWrap(x,m),$OutputForm)) =>
;           form2String1 objValUnwrap x'
;         form2String1 x
;     form2String1 x

(DEFUN |formArguments2String| (|argl| |ml|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#44| |bfVar#42| |x| |bfVar#43| |m|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#42|) (PROGN (SETQ |x| (CAR |bfVar#42|)) NIL)
               (ATOM |bfVar#43|) (PROGN (SETQ |m| (CAR |bfVar#43|)) NIL))
           (RETURN (NREVERSE |bfVar#44|)))
          ('T
           (SETQ |bfVar#44|
                   (CONS (|formArguments2String,fn| |x| |m|) |bfVar#44|))))
         (SETQ |bfVar#42| (CDR |bfVar#42|))
         (SETQ |bfVar#43| (CDR |bfVar#43|))))
      NIL |argl| NIL |ml| NIL))))
(DEFUN |formArguments2String,fn| (|x| |m|)
  (PROG (|ISTMP#1| |y| |x'|)
    (RETURN
     (COND
      ((OR (EQUAL |x| |$EmptyMode|) (EQUAL |x| |$quadSymbol|))
       (|specialChar| '|quad|))
      ((OR (STRINGP |x|) (IDENTP |x|)) |x|)
      ((AND (CONSP |x|) (EQUAL (CAR |x|) '|:|)) (|form2String1| |x|))
      ((AND (CONSP |x|) (EQ (CAR |x|) 'QUOTE)
            (PROGN
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |y| (CAR |ISTMP#1|)) #1='T))))
       (COND ((AND (EQUAL |m| |$Symbol|) (SYMBOLP |y|)) |y|)
             (#1# (|form2String1| |x|))))
      ((AND (|isValidType| |m|) (CONSP |m|)
            (EQ (GETDATABASE (CAR |m|) 'CONSTRUCTORKIND) '|domain|))
       (COND
        ((SETQ |x'| (|coerceInteractive| (|objNewWrap| |x| |m|) |$OutputForm|))
         (|form2String1| (|objValUnwrap| |x'|)))
        (#1# (|form2String1| |x|))))
      (#1# (|form2String1| |x|))))))

; formDecl2String(left,right) ==
;   $declVar: local := left
;   whereBefore := $whereList
;   ls:= form2StringLocal left
;   rs:= form2StringLocal right
;   $whereList ~= whereBefore and $permitWhere => ls
;   concat(form2StringLocal ls,'": ",rs)

(DEFUN |formDecl2String| (|left| |right|)
  (PROG (|$declVar| |rs| |ls| |whereBefore|)
    (DECLARE (SPECIAL |$declVar|))
    (RETURN
     (PROGN
      (SETQ |$declVar| |left|)
      (SETQ |whereBefore| |$whereList|)
      (SETQ |ls| (|form2StringLocal| |left|))
      (SETQ |rs| (|form2StringLocal| |right|))
      (COND
       ((AND (NOT (EQUAL |$whereList| |whereBefore|)) |$permitWhere|) |ls|)
       ('T (|concat| (|form2StringLocal| |ls|) ": " |rs|)))))))

; formJoin1(op,u) ==
;   if op = 'Join then [:argl,last] := u else (argl := nil; last := [op,:u])
;   last is [id, :r] and id in '(mkCategory CATEGORY) =>
;     if id = "CATEGORY" then r := rest(r)
;     $abbreviateJoin = true => concat(formJoin2 argl,'%b,'"with",'%d,'"...")
;     $permitWhere = true =>
;       opList:= formatJoinKey(r,id)
;       $whereList:= concat($whereList,"%l",$declVar,": ",
;         formJoin2 argl,'%b,'"with",'%d,"%i",opList,"%u")
;       formJoin2 argl
;     opList:= formatJoinKey(r,id)
;     suffix := concat('%b,'"with",'%d,"%i",opList,"%u")
;     concat(formJoin2 argl,suffix)
;   formJoin2 u

(DEFUN |formJoin1| (|op| |u|)
  (PROG (|LETTMP#1| |last| |argl| |id| |r| |opList| |suffix|)
    (RETURN
     (PROGN
      (COND
       ((EQ |op| '|Join|) (SETQ |LETTMP#1| (REVERSE |u|))
        (SETQ |last| (CAR |LETTMP#1|))
        (SETQ |argl| (NREVERSE (CDR |LETTMP#1|))) |u|)
       (#1='T (SETQ |argl| NIL) (SETQ |last| (CONS |op| |u|))))
      (COND
       ((AND (CONSP |last|)
             (PROGN (SETQ |id| (CAR |last|)) (SETQ |r| (CDR |last|)) #1#)
             (|member| |id| '(|mkCategory| CATEGORY)))
        (PROGN
         (COND ((EQ |id| 'CATEGORY) (SETQ |r| (CDR |r|))))
         (COND
          ((EQUAL |$abbreviateJoin| T)
           (|concat| (|formJoin2| |argl|) '|%b| "with" '|%d| "..."))
          ((EQUAL |$permitWhere| T)
           (PROGN
            (SETQ |opList| (|formatJoinKey| |r| |id|))
            (SETQ |$whereList|
                    (|concat| |$whereList| '|%l| |$declVar| '|: |
                     (|formJoin2| |argl|) '|%b| "with" '|%d| '|%i| |opList|
                     '|%u|))
            (|formJoin2| |argl|)))
          (#1#
           (PROGN
            (SETQ |opList| (|formatJoinKey| |r| |id|))
            (SETQ |suffix| (|concat| '|%b| "with" '|%d| '|%i| |opList| '|%u|))
            (|concat| (|formJoin2| |argl|) |suffix|))))))
       (#1# (|formJoin2| |u|)))))))

; formatJoinKey(r,key) ==
;   key = 'mkCategory =>
;     r is [opPart,catPart,:.] =>
;       opString :=
;         opPart is [='LIST,:u] =>
;           "append"/[concat("%l",formatOpSignature(op,sig),formatIf pred)
;             for [='QUOTE,[[op,sig],pred]] in u]
;         nil
;       catString :=
;         catPart is [='LIST,:u] =>
;           "append"/[concat("%l",'" ",form2StringLocal con,formatIf pred)
;             for [='QUOTE,[con,pred]] in u]
;         nil
;       concat(opString,catString)
;     '"?? unknown mkCategory format ??"
;   -- otherwise we have the CATEGORY form
;   "append"/[fn for x in r] where fn ==
;     x is ['SIGNATURE,op,sig] => concat("%l",formatOpSignature(op,sig))
;     x is ['ATTRIBUTE,a] => concat("%l",formatAttribute a)
;     x

(DEFUN |formatJoinKey| (|r| |key|)
  (PROG (|opPart| |ISTMP#1| |catPart| |u| |ISTMP#2| |ISTMP#3| |op| |ISTMP#4|
         |sig| |ISTMP#5| |pred| |opString| |con| |catString| |a|)
    (RETURN
     (COND
      ((EQ |key| '|mkCategory|)
       (COND
        ((AND (CONSP |r|)
              (PROGN
               (SETQ |opPart| (CAR |r|))
               (SETQ |ISTMP#1| (CDR |r|))
               (AND (CONSP |ISTMP#1|)
                    (PROGN (SETQ |catPart| (CAR |ISTMP#1|)) #1='T))))
         (PROGN
          (SETQ |opString|
                  (COND
                   ((AND (CONSP |opPart|) (EQUAL (CAR |opPart|) 'LIST)
                         (PROGN (SETQ |u| (CDR |opPart|)) #1#))
                    ((LAMBDA (|bfVar#47| |bfVar#46| |bfVar#45|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#46|)
                              (PROGN (SETQ |bfVar#45| (CAR |bfVar#46|)) NIL))
                          (RETURN |bfVar#47|))
                         (#1#
                          (AND (CONSP |bfVar#45|)
                               (EQUAL (CAR |bfVar#45|) 'QUOTE)
                               (PROGN
                                (SETQ |ISTMP#1| (CDR |bfVar#45|))
                                (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                                     (PROGN
                                      (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                                      (AND (CONSP |ISTMP#2|)
                                           (PROGN
                                            (SETQ |ISTMP#3| (CAR |ISTMP#2|))
                                            (AND (CONSP |ISTMP#3|)
                                                 (PROGN
                                                  (SETQ |op| (CAR |ISTMP#3|))
                                                  (SETQ |ISTMP#4|
                                                          (CDR |ISTMP#3|))
                                                  (AND (CONSP |ISTMP#4|)
                                                       (EQ (CDR |ISTMP#4|) NIL)
                                                       (PROGN
                                                        (SETQ |sig|
                                                                (CAR
                                                                 |ISTMP#4|))
                                                        #1#)))))
                                           (PROGN
                                            (SETQ |ISTMP#5| (CDR |ISTMP#2|))
                                            (AND (CONSP |ISTMP#5|)
                                                 (EQ (CDR |ISTMP#5|) NIL)
                                                 (PROGN
                                                  (SETQ |pred| (CAR |ISTMP#5|))
                                                  #1#)))))))
                               (SETQ |bfVar#47|
                                       (APPEND |bfVar#47|
                                               (|concat| '|%l|
                                                (|formatOpSignature| |op|
                                                 |sig|)
                                                (|formatIf| |pred|)))))))
                        (SETQ |bfVar#46| (CDR |bfVar#46|))))
                     NIL |u| NIL))
                   (#1# NIL)))
          (SETQ |catString|
                  (COND
                   ((AND (CONSP |catPart|) (EQUAL (CAR |catPart|) 'LIST)
                         (PROGN (SETQ |u| (CDR |catPart|)) #1#))
                    ((LAMBDA (|bfVar#50| |bfVar#49| |bfVar#48|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#49|)
                              (PROGN (SETQ |bfVar#48| (CAR |bfVar#49|)) NIL))
                          (RETURN |bfVar#50|))
                         (#1#
                          (AND (CONSP |bfVar#48|)
                               (EQUAL (CAR |bfVar#48|) 'QUOTE)
                               (PROGN
                                (SETQ |ISTMP#1| (CDR |bfVar#48|))
                                (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                                     (PROGN
                                      (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                                      (AND (CONSP |ISTMP#2|)
                                           (PROGN
                                            (SETQ |con| (CAR |ISTMP#2|))
                                            (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                                            (AND (CONSP |ISTMP#3|)
                                                 (EQ (CDR |ISTMP#3|) NIL)
                                                 (PROGN
                                                  (SETQ |pred| (CAR |ISTMP#3|))
                                                  #1#)))))))
                               (SETQ |bfVar#50|
                                       (APPEND |bfVar#50|
                                               (|concat| '|%l| " "
                                                (|form2StringLocal| |con|)
                                                (|formatIf| |pred|)))))))
                        (SETQ |bfVar#49| (CDR |bfVar#49|))))
                     NIL |u| NIL))
                   (#1# NIL)))
          (|concat| |opString| |catString|)))
        (#1# "?? unknown mkCategory format ??")))
      (#1#
       ((LAMBDA (|bfVar#52| |bfVar#51| |x|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#51|) (PROGN (SETQ |x| (CAR |bfVar#51|)) NIL))
             (RETURN |bfVar#52|))
            (#1#
             (SETQ |bfVar#52|
                     (APPEND |bfVar#52|
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
                               (|concat| '|%l|
                                (|formatOpSignature| |op| |sig|)))
                              ((AND (CONSP |x|) (EQ (CAR |x|) 'ATTRIBUTE)
                                    (PROGN
                                     (SETQ |ISTMP#1| (CDR |x|))
                                     (AND (CONSP |ISTMP#1|)
                                          (EQ (CDR |ISTMP#1|) NIL)
                                          (PROGN
                                           (SETQ |a| (CAR |ISTMP#1|))
                                           #1#))))
                               (|concat| '|%l| (|formatAttribute| |a|)))
                              (#1# |x|))))))
           (SETQ |bfVar#51| (CDR |bfVar#51|))))
        NIL |r| NIL))))))

; formJoin2 argl ==
; -- argl is a list of categories NOT containing a "with"
;   null argl => '""
;   1=#argl => form2StringLocal argl.0
;   application2String('Join,[form2StringLocal x for x in argl], NIL)

(DEFUN |formJoin2| (|argl|)
  (PROG ()
    (RETURN
     (COND ((NULL |argl|) "")
           ((EQL 1 (LENGTH |argl|)) (|form2StringLocal| (ELT |argl| 0)))
           (#1='T
            (|application2String| '|Join|
             ((LAMBDA (|bfVar#54| |bfVar#53| |x|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#53|)
                       (PROGN (SETQ |x| (CAR |bfVar#53|)) NIL))
                   (RETURN (NREVERSE |bfVar#54|)))
                  (#1#
                   (SETQ |bfVar#54|
                           (CONS (|form2StringLocal| |x|) |bfVar#54|))))
                 (SETQ |bfVar#53| (CDR |bfVar#53|))))
              NIL |argl| NIL)
             NIL))))))

; formJoin2String (u:=[:argl,last]) ==
;   last is ["CATEGORY",.,:atsigList] =>
;     postString:= concat("_(",formTuple2String atsigList,"_)")
;     #argl=1 => concat(first argl,'" with ",postString)
;     concat(application2String('Join,argl, NIL)," with ",postString)
;   application2String('Join,u, NIL)

(DEFUN |formJoin2String| (|u|)
  (PROG (|LETTMP#1| |last| |argl| |ISTMP#1| |atsigList| |postString|)
    (RETURN
     (PROGN
      (SETQ |LETTMP#1| (REVERSE |u|))
      (SETQ |last| (CAR |LETTMP#1|))
      (SETQ |argl| (NREVERSE (CDR |LETTMP#1|)))
      (COND
       ((AND (CONSP |last|) (EQ (CAR |last|) 'CATEGORY)
             (PROGN
              (SETQ |ISTMP#1| (CDR |last|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN (SETQ |atsigList| (CDR |ISTMP#1|)) #1='T))))
        (PROGN
         (SETQ |postString|
                 (|concat| '|(| (|formTuple2String| |atsigList|) '|)|))
         (COND
          ((EQL (LENGTH |argl|) 1)
           (|concat| (CAR |argl|) " with " |postString|))
          (#1#
           (|concat| (|application2String| '|Join| |argl| NIL) '| with |
            |postString|)))))
       (#1# (|application2String| '|Join| |u| NIL)))))))

; sub_to_string(u) ==
;     [op, :argl] := u
;     fo := form2String1(op)
;     if atom(fo) then fo := [fo];
;     rargl := REVERSE(argl)
;     resl := []
;     for arg in rargl repeat
;         resl = [] and arg = [] => "iterate"
;         if resl then resl := cons(";", resl)
;         fa := form2String1(arg)
;         if atom(fa) then fa := [fa]
;         resl := [:fa, :resl]
;     [:fo, "[", :resl, "]"]

(DEFUN |sub_to_string| (|u|)
  (PROG (|op| |argl| |fo| |rargl| |resl| |fa|)
    (RETURN
     (PROGN
      (SETQ |op| (CAR |u|))
      (SETQ |argl| (CDR |u|))
      (SETQ |fo| (|form2String1| |op|))
      (COND ((ATOM |fo|) (SETQ |fo| (LIST |fo|))))
      (SETQ |rargl| (REVERSE |argl|))
      (SETQ |resl| NIL)
      ((LAMBDA (|bfVar#55| |arg|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#55|) (PROGN (SETQ |arg| (CAR |bfVar#55|)) NIL))
            (RETURN NIL))
           (#1='T
            (COND ((AND (NULL |resl|) (NULL |arg|)) '|iterate|)
                  (#1#
                   (PROGN
                    (COND (|resl| (SETQ |resl| (CONS '|;| |resl|))))
                    (SETQ |fa| (|form2String1| |arg|))
                    (COND ((ATOM |fa|) (SETQ |fa| (LIST |fa|))))
                    (SETQ |resl| (APPEND |fa| |resl|)))))))
          (SETQ |bfVar#55| (CDR |bfVar#55|))))
       |rargl| NIL)
      (APPEND |fo| (CONS '[ (APPEND |resl| (CONS '] NIL))))))))

; formCollect2String [:itl,body] ==
;   ["_(",body,:"append"/[formIterator2String x for x in itl],"_)"]

(DEFUN |formCollect2String| (|bfVar#58|)
  (PROG (|LETTMP#1| |body| |itl|)
    (RETURN
     (PROGN
      (SETQ |LETTMP#1| (REVERSE |bfVar#58|))
      (SETQ |body| (CAR |LETTMP#1|))
      (SETQ |itl| (NREVERSE (CDR |LETTMP#1|)))
      (CONS '|(|
            (CONS |body|
                  (APPEND
                   ((LAMBDA (|bfVar#57| |bfVar#56| |x|)
                      (LOOP
                       (COND
                        ((OR (ATOM |bfVar#56|)
                             (PROGN (SETQ |x| (CAR |bfVar#56|)) NIL))
                         (RETURN |bfVar#57|))
                        ('T
                         (SETQ |bfVar#57|
                                 (APPEND |bfVar#57|
                                         (|formIterator2String| |x|)))))
                       (SETQ |bfVar#56| (CDR |bfVar#56|))))
                    NIL |itl| NIL)
                   (CONS '|)| NIL))))))))

; formIterator2String x ==
;   x is ["STEP",y,s,.,:l] =>
;     tail:= (l is [f] => form2StringLocal f; nil)
;     concat("for ",y," in ",s,'"..",tail)
;   x is ["tails",y] => concat("tails ",formatIterator y)
;   x is ["reverse",y] => concat("reverse ",formatIterator y)
;   x is ["|",y,p] => concat(formatIterator y," | ",form2StringLocal p)
;   x is ["until",p] => concat("until ",form2StringLocal p)
;   x is ["while",p] => concat("while ",form2StringLocal p)
;   systemErrorHere "formatIterator"

(DEFUN |formIterator2String| (|x|)
  (PROG (|ISTMP#1| |y| |ISTMP#2| |s| |ISTMP#3| |l| |f| |tail| |p|)
    (RETURN
     (COND
      ((AND (CONSP |x|) (EQ (CAR |x|) 'STEP)
            (PROGN
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |y| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|)
                        (PROGN
                         (SETQ |s| (CAR |ISTMP#2|))
                         (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                         (AND (CONSP |ISTMP#3|)
                              (PROGN (SETQ |l| (CDR |ISTMP#3|)) #1='T))))))))
       (PROGN
        (SETQ |tail|
                (COND
                 ((AND (CONSP |l|) (EQ (CDR |l|) NIL)
                       (PROGN (SETQ |f| (CAR |l|)) #1#))
                  (|form2StringLocal| |f|))
                 (#1# NIL)))
        (|concat| '|for | |y| '| in | |s| ".." |tail|)))
      ((AND (CONSP |x|) (EQ (CAR |x|) '|tails|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |y| (CAR |ISTMP#1|)) #1#))))
       (|concat| '|tails | (|formatIterator| |y|)))
      ((AND (CONSP |x|) (EQ (CAR |x|) '|reverse|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |y| (CAR |ISTMP#1|)) #1#))))
       (|concat| '|reverse | (|formatIterator| |y|)))
      ((AND (CONSP |x|) (EQ (CAR |x|) '|\||)
            (PROGN
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |y| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |p| (CAR |ISTMP#2|)) #1#))))))
       (|concat| (|formatIterator| |y|) '| \| | (|form2StringLocal| |p|)))
      ((AND (CONSP |x|) (EQ (CAR |x|) '|until|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |p| (CAR |ISTMP#1|)) #1#))))
       (|concat| '|until | (|form2StringLocal| |p|)))
      ((AND (CONSP |x|) (EQ (CAR |x|) '|while|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |p| (CAR |ISTMP#1|)) #1#))))
       (|concat| '|while | (|form2StringLocal| |p|)))
      (#1# (|systemErrorHere| '|formatIterator|))))))

; tuple2String argl ==
;   fn1 argl where
;     fn1 argl ==
;         null argl => nil
;         string := first argl
;         if member(string, '("failed" "nil" "prime" "sqfr" "irred"))
;             then string := STRCONC('"_"", string, '"_"")
;             else string :=
;                 ATOM string => object2String string
;                 [fn2 x for x in string]
;         for x in rest argl repeat
;             if member(x, '("failed" "nil" "prime" "sqfr" "irred")) then
;                 x := STRCONC('"_"", x, '"_"")
;             string := concat(string, concat(",", fn2 x))
;         string
;     fn2 x ==
;       ATOM x => object2String x
;       -- [fn2 first x, :f rest x]
;       [fn2 y for y in x]

(DEFUN |tuple2String| (|argl|) (PROG () (RETURN (|tuple2String,fn1| |argl|))))
(DEFUN |tuple2String,fn1| (|argl|)
  (PROG (|string|)
    (RETURN
     (COND ((NULL |argl|) NIL)
           (#1='T
            (PROGN
             (SETQ |string| (CAR |argl|))
             (COND
              ((|member| |string| '("failed" "nil" "prime" "sqfr" "irred"))
               (SETQ |string| (STRCONC "\"" |string| "\"")))
              (#1#
               (SETQ |string|
                       (COND ((ATOM |string|) (|object2String| |string|))
                             (#1#
                              ((LAMBDA (|bfVar#60| |bfVar#59| |x|)
                                 (LOOP
                                  (COND
                                   ((OR (ATOM |bfVar#59|)
                                        (PROGN
                                         (SETQ |x| (CAR |bfVar#59|))
                                         NIL))
                                    (RETURN (NREVERSE |bfVar#60|)))
                                   (#1#
                                    (SETQ |bfVar#60|
                                            (CONS (|tuple2String,fn2| |x|)
                                                  |bfVar#60|))))
                                  (SETQ |bfVar#59| (CDR |bfVar#59|))))
                               NIL |string| NIL))))))
             ((LAMBDA (|bfVar#61| |x|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#61|)
                       (PROGN (SETQ |x| (CAR |bfVar#61|)) NIL))
                   (RETURN NIL))
                  (#1#
                   (PROGN
                    (COND
                     ((|member| |x| '("failed" "nil" "prime" "sqfr" "irred"))
                      (SETQ |x| (STRCONC "\"" |x| "\""))))
                    (SETQ |string|
                            (|concat| |string|
                             (|concat| '|,| (|tuple2String,fn2| |x|)))))))
                 (SETQ |bfVar#61| (CDR |bfVar#61|))))
              (CDR |argl|) NIL)
             |string|))))))
(DEFUN |tuple2String,fn2| (|x|)
  (PROG ()
    (RETURN
     (COND ((ATOM |x|) (|object2String| |x|))
           (#1='T
            ((LAMBDA (|bfVar#63| |bfVar#62| |y|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#62|)
                      (PROGN (SETQ |y| (CAR |bfVar#62|)) NIL))
                  (RETURN (NREVERSE |bfVar#63|)))
                 (#1#
                  (SETQ |bfVar#63|
                          (CONS (|tuple2String,fn2| |y|) |bfVar#63|))))
                (SETQ |bfVar#62| (CDR |bfVar#62|))))
             NIL |x| NIL))))))

; linearFormatName x ==
;   atom x => x
;   linearFormat x

(DEFUN |linearFormatName| (|x|)
  (PROG () (RETURN (COND ((ATOM |x|) |x|) ('T (|linearFormat| |x|))))))

; linearFormat x ==
;   atom x => x
;   x is [op,:argl] and atom op =>
;     argPart:=
;       argl is [a,:l] => [a,:"append"/[[",",x] for x in l]]
;       nil
;     [op,"(",:argPart,")"]
;   [linearFormat y for y in x]

(DEFUN |linearFormat| (|x|)
  (PROG (|op| |argl| |a| |l| |argPart|)
    (RETURN
     (COND ((ATOM |x|) |x|)
           ((AND (CONSP |x|)
                 (PROGN (SETQ |op| (CAR |x|)) (SETQ |argl| (CDR |x|)) #1='T)
                 (ATOM |op|))
            (PROGN
             (SETQ |argPart|
                     (COND
                      ((AND (CONSP |argl|)
                            (PROGN
                             (SETQ |a| (CAR |argl|))
                             (SETQ |l| (CDR |argl|))
                             #1#))
                       (CONS |a|
                             ((LAMBDA (|bfVar#65| |bfVar#64| |x|)
                                (LOOP
                                 (COND
                                  ((OR (ATOM |bfVar#64|)
                                       (PROGN (SETQ |x| (CAR |bfVar#64|)) NIL))
                                   (RETURN |bfVar#65|))
                                  (#1#
                                   (SETQ |bfVar#65|
                                           (APPEND |bfVar#65|
                                                   (LIST '|,| |x|)))))
                                 (SETQ |bfVar#64| (CDR |bfVar#64|))))
                              NIL |l| NIL)))
                      (#1# NIL)))
             (CONS |op| (CONS '|(| (APPEND |argPart| (CONS '|)| NIL))))))
           (#1#
            ((LAMBDA (|bfVar#67| |bfVar#66| |y|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#66|)
                      (PROGN (SETQ |y| (CAR |bfVar#66|)) NIL))
                  (RETURN (NREVERSE |bfVar#67|)))
                 (#1#
                  (SETQ |bfVar#67| (CONS (|linearFormat| |y|) |bfVar#67|))))
                (SETQ |bfVar#66| (CDR |bfVar#66|))))
             NIL |x| NIL))))))

; formTuple2String argl ==
;   null argl => nil
;   string:= form2StringLocal first argl
;   for x in rest argl repeat
;     string:= concat(string,concat(",",form2StringLocal x))
;   string

(DEFUN |formTuple2String| (|argl|)
  (PROG (|string|)
    (RETURN
     (COND ((NULL |argl|) NIL)
           (#1='T
            (PROGN
             (SETQ |string| (|form2StringLocal| (CAR |argl|)))
             ((LAMBDA (|bfVar#68| |x|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#68|)
                       (PROGN (SETQ |x| (CAR |bfVar#68|)) NIL))
                   (RETURN NIL))
                  (#1#
                   (SETQ |string|
                           (|concat| |string|
                            (|concat| '|,| (|form2StringLocal| |x|))))))
                 (SETQ |bfVar#68| (CDR |bfVar#68|))))
              (CDR |argl|) NIL)
             |string|))))))

; isInternalFunctionName(op) ==
;   (not IDENTP(op)) or (op = "*") or (op = "**") => NIL
;   (1 = SIZE(op':= PNAME op)) or (char("*") ~= op'.0) => NIL
;   -- if there is a semicolon in the name then it is the name of
;   -- a compiled spad function
;   null (e := STRPOS('"_;",op',1,NIL)) => NIL
;   (char(" ") = (y := op'.1)) or (char("*") = y) => NIL
;   table := MAKETRTTABLE('"0123456789",NIL)
;   s := STRPOSL(table,op',1,true)
;   null(s) or s > e => NIL
;   SUBSTRING(op',s,e-s)

(DEFUN |isInternalFunctionName| (|op|)
  (PROG (|op'| |e| |y| |table| |s|)
    (RETURN
     (COND ((OR (NULL (IDENTP |op|)) (EQ |op| '*) (EQ |op| '**)) NIL)
           ((OR (EQL 1 (SIZE (SETQ |op'| (PNAME |op|))))
                (NOT (EQUAL (|char| '*) (ELT |op'| 0))))
            NIL)
           ((NULL (SETQ |e| (STRPOS ";" |op'| 1 NIL))) NIL)
           ((OR (EQUAL (|char| '| |) (SETQ |y| (ELT |op'| 1)))
                (EQUAL (|char| '*) |y|))
            NIL)
           (#1='T
            (PROGN
             (SETQ |table| (MAKETRTTABLE "0123456789" NIL))
             (SETQ |s| (STRPOSL |table| |op'| 1 T))
             (COND ((OR (NULL |s|) (< |e| |s|)) NIL)
                   (#1# (SUBSTRING |op'| |s| (- |e| |s|))))))))))

; application2String(op,argl, linkInfo) ==
;   op is ["$elt", t, f] =>
;       concat(application2String(f, argl, linkInfo), '"$", _
;              form2String1 t)
;   null argl =>
;     res1 :=
;        (op' := isInternalFunctionName(op)) => op'
;        app2StringWrap(formWrapId op, linkInfo)
;     $from_unparse => concat(res1,'"()")
;     res1
;   1=#argl =>
;     first argl is ["<",:.] => concat(op,first argl)
;     concat(app2StringWrap(formWrapId op, linkInfo), '"(", first argl, '")")
;   op='SEGMENT =>
;     null argl => '".."
;     (null rest argl) or (null first rest argl) =>
;       concat(first argl, '"..")
;     concat('"(", first argl, concat('"..", first rest argl), '")")
;   concat(app2StringWrap(formWrapId op, linkInfo) ,
;                         concat("_(",concat(tuple2String argl,"_)")))

(DEFUN |application2String| (|op| |argl| |linkInfo|)
  (PROG (|ISTMP#1| |t| |ISTMP#2| |f| |op'| |res1|)
    (RETURN
     (COND
      ((AND (CONSP |op|) (EQ (CAR |op|) '|$elt|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |op|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |t| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |f| (CAR |ISTMP#2|)) #1='T))))))
       (|concat| (|application2String| |f| |argl| |linkInfo|) "$"
        (|form2String1| |t|)))
      ((NULL |argl|)
       (PROGN
        (SETQ |res1|
                (COND ((SETQ |op'| (|isInternalFunctionName| |op|)) |op'|)
                      (#1# (|app2StringWrap| (|formWrapId| |op|) |linkInfo|))))
        (COND (|$from_unparse| (|concat| |res1| "()")) (#1# |res1|))))
      ((EQL 1 (LENGTH |argl|))
       (COND
        ((PROGN
          (SETQ |ISTMP#1| (CAR |argl|))
          (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '<)))
         (|concat| |op| (CAR |argl|)))
        (#1#
         (|concat| (|app2StringWrap| (|formWrapId| |op|) |linkInfo|) "("
          (CAR |argl|) ")"))))
      ((EQ |op| 'SEGMENT)
       (COND ((NULL |argl|) "..")
             ((OR (NULL (CDR |argl|)) (NULL (CAR (CDR |argl|))))
              (|concat| (CAR |argl|) ".."))
             (#1#
              (|concat| "(" (CAR |argl|) (|concat| ".." (CAR (CDR |argl|)))
               ")"))))
      (#1#
       (|concat| (|app2StringWrap| (|formWrapId| |op|) |linkInfo|)
        (|concat| '|(| (|concat| (|tuple2String| |argl|) '|)|))))))))

; app2StringConcat0(x,y) ==
;   FORMAT(NIL, '"~a ~a", x, y)

(DEFUN |app2StringConcat0| (|x| |y|)
  (PROG () (RETURN (FORMAT NIL "~a ~a" |x| |y|))))

; app2StringWrap(string, linkInfo) == string

(DEFUN |app2StringWrap| (|string| |linkInfo|) (PROG () (RETURN |string|)))

; record2String x ==
;   argPart := NIL
;   for [":",a,b] in x repeat argPart:=
;     concat(argPart,",",a,": ",form2StringLocal b)
;   null argPart => '"Record()"
;   concat("Record_(",rest argPart,"_)")

(DEFUN |record2String| (|x|)
  (PROG (|argPart| |ISTMP#1| |a| |ISTMP#2| |b|)
    (RETURN
     (PROGN
      (SETQ |argPart| NIL)
      ((LAMBDA (|bfVar#70| |bfVar#69|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#70|)
                (PROGN (SETQ |bfVar#69| (CAR |bfVar#70|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#69|) (EQ (CAR |bfVar#69|) '|:|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |bfVar#69|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |a| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1#)))))
                 (SETQ |argPart|
                         (|concat| |argPart| '|,| |a| '|: |
                          (|form2StringLocal| |b|))))))
          (SETQ |bfVar#70| (CDR |bfVar#70|))))
       |x| NIL)
      (COND ((NULL |argPart|) "Record()")
            (#1# (|concat| '|Record(| (CDR |argPart|) '|)|)))))))

; plural(n,string) ==
;   suffix:=
;     n = 1 => '""
;     '"s"
;   [:bright n,string,suffix]

(DEFUN |plural| (|n| |string|)
  (PROG (|suffix|)
    (RETURN
     (PROGN
      (SETQ |suffix| (COND ((EQL |n| 1) "") ('T "s")))
      (APPEND (|bright| |n|) (CONS |string| (CONS |suffix| NIL)))))))

; formatIf pred ==
;   not pred => nil
;   pred in '(T (QUOTE T)) => nil
;   concat('%b,'"if",'%d,pred2English pred)

(DEFUN |formatIf| (|pred|)
  (PROG ()
    (RETURN
     (COND ((NULL |pred|) NIL) ((|member| |pred| '(T 'T)) NIL)
           ('T (|concat| '|%b| "if" '|%d| (|pred2English| |pred|)))))))

; formatPredParts s ==
;   s is ['QUOTE,s1] => formatPredParts s1
;   s is ['LIST,:s1] => [formatPredParts s2 for s2 in s1]
;   s is ['devaluate,s1] => formatPredParts s1
;   s is ['getDomainView,s1,.] => formatPredParts s1
;   s is ['SUBST,a,b,c] =>    -- this is a signature
;     BREAK()
;     s1 := formatPredParts substitute(formatPredParts a,b,c)
;     s1 isnt [fun,sig] => s1
;     ['SIGNATURE,fun,[formatPredParts(r) for r in sig]]
;   s

(DEFUN |formatPredParts| (|s|)
  (PROG (|ISTMP#1| |s1| |ISTMP#2| |a| |b| |ISTMP#3| |c| |fun| |sig|)
    (RETURN
     (COND
      ((AND (CONSP |s|) (EQ (CAR |s|) 'QUOTE)
            (PROGN
             (SETQ |ISTMP#1| (CDR |s|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |s1| (CAR |ISTMP#1|)) #1='T))))
       (|formatPredParts| |s1|))
      ((AND (CONSP |s|) (EQ (CAR |s|) 'LIST) (PROGN (SETQ |s1| (CDR |s|)) #1#))
       ((LAMBDA (|bfVar#72| |bfVar#71| |s2|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#71|) (PROGN (SETQ |s2| (CAR |bfVar#71|)) NIL))
             (RETURN (NREVERSE |bfVar#72|)))
            (#1# (SETQ |bfVar#72| (CONS (|formatPredParts| |s2|) |bfVar#72|))))
           (SETQ |bfVar#71| (CDR |bfVar#71|))))
        NIL |s1| NIL))
      ((AND (CONSP |s|) (EQ (CAR |s|) '|devaluate|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |s|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |s1| (CAR |ISTMP#1|)) #1#))))
       (|formatPredParts| |s1|))
      ((AND (CONSP |s|) (EQ (CAR |s|) '|getDomainView|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |s|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |s1| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL))))))
       (|formatPredParts| |s1|))
      ((AND (CONSP |s|) (EQ (CAR |s|) 'SUBST)
            (PROGN
             (SETQ |ISTMP#1| (CDR |s|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |a| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|)
                        (PROGN
                         (SETQ |b| (CAR |ISTMP#2|))
                         (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                         (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                              (PROGN (SETQ |c| (CAR |ISTMP#3|)) #1#))))))))
       (PROGN
        (BREAK)
        (SETQ |s1|
                (|formatPredParts|
                 (|substitute| (|formatPredParts| |a|) |b| |c|)))
        (COND
         ((NOT
           (AND (CONSP |s1|)
                (PROGN
                 (SETQ |fun| (CAR |s1|))
                 (SETQ |ISTMP#1| (CDR |s1|))
                 (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                      (PROGN (SETQ |sig| (CAR |ISTMP#1|)) #1#)))))
          |s1|)
         (#1#
          (LIST 'SIGNATURE |fun|
                ((LAMBDA (|bfVar#74| |bfVar#73| |r|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#73|)
                          (PROGN (SETQ |r| (CAR |bfVar#73|)) NIL))
                      (RETURN (NREVERSE |bfVar#74|)))
                     (#1#
                      (SETQ |bfVar#74|
                              (CONS (|formatPredParts| |r|) |bfVar#74|))))
                    (SETQ |bfVar#73| (CDR |bfVar#73|))))
                 NIL |sig| NIL))))))
      (#1# |s|)))))

; form_to_abbrev(x) ==
;     $abbreviateTypes : local := true
;     form2String(x)

(DEFUN |form_to_abbrev| (|x|)
  (PROG (|$abbreviateTypes|)
    (DECLARE (SPECIAL |$abbreviateTypes|))
    (RETURN (PROGN (SETQ |$abbreviateTypes| T) (|form2String| |x|)))))

; pred2English x ==
;   x is ['IF,cond,thenClause,elseClause] =>
;     c := concat('"if ",pred2English cond)
;     t := concat('" then ",pred2English thenClause)
;     e := concat('" else ",pred2English elseClause)
;     concat(c,t,e)
;   x is ['AND,:l] =>
;     tail:="append"/[concat(bright '"and",pred2English x) for x in rest l]
;     concat(pred2English first l,tail)
;   x is ['OR,:l] =>
;     tail:= "append"/[concat(bright '"or",pred2English x) for x in rest l]
;     concat(pred2English first l,tail)
;   x is ['not, l] =>
;     concat('"not ",pred2English l)
;   x is [op,a,b] and op in '(has ofCategory) =>
;     concat(pred2English a, '%b, '"has",'%d, form_to_abbrev b)
;   x is [op,a,b] and op in '(HasSignature HasCategory) =>
;     concat(prefix2String0 formatPredParts a,'%b,'"has",'%d,
;       prefix2String0 formatPredParts b)
;   x is [op,a,b] and op in '(ofType getDomainView) =>
;     if b is ['QUOTE,b'] then b := b'
;     concat(pred2English a, '": ", form_to_abbrev b)
;   x is [op,a,b] and op in '(isDomain domainEqual) =>
;     concat(pred2English a, '" = ", form_to_abbrev b)
;   x is [op,:.] and (translation := LASSOC(op,'(
;     (_< . " < ") (_<_= . " <= ")
;       (_> . " > ") (_>_= . " >= ") (_=  . " = ") (_^_= . " _^_= ")))) =>
;         concat(pred2English a,translation,pred2English b)
;   x is ['ATTRIBUTE, form] => BREAK()
;   x is '$ => '"%%"
;   form2String x

(DEFUN |pred2English| (|x|)
  (PROG (|ISTMP#1| |cond| |ISTMP#2| |thenClause| |ISTMP#3| |elseClause| |c| |t|
         |e| |l| |tail| |op| |a| |b| |b'| |translation| |form|)
    (RETURN
     (COND
      ((AND (CONSP |x|) (EQ (CAR |x|) 'IF)
            (PROGN
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |cond| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|)
                        (PROGN
                         (SETQ |thenClause| (CAR |ISTMP#2|))
                         (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                         (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                              (PROGN
                               (SETQ |elseClause| (CAR |ISTMP#3|))
                               #1='T))))))))
       (PROGN
        (SETQ |c| (|concat| "if " (|pred2English| |cond|)))
        (SETQ |t| (|concat| " then " (|pred2English| |thenClause|)))
        (SETQ |e| (|concat| " else " (|pred2English| |elseClause|)))
        (|concat| |c| |t| |e|)))
      ((AND (CONSP |x|) (EQ (CAR |x|) 'AND) (PROGN (SETQ |l| (CDR |x|)) #1#))
       (PROGN
        (SETQ |tail|
                ((LAMBDA (|bfVar#76| |bfVar#75| |x|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#75|)
                          (PROGN (SETQ |x| (CAR |bfVar#75|)) NIL))
                      (RETURN |bfVar#76|))
                     (#1#
                      (SETQ |bfVar#76|
                              (APPEND |bfVar#76|
                                      (|concat| (|bright| "and")
                                       (|pred2English| |x|))))))
                    (SETQ |bfVar#75| (CDR |bfVar#75|))))
                 NIL (CDR |l|) NIL))
        (|concat| (|pred2English| (CAR |l|)) |tail|)))
      ((AND (CONSP |x|) (EQ (CAR |x|) 'OR) (PROGN (SETQ |l| (CDR |x|)) #1#))
       (PROGN
        (SETQ |tail|
                ((LAMBDA (|bfVar#78| |bfVar#77| |x|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#77|)
                          (PROGN (SETQ |x| (CAR |bfVar#77|)) NIL))
                      (RETURN |bfVar#78|))
                     (#1#
                      (SETQ |bfVar#78|
                              (APPEND |bfVar#78|
                                      (|concat| (|bright| "or")
                                       (|pred2English| |x|))))))
                    (SETQ |bfVar#77| (CDR |bfVar#77|))))
                 NIL (CDR |l|) NIL))
        (|concat| (|pred2English| (CAR |l|)) |tail|)))
      ((AND (CONSP |x|) (EQ (CAR |x|) '|not|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |l| (CAR |ISTMP#1|)) #1#))))
       (|concat| "not " (|pred2English| |l|)))
      ((AND (CONSP |x|)
            (PROGN
             (SETQ |op| (CAR |x|))
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |a| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1#)))))
            (|member| |op| '(|has| |ofCategory|)))
       (|concat| (|pred2English| |a|) '|%b| "has" '|%d|
        (|form_to_abbrev| |b|)))
      ((AND (CONSP |x|)
            (PROGN
             (SETQ |op| (CAR |x|))
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |a| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1#)))))
            (|member| |op| '(|HasSignature| |HasCategory|)))
       (|concat| (|prefix2String0| (|formatPredParts| |a|)) '|%b| "has" '|%d|
        (|prefix2String0| (|formatPredParts| |b|))))
      ((AND (CONSP |x|)
            (PROGN
             (SETQ |op| (CAR |x|))
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |a| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1#)))))
            (|member| |op| '(|ofType| |getDomainView|)))
       (PROGN
        (COND
         ((AND (CONSP |b|) (EQ (CAR |b|) 'QUOTE)
               (PROGN
                (SETQ |ISTMP#1| (CDR |b|))
                (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                     (PROGN (SETQ |b'| (CAR |ISTMP#1|)) #1#))))
          (SETQ |b| |b'|)))
        (|concat| (|pred2English| |a|) ": " (|form_to_abbrev| |b|))))
      ((AND (CONSP |x|)
            (PROGN
             (SETQ |op| (CAR |x|))
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |a| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1#)))))
            (|member| |op| '(|isDomain| |domainEqual|)))
       (|concat| (|pred2English| |a|) " = " (|form_to_abbrev| |b|)))
      ((AND (CONSP |x|) (PROGN (SETQ |op| (CAR |x|)) #1#)
            (SETQ |translation|
                    (LASSOC |op|
                     '((< . " < ") (<= . " <= ") (> . " > ") (>= . " >= ")
                       (= . " = ") (^= . " ^= ")))))
       (|concat| (|pred2English| |a|) |translation| (|pred2English| |b|)))
      ((AND (CONSP |x|) (EQ (CAR |x|) 'ATTRIBUTE)
            (PROGN
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |form| (CAR |ISTMP#1|)) #1#))))
       (BREAK))
      ((EQ |x| '$) "%%") (#1# (|form2String| |x|))))))

; mathObject2String x ==
;   CHARACTERP x => COERCE([x],'STRING)
;   object2String x

(DEFUN |mathObject2String| (|x|)
  (PROG ()
    (RETURN
     (COND ((CHARACTERP |x|) (COERCE (LIST |x|) 'STRING))
           ('T (|object2String| |x|))))))

; object2String x ==
;   STRINGP x => x
;   IDENTP x  => PNAME x
;   NULL x    => '""
;   PAIRP  x  => STRCONC(object2String first x, object2String rest x)
;   WRITE_-TO_-STRING x

(DEFUN |object2String| (|x|)
  (PROG ()
    (RETURN
     (COND ((STRINGP |x|) |x|) ((IDENTP |x|) (PNAME |x|)) ((NULL |x|) "")
           ((CONSP |x|)
            (STRCONC (|object2String| (CAR |x|)) (|object2String| (CDR |x|))))
           ('T (WRITE-TO-STRING |x|))))))

; object2Identifier x ==
;   IDENTP x  => x
;   STRINGP x => INTERN x
;   INTERN WRITE_-TO_-STRING x

(DEFUN |object2Identifier| (|x|)
  (PROG ()
    (RETURN
     (COND ((IDENTP |x|) |x|) ((STRINGP |x|) (INTERN |x|))
           ('T (INTERN (WRITE-TO-STRING |x|)))))))

; blankList x == "append"/[[BLANK,y] for y in x]

(DEFUN |blankList| (|x|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#80| |bfVar#79| |y|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#79|) (PROGN (SETQ |y| (CAR |bfVar#79|)) NIL))
           (RETURN |bfVar#80|))
          ('T (SETQ |bfVar#80| (APPEND |bfVar#80| (LIST BLANK |y|)))))
         (SETQ |bfVar#79| (CDR |bfVar#79|))))
      NIL |x| NIL))))

; string2Float s ==
;   -- takes a string, calls the parser on it and returns a float object
;   p := ncParseFromString s
;   p isnt [["$elt", FloatDomain, "float"], x, y, z] =>
;     systemError '"string2Float: did not get a float expression"
;   flt := getFunctionFromDomain("float", FloatDomain,
;     [$Integer, $Integer, $PositiveInteger])
;   SPADCALL(x, y, z, flt)

(DEFUN |string2Float| (|s|)
  (PROG (|p| |ISTMP#1| |ISTMP#2| |FloatDomain| |ISTMP#3| |ISTMP#4| |x|
         |ISTMP#5| |y| |ISTMP#6| |z| |flt|)
    (RETURN
     (PROGN
      (SETQ |p| (|ncParseFromString| |s|))
      (COND
       ((NOT
         (AND (CONSP |p|)
              (PROGN
               (SETQ |ISTMP#1| (CAR |p|))
               (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|$elt|)
                    (PROGN
                     (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                     (AND (CONSP |ISTMP#2|)
                          (PROGN
                           (SETQ |FloatDomain| (CAR |ISTMP#2|))
                           (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                           (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                                (EQ (CAR |ISTMP#3|) '|float|)))))))
              (PROGN
               (SETQ |ISTMP#4| (CDR |p|))
               (AND (CONSP |ISTMP#4|)
                    (PROGN
                     (SETQ |x| (CAR |ISTMP#4|))
                     (SETQ |ISTMP#5| (CDR |ISTMP#4|))
                     (AND (CONSP |ISTMP#5|)
                          (PROGN
                           (SETQ |y| (CAR |ISTMP#5|))
                           (SETQ |ISTMP#6| (CDR |ISTMP#5|))
                           (AND (CONSP |ISTMP#6|) (EQ (CDR |ISTMP#6|) NIL)
                                (PROGN
                                 (SETQ |z| (CAR |ISTMP#6|))
                                 #1='T)))))))))
        (|systemError| "string2Float: did not get a float expression"))
       (#1#
        (PROGN
         (SETQ |flt|
                 (|getFunctionFromDomain| '|float| |FloatDomain|
                  (LIST |$Integer| |$Integer| |$PositiveInteger|)))
         (SPADCALL |x| |y| |z| |flt|))))))))

; form2Fence form ==
;   -- body of dbMkEvalable
;   [op, :.] := form
;   kind := GETDATABASE(op,'CONSTRUCTORKIND)
;   kind = 'category => form2Fence1 form
;   form2Fence1 mkEvalable form

(DEFUN |form2Fence| (|form|)
  (PROG (|op| |kind|)
    (RETURN
     (PROGN
      (SETQ |op| (CAR |form|))
      (SETQ |kind| (GETDATABASE |op| 'CONSTRUCTORKIND))
      (COND ((EQ |kind| '|category|) (|form2Fence1| |form|))
            ('T (|form2Fence1| (|mkEvalable| |form|))))))))

; form2Fence1 x ==
;   x is [op,:argl] =>
;     op = 'QUOTE => ['"(QUOTE ",:form2FenceQuote first argl,'")"]
;     ['"(", FORMAT(NIL, '"|~a|", op),:"append"/[form2Fence1 y for y in argl],'")"]
;   x = "$" => ["%"]
;   IDENTP x => [FORMAT(NIL, '"|~a|", x)]
; --  [x]
;   ['"  ", x]

(DEFUN |form2Fence1| (|x|)
  (PROG (|op| |argl|)
    (RETURN
     (COND
      ((AND (CONSP |x|)
            (PROGN (SETQ |op| (CAR |x|)) (SETQ |argl| (CDR |x|)) #1='T))
       (COND
        ((EQ |op| 'QUOTE)
         (CONS "(QUOTE "
               (APPEND (|form2FenceQuote| (CAR |argl|)) (CONS ")" NIL))))
        (#1#
         (CONS "("
               (CONS (FORMAT NIL "|~a|" |op|)
                     (APPEND
                      ((LAMBDA (|bfVar#82| |bfVar#81| |y|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#81|)
                                (PROGN (SETQ |y| (CAR |bfVar#81|)) NIL))
                            (RETURN |bfVar#82|))
                           (#1#
                            (SETQ |bfVar#82|
                                    (APPEND |bfVar#82| (|form2Fence1| |y|)))))
                          (SETQ |bfVar#81| (CDR |bfVar#81|))))
                       NIL |argl| NIL)
                      (CONS ")" NIL)))))))
      ((EQ |x| '$) (LIST '%)) ((IDENTP |x|) (LIST (FORMAT NIL "|~a|" |x|)))
      (#1# (LIST "  " |x|))))))

; form2FenceQuote x ==
;   NUMBERP x => [STRINGIMAGE x]
;   SYMBOLP x => [FORMAT(NIL, '"|~a|", x)]
;   atom    x => ['"??"]
;   ['"(",:form2FenceQuote first x,:form2FenceQuoteTail rest x]

(DEFUN |form2FenceQuote| (|x|)
  (PROG ()
    (RETURN
     (COND ((NUMBERP |x|) (LIST (STRINGIMAGE |x|)))
           ((SYMBOLP |x|) (LIST (FORMAT NIL "|~a|" |x|)))
           ((ATOM |x|) (LIST "??"))
           ('T
            (CONS "("
                  (APPEND (|form2FenceQuote| (CAR |x|))
                          (|form2FenceQuoteTail| (CDR |x|)))))))))

; form2FenceQuoteTail x ==
;   null x => ['")"]
;   atom x => ['" . ",:form2FenceQuote x,'")"]
;   ['" ",:form2FenceQuote first x,:form2FenceQuoteTail rest x]

(DEFUN |form2FenceQuoteTail| (|x|)
  (PROG ()
    (RETURN
     (COND ((NULL |x|) (LIST ")"))
           ((ATOM |x|)
            (CONS " . " (APPEND (|form2FenceQuote| |x|) (CONS ")" NIL))))
           ('T
            (CONS " "
                  (APPEND (|form2FenceQuote| (CAR |x|))
                          (|form2FenceQuoteTail| (CDR |x|)))))))))

; form2StringList u ==
;   atom (r := form2String u) => [r]
;   r

(DEFUN |form2StringList| (|u|)
  (PROG (|r|)
    (RETURN
     (COND ((ATOM (SETQ |r| (|form2String| |u|))) (LIST |r|)) ('T |r|)))))
