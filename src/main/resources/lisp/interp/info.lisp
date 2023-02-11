
; )package "BOOT"

(IN-PACKAGE "BOOT")

; printInfo e ==
;   for u in get("$Information", "special", e) repeat PRETTYPRINT u
;   nil

(DEFUN |printInfo| (|e|)
  (PROG ()
    (RETURN
     (PROGN
      ((LAMBDA (|bfVar#1| |u|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#1|) (PROGN (SETQ |u| (CAR |bfVar#1|)) NIL))
            (RETURN NIL))
           ('T (PRETTYPRINT |u|)))
          (SETQ |bfVar#1| (CDR |bfVar#1|))))
       (|get| '|$Information| '|special| |e|) NIL)
      NIL))))

; addInformation(m, e) ==
;   ni := info(m, []) where
;     info(m, il) ==
;       --Processes information from a mode declaration in compCapsule
;       atom m => il
;       m is ["CATEGORY", ., :stuff] =>
;           for u in stuff repeat il := addInfo(u, il)
;           il
;       m is ["Join",:stuff] =>
;           for u in stuff repeat il := info(u, il)
;           il
;       il
;   put("$Information", "special", [:ni,
;         :get("$Information", "special", e)], e)
;   e

(DEFUN |addInformation| (|m| |e|)
  (PROG (|ni|)
    (RETURN
     (PROGN
      (SETQ |ni| (|addInformation,info| |m| NIL))
      (|put| '|$Information| '|special|
       (APPEND |ni| (|get| '|$Information| '|special| |e|)) |e|)
      |e|))))
(DEFUN |addInformation,info| (|m| |il|)
  (PROG (|ISTMP#1| |stuff|)
    (RETURN
     (COND ((ATOM |m|) |il|)
           ((AND (CONSP |m|) (EQ (CAR |m|) 'CATEGORY)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |m|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN (SETQ |stuff| (CDR |ISTMP#1|)) #1='T))))
            (PROGN
             ((LAMBDA (|bfVar#2| |u|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#2|) (PROGN (SETQ |u| (CAR |bfVar#2|)) NIL))
                   (RETURN NIL))
                  (#1# (SETQ |il| (|addInfo| |u| |il|))))
                 (SETQ |bfVar#2| (CDR |bfVar#2|))))
              |stuff| NIL)
             |il|))
           ((AND (CONSP |m|) (EQ (CAR |m|) '|Join|)
                 (PROGN (SETQ |stuff| (CDR |m|)) #1#))
            (PROGN
             ((LAMBDA (|bfVar#3| |u|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#3|) (PROGN (SETQ |u| (CAR |bfVar#3|)) NIL))
                   (RETURN NIL))
                  (#1# (SETQ |il| (|addInformation,info| |u| |il|))))
                 (SETQ |bfVar#3| (CDR |bfVar#3|))))
              |stuff| NIL)
             |il|))
           (#1# |il|)))))

; addInfo(u, il) == [formatInfo u, :il]

(DEFUN |addInfo| (|u| |il|) (PROG () (RETURN (CONS (|formatInfo| |u|) |il|))))

; formatInfo u ==
;   atom u => u
;   u is ["SIGNATURE",:v] => ["SIGNATURE","$",:v]
;   u is ["PROGN",:l] => ["PROGN",:[formatInfo v for v in l]]
;   u is ["ATTRIBUTE", v] =>
;       isCategoryForm(v) => ["has", "$", v]
;       BREAK()
;   u is ["IF",a,b,c] =>
;     c="noBranch" => ["COND",:liftCond [formatPred a,formatInfo b]]
;     b="noBranch" => ["COND",:liftCond [["not",formatPred a],formatInfo c]]
;     ["COND",:liftCond [formatPred a,formatInfo b],:
;       liftCond [["not",formatPred a],formatInfo c]]
;   systemError '"formatInfo"

(DEFUN |formatInfo| (|u|)
  (PROG (|v| |l| |ISTMP#1| |a| |ISTMP#2| |b| |ISTMP#3| |c|)
    (RETURN
     (COND ((ATOM |u|) |u|)
           ((AND (CONSP |u|) (EQ (CAR |u|) 'SIGNATURE)
                 (PROGN (SETQ |v| (CDR |u|)) #1='T))
            (CONS 'SIGNATURE (CONS '$ |v|)))
           ((AND (CONSP |u|) (EQ (CAR |u|) 'PROGN)
                 (PROGN (SETQ |l| (CDR |u|)) #1#))
            (CONS 'PROGN
                  ((LAMBDA (|bfVar#5| |bfVar#4| |v|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#4|)
                            (PROGN (SETQ |v| (CAR |bfVar#4|)) NIL))
                        (RETURN (NREVERSE |bfVar#5|)))
                       (#1#
                        (SETQ |bfVar#5| (CONS (|formatInfo| |v|) |bfVar#5|))))
                      (SETQ |bfVar#4| (CDR |bfVar#4|))))
                   NIL |l| NIL)))
           ((AND (CONSP |u|) (EQ (CAR |u|) 'ATTRIBUTE)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |u|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                       (PROGN (SETQ |v| (CAR |ISTMP#1|)) #1#))))
            (COND ((|isCategoryForm| |v|) (LIST '|has| '$ |v|)) (#1# (BREAK))))
           ((AND (CONSP |u|) (EQ (CAR |u|) 'IF)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |u|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |a| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|)
                             (PROGN
                              (SETQ |b| (CAR |ISTMP#2|))
                              (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                              (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                                   (PROGN
                                    (SETQ |c| (CAR |ISTMP#3|))
                                    #1#))))))))
            (COND
             ((EQ |c| '|noBranch|)
              (CONS 'COND
                    (|liftCond| (LIST (|formatPred| |a|) (|formatInfo| |b|)))))
             ((EQ |b| '|noBranch|)
              (CONS 'COND
                    (|liftCond|
                     (LIST (LIST '|not| (|formatPred| |a|))
                           (|formatInfo| |c|)))))
             (#1#
              (CONS 'COND
                    (APPEND
                     (|liftCond| (LIST (|formatPred| |a|) (|formatInfo| |b|)))
                     (|liftCond|
                      (LIST (LIST '|not| (|formatPred| |a|))
                            (|formatInfo| |c|))))))))
           (#1# (|systemError| "formatInfo"))))))

; liftCond (clause is [ante,conseq]) ==
;   conseq is ["COND",:l] =>
;     [[lcAnd(ante,a),:b] for [a,:b] in l] where
;       lcAnd(pred,conj) ==
;         conj is ["and",:ll] => ["and",pred,:ll]
;         ["and",pred,conj]
;   [clause]

(DEFUN |liftCond| (|clause|)
  (PROG (|ante| |conseq| |l| |a| |b|)
    (RETURN
     (PROGN
      (SETQ |ante| (CAR |clause|))
      (SETQ |conseq| (CADR |clause|))
      (COND
       ((AND (CONSP |conseq|) (EQ (CAR |conseq|) 'COND)
             (PROGN (SETQ |l| (CDR |conseq|)) #1='T))
        ((LAMBDA (|bfVar#8| |bfVar#7| |bfVar#6|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#7|)
                  (PROGN (SETQ |bfVar#6| (CAR |bfVar#7|)) NIL))
              (RETURN (NREVERSE |bfVar#8|)))
             (#1#
              (AND (CONSP |bfVar#6|)
                   (PROGN
                    (SETQ |a| (CAR |bfVar#6|))
                    (SETQ |b| (CDR |bfVar#6|))
                    #1#)
                   (SETQ |bfVar#8|
                           (CONS (CONS (|liftCond,lcAnd| |ante| |a|) |b|)
                                 |bfVar#8|)))))
            (SETQ |bfVar#7| (CDR |bfVar#7|))))
         NIL |l| NIL))
       (#1# (LIST |clause|)))))))
(DEFUN |liftCond,lcAnd| (|pred| |conj|)
  (PROG (|ll|)
    (RETURN
     (COND
      ((AND (CONSP |conj|) (EQ (CAR |conj|) '|and|)
            (PROGN (SETQ |ll| (CDR |conj|)) #1='T))
       (CONS '|and| (CONS |pred| |ll|)))
      (#1# (LIST '|and| |pred| |conj|))))))

; formatPred u ==
;          --Assumes that $e is set up to point to an environment
;   u is ["has",a,b] =>
;     atom b and isCategoryForm([b]) => ["has", a, [b]]
;     atom b => BREAK()
;     isCategoryForm(b) => u
;     b is ["ATTRIBUTE",.] => BREAK()
;     b is ["SIGNATURE",:.] => u
;     BREAK()
;   atom u => u
;   u is ["and",:v] => ["and",:[formatPred w for w in v]]
;   systemError '"formatPred"

(DEFUN |formatPred| (|u|)
  (PROG (|ISTMP#1| |a| |ISTMP#2| |b| |v|)
    (RETURN
     (COND
      ((AND (CONSP |u|) (EQ (CAR |u|) '|has|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |u|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |a| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1='T))))))
       (COND
        ((AND (ATOM |b|) (|isCategoryForm| (LIST |b|)))
         (LIST '|has| |a| (LIST |b|)))
        ((ATOM |b|) (BREAK)) ((|isCategoryForm| |b|) |u|)
        ((AND (CONSP |b|) (EQ (CAR |b|) 'ATTRIBUTE)
              (PROGN
               (SETQ |ISTMP#1| (CDR |b|))
               (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL))))
         (BREAK))
        ((AND (CONSP |b|) (EQ (CAR |b|) 'SIGNATURE)) |u|) (#1# (BREAK))))
      ((ATOM |u|) |u|)
      ((AND (CONSP |u|) (EQ (CAR |u|) '|and|) (PROGN (SETQ |v| (CDR |u|)) #1#))
       (CONS '|and|
             ((LAMBDA (|bfVar#10| |bfVar#9| |w|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#9|) (PROGN (SETQ |w| (CAR |bfVar#9|)) NIL))
                   (RETURN (NREVERSE |bfVar#10|)))
                  (#1# (SETQ |bfVar#10| (CONS (|formatPred| |w|) |bfVar#10|))))
                 (SETQ |bfVar#9| (CDR |bfVar#9|))))
              NIL |v| NIL)))
      (#1# (|systemError| "formatPred"))))))

; chaseInferences(pred, $info_e) ==
;   foo(hasToInfo(pred)) where
;     foo(pred) ==
;       knownInfo pred => nil
;       $info_e := actOnInfo(pred, $info_e)
;       pred:= infoToHas pred
;       for u in get("$Information", "special", $info_e) repeat
;         u is ["COND",:l] =>
;           for [ante,:conseq] in l repeat
;             ante=pred => [foo w for w in conseq]
;             ante is ["and",:ante'] and member(pred,ante') =>
;               ante':= delete(pred,ante')
;               v':=
;                 LENGTH ante'=1 => first ante'
;                 ["and",:ante']
;               v':= ["COND",[v',:conseq]]
;               member(v', get("$Information", "special", $info_e)) => nil
;               $info_e :=
;                 put("$Information", "special", [v',:
;                   get("$Information", "special", $info_e)], $info_e)
;             nil
;   $info_e

(DEFUN |chaseInferences| (|pred| |$info_e|)
  (DECLARE (SPECIAL |$info_e|))
  (PROG ()
    (RETURN (PROGN (|chaseInferences,foo| (|hasToInfo| |pred|)) |$info_e|))))
(DEFUN |chaseInferences,foo| (|pred|)
  (PROG (|l| |ante| |conseq| |ante'| |v'|)
    (RETURN
     (COND ((|knownInfo| |pred|) NIL)
           (#1='T
            (PROGN
             (SETQ |$info_e| (|actOnInfo| |pred| |$info_e|))
             (SETQ |pred| (|infoToHas| |pred|))
             ((LAMBDA (|bfVar#11| |u|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#11|)
                       (PROGN (SETQ |u| (CAR |bfVar#11|)) NIL))
                   (RETURN NIL))
                  (#1#
                   (COND
                    ((AND (CONSP |u|) (EQ (CAR |u|) 'COND)
                          (PROGN (SETQ |l| (CDR |u|)) #1#))
                     (IDENTITY
                      ((LAMBDA (|bfVar#13| |bfVar#12|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#13|)
                                (PROGN (SETQ |bfVar#12| (CAR |bfVar#13|)) NIL))
                            (RETURN NIL))
                           (#1#
                            (AND (CONSP |bfVar#12|)
                                 (PROGN
                                  (SETQ |ante| (CAR |bfVar#12|))
                                  (SETQ |conseq| (CDR |bfVar#12|))
                                  #1#)
                                 (COND
                                  ((EQUAL |ante| |pred|)
                                   ((LAMBDA (|bfVar#15| |bfVar#14| |w|)
                                      (LOOP
                                       (COND
                                        ((OR (ATOM |bfVar#14|)
                                             (PROGN
                                              (SETQ |w| (CAR |bfVar#14|))
                                              NIL))
                                         (RETURN (NREVERSE |bfVar#15|)))
                                        (#1#
                                         (SETQ |bfVar#15|
                                                 (CONS
                                                  (|chaseInferences,foo| |w|)
                                                  |bfVar#15|))))
                                       (SETQ |bfVar#14| (CDR |bfVar#14|))))
                                    NIL |conseq| NIL))
                                  ((AND (CONSP |ante|) (EQ (CAR |ante|) '|and|)
                                        (PROGN (SETQ |ante'| (CDR |ante|)) #1#)
                                        (|member| |pred| |ante'|))
                                   (PROGN
                                    (SETQ |ante'| (|delete| |pred| |ante'|))
                                    (SETQ |v'|
                                            (COND
                                             ((EQL (LENGTH |ante'|) 1)
                                              (CAR |ante'|))
                                             (#1# (CONS '|and| |ante'|))))
                                    (SETQ |v'|
                                            (LIST 'COND (CONS |v'| |conseq|)))
                                    (COND
                                     ((|member| |v'|
                                       (|get| '|$Information| '|special|
                                        |$info_e|))
                                      NIL)
                                     (#1#
                                      (SETQ |$info_e|
                                              (|put| '|$Information| '|special|
                                               (CONS |v'|
                                                     (|get| '|$Information|
                                                      '|special| |$info_e|))
                                               |$info_e|))))))
                                  (#1# NIL)))))
                          (SETQ |bfVar#13| (CDR |bfVar#13|))))
                       |l| NIL))))))
                 (SETQ |bfVar#11| (CDR |bfVar#11|))))
              (|get| '|$Information| '|special| |$info_e|) NIL)))))))

; hasToInfo (pred is ["has",a,b]) ==
;   b is ["SIGNATURE",:data] => ["SIGNATURE",a,:data]
;   b is ["ATTRIBUTE",c] => BREAK()
;   pred

(DEFUN |hasToInfo| (|pred|)
  (PROG (|a| |b| |data| |ISTMP#1| |c|)
    (RETURN
     (PROGN
      (SETQ |a| (CADR . #1=(|pred|)))
      (SETQ |b| (CADDR . #1#))
      (COND
       ((AND (CONSP |b|) (EQ (CAR |b|) 'SIGNATURE)
             (PROGN (SETQ |data| (CDR |b|)) #2='T))
        (CONS 'SIGNATURE (CONS |a| |data|)))
       ((AND (CONSP |b|) (EQ (CAR |b|) 'ATTRIBUTE)
             (PROGN
              (SETQ |ISTMP#1| (CDR |b|))
              (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                   (PROGN (SETQ |c| (CAR |ISTMP#1|)) #2#))))
        (BREAK))
       (#2# |pred|))))))

; infoToHas a ==
;   a is ["SIGNATURE",b,:data] => ["has",b,["SIGNATURE",:data]]
;   a is ["ATTRIBUTE",b,c] => BREAK()
;   a

(DEFUN |infoToHas| (|a|)
  (PROG (|ISTMP#1| |b| |data| |ISTMP#2| |c|)
    (RETURN
     (COND
      ((AND (CONSP |a|) (EQ (CAR |a|) 'SIGNATURE)
            (PROGN
             (SETQ |ISTMP#1| (CDR |a|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |b| (CAR |ISTMP#1|))
                   (SETQ |data| (CDR |ISTMP#1|))
                   #1='T))))
       (LIST '|has| |b| (CONS 'SIGNATURE |data|)))
      ((AND (CONSP |a|) (EQ (CAR |a|) 'ATTRIBUTE)
            (PROGN
             (SETQ |ISTMP#1| (CDR |a|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |b| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |c| (CAR |ISTMP#2|)) #1#))))))
       (BREAK))
      (#1# |a|)))))

; DEFPARAMETER($cycleMarker, GENSYM())

(DEFPARAMETER |$cycleMarker| (GENSYM))

; known_info_in_env(pred, $info_e) == knownInfo(pred)

(DEFUN |known_info_in_env| (|pred| |$info_e|)
  (DECLARE (SPECIAL |$info_e|))
  (PROG () (RETURN (|knownInfo| |pred|))))

; hashed_known_info(pred) ==
;     $infoHash : local := MAKE_HASHTABLE('EQUAL)
;     knownInfo pred

(DEFUN |hashed_known_info| (|pred|)
  (PROG (|$infoHash|)
    (DECLARE (SPECIAL |$infoHash|))
    (RETURN
     (PROGN (SETQ |$infoHash| (MAKE_HASHTABLE 'EQUAL)) (|knownInfo| |pred|)))))

; knownInfo pred ==
;                --true %if the information is already known
;   pred=true => true
;   --pred = "true" => true
;   member(pred, get("$Information", "special", $info_e)) => true
;   not($infoHash) => hashed_known_info(pred)
;   ress := HGET($infoHash, pred) =>
;       ress = $cycleMarker => nil
;       ress
;   -- avoid cycles
;   HPUT($infoHash, pred, $cycleMarker)
;   ress := knownInfo1 pred
;   HPUT($infoHash, pred, ress)
;   ress

(DEFUN |knownInfo| (|pred|)
  (PROG (|ress|)
    (RETURN
     (COND ((EQUAL |pred| T) T)
           ((|member| |pred| (|get| '|$Information| '|special| |$info_e|)) T)
           ((NULL |$infoHash|) (|hashed_known_info| |pred|))
           ((SETQ |ress| (HGET |$infoHash| |pred|))
            (COND ((EQUAL |ress| |$cycleMarker|) NIL) (#1='T |ress|)))
           (#1#
            (PROGN
             (HPUT |$infoHash| |pred| |$cycleMarker|)
             (SETQ |ress| (|knownInfo1| |pred|))
             (HPUT |$infoHash| |pred| |ress|)
             |ress|))))))

; get_catlist(vmode, e) ==
;     -- FIXME: setting $compForModeIfTrue should be not needed
;     $compForModeIfTrue : local := true
;     compMakeCategoryObject(vmode, e)

(DEFUN |get_catlist| (|vmode| |e|)
  (PROG (|$compForModeIfTrue|)
    (DECLARE (SPECIAL |$compForModeIfTrue|))
    (RETURN
     (PROGN
      (SETQ |$compForModeIfTrue| T)
      (|compMakeCategoryObject| |vmode| |e|)))))

; knownInfo1 pred ==
;   pred is ["OR",:l] => or/[knownInfo u for u in l]
;   pred is ["AND",:l] => and/[knownInfo u for u in l]
;   pred is ["or",:l] => or/[knownInfo u for u in l]
;   pred is ["and",:l] => and/[knownInfo u for u in l]
;   pred is ["ATTRIBUTE",name,attr] => BREAK()
;   pred is ["has",name,cat] =>
;     cat is ["ATTRIBUTE",:a] => BREAK()
;     cat is ["SIGNATURE",:a] => knownInfo ["SIGNATURE",name,:a]
;     name is ['Union,:.] => false
;     -- FIXME: there is confusion between '$ in outer domain
;     -- (the one which needs info) and freshly compiled
;     -- domain...
;     v := compForMode(name, $EmptyMode, $info_e)
;     null v => stackSemanticError(["can't find category of ",name],nil)
;     vmode := CADR v
;     cat = vmode => true
;     vmode is ["Join",:l] and member(cat,l) => true
;     [vv, ., .] := get_catlist(vmode, $info_e)
;     catlist := vv.4
;     --catlist := SUBST(name,'$,vv.4)
;     null vv => stackSemanticError(["can't make category of ",name],nil)
;     member(cat,first catlist) => true  --checks princ. ancestors
;     (u:= assoc(cat,CADR catlist)) and knownInfo(CADR u) => true
;     -- previous line checks fundamental anscestors, we should check their
;     --   principal anscestors but this requires instantiating categories
;     -- Order of tests below is tricky performencewise.  We
;     -- put AncestorP test first because knownInfo in worst case
;     -- may lead to large number of recursive calls.
;     or/[AncestorP(cat, LIST first u) and knownInfo CADR u
;           for u in CADR catlist] => true
;     false
;   pred is ["SIGNATURE",name,op,sig,:.] =>
;       v:= get(op, "modemap", $info_e)
;       res := false
;       for w in v while(not(res)) repeat
;           w1 := first(w)
;           ww := rest(w1)
;           --the actual signature part
;           name = first(w1) and LENGTH ww = LENGTH(sig) and _
;             SourceLevelSubsume(ww, sig) =>
;               CAADR w = true => res := true
;       res
;   false

(DEFUN |knownInfo1| (|pred|)
  (PROG (|l| |ISTMP#1| |name| |ISTMP#2| |attr| |cat| |a| |v| |vmode| |LETTMP#1|
         |vv| |catlist| |u| |op| |ISTMP#3| |sig| |res| |w1| |ww|)
    (RETURN
     (COND
      ((AND (CONSP |pred|) (EQ (CAR |pred|) 'OR)
            (PROGN (SETQ |l| (CDR |pred|)) #1='T))
       ((LAMBDA (|bfVar#17| |bfVar#16| |u|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#16|) (PROGN (SETQ |u| (CAR |bfVar#16|)) NIL))
             (RETURN |bfVar#17|))
            (#1#
             (PROGN
              (SETQ |bfVar#17| (|knownInfo| |u|))
              (COND (|bfVar#17| (RETURN |bfVar#17|))))))
           (SETQ |bfVar#16| (CDR |bfVar#16|))))
        NIL |l| NIL))
      ((AND (CONSP |pred|) (EQ (CAR |pred|) 'AND)
            (PROGN (SETQ |l| (CDR |pred|)) #1#))
       ((LAMBDA (|bfVar#19| |bfVar#18| |u|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#18|) (PROGN (SETQ |u| (CAR |bfVar#18|)) NIL))
             (RETURN |bfVar#19|))
            (#1#
             (PROGN
              (SETQ |bfVar#19| (|knownInfo| |u|))
              (COND ((NOT |bfVar#19|) (RETURN NIL))))))
           (SETQ |bfVar#18| (CDR |bfVar#18|))))
        T |l| NIL))
      ((AND (CONSP |pred|) (EQ (CAR |pred|) '|or|)
            (PROGN (SETQ |l| (CDR |pred|)) #1#))
       ((LAMBDA (|bfVar#21| |bfVar#20| |u|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#20|) (PROGN (SETQ |u| (CAR |bfVar#20|)) NIL))
             (RETURN |bfVar#21|))
            (#1#
             (PROGN
              (SETQ |bfVar#21| (|knownInfo| |u|))
              (COND (|bfVar#21| (RETURN |bfVar#21|))))))
           (SETQ |bfVar#20| (CDR |bfVar#20|))))
        NIL |l| NIL))
      ((AND (CONSP |pred|) (EQ (CAR |pred|) '|and|)
            (PROGN (SETQ |l| (CDR |pred|)) #1#))
       ((LAMBDA (|bfVar#23| |bfVar#22| |u|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#22|) (PROGN (SETQ |u| (CAR |bfVar#22|)) NIL))
             (RETURN |bfVar#23|))
            (#1#
             (PROGN
              (SETQ |bfVar#23| (|knownInfo| |u|))
              (COND ((NOT |bfVar#23|) (RETURN NIL))))))
           (SETQ |bfVar#22| (CDR |bfVar#22|))))
        T |l| NIL))
      ((AND (CONSP |pred|) (EQ (CAR |pred|) 'ATTRIBUTE)
            (PROGN
             (SETQ |ISTMP#1| (CDR |pred|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |name| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |attr| (CAR |ISTMP#2|)) #1#))))))
       (BREAK))
      ((AND (CONSP |pred|) (EQ (CAR |pred|) '|has|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |pred|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |name| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |cat| (CAR |ISTMP#2|)) #1#))))))
       (COND
        ((AND (CONSP |cat|) (EQ (CAR |cat|) 'ATTRIBUTE)
              (PROGN (SETQ |a| (CDR |cat|)) #1#))
         (BREAK))
        ((AND (CONSP |cat|) (EQ (CAR |cat|) 'SIGNATURE)
              (PROGN (SETQ |a| (CDR |cat|)) #1#))
         (|knownInfo| (CONS 'SIGNATURE (CONS |name| |a|))))
        ((AND (CONSP |name|) (EQ (CAR |name|) '|Union|)) NIL)
        (#1#
         (PROGN
          (SETQ |v| (|compForMode| |name| |$EmptyMode| |$info_e|))
          (COND
           ((NULL |v|)
            (|stackSemanticError| (LIST '|can't find category of | |name|)
             NIL))
           (#1#
            (PROGN
             (SETQ |vmode| (CADR |v|))
             (COND ((EQUAL |cat| |vmode|) T)
                   ((AND (CONSP |vmode|) (EQ (CAR |vmode|) '|Join|)
                         (PROGN (SETQ |l| (CDR |vmode|)) #1#)
                         (|member| |cat| |l|))
                    T)
                   (#1#
                    (PROGN
                     (SETQ |LETTMP#1| (|get_catlist| |vmode| |$info_e|))
                     (SETQ |vv| (CAR |LETTMP#1|))
                     (SETQ |catlist| (ELT |vv| 4))
                     (COND
                      ((NULL |vv|)
                       (|stackSemanticError|
                        (LIST '|can't make category of | |name|) NIL))
                      ((|member| |cat| (CAR |catlist|)) T)
                      ((AND (SETQ |u| (|assoc| |cat| (CADR |catlist|)))
                            (|knownInfo| (CADR |u|)))
                       T)
                      (((LAMBDA (|bfVar#25| |bfVar#24| |u|)
                          (LOOP
                           (COND
                            ((OR (ATOM |bfVar#24|)
                                 (PROGN (SETQ |u| (CAR |bfVar#24|)) NIL))
                             (RETURN |bfVar#25|))
                            (#1#
                             (PROGN
                              (SETQ |bfVar#25|
                                      (AND (|AncestorP| |cat| (LIST (CAR |u|)))
                                           (|knownInfo| (CADR |u|))))
                              (COND (|bfVar#25| (RETURN |bfVar#25|))))))
                           (SETQ |bfVar#24| (CDR |bfVar#24|))))
                        NIL (CADR |catlist|) NIL)
                       T)
                      (#1# NIL))))))))))))
      ((AND (CONSP |pred|) (EQ (CAR |pred|) 'SIGNATURE)
            (PROGN
             (SETQ |ISTMP#1| (CDR |pred|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |name| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|)
                        (PROGN
                         (SETQ |op| (CAR |ISTMP#2|))
                         (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                         (AND (CONSP |ISTMP#3|)
                              (PROGN (SETQ |sig| (CAR |ISTMP#3|)) #1#))))))))
       (PROGN
        (SETQ |v| (|get| |op| '|modemap| |$info_e|))
        (SETQ |res| NIL)
        ((LAMBDA (|bfVar#26| |w|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#26|) (PROGN (SETQ |w| (CAR |bfVar#26|)) NIL)
                  |res|)
              (RETURN NIL))
             (#1#
              (PROGN
               (SETQ |w1| (CAR |w|))
               (SETQ |ww| (CDR |w1|))
               (COND
                ((AND (EQUAL |name| (CAR |w1|))
                      (EQL (LENGTH |ww|) (LENGTH |sig|))
                      (|SourceLevelSubsume| |ww| |sig|))
                 (COND ((EQUAL (CAADR |w|) T) (IDENTITY (SETQ |res| T)))))))))
            (SETQ |bfVar#26| (CDR |bfVar#26|))))
         |v| NIL)
        |res|))
      (#1# NIL)))))

; actOnInfo(u, e) ==
;   null u => e
;   u is ["PROGN", :l] =>
;       for v in l repeat
;           e := actOnInfo(v, e)
;       e
;   Info := [u, :get("$Information", "special", e)]
;   e := put("$Information", "special", Info, e)
;   u is ["COND",:l] =>
;       --there is nowhere %else that this sort of thing exists
;     for [ante,:conseq] in l repeat
;       if member(hasToInfo ante,Info) then for v in conseq repeat
;         e := actOnInfo(v, e)
;     e
;   u is ["ATTRIBUTE",name,att] => BREAK()
;   u is ["SIGNATURE",name,operator,modemap] =>
;     implem:=
;       (implem := assoc([name, :modemap], get(operator, 'modemap, e))) =>
;           CADADR implem
;       name = "$" => ['ELT,name,-1]
;       ['ELT,name,substitute('$,name,modemap)]
;     e := addModemap(operator, name, modemap, true, implem, e)
;     [vval, vmode, venv] := GetValue(name, e)
;     SAY("augmenting ",name,": ",u)
;     key:= if CONTAINED("$",vmode) then "domain" else name
;     cat:= ["CATEGORY",key,["SIGNATURE",operator,modemap]]
;     put(name, "value", [vval, mkJoin(cat, vmode), venv], e)
;   u is ["has",name,cat] =>
;     [vval, vmode, venv] := GetValue(name, e)
;     cat = vmode => e --stating the already known
;     u := compMakeCategoryObject(cat, e) =>
;          --we are adding information about a category
;       [catvec, ., e] := u
;       [ocatvec, ., e] := compMakeCategoryObject(vmode, e)
;       -- member(vmode, first catvec.4) =>
;       --    JHD 82/08/08 01:40 This does not mean that we can ignore the
;       --    extension, since this may not be compatible with the view we
;       --    were passed
;
;       --we are adding a principal descendant of what was already known
;       --    $e:= augModemapsFromCategory(name,nil,catvec,$e)
;       --    SAY("augmenting ",name,": ",cat)
;       --    put(name, "value", (vval, cat, venv), $e)
;       member(cat,first ocatvec.4) or
;          assoc(cat, CADR ocatvec.4) is [., 'T, .] => e
;         --SAY("Category extension error:
;         --cat shouldn't be a join
;                       --what was being asserted is an ancestor of what was known
;       -- augModemapsFromCategory asserts that domain is in scope,
;       -- so make sure it really is (and not only the extra view we add)
;       e := addDomain(name, e)
;       if ATOM(name) then
;           e := augModemapsFromCategory(name, name, cat, e)
;       else
;           e := augModemapsFromCategory(name, nil, cat, e)
;       SAY("augmenting ",name,": ",cat)
;       e := put(name, "value", [vval, mkJoin(cat, vmode), venv], e)
;     SAY("extension of ",vval," to ",cat," ignored")
;     e
;   systemError '"knownInfo"

(DEFUN |actOnInfo| (|u| |e|)
  (PROG (|l| |Info| |ante| |conseq| |ISTMP#1| |name| |ISTMP#2| |att| |operator|
         |ISTMP#3| |modemap| |implem| |LETTMP#1| |vval| |vmode| |venv| |key|
         |cat| |catvec| |ocatvec|)
    (RETURN
     (COND ((NULL |u|) |e|)
           ((AND (CONSP |u|) (EQ (CAR |u|) 'PROGN)
                 (PROGN (SETQ |l| (CDR |u|)) #1='T))
            (PROGN
             ((LAMBDA (|bfVar#27| |v|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#27|)
                       (PROGN (SETQ |v| (CAR |bfVar#27|)) NIL))
                   (RETURN NIL))
                  (#1# (SETQ |e| (|actOnInfo| |v| |e|))))
                 (SETQ |bfVar#27| (CDR |bfVar#27|))))
              |l| NIL)
             |e|))
           (#1#
            (PROGN
             (SETQ |Info| (CONS |u| (|get| '|$Information| '|special| |e|)))
             (SETQ |e| (|put| '|$Information| '|special| |Info| |e|))
             (COND
              ((AND (CONSP |u|) (EQ (CAR |u|) 'COND)
                    (PROGN (SETQ |l| (CDR |u|)) #1#))
               (PROGN
                ((LAMBDA (|bfVar#29| |bfVar#28|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#29|)
                          (PROGN (SETQ |bfVar#28| (CAR |bfVar#29|)) NIL))
                      (RETURN NIL))
                     (#1#
                      (AND (CONSP |bfVar#28|)
                           (PROGN
                            (SETQ |ante| (CAR |bfVar#28|))
                            (SETQ |conseq| (CDR |bfVar#28|))
                            #1#)
                           (COND
                            ((|member| (|hasToInfo| |ante|) |Info|)
                             ((LAMBDA (|bfVar#30| |v|)
                                (LOOP
                                 (COND
                                  ((OR (ATOM |bfVar#30|)
                                       (PROGN (SETQ |v| (CAR |bfVar#30|)) NIL))
                                   (RETURN NIL))
                                  (#1# (SETQ |e| (|actOnInfo| |v| |e|))))
                                 (SETQ |bfVar#30| (CDR |bfVar#30|))))
                              |conseq| NIL))))))
                    (SETQ |bfVar#29| (CDR |bfVar#29|))))
                 |l| NIL)
                |e|))
              ((AND (CONSP |u|) (EQ (CAR |u|) 'ATTRIBUTE)
                    (PROGN
                     (SETQ |ISTMP#1| (CDR |u|))
                     (AND (CONSP |ISTMP#1|)
                          (PROGN
                           (SETQ |name| (CAR |ISTMP#1|))
                           (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                           (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                (PROGN (SETQ |att| (CAR |ISTMP#2|)) #1#))))))
               (BREAK))
              ((AND (CONSP |u|) (EQ (CAR |u|) 'SIGNATURE)
                    (PROGN
                     (SETQ |ISTMP#1| (CDR |u|))
                     (AND (CONSP |ISTMP#1|)
                          (PROGN
                           (SETQ |name| (CAR |ISTMP#1|))
                           (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                           (AND (CONSP |ISTMP#2|)
                                (PROGN
                                 (SETQ |operator| (CAR |ISTMP#2|))
                                 (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                                 (AND (CONSP |ISTMP#3|)
                                      (EQ (CDR |ISTMP#3|) NIL)
                                      (PROGN
                                       (SETQ |modemap| (CAR |ISTMP#3|))
                                       #1#))))))))
               (PROGN
                (SETQ |implem|
                        (COND
                         ((SETQ |implem|
                                  (|assoc| (CONS |name| |modemap|)
                                   (|get| |operator| '|modemap| |e|)))
                          (CADADR |implem|))
                         ((EQ |name| '$) (LIST 'ELT |name| (- 1)))
                         (#1#
                          (LIST 'ELT |name|
                                (|substitute| '$ |name| |modemap|)))))
                (SETQ |e|
                        (|addModemap| |operator| |name| |modemap| T |implem|
                         |e|))
                (SETQ |LETTMP#1| (|GetValue| |name| |e|))
                (SETQ |vval| (CAR |LETTMP#1|))
                (SETQ |vmode| (CADR . #2=(|LETTMP#1|)))
                (SETQ |venv| (CADDR . #2#))
                (SAY '|augmenting | |name| '|: | |u|)
                (SETQ |key|
                        (COND ((CONTAINED '$ |vmode|) '|domain|) (#1# |name|)))
                (SETQ |cat|
                        (LIST 'CATEGORY |key|
                              (LIST 'SIGNATURE |operator| |modemap|)))
                (|put| |name| '|value|
                 (LIST |vval| (|mkJoin| |cat| |vmode|) |venv|) |e|)))
              ((AND (CONSP |u|) (EQ (CAR |u|) '|has|)
                    (PROGN
                     (SETQ |ISTMP#1| (CDR |u|))
                     (AND (CONSP |ISTMP#1|)
                          (PROGN
                           (SETQ |name| (CAR |ISTMP#1|))
                           (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                           (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                (PROGN (SETQ |cat| (CAR |ISTMP#2|)) #1#))))))
               (PROGN
                (SETQ |LETTMP#1| (|GetValue| |name| |e|))
                (SETQ |vval| (CAR |LETTMP#1|))
                (SETQ |vmode| (CADR . #3=(|LETTMP#1|)))
                (SETQ |venv| (CADDR . #3#))
                (COND ((EQUAL |cat| |vmode|) |e|)
                      ((SETQ |u| (|compMakeCategoryObject| |cat| |e|))
                       (PROGN
                        (SETQ |catvec| (CAR |u|))
                        (SETQ |e| (CADDR |u|))
                        (SETQ |LETTMP#1|
                                (|compMakeCategoryObject| |vmode| |e|))
                        (SETQ |ocatvec| (CAR |LETTMP#1|))
                        (SETQ |e| (CADDR |LETTMP#1|))
                        (COND
                         ((OR (|member| |cat| (CAR (ELT |ocatvec| 4)))
                              (PROGN
                               (SETQ |ISTMP#1|
                                       (|assoc| |cat|
                                        (CADR (ELT |ocatvec| 4))))
                               (AND (CONSP |ISTMP#1|)
                                    (PROGN
                                     (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                     (AND (CONSP |ISTMP#2|)
                                          (EQ (CAR |ISTMP#2|) 'T)
                                          (PROGN
                                           (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                                           (AND (CONSP |ISTMP#3|)
                                                (EQ (CDR |ISTMP#3|) NIL))))))))
                          |e|)
                         (#1#
                          (PROGN
                           (SETQ |e| (|addDomain| |name| |e|))
                           (COND
                            ((ATOM |name|)
                             (SETQ |e|
                                     (|augModemapsFromCategory| |name| |name|
                                      |cat| |e|)))
                            (#1#
                             (SETQ |e|
                                     (|augModemapsFromCategory| |name| NIL
                                      |cat| |e|))))
                           (SAY '|augmenting | |name| '|: | |cat|)
                           (SETQ |e|
                                   (|put| |name| '|value|
                                    (LIST |vval| (|mkJoin| |cat| |vmode|)
                                          |venv|)
                                    |e|)))))))
                      (#1#
                       (PROGN
                        (SAY '|extension of | |vval| '| to | |cat| '| ignored|)
                        |e|)))))
              (#1# (|systemError| "knownInfo")))))))))

; mkJoin(cat,mode) ==
;   mode is ['Join,:cats] => ['Join,cat,:cats]
;   ['Join,cat,mode]

(DEFUN |mkJoin| (|cat| |mode|)
  (PROG (|cats|)
    (RETURN
     (COND
      ((AND (CONSP |mode|) (EQ (CAR |mode|) '|Join|)
            (PROGN (SETQ |cats| (CDR |mode|)) #1='T))
       (CONS '|Join| (CONS |cat| |cats|)))
      (#1# (LIST '|Join| |cat| |mode|))))))

; GetValue(name, e) ==
;   u := get(name,"value", e) => u
;   u := comp(name, $EmptyMode, e) => u  --name may be a form
;   systemError [name,'" is not bound in the current environment"]

(DEFUN |GetValue| (|name| |e|)
  (PROG (|u|)
    (RETURN
     (COND ((SETQ |u| (|get| |name| '|value| |e|)) |u|)
           ((SETQ |u| (|comp| |name| |$EmptyMode| |e|)) |u|)
           ('T
            (|systemError|
             (LIST |name| " is not bound in the current environment")))))))
