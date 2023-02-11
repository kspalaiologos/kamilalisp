
; )package "BOOT"

(IN-PACKAGE "BOOT")

; initializeSetVariables (setTree) ==
;   -- this function passes through the table of set variable information
;   -- and initializes the variables to their default definitions.
;   for setData in setTree repeat
;     st := setData.setType
;     st = 'FUNCTION =>
;       -- here setVar is really the name of a function to call
;       if functionp(setData.setVar)
;         then FUNCALL( setData.setVar,"%initialize%")
;         else sayMSG '"   Function not implemented."
;     st = 'INTEGER  =>
;       SET(setData.setVar, setData.setDef)
;     st = 'STRING  =>
;       SET(setData.setVar, setData.setDef)
;     st = 'LITERALS =>
;       SET(setData.setVar, translateYesNo2TrueFalse setData.setDef)
;     st = 'TREE =>
;       initializeSetVariables(setData.setLeaf)

(DEFUN |initializeSetVariables| (|setTree|)
  (PROG (|st|)
    (RETURN
     ((LAMBDA (|bfVar#1| |setData|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#1|) (PROGN (SETQ |setData| (CAR |bfVar#1|)) NIL))
           (RETURN NIL))
          (#1='T
           (PROGN
            (SETQ |st| (ELT |setData| 3))
            (COND
             ((EQ |st| 'FUNCTION)
              (COND
               ((|functionp| (ELT |setData| 4))
                (FUNCALL (ELT |setData| 4) '|%initialize%|))
               (#1# (|sayMSG| "   Function not implemented."))))
             ((EQ |st| 'INTEGER) (SET (ELT |setData| 4) (ELT |setData| 6)))
             ((EQ |st| 'STRING) (SET (ELT |setData| 4) (ELT |setData| 6)))
             ((EQ |st| 'LITERALS)
              (SET (ELT |setData| 4)
                   (|translateYesNo2TrueFalse| (ELT |setData| 6))))
             ((EQ |st| 'TREE) (|initializeSetVariables| (ELT |setData| 5)))))))
         (SETQ |bfVar#1| (CDR |bfVar#1|))))
      |setTree| NIL))))

; resetWorkspaceVariables () ==
;   -- this replaces def in DEBUG LISP
;   -- this function resets many workspace variables to their default
;   -- values. Some things are reset by start and not reset by restart.
;   SETQ($count_list                  , NIL)
;   $edit_file := nil
;   SETQ($timer_list                  , NIL)
;   SETQ($CommandSynonymAlist         , COPY($InitialCommandSynonymAlist))
;   SETQ($IOindex                     , 1  )
;   SETQ($e                           , [[NIL]])
;   SETQ($env                         , [[NIL]])
;
;   -- many variables set by the following
;
;   initializeSetVariables($setOptions)

(DEFUN |resetWorkspaceVariables| ()
  (PROG ()
    (RETURN
     (PROGN
      (SETQ |$count_list| NIL)
      (SETQ |$edit_file| NIL)
      (SETQ |$timer_list| NIL)
      (SETQ |$CommandSynonymAlist| (COPY |$InitialCommandSynonymAlist|))
      (SETQ |$IOindex| 1)
      (SETQ |$e| (LIST (LIST NIL)))
      (SETQ |$env| (LIST (LIST NIL)))
      (|initializeSetVariables| |$setOptions|)))))

; translateYesNo2TrueFalse x ==
;   x in '(yes on) => true
;   x in '(no off)  => false
;   x

(DEFUN |translateYesNo2TrueFalse| (|x|)
  (PROG ()
    (RETURN
     (COND ((|member| |x| '(|yes| |on|)) T) ((|member| |x| '(|no| |off|)) NIL)
           ('T |x|)))))

; translateTrueFalse2YesNo x ==
;   x = true  => 'on
;   x = false => 'off
;   x

(DEFUN |translateTrueFalse2YesNo| (|x|)
  (PROG () (RETURN (COND ((EQUAL |x| T) '|on|) ((NULL |x|) '|off|) ('T |x|)))))

; set l ==
;   ioHook("startSysCmd", "set")
;   UNWIND_-PROTECT(set1(l, $setOptions), ioHook("endSysCmd", "set"))

(DEFUN |set| (|l|)
  (PROG ()
    (RETURN
     (PROGN
      (|ioHook| '|startSysCmd| '|set|)
      (UNWIND-PROTECT (|set1| |l| |$setOptions|)
        (|ioHook| '|endSysCmd| '|set|))))))

; set1(l,setTree) ==
;   null l => displaySetVariableSettings(setTree,"")
;   $setOptionNames : local := [x.0 for x in setTree]
;   arg := selectOption(DOWNCASE first l, $setOptionNames, 'optionError)
;   setData := [arg,:LASSOC(arg,setTree)]
;
;   -- check is the user is authorized for the set variable
;   null satisfiesUserLevel setData.setLevel =>
;     sayKeyedMsg("S2IZ0007",[$UserLevel,'"set option"])
;
;   1 = #l => displaySetOptionInformation(arg,setData)
;   st := setData.setType
;
;   st = 'FUNCTION =>
;     -- allow the user to set the default
;     setfunarg :=
;       l.1 = 'DEFAULT => "%initialize%"
; --    (arg2 := selectOption(l.1,['default],nil)) => "%initialize%"
;       IFCDR l
;     if functionp(setData.setVar)
;       then FUNCALL( setData.setVar,setfunarg)
;       else sayMSG '"   Function not implemented."
;     -- if so set, then show option information
;     if $displaySetValue then displaySetOptionInformation(arg,setData)
;     NIL
;
;   st = 'STRING   =>
;     arg2 := l.1
;     if arg2 = 'DEFAULT
;       then SET(setData.setVar, setData.setDef)
;       else if arg2 then SET(setData.setVar, arg2)
;     -- if so set or not a valid choice, then show option information
;     if $displaySetValue or (null arg2) then
;       displaySetOptionInformation(arg,setData)
;     NIL
;
;   st = 'INTEGER  =>
;     -- validate the option, allowing the user to set the default
;     arg2 :=
;       num := l.1
;       (FIXP num) and (num >= (setData.setLeaf).0) and
;         (null (upperlimit := setData.setLeaf.1) or num <= upperlimit) => num
;       selectOption(l.1,['default,:setData.setLeaf],nil)
;     if arg2 = 'DEFAULT
;       then SET(setData.setVar, setData.setDef)
;       else if arg2 then SET(setData.setVar, arg2)
;     -- if so set or not a valid choice, then show option information
;     if $displaySetValue or (null arg2) then
;       displaySetOptionInformation(arg,setData)
;     null arg2 => sayMessage ['" Your value",:bright object2String l.1,
;         '"is not among the valid choices."]
;     NIL
;
;   st = 'LITERALS =>
;     -- validate the option, allowing the user to set the default
;     if (arg2 := selectOption(l.1,['default,:setData.setLeaf],nil)) then
;       if arg2 = 'DEFAULT
;         then SET(setData.setVar, translateYesNo2TrueFalse setData.setDef)
;         else
;           SET(setData.setVar, translateYesNo2TrueFalse arg2)
;     -- if so set or not a valid choice, then show option information
;     if $displaySetValue or (null arg2) then
;       displaySetOptionInformation(arg,setData)
;     null arg2 => sayMessage ['" Your value",:bright object2String l.1,
;         '"is not among the valid choices."]
;     NIL
;
;   -- for a sub-tree, we must recurse
;   st = 'TREE =>
;     set1(IFCDR l, setData.setLeaf)
;     NIL
;   sayMessage ['"Cannot handle set tree node type",:bright st,"yet"]
;   NIL

(DEFUN |set1| (|l| |setTree|)
  (PROG (|$setOptionNames| |upperlimit| |num| |arg2| |setfunarg| |st| |setData|
         |arg|)
    (DECLARE (SPECIAL |$setOptionNames|))
    (RETURN
     (COND ((NULL |l|) (|displaySetVariableSettings| |setTree| '||))
           (#1='T
            (PROGN
             (SETQ |$setOptionNames|
                     ((LAMBDA (|bfVar#3| |bfVar#2| |x|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#2|)
                               (PROGN (SETQ |x| (CAR |bfVar#2|)) NIL))
                           (RETURN (NREVERSE |bfVar#3|)))
                          (#1# (SETQ |bfVar#3| (CONS (ELT |x| 0) |bfVar#3|))))
                         (SETQ |bfVar#2| (CDR |bfVar#2|))))
                      NIL |setTree| NIL))
             (SETQ |arg|
                     (|selectOption| (DOWNCASE (CAR |l|)) |$setOptionNames|
                      '|optionError|))
             (SETQ |setData| (CONS |arg| (LASSOC |arg| |setTree|)))
             (COND
              ((NULL (|satisfiesUserLevel| (ELT |setData| 2)))
               (|sayKeyedMsg| 'S2IZ0007 (LIST |$UserLevel| "set option")))
              ((EQL 1 (LENGTH |l|))
               (|displaySetOptionInformation| |arg| |setData|))
              (#1#
               (PROGN
                (SETQ |st| (ELT |setData| 3))
                (COND
                 ((EQ |st| 'FUNCTION)
                  (PROGN
                   (SETQ |setfunarg|
                           (COND ((EQ (ELT |l| 1) 'DEFAULT) '|%initialize%|)
                                 (#1# (IFCDR |l|))))
                   (COND
                    ((|functionp| (ELT |setData| 4))
                     (FUNCALL (ELT |setData| 4) |setfunarg|))
                    (#1# (|sayMSG| "   Function not implemented.")))
                   (COND
                    (|$displaySetValue|
                     (|displaySetOptionInformation| |arg| |setData|)))
                   NIL))
                 ((EQ |st| 'STRING)
                  (PROGN
                   (SETQ |arg2| (ELT |l| 1))
                   (COND
                    ((EQ |arg2| 'DEFAULT)
                     (SET (ELT |setData| 4) (ELT |setData| 6)))
                    (|arg2| (SET (ELT |setData| 4) |arg2|)))
                   (COND
                    ((OR |$displaySetValue| (NULL |arg2|))
                     (|displaySetOptionInformation| |arg| |setData|)))
                   NIL))
                 ((EQ |st| 'INTEGER)
                  (PROGN
                   (SETQ |arg2|
                           (PROGN
                            (SETQ |num| (ELT |l| 1))
                            (COND
                             ((AND (FIXP |num|)
                                   (NOT (< |num| (ELT (ELT |setData| 5) 0)))
                                   (OR
                                    (NULL
                                     (SETQ |upperlimit|
                                             (ELT (ELT |setData| 5) 1)))
                                    (NOT (< |upperlimit| |num|))))
                              |num|)
                             (#1#
                              (|selectOption| (ELT |l| 1)
                               (CONS '|default| (ELT |setData| 5)) NIL)))))
                   (COND
                    ((EQ |arg2| 'DEFAULT)
                     (SET (ELT |setData| 4) (ELT |setData| 6)))
                    (|arg2| (SET (ELT |setData| 4) |arg2|)))
                   (COND
                    ((OR |$displaySetValue| (NULL |arg2|))
                     (|displaySetOptionInformation| |arg| |setData|)))
                   (COND
                    ((NULL |arg2|)
                     (|sayMessage|
                      (CONS " Your value"
                            (APPEND (|bright| (|object2String| (ELT |l| 1)))
                                    (CONS "is not among the valid choices."
                                          NIL)))))
                    (#1# NIL))))
                 ((EQ |st| 'LITERALS)
                  (PROGN
                   (COND
                    ((SETQ |arg2|
                             (|selectOption| (ELT |l| 1)
                              (CONS '|default| (ELT |setData| 5)) NIL))
                     (COND
                      ((EQ |arg2| 'DEFAULT)
                       (SET (ELT |setData| 4)
                            (|translateYesNo2TrueFalse| (ELT |setData| 6))))
                      (#1#
                       (SET (ELT |setData| 4)
                            (|translateYesNo2TrueFalse| |arg2|))))))
                   (COND
                    ((OR |$displaySetValue| (NULL |arg2|))
                     (|displaySetOptionInformation| |arg| |setData|)))
                   (COND
                    ((NULL |arg2|)
                     (|sayMessage|
                      (CONS " Your value"
                            (APPEND (|bright| (|object2String| (ELT |l| 1)))
                                    (CONS "is not among the valid choices."
                                          NIL)))))
                    (#1# NIL))))
                 ((EQ |st| 'TREE)
                  (PROGN (|set1| (IFCDR |l|) (ELT |setData| 5)) NIL))
                 (#1#
                  (PROGN
                   (|sayMessage|
                    (CONS "Cannot handle set tree node type"
                          (APPEND (|bright| |st|) (CONS '|yet| NIL))))
                   NIL))))))))))))

; displaySetOptionInformation(arg,setData) ==
;   st := setData.setType
;   -- if the option is a sub-tree, show the full menu
;   st = 'TREE =>
;     displaySetVariableSettings(setData.setLeaf,setData.setName)
;
;   -- otherwise we want to show the current setting
;   centerAndHighlight (STRCONC('"The ",object2String arg,'" Option"),
;                       $LINELENGTH,specialChar 'hbar)
;   sayBrightly ['%l,:bright '"Description:",setData.setLabel]
;
;   st = 'FUNCTION =>
;     TERPRI()
;     if functionp(setData.setVar)
;       then FUNCALL(setData.setVar,"%describe%")
;       else sayMSG '"   Function not implemented."
;
;   st = 'INTEGER  =>
;     sayMessage ['" The",:bright arg,'"option",
;       '" may be followed by an integer in the range",
;        :bright (setData.setLeaf).0,'"to",'%l,
;         :bright (setData.setLeaf).1,'"inclusive.",
;          '" The current setting is",:bright eval setData.setVar]
;
;   st = 'STRING  =>
;     sayMessage ['" The",:bright arg,'"option",
;       '" is followed by a string enclosed in double quote marks.", '%l,
;          '" The current setting is",:bright ["_"",eval setData.setVar, "_""]]
;
;   st = 'LITERALS =>
;     sayMessage ['" The",:bright arg,'"option",
;       '" may be followed by any one of the following:"]
;     current := translateTrueFalse2YesNo eval setData.setVar
;     for name in setData.setLeaf repeat
;       if name = current
;         then sayBrightly ['" ->",:bright object2String name]
;         else sayBrightly ['"    ",object2String name]
;     sayMessage '" The current setting is indicated within the list."
;     if (setData.setLeaf = '(yes no on off)) or
;       (setData.setLeaf = '(yes no on off long)) then
;        sayMessage [:bright '"yes",'"and",:bright '"no",
;         '"have the same effect as",:bright '"on",'"and",:bright '"off",
;           '"respectively."]

(DEFUN |displaySetOptionInformation| (|arg| |setData|)
  (PROG (|st| |current|)
    (RETURN
     (PROGN
      (SETQ |st| (ELT |setData| 3))
      (COND
       ((EQ |st| 'TREE)
        (|displaySetVariableSettings| (ELT |setData| 5) (ELT |setData| 0)))
       (#1='T
        (PROGN
         (|centerAndHighlight|
          (STRCONC "The " (|object2String| |arg|) " Option") $LINELENGTH
          (|specialChar| '|hbar|))
         (|sayBrightly|
          (CONS '|%l|
                (APPEND (|bright| "Description:")
                        (CONS (ELT |setData| 1) NIL))))
         (COND
          ((EQ |st| 'FUNCTION)
           (PROGN
            (TERPRI)
            (COND
             ((|functionp| (ELT |setData| 4))
              (FUNCALL (ELT |setData| 4) '|%describe%|))
             (#1# (|sayMSG| "   Function not implemented.")))))
          ((EQ |st| 'INTEGER)
           (|sayMessage|
            (CONS " The"
                  (APPEND (|bright| |arg|)
                          (CONS "option"
                                (CONS
                                 " may be followed by an integer in the range"
                                 (APPEND (|bright| (ELT (ELT |setData| 5) 0))
                                         (CONS "to"
                                               (CONS '|%l|
                                                     (APPEND
                                                      (|bright|
                                                       (ELT (ELT |setData| 5)
                                                            1))
                                                      (CONS "inclusive."
                                                            (CONS
                                                             " The current setting is"
                                                             (|bright|
                                                              (|eval|
                                                               (ELT |setData|
                                                                    4)))))))))))))))
          ((EQ |st| 'STRING)
           (|sayMessage|
            (CONS " The"
                  (APPEND (|bright| |arg|)
                          (CONS "option"
                                (CONS
                                 " is followed by a string enclosed in double quote marks."
                                 (CONS '|%l|
                                       (CONS " The current setting is"
                                             (|bright|
                                              (LIST '|"|
                                                    (|eval| (ELT |setData| 4))
                                                    '|"|))))))))))
          ((EQ |st| 'LITERALS)
           (PROGN
            (|sayMessage|
             (CONS " The"
                   (APPEND (|bright| |arg|)
                           (CONS "option"
                                 (CONS
                                  " may be followed by any one of the following:"
                                  NIL)))))
            (SETQ |current|
                    (|translateTrueFalse2YesNo| (|eval| (ELT |setData| 4))))
            ((LAMBDA (|bfVar#4| |name|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#4|)
                      (PROGN (SETQ |name| (CAR |bfVar#4|)) NIL))
                  (RETURN NIL))
                 (#1#
                  (COND
                   ((EQUAL |name| |current|)
                    (|sayBrightly|
                     (CONS " ->" (|bright| (|object2String| |name|)))))
                   (#1#
                    (|sayBrightly| (LIST "    " (|object2String| |name|)))))))
                (SETQ |bfVar#4| (CDR |bfVar#4|))))
             (ELT |setData| 5) NIL)
            (|sayMessage| " The current setting is indicated within the list.")
            (COND
             ((OR (EQUAL (ELT |setData| 5) '(|yes| |no| |on| |off|))
                  (EQUAL (ELT |setData| 5) '(|yes| |no| |on| |off| |long|)))
              (|sayMessage|
               (APPEND (|bright| "yes")
                       (CONS "and"
                             (APPEND (|bright| "no")
                                     (CONS "have the same effect as"
                                           (APPEND (|bright| "on")
                                                   (CONS "and"
                                                         (APPEND
                                                          (|bright| "off")
                                                          (CONS "respectively."
                                                                NIL)))))))))))))))))))))

; displaySetVariableSettings(setTree,label) ==
;   if label = "" then label := '")set"
;     else label := STRCONC('" ",object2String label,'" ")
;   centerAndHighlight(STRCONC('"Current Values of ",label,
;     '" Variables"),$LINELENGTH," ")
;   TERPRI()
;   sayBrightly ["Variable     ",
;                "Description                                ",
;                  "Current Value"]
;   SAY fillerSpaces($LINELENGTH,specialChar 'hbar)
;   subtree := nil
;   for setData in setTree repeat
;     null satisfiesUserLevel setData.setLevel => nil
;     setOption := object2String setData.setName
;     setOption := STRCONC(setOption,fillerSpaces(13-#setOption,'" "),
;                          setData.setLabel)
;     setOption := STRCONC(setOption,fillerSpaces(55-#setOption,'" "))
;     st := setData.setType
;     st = 'FUNCTION =>
;       opt :=
;         functionp(setData.setVar) => FUNCALL( setData.setVar,"%display%")
;         '"unimplemented"
;       if PAIRP opt then opt := [:[o,'" "] for o in opt]
;       sayBrightly concat(setOption,'%b,opt,'%d)
;     st = 'STRING   =>
;       opt := object2String eval setData.setVar
;       sayBrightly [setOption,:bright opt]
;     st = 'INTEGER  =>
;       opt := object2String eval setData.setVar
;       sayBrightly [setOption,:bright opt]
;     st = 'LITERALS =>
;       opt := object2String translateTrueFalse2YesNo eval setData.setVar
;       sayBrightly [setOption,:bright opt]
;     st = 'TREE     =>
;       sayBrightly [setOption,:bright '"..."]
;       subtree := true
;       subname := object2String setData.setName
;   TERPRI()
;   subtree =>
;     sayBrightly ['"Variables with current values of",:bright '"...",
;       '"have further sub-options. For example,"]
;     sayBrightly ['"issue",:bright '")set ",subname,
;       '" to see what the options are for",:bright subname,'".",'%l,
;         '"For more information, issue",:bright '")help set",'"."]

(DEFUN |displaySetVariableSettings| (|setTree| |label|)
  (PROG (|subtree| |setOption| |st| |opt| |subname|)
    (RETURN
     (PROGN
      (COND ((EQ |label| '||) (SETQ |label| ")set"))
            (#1='T (SETQ |label| (STRCONC " " (|object2String| |label|) " "))))
      (|centerAndHighlight| (STRCONC "Current Values of " |label| " Variables")
       $LINELENGTH '| |)
      (TERPRI)
      (|sayBrightly|
       (LIST '|Variable     | '|Description                                |
             '|Current Value|))
      (SAY (|fillerSpaces| $LINELENGTH (|specialChar| '|hbar|)))
      (SETQ |subtree| NIL)
      ((LAMBDA (|bfVar#5| |setData|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#5|) (PROGN (SETQ |setData| (CAR |bfVar#5|)) NIL))
            (RETURN NIL))
           (#1#
            (COND ((NULL (|satisfiesUserLevel| (ELT |setData| 2))) NIL)
                  (#1#
                   (PROGN
                    (SETQ |setOption| (|object2String| (ELT |setData| 0)))
                    (SETQ |setOption|
                            (STRCONC |setOption|
                             (|fillerSpaces| (- 13 (LENGTH |setOption|)) " ")
                             (ELT |setData| 1)))
                    (SETQ |setOption|
                            (STRCONC |setOption|
                             (|fillerSpaces| (- 55 (LENGTH |setOption|)) " ")))
                    (SETQ |st| (ELT |setData| 3))
                    (COND
                     ((EQ |st| 'FUNCTION)
                      (PROGN
                       (SETQ |opt|
                               (COND
                                ((|functionp| (ELT |setData| 4))
                                 (FUNCALL (ELT |setData| 4) '|%display%|))
                                (#1# "unimplemented")))
                       (COND
                        ((CONSP |opt|)
                         (SETQ |opt|
                                 ((LAMBDA (|bfVar#7| |bfVar#6| |o|)
                                    (LOOP
                                     (COND
                                      ((OR (ATOM |bfVar#6|)
                                           (PROGN
                                            (SETQ |o| (CAR |bfVar#6|))
                                            NIL))
                                       (RETURN (NREVERSE |bfVar#7|)))
                                      (#1#
                                       (SETQ |bfVar#7|
                                               (APPEND (REVERSE (LIST |o| " "))
                                                       |bfVar#7|))))
                                     (SETQ |bfVar#6| (CDR |bfVar#6|))))
                                  NIL |opt| NIL))))
                       (|sayBrightly|
                        (|concat| |setOption| '|%b| |opt| '|%d|))))
                     ((EQ |st| 'STRING)
                      (PROGN
                       (SETQ |opt|
                               (|object2String| (|eval| (ELT |setData| 4))))
                       (|sayBrightly| (CONS |setOption| (|bright| |opt|)))))
                     ((EQ |st| 'INTEGER)
                      (PROGN
                       (SETQ |opt|
                               (|object2String| (|eval| (ELT |setData| 4))))
                       (|sayBrightly| (CONS |setOption| (|bright| |opt|)))))
                     ((EQ |st| 'LITERALS)
                      (PROGN
                       (SETQ |opt|
                               (|object2String|
                                (|translateTrueFalse2YesNo|
                                 (|eval| (ELT |setData| 4)))))
                       (|sayBrightly| (CONS |setOption| (|bright| |opt|)))))
                     ((EQ |st| 'TREE)
                      (PROGN
                       (|sayBrightly| (CONS |setOption| (|bright| "...")))
                       (SETQ |subtree| T)
                       (SETQ |subname|
                               (|object2String| (ELT |setData| 0)))))))))))
          (SETQ |bfVar#5| (CDR |bfVar#5|))))
       |setTree| NIL)
      (TERPRI)
      (COND
       (|subtree|
        (PROGN
         (|sayBrightly|
          (CONS "Variables with current values of"
                (APPEND (|bright| "...")
                        (CONS "have further sub-options. For example," NIL))))
         (|sayBrightly|
          (CONS "issue"
                (APPEND (|bright| ")set ")
                        (CONS |subname|
                              (CONS " to see what the options are for"
                                    (APPEND (|bright| |subname|)
                                            (CONS "."
                                                  (CONS '|%l|
                                                        (CONS
                                                         "For more information, issue"
                                                         (APPEND
                                                          (|bright|
                                                           ")help set")
                                                          (CONS "."
                                                                NIL))))))))))))))))))

; setAsharpArgs arg ==
;   arg = "%initialize%" =>
;     $asharpCmdlineFlags := '"-O -Fasy -Fao -Flsp -lfricas -Mno-ALDOR__W__WillObsolete -DFriCAS -Y $FRICAS/algebra -I $FRICAS/algebra"
;   arg = "%display%" =>
;     $asharpCmdlineFlags
;   (null arg) or (arg = "%describe%") or (first arg = '_?) =>
;     describeAsharpArgs()
;   $asharpCmdlineFlags := first(arg)

(DEFUN |setAsharpArgs| (|arg|)
  (PROG ()
    (RETURN
     (COND
      ((EQ |arg| '|%initialize%|)
       (SETQ |$asharpCmdlineFlags|
               "-O -Fasy -Fao -Flsp -lfricas -Mno-ALDOR_W_WillObsolete -DFriCAS -Y $FRICAS/algebra -I $FRICAS/algebra"))
      ((EQ |arg| '|%display%|) |$asharpCmdlineFlags|)
      ((OR (NULL |arg|) (EQ |arg| '|%describe%|) (EQ (CAR |arg|) '?))
       (|describeAsharpArgs|))
      ('T (SETQ |$asharpCmdlineFlags| (CAR |arg|)))))))

; describeAsharpArgs() ==
;   sayBrightly LIST (
;    '%b,'")set compiler args ",'%d,_
;    '"is used to tell FriCAS how to invoke the library compiler ",'%l,_
;    '" when compiling code for FriCAS.",'%l,_
;    '" The args option is followed by a string enclosed in double quotes.",'%l,'%l,_
;    '" The current setting is",'%l,'%b,'"_"",$asharpCmdlineFlags,'"_"",'%d)

(DEFUN |describeAsharpArgs| ()
  (PROG ()
    (RETURN
     (|sayBrightly|
      (LIST '|%b| ")set compiler args " '|%d|
            "is used to tell FriCAS how to invoke the library compiler " '|%l|
            " when compiling code for FriCAS." '|%l|
            " The args option is followed by a string enclosed in double quotes."
            '|%l| '|%l| " The current setting is" '|%l| '|%b| "\""
            |$asharpCmdlineFlags| "\"" '|%d|)))))

; setInputLibrary arg ==
;   arg = "%initialize%" =>
;    true
;   nil

(DEFUN |setInputLibrary| (|arg|)
  (PROG () (RETURN (COND ((EQ |arg| '|%initialize%|) T) ('T NIL)))))

; setOutputLibrary arg == false

(DEFUN |setOutputLibrary| (|arg|) (PROG () (RETURN NIL)))

; describeOutputLibraryArgs() ==
;   sayBrightly LIST (
;    '%b,'")set compiler output library",'%d,_
;    '"is used to tell the compiler where to place", '%l,_
;    '"compiled code generated by the library compiler.  By default it goes",'%l,_
;    '"in a file called",'%b, '"user.lib", '%d, '"in the current directory."
;     )

(DEFUN |describeOutputLibraryArgs| ()
  (PROG ()
    (RETURN
     (|sayBrightly|
      (LIST '|%b| ")set compiler output library" '|%d|
            "is used to tell the compiler where to place" '|%l|
            "compiled code generated by the library compiler.  By default it goes"
            '|%l| "in a file called" '|%b| "user.lib" '|%d|
            "in the current directory.")))))

; describeInputLibraryArgs() ==
;   sayBrightly LIST (
;    '%b,'")set compiler input add library",'%d,_
;    '"is used to tell FriCAS to add", '%b, '"library", '%d, '"to",'%l,
;    '"the front of the path which determines where compiled code is loaded from.",_
;    '%l, '%b,'")set compiler input drop library",'%d,_
;    '"is used to tell FriCAS to remove", '%b, '"library", '%d, '%l,_
;    '"from this path."
;     )

(DEFUN |describeInputLibraryArgs| ()
  (PROG ()
    (RETURN
     (|sayBrightly|
      (LIST '|%b| ")set compiler input add library" '|%d|
            "is used to tell FriCAS to add" '|%b| "library" '|%d| "to" '|%l|
            "the front of the path which determines where compiled code is loaded from."
            '|%l| '|%b| ")set compiler input drop library" '|%d|
            "is used to tell FriCAS to remove" '|%b| "library" '|%d| '|%l|
            "from this path.")))))

; setExpose arg ==
;   arg = "%initialize%" => loadExposureGroupData()
;   arg = "%display%" => '"..."
;
;   (null arg) or (arg = "%describe%") or (first arg = '_?) =>
;     --  give msg about exposure groups
;     displayExposedGroups()
;     --  give msg about explicitly exposed constructors
;     sayMSG '" "
;     displayExposedConstructors()
;     --  give msg about explicitly hidden constructors
;     sayMSG '" "
;     displayHiddenConstructors()
;     -- give some more details
;     sayMSG '" "
;     sayKeyedMsg("S2IZ0049D",[namestring pathname ["INTERP","EXPOSED"]])
;
;   arg is [fn,:fnargs] and (fn := selectOptionLC(fn,
;     '(add drop initialize),NIL)) =>
;       fn = 'add  =>  setExposeAdd fnargs
;       fn = 'drop =>  setExposeDrop fnargs
;       fn = 'initialize => setExpose "%initialize%"
;       NIL
;   setExpose NIL

(DEFUN |setExpose| (|arg|)
  (PROG (|fn| |fnargs|)
    (RETURN
     (COND ((EQ |arg| '|%initialize%|) (|loadExposureGroupData|))
           ((EQ |arg| '|%display%|) "...")
           ((OR (NULL |arg|) (EQ |arg| '|%describe%|) (EQ (CAR |arg|) '?))
            (PROGN
             (|displayExposedGroups|)
             (|sayMSG| " ")
             (|displayExposedConstructors|)
             (|sayMSG| " ")
             (|displayHiddenConstructors|)
             (|sayMSG| " ")
             (|sayKeyedMsg| 'S2IZ0049D
              (LIST (|namestring| (|pathname| (LIST 'INTERP 'EXPOSED)))))))
           ((AND (CONSP |arg|)
                 (PROGN
                  (SETQ |fn| (CAR |arg|))
                  (SETQ |fnargs| (CDR |arg|))
                  #1='T)
                 (SETQ |fn|
                         (|selectOptionLC| |fn| '(|add| |drop| |initialize|)
                          NIL)))
            (COND ((EQ |fn| '|add|) (|setExposeAdd| |fnargs|))
                  ((EQ |fn| '|drop|) (|setExposeDrop| |fnargs|))
                  ((EQ |fn| '|initialize|) (|setExpose| '|%initialize%|))
                  (#1# NIL)))
           (#1# (|setExpose| NIL))))))

; setExposeAdd arg ==
;   (null arg) =>
;     centerAndHighlight ("The add Option",$LINELENGTH,specialChar 'hbar)
;     --  give msg about exposure groups
;     displayExposedGroups()
;     --  give msg about explicitly exposed constructors
;     sayMSG '" "
;     displayExposedConstructors()
;     sayMSG '" "
;     sayKeyedMsg("S2IZ0049E",NIL)
;   arg is [fn,:fnargs] and (fn := selectOptionLC(fn,
;     '(group constructor),NIL)) =>
;       fn = 'group  =>  setExposeAddGroup fnargs
;       fn = 'constructor =>  setExposeAddConstr fnargs
;       NIL
;   setExposeAdd NIL

(DEFUN |setExposeAdd| (|arg|)
  (PROG (|fn| |fnargs|)
    (RETURN
     (COND
      ((NULL |arg|)
       (PROGN
        (|centerAndHighlight| '|The add Option| $LINELENGTH
         (|specialChar| '|hbar|))
        (|displayExposedGroups|)
        (|sayMSG| " ")
        (|displayExposedConstructors|)
        (|sayMSG| " ")
        (|sayKeyedMsg| 'S2IZ0049E NIL)))
      ((AND (CONSP |arg|)
            (PROGN (SETQ |fn| (CAR |arg|)) (SETQ |fnargs| (CDR |arg|)) #1='T)
            (SETQ |fn| (|selectOptionLC| |fn| '(|group| |constructor|) NIL)))
       (COND ((EQ |fn| '|group|) (|setExposeAddGroup| |fnargs|))
             ((EQ |fn| '|constructor|) (|setExposeAddConstr| |fnargs|))
             (#1# NIL)))
      (#1# (|setExposeAdd| NIL))))))

; setExposeAddGroup arg ==
;   (null arg) =>
;     centerAndHighlight("The group Option",$LINELENGTH,specialChar 'hbar)
;     --  give msg about exposure groups
;     displayExposedGroups()
;     sayMSG '" "
;     sayKeyedMsg("S2IZ0049G",[namestring pathname ["INTERP","EXPOSED"]])
;     sayMSG '" "
;     sayAsManyPerLineAsPossible [object2String first x for x in
;       $globalExposureGroupAlist]
;   for x in arg repeat
;     if PAIRP x then x := QCAR x
;     x = 'all =>
;       $localExposureData.0 :=[first x for x in $globalExposureGroupAlist]
;       $localExposureData.1 :=NIL
;       $localExposureData.2 :=NIL
;       displayExposedGroups()
;       sayMSG '" "
;       displayExposedConstructors()
;       sayMSG '" "
;       displayHiddenConstructors()
;       clearClams()
;     null GETALIST($globalExposureGroupAlist,x) =>
;       sayKeyedMsg("S2IZ0049H",[x])
;     member(x,$localExposureData.0) =>
;       sayKeyedMsg("S2IZ0049I",[x,$interpreterFrameName])
;     $localExposureData.0 := MSORT cons(x,$localExposureData.0)
;     sayKeyedMsg("S2IZ0049R",[x,$interpreterFrameName])
;     clearClams()

(DEFUN |setExposeAddGroup| (|arg|)
  (PROG ()
    (RETURN
     (COND
      ((NULL |arg|)
       (PROGN
        (|centerAndHighlight| '|The group Option| $LINELENGTH
         (|specialChar| '|hbar|))
        (|displayExposedGroups|)
        (|sayMSG| " ")
        (|sayKeyedMsg| 'S2IZ0049G
         (LIST (|namestring| (|pathname| (LIST 'INTERP 'EXPOSED)))))
        (|sayMSG| " ")
        (|sayAsManyPerLineAsPossible|
         ((LAMBDA (|bfVar#9| |bfVar#8| |x|)
            (LOOP
             (COND
              ((OR (ATOM |bfVar#8|) (PROGN (SETQ |x| (CAR |bfVar#8|)) NIL))
               (RETURN (NREVERSE |bfVar#9|)))
              (#1='T
               (SETQ |bfVar#9| (CONS (|object2String| (CAR |x|)) |bfVar#9|))))
             (SETQ |bfVar#8| (CDR |bfVar#8|))))
          NIL |$globalExposureGroupAlist| NIL))))
      (#1#
       ((LAMBDA (|bfVar#10| |x|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#10|) (PROGN (SETQ |x| (CAR |bfVar#10|)) NIL))
             (RETURN NIL))
            (#1#
             (PROGN
              (COND ((CONSP |x|) (SETQ |x| (QCAR |x|))))
              (COND
               ((EQ |x| '|all|)
                (PROGN
                 (SETF (ELT |$localExposureData| 0)
                         ((LAMBDA (|bfVar#12| |bfVar#11| |x|)
                            (LOOP
                             (COND
                              ((OR (ATOM |bfVar#11|)
                                   (PROGN (SETQ |x| (CAR |bfVar#11|)) NIL))
                               (RETURN (NREVERSE |bfVar#12|)))
                              (#1#
                               (SETQ |bfVar#12| (CONS (CAR |x|) |bfVar#12|))))
                             (SETQ |bfVar#11| (CDR |bfVar#11|))))
                          NIL |$globalExposureGroupAlist| NIL))
                 (SETF (ELT |$localExposureData| 1) NIL)
                 (SETF (ELT |$localExposureData| 2) NIL)
                 (|displayExposedGroups|)
                 (|sayMSG| " ")
                 (|displayExposedConstructors|)
                 (|sayMSG| " ")
                 (|displayHiddenConstructors|)
                 (|clearClams|)))
               ((NULL (GETALIST |$globalExposureGroupAlist| |x|))
                (|sayKeyedMsg| 'S2IZ0049H (LIST |x|)))
               ((|member| |x| (ELT |$localExposureData| 0))
                (|sayKeyedMsg| 'S2IZ0049I (LIST |x| |$interpreterFrameName|)))
               (#1#
                (PROGN
                 (SETF (ELT |$localExposureData| 0)
                         (MSORT (CONS |x| (ELT |$localExposureData| 0))))
                 (|sayKeyedMsg| 'S2IZ0049R (LIST |x| |$interpreterFrameName|))
                 (|clearClams|)))))))
           (SETQ |bfVar#10| (CDR |bfVar#10|))))
        |arg| NIL))))))

; setExposeAddConstr arg ==
;   (null arg) =>
;     centerAndHighlight ("The constructor Option",$LINELENGTH,
;       specialChar 'hbar)
;     --  give msg about explicitly exposed constructors
;     displayExposedConstructors()
;   for x in arg repeat
;     x := unabbrev x
;     if PAIRP x then x := QCAR x
;     -- if the constructor is known, we know what type it is
;     null GETDATABASE(x,'CONSTRUCTORKIND) =>
;       sayKeyedMsg("S2IZ0049J",[x])
;     member(x,$localExposureData.1) =>
;       sayKeyedMsg("S2IZ0049K",[x,$interpreterFrameName])
;     -- if the constructor is explicitly hidden, then remove that
;     if member(x,$localExposureData.2) then
;       $localExposureData.2 := delete(x,$localExposureData.2)
;     $localExposureData.1 := MSORT cons(x,$localExposureData.1)
;     clearClams()
;     sayKeyedMsg("S2IZ0049P",[x,$interpreterFrameName])

(DEFUN |setExposeAddConstr| (|arg|)
  (PROG ()
    (RETURN
     (COND
      ((NULL |arg|)
       (PROGN
        (|centerAndHighlight| '|The constructor Option| $LINELENGTH
         (|specialChar| '|hbar|))
        (|displayExposedConstructors|)))
      (#1='T
       ((LAMBDA (|bfVar#13| |x|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#13|) (PROGN (SETQ |x| (CAR |bfVar#13|)) NIL))
             (RETURN NIL))
            (#1#
             (PROGN
              (SETQ |x| (|unabbrev| |x|))
              (COND ((CONSP |x|) (SETQ |x| (QCAR |x|))))
              (COND
               ((NULL (GETDATABASE |x| 'CONSTRUCTORKIND))
                (|sayKeyedMsg| 'S2IZ0049J (LIST |x|)))
               ((|member| |x| (ELT |$localExposureData| 1))
                (|sayKeyedMsg| 'S2IZ0049K (LIST |x| |$interpreterFrameName|)))
               (#1#
                (PROGN
                 (COND
                  ((|member| |x| (ELT |$localExposureData| 2))
                   (SETF (ELT |$localExposureData| 2)
                           (|delete| |x| (ELT |$localExposureData| 2)))))
                 (SETF (ELT |$localExposureData| 1)
                         (MSORT (CONS |x| (ELT |$localExposureData| 1))))
                 (|clearClams|)
                 (|sayKeyedMsg| 'S2IZ0049P
                  (LIST |x| |$interpreterFrameName|))))))))
           (SETQ |bfVar#13| (CDR |bfVar#13|))))
        |arg| NIL))))))

; setExposeDrop arg ==
;   (null arg) =>
;     centerAndHighlight ("The drop Option",$LINELENGTH,specialChar 'hbar)
;     --  give msg about explicitly hidden constructors
;     displayHiddenConstructors()
;     sayMSG '" "
;     sayKeyedMsg("S2IZ0049F",NIL)
;   arg is [fn,:fnargs] and (fn := selectOptionLC(fn,
;     '(group constructor),NIL)) =>
;       fn = 'group  =>  setExposeDropGroup fnargs
;       fn = 'constructor =>  setExposeDropConstr fnargs
;       NIL
;   setExposeDrop NIL

(DEFUN |setExposeDrop| (|arg|)
  (PROG (|fn| |fnargs|)
    (RETURN
     (COND
      ((NULL |arg|)
       (PROGN
        (|centerAndHighlight| '|The drop Option| $LINELENGTH
         (|specialChar| '|hbar|))
        (|displayHiddenConstructors|)
        (|sayMSG| " ")
        (|sayKeyedMsg| 'S2IZ0049F NIL)))
      ((AND (CONSP |arg|)
            (PROGN (SETQ |fn| (CAR |arg|)) (SETQ |fnargs| (CDR |arg|)) #1='T)
            (SETQ |fn| (|selectOptionLC| |fn| '(|group| |constructor|) NIL)))
       (COND ((EQ |fn| '|group|) (|setExposeDropGroup| |fnargs|))
             ((EQ |fn| '|constructor|) (|setExposeDropConstr| |fnargs|))
             (#1# NIL)))
      (#1# (|setExposeDrop| NIL))))))

; setExposeDropGroup arg ==
;   (null arg) =>
;     centerAndHighlight ("The group Option",$LINELENGTH,specialChar 'hbar)
;     sayKeyedMsg("S2IZ0049L",NIL)
;     sayMSG '" "
;     displayExposedGroups()
;   for x in arg repeat
;     if PAIRP x then x := QCAR x
;     x = 'all =>
;       $localExposureData.0 := NIL
;       $localExposureData.1 := NIL
;       $localExposureData.2 := NIL
;       displayExposedGroups()
;       sayMSG '" "
;       displayExposedConstructors()
;       sayMSG '" "
;       displayHiddenConstructors()
;       clearClams()
;     member(x,$localExposureData.0) =>
;       $localExposureData.0 := delete(x,$localExposureData.0)
;       clearClams()
;       sayKeyedMsg("S2IZ0049S",[x,$interpreterFrameName])
;     GETALIST($globalExposureGroupAlist,x) =>
;       sayKeyedMsg("S2IZ0049I",[x,$interpreterFrameName])
;     sayKeyedMsg("S2IZ0049H",[x])

(DEFUN |setExposeDropGroup| (|arg|)
  (PROG ()
    (RETURN
     (COND
      ((NULL |arg|)
       (PROGN
        (|centerAndHighlight| '|The group Option| $LINELENGTH
         (|specialChar| '|hbar|))
        (|sayKeyedMsg| 'S2IZ0049L NIL)
        (|sayMSG| " ")
        (|displayExposedGroups|)))
      (#1='T
       ((LAMBDA (|bfVar#14| |x|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#14|) (PROGN (SETQ |x| (CAR |bfVar#14|)) NIL))
             (RETURN NIL))
            (#1#
             (PROGN
              (COND ((CONSP |x|) (SETQ |x| (QCAR |x|))))
              (COND
               ((EQ |x| '|all|)
                (PROGN
                 (SETF (ELT |$localExposureData| 0) NIL)
                 (SETF (ELT |$localExposureData| 1) NIL)
                 (SETF (ELT |$localExposureData| 2) NIL)
                 (|displayExposedGroups|)
                 (|sayMSG| " ")
                 (|displayExposedConstructors|)
                 (|sayMSG| " ")
                 (|displayHiddenConstructors|)
                 (|clearClams|)))
               ((|member| |x| (ELT |$localExposureData| 0))
                (PROGN
                 (SETF (ELT |$localExposureData| 0)
                         (|delete| |x| (ELT |$localExposureData| 0)))
                 (|clearClams|)
                 (|sayKeyedMsg| 'S2IZ0049S
                  (LIST |x| |$interpreterFrameName|))))
               ((GETALIST |$globalExposureGroupAlist| |x|)
                (|sayKeyedMsg| 'S2IZ0049I (LIST |x| |$interpreterFrameName|)))
               (#1# (|sayKeyedMsg| 'S2IZ0049H (LIST |x|)))))))
           (SETQ |bfVar#14| (CDR |bfVar#14|))))
        |arg| NIL))))))

; setExposeDropConstr arg ==
;   (null arg) =>
;     centerAndHighlight ("The constructor Option",$LINELENGTH,
;       specialChar 'hbar)
;     sayKeyedMsg("S2IZ0049N",NIL)
;     sayMSG '" "
;     displayExposedConstructors()
;     sayMSG '" "
;     displayHiddenConstructors()
;   for x in arg repeat
;     x := unabbrev x
;     if PAIRP x then x := QCAR x
;     -- if the constructor is known, we know what type it is
;     null GETDATABASE(x,'CONSTRUCTORKIND) =>
;       sayKeyedMsg("S2IZ0049J",[x])
;     member(x,$localExposureData.2) =>
;       sayKeyedMsg("S2IZ0049O",[x,$interpreterFrameName])
;     if member(x,$localExposureData.1) then
;       $localExposureData.1 := delete(x,$localExposureData.1)
;     $localExposureData.2 := MSORT cons(x,$localExposureData.2)
;     clearClams()
;     sayKeyedMsg("S2IZ0049Q",[x,$interpreterFrameName])

(DEFUN |setExposeDropConstr| (|arg|)
  (PROG ()
    (RETURN
     (COND
      ((NULL |arg|)
       (PROGN
        (|centerAndHighlight| '|The constructor Option| $LINELENGTH
         (|specialChar| '|hbar|))
        (|sayKeyedMsg| 'S2IZ0049N NIL)
        (|sayMSG| " ")
        (|displayExposedConstructors|)
        (|sayMSG| " ")
        (|displayHiddenConstructors|)))
      (#1='T
       ((LAMBDA (|bfVar#15| |x|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#15|) (PROGN (SETQ |x| (CAR |bfVar#15|)) NIL))
             (RETURN NIL))
            (#1#
             (PROGN
              (SETQ |x| (|unabbrev| |x|))
              (COND ((CONSP |x|) (SETQ |x| (QCAR |x|))))
              (COND
               ((NULL (GETDATABASE |x| 'CONSTRUCTORKIND))
                (|sayKeyedMsg| 'S2IZ0049J (LIST |x|)))
               ((|member| |x| (ELT |$localExposureData| 2))
                (|sayKeyedMsg| 'S2IZ0049O (LIST |x| |$interpreterFrameName|)))
               (#1#
                (PROGN
                 (COND
                  ((|member| |x| (ELT |$localExposureData| 1))
                   (SETF (ELT |$localExposureData| 1)
                           (|delete| |x| (ELT |$localExposureData| 1)))))
                 (SETF (ELT |$localExposureData| 2)
                         (MSORT (CONS |x| (ELT |$localExposureData| 2))))
                 (|clearClams|)
                 (|sayKeyedMsg| 'S2IZ0049Q
                  (LIST |x| |$interpreterFrameName|))))))))
           (SETQ |bfVar#15| (CDR |bfVar#15|))))
        |arg| NIL))))))

; setFunctionsCache arg ==
;   $options : local := NIL
;   arg = "%initialize%" =>
;     $cacheCount := 0
;     $cacheAlist := NIL
;   arg = "%display%" =>
;     null $cacheAlist => object2String $cacheCount
;     '"..."
;   (null arg) or (arg = "%describe%") or (first arg = '_?) =>
;     describeSetFunctionsCache()
;     TERPRI()
;     sayAllCacheCounts()
;   n := first arg
;   (n ~= 'all) and ((not FIXP n) or (n < 0)) =>
;     sayMessage ['"Your value of",:bright n,'"is invalid because ..."]
;     describeSetFunctionsCache()
;     terminateSystemCommand()
;   if (rest arg) then $options := [['vars,:rest arg]]
;   countCache n

(DEFUN |setFunctionsCache| (|arg|)
  (PROG (|$options| |n|)
    (DECLARE (SPECIAL |$options|))
    (RETURN
     (PROGN
      (SETQ |$options| NIL)
      (COND
       ((EQ |arg| '|%initialize%|)
        (PROGN (SETQ |$cacheCount| 0) (SETQ |$cacheAlist| NIL)))
       ((EQ |arg| '|%display%|)
        (COND ((NULL |$cacheAlist|) (|object2String| |$cacheCount|))
              (#1='T "...")))
       ((OR (NULL |arg|) (EQ |arg| '|%describe%|) (EQ (CAR |arg|) '?))
        (PROGN (|describeSetFunctionsCache|) (TERPRI) (|sayAllCacheCounts|)))
       (#1#
        (PROGN
         (SETQ |n| (CAR |arg|))
         (COND
          ((AND (NOT (EQ |n| '|all|)) (OR (NULL (FIXP |n|)) (MINUSP |n|)))
           (PROGN
            (|sayMessage|
             (CONS "Your value of"
                   (APPEND (|bright| |n|)
                           (CONS "is invalid because ..." NIL))))
            (|describeSetFunctionsCache|)
            (|terminateSystemCommand|)))
          (#1#
           (PROGN
            (COND
             ((CDR |arg|) (SETQ |$options| (LIST (CONS '|vars| (CDR |arg|))))))
            (|countCache| |n|)))))))))))

; countCache n ==
;   $options =>
;     $options is [["vars",:l]] =>
;       for x in l repeat
;         NULL IDENTP x => sayKeyedMsg("S2IF0007",[x])
;         $cacheAlist:= insertAlist(x,n,$cacheAlist)
;         cacheCountName := INTERNL1(x, '";COUNT")
;         SET(cacheCountName,n)
;         sayCacheCount(x,n)
;     optionError(CAAR $options,nil)
;   sayCacheCount(nil,$cacheCount:= n)

(DEFUN |countCache| (|n|)
  (PROG (|ISTMP#1| |l| |cacheCountName|)
    (RETURN
     (COND
      (|$options|
       (COND
        ((AND (CONSP |$options|) (EQ (CDR |$options|) NIL)
              (PROGN
               (SETQ |ISTMP#1| (CAR |$options|))
               (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|vars|)
                    (PROGN (SETQ |l| (CDR |ISTMP#1|)) #1='T))))
         ((LAMBDA (|bfVar#16| |x|)
            (LOOP
             (COND
              ((OR (ATOM |bfVar#16|) (PROGN (SETQ |x| (CAR |bfVar#16|)) NIL))
               (RETURN NIL))
              (#1#
               (COND ((NULL (IDENTP |x|)) (|sayKeyedMsg| 'S2IF0007 (LIST |x|)))
                     (#1#
                      (PROGN
                       (SETQ |$cacheAlist|
                               (|insertAlist| |x| |n| |$cacheAlist|))
                       (SETQ |cacheCountName| (INTERNL1 |x| ";COUNT"))
                       (SET |cacheCountName| |n|)
                       (|sayCacheCount| |x| |n|))))))
             (SETQ |bfVar#16| (CDR |bfVar#16|))))
          |l| NIL))
        (#1# (|optionError| (CAAR |$options|) NIL))))
      (#1# (|sayCacheCount| NIL (SETQ |$cacheCount| |n|)))))))

; describeSetFunctionsCache() ==
;   sayBrightly LIST(
;     '%b,'")set functions cache",'%d,'"is used to tell FriCAS how many",'%l,_
;     '" values computed by interpreter functions should be saved.  This can save ",'%l, _
;     '" quite a bit of time in recursive functions, though one must consider that",'%l,_
;     '" the cached values will take up (perhaps valuable) room in the workspace.",'%l,'%l,_
;     '" The value given  after",'%b,'"cache",'%d,'"must either be the",_
;     '" word",'%b,'"all",'%d,'"or a positive",'%l,_
;     '" integer.  This may be followed by any number of function names whose cache",'%l,_
;     '" sizes you wish to so set.  If no functions are given, the default cache",'%l,_
;     '" size is set.",'%l,'" Examples:",_
;     '"   )set fun cache all         )set fun cache 10 f g Legendre")

(DEFUN |describeSetFunctionsCache| ()
  (PROG ()
    (RETURN
     (|sayBrightly|
      (LIST '|%b| ")set functions cache" '|%d|
            "is used to tell FriCAS how many" '|%l|
            " values computed by interpreter functions should be saved.  This can save "
            '|%l|
            " quite a bit of time in recursive functions, though one must consider that"
            '|%l|
            " the cached values will take up (perhaps valuable) room in the workspace."
            '|%l| '|%l| " The value given  after" '|%b| "cache" '|%d|
            "must either be the" " word" '|%b| "all" '|%d| "or a positive"
            '|%l|
            " integer.  This may be followed by any number of function names whose cache"
            '|%l|
            " sizes you wish to so set.  If no functions are given, the default cache"
            '|%l| " size is set." '|%l| " Examples:"
            "   )set fun cache all         )set fun cache 10 f g Legendre")))))

; sayAllCacheCounts () ==
;   sayCacheCount(nil,$cacheCount)
;   $cacheAlist =>
;     TERPRI()
; --    SAY '" However,"
;     for [x,:n] in $cacheAlist | n ~= $cacheCount repeat sayCacheCount(x,n)

(DEFUN |sayAllCacheCounts| ()
  (PROG (|n| |x|)
    (RETURN
     (PROGN
      (|sayCacheCount| NIL |$cacheCount|)
      (COND
       (|$cacheAlist|
        (PROGN
         (TERPRI)
         ((LAMBDA (|bfVar#18| |bfVar#17|)
            (LOOP
             (COND
              ((OR (ATOM |bfVar#18|)
                   (PROGN (SETQ |bfVar#17| (CAR |bfVar#18|)) NIL))
               (RETURN NIL))
              (#1='T
               (AND (CONSP |bfVar#17|)
                    (PROGN
                     (SETQ |x| (CAR |bfVar#17|))
                     (SETQ |n| (CDR |bfVar#17|))
                     #1#)
                    (NOT (EQUAL |n| |$cacheCount|))
                    (|sayCacheCount| |x| |n|))))
             (SETQ |bfVar#18| (CDR |bfVar#18|))))
          |$cacheAlist| NIL))))))))

; sayCacheCount(fn,n) ==
;   prefix:=
;     fn => ["function",:bright linearFormatName fn]
;     n = 0 => ["interpreter functions "]
;     ["In general, interpreter functions "]
;   n = 0 =>
;     fn =>
;       sayBrightly ['"   Caching for ",:prefix,
;         '"is turned off"]
;     sayBrightly '" In general, functions will cache no returned values."
;   phrase:=
;     n="all" => [:bright "all","values."]
;     n=1 => [" only the last value."]
;     [" the last",:bright n,"values."]
;   sayBrightly ['"   ",:prefix,'"will cache",:phrase]

(DEFUN |sayCacheCount| (|fn| |n|)
  (PROG (|prefix| |phrase|)
    (RETURN
     (PROGN
      (SETQ |prefix|
              (COND
               (|fn| (CONS '|function| (|bright| (|linearFormatName| |fn|))))
               ((EQL |n| 0) (LIST '|interpreter functions |))
               (#1='T (LIST '|In general, interpreter functions |))))
      (COND
       ((EQL |n| 0)
        (COND
         (|fn|
          (|sayBrightly|
           (CONS "   Caching for "
                 (APPEND |prefix| (CONS "is turned off" NIL)))))
         (#1#
          (|sayBrightly|
           " In general, functions will cache no returned values."))))
       (#1#
        (PROGN
         (SETQ |phrase|
                 (COND
                  ((EQ |n| '|all|)
                   (APPEND (|bright| '|all|) (CONS '|values.| NIL)))
                  ((EQL |n| 1) (LIST '| only the last value.|))
                  (#1#
                   (CONS '| the last|
                         (APPEND (|bright| |n|) (CONS '|values.| NIL))))))
         (|sayBrightly|
          (CONS "   " (APPEND |prefix| (CONS "will cache" |phrase|)))))))))))

; setHistory arg ==
;   -- this is just a front end for the history functions
;   arg = "%initialize%" => nil
;
;   current := object2String translateTrueFalse2YesNo $HiFiAccess
;   arg = "%display%" => current
;
;   (null arg) or (arg = "%describe%") or (first arg = '_?) =>
;     sayMessage ['" The",:bright '"history",'"option",
;       '" may be followed by any one of the following:"]
;     for name in '("on" "off" "yes" "no") repeat
;       if name = current
;         then sayBrightly ['" ->",:bright name]
;         else sayBrightly ['"    ",name]
;     TERPRI()
;     sayBrightly '" The current setting is indicated within the list."
;     sayBrightly [:bright '"yes",'"and",:bright '"no",
;      '"have the same effect as",:bright '"on",'"and",:bright '"off",
;        '"respectively."]
;     if $useInternalHistoryTable
;       then wh := '"memory"
;       else wh := '"a file"
;     sayBrightly ['%l,'" When the history facility is active, the data",
;       '" is kept in ",wh,'"."]
;     sayMessage ['" Issue",:bright '")help history",
;       '"for more information."]
;
;   arg is [fn] and
;    (fn := DOWNCASE(fn)) in '(y n ye yes no on of off) =>
;     $options := [[fn]]
;     historySpad2Cmd()
;   setHistory NIL

(DEFUN |setHistory| (|arg|)
  (PROG (|current| |wh| |fn|)
    (RETURN
     (COND ((EQ |arg| '|%initialize%|) NIL)
           (#1='T
            (PROGN
             (SETQ |current|
                     (|object2String|
                      (|translateTrueFalse2YesNo| |$HiFiAccess|)))
             (COND ((EQ |arg| '|%display%|) |current|)
                   ((OR (NULL |arg|) (EQ |arg| '|%describe%|)
                        (EQ (CAR |arg|) '?))
                    (PROGN
                     (|sayMessage|
                      (CONS " The"
                            (APPEND (|bright| "history")
                                    (CONS "option"
                                          (CONS
                                           " may be followed by any one of the following:"
                                           NIL)))))
                     ((LAMBDA (|bfVar#19| |name|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#19|)
                               (PROGN (SETQ |name| (CAR |bfVar#19|)) NIL))
                           (RETURN NIL))
                          (#1#
                           (COND
                            ((EQUAL |name| |current|)
                             (|sayBrightly| (CONS " ->" (|bright| |name|))))
                            (#1# (|sayBrightly| (LIST "    " |name|))))))
                         (SETQ |bfVar#19| (CDR |bfVar#19|))))
                      '("on" "off" "yes" "no") NIL)
                     (TERPRI)
                     (|sayBrightly|
                      " The current setting is indicated within the list.")
                     (|sayBrightly|
                      (APPEND (|bright| "yes")
                              (CONS "and"
                                    (APPEND (|bright| "no")
                                            (CONS "have the same effect as"
                                                  (APPEND (|bright| "on")
                                                          (CONS "and"
                                                                (APPEND
                                                                 (|bright|
                                                                  "off")
                                                                 (CONS
                                                                  "respectively."
                                                                  NIL)))))))))
                     (COND (|$useInternalHistoryTable| (SETQ |wh| "memory"))
                           (#1# (SETQ |wh| "a file")))
                     (|sayBrightly|
                      (LIST '|%l|
                            " When the history facility is active, the data"
                            " is kept in " |wh| "."))
                     (|sayMessage|
                      (CONS " Issue"
                            (APPEND (|bright| ")help history")
                                    (CONS "for more information." NIL))))))
                   ((AND (CONSP |arg|) (EQ (CDR |arg|) NIL)
                         (PROGN (SETQ |fn| (CAR |arg|)) #1#)
                         (|member| (SETQ |fn| (DOWNCASE |fn|))
                          '(|y| |n| |ye| |yes| |no| |on| OF |off|)))
                    (PROGN
                     (SETQ |$options| (LIST (LIST |fn|)))
                     (|historySpad2Cmd|)))
                   (#1# (|setHistory| NIL)))))))))

; describeSetOutputU(s_nam, o_nam, o_ext, is_on, cs) ==
;          sayBrightly LIST ('%b,'")set output ", s_nam,'%d,_
;   '"is used to tell FriCAS to turn ", o_nam, '"-style output",'%l,_
;   '"printing on and off, and where to place the output.  By default, the",'%l,_
;   '"destination for the output is the screen but printing is turned off.",'%l,_
;   '%l, '"Syntax:   )set output ", s_nam, '" <arg>",'%l,_
;   '"    where arg can be one of",'%l,_
;   '"  on          turn ", o_nam, _
;    (is_on => '" printing on (default state)"; '" printing on") ,'%l,_
;   '"  off         turn ", o_nam,
;    (is_on => '" printing off"; '" printing off (default state)"),'%l,_
;   '"  console     send ", o_nam, '" output to screen (default state)",'%l,_
;   '"  fp<.fe>     send ", o_nam, _
;     '" output to file with file prefix fp and file",'%l, _
;   '"              extension .fe. If not given, .fe defaults to .", _
;     o_ext, '".",'%l, '%l,_
;   '"If you wish to send the output to a file, you may need to issue this command",'%l,_
;   '"twice: once with", '%b, '"on", '%d, _
;     '"and once with the file name. For example, to send", '%l,_
;   o_nam, '" output to the file", '%b, '"polymer.", o_ext, '",", '%d, _
;   '"issue the two commands", '%l, _
;   '%l, _
;   '"  )set output ", s_nam, '" on", '%l, _
;   '"  )set output ", s_nam, '" polymer", '%l,_
;   '%l, _
;   '"The output is placed in the directory from which you invoked FriCAS or", _
;   '%l, '"the one you set with the )cd system command.", '%l, _
;   '"The current setting is: ",'%b, cs,'%d)

(DEFUN |describeSetOutputU| (|s_nam| |o_nam| |o_ext| |is_on| |cs|)
  (PROG ()
    (RETURN
     (|sayBrightly|
      (LIST '|%b| ")set output " |s_nam| '|%d|
            "is used to tell FriCAS to turn " |o_nam| "-style output" '|%l|
            "printing on and off, and where to place the output.  By default, the"
            '|%l|
            "destination for the output is the screen but printing is turned off."
            '|%l| '|%l| "Syntax:   )set output " |s_nam| " <arg>" '|%l|
            "    where arg can be one of" '|%l| "  on          turn " |o_nam|
            (COND (|is_on| " printing on (default state)")
                  (#1='T " printing on"))
            '|%l| "  off         turn " |o_nam|
            (COND (|is_on| " printing off")
                  (#1# " printing off (default state)"))
            '|%l| "  console     send " |o_nam|
            " output to screen (default state)" '|%l| "  fp<.fe>     send "
            |o_nam| " output to file with file prefix fp and file" '|%l|
            "              extension .fe. If not given, .fe defaults to ."
            |o_ext| "." '|%l| '|%l|
            "If you wish to send the output to a file, you may need to issue this command"
            '|%l| "twice: once with" '|%b| "on" '|%d|
            "and once with the file name. For example, to send" '|%l| |o_nam|
            " output to the file" '|%b| "polymer." |o_ext| "," '|%d|
            "issue the two commands" '|%l| '|%l| "  )set output " |s_nam| " on"
            '|%l| "  )set output " |s_nam| " polymer" '|%l| '|%l|
            "The output is placed in the directory from which you invoked FriCAS or"
            '|%l| "the one you set with the )cd system command." '|%l|
            "The current setting is: " '|%b| |cs| '|%d|)))))

; stream_close(st) ==
;     if first(st) then CLOSE(rest(st))

(DEFUN |stream_close| (|st|)
  (PROG () (RETURN (COND ((CAR |st|) (CLOSE (CDR |st|)))))))

; try_open(fn, ft, append) ==
;     if (ptype := pathnameType fn) then
;         fn := STRCONC(pathnameDirectory fn,pathnameName fn)
;         ft := ptype
;     filename := make_full_namestring([fn, ft])
;     null filename => [NIL, NIL]
;     (testStream := makeStream(append, filename)) => [testStream, filename]
;     [NIL, NIL]

(DEFUN |try_open| (|fn| |ft| APPEND)
  (PROG (|ptype| |filename| |testStream|)
    (RETURN
     (PROGN
      (COND
       ((SETQ |ptype| (|pathnameType| |fn|))
        (SETQ |fn| (STRCONC (|pathnameDirectory| |fn|) (|pathnameName| |fn|)))
        (SETQ |ft| |ptype|)))
      (SETQ |filename| (|make_full_namestring| (LIST |fn| |ft|)))
      (COND ((NULL |filename|) (LIST NIL NIL))
            ((SETQ |testStream| (|makeStream| APPEND |filename|))
             (LIST |testStream| |filename|))
            ('T (LIST NIL NIL)))))))

; setOutputAlgebra arg ==
;   arg = "%initialize%" =>
;     $algebraOutputStream := mkOutputConsoleStream()
;     $algebraOutputFile := '"CONSOLE"
;     $algebraFormat := true
;
;   arg = "%display%" =>
;     if $algebraFormat then label := '"On:" else label := '"Off:"
;     STRCONC(label,$algebraOutputFile)
;
;   (null arg) or (arg = "%describe%") or (first arg = '_?) =>
;     describeSetOutputAlgebra()
;
;   -- try to figure out what the argument is
;
;   if arg is [fn] and
;     fn in '(Y N YE YES NO O ON OF OFF CONSOLE y n ye yes no o on of off console)
;       then 'ok
;       else arg := [fn,'spout]
;
;   arg is [fn] =>
;     UPCASE(fn) in '(Y N YE O OF) =>
;       sayKeyedMsg("S2IV0002",'(algebra algebra))
;     UPCASE(fn) in '(NO OFF)  => $algebraFormat := NIL
;     UPCASE(fn) in '(YES ON) => $algebraFormat := true
;     UPCASE(fn) = 'CONSOLE =>
;       stream_close($algebraOutputStream)
;       $algebraOutputStream := mkOutputConsoleStream()
;       $algebraOutputFile := '"CONSOLE"
;
;   (arg is [fn,ft]) or (arg is [fn,ft,fm]) => -- aha, a file
;     [testStream, filename] := try_open(fn, ft, false)
;     testStream =>
;       stream_close($algebraOutputStream)
;       $algebraOutputStream := testStream
;       $algebraOutputFile := filename
;       sayKeyedMsg("S2IV0004",['"Algebra",$algebraOutputFile])
;     sayKeyedMsg("S2IV0003",[fn,ft])
;
;   sayKeyedMsg("S2IV0005",NIL)
;   describeSetOutputAlgebra()

(DEFUN |setOutputAlgebra| (|arg|)
  (PROG (|label| |fn| |ISTMP#1| |ft| |ISTMP#2| |fm| |LETTMP#1| |testStream|
         |filename|)
    (RETURN
     (COND
      ((EQ |arg| '|%initialize%|)
       (PROGN
        (SETQ |$algebraOutputStream| (|mkOutputConsoleStream|))
        (SETQ |$algebraOutputFile| "CONSOLE")
        (SETQ |$algebraFormat| T)))
      ((EQ |arg| '|%display%|)
       (PROGN
        (COND (|$algebraFormat| (SETQ |label| "On:"))
              (#1='T (SETQ |label| "Off:")))
        (STRCONC |label| |$algebraOutputFile|)))
      ((OR (NULL |arg|) (EQ |arg| '|%describe%|) (EQ (CAR |arg|) '?))
       (|describeSetOutputAlgebra|))
      (#1#
       (PROGN
        (COND
         ((AND (CONSP |arg|) (EQ (CDR |arg|) NIL)
               (PROGN (SETQ |fn| (CAR |arg|)) #1#)
               (|member| |fn|
                '(Y N YE YES NO O ON OF OFF CONSOLE |y| |n| |ye| |yes| |no| |o|
                  |on| OF |off| |console|)))
          '|ok|)
         (#1# (SETQ |arg| (LIST |fn| '|spout|))))
        (COND
         ((AND (CONSP |arg|) (EQ (CDR |arg|) NIL)
               (PROGN (SETQ |fn| (CAR |arg|)) #1#))
          (COND
           ((|member| (UPCASE |fn|) '(Y N YE O OF))
            (|sayKeyedMsg| 'S2IV0002 '(|algebra| |algebra|)))
           ((|member| (UPCASE |fn|) '(NO OFF)) (SETQ |$algebraFormat| NIL))
           ((|member| (UPCASE |fn|) '(YES ON)) (SETQ |$algebraFormat| T))
           ((EQ (UPCASE |fn|) 'CONSOLE)
            (PROGN
             (|stream_close| |$algebraOutputStream|)
             (SETQ |$algebraOutputStream| (|mkOutputConsoleStream|))
             (SETQ |$algebraOutputFile| "CONSOLE")))))
         ((OR
           (AND (CONSP |arg|)
                (PROGN
                 (SETQ |fn| (CAR |arg|))
                 (SETQ |ISTMP#1| (CDR |arg|))
                 (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                      (PROGN (SETQ |ft| (CAR |ISTMP#1|)) #1#))))
           (AND (CONSP |arg|)
                (PROGN
                 (SETQ |fn| (CAR |arg|))
                 (SETQ |ISTMP#1| (CDR |arg|))
                 (AND (CONSP |ISTMP#1|)
                      (PROGN
                       (SETQ |ft| (CAR |ISTMP#1|))
                       (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                       (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                            (PROGN (SETQ |fm| (CAR |ISTMP#2|)) #1#)))))))
          (PROGN
           (SETQ |LETTMP#1| (|try_open| |fn| |ft| NIL))
           (SETQ |testStream| (CAR |LETTMP#1|))
           (SETQ |filename| (CADR |LETTMP#1|))
           (COND
            (|testStream|
             (PROGN
              (|stream_close| |$algebraOutputStream|)
              (SETQ |$algebraOutputStream| |testStream|)
              (SETQ |$algebraOutputFile| |filename|)
              (|sayKeyedMsg| 'S2IV0004 (LIST "Algebra" |$algebraOutputFile|))))
            (#1# (|sayKeyedMsg| 'S2IV0003 (LIST |fn| |ft|))))))
         (#1#
          (PROGN
           (|sayKeyedMsg| 'S2IV0005 NIL)
           (|describeSetOutputAlgebra|))))))))))

; describeSetOutputAlgebra() == describeSetOutputU(
;     '"algebra", '"algebra", '"spout", true, setOutputAlgebra "%display%")

(DEFUN |describeSetOutputAlgebra| ()
  (PROG ()
    (RETURN
     (|describeSetOutputU| "algebra" "algebra" "spout" T
      (|setOutputAlgebra| '|%display%|)))))

; setOutputCharacters arg ==
;   -- this sets the special character set
;   arg = "%initialize%" =>
;     $specialCharacters := $plainRTspecialCharacters
;
;   current :=
;     $specialCharacters = $RTspecialCharacters      => '"default"
;     $specialCharacters = $plainRTspecialCharacters => '"plain"
;     '"unknown"
;   arg = "%display%" => current
;
;   (null arg) or (arg = "%describe%") or (first arg = '_?) =>
;     sayMessage ['" The",:bright '"characters",'"option",
;       '" may be followed by any one of the following:"]
;     for name in '("default" "plain") repeat
;       if name = current
;         then sayBrightly ['" ->",:bright name]
;         else sayBrightly ['"    ",name]
;     TERPRI()
;     sayBrightly '" The current setting is indicated within the list.  This option determines "
;     sayBrightly '" the special characters used for algebraic output.  This is what the"
;     sayBrightly '" current choice of special characters looks like:"
;     l := NIL
;     for [char,:.] in $specialCharacterAlist repeat
;       s := STRCONC('"   ",PNAME char,'" is shown as ",
;         PNAME specialChar(char))
;       l := cons(s,l)
;     sayAsManyPerLineAsPossible reverse l
;
;   arg is [fn] and (fn := DOWNCASE(fn)) =>
;     fn = 'default => $specialCharacters := $RTspecialCharacters
;     fn = 'plain   => $specialCharacters := $plainRTspecialCharacters
;     setOutputCharacters NIL
;   setOutputCharacters NIL

(DEFUN |setOutputCharacters| (|arg|)
  (PROG (|current| |l| |char| |s| |fn|)
    (RETURN
     (COND
      ((EQ |arg| '|%initialize%|)
       (SETQ |$specialCharacters| |$plainRTspecialCharacters|))
      (#1='T
       (PROGN
        (SETQ |current|
                (COND
                 ((EQUAL |$specialCharacters| |$RTspecialCharacters|)
                  "default")
                 ((EQUAL |$specialCharacters| |$plainRTspecialCharacters|)
                  "plain")
                 (#1# "unknown")))
        (COND ((EQ |arg| '|%display%|) |current|)
              ((OR (NULL |arg|) (EQ |arg| '|%describe%|) (EQ (CAR |arg|) '?))
               (PROGN
                (|sayMessage|
                 (CONS " The"
                       (APPEND (|bright| "characters")
                               (CONS "option"
                                     (CONS
                                      " may be followed by any one of the following:"
                                      NIL)))))
                ((LAMBDA (|bfVar#20| |name|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#20|)
                          (PROGN (SETQ |name| (CAR |bfVar#20|)) NIL))
                      (RETURN NIL))
                     (#1#
                      (COND
                       ((EQUAL |name| |current|)
                        (|sayBrightly| (CONS " ->" (|bright| |name|))))
                       (#1# (|sayBrightly| (LIST "    " |name|))))))
                    (SETQ |bfVar#20| (CDR |bfVar#20|))))
                 '("default" "plain") NIL)
                (TERPRI)
                (|sayBrightly|
                 " The current setting is indicated within the list.  This option determines ")
                (|sayBrightly|
                 " the special characters used for algebraic output.  This is what the")
                (|sayBrightly|
                 " current choice of special characters looks like:")
                (SETQ |l| NIL)
                ((LAMBDA (|bfVar#22| |bfVar#21|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#22|)
                          (PROGN (SETQ |bfVar#21| (CAR |bfVar#22|)) NIL))
                      (RETURN NIL))
                     (#1#
                      (AND (CONSP |bfVar#21|)
                           (PROGN (SETQ |char| (CAR |bfVar#21|)) #1#)
                           (PROGN
                            (SETQ |s|
                                    (STRCONC "   " (PNAME |char|)
                                     " is shown as "
                                     (PNAME (|specialChar| |char|))))
                            (SETQ |l| (CONS |s| |l|))))))
                    (SETQ |bfVar#22| (CDR |bfVar#22|))))
                 |$specialCharacterAlist| NIL)
                (|sayAsManyPerLineAsPossible| (REVERSE |l|))))
              ((AND (CONSP |arg|) (EQ (CDR |arg|) NIL)
                    (PROGN (SETQ |fn| (CAR |arg|)) #1#)
                    (SETQ |fn| (DOWNCASE |fn|)))
               (COND
                ((EQ |fn| '|default|)
                 (SETQ |$specialCharacters| |$RTspecialCharacters|))
                ((EQ |fn| '|plain|)
                 (SETQ |$specialCharacters| |$plainRTspecialCharacters|))
                (#1# (|setOutputCharacters| NIL))))
              (#1# (|setOutputCharacters| NIL)))))))))

; makeStream(append,filename) ==
;   append => make_append_stream(filename)
;   make_out_stream(filename)

(DEFUN |makeStream| (APPEND |filename|)
  (PROG ()
    (RETURN
     (COND (APPEND (|make_append_stream| |filename|))
           ('T (|make_out_stream| |filename|))))))

; setOutputFortran arg ==
;   arg = "%initialize%" =>
;     $fortranOutputStream := mkOutputConsoleStream()
;     $fortranOutputFile := '"CONSOLE"
;     $fortranFormat := NIL
;
;   arg = "%display%" =>
;     if $fortranFormat then label := '"On:" else label := '"Off:"
;     STRCONC(label,$fortranOutputFile)
;
;   (null arg) or (arg = "%describe%") or (first arg = '_?) =>
;     describeSetOutputFortran()
;
;   -- try to figure out what the argument is
;
;   append := NIL
;   quiet := NIL
;   while LISTP arg and UPCASE(first arg) in '(APPEND QUIET) repeat
;     if UPCASE first(arg) = 'APPEND then append := true
;     else if UPCASE first(arg) = 'QUIET then quiet := true
;     arg := rest(arg)
;
;   if arg is [fn] and
;     fn in '(Y N YE YES NO O ON OF OFF CONSOLE y n ye yes no o on of off console)
;       then 'ok
;       else arg := [fn,'sfort]
;
;   arg is [fn] =>
;     UPCASE(fn) in '(Y N YE O OF) =>
;       sayKeyedMsg("S2IV0002",'(FORTRAN fortran))
;     UPCASE(fn) in '(NO OFF)  => $fortranFormat := NIL
;     UPCASE(fn) in '(YES ON)  => $fortranFormat := true
;     UPCASE(fn) = 'CONSOLE =>
;       stream_close($fortranOutputStream)
;       $fortranOutputStream := mkOutputConsoleStream()
;       $fortranOutputFile := '"CONSOLE"
;
;   (arg is [fn,ft]) or (arg is [fn,ft,fm]) => -- aha, a file
;     [testStream, filename] := try_open(fn, ft, append)
;     testStream =>
;       stream_close($fortranOutputStream)
;       $fortranOutputStream := testStream
;       $fortranOutputFile := filename
;       if null quiet then sayKeyedMsg("S2IV0004",['FORTRAN,$fortranOutputFile])
;     if null quiet then sayKeyedMsg("S2IV0003",[fn,ft])
;   if null quiet then sayKeyedMsg("S2IV0005",NIL)
;   describeSetOutputFortran()

(DEFUN |setOutputFortran| (|arg|)
  (PROG (|label| APPEND |quiet| |fn| |ISTMP#1| |ft| |ISTMP#2| |fm| |LETTMP#1|
         |testStream| |filename|)
    (RETURN
     (COND
      ((EQ |arg| '|%initialize%|)
       (PROGN
        (SETQ |$fortranOutputStream| (|mkOutputConsoleStream|))
        (SETQ |$fortranOutputFile| "CONSOLE")
        (SETQ |$fortranFormat| NIL)))
      ((EQ |arg| '|%display%|)
       (PROGN
        (COND (|$fortranFormat| (SETQ |label| "On:"))
              (#1='T (SETQ |label| "Off:")))
        (STRCONC |label| |$fortranOutputFile|)))
      ((OR (NULL |arg|) (EQ |arg| '|%describe%|) (EQ (CAR |arg|) '?))
       (|describeSetOutputFortran|))
      (#1#
       (PROGN
        (SETQ APPEND NIL)
        (SETQ |quiet| NIL)
        ((LAMBDA ()
           (LOOP
            (COND
             ((NOT
               (AND (LISTP |arg|)
                    (|member| (UPCASE (CAR |arg|)) '(APPEND QUIET))))
              (RETURN NIL))
             (#1#
              (PROGN
               (COND ((EQ (UPCASE (CAR |arg|)) 'APPEND) (SETQ APPEND T))
                     ((EQ (UPCASE (CAR |arg|)) 'QUIET) (SETQ |quiet| T)))
               (SETQ |arg| (CDR |arg|))))))))
        (COND
         ((AND (CONSP |arg|) (EQ (CDR |arg|) NIL)
               (PROGN (SETQ |fn| (CAR |arg|)) #1#)
               (|member| |fn|
                '(Y N YE YES NO O ON OF OFF CONSOLE |y| |n| |ye| |yes| |no| |o|
                  |on| OF |off| |console|)))
          '|ok|)
         (#1# (SETQ |arg| (LIST |fn| '|sfort|))))
        (COND
         ((AND (CONSP |arg|) (EQ (CDR |arg|) NIL)
               (PROGN (SETQ |fn| (CAR |arg|)) #1#))
          (COND
           ((|member| (UPCASE |fn|) '(Y N YE O OF))
            (|sayKeyedMsg| 'S2IV0002 '(FORTRAN |fortran|)))
           ((|member| (UPCASE |fn|) '(NO OFF)) (SETQ |$fortranFormat| NIL))
           ((|member| (UPCASE |fn|) '(YES ON)) (SETQ |$fortranFormat| T))
           ((EQ (UPCASE |fn|) 'CONSOLE)
            (PROGN
             (|stream_close| |$fortranOutputStream|)
             (SETQ |$fortranOutputStream| (|mkOutputConsoleStream|))
             (SETQ |$fortranOutputFile| "CONSOLE")))))
         ((OR
           (AND (CONSP |arg|)
                (PROGN
                 (SETQ |fn| (CAR |arg|))
                 (SETQ |ISTMP#1| (CDR |arg|))
                 (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                      (PROGN (SETQ |ft| (CAR |ISTMP#1|)) #1#))))
           (AND (CONSP |arg|)
                (PROGN
                 (SETQ |fn| (CAR |arg|))
                 (SETQ |ISTMP#1| (CDR |arg|))
                 (AND (CONSP |ISTMP#1|)
                      (PROGN
                       (SETQ |ft| (CAR |ISTMP#1|))
                       (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                       (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                            (PROGN (SETQ |fm| (CAR |ISTMP#2|)) #1#)))))))
          (PROGN
           (SETQ |LETTMP#1| (|try_open| |fn| |ft| APPEND))
           (SETQ |testStream| (CAR |LETTMP#1|))
           (SETQ |filename| (CADR |LETTMP#1|))
           (COND
            (|testStream|
             (PROGN
              (|stream_close| |$fortranOutputStream|)
              (SETQ |$fortranOutputStream| |testStream|)
              (SETQ |$fortranOutputFile| |filename|)
              (COND
               ((NULL |quiet|)
                (|sayKeyedMsg| 'S2IV0004
                 (LIST 'FORTRAN |$fortranOutputFile|))))))
            (#1#
             (COND
              ((NULL |quiet|) (|sayKeyedMsg| 'S2IV0003 (LIST |fn| |ft|))))))))
         (#1#
          (PROGN
           (COND ((NULL |quiet|) (|sayKeyedMsg| 'S2IV0005 NIL)))
           (|describeSetOutputFortran|))))))))))

; describeSetOutputFortran() == describeSetOutputU(
;     '"fortran", '"FORTRAN", '"sfort", false, setOutputFortran "%display%")

(DEFUN |describeSetOutputFortran| ()
  (PROG ()
    (RETURN
     (|describeSetOutputU| "fortran" "FORTRAN" "sfort" NIL
      (|setOutputFortran| '|%display%|)))))

; setOutputMathml arg ==
;   arg = "%initialize%" =>
;     $mathmlOutputStream := mkOutputConsoleStream()
;     $mathmlOutputFile := '"CONSOLE"
;     $mathmlFormat := NIL
;
;   arg = "%display%" =>
;     if $mathmlFormat then label := '"On:" else label := '"Off:"
;     STRCONC(label,$mathmlOutputFile)
;
;   (null arg) or (arg = "%describe%") or (first arg = '_?) =>
;     describeSetOutputMathml()
;
;   -- try to figure out what the argument is
;
;   if arg is [fn] and
;     fn in '(Y N YE YES NO O ON OF OFF CONSOLE y n ye yes no o on of off console)
;       then 'ok
;       else arg := [fn,'smml]
;
;   arg is [fn] =>
;     UPCASE(fn) in '(Y N YE O OF) =>
;       sayKeyedMsg("S2IV0002",'(MathML mathml))
;     UPCASE(fn) in '(NO OFF)  => $mathmlFormat := NIL
;     UPCASE(fn) in '(YES ON) => $mathmlFormat := true
;     UPCASE(fn) = 'CONSOLE =>
;       stream_close($mathmlOutputStream)
;       $mathmlOutputStream := mkOutputConsoleStream()
;       $mathmlOutputFile := '"CONSOLE"
;
;   (arg is [fn,ft]) or (arg is [fn,ft,fm]) => -- aha, a file
;     [testStream, filename] := try_open(fn, ft, false)
;     testStream =>
;       stream_close($mathmlOutputStream)
;       $mathmlOutputStream := testStream
;       $mathmlOutputFile := filename
;       sayKeyedMsg("S2IV0004",['"MathML",$mathmlOutputFile])
;     sayKeyedMsg("S2IV0003",[fn,ft])
;
;   sayKeyedMsg("S2IV0005",NIL)
;   describeSetOutputMathml()

(DEFUN |setOutputMathml| (|arg|)
  (PROG (|label| |fn| |ISTMP#1| |ft| |ISTMP#2| |fm| |LETTMP#1| |testStream|
         |filename|)
    (RETURN
     (COND
      ((EQ |arg| '|%initialize%|)
       (PROGN
        (SETQ |$mathmlOutputStream| (|mkOutputConsoleStream|))
        (SETQ |$mathmlOutputFile| "CONSOLE")
        (SETQ |$mathmlFormat| NIL)))
      ((EQ |arg| '|%display%|)
       (PROGN
        (COND (|$mathmlFormat| (SETQ |label| "On:"))
              (#1='T (SETQ |label| "Off:")))
        (STRCONC |label| |$mathmlOutputFile|)))
      ((OR (NULL |arg|) (EQ |arg| '|%describe%|) (EQ (CAR |arg|) '?))
       (|describeSetOutputMathml|))
      (#1#
       (PROGN
        (COND
         ((AND (CONSP |arg|) (EQ (CDR |arg|) NIL)
               (PROGN (SETQ |fn| (CAR |arg|)) #1#)
               (|member| |fn|
                '(Y N YE YES NO O ON OF OFF CONSOLE |y| |n| |ye| |yes| |no| |o|
                  |on| OF |off| |console|)))
          '|ok|)
         (#1# (SETQ |arg| (LIST |fn| '|smml|))))
        (COND
         ((AND (CONSP |arg|) (EQ (CDR |arg|) NIL)
               (PROGN (SETQ |fn| (CAR |arg|)) #1#))
          (COND
           ((|member| (UPCASE |fn|) '(Y N YE O OF))
            (|sayKeyedMsg| 'S2IV0002 '(|MathML| |mathml|)))
           ((|member| (UPCASE |fn|) '(NO OFF)) (SETQ |$mathmlFormat| NIL))
           ((|member| (UPCASE |fn|) '(YES ON)) (SETQ |$mathmlFormat| T))
           ((EQ (UPCASE |fn|) 'CONSOLE)
            (PROGN
             (|stream_close| |$mathmlOutputStream|)
             (SETQ |$mathmlOutputStream| (|mkOutputConsoleStream|))
             (SETQ |$mathmlOutputFile| "CONSOLE")))))
         ((OR
           (AND (CONSP |arg|)
                (PROGN
                 (SETQ |fn| (CAR |arg|))
                 (SETQ |ISTMP#1| (CDR |arg|))
                 (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                      (PROGN (SETQ |ft| (CAR |ISTMP#1|)) #1#))))
           (AND (CONSP |arg|)
                (PROGN
                 (SETQ |fn| (CAR |arg|))
                 (SETQ |ISTMP#1| (CDR |arg|))
                 (AND (CONSP |ISTMP#1|)
                      (PROGN
                       (SETQ |ft| (CAR |ISTMP#1|))
                       (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                       (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                            (PROGN (SETQ |fm| (CAR |ISTMP#2|)) #1#)))))))
          (PROGN
           (SETQ |LETTMP#1| (|try_open| |fn| |ft| NIL))
           (SETQ |testStream| (CAR |LETTMP#1|))
           (SETQ |filename| (CADR |LETTMP#1|))
           (COND
            (|testStream|
             (PROGN
              (|stream_close| |$mathmlOutputStream|)
              (SETQ |$mathmlOutputStream| |testStream|)
              (SETQ |$mathmlOutputFile| |filename|)
              (|sayKeyedMsg| 'S2IV0004 (LIST "MathML" |$mathmlOutputFile|))))
            (#1# (|sayKeyedMsg| 'S2IV0003 (LIST |fn| |ft|))))))
         (#1#
          (PROGN
           (|sayKeyedMsg| 'S2IV0005 NIL)
           (|describeSetOutputMathml|))))))))))

; describeSetOutputMathml() == describeSetOutputU(
;     '"mathml", '"MathML", '"smml", false, setOutputMathml "%display%")

(DEFUN |describeSetOutputMathml| ()
  (PROG ()
    (RETURN
     (|describeSetOutputU| "mathml" "MathML" "smml" NIL
      (|setOutputMathml| '|%display%|)))))

; setOutputTexmacs arg ==
;   arg = "%initialize%" =>
;     $texmacsOutputStream := mkOutputConsoleStream()
;     $texmacsOutputFile := '"CONSOLE"
;     $texmacsFormat := NIL
;
;   arg = "%display%" =>
;     if $texmacsFormat then label := '"On:" else label := '"Off:"
;     STRCONC(label,$texmacsOutputFile)
;
;   (null arg) or (arg = "%describe%") or (first arg = '_?) =>
;     describeSetOutputTexmacs()
;
;   -- try to figure out what the argument is
;
;   if arg is [fn] and
;     fn in '(Y N YE YES NO O ON OF OFF CONSOLE y n ye yes no o on of off console)
;       then 'ok
;       else arg := [fn,'stmx]
;
;   arg is [fn] =>
;     UPCASE(fn) in '(Y N YE O OF) =>
;       sayKeyedMsg("S2IV0002",'(Texmacs texmacs))
;     UPCASE(fn) in '(NO OFF)  => $texmacsFormat := NIL
;     UPCASE(fn) in '(YES ON) => $texmacsFormat := true
;     UPCASE(fn) = 'CONSOLE =>
;       stream_close($texmacsOutputStream)
;       $texmacsOutputStream := mkOutputConsoleStream()
;       $texmacsOutputFile := '"CONSOLE"
;
;   (arg is [fn,ft]) or (arg is [fn,ft,fm]) => -- aha, a file
;     [testStream, filename] := try_open(fn, ft, false)
;     testStream =>
;       stream_close($texmacsOutputStream)
;       $texmacsOutputStream := testStream
;       $texmacsOutputFile := filename
;       sayKeyedMsg("S2IV0004",['"Texmacs",$texmacsOutputFile])
;     sayKeyedMsg("S2IV0003",[fn,ft])
;
;   sayKeyedMsg("S2IV0005",NIL)
;   describeSetOutputTexmacs()

(DEFUN |setOutputTexmacs| (|arg|)
  (PROG (|label| |fn| |ISTMP#1| |ft| |ISTMP#2| |fm| |LETTMP#1| |testStream|
         |filename|)
    (RETURN
     (COND
      ((EQ |arg| '|%initialize%|)
       (PROGN
        (SETQ |$texmacsOutputStream| (|mkOutputConsoleStream|))
        (SETQ |$texmacsOutputFile| "CONSOLE")
        (SETQ |$texmacsFormat| NIL)))
      ((EQ |arg| '|%display%|)
       (PROGN
        (COND (|$texmacsFormat| (SETQ |label| "On:"))
              (#1='T (SETQ |label| "Off:")))
        (STRCONC |label| |$texmacsOutputFile|)))
      ((OR (NULL |arg|) (EQ |arg| '|%describe%|) (EQ (CAR |arg|) '?))
       (|describeSetOutputTexmacs|))
      (#1#
       (PROGN
        (COND
         ((AND (CONSP |arg|) (EQ (CDR |arg|) NIL)
               (PROGN (SETQ |fn| (CAR |arg|)) #1#)
               (|member| |fn|
                '(Y N YE YES NO O ON OF OFF CONSOLE |y| |n| |ye| |yes| |no| |o|
                  |on| OF |off| |console|)))
          '|ok|)
         (#1# (SETQ |arg| (LIST |fn| '|stmx|))))
        (COND
         ((AND (CONSP |arg|) (EQ (CDR |arg|) NIL)
               (PROGN (SETQ |fn| (CAR |arg|)) #1#))
          (COND
           ((|member| (UPCASE |fn|) '(Y N YE O OF))
            (|sayKeyedMsg| 'S2IV0002 '(|Texmacs| |texmacs|)))
           ((|member| (UPCASE |fn|) '(NO OFF)) (SETQ |$texmacsFormat| NIL))
           ((|member| (UPCASE |fn|) '(YES ON)) (SETQ |$texmacsFormat| T))
           ((EQ (UPCASE |fn|) 'CONSOLE)
            (PROGN
             (|stream_close| |$texmacsOutputStream|)
             (SETQ |$texmacsOutputStream| (|mkOutputConsoleStream|))
             (SETQ |$texmacsOutputFile| "CONSOLE")))))
         ((OR
           (AND (CONSP |arg|)
                (PROGN
                 (SETQ |fn| (CAR |arg|))
                 (SETQ |ISTMP#1| (CDR |arg|))
                 (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                      (PROGN (SETQ |ft| (CAR |ISTMP#1|)) #1#))))
           (AND (CONSP |arg|)
                (PROGN
                 (SETQ |fn| (CAR |arg|))
                 (SETQ |ISTMP#1| (CDR |arg|))
                 (AND (CONSP |ISTMP#1|)
                      (PROGN
                       (SETQ |ft| (CAR |ISTMP#1|))
                       (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                       (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                            (PROGN (SETQ |fm| (CAR |ISTMP#2|)) #1#)))))))
          (PROGN
           (SETQ |LETTMP#1| (|try_open| |fn| |ft| NIL))
           (SETQ |testStream| (CAR |LETTMP#1|))
           (SETQ |filename| (CADR |LETTMP#1|))
           (COND
            (|testStream|
             (PROGN
              (|stream_close| |$texmacsOutputStream|)
              (SETQ |$texmacsOutputStream| |testStream|)
              (SETQ |$texmacsOutputFile| |filename|)
              (|sayKeyedMsg| 'S2IV0004 (LIST "Texmacs" |$texmacsOutputFile|))))
            (#1# (|sayKeyedMsg| 'S2IV0003 (LIST |fn| |ft|))))))
         (#1#
          (PROGN
           (|sayKeyedMsg| 'S2IV0005 NIL)
           (|describeSetOutputTexmacs|))))))))))

; describeSetOutputTexmacs() == describeSetOutputU(
;     '"texmacs", '"Texmacs", '"stmx", false, setOutputTexmacs "%display%")

(DEFUN |describeSetOutputTexmacs| ()
  (PROG ()
    (RETURN
     (|describeSetOutputU| "texmacs" "Texmacs" "stmx" NIL
      (|setOutputTexmacs| '|%display%|)))))

; setOutputHtml arg ==
;   arg = "%initialize%" =>
;     $htmlOutputStream := mkOutputConsoleStream()
;     $htmlOutputFile := '"CONSOLE"
;     $htmlFormat := NIL
;
;   arg = "%display%" =>
;     if $htmlFormat then label := '"On:" else label := '"Off:"
;     STRCONC(label, $htmlOutputFile)
;
;   (null arg) or (arg = "%describe%") or (first arg = '_?) =>
;     describeSetOutputHtml()
;
;   -- try to figure out what the argument is
;
;   if arg is [fn] and
;     fn in '(Y N YE YES NO O ON OF OFF CONSOLE y n ye yes no o on of off console)
;       then 'ok
;       else arg := [fn,'shtml]
;
;   arg is [fn] =>
;     UPCASE(fn) in '(Y N YE O OF) =>
;       sayKeyedMsg("S2IV0002",'(HTML html))
;     UPCASE(fn) in '(NO OFF)  => $htmlFormat := NIL
;     UPCASE(fn) in '(YES ON) => $htmlFormat := true
;     UPCASE(fn) = 'CONSOLE =>
;       stream_close($htmlOutputStream)
;       $htmlOutputStream := mkOutputConsoleStream()
;       $htmlOutputFile := '"CONSOLE"
;
;   (arg is [fn,ft]) or (arg is [fn,ft,fm]) => -- aha, a file
;     [testStream, filename] := try_open(fn, ft, false)
;     testStream =>
;       stream_close($htmlOutputStream)
;       $htmlOutputStream := testStream
;       $htmlOutputFile := filename
;       sayKeyedMsg("S2IV0004",['"HTML",$htmlOutputFile])
;     sayKeyedMsg("S2IV0003",[fn,ft])
;
;   sayKeyedMsg("S2IV0005",NIL)
;   describeSetOutputHtml()

(DEFUN |setOutputHtml| (|arg|)
  (PROG (|label| |fn| |ISTMP#1| |ft| |ISTMP#2| |fm| |LETTMP#1| |testStream|
         |filename|)
    (RETURN
     (COND
      ((EQ |arg| '|%initialize%|)
       (PROGN
        (SETQ |$htmlOutputStream| (|mkOutputConsoleStream|))
        (SETQ |$htmlOutputFile| "CONSOLE")
        (SETQ |$htmlFormat| NIL)))
      ((EQ |arg| '|%display%|)
       (PROGN
        (COND (|$htmlFormat| (SETQ |label| "On:"))
              (#1='T (SETQ |label| "Off:")))
        (STRCONC |label| |$htmlOutputFile|)))
      ((OR (NULL |arg|) (EQ |arg| '|%describe%|) (EQ (CAR |arg|) '?))
       (|describeSetOutputHtml|))
      (#1#
       (PROGN
        (COND
         ((AND (CONSP |arg|) (EQ (CDR |arg|) NIL)
               (PROGN (SETQ |fn| (CAR |arg|)) #1#)
               (|member| |fn|
                '(Y N YE YES NO O ON OF OFF CONSOLE |y| |n| |ye| |yes| |no| |o|
                  |on| OF |off| |console|)))
          '|ok|)
         (#1# (SETQ |arg| (LIST |fn| '|shtml|))))
        (COND
         ((AND (CONSP |arg|) (EQ (CDR |arg|) NIL)
               (PROGN (SETQ |fn| (CAR |arg|)) #1#))
          (COND
           ((|member| (UPCASE |fn|) '(Y N YE O OF))
            (|sayKeyedMsg| 'S2IV0002 '(HTML |html|)))
           ((|member| (UPCASE |fn|) '(NO OFF)) (SETQ |$htmlFormat| NIL))
           ((|member| (UPCASE |fn|) '(YES ON)) (SETQ |$htmlFormat| T))
           ((EQ (UPCASE |fn|) 'CONSOLE)
            (PROGN
             (|stream_close| |$htmlOutputStream|)
             (SETQ |$htmlOutputStream| (|mkOutputConsoleStream|))
             (SETQ |$htmlOutputFile| "CONSOLE")))))
         ((OR
           (AND (CONSP |arg|)
                (PROGN
                 (SETQ |fn| (CAR |arg|))
                 (SETQ |ISTMP#1| (CDR |arg|))
                 (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                      (PROGN (SETQ |ft| (CAR |ISTMP#1|)) #1#))))
           (AND (CONSP |arg|)
                (PROGN
                 (SETQ |fn| (CAR |arg|))
                 (SETQ |ISTMP#1| (CDR |arg|))
                 (AND (CONSP |ISTMP#1|)
                      (PROGN
                       (SETQ |ft| (CAR |ISTMP#1|))
                       (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                       (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                            (PROGN (SETQ |fm| (CAR |ISTMP#2|)) #1#)))))))
          (PROGN
           (SETQ |LETTMP#1| (|try_open| |fn| |ft| NIL))
           (SETQ |testStream| (CAR |LETTMP#1|))
           (SETQ |filename| (CADR |LETTMP#1|))
           (COND
            (|testStream|
             (PROGN
              (|stream_close| |$htmlOutputStream|)
              (SETQ |$htmlOutputStream| |testStream|)
              (SETQ |$htmlOutputFile| |filename|)
              (|sayKeyedMsg| 'S2IV0004 (LIST "HTML" |$htmlOutputFile|))))
            (#1# (|sayKeyedMsg| 'S2IV0003 (LIST |fn| |ft|))))))
         (#1#
          (PROGN
           (|sayKeyedMsg| 'S2IV0005 NIL)
           (|describeSetOutputHtml|))))))))))

; describeSetOutputHtml() == describeSetOutputU(
;     '"html", '"HTML", '"shtml", false, setOutputHtml "%display%")

(DEFUN |describeSetOutputHtml| ()
  (PROG ()
    (RETURN
     (|describeSetOutputU| "html" "HTML" "shtml" NIL
      (|setOutputHtml| '|%display%|)))))

; setOutputOpenMath arg ==
;   arg = "%initialize%" =>
;     $openMathOutputStream := mkOutputConsoleStream()
;     $openMathOutputFile := '"CONSOLE"
;     $openMathFormat := NIL
;
;   arg = "%display%" =>
;     if $openMathFormat then label := '"On:" else label := '"Off:"
;     STRCONC(label,$openMathOutputFile)
;
;   (null arg) or (arg = "%describe%") or (first arg = '_?) =>
;     describeSetOutputOpenMath()
;
;   -- try to figure out what the argument is
;
;   if arg is [fn] and
;     fn in '(Y N YE YES NO O ON OF OFF CONSOLE y n ye yes no o on of off console)
;       then 'ok
;       else arg := [fn,'som]
;
;   arg is [fn] =>
;     UPCASE(fn) in '(Y N YE O OF) =>
;       sayKeyedMsg("S2IV0002",'(OpenMath openmath))
;     UPCASE(fn) in '(NO OFF)  => $openMathFormat := NIL
;     UPCASE(fn) in '(YES ON) => $openMathFormat := true
;     UPCASE(fn) = 'CONSOLE =>
;       stream_close($openMathOutputStream)
;       $openMathOutputStream := mkOutputConsoleStream()
;       $openMathOutputFile := '"CONSOLE"
;
;   (arg is [fn,ft]) or (arg is [fn,ft,fm]) => -- aha, a file
;     [testStream, filename] := try_open(fn, ft, false)
;     testStream =>
;       stream_close($openMathOutputStream)
;       $openMathOutputStream := testStream
;       $openMathOutputFile := filename
;       sayKeyedMsg("S2IV0004",['"OpenMath",$openMathOutputFile])
;     sayKeyedMsg("S2IV0003",[fn,ft])
;
;   sayKeyedMsg("S2IV0005",NIL)
;   describeSetOutputOpenMath()

(DEFUN |setOutputOpenMath| (|arg|)
  (PROG (|label| |fn| |ISTMP#1| |ft| |ISTMP#2| |fm| |LETTMP#1| |testStream|
         |filename|)
    (RETURN
     (COND
      ((EQ |arg| '|%initialize%|)
       (PROGN
        (SETQ |$openMathOutputStream| (|mkOutputConsoleStream|))
        (SETQ |$openMathOutputFile| "CONSOLE")
        (SETQ |$openMathFormat| NIL)))
      ((EQ |arg| '|%display%|)
       (PROGN
        (COND (|$openMathFormat| (SETQ |label| "On:"))
              (#1='T (SETQ |label| "Off:")))
        (STRCONC |label| |$openMathOutputFile|)))
      ((OR (NULL |arg|) (EQ |arg| '|%describe%|) (EQ (CAR |arg|) '?))
       (|describeSetOutputOpenMath|))
      (#1#
       (PROGN
        (COND
         ((AND (CONSP |arg|) (EQ (CDR |arg|) NIL)
               (PROGN (SETQ |fn| (CAR |arg|)) #1#)
               (|member| |fn|
                '(Y N YE YES NO O ON OF OFF CONSOLE |y| |n| |ye| |yes| |no| |o|
                  |on| OF |off| |console|)))
          '|ok|)
         (#1# (SETQ |arg| (LIST |fn| '|som|))))
        (COND
         ((AND (CONSP |arg|) (EQ (CDR |arg|) NIL)
               (PROGN (SETQ |fn| (CAR |arg|)) #1#))
          (COND
           ((|member| (UPCASE |fn|) '(Y N YE O OF))
            (|sayKeyedMsg| 'S2IV0002 '(|OpenMath| |openmath|)))
           ((|member| (UPCASE |fn|) '(NO OFF)) (SETQ |$openMathFormat| NIL))
           ((|member| (UPCASE |fn|) '(YES ON)) (SETQ |$openMathFormat| T))
           ((EQ (UPCASE |fn|) 'CONSOLE)
            (PROGN
             (|stream_close| |$openMathOutputStream|)
             (SETQ |$openMathOutputStream| (|mkOutputConsoleStream|))
             (SETQ |$openMathOutputFile| "CONSOLE")))))
         ((OR
           (AND (CONSP |arg|)
                (PROGN
                 (SETQ |fn| (CAR |arg|))
                 (SETQ |ISTMP#1| (CDR |arg|))
                 (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                      (PROGN (SETQ |ft| (CAR |ISTMP#1|)) #1#))))
           (AND (CONSP |arg|)
                (PROGN
                 (SETQ |fn| (CAR |arg|))
                 (SETQ |ISTMP#1| (CDR |arg|))
                 (AND (CONSP |ISTMP#1|)
                      (PROGN
                       (SETQ |ft| (CAR |ISTMP#1|))
                       (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                       (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                            (PROGN (SETQ |fm| (CAR |ISTMP#2|)) #1#)))))))
          (PROGN
           (SETQ |LETTMP#1| (|try_open| |fn| |ft| NIL))
           (SETQ |testStream| (CAR |LETTMP#1|))
           (SETQ |filename| (CADR |LETTMP#1|))
           (COND
            (|testStream|
             (PROGN
              (|stream_close| |$openMathOutputStream|)
              (SETQ |$openMathOutputStream| |testStream|)
              (SETQ |$openMathOutputFile| |filename|)
              (|sayKeyedMsg| 'S2IV0004
               (LIST "OpenMath" |$openMathOutputFile|))))
            (#1# (|sayKeyedMsg| 'S2IV0003 (LIST |fn| |ft|))))))
         (#1#
          (PROGN
           (|sayKeyedMsg| 'S2IV0005 NIL)
           (|describeSetOutputOpenMath|))))))))))

; describeSetOutputOpenMath() == describeSetOutputU(
;     '"openmath", '"OpenMath", '"som", false, setOutputOpenMath "%display%")

(DEFUN |describeSetOutputOpenMath| ()
  (PROG ()
    (RETURN
     (|describeSetOutputU| "openmath" "OpenMath" "som" NIL
      (|setOutputOpenMath| '|%display%|)))))

; setOutputTex arg ==
;   arg = "%initialize%" =>
;     $texOutputStream := mkOutputConsoleStream()
;     $texOutputFile := '"CONSOLE"
;     $texFormat := NIL
;
;   arg = "%display%" =>
;     if $texFormat then label := '"On:" else label := '"Off:"
;     STRCONC(label,$texOutputFile)
;
;   (null arg) or (arg = "%describe%") or (first arg = '_?) =>
;     describeSetOutputTex()
;
;   -- try to figure out what the argument is
;
;   if arg is [fn] and
;     fn in '(Y N YE YES NO O ON OF OFF CONSOLE y n ye yes no o on of off console)
;       then 'ok
;       else arg := [fn,'stex]
;
;   arg is [fn] =>
;     UPCASE(fn) in '(Y N YE O OF) =>
;       sayKeyedMsg("S2IV0002",'(TeX tex))
;     UPCASE(fn) in '(NO OFF)  => $texFormat := NIL
;     UPCASE(fn) in '(YES ON) => $texFormat := true
;     UPCASE(fn) = 'CONSOLE =>
;       stream_close($texOutputStream)
;       $texOutputStream := mkOutputConsoleStream()
;       $texOutputFile := '"CONSOLE"
;
;   (arg is [fn,ft]) or (arg is [fn,ft,fm]) => -- aha, a file
;     [testStream, filename] := try_open(fn, ft, false)
;     testStream =>
;       stream_close($texOutputStream)
;       $texOutputStream := testStream
;       $texOutputFile := filename
;       sayKeyedMsg("S2IV0004",['"TeX",$texOutputFile])
;     sayKeyedMsg("S2IV0003",[fn,ft])
;
;   sayKeyedMsg("S2IV0005",NIL)
;   describeSetOutputTex()

(DEFUN |setOutputTex| (|arg|)
  (PROG (|label| |fn| |ISTMP#1| |ft| |ISTMP#2| |fm| |LETTMP#1| |testStream|
         |filename|)
    (RETURN
     (COND
      ((EQ |arg| '|%initialize%|)
       (PROGN
        (SETQ |$texOutputStream| (|mkOutputConsoleStream|))
        (SETQ |$texOutputFile| "CONSOLE")
        (SETQ |$texFormat| NIL)))
      ((EQ |arg| '|%display%|)
       (PROGN
        (COND (|$texFormat| (SETQ |label| "On:"))
              (#1='T (SETQ |label| "Off:")))
        (STRCONC |label| |$texOutputFile|)))
      ((OR (NULL |arg|) (EQ |arg| '|%describe%|) (EQ (CAR |arg|) '?))
       (|describeSetOutputTex|))
      (#1#
       (PROGN
        (COND
         ((AND (CONSP |arg|) (EQ (CDR |arg|) NIL)
               (PROGN (SETQ |fn| (CAR |arg|)) #1#)
               (|member| |fn|
                '(Y N YE YES NO O ON OF OFF CONSOLE |y| |n| |ye| |yes| |no| |o|
                  |on| OF |off| |console|)))
          '|ok|)
         (#1# (SETQ |arg| (LIST |fn| '|stex|))))
        (COND
         ((AND (CONSP |arg|) (EQ (CDR |arg|) NIL)
               (PROGN (SETQ |fn| (CAR |arg|)) #1#))
          (COND
           ((|member| (UPCASE |fn|) '(Y N YE O OF))
            (|sayKeyedMsg| 'S2IV0002 '(|TeX| |tex|)))
           ((|member| (UPCASE |fn|) '(NO OFF)) (SETQ |$texFormat| NIL))
           ((|member| (UPCASE |fn|) '(YES ON)) (SETQ |$texFormat| T))
           ((EQ (UPCASE |fn|) 'CONSOLE)
            (PROGN
             (|stream_close| |$texOutputStream|)
             (SETQ |$texOutputStream| (|mkOutputConsoleStream|))
             (SETQ |$texOutputFile| "CONSOLE")))))
         ((OR
           (AND (CONSP |arg|)
                (PROGN
                 (SETQ |fn| (CAR |arg|))
                 (SETQ |ISTMP#1| (CDR |arg|))
                 (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                      (PROGN (SETQ |ft| (CAR |ISTMP#1|)) #1#))))
           (AND (CONSP |arg|)
                (PROGN
                 (SETQ |fn| (CAR |arg|))
                 (SETQ |ISTMP#1| (CDR |arg|))
                 (AND (CONSP |ISTMP#1|)
                      (PROGN
                       (SETQ |ft| (CAR |ISTMP#1|))
                       (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                       (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                            (PROGN (SETQ |fm| (CAR |ISTMP#2|)) #1#)))))))
          (PROGN
           (SETQ |LETTMP#1| (|try_open| |fn| |ft| NIL))
           (SETQ |testStream| (CAR |LETTMP#1|))
           (SETQ |filename| (CADR |LETTMP#1|))
           (COND
            (|testStream|
             (PROGN
              (|stream_close| |$texOutputStream|)
              (SETQ |$texOutputStream| |testStream|)
              (SETQ |$texOutputFile| |filename|)
              (|sayKeyedMsg| 'S2IV0004 (LIST "TeX" |$texOutputFile|))))
            (#1# (|sayKeyedMsg| 'S2IV0003 (LIST |fn| |ft|))))))
         (#1#
          (PROGN (|sayKeyedMsg| 'S2IV0005 NIL) (|describeSetOutputTex|))))))))))

; describeSetOutputTex() == describeSetOutputU(
;     '"tex", '"TeX", '"stex", false, setOutputTex "%display%")

(DEFUN |describeSetOutputTex| ()
  (PROG ()
    (RETURN
     (|describeSetOutputU| "tex" "TeX" "stex" NIL
      (|setOutputTex| '|%display%|)))))

; setOutputFormatted arg ==
;   arg = "%initialize%" =>
;     $formattedOutputStream := mkOutputConsoleStream()
;     $formattedOutputFile := '"CONSOLE"
;     $formattedFormat := NIL
;
;   arg = "%display%" =>
;     if $formattedFormat then label := '"On:" else label := '"Off:"
;     STRCONC(label, $formattedOutputFile)
;
;   (null arg) or (arg = "%describe%") or (first arg = '_?) =>
;     describeSetOutputFormatted()
;
;   -- try to figure out what the argument is
;
;   if arg is [fn] and
;     fn in '(Y N YE YES NO O ON OF OFF CONSOLE y n ye yes no o on of off console)
;       then 'ok
;       else arg := [fn,'formatted]
;
;   arg is [fn] =>
;     UPCASE(fn) in '(Y N YE O OF) =>
;       sayKeyedMsg("S2IV0002",'(FORMATTED formatted))
;     UPCASE(fn) in '(NO OFF) => $formattedFormat := NIL
;     UPCASE(fn) in '(YES ON) => $formattedFormat := true
;     UPCASE(fn) = 'CONSOLE =>
;       stream_close($formattedOutputStream)
;       $formattedOutputStream := mkOutputConsoleStream()
;       $formattedOutputFile := '"CONSOLE"
;
;   (arg is [fn,ft]) or (arg is [fn,ft,fm]) => -- aha, a file
;     [testStream, filename] := try_open(fn, ft, false)
;     testStream =>
;       stream_close($formattedOutputStream)
;       $formattedOutputStream := testStream
;       $formattedOutputFile := filename
;       sayKeyedMsg("S2IV0004",['"FORMATTED",$formattedOutputFile])
;     sayKeyedMsg("S2IV0003",[fn,ft])
;
;   sayKeyedMsg("S2IV0005",NIL)
;   describeSetOutputFormatted()

(DEFUN |setOutputFormatted| (|arg|)
  (PROG (|label| |fn| |ISTMP#1| |ft| |ISTMP#2| |fm| |LETTMP#1| |testStream|
         |filename|)
    (RETURN
     (COND
      ((EQ |arg| '|%initialize%|)
       (PROGN
        (SETQ |$formattedOutputStream| (|mkOutputConsoleStream|))
        (SETQ |$formattedOutputFile| "CONSOLE")
        (SETQ |$formattedFormat| NIL)))
      ((EQ |arg| '|%display%|)
       (PROGN
        (COND (|$formattedFormat| (SETQ |label| "On:"))
              (#1='T (SETQ |label| "Off:")))
        (STRCONC |label| |$formattedOutputFile|)))
      ((OR (NULL |arg|) (EQ |arg| '|%describe%|) (EQ (CAR |arg|) '?))
       (|describeSetOutputFormatted|))
      (#1#
       (PROGN
        (COND
         ((AND (CONSP |arg|) (EQ (CDR |arg|) NIL)
               (PROGN (SETQ |fn| (CAR |arg|)) #1#)
               (|member| |fn|
                '(Y N YE YES NO O ON OF OFF CONSOLE |y| |n| |ye| |yes| |no| |o|
                  |on| OF |off| |console|)))
          '|ok|)
         (#1# (SETQ |arg| (LIST |fn| '|formatted|))))
        (COND
         ((AND (CONSP |arg|) (EQ (CDR |arg|) NIL)
               (PROGN (SETQ |fn| (CAR |arg|)) #1#))
          (COND
           ((|member| (UPCASE |fn|) '(Y N YE O OF))
            (|sayKeyedMsg| 'S2IV0002 '(FORMATTED |formatted|)))
           ((|member| (UPCASE |fn|) '(NO OFF)) (SETQ |$formattedFormat| NIL))
           ((|member| (UPCASE |fn|) '(YES ON)) (SETQ |$formattedFormat| T))
           ((EQ (UPCASE |fn|) 'CONSOLE)
            (PROGN
             (|stream_close| |$formattedOutputStream|)
             (SETQ |$formattedOutputStream| (|mkOutputConsoleStream|))
             (SETQ |$formattedOutputFile| "CONSOLE")))))
         ((OR
           (AND (CONSP |arg|)
                (PROGN
                 (SETQ |fn| (CAR |arg|))
                 (SETQ |ISTMP#1| (CDR |arg|))
                 (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                      (PROGN (SETQ |ft| (CAR |ISTMP#1|)) #1#))))
           (AND (CONSP |arg|)
                (PROGN
                 (SETQ |fn| (CAR |arg|))
                 (SETQ |ISTMP#1| (CDR |arg|))
                 (AND (CONSP |ISTMP#1|)
                      (PROGN
                       (SETQ |ft| (CAR |ISTMP#1|))
                       (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                       (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                            (PROGN (SETQ |fm| (CAR |ISTMP#2|)) #1#)))))))
          (PROGN
           (SETQ |LETTMP#1| (|try_open| |fn| |ft| NIL))
           (SETQ |testStream| (CAR |LETTMP#1|))
           (SETQ |filename| (CADR |LETTMP#1|))
           (COND
            (|testStream|
             (PROGN
              (|stream_close| |$formattedOutputStream|)
              (SETQ |$formattedOutputStream| |testStream|)
              (SETQ |$formattedOutputFile| |filename|)
              (|sayKeyedMsg| 'S2IV0004
               (LIST "FORMATTED" |$formattedOutputFile|))))
            (#1# (|sayKeyedMsg| 'S2IV0003 (LIST |fn| |ft|))))))
         (#1#
          (PROGN
           (|sayKeyedMsg| 'S2IV0005 NIL)
           (|describeSetOutputFormatted|))))))))))

; describeSetOutputFormatted() == describeSetOutputU(
;     '"formatted",'"formatted",'"formatted",false,setOutputFormatted "%display%")

(DEFUN |describeSetOutputFormatted| ()
  (PROG ()
    (RETURN
     (|describeSetOutputU| "formatted" "formatted" "formatted" NIL
      (|setOutputFormatted| '|%display%|)))))

; setStreamsCalculate arg ==
;   arg = "%initialize%" =>
;     $streamCount := 10
;   arg = "%display%" =>
;     object2String $streamCount
;   (null arg) or (arg = "%describe%") or (first arg = '_?) =>
;     describeSetStreamsCalculate()
;   n := first arg
;   (n ~= 'all) and ((not FIXP n) or (n < 0)) =>
;     sayMessage ['"Your value of",:bright n,'"is invalid because ..."]
;     describeSetStreamsCalculate()
;     terminateSystemCommand()
;   $streamCount := n

(DEFUN |setStreamsCalculate| (|arg|)
  (PROG (|n|)
    (RETURN
     (COND ((EQ |arg| '|%initialize%|) (SETQ |$streamCount| 10))
           ((EQ |arg| '|%display%|) (|object2String| |$streamCount|))
           ((OR (NULL |arg|) (EQ |arg| '|%describe%|) (EQ (CAR |arg|) '?))
            (|describeSetStreamsCalculate|))
           (#1='T
            (PROGN
             (SETQ |n| (CAR |arg|))
             (COND
              ((AND (NOT (EQ |n| '|all|)) (OR (NULL (FIXP |n|)) (MINUSP |n|)))
               (PROGN
                (|sayMessage|
                 (CONS "Your value of"
                       (APPEND (|bright| |n|)
                               (CONS "is invalid because ..." NIL))))
                (|describeSetStreamsCalculate|)
                (|terminateSystemCommand|)))
              (#1# (SETQ |$streamCount| |n|)))))))))

; describeSetStreamsCalculate() == sayKeyedMsg("S2IV0001",[$streamCount])

(DEFUN |describeSetStreamsCalculate| ()
  (PROG () (RETURN (|sayKeyedMsg| 'S2IV0001 (LIST |$streamCount|)))))
