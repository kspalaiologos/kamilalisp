
; )package "BOOT"

(IN-PACKAGE "BOOT")

; getSignatureDocumentation(lineno) ==
;     $docList : local := nil
;     recordDocumentation("Signature", lineno)
;     rest first $docList

(DEFUN |getSignatureDocumentation| (|lineno|)
  (PROG (|$docList|)
    (DECLARE (SPECIAL |$docList|))
    (RETURN
     (PROGN
      (SETQ |$docList| NIL)
      (|recordDocumentation| '|Signature| |lineno|)
      (CDR (CAR |$docList|))))))

; record_on_docList(key, item) ==
;     $docList := [[key, :item], :$docList]

(DEFUN |record_on_docList| (|key| |item|)
  (PROG () (RETURN (SETQ |$docList| (CONS (CONS |key| |item|) |$docList|)))))

; recordAttributeDocumentation(['ATTRIBUTE, att], lineno) ==
;   name := opOf att
;   UPPER_-CASE_-P (PNAME name).0 => nil
;   recordDocumentation([name,['attribute,:IFCDR postTransform att]],lineno)

(DEFUN |recordAttributeDocumentation| (|bfVar#1| |lineno|)
  (PROG (|att| |name|)
    (RETURN
     (PROGN
      (SETQ |att| (CADR |bfVar#1|))
      (SETQ |name| (|opOf| |att|))
      (COND ((UPPER-CASE-P (ELT (PNAME |name|) 0)) NIL)
            ('T
             (|recordDocumentation|
              (LIST |name| (CONS '|attribute| (IFCDR (|postTransform| |att|))))
              |lineno|)))))))

; recordDocumentation(key,lineno) ==
;   recordHeaderDocumentation lineno
;   u:= collectComBlock lineno
;   --record NIL to mean "there was no documentation"
;   $maxSignatureLineNumber := lineno
;   $docList := [[key,:u],:$docList]

(DEFUN |recordDocumentation| (|key| |lineno|)
  (PROG (|u|)
    (RETURN
     (PROGN
      (|recordHeaderDocumentation| |lineno|)
      (SETQ |u| (|collectComBlock| |lineno|))
      (SETQ |$maxSignatureLineNumber| |lineno|)
      (SETQ |$docList| (CONS (CONS |key| |u|) |$docList|))))))

; recordHeaderDocumentation lineno ==
;   if $maxSignatureLineNumber = 0 then
;     al := [p for (p := [n,:u]) in $COMBLOCKLIST
;                | NULL n or NULL lineno or n < lineno]
;     $COMBLOCKLIST := SETDIFFERENCE($COMBLOCKLIST,al)
;     $headerDocumentation := ASSOCRIGHT al
;     if $headerDocumentation then $maxSignatureLineNumber := 1 --see postDef
;     $headerDocumentation

(DEFUN |recordHeaderDocumentation| (|lineno|)
  (PROG (|n| |u| |al|)
    (RETURN
     (COND
      ((EQL |$maxSignatureLineNumber| 0)
       (SETQ |al|
               ((LAMBDA (|bfVar#3| |bfVar#2| |p|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#2|)
                         (PROGN (SETQ |p| (CAR |bfVar#2|)) NIL))
                     (RETURN (NREVERSE |bfVar#3|)))
                    (#1='T
                     (AND (CONSP |p|)
                          (PROGN (SETQ |n| (CAR |p|)) (SETQ |u| (CDR |p|)) #1#)
                          (OR (NULL |n|) (NULL |lineno|) (< |n| |lineno|))
                          (SETQ |bfVar#3| (CONS |p| |bfVar#3|)))))
                   (SETQ |bfVar#2| (CDR |bfVar#2|))))
                NIL $COMBLOCKLIST NIL))
       (SETQ $COMBLOCKLIST (SETDIFFERENCE $COMBLOCKLIST |al|))
       (SETQ |$headerDocumentation| (ASSOCRIGHT |al|))
       (COND (|$headerDocumentation| (SETQ |$maxSignatureLineNumber| 1)))
       |$headerDocumentation|)))))

; collectComBlock x ==
;   $COMBLOCKLIST is [[=x,:val],:.] =>
;     u := [:val,:collectAndDeleteAssoc x]
;     $COMBLOCKLIST := rest $COMBLOCKLIST
;     u
;   collectAndDeleteAssoc x

(DEFUN |collectComBlock| (|x|)
  (PROG (|ISTMP#1| |val| |u|)
    (RETURN
     (COND
      ((AND (CONSP $COMBLOCKLIST)
            (PROGN
             (SETQ |ISTMP#1| (CAR $COMBLOCKLIST))
             (AND (CONSP |ISTMP#1|) (EQUAL (CAR |ISTMP#1|) |x|)
                  (PROGN (SETQ |val| (CDR |ISTMP#1|)) #1='T))))
       (PROGN
        (SETQ |u| (APPEND |val| (|collectAndDeleteAssoc| |x|)))
        (SETQ $COMBLOCKLIST (CDR $COMBLOCKLIST))
        |u|))
      (#1# (|collectAndDeleteAssoc| |x|))))))

; collectAndDeleteAssoc x ==
; --u is (.. (x . a) .. (x . b) .. )  ==> (a b ..) deleting entries from u
; --assumes that the first element is useless
;   for y in tails $COMBLOCKLIST | (s := rest y) repeat
;     while s and first s is [=x,:r] repeat
;       res := [:res,:r]
;       s := rest s
;       RPLACD(y,s)
;   res

(DEFUN |collectAndDeleteAssoc| (|x|)
  (PROG (|s| |ISTMP#1| |r| |res|)
    (RETURN
     (PROGN
      ((LAMBDA (|y|)
         (LOOP
          (COND ((ATOM |y|) (RETURN NIL))
                (#1='T
                 (AND (SETQ |s| (CDR |y|))
                      ((LAMBDA ()
                         (LOOP
                          (COND
                           ((NOT
                             (AND |s|
                                  (PROGN
                                   (SETQ |ISTMP#1| (CAR |s|))
                                   (AND (CONSP |ISTMP#1|)
                                        (EQUAL (CAR |ISTMP#1|) |x|)
                                        (PROGN
                                         (SETQ |r| (CDR |ISTMP#1|))
                                         #1#)))))
                            (RETURN NIL))
                           (#1#
                            (PROGN
                             (SETQ |res| (APPEND |res| |r|))
                             (SETQ |s| (CDR |s|))
                             (RPLACD |y| |s|))))))))))
          (SETQ |y| (CDR |y|))))
       $COMBLOCKLIST)
      |res|))))

; finalizeDocumentation() ==
;   -- skip during bootstrap to save time
;   $bootStrapMode => []
;   unusedCommentLineNumbers := [x for (x := [n,:r]) in $COMBLOCKLIST | r]
;   docList := SUBST("$","%",transDocList($op,$docList))
;   if u := [sig for [sig,:doc] in docList | null doc] then
;     for y in u repeat
;       y = 'constructor => noHeading := true
;       y is [x,b] and b is [='attribute,:r] =>
;         attributes := [[x,:r],:attributes]
;       signatures := [y,:signatures]
;     name := first $lisplibForm
;     if noHeading or signatures or unusedCommentLineNumbers then
;       say_msg('"%b Constructor documentation warnings (++ comments): %d", nil)
;       bigcnt := 1
;       if noHeading or signatures then
;         say_msg('"%1 The constructor %2b has missing documentation.",
;                 [STRCONC(STRINGIMAGE bigcnt,'"."),name])
;         bigcnt := bigcnt + 1
;         litcnt := 1
;         if noHeading then
;           say_msg('"%x3 %1 The constructor %2b is missing the heading description.",
;             [STRCONC('"(",STRINGIMAGE litcnt,'")"),name])
;           litcnt := litcnt + 1
;         if signatures then
;           say_msg('"%x3 %1 The following functions do not have documentation:",
;                   [STRCONC('"(",STRINGIMAGE litcnt,'")")])
;           litcnt := litcnt + 1
;           for [op,sig] in signatures repeat
;             s := formatOpSignature(op,sig)
;             sayMSG
;               atom s => ['%x9,s]
;               ['%x9,:s]
;       if unusedCommentLineNumbers then
;         say_msg('"%1 The constructor %2b has incorrectly placed documentation.",[STRCONC(STRINGIMAGE bigcnt,'"."),name])
;         for [n,r] in unusedCommentLineNumbers repeat
;           sayMSG ['"   ",:bright n,'"   ",r]
;   hn([[:fn(sig), :doc] for [sig, :doc] in docList]) where
;     fn(x) ==
;       atom x => [x,nil]
;       if #x > 2 then x := TAKE(2,x)
;       SUBLISLIS($FormalMapVariableList, rest($lisplibForm), x)
;     hn u ==
;      -- ((op,sig,doc), ...)  --> ((op ((sig doc) ...)) ...)
;       opList := REMDUP ASSOCLEFT u
;       [[op,:[[sig,doc] for [op1,sig,doc] in u | op = op1]] for op in opList]

(DEFUN |finalizeDocumentation| ()
  (PROG (|s| |op| |litcnt| |bigcnt| |name| |signatures| |attributes| |b|
         |ISTMP#1| |x| |noHeading| |u| |doc| |sig| |docList|
         |unusedCommentLineNumbers| |r| |n|)
    (RETURN
     (COND (|$bootStrapMode| NIL)
           (#1='T
            (PROGN
             (SETQ |unusedCommentLineNumbers|
                     ((LAMBDA (|bfVar#5| |bfVar#4| |x|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#4|)
                               (PROGN (SETQ |x| (CAR |bfVar#4|)) NIL))
                           (RETURN (NREVERSE |bfVar#5|)))
                          (#1#
                           (AND (CONSP |x|)
                                (PROGN
                                 (SETQ |n| (CAR |x|))
                                 (SETQ |r| (CDR |x|))
                                 #1#)
                                |r| (SETQ |bfVar#5| (CONS |x| |bfVar#5|)))))
                         (SETQ |bfVar#4| (CDR |bfVar#4|))))
                      NIL $COMBLOCKLIST NIL))
             (SETQ |docList| (SUBST '$ '% (|transDocList| |$op| |$docList|)))
             (COND
              ((SETQ |u|
                       ((LAMBDA (|bfVar#8| |bfVar#7| |bfVar#6|)
                          (LOOP
                           (COND
                            ((OR (ATOM |bfVar#7|)
                                 (PROGN (SETQ |bfVar#6| (CAR |bfVar#7|)) NIL))
                             (RETURN (NREVERSE |bfVar#8|)))
                            (#1#
                             (AND (CONSP |bfVar#6|)
                                  (PROGN
                                   (SETQ |sig| (CAR |bfVar#6|))
                                   (SETQ |doc| (CDR |bfVar#6|))
                                   #1#)
                                  (NULL |doc|)
                                  (SETQ |bfVar#8| (CONS |sig| |bfVar#8|)))))
                           (SETQ |bfVar#7| (CDR |bfVar#7|))))
                        NIL |docList| NIL))
               ((LAMBDA (|bfVar#9| |y|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#9|)
                         (PROGN (SETQ |y| (CAR |bfVar#9|)) NIL))
                     (RETURN NIL))
                    (#1#
                     (COND ((EQ |y| '|constructor|) (SETQ |noHeading| T))
                           ((AND (CONSP |y|)
                                 (PROGN
                                  (SETQ |x| (CAR |y|))
                                  (SETQ |ISTMP#1| (CDR |y|))
                                  (AND (CONSP |ISTMP#1|)
                                       (EQ (CDR |ISTMP#1|) NIL)
                                       (PROGN (SETQ |b| (CAR |ISTMP#1|)) #1#)))
                                 (CONSP |b|) (EQUAL (CAR |b|) '|attribute|)
                                 (PROGN (SETQ |r| (CDR |b|)) #1#))
                            (SETQ |attributes|
                                    (CONS (CONS |x| |r|) |attributes|)))
                           (#1# (SETQ |signatures| (CONS |y| |signatures|))))))
                   (SETQ |bfVar#9| (CDR |bfVar#9|))))
                |u| NIL)
               (SETQ |name| (CAR |$lisplibForm|))
               (COND
                ((OR |noHeading| |signatures| |unusedCommentLineNumbers|)
                 (|say_msg|
                  "%b Constructor documentation warnings (++ comments): %d"
                  NIL)
                 (SETQ |bigcnt| 1)
                 (COND
                  ((OR |noHeading| |signatures|)
                   (|say_msg|
                    "%1 The constructor %2b has missing documentation."
                    (LIST (STRCONC (STRINGIMAGE |bigcnt|) ".") |name|))
                   (SETQ |bigcnt| (+ |bigcnt| 1)) (SETQ |litcnt| 1)
                   (COND
                    (|noHeading|
                     (|say_msg|
                      "%x3 %1 The constructor %2b is missing the heading description."
                      (LIST (STRCONC "(" (STRINGIMAGE |litcnt|) ")") |name|))
                     (SETQ |litcnt| (+ |litcnt| 1))))
                   (COND
                    (|signatures|
                     (|say_msg|
                      "%x3 %1 The following functions do not have documentation:"
                      (LIST (STRCONC "(" (STRINGIMAGE |litcnt|) ")")))
                     (SETQ |litcnt| (+ |litcnt| 1))
                     ((LAMBDA (|bfVar#11| |bfVar#10|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#11|)
                               (PROGN (SETQ |bfVar#10| (CAR |bfVar#11|)) NIL))
                           (RETURN NIL))
                          (#1#
                           (AND (CONSP |bfVar#10|)
                                (PROGN
                                 (SETQ |op| (CAR |bfVar#10|))
                                 (SETQ |ISTMP#1| (CDR |bfVar#10|))
                                 (AND (CONSP |ISTMP#1|)
                                      (EQ (CDR |ISTMP#1|) NIL)
                                      (PROGN
                                       (SETQ |sig| (CAR |ISTMP#1|))
                                       #1#)))
                                (PROGN
                                 (SETQ |s| (|formatOpSignature| |op| |sig|))
                                 (|sayMSG|
                                  (COND ((ATOM |s|) (LIST '|%x9| |s|))
                                        (#1# (CONS '|%x9| |s|))))))))
                         (SETQ |bfVar#11| (CDR |bfVar#11|))))
                      |signatures| NIL)))))
                 (COND
                  (|unusedCommentLineNumbers|
                   (|say_msg|
                    "%1 The constructor %2b has incorrectly placed documentation."
                    (LIST (STRCONC (STRINGIMAGE |bigcnt|) ".") |name|))
                   ((LAMBDA (|bfVar#13| |bfVar#12|)
                      (LOOP
                       (COND
                        ((OR (ATOM |bfVar#13|)
                             (PROGN (SETQ |bfVar#12| (CAR |bfVar#13|)) NIL))
                         (RETURN NIL))
                        (#1#
                         (AND (CONSP |bfVar#12|)
                              (PROGN
                               (SETQ |n| (CAR |bfVar#12|))
                               (SETQ |ISTMP#1| (CDR |bfVar#12|))
                               (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                                    (PROGN (SETQ |r| (CAR |ISTMP#1|)) #1#)))
                              (|sayMSG|
                               (CONS "   "
                                     (APPEND (|bright| |n|)
                                             (CONS "   " (CONS |r| NIL))))))))
                       (SETQ |bfVar#13| (CDR |bfVar#13|))))
                    |unusedCommentLineNumbers| NIL)))))))
             (|finalizeDocumentation,hn|
              ((LAMBDA (|bfVar#16| |bfVar#15| |bfVar#14|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#15|)
                        (PROGN (SETQ |bfVar#14| (CAR |bfVar#15|)) NIL))
                    (RETURN (NREVERSE |bfVar#16|)))
                   (#1#
                    (AND (CONSP |bfVar#14|)
                         (PROGN
                          (SETQ |sig| (CAR |bfVar#14|))
                          (SETQ |doc| (CDR |bfVar#14|))
                          #1#)
                         (SETQ |bfVar#16|
                                 (CONS
                                  (APPEND (|finalizeDocumentation,fn| |sig|)
                                          |doc|)
                                  |bfVar#16|)))))
                  (SETQ |bfVar#15| (CDR |bfVar#15|))))
               NIL |docList| NIL))))))))
(DEFUN |finalizeDocumentation,fn| (|x|)
  (PROG ()
    (RETURN
     (COND ((ATOM |x|) (LIST |x| NIL))
           ('T
            (PROGN
             (COND ((< 2 (LENGTH |x|)) (SETQ |x| (TAKE 2 |x|))))
             (SUBLISLIS |$FormalMapVariableList| (CDR |$lisplibForm|) |x|)))))))
(DEFUN |finalizeDocumentation,hn| (|u|)
  (PROG (|opList| |op1| |ISTMP#1| |sig| |ISTMP#2| |doc|)
    (RETURN
     (PROGN
      (SETQ |opList| (REMDUP (ASSOCLEFT |u|)))
      ((LAMBDA (|bfVar#21| |bfVar#20| |op|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#20|) (PROGN (SETQ |op| (CAR |bfVar#20|)) NIL))
            (RETURN (NREVERSE |bfVar#21|)))
           (#1='T
            (SETQ |bfVar#21|
                    (CONS
                     (CONS |op|
                           ((LAMBDA (|bfVar#19| |bfVar#18| |bfVar#17|)
                              (LOOP
                               (COND
                                ((OR (ATOM |bfVar#18|)
                                     (PROGN
                                      (SETQ |bfVar#17| (CAR |bfVar#18|))
                                      NIL))
                                 (RETURN (NREVERSE |bfVar#19|)))
                                (#1#
                                 (AND (CONSP |bfVar#17|)
                                      (PROGN
                                       (SETQ |op1| (CAR |bfVar#17|))
                                       (SETQ |ISTMP#1| (CDR |bfVar#17|))
                                       (AND (CONSP |ISTMP#1|)
                                            (PROGN
                                             (SETQ |sig| (CAR |ISTMP#1|))
                                             (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                             (AND (CONSP |ISTMP#2|)
                                                  (EQ (CDR |ISTMP#2|) NIL)
                                                  (PROGN
                                                   (SETQ |doc| (CAR |ISTMP#2|))
                                                   #1#)))))
                                      (EQUAL |op| |op1|)
                                      (SETQ |bfVar#19|
                                              (CONS (LIST |sig| |doc|)
                                                    |bfVar#19|)))))
                               (SETQ |bfVar#18| (CDR |bfVar#18|))))
                            NIL |u| NIL))
                     |bfVar#21|))))
          (SETQ |bfVar#20| (CDR |bfVar#20|))))
       NIL |opList| NIL)))))

; transDocList($constructorName,doclist) == --returns ((key line)...)
; --called ONLY by finalizeDocumentation
; --if $exposeFlag then messages go to file $outStream; flag=nil by default
;   sayBrightly ['"   Processing ",$constructorName,'" for Browser database:"]
;   commentList := transDoc($constructorName,doclist)
;   acc := nil
;   for entry in commentList repeat
;     entry is ['constructor,x] =>
;       conEntry => checkDocError ['"Spurious comments: ",x]
;       conEntry := entry
;     acc := [entry,:acc]
;   conEntry => [conEntry,:acc]
;   checkDocError1 ['"Missing Description"]
;   acc

(DEFUN |transDocList| (|$constructorName| |doclist|)
  (DECLARE (SPECIAL |$constructorName|))
  (PROG (|commentList| |acc| |ISTMP#1| |x| |conEntry|)
    (RETURN
     (PROGN
      (|sayBrightly|
       (LIST "   Processing " |$constructorName| " for Browser database:"))
      (SETQ |commentList| (|transDoc| |$constructorName| |doclist|))
      (SETQ |acc| NIL)
      ((LAMBDA (|bfVar#22| |entry|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#22|) (PROGN (SETQ |entry| (CAR |bfVar#22|)) NIL))
            (RETURN NIL))
           (#1='T
            (COND
             ((AND (CONSP |entry|) (EQ (CAR |entry|) '|constructor|)
                   (PROGN
                    (SETQ |ISTMP#1| (CDR |entry|))
                    (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                         (PROGN (SETQ |x| (CAR |ISTMP#1|)) #1#))))
              (COND
               (|conEntry| (|checkDocError| (LIST "Spurious comments: " |x|)))
               (#1# (SETQ |conEntry| |entry|))))
             (#1# (SETQ |acc| (CONS |entry| |acc|))))))
          (SETQ |bfVar#22| (CDR |bfVar#22|))))
       |commentList| NIL)
      (COND (|conEntry| (CONS |conEntry| |acc|))
            (#1#
             (PROGN (|checkDocError1| (LIST "Missing Description")) |acc|)))))))

; transDoc(conname,doclist) ==
; --$exposeFlag and not isExposedConstructor conname => nil
; --skip over unexposed constructors when checking system files
;   $x: local := nil
;   rlist := REVERSE doclist
;   for [$x,:lines] in rlist repeat
;     $attribute? : local := $x is [.,[key]] and key = 'attribute
;     null lines =>
;       $attribute? => nil
;       checkDocError1 ['"Not documented!!!!"]
;     u := checkTrim($x,(STRINGP lines => [lines]; $x = 'constructor => first lines; lines))
;     $argl : local := nil    --set by checkGetArgs
; -- tpd: related domain information doesn't exist
; --    if v := checkExtract('"Related Domains:",u) then
; --      $lisplibRelatedDomains:=[w for x in gn(v) | w := fn(x)] where
; --        gn(v) ==  --note: unabbrev checks for correct number of arguments
; --          s := checkExtractItemList v
; --          parse := ncParseFromString s  --is a single conform or a tuple
; --          null parse => nil
; --          parse is ['Tuple,:r] => r
; --          [parse]
; --        fn(x) ==
; --          expectedNumOfArgs := checkNumOfArgs x
; --          null expectedNumOfArgs =>
; --            checkDocError ['"Unknown constructor name?: ",opOf x]
; --            x
; --          expectedNumOfArgs ~= (n := #(IFCDR x)) =>
; --            n = 0 => checkDocError1
; --              ['"You must give arguments to the _"Related Domain_": ",x]
; --            checkDocError
; --              ['"_"Related Domain_" has wrong number of arguments: ",x]
; --            nil
; --          n=0 and atom x => [x]
; --          x
;     longline :=
;       $x = 'constructor =>
;         v :=checkExtract('"Description:",u) or u and
;               checkExtract('"Description:",
;                 [STRCONC('"Description: ",first u),:rest u])
;         transformAndRecheckComments('constructor,v or u)
;       transformAndRecheckComments($x,u)
;     acc := [[$x,longline],:acc]  --processor assumes a list of lines
;   NREVERSE acc

(DEFUN |transDoc| (|conname| |doclist|)
  (PROG (|$argl| |$attribute?| |$x| |acc| |longline| |v| |u| |key| |ISTMP#2|
         |ISTMP#1| |lines| |rlist|)
    (DECLARE (SPECIAL |$argl| |$attribute?| |$x|))
    (RETURN
     (PROGN
      (SETQ |$x| NIL)
      (SETQ |rlist| (REVERSE |doclist|))
      ((LAMBDA (|bfVar#24| |bfVar#23|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#24|)
                (PROGN (SETQ |bfVar#23| (CAR |bfVar#24|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#23|)
                 (PROGN
                  (SETQ |$x| (CAR |bfVar#23|))
                  (SETQ |lines| (CDR |bfVar#23|))
                  #1#)
                 (PROGN
                  (SETQ |$attribute?|
                          (AND (CONSP |$x|)
                               (PROGN
                                (SETQ |ISTMP#1| (CDR |$x|))
                                (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                                     (PROGN
                                      (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                                      (AND (CONSP |ISTMP#2|)
                                           (EQ (CDR |ISTMP#2|) NIL)
                                           (PROGN
                                            (SETQ |key| (CAR |ISTMP#2|))
                                            #1#)))))
                               (EQ |key| '|attribute|)))
                  (COND
                   ((NULL |lines|)
                    (COND (|$attribute?| NIL)
                          (#1#
                           (|checkDocError1| (LIST "Not documented!!!!")))))
                   (#1#
                    (PROGN
                     (SETQ |u|
                             (|checkTrim| |$x|
                              (COND ((STRINGP |lines|) (LIST |lines|))
                                    ((EQ |$x| '|constructor|) (CAR |lines|))
                                    (#1# |lines|))))
                     (SETQ |$argl| NIL)
                     (SETQ |longline|
                             (COND
                              ((EQ |$x| '|constructor|)
                               (PROGN
                                (SETQ |v|
                                        (OR (|checkExtract| "Description:" |u|)
                                            (AND |u|
                                                 (|checkExtract| "Description:"
                                                  (CONS
                                                   (STRCONC "Description: "
                                                    (CAR |u|))
                                                   (CDR |u|))))))
                                (|transformAndRecheckComments| '|constructor|
                                 (OR |v| |u|))))
                              (#1# (|transformAndRecheckComments| |$x| |u|))))
                     (SETQ |acc| (CONS (LIST |$x| |longline|) |acc|)))))))))
          (SETQ |bfVar#24| (CDR |bfVar#24|))))
       |rlist| NIL)
      (NREVERSE |acc|)))))

; checkExtractItemList l ==  --items are separated by commas or end of line
;   acc := nil               --l is list of remaining lines
;   while l repeat           --stop when you get to a line with a colon
;     m := MAXINDEX first l
;     k := charPosition(char '_:,first l,0)
;     k <= m => return nil
;     acc := [first l,:acc]
;     l := rest l
;   "STRCONC"/[x for x in NREVERSE acc]

(DEFUN |checkExtractItemList| (|l|)
  (PROG (|acc| |m| |k|)
    (RETURN
     (PROGN
      (SETQ |acc| NIL)
      ((LAMBDA ()
         (LOOP
          (COND ((NOT |l|) (RETURN NIL))
                (#1='T
                 (PROGN
                  (SETQ |m| (MAXINDEX (CAR |l|)))
                  (SETQ |k| (|charPosition| (|char| '|:|) (CAR |l|) 0))
                  (COND ((NOT (< |m| |k|)) (RETURN NIL))
                        (#1#
                         (PROGN
                          (SETQ |acc| (CONS (CAR |l|) |acc|))
                          (SETQ |l| (CDR |l|)))))))))))
      ((LAMBDA (|bfVar#26| |bfVar#25| |x|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#25|) (PROGN (SETQ |x| (CAR |bfVar#25|)) NIL))
            (RETURN |bfVar#26|))
           (#1# (SETQ |bfVar#26| (STRCONC |bfVar#26| |x|))))
          (SETQ |bfVar#25| (CDR |bfVar#25|))))
       "" (NREVERSE |acc|) NIL)))))

; transformAndRecheckComments(name,lines) ==
;   $checkingXmptex? := false
;   $x            : local := name
;   $name         : local := 'GlossaryPage
;   $origin       : local := 'gloss
;   $recheckingFlag : local := false
;   $exposeFlagHeading : local := ['"--------",name,'"---------"]
;   if null $exposeFlag then sayBrightly $exposeFlagHeading
;   u := checkComments(name,lines)
;   $recheckingFlag := true
;   checkRewrite(name,[u])
;   $recheckingFlag := false
;   u

(DEFUN |transformAndRecheckComments| (|name| |lines|)
  (PROG (|$exposeFlagHeading| |$recheckingFlag| |$origin| |$name| |$x| |u|)
    (DECLARE
     (SPECIAL |$exposeFlagHeading| |$recheckingFlag| |$origin| |$name| |$x|))
    (RETURN
     (PROGN
      (SETQ |$checkingXmptex?| NIL)
      (SETQ |$x| |name|)
      (SETQ |$name| '|GlossaryPage|)
      (SETQ |$origin| '|gloss|)
      (SETQ |$recheckingFlag| NIL)
      (SETQ |$exposeFlagHeading| (LIST "--------" |name| "---------"))
      (COND ((NULL |$exposeFlag|) (|sayBrightly| |$exposeFlagHeading|)))
      (SETQ |u| (|checkComments| |name| |lines|))
      (SETQ |$recheckingFlag| T)
      (|checkRewrite| |name| (LIST |u|))
      (SETQ |$recheckingFlag| NIL)
      |u|))))

; checkRewrite(name, lines) ==    --similar to checkComments from c-doc
;     $checkErrorFlag: local := true
;     margin := 0
;     lines := checkRemoveComments lines
;     u := lines
;     if $checkingXmptex? then
;       u := [checkAddIndented(x,margin) for x in u]
;     $argl := checkGetArgs first u      --set $argl
;     u2 := nil
;     verbatim := nil
;     for x in u repeat
;         w := newString2Words x
;         verbatim =>
;           w and first w = '"\end{verbatim}" =>
;             verbatim := false
;             u2 := append(u2, w)
;           u2 := append(u2, [x])
;         w and first w = '"\begin{verbatim}" =>
;             verbatim := true
;             u2 := append(u2, w)
;         u2 := append(u2, w)
;     u := u2
;     u := checkAddSpaces u
;     u := checkSplit2Words u
;     u := checkAddMacros u
;     u := checkTexht u
; --  checkBalance u
;     checkArguments u
;     if $checkErrorFlag then u := checkFixCommonProblem u
;     checkRecordHash u
; --  u := checkTranVerbatim u
;     checkDecorateForHt u

(DEFUN |checkRewrite| (|name| |lines|)
  (PROG (|$checkErrorFlag| |w| |verbatim| |u2| |u| |margin|)
    (DECLARE (SPECIAL |$checkErrorFlag|))
    (RETURN
     (PROGN
      (SETQ |$checkErrorFlag| T)
      (SETQ |margin| 0)
      (SETQ |lines| (|checkRemoveComments| |lines|))
      (SETQ |u| |lines|)
      (COND
       (|$checkingXmptex?|
        (SETQ |u|
                ((LAMBDA (|bfVar#28| |bfVar#27| |x|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#27|)
                          (PROGN (SETQ |x| (CAR |bfVar#27|)) NIL))
                      (RETURN (NREVERSE |bfVar#28|)))
                     (#1='T
                      (SETQ |bfVar#28|
                              (CONS (|checkAddIndented| |x| |margin|)
                                    |bfVar#28|))))
                    (SETQ |bfVar#27| (CDR |bfVar#27|))))
                 NIL |u| NIL))))
      (SETQ |$argl| (|checkGetArgs| (CAR |u|)))
      (SETQ |u2| NIL)
      (SETQ |verbatim| NIL)
      ((LAMBDA (|bfVar#29| |x|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#29|) (PROGN (SETQ |x| (CAR |bfVar#29|)) NIL))
            (RETURN NIL))
           (#1#
            (PROGN
             (SETQ |w| (|newString2Words| |x|))
             (COND
              (|verbatim|
               (COND
                ((AND |w| (EQUAL (CAR |w|) "\\end{verbatim}"))
                 (PROGN (SETQ |verbatim| NIL) (SETQ |u2| (APPEND |u2| |w|))))
                (#1# (SETQ |u2| (APPEND |u2| (LIST |x|))))))
              ((AND |w| (EQUAL (CAR |w|) "\\begin{verbatim}"))
               (PROGN (SETQ |verbatim| T) (SETQ |u2| (APPEND |u2| |w|))))
              (#1# (SETQ |u2| (APPEND |u2| |w|)))))))
          (SETQ |bfVar#29| (CDR |bfVar#29|))))
       |u| NIL)
      (SETQ |u| |u2|)
      (SETQ |u| (|checkAddSpaces| |u|))
      (SETQ |u| (|checkSplit2Words| |u|))
      (SETQ |u| (|checkAddMacros| |u|))
      (SETQ |u| (|checkTexht| |u|))
      (|checkArguments| |u|)
      (COND (|$checkErrorFlag| (SETQ |u| (|checkFixCommonProblem| |u|))))
      (|checkRecordHash| |u|)
      (|checkDecorateForHt| |u|)))))

; checkTexht u ==
;   count := 0
;   acc   := nil
;   while u repeat
;     x := first u
;     if x = '"\texht" and (u := IFCDR u) then
;         if not (IFCAR u = $charLbrace) then
;            checkDocError '"First left brace after \texht missing"
;         count := 1  -- drop first argument including braces of \texht
;         while ((y := IFCAR (u := rest u))~= $charRbrace or count > 1) repeat
;           if y = $charLbrace then count := count + 1
;           if y = $charRbrace then count := count - 1
;         x :=  IFCAR (u := rest u)  -- drop first right brace of 1st arg
;     if x = '"\httex" and (u := IFCDR u) and (IFCAR u = $charLbrace) then
;         acc := [IFCAR u,:acc]      --left  brace: add it
;         while (y := IFCAR (u := rest u)) ~= $charRbrace repeat (acc := [y,:acc])
;         acc := [IFCAR u,:acc]      --right brace: add it
;         x :=  IFCAR (u := rest u)  --left brace:  forget it
;         while IFCAR (u := rest u) ~= $charRbrace repeat 'skip
;         x :=  IFCAR (u := rest u)  --forget right brace: move to next char
;     acc := [x,:acc]
;     u := rest u
;   NREVERSE acc

(DEFUN |checkTexht| (|u|)
  (PROG (|count| |acc| |x| |y|)
    (RETURN
     (PROGN
      (SETQ |count| 0)
      (SETQ |acc| NIL)
      ((LAMBDA ()
         (LOOP
          (COND ((NOT |u|) (RETURN NIL))
                (#1='T
                 (PROGN
                  (SETQ |x| (CAR |u|))
                  (COND
                   ((AND (EQUAL |x| "\\texht") (SETQ |u| (IFCDR |u|)))
                    (COND
                     ((NULL (EQUAL (IFCAR |u|) |$charLbrace|))
                      (|checkDocError|
                       "First left brace after \\texht missing")))
                    (SETQ |count| 1)
                    ((LAMBDA ()
                       (LOOP
                        (COND
                         ((NOT
                           (OR
                            (NOT
                             (EQUAL (SETQ |y| (IFCAR (SETQ |u| (CDR |u|))))
                                    |$charRbrace|))
                            (< 1 |count|)))
                          (RETURN NIL))
                         (#1#
                          (PROGN
                           (COND
                            ((EQUAL |y| |$charLbrace|)
                             (SETQ |count| (+ |count| 1))))
                           (COND
                            ((EQUAL |y| |$charRbrace|)
                             (SETQ |count| (- |count| 1))))))))))
                    (SETQ |x| (IFCAR (SETQ |u| (CDR |u|))))))
                  (COND
                   ((AND (EQUAL |x| "\\httex") (SETQ |u| (IFCDR |u|))
                         (EQUAL (IFCAR |u|) |$charLbrace|))
                    (SETQ |acc| (CONS (IFCAR |u|) |acc|))
                    ((LAMBDA ()
                       (LOOP
                        (COND
                         ((EQUAL (SETQ |y| (IFCAR (SETQ |u| (CDR |u|))))
                                 |$charRbrace|)
                          (RETURN NIL))
                         (#1# (SETQ |acc| (CONS |y| |acc|)))))))
                    (SETQ |acc| (CONS (IFCAR |u|) |acc|))
                    (SETQ |x| (IFCAR (SETQ |u| (CDR |u|))))
                    ((LAMBDA ()
                       (LOOP
                        (COND
                         ((EQUAL (IFCAR (SETQ |u| (CDR |u|))) |$charRbrace|)
                          (RETURN NIL))
                         (#1# '|skip|)))))
                    (SETQ |x| (IFCAR (SETQ |u| (CDR |u|))))))
                  (SETQ |acc| (CONS |x| |acc|))
                  (SETQ |u| (CDR |u|))))))))
      (NREVERSE |acc|)))))

; checkRecordHash u ==
;   while u repeat
;     x := first u
;     if STRINGP x and x.0 = $charBack then
;       if member(x,$HTlinks) and (u := checkLookForLeftBrace IFCDR u)
;            and (u := checkLookForRightBrace IFCDR u)
;              and (u := checkLookForLeftBrace IFCDR u) and (u := IFCDR u) then
;         htname := intern IFCAR u
;         entry := HGET($htHash,htname) or [nil]
;         HPUT($htHash,htname,[first entry,:[[$name,:$origin],:rest entry]])
;       else if member(x,$HTlisplinks) and (u := checkLookForLeftBrace IFCDR u)
;             and (u := checkLookForRightBrace IFCDR u)
;               and (u := checkLookForLeftBrace IFCDR u) and (u := IFCDR u) then
;         htname := intern checkGetLispFunctionName checkGetStringBeforeRightBrace u
;         entry := HGET($lispHash,htname) or [nil]
;         HPUT($lispHash,htname,[first entry,:[[$name,:$origin],:rest entry]])
;       else if ((p := member(x,'("\gloss" "\spadglos")))
;                  or (q := member(x,'("\glossSee" "\spadglosSee"))))
;                     and (u := checkLookForLeftBrace IFCDR u)
;                       and (u := IFCDR u) then
;           if q then
;              u := checkLookForRightBrace u
;              u := checkLookForLeftBrace IFCDR u
;              u := IFCDR u
;           htname := intern checkGetStringBeforeRightBrace u
;           entry := HGET($glossHash,htname) or [nil]
;           HPUT($glossHash,htname,[first entry,:[[$name,:$origin],:rest entry]])
;       else if x = '"\spadsys" and (u := checkLookForLeftBrace IFCDR u) and (u := IFCDR u) then
;           s := checkGetStringBeforeRightBrace u
;           if s.0 = char '_) then s := SUBSTRING(s,1,nil)
;           parse := checkGetParse s
;           null parse => checkDocError ['"Unparseable \spadtype: ",s]
;           not member(opOf parse,$currentSysList) =>
;             checkDocError ['"Bad system command: ",s]
;           atom parse or not (parse is ['set,arg]) => 'ok  ---assume ok
;           not spadSysChoose($setOptions,arg) =>
;             checkDocError ['"Incorrect \spadsys: ",s]
;             entry := HGET($sysHash,htname) or [nil]
;             HPUT($sysHash,htname,[first entry,:[[$name,:$origin],:rest entry]])
;       else if x = '"\spadtype" and (u := checkLookForLeftBrace IFCDR u) and (u := IFCDR u) then
;           s := checkGetStringBeforeRightBrace u
;           parse := checkGetParse s
;           null parse => checkDocError ['"Unparseable \spadtype: ",s]
;           n := checkNumOfArgs parse
;           null n => checkDocError ['"Unknown \spadtype: ", s]
;           atom parse and n > 0 => 'skip
;           null (key := checkIsValidType parse) =>
;             checkDocError ['"Unknown \spadtype: ", s]
;           atom key => 'ok
;           checkDocError ['"Wrong number of arguments: ",form2HtString key]
;       else if member(x,'("\spadop" "\keyword")) and (u := checkLookForLeftBrace IFCDR u) and (u := IFCDR u) then
;           x := intern checkGetStringBeforeRightBrace u
;           not (GETL(x,'Led) or GETL(x,'Nud)) =>
;             checkDocError ['"Unknown \spadop: ",x]
;     u := rest u
;   'done

(DEFUN |checkRecordHash| (|u|)
  (PROG (|x| |htname| |entry| |p| |q| |s| |parse| |ISTMP#1| |arg| |n| |key|)
    (RETURN
     (PROGN
      ((LAMBDA ()
         (LOOP
          (COND ((NOT |u|) (RETURN NIL))
                (#1='T
                 (PROGN
                  (SETQ |x| (CAR |u|))
                  (COND
                   ((AND (STRINGP |x|) (EQUAL (ELT |x| 0) |$charBack|))
                    (COND
                     ((AND (|member| |x| |$HTlinks|)
                           (SETQ |u| (|checkLookForLeftBrace| (IFCDR |u|)))
                           (SETQ |u| (|checkLookForRightBrace| (IFCDR |u|)))
                           (SETQ |u| (|checkLookForLeftBrace| (IFCDR |u|)))
                           (SETQ |u| (IFCDR |u|)))
                      (SETQ |htname| (|intern| (IFCAR |u|)))
                      (SETQ |entry| (OR (HGET |$htHash| |htname|) (LIST NIL)))
                      (HPUT |$htHash| |htname|
                            (CONS (CAR |entry|)
                                  (CONS (CONS |$name| |$origin|)
                                        (CDR |entry|)))))
                     ((AND (|member| |x| |$HTlisplinks|)
                           (SETQ |u| (|checkLookForLeftBrace| (IFCDR |u|)))
                           (SETQ |u| (|checkLookForRightBrace| (IFCDR |u|)))
                           (SETQ |u| (|checkLookForLeftBrace| (IFCDR |u|)))
                           (SETQ |u| (IFCDR |u|)))
                      (SETQ |htname|
                              (|intern|
                               (|checkGetLispFunctionName|
                                (|checkGetStringBeforeRightBrace| |u|))))
                      (SETQ |entry|
                              (OR (HGET |$lispHash| |htname|) (LIST NIL)))
                      (HPUT |$lispHash| |htname|
                            (CONS (CAR |entry|)
                                  (CONS (CONS |$name| |$origin|)
                                        (CDR |entry|)))))
                     ((AND
                       (OR (SETQ |p| (|member| |x| '("\\gloss" "\\spadglos")))
                           (SETQ |q|
                                   (|member| |x|
                                    '("\\glossSee" "\\spadglosSee"))))
                       (SETQ |u| (|checkLookForLeftBrace| (IFCDR |u|)))
                       (SETQ |u| (IFCDR |u|)))
                      (COND
                       (|q| (SETQ |u| (|checkLookForRightBrace| |u|))
                        (SETQ |u| (|checkLookForLeftBrace| (IFCDR |u|)))
                        (SETQ |u| (IFCDR |u|))))
                      (SETQ |htname|
                              (|intern|
                               (|checkGetStringBeforeRightBrace| |u|)))
                      (SETQ |entry|
                              (OR (HGET |$glossHash| |htname|) (LIST NIL)))
                      (HPUT |$glossHash| |htname|
                            (CONS (CAR |entry|)
                                  (CONS (CONS |$name| |$origin|)
                                        (CDR |entry|)))))
                     ((AND (EQUAL |x| "\\spadsys")
                           (SETQ |u| (|checkLookForLeftBrace| (IFCDR |u|)))
                           (SETQ |u| (IFCDR |u|)))
                      (SETQ |s| (|checkGetStringBeforeRightBrace| |u|))
                      (COND
                       ((EQUAL (ELT |s| 0) (|char| '|)|))
                        (SETQ |s| (SUBSTRING |s| 1 NIL))))
                      (SETQ |parse| (|checkGetParse| |s|))
                      (COND
                       ((NULL |parse|)
                        (|checkDocError|
                         (LIST "Unparseable \\spadtype: " |s|)))
                       ((NULL (|member| (|opOf| |parse|) |$currentSysList|))
                        (|checkDocError| (LIST "Bad system command: " |s|)))
                       ((OR (ATOM |parse|)
                            (NULL
                             (AND (CONSP |parse|) (EQ (CAR |parse|) '|set|)
                                  (PROGN
                                   (SETQ |ISTMP#1| (CDR |parse|))
                                   (AND (CONSP |ISTMP#1|)
                                        (EQ (CDR |ISTMP#1|) NIL)
                                        (PROGN
                                         (SETQ |arg| (CAR |ISTMP#1|))
                                         #1#))))))
                        '|ok|)
                       ((NULL (|spadSysChoose| |$setOptions| |arg|))
                        (PROGN
                         (|checkDocError| (LIST "Incorrect \\spadsys: " |s|))
                         (SETQ |entry|
                                 (OR (HGET |$sysHash| |htname|) (LIST NIL)))
                         (HPUT |$sysHash| |htname|
                               (CONS (CAR |entry|)
                                     (CONS (CONS |$name| |$origin|)
                                           (CDR |entry|))))))))
                     ((AND (EQUAL |x| "\\spadtype")
                           (SETQ |u| (|checkLookForLeftBrace| (IFCDR |u|)))
                           (SETQ |u| (IFCDR |u|)))
                      (SETQ |s| (|checkGetStringBeforeRightBrace| |u|))
                      (SETQ |parse| (|checkGetParse| |s|))
                      (COND
                       ((NULL |parse|)
                        (|checkDocError|
                         (LIST "Unparseable \\spadtype: " |s|)))
                       (#1#
                        (PROGN
                         (SETQ |n| (|checkNumOfArgs| |parse|))
                         (COND
                          ((NULL |n|)
                           (|checkDocError| (LIST "Unknown \\spadtype: " |s|)))
                          ((AND (ATOM |parse|) (< 0 |n|)) '|skip|)
                          ((NULL (SETQ |key| (|checkIsValidType| |parse|)))
                           (|checkDocError| (LIST "Unknown \\spadtype: " |s|)))
                          ((ATOM |key|) '|ok|)
                          (#1#
                           (|checkDocError|
                            (LIST "Wrong number of arguments: "
                                  (|form2HtString| |key|)))))))))
                     ((AND (|member| |x| '("\\spadop" "\\keyword"))
                           (SETQ |u| (|checkLookForLeftBrace| (IFCDR |u|)))
                           (SETQ |u| (IFCDR |u|)))
                      (SETQ |x|
                              (|intern|
                               (|checkGetStringBeforeRightBrace| |u|)))
                      (COND
                       ((NULL (OR (GETL |x| '|Led|) (GETL |x| '|Nud|)))
                        (|checkDocError| (LIST "Unknown \\spadop: " |x|))))))))
                  (SETQ |u| (CDR |u|))))))))
      '|done|))))

; checkGetParse s == ncParseFromString removeBackslashes s

(DEFUN |checkGetParse| (|s|)
  (PROG () (RETURN (|ncParseFromString| (|removeBackslashes| |s|)))))

; removeBackslashes s ==
;     s = '"" => '""
;     (k := charPosition($charBack,s,0)) < #s =>
;       k = 0 => removeBackslashes SUBSTRING(s,1,nil)
;       STRCONC(SUBSTRING(s,0,k),removeBackslashes SUBSTRING(s,k + 1,nil))
;     s

(DEFUN |removeBackslashes| (|s|)
  (PROG (|k|)
    (RETURN
     (COND ((EQUAL |s| "") "")
           ((< (SETQ |k| (|charPosition| |$charBack| |s| 0)) (LENGTH |s|))
            (COND ((EQL |k| 0) (|removeBackslashes| (SUBSTRING |s| 1 NIL)))
                  (#1='T
                   (STRCONC (SUBSTRING |s| 0 |k|)
                    (|removeBackslashes| (SUBSTRING |s| (+ |k| 1) NIL))))))
           (#1# |s|)))))

; checkNumOfArgs conform ==
;   conname := opOf conform
;   constructor? conname or (conname := abbreviation? conname) =>
;     #GETDATABASE(conname,'CONSTRUCTORARGS)
;   nil  --signals error

(DEFUN |checkNumOfArgs| (|conform|)
  (PROG (|conname|)
    (RETURN
     (PROGN
      (SETQ |conname| (|opOf| |conform|))
      (COND
       ((OR (|constructor?| |conname|)
            (SETQ |conname| (|abbreviation?| |conname|)))
        (LENGTH (GETDATABASE |conname| 'CONSTRUCTORARGS)))
       ('T NIL))))))

; checkIsValidType form == main where
; --returns ok if correct, form is wrong number of arguments, nil if unknown
;   main ==
;     atom form => 'ok
;     [op,:args] := form
;     conname := (constructor? op => op; abbreviation? op)
;     null conname => nil
;     fn(form,GETDATABASE(conname,'COSIG))
;   fn(form,coSig) ==
;     #form ~= #coSig => form
;     or/[null checkIsValidType x for x in rest form for flag in rest coSig | flag]
;       => nil
;     'ok

(DEFUN |checkIsValidType| (|form|)
  (PROG (|op| |args| |conname|)
    (RETURN
     (COND ((ATOM |form|) '|ok|)
           (#1='T
            (PROGN
             (SETQ |op| (CAR |form|))
             (SETQ |args| (CDR |form|))
             (SETQ |conname|
                     (COND ((|constructor?| |op|) |op|)
                           (#1# (|abbreviation?| |op|))))
             (COND ((NULL |conname|) NIL)
                   (#1#
                    (|checkIsValidType,fn| |form|
                     (GETDATABASE |conname| 'COSIG))))))))))
(DEFUN |checkIsValidType,fn| (|form| |coSig|)
  (PROG ()
    (RETURN
     (COND ((NOT (EQL (LENGTH |form|) (LENGTH |coSig|))) |form|)
           (((LAMBDA (|bfVar#32| |bfVar#30| |x| |bfVar#31| |flag|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#30|) (PROGN (SETQ |x| (CAR |bfVar#30|)) NIL)
                      (ATOM |bfVar#31|)
                      (PROGN (SETQ |flag| (CAR |bfVar#31|)) NIL))
                  (RETURN |bfVar#32|))
                 (#1='T
                  (AND |flag|
                       (PROGN
                        (SETQ |bfVar#32| (NULL (|checkIsValidType| |x|)))
                        (COND (|bfVar#32| (RETURN |bfVar#32|)))))))
                (SETQ |bfVar#30| (CDR |bfVar#30|))
                (SETQ |bfVar#31| (CDR |bfVar#31|))))
             NIL (CDR |form|) NIL (CDR |coSig|) NIL)
            NIL)
           (#1# '|ok|)))))

; checkGetLispFunctionName s ==
;   n := #s
;   (k := charPosition(char '_|,s,1)) and k < n and
;     (j := charPosition(char '_|,s,k + 1)) and j < n => SUBSTRING(s,k + 1,j-k-1)
;   checkDocError ['"Ill-formed lisp expression : ",s]
;   'illformed

(DEFUN |checkGetLispFunctionName| (|s|)
  (PROG (|n| |k| |j|)
    (RETURN
     (PROGN
      (SETQ |n| (LENGTH |s|))
      (COND
       ((AND (SETQ |k| (|charPosition| (|char| '|\||) |s| 1)) (< |k| |n|)
             (SETQ |j| (|charPosition| (|char| '|\||) |s| (+ |k| 1)))
             (< |j| |n|))
        (SUBSTRING |s| (+ |k| 1) (- (- |j| |k|) 1)))
       ('T
        (PROGN
         (|checkDocError| (LIST "Ill-formed lisp expression : " |s|))
         '|illformed|)))))))

; checkGetStringBeforeRightBrace u ==
;   acc := nil
;   while u repeat
;     x := first u
;     x = $charRbrace => return "STRCONC"/(NREVERSE acc)
;     acc := [x,:acc]
;     u := rest u

(DEFUN |checkGetStringBeforeRightBrace| (|u|)
  (PROG (|acc| |x|)
    (RETURN
     (PROGN
      (SETQ |acc| NIL)
      ((LAMBDA ()
         (LOOP
          (COND ((NOT |u|) (RETURN NIL))
                (#1='T
                 (PROGN
                  (SETQ |x| (CAR |u|))
                  (COND
                   ((EQUAL |x| |$charRbrace|)
                    (RETURN
                     ((LAMBDA (|bfVar#33| |bfVar#35| |bfVar#34|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#35|)
                               (PROGN (SETQ |bfVar#34| (CAR |bfVar#35|)) NIL))
                           (RETURN |bfVar#33|))
                          (#1#
                           (SETQ |bfVar#33| (STRCONC |bfVar#33| |bfVar#34|))))
                         (SETQ |bfVar#35| (CDR |bfVar#35|))))
                      "" (NREVERSE |acc|) NIL)))
                   (#1#
                    (PROGN
                     (SETQ |acc| (CONS |x| |acc|))
                     (SETQ |u| (CDR |u|)))))))))))))))

; appendOver [head,:tail] ==
;  acc := LASTNODE head
;  for x in tail repeat
;    end := LASTNODE x
;    RPLACD(acc,x)
;    acc := end
;  head

(DEFUN |appendOver| (|bfVar#37|)
  (PROG (|head| |tail| |acc| |end|)
    (RETURN
     (PROGN
      (SETQ |head| (CAR |bfVar#37|))
      (SETQ |tail| (CDR |bfVar#37|))
      (SETQ |acc| (LASTNODE |head|))
      ((LAMBDA (|bfVar#36| |x|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#36|) (PROGN (SETQ |x| (CAR |bfVar#36|)) NIL))
            (RETURN NIL))
           ('T
            (PROGN
             (SETQ |end| (LASTNODE |x|))
             (RPLACD |acc| |x|)
             (SETQ |acc| |end|))))
          (SETQ |bfVar#36| (CDR |bfVar#36|))))
       |tail| NIL)
      |head|))))

; checkRemoveComments lines ==
;   while lines repeat
;     do
;       line := checkTrimCommented first lines
;       if firstNonBlankPosition line >= 0 then acc := [line,:acc]
;     lines := rest lines
;   NREVERSE acc

(DEFUN |checkRemoveComments| (|lines|)
  (PROG (|line| |acc|)
    (RETURN
     (PROGN
      ((LAMBDA ()
         (LOOP
          (COND ((NOT |lines|) (RETURN NIL))
                ('T
                 (PROGN
                  (|do|
                   (PROGN
                    (SETQ |line| (|checkTrimCommented| (CAR |lines|)))
                    (COND
                     ((NOT (MINUSP (|firstNonBlankPosition| |line|)))
                      (SETQ |acc| (CONS |line| |acc|))))))
                  (SETQ |lines| (CDR |lines|))))))))
      (NREVERSE |acc|)))))

; checkTrimCommented line ==
;   n := #line
;   k := htcharPosition(char '_%,line,0)
;   --line beginning with % is a comment
;   k = 0 => '""
;   --remarks beginning with %% are comments
;   k >= n - 1 or line.(k + 1) ~= char '_% => line
;   k < #line => SUBSTRING(line,0,k)
;   line

(DEFUN |checkTrimCommented| (|line|)
  (PROG (|n| |k|)
    (RETURN
     (PROGN
      (SETQ |n| (LENGTH |line|))
      (SETQ |k| (|htcharPosition| (|char| '%) |line| 0))
      (COND ((EQL |k| 0) "")
            ((OR (NOT (< |k| (- |n| 1)))
                 (NOT (EQUAL (ELT |line| (+ |k| 1)) (|char| '%))))
             |line|)
            ((< |k| (LENGTH |line|)) (SUBSTRING |line| 0 |k|)) ('T |line|))))))

; htcharPosition(char,line,i) ==
;   m := #line
;   k := charPosition(char,line,i)
;   k = m => k
;   k > 0 =>
;     line.(k - 1) ~= $charBack => k
;     htcharPosition(char,line,k + 1)
;   0

(DEFUN |htcharPosition| (|char| |line| |i|)
  (PROG (|m| |k|)
    (RETURN
     (PROGN
      (SETQ |m| (LENGTH |line|))
      (SETQ |k| (|charPosition| |char| |line| |i|))
      (COND ((EQUAL |k| |m|) |k|)
            ((< 0 |k|)
             (COND ((NOT (EQUAL (ELT |line| (- |k| 1)) |$charBack|)) |k|)
                   (#1='T (|htcharPosition| |char| |line| (+ |k| 1)))))
            (#1# 0))))))

; checkAddMacros u ==
;   acc := nil
;   verbatim := false
;   while u repeat
;     x := first u
;     acc :=
;       x = '"\end{verbatim}" =>
;         verbatim := false
;         [x, :acc]
;       verbatim => [x, :acc]
;       x = '"\begin{verbatim}" =>
;         verbatim := true
;         [x, :acc]
;       y := LASSOC(x,$HTmacs) => [:y,:acc]
;       [x,:acc]
;     u := rest u
;   NREVERSE acc

(DEFUN |checkAddMacros| (|u|)
  (PROG (|acc| |verbatim| |x| |y|)
    (RETURN
     (PROGN
      (SETQ |acc| NIL)
      (SETQ |verbatim| NIL)
      ((LAMBDA ()
         (LOOP
          (COND ((NOT |u|) (RETURN NIL))
                (#1='T
                 (PROGN
                  (SETQ |x| (CAR |u|))
                  (SETQ |acc|
                          (COND
                           ((EQUAL |x| "\\end{verbatim}")
                            (PROGN (SETQ |verbatim| NIL) (CONS |x| |acc|)))
                           (|verbatim| (CONS |x| |acc|))
                           ((EQUAL |x| "\\begin{verbatim}")
                            (PROGN (SETQ |verbatim| T) (CONS |x| |acc|)))
                           ((SETQ |y| (LASSOC |x| |$HTmacs|))
                            (APPEND |y| |acc|))
                           (#1# (CONS |x| |acc|))))
                  (SETQ |u| (CDR |u|))))))))
      (NREVERSE |acc|)))))

; checkComments(nameSig,lines) == main where
;   main ==
;     $checkErrorFlag: local := false
;     margin := checkGetMargin lines
;     if (null BOUNDP '$attribute? or null $attribute?)
;       and nameSig ~= 'constructor then lines :=
;         [checkTransformFirsts(first nameSig,first lines,margin),:rest lines]
;     u := checkIndentedLines(lines, margin)
;     $argl := checkGetArgs first u      --set $argl
;     u2 := nil
;     verbatim := nil
;     for x in u repeat
;         w := newString2Words x
;         verbatim =>
;           w and first w = '"\end{verbatim}" =>
;             verbatim := false
;             u2 := append(u2, w)
;           u2 := append(u2, [x])
;         w and first w = '"\begin{verbatim}" =>
;             verbatim := true
;             u2 := append(u2, w)
;         u2 := append(u2, w)
;     u := u2
;     u := checkAddSpaces u
;     u := checkIeEg u
;     u := checkSplit2Words u
;     checkBalance u
;     checkArguments u
;     if $checkErrorFlag then u := checkFixCommonProblem u
;     v := checkDecorate u
;     res := "STRCONC"/[y for y in v]
;     res := checkAddPeriod res
;     if $checkErrorFlag then pp res
;     res

(DEFUN |checkComments| (|nameSig| |lines|)
  (PROG (|$checkErrorFlag| |res| |v| |w| |verbatim| |u2| |u| |margin|)
    (DECLARE (SPECIAL |$checkErrorFlag|))
    (RETURN
     (PROGN
      (SETQ |$checkErrorFlag| NIL)
      (SETQ |margin| (|checkGetMargin| |lines|))
      (COND
       ((AND (OR (NULL (BOUNDP '|$attribute?|)) (NULL |$attribute?|))
             (NOT (EQ |nameSig| '|constructor|)))
        (SETQ |lines|
                (CONS
                 (|checkTransformFirsts| (CAR |nameSig|) (CAR |lines|)
                  |margin|)
                 (CDR |lines|)))))
      (SETQ |u| (|checkIndentedLines| |lines| |margin|))
      (SETQ |$argl| (|checkGetArgs| (CAR |u|)))
      (SETQ |u2| NIL)
      (SETQ |verbatim| NIL)
      ((LAMBDA (|bfVar#38| |x|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#38|) (PROGN (SETQ |x| (CAR |bfVar#38|)) NIL))
            (RETURN NIL))
           (#1='T
            (PROGN
             (SETQ |w| (|newString2Words| |x|))
             (COND
              (|verbatim|
               (COND
                ((AND |w| (EQUAL (CAR |w|) "\\end{verbatim}"))
                 (PROGN (SETQ |verbatim| NIL) (SETQ |u2| (APPEND |u2| |w|))))
                (#1# (SETQ |u2| (APPEND |u2| (LIST |x|))))))
              ((AND |w| (EQUAL (CAR |w|) "\\begin{verbatim}"))
               (PROGN (SETQ |verbatim| T) (SETQ |u2| (APPEND |u2| |w|))))
              (#1# (SETQ |u2| (APPEND |u2| |w|)))))))
          (SETQ |bfVar#38| (CDR |bfVar#38|))))
       |u| NIL)
      (SETQ |u| |u2|)
      (SETQ |u| (|checkAddSpaces| |u|))
      (SETQ |u| (|checkIeEg| |u|))
      (SETQ |u| (|checkSplit2Words| |u|))
      (|checkBalance| |u|)
      (|checkArguments| |u|)
      (COND (|$checkErrorFlag| (SETQ |u| (|checkFixCommonProblem| |u|))))
      (SETQ |v| (|checkDecorate| |u|))
      (SETQ |res|
              ((LAMBDA (|bfVar#40| |bfVar#39| |y|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#39|)
                        (PROGN (SETQ |y| (CAR |bfVar#39|)) NIL))
                    (RETURN |bfVar#40|))
                   (#1# (SETQ |bfVar#40| (STRCONC |bfVar#40| |y|))))
                  (SETQ |bfVar#39| (CDR |bfVar#39|))))
               "" |v| NIL))
      (SETQ |res| (|checkAddPeriod| |res|))
      (COND (|$checkErrorFlag| (|pp| |res|)))
      |res|))))

; checkIndentedLines(u, margin) ==
;   verbatim := false
;   u2 := nil
;   for x in u repeat
;     k := firstNonBlankPosition x
;     k = -1 =>
;         verbatim => u2 := [:u2, $charFauxNewline]
;         u2 := [:u2, '"\blankline "]
;     s := SUBSTRING(x, k, nil)
;     s = '"\begin{verbatim}" =>
;         verbatim := true
;         u2 := [:u2, s]
;     s = '"\end{verbatim}" =>
;         verbatim := false
;         u2 := [:u2, s]
;     verbatim => u2 := [:u2, SUBSTRING(x, margin, nil)]
;     margin = k => u2 := [:u2, s]
;     u2 := [:u2, STRCONC('"\indented{",STRINGIMAGE(k-margin),'"}{",checkAddSpaceSegments(s,0),'"}")]
;   u2

(DEFUN |checkIndentedLines| (|u| |margin|)
  (PROG (|verbatim| |u2| |k| |s|)
    (RETURN
     (PROGN
      (SETQ |verbatim| NIL)
      (SETQ |u2| NIL)
      ((LAMBDA (|bfVar#41| |x|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#41|) (PROGN (SETQ |x| (CAR |bfVar#41|)) NIL))
            (RETURN NIL))
           (#1='T
            (PROGN
             (SETQ |k| (|firstNonBlankPosition| |x|))
             (COND
              ((EQUAL |k| (- 1))
               (COND
                (|verbatim|
                 (SETQ |u2| (APPEND |u2| (CONS |$charFauxNewline| NIL))))
                (#1# (SETQ |u2| (APPEND |u2| (CONS "\\blankline " NIL))))))
              (#1#
               (PROGN
                (SETQ |s| (SUBSTRING |x| |k| NIL))
                (COND
                 ((EQUAL |s| "\\begin{verbatim}")
                  (PROGN
                   (SETQ |verbatim| T)
                   (SETQ |u2| (APPEND |u2| (CONS |s| NIL)))))
                 ((EQUAL |s| "\\end{verbatim}")
                  (PROGN
                   (SETQ |verbatim| NIL)
                   (SETQ |u2| (APPEND |u2| (CONS |s| NIL)))))
                 (|verbatim|
                  (SETQ |u2|
                          (APPEND |u2|
                                  (CONS (SUBSTRING |x| |margin| NIL) NIL))))
                 ((EQUAL |margin| |k|)
                  (SETQ |u2| (APPEND |u2| (CONS |s| NIL))))
                 (#1#
                  (SETQ |u2|
                          (APPEND |u2|
                                  (CONS
                                   (STRCONC "\\indented{"
                                    (STRINGIMAGE (- |k| |margin|)) "}{"
                                    (|checkAddSpaceSegments| |s| 0) "}")
                                   NIL)))))))))))
          (SETQ |bfVar#41| (CDR |bfVar#41|))))
       |u| NIL)
      |u2|))))

; newString2Words l ==
;   not STRINGP l => [l]
;   m := MAXINDEX l
;   m = -1 => NIL
;   i := 0
;   [w while newWordFrom(l,i,m) is [w,i]]

(DEFUN |newString2Words| (|l|)
  (PROG (|m| |i| |ISTMP#1| |w| |ISTMP#2|)
    (RETURN
     (COND ((NULL (STRINGP |l|)) (LIST |l|))
           (#1='T
            (PROGN
             (SETQ |m| (MAXINDEX |l|))
             (COND ((EQUAL |m| (- 1)) NIL)
                   (#1#
                    (PROGN
                     (SETQ |i| 0)
                     ((LAMBDA (|bfVar#42|)
                        (LOOP
                         (COND
                          ((NOT
                            (PROGN
                             (SETQ |ISTMP#1| (|newWordFrom| |l| |i| |m|))
                             (AND (CONSP |ISTMP#1|)
                                  (PROGN
                                   (SETQ |w| (CAR |ISTMP#1|))
                                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                   (AND (CONSP |ISTMP#2|)
                                        (EQ (CDR |ISTMP#2|) NIL)
                                        (PROGN
                                         (SETQ |i| (CAR |ISTMP#2|))
                                         #1#))))))
                           (RETURN (NREVERSE |bfVar#42|)))
                          (#1# (SETQ |bfVar#42| (CONS |w| |bfVar#42|))))))
                      NIL))))))))))

; newWordFrom(l,i,m) ==
;   while i <= m and l.i = $charBlank repeat i := i + 1
;   i > m => NIL
;   i0 := i
;   ch := l.i
;   ch = $charFauxNewline => [$stringFauxNewline, i+ 1]
;   done := false
;   while i <= m and not done repeat
;     ch := l.i
;     ch = $charBlank or ch = $charFauxNewline => done := true
;     i := i + 1
;   [SUBSTRING(l, i0, i - i0), i]

(DEFUN |newWordFrom| (|l| |i| |m|)
  (PROG (|i0| |ch| |done|)
    (RETURN
     (PROGN
      ((LAMBDA ()
         (LOOP
          (COND
           ((NOT (AND (NOT (< |m| |i|)) (EQUAL (ELT |l| |i|) |$charBlank|)))
            (RETURN NIL))
           (#1='T (SETQ |i| (+ |i| 1)))))))
      (COND ((< |m| |i|) NIL)
            (#1#
             (PROGN
              (SETQ |i0| |i|)
              (SETQ |ch| (ELT |l| |i|))
              (COND
               ((EQUAL |ch| |$charFauxNewline|)
                (LIST |$stringFauxNewline| (+ |i| 1)))
               (#1#
                (PROGN
                 (SETQ |done| NIL)
                 ((LAMBDA ()
                    (LOOP
                     (COND
                      ((NOT (AND (NOT (< |m| |i|)) (NULL |done|)))
                       (RETURN NIL))
                      (#1#
                       (PROGN
                        (SETQ |ch| (ELT |l| |i|))
                        (COND
                         ((OR (EQUAL |ch| |$charBlank|)
                              (EQUAL |ch| |$charFauxNewline|))
                          (SETQ |done| T))
                         (#1# (SETQ |i| (+ |i| 1))))))))))
                 (LIST (SUBSTRING |l| |i0| (- |i| |i0|)) |i|)))))))))))

; checkAddPeriod s ==  --No, just leave blank at the end (rdj: 10/18/91)
;   m := MAXINDEX s
;   lastChar := s . m
;   lastChar = char '_! or lastChar = char '_? or lastChar = char '_. => s
;   lastChar = char '_, or lastChar = char '_; =>
;     s . m := (char '_.)
;     s
;   s

(DEFUN |checkAddPeriod| (|s|)
  (PROG (|m| |lastChar|)
    (RETURN
     (PROGN
      (SETQ |m| (MAXINDEX |s|))
      (SETQ |lastChar| (ELT |s| |m|))
      (COND
       ((OR (EQUAL |lastChar| (|char| '!)) (EQUAL |lastChar| (|char| '?))
            (EQUAL |lastChar| (|char| '|.|)))
        |s|)
       ((OR (EQUAL |lastChar| (|char| '|,|)) (EQUAL |lastChar| (|char| '|;|)))
        (PROGN (SETF (ELT |s| |m|) (|char| '|.|)) |s|))
       ('T |s|))))))

; checkGetArgs u ==
;   NOT STRINGP u => nil
;   m := MAXINDEX u
;   k := firstNonBlankPosition(u)
;   k > 0 => checkGetArgs SUBSTRING(u,k,nil)
;   stringPrefix?('"\spad{",u) =>
;     k := getMatchingRightPren(u,6,char '_{,char '_}) or m
;     checkGetArgs SUBSTRING(u,6,k-6)
;   (i := charPosition(char '_(,u,0)) > m => nil
;   (u . m) ~= char '_) => nil
;   while (k := charPosition($charComma,u,i + 1)) < m repeat
;     acc := [trimString SUBSTRING(u,i + 1,k - i - 1),:acc]
;     i := k
;   NREVERSE [SUBSTRING(u,i + 1,m - i - 1),:acc]

(DEFUN |checkGetArgs| (|u|)
  (PROG (|m| |k| |i| |acc|)
    (RETURN
     (COND ((NULL (STRINGP |u|)) NIL)
           (#1='T
            (PROGN
             (SETQ |m| (MAXINDEX |u|))
             (SETQ |k| (|firstNonBlankPosition| |u|))
             (COND ((< 0 |k|) (|checkGetArgs| (SUBSTRING |u| |k| NIL)))
                   ((|stringPrefix?| "\\spad{" |u|)
                    (PROGN
                     (SETQ |k|
                             (OR
                              (|getMatchingRightPren| |u| 6 (|char| '{)
                               (|char| '}))
                              |m|))
                     (|checkGetArgs| (SUBSTRING |u| 6 (- |k| 6)))))
                   ((< |m| (SETQ |i| (|charPosition| (|char| '|(|) |u| 0)))
                    NIL)
                   ((NOT (EQUAL (ELT |u| |m|) (|char| '|)|))) NIL)
                   (#1#
                    (PROGN
                     ((LAMBDA ()
                        (LOOP
                         (COND
                          ((NOT
                            (<
                             (SETQ |k|
                                     (|charPosition| |$charComma| |u|
                                      (+ |i| 1)))
                             |m|))
                           (RETURN NIL))
                          (#1#
                           (PROGN
                            (SETQ |acc|
                                    (CONS
                                     (|trimString|
                                      (SUBSTRING |u| (+ |i| 1)
                                                 (- (- |k| |i|) 1)))
                                     |acc|))
                            (SETQ |i| |k|)))))))
                     (NREVERSE
                      (CONS (SUBSTRING |u| (+ |i| 1) (- (- |m| |i|) 1))
                            |acc|)))))))))))

; checkGetMargin lines ==
;   while lines repeat
;     do
;       x := first lines
;       k := firstNonBlankPosition x
;       k = -1 => nil
;       margin := (margin => MIN(margin,k); k)
;     lines := rest lines
;   margin or 0

(DEFUN |checkGetMargin| (|lines|)
  (PROG (|x| |k| |margin|)
    (RETURN
     (PROGN
      ((LAMBDA ()
         (LOOP
          (COND ((NOT |lines|) (RETURN NIL))
                (#1='T
                 (PROGN
                  (|do|
                   (PROGN
                    (SETQ |x| (CAR |lines|))
                    (SETQ |k| (|firstNonBlankPosition| |x|))
                    (COND ((EQUAL |k| (- 1)) NIL)
                          (#1#
                           (SETQ |margin|
                                   (COND (|margin| (MIN |margin| |k|))
                                         (#1# |k|)))))))
                  (SETQ |lines| (CDR |lines|))))))))
      (OR |margin| 0)))))

; firstNonBlankPosition(x,:options) ==
;   start := IFCAR options or 0
;   k := -1
;   for i in start..MAXINDEX x repeat
;     if x.i ~= $charBlank then return (k := i)
;   k

(DEFUN |firstNonBlankPosition| (|x| &REST |options|)
  (PROG (|start| |k|)
    (RETURN
     (PROGN
      (SETQ |start| (OR (IFCAR |options|) 0))
      (SETQ |k| (- 1))
      ((LAMBDA (|bfVar#43| |i|)
         (LOOP
          (COND ((> |i| |bfVar#43|) (RETURN NIL))
                ('T
                 (COND
                  ((NOT (EQUAL (ELT |x| |i|) |$charBlank|))
                   (RETURN (SETQ |k| |i|))))))
          (SETQ |i| (+ |i| 1))))
       (MAXINDEX |x|) |start|)
      |k|))))

; checkAddIndented(x,margin) ==
;   k := firstNonBlankPosition x
;   k = -1 => '"\blankline "
;   margin = k => x
;   STRCONC('"\indented{",STRINGIMAGE(k-margin),'"}{",checkAddSpaceSegments(SUBSTRING(x,k,nil),0),'"}")

(DEFUN |checkAddIndented| (|x| |margin|)
  (PROG (|k|)
    (RETURN
     (PROGN
      (SETQ |k| (|firstNonBlankPosition| |x|))
      (COND ((EQUAL |k| (- 1)) "\\blankline ") ((EQUAL |margin| |k|) |x|)
            ('T
             (STRCONC "\\indented{" (STRINGIMAGE (- |k| |margin|)) "}{"
              (|checkAddSpaceSegments| (SUBSTRING |x| |k| NIL) 0) "}")))))))

; checkAddSpaceSegments(u,k) ==
;   m := MAXINDEX u
;   i := charPosition($charBlank,u,k)
;   m < i => u
;   j := i
;   while (j := j + 1) < m and u.j = (char '_  ) repeat 'continue
;   n := j - i   --number of blanks
;   n > 1 => STRCONC(SUBSTRING(u,0,i),'"\space{",
;              STRINGIMAGE n,'"}",checkAddSpaceSegments(SUBSTRING(u,i + n,nil),0))
;   checkAddSpaceSegments(u,j)

(DEFUN |checkAddSpaceSegments| (|u| |k|)
  (PROG (|m| |i| |j| |n|)
    (RETURN
     (PROGN
      (SETQ |m| (MAXINDEX |u|))
      (SETQ |i| (|charPosition| |$charBlank| |u| |k|))
      (COND ((< |m| |i|) |u|)
            (#1='T
             (PROGN
              (SETQ |j| |i|)
              ((LAMBDA ()
                 (LOOP
                  (COND
                   ((NOT
                     (AND (< (SETQ |j| (+ |j| 1)) |m|)
                          (EQUAL (ELT |u| |j|) (|char| '| |))))
                    (RETURN NIL))
                   (#1# '|continue|)))))
              (SETQ |n| (- |j| |i|))
              (COND
               ((< 1 |n|)
                (STRCONC (SUBSTRING |u| 0 |i|) "\\space{" (STRINGIMAGE |n|) "}"
                 (|checkAddSpaceSegments| (SUBSTRING |u| (+ |i| |n|) NIL) 0)))
               (#1# (|checkAddSpaceSegments| |u| |j|))))))))))

; checkTrim($x,lines) == main where
;   main ==
;     s := [wherePP first lines]
;     for x in rest lines repeat
;       j := wherePP x
;       if not MEMQ(j,s) then
;         checkDocError [$x,'" has varying indentation levels"]
;         s := [j,:s]
;     [trim y for y in lines]
;   wherePP(u) ==
;     k := charPosition($charPlus,u,0)
;     k = #u or charPosition($charPlus,u,k + 1) ~= k + 1 =>
;       systemError '" Improper comment found"
;     k
;   trim(s) ==
;     k := wherePP(s)
;     return SUBSTRING(s,k + 2,nil)
;     m := MAXINDEX s
;     n := k + 2
;     for j in (k + 2)..m while s.j = $charBlank repeat (n := n + 1)
;     SUBSTRING(s,n,nil)

(DEFUN |checkTrim| (|$x| |lines|)
  (DECLARE (SPECIAL |$x|))
  (PROG (|s| |j|)
    (RETURN
     (PROGN
      (SETQ |s| (LIST (|checkTrim,wherePP| (CAR |lines|))))
      ((LAMBDA (|bfVar#44| |x|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#44|) (PROGN (SETQ |x| (CAR |bfVar#44|)) NIL))
            (RETURN NIL))
           (#1='T
            (PROGN
             (SETQ |j| (|checkTrim,wherePP| |x|))
             (COND
              ((NULL (MEMQ |j| |s|))
               (|checkDocError| (LIST |$x| " has varying indentation levels"))
               (SETQ |s| (CONS |j| |s|)))))))
          (SETQ |bfVar#44| (CDR |bfVar#44|))))
       (CDR |lines|) NIL)
      ((LAMBDA (|bfVar#46| |bfVar#45| |y|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#45|) (PROGN (SETQ |y| (CAR |bfVar#45|)) NIL))
            (RETURN (NREVERSE |bfVar#46|)))
           (#1# (SETQ |bfVar#46| (CONS (|checkTrim,trim| |y|) |bfVar#46|))))
          (SETQ |bfVar#45| (CDR |bfVar#45|))))
       NIL |lines| NIL)))))
(DEFUN |checkTrim,wherePP| (|u|)
  (PROG (|k|)
    (RETURN
     (PROGN
      (SETQ |k| (|charPosition| |$charPlus| |u| 0))
      (COND
       ((OR (EQL |k| (LENGTH |u|))
            (NOT (EQUAL (|charPosition| |$charPlus| |u| (+ |k| 1)) (+ |k| 1))))
        (|systemError| " Improper comment found"))
       ('T |k|))))))
(DEFUN |checkTrim,trim| (|s|)
  (PROG (|k| |m| |n|)
    (RETURN
     (PROGN
      (SETQ |k| (|checkTrim,wherePP| |s|))
      (RETURN (SUBSTRING |s| (+ |k| 2) NIL))
      (SETQ |m| (MAXINDEX |s|))
      (SETQ |n| (+ |k| 2))
      ((LAMBDA (|j|)
         (LOOP
          (COND
           ((OR (> |j| |m|) (NOT (EQUAL (ELT |s| |j|) |$charBlank|)))
            (RETURN NIL))
           ('T (SETQ |n| (+ |n| 1))))
          (SETQ |j| (+ |j| 1))))
       (+ |k| 2))
      (SUBSTRING |s| |n| NIL)))))

; checkExtract(header,lines) ==
;   while lines repeat
;     line := first lines
;     k := firstNonBlankPosition line           --k gives margin of Description:
;     substring?(header,line,k) => return nil
;     lines := rest lines
;   null lines => nil
;   u := first lines
;   j := charPosition(char '_:,u,k)
;   margin := k
;   firstLines :=
;     (k := firstNonBlankPosition(u,j + 1)) ~= -1 =>
;       [SUBSTRING(u,j + 1,nil),:rest lines]
;     rest lines
;   --now look for another header; if found skip all rest of these lines
;   acc := nil
;   for line in firstLines repeat
;     do
;       m := #line
;       (k := firstNonBlankPosition line) = -1     => 'skip  --include if blank
;       k > margin                                 => 'skip  --include if idented
;       not UPPER_-CASE_-P line.k                  => 'skip  --also if not upcased
;       (j := charPosition(char '_:,line,k)) = m   => 'skip  --or if not colon, or
;       (i := charPosition(char '_ ,line,k+1)) < j => 'skip  --blank before colon
;       return nil
;     acc := [line,:acc]
;   NREVERSE acc

(DEFUN |checkExtract| (|header| |lines|)
  (PROG (|line| |k| |u| |j| |margin| |firstLines| |acc| |m| |i|)
    (RETURN
     (PROGN
      ((LAMBDA ()
         (LOOP
          (COND ((NOT |lines|) (RETURN NIL))
                (#1='T
                 (PROGN
                  (SETQ |line| (CAR |lines|))
                  (SETQ |k| (|firstNonBlankPosition| |line|))
                  (COND ((|substring?| |header| |line| |k|) (RETURN NIL))
                        (#1# (SETQ |lines| (CDR |lines|))))))))))
      (COND ((NULL |lines|) NIL)
            (#1#
             (PROGN
              (SETQ |u| (CAR |lines|))
              (SETQ |j| (|charPosition| (|char| '|:|) |u| |k|))
              (SETQ |margin| |k|)
              (SETQ |firstLines|
                      (COND
                       ((NOT
                         (EQUAL
                          (SETQ |k| (|firstNonBlankPosition| |u| (+ |j| 1)))
                          (- 1)))
                        (CONS (SUBSTRING |u| (+ |j| 1) NIL) (CDR |lines|)))
                       (#1# (CDR |lines|))))
              (SETQ |acc| NIL)
              ((LAMBDA (|bfVar#47| |line|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#47|)
                        (PROGN (SETQ |line| (CAR |bfVar#47|)) NIL))
                    (RETURN NIL))
                   (#1#
                    (PROGN
                     (|do|
                      (PROGN
                       (SETQ |m| (LENGTH |line|))
                       (COND
                        ((EQUAL (SETQ |k| (|firstNonBlankPosition| |line|))
                                (- 1))
                         '|skip|)
                        ((< |margin| |k|) '|skip|)
                        ((NULL (UPPER-CASE-P (ELT |line| |k|))) '|skip|)
                        ((EQUAL
                          (SETQ |j| (|charPosition| (|char| '|:|) |line| |k|))
                          |m|)
                         '|skip|)
                        ((<
                          (SETQ |i|
                                  (|charPosition| (|char| '| |) |line|
                                   (+ |k| 1)))
                          |j|)
                         '|skip|)
                        (#1# (RETURN NIL)))))
                     (SETQ |acc| (CONS |line| |acc|)))))
                  (SETQ |bfVar#47| (CDR |bfVar#47|))))
               |firstLines| NIL)
              (NREVERSE |acc|))))))))

; checkFixCommonProblem u ==
;   acc := nil
;   while u repeat
;     x := first u
;     x = $charLbrace and member(next := IFCAR rest u,$HTspadmacros) and
;                        (IFCAR IFCDR rest u ~= $charLbrace) =>
;       checkDocError ['"Reversing ",next,'" and left brace"]
;       acc := [$charLbrace,next,:acc]  --reverse order of brace and command
;       u := rest rest u
;     acc := [x,:acc]
;     u := rest u
;   NREVERSE acc

(DEFUN |checkFixCommonProblem| (|u|)
  (PROG (|acc| |x| |next|)
    (RETURN
     (PROGN
      (SETQ |acc| NIL)
      ((LAMBDA ()
         (LOOP
          (COND ((NOT |u|) (RETURN NIL))
                (#1='T
                 (PROGN
                  (SETQ |x| (CAR |u|))
                  (COND
                   ((AND (EQUAL |x| |$charLbrace|)
                         (|member| (SETQ |next| (IFCAR (CDR |u|)))
                          |$HTspadmacros|)
                         (NOT (EQUAL (IFCAR (IFCDR (CDR |u|))) |$charLbrace|)))
                    (PROGN
                     (|checkDocError|
                      (LIST "Reversing " |next| " and left brace"))
                     (SETQ |acc| (CONS |$charLbrace| (CONS |next| |acc|)))
                     (SETQ |u| (CDR (CDR |u|)))))
                   (#1#
                    (PROGN
                     (SETQ |acc| (CONS |x| |acc|))
                     (SETQ |u| (CDR |u|)))))))))))
      (NREVERSE |acc|)))))

; checkDecorate u ==
;   count := 0
;   spadflag := false    --means OK to wrap single letter words with \s{}
;   mathSymbolsOk := false
;   acc := nil
;   verbatim := false
;   while u repeat
;     x := first u
;
;     if not verbatim then
;       if x = '"\em" then
;         if count > 0 then
;           mathSymbolsOk := count - 1
;           spadflag := count - 1
;         else checkDocError ['"\em must be enclosed in braces"]
;       if member(x,'("\spadpaste" "\spad" "\spadop")) then mathSymbolsOk := count
;       if member(x,'("\s" "\spadtype" "\spadsys" "\example" "\andexample" "\spadop" "\spad" "\spadignore" "\spadpaste" "\spadcommand" "\footnote")) then spadflag := count
;       else if x = $charLbrace then
;         count := count + 1
;       else if x = $charRbrace then
;         count := count - 1
;         if mathSymbolsOk = count then mathSymbolsOk := false
;         if spadflag = count then spadflag := false
;       else if not mathSymbolsOk and member(x,'("+" "*" "=" "==" "->")) then
;         if $checkingXmptex? then
;           checkDocError ["Symbol ",x,'" appearing outside \spad{}"]
;
;     acc :=
;       x = '"\end{verbatim}" =>
;         verbatim := false
;         [x, :acc]
;       verbatim => [x, :acc]
;       x = '"\begin{verbatim}" =>
;         verbatim := true
;         [x, :acc]
;
;       x = '"\begin" and first (v := IFCDR u) = $charLbrace and
;         first (v := IFCDR v) = '"detail" and first (v := IFCDR v) = $charRbrace
;           =>
;             u := v
;             ['"\blankline ",:acc]
;       x = '"\end" and first (v := IFCDR u) = $charLbrace and
;         first (v := IFCDR v) = '"detail" and first (v := IFCDR v) = $charRbrace
;           =>
;             u := v
;             acc
;       x = char '_$ or x = '"$"  => ['"\$",:acc]
;       x = char '_% or x = '"%"  => ['"\%",:acc]
;       x = char '_, or x = '","  => ['",{}",:acc]
;       x = '"\spad" => ['"\spad",:acc]
;       STRINGP x and DIGITP x.0 => [x,:acc]
;       null spadflag and
;         (CHARP x and ALPHA_-CHAR_-P x and not MEMQ(x,$charExclusions) or
;           member(x,$argl)) => [$charRbrace,x,$charLbrace,'"\spad",:acc]
;       null spadflag and ((STRINGP x and not (x.0 = $charBack) and DIGITP(x.(MAXINDEX x))) or member(x, '("true" "false"))) =>
;         [$charRbrace,x,$charLbrace,'"\spad",:acc]  --wrap x1, alpha3, etc
;       CHARP x => [checkAddBackSlashes x,:acc]
;       xcount := #x
;       xcount = 3 and x.1 = char 't and x.2 = char 'h =>
;         ['"th",$charRbrace,x.0,$charLbrace,'"\spad",:acc]
;       xcount = 4 and x.1 = char '_- and x.2 = char 't and x.3 = char 'h =>
;         ['"-th",$charRbrace,x.0,$charLbrace,'"\spad",:acc]
;       xcount = 2 and x.1 = char 'i or              --wrap ei, xi, hi
;         null spadflag and xcount > 0 and xcount < 4 and not member(x,'("th" "rd" "st")) and
;           hasNoVowels x =>                         --wrap words with no vowels
;             [$charRbrace, checkAddBackSlashes x, $charLbrace, '"\spad", :acc]
;       [checkAddBackSlashes x,:acc]
;     u := rest u
;   NREVERSE acc

(DEFUN |checkDecorate| (|u|)
  (PROG (|count| |spadflag| |mathSymbolsOk| |acc| |verbatim| |x| |v| |xcount|)
    (RETURN
     (PROGN
      (SETQ |count| 0)
      (SETQ |spadflag| NIL)
      (SETQ |mathSymbolsOk| NIL)
      (SETQ |acc| NIL)
      (SETQ |verbatim| NIL)
      ((LAMBDA ()
         (LOOP
          (COND ((NOT |u|) (RETURN NIL))
                (#1='T
                 (PROGN
                  (SETQ |x| (CAR |u|))
                  (COND
                   ((NULL |verbatim|)
                    (COND
                     ((EQUAL |x| "\\em")
                      (COND
                       ((< 0 |count|) (SETQ |mathSymbolsOk| (- |count| 1))
                        (SETQ |spadflag| (- |count| 1)))
                       (#1#
                        (|checkDocError|
                         (LIST "\\em must be enclosed in braces"))))))
                    (COND
                     ((|member| |x| '("\\spadpaste" "\\spad" "\\spadop"))
                      (SETQ |mathSymbolsOk| |count|)))
                    (COND
                     ((|member| |x|
                       '("\\s" "\\spadtype" "\\spadsys" "\\example"
                         "\\andexample" "\\spadop" "\\spad" "\\spadignore"
                         "\\spadpaste" "\\spadcommand" "\\footnote"))
                      (SETQ |spadflag| |count|))
                     ((EQUAL |x| |$charLbrace|) (SETQ |count| (+ |count| 1)))
                     ((EQUAL |x| |$charRbrace|) (SETQ |count| (- |count| 1))
                      (COND
                       ((EQUAL |mathSymbolsOk| |count|)
                        (SETQ |mathSymbolsOk| NIL)))
                      (COND
                       ((EQUAL |spadflag| |count|) (SETQ |spadflag| NIL))))
                     ((AND (NULL |mathSymbolsOk|)
                           (|member| |x| '("+" "*" "=" "==" "->")))
                      (COND
                       (|$checkingXmptex?|
                        (|checkDocError|
                         (LIST '|Symbol | |x|
                               " appearing outside \\spad{}"))))))))
                  (SETQ |acc|
                          (COND
                           ((EQUAL |x| "\\end{verbatim}")
                            (PROGN (SETQ |verbatim| NIL) (CONS |x| |acc|)))
                           (|verbatim| (CONS |x| |acc|))
                           ((EQUAL |x| "\\begin{verbatim}")
                            (PROGN (SETQ |verbatim| T) (CONS |x| |acc|)))
                           ((AND (EQUAL |x| "\\begin")
                                 (EQUAL (CAR (SETQ |v| (IFCDR |u|)))
                                        |$charLbrace|)
                                 (EQUAL (CAR (SETQ |v| (IFCDR |v|))) "detail")
                                 (EQUAL (CAR (SETQ |v| (IFCDR |v|)))
                                        |$charRbrace|))
                            (PROGN (SETQ |u| |v|) (CONS "\\blankline " |acc|)))
                           ((AND (EQUAL |x| "\\end")
                                 (EQUAL (CAR (SETQ |v| (IFCDR |u|)))
                                        |$charLbrace|)
                                 (EQUAL (CAR (SETQ |v| (IFCDR |v|))) "detail")
                                 (EQUAL (CAR (SETQ |v| (IFCDR |v|)))
                                        |$charRbrace|))
                            (PROGN (SETQ |u| |v|) |acc|))
                           ((OR (EQUAL |x| (|char| '$)) (EQUAL |x| "$"))
                            (CONS "\\$" |acc|))
                           ((OR (EQUAL |x| (|char| '%)) (EQUAL |x| "%"))
                            (CONS "\\%" |acc|))
                           ((OR (EQUAL |x| (|char| '|,|)) (EQUAL |x| ","))
                            (CONS ",{}" |acc|))
                           ((EQUAL |x| "\\spad") (CONS "\\spad" |acc|))
                           ((AND (STRINGP |x|) (DIGITP (ELT |x| 0)))
                            (CONS |x| |acc|))
                           ((AND (NULL |spadflag|)
                                 (OR
                                  (AND (CHARP |x|) (ALPHA-CHAR-P |x|)
                                       (NULL (MEMQ |x| |$charExclusions|)))
                                  (|member| |x| |$argl|)))
                            (CONS |$charRbrace|
                                  (CONS |x|
                                        (CONS |$charLbrace|
                                              (CONS "\\spad" |acc|)))))
                           ((AND (NULL |spadflag|)
                                 (OR
                                  (AND (STRINGP |x|)
                                       (NULL (EQUAL (ELT |x| 0) |$charBack|))
                                       (DIGITP (ELT |x| (MAXINDEX |x|))))
                                  (|member| |x| '("true" "false"))))
                            (CONS |$charRbrace|
                                  (CONS |x|
                                        (CONS |$charLbrace|
                                              (CONS "\\spad" |acc|)))))
                           ((CHARP |x|)
                            (CONS (|checkAddBackSlashes| |x|) |acc|))
                           (#1#
                            (PROGN
                             (SETQ |xcount| (LENGTH |x|))
                             (COND
                              ((AND (EQL |xcount| 3)
                                    (EQUAL (ELT |x| 1) (|char| '|t|))
                                    (EQUAL (ELT |x| 2) (|char| '|h|)))
                               (CONS "th"
                                     (CONS |$charRbrace|
                                           (CONS (ELT |x| 0)
                                                 (CONS |$charLbrace|
                                                       (CONS "\\spad"
                                                             |acc|))))))
                              ((AND (EQL |xcount| 4)
                                    (EQUAL (ELT |x| 1) (|char| '-))
                                    (EQUAL (ELT |x| 2) (|char| '|t|))
                                    (EQUAL (ELT |x| 3) (|char| '|h|)))
                               (CONS "-th"
                                     (CONS |$charRbrace|
                                           (CONS (ELT |x| 0)
                                                 (CONS |$charLbrace|
                                                       (CONS "\\spad"
                                                             |acc|))))))
                              ((OR
                                (AND (EQL |xcount| 2)
                                     (EQUAL (ELT |x| 1) (|char| '|i|)))
                                (AND (NULL |spadflag|) (< 0 |xcount|)
                                     (< |xcount| 4)
                                     (NULL (|member| |x| '("th" "rd" "st")))
                                     (|hasNoVowels| |x|)))
                               (CONS |$charRbrace|
                                     (CONS (|checkAddBackSlashes| |x|)
                                           (CONS |$charLbrace|
                                                 (CONS "\\spad" |acc|)))))
                              (#1#
                               (CONS (|checkAddBackSlashes| |x|) |acc|)))))))
                  (SETQ |u| (CDR |u|))))))))
      (NREVERSE |acc|)))))

; hasNoVowels x ==
;   max := MAXINDEX x
;   x.max = char 'y => false
;   and/[not isVowel(x.i) for i in 0..max]

(DEFUN |hasNoVowels| (|x|)
  (PROG (|max|)
    (RETURN
     (PROGN
      (SETQ |max| (MAXINDEX |x|))
      (COND ((EQUAL (ELT |x| |max|) (|char| '|y|)) NIL)
            (#1='T
             ((LAMBDA (|bfVar#48| |i|)
                (LOOP
                 (COND ((> |i| |max|) (RETURN |bfVar#48|))
                       (#1#
                        (PROGN
                         (SETQ |bfVar#48| (NULL (|isVowel| (ELT |x| |i|))))
                         (COND ((NOT |bfVar#48|) (RETURN NIL))))))
                 (SETQ |i| (+ |i| 1))))
              T 0)))))))

; isVowel c ==
;   EQ(c,char 'a) or EQ(c,char 'e) or EQ(c,char 'i) or EQ(c,char 'o) or EQ(c,char 'u) or
;     EQ(c,char 'A) or EQ(c,char 'E) or EQ(c,char 'I) or EQ(c,char 'O) or EQ(c,char 'U)

(DEFUN |isVowel| (|c|)
  (PROG ()
    (RETURN
     (OR (EQ |c| (|char| '|a|)) (EQ |c| (|char| '|e|)) (EQ |c| (|char| '|i|))
         (EQ |c| (|char| '|o|)) (EQ |c| (|char| '|u|)) (EQ |c| (|char| 'A))
         (EQ |c| (|char| 'E)) (EQ |c| (|char| 'I)) (EQ |c| (|char| 'O))
         (EQ |c| (|char| 'U))))))

; checkAddBackSlashes s ==
;   (CHARP s and (c := s)) or (#s = 1 and (c := s.0)) =>
;     MEMQ(c, $charEscapeList) => STRCONC($charBack, c)
;     s
;   k := 0
;   m := MAXINDEX s
;   insertIndex := nil
;   while k <= m repeat
;     do
;       char := s.k
;       char = $charBack => k := k + 2
;       MEMQ(char,$charEscapeList) => return (insertIndex := k)
;     k := k + 1
;   insertIndex => checkAddBackSlashes STRCONC(SUBSTRING(s,0,insertIndex),$charBack,s.k,SUBSTRING(s,insertIndex + 1,nil))
;   s

(DEFUN |checkAddBackSlashes| (|s|)
  (PROG (|c| |k| |m| |insertIndex| |char|)
    (RETURN
     (COND
      ((OR (AND (CHARP |s|) (SETQ |c| |s|))
           (AND (EQL (LENGTH |s|) 1) (SETQ |c| (ELT |s| 0))))
       (COND ((MEMQ |c| |$charEscapeList|) (STRCONC |$charBack| |c|))
             (#1='T |s|)))
      (#1#
       (PROGN
        (SETQ |k| 0)
        (SETQ |m| (MAXINDEX |s|))
        (SETQ |insertIndex| NIL)
        ((LAMBDA ()
           (LOOP
            (COND ((< |m| |k|) (RETURN NIL))
                  (#1#
                   (PROGN
                    (|do|
                     (PROGN
                      (SETQ |char| (ELT |s| |k|))
                      (COND ((EQUAL |char| |$charBack|) (SETQ |k| (+ |k| 2)))
                            ((MEMQ |char| |$charEscapeList|)
                             (RETURN (SETQ |insertIndex| |k|))))))
                    (SETQ |k| (+ |k| 1))))))))
        (COND
         (|insertIndex|
          (|checkAddBackSlashes|
           (STRCONC (SUBSTRING |s| 0 |insertIndex|) |$charBack| (ELT |s| |k|)
            (SUBSTRING |s| (+ |insertIndex| 1) NIL))))
         (#1# |s|))))))))

; checkAddSpaces u ==
;   null u => nil
;   null rest u => u
;   space := $charBlank
;   u2 := nil
;   for i in 1.. for f in u repeat
;     -- want newlines before and after begin/end verbatim and between lines
;     -- since this might be written to a file, we can't really use
;     -- newline characters. The Browser and HD will do the translation
;     -- later.
;     if f = '"\begin{verbatim}" then
;         space := $charFauxNewline
;         if null u2 then u2 := [space]
;
;     if i > 1 then u2 := [:u2, space, f]
;     else u2 := [:u2, f]
;
;     if f = '"\end{verbatim}" then
;         u2 := [:u2, space]
;         space := $charBlank
;   u2

(DEFUN |checkAddSpaces| (|u|)
  (PROG (|space| |u2|)
    (RETURN
     (COND ((NULL |u|) NIL) ((NULL (CDR |u|)) |u|)
           (#1='T
            (PROGN
             (SETQ |space| |$charBlank|)
             (SETQ |u2| NIL)
             ((LAMBDA (|i| |bfVar#49| |f|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#49|)
                       (PROGN (SETQ |f| (CAR |bfVar#49|)) NIL))
                   (RETURN NIL))
                  (#1#
                   (PROGN
                    (COND
                     ((EQUAL |f| "\\begin{verbatim}")
                      (SETQ |space| |$charFauxNewline|)
                      (COND ((NULL |u2|) (SETQ |u2| (LIST |space|))))))
                    (COND
                     ((< 1 |i|)
                      (SETQ |u2| (APPEND |u2| (CONS |space| (CONS |f| NIL)))))
                     (#1# (SETQ |u2| (APPEND |u2| (CONS |f| NIL)))))
                    (COND
                     ((EQUAL |f| "\\end{verbatim}")
                      (SETQ |u2| (APPEND |u2| (CONS |space| NIL)))
                      (SETQ |space| |$charBlank|))))))
                 (SETQ |i| (+ |i| 1))
                 (SETQ |bfVar#49| (CDR |bfVar#49|))))
              1 |u| NIL)
             |u2|))))))

; checkIeEg u ==
;   acc := nil
;   verbatim := false
;   while u repeat
;     x := first u
;     acc :=
;       x = '"\end{verbatim}" =>
;         verbatim := false
;         [x, :acc]
;       verbatim => [x, :acc]
;       x = '"\begin{verbatim}" =>
;         verbatim := true
;         [x, :acc]
;       z := checkIeEgfun x => [:NREVERSE z,:acc]
;       [x,:acc]
;     u := rest u
;   NREVERSE acc

(DEFUN |checkIeEg| (|u|)
  (PROG (|acc| |verbatim| |x| |z|)
    (RETURN
     (PROGN
      (SETQ |acc| NIL)
      (SETQ |verbatim| NIL)
      ((LAMBDA ()
         (LOOP
          (COND ((NOT |u|) (RETURN NIL))
                (#1='T
                 (PROGN
                  (SETQ |x| (CAR |u|))
                  (SETQ |acc|
                          (COND
                           ((EQUAL |x| "\\end{verbatim}")
                            (PROGN (SETQ |verbatim| NIL) (CONS |x| |acc|)))
                           (|verbatim| (CONS |x| |acc|))
                           ((EQUAL |x| "\\begin{verbatim}")
                            (PROGN (SETQ |verbatim| T) (CONS |x| |acc|)))
                           ((SETQ |z| (|checkIeEgfun| |x|))
                            (APPEND (NREVERSE |z|) |acc|))
                           (#1# (CONS |x| |acc|))))
                  (SETQ |u| (CDR |u|))))))))
      (NREVERSE |acc|)))))

; checkIeEgfun x ==
;   CHARP x => nil
;   x = '"" => nil
;   m := MAXINDEX x
;   for k in 0..(m - 3) repeat
;     x.(k + 1) = $charPeriod and x.(k + 3) = $charPeriod and
;      (x.k = char 'i and x.(k + 2) = char 'e and (key := '"that is")
;        or x.k = char 'e and x.(k + 2) = char 'g and (key := '"for example")) =>
;           firstPart := (k > 0 => [SUBSTRING(x,0,k)]; nil)
;           result := [:firstPart,'"\spadignore{",SUBSTRING(x,k,4),'"}",
;                      :checkIeEgfun SUBSTRING(x,k+4,nil)]
;   result

(DEFUN |checkIeEgfun| (|x|)
  (PROG (|m| |key| |firstPart| |result|)
    (RETURN
     (COND ((CHARP |x|) NIL) ((EQUAL |x| "") NIL)
           (#1='T
            (PROGN
             (SETQ |m| (MAXINDEX |x|))
             ((LAMBDA (|bfVar#50| |k|)
                (LOOP
                 (COND ((> |k| |bfVar#50|) (RETURN NIL))
                       (#1#
                        (COND
                         ((AND (EQUAL (ELT |x| (+ |k| 1)) |$charPeriod|)
                               (EQUAL (ELT |x| (+ |k| 3)) |$charPeriod|)
                               (OR
                                (AND (EQUAL (ELT |x| |k|) (|char| '|i|))
                                     (EQUAL (ELT |x| (+ |k| 2)) (|char| '|e|))
                                     (SETQ |key| "that is"))
                                (AND (EQUAL (ELT |x| |k|) (|char| '|e|))
                                     (EQUAL (ELT |x| (+ |k| 2)) (|char| '|g|))
                                     (SETQ |key| "for example"))))
                          (IDENTITY
                           (PROGN
                            (SETQ |firstPart|
                                    (COND
                                     ((< 0 |k|) (LIST (SUBSTRING |x| 0 |k|)))
                                     (#1# NIL)))
                            (SETQ |result|
                                    (APPEND |firstPart|
                                            (CONS "\\spadignore{"
                                                  (CONS (SUBSTRING |x| |k| 4)
                                                        (CONS "}"
                                                              (|checkIeEgfun|
                                                               (SUBSTRING |x|
                                                                          (+
                                                                           |k|
                                                                           4)
                                                                          NIL)))))))))))))
                 (SETQ |k| (+ |k| 1))))
              (- |m| 3) 0)
             |result|))))))

; checkSplit2Words u ==
;   acc := nil
;   while u repeat
;     x := first u
;     acc :=
;       x = '"\end{verbatim}" =>
;         verbatim := false
;         [x, :acc]
;       verbatim => [x, :acc]
;       x = '"\begin{verbatim}" =>
;         verbatim := true
;         [x, :acc]
;       z := checkSplitBrace x => [:NREVERSE z,:acc]
;       [x,:acc]
;     u := rest u
;   NREVERSE acc

(DEFUN |checkSplit2Words| (|u|)
  (PROG (|acc| |x| |verbatim| |z|)
    (RETURN
     (PROGN
      (SETQ |acc| NIL)
      ((LAMBDA ()
         (LOOP
          (COND ((NOT |u|) (RETURN NIL))
                (#1='T
                 (PROGN
                  (SETQ |x| (CAR |u|))
                  (SETQ |acc|
                          (COND
                           ((EQUAL |x| "\\end{verbatim}")
                            (PROGN (SETQ |verbatim| NIL) (CONS |x| |acc|)))
                           (|verbatim| (CONS |x| |acc|))
                           ((EQUAL |x| "\\begin{verbatim}")
                            (PROGN (SETQ |verbatim| T) (CONS |x| |acc|)))
                           ((SETQ |z| (|checkSplitBrace| |x|))
                            (APPEND (NREVERSE |z|) |acc|))
                           (#1# (CONS |x| |acc|))))
                  (SETQ |u| (CDR |u|))))))))
      (NREVERSE |acc|)))))

; checkSplitBrace x ==
;   CHARP x => [x]
;   #x = 1 => [x.0]
;   (u := checkSplitBackslash x)
;      and rest u  => "append"/[checkSplitBrace y for y in u]
;   m := MAXINDEX x
;   (u := checkSplitOn x)
;      and rest u  => "append"/[checkSplitBrace y for y in u]
;   (u := checkSplitPunctuation x)
;      and rest u  => "append"/[checkSplitBrace y for y in u]
;   [x]

(DEFUN |checkSplitBrace| (|x|)
  (PROG (|u| |m|)
    (RETURN
     (COND ((CHARP |x|) (LIST |x|)) ((EQL (LENGTH |x|) 1) (LIST (ELT |x| 0)))
           ((AND (SETQ |u| (|checkSplitBackslash| |x|)) (CDR |u|))
            ((LAMBDA (|bfVar#52| |bfVar#51| |y|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#51|)
                      (PROGN (SETQ |y| (CAR |bfVar#51|)) NIL))
                  (RETURN |bfVar#52|))
                 (#1='T
                  (SETQ |bfVar#52|
                          (APPEND |bfVar#52| (|checkSplitBrace| |y|)))))
                (SETQ |bfVar#51| (CDR |bfVar#51|))))
             NIL |u| NIL))
           (#1#
            (PROGN
             (SETQ |m| (MAXINDEX |x|))
             (COND
              ((AND (SETQ |u| (|checkSplitOn| |x|)) (CDR |u|))
               ((LAMBDA (|bfVar#54| |bfVar#53| |y|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#53|)
                         (PROGN (SETQ |y| (CAR |bfVar#53|)) NIL))
                     (RETURN |bfVar#54|))
                    (#1#
                     (SETQ |bfVar#54|
                             (APPEND |bfVar#54| (|checkSplitBrace| |y|)))))
                   (SETQ |bfVar#53| (CDR |bfVar#53|))))
                NIL |u| NIL))
              ((AND (SETQ |u| (|checkSplitPunctuation| |x|)) (CDR |u|))
               ((LAMBDA (|bfVar#56| |bfVar#55| |y|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#55|)
                         (PROGN (SETQ |y| (CAR |bfVar#55|)) NIL))
                     (RETURN |bfVar#56|))
                    (#1#
                     (SETQ |bfVar#56|
                             (APPEND |bfVar#56| (|checkSplitBrace| |y|)))))
                   (SETQ |bfVar#55| (CDR |bfVar#55|))))
                NIL |u| NIL))
              (#1# (LIST |x|)))))))))

; checkSplitBackslash x ==
;   not STRINGP x => [x]
;   m := MAXINDEX x
;   (k := charPosition($charBack,x,0)) < m =>
;     m = 1 or ALPHA_-CHAR_-P(x . (k + 1)) =>     --starts with a backslash so..
;       (k := charPosition($charBack,x,1)) < m => --..see if there is another
;          [SUBSTRING(x,0,k),:checkSplitBackslash SUBSTRING(x,k,nil)]  -- yup
;       [x]                                       --no, just return line
;     k = 0 => --starts with backspace but x.1 is not a letter; break it up
;       [SUBSTRING(x,0,2),:checkSplitBackslash SUBSTRING(x,2,nil)]
;     u := SUBSTRING(x,0,k)
;     v := SUBSTRING(x,k,2)
;     k + 1 = m => [u,v]
;     [u,v,:checkSplitBackslash SUBSTRING(x,k + 2,nil)]
;   [x]

(DEFUN |checkSplitBackslash| (|x|)
  (PROG (|m| |k| |u| |v|)
    (RETURN
     (COND ((NULL (STRINGP |x|)) (LIST |x|))
           (#1='T
            (PROGN
             (SETQ |m| (MAXINDEX |x|))
             (COND
              ((< (SETQ |k| (|charPosition| |$charBack| |x| 0)) |m|)
               (COND
                ((OR (EQL |m| 1) (ALPHA-CHAR-P (ELT |x| (+ |k| 1))))
                 (COND
                  ((< (SETQ |k| (|charPosition| |$charBack| |x| 1)) |m|)
                   (CONS (SUBSTRING |x| 0 |k|)
                         (|checkSplitBackslash| (SUBSTRING |x| |k| NIL))))
                  (#1# (LIST |x|))))
                ((EQL |k| 0)
                 (CONS (SUBSTRING |x| 0 2)
                       (|checkSplitBackslash| (SUBSTRING |x| 2 NIL))))
                (#1#
                 (PROGN
                  (SETQ |u| (SUBSTRING |x| 0 |k|))
                  (SETQ |v| (SUBSTRING |x| |k| 2))
                  (COND ((EQUAL (+ |k| 1) |m|) (LIST |u| |v|))
                        (#1#
                         (CONS |u|
                               (CONS |v|
                                     (|checkSplitBackslash|
                                      (SUBSTRING |x| (+ |k| 2) NIL))))))))))
              (#1# (LIST |x|)))))))))

; checkSplitPunctuation x ==
;   CHARP x => [x]
;   m := MAXINDEX x
;   m < 1 => [x]
;   lastchar := x.m
;   lastchar = $charPeriod and x.(m - 1) = $charPeriod =>
;     m = 1 => [x]
;     m > 3 and x.(m-2) = $charPeriod =>
;       [:checkSplitPunctuation SUBSTRING(x,0,m-2),'"..."]
;     [:checkSplitPunctuation SUBSTRING(x,0,m-1),'".."]
;   lastchar = $charPeriod or lastchar = $charSemiColon or lastchar = $charComma
;     => [SUBSTRING(x,0,m),lastchar]
;   m > 1 and x.(m - 1) = $charQuote => [SUBSTRING(x,0,m - 1),SUBSTRING(x,m-1,nil)]
;   (k := charPosition($charBack,x,0)) < m =>
;     k = 0 =>
;       m = 1 or HGET($htMacroTable,x) or ALPHA_-CHAR_-P x.1 => [x]
;       v := SUBSTRING(x,2,nil)
;       [SUBSTRING(x,0,2),:checkSplitPunctuation v]
;     u := SUBSTRING(x,0,k)
;     v := SUBSTRING(x,k,nil)
;     [:checkSplitPunctuation u,:checkSplitPunctuation v]
;   (k := charPosition($charDash,x,1)) < m =>
;     u := SUBSTRING(x,k + 1,nil)
;     [SUBSTRING(x,0,k),$charDash,:checkSplitPunctuation u]
;   [x]

(DEFUN |checkSplitPunctuation| (|x|)
  (PROG (|m| |lastchar| |k| |v| |u|)
    (RETURN
     (COND ((CHARP |x|) (LIST |x|))
           (#1='T
            (PROGN
             (SETQ |m| (MAXINDEX |x|))
             (COND ((< |m| 1) (LIST |x|))
                   (#1#
                    (PROGN
                     (SETQ |lastchar| (ELT |x| |m|))
                     (COND
                      ((AND (EQUAL |lastchar| |$charPeriod|)
                            (EQUAL (ELT |x| (- |m| 1)) |$charPeriod|))
                       (COND ((EQL |m| 1) (LIST |x|))
                             ((AND (< 3 |m|)
                                   (EQUAL (ELT |x| (- |m| 2)) |$charPeriod|))
                              (APPEND
                               (|checkSplitPunctuation|
                                (SUBSTRING |x| 0 (- |m| 2)))
                               (CONS "..." NIL)))
                             (#1#
                              (APPEND
                               (|checkSplitPunctuation|
                                (SUBSTRING |x| 0 (- |m| 1)))
                               (CONS ".." NIL)))))
                      ((OR (EQUAL |lastchar| |$charPeriod|)
                           (EQUAL |lastchar| |$charSemiColon|)
                           (EQUAL |lastchar| |$charComma|))
                       (LIST (SUBSTRING |x| 0 |m|) |lastchar|))
                      ((AND (< 1 |m|) (EQUAL (ELT |x| (- |m| 1)) |$charQuote|))
                       (LIST (SUBSTRING |x| 0 (- |m| 1))
                             (SUBSTRING |x| (- |m| 1) NIL)))
                      ((< (SETQ |k| (|charPosition| |$charBack| |x| 0)) |m|)
                       (COND
                        ((EQL |k| 0)
                         (COND
                          ((OR (EQL |m| 1) (HGET |$htMacroTable| |x|)
                               (ALPHA-CHAR-P (ELT |x| 1)))
                           (LIST |x|))
                          (#1#
                           (PROGN
                            (SETQ |v| (SUBSTRING |x| 2 NIL))
                            (CONS (SUBSTRING |x| 0 2)
                                  (|checkSplitPunctuation| |v|))))))
                        (#1#
                         (PROGN
                          (SETQ |u| (SUBSTRING |x| 0 |k|))
                          (SETQ |v| (SUBSTRING |x| |k| NIL))
                          (APPEND (|checkSplitPunctuation| |u|)
                                  (|checkSplitPunctuation| |v|))))))
                      ((< (SETQ |k| (|charPosition| |$charDash| |x| 1)) |m|)
                       (PROGN
                        (SETQ |u| (SUBSTRING |x| (+ |k| 1) NIL))
                        (CONS (SUBSTRING |x| 0 |k|)
                              (CONS |$charDash|
                                    (|checkSplitPunctuation| |u|)))))
                      (#1# (LIST |x|))))))))))))

; checkSplitOn(x) ==
;   CHARP x => [x]
;   l := $charSplitList
;   m := MAXINDEX x
;   while l repeat
;     char := first l
;     do
;       m = 0 and x.0 = char => return (k := -1)  --special exit
;       k := charPosition(char,x,0)
;       k > 0 and x.(k - 1) = $charBack => [x]
;       k <= m => return k
;     l := rest l
;   null l => [x]
;   k = -1 => [char]
;   k = 0 => [char,SUBSTRING(x,1,nil)]
;   k = MAXINDEX x => [SUBSTRING(x,0,k),char]
;   [SUBSTRING(x,0,k),char,:checkSplitOn SUBSTRING(x,k + 1,nil)]

(DEFUN |checkSplitOn| (|x|)
  (PROG (|l| |m| |char| |k|)
    (RETURN
     (COND ((CHARP |x|) (LIST |x|))
           (#1='T
            (PROGN
             (SETQ |l| |$charSplitList|)
             (SETQ |m| (MAXINDEX |x|))
             ((LAMBDA ()
                (LOOP
                 (COND ((NOT |l|) (RETURN NIL))
                       (#1#
                        (PROGN
                         (SETQ |char| (CAR |l|))
                         (|do|
                          (COND
                           ((AND (EQL |m| 0) (EQUAL (ELT |x| 0) |char|))
                            (RETURN (SETQ |k| (- 1))))
                           (#1#
                            (PROGN
                             (SETQ |k| (|charPosition| |char| |x| 0))
                             (COND
                              ((AND (< 0 |k|)
                                    (EQUAL (ELT |x| (- |k| 1)) |$charBack|))
                               (LIST |x|))
                              ((NOT (< |m| |k|)) (RETURN |k|)))))))
                         (SETQ |l| (CDR |l|))))))))
             (COND ((NULL |l|) (LIST |x|)) ((EQUAL |k| (- 1)) (LIST |char|))
                   ((EQL |k| 0) (LIST |char| (SUBSTRING |x| 1 NIL)))
                   ((EQUAL |k| (MAXINDEX |x|))
                    (LIST (SUBSTRING |x| 0 |k|) |char|))
                   (#1#
                    (CONS (SUBSTRING |x| 0 |k|)
                          (CONS |char|
                                (|checkSplitOn|
                                 (SUBSTRING |x| (+ |k| 1) NIL))))))))))))

; checkBalance u ==
;   checkBeginEnd u
;   stack := nil
;   while u repeat
;     do
;       x := first u
;       openClose := assoc(x, $checkPrenAlist) =>  --is it an open bracket?
;           stack := [first openClose, :stack]   --yes, push the open bracket
;       open  := rassoc(x,$checkPrenAlist) =>  --it is a close bracket!
;         stack is [top,:restStack] => --does corresponding open bracket match?
;           if open ~= top then          --yes: just pop the stack
;             checkDocError
;               ['"Mismatch: left ",checkSayBracket top,'" matches right ",checkSayBracket open]
;           stack := restStack
;         checkDocError ['"Missing left ",checkSayBracket open]
;     u := rest u
;   if stack then
;     for x in NREVERSE stack repeat
;       checkDocError ['"Missing right ",checkSayBracket x]
;   u

(DEFUN |checkBalance| (|u|)
  (PROG (|stack| |x| |openClose| |open| |top| |restStack|)
    (RETURN
     (PROGN
      (|checkBeginEnd| |u|)
      (SETQ |stack| NIL)
      ((LAMBDA ()
         (LOOP
          (COND ((NOT |u|) (RETURN NIL))
                (#1='T
                 (PROGN
                  (|do|
                   (PROGN
                    (SETQ |x| (CAR |u|))
                    (COND
                     ((SETQ |openClose| (|assoc| |x| |$checkPrenAlist|))
                      (SETQ |stack| (CONS (CAR |openClose|) |stack|)))
                     ((SETQ |open| (|rassoc| |x| |$checkPrenAlist|))
                      (COND
                       ((AND (CONSP |stack|)
                             (PROGN
                              (SETQ |top| (CAR |stack|))
                              (SETQ |restStack| (CDR |stack|))
                              #1#))
                        (PROGN
                         (COND
                          ((NOT (EQUAL |open| |top|))
                           (|checkDocError|
                            (LIST "Mismatch: left " (|checkSayBracket| |top|)
                                  " matches right "
                                  (|checkSayBracket| |open|)))))
                         (SETQ |stack| |restStack|)))
                       (#1#
                        (|checkDocError|
                         (LIST "Missing left "
                               (|checkSayBracket| |open|)))))))))
                  (SETQ |u| (CDR |u|))))))))
      (COND
       (|stack|
        ((LAMBDA (|bfVar#57| |x|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#57|) (PROGN (SETQ |x| (CAR |bfVar#57|)) NIL))
              (RETURN NIL))
             (#1#
              (|checkDocError|
               (LIST "Missing right " (|checkSayBracket| |x|)))))
            (SETQ |bfVar#57| (CDR |bfVar#57|))))
         (NREVERSE |stack|) NIL)))
      |u|))))

; checkSayBracket x ==
;   x = char '_( or x = char '_) => '"pren"
;   x = char '_{ or x = char '_} => '"brace"
;   '"bracket"

(DEFUN |checkSayBracket| (|x|)
  (PROG ()
    (RETURN
     (COND ((OR (EQUAL |x| (|char| '|(|)) (EQUAL |x| (|char| '|)|))) "pren")
           ((OR (EQUAL |x| (|char| '{)) (EQUAL |x| (|char| '}))) "brace")
           ('T "bracket")))))

; checkBeginEnd u ==
;   beginEndStack := nil
;   while u repeat
;     IDENTITY
;       x := first u
;       STRINGP x and x.0 = $charBack and #x > 2 and not HGET($htMacroTable,x)
;         and not (x = '"\spadignore") and IFCAR IFCDR u = $charLbrace
;           and not
;             (substring?('"\radiobox",x,0) or substring?('"\inputbox",x,0))=>
;              --allow 0 argument guys to pass through
;               checkDocError ["Unexpected HT command: ",x]
;       x = '"\beginitems" =>
;         beginEndStack := ["items",:beginEndStack]
;       x = '"\begin" =>
;         u is [., =$charLbrace, y, :r] and first r = $charRbrace =>
;           if not member(y,$beginEndList) then
;             checkDocError ['"Unknown begin type: \begin{",y,'"}"]
;           beginEndStack := [y,:beginEndStack]
;           u := r
;         checkDocError ['"Improper \begin command"]
;       x = '"\item" =>
;         member(IFCAR beginEndStack,'("items" "menu")) => nil
;         null beginEndStack =>
;           checkDocError ['"\item appears outside a \begin-\end"]
;         checkDocError ['"\item appears within a \begin{",IFCAR beginEndStack,'"}.."]
;       x = '"\end" =>
;         u is [., =$charLbrace, y, :r] and first r = $charRbrace =>
;           y = IFCAR beginEndStack =>
;             beginEndStack := rest beginEndStack
;             u := r
;           checkDocError ['"Trying to match \begin{",IFCAR beginEndStack,'"} with \end{",y,"}"]
;         checkDocError ['"Improper \end command"]
;     u := rest u
;   beginEndStack => checkDocError ['"Missing \end{",first beginEndStack,'"}"]
;   'ok

(DEFUN |checkBeginEnd| (|u|)
  (PROG (|beginEndStack| |x| |ISTMP#1| |ISTMP#2| |y| |r|)
    (RETURN
     (PROGN
      (SETQ |beginEndStack| NIL)
      ((LAMBDA ()
         (LOOP
          (COND ((NOT |u|) (RETURN NIL))
                (#1='T
                 (PROGN
                  (IDENTITY
                   (PROGN
                    (SETQ |x| (CAR |u|))
                    (COND
                     ((AND (STRINGP |x|) (EQUAL (ELT |x| 0) |$charBack|)
                           (< 2 (LENGTH |x|)) (NULL (HGET |$htMacroTable| |x|))
                           (NULL (EQUAL |x| "\\spadignore"))
                           (EQUAL (IFCAR (IFCDR |u|)) |$charLbrace|)
                           (NULL
                            (OR (|substring?| "\\radiobox" |x| 0)
                                (|substring?| "\\inputbox" |x| 0))))
                      (|checkDocError| (LIST '|Unexpected HT command: | |x|)))
                     ((EQUAL |x| "\\beginitems")
                      (SETQ |beginEndStack| (CONS '|items| |beginEndStack|)))
                     ((EQUAL |x| "\\begin")
                      (COND
                       ((AND (CONSP |u|)
                             (PROGN
                              (SETQ |ISTMP#1| (CDR |u|))
                              (AND (CONSP |ISTMP#1|)
                                   (EQUAL (CAR |ISTMP#1|) |$charLbrace|)
                                   (PROGN
                                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                    (AND (CONSP |ISTMP#2|)
                                         (PROGN
                                          (SETQ |y| (CAR |ISTMP#2|))
                                          (SETQ |r| (CDR |ISTMP#2|))
                                          #1#)))))
                             (EQUAL (CAR |r|) |$charRbrace|))
                        (PROGN
                         (COND
                          ((NULL (|member| |y| |$beginEndList|))
                           (|checkDocError|
                            (LIST "Unknown begin type: \\begin{" |y| "}"))))
                         (SETQ |beginEndStack| (CONS |y| |beginEndStack|))
                         (SETQ |u| |r|)))
                       (#1#
                        (|checkDocError| (LIST "Improper \\begin command")))))
                     ((EQUAL |x| "\\item")
                      (COND
                       ((|member| (IFCAR |beginEndStack|) '("items" "menu"))
                        NIL)
                       ((NULL |beginEndStack|)
                        (|checkDocError|
                         (LIST "\\item appears outside a \\begin-\\end")))
                       (#1#
                        (|checkDocError|
                         (LIST "\\item appears within a \\begin{"
                               (IFCAR |beginEndStack|) "}..")))))
                     ((EQUAL |x| "\\end")
                      (COND
                       ((AND (CONSP |u|)
                             (PROGN
                              (SETQ |ISTMP#1| (CDR |u|))
                              (AND (CONSP |ISTMP#1|)
                                   (EQUAL (CAR |ISTMP#1|) |$charLbrace|)
                                   (PROGN
                                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                    (AND (CONSP |ISTMP#2|)
                                         (PROGN
                                          (SETQ |y| (CAR |ISTMP#2|))
                                          (SETQ |r| (CDR |ISTMP#2|))
                                          #1#)))))
                             (EQUAL (CAR |r|) |$charRbrace|))
                        (COND
                         ((EQUAL |y| (IFCAR |beginEndStack|))
                          (PROGN
                           (SETQ |beginEndStack| (CDR |beginEndStack|))
                           (SETQ |u| |r|)))
                         (#1#
                          (|checkDocError|
                           (LIST "Trying to match \\begin{"
                                 (IFCAR |beginEndStack|) "} with \\end{" |y|
                                 '})))))
                       (#1#
                        (|checkDocError| (LIST "Improper \\end command"))))))))
                  (SETQ |u| (CDR |u|))))))))
      (COND
       (|beginEndStack|
        (|checkDocError| (LIST "Missing \\end{" (CAR |beginEndStack|) "}")))
       (#1# '|ok|))))))

; checkArguments u ==
;   while u repeat
;     do
;       x := first u
;       null (k := HGET($htMacroTable,x)) => 'skip
;       k = 0 => 'skip
;       k > 0 => checkHTargs(x,rest u,k,nil)
;       checkHTargs(x,rest u,-k,true)
;     u := rest u
;   u

(DEFUN |checkArguments| (|u|)
  (PROG (|x| |k|)
    (RETURN
     (PROGN
      ((LAMBDA ()
         (LOOP
          (COND ((NOT |u|) (RETURN NIL))
                (#1='T
                 (PROGN
                  (|do|
                   (PROGN
                    (SETQ |x| (CAR |u|))
                    (COND
                     ((NULL (SETQ |k| (HGET |$htMacroTable| |x|))) '|skip|)
                     ((EQL |k| 0) '|skip|)
                     ((< 0 |k|) (|checkHTargs| |x| (CDR |u|) |k| NIL))
                     (#1# (|checkHTargs| |x| (CDR |u|) (- |k|) T)))))
                  (SETQ |u| (CDR |u|))))))))
      |u|))))

; checkHTargs(keyword,u,nargs,integerValue?) ==
; --u should start with an open brace ...
;    nargs = 0 => 'ok
;    if not (u := checkLookForLeftBrace u) then
;      return checkDocError ['"Missing argument for ",keyword]
;    if not (u := checkLookForRightBrace IFCDR u) then
;      return checkDocError ['"Missing right brace for ",keyword]
;    checkHTargs(keyword,rest u,nargs - 1,integerValue?)

(DEFUN |checkHTargs| (|keyword| |u| |nargs| |integerValue?|)
  (PROG ()
    (RETURN
     (COND ((EQL |nargs| 0) '|ok|)
           ('T
            (PROGN
             (COND
              ((NULL (SETQ |u| (|checkLookForLeftBrace| |u|)))
               (RETURN
                (|checkDocError| (LIST "Missing argument for " |keyword|)))))
             (COND
              ((NULL (SETQ |u| (|checkLookForRightBrace| (IFCDR |u|))))
               (RETURN
                (|checkDocError|
                 (LIST "Missing right brace for " |keyword|)))))
             (|checkHTargs| |keyword| (CDR |u|) (- |nargs| 1)
              |integerValue?|)))))))

; checkLookForLeftBrace(u) ==   --return line beginning with left brace
;   while u repeat
;     x := first u
;     if x = $charLbrace then return u
;     x ~= $charBlank => return nil
;     u := rest u
;   u

(DEFUN |checkLookForLeftBrace| (|u|)
  (PROG (|x|)
    (RETURN
     (PROGN
      ((LAMBDA ()
         (LOOP
          (COND ((NOT |u|) (RETURN NIL))
                (#1='T
                 (PROGN
                  (SETQ |x| (CAR |u|))
                  (COND ((EQUAL |x| |$charLbrace|) (RETURN |u|)))
                  (COND ((NOT (EQUAL |x| |$charBlank|)) (RETURN NIL))
                        (#1# (SETQ |u| (CDR |u|))))))))))
      |u|))))

; checkLookForRightBrace(u) ==  --return line beginning with right brace
;   count := 0
;   while u repeat
;     x := first u
;     do
;       x = $charRbrace =>
;         count = 0 => return (found := u)
;         count := count - 1
;       x = $charLbrace => count := count + 1
;     u := rest u
;   found

(DEFUN |checkLookForRightBrace| (|u|)
  (PROG (|count| |x| |found|)
    (RETURN
     (PROGN
      (SETQ |count| 0)
      ((LAMBDA ()
         (LOOP
          (COND ((NOT |u|) (RETURN NIL))
                (#1='T
                 (PROGN
                  (SETQ |x| (CAR |u|))
                  (|do|
                   (COND
                    ((EQUAL |x| |$charRbrace|)
                     (COND ((EQL |count| 0) (RETURN (SETQ |found| |u|)))
                           (#1# (SETQ |count| (- |count| 1)))))
                    ((EQUAL |x| |$charLbrace|) (SETQ |count| (+ |count| 1)))))
                  (SETQ |u| (CDR |u|))))))))
      |found|))))

; checkInteger s ==
;   CHARP s => false
;   s = '"" => false
;   and/[DIGIT_-CHAR_-P s.i for i in 0..MAXINDEX s]

(DEFUN |checkInteger| (|s|)
  (PROG ()
    (RETURN
     (COND ((CHARP |s|) NIL) ((EQUAL |s| "") NIL)
           (#1='T
            ((LAMBDA (|bfVar#59| |bfVar#58| |i|)
               (LOOP
                (COND ((> |i| |bfVar#58|) (RETURN |bfVar#59|))
                      (#1#
                       (PROGN
                        (SETQ |bfVar#59| (DIGIT-CHAR-P (ELT |s| |i|)))
                        (COND ((NOT |bfVar#59|) (RETURN NIL))))))
                (SETQ |i| (+ |i| 1))))
             T (MAXINDEX |s|) 0))))))

; checkTransformFirsts(opname,u,margin) ==
; --case 1: \spad{...
; --case 2: form(args)
; --case 3: form arg
; --case 4: op arg
; --case 5: arg op arg
;   namestring := PNAME opname
;   if namestring = '"Zero" then namestring := '"0"
;   else if namestring = '"One" then namestring := '"1"
;   margin > 0 =>
;     s := leftTrim u
;     STRCONC(fillerSpaces(margin, '" "), checkTransformFirsts(opname, s, 0))
;   m := MAXINDEX u
;   m < 2 => u
;   u.0 = $charBack => u
;   ALPHA_-CHAR_-P u.0 =>
;     i := checkSkipToken(u,0,m) or return u
;     j := checkSkipBlanks(u,i,m) or return u
;     open := u.j
;     open = char '_[ and (close := char '_]) or
;           open = char '_(  and (close := char '_)) =>
;       k := getMatchingRightPren(u,j + 1,open,close)
;       namestring ~= (firstWord := SUBSTRING(u,0,i)) =>
;         checkDocError ['"Improper first word in comments: ",firstWord]
;         u
;       null k =>
;          if open = char '_[
;            then checkDocError ['"Missing close bracket on first line: ", u]
;            else checkDocError ['"Missing close parenthesis on first line: ", u]
;          u
;       STRCONC('"\spad{",SUBSTRING(u,0,k + 1),'"}",SUBSTRING(u,k + 1,nil))
;     k := checkSkipToken(u,j,m) or return u
;     infixOp := INTERN SUBSTRING(u,j,k - j)
;     not GETL(infixOp,'Led) =>                                     --case 3
;       namestring ~= (firstWord := SUBSTRING(u,0,i)) =>
;         checkDocError ['"Improper first word in comments: ",firstWord]
;         u
;       #(p := PNAME infixOp) = 1 and (open := p.0) and
;         (close := LASSOC(open,$checkPrenAlist)) =>  --have an open bracket
;           l := getMatchingRightPren(u,k + 1,open,close)
;           if l > MAXINDEX u then l := k - 1
;           STRCONC('"\spad{",SUBSTRING(u,0,l + 1),'"}",SUBSTRING(u,l + 1,nil))
;       STRCONC('"\spad{",SUBSTRING(u,0,k),'"}",SUBSTRING(u,k,nil))
;     l := checkSkipBlanks(u,k,m) or return u
;     n := checkSkipToken(u,l,m) or return u
;     namestring ~= PNAME infixOp =>
;       checkDocError ['"Improper initial operator in comments: ",infixOp]
;       u
;     STRCONC('"\spad{",SUBSTRING(u,0,n),'"}",SUBSTRING(u,n,nil))   --case 5
;   true =>          -- not ALPHA_-CHAR_-P u.0 =>
;     i := checkSkipToken(u,0,m) or return u
;     namestring ~= (firstWord := SUBSTRING(u,0,i)) =>
;       checkDocError ['"Improper first word in comments: ",firstWord]
;       u
;     prefixOp := INTERN SUBSTRING(u,0,i)
;     not GETL(prefixOp,'Nud) =>
;       u ---what could this be?
;     j := checkSkipBlanks(u,i,m) or return u
;     u.j = char '_( =>                                            --case 4
;       j := getMatchingRightPren(u,j + 1,char '_(,char '_))
;       j > m => u
;       STRCONC('"\spad{",SUBSTRING(u,0,j + 1),'"}",SUBSTRING(u,j + 1,nil))
;     k := checkSkipToken(u,j,m) or return u
;     namestring ~= (firstWord := SUBSTRING(u,0,i)) =>
;       checkDocError ['"Improper first word in comments: ",firstWord]
;       u
;     STRCONC('"\spad{",SUBSTRING(u,0,k),'"}",SUBSTRING(u,k,nil))

(DEFUN |checkTransformFirsts| (|opname| |u| |margin|)
  (PROG (|namestring| |s| |m| |i| |j| |open| |close| |k| |firstWord| |infixOp|
         |p| |l| |n| |prefixOp|)
    (RETURN
     (PROGN
      (SETQ |namestring| (PNAME |opname|))
      (COND ((EQUAL |namestring| "Zero") (SETQ |namestring| "0"))
            ((EQUAL |namestring| "One") (SETQ |namestring| "1")))
      (COND
       ((< 0 |margin|)
        (PROGN
         (SETQ |s| (|leftTrim| |u|))
         (STRCONC (|fillerSpaces| |margin| " ")
          (|checkTransformFirsts| |opname| |s| 0))))
       (#1='T
        (PROGN
         (SETQ |m| (MAXINDEX |u|))
         (COND ((< |m| 2) |u|) ((EQUAL (ELT |u| 0) |$charBack|) |u|)
               ((ALPHA-CHAR-P (ELT |u| 0))
                (PROGN
                 (SETQ |i| (OR (|checkSkipToken| |u| 0 |m|) (RETURN |u|)))
                 (SETQ |j| (OR (|checkSkipBlanks| |u| |i| |m|) (RETURN |u|)))
                 (SETQ |open| (ELT |u| |j|))
                 (COND
                  ((OR
                    (AND (EQUAL |open| (|char| '[)) (SETQ |close| (|char| '])))
                    (AND (EQUAL |open| (|char| '|(|))
                         (SETQ |close| (|char| '|)|))))
                   (PROGN
                    (SETQ |k|
                            (|getMatchingRightPren| |u| (+ |j| 1) |open|
                             |close|))
                    (COND
                     ((NOT
                       (EQUAL |namestring|
                              (SETQ |firstWord| (SUBSTRING |u| 0 |i|))))
                      (PROGN
                       (|checkDocError|
                        (LIST "Improper first word in comments: " |firstWord|))
                       |u|))
                     ((NULL |k|)
                      (PROGN
                       (COND
                        ((EQUAL |open| (|char| '[))
                         (|checkDocError|
                          (LIST "Missing close bracket on first line: " |u|)))
                        (#1#
                         (|checkDocError|
                          (LIST "Missing close parenthesis on first line: "
                                |u|))))
                       |u|))
                     (#1#
                      (STRCONC "\\spad{" (SUBSTRING |u| 0 (+ |k| 1)) "}"
                       (SUBSTRING |u| (+ |k| 1) NIL))))))
                  (#1#
                   (PROGN
                    (SETQ |k| (OR (|checkSkipToken| |u| |j| |m|) (RETURN |u|)))
                    (SETQ |infixOp| (INTERN (SUBSTRING |u| |j| (- |k| |j|))))
                    (COND
                     ((NULL (GETL |infixOp| '|Led|))
                      (COND
                       ((NOT
                         (EQUAL |namestring|
                                (SETQ |firstWord| (SUBSTRING |u| 0 |i|))))
                        (PROGN
                         (|checkDocError|
                          (LIST "Improper first word in comments: "
                                |firstWord|))
                         |u|))
                       ((AND (EQL (LENGTH (SETQ |p| (PNAME |infixOp|))) 1)
                             (SETQ |open| (ELT |p| 0))
                             (SETQ |close| (LASSOC |open| |$checkPrenAlist|)))
                        (PROGN
                         (SETQ |l|
                                 (|getMatchingRightPren| |u| (+ |k| 1) |open|
                                  |close|))
                         (COND ((< (MAXINDEX |u|) |l|) (SETQ |l| (- |k| 1))))
                         (STRCONC "\\spad{" (SUBSTRING |u| 0 (+ |l| 1)) "}"
                          (SUBSTRING |u| (+ |l| 1) NIL))))
                       (#1#
                        (STRCONC "\\spad{" (SUBSTRING |u| 0 |k|) "}"
                         (SUBSTRING |u| |k| NIL)))))
                     (#1#
                      (PROGN
                       (SETQ |l|
                               (OR (|checkSkipBlanks| |u| |k| |m|)
                                   (RETURN |u|)))
                       (SETQ |n|
                               (OR (|checkSkipToken| |u| |l| |m|)
                                   (RETURN |u|)))
                       (COND
                        ((NOT (EQUAL |namestring| (PNAME |infixOp|)))
                         (PROGN
                          (|checkDocError|
                           (LIST "Improper initial operator in comments: "
                                 |infixOp|))
                          |u|))
                        (#1#
                         (STRCONC "\\spad{" (SUBSTRING |u| 0 |n|) "}"
                          (SUBSTRING |u| |n| NIL))))))))))))
               (T
                (PROGN
                 (SETQ |i| (OR (|checkSkipToken| |u| 0 |m|) (RETURN |u|)))
                 (COND
                  ((NOT
                    (EQUAL |namestring|
                           (SETQ |firstWord| (SUBSTRING |u| 0 |i|))))
                   (PROGN
                    (|checkDocError|
                     (LIST "Improper first word in comments: " |firstWord|))
                    |u|))
                  (#1#
                   (PROGN
                    (SETQ |prefixOp| (INTERN (SUBSTRING |u| 0 |i|)))
                    (COND ((NULL (GETL |prefixOp| '|Nud|)) |u|)
                          (#1#
                           (PROGN
                            (SETQ |j|
                                    (OR (|checkSkipBlanks| |u| |i| |m|)
                                        (RETURN |u|)))
                            (COND
                             ((EQUAL (ELT |u| |j|) (|char| '|(|))
                              (PROGN
                               (SETQ |j|
                                       (|getMatchingRightPren| |u| (+ |j| 1)
                                        (|char| '|(|) (|char| '|)|)))
                               (COND ((< |m| |j|) |u|)
                                     (#1#
                                      (STRCONC "\\spad{"
                                       (SUBSTRING |u| 0 (+ |j| 1)) "}"
                                       (SUBSTRING |u| (+ |j| 1) NIL))))))
                             (#1#
                              (PROGN
                               (SETQ |k|
                                       (OR (|checkSkipToken| |u| |j| |m|)
                                           (RETURN |u|)))
                               (COND
                                ((NOT
                                  (EQUAL |namestring|
                                         (SETQ |firstWord|
                                                 (SUBSTRING |u| 0 |i|))))
                                 (PROGN
                                  (|checkDocError|
                                   (LIST "Improper first word in comments: "
                                         |firstWord|))
                                  |u|))
                                (#1#
                                 (STRCONC "\\spad{" (SUBSTRING |u| 0 |k|) "}"
                                  (SUBSTRING |u| |k| NIL)))))))))))))))))))))))

; getMatchingRightPren(u,j,open,close) ==
;   count := 0
;   m := MAXINDEX u
;   for i in j..m repeat
;     c := u . i
;     do
;       c = close =>
;         count = 0 => return (found := i)
;         count := count - 1
;       c = open => count := count + 1
;   found

(DEFUN |getMatchingRightPren| (|u| |j| |open| |close|)
  (PROG (|count| |m| |c| |found|)
    (RETURN
     (PROGN
      (SETQ |count| 0)
      (SETQ |m| (MAXINDEX |u|))
      ((LAMBDA (|i|)
         (LOOP
          (COND ((> |i| |m|) (RETURN NIL))
                (#1='T
                 (PROGN
                  (SETQ |c| (ELT |u| |i|))
                  (|do|
                   (COND
                    ((EQUAL |c| |close|)
                     (COND ((EQL |count| 0) (RETURN (SETQ |found| |i|)))
                           (#1# (SETQ |count| (- |count| 1)))))
                    ((EQUAL |c| |open|) (SETQ |count| (+ |count| 1))))))))
          (SETQ |i| (+ |i| 1))))
       |j|)
      |found|))))

; checkSkipBlanks(u,i,m) ==
;   while i < m and u.i = $charBlank repeat i := i + 1
;   i = m => nil
;   i

(DEFUN |checkSkipBlanks| (|u| |i| |m|)
  (PROG ()
    (RETURN
     (PROGN
      ((LAMBDA ()
         (LOOP
          (COND
           ((NOT (AND (< |i| |m|) (EQUAL (ELT |u| |i|) |$charBlank|)))
            (RETURN NIL))
           (#1='T (SETQ |i| (+ |i| 1)))))))
      (COND ((EQUAL |i| |m|) NIL) (#1# |i|))))))

; checkSkipToken(u,i,m) ==
;   ALPHA_-CHAR_-P(u.i) => checkSkipIdentifierToken(u,i,m)
;   checkSkipOpToken(u,i,m)

(DEFUN |checkSkipToken| (|u| |i| |m|)
  (PROG ()
    (RETURN
     (COND
      ((ALPHA-CHAR-P (ELT |u| |i|)) (|checkSkipIdentifierToken| |u| |i| |m|))
      ('T (|checkSkipOpToken| |u| |i| |m|))))))

; checkSkipOpToken(u,i,m) ==
;   while i < m and
;     (not(checkAlphabetic(u.i)) and not(member(u.i,$charDelimiters))) repeat
;       i := i + 1
;   i = m => nil
;   i

(DEFUN |checkSkipOpToken| (|u| |i| |m|)
  (PROG ()
    (RETURN
     (PROGN
      ((LAMBDA ()
         (LOOP
          (COND
           ((NOT
             (AND (< |i| |m|) (NULL (|checkAlphabetic| (ELT |u| |i|)))
                  (NULL (|member| (ELT |u| |i|) |$charDelimiters|))))
            (RETURN NIL))
           (#1='T (SETQ |i| (+ |i| 1)))))))
      (COND ((EQUAL |i| |m|) NIL) (#1# |i|))))))

; checkSkipIdentifierToken(u,i,m) ==
;   while i < m and checkAlphabetic u.i repeat i := i + 1
;   i = m => nil
;   i

(DEFUN |checkSkipIdentifierToken| (|u| |i| |m|)
  (PROG ()
    (RETURN
     (PROGN
      ((LAMBDA ()
         (LOOP
          (COND
           ((NOT (AND (< |i| |m|) (|checkAlphabetic| (ELT |u| |i|))))
            (RETURN NIL))
           (#1='T (SETQ |i| (+ |i| 1)))))))
      (COND ((EQUAL |i| |m|) NIL) (#1# |i|))))))

; checkAlphabetic c ==
;   ALPHA_-CHAR_-P c or DIGITP c or MEMQ(c,$charIdentifierEndings)

(DEFUN |checkAlphabetic| (|c|)
  (PROG ()
    (RETURN
     (OR (ALPHA-CHAR-P |c|) (DIGITP |c|) (MEMQ |c| |$charIdentifierEndings|)))))

; checkDocError1 u ==
; --when compiling for documentation, ignore certain errors
;   BOUNDP '$compileDocumentation and $compileDocumentation => nil
;   checkDocError u

(DEFUN |checkDocError1| (|u|)
  (PROG ()
    (RETURN
     (COND
      ((AND (BOUNDP '|$compileDocumentation|) |$compileDocumentation|) NIL)
      ('T (|checkDocError| |u|))))))

; checkDocError u ==
;   $checkErrorFlag := true
;   msg :=
;     $recheckingFlag =>
;       $constructorName => checkDocMessage u
;       concat('"> ",u)
;     $constructorName => checkDocMessage u
;     u
;   if $exposeFlag and $exposeFlagHeading then
;     sayBrightly1($exposeFlagHeading,$outStream)
;     sayBrightly $exposeFlagHeading
;     $exposeFlagHeading := nil
;   sayBrightly msg
;   if $exposeFlag then sayBrightly1(msg,$outStream)

(DEFUN |checkDocError| (|u|)
  (PROG (|msg|)
    (RETURN
     (PROGN
      (SETQ |$checkErrorFlag| T)
      (SETQ |msg|
              (COND
               (|$recheckingFlag|
                (COND (|$constructorName| (|checkDocMessage| |u|))
                      (#1='T (|concat| "> " |u|))))
               (|$constructorName| (|checkDocMessage| |u|)) (#1# |u|)))
      (COND
       ((AND |$exposeFlag| |$exposeFlagHeading|)
        (|sayBrightly1| |$exposeFlagHeading| |$outStream|)
        (|sayBrightly| |$exposeFlagHeading|) (SETQ |$exposeFlagHeading| NIL)))
      (|sayBrightly| |msg|)
      (COND (|$exposeFlag| (|sayBrightly1| |msg| |$outStream|)))))))

; checkDocMessage u ==
;   sourcefile := GETDATABASE($constructorName,'SOURCEFILE)
;   person := '"---"
;   middle :=
;     BOUNDP '$x => ['"(",$x,'"): "]
;     ['": "]
;   concat(person,'">",sourcefile,'"-->",$constructorName,middle,u)

(DEFUN |checkDocMessage| (|u|)
  (PROG (|sourcefile| |person| |middle|)
    (RETURN
     (PROGN
      (SETQ |sourcefile| (GETDATABASE |$constructorName| 'SOURCEFILE))
      (SETQ |person| "---")
      (SETQ |middle|
              (COND ((BOUNDP '|$x|) (LIST "(" |$x| "): ")) ('T (LIST ": "))))
      (|concat| |person| ">" |sourcefile| "-->" |$constructorName| |middle|
       |u|)))))

; checkDecorateForHt u ==
;   count := 0
;   spadflag := false    --means OK to wrap single letter words with \s{}
;   while u repeat
;     x := first u
;     do
;       if x = '"\em" then
;         if count > 0 then spadflag := count - 1
;         else checkDocError ['"\em must be enclosed in braces"]
;       if member(x,'("\s" "\spadop" "\spadtype" "\spad" "\spadpaste" "\spadcommand" "\footnote")) then spadflag := count
;       else if x = $charLbrace then count := count + 1
;       else if x = $charRbrace then
;         count := count - 1
;         if spadflag = count then spadflag := false
;       else if not spadflag and member(x,'("+" "*" "=" "==" "->")) then
;         if $checkingXmptex? then
;           checkDocError ["Symbol ",x,'" appearing outside \spad{}"]
;       x = '"$" or x = '"%" => checkDocError ['"Unescaped ",x]
;     u := rest u
;   u

(DEFUN |checkDecorateForHt| (|u|)
  (PROG (|count| |spadflag| |x|)
    (RETURN
     (PROGN
      (SETQ |count| 0)
      (SETQ |spadflag| NIL)
      ((LAMBDA ()
         (LOOP
          (COND ((NOT |u|) (RETURN NIL))
                (#1='T
                 (PROGN
                  (SETQ |x| (CAR |u|))
                  (|do|
                   (PROGN
                    (COND
                     ((EQUAL |x| "\\em")
                      (COND ((< 0 |count|) (SETQ |spadflag| (- |count| 1)))
                            (#1#
                             (|checkDocError|
                              (LIST "\\em must be enclosed in braces"))))))
                    (COND
                     ((|member| |x|
                       '("\\s" "\\spadop" "\\spadtype" "\\spad" "\\spadpaste"
                         "\\spadcommand" "\\footnote"))
                      (SETQ |spadflag| |count|))
                     ((EQUAL |x| |$charLbrace|) (SETQ |count| (+ |count| 1)))
                     ((EQUAL |x| |$charRbrace|) (SETQ |count| (- |count| 1))
                      (COND
                       ((EQUAL |spadflag| |count|) (SETQ |spadflag| NIL))))
                     ((AND (NULL |spadflag|)
                           (|member| |x| '("+" "*" "=" "==" "->")))
                      (COND
                       (|$checkingXmptex?|
                        (|checkDocError|
                         (LIST '|Symbol | |x|
                               " appearing outside \\spad{}"))))))
                    (COND
                     ((OR (EQUAL |x| "$") (EQUAL |x| "%"))
                      (|checkDocError| (LIST "Unescaped " |x|))))))
                  (SETQ |u| (CDR |u|))))))))
      |u|))))
