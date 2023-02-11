
; )package "BOOT"

(IN-PACKAGE "BOOT")

; DEFPARAMETER($ParseMode, NIL)

(DEFPARAMETER |$ParseMode| NIL)

; DEFPARAMETER($LABLASOC, NIL)

(DEFPARAMETER $LABLASOC NIL)

; DEFVAR($NONBLANK, nil)

(DEFVAR $NONBLANK NIL)

; MAKEOP(X, Y) ==
;     if OR(NOT (CDR X), NUMBERP (SECOND X)) then
;         X := CONS(first X, X)
;     MAKEPROP(first X, Y, X)

(DEFUN MAKEOP (X Y)
  (PROG ()
    (RETURN
     (PROGN
      (COND
       ((OR (NULL (CDR X)) (NUMBERP (SECOND X))) (SETQ X (CONS (CAR X) X))))
      (MAKEPROP (CAR X) Y X)))))

; init_parser_properties() ==
;     for j in _
;          [["*", 800, 801],   ["rem", 800, 801], _
;           ["quo", 800, 801], _
;           ["/", 800, 801],    ["**", 901, 900],  ["^", 901, 900], _
;           ["exquo", 800, 801], ["+", 700, 701], _
;           ["-", 700, 701],    ["->", 1002, 1001],  ["<-", 1001, 1002], _
;           [":", 996, 997],    ["::", 996, 997], _
;           ["@", 996, 997],    ["pretend", 995, 996], _
;           ["."],            ["!", 1002, 1001], _
;           [",", 110, 111], _
;           [";", 81, 82, ["parse_SemiColon"]], _
;           ["<", 400, 400],    [">", 400, 400], _
;           ["<<", 400, 400],  [">>", 400, 400], _
;           ["<=", 400, 400],   [">=", 400, 400], _
;           ["=", 400, 400],     ["^=", 400, 400], _
;           ["~=", 400, 400], _
;           ["in", 400, 400],    ["case", 400, 400], _
;           ["add", 400, 120],   ["with", 2000, 400, ["parse_InfixWith"]], _
;           ["has", 400, 400], _
;           ["where", 121, 104], _
;           ["is", 400, 400],    ["isnt", 400, 400], _
;           ["and", 250, 251],   ["or", 200, 201], _
;           ["/\", 250, 251],   ["\/", 200, 201], _
;           ["..", "SEGMENT", 401, 699, ["parse_Seg"]], _
;           ["=>", 123, 103], _
;           ["+->", 995, 112], _
;           ["==", "DEF", 122, 121], _
;           ["==>", "MDEF", 122, 121], _
;           ["|", 108, 111], _
;           [":=", "LET", 125, 124]] repeat
;         MAKEOP(j, "Led")
;
;     for j in _
;          [["for", 130, 350, ["parse_Loop"]], _
;           ["while", 130, 190, ["parse_Loop"]], _
;           ["until", 130, 190, ["parse_Loop"]], _
;           ["repeat", 130, 190, ["parse_Loop"]], _
;           ["import", 120, 0, ["parse_Import"]], _
;           ["add", 900, 120], _
;           ["with", 1000, 300, ["parse_With"]], _
;           ["has", 400, 400], _
;           ["-", 701, 700], _
;           ["#", 999, 998], _
;           ["'", 999, 999, ["parse_Data"]], _
;           ["->", 1001, 1002], _
;           [":", 194, 195], _
;           ["not", 260, 259, NIL], _
;           ["~", 260, 259, nil], _
;           ["=", 400, 700], _
;           ["return", 202, 201, ["parse_Return"]], _
;           ["from"], _
;           ["yield"], _
;           ["if", 130, 0, ["parse_Conditional"]], _
;           ["try", 130, 0, ["parse_Try"]], _
;           ["catch", 0, 114], _
;           ["finally", 0, 114], _
;           ["|", 0, 190], _
;           ["then", 0, 114], _
;           ["else", 0, 114]] repeat
;         MAKEOP(j, "Nud")

(DEFUN |init_parser_properties| ()
  (PROG ()
    (RETURN
     (PROGN
      ((LAMBDA (|bfVar#1| |j|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#1|) (PROGN (SETQ |j| (CAR |bfVar#1|)) NIL))
            (RETURN NIL))
           (#1='T (MAKEOP |j| '|Led|)))
          (SETQ |bfVar#1| (CDR |bfVar#1|))))
       (LIST (LIST '* 800 801) (LIST '|rem| 800 801) (LIST '|quo| 800 801)
             (LIST '/ 800 801) (LIST '** 901 900) (LIST '^ 901 900)
             (LIST '|exquo| 800 801) (LIST '+ 700 701) (LIST '- 700 701)
             (LIST '-> 1002 1001) (LIST '<- 1001 1002) (LIST '|:| 996 997)
             (LIST '|::| 996 997) (LIST '@ 996 997) (LIST '|pretend| 995 996)
             (LIST '|.|) (LIST '! 1002 1001) (LIST '|,| 110 111)
             (LIST '|;| 81 82 (LIST '|parse_SemiColon|)) (LIST '< 400 400)
             (LIST '> 400 400) (LIST '<< 400 400) (LIST '>> 400 400)
             (LIST '<= 400 400) (LIST '>= 400 400) (LIST '= 400 400)
             (LIST '^= 400 400) (LIST '~= 400 400) (LIST '|in| 400 400)
             (LIST '|case| 400 400) (LIST '|add| 400 120)
             (LIST '|with| 2000 400 (LIST '|parse_InfixWith|))
             (LIST '|has| 400 400) (LIST '|where| 121 104) (LIST '|is| 400 400)
             (LIST '|isnt| 400 400) (LIST '|and| 250 251) (LIST '|or| 200 201)
             (LIST '|/\\| 250 251) (LIST '|\\/| 200 201)
             (LIST '|..| 'SEGMENT 401 699 (LIST '|parse_Seg|))
             (LIST '=> 123 103) (LIST '+-> 995 112) (LIST '== 'DEF 122 121)
             (LIST '==> 'MDEF 122 121) (LIST '|\|| 108 111)
             (LIST '|:=| 'LET 125 124))
       NIL)
      ((LAMBDA (|bfVar#2| |j|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#2|) (PROGN (SETQ |j| (CAR |bfVar#2|)) NIL))
            (RETURN NIL))
           (#1# (MAKEOP |j| '|Nud|)))
          (SETQ |bfVar#2| (CDR |bfVar#2|))))
       (LIST (LIST '|for| 130 350 (LIST '|parse_Loop|))
             (LIST '|while| 130 190 (LIST '|parse_Loop|))
             (LIST '|until| 130 190 (LIST '|parse_Loop|))
             (LIST '|repeat| 130 190 (LIST '|parse_Loop|))
             (LIST '|import| 120 0 (LIST '|parse_Import|))
             (LIST '|add| 900 120) (LIST '|with| 1000 300 (LIST '|parse_With|))
             (LIST '|has| 400 400) (LIST '- 701 700) (LIST '|#| 999 998)
             (LIST '|'| 999 999 (LIST '|parse_Data|)) (LIST '-> 1001 1002)
             (LIST '|:| 194 195) (LIST '|not| 260 259 NIL)
             (LIST '~ 260 259 NIL) (LIST '= 400 700)
             (LIST '|return| 202 201 (LIST '|parse_Return|)) (LIST '|from|)
             (LIST '|yield|) (LIST '|if| 130 0 (LIST '|parse_Conditional|))
             (LIST '|try| 130 0 (LIST '|parse_Try|)) (LIST '|catch| 0 114)
             (LIST '|finally| 0 114) (LIST '|\|| 0 190) (LIST '|then| 0 114)
             (LIST '|else| 0 114))
       NIL)))))

; init_parser_properties()

(EVAL-WHEN (EVAL LOAD) (PROG () (RETURN (|init_parser_properties|))))

; MUST(x) ==
;     x => true
;     spad_syntax_error(nil, nil)

(DEFUN MUST (|x|)
  (PROG () (RETURN (COND (|x| T) ('T (|spad_syntax_error| NIL NIL))))))

; OPTIONAL(x) == true

(DEFUN OPTIONAL (|x|) (PROG () (RETURN T)))

; ACTION(x) == true

(DEFUN ACTION (|x|) (PROG () (RETURN T)))

; symbol_is?(x) == EQ(current_symbol(), x)

(DEFUN |symbol_is?| (|x|) (PROG () (RETURN (EQ (|current_symbol|) |x|))))

; match_symbol(x) ==
;     match_current_token("KEYWORD", x) => (advance_token(); true)
;     false

(DEFUN |match_symbol| (|x|)
  (PROG ()
    (RETURN
     (COND ((|match_current_token| 'KEYWORD |x|) (PROGN (|advance_token|) T))
           ('T NIL)))))

; expect_symbol(x) ==
;     match_symbol(x) => true
;     spad_syntax_error(x, nil)

(DEFUN |expect_symbol| (|x|)
  (PROG ()
    (RETURN
     (COND ((|match_symbol| |x|) T) ('T (|spad_syntax_error| |x| NIL))))))

; DEFPARAMETER($reduction_stack, nil)

(DEFPARAMETER |$reduction_stack| NIL)

; push_reduction(x, y) ==
;     PUSH(y, $reduction_stack)
;     true

(DEFUN |push_reduction| (|x| |y|)
  (PROG () (RETURN (PROGN (PUSH |y| |$reduction_stack|) T))))

; pop_stack_1() == POP($reduction_stack)

(DEFUN |pop_stack_1| () (PROG () (RETURN (POP |$reduction_stack|))))

; pop_stack_2() ==
;     el1 := POP($reduction_stack)
;     el2 := POP($reduction_stack)
;     PUSH(el1, $reduction_stack)
;     el2

(DEFUN |pop_stack_2| ()
  (PROG (|el2| |el1|)
    (RETURN
     (PROGN
      (SETQ |el1| (POP |$reduction_stack|))
      (SETQ |el2| (POP |$reduction_stack|))
      (PUSH |el1| |$reduction_stack|)
      |el2|))))

; pop_stack_3() ==
;     el1 := POP($reduction_stack)
;     el2 := POP($reduction_stack)
;     el3 := POP($reduction_stack)
;     PUSH(el2, $reduction_stack)
;     PUSH(el1, $reduction_stack)
;     el3

(DEFUN |pop_stack_3| ()
  (PROG (|el3| |el2| |el1|)
    (RETURN
     (PROGN
      (SETQ |el1| (POP |$reduction_stack|))
      (SETQ |el2| (POP |$reduction_stack|))
      (SETQ |el3| (POP |$reduction_stack|))
      (PUSH |el2| |$reduction_stack|)
      (PUSH |el1| |$reduction_stack|)
      |el3|))))

; top_of_stack() == first($reduction_stack)

(DEFUN |top_of_stack| () (PROG () (RETURN (CAR |$reduction_stack|))))

; parse_token(token) ==
;     tok := match_current_token(token, nil)
;     not(tok) => nil
;     symbol := TOKEN_-SYMBOL(tok)
;     push_reduction(token, COPY_-TREE(symbol))
;     advance_token()
;     true

(DEFUN |parse_token| (|token|)
  (PROG (|tok| |symbol|)
    (RETURN
     (PROGN
      (SETQ |tok| (|match_current_token| |token| NIL))
      (COND ((NULL |tok|) NIL)
            ('T
             (PROGN
              (SETQ |symbol| (TOKEN-SYMBOL |tok|))
              (|push_reduction| |token| (COPY-TREE |symbol|))
              (|advance_token|)
              T)))))))

; parse_SPADSTRING() == parse_token("SPADSTRING")

(DEFUN |parse_SPADSTRING| () (PROG () (RETURN (|parse_token| 'SPADSTRING))))

; parse_KEYWORD() == parse_token("KEYWORD")

(DEFUN |parse_KEYWORD| () (PROG () (RETURN (|parse_token| 'KEYWORD))))

; parse_ARGUMENT_DESIGNATOR() == parse_token("ARGUMENT-DESIGNATOR")

(DEFUN |parse_ARGUMENT_DESIGNATOR| ()
  (PROG () (RETURN (|parse_token| 'ARGUMENT-DESIGNATOR))))

; parse_SPADFLOAT() == parse_token("SPADFLOAT")

(DEFUN |parse_SPADFLOAT| () (PROG () (RETURN (|parse_token| 'SPADFLOAT))))

; parse_IDENTIFIER() == parse_token("IDENTIFIER")

(DEFUN |parse_IDENTIFIER| () (PROG () (RETURN (|parse_token| 'IDENTIFIER))))

; parse_NUMBER() == parse_token("NUMBER")

(DEFUN |parse_NUMBER| () (PROG () (RETURN (|parse_token| 'NUMBER))))

; push_lform0(tag) ==
;     push_reduction("dummy", tag)

(DEFUN |push_lform0| (|tag|)
  (PROG () (RETURN (|push_reduction| '|dummy| |tag|))))

; push_form0(tag) ==
;     push_reduction("dummy", [tag])

(DEFUN |push_form0| (|tag|)
  (PROG () (RETURN (|push_reduction| '|dummy| (LIST |tag|)))))

; push_lform1(tag, arg1) ==
;     push_reduction("dummy", [tag, :arg1])

(DEFUN |push_lform1| (|tag| |arg1|)
  (PROG () (RETURN (|push_reduction| '|dummy| (CONS |tag| |arg1|)))))

; push_form1(tag, arg1) ==
;     push_reduction("dummy", [tag, arg1])

(DEFUN |push_form1| (|tag| |arg1|)
  (PROG () (RETURN (|push_reduction| '|dummy| (LIST |tag| |arg1|)))))

; push_lform2(tag, arg1, arg2) ==
;     push_reduction("dummy", [tag, arg1, :arg2])

(DEFUN |push_lform2| (|tag| |arg1| |arg2|)
  (PROG ()
    (RETURN (|push_reduction| '|dummy| (CONS |tag| (CONS |arg1| |arg2|))))))

; push_form2(tag, arg1, arg2) ==
;     push_reduction("dummy", [tag, arg1, arg2])

(DEFUN |push_form2| (|tag| |arg1| |arg2|)
  (PROG () (RETURN (|push_reduction| '|dummy| (LIST |tag| |arg1| |arg2|)))))

; push_form3(tag, arg1, arg2, arg3) ==
;     push_reduction("dummy", [tag, arg1, arg2, arg3])

(DEFUN |push_form3| (|tag| |arg1| |arg2| |arg3|)
  (PROG ()
    (RETURN (|push_reduction| '|dummy| (LIST |tag| |arg1| |arg2| |arg3|)))))

; dollarTran(dom, expr) ==
;     expr is [fun, :args] =>
;         [["Sel", dom, fun], :args]
;     ["Sel", dom, expr]

(DEFUN |dollarTran| (|dom| |expr|)
  (PROG (|fun| |args|)
    (RETURN
     (COND
      ((AND (CONSP |expr|)
            (PROGN (SETQ |fun| (CAR |expr|)) (SETQ |args| (CDR |expr|)) #1='T))
       (CONS (LIST '|Sel| |dom| |fun|) |args|))
      (#1# (LIST '|Sel| |dom| |expr|))))))

; parse_new_expr() ==
;     $reduction_stack := nil
;     parse_Expr 0

(DEFUN |parse_new_expr| ()
  (PROG () (RETURN (PROGN (SETQ |$reduction_stack| NIL) (|parse_Expr| 0)))))

; parse_InfixWith() ==
;     not(parse_With()) => nil
;     push_form2("Join", pop_stack_2(), pop_stack_1())

(DEFUN |parse_InfixWith| ()
  (PROG ()
    (RETURN
     (COND ((NULL (|parse_With|)) NIL)
           ('T (|push_form2| '|Join| (|pop_stack_2|) (|pop_stack_1|)))))))

; parse_With() ==
;     not(match_symbol "with") => nil
;     MUST parse_Category()
;     push_form1("with", pop_stack_1())

(DEFUN |parse_With| ()
  (PROG ()
    (RETURN
     (COND ((NULL (|match_symbol| '|with|)) NIL)
           ('T
            (PROGN
             (MUST (|parse_Category|))
             (|push_form1| '|with| (|pop_stack_1|))))))))

; repetition(delimiter, fn) ==
;     val := nil
;     repeat
;         if delimiter then
;             if not(match_symbol(delimiter)) then return nil -- break loop
;             MUST(FUNCALL fn)
;         else
;             if not(FUNCALL fn) then return nil -- break loop
;         val := [pop_stack_1(), :val]
;     val => push_lform0(nreverse(val))
;     nil

(DEFUN |repetition| (|delimiter| |fn|)
  (PROG (|val|)
    (RETURN
     (PROGN
      (SETQ |val| NIL)
      ((LAMBDA ()
         (LOOP
          (COND (NIL (RETURN NIL))
                (#1='T
                 (PROGN
                  (COND
                   (|delimiter|
                    (COND ((NULL (|match_symbol| |delimiter|)) (RETURN NIL)))
                    (MUST (FUNCALL |fn|)))
                   ((NULL (FUNCALL |fn|)) (RETURN NIL)))
                  (SETQ |val| (CONS (|pop_stack_1|) |val|))))))))
      (COND (|val| (|push_lform0| (NREVERSE |val|))) (#1# NIL))))))

; getSignatureDocumentation2(n1, n2) ==
;     val1 := getSignatureDocumentation(n1) => val1
;     not(n2) =>
;         $COMBLOCKLIST is [[n, :val], :rr] and n1 <= n =>
;             $COMBLOCKLIST := rr
;             val
;         nil
;     nr := n2 + 1
;     for pp in $COMBLOCKLIST repeat
;         if pp is [n, :val] and n1 <= n and n <= n2 then
;             nr := n
;     nr <= n2 => getSignatureDocumentation(nr)
;     nil

(DEFUN |getSignatureDocumentation2| (|n1| |n2|)
  (PROG (|val1| |ISTMP#1| |n| |val| |rr| |nr|)
    (RETURN
     (COND ((SETQ |val1| (|getSignatureDocumentation| |n1|)) |val1|)
           ((NULL |n2|)
            (COND
             ((AND (CONSP $COMBLOCKLIST)
                   (PROGN
                    (SETQ |ISTMP#1| (CAR $COMBLOCKLIST))
                    (AND (CONSP |ISTMP#1|)
                         (PROGN
                          (SETQ |n| (CAR |ISTMP#1|))
                          (SETQ |val| (CDR |ISTMP#1|))
                          #1='T)))
                   (PROGN (SETQ |rr| (CDR $COMBLOCKLIST)) #1#)
                   (NOT (< |n| |n1|)))
              (PROGN (SETQ $COMBLOCKLIST |rr|) |val|))
             (#1# NIL)))
           (#1#
            (PROGN
             (SETQ |nr| (+ |n2| 1))
             ((LAMBDA (|bfVar#3| |pp|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#3|)
                       (PROGN (SETQ |pp| (CAR |bfVar#3|)) NIL))
                   (RETURN NIL))
                  (#1#
                   (COND
                    ((AND (CONSP |pp|)
                          (PROGN
                           (SETQ |n| (CAR |pp|))
                           (SETQ |val| (CDR |pp|))
                           #1#)
                          (NOT (< |n| |n1|)) (NOT (< |n2| |n|)))
                     (SETQ |nr| |n|)))))
                 (SETQ |bfVar#3| (CDR |bfVar#3|))))
              $COMBLOCKLIST NIL)
             (COND ((NOT (< |n2| |nr|)) (|getSignatureDocumentation| |nr|))
                   (#1# NIL))))))))

; parse_category_list(closer) ==
;     MUST
;         match_symbol(closer) => push_form0("CATEGORY")
;         MUST(parse_Category())
;         tail_val :=
;             repetition(";", FUNCTION parse_Category) => pop_stack_1()
;             nil
;         expect_symbol(closer)
;         val1 := pop_stack_1()
;         IFCAR(val1) = "if" and tail_val = nil => push_lform0(val1)
;         push_lform2("CATEGORY", val1, tail_val)

(DEFUN |parse_category_list| (|closer|)
  (PROG (|tail_val| |val1|)
    (RETURN
     (MUST
      (COND ((|match_symbol| |closer|) (|push_form0| 'CATEGORY))
            (#1='T
             (PROGN
              (MUST (|parse_Category|))
              (SETQ |tail_val|
                      (COND
                       ((|repetition| '|;| #'|parse_Category|) (|pop_stack_1|))
                       (#1# NIL)))
              (|expect_symbol| |closer|)
              (SETQ |val1| (|pop_stack_1|))
              (COND
               ((AND (EQ (IFCAR |val1|) '|if|) (NULL |tail_val|))
                (|push_lform0| |val1|))
               (#1# (|push_lform2| 'CATEGORY |val1| |tail_val|))))))))))

; parse_Category() ==
;     match_symbol("if") =>
;         MUST parse_Expression()
;         cond := pop_stack_1()
;         expect_symbol "then"
;         MUST parse_Category()
;         else_val :=
;             match_symbol "else" =>
;                 MUST parse_Category()
;                 pop_stack_1()
;             nil
;         push_form3("if", cond, pop_stack_1(), else_val)
;     match_symbol("(") => parse_category_list(")")
;     match_symbol("{") => parse_category_list("}")
;     match_symbol("SETTAB") => parse_category_list("BACKTAB")
;     G1 := current_line_number()
;     not(parse_Application()) => nil
;     MUST
;         OR(
;               AND(match_symbol ":", MUST parse_Expression(),
;                   push_form3("Signature", pop_stack_2(), pop_stack_1(),
;                       getSignatureDocumentation2(G1, current_line_number()))),
;               AND(push_form1("ATTRIBUTE", pop_stack_1()),
;                   ACTION recordAttributeDocumentation(top_of_stack(), G1)))

(DEFUN |parse_Category| ()
  (PROG (G1 |else_val| |cond|)
    (RETURN
     (COND
      ((|match_symbol| '|if|)
       (PROGN
        (MUST (|parse_Expression|))
        (SETQ |cond| (|pop_stack_1|))
        (|expect_symbol| '|then|)
        (MUST (|parse_Category|))
        (SETQ |else_val|
                (COND
                 ((|match_symbol| '|else|)
                  (PROGN (MUST (|parse_Category|)) (|pop_stack_1|)))
                 (#1='T NIL)))
        (|push_form3| '|if| |cond| (|pop_stack_1|) |else_val|)))
      ((|match_symbol| '|(|) (|parse_category_list| '|)|))
      ((|match_symbol| '{) (|parse_category_list| '}))
      ((|match_symbol| 'SETTAB) (|parse_category_list| 'BACKTAB))
      (#1#
       (PROGN
        (SETQ G1 (|current_line_number|))
        (COND ((NULL (|parse_Application|)) NIL)
              (#1#
               (MUST
                (OR
                 (AND (|match_symbol| '|:|) (MUST (|parse_Expression|))
                      (|push_form3| '|Signature| (|pop_stack_2|)
                       (|pop_stack_1|)
                       (|getSignatureDocumentation2| G1
                        (|current_line_number|))))
                 (AND (|push_form1| 'ATTRIBUTE (|pop_stack_1|))
                      (ACTION
                       (|recordAttributeDocumentation| (|top_of_stack|)
                        G1)))))))))))))

; parse_Expression() ==
;     prior_sym := MAKE_-SYMBOL_-OF PRIOR_-TOKEN
;     prior_sym :=
;         SYMBOLP(prior_sym) => prior_sym
;         nil
;     parse_Expr
;      parse_rightBindingPowerOf(prior_sym, $ParseMode)

(DEFUN |parse_Expression| ()
  (PROG (|prior_sym|)
    (RETURN
     (PROGN
      (SETQ |prior_sym| (MAKE-SYMBOL-OF PRIOR-TOKEN))
      (SETQ |prior_sym| (COND ((SYMBOLP |prior_sym|) |prior_sym|) ('T NIL)))
      (|parse_Expr| (|parse_rightBindingPowerOf| |prior_sym| |$ParseMode|))))))

; parse_Expr1000() == parse_Expr 1000

(DEFUN |parse_Expr1000| () (PROG () (RETURN (|parse_Expr| 1000))))

; parse_Import() ==
;     not(match_symbol "import") => nil
;     match_symbol "from" or true
;     MUST parse_Expr 1000
;     tail_val :=
;         repetition(",", FUNCTION parse_Expr1000) => pop_stack_1()
;         nil
;     push_lform2("import", pop_stack_1(), tail_val)

(DEFUN |parse_Import| ()
  (PROG (|tail_val|)
    (RETURN
     (COND ((NULL (|match_symbol| '|import|)) NIL)
           (#1='T
            (PROGN
             (OR (|match_symbol| '|from|) T)
             (MUST (|parse_Expr| 1000))
             (SETQ |tail_val|
                     (COND
                      ((|repetition| '|,| #'|parse_Expr1000|) (|pop_stack_1|))
                      (#1# NIL)))
             (|push_lform2| '|import| (|pop_stack_1|) |tail_val|)))))))

; parse_Infix() ==
;     push_reduction("parse_Infix", current_symbol())
;     advance_token()
;     parse_TokTail()
;     MUST parse_Expression()
;     push_reduction("parse_Infix",
;                    [pop_stack_2(), pop_stack_2(), pop_stack_1()])

(DEFUN |parse_Infix| ()
  (PROG ()
    (RETURN
     (PROGN
      (|push_reduction| '|parse_Infix| (|current_symbol|))
      (|advance_token|)
      (|parse_TokTail|)
      (MUST (|parse_Expression|))
      (|push_reduction| '|parse_Infix|
       (LIST (|pop_stack_2|) (|pop_stack_2|) (|pop_stack_1|)))))))

; parse_Prefix() ==
;     push_reduction("parse_Prefix", current_symbol())
;     advance_token()
;     parse_TokTail()
;     MUST parse_Expression()
;     push_reduction("parse_Prefix", [pop_stack_2(), pop_stack_1()])

(DEFUN |parse_Prefix| ()
  (PROG ()
    (RETURN
     (PROGN
      (|push_reduction| '|parse_Prefix| (|current_symbol|))
      (|advance_token|)
      (|parse_TokTail|)
      (MUST (|parse_Expression|))
      (|push_reduction| '|parse_Prefix|
       (LIST (|pop_stack_2|) (|pop_stack_1|)))))))

; parse_Suffix() ==
;     push_reduction("parse_Suffix", current_symbol())
;     advance_token()
;     parse_TokTail()
;     push_reduction("parse_Suffix", [pop_stack_1(), pop_stack_1()])

(DEFUN |parse_Suffix| ()
  (PROG ()
    (RETURN
     (PROGN
      (|push_reduction| '|parse_Suffix| (|current_symbol|))
      (|advance_token|)
      (|parse_TokTail|)
      (|push_reduction| '|parse_Suffix|
       (LIST (|pop_stack_1|) (|pop_stack_1|)))))))

; parse_TokTail() ==
;     current_symbol() ~= "$" => nil
;     not(OR(match_next_token("IDENTIFIER", NIL), next_symbol() = "%",
;            next_symbol() = "(")) => nil                     -- )
;     G1 := COPY_-TOKEN PRIOR_-TOKEN
;     not(parse_Qualification()) => nil
;     SETF(PRIOR_-TOKEN, G1)

(DEFUN |parse_TokTail| ()
  (PROG (G1)
    (RETURN
     (COND ((NOT (EQ (|current_symbol|) '$)) NIL)
           ((NULL
             (OR (|match_next_token| 'IDENTIFIER NIL) (EQ (|next_symbol|) '%)
                 (EQ (|next_symbol|) '|(|)))
            NIL)
           (#1='T
            (PROGN
             (SETQ G1 (COPY-TOKEN PRIOR-TOKEN))
             (COND ((NULL (|parse_Qualification|)) NIL)
                   (#1# (SETF PRIOR-TOKEN G1)))))))))

; parse_Qualification() ==
;     not(match_symbol "$") => nil
;     MUST parse_Primary1()
;     push_reduction("parse_Qualification",
;                    dollarTran(pop_stack_1(), pop_stack_1()))

(DEFUN |parse_Qualification| ()
  (PROG ()
    (RETURN
     (COND ((NULL (|match_symbol| '$)) NIL)
           ('T
            (PROGN
             (MUST (|parse_Primary1|))
             (|push_reduction| '|parse_Qualification|
              (|dollarTran| (|pop_stack_1|) (|pop_stack_1|)))))))))

; parse_SemiColon() ==
;     not(match_symbol ";") => nil
;     parse_Expr 82 =>
;         push_form2(";", pop_stack_2(), pop_stack_1())
;     true

(DEFUN |parse_SemiColon| ()
  (PROG ()
    (RETURN
     (COND ((NULL (|match_symbol| '|;|)) NIL)
           ((|parse_Expr| 82)
            (|push_form2| '|;| (|pop_stack_2|) (|pop_stack_1|)))
           ('T T)))))

; parse_Return() ==
;     not(match_symbol "return") => nil
;     MUST parse_Expression()
;     push_form1("return", pop_stack_1())

(DEFUN |parse_Return| ()
  (PROG ()
    (RETURN
     (COND ((NULL (|match_symbol| '|return|)) NIL)
           ('T
            (PROGN
             (MUST (|parse_Expression|))
             (|push_form1| '|return| (|pop_stack_1|))))))))

; parse_Seg() ==
;     not(parse_GliphTok "..") => nil
;     right_val :=
;         parse_Expression() => pop_stack_1()
;         nil
;     push_form2("SEGMENT", pop_stack_1(), right_val)

(DEFUN |parse_Seg| ()
  (PROG (|right_val|)
    (RETURN
     (COND ((NULL (|parse_GliphTok| '|..|)) NIL)
           (#1='T
            (PROGN
             (SETQ |right_val|
                     (COND ((|parse_Expression|) (|pop_stack_1|)) (#1# NIL)))
             (|push_form2| 'SEGMENT (|pop_stack_1|) |right_val|)))))))

; parse_Conditional() ==
;     not(match_symbol "if") => nil
;     MUST parse_Expression()
;     expect_symbol "then"
;     MUST parse_Expression()
;     else_val :=
;         match_symbol "else" =>
;             MUST parse_ElseClause()
;             pop_stack_1()
;         nil
;     push_form3("if", pop_stack_2(), pop_stack_1(), else_val)

(DEFUN |parse_Conditional| ()
  (PROG (|else_val|)
    (RETURN
     (COND ((NULL (|match_symbol| '|if|)) NIL)
           (#1='T
            (PROGN
             (MUST (|parse_Expression|))
             (|expect_symbol| '|then|)
             (MUST (|parse_Expression|))
             (SETQ |else_val|
                     (COND
                      ((|match_symbol| '|else|)
                       (PROGN (MUST (|parse_ElseClause|)) (|pop_stack_1|)))
                      (#1# NIL)))
             (|push_form3| '|if| (|pop_stack_2|) (|pop_stack_1|)
              |else_val|)))))))

; parse_ElseClause() ==
;     current_symbol() = "if" => parse_Conditional()
;     parse_Expression()

(DEFUN |parse_ElseClause| ()
  (PROG ()
    (RETURN
     (COND ((EQ (|current_symbol|) '|if|) (|parse_Conditional|))
           ('T (|parse_Expression|))))))

; parse_Try() ==
;     not(match_symbol "try") => nil
;     MUST parse_Expression()
;     expr := pop_stack_1()
;     expr :=
;         expr is [";", expr1, "/throwAway"] => expr1
;         expr
;     catcher := nil
;     if match_symbol "catch" then
;         MUST parse_Expression()
;         catcher := pop_stack_1()
;         MUST(catcher is ["in", var, expr])
;     finalizer := nil
;     if match_symbol "finally" then
;         MUST parse_Expression()
;         finalizer := pop_stack_1()
;     MUST(catcher or finalizer)
;     push_form3("try", expr, catcher, finalizer)

(DEFUN |parse_Try| ()
  (PROG (|finalizer| |var| |catcher| |ISTMP#2| |expr1| |ISTMP#1| |expr|)
    (RETURN
     (COND ((NULL (|match_symbol| '|try|)) NIL)
           (#1='T
            (PROGN
             (MUST (|parse_Expression|))
             (SETQ |expr| (|pop_stack_1|))
             (SETQ |expr|
                     (COND
                      ((AND (CONSP |expr|) (EQ (CAR |expr|) '|;|)
                            (PROGN
                             (SETQ |ISTMP#1| (CDR |expr|))
                             (AND (CONSP |ISTMP#1|)
                                  (PROGN
                                   (SETQ |expr1| (CAR |ISTMP#1|))
                                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                   (AND (CONSP |ISTMP#2|)
                                        (EQ (CDR |ISTMP#2|) NIL)
                                        (EQ (CAR |ISTMP#2|) '|/throwAway|))))))
                       |expr1|)
                      (#1# |expr|)))
             (SETQ |catcher| NIL)
             (COND
              ((|match_symbol| '|catch|) (MUST (|parse_Expression|))
               (SETQ |catcher| (|pop_stack_1|))
               (MUST
                (AND (CONSP |catcher|) (EQ (CAR |catcher|) '|in|)
                     (PROGN
                      (SETQ |ISTMP#1| (CDR |catcher|))
                      (AND (CONSP |ISTMP#1|)
                           (PROGN
                            (SETQ |var| (CAR |ISTMP#1|))
                            (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                            (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                 (PROGN
                                  (SETQ |expr| (CAR |ISTMP#2|))
                                  #1#)))))))))
             (SETQ |finalizer| NIL)
             (COND
              ((|match_symbol| '|finally|) (MUST (|parse_Expression|))
               (SETQ |finalizer| (|pop_stack_1|))))
             (MUST (OR |catcher| |finalizer|))
             (|push_form3| '|try| |expr| |catcher| |finalizer|)))))))

; parse_Loop() ==
;     OR(AND(repetition(nil, FUNCTION parse_Iterator),
;            expect_symbol "repeat", MUST parse_Expr 110,
;            push_lform1("REPEAT", [:pop_stack_2(), pop_stack_1()])),
;        AND(expect_symbol "repeat", MUST parse_Expr 110,
;            push_form1("REPEAT", pop_stack_1())))

(DEFUN |parse_Loop| ()
  (PROG ()
    (RETURN
     (OR
      (AND (|repetition| NIL #'|parse_Iterator|) (|expect_symbol| '|repeat|)
           (MUST (|parse_Expr| 110))
           (|push_lform1| 'REPEAT
            (APPEND (|pop_stack_2|) (CONS (|pop_stack_1|) NIL))))
      (AND (|expect_symbol| '|repeat|) (MUST (|parse_Expr| 110))
           (|push_form1| 'REPEAT (|pop_stack_1|)))))))

; parse_Iterator() ==
;     match_symbol "for" =>
;         MUST parse_Primary()
;         expect_symbol "in"
;         MUST parse_Expression()
;         by_val :=
;               AND(match_symbol "by", MUST parse_Expr 200) => pop_stack_1()
;               nil
;         bar_val :=
;             AND(match_symbol "|", MUST parse_Expr 111) => pop_stack_1()
;             nil
;         in_val := pop_stack_1()
;         if bar_val then
;             in_val := ["|", in_val, bar_val]
;         if by_val then
;             push_form3("INBY", pop_stack_1(), in_val, by_val)
;         else
;             push_form2("IN", pop_stack_1(), in_val)
;     match_symbol "while" =>
;         MUST parse_Expr 190
;         push_form1("WHILE", pop_stack_1())
;     match_symbol "until" =>
;         MUST parse_Expr 190
;         push_form1("UNTIL", pop_stack_1())
;     nil

(DEFUN |parse_Iterator| ()
  (PROG (|in_val| |bar_val| |by_val|)
    (RETURN
     (COND
      ((|match_symbol| '|for|)
       (PROGN
        (MUST (|parse_Primary|))
        (|expect_symbol| '|in|)
        (MUST (|parse_Expression|))
        (SETQ |by_val|
                (COND
                 ((AND (|match_symbol| '|by|) (MUST (|parse_Expr| 200)))
                  (|pop_stack_1|))
                 (#1='T NIL)))
        (SETQ |bar_val|
                (COND
                 ((AND (|match_symbol| '|\||) (MUST (|parse_Expr| 111)))
                  (|pop_stack_1|))
                 (#1# NIL)))
        (SETQ |in_val| (|pop_stack_1|))
        (COND (|bar_val| (SETQ |in_val| (LIST '|\|| |in_val| |bar_val|))))
        (COND (|by_val| (|push_form3| 'INBY (|pop_stack_1|) |in_val| |by_val|))
              (#1# (|push_form2| 'IN (|pop_stack_1|) |in_val|)))))
      ((|match_symbol| '|while|)
       (PROGN (MUST (|parse_Expr| 190)) (|push_form1| 'WHILE (|pop_stack_1|))))
      ((|match_symbol| '|until|)
       (PROGN (MUST (|parse_Expr| 190)) (|push_form1| 'UNTIL (|pop_stack_1|))))
      (#1# NIL)))))

; parse_Expr($RBP) ==
;     not(parse_NudPart($RBP)) => nil
;     while parse_LedPart($RBP) repeat nil
;     push_reduction("parse_Expr", pop_stack_1())

(DEFUN |parse_Expr| ($RBP)
  (DECLARE (SPECIAL $RBP))
  (PROG ()
    (RETURN
     (COND ((NULL (|parse_NudPart| $RBP)) NIL)
           (#1='T
            (PROGN
             ((LAMBDA ()
                (LOOP
                 (COND ((NOT (|parse_LedPart| $RBP)) (RETURN NIL))
                       (#1# NIL)))))
             (|push_reduction| '|parse_Expr| (|pop_stack_1|))))))))

; parse_LabelExpr() ==
;     not(parse_Label()) => nil
;     MUST parse_Expr(120)
;     push_form2("LABEL", pop_stack_2(), pop_stack_1())

(DEFUN |parse_LabelExpr| ()
  (PROG ()
    (RETURN
     (COND ((NULL (|parse_Label|)) NIL)
           ('T
            (PROGN
             (MUST (|parse_Expr| 120))
             (|push_form2| 'LABEL (|pop_stack_2|) (|pop_stack_1|))))))))

; parse_Label() ==
;     not(match_symbol "<<") => nil
;     MUST parse_Name()
;     MUST match_symbol ">>"

(DEFUN |parse_Label| ()
  (PROG ()
    (RETURN
     (COND ((NULL (|match_symbol| '<<)) NIL)
           ('T (PROGN (MUST (|parse_Name|)) (MUST (|match_symbol| '>>))))))))

; parse_LedPart($RBP) ==
;     not(parse_Operation("Led", $RBP)) => nil
;     push_reduction("parse_LedPart", pop_stack_1())

(DEFUN |parse_LedPart| ($RBP)
  (DECLARE (SPECIAL $RBP))
  (PROG ()
    (RETURN
     (COND ((NULL (|parse_Operation| '|Led| $RBP)) NIL)
           ('T (|push_reduction| '|parse_LedPart| (|pop_stack_1|)))))))

; parse_NudPart($RBP) ==
;     AND(OR(parse_Operation("Nud", $RBP), parse_Reduction(), parse_Form()),
;         push_reduction("parse_NudPart", pop_stack_1()))

(DEFUN |parse_NudPart| ($RBP)
  (DECLARE (SPECIAL $RBP))
  (PROG ()
    (RETURN
     (AND
      (OR (|parse_Operation| '|Nud| $RBP) (|parse_Reduction|) (|parse_Form|))
      (|push_reduction| '|parse_NudPart| (|pop_stack_1|))))))

; parse_Operation($ParseMode, $RBP) ==
;     match_current_token("IDENTIFIER", NIL) => nil
;     tmptok := current_symbol()
;     SYMBOLP(tmptok) and GET(tmptok, $ParseMode) and
;       $RBP < parse_leftBindingPowerOf(tmptok, $ParseMode) =>
;         $RBP := parse_rightBindingPowerOf(tmptok, $ParseMode)
;         parse_getSemanticForm($ParseMode,
;                                ELEMN(GET(tmptok, $ParseMode), 5, NIL))

(DEFUN |parse_Operation| (|$ParseMode| $RBP)
  (DECLARE (SPECIAL |$ParseMode| $RBP))
  (PROG (|tmptok|)
    (RETURN
     (COND ((|match_current_token| 'IDENTIFIER NIL) NIL)
           ('T
            (PROGN
             (SETQ |tmptok| (|current_symbol|))
             (COND
              ((AND (SYMBOLP |tmptok|) (GET |tmptok| |$ParseMode|)
                    (< $RBP
                       (|parse_leftBindingPowerOf| |tmptok| |$ParseMode|)))
               (PROGN
                (SETQ $RBP (|parse_rightBindingPowerOf| |tmptok| |$ParseMode|))
                (|parse_getSemanticForm| |$ParseMode|
                 (ELEMN (GET |tmptok| |$ParseMode|) 5 NIL)))))))))))

; parse_leftBindingPowerOf(x, ind) ==
;     (y := GET(x, ind)) => ELEMN(y, 3, 0)
;     0

(DEFUN |parse_leftBindingPowerOf| (|x| |ind|)
  (PROG (|y|)
    (RETURN (COND ((SETQ |y| (GET |x| |ind|)) (ELEMN |y| 3 0)) ('T 0)))))

; parse_rightBindingPowerOf(x, ind) ==
;     (y := GET(x, ind)) => ELEMN(y, 4, 105)
;     105

(DEFUN |parse_rightBindingPowerOf| (|x| |ind|)
  (PROG (|y|)
    (RETURN (COND ((SETQ |y| (GET |x| |ind|)) (ELEMN |y| 4 105)) ('T 105)))))

; parse_getSemanticForm(ind, y) ==
;     AND(y, FUNCALL(first y)) => true
;     ind = "Nud" => parse_Prefix()
;     ind = "Led" => parse_Infix()
;     nil

(DEFUN |parse_getSemanticForm| (|ind| |y|)
  (PROG ()
    (RETURN
     (COND ((AND |y| (FUNCALL (CAR |y|))) T)
           ((EQ |ind| '|Nud|) (|parse_Prefix|))
           ((EQ |ind| '|Led|) (|parse_Infix|)) ('T NIL)))))

; parse_Reduction() ==
;     parse_ReductionOp() =>
;         MUST parse_Expr 1000
;         push_form2("Reduce", pop_stack_2(), pop_stack_1())
;     nil

(DEFUN |parse_Reduction| ()
  (PROG ()
    (RETURN
     (COND
      ((|parse_ReductionOp|)
       (PROGN
        (MUST (|parse_Expr| 1000))
        (|push_form2| '|Reduce| (|pop_stack_2|) (|pop_stack_1|))))
      ('T NIL)))))

; parse_ReductionOp() ==
;     cur_sym := current_symbol()
;     AND(SYMBOLP(cur_sym), GET(cur_sym, "Led"),
;         match_next_token("KEYWORD", "/"),
;         push_reduction("parse_ReductionOp", cur_sym),
;         ACTION advance_token(), ACTION advance_token())

(DEFUN |parse_ReductionOp| ()
  (PROG (|cur_sym|)
    (RETURN
     (PROGN
      (SETQ |cur_sym| (|current_symbol|))
      (AND (SYMBOLP |cur_sym|) (GET |cur_sym| '|Led|)
           (|match_next_token| 'KEYWORD '/)
           (|push_reduction| '|parse_ReductionOp| |cur_sym|)
           (ACTION (|advance_token|)) (ACTION (|advance_token|)))))))

; parse_Form() ==
;     match_symbol "iterate" =>
;         from_val :=
;             match_symbol "from" =>
;                 MUST parse_Label()
;                 [pop_stack_1()]
;             nil
;         push_lform1("iterate", from_val)
;     match_symbol "yield" =>
;         MUST parse_Application()
;         push_form1("yield", pop_stack_1())
;     parse_Application()

(DEFUN |parse_Form| ()
  (PROG (|from_val|)
    (RETURN
     (COND
      ((|match_symbol| '|iterate|)
       (PROGN
        (SETQ |from_val|
                (COND
                 ((|match_symbol| '|from|)
                  (PROGN (MUST (|parse_Label|)) (LIST (|pop_stack_1|))))
                 (#1='T NIL)))
        (|push_lform1| '|iterate| |from_val|)))
      ((|match_symbol| '|yield|)
       (PROGN
        (MUST (|parse_Application|))
        (|push_form1| '|yield| (|pop_stack_1|))))
      (#1# (|parse_Application|))))))

; parse_Application() ==
;     not(parse_Primary()) => nil
;     while parse_Selector() repeat nil
;     parse_Application() =>
;         push_reduction("parse_Application", [pop_stack_2(), pop_stack_1()])
;     true

(DEFUN |parse_Application| ()
  (PROG ()
    (RETURN
     (COND ((NULL (|parse_Primary|)) NIL)
           (#1='T
            (PROGN
             ((LAMBDA ()
                (LOOP
                 (COND ((NOT (|parse_Selector|)) (RETURN NIL)) (#1# NIL)))))
             (COND
              ((|parse_Application|)
               (|push_reduction| '|parse_Application|
                (LIST (|pop_stack_2|) (|pop_stack_1|))))
              (#1# T))))))))

; parse_Selector() ==
;     not(match_symbol ".") => nil
;     MUST parse_Primary()
;     push_reduction("parse_Selector",
;                          [pop_stack_2(), pop_stack_1()])

(DEFUN |parse_Selector| ()
  (PROG ()
    (RETURN
     (COND ((NULL (|match_symbol| '|.|)) NIL)
           ('T
            (PROGN
             (MUST (|parse_Primary|))
             (|push_reduction| '|parse_Selector|
              (LIST (|pop_stack_2|) (|pop_stack_1|)))))))))

; parse_PrimaryNoFloat() ==
;     AND(parse_Primary1(), OPTIONAL(parse_TokTail()))

(DEFUN |parse_PrimaryNoFloat| ()
  (PROG () (RETURN (AND (|parse_Primary1|) (OPTIONAL (|parse_TokTail|))))))

; parse_Primary() == OR(parse_Float(), parse_PrimaryNoFloat())

(DEFUN |parse_Primary| ()
  (PROG () (RETURN (OR (|parse_Float|) (|parse_PrimaryNoFloat|)))))

; parse_Primary1() ==
;     OR(
;        AND(parse_VarForm(),
;            OPTIONAL AND(current_token_is_nonblank(),
;               current_symbol() = "(", MUST parse_Enclosure(),
;               push_reduction("parse_Primary1",
;                              [pop_stack_2(), pop_stack_1()]))),
;        parse_String(), parse_IntegerTok(),
;        parse_FormalParameter(),
;        AND(symbol_is? "'",
;           MUST AND(match_symbol "'", MUST parse_Expr 999,
;                    push_form1("QUOTE", pop_stack_1()))),
;        parse_Sequence(), parse_Enclosure())

(DEFUN |parse_Primary1| ()
  (PROG ()
    (RETURN
     (OR
      (AND (|parse_VarForm|)
           (OPTIONAL
            (AND (|current_token_is_nonblank|) (EQ (|current_symbol|) '|(|)
                 (MUST (|parse_Enclosure|))
                 (|push_reduction| '|parse_Primary1|
                  (LIST (|pop_stack_2|) (|pop_stack_1|))))))
      (|parse_String|) (|parse_IntegerTok|) (|parse_FormalParameter|)
      (AND (|symbol_is?| '|'|)
           (MUST
            (AND (|match_symbol| '|'|) (MUST (|parse_Expr| 999))
                 (|push_form1| 'QUOTE (|pop_stack_1|)))))
      (|parse_Sequence|) (|parse_Enclosure|)))))

; parse_Float() == parse_SPADFLOAT()

(DEFUN |parse_Float| () (PROG () (RETURN (|parse_SPADFLOAT|))))

; parse_Enclosure1(closer) ==
;     MUST OR(
;             AND(parse_Expr 6, expect_symbol(closer)),
;             AND(expect_symbol(closer), push_form0("@Tuple")))

(DEFUN |parse_Enclosure1| (|closer|)
  (PROG ()
    (RETURN
     (MUST
      (OR (AND (|parse_Expr| 6) (|expect_symbol| |closer|))
          (AND (|expect_symbol| |closer|) (|push_form0| '|@Tuple|)))))))

; parse_Enclosure() ==
;     match_symbol "(" => parse_Enclosure1(")")
;     match_symbol "{" => parse_Enclosure1("}")
;     match_symbol "SETTAB" => parse_Enclosure1("BACKTAB")
;     nil

(DEFUN |parse_Enclosure| ()
  (PROG ()
    (RETURN
     (COND ((|match_symbol| '|(|) (|parse_Enclosure1| '|)|))
           ((|match_symbol| '{) (|parse_Enclosure1| '}))
           ((|match_symbol| 'SETTAB) (|parse_Enclosure1| 'BACKTAB)) ('T NIL)))))

; parse_IntegerTok() == parse_NUMBER()

(DEFUN |parse_IntegerTok| () (PROG () (RETURN (|parse_NUMBER|))))

; parse_FormalParameter() == parse_ARGUMENT_DESIGNATOR()

(DEFUN |parse_FormalParameter| ()
  (PROG () (RETURN (|parse_ARGUMENT_DESIGNATOR|))))

; parse_String() == parse_SPADSTRING()

(DEFUN |parse_String| () (PROG () (RETURN (|parse_SPADSTRING|))))

; parse_VarForm() == parse_IDENTIFIER()

(DEFUN |parse_VarForm| () (PROG () (RETURN (|parse_IDENTIFIER|))))

; parse_Name() == parse_IDENTIFIER()

(DEFUN |parse_Name| () (PROG () (RETURN (|parse_IDENTIFIER|))))

; parse_Data() == AND(ACTION(advance_token()),
;                     OR(parse_IDENTIFIER(), parse_KEYWORD()),
;                     push_form1("QUOTE", pop_stack_1()))

(DEFUN |parse_Data| ()
  (PROG ()
    (RETURN
     (AND (ACTION (|advance_token|))
          (OR (|parse_IDENTIFIER|) (|parse_KEYWORD|))
          (|push_form1| 'QUOTE (|pop_stack_1|))))))

; parse_GliphTok(tok) ==
;   AND(match_current_token('KEYWORD, tok), ACTION(advance_token()))

(DEFUN |parse_GliphTok| (|tok|)
  (PROG ()
    (RETURN
     (AND (|match_current_token| 'KEYWORD |tok|) (ACTION (|advance_token|))))))

; parse_Sequence() ==
;     match_symbol "[" =>
;         MUST(parse_Sequence1())
;         expect_symbol "]"
;     nil

(DEFUN |parse_Sequence| ()
  (PROG ()
    (RETURN
     (COND
      ((|match_symbol| '[)
       (PROGN (MUST (|parse_Sequence1|)) (|expect_symbol| '])))
      ('T NIL)))))

; parse_Sequence1() ==
;     val :=
;         parse_Expression() => [pop_stack_1()]
;         nil
;     push_reduction("parse_Sequence1", ["construct", :val])
;     OPTIONAL
;       AND(parse_IteratorTail(),
;           push_lform1("COLLECT", [:pop_stack_1(),
;                                        pop_stack_1()]))

(DEFUN |parse_Sequence1| ()
  (PROG (|val|)
    (RETURN
     (PROGN
      (SETQ |val|
              (COND ((|parse_Expression|) (LIST (|pop_stack_1|))) ('T NIL)))
      (|push_reduction| '|parse_Sequence1| (CONS '|construct| |val|))
      (OPTIONAL
       (AND (|parse_IteratorTail|)
            (|push_lform1| 'COLLECT
             (APPEND (|pop_stack_1|) (CONS (|pop_stack_1|) NIL)))))))))

; parse_IteratorTail() ==
;     repetition(nil, FUNCTION parse_Iterator)

(DEFUN |parse_IteratorTail| ()
  (PROG () (RETURN (|repetition| NIL #'|parse_Iterator|))))
