
; )package "BOOT"

(IN-PACKAGE "BOOT")

; flattenSemi(tree) ==
;     not(CONSP(tree)) => tree
;     tree is [";", t1, t2] =>
;         t1 := flattenSemi(t1)
;         t2 := flattenSemi(t2)
;         t1 :=
;             t1 is [";",:rest] => rest
;             [t1]
;         t2 :=
;             t2 is [";",:rest] => rest
;             [t2]
;         [";", :t1, :t2]
;     tree is [";", :.] => BREAK()
;     [flattenSemi(el) for el in tree]

(DEFUN |flattenSemi| (|tree|)
  (PROG (|ISTMP#1| |t1| |ISTMP#2| |t2| CDR)
    (RETURN
     (COND ((NULL (CONSP |tree|)) |tree|)
           ((AND (CONSP |tree|) (EQ (CAR |tree|) '|;|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |tree|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |t1| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |t2| (CAR |ISTMP#2|)) #1='T))))))
            (PROGN
             (SETQ |t1| (|flattenSemi| |t1|))
             (SETQ |t2| (|flattenSemi| |t2|))
             (SETQ |t1|
                     (COND
                      ((AND (CONSP |t1|) (EQ (CAR |t1|) '|;|)
                            (PROGN (SETQ CDR (CDR |t1|)) #1#))
                       CDR)
                      (#1# (LIST |t1|))))
             (SETQ |t2|
                     (COND
                      ((AND (CONSP |t2|) (EQ (CAR |t2|) '|;|)
                            (PROGN (SETQ CDR (CDR |t2|)) #1#))
                       CDR)
                      (#1# (LIST |t2|))))
             (CONS '|;| (APPEND |t1| |t2|))))
           ((AND (CONSP |tree|) (EQ (CAR |tree|) '|;|)) (BREAK))
           (#1#
            ((LAMBDA (|bfVar#2| |bfVar#1| |el|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#1|) (PROGN (SETQ |el| (CAR |bfVar#1|)) NIL))
                  (RETURN (NREVERSE |bfVar#2|)))
                 (#1# (SETQ |bfVar#2| (CONS (|flattenSemi| |el|) |bfVar#2|))))
                (SETQ |bfVar#1| (CDR |bfVar#1|))))
             NIL |tree| NIL))))))

; expandMacros(tree) ==
;     ATOM tree =>
;         mdef := HGET($MacroTable, tree)
;         mdef =>
;             repval := first(mdef)
;             null(rest(mdef)) => expandMacros(repval)
;             userError("macro call needs arguments")
;         tree
;     -- floating point numbers
;     [op, :args] := tree
;     EQ(op, ":BF") => tree
;     ATOM(op) =>
;         mdef := HGET($MacroTable, op)
;         mdef =>
;             repval := first(mdef)
;             margs := rest(mdef)
;             null(margs) =>
;                 [expandMacros(repval), :[expandMacros(x) for x in args]]
;             args :=
;                 args is [[",", :args1]] => postFlatten(first(args), ",")
;                 args
;             #args = #margs =>
;                 expandMacros(SUBLISLIS(args, margs, repval))
;             userError("invalid macro call, #args ~= #margs")
;         [op, :[expandMacros(x) for x in args]]
;     [expandMacros(x) for x in tree]

(DEFUN |expandMacros| (|tree|)
  (PROG (|mdef| |repval| |op| |args| |margs| |ISTMP#1| |args1|)
    (RETURN
     (COND
      ((ATOM |tree|)
       (PROGN
        (SETQ |mdef| (HGET |$MacroTable| |tree|))
        (COND
         (|mdef|
          (PROGN
           (SETQ |repval| (CAR |mdef|))
           (COND ((NULL (CDR |mdef|)) (|expandMacros| |repval|))
                 (#1='T (|userError| '|macro call needs arguments|)))))
         (#1# |tree|))))
      (#1#
       (PROGN
        (SETQ |op| (CAR |tree|))
        (SETQ |args| (CDR |tree|))
        (COND ((EQ |op| '|:BF|) |tree|)
              ((ATOM |op|)
               (PROGN
                (SETQ |mdef| (HGET |$MacroTable| |op|))
                (COND
                 (|mdef|
                  (PROGN
                   (SETQ |repval| (CAR |mdef|))
                   (SETQ |margs| (CDR |mdef|))
                   (COND
                    ((NULL |margs|)
                     (CONS (|expandMacros| |repval|)
                           ((LAMBDA (|bfVar#4| |bfVar#3| |x|)
                              (LOOP
                               (COND
                                ((OR (ATOM |bfVar#3|)
                                     (PROGN (SETQ |x| (CAR |bfVar#3|)) NIL))
                                 (RETURN (NREVERSE |bfVar#4|)))
                                (#1#
                                 (SETQ |bfVar#4|
                                         (CONS (|expandMacros| |x|)
                                               |bfVar#4|))))
                               (SETQ |bfVar#3| (CDR |bfVar#3|))))
                            NIL |args| NIL)))
                    (#1#
                     (PROGN
                      (SETQ |args|
                              (COND
                               ((AND (CONSP |args|) (EQ (CDR |args|) NIL)
                                     (PROGN
                                      (SETQ |ISTMP#1| (CAR |args|))
                                      (AND (CONSP |ISTMP#1|)
                                           (EQ (CAR |ISTMP#1|) '|,|)
                                           (PROGN
                                            (SETQ |args1| (CDR |ISTMP#1|))
                                            #1#))))
                                (|postFlatten| (CAR |args|) '|,|))
                               (#1# |args|)))
                      (COND
                       ((EQL (LENGTH |args|) (LENGTH |margs|))
                        (|expandMacros| (SUBLISLIS |args| |margs| |repval|)))
                       (#1#
                        (|userError|
                         '|invalid macro call, #args ~= #margs|))))))))
                 (#1#
                  (CONS |op|
                        ((LAMBDA (|bfVar#6| |bfVar#5| |x|)
                           (LOOP
                            (COND
                             ((OR (ATOM |bfVar#5|)
                                  (PROGN (SETQ |x| (CAR |bfVar#5|)) NIL))
                              (RETURN (NREVERSE |bfVar#6|)))
                             (#1#
                              (SETQ |bfVar#6|
                                      (CONS (|expandMacros| |x|) |bfVar#6|))))
                            (SETQ |bfVar#5| (CDR |bfVar#5|))))
                         NIL |args| NIL))))))
              (#1#
               ((LAMBDA (|bfVar#8| |bfVar#7| |x|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#7|)
                         (PROGN (SETQ |x| (CAR |bfVar#7|)) NIL))
                     (RETURN (NREVERSE |bfVar#8|)))
                    (#1#
                     (SETQ |bfVar#8| (CONS (|expandMacros| |x|) |bfVar#8|))))
                   (SETQ |bfVar#7| (CDR |bfVar#7|))))
                NIL |tree| NIL)))))))))

; replaceArgDef1(args, edef) ==
;     SYMBOLP args =>
;         edef is [":", args, .] => edef
;         BREAK()
;     args is  [",", args1, args2] =>
;         EQ(args2, NTH(1, edef)) => [",", args1, edef]
;         [",", replaceArgDef1(args1, edef), args2]
;     BREAK()

(DEFUN |replaceArgDef1| (|args| |edef|)
  (PROG (|ISTMP#1| |ISTMP#2| |args1| |args2|)
    (RETURN
     (COND
      ((SYMBOLP |args|)
       (COND
        ((AND (CONSP |edef|) (EQ (CAR |edef|) '|:|)
              (PROGN
               (SETQ |ISTMP#1| (CDR |edef|))
               (AND (CONSP |ISTMP#1|)
                    (PROGN
                     (SETQ |args| (CAR |ISTMP#1|))
                     (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                     (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL))))))
         |edef|)
        (#1='T (BREAK))))
      ((AND (CONSP |args|) (EQ (CAR |args|) '|,|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |args|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |args1| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |args2| (CAR |ISTMP#2|)) #1#))))))
       (COND ((EQ |args2| (NTH 1 |edef|)) (LIST '|,| |args1| |edef|))
             (#1# (LIST '|,| (|replaceArgDef1| |args1| |edef|) |args2|))))
      (#1# (BREAK))))))

; replaceArgDef(h1, edef) ==
;    h1 is [name, args] => [name, replaceArgDef1(args, edef)]
;    BREAK()

(DEFUN |replaceArgDef| (|h1| |edef|)
  (PROG (|name| |ISTMP#1| |args|)
    (RETURN
     (COND
      ((AND (CONSP |h1|)
            (PROGN
             (SETQ |name| (CAR |h1|))
             (SETQ |ISTMP#1| (CDR |h1|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |args| (CAR |ISTMP#1|)) #1='T))))
       (LIST |name| (|replaceArgDef1| |args| |edef|)))
      (#1# (BREAK))))))

; replaceArgDefs1(h1, edefs) ==
;     for edef in edefs repeat
;         h1 := replaceArgDef(h1, edef)
;     h1

(DEFUN |replaceArgDefs1| (|h1| |edefs|)
  (PROG ()
    (RETURN
     (PROGN
      ((LAMBDA (|bfVar#9| |edef|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#9|) (PROGN (SETQ |edef| (CAR |bfVar#9|)) NIL))
            (RETURN NIL))
           ('T (SETQ |h1| (|replaceArgDef| |h1| |edef|))))
          (SETQ |bfVar#9| (CDR |bfVar#9|))))
       |edefs| NIL)
      |h1|))))

; replaceArgDefs(header, edefs) ==
;     header is [":", h1, type] => [":", replaceArgDefs1(h1, edefs), type]
;     replaceArgDefs1(header, edefs)

(DEFUN |replaceArgDefs| (|header| |edefs|)
  (PROG (|ISTMP#1| |h1| |ISTMP#2| |type|)
    (RETURN
     (COND
      ((AND (CONSP |header|) (EQ (CAR |header|) '|:|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |header|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |h1| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |type| (CAR |ISTMP#2|)) #1='T))))))
       (LIST '|:| (|replaceArgDefs1| |h1| |edefs|) |type|))
      (#1# (|replaceArgDefs1| |header| |edefs|))))))

; DEFPARAMETER($restore_list, nil)

(DEFPARAMETER |$restore_list| NIL)

; define_macro(name, def) ==
;     if SYMBOLP(name) then
;         def := [def]
;     else if name is [op, :args] and SYMBOLP(op) then
;         args :=
;             args is [[",", :args1]] => postFlatten(first(args), ",")
;             args
;         name := op
;         def := [def, :args]
;     else
;         SAY([name, def])
;         userError("Invalid macro definition")
;     prev_def := HGET($MacroTable, name)
;     PUSH([name, :prev_def], $restore_list)
;     HPUT($MacroTable, name, def)

(DEFUN |define_macro| (|name| |def|)
  (PROG (|op| |args| |ISTMP#1| |args1| |prev_def|)
    (RETURN
     (PROGN
      (COND ((SYMBOLP |name|) (SETQ |def| (LIST |def|)))
            ((AND (CONSP |name|)
                  (PROGN
                   (SETQ |op| (CAR |name|))
                   (SETQ |args| (CDR |name|))
                   #1='T)
                  (SYMBOLP |op|))
             (SETQ |args|
                     (COND
                      ((AND (CONSP |args|) (EQ (CDR |args|) NIL)
                            (PROGN
                             (SETQ |ISTMP#1| (CAR |args|))
                             (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|,|)
                                  (PROGN (SETQ |args1| (CDR |ISTMP#1|)) #1#))))
                       (|postFlatten| (CAR |args|) '|,|))
                      (#1# |args|)))
             (SETQ |name| |op|) (SETQ |def| (CONS |def| |args|)))
            (#1# (SAY (LIST |name| |def|))
             (|userError| '|Invalid macro definition|)))
      (SETQ |prev_def| (HGET |$MacroTable| |name|))
      (PUSH (CONS |name| |prev_def|) |$restore_list|)
      (HPUT |$MacroTable| |name| |def|)))))

; do_walk_where_list(tree) ==
;     lastIteration := false
;     ress := nil
;     while not(lastIteration) repeat
;         if tree is [";", tree1, el] then
;             tree := tree1
;         else
;             el := tree
;             lastIteration := true
;         el is ["==>", name, def] => define_macro(name, def)
;         el is ["==", name, def] =>
;             define_macro(name, def)
;         el is [":", ., .] =>
;             ress := [el, :ress]
;         el is [",", pel, item] =>
;             item is [":", sym, type] =>
;                 sl := [sym]
;                 while pel is [",", pel1, sym] repeat
;                     sl := [sym, :sl]
;                     pel := pel1
;                 if not(SYMBOLP pel) then
;                     FORMAT(true, '"strange where |,| item2")
;                     BREAK()
;                 sl := [pel, :sl]
;                 for sym in sl repeat
;                     ress := [[":", sym, type], :ress]
;             FORMAT(true, '"strange where |,| item1")
;             BREAK()
;         FORMAT(true, '"strange where item: ~S~&", el)
;         BREAK()
;     ress

(DEFUN |do_walk_where_list| (|tree|)
  (PROG (|lastIteration| |ress| |ISTMP#1| |tree1| |ISTMP#2| |el| |name| |def|
         |pel| |item| |sym| |type| |sl| |pel1|)
    (RETURN
     (PROGN
      (SETQ |lastIteration| NIL)
      (SETQ |ress| NIL)
      ((LAMBDA ()
         (LOOP
          (COND (|lastIteration| (RETURN NIL))
                (#1='T
                 (PROGN
                  (COND
                   ((AND (CONSP |tree|) (EQ (CAR |tree|) '|;|)
                         (PROGN
                          (SETQ |ISTMP#1| (CDR |tree|))
                          (AND (CONSP |ISTMP#1|)
                               (PROGN
                                (SETQ |tree1| (CAR |ISTMP#1|))
                                (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                     (PROGN
                                      (SETQ |el| (CAR |ISTMP#2|))
                                      #1#))))))
                    (SETQ |tree| |tree1|))
                   (#1# (SETQ |el| |tree|) (SETQ |lastIteration| T)))
                  (COND
                   ((AND (CONSP |el|) (EQ (CAR |el|) '==>)
                         (PROGN
                          (SETQ |ISTMP#1| (CDR |el|))
                          (AND (CONSP |ISTMP#1|)
                               (PROGN
                                (SETQ |name| (CAR |ISTMP#1|))
                                (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                     (PROGN
                                      (SETQ |def| (CAR |ISTMP#2|))
                                      #1#))))))
                    (|define_macro| |name| |def|))
                   ((AND (CONSP |el|) (EQ (CAR |el|) '==)
                         (PROGN
                          (SETQ |ISTMP#1| (CDR |el|))
                          (AND (CONSP |ISTMP#1|)
                               (PROGN
                                (SETQ |name| (CAR |ISTMP#1|))
                                (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                     (PROGN
                                      (SETQ |def| (CAR |ISTMP#2|))
                                      #1#))))))
                    (|define_macro| |name| |def|))
                   ((AND (CONSP |el|) (EQ (CAR |el|) '|:|)
                         (PROGN
                          (SETQ |ISTMP#1| (CDR |el|))
                          (AND (CONSP |ISTMP#1|)
                               (PROGN
                                (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                (AND (CONSP |ISTMP#2|)
                                     (EQ (CDR |ISTMP#2|) NIL))))))
                    (SETQ |ress| (CONS |el| |ress|)))
                   ((AND (CONSP |el|) (EQ (CAR |el|) '|,|)
                         (PROGN
                          (SETQ |ISTMP#1| (CDR |el|))
                          (AND (CONSP |ISTMP#1|)
                               (PROGN
                                (SETQ |pel| (CAR |ISTMP#1|))
                                (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                     (PROGN
                                      (SETQ |item| (CAR |ISTMP#2|))
                                      #1#))))))
                    (COND
                     ((AND (CONSP |item|) (EQ (CAR |item|) '|:|)
                           (PROGN
                            (SETQ |ISTMP#1| (CDR |item|))
                            (AND (CONSP |ISTMP#1|)
                                 (PROGN
                                  (SETQ |sym| (CAR |ISTMP#1|))
                                  (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                  (AND (CONSP |ISTMP#2|)
                                       (EQ (CDR |ISTMP#2|) NIL)
                                       (PROGN
                                        (SETQ |type| (CAR |ISTMP#2|))
                                        #1#))))))
                      (PROGN
                       (SETQ |sl| (LIST |sym|))
                       ((LAMBDA ()
                          (LOOP
                           (COND
                            ((NOT
                              (AND (CONSP |pel|) (EQ (CAR |pel|) '|,|)
                                   (PROGN
                                    (SETQ |ISTMP#1| (CDR |pel|))
                                    (AND (CONSP |ISTMP#1|)
                                         (PROGN
                                          (SETQ |pel1| (CAR |ISTMP#1|))
                                          (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                          (AND (CONSP |ISTMP#2|)
                                               (EQ (CDR |ISTMP#2|) NIL)
                                               (PROGN
                                                (SETQ |sym| (CAR |ISTMP#2|))
                                                #1#)))))))
                             (RETURN NIL))
                            (#1#
                             (PROGN
                              (SETQ |sl| (CONS |sym| |sl|))
                              (SETQ |pel| |pel1|)))))))
                       (COND
                        ((NULL (SYMBOLP |pel|))
                         (FORMAT T "strange where |,| item2") (BREAK)))
                       (SETQ |sl| (CONS |pel| |sl|))
                       ((LAMBDA (|bfVar#10| |sym|)
                          (LOOP
                           (COND
                            ((OR (ATOM |bfVar#10|)
                                 (PROGN (SETQ |sym| (CAR |bfVar#10|)) NIL))
                             (RETURN NIL))
                            (#1#
                             (SETQ |ress|
                                     (CONS (LIST '|:| |sym| |type|) |ress|))))
                           (SETQ |bfVar#10| (CDR |bfVar#10|))))
                        |sl| NIL)))
                     (#1#
                      (PROGN (FORMAT T "strange where |,| item1") (BREAK)))))
                   (#1#
                    (PROGN
                     (FORMAT T "strange where item: ~S~&" |el|)
                     (BREAK))))))))))
      |ress|))))

; walkWhereList(name, def, env) ==
;     $restore_list : local := nil
;     edefs := do_walk_where_list env
;     ress := expandMacros(["==", replaceArgDefs(name, edefs), def])
;     for it in $restore_list repeat
;         [op, :def] := it
;         HPUT($MacroTable, op, def)
;     ress

(DEFUN |walkWhereList| (|name| |def| |env|)
  (PROG (|$restore_list| |op| |ress| |edefs|)
    (DECLARE (SPECIAL |$restore_list|))
    (RETURN
     (PROGN
      (SETQ |$restore_list| NIL)
      (SETQ |edefs| (|do_walk_where_list| |env|))
      (SETQ |ress|
              (|expandMacros|
               (LIST '== (|replaceArgDefs| |name| |edefs|) |def|)))
      ((LAMBDA (|bfVar#11| |it|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#11|) (PROGN (SETQ |it| (CAR |bfVar#11|)) NIL))
            (RETURN NIL))
           ('T
            (PROGN
             (SETQ |op| (CAR |it|))
             (SETQ |def| (CDR |it|))
             (HPUT |$MacroTable| |op| |def|))))
          (SETQ |bfVar#11| (CDR |bfVar#11|))))
       |$restore_list| NIL)
      |ress|))))

; walkForm(tree) ==
;     tree is ["==>", name, def] =>
;         define_macro(name, def)
;         nil
;     tree is ["==", head, def] => expandMacros(tree)
;     tree is ["where", ["==", name, def], env] =>
;         walkWhereList(name, def, env)
;     userError("Parsing error: illegal toplevel form")
;     nil

(DEFUN |walkForm| (|tree|)
  (PROG (|ISTMP#1| |name| |ISTMP#2| |def| |head| |ISTMP#3| |ISTMP#4| |ISTMP#5|
         |env|)
    (RETURN
     (COND
      ((AND (CONSP |tree|) (EQ (CAR |tree|) '==>)
            (PROGN
             (SETQ |ISTMP#1| (CDR |tree|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |name| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |def| (CAR |ISTMP#2|)) #1='T))))))
       (PROGN (|define_macro| |name| |def|) NIL))
      ((AND (CONSP |tree|) (EQ (CAR |tree|) '==)
            (PROGN
             (SETQ |ISTMP#1| (CDR |tree|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |head| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |def| (CAR |ISTMP#2|)) #1#))))))
       (|expandMacros| |tree|))
      ((AND (CONSP |tree|) (EQ (CAR |tree|) '|where|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |tree|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CAR |ISTMP#2|) '==)
                        (PROGN
                         (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                         (AND (CONSP |ISTMP#3|)
                              (PROGN
                               (SETQ |name| (CAR |ISTMP#3|))
                               (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                               (AND (CONSP |ISTMP#4|) (EQ (CDR |ISTMP#4|) NIL)
                                    (PROGN
                                     (SETQ |def| (CAR |ISTMP#4|))
                                     #1#)))))))
                  (PROGN
                   (SETQ |ISTMP#5| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#5|) (EQ (CDR |ISTMP#5|) NIL)
                        (PROGN (SETQ |env| (CAR |ISTMP#5|)) #1#))))))
       (|walkWhereList| |name| |def| |env|))
      (#1#
       (PROGN (|userError| '|Parsing error: illegal toplevel form|) NIL))))))

; isNiladic(head1) ==
;     SYMBOLP head1 => true
;     head1 is [., ["@Tuple"]]

(DEFUN |isNiladic| (|head1|)
  (PROG (|ISTMP#1| |ISTMP#2|)
    (RETURN
     (COND ((SYMBOLP |head1|) T)
           ('T
            (AND (CONSP |head1|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |head1|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                       (PROGN
                        (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (EQ (CAR |ISTMP#2|) '|@Tuple|)))))))))))

; getCon(head1) ==
;     SYMBOLP head1 => head1
;     first head1

(DEFUN |getCon| (|head1|)
  (PROG () (RETURN (COND ((SYMBOLP |head1|) |head1|) ('T (CAR |head1|))))))

; processGlobals1() ==
;     for form in $globalDefs repeat
;         [., head, :.] := form
;         head1 :=
;             head is [":", a, .] => a
;             head
;         con := getCon head1
;         -- at this stage distinction between domain and package does
;         -- not matter, so we treat packages as domains
;         if head is [":", ., "Category"] then
;             SETDATABASE(con, 'CONSTRUCTORKIND, "category")
;         else
;             SETDATABASE(con, 'CONSTRUCTORKIND, "domain")
;         SETDATABASE(con, 'NILADIC, isNiladic head1)

(DEFUN |processGlobals1| ()
  (PROG (|con| |head1| |ISTMP#2| |a| |ISTMP#1| |head|)
    (RETURN
     ((LAMBDA (|bfVar#12| |form|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#12|) (PROGN (SETQ |form| (CAR |bfVar#12|)) NIL))
           (RETURN NIL))
          (#1='T
           (PROGN
            (SETQ |head| (CADR |form|))
            (SETQ |head1|
                    (COND
                     ((AND (CONSP |head|) (EQ (CAR |head|) '|:|)
                           (PROGN
                            (SETQ |ISTMP#1| (CDR |head|))
                            (AND (CONSP |ISTMP#1|)
                                 (PROGN
                                  (SETQ |a| (CAR |ISTMP#1|))
                                  (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                  (AND (CONSP |ISTMP#2|)
                                       (EQ (CDR |ISTMP#2|) NIL))))))
                      |a|)
                     (#1# |head|)))
            (SETQ |con| (|getCon| |head1|))
            (COND
             ((AND (CONSP |head|) (EQ (CAR |head|) '|:|)
                   (PROGN
                    (SETQ |ISTMP#1| (CDR |head|))
                    (AND (CONSP |ISTMP#1|)
                         (PROGN
                          (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                          (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                               (EQ (CAR |ISTMP#2|) '|Category|))))))
              (SETDATABASE |con| 'CONSTRUCTORKIND '|category|))
             (#1# (SETDATABASE |con| 'CONSTRUCTORKIND '|domain|)))
            (SETDATABASE |con| 'NILADIC (|isNiladic| |head1|)))))
         (SETQ |bfVar#12| (CDR |bfVar#12|))))
      |$globalDefs| NIL))))

; processGlobals () ==
;     $InteractiveMode : local := nil
;     $globalDefs := REVERSE $globalDefs
;     processGlobals1()
;     $globalDefs := [parseTransform postTransform x for x in $globalDefs]
;     untypedDefs := []
;     for def in $globalDefs repeat
;         ["DEF", form, sig, body] := def
;         cosig := CONS(nil, [categoryForm? ty for ty in rest(sig)])
;         SETDATABASE(first form, 'COSIG, cosig)
;         if null first(sig) then
;             untypedDefs := [def, :untypedDefs]
;         else
;             handleKind(def)
;
;     for def in untypedDefs repeat
;         ["DEF", form, sig, body] := def
;         nt := computeTargetMode(form, body)
;         if nt then
;             handleKind(["DEF", form, [nt, :rest sig], body])
;         else
;             SAY(["unhandled target", form])
;     boo_comp_cats()

(DEFUN |processGlobals| ()
  (PROG (|$InteractiveMode| |untypedDefs| |form| |sig| |body| |cosig| |nt|)
    (DECLARE (SPECIAL |$InteractiveMode|))
    (RETURN
     (PROGN
      (SETQ |$InteractiveMode| NIL)
      (SETQ |$globalDefs| (REVERSE |$globalDefs|))
      (|processGlobals1|)
      (SETQ |$globalDefs|
              ((LAMBDA (|bfVar#14| |bfVar#13| |x|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#13|)
                        (PROGN (SETQ |x| (CAR |bfVar#13|)) NIL))
                    (RETURN (NREVERSE |bfVar#14|)))
                   (#1='T
                    (SETQ |bfVar#14|
                            (CONS (|parseTransform| (|postTransform| |x|))
                                  |bfVar#14|))))
                  (SETQ |bfVar#13| (CDR |bfVar#13|))))
               NIL |$globalDefs| NIL))
      (SETQ |untypedDefs| NIL)
      ((LAMBDA (|bfVar#15| |def|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#15|) (PROGN (SETQ |def| (CAR |bfVar#15|)) NIL))
            (RETURN NIL))
           (#1#
            (PROGN
             (SETQ |form| (CADR . #2=(|def|)))
             (SETQ |sig| (CADDR . #2#))
             (SETQ |body| (CADDDR . #2#))
             (SETQ |cosig|
                     (CONS NIL
                           ((LAMBDA (|bfVar#17| |bfVar#16| |ty|)
                              (LOOP
                               (COND
                                ((OR (ATOM |bfVar#16|)
                                     (PROGN (SETQ |ty| (CAR |bfVar#16|)) NIL))
                                 (RETURN (NREVERSE |bfVar#17|)))
                                (#1#
                                 (SETQ |bfVar#17|
                                         (CONS (|categoryForm?| |ty|)
                                               |bfVar#17|))))
                               (SETQ |bfVar#16| (CDR |bfVar#16|))))
                            NIL (CDR |sig|) NIL)))
             (SETDATABASE (CAR |form|) 'COSIG |cosig|)
             (COND
              ((NULL (CAR |sig|))
               (SETQ |untypedDefs| (CONS |def| |untypedDefs|)))
              (#1# (|handleKind| |def|))))))
          (SETQ |bfVar#15| (CDR |bfVar#15|))))
       |$globalDefs| NIL)
      ((LAMBDA (|bfVar#18| |def|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#18|) (PROGN (SETQ |def| (CAR |bfVar#18|)) NIL))
            (RETURN NIL))
           (#1#
            (PROGN
             (SETQ |form| (CADR . #3=(|def|)))
             (SETQ |sig| (CADDR . #3#))
             (SETQ |body| (CADDDR . #3#))
             (SETQ |nt| (|computeTargetMode| |form| |body|))
             (COND
              (|nt|
               (|handleKind|
                (LIST 'DEF |form| (CONS |nt| (CDR |sig|)) |body|)))
              (#1# (SAY (LIST '|unhandled target| |form|)))))))
          (SETQ |bfVar#18| (CDR |bfVar#18|))))
       |untypedDefs| NIL)
      (|boo_comp_cats|)))))

; handleKind(df is ['DEF, form, sig, body]) ==
;     [op, :argl] := form
;
;     null first(sig) => nil
;     if sig is [["Category"], :.] then
;         if body is ['add,cat,capsule] then
;             body := cat
;         sargl:= TAKE(# argl, $TriangleVariableList)
;         aList:= [[a,:sa] for a in argl for sa in sargl]
;         formalBody:= SUBLIS(aList,body)
;         if (not(opOf(formalBody) = "Join")) and _
;            (not(opOf(formalBody) = "mkCategory")) then
;            formalBody := ['Join, formalBody]
;         signature' := SUBLIS(aList,sig)
;         constructorCategory := formalBody
;     else
;         signature' := sig
;
;     pairlis:= [[a,:v] for a in argl for v in $FormalMapVariableList]
;     parSignature:= SUBLIS(pairlis,signature')
;     parForm:= SUBLIS(pairlis,form)
;     constructorModemap := removeZeroOne [[parForm,:parSignature],[true,op]]
;     SETDATABASE(op, 'CONSTRUCTORMODEMAP, constructorModemap)
;     SETDATABASE(op, 'CONSTRUCTORCATEGORY, constructorCategory)

(DEFUN |handleKind| (|df|)
  (PROG (|form| |sig| |body| |op| |argl| |ISTMP#1| |cat| |ISTMP#2| |capsule|
         |sargl| |aList| |formalBody| |signature'| |constructorCategory|
         |pairlis| |parSignature| |parForm| |constructorModemap|)
    (RETURN
     (PROGN
      (SETQ |form| (CADR . #1=(|df|)))
      (SETQ |sig| (CADDR . #1#))
      (SETQ |body| (CADDDR . #1#))
      (SETQ |op| (CAR |form|))
      (SETQ |argl| (CDR |form|))
      (COND ((NULL (CAR |sig|)) NIL)
            (#2='T
             (PROGN
              (COND
               ((AND (CONSP |sig|)
                     (PROGN
                      (SETQ |ISTMP#1| (CAR |sig|))
                      (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                           (EQ (CAR |ISTMP#1|) '|Category|))))
                (COND
                 ((AND (CONSP |body|) (EQ (CAR |body|) '|add|)
                       (PROGN
                        (SETQ |ISTMP#1| (CDR |body|))
                        (AND (CONSP |ISTMP#1|)
                             (PROGN
                              (SETQ |cat| (CAR |ISTMP#1|))
                              (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                              (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                   (PROGN
                                    (SETQ |capsule| (CAR |ISTMP#2|))
                                    #2#))))))
                  (SETQ |body| |cat|)))
                (SETQ |sargl| (TAKE (LENGTH |argl|) |$TriangleVariableList|))
                (SETQ |aList|
                        ((LAMBDA (|bfVar#21| |bfVar#19| |a| |bfVar#20| |sa|)
                           (LOOP
                            (COND
                             ((OR (ATOM |bfVar#19|)
                                  (PROGN (SETQ |a| (CAR |bfVar#19|)) NIL)
                                  (ATOM |bfVar#20|)
                                  (PROGN (SETQ |sa| (CAR |bfVar#20|)) NIL))
                              (RETURN (NREVERSE |bfVar#21|)))
                             (#2#
                              (SETQ |bfVar#21|
                                      (CONS (CONS |a| |sa|) |bfVar#21|))))
                            (SETQ |bfVar#19| (CDR |bfVar#19|))
                            (SETQ |bfVar#20| (CDR |bfVar#20|))))
                         NIL |argl| NIL |sargl| NIL))
                (SETQ |formalBody| (SUBLIS |aList| |body|))
                (COND
                 ((AND (NULL (EQ (|opOf| |formalBody|) '|Join|))
                       (NULL (EQ (|opOf| |formalBody|) '|mkCategory|)))
                  (SETQ |formalBody| (LIST '|Join| |formalBody|))))
                (SETQ |signature'| (SUBLIS |aList| |sig|))
                (SETQ |constructorCategory| |formalBody|))
               (#2# (SETQ |signature'| |sig|)))
              (SETQ |pairlis|
                      ((LAMBDA (|bfVar#24| |bfVar#22| |a| |bfVar#23| |v|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#22|)
                                (PROGN (SETQ |a| (CAR |bfVar#22|)) NIL)
                                (ATOM |bfVar#23|)
                                (PROGN (SETQ |v| (CAR |bfVar#23|)) NIL))
                            (RETURN (NREVERSE |bfVar#24|)))
                           (#2#
                            (SETQ |bfVar#24|
                                    (CONS (CONS |a| |v|) |bfVar#24|))))
                          (SETQ |bfVar#22| (CDR |bfVar#22|))
                          (SETQ |bfVar#23| (CDR |bfVar#23|))))
                       NIL |argl| NIL |$FormalMapVariableList| NIL))
              (SETQ |parSignature| (SUBLIS |pairlis| |signature'|))
              (SETQ |parForm| (SUBLIS |pairlis| |form|))
              (SETQ |constructorModemap|
                      (|removeZeroOne|
                       (LIST (CONS |parForm| |parSignature|) (LIST T |op|))))
              (SETDATABASE |op| 'CONSTRUCTORMODEMAP |constructorModemap|)
              (SETDATABASE |op| 'CONSTRUCTORCATEGORY
               |constructorCategory|))))))))

; boo_comp_cats() ==
;     $compiler_output_stream := MAKE_-BROADCAST_-STREAM()
;     $bootStrapMode : local := true
;     SAY(["boo_comp_cats"])
;     hcats := []
;     for def in $globalDefs repeat
;         ["DEF", form, sig, body] := def
;         if sig is [["Category"], :.] then
;             SAY(["doing", form, sig])
;             not("and"/[categoryForm? ty for ty in rest(sig)]) =>
;                 hcats := cons(def, hcats)
;             boo_comp1(def)
;     for def in hcats repeat boo_comp1(def)

(DEFUN |boo_comp_cats| ()
  (PROG (|$bootStrapMode| |hcats| |form| |sig| |body| |ISTMP#1|)
    (DECLARE (SPECIAL |$bootStrapMode|))
    (RETURN
     (PROGN
      (SETQ |$compiler_output_stream| (MAKE-BROADCAST-STREAM))
      (SETQ |$bootStrapMode| T)
      (SAY (LIST '|boo_comp_cats|))
      (SETQ |hcats| NIL)
      ((LAMBDA (|bfVar#25| |def|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#25|) (PROGN (SETQ |def| (CAR |bfVar#25|)) NIL))
            (RETURN NIL))
           (#1='T
            (PROGN
             (SETQ |form| (CADR . #2=(|def|)))
             (SETQ |sig| (CADDR . #2#))
             (SETQ |body| (CADDDR . #2#))
             (COND
              ((AND (CONSP |sig|)
                    (PROGN
                     (SETQ |ISTMP#1| (CAR |sig|))
                     (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                          (EQ (CAR |ISTMP#1|) '|Category|))))
               (SAY (LIST '|doing| |form| |sig|))
               (COND
                ((NULL
                  ((LAMBDA (|bfVar#27| |bfVar#26| |ty|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#26|)
                            (PROGN (SETQ |ty| (CAR |bfVar#26|)) NIL))
                        (RETURN |bfVar#27|))
                       (#1#
                        (PROGN
                         (SETQ |bfVar#27| (|categoryForm?| |ty|))
                         (COND ((NOT |bfVar#27|) (RETURN NIL))))))
                      (SETQ |bfVar#26| (CDR |bfVar#26|))))
                   T (CDR |sig|) NIL))
                 (SETQ |hcats| (CONS |def| |hcats|)))
                (#1# (|boo_comp1| |def|))))))))
          (SETQ |bfVar#25| (CDR |bfVar#25|))))
       |$globalDefs| NIL)
      ((LAMBDA (|bfVar#28| |def|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#28|) (PROGN (SETQ |def| (CAR |bfVar#28|)) NIL))
            (RETURN NIL))
           (#1# (|boo_comp1| |def|)))
          (SETQ |bfVar#28| (CDR |bfVar#28|))))
       |hcats| NIL)))))

; boo_comp1(x) ==
;     $Index : local := 0
;     $MACROASSOC : local := []
;     $compUniquelyIfTrue : local := nil
;     $postStack : local := nil
;     $topOp : local := nil
;     $semanticErrorStack : local := []
;     $warningStack : local := []
;     $exitMode : local := $EmptyMode
;     $exitModeStack : local := []
;     $returnMode : local := $EmptyMode
;     $leaveLevelStack : local := []
;     $iterate_tag : local := []
;     $iterate_count : local := 0
;     $CategoryFrame : local := [[[]]]
;     $insideFunctorIfTrue : local := false
;     $insideWhereIfTrue : local := false
;     $insideCategoryIfTrue : local := false
;     $insideCapsuleFunctionIfTrue : local := false
;     $e : local := $EmptyEnvironment
;     $genSDVar : local :=  0
;     $previousTime : local := get_run_time()
;     compTopLevel(x, $EmptyMode,  [[[]]])
;     if $semanticErrorStack then displaySemanticErrors()

(DEFUN |boo_comp1| (|x|)
  (PROG (|$previousTime| |$genSDVar| |$e| |$insideCapsuleFunctionIfTrue|
         |$insideCategoryIfTrue| |$insideWhereIfTrue| |$insideFunctorIfTrue|
         |$CategoryFrame| |$iterate_count| |$iterate_tag| |$leaveLevelStack|
         |$returnMode| |$exitModeStack| |$exitMode| |$warningStack|
         |$semanticErrorStack| |$topOp| |$postStack| |$compUniquelyIfTrue|
         $MACROASSOC |$Index|)
    (DECLARE
     (SPECIAL |$previousTime| |$genSDVar| |$e| |$insideCapsuleFunctionIfTrue|
      |$insideCategoryIfTrue| |$insideWhereIfTrue| |$insideFunctorIfTrue|
      |$CategoryFrame| |$iterate_count| |$iterate_tag| |$leaveLevelStack|
      |$returnMode| |$exitModeStack| |$exitMode| |$warningStack|
      |$semanticErrorStack| |$topOp| |$postStack| |$compUniquelyIfTrue|
      $MACROASSOC |$Index|))
    (RETURN
     (PROGN
      (SETQ |$Index| 0)
      (SETQ $MACROASSOC NIL)
      (SETQ |$compUniquelyIfTrue| NIL)
      (SETQ |$postStack| NIL)
      (SETQ |$topOp| NIL)
      (SETQ |$semanticErrorStack| NIL)
      (SETQ |$warningStack| NIL)
      (SETQ |$exitMode| |$EmptyMode|)
      (SETQ |$exitModeStack| NIL)
      (SETQ |$returnMode| |$EmptyMode|)
      (SETQ |$leaveLevelStack| NIL)
      (SETQ |$iterate_tag| NIL)
      (SETQ |$iterate_count| 0)
      (SETQ |$CategoryFrame| (LIST (LIST NIL)))
      (SETQ |$insideFunctorIfTrue| NIL)
      (SETQ |$insideWhereIfTrue| NIL)
      (SETQ |$insideCategoryIfTrue| NIL)
      (SETQ |$insideCapsuleFunctionIfTrue| NIL)
      (SETQ |$e| |$EmptyEnvironment|)
      (SETQ |$genSDVar| 0)
      (SETQ |$previousTime| (|get_run_time|))
      (|compTopLevel| |x| |$EmptyMode| (LIST (LIST NIL)))
      (COND (|$semanticErrorStack| (|displaySemanticErrors|)))))))

; computeTargetMode(lhs, rhs) ==
;     PRETTYPRINT(["computeTargetMode", lhs])
;     rhs is ['CAPSULE,:.] => MOAN(['"target category of ", lhs,_
;           '" cannot be determined from definition"],nil)
;     rhs is ['SubDomain,D,:.] => computeTargetMode(lhs,D)
;     rhs is ['add,D,['CAPSULE,:.]] => computeTargetMode(lhs,D)
;     rhs is ['Record,:l] => ['RecordCategory,:l]
;     rhs is ['Union,:l] => ['UnionCategory,:l]
;     rhs is ['List,:l] => ['ListCategory,:l]
;     rhs is ['Vector,:l] => ['VectorCategory,:l]
;
;     rhs is [op, :argl] =>
;         modemap := GETDATABASE(op, 'CONSTRUCTORMODEMAP)
;         modemap is [[form, sig, :.], [=true,.]] =>
;             pairlis:= [[v,:a] for a in argl for v in $FormalMapVariableList]
;             -- substitute
;             SUBLIS(pairlis, sig)
;         PRETTYPRINT("strange untyped def")
;         PRETTYPRINT([lhs, rhs, modemap])
;         nil
;     BREAK()

(DEFUN |computeTargetMode| (|lhs| |rhs|)
  (PROG (|ISTMP#1| D |ISTMP#2| |ISTMP#3| |l| |op| |argl| |modemap| |form| |sig|
         |ISTMP#4| |ISTMP#5| |pairlis|)
    (RETURN
     (PROGN
      (PRETTYPRINT (LIST '|computeTargetMode| |lhs|))
      (COND
       ((AND (CONSP |rhs|) (EQ (CAR |rhs|) 'CAPSULE))
        (MOAN
         (LIST "target category of " |lhs|
               " cannot be determined from definition")
         NIL))
       ((AND (CONSP |rhs|) (EQ (CAR |rhs|) '|SubDomain|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |rhs|))
              (AND (CONSP |ISTMP#1|) (PROGN (SETQ D (CAR |ISTMP#1|)) #1='T))))
        (|computeTargetMode| |lhs| D))
       ((AND (CONSP |rhs|) (EQ (CAR |rhs|) '|add|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |rhs|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ D (CAR |ISTMP#1|))
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                         (PROGN
                          (SETQ |ISTMP#3| (CAR |ISTMP#2|))
                          (AND (CONSP |ISTMP#3|)
                               (EQ (CAR |ISTMP#3|) 'CAPSULE))))))))
        (|computeTargetMode| |lhs| D))
       ((AND (CONSP |rhs|) (EQ (CAR |rhs|) '|Record|)
             (PROGN (SETQ |l| (CDR |rhs|)) #1#))
        (CONS '|RecordCategory| |l|))
       ((AND (CONSP |rhs|) (EQ (CAR |rhs|) '|Union|)
             (PROGN (SETQ |l| (CDR |rhs|)) #1#))
        (CONS '|UnionCategory| |l|))
       ((AND (CONSP |rhs|) (EQ (CAR |rhs|) '|List|)
             (PROGN (SETQ |l| (CDR |rhs|)) #1#))
        (CONS '|ListCategory| |l|))
       ((AND (CONSP |rhs|) (EQ (CAR |rhs|) '|Vector|)
             (PROGN (SETQ |l| (CDR |rhs|)) #1#))
        (CONS '|VectorCategory| |l|))
       ((AND (CONSP |rhs|)
             (PROGN (SETQ |op| (CAR |rhs|)) (SETQ |argl| (CDR |rhs|)) #1#))
        (PROGN
         (SETQ |modemap| (GETDATABASE |op| 'CONSTRUCTORMODEMAP))
         (COND
          ((AND (CONSP |modemap|)
                (PROGN
                 (SETQ |ISTMP#1| (CAR |modemap|))
                 (AND (CONSP |ISTMP#1|)
                      (PROGN
                       (SETQ |form| (CAR |ISTMP#1|))
                       (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                       (AND (CONSP |ISTMP#2|)
                            (PROGN (SETQ |sig| (CAR |ISTMP#2|)) #1#)))))
                (PROGN
                 (SETQ |ISTMP#3| (CDR |modemap|))
                 (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                      (PROGN
                       (SETQ |ISTMP#4| (CAR |ISTMP#3|))
                       (AND (CONSP |ISTMP#4|) (EQUAL (CAR |ISTMP#4|) T)
                            (PROGN
                             (SETQ |ISTMP#5| (CDR |ISTMP#4|))
                             (AND (CONSP |ISTMP#5|)
                                  (EQ (CDR |ISTMP#5|) NIL))))))))
           (PROGN
            (SETQ |pairlis|
                    ((LAMBDA (|bfVar#31| |bfVar#29| |a| |bfVar#30| |v|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#29|)
                              (PROGN (SETQ |a| (CAR |bfVar#29|)) NIL)
                              (ATOM |bfVar#30|)
                              (PROGN (SETQ |v| (CAR |bfVar#30|)) NIL))
                          (RETURN (NREVERSE |bfVar#31|)))
                         (#1#
                          (SETQ |bfVar#31| (CONS (CONS |v| |a|) |bfVar#31|))))
                        (SETQ |bfVar#29| (CDR |bfVar#29|))
                        (SETQ |bfVar#30| (CDR |bfVar#30|))))
                     NIL |argl| NIL |$FormalMapVariableList| NIL))
            (SUBLIS |pairlis| |sig|)))
          (#1#
           (PROGN
            (PRETTYPRINT '|strange untyped def|)
            (PRETTYPRINT (LIST |lhs| |rhs| |modemap|))
            NIL)))))
       (#1# (BREAK)))))))

; DEFVAR($PrintOnly, false)

(DEFVAR |$PrintOnly| NIL)

; DEFVAR($RawParseOnly, false)

(DEFVAR |$RawParseOnly| NIL)

; DEFVAR($PostTranOnly, false)

(DEFVAR |$PostTranOnly| NIL)

; DEFVAR($FlatParseOnly, false)

(DEFVAR |$FlatParseOnly| NIL)

; DEFVAR($TranslateOnly, false)

(DEFVAR |$TranslateOnly| NIL)

; DEFVAR($noEarlyMacroexpand, false)

(DEFVAR |$noEarlyMacroexpand| NIL)

; DEFVAR($SaveParseOnly, false)

(DEFVAR |$SaveParseOnly| NIL)

; DEFVAR($globalDefs, nil)

(DEFVAR |$globalDefs| NIL)

; DEFVAR($MacroTable)

(DEFVAR |$MacroTable|)

; S_process(x) ==
;     $Index : local := 0
;     $MACROASSOC : local := nil
;     $compUniquelyIfTrue : local := false
;     $postStack : local := nil
;     $topOp : local := nil
;     $semanticErrorStack : local := nil
;     $warningStack : local := nil
;     $exitMode : local := $EmptyMode
;     $exitModeStack : local := []
;     $returnMode : local := $EmptyMode
;     $leaveLevelStack : local := []
;     $iterate_tag : local := []
;     $iterate_count : local := 0
;     $CategoryFrame : local := [[[]]]
;     $insideFunctorIfTrue : local := false
;     $insideWhereIfTrue : local := false
;     $insideCategoryIfTrue : local := false
;     $insideCapsuleFunctionIfTrue : local := false
;     $e : local := $EmptyEnvironment
;     $genSDVar : local := 0
;     $previousTime : local := get_run_time()
;     $s : local := nil
;     $x : local := nil
;     $m : local := nil
;     null(x) => nil
;     $SaveParseOnly =>
;         x := walkForm(x)
;         if x then PUSH(x, $globalDefs)
;     $RawParseOnly => PRETTYPRINT(x)
;     $FlatParseOnly => PRETTYPRINT(flattenSemi x)
;     $PostTranOnly => PRETTYPRINT(postTransform x)
;     nform :=
;         $noEarlyMacroexpand => x
;         walkForm x
;     null(nform) => nil
;     x := parseTransform(postTransform(nform))
;     $TranslateOnly => $Translation := x
;     $postStack =>
;         displayPreCompilationErrors()
;         userError "precompilation failed"
;     $PrintOnly =>
;         FORMAT(true, '"~S   =====>~%", $currentLine)
;         PRETTYPRINT(x)
;     u := compTopLevel(x, $EmptyMode, $InteractiveFrame)
;     if u then $InteractiveFrame := THIRD(u)
;     if $semanticErrorStack then displaySemanticErrors()
;     TERPRI()

(DEFUN |S_process| (|x|)
  (PROG (|$m| |$x| |$s| |$previousTime| |$genSDVar| |$e|
         |$insideCapsuleFunctionIfTrue| |$insideCategoryIfTrue|
         |$insideWhereIfTrue| |$insideFunctorIfTrue| |$CategoryFrame|
         |$iterate_count| |$iterate_tag| |$leaveLevelStack| |$returnMode|
         |$exitModeStack| |$exitMode| |$warningStack| |$semanticErrorStack|
         |$topOp| |$postStack| |$compUniquelyIfTrue| $MACROASSOC |$Index| |u|
         |nform|)
    (DECLARE
     (SPECIAL |$m| |$x| |$s| |$previousTime| |$genSDVar| |$e|
      |$insideCapsuleFunctionIfTrue| |$insideCategoryIfTrue|
      |$insideWhereIfTrue| |$insideFunctorIfTrue| |$CategoryFrame|
      |$iterate_count| |$iterate_tag| |$leaveLevelStack| |$returnMode|
      |$exitModeStack| |$exitMode| |$warningStack| |$semanticErrorStack|
      |$topOp| |$postStack| |$compUniquelyIfTrue| $MACROASSOC |$Index|))
    (RETURN
     (PROGN
      (SETQ |$Index| 0)
      (SETQ $MACROASSOC NIL)
      (SETQ |$compUniquelyIfTrue| NIL)
      (SETQ |$postStack| NIL)
      (SETQ |$topOp| NIL)
      (SETQ |$semanticErrorStack| NIL)
      (SETQ |$warningStack| NIL)
      (SETQ |$exitMode| |$EmptyMode|)
      (SETQ |$exitModeStack| NIL)
      (SETQ |$returnMode| |$EmptyMode|)
      (SETQ |$leaveLevelStack| NIL)
      (SETQ |$iterate_tag| NIL)
      (SETQ |$iterate_count| 0)
      (SETQ |$CategoryFrame| (LIST (LIST NIL)))
      (SETQ |$insideFunctorIfTrue| NIL)
      (SETQ |$insideWhereIfTrue| NIL)
      (SETQ |$insideCategoryIfTrue| NIL)
      (SETQ |$insideCapsuleFunctionIfTrue| NIL)
      (SETQ |$e| |$EmptyEnvironment|)
      (SETQ |$genSDVar| 0)
      (SETQ |$previousTime| (|get_run_time|))
      (SETQ |$s| NIL)
      (SETQ |$x| NIL)
      (SETQ |$m| NIL)
      (COND ((NULL |x|) NIL)
            (|$SaveParseOnly|
             (PROGN
              (SETQ |x| (|walkForm| |x|))
              (COND (|x| (PUSH |x| |$globalDefs|)))))
            (|$RawParseOnly| (PRETTYPRINT |x|))
            (|$FlatParseOnly| (PRETTYPRINT (|flattenSemi| |x|)))
            (|$PostTranOnly| (PRETTYPRINT (|postTransform| |x|)))
            (#1='T
             (PROGN
              (SETQ |nform|
                      (COND (|$noEarlyMacroexpand| |x|)
                            (#1# (|walkForm| |x|))))
              (COND ((NULL |nform|) NIL)
                    (#1#
                     (PROGN
                      (SETQ |x| (|parseTransform| (|postTransform| |nform|)))
                      (COND (|$TranslateOnly| (SETQ |$Translation| |x|))
                            (|$postStack|
                             (PROGN
                              (|displayPreCompilationErrors|)
                              (|userError| '|precompilation failed|)))
                            (|$PrintOnly|
                             (PROGN
                              (FORMAT T "~S   =====>~%" |$currentLine|)
                              (PRETTYPRINT |x|)))
                            (#1#
                             (PROGN
                              (SETQ |u|
                                      (|compTopLevel| |x| |$EmptyMode|
                                       |$InteractiveFrame|))
                              (COND
                               (|u| (SETQ |$InteractiveFrame| (THIRD |u|))))
                              (COND
                               (|$semanticErrorStack|
                                (|displaySemanticErrors|)))
                              (TERPRI))))))))))))))
