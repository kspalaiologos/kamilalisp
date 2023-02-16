
; )package "BOOT"

(IN-PACKAGE "BOOT")

; dbFromConstructor?(htPage) == htpProperty(htPage,'conform)

(DEFUN |dbFromConstructor?| (|htPage|)
  (PROG () (RETURN (|htpProperty| |htPage| '|conform|))))

; dbDoesOneOpHaveParameters? opAlist ==
;   or/[(or/[fn for x in items]) for [op,:items] in opAlist] where fn ==
;     STRINGP x => dbPart(x,2,1) ~= '"0"
;     IFCAR x

(DEFUN |dbDoesOneOpHaveParameters?| (|opAlist|)
  (PROG (|op| |items|)
    (RETURN
     ((LAMBDA (|bfVar#5| |bfVar#4| |bfVar#3|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#4|) (PROGN (SETQ |bfVar#3| (CAR |bfVar#4|)) NIL))
           (RETURN |bfVar#5|))
          (#1='T
           (AND (CONSP |bfVar#3|)
                (PROGN
                 (SETQ |op| (CAR |bfVar#3|))
                 (SETQ |items| (CDR |bfVar#3|))
                 #1#)
                (PROGN
                 (SETQ |bfVar#5|
                         ((LAMBDA (|bfVar#2| |bfVar#1| |x|)
                            (LOOP
                             (COND
                              ((OR (ATOM |bfVar#1|)
                                   (PROGN (SETQ |x| (CAR |bfVar#1|)) NIL))
                               (RETURN |bfVar#2|))
                              (#1#
                               (PROGN
                                (SETQ |bfVar#2|
                                        (COND
                                         ((STRINGP |x|)
                                          (NOT (EQUAL (|dbPart| |x| 2 1) "0")))
                                         (#1# (IFCAR |x|))))
                                (COND (|bfVar#2| (RETURN |bfVar#2|))))))
                             (SETQ |bfVar#1| (CDR |bfVar#1|))))
                          NIL |items| NIL))
                 (COND (|bfVar#5| (RETURN |bfVar#5|)))))))
         (SETQ |bfVar#4| (CDR |bfVar#4|))))
      NIL |opAlist| NIL))))

; dbShowOps(htPage, which, key) ==
;   --NEXT LINE SHOULD BE REMOVED if we are sure that which is a string
;   which := STRINGIMAGE which
;   which ~= '"operation" => BREAK()
;   if MEMQ(key,'(extended basic all)) then
;     $groupChoice := key
;     key := htpProperty(htPage,'key) or 'names
;   opAlist := htpProperty(htPage, 'opAlist)
;   key = 'generalise =>
;     arg  := STRINGIMAGE CAAR opAlist
;     oPage arg
;   key = 'allDomains => dbShowOpAllDomains(htPage,opAlist,which)
;   key = 'filter =>
;     filter := pmTransFilter(dbGetInputString htPage)
;     filter is ['error,:.] => bcErrorPage filter
;     opAlist:= [x for x in opAlist | superMatch?(filter,DOWNCASE STRINGIMAGE opOf x)]
;     null opAlist => emptySearchPage(which, filter, false)
;     htPage := htInitPageNoHeading(htCopyProplist htPage)
;     htpSetProperty(htPage, 'opAlist, opAlist)
;     if not (htpProperty(htPage, 'condition?) = 'no) then
;       dbResetOpAlistCondition(htPage,which,opAlist)
;     dbShowOps(htPage,which,htpProperty(htPage,'exclusion))
;   htpSetProperty(htPage,'key,key)
;   if MEMQ(key,'(exposureOn exposureOff)) then
;     $exposedOnlyIfTrue :=
;        key = 'exposureOn => 'T
;        nil
;     key := htpProperty(htPage,'exclusion)
;   dbShowOp1(htPage,opAlist,which,key)

(DEFUN |dbShowOps| (|htPage| |which| |key|)
  (PROG (|opAlist| |arg| |filter|)
    (RETURN
     (PROGN
      (SETQ |which| (STRINGIMAGE |which|))
      (COND ((NOT (EQUAL |which| "operation")) (BREAK))
            (#1='T
             (PROGN
              (COND
               ((MEMQ |key| '(|extended| |basic| |all|))
                (SETQ |$groupChoice| |key|)
                (SETQ |key| (OR (|htpProperty| |htPage| '|key|) '|names|))))
              (SETQ |opAlist| (|htpProperty| |htPage| '|opAlist|))
              (COND
               ((EQ |key| '|generalise|)
                (PROGN
                 (SETQ |arg| (STRINGIMAGE (CAAR |opAlist|)))
                 (|oPage| |arg|)))
               ((EQ |key| '|allDomains|)
                (|dbShowOpAllDomains| |htPage| |opAlist| |which|))
               ((EQ |key| '|filter|)
                (PROGN
                 (SETQ |filter|
                         (|pmTransFilter| (|dbGetInputString| |htPage|)))
                 (COND
                  ((AND (CONSP |filter|) (EQ (CAR |filter|) '|error|))
                   (|bcErrorPage| |filter|))
                  (#1#
                   (PROGN
                    (SETQ |opAlist|
                            ((LAMBDA (|bfVar#7| |bfVar#6| |x|)
                               (LOOP
                                (COND
                                 ((OR (ATOM |bfVar#6|)
                                      (PROGN (SETQ |x| (CAR |bfVar#6|)) NIL))
                                  (RETURN (NREVERSE |bfVar#7|)))
                                 (#1#
                                  (AND
                                   (|superMatch?| |filter|
                                    (DOWNCASE (STRINGIMAGE (|opOf| |x|))))
                                   (SETQ |bfVar#7| (CONS |x| |bfVar#7|)))))
                                (SETQ |bfVar#6| (CDR |bfVar#6|))))
                             NIL |opAlist| NIL))
                    (COND
                     ((NULL |opAlist|)
                      (|emptySearchPage| |which| |filter| NIL))
                     (#1#
                      (PROGN
                       (SETQ |htPage|
                               (|htInitPageNoHeading|
                                (|htCopyProplist| |htPage|)))
                       (|htpSetProperty| |htPage| '|opAlist| |opAlist|)
                       (COND
                        ((NULL
                          (EQ (|htpProperty| |htPage| '|condition?|) '|no|))
                         (|dbResetOpAlistCondition| |htPage| |which|
                          |opAlist|)))
                       (|dbShowOps| |htPage| |which|
                        (|htpProperty| |htPage| '|exclusion|))))))))))
               (#1#
                (PROGN
                 (|htpSetProperty| |htPage| '|key| |key|)
                 (COND
                  ((MEMQ |key| '(|exposureOn| |exposureOff|))
                   (SETQ |$exposedOnlyIfTrue|
                           (COND ((EQ |key| '|exposureOn|) 'T) (#1# NIL)))
                   (SETQ |key| (|htpProperty| |htPage| '|exclusion|))))
                 (|dbShowOp1| |htPage| |opAlist| |which| |key|)))))))))))

; reduceByGroup(htPage,opAlist) ==
;   not dbFromConstructor?(htPage) or null $groupChoice => opAlist
;   dbExpandOpAlistIfNecessary(htPage,opAlist,'"operation",true,false)
;   bitNumber := HGET($topicHash,$groupChoice)
;   res := [[op,:newItems] for [op,:items] in opAlist | newItems] where
;     newItems ==
;       null bitNumber => items
;       [x for x in items | FIXP (code := LASTATOM x) and LOGBITP(bitNumber,code)]
;   res

(DEFUN |reduceByGroup| (|htPage| |opAlist|)
  (PROG (|bitNumber| |op| |items| |code| |res|)
    (RETURN
     (COND
      ((OR (NULL (|dbFromConstructor?| |htPage|)) (NULL |$groupChoice|))
       |opAlist|)
      (#1='T
       (PROGN
        (|dbExpandOpAlistIfNecessary| |htPage| |opAlist| "operation" T NIL)
        (SETQ |bitNumber| (HGET |$topicHash| |$groupChoice|))
        (SETQ |res|
                ((LAMBDA (|bfVar#10| |bfVar#9| |bfVar#8|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#9|)
                          (PROGN (SETQ |bfVar#8| (CAR |bfVar#9|)) NIL))
                      (RETURN (NREVERSE |bfVar#10|)))
                     (#1#
                      (AND (CONSP |bfVar#8|)
                           (PROGN
                            (SETQ |op| (CAR |bfVar#8|))
                            (SETQ |items| (CDR |bfVar#8|))
                            #1#)
                           #2=(COND ((NULL |bitNumber|) |items|)
                                    (#1#
                                     ((LAMBDA (|bfVar#12| |bfVar#11| |x|)
                                        (LOOP
                                         (COND
                                          ((OR (ATOM |bfVar#11|)
                                               (PROGN
                                                (SETQ |x| (CAR |bfVar#11|))
                                                NIL))
                                           (RETURN (NREVERSE |bfVar#12|)))
                                          (#1#
                                           (AND
                                            (FIXP (SETQ |code| (LASTATOM |x|)))
                                            (LOGBITP |bitNumber| |code|)
                                            (SETQ |bfVar#12|
                                                    (CONS |x| |bfVar#12|)))))
                                         (SETQ |bfVar#11| (CDR |bfVar#11|))))
                                      NIL |items| NIL)))
                           (SETQ |bfVar#10|
                                   (CONS (CONS |op| #2#) |bfVar#10|)))))
                    (SETQ |bfVar#9| (CDR |bfVar#9|))))
                 NIL |opAlist| NIL))
        |res|))))))

; dbShowOp1(htPage,opAlist,which,key) ==
;   --set up for filtering below in dbGatherData
;   which ~= '"operation" => BREAK()
;   if INTEGERP key then
;     -- BREAK()
;     opAlist := dbSelectData(htPage,opAlist,key)
;     ------> Jump out for constructor names in file <--------
;   INTEGERP key and opAlist is [[con,:.]] and htpProperty(htPage,'isFile)
;       and constructor? con => return conPageChoose con
;   if INTEGERP key then
;     htPage := htInitPageNoHeading(htCopyProplist htPage)
;     htpSetProperty(htPage, 'opAlist, opAlist)
;     if not (htpProperty(htPage, 'condition?) = 'no) then
;       dbResetOpAlistCondition(htPage,which,opAlist)
;   dbExpandOpAlistIfNecessary(htPage,opAlist,which,true,false)
;   if $exposedOnlyIfTrue and not dbFromConstructor?(htPage) then
;   --opAlist is expanded to form [[op,[sig,pred,origin,exposed,comments],...],...]
;     opAlist:=[item for [op,:items] in opAlist | item] where
;       item ==
;         acc := nil
;         for x in items | x.3 repeat acc:= [x,:acc]
;         null acc => nil
;         [op,:NREVERSE acc]
;   $conformsAreDomains : local := htpProperty(htPage,'domname)
;   opCount := opAlistCount(opAlist, which)
;   branch :=
;     INTEGERP key =>
;       opCount <= $opDescriptionThreshold => 'documentation
;       'names
;     key = 'names and null rest opAlist =>      --means a single op
;       opCount <= $opDescriptionThreshold => 'documentation
;       'names
;     key
;   [what,whats,fn] := LASSOC(branch,$OpViewTable)
;   data := dbGatherData(htPage,opAlist,which,branch)
;   dataCount := +/[1 for x in data | (what = '"Name" and $exposedOnlyIfTrue => atom x; true)]
;   namedPart :=
;     null rest opAlist =>
;       ops := escapeSpecialChars STRINGIMAGE CAAR opAlist
;       ['" {\em ",ops,'"}"]
;     nil
;   if what = '"Condition" and null IFCAR IFCAR data then dataCount := dataCount - 1
;   exposurePart :=
;     $exposedOnlyIfTrue => '(" Exposed ")
;     nil
;   firstPart :=
;     opCount = 0 => ['"No ",:exposurePart, pluralize capitalize which]
;     dataCount = 1 or dataCount = opCount =>
;       opCount = 1 => [:exposurePart, capitalize which,:namedPart]
;       [STRINGIMAGE opCount,'" ",:exposurePart,
;          pluralize capitalize which,:namedPart]
;     prefix := pluralSay(dataCount,what,whats)
;     [:prefix,'" for ",STRINGIMAGE opCount,'" ",pluralize capitalize which,:namedPart]
;   page := htInitPageNoHeading(htCopyProplist htPage)
;   ------------>above line used to call htInitPageHoHeading<----------
;   htAddHeading dbShowOpHeading([:firstPart,:fromHeading page], branch)
;   htpSetProperty(page,'data,data)
;   htpSetProperty(page,'branch,branch)
;   -- the only place where specialMessage property is set seems to be commented. out
;   if u := htpProperty(page,'specialMessage) then APPLY(first u,rest u)
;   htSayStandard('"\beginscroll ")
;   FUNCALL(fn,page,opAlist,which,data) --apply branch function
;   if $atLeastOneUnexposed then
;       htSay '"{\em *} = unexposed"
;   htSayStandard("\endscroll ")
;   dbPresentOps(page,which,branch)
;   htShowPageNoScroll()

(DEFUN |dbShowOp1| (|htPage| |opAlist| |which| |key|)
  (PROG (|$conformsAreDomains| |u| |page| |firstPart| |prefix| |exposurePart|
         |namedPart| |ops| |dataCount| |data| |fn| |whats| |what| |LETTMP#1|
         |branch| |opCount| |acc| |items| |op| |con| |ISTMP#1|)
    (DECLARE (SPECIAL |$conformsAreDomains|))
    (RETURN
     (COND ((NOT (EQUAL |which| "operation")) (BREAK))
           (#1='T
            (PROGN
             (COND
              ((INTEGERP |key|)
               (SETQ |opAlist| (|dbSelectData| |htPage| |opAlist| |key|))))
             (COND
              ((AND (INTEGERP |key|) (CONSP |opAlist|) (EQ (CDR |opAlist|) NIL)
                    (PROGN
                     (SETQ |ISTMP#1| (CAR |opAlist|))
                     (AND (CONSP |ISTMP#1|)
                          (PROGN (SETQ |con| (CAR |ISTMP#1|)) #1#)))
                    (|htpProperty| |htPage| '|isFile|) (|constructor?| |con|))
               (RETURN (|conPageChoose| |con|)))
              (#1#
               (PROGN
                (COND
                 ((INTEGERP |key|)
                  (SETQ |htPage|
                          (|htInitPageNoHeading| (|htCopyProplist| |htPage|)))
                  (|htpSetProperty| |htPage| '|opAlist| |opAlist|)
                  (COND
                   ((NULL (EQ (|htpProperty| |htPage| '|condition?|) '|no|))
                    (|dbResetOpAlistCondition| |htPage| |which| |opAlist|)))))
                (|dbExpandOpAlistIfNecessary| |htPage| |opAlist| |which| T NIL)
                (COND
                 ((AND |$exposedOnlyIfTrue|
                       (NULL (|dbFromConstructor?| |htPage|)))
                  (SETQ |opAlist|
                          ((LAMBDA (|bfVar#15| |bfVar#14| |bfVar#13|)
                             (LOOP
                              (COND
                               ((OR (ATOM |bfVar#14|)
                                    (PROGN
                                     (SETQ |bfVar#13| (CAR |bfVar#14|))
                                     NIL))
                                (RETURN (NREVERSE |bfVar#15|)))
                               (#1#
                                (AND (CONSP |bfVar#13|)
                                     (PROGN
                                      (SETQ |op| (CAR |bfVar#13|))
                                      (SETQ |items| (CDR |bfVar#13|))
                                      #1#)
                                     #2=(PROGN
                                         (SETQ |acc| NIL)
                                         ((LAMBDA (|bfVar#16| |x|)
                                            (LOOP
                                             (COND
                                              ((OR (ATOM |bfVar#16|)
                                                   (PROGN
                                                    (SETQ |x| (CAR |bfVar#16|))
                                                    NIL))
                                               (RETURN NIL))
                                              (#1#
                                               (AND (ELT |x| 3)
                                                    (SETQ |acc|
                                                            (CONS |x|
                                                                  |acc|)))))
                                             (SETQ |bfVar#16|
                                                     (CDR |bfVar#16|))))
                                          |items| NIL)
                                         (COND ((NULL |acc|) NIL)
                                               (#1#
                                                (CONS |op| (NREVERSE |acc|)))))
                                     (SETQ |bfVar#15| (CONS #2# |bfVar#15|)))))
                              (SETQ |bfVar#14| (CDR |bfVar#14|))))
                           NIL |opAlist| NIL))))
                (SETQ |$conformsAreDomains|
                        (|htpProperty| |htPage| '|domname|))
                (SETQ |opCount| (|opAlistCount| |opAlist| |which|))
                (SETQ |branch|
                        (COND
                         ((INTEGERP |key|)
                          (COND
                           ((NOT (< |$opDescriptionThreshold| |opCount|))
                            '|documentation|)
                           (#1# '|names|)))
                         ((AND (EQ |key| '|names|) (NULL (CDR |opAlist|)))
                          (COND
                           ((NOT (< |$opDescriptionThreshold| |opCount|))
                            '|documentation|)
                           (#1# '|names|)))
                         (#1# |key|)))
                (SETQ |LETTMP#1| (LASSOC |branch| |$OpViewTable|))
                (SETQ |what| (CAR |LETTMP#1|))
                (SETQ |whats| (CADR . #3=(|LETTMP#1|)))
                (SETQ |fn| (CADDR . #3#))
                (SETQ |data|
                        (|dbGatherData| |htPage| |opAlist| |which| |branch|))
                (SETQ |dataCount|
                        ((LAMBDA (|bfVar#18| |bfVar#17| |x|)
                           (LOOP
                            (COND
                             ((OR (ATOM |bfVar#17|)
                                  (PROGN (SETQ |x| (CAR |bfVar#17|)) NIL))
                              (RETURN |bfVar#18|))
                             (#1#
                              (AND
                               (COND
                                ((AND (EQUAL |what| "Name")
                                      |$exposedOnlyIfTrue|)
                                 (ATOM |x|))
                                (#1# T))
                               (SETQ |bfVar#18| (+ |bfVar#18| 1)))))
                            (SETQ |bfVar#17| (CDR |bfVar#17|))))
                         0 |data| NIL))
                (SETQ |namedPart|
                        (COND
                         ((NULL (CDR |opAlist|))
                          (PROGN
                           (SETQ |ops|
                                   (|escapeSpecialChars|
                                    (STRINGIMAGE (CAAR |opAlist|))))
                           (LIST " {\\em " |ops| "}")))
                         (#1# NIL)))
                (COND
                 ((AND (EQUAL |what| "Condition")
                       (NULL (IFCAR (IFCAR |data|))))
                  (SETQ |dataCount| (- |dataCount| 1))))
                (SETQ |exposurePart|
                        (COND (|$exposedOnlyIfTrue| '(" Exposed ")) (#1# NIL)))
                (SETQ |firstPart|
                        (COND
                         ((EQL |opCount| 0)
                          (CONS "No "
                                (APPEND |exposurePart|
                                        (CONS
                                         (|pluralize| (|capitalize| |which|))
                                         NIL))))
                         ((OR (EQL |dataCount| 1)
                              (EQUAL |dataCount| |opCount|))
                          (COND
                           ((EQL |opCount| 1)
                            (APPEND |exposurePart|
                                    (CONS (|capitalize| |which|) |namedPart|)))
                           (#1#
                            (CONS (STRINGIMAGE |opCount|)
                                  (CONS " "
                                        (APPEND |exposurePart|
                                                (CONS
                                                 (|pluralize|
                                                  (|capitalize| |which|))
                                                 |namedPart|)))))))
                         (#1#
                          (PROGN
                           (SETQ |prefix|
                                   (|pluralSay| |dataCount| |what| |whats|))
                           (APPEND |prefix|
                                   (CONS " for "
                                         (CONS (STRINGIMAGE |opCount|)
                                               (CONS " "
                                                     (CONS
                                                      (|pluralize|
                                                       (|capitalize| |which|))
                                                      |namedPart|)))))))))
                (SETQ |page|
                        (|htInitPageNoHeading| (|htCopyProplist| |htPage|)))
                (|htAddHeading|
                 (|dbShowOpHeading| (APPEND |firstPart| (|fromHeading| |page|))
                  |branch|))
                (|htpSetProperty| |page| '|data| |data|)
                (|htpSetProperty| |page| '|branch| |branch|)
                (COND
                 ((SETQ |u| (|htpProperty| |page| '|specialMessage|))
                  (APPLY (CAR |u|) (CDR |u|))))
                (|htSayStandard| "\\beginscroll ")
                (FUNCALL |fn| |page| |opAlist| |which| |data|)
                (COND
                 (|$atLeastOneUnexposed| (|htSay| "{\\em *} = unexposed")))
                (|htSayStandard| '|\\endscroll |)
                (|dbPresentOps| |page| |which| |branch|)
                (|htShowPageNoScroll|))))))))))

; opAlistCount(opAlist, which) == +/[foo for [op,:items] in opAlist] where foo ==
;   which = '"attribute" => BREAK()
;   null $exposedOnlyIfTrue => #items
;   +/[1 for w in items | null (p := CDDR w) or p . 1]

(DEFUN |opAlistCount| (|opAlist| |which|)
  (PROG (|op| |items| |p|)
    (RETURN
     ((LAMBDA (|bfVar#21| |bfVar#20| |bfVar#19|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#20|)
               (PROGN (SETQ |bfVar#19| (CAR |bfVar#20|)) NIL))
           (RETURN |bfVar#21|))
          (#1='T
           (AND (CONSP |bfVar#19|)
                (PROGN
                 (SETQ |op| (CAR |bfVar#19|))
                 (SETQ |items| (CDR |bfVar#19|))
                 #1#)
                (SETQ |bfVar#21|
                        (+ |bfVar#21|
                           (COND ((EQUAL |which| "attribute") (BREAK))
                                 ((NULL |$exposedOnlyIfTrue|) (LENGTH |items|))
                                 (#1#
                                  ((LAMBDA (|bfVar#23| |bfVar#22| |w|)
                                     (LOOP
                                      (COND
                                       ((OR (ATOM |bfVar#22|)
                                            (PROGN
                                             (SETQ |w| (CAR |bfVar#22|))
                                             NIL))
                                        (RETURN |bfVar#23|))
                                       (#1#
                                        (AND
                                         (OR (NULL (SETQ |p| (CDDR |w|)))
                                             (ELT |p| 1))
                                         (SETQ |bfVar#23| (+ |bfVar#23| 1)))))
                                      (SETQ |bfVar#22| (CDR |bfVar#22|))))
                                   0 |items| NIL))))))))
         (SETQ |bfVar#20| (CDR |bfVar#20|))))
      0 |opAlist| NIL))))

; dbShowOpHeading(heading, branch) ==
;   suffix :=
; --  branch = 'signatures => '" viewed as signatures"
;     branch = 'parameters => '" viewed with parameters"
;     branch = 'origins    => '" organized by origins"
;     branch = 'conditions => '" organized by conditions"
;     '""
;   [:heading, suffix]

(DEFUN |dbShowOpHeading| (|heading| |branch|)
  (PROG (|suffix|)
    (RETURN
     (PROGN
      (SETQ |suffix|
              (COND ((EQ |branch| '|parameters|) " viewed with parameters")
                    ((EQ |branch| '|origins|) " organized by origins")
                    ((EQ |branch| '|conditions|) " organized by conditions")
                    ('T "")))
      (APPEND |heading| (CONS |suffix| NIL))))))

; fromHeading htPage ==
;   null htPage => '""
;   $pn := [htPage.0,'"}{"]
;   updomain := htpProperty(htPage,'updomain) =>
;     dnForm  := dbExtractUnderlyingDomain updomain
;     dnString:= form2StringList dnForm
;     dnFence := form2Fence  dnForm
; --  upString:= form2StringList updomain
;     upFence := form2Fence  updomain
;     upOp    := PNAME opOf  updomain
;     ['" {\em from} ",:dbConformGen dnForm,'" {\em under} \ops{",upOp,'"}{",:$pn,:upFence,'"}"]
;   domname  := htpProperty(htPage,'domname)
;   numberOfUnderlyingDomains := #[x for x in rest GETDATABASE(opOf domname,'COSIG) | x]
;   IFCDR domname => ['" {\em from} ", :dbConformGen domname]
;   htpProperty(htPage,'fromHeading)

(DEFUN |fromHeading| (|htPage|)
  (PROG (|updomain| |dnForm| |dnString| |dnFence| |upFence| |upOp| |domname|
         |numberOfUnderlyingDomains|)
    (RETURN
     (COND ((NULL |htPage|) "")
           (#1='T
            (PROGN
             (SETQ |$pn| (LIST (ELT |htPage| 0) "}{"))
             (COND
              ((SETQ |updomain| (|htpProperty| |htPage| '|updomain|))
               (PROGN
                (SETQ |dnForm| (|dbExtractUnderlyingDomain| |updomain|))
                (SETQ |dnString| (|form2StringList| |dnForm|))
                (SETQ |dnFence| (|form2Fence| |dnForm|))
                (SETQ |upFence| (|form2Fence| |updomain|))
                (SETQ |upOp| (PNAME (|opOf| |updomain|)))
                (CONS " {\\em from} "
                      (APPEND (|dbConformGen| |dnForm|)
                              (CONS " {\\em under} \\ops{"
                                    (CONS |upOp|
                                          (CONS "}{"
                                                (APPEND |$pn|
                                                        (APPEND |upFence|
                                                                (CONS "}"
                                                                      NIL))))))))))
              (#1#
               (PROGN
                (SETQ |domname| (|htpProperty| |htPage| '|domname|))
                (SETQ |numberOfUnderlyingDomains|
                        (LENGTH
                         ((LAMBDA (|bfVar#25| |bfVar#24| |x|)
                            (LOOP
                             (COND
                              ((OR (ATOM |bfVar#24|)
                                   (PROGN (SETQ |x| (CAR |bfVar#24|)) NIL))
                               (RETURN (NREVERSE |bfVar#25|)))
                              (#1#
                               (AND |x|
                                    (SETQ |bfVar#25| (CONS |x| |bfVar#25|)))))
                             (SETQ |bfVar#24| (CDR |bfVar#24|))))
                          NIL (CDR (GETDATABASE (|opOf| |domname|) 'COSIG))
                          NIL)))
                (COND
                 ((IFCDR |domname|)
                  (CONS " {\\em from} " (|dbConformGen| |domname|)))
                 (#1# (|htpProperty| |htPage| '|fromHeading|))))))))))))

; conform2StringList(form, opFn, argFn) ==
;   [op1,:args] := form
;   op := IFCAR HGET($lowerCaseConTb,op1) or op1
;   null args => APPLY(opFn,[op])
;   special := MEMQ(op,'(Union Record Mapping))
;   cosig :=
;     special => ['T for x in args]
;     rest GETDATABASE(op,'COSIG)
;   atypes :=
;     special => cosig
;     rest CDAR GETDATABASE(op,'CONSTRUCTORMODEMAP)
;   sargl := [fn for x in args for atype in atypes for pred in cosig] where fn ==
;     keyword :=
;       special and x is [":",y,t] =>
;         x := t
;         y
;       nil
;     res :=
;       pred =>
;         STRINGP x => [x]
;         u := APPLY(argFn,[x])
;         atom u and [u] or u
;       typ := sublisFormal(args,atype)
;       if x is ['QUOTE,a] then x := a
;       u := mathform2HtString algCoerceInteractive(x,typ,'(OutputForm)) => [u]
;       NUMBERP x or STRINGP x => [x]
;       systemError()
;     keyword => [keyword,'": ",:res]
;     res
;   op = 'Mapping => dbMapping2StringList sargl
;   head :=
;     special => [op]
;     APPLY(opFn,[form])
;   [:head,'"(",:first sargl,:"append"/[[",",:y] for y in rest sargl],'")"]

(DEFUN |conform2StringList| (|form| |opFn| |argFn|)
  (PROG (|op1| |args| |op| |special| |cosig| |atypes| |ISTMP#1| |y| |ISTMP#2|
         |t| |keyword| |u| |typ| |a| |res| |sargl| |head|)
    (RETURN
     (PROGN
      (SETQ |op1| (CAR |form|))
      (SETQ |args| (CDR |form|))
      (SETQ |op| (OR (IFCAR (HGET |$lowerCaseConTb| |op1|)) |op1|))
      (COND ((NULL |args|) (APPLY |opFn| (LIST |op|)))
            (#1='T
             (PROGN
              (SETQ |special| (MEMQ |op| '(|Union| |Record| |Mapping|)))
              (SETQ |cosig|
                      (COND
                       (|special|
                        ((LAMBDA (|bfVar#27| |bfVar#26| |x|)
                           (LOOP
                            (COND
                             ((OR (ATOM |bfVar#26|)
                                  (PROGN (SETQ |x| (CAR |bfVar#26|)) NIL))
                              (RETURN (NREVERSE |bfVar#27|)))
                             (#1# (SETQ |bfVar#27| (CONS 'T |bfVar#27|))))
                            (SETQ |bfVar#26| (CDR |bfVar#26|))))
                         NIL |args| NIL))
                       (#1# (CDR (GETDATABASE |op| 'COSIG)))))
              (SETQ |atypes|
                      (COND (|special| |cosig|)
                            (#1#
                             (CDR
                              (CDAR (GETDATABASE |op| 'CONSTRUCTORMODEMAP))))))
              (SETQ |sargl|
                      ((LAMBDA
                           (|bfVar#31| |bfVar#28| |x| |bfVar#29| |atype|
                            |bfVar#30| |pred|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#28|)
                                (PROGN (SETQ |x| (CAR |bfVar#28|)) NIL)
                                (ATOM |bfVar#29|)
                                (PROGN (SETQ |atype| (CAR |bfVar#29|)) NIL)
                                (ATOM |bfVar#30|)
                                (PROGN (SETQ |pred| (CAR |bfVar#30|)) NIL))
                            (RETURN (NREVERSE |bfVar#31|)))
                           (#1#
                            (SETQ |bfVar#31|
                                    (CONS
                                     (PROGN
                                      (SETQ |keyword|
                                              (COND
                                               ((AND |special| (CONSP |x|)
                                                     (EQ (CAR |x|) '|:|)
                                                     (PROGN
                                                      (SETQ |ISTMP#1|
                                                              (CDR |x|))
                                                      (AND (CONSP |ISTMP#1|)
                                                           (PROGN
                                                            (SETQ |y|
                                                                    (CAR
                                                                     |ISTMP#1|))
                                                            (SETQ |ISTMP#2|
                                                                    (CDR
                                                                     |ISTMP#1|))
                                                            (AND
                                                             (CONSP |ISTMP#2|)
                                                             (EQ
                                                              (CDR |ISTMP#2|)
                                                              NIL)
                                                             (PROGN
                                                              (SETQ |t|
                                                                      (CAR
                                                                       |ISTMP#2|))
                                                              #1#))))))
                                                (PROGN (SETQ |x| |t|) |y|))
                                               (#1# NIL)))
                                      (SETQ |res|
                                              (COND
                                               (|pred|
                                                (COND
                                                 ((STRINGP |x|) (LIST |x|))
                                                 (#1#
                                                  (PROGN
                                                   (SETQ |u|
                                                           (APPLY |argFn|
                                                                  (LIST |x|)))
                                                   (OR
                                                    (AND (ATOM |u|) (LIST |u|))
                                                    |u|)))))
                                               (#1#
                                                (PROGN
                                                 (SETQ |typ|
                                                         (|sublisFormal| |args|
                                                          |atype|))
                                                 (COND
                                                  ((AND (CONSP |x|)
                                                        (EQ (CAR |x|) 'QUOTE)
                                                        (PROGN
                                                         (SETQ |ISTMP#1|
                                                                 (CDR |x|))
                                                         (AND (CONSP |ISTMP#1|)
                                                              (EQ
                                                               (CDR |ISTMP#1|)
                                                               NIL)
                                                              (PROGN
                                                               (SETQ |a|
                                                                       (CAR
                                                                        |ISTMP#1|))
                                                               #1#))))
                                                   (SETQ |x| |a|)))
                                                 (COND
                                                  ((SETQ |u|
                                                           (|mathform2HtString|
                                                            (|algCoerceInteractive|
                                                             |x| |typ|
                                                             '(|OutputForm|))))
                                                   (LIST |u|))
                                                  ((OR (NUMBERP |x|)
                                                       (STRINGP |x|))
                                                   (LIST |x|))
                                                  (#1# (|systemError|)))))))
                                      (COND
                                       (|keyword|
                                        (CONS |keyword| (CONS ": " |res|)))
                                       (#1# |res|)))
                                     |bfVar#31|))))
                          (SETQ |bfVar#28| (CDR |bfVar#28|))
                          (SETQ |bfVar#29| (CDR |bfVar#29|))
                          (SETQ |bfVar#30| (CDR |bfVar#30|))))
                       NIL |args| NIL |atypes| NIL |cosig| NIL))
              (COND ((EQ |op| '|Mapping|) (|dbMapping2StringList| |sargl|))
                    (#1#
                     (PROGN
                      (SETQ |head|
                              (COND (|special| (LIST |op|))
                                    (#1# (APPLY |opFn| (LIST |form|)))))
                      (APPEND |head|
                              (CONS "("
                                    (APPEND (CAR |sargl|)
                                            (APPEND
                                             ((LAMBDA
                                                  (|bfVar#33| |bfVar#32| |y|)
                                                (LOOP
                                                 (COND
                                                  ((OR (ATOM |bfVar#32|)
                                                       (PROGN
                                                        (SETQ |y|
                                                                (CAR
                                                                 |bfVar#32|))
                                                        NIL))
                                                   (RETURN |bfVar#33|))
                                                  (#1#
                                                   (SETQ |bfVar#33|
                                                           (APPEND |bfVar#33|
                                                                   (CONS '|,|
                                                                         |y|)))))
                                                 (SETQ |bfVar#32|
                                                         (CDR |bfVar#32|))))
                                              NIL (CDR |sargl|) NIL)
                                             (CONS ")" NIL)))))))))))))))

; dbMapping2StringList [target,:sl] ==
;   null sl => target
;   restPart :=
;     null rest sl => nil
;     "append"/[[",",:y] for y in rest sl]
;   sourcePart :=
;     restPart => ['"(",:first sl,:restPart,'")"]
;     first sl
;   [:sourcePart,'" -> ",:target]

(DEFUN |dbMapping2StringList| (|bfVar#36|)
  (PROG (|target| |sl| |restPart| |sourcePart|)
    (RETURN
     (PROGN
      (SETQ |target| (CAR |bfVar#36|))
      (SETQ |sl| (CDR |bfVar#36|))
      (COND ((NULL |sl|) |target|)
            (#1='T
             (PROGN
              (SETQ |restPart|
                      (COND ((NULL (CDR |sl|)) NIL)
                            (#1#
                             ((LAMBDA (|bfVar#35| |bfVar#34| |y|)
                                (LOOP
                                 (COND
                                  ((OR (ATOM |bfVar#34|)
                                       (PROGN (SETQ |y| (CAR |bfVar#34|)) NIL))
                                   (RETURN |bfVar#35|))
                                  (#1#
                                   (SETQ |bfVar#35|
                                           (APPEND |bfVar#35|
                                                   (CONS '|,| |y|)))))
                                 (SETQ |bfVar#34| (CDR |bfVar#34|))))
                              NIL (CDR |sl|) NIL))))
              (SETQ |sourcePart|
                      (COND
                       (|restPart|
                        (CONS "("
                              (APPEND (CAR |sl|)
                                      (APPEND |restPart| (CONS ")" NIL)))))
                       (#1# (CAR |sl|))))
              (APPEND |sourcePart| (CONS " -> " |target|)))))))))

; dbOuttran form ==
;   if LISTP form then
;     [op,:args] := form
;   else
;     op := form
;     args := nil
;   cosig := rest GETDATABASE(op,'COSIG)
;   atypes := rest CDAR GETDATABASE(op,'CONSTRUCTORMODEMAP)
;   argl := [fn for x in args for atype in atypes for pred in cosig] where fn ==
;     pred => x
;     typ := sublisFormal(args,atype)
;     arg :=
;       x is ['QUOTE,a] => a
;       x
;     res := mathform2HtString algCoerceInteractive(arg,typ,'(OutputForm))
;     NUMBERP res or STRINGP res => res
;     ['QUOTE,res]
;   [op,:argl]

(DEFUN |dbOuttran| (|form|)
  (PROG (|op| |args| |cosig| |atypes| |typ| |ISTMP#1| |a| |arg| |res| |argl|)
    (RETURN
     (PROGN
      (COND
       ((LISTP |form|) (SETQ |op| (CAR |form|)) (SETQ |args| (CDR |form|))
        |form|)
       (#1='T (SETQ |op| |form|) (SETQ |args| NIL)))
      (SETQ |cosig| (CDR (GETDATABASE |op| 'COSIG)))
      (SETQ |atypes| (CDR (CDAR (GETDATABASE |op| 'CONSTRUCTORMODEMAP))))
      (SETQ |argl|
              ((LAMBDA
                   (|bfVar#40| |bfVar#37| |x| |bfVar#38| |atype| |bfVar#39|
                    |pred|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#37|)
                        (PROGN (SETQ |x| (CAR |bfVar#37|)) NIL)
                        (ATOM |bfVar#38|)
                        (PROGN (SETQ |atype| (CAR |bfVar#38|)) NIL)
                        (ATOM |bfVar#39|)
                        (PROGN (SETQ |pred| (CAR |bfVar#39|)) NIL))
                    (RETURN (NREVERSE |bfVar#40|)))
                   (#1#
                    (SETQ |bfVar#40|
                            (CONS
                             (COND (|pred| |x|)
                                   (#1#
                                    (PROGN
                                     (SETQ |typ|
                                             (|sublisFormal| |args| |atype|))
                                     (SETQ |arg|
                                             (COND
                                              ((AND (CONSP |x|)
                                                    (EQ (CAR |x|) 'QUOTE)
                                                    (PROGN
                                                     (SETQ |ISTMP#1| (CDR |x|))
                                                     (AND (CONSP |ISTMP#1|)
                                                          (EQ (CDR |ISTMP#1|)
                                                              NIL)
                                                          (PROGN
                                                           (SETQ |a|
                                                                   (CAR
                                                                    |ISTMP#1|))
                                                           #1#))))
                                               |a|)
                                              (#1# |x|)))
                                     (SETQ |res|
                                             (|mathform2HtString|
                                              (|algCoerceInteractive| |arg|
                                               |typ| '(|OutputForm|))))
                                     (COND
                                      ((OR (NUMBERP |res|) (STRINGP |res|))
                                       |res|)
                                      (#1# (LIST 'QUOTE |res|))))))
                             |bfVar#40|))))
                  (SETQ |bfVar#37| (CDR |bfVar#37|))
                  (SETQ |bfVar#38| (CDR |bfVar#38|))
                  (SETQ |bfVar#39| (CDR |bfVar#39|))))
               NIL |args| NIL |atypes| NIL |cosig| NIL))
      (CONS |op| |argl|)))))

; dbConformGen form == dbConformGen1(form,true)

(DEFUN |dbConformGen| (|form|) (PROG () (RETURN (|dbConformGen1| |form| T))))

; dbConformGenUnder form == dbConformGen1(form,false)

(DEFUN |dbConformGenUnder| (|form|)
  (PROG () (RETURN (|dbConformGen1| |form| NIL))))

; dbConformGen1(form,opButton?) ==
;   opFunction :=
;     opButton? => FUNCTION dbConform
;     FUNCTION conname2StringList
;   originalOp := opOf form
;   op := unAbbreviateIfNecessary opOf form
;   args := IFCDR form
;   form :=
;     originalOp=op => form
;     [op, :args]
;   args => conform2StringList(form, opFunction, FUNCTION dbConformGen)
;   APPLY(opFunction,[form])

(DEFUN |dbConformGen1| (|form| |opButton?|)
  (PROG (|opFunction| |originalOp| |op| |args|)
    (RETURN
     (PROGN
      (SETQ |opFunction|
              (COND (|opButton?| #'|dbConform|)
                    (#1='T #'|conname2StringList|)))
      (SETQ |originalOp| (|opOf| |form|))
      (SETQ |op| (|unAbbreviateIfNecessary| (|opOf| |form|)))
      (SETQ |args| (IFCDR |form|))
      (SETQ |form|
              (COND ((EQUAL |originalOp| |op|) |form|)
                    (#1# (CONS |op| |args|))))
      (COND
       (|args| (|conform2StringList| |form| |opFunction| #'|dbConformGen|))
       (#1# (APPLY |opFunction| (LIST |form|))))))))

; unAbbreviateIfNecessary op == IFCAR HGET($lowerCaseConTb, op) or op

(DEFUN |unAbbreviateIfNecessary| (|op|)
  (PROG () (RETURN (OR (IFCAR (HGET |$lowerCaseConTb| |op|)) |op|))))

; conname2StringList form == [PNAME unAbbreviateIfNecessary opOf form]

(DEFUN |conname2StringList| (|form|)
  (PROG () (RETURN (LIST (PNAME (|unAbbreviateIfNecessary| (|opOf| |form|)))))))

; dbGatherData(htPage,opAlist,which,key) ==
;   which ~= '"operation" => BREAK()
;   key = 'implementation => dbGatherDataImplementation(htPage,opAlist)
;   dataFunction := LASSOC(key,table) where
;     table ==
;       $dbDataFunctionAlist or
;         ($dbDataFunctionAlist := [
;           ['signatures,:function dbMakeSignature],
;             ['parameters,:function dbContrivedForm],
;               ['origins,:function dbGetOrigin],
;                 ['domains,:function dbGetOrigin],
;                   ['conditions,:function dbGetCondition]])
;   null dataFunction =>
;     --key= names or filter or documentation; do not expand
;     if $exposedOnlyIfTrue and not dbFromConstructor?(htPage) then
;       opAlist := --to get indexing correct
;          which = '"operation" => htpProperty(htPage,'opAlist)
;          htpProperty(htPage,'attrAlist)
;     acc := nil
;     initialExposure :=
;       htPage and htpProperty(htPage,'conform) and which ~= '"package operation"
;         => true
;       --never star ops from a constructor
;       nil
;     for [op,:alist] in opAlist repeat
;       exposureFlag := initialExposure
;       while alist repeat
;         item := first alist
;         isExposed? :=
;           STRINGP item => dbExposed?(item,char 'o)   --unexpanded case
;           null (r := rest rest item) => true      --assume true if unexpanded
;           r . 1                                   --expanded case
;         if isExposed? then return (exposureFlag := true)
;         alist := rest alist
;       node :=
;         exposureFlag => op
;         [op,nil]
;       acc := [node,:acc]
;     NREVERSE acc
;   data := nil
;   dbExpandOpAlistIfNecessary(htPage,opAlist,which,key in '(origins documentation),false)
;   --create data, a list of the form ((entry,exposeFlag,:entries)...)
;   for [op,:alist] in opAlist repeat
;     for item in alist repeat
;       entry := FUNCALL(dataFunction,op,item)--get key item
;       exposeFlag :=                         --is the current op-sig exposed?
;         null (r := rest rest item) => true  --not given, assume yes
;         r . 1                               --is  given, use value
;       tail :=
;         item is [.,'ASCONST,:.] => 'ASCONST
;         nil
;       newEntry :=
;         u := assoc(entry,data) =>           --key seen before? look on DATA
;           RPLACA(rest u, CADR u or exposeFlag)--yes, expose if any 1 is exposed
;           u
;         data := [y := [entry,exposeFlag,:tail],:data]
;         y                                   --no, create new entry in DATA
;       if member(key,'(origins conditions)) then
;         r := CDDR newEntry
;         if atom r then r := nil             --clear out possible 'ASCONST
;         RPLACD(rest newEntry,             --store op/sigs under key if needed
;           insert([dbMakeSignature(op,item),exposeFlag,:tail],r))
;   if member(key,'(origins conditions)) then
;     for entry in data repeat   --sort list of entries (after the 2nd)
;       tail := CDDR entry
;       tail :=
;         atom tail => tail
;         listSort(function LEXLESSEQP,tail)
;       RPLACD(rest entry, tail)
;   data := listSort(function LEXLESSEQP,data)
;   data

(DEFUN |dbGatherData| (|htPage| |opAlist| |which| |key|)
  (PROG (|dataFunction| |acc| |initialExposure| |op| |alist| |exposureFlag|
         |item| |r| |isExposed?| |node| |data| |entry| |exposeFlag| |ISTMP#1|
         |tail| |u| |y| |newEntry|)
    (RETURN
     (COND ((NOT (EQUAL |which| "operation")) (BREAK))
           ((EQ |key| '|implementation|)
            (|dbGatherDataImplementation| |htPage| |opAlist|))
           (#1='T
            (PROGN
             (SETQ |dataFunction|
                     (LASSOC |key|
                      (OR |$dbDataFunctionAlist|
                          (SETQ |$dbDataFunctionAlist|
                                  (LIST
                                   (CONS '|signatures| #'|dbMakeSignature|)
                                   (CONS '|parameters| #'|dbContrivedForm|)
                                   (CONS '|origins| #'|dbGetOrigin|)
                                   (CONS '|domains| #'|dbGetOrigin|)
                                   (CONS '|conditions| #'|dbGetCondition|))))))
             (COND
              ((NULL |dataFunction|)
               (PROGN
                (COND
                 ((AND |$exposedOnlyIfTrue|
                       (NULL (|dbFromConstructor?| |htPage|)))
                  (SETQ |opAlist|
                          (COND
                           ((EQUAL |which| "operation")
                            (|htpProperty| |htPage| '|opAlist|))
                           (#1# (|htpProperty| |htPage| '|attrAlist|))))))
                (SETQ |acc| NIL)
                (SETQ |initialExposure|
                        (COND
                         ((AND |htPage| (|htpProperty| |htPage| '|conform|)
                               (NOT (EQUAL |which| "package operation")))
                          T)
                         (#1# NIL)))
                ((LAMBDA (|bfVar#42| |bfVar#41|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#42|)
                          (PROGN (SETQ |bfVar#41| (CAR |bfVar#42|)) NIL))
                      (RETURN NIL))
                     (#1#
                      (AND (CONSP |bfVar#41|)
                           (PROGN
                            (SETQ |op| (CAR |bfVar#41|))
                            (SETQ |alist| (CDR |bfVar#41|))
                            #1#)
                           (PROGN
                            (SETQ |exposureFlag| |initialExposure|)
                            ((LAMBDA ()
                               (LOOP
                                (COND ((NOT |alist|) (RETURN NIL))
                                      (#1#
                                       (PROGN
                                        (SETQ |item| (CAR |alist|))
                                        (SETQ |isExposed?|
                                                (COND
                                                 ((STRINGP |item|)
                                                  (|dbExposed?| |item|
                                                   (|char| '|o|)))
                                                 ((NULL
                                                   (SETQ |r|
                                                           (CDR (CDR |item|))))
                                                  T)
                                                 (#1# (ELT |r| 1))))
                                        (COND
                                         (|isExposed?|
                                          (RETURN (SETQ |exposureFlag| T))))
                                        (SETQ |alist| (CDR |alist|))))))))
                            (SETQ |node|
                                    (COND (|exposureFlag| |op|)
                                          (#1# (LIST |op| NIL))))
                            (SETQ |acc| (CONS |node| |acc|))))))
                    (SETQ |bfVar#42| (CDR |bfVar#42|))))
                 |opAlist| NIL)
                (NREVERSE |acc|)))
              (#1#
               (PROGN
                (SETQ |data| NIL)
                (|dbExpandOpAlistIfNecessary| |htPage| |opAlist| |which|
                 (|member| |key| '(|origins| |documentation|)) NIL)
                ((LAMBDA (|bfVar#44| |bfVar#43|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#44|)
                          (PROGN (SETQ |bfVar#43| (CAR |bfVar#44|)) NIL))
                      (RETURN NIL))
                     (#1#
                      (AND (CONSP |bfVar#43|)
                           (PROGN
                            (SETQ |op| (CAR |bfVar#43|))
                            (SETQ |alist| (CDR |bfVar#43|))
                            #1#)
                           ((LAMBDA (|bfVar#45| |item|)
                              (LOOP
                               (COND
                                ((OR (ATOM |bfVar#45|)
                                     (PROGN
                                      (SETQ |item| (CAR |bfVar#45|))
                                      NIL))
                                 (RETURN NIL))
                                (#1#
                                 (PROGN
                                  (SETQ |entry|
                                          (FUNCALL |dataFunction| |op| |item|))
                                  (SETQ |exposeFlag|
                                          (COND
                                           ((NULL
                                             (SETQ |r| (CDR (CDR |item|))))
                                            T)
                                           (#1# (ELT |r| 1))))
                                  (SETQ |tail|
                                          (COND
                                           ((AND (CONSP |item|)
                                                 (PROGN
                                                  (SETQ |ISTMP#1| (CDR |item|))
                                                  (AND (CONSP |ISTMP#1|)
                                                       (EQ (CAR |ISTMP#1|)
                                                           'ASCONST))))
                                            'ASCONST)
                                           (#1# NIL)))
                                  (SETQ |newEntry|
                                          (COND
                                           ((SETQ |u| (|assoc| |entry| |data|))
                                            (PROGN
                                             (RPLACA (CDR |u|)
                                                     (OR (CADR |u|)
                                                         |exposeFlag|))
                                             |u|))
                                           (#1#
                                            (PROGN
                                             (SETQ |data|
                                                     (CONS
                                                      (SETQ |y|
                                                              (CONS |entry|
                                                                    (CONS
                                                                     |exposeFlag|
                                                                     |tail|)))
                                                      |data|))
                                             |y|))))
                                  (COND
                                   ((|member| |key| '(|origins| |conditions|))
                                    (SETQ |r| (CDDR |newEntry|))
                                    (COND ((ATOM |r|) (SETQ |r| NIL)))
                                    (RPLACD (CDR |newEntry|)
                                            (|insert|
                                             (CONS
                                              (|dbMakeSignature| |op| |item|)
                                              (CONS |exposeFlag| |tail|))
                                             |r|)))))))
                               (SETQ |bfVar#45| (CDR |bfVar#45|))))
                            |alist| NIL))))
                    (SETQ |bfVar#44| (CDR |bfVar#44|))))
                 |opAlist| NIL)
                (COND
                 ((|member| |key| '(|origins| |conditions|))
                  ((LAMBDA (|bfVar#46| |entry|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#46|)
                            (PROGN (SETQ |entry| (CAR |bfVar#46|)) NIL))
                        (RETURN NIL))
                       (#1#
                        (PROGN
                         (SETQ |tail| (CDDR |entry|))
                         (SETQ |tail|
                                 (COND ((ATOM |tail|) |tail|)
                                       (#1# (|listSort| #'LEXLESSEQP |tail|))))
                         (RPLACD (CDR |entry|) |tail|))))
                      (SETQ |bfVar#46| (CDR |bfVar#46|))))
                   |data| NIL)))
                (SETQ |data| (|listSort| #'LEXLESSEQP |data|))
                |data|)))))))))

; dbGatherDataImplementation(htPage,opAlist) ==
; --returns data, of form ((implementor exposed? entry entry...)...
; --  where entry has form ((op sig . implementor) . stuff)
;   conform := htpProperty(htPage,'conform)
;   domainForm  := htpProperty(htPage,'domname)
;   dom     := EVAL domainForm
;   which   := '"operation"
;   [nam, :.] := domainForm
;   $predicateList: local := GETDATABASE(nam,'PREDICATES)
;   u := getDomainOpTable2(dom, true, ASSOCLEFT opAlist)
;   --u has form ((op,sig,:implementor)...)
;   --sort into 4 groups: domain exports, unexports, default exports, others
;
;   for (x := [.,.,:key]) in u for i in 0.. repeat
;     key = domainForm => domexports := [x,:domexports]
;     INTEGERP key => unexports := [x,:unexports]
;     isDefaultPackageForm? key => defexports := [x,:defexports]
;     key = 'nowhere => nowheres := [x,:nowheres]
;     key = 'constant =>constants := [x,:constants]
;     others := [x,:others]   --add chain domains go here
;   fn [nowheres,constants,domexports,SORTBY('CDDR,NREVERSE others),SORTBY('CDDR,
;                NREVERSE defexports),SORTBY('CDDR,NREVERSE unexports)] where
;     fn l ==
;       alist := nil
;       for u in l repeat
;         while u repeat
;           key := CDDAR u  --implementor
;           entries :=
;             [[first u, true],
;              :[u and [first u, true] while key = CDDAR(u := rest u)]]
;           alist := [[key,gn key,:entries],:alist]
;       NREVERSE alist
;     gn key ==
;       atom key => true
;       isExposedConstructor first key

(DEFUN |dbGatherDataImplementation| (|htPage| |opAlist|)
  (PROG (|$predicateList| |others| |constants| |nowheres| |defexports|
         |unexports| |domexports| |key| |ISTMP#1| |u| |nam| |which| |dom|
         |domainForm| |conform|)
    (DECLARE (SPECIAL |$predicateList|))
    (RETURN
     (PROGN
      (SETQ |conform| (|htpProperty| |htPage| '|conform|))
      (SETQ |domainForm| (|htpProperty| |htPage| '|domname|))
      (SETQ |dom| (EVAL |domainForm|))
      (SETQ |which| "operation")
      (SETQ |nam| (CAR |domainForm|))
      (SETQ |$predicateList| (GETDATABASE |nam| 'PREDICATES))
      (SETQ |u| (|getDomainOpTable2| |dom| T (ASSOCLEFT |opAlist|)))
      ((LAMBDA (|bfVar#47| |x| |i|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#47|) (PROGN (SETQ |x| (CAR |bfVar#47|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |x|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |x|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN (SETQ |key| (CDR |ISTMP#1|)) #1#)))
                 (COND
                  ((EQUAL |key| |domainForm|)
                   (SETQ |domexports| (CONS |x| |domexports|)))
                  ((INTEGERP |key|) (SETQ |unexports| (CONS |x| |unexports|)))
                  ((|isDefaultPackageForm?| |key|)
                   (SETQ |defexports| (CONS |x| |defexports|)))
                  ((EQ |key| '|nowhere|)
                   (SETQ |nowheres| (CONS |x| |nowheres|)))
                  ((EQ |key| '|constant|)
                   (SETQ |constants| (CONS |x| |constants|)))
                  (#1# (SETQ |others| (CONS |x| |others|)))))))
          (SETQ |bfVar#47| (CDR |bfVar#47|))
          (SETQ |i| (+ |i| 1))))
       |u| NIL 0)
      (|dbGatherDataImplementation,fn|
       (LIST |nowheres| |constants| |domexports|
             (SORTBY 'CDDR (NREVERSE |others|))
             (SORTBY 'CDDR (NREVERSE |defexports|))
             (SORTBY 'CDDR (NREVERSE |unexports|))))))))
(DEFUN |dbGatherDataImplementation,fn| (|l|)
  (PROG (|alist| |key| |entries|)
    (RETURN
     (PROGN
      (SETQ |alist| NIL)
      ((LAMBDA (|bfVar#48| |u|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#48|) (PROGN (SETQ |u| (CAR |bfVar#48|)) NIL))
            (RETURN NIL))
           (#1='T
            ((LAMBDA ()
               (LOOP
                (COND ((NOT |u|) (RETURN NIL))
                      (#1#
                       (PROGN
                        (SETQ |key| (CDDAR |u|))
                        (SETQ |entries|
                                (CONS (LIST (CAR |u|) T)
                                      ((LAMBDA (|bfVar#49|)
                                         (LOOP
                                          (COND
                                           ((NOT
                                             (EQUAL |key|
                                                    (CDDAR
                                                     (SETQ |u| (CDR |u|)))))
                                            (RETURN (NREVERSE |bfVar#49|)))
                                           (#1#
                                            (SETQ |bfVar#49|
                                                    (CONS
                                                     (AND |u|
                                                          (LIST (CAR |u|) T))
                                                     |bfVar#49|))))))
                                       NIL)))
                        (SETQ |alist|
                                (CONS
                                 (CONS |key|
                                       (CONS
                                        (|dbGatherDataImplementation,gn| |key|)
                                        |entries|))
                                 |alist|))))))))))
          (SETQ |bfVar#48| (CDR |bfVar#48|))))
       |l| NIL)
      (NREVERSE |alist|)))))
(DEFUN |dbGatherDataImplementation,gn| (|key|)
  (PROG ()
    (RETURN (COND ((ATOM |key|) T) ('T (|isExposedConstructor| (CAR |key|)))))))

; dbSelectData(htPage,opAlist,key) ==
;   branch := htpProperty(htPage,'branch)
;   data   := htpProperty(htPage,'data)
;   MEMQ(branch,'(signatures parameters)) =>
;     dbReduceOpAlist(opAlist,data.key,branch)
;   MEMQ(branch,'(origins conditions implementation)) =>
;     key < 8192 => dbReduceOpAlist(opAlist,data.key,branch)
;     [newkey,binkey] := DIVIDE(key,8192)  --newkey is 1 too large
;     innerData := CDDR data.(newkey - 1)
;     dbReduceOpAlist(opAlist,innerData.binkey,'signatures)
;   [opAlist . key]

(DEFUN |dbSelectData| (|htPage| |opAlist| |key|)
  (PROG (|branch| |data| |LETTMP#1| |newkey| |binkey| |innerData|)
    (RETURN
     (PROGN
      (SETQ |branch| (|htpProperty| |htPage| '|branch|))
      (SETQ |data| (|htpProperty| |htPage| '|data|))
      (COND
       ((MEMQ |branch| '(|signatures| |parameters|))
        (|dbReduceOpAlist| |opAlist| (ELT |data| |key|) |branch|))
       ((MEMQ |branch| '(|origins| |conditions| |implementation|))
        (COND
         ((< |key| 8192)
          (|dbReduceOpAlist| |opAlist| (ELT |data| |key|) |branch|))
         (#1='T
          (PROGN
           (SETQ |LETTMP#1| (DIVIDE |key| 8192))
           (SETQ |newkey| (CAR |LETTMP#1|))
           (SETQ |binkey| (CADR |LETTMP#1|))
           (SETQ |innerData| (CDDR (ELT |data| (- |newkey| 1))))
           (|dbReduceOpAlist| |opAlist| (ELT |innerData| |binkey|)
            '|signatures|)))))
       (#1# (LIST (ELT |opAlist| |key|))))))))

; dbReduceOpAlist(opAlist,data,branch) ==
;   branch = 'signatures => dbReduceBySignature(opAlist,CAAR data,CADAR data)
;   branch = 'origins => dbReduceBySelection(opAlist, first data, function CADDR)
;   branch = 'conditions =>
;       dbReduceBySelection(opAlist, first data, function CADR)
;   branch = 'implementation => dbReduceByOpSignature(opAlist,CDDR data)
;   branch = 'parameters => dbReduceByForm(opAlist, first data)
;   systemError ['"Unexpected branch: ",branch]

(DEFUN |dbReduceOpAlist| (|opAlist| |data| |branch|)
  (PROG ()
    (RETURN
     (COND
      ((EQ |branch| '|signatures|)
       (|dbReduceBySignature| |opAlist| (CAAR |data|) (CADAR |data|)))
      ((EQ |branch| '|origins|)
       (|dbReduceBySelection| |opAlist| (CAR |data|) #'CADDR))
      ((EQ |branch| '|conditions|)
       (|dbReduceBySelection| |opAlist| (CAR |data|) #'CADR))
      ((EQ |branch| '|implementation|)
       (|dbReduceByOpSignature| |opAlist| (CDDR |data|)))
      ((EQ |branch| '|parameters|) (|dbReduceByForm| |opAlist| (CAR |data|)))
      ('T (|systemError| (LIST "Unexpected branch: " |branch|)))))))

; dbReduceByOpSignature(opAlist,datalist) ==
; --reduces opAlist by implementation datalist, one of the form
; --    (((op,sig,:implementor),:stuff),...)
;   ops := [CAAR x for x in datalist] --x is [[op,sig,:implementor],:.]
;   acc := nil
;   for [op,:alist] in opAlist | MEMQ(op,ops) repeat
;     entryList := [entry for (entry := [sig,:.]) in alist | test] where test ==
;       or/[x for x in datalist | x is [[=op,=sig,:.],:.]]
;     entryList => acc := [[op,:NREVERSE entryList],:acc]
;   NREVERSE acc

(DEFUN |dbReduceByOpSignature| (|opAlist| |datalist|)
  (PROG (|ops| |acc| |op| |alist| |sig| |ISTMP#1| |ISTMP#2| |entryList|)
    (RETURN
     (PROGN
      (SETQ |ops|
              ((LAMBDA (|bfVar#51| |bfVar#50| |x|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#50|)
                        (PROGN (SETQ |x| (CAR |bfVar#50|)) NIL))
                    (RETURN (NREVERSE |bfVar#51|)))
                   (#1='T (SETQ |bfVar#51| (CONS (CAAR |x|) |bfVar#51|))))
                  (SETQ |bfVar#50| (CDR |bfVar#50|))))
               NIL |datalist| NIL))
      (SETQ |acc| NIL)
      ((LAMBDA (|bfVar#53| |bfVar#52|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#53|)
                (PROGN (SETQ |bfVar#52| (CAR |bfVar#53|)) NIL))
            (RETURN NIL))
           (#1#
            (AND (CONSP |bfVar#52|)
                 (PROGN
                  (SETQ |op| (CAR |bfVar#52|))
                  (SETQ |alist| (CDR |bfVar#52|))
                  #1#)
                 (MEMQ |op| |ops|)
                 (PROGN
                  (SETQ |entryList|
                          ((LAMBDA (|bfVar#55| |bfVar#54| |entry|)
                             (LOOP
                              (COND
                               ((OR (ATOM |bfVar#54|)
                                    (PROGN
                                     (SETQ |entry| (CAR |bfVar#54|))
                                     NIL))
                                (RETURN (NREVERSE |bfVar#55|)))
                               (#1#
                                (AND (CONSP |entry|)
                                     (PROGN (SETQ |sig| (CAR |entry|)) #1#)
                                     ((LAMBDA (|bfVar#57| |bfVar#56| |x|)
                                        (LOOP
                                         (COND
                                          ((OR (ATOM |bfVar#56|)
                                               (PROGN
                                                (SETQ |x| (CAR |bfVar#56|))
                                                NIL))
                                           (RETURN |bfVar#57|))
                                          (#1#
                                           (AND (CONSP |x|)
                                                (PROGN
                                                 (SETQ |ISTMP#1| (CAR |x|))
                                                 (AND (CONSP |ISTMP#1|)
                                                      (EQUAL (CAR |ISTMP#1|)
                                                             |op|)
                                                      (PROGN
                                                       (SETQ |ISTMP#2|
                                                               (CDR |ISTMP#1|))
                                                       (AND (CONSP |ISTMP#2|)
                                                            (EQUAL
                                                             (CAR |ISTMP#2|)
                                                             |sig|)))))
                                                (PROGN
                                                 (SETQ |bfVar#57| |x|)
                                                 (COND
                                                  (|bfVar#57|
                                                   (RETURN |bfVar#57|)))))))
                                         (SETQ |bfVar#56| (CDR |bfVar#56|))))
                                      NIL |datalist| NIL)
                                     (SETQ |bfVar#55|
                                             (CONS |entry| |bfVar#55|)))))
                              (SETQ |bfVar#54| (CDR |bfVar#54|))))
                           NIL |alist| NIL))
                  (COND
                   (|entryList|
                    (SETQ |acc|
                            (CONS (CONS |op| (NREVERSE |entryList|))
                                  |acc|))))))))
          (SETQ |bfVar#53| (CDR |bfVar#53|))))
       |opAlist| NIL)
      (NREVERSE |acc|)))))

; dbReduceBySignature(opAlist,op,sig) ==
; --reduces opAlist to one with a fixed op and sig
;   [[op,:[x for x in LASSOC(op,opAlist) | x is [=sig,:.]]]]

(DEFUN |dbReduceBySignature| (|opAlist| |op| |sig|)
  (PROG ()
    (RETURN
     (LIST
      (CONS |op|
            ((LAMBDA (|bfVar#59| |bfVar#58| |x|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#58|)
                      (PROGN (SETQ |x| (CAR |bfVar#58|)) NIL))
                  (RETURN (NREVERSE |bfVar#59|)))
                 ('T
                  (AND (CONSP |x|) (EQUAL (CAR |x|) |sig|)
                       (SETQ |bfVar#59| (CONS |x| |bfVar#59|)))))
                (SETQ |bfVar#58| (CDR |bfVar#58|))))
             NIL (LASSOC |op| |opAlist|) NIL))))))

; dbReduceByForm(opAlist,form) ==
;   acc := nil
;   for [op,:alist] in opAlist repeat
;     items := [x for x in alist | dbContrivedForm(op,x) = form] =>
;       acc := [[op,:items],:acc]
;   NREVERSE acc

(DEFUN |dbReduceByForm| (|opAlist| |form|)
  (PROG (|acc| |op| |alist| |items|)
    (RETURN
     (PROGN
      (SETQ |acc| NIL)
      ((LAMBDA (|bfVar#61| |bfVar#60|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#61|)
                (PROGN (SETQ |bfVar#60| (CAR |bfVar#61|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#60|)
                 (PROGN
                  (SETQ |op| (CAR |bfVar#60|))
                  (SETQ |alist| (CDR |bfVar#60|))
                  #1#)
                 (COND
                  ((SETQ |items|
                           ((LAMBDA (|bfVar#63| |bfVar#62| |x|)
                              (LOOP
                               (COND
                                ((OR (ATOM |bfVar#62|)
                                     (PROGN (SETQ |x| (CAR |bfVar#62|)) NIL))
                                 (RETURN (NREVERSE |bfVar#63|)))
                                (#1#
                                 (AND
                                  (EQUAL (|dbContrivedForm| |op| |x|) |form|)
                                  (SETQ |bfVar#63| (CONS |x| |bfVar#63|)))))
                               (SETQ |bfVar#62| (CDR |bfVar#62|))))
                            NIL |alist| NIL))
                   (IDENTITY
                    (SETQ |acc| (CONS (CONS |op| |items|) |acc|))))))))
          (SETQ |bfVar#61| (CDR |bfVar#61|))))
       |opAlist| NIL)
      (NREVERSE |acc|)))))

; dbReduceBySelection(opAlist,key,fn) ==
;   acc := nil
;   for [op,:alist] in opAlist repeat
;     items := [x for x in alist | FUNCALL(fn,x) = key] =>
;       acc := [[op,:items],:acc]
;   NREVERSE acc

(DEFUN |dbReduceBySelection| (|opAlist| |key| |fn|)
  (PROG (|acc| |op| |alist| |items|)
    (RETURN
     (PROGN
      (SETQ |acc| NIL)
      ((LAMBDA (|bfVar#65| |bfVar#64|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#65|)
                (PROGN (SETQ |bfVar#64| (CAR |bfVar#65|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#64|)
                 (PROGN
                  (SETQ |op| (CAR |bfVar#64|))
                  (SETQ |alist| (CDR |bfVar#64|))
                  #1#)
                 (COND
                  ((SETQ |items|
                           ((LAMBDA (|bfVar#67| |bfVar#66| |x|)
                              (LOOP
                               (COND
                                ((OR (ATOM |bfVar#66|)
                                     (PROGN (SETQ |x| (CAR |bfVar#66|)) NIL))
                                 (RETURN (NREVERSE |bfVar#67|)))
                                (#1#
                                 (AND (EQUAL (FUNCALL |fn| |x|) |key|)
                                      (SETQ |bfVar#67|
                                              (CONS |x| |bfVar#67|)))))
                               (SETQ |bfVar#66| (CDR |bfVar#66|))))
                            NIL |alist| NIL))
                   (IDENTITY
                    (SETQ |acc| (CONS (CONS |op| |items|) |acc|))))))))
          (SETQ |bfVar#65| (CDR |bfVar#65|))))
       |opAlist| NIL)
      (NREVERSE |acc|)))))

; dbContrivedForm(op,[sig,:.]) ==
;   dbMakeContrivedForm(op,sig)

(DEFUN |dbContrivedForm| (|op| |bfVar#68|)
  (PROG (|sig|)
    (RETURN
     (PROGN (SETQ |sig| (CAR |bfVar#68|)) (|dbMakeContrivedForm| |op| |sig|)))))

; dbMakeSignature(op,[sig,:.]) == [op,sig]  --getDomainOpTable format

(DEFUN |dbMakeSignature| (|op| |bfVar#69|)
  (PROG (|sig|)
    (RETURN (PROGN (SETQ |sig| (CAR |bfVar#69|)) (LIST |op| |sig|)))))

; dbGetOrigin(op,[.,.,origin,:.]) == origin

(DEFUN |dbGetOrigin| (|op| |bfVar#70|)
  (PROG (|origin|)
    (RETURN (PROGN (SETQ |origin| (CADDR |bfVar#70|)) |origin|))))

; dbGetCondition(op,[.,pred,:.]) == pred

(DEFUN |dbGetCondition| (|op| |bfVar#71|)
  (PROG (|pred|) (RETURN (PROGN (SETQ |pred| (CADR |bfVar#71|)) |pred|))))

; dbShowOpNames(htPage,opAlist,which,data) ==
;   single? := opAlist and null rest data
;   single? =>
;     ops := escapeSpecialChars STRINGIMAGE CAAR opAlist
;     htSayStandard('"Select a view below")
;   exposedOnly? := $exposedOnlyIfTrue and not dbFromConstructor?(htPage)
;   dbShowOpItems(which,data,exposedOnly?)

(DEFUN |dbShowOpNames| (|htPage| |opAlist| |which| |data|)
  (PROG (|single?| |ops| |exposedOnly?|)
    (RETURN
     (PROGN
      (SETQ |single?| (AND |opAlist| (NULL (CDR |data|))))
      (COND
       (|single?|
        (PROGN
         (SETQ |ops| (|escapeSpecialChars| (STRINGIMAGE (CAAR |opAlist|))))
         (|htSayStandard| "Select a view below")))
       ('T
        (PROGN
         (SETQ |exposedOnly?|
                 (AND |$exposedOnlyIfTrue|
                      (NULL (|dbFromConstructor?| |htPage|))))
         (|dbShowOpItems| |which| |data| |exposedOnly?|))))))))

; dbShowOpItems(which,data,exposedOnly?) ==
;   htBeginTable()
;   for i in 0.. for item in data repeat
;     if atom item then
;       op := item
;       exposeFlag := true
;     else
;       [op,exposeFlag] := item
;     ops := escapeSpecialChars STRINGIMAGE op
;     exposeFlag or not exposedOnly? =>
;       htSay('"{")
;       bcStarSpaceOp(ops,exposeFlag)
;       htMakePage [['bcLinks,[ops,'"",'dbShowOps,which,i]]]
;       htSay('"}")
;   htEndTable()

(DEFUN |dbShowOpItems| (|which| |data| |exposedOnly?|)
  (PROG (|op| |exposeFlag| |ops|)
    (RETURN
     (PROGN
      (|htBeginTable|)
      ((LAMBDA (|i| |bfVar#72| |item|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#72|) (PROGN (SETQ |item| (CAR |bfVar#72|)) NIL))
            (RETURN NIL))
           (#1='T
            (PROGN
             (COND ((ATOM |item|) (SETQ |op| |item|) (SETQ |exposeFlag| T))
                   (#1# (SETQ |op| (CAR |item|))
                    (SETQ |exposeFlag| (CADR |item|)) |item|))
             (SETQ |ops| (|escapeSpecialChars| (STRINGIMAGE |op|)))
             (COND
              ((OR |exposeFlag| (NULL |exposedOnly?|))
               (PROGN
                (|htSay| "{")
                (|bcStarSpaceOp| |ops| |exposeFlag|)
                (|htMakePage|
                 (LIST
                  (LIST '|bcLinks| (LIST |ops| "" '|dbShowOps| |which| |i|))))
                (|htSay| "}")))))))
          (SETQ |i| (+ |i| 1))
          (SETQ |bfVar#72| (CDR |bfVar#72|))))
       0 |data| NIL)
      (|htEndTable|)))))

; dbShowOpAllDomains(htPage,opAlist,which) ==
;   SAY("dbShowOpAllDomains")
;   BREAK()
;   dbExpandOpAlistIfNecessary(htPage,opAlist,which,true,false)
;   catOriginAlist := nil --list of category origins
;   domOriginAlist := nil --list of domain origins
;   for [op,:items] in opAlist repeat
;     for [.,predicate,origin,:.] in items repeat
;       conname := first origin
;       GETDATABASE(conname,'CONSTRUCTORKIND) = 'category =>
;         pred := simpOrDumb(predicate, QLASSQ(conname, catOriginAlist) or true)
;         catOriginAlist := insertAlist(conname,pred,catOriginAlist)
;       pred := simpOrDumb(predicate, QLASSQ(conname, domOriginAlist) or true)
;       domOriginAlist := insertAlist(conname,pred,domOriginAlist)
;   --the following is similar to "domainsOf" but do not sort immediately
;   u := [COPY key for key in HKEYS($has_category_hash)
;           | QLASSQ(rest key, catOriginAlist)]
;   for pair in u repeat
;     [dom,:cat] := pair
;     QLASSQ(cat, catOriginAlist) = 'etc => RPLACD(pair, 'etc)
;     RPLACD(pair,simpOrDumb(GETDATABASE(pair,'HASCATEGORY),true))
;   --now add all of the domains
;   for [dom,:pred] in domOriginAlist repeat
;     u := insertAlist(dom, simpOrDumb(pred, QLASSQ(dom, u) or true), u)
;   cAlist := listSort(function GLESSEQP,u)
;   for pair in cAlist repeat RPLACA(pair,getConstructorForm first pair)
;   htpSetProperty(htPage,'cAlist,cAlist)
;   htpSetProperty(htPage,'thing,'"constructor")
;   htpSetProperty(htPage,'specialHeading,'"hoho")
;   dbShowCons(htPage,'names)

(DEFUN |dbShowOpAllDomains| (|htPage| |opAlist| |which|)
  (PROG (|catOriginAlist| |domOriginAlist| |op| |items| |ISTMP#1| |predicate|
         |ISTMP#2| |origin| |conname| |pred| |u| |dom| |cat| |cAlist|)
    (RETURN
     (PROGN
      (SAY '|dbShowOpAllDomains|)
      (BREAK)
      (|dbExpandOpAlistIfNecessary| |htPage| |opAlist| |which| T NIL)
      (SETQ |catOriginAlist| NIL)
      (SETQ |domOriginAlist| NIL)
      ((LAMBDA (|bfVar#74| |bfVar#73|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#74|)
                (PROGN (SETQ |bfVar#73| (CAR |bfVar#74|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#73|)
                 (PROGN
                  (SETQ |op| (CAR |bfVar#73|))
                  (SETQ |items| (CDR |bfVar#73|))
                  #1#)
                 ((LAMBDA (|bfVar#76| |bfVar#75|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#76|)
                           (PROGN (SETQ |bfVar#75| (CAR |bfVar#76|)) NIL))
                       (RETURN NIL))
                      (#1#
                       (AND (CONSP |bfVar#75|)
                            (PROGN
                             (SETQ |ISTMP#1| (CDR |bfVar#75|))
                             (AND (CONSP |ISTMP#1|)
                                  (PROGN
                                   (SETQ |predicate| (CAR |ISTMP#1|))
                                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                   (AND (CONSP |ISTMP#2|)
                                        (PROGN
                                         (SETQ |origin| (CAR |ISTMP#2|))
                                         #1#)))))
                            (PROGN
                             (SETQ |conname| (CAR |origin|))
                             (COND
                              ((EQ (GETDATABASE |conname| 'CONSTRUCTORKIND)
                                   '|category|)
                               (PROGN
                                (SETQ |pred|
                                        (|simpOrDumb| |predicate|
                                         (OR
                                          (QLASSQ |conname| |catOriginAlist|)
                                          T)))
                                (SETQ |catOriginAlist|
                                        (|insertAlist| |conname| |pred|
                                         |catOriginAlist|))))
                              (#1#
                               (PROGN
                                (SETQ |pred|
                                        (|simpOrDumb| |predicate|
                                         (OR
                                          (QLASSQ |conname| |domOriginAlist|)
                                          T)))
                                (SETQ |domOriginAlist|
                                        (|insertAlist| |conname| |pred|
                                         |domOriginAlist|)))))))))
                     (SETQ |bfVar#76| (CDR |bfVar#76|))))
                  |items| NIL))))
          (SETQ |bfVar#74| (CDR |bfVar#74|))))
       |opAlist| NIL)
      (SETQ |u|
              ((LAMBDA (|bfVar#78| |bfVar#77| |key|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#77|)
                        (PROGN (SETQ |key| (CAR |bfVar#77|)) NIL))
                    (RETURN (NREVERSE |bfVar#78|)))
                   (#1#
                    (AND (QLASSQ (CDR |key|) |catOriginAlist|)
                         (SETQ |bfVar#78| (CONS (COPY |key|) |bfVar#78|)))))
                  (SETQ |bfVar#77| (CDR |bfVar#77|))))
               NIL (HKEYS |$has_category_hash|) NIL))
      ((LAMBDA (|bfVar#79| |pair|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#79|) (PROGN (SETQ |pair| (CAR |bfVar#79|)) NIL))
            (RETURN NIL))
           (#1#
            (PROGN
             (SETQ |dom| (CAR |pair|))
             (SETQ |cat| (CDR |pair|))
             (COND
              ((EQ (QLASSQ |cat| |catOriginAlist|) '|etc|)
               (RPLACD |pair| '|etc|))
              (#1#
               (RPLACD |pair|
                       (|simpOrDumb| (GETDATABASE |pair| 'HASCATEGORY) T)))))))
          (SETQ |bfVar#79| (CDR |bfVar#79|))))
       |u| NIL)
      ((LAMBDA (|bfVar#81| |bfVar#80|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#81|)
                (PROGN (SETQ |bfVar#80| (CAR |bfVar#81|)) NIL))
            (RETURN NIL))
           (#1#
            (AND (CONSP |bfVar#80|)
                 (PROGN
                  (SETQ |dom| (CAR |bfVar#80|))
                  (SETQ |pred| (CDR |bfVar#80|))
                  #1#)
                 (SETQ |u|
                         (|insertAlist| |dom|
                          (|simpOrDumb| |pred| (OR (QLASSQ |dom| |u|) T))
                          |u|)))))
          (SETQ |bfVar#81| (CDR |bfVar#81|))))
       |domOriginAlist| NIL)
      (SETQ |cAlist| (|listSort| #'GLESSEQP |u|))
      ((LAMBDA (|bfVar#82| |pair|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#82|) (PROGN (SETQ |pair| (CAR |bfVar#82|)) NIL))
            (RETURN NIL))
           (#1# (RPLACA |pair| (|getConstructorForm| (CAR |pair|)))))
          (SETQ |bfVar#82| (CDR |bfVar#82|))))
       |cAlist| NIL)
      (|htpSetProperty| |htPage| '|cAlist| |cAlist|)
      (|htpSetProperty| |htPage| '|thing| "constructor")
      (|htpSetProperty| |htPage| '|specialHeading| "hoho")
      (|dbShowCons| |htPage| '|names|)))))

; simpOrDumb(new,old) ==
;   new = 'etc => 'etc
;   atom new => old
;   'etc

(DEFUN |simpOrDumb| (|new| |old|)
  (PROG ()
    (RETURN
     (COND ((EQ |new| '|etc|) '|etc|) ((ATOM |new|) |old|) ('T '|etc|)))))

; dbShowOpOrigins(htPage,opAlist,which,data) ==
;   dbGatherThenShow(htPage,opAlist,which,data,true,'"from",function bcStarConform)

(DEFUN |dbShowOpOrigins| (|htPage| |opAlist| |which| |data|)
  (PROG ()
    (RETURN
     (|dbGatherThenShow| |htPage| |opAlist| |which| |data| T "from"
      #'|bcStarConform|))))

; dbShowOpImplementations(htPage,opAlist,which,data) ==
;     $from_show_implementations : local := true
;     dbGatherThenShow(htPage, opAlist, which, data, true, '"by",
;                      function bcStarConform)

(DEFUN |dbShowOpImplementations| (|htPage| |opAlist| |which| |data|)
  (PROG (|$from_show_implementations|)
    (DECLARE (SPECIAL |$from_show_implementations|))
    (RETURN
     (PROGN
      (SETQ |$from_show_implementations| T)
      (|dbGatherThenShow| |htPage| |opAlist| |which| |data| T "by"
       #'|bcStarConform|)))))

; dbShowOpConditions(htPage,opAlist,which,data) ==
;   dbGatherThenShow(htPage,opAlist,which,data,nil,nil,function bcPred)

(DEFUN |dbShowOpConditions| (|htPage| |opAlist| |which| |data|)
  (PROG ()
    (RETURN
     (|dbGatherThenShow| |htPage| |opAlist| |which| |data| NIL NIL
      #'|bcPred|))))

; dbShowKind conform ==
;   conname := first conform
;   kind := GETDATABASE(conname,'CONSTRUCTORKIND)
;   kind = 'domain =>
;     (s := PNAME conname).(MAXINDEX s) = '_& => '"default package"
;     '"domain"
;   PNAME kind

(DEFUN |dbShowKind| (|conform|)
  (PROG (|conname| |kind| |s|)
    (RETURN
     (PROGN
      (SETQ |conname| (CAR |conform|))
      (SETQ |kind| (GETDATABASE |conname| 'CONSTRUCTORKIND))
      (COND
       ((EQ |kind| '|domain|)
        (COND
         ((EQ (ELT (SETQ |s| (PNAME |conname|)) (MAXINDEX |s|)) '&)
          "default package")
         (#1='T "domain")))
       (#1# (PNAME |kind|)))))))

; dbShowOpSignatures(htPage,opAlist,which,data) == dbShowOpSigList(which,data,0)

(DEFUN |dbShowOpSignatures| (|htPage| |opAlist| |which| |data|)
  (PROG () (RETURN (|dbShowOpSigList| |which| |data| 0))))

; dbShowOpSigList(which,dataItems,count) ==
; --dataItems is (((op,sig,:.),exposureFlag,...)
;   which ~= '"operation" => BREAK()
;   single? := null rest dataItems
;   htBeginTable()
;   for [[op,sig,:.],exposureFlag,:tail] in dataItems repeat
;     ops := escapeSpecialChars STRINGIMAGE op
;     htSay '"{"
;     htSayExpose(ops,exposureFlag)
;     htMakePage [['bcLinks,[ops,'"",'dbShowOps,which,count]]]
;     htSay '": "
;     if tail = 'ASCONST then
;         bcConform(first(sig))
;     else
;         bcConform(['Mapping, :sig])
;     htSay '"}"
;     count := count + 1
;   htEndTable()
;   count

(DEFUN |dbShowOpSigList| (|which| |dataItems| |count|)
  (PROG (|single?| |ISTMP#1| |op| |ISTMP#2| |sig| |ISTMP#3| |exposureFlag|
         |tail| |ops|)
    (RETURN
     (COND ((NOT (EQUAL |which| "operation")) (BREAK))
           (#1='T
            (PROGN
             (SETQ |single?| (NULL (CDR |dataItems|)))
             (|htBeginTable|)
             ((LAMBDA (|bfVar#84| |bfVar#83|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#84|)
                       (PROGN (SETQ |bfVar#83| (CAR |bfVar#84|)) NIL))
                   (RETURN NIL))
                  (#1#
                   (AND (CONSP |bfVar#83|)
                        (PROGN
                         (SETQ |ISTMP#1| (CAR |bfVar#83|))
                         (AND (CONSP |ISTMP#1|)
                              (PROGN
                               (SETQ |op| (CAR |ISTMP#1|))
                               (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                               (AND (CONSP |ISTMP#2|)
                                    (PROGN
                                     (SETQ |sig| (CAR |ISTMP#2|))
                                     #1#)))))
                        (PROGN
                         (SETQ |ISTMP#3| (CDR |bfVar#83|))
                         (AND (CONSP |ISTMP#3|)
                              (PROGN
                               (SETQ |exposureFlag| (CAR |ISTMP#3|))
                               (SETQ |tail| (CDR |ISTMP#3|))
                               #1#)))
                        (PROGN
                         (SETQ |ops| (|escapeSpecialChars| (STRINGIMAGE |op|)))
                         (|htSay| "{")
                         (|htSayExpose| |ops| |exposureFlag|)
                         (|htMakePage|
                          (LIST
                           (LIST '|bcLinks|
                                 (LIST |ops| "" '|dbShowOps| |which|
                                       |count|))))
                         (|htSay| ": ")
                         (COND ((EQ |tail| 'ASCONST) (|bcConform| (CAR |sig|)))
                               (#1# (|bcConform| (CONS '|Mapping| |sig|))))
                         (|htSay| "}")
                         (SETQ |count| (+ |count| 1))))))
                 (SETQ |bfVar#84| (CDR |bfVar#84|))))
              |dataItems| NIL)
             (|htEndTable|)
             |count|))))))

; dbShowOpParameters(htPage,opAlist,which,data) ==
;   single? := null rest data
;   count := 0
;   htBeginTable()
;   for item in data repeat
;     [opform,exposeFlag,:tail] := item
;     op := intern IFCAR opform
;     args := IFCDR opform
;     ops := escapeSpecialChars STRINGIMAGE op
;     htSay '"{"
;     htSayExpose(ops,exposeFlag)
;     n := #opform
;     do
;       n = 2 and GETL(op, 'Nud) =>
;         dbShowOpParameterJump(ops,which,count,single?)
;         htSayList(['" {\em ", IFCAR args, '"}"])
;       n = 3 and GETL(op, 'Led) =>
;         htSayList(['"{\em ", IFCAR args, '"} "])
;         dbShowOpParameterJump(ops,which,count,single?)
;         htSayList(['" {\em ", IFCAR IFCDR args, '"}"])
;       dbShowOpParameterJump(ops,which,count,single?)
;       which = '"attribute" => BREAK()
;       tail = 'ASCONST or member(op,'(0 1)) => 'skip
;       htSay('"(")
;       if IFCAR args then htSayList(['"{\em ", IFCAR args, '"}"])
;       for x in IFCDR args repeat
;         htSayList(['", {\em ", x, '"}"])
;       htSay('")")
;     htSay '"}"
;     count := count + 1
;   htEndTable()

(DEFUN |dbShowOpParameters| (|htPage| |opAlist| |which| |data|)
  (PROG (|single?| |count| |opform| |exposeFlag| |tail| |op| |args| |ops| |n|)
    (RETURN
     (PROGN
      (SETQ |single?| (NULL (CDR |data|)))
      (SETQ |count| 0)
      (|htBeginTable|)
      ((LAMBDA (|bfVar#85| |item|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#85|) (PROGN (SETQ |item| (CAR |bfVar#85|)) NIL))
            (RETURN NIL))
           (#1='T
            (PROGN
             (SETQ |opform| (CAR |item|))
             (SETQ |exposeFlag| (CADR . #2=(|item|)))
             (SETQ |tail| (CDDR . #2#))
             (SETQ |op| (|intern| (IFCAR |opform|)))
             (SETQ |args| (IFCDR |opform|))
             (SETQ |ops| (|escapeSpecialChars| (STRINGIMAGE |op|)))
             (|htSay| "{")
             (|htSayExpose| |ops| |exposeFlag|)
             (SETQ |n| (LENGTH |opform|))
             (|do|
              (COND
               ((AND (EQL |n| 2) (GETL |op| '|Nud|))
                (PROGN
                 (|dbShowOpParameterJump| |ops| |which| |count| |single?|)
                 (|htSayList| (LIST " {\\em " (IFCAR |args|) "}"))))
               ((AND (EQL |n| 3) (GETL |op| '|Led|))
                (PROGN
                 (|htSayList| (LIST "{\\em " (IFCAR |args|) "} "))
                 (|dbShowOpParameterJump| |ops| |which| |count| |single?|)
                 (|htSayList| (LIST " {\\em " (IFCAR (IFCDR |args|)) "}"))))
               (#1#
                (PROGN
                 (|dbShowOpParameterJump| |ops| |which| |count| |single?|)
                 (COND ((EQUAL |which| "attribute") (BREAK))
                       ((OR (EQ |tail| 'ASCONST) (|member| |op| '(0 1)))
                        '|skip|)
                       (#1#
                        (PROGN
                         (|htSay| "(")
                         (COND
                          ((IFCAR |args|)
                           (|htSayList| (LIST "{\\em " (IFCAR |args|) "}"))))
                         ((LAMBDA (|bfVar#86| |x|)
                            (LOOP
                             (COND
                              ((OR (ATOM |bfVar#86|)
                                   (PROGN (SETQ |x| (CAR |bfVar#86|)) NIL))
                               (RETURN NIL))
                              (#1# (|htSayList| (LIST ", {\\em " |x| "}"))))
                             (SETQ |bfVar#86| (CDR |bfVar#86|))))
                          (IFCDR |args|) NIL)
                         (|htSay| ")"))))))))
             (|htSay| "}")
             (SETQ |count| (+ |count| 1)))))
          (SETQ |bfVar#85| (CDR |bfVar#85|))))
       |data| NIL)
      (|htEndTable|)))))

; dbShowOpParameterJump(ops,which,count,single?) ==
;   single? => htSayList(['"{\em ", ops, '"}"])
;   htMakePage [['bcLinks,[ops,'"",'dbShowOps,which,count]]]

(DEFUN |dbShowOpParameterJump| (|ops| |which| |count| |single?|)
  (PROG ()
    (RETURN
     (COND (|single?| (|htSayList| (LIST "{\\em " |ops| "}")))
           ('T
            (|htMakePage|
             (LIST
              (LIST '|bcLinks|
                    (LIST |ops| "" '|dbShowOps| |which| |count|)))))))))

; dbShowOpDocumentation(htPage,opAlist,which,data) ==
;   which ~= '"operation" => BREAK()
;   if $exposedOnlyIfTrue and not dbFromConstructor?(htPage) then
;       opAlist := htpProperty(htPage, 'opAlist)
;   conform := htpProperty(htPage, 'domname) or htpProperty(htPage, 'conform)
;   expand := dbExpandOpAlistIfNecessary(htPage,opAlist,which,true,false)
;   if expand then
;     condata := dbGatherData(htPage,opAlist,which,'conditions)
;     htpSetProperty(htPage,'conditionData,condata)
;   base := -8192
;   exactlyOneOpSig := opAlist is [[.,.]] --checked by displayDomainOp
;   for [op,:alist] in opAlist repeat
;     base := 8192 + base
;     for item in alist for j in 0.. repeat
;       [sig,predicate,origin,exposeFlag,comments] := item
;       exposeFlag or not $exposedOnlyIfTrue =>
;         if comments ~= '"" and STRINGP comments and (k := string2Integer comments) then
;           comments :=
;             MEMQ(k,'(0 1)) => '""
;             dbReadComments k
;           tail := CDDDDR item
;           RPLACA(tail,comments)
;         doc := (STRINGP comments and comments ~= '"" => comments; nil)
;         pred := predicate or true
;         index := (exactlyOneOpSig => nil; base + j)
;         displayDomainOp(htPage, '"operation", origin, op, sig, pred,
;                         doc, index, 'dbChooseDomainOp, null(exposeFlag), true)

(DEFUN |dbShowOpDocumentation| (|htPage| |opAlist| |which| |data|)
  (PROG (|conform| |expand| |condata| |base| |ISTMP#1| |ISTMP#2|
         |exactlyOneOpSig| |op| |alist| |sig| |predicate| |origin| |exposeFlag|
         |comments| |k| |tail| |doc| |pred| |index|)
    (RETURN
     (COND ((NOT (EQUAL |which| "operation")) (BREAK))
           (#1='T
            (PROGN
             (COND
              ((AND |$exposedOnlyIfTrue|
                    (NULL (|dbFromConstructor?| |htPage|)))
               (SETQ |opAlist| (|htpProperty| |htPage| '|opAlist|))))
             (SETQ |conform|
                     (OR (|htpProperty| |htPage| '|domname|)
                         (|htpProperty| |htPage| '|conform|)))
             (SETQ |expand|
                     (|dbExpandOpAlistIfNecessary| |htPage| |opAlist| |which| T
                      NIL))
             (COND
              (|expand|
               (SETQ |condata|
                       (|dbGatherData| |htPage| |opAlist| |which|
                        '|conditions|))
               (|htpSetProperty| |htPage| '|conditionData| |condata|)))
             (SETQ |base| (- 8192))
             (SETQ |exactlyOneOpSig|
                     (AND (CONSP |opAlist|) (EQ (CDR |opAlist|) NIL)
                          (PROGN
                           (SETQ |ISTMP#1| (CAR |opAlist|))
                           (AND (CONSP |ISTMP#1|)
                                (PROGN
                                 (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                 (AND (CONSP |ISTMP#2|)
                                      (EQ (CDR |ISTMP#2|) NIL)))))))
             ((LAMBDA (|bfVar#88| |bfVar#87|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#88|)
                       (PROGN (SETQ |bfVar#87| (CAR |bfVar#88|)) NIL))
                   (RETURN NIL))
                  (#1#
                   (AND (CONSP |bfVar#87|)
                        (PROGN
                         (SETQ |op| (CAR |bfVar#87|))
                         (SETQ |alist| (CDR |bfVar#87|))
                         #1#)
                        (PROGN
                         (SETQ |base| (+ 8192 |base|))
                         ((LAMBDA (|bfVar#89| |item| |j|)
                            (LOOP
                             (COND
                              ((OR (ATOM |bfVar#89|)
                                   (PROGN (SETQ |item| (CAR |bfVar#89|)) NIL))
                               (RETURN NIL))
                              (#1#
                               (PROGN
                                (SETQ |sig| (CAR |item|))
                                (SETQ |predicate| (CADR . #2=(|item|)))
                                (SETQ |origin| (CADDR . #2#))
                                (SETQ |exposeFlag| (CADDDR . #2#))
                                (SETQ |comments| (CAR (CDDDDR . #2#)))
                                (COND
                                 ((OR |exposeFlag| (NULL |$exposedOnlyIfTrue|))
                                  (PROGN
                                   (COND
                                    ((AND (NOT (EQUAL |comments| ""))
                                          (STRINGP |comments|)
                                          (SETQ |k|
                                                  (|string2Integer|
                                                   |comments|)))
                                     (SETQ |comments|
                                             (COND ((MEMQ |k| '(0 1)) "")
                                                   (#1#
                                                    (|dbReadComments| |k|))))
                                     (SETQ |tail| (CDDDDR |item|))
                                     (RPLACA |tail| |comments|)))
                                   (SETQ |doc|
                                           (COND
                                            ((AND (STRINGP |comments|)
                                                  (NOT (EQUAL |comments| "")))
                                             |comments|)
                                            (#1# NIL)))
                                   (SETQ |pred| (OR |predicate| T))
                                   (SETQ |index|
                                           (COND (|exactlyOneOpSig| NIL)
                                                 (#1# (+ |base| |j|))))
                                   (|displayDomainOp| |htPage| "operation"
                                    |origin| |op| |sig| |pred| |doc| |index|
                                    '|dbChooseDomainOp| (NULL |exposeFlag|)
                                    T)))))))
                             (SETQ |bfVar#89| (CDR |bfVar#89|))
                             (SETQ |j| (+ |j| 1))))
                          |alist| NIL 0)))))
                 (SETQ |bfVar#88| (CDR |bfVar#88|))))
              |opAlist| NIL)))))))

; dbChooseDomainOp(htPage,which,index) ==
;   which ~= '"operation" => BREAK()
;   [opKey,entryKey] := DIVIDE(index,8192)
;   opAlist :=
;     which = '"operation" => htpProperty(htPage,'opAlist)
;     htpProperty(htPage,'attrAlist)
;   [op,:entries] := opAlist . opKey
;   entry := entries . entryKey
;   htPage := htInitPageNoHeading(htCopyProplist(htPage))
;   if which = '"operation"
;     then htpSetProperty(htPage,'opAlist,[[op,entry]])
;     else htpSetProperty(htPage,'attrAlist,[[op,entry]])
;   if not (htpProperty(htPage, 'condition?) = 'no) then
;     dbResetOpAlistCondition(htPage,which,opAlist)
;   dbShowOps(htPage,which,'documentation)

(DEFUN |dbChooseDomainOp| (|htPage| |which| |index|)
  (PROG (|LETTMP#1| |opKey| |entryKey| |opAlist| |op| |entries| |entry|)
    (RETURN
     (COND ((NOT (EQUAL |which| "operation")) (BREAK))
           (#1='T
            (PROGN
             (SETQ |LETTMP#1| (DIVIDE |index| 8192))
             (SETQ |opKey| (CAR |LETTMP#1|))
             (SETQ |entryKey| (CADR |LETTMP#1|))
             (SETQ |opAlist|
                     (COND
                      ((EQUAL |which| "operation")
                       (|htpProperty| |htPage| '|opAlist|))
                      (#1# (|htpProperty| |htPage| '|attrAlist|))))
             (SETQ |LETTMP#1| (ELT |opAlist| |opKey|))
             (SETQ |op| (CAR |LETTMP#1|))
             (SETQ |entries| (CDR |LETTMP#1|))
             (SETQ |entry| (ELT |entries| |entryKey|))
             (SETQ |htPage|
                     (|htInitPageNoHeading| (|htCopyProplist| |htPage|)))
             (COND
              ((EQUAL |which| "operation")
               (|htpSetProperty| |htPage| '|opAlist|
                (LIST (LIST |op| |entry|))))
              (#1#
               (|htpSetProperty| |htPage| '|attrAlist|
                (LIST (LIST |op| |entry|)))))
             (COND
              ((NULL (EQ (|htpProperty| |htPage| '|condition?|) '|no|))
               (|dbResetOpAlistCondition| |htPage| |which| |opAlist|)))
             (|dbShowOps| |htPage| |which| '|documentation|)))))))

; htSayExpose(op, flag) ==
;   $includeUnexposed? =>
;     flag => htBlank()
;     op.0 = char '_* => htSay '"{\em *} "
;     htSayUnexposed()
;   htSay '""

(DEFUN |htSayExpose| (|op| |flag|)
  (PROG ()
    (RETURN
     (COND
      (|$includeUnexposed?|
       (COND (|flag| (|htBlank|))
             ((EQUAL (ELT |op| 0) (|char| '*)) (|htSay| "{\\em *} "))
             (#1='T (|htSayUnexposed|))))
      (#1# (|htSay| ""))))))

; dbShowOperationsFromConform(htPage,which,opAlist) ==  --branch in with lists
;   which ~= '"operation" => BREAK()
;   $groupChoice := nil
;   conform := htpProperty(htPage,'conform)
;   --prepare opAlist for possible filtering of groups
;   if null BOUNDP '$topicHash then
;     $topicHash := MAKE_HASHTABLE('ID)
;     for [x,:c] in '((extended . 0) (basic . 1) (hidden . 2)) repeat
;       HPUT($topicHash,x,c)
;   domform := htpProperty(htPage,'domname)
;   if htpProperty(htPage, 'kind) = '"category" then
;       domform := false
;   if domform then
;     $conformsAreDomains : local := true
;     opAlist := reduceOpAlistForDomain(opAlist, domform, conform)
;   conform := domform or conform
;   kind := capitalize htpProperty(htPage,'kind)
;   exposePart :=
;     isExposedConstructor opOf conform => '""
;     '" Unexposed "
;   fromPart :=
;     domform => evalableConstructor2HtString domform
;     form2HtString conform
;   heading :=
;     ['" from ",exposePart,kind,'" {\em ",fromPart,'"}"]
;   htpSetProperty(htPage, 'expandOperations, 'lists)
;   htpSetProperty(htPage,'fromHeading,heading)
;   reducedOpAlist := reduceByGroup(htPage, opAlist)
;   htpSetProperty(htPage, 'principalOpAlist, opAlist)
;   htpSetProperty(htPage, 'opAlist, reducedOpAlist)
;   if domform
;    then htpSetProperty(htPage,'condition?,'no)
;    else dbResetOpAlistCondition(htPage,which,opAlist)
;   dbShowOp1(htPage,reducedOpAlist,which,'names)

(DEFUN |dbShowOperationsFromConform| (|htPage| |which| |opAlist|)
  (PROG (|$conformsAreDomains| |reducedOpAlist| |heading| |fromPart|
         |exposePart| |kind| |domform| |c| |x| |conform|)
    (DECLARE (SPECIAL |$conformsAreDomains|))
    (RETURN
     (COND ((NOT (EQUAL |which| "operation")) (BREAK))
           (#1='T
            (PROGN
             (SETQ |$groupChoice| NIL)
             (SETQ |conform| (|htpProperty| |htPage| '|conform|))
             (COND
              ((NULL (BOUNDP '|$topicHash|))
               (SETQ |$topicHash| (MAKE_HASHTABLE 'ID))
               ((LAMBDA (|bfVar#91| |bfVar#90|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#91|)
                         (PROGN (SETQ |bfVar#90| (CAR |bfVar#91|)) NIL))
                     (RETURN NIL))
                    (#1#
                     (AND (CONSP |bfVar#90|)
                          (PROGN
                           (SETQ |x| (CAR |bfVar#90|))
                           (SETQ |c| (CDR |bfVar#90|))
                           #1#)
                          (HPUT |$topicHash| |x| |c|))))
                   (SETQ |bfVar#91| (CDR |bfVar#91|))))
                '((|extended| . 0) (|basic| . 1) (|hidden| . 2)) NIL)))
             (SETQ |domform| (|htpProperty| |htPage| '|domname|))
             (COND
              ((EQUAL (|htpProperty| |htPage| '|kind|) "category")
               (SETQ |domform| NIL)))
             (COND
              (|domform| (SETQ |$conformsAreDomains| T)
               (SETQ |opAlist|
                       (|reduceOpAlistForDomain| |opAlist| |domform|
                        |conform|))))
             (SETQ |conform| (OR |domform| |conform|))
             (SETQ |kind| (|capitalize| (|htpProperty| |htPage| '|kind|)))
             (SETQ |exposePart|
                     (COND ((|isExposedConstructor| (|opOf| |conform|)) "")
                           (#1# " Unexposed ")))
             (SETQ |fromPart|
                     (COND
                      (|domform| (|evalableConstructor2HtString| |domform|))
                      (#1# (|form2HtString| |conform|))))
             (SETQ |heading|
                     (LIST " from " |exposePart| |kind| " {\\em " |fromPart|
                           "}"))
             (|htpSetProperty| |htPage| '|expandOperations| '|lists|)
             (|htpSetProperty| |htPage| '|fromHeading| |heading|)
             (SETQ |reducedOpAlist| (|reduceByGroup| |htPage| |opAlist|))
             (|htpSetProperty| |htPage| '|principalOpAlist| |opAlist|)
             (|htpSetProperty| |htPage| '|opAlist| |reducedOpAlist|)
             (COND (|domform| (|htpSetProperty| |htPage| '|condition?| '|no|))
                   (#1#
                    (|dbResetOpAlistCondition| |htPage| |which| |opAlist|)))
             (|dbShowOp1| |htPage| |reducedOpAlist| |which| '|names|)))))))

; reduceOpAlistForDomain(opAlist,domform,conform) ==
; --destructively simplify all predicates; filter out any that fail
;   form1 := [domform,:rest domform]
;   form2 := ['$,:rest conform]
;   new_opAlist := []
;   for pair in opAlist repeat
;     n_items := [test for item in rest pair | test] where test ==
;       [head,:tail] := item
;       first tail = true => item
;       pred := simpHasPred SUBLISLIS(form1,form2,QCAR tail)
;       null pred => false
;       RPLACD(item,[pred])
;       item
;     if not(null(n_items)) then
;         n_pair := cons(first(pair), n_items)
;         new_opAlist := cons(n_pair, new_opAlist)
;   NREVERSE(new_opAlist)

(DEFUN |reduceOpAlistForDomain| (|opAlist| |domform| |conform|)
  (PROG (|form1| |form2| |new_opAlist| |head| |tail| |pred| |n_items| |n_pair|)
    (RETURN
     (PROGN
      (SETQ |form1| (CONS |domform| (CDR |domform|)))
      (SETQ |form2| (CONS '$ (CDR |conform|)))
      (SETQ |new_opAlist| NIL)
      ((LAMBDA (|bfVar#92| |pair|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#92|) (PROGN (SETQ |pair| (CAR |bfVar#92|)) NIL))
            (RETURN NIL))
           (#1='T
            (PROGN
             (SETQ |n_items|
                     ((LAMBDA (|bfVar#94| |bfVar#93| |item|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#93|)
                               (PROGN (SETQ |item| (CAR |bfVar#93|)) NIL))
                           (RETURN (NREVERSE |bfVar#94|)))
                          (#1#
                           (AND
                            #2=(PROGN
                                (SETQ |head| (CAR |item|))
                                (SETQ |tail| (CDR |item|))
                                (COND ((EQUAL (CAR |tail|) T) |item|)
                                      (#1#
                                       (PROGN
                                        (SETQ |pred|
                                                (|simpHasPred|
                                                 (SUBLISLIS |form1| |form2|
                                                  (QCAR |tail|))))
                                        (COND ((NULL |pred|) NIL)
                                              (#1#
                                               (PROGN
                                                (RPLACD |item| (LIST |pred|))
                                                |item|)))))))
                            (SETQ |bfVar#94| (CONS #2# |bfVar#94|)))))
                         (SETQ |bfVar#93| (CDR |bfVar#93|))))
                      NIL (CDR |pair|) NIL))
             (COND
              ((NULL (NULL |n_items|))
               (SETQ |n_pair| (CONS (CAR |pair|) |n_items|))
               (SETQ |new_opAlist| (CONS |n_pair| |new_opAlist|)))))))
          (SETQ |bfVar#92| (CDR |bfVar#92|))))
       |opAlist| NIL)
      (NREVERSE |new_opAlist|)))))

; dbShowOperationLines(which,linelist) ==  --branch in with lines
;   which ~= '"operation" => BREAK()
;   htPage := htInitPage(nil,nil)  --create empty page
;   opAlist := nil
;   lines := linelist
;   while lines repeat
;     name := dbName (x := first lines)
;     pile := [x]
;     while (lines := rest lines) and name = dbName (x := first lines) repeat
;       pile := [x,:pile]
;     opAlist := [[name,:NREVERSE pile],:opAlist]
;   -- sorting list of pairs (String, List(String))
;   opAlist := listSort(function LEXLESSEQP,NREVERSE opAlist)
;   if which = '"operation"
;     then htpSetProperty(htPage,'opAlist,opAlist)
;     else htpSetProperty(htPage,'attrAlist,opAlist)
;   expandProperty :=
;     which = '"operation" => 'expandOperations
;     'expandAttributes
;   htpSetProperty(htPage,expandProperty,'strings)
;   dbResetOpAlistCondition(htPage,which,opAlist)
;   if which = '"attribute" then BREAK()
;   dbShowOp1(htPage,opAlist,which,'names)

(DEFUN |dbShowOperationLines| (|which| |linelist|)
  (PROG (|htPage| |opAlist| |lines| |x| |name| |pile| |expandProperty|)
    (RETURN
     (COND ((NOT (EQUAL |which| "operation")) (BREAK))
           (#1='T
            (PROGN
             (SETQ |htPage| (|htInitPage| NIL NIL))
             (SETQ |opAlist| NIL)
             (SETQ |lines| |linelist|)
             ((LAMBDA ()
                (LOOP
                 (COND ((NOT |lines|) (RETURN NIL))
                       (#1#
                        (PROGN
                         (SETQ |name| (|dbName| (SETQ |x| (CAR |lines|))))
                         (SETQ |pile| (LIST |x|))
                         ((LAMBDA ()
                            (LOOP
                             (COND
                              ((NOT
                                (AND (SETQ |lines| (CDR |lines|))
                                     (EQUAL |name|
                                            (|dbName|
                                             (SETQ |x| (CAR |lines|))))))
                               (RETURN NIL))
                              (#1# (SETQ |pile| (CONS |x| |pile|)))))))
                         (SETQ |opAlist|
                                 (CONS (CONS |name| (NREVERSE |pile|))
                                       |opAlist|))))))))
             (SETQ |opAlist| (|listSort| #'LEXLESSEQP (NREVERSE |opAlist|)))
             (COND
              ((EQUAL |which| "operation")
               (|htpSetProperty| |htPage| '|opAlist| |opAlist|))
              (#1# (|htpSetProperty| |htPage| '|attrAlist| |opAlist|)))
             (SETQ |expandProperty|
                     (COND ((EQUAL |which| "operation") '|expandOperations|)
                           (#1# '|expandAttributes|)))
             (|htpSetProperty| |htPage| |expandProperty| '|strings|)
             (|dbResetOpAlistCondition| |htPage| |which| |opAlist|)
             (COND ((EQUAL |which| "attribute") (BREAK)))
             (|dbShowOp1| |htPage| |opAlist| |which| '|names|)))))))

; dbResetOpAlistCondition(htPage,which,opAlist) ==
;   which ~= '"operation" => BREAK()
;   value := dbExpandOpAlistIfNecessary(htPage,opAlist,which,false,true)
;   htpSetProperty(htPage,'condition?,(value => 'yes; 'no))
;   value

(DEFUN |dbResetOpAlistCondition| (|htPage| |which| |opAlist|)
  (PROG (|value|)
    (RETURN
     (COND ((NOT (EQUAL |which| "operation")) (BREAK))
           (#1='T
            (PROGN
             (SETQ |value|
                     (|dbExpandOpAlistIfNecessary| |htPage| |opAlist| |which|
                      NIL T))
             (|htpSetProperty| |htPage| '|condition?|
              (COND (|value| '|yes|) (#1# '|no|)))
             |value|))))))

; dbExpandOpAlistIfNecessary(htPage,opAlist,which,needOrigins?,condition?) ==
; --if condition? = true, stop when you find a non-trivial predicate
; --otherwise, expand in full
; --RETURNS:
; --  non-trivial predicate, if condition? = true and it finds one
; --  nil,                   otherwise
; --SIDE-EFFECT: this function references the "expand" property (set elsewhere):
; --  'strings, if not fully expanded and it contains strings
; --            i.e. opAlist is ((op . (string ...))...) if unexpanded
; --  'lists,   if not fully expanded and it contains lists
; --            i.e. opAlist is ((op . ((sig pred) ...))...) if unexpanded
;     which ~= '"operation" => BREAK()
;     condition? := condition? and not $exposedOnlyIfTrue
;     value      := nil  --return value
;     expandProperty :=
;       which = '"operation" => 'expandOperations
;       'expandAttributes
;     expandFlag := htpProperty(htPage,expandProperty)
;     expandFlag = 'fullyExpanded => nil
;     expandFlag = 'strings => --strings are partially expanded
;       for pair in opAlist repeat
;         [op,:lines] := pair
;         acc := nil
;         for line in lines repeat
;         --NOTE: we must expand all lines here for a given op
;         --      since below we will change opAlist
;         --Case 1: Already expanded; just cons it onto ACC
;           null STRINGP line => --already expanded
;             if condition? then --this could have been expanded at a lower level
;               if null atom (pred := CADR line) then value := pred
;             acc := [line,:acc] --this one is already expanded; record it anyway
;         --Case 2: unexpanded; expand it then cons it onto ACC
;           [name,nargs,xflag,sigs,conname,pred,comments] := dbParts(line,7,1)
;           predicate := ncParseFromString pred
;           if condition? and null atom predicate then value := predicate
;           sig := ncParseFromString sigs --is (Mapping,:.)
;           if which = '"operation" then
;             if sig isnt ['Mapping,:.]
;             then sayBrightly ['"Unexpected signature for ",name,'": ",sigs]
;             else sig := rest sig
;           conname := intern dbNewConname line
;           origin := [conname,:getConstructorArgs conname]
;           exposeFlag := dbExposed?(line,char 'o)
;           acc := [[sig,predicate,origin,exposeFlag,comments],:acc]
;         --always store the fruits of our labor:
;         RPLACD(pair,NREVERSE acc)             --at least partially expand it
;         condition? and value => return value  --early exit
;       value => value
;       condition? => nil
;       htpSetProperty(htPage,expandProperty,'fullyExpanded)
;     expandFlag = 'lists => --lists are partially expanded
;       -- entry is [sig, predicate, origin, exposeFlag, comments]
;       $value: local := nil
;       $docTableHash := MAKE_HASHTABLE('EQUAL)
;       packageSymbol := false
;       domform := htpProperty(htPage,'domname) or htpProperty(htPage,'conform)
;       if isDefaultPackageName opOf domform then
;          catname := intern SUBSTRING(s := PNAME opOf domform,0,MAXINDEX s)
;          packageSymbol := first rest domform
;          domform := [catname,:rest rest domform]  --skip first argument ($)
;       docTable:= dbDocTable domform
;       for [op,:alist] in opAlist repeat
;         for [sig,:tail] in alist repeat
;           condition? => --the only purpose here is to find a non-trivial pred
;             null atom (pred := first tail) => return ($value := pred)
;             'skip
;           u :=
;             tail is [.,origin,:.] and origin =>
; --  must change any % into $ otherwise we will not pick up comments properly
; --  delete the SUBLISLIS when we fix on % or $
;               dbGetDocTable(op,SUBLISLIS(['$],['%],sig),dbDocTable origin,which,nil)
;             if packageSymbol then sig := substitute('_$, packageSymbol, sig)
;             dbGetDocTable(op,sig,docTable,which,nil)
;           origin := IFCAR u or origin
;           docCode := IFCDR u   --> (doc . code)
;           which = '"attribute" => BREAK()
;           RPLACD(tail,[origin,isExposedConstructor opOf origin,:docCode])
;         $value => return $value
;       $value => $value
;       condition? => nil
;       htpSetProperty(htPage,expandProperty,'fullyExpanded)
;     'done

(DEFUN |dbExpandOpAlistIfNecessary|
       (|htPage| |opAlist| |which| |needOrigins?| |condition?|)
  (PROG (|$value| |docCode| |u| |ISTMP#1| |tail| |alist| |docTable| |catname|
         |s| |domform| |packageSymbol| |exposeFlag| |origin| |sig| |predicate|
         |comments| |conname| |sigs| |xflag| |nargs| |name| |LETTMP#1| |pred|
         |acc| |lines| |op| |expandFlag| |expandProperty| |value|)
    (DECLARE (SPECIAL |$value|))
    (RETURN
     (COND ((NOT (EQUAL |which| "operation")) (BREAK))
           (#1='T
            (PROGN
             (SETQ |condition?| (AND |condition?| (NULL |$exposedOnlyIfTrue|)))
             (SETQ |value| NIL)
             (SETQ |expandProperty|
                     (COND ((EQUAL |which| "operation") '|expandOperations|)
                           (#1# '|expandAttributes|)))
             (SETQ |expandFlag| (|htpProperty| |htPage| |expandProperty|))
             (COND ((EQ |expandFlag| '|fullyExpanded|) NIL)
                   ((EQ |expandFlag| '|strings|)
                    (PROGN
                     ((LAMBDA (|bfVar#95| |pair|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#95|)
                               (PROGN (SETQ |pair| (CAR |bfVar#95|)) NIL))
                           (RETURN NIL))
                          (#1#
                           (PROGN
                            (SETQ |op| (CAR |pair|))
                            (SETQ |lines| (CDR |pair|))
                            (SETQ |acc| NIL)
                            ((LAMBDA (|bfVar#96| |line|)
                               (LOOP
                                (COND
                                 ((OR (ATOM |bfVar#96|)
                                      (PROGN
                                       (SETQ |line| (CAR |bfVar#96|))
                                       NIL))
                                  (RETURN NIL))
                                 (#1#
                                  (COND
                                   ((NULL (STRINGP |line|))
                                    (PROGN
                                     (COND
                                      (|condition?|
                                       (COND
                                        ((NULL
                                          (ATOM (SETQ |pred| (CADR |line|))))
                                         (SETQ |value| |pred|)))))
                                     (SETQ |acc| (CONS |line| |acc|))))
                                   (#1#
                                    (PROGN
                                     (SETQ |LETTMP#1| (|dbParts| |line| 7 1))
                                     (SETQ |name| (CAR |LETTMP#1|))
                                     (SETQ |nargs| (CADR . #2=(|LETTMP#1|)))
                                     (SETQ |xflag| (CADDR . #2#))
                                     (SETQ |sigs| (CADDDR . #2#))
                                     (SETQ |conname| (CAR #3=(CDDDDR . #2#)))
                                     (SETQ |pred| (CADR . #4=(#3#)))
                                     (SETQ |comments| (CADDR . #4#))
                                     (SETQ |predicate|
                                             (|ncParseFromString| |pred|))
                                     (COND
                                      ((AND |condition?|
                                            (NULL (ATOM |predicate|)))
                                       (SETQ |value| |predicate|)))
                                     (SETQ |sig| (|ncParseFromString| |sigs|))
                                     (COND
                                      ((EQUAL |which| "operation")
                                       (COND
                                        ((NOT
                                          (AND (CONSP |sig|)
                                               (EQ (CAR |sig|) '|Mapping|)))
                                         (|sayBrightly|
                                          (LIST "Unexpected signature for "
                                                |name| ": " |sigs|)))
                                        (#1# (SETQ |sig| (CDR |sig|))))))
                                     (SETQ |conname|
                                             (|intern|
                                              (|dbNewConname| |line|)))
                                     (SETQ |origin|
                                             (CONS |conname|
                                                   (|getConstructorArgs|
                                                    |conname|)))
                                     (SETQ |exposeFlag|
                                             (|dbExposed?| |line|
                                              (|char| '|o|)))
                                     (SETQ |acc|
                                             (CONS
                                              (LIST |sig| |predicate| |origin|
                                                    |exposeFlag| |comments|)
                                              |acc|)))))))
                                (SETQ |bfVar#96| (CDR |bfVar#96|))))
                             |lines| NIL)
                            (RPLACD |pair| (NREVERSE |acc|))
                            (COND
                             ((AND |condition?| |value|) (RETURN |value|))))))
                         (SETQ |bfVar#95| (CDR |bfVar#95|))))
                      |opAlist| NIL)
                     (COND (|value| |value|) (|condition?| NIL)
                           (#1#
                            (|htpSetProperty| |htPage| |expandProperty|
                             '|fullyExpanded|)))))
                   ((EQ |expandFlag| '|lists|)
                    (PROGN
                     (SETQ |$value| NIL)
                     (SETQ |$docTableHash| (MAKE_HASHTABLE 'EQUAL))
                     (SETQ |packageSymbol| NIL)
                     (SETQ |domform|
                             (OR (|htpProperty| |htPage| '|domname|)
                                 (|htpProperty| |htPage| '|conform|)))
                     (COND
                      ((|isDefaultPackageName| (|opOf| |domform|))
                       (SETQ |catname|
                               (|intern|
                                (SUBSTRING
                                 (SETQ |s| (PNAME (|opOf| |domform|))) 0
                                 (MAXINDEX |s|))))
                       (SETQ |packageSymbol| (CAR (CDR |domform|)))
                       (SETQ |domform|
                               (CONS |catname| (CDR (CDR |domform|))))))
                     (SETQ |docTable| (|dbDocTable| |domform|))
                     ((LAMBDA (|bfVar#98| |bfVar#97|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#98|)
                               (PROGN (SETQ |bfVar#97| (CAR |bfVar#98|)) NIL))
                           (RETURN NIL))
                          (#1#
                           (AND (CONSP |bfVar#97|)
                                (PROGN
                                 (SETQ |op| (CAR |bfVar#97|))
                                 (SETQ |alist| (CDR |bfVar#97|))
                                 #1#)
                                (PROGN
                                 ((LAMBDA (|bfVar#100| |bfVar#99|)
                                    (LOOP
                                     (COND
                                      ((OR (ATOM |bfVar#100|)
                                           (PROGN
                                            (SETQ |bfVar#99| (CAR |bfVar#100|))
                                            NIL))
                                       (RETURN NIL))
                                      (#1#
                                       (AND (CONSP |bfVar#99|)
                                            (PROGN
                                             (SETQ |sig| (CAR |bfVar#99|))
                                             (SETQ |tail| (CDR |bfVar#99|))
                                             #1#)
                                            (COND
                                             (|condition?|
                                              (COND
                                               ((NULL
                                                 (ATOM
                                                  (SETQ |pred| (CAR |tail|))))
                                                (RETURN
                                                 (SETQ |$value| |pred|)))
                                               (#1# '|skip|)))
                                             (#1#
                                              (PROGN
                                               (SETQ |u|
                                                       (COND
                                                        ((AND (CONSP |tail|)
                                                              (PROGN
                                                               (SETQ |ISTMP#1|
                                                                       (CDR
                                                                        |tail|))
                                                               (AND
                                                                (CONSP
                                                                 |ISTMP#1|)
                                                                (PROGN
                                                                 (SETQ |origin|
                                                                         (CAR
                                                                          |ISTMP#1|))
                                                                 #1#)))
                                                              |origin|)
                                                         (|dbGetDocTable| |op|
                                                          (SUBLISLIS (LIST '$)
                                                           (LIST '%) |sig|)
                                                          (|dbDocTable|
                                                           |origin|)
                                                          |which| NIL))
                                                        (#1#
                                                         (PROGN
                                                          (COND
                                                           (|packageSymbol|
                                                            (SETQ |sig|
                                                                    (|substitute|
                                                                     '$
                                                                     |packageSymbol|
                                                                     |sig|))))
                                                          (|dbGetDocTable| |op|
                                                           |sig| |docTable|
                                                           |which| NIL)))))
                                               (SETQ |origin|
                                                       (OR (IFCAR |u|)
                                                           |origin|))
                                               (SETQ |docCode| (IFCDR |u|))
                                               (COND
                                                ((EQUAL |which| "attribute")
                                                 (BREAK))
                                                (#1#
                                                 (RPLACD |tail|
                                                         (CONS |origin|
                                                               (CONS
                                                                (|isExposedConstructor|
                                                                 (|opOf|
                                                                  |origin|))
                                                                |docCode|)))))))))))
                                     (SETQ |bfVar#100| (CDR |bfVar#100|))))
                                  |alist| NIL)
                                 (COND (|$value| (RETURN |$value|)))))))
                         (SETQ |bfVar#98| (CDR |bfVar#98|))))
                      |opAlist| NIL)
                     (COND (|$value| |$value|) (|condition?| NIL)
                           (#1#
                            (|htpSetProperty| |htPage| |expandProperty|
                             '|fullyExpanded|)))))
                   (#1# '|done|))))))))

; getRegistry(op,sig) ==
;   u := GETDATABASE('AttributeRegistry,'DOCUMENTATION)
;   v := LASSOC(op,u)
;   match := or/[y for y in v | y is [['attribute,: =sig],:.]] => CADR match
;   '""

(DEFUN |getRegistry| (|op| |sig|)
  (PROG (|u| |v| |ISTMP#1| |match|)
    (RETURN
     (PROGN
      (SETQ |u| (GETDATABASE '|AttributeRegistry| 'DOCUMENTATION))
      (SETQ |v| (LASSOC |op| |u|))
      (COND
       ((SETQ |match|
                ((LAMBDA (|bfVar#102| |bfVar#101| |y|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#101|)
                          (PROGN (SETQ |y| (CAR |bfVar#101|)) NIL))
                      (RETURN |bfVar#102|))
                     (#1='T
                      (AND (CONSP |y|)
                           (PROGN
                            (SETQ |ISTMP#1| (CAR |y|))
                            (AND (CONSP |ISTMP#1|)
                                 (EQ (CAR |ISTMP#1|) '|attribute|)
                                 (EQUAL (CDR |ISTMP#1|) |sig|)))
                           (PROGN
                            (SETQ |bfVar#102| |y|)
                            (COND (|bfVar#102| (RETURN |bfVar#102|)))))))
                    (SETQ |bfVar#101| (CDR |bfVar#101|))))
                 NIL |v| NIL))
        (CADR |match|))
       (#1# ""))))))

; evalableConstructor2HtString domform ==
;   if VECP domform then domform := devaluate domform
;   conname := first domform
;   coSig   := rest GETDATABASE(conname,'COSIG)
;   --entries are T for arguments which are domains; NIL for computational objects
;   and/[x for x in coSig] => form2HtString(domform,nil,true)
;   arglist := [unquote x for x in rest domform] where
;     unquote arg  ==
;       arg is [f,:args] =>
;         f = 'QUOTE => first args
;         [f,:[unquote x for x in args]]
;       arg
;   fargtypes:=CDDAR GETDATABASE(conname,'CONSTRUCTORMODEMAP)
; --argtypes:= sublisFormal(arglist,fargtypes)
;   form2HtString([conname,:[fn for arg in arglist for x in coSig
;                    for ftype in fargtypes]],nil,true) where
;     fn ==
;       x => arg
;       typ := sublisFormal(arglist,ftype)
;       mathform2HtString algCoerceInteractive(arg,typ,'(OutputForm))

(DEFUN |evalableConstructor2HtString| (|domform|)
  (PROG (|conname| |coSig| |arglist| |fargtypes| |typ|)
    (RETURN
     (PROGN
      (COND ((VECP |domform|) (SETQ |domform| (|devaluate| |domform|))))
      (SETQ |conname| (CAR |domform|))
      (SETQ |coSig| (CDR (GETDATABASE |conname| 'COSIG)))
      (COND
       (((LAMBDA (|bfVar#104| |bfVar#103| |x|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#103|) (PROGN (SETQ |x| (CAR |bfVar#103|)) NIL))
              (RETURN |bfVar#104|))
             (#1='T
              (PROGN
               (SETQ |bfVar#104| |x|)
               (COND ((NOT |bfVar#104|) (RETURN NIL))))))
            (SETQ |bfVar#103| (CDR |bfVar#103|))))
         T |coSig| NIL)
        (|form2HtString| |domform| NIL T))
       (#1#
        (PROGN
         (SETQ |arglist|
                 ((LAMBDA (|bfVar#106| |bfVar#105| |x|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#105|)
                           (PROGN (SETQ |x| (CAR |bfVar#105|)) NIL))
                       (RETURN (NREVERSE |bfVar#106|)))
                      (#1#
                       (SETQ |bfVar#106|
                               (CONS
                                (|evalableConstructor2HtString,unquote| |x|)
                                |bfVar#106|))))
                     (SETQ |bfVar#105| (CDR |bfVar#105|))))
                  NIL (CDR |domform|) NIL))
         (SETQ |fargtypes| (CDDAR (GETDATABASE |conname| 'CONSTRUCTORMODEMAP)))
         (|form2HtString|
          (CONS |conname|
                ((LAMBDA
                     (|bfVar#112| |bfVar#109| |arg| |bfVar#110| |x| |bfVar#111|
                      |ftype|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#109|)
                          (PROGN (SETQ |arg| (CAR |bfVar#109|)) NIL)
                          (ATOM |bfVar#110|)
                          (PROGN (SETQ |x| (CAR |bfVar#110|)) NIL)
                          (ATOM |bfVar#111|)
                          (PROGN (SETQ |ftype| (CAR |bfVar#111|)) NIL))
                      (RETURN (NREVERSE |bfVar#112|)))
                     (#1#
                      (SETQ |bfVar#112|
                              (CONS
                               (COND (|x| |arg|)
                                     (#1#
                                      (PROGN
                                       (SETQ |typ|
                                               (|sublisFormal| |arglist|
                                                |ftype|))
                                       (|mathform2HtString|
                                        (|algCoerceInteractive| |arg| |typ|
                                         '(|OutputForm|))))))
                               |bfVar#112|))))
                    (SETQ |bfVar#109| (CDR |bfVar#109|))
                    (SETQ |bfVar#110| (CDR |bfVar#110|))
                    (SETQ |bfVar#111| (CDR |bfVar#111|))))
                 NIL |arglist| NIL |coSig| NIL |fargtypes| NIL))
          NIL T))))))))
(DEFUN |evalableConstructor2HtString,unquote| (|arg|)
  (PROG (|f| |args|)
    (RETURN
     (COND
      ((AND (CONSP |arg|)
            (PROGN (SETQ |f| (CAR |arg|)) (SETQ |args| (CDR |arg|)) #1='T))
       (COND ((EQ |f| 'QUOTE) (CAR |args|))
             (#1#
              (CONS |f|
                    ((LAMBDA (|bfVar#108| |bfVar#107| |x|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#107|)
                              (PROGN (SETQ |x| (CAR |bfVar#107|)) NIL))
                          (RETURN (NREVERSE |bfVar#108|)))
                         (#1#
                          (SETQ |bfVar#108|
                                  (CONS
                                   (|evalableConstructor2HtString,unquote| |x|)
                                   |bfVar#108|))))
                        (SETQ |bfVar#107| (CDR |bfVar#107|))))
                     NIL |args| NIL)))))
      (#1# |arg|)))))

; fortexp0 x ==
;   e_to_f := getFunctionFromDomain("expression2Fortran", ['FortranCodeTools],
;                                  [$OutputForm])
;   f := SPADCALL(x, e_to_f)
;   p := position('"%l",f)
;   p < 0 => f
;   l := NIL
;   while p < 0 repeat
;     [t,:f] := f
;     l := [t,:l]
;   NREVERSE ['"...",:l]

(DEFUN |fortexp0| (|x|)
  (PROG (|e_to_f| |f| |p| |l| |LETTMP#1| |t|)
    (RETURN
     (PROGN
      (SETQ |e_to_f|
              (|getFunctionFromDomain| '|expression2Fortran|
               (LIST '|FortranCodeTools|) (LIST |$OutputForm|)))
      (SETQ |f| (SPADCALL |x| |e_to_f|))
      (SETQ |p| (|position| "%l" |f|))
      (COND ((MINUSP |p|) |f|)
            (#1='T
             (PROGN
              (SETQ |l| NIL)
              ((LAMBDA ()
                 (LOOP
                  (COND ((NOT (MINUSP |p|)) (RETURN NIL))
                        (#1#
                         (PROGN
                          (SETQ |LETTMP#1| |f|)
                          (SETQ |t| (CAR |LETTMP#1|))
                          (SETQ |f| (CDR |LETTMP#1|))
                          (SETQ |l| (CONS |t| |l|))))))))
              (NREVERSE (CONS "..." |l|)))))))))

; mathform2HtString form == escapeString
;   form is ['QUOTE,a] => STRCONC('"'","STRCONC"/fortexp0 a)
;   form is ['BRACKET,['AGGLST,:arg]] =>
;     if arg is ['construct,:r] then arg := r
;     arg :=
;       atom arg => [arg]
;       [y for x in arg | y := (x is ['QUOTE,a] => a; x)]
;     tailPart := "STRCONC"/[STRCONC('",",STRINGIMAGE x) for x in rest arg]
;     STRCONC('"[",STRINGIMAGE first arg,tailPart,'"]")
;   form is ['BRACKET,['AGGLST,'QUOTE,arg]] =>
;     if atom arg then arg := [arg]
;     tailPart := "STRCONC"/[STRCONC('",",x) for x in rest arg]
;     STRCONC('"[",first arg,tailPart,'"]")
;   atom form => form
;   "STRCONC"/fortexp0 form

(DEFUN |mathform2HtString| (|form|)
  (PROG (|ISTMP#1| |a| |ISTMP#2| |arg| |r| |y| |tailPart| |ISTMP#3| |ISTMP#4|)
    (RETURN
     (|escapeString|
      (COND
       ((AND (CONSP |form|) (EQ (CAR |form|) 'QUOTE)
             (PROGN
              (SETQ |ISTMP#1| (CDR |form|))
              (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                   (PROGN (SETQ |a| (CAR |ISTMP#1|)) #1='T))))
        (STRCONC "'"
         ((LAMBDA (|bfVar#113| |bfVar#115| |bfVar#114|)
            (LOOP
             (COND
              ((OR (ATOM |bfVar#115|)
                   (PROGN (SETQ |bfVar#114| (CAR |bfVar#115|)) NIL))
               (RETURN |bfVar#113|))
              (#1# (SETQ |bfVar#113| (STRCONC |bfVar#113| |bfVar#114|))))
             (SETQ |bfVar#115| (CDR |bfVar#115|))))
          #2="" (|fortexp0| |a|) NIL)))
       ((AND (CONSP |form|) (EQ (CAR |form|) 'BRACKET)
             (PROGN
              (SETQ |ISTMP#1| (CDR |form|))
              (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                   (PROGN
                    (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|) (EQ (CAR |ISTMP#2|) 'AGGLST)
                         (PROGN (SETQ |arg| (CDR |ISTMP#2|)) #1#))))))
        (PROGN
         (COND
          ((AND (CONSP |arg|) (EQ (CAR |arg|) '|construct|)
                (PROGN (SETQ |r| (CDR |arg|)) #1#))
           (SETQ |arg| |r|)))
         (SETQ |arg|
                 (COND ((ATOM |arg|) (LIST |arg|))
                       (#1#
                        ((LAMBDA (|bfVar#117| |bfVar#116| |x|)
                           (LOOP
                            (COND
                             ((OR (ATOM |bfVar#116|)
                                  (PROGN (SETQ |x| (CAR |bfVar#116|)) NIL))
                              (RETURN (NREVERSE |bfVar#117|)))
                             (#1#
                              (AND
                               (SETQ |y|
                                       (COND
                                        ((AND (CONSP |x|) (EQ (CAR |x|) 'QUOTE)
                                              (PROGN
                                               (SETQ |ISTMP#1| (CDR |x|))
                                               (AND (CONSP |ISTMP#1|)
                                                    (EQ (CDR |ISTMP#1|) NIL)
                                                    (PROGN
                                                     (SETQ |a| (CAR |ISTMP#1|))
                                                     #1#))))
                                         |a|)
                                        (#1# |x|)))
                               (SETQ |bfVar#117| (CONS |y| |bfVar#117|)))))
                            (SETQ |bfVar#116| (CDR |bfVar#116|))))
                         NIL |arg| NIL))))
         (SETQ |tailPart|
                 ((LAMBDA (|bfVar#119| |bfVar#118| |x|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#118|)
                           (PROGN (SETQ |x| (CAR |bfVar#118|)) NIL))
                       (RETURN |bfVar#119|))
                      (#1#
                       (SETQ |bfVar#119|
                               (STRCONC |bfVar#119|
                                (STRCONC "," (STRINGIMAGE |x|))))))
                     (SETQ |bfVar#118| (CDR |bfVar#118|))))
                  #2# (CDR |arg|) NIL))
         (STRCONC "[" (STRINGIMAGE (CAR |arg|)) |tailPart| "]")))
       ((AND (CONSP |form|) (EQ (CAR |form|) 'BRACKET)
             (PROGN
              (SETQ |ISTMP#1| (CDR |form|))
              (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                   (PROGN
                    (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|) (EQ (CAR |ISTMP#2|) 'AGGLST)
                         (PROGN
                          (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                          (AND (CONSP |ISTMP#3|) (EQ (CAR |ISTMP#3|) 'QUOTE)
                               (PROGN
                                (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                                (AND (CONSP |ISTMP#4|) (EQ (CDR |ISTMP#4|) NIL)
                                     (PROGN
                                      (SETQ |arg| (CAR |ISTMP#4|))
                                      #1#))))))))))
        (PROGN
         (COND ((ATOM |arg|) (SETQ |arg| (LIST |arg|))))
         (SETQ |tailPart|
                 ((LAMBDA (|bfVar#121| |bfVar#120| |x|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#120|)
                           (PROGN (SETQ |x| (CAR |bfVar#120|)) NIL))
                       (RETURN |bfVar#121|))
                      (#1#
                       (SETQ |bfVar#121|
                               (STRCONC |bfVar#121| (STRCONC "," |x|)))))
                     (SETQ |bfVar#120| (CDR |bfVar#120|))))
                  #2# (CDR |arg|) NIL))
         (STRCONC "[" (CAR |arg|) |tailPart| "]")))
       ((ATOM |form|) |form|)
       (#1#
        ((LAMBDA (|bfVar#122| |bfVar#124| |bfVar#123|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#124|)
                  (PROGN (SETQ |bfVar#123| (CAR |bfVar#124|)) NIL))
              (RETURN |bfVar#122|))
             (#1# (SETQ |bfVar#122| (STRCONC |bfVar#122| |bfVar#123|))))
            (SETQ |bfVar#124| (CDR |bfVar#124|))))
         #2# (|fortexp0| |form|) NIL)))))))

; getDomainOpTable(dom, fromIfTrue) == getDomainOpTable2(dom, fromIfTrue, [])

(DEFUN |getDomainOpTable| (|dom| |fromIfTrue|)
  (PROG () (RETURN (|getDomainOpTable2| |dom| |fromIfTrue| NIL))))

; getDomainOpTable2(dom, fromIfTrue, ops) ==
;   $returnNowhereFromGoGet: local := true
;   domname := dom.0
;   conname := first domname
;   abb := getConstructorAbbreviation conname
;   opAlist := getOperationAlistFromLisplib conname
;   "append"/[REMDUP [[op1,:fn] for [sig,slot,pred,key,:.] in u
;               | ((null ops and (op1 := op)) or (op1 := memq(op, ops)))]
;                  for [op,:u] in opAlist] where
;     memq(op,ops) ==   --dirty trick to get 0 and 1 instead of Zero and One
;       MEMQ(op,ops) => op
;       EQ(op,'One)  => MEMQ(1,ops) and 1
;       EQ(op,'Zero) => MEMQ(0,ops) and 0
;       false
;     fn ==
;       sig1 := sublisFormal(rest domname,sig)
;       predValue := evalDomainOpPred(dom,pred)
;       info :=
;         null predValue =>
;           1   -- signifies not exported
;         null fromIfTrue => nil
;         cell := compiledLookup(op,sig1,dom) =>
;           [f,:r] := cell
;           f = 'nowhere => 'nowhere           --see replaceGoGetSlot
;           f = function makeSpadConstant => 'constant
;           f = function IDENTITY => 'constant
;           f = function newGoGet => substitute('_$, domname, devaluate first r)
;           null VECP r => systemError devaluateList r
;           substitute('_$, domname, devaluate r)
;         'nowhere
;       [sig1,:info]

(DEFUN |getDomainOpTable2| (|dom| |fromIfTrue| |ops|)
  (PROG (|$returnNowhereFromGoGet| |info| |r| |f| |cell| |predValue| |sig1|
         |op1| |key| |ISTMP#3| |pred| |ISTMP#2| |slot| |ISTMP#1| |sig| |u| |op|
         |opAlist| |abb| |conname| |domname|)
    (DECLARE (SPECIAL |$returnNowhereFromGoGet|))
    (RETURN
     (PROGN
      (SETQ |$returnNowhereFromGoGet| T)
      (SETQ |domname| (ELT |dom| 0))
      (SETQ |conname| (CAR |domname|))
      (SETQ |abb| (|getConstructorAbbreviation| |conname|))
      (SETQ |opAlist| (|getOperationAlistFromLisplib| |conname|))
      ((LAMBDA (|bfVar#130| |bfVar#129| |bfVar#128|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#129|)
                (PROGN (SETQ |bfVar#128| (CAR |bfVar#129|)) NIL))
            (RETURN |bfVar#130|))
           (#1='T
            (AND (CONSP |bfVar#128|)
                 (PROGN
                  (SETQ |op| (CAR |bfVar#128|))
                  (SETQ |u| (CDR |bfVar#128|))
                  #1#)
                 (SETQ |bfVar#130|
                         (APPEND |bfVar#130|
                                 (REMDUP
                                  ((LAMBDA
                                       (|bfVar#127| |bfVar#126| |bfVar#125|)
                                     (LOOP
                                      (COND
                                       ((OR (ATOM |bfVar#126|)
                                            (PROGN
                                             (SETQ |bfVar#125|
                                                     (CAR |bfVar#126|))
                                             NIL))
                                        (RETURN (NREVERSE |bfVar#127|)))
                                       (#1#
                                        (AND (CONSP |bfVar#125|)
                                             (PROGN
                                              (SETQ |sig| (CAR |bfVar#125|))
                                              (SETQ |ISTMP#1|
                                                      (CDR |bfVar#125|))
                                              (AND (CONSP |ISTMP#1|)
                                                   (PROGN
                                                    (SETQ |slot|
                                                            (CAR |ISTMP#1|))
                                                    (SETQ |ISTMP#2|
                                                            (CDR |ISTMP#1|))
                                                    (AND (CONSP |ISTMP#2|)
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
                                             (OR
                                              (AND (NULL |ops|)
                                                   (SETQ |op1| |op|))
                                              (SETQ |op1|
                                                      (|getDomainOpTable2,memq|
                                                       |op| |ops|)))
                                             (SETQ |bfVar#127|
                                                     (CONS
                                                      (CONS |op1|
                                                            (PROGN
                                                             (SETQ |sig1|
                                                                     (|sublisFormal|
                                                                      (CDR
                                                                       |domname|)
                                                                      |sig|))
                                                             (SETQ |predValue|
                                                                     (|evalDomainOpPred|
                                                                      |dom|
                                                                      |pred|))
                                                             (SETQ |info|
                                                                     (COND
                                                                      ((NULL
                                                                        |predValue|)
                                                                       1)
                                                                      ((NULL
                                                                        |fromIfTrue|)
                                                                       NIL)
                                                                      ((SETQ |cell|
                                                                               (|compiledLookup|
                                                                                |op|
                                                                                |sig1|
                                                                                |dom|))
                                                                       (PROGN
                                                                        (SETQ |f|
                                                                                (CAR
                                                                                 |cell|))
                                                                        (SETQ |r|
                                                                                (CDR
                                                                                 |cell|))
                                                                        (COND
                                                                         ((EQ
                                                                           |f|
                                                                           '|nowhere|)
                                                                          '|nowhere|)
                                                                         ((EQUAL
                                                                           |f|
                                                                           #'|makeSpadConstant|)
                                                                          '|constant|)
                                                                         ((EQUAL
                                                                           |f|
                                                                           #'IDENTITY)
                                                                          '|constant|)
                                                                         ((EQUAL
                                                                           |f|
                                                                           #'|newGoGet|)
                                                                          (|substitute|
                                                                           '$
                                                                           |domname|
                                                                           (|devaluate|
                                                                            (CAR
                                                                             |r|))))
                                                                         ((NULL
                                                                           (VECP
                                                                            |r|))
                                                                          (|systemError|
                                                                           (|devaluateList|
                                                                            |r|)))
                                                                         (#1#
                                                                          (|substitute|
                                                                           '$
                                                                           |domname|
                                                                           (|devaluate|
                                                                            |r|))))))
                                                                      (#1#
                                                                       '|nowhere|)))
                                                             (CONS |sig1|
                                                                   |info|)))
                                                      |bfVar#127|)))))
                                      (SETQ |bfVar#126| (CDR |bfVar#126|))))
                                   NIL |u| NIL)))))))
          (SETQ |bfVar#129| (CDR |bfVar#129|))))
       NIL |opAlist| NIL)))))
(DEFUN |getDomainOpTable2,memq| (|op| |ops|)
  (PROG ()
    (RETURN
     (COND ((MEMQ |op| |ops|) |op|) ((EQ |op| '|One|) (AND (MEMQ 1 |ops|) 1))
           ((EQ |op| '|Zero|) (AND (MEMQ 0 |ops|) 0)) ('T NIL)))))

; evalDomainOpPred2(dom, pred) ==
;     $predicateList : local := GETDATABASE(first(dom.0), 'PREDICATES)
;     evalDomainOpPred(dom,pred)

(DEFUN |evalDomainOpPred2| (|dom| |pred|)
  (PROG (|$predicateList|)
    (DECLARE (SPECIAL |$predicateList|))
    (RETURN
     (PROGN
      (SETQ |$predicateList| (GETDATABASE (CAR (ELT |dom| 0)) 'PREDICATES))
      (|evalDomainOpPred| |dom| |pred|)))))

; evalDomainOpPred(dom,pred) == process(dom,pred) where
;   process(dom,pred) ==
;     u := convert(dom,pred)
;     u = 'T => true
;     evpred(dom,u)
;   convert(dom,pred) ==
;     pred is [op,:argl] =>
;       MEMQ(op,'(AND and)) => ['AND,:[convert(dom,x) for x in argl]]
;       MEMQ(op,'(OR or))   => ['OR,:[convert(dom,x) for x in argl]]
;       MEMQ(op,'(NOT not)) => ['NOT,convert(dom,first argl)]
;       op = 'has =>
;         [arg,p] := argl
;         p is ['ATTRIBUTE,a] => BREAK()
;         ['HasCategory,arg,convertCatArg p]
;       systemError '"unknown predicate form"
;     pred = 'T => true
;     systemError nil
;   convertCatArg p ==
;     atom p or #p = 1 => MKQ p
;     ['LIST,MKQ first p,:[convertCatArg x for x in rest p]]
;   evpred(dom,pred) ==
;     k := POSN1(pred,$predicateList) => testBitVector(dom.3,k + 1)
;     evpred1(dom,pred)
;   evpred1(dom,pred) ==
;     pred is [op,:argl] =>
;       MEMQ(op,'(AND and)) => "and"/[evpred1(dom,x) for x in argl]
;       MEMQ(op,'(OR or))   =>  "or"/[evpred1(dom,x) for x in argl]
;       op = 'NOT => not evpred1(dom,first argl)
;       k := POSN1(pred,$predicateList) => testBitVector(dom.3,k + 1)
;       op = 'HasAttribute => BREAK()
;       nil
;     pred = 'T => true
;     systemError '"unknown atomic predicate form"

(DEFUN |evalDomainOpPred| (|dom| |pred|)
  (PROG () (RETURN (|evalDomainOpPred,process| |dom| |pred|))))
(DEFUN |evalDomainOpPred,process| (|dom| |pred|)
  (PROG (|u|)
    (RETURN
     (PROGN
      (SETQ |u| (|evalDomainOpPred,convert| |dom| |pred|))
      (COND ((EQ |u| 'T) T) ('T (|evalDomainOpPred,evpred| |dom| |u|)))))))
(DEFUN |evalDomainOpPred,convert| (|dom| |pred|)
  (PROG (|op| |argl| |arg| |p| |ISTMP#1| |a|)
    (RETURN
     (COND
      ((AND (CONSP |pred|)
            (PROGN (SETQ |op| (CAR |pred|)) (SETQ |argl| (CDR |pred|)) #1='T))
       (COND
        ((MEMQ |op| '(AND |and|))
         (CONS 'AND
               ((LAMBDA (|bfVar#132| |bfVar#131| |x|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#131|)
                         (PROGN (SETQ |x| (CAR |bfVar#131|)) NIL))
                     (RETURN (NREVERSE |bfVar#132|)))
                    (#1#
                     (SETQ |bfVar#132|
                             (CONS (|evalDomainOpPred,convert| |dom| |x|)
                                   |bfVar#132|))))
                   (SETQ |bfVar#131| (CDR |bfVar#131|))))
                NIL |argl| NIL)))
        ((MEMQ |op| '(OR |or|))
         (CONS 'OR
               ((LAMBDA (|bfVar#134| |bfVar#133| |x|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#133|)
                         (PROGN (SETQ |x| (CAR |bfVar#133|)) NIL))
                     (RETURN (NREVERSE |bfVar#134|)))
                    (#1#
                     (SETQ |bfVar#134|
                             (CONS (|evalDomainOpPred,convert| |dom| |x|)
                                   |bfVar#134|))))
                   (SETQ |bfVar#133| (CDR |bfVar#133|))))
                NIL |argl| NIL)))
        ((MEMQ |op| '(NOT |not|))
         (LIST 'NOT (|evalDomainOpPred,convert| |dom| (CAR |argl|))))
        ((EQ |op| '|has|)
         (PROGN
          (SETQ |arg| (CAR |argl|))
          (SETQ |p| (CADR |argl|))
          (COND
           ((AND (CONSP |p|) (EQ (CAR |p|) 'ATTRIBUTE)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |p|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                       (PROGN (SETQ |a| (CAR |ISTMP#1|)) #1#))))
            (BREAK))
           (#1#
            (LIST '|HasCategory| |arg|
                  (|evalDomainOpPred,convertCatArg| |p|))))))
        (#1# (|systemError| "unknown predicate form"))))
      ((EQ |pred| 'T) T) (#1# (|systemError| NIL))))))
(DEFUN |evalDomainOpPred,convertCatArg| (|p|)
  (PROG ()
    (RETURN
     (COND ((OR (ATOM |p|) (EQL (LENGTH |p|) 1)) (MKQ |p|))
           (#1='T
            (CONS 'LIST
                  (CONS (MKQ (CAR |p|))
                        ((LAMBDA (|bfVar#136| |bfVar#135| |x|)
                           (LOOP
                            (COND
                             ((OR (ATOM |bfVar#135|)
                                  (PROGN (SETQ |x| (CAR |bfVar#135|)) NIL))
                              (RETURN (NREVERSE |bfVar#136|)))
                             (#1#
                              (SETQ |bfVar#136|
                                      (CONS
                                       (|evalDomainOpPred,convertCatArg| |x|)
                                       |bfVar#136|))))
                            (SETQ |bfVar#135| (CDR |bfVar#135|))))
                         NIL (CDR |p|) NIL))))))))
(DEFUN |evalDomainOpPred,evpred| (|dom| |pred|)
  (PROG (|k|)
    (RETURN
     (COND
      ((SETQ |k| (POSN1 |pred| |$predicateList|))
       (|testBitVector| (ELT |dom| 3) (+ |k| 1)))
      ('T (|evalDomainOpPred,evpred1| |dom| |pred|))))))
(DEFUN |evalDomainOpPred,evpred1| (|dom| |pred|)
  (PROG (|op| |argl| |k|)
    (RETURN
     (COND
      ((AND (CONSP |pred|)
            (PROGN (SETQ |op| (CAR |pred|)) (SETQ |argl| (CDR |pred|)) #1='T))
       (COND
        ((MEMQ |op| '(AND |and|))
         ((LAMBDA (|bfVar#138| |bfVar#137| |x|)
            (LOOP
             (COND
              ((OR (ATOM |bfVar#137|) (PROGN (SETQ |x| (CAR |bfVar#137|)) NIL))
               (RETURN |bfVar#138|))
              (#1#
               (PROGN
                (SETQ |bfVar#138| (|evalDomainOpPred,evpred1| |dom| |x|))
                (COND ((NOT |bfVar#138|) (RETURN NIL))))))
             (SETQ |bfVar#137| (CDR |bfVar#137|))))
          T |argl| NIL))
        ((MEMQ |op| '(OR |or|))
         ((LAMBDA (|bfVar#140| |bfVar#139| |x|)
            (LOOP
             (COND
              ((OR (ATOM |bfVar#139|) (PROGN (SETQ |x| (CAR |bfVar#139|)) NIL))
               (RETURN |bfVar#140|))
              (#1#
               (PROGN
                (SETQ |bfVar#140| (|evalDomainOpPred,evpred1| |dom| |x|))
                (COND (|bfVar#140| (RETURN |bfVar#140|))))))
             (SETQ |bfVar#139| (CDR |bfVar#139|))))
          NIL |argl| NIL))
        ((EQ |op| 'NOT) (NULL (|evalDomainOpPred,evpred1| |dom| (CAR |argl|))))
        ((SETQ |k| (POSN1 |pred| |$predicateList|))
         (|testBitVector| (ELT |dom| 3) (+ |k| 1)))
        ((EQ |op| '|HasAttribute|) (BREAK)) (#1# NIL)))
      ((EQ |pred| 'T) T)
      (#1# (|systemError| "unknown atomic predicate form"))))))
