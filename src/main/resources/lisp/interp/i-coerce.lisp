
; )package "BOOT"

(IN-PACKAGE "BOOT")

; algCoerceInteractive(p,source,target) ==
;   -- now called in some groebner code
;   $useConvertForCoercions : local := true
;   source := devaluate source
;   target := devaluate target
;   u := coerceInteractive(objNewWrap(p,source),target)
;   u => objValUnwrap(u)
;   error ['"can't convert",p,'"of mode",source,'"to mode",target]

(DEFUN |algCoerceInteractive| (|p| |source| |target|)
  (PROG (|$useConvertForCoercions| |u|)
    (DECLARE (SPECIAL |$useConvertForCoercions|))
    (RETURN
     (PROGN
      (SETQ |$useConvertForCoercions| T)
      (SETQ |source| (|devaluate| |source|))
      (SETQ |target| (|devaluate| |target|))
      (SETQ |u| (|coerceInteractive| (|objNewWrap| |p| |source|) |target|))
      (COND (|u| (|objValUnwrap| |u|))
            ('T
             (|error|
              (LIST "can't convert" |p| "of mode" |source| "to mode"
                    |target|))))))))

; spad2BootCoerce(x,source,target) ==
;   -- x : source and we wish to coerce to target
;   -- used in spad code for Any
;   null isValidType source => throwKeyedMsg("S2IE0004",[source])
;   null isValidType target => throwKeyedMsg("S2IE0004",[target])
;   x' := coerceInteractive(objNewWrap(x,source),target) =>
;     objValUnwrap(x')
;   throwKeyedMsgCannotCoerceWithValue(wrap x,source,target)

(DEFUN |spad2BootCoerce| (|x| |source| |target|)
  (PROG (|x'|)
    (RETURN
     (COND
      ((NULL (|isValidType| |source|))
       (|throwKeyedMsg| 'S2IE0004 (LIST |source|)))
      ((NULL (|isValidType| |target|))
       (|throwKeyedMsg| 'S2IE0004 (LIST |target|)))
      ((SETQ |x'| (|coerceInteractive| (|objNewWrap| |x| |source|) |target|))
       (|objValUnwrap| |x'|))
      ('T
       (|throwKeyedMsgCannotCoerceWithValue| (|wrap| |x|) |source|
        |target|))))))

; coerceOrFail(triple,t,mapName) ==
;   -- some code generated for this is in coerceInt0
;   t = $NoValueMode => triple
;   t' := coerceInteractive(triple,t)
;   t' => objValUnwrap(t')
;   sayKeyedMsg("S2IC0004",[mapName,objMode triple,t])
;   '"failed"

(DEFUN |coerceOrFail| (|triple| |t| |mapName|)
  (PROG (|t'|)
    (RETURN
     (COND ((EQUAL |t| |$NoValueMode|) |triple|)
           (#1='T
            (PROGN
             (SETQ |t'| (|coerceInteractive| |triple| |t|))
             (COND (|t'| (|objValUnwrap| |t'|))
                   (#1#
                    (PROGN
                     (|sayKeyedMsg| 'S2IC0004
                      (LIST |mapName| (|objMode| |triple|) |t|))
                     "failed")))))))))

; coerceOrCroak(triple, t, mapName) ==
;   -- this does the coercion and returns the value or dies
;   t = $NoValueMode => triple
;   t' := coerceOrConvertOrRetract(triple,t)
;   t' => objValUnwrap(t')
;   mapName = 'noMapName =>
;     throwKeyedMsgCannotCoerceWithValue(objVal triple,objMode triple, t)
;   sayKeyedMsg("S2IC0005",[mapName])
;   throwKeyedMsgCannotCoerceWithValue(objVal triple,objMode triple, t)

(DEFUN |coerceOrCroak| (|triple| |t| |mapName|)
  (PROG (|t'|)
    (RETURN
     (COND ((EQUAL |t| |$NoValueMode|) |triple|)
           (#1='T
            (PROGN
             (SETQ |t'| (|coerceOrConvertOrRetract| |triple| |t|))
             (COND (|t'| (|objValUnwrap| |t'|))
                   ((EQ |mapName| '|noMapName|)
                    (|throwKeyedMsgCannotCoerceWithValue| (|objVal| |triple|)
                     (|objMode| |triple|) |t|))
                   (#1#
                    (PROGN
                     (|sayKeyedMsg| 'S2IC0005 (LIST |mapName|))
                     (|throwKeyedMsgCannotCoerceWithValue| (|objVal| |triple|)
                      (|objMode| |triple|) |t|))))))))))

; coerceOrThrowFailure(value, t1, t2) ==
;   (result := coerceOrRetract(objNewWrap(value, t1), t2)) or
;     coercionFailure()
;   objValUnwrap(result)

(DEFUN |coerceOrThrowFailure| (|value| |t1| |t2|)
  (PROG (|result|)
    (RETURN
     (PROGN
      (OR (SETQ |result| (|coerceOrRetract| (|objNewWrap| |value| |t1|) |t2|))
          (|coercionFailure|))
      (|objValUnwrap| |result|)))))

; retract object ==
;   type := objMode object
;   STRINGP type => 'failed
;   type = $EmptyMode => 'failed
;   val := objVal object
;   not isWrapped val and val isnt ['SPADMAP, :.] => 'failed
;   (ans := retract1 objNew(val, type)) = 'failed => ans
;   objNew(objVal ans, objMode ans)

(DEFUN |retract| (|object|)
  (PROG (|type| |val| |ans|)
    (RETURN
     (PROGN
      (SETQ |type| (|objMode| |object|))
      (COND ((STRINGP |type|) '|failed|)
            ((EQUAL |type| |$EmptyMode|) '|failed|)
            (#1='T
             (PROGN
              (SETQ |val| (|objVal| |object|))
              (COND
               ((AND (NULL (|isWrapped| |val|))
                     (NOT (AND (CONSP |val|) (EQ (CAR |val|) 'SPADMAP))))
                '|failed|)
               ((EQ (SETQ |ans| (|retract1| (|objNew| |val| |type|)))
                    '|failed|)
                |ans|)
               (#1# (|objNew| (|objVal| |ans|) (|objMode| |ans|)))))))))))

; retract1 object ==
;   -- this function is the new version of the old "pullback"
;   -- it first tries to change the datatype of an object to that of
;   -- largest contained type. Examples: P RN -> RN, RN -> I
;   -- This is mostly for cases such as constant polynomials or
;   -- quotients with 1 in the denominator.
;   type := objMode object
;   STRINGP type => 'failed
;   val := objVal object
;   type = $PositiveInteger =>    objNew(val,$NonNegativeInteger)
;   type = $NonNegativeInteger => objNew(val,$Integer)
;   type = $Integer and SINTP unwrap val => objNew(val, $SingleInteger)
;   (1 = #type) or (type is ['Union,:.]) or
;     (type is ['FunctionCalled,.])
;      or (type is ['OrderedVariableList,.]) or (type is ['Variable,.]) =>
;       (object' := retract2Specialization(object)) => object'
;       'failed
;   null (underDomain := underDomainOf type) => 'failed
;   -- try to retract the "coefficients"
;   -- think of P RN -> P I or M RN -> M I
;   object' := retractUnderDomain(object,type,underDomain)
;   object' ~= 'failed => object'
;   -- see if we can use the retract functions
;   (object' := coerceRetract(object,underDomain)) => object'
;   -- see if we have a special case here
;   (object' := retract2Specialization(object)) => object'
;   'failed

(DEFUN |retract1| (|object|)
  (PROG (|type| |val| |ISTMP#1| |object'| |underDomain|)
    (RETURN
     (PROGN
      (SETQ |type| (|objMode| |object|))
      (COND ((STRINGP |type|) '|failed|)
            (#1='T
             (PROGN
              (SETQ |val| (|objVal| |object|))
              (COND
               ((EQUAL |type| |$PositiveInteger|)
                (|objNew| |val| |$NonNegativeInteger|))
               ((EQUAL |type| |$NonNegativeInteger|)
                (|objNew| |val| |$Integer|))
               ((AND (EQUAL |type| |$Integer|) (SINTP (|unwrap| |val|)))
                (|objNew| |val| |$SingleInteger|))
               ((OR (EQL 1 (LENGTH |type|))
                    (AND (CONSP |type|) (EQ (CAR |type|) '|Union|))
                    (AND (CONSP |type|) (EQ (CAR |type|) '|FunctionCalled|)
                         (PROGN
                          (SETQ |ISTMP#1| (CDR |type|))
                          (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL))))
                    (AND (CONSP |type|)
                         (EQ (CAR |type|) '|OrderedVariableList|)
                         (PROGN
                          (SETQ |ISTMP#1| (CDR |type|))
                          (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL))))
                    (AND (CONSP |type|) (EQ (CAR |type|) '|Variable|)
                         (PROGN
                          (SETQ |ISTMP#1| (CDR |type|))
                          (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)))))
                (COND
                 ((SETQ |object'| (|retract2Specialization| |object|))
                  |object'|)
                 (#1# '|failed|)))
               ((NULL (SETQ |underDomain| (|underDomainOf| |type|))) '|failed|)
               (#1#
                (PROGN
                 (SETQ |object'|
                         (|retractUnderDomain| |object| |type| |underDomain|))
                 (COND ((NOT (EQ |object'| '|failed|)) |object'|)
                       ((SETQ |object'|
                                (|coerceRetract| |object| |underDomain|))
                        |object'|)
                       ((SETQ |object'| (|retract2Specialization| |object|))
                        |object'|)
                       (#1# '|failed|))))))))))))

; retractUnderDomain(object,type,underDomain) ==
;   null (ud := underDomainOf underDomain) => 'failed
;   [c,:args] := deconstructT type
;   1 ~= #args => 'failed
;   1 ~= #c => 'failed
;   type'' := constructT(c,[ud])
;   (object' := coerceInt(object,type'')) => object'
;   'failed

(DEFUN |retractUnderDomain| (|object| |type| |underDomain|)
  (PROG (|ud| |LETTMP#1| |c| |args| |type''| |object'|)
    (RETURN
     (COND ((NULL (SETQ |ud| (|underDomainOf| |underDomain|))) '|failed|)
           (#1='T
            (PROGN
             (SETQ |LETTMP#1| (|deconstructT| |type|))
             (SETQ |c| (CAR |LETTMP#1|))
             (SETQ |args| (CDR |LETTMP#1|))
             (COND ((NOT (EQL 1 (LENGTH |args|))) '|failed|)
                   ((NOT (EQL 1 (LENGTH |c|))) '|failed|)
                   (#1#
                    (PROGN
                     (SETQ |type''| (|constructT| |c| (LIST |ud|)))
                     (COND
                      ((SETQ |object'| (|coerceInt| |object| |type''|))
                       |object'|)
                      (#1# '|failed|)))))))))))

; retract2Specialization object ==
;   -- handles some specialization retraction cases, like matrices
;   val := objVal object
;   val' := unwrap val
;   type := objMode object
;
;   type = $Any =>
;     [dom,:obj] := val'
;     objNewWrap(obj,dom)
;   type is ['Union,:unionDoms] => coerceUnion2Branch object
;   type = $Symbol =>
;     objNewWrap(1,['OrderedVariableList,[val']])
;   type is ['OrderedVariableList,var] =>
;     coerceInt(objNewWrap(var.(val'-1),$Symbol), '(Polynomial (Integer)))
; -- !! following retract seems wrong and breaks ug13.input
; --  type is ['Variable,var] =>
; --    coerceInt(object,$Symbol)
;   type is ['Polynomial,D] =>
;     val' is [ =1,x,:.] =>
;       vl := REMDUP reverse varsInPoly val'
;       1 = #vl => coerceInt(object,['UnivariatePolynomial,x,D])
;       NIL
;     val' is [ =0,:.] => coerceInt(object, D)
;     NIL
;   type is ['Matrix,D] =>
;     n := ANROWS(val')
;     m := ANCOLS(val')
;     n = m => objNew(val,['SquareMatrix,n,D])
;     objNew(val,['RectangularMatrix,n,m,D])
;   type is ['RectangularMatrix,n,m,D] =>
;     n = m => objNew(val,['SquareMatrix,n,D])
;     NIL
;   (type is [agg,D]) and (agg in '(Vector Segment UniversalSegment)) =>
;     D = $PositiveInteger => objNew(val,[agg,$NonNegativeInteger])
;     D = $NonNegativeInteger => objNew(val,[agg,$Integer])
;     NIL
;   type is ['Array,bds,D] =>
;     D = $PositiveInteger => objNew(val,['Array,bds,$NonNegativeInteger])
;     D = $NonNegativeInteger => objNew(val,['Array,bds,$Integer])
;     NIL
;   type is ['List,D] =>
;     D isnt ['List,D'] =>
;       -- try to retract elements
;       D = $PositiveInteger => objNew(val,['List,$NonNegativeInteger])
;       D = $NonNegativeInteger => objNew(val,['List,$Integer])
;       null val' => nil
; --        null (um := underDomainOf D) => nil
; --        objNewWrap(nil,['List,um])
;       vl := nil
;       tl := nil
;       bad := nil
;       for e in val' while not bad repeat
;         (e' := retract objNewWrap(e,D)) = 'failed => bad := true
;         vl := [objValUnwrap e',:vl]
;         tl := [objMode e',:tl]
;       bad => NIL
;       (m := resolveTypeListAny tl) = D => NIL
;       vl' := nil
;       for e in vl for t in tl repeat
;         t = m => vl' := [e,:vl']
;         e' := coerceInt(objNewWrap(e,t),m)
;         null e' => return NIL
;         vl' := [objValUnwrap e',:vl']
;       objNewWrap(vl',['List,m])
;     D' = $PositiveInteger =>
;       objNew(val,['List,['List,$NonNegativeInteger]])
;     D' = $NonNegativeInteger =>
;       objNew(val,['List,['List,$Integer]])
;     D' is ['Variable,.] or D' is ['OrderedVariableList,.] =>
;         coerceInt(object,['List,['List,$Symbol]])
;
;     n := # val'
;     m := # val'.0
;     null isRectangularList(val',n,m) => NIL
;     coerceInt(object,['Matrix,D'])
;   type is ['Expression,D] =>
;     ofCategory(type, '(Field)) =>
;       [num,:den] := val'
;       -- coerceRetract already handles case where den = 1
;       num isnt [0,:num] => NIL
;       den isnt [0,:den] => NIL
;       objNewWrap([num,:den],[$QuotientField, D])
;     NIL
;   type is ['SimpleAlgebraicExtension,k,rep,.] =>
;     -- try to retract as an element of rep and see if we can get an
;     -- element of k
;     val' := retract objNew(val,rep)
;     while (val' ~= 'failed) and
;       (objMode(val') ~= k) repeat
;         val' := retract val'
;     val' = 'failed => NIL
;     val'
;
;   type is ['UnivariatePuiseuxSeries, coef, var, cen] =>
;     coerceInt(object, ['UnivariateLaurentSeries, coef, var, cen])
;   type is ['UnivariateLaurentSeries, coef, var, cen] =>
;     coerceInt(object, ['UnivariateTaylorSeries, coef, var, cen])
;
;   type is ['FunctionCalled,name] =>
;     null (m := get(name,'mode,$e)) => NIL
;     isPartialMode m => NIL
;     objNew(val,m)
;   NIL

(DEFUN |retract2Specialization| (|object|)
  (PROG (|val| |val'| |type| |dom| |obj| |unionDoms| |ISTMP#1| |var| D |x| |vl|
         |n| |m| |ISTMP#2| |ISTMP#3| |agg| |bds| |D'| |tl| |bad| |e'| |vl'|
         |num| |den| |k| |rep| |coef| |cen| |name|)
    (RETURN
     (PROGN
      (SETQ |val| (|objVal| |object|))
      (SETQ |val'| (|unwrap| |val|))
      (SETQ |type| (|objMode| |object|))
      (COND
       ((EQUAL |type| |$Any|)
        (PROGN
         (SETQ |dom| (CAR |val'|))
         (SETQ |obj| (CDR |val'|))
         (|objNewWrap| |obj| |dom|)))
       ((AND (CONSP |type|) (EQ (CAR |type|) '|Union|)
             (PROGN (SETQ |unionDoms| (CDR |type|)) #1='T))
        (|coerceUnion2Branch| |object|))
       ((EQUAL |type| |$Symbol|)
        (|objNewWrap| 1 (LIST '|OrderedVariableList| (LIST |val'|))))
       ((AND (CONSP |type|) (EQ (CAR |type|) '|OrderedVariableList|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |type|))
              (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                   (PROGN (SETQ |var| (CAR |ISTMP#1|)) #1#))))
        (|coerceInt| (|objNewWrap| (ELT |var| (- |val'| 1)) |$Symbol|)
         '(|Polynomial| (|Integer|))))
       ((AND (CONSP |type|) (EQ (CAR |type|) '|Polynomial|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |type|))
              (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                   (PROGN (SETQ D (CAR |ISTMP#1|)) #1#))))
        (COND
         ((AND (CONSP |val'|) (EQUAL (CAR |val'|) 1)
               (PROGN
                (SETQ |ISTMP#1| (CDR |val'|))
                (AND (CONSP |ISTMP#1|)
                     (PROGN (SETQ |x| (CAR |ISTMP#1|)) #1#))))
          (PROGN
           (SETQ |vl| (REMDUP (REVERSE (|varsInPoly| |val'|))))
           (COND
            ((EQL 1 (LENGTH |vl|))
             (|coerceInt| |object| (LIST '|UnivariatePolynomial| |x| D)))
            (#1# NIL))))
         ((AND (CONSP |val'|) (EQUAL (CAR |val'|) 0)) (|coerceInt| |object| D))
         (#1# NIL)))
       ((AND (CONSP |type|) (EQ (CAR |type|) '|Matrix|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |type|))
              (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                   (PROGN (SETQ D (CAR |ISTMP#1|)) #1#))))
        (PROGN
         (SETQ |n| (ANROWS |val'|))
         (SETQ |m| (ANCOLS |val'|))
         (COND ((EQUAL |n| |m|) (|objNew| |val| (LIST '|SquareMatrix| |n| D)))
               (#1# (|objNew| |val| (LIST '|RectangularMatrix| |n| |m| D))))))
       ((AND (CONSP |type|) (EQ (CAR |type|) '|RectangularMatrix|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |type|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |n| (CAR |ISTMP#1|))
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|)
                         (PROGN
                          (SETQ |m| (CAR |ISTMP#2|))
                          (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                          (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                               (PROGN (SETQ D (CAR |ISTMP#3|)) #1#))))))))
        (COND ((EQUAL |n| |m|) (|objNew| |val| (LIST '|SquareMatrix| |n| D)))
              (#1# NIL)))
       ((AND (CONSP |type|)
             (PROGN
              (SETQ |agg| (CAR |type|))
              (SETQ |ISTMP#1| (CDR |type|))
              (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                   (PROGN (SETQ D (CAR |ISTMP#1|)) #1#)))
             (|member| |agg| '(|Vector| |Segment| |UniversalSegment|)))
        (COND
         ((EQUAL D |$PositiveInteger|)
          (|objNew| |val| (LIST |agg| |$NonNegativeInteger|)))
         ((EQUAL D |$NonNegativeInteger|)
          (|objNew| |val| (LIST |agg| |$Integer|)))
         (#1# NIL)))
       ((AND (CONSP |type|) (EQ (CAR |type|) '|Array|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |type|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |bds| (CAR |ISTMP#1|))
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                         (PROGN (SETQ D (CAR |ISTMP#2|)) #1#))))))
        (COND
         ((EQUAL D |$PositiveInteger|)
          (|objNew| |val| (LIST '|Array| |bds| |$NonNegativeInteger|)))
         ((EQUAL D |$NonNegativeInteger|)
          (|objNew| |val| (LIST '|Array| |bds| |$Integer|)))
         (#1# NIL)))
       ((AND (CONSP |type|) (EQ (CAR |type|) '|List|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |type|))
              (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                   (PROGN (SETQ D (CAR |ISTMP#1|)) #1#))))
        (COND
         ((NOT
           (AND (CONSP D) (EQ (CAR D) '|List|)
                (PROGN
                 (SETQ |ISTMP#1| (CDR D))
                 (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                      (PROGN (SETQ |D'| (CAR |ISTMP#1|)) #1#)))))
          (COND
           ((EQUAL D |$PositiveInteger|)
            (|objNew| |val| (LIST '|List| |$NonNegativeInteger|)))
           ((EQUAL D |$NonNegativeInteger|)
            (|objNew| |val| (LIST '|List| |$Integer|)))
           ((NULL |val'|) NIL)
           (#1#
            (PROGN
             (SETQ |vl| NIL)
             (SETQ |tl| NIL)
             (SETQ |bad| NIL)
             ((LAMBDA (|bfVar#1| |e|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#1|) (PROGN (SETQ |e| (CAR |bfVar#1|)) NIL)
                       |bad|)
                   (RETURN NIL))
                  (#1#
                   (COND
                    ((EQ (SETQ |e'| (|retract| (|objNewWrap| |e| D)))
                         '|failed|)
                     (SETQ |bad| T))
                    (#1#
                     (PROGN
                      (SETQ |vl| (CONS (|objValUnwrap| |e'|) |vl|))
                      (SETQ |tl| (CONS (|objMode| |e'|) |tl|)))))))
                 (SETQ |bfVar#1| (CDR |bfVar#1|))))
              |val'| NIL)
             (COND (|bad| NIL)
                   ((EQUAL (SETQ |m| (|resolveTypeListAny| |tl|)) D) NIL)
                   (#1#
                    (PROGN
                     (SETQ |vl'| NIL)
                     ((LAMBDA (|bfVar#2| |e| |bfVar#3| |t|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#2|)
                               (PROGN (SETQ |e| (CAR |bfVar#2|)) NIL)
                               (ATOM |bfVar#3|)
                               (PROGN (SETQ |t| (CAR |bfVar#3|)) NIL))
                           (RETURN NIL))
                          (#1#
                           (COND
                            ((EQUAL |t| |m|) (SETQ |vl'| (CONS |e| |vl'|)))
                            (#1#
                             (PROGN
                              (SETQ |e'|
                                      (|coerceInt| (|objNewWrap| |e| |t|) |m|))
                              (COND ((NULL |e'|) (RETURN NIL))
                                    (#1#
                                     (SETQ |vl'|
                                             (CONS (|objValUnwrap| |e'|)
                                                   |vl'|)))))))))
                         (SETQ |bfVar#2| (CDR |bfVar#2|))
                         (SETQ |bfVar#3| (CDR |bfVar#3|))))
                      |vl| NIL |tl| NIL)
                     (|objNewWrap| |vl'| (LIST '|List| |m|)))))))))
         ((EQUAL |D'| |$PositiveInteger|)
          (|objNew| |val| (LIST '|List| (LIST '|List| |$NonNegativeInteger|))))
         ((EQUAL |D'| |$NonNegativeInteger|)
          (|objNew| |val| (LIST '|List| (LIST '|List| |$Integer|))))
         ((OR
           (AND (CONSP |D'|) (EQ (CAR |D'|) '|Variable|)
                (PROGN
                 (SETQ |ISTMP#1| (CDR |D'|))
                 (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL))))
           (AND (CONSP |D'|) (EQ (CAR |D'|) '|OrderedVariableList|)
                (PROGN
                 (SETQ |ISTMP#1| (CDR |D'|))
                 (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)))))
          (|coerceInt| |object| (LIST '|List| (LIST '|List| |$Symbol|))))
         (#1#
          (PROGN
           (SETQ |n| (LENGTH |val'|))
           (SETQ |m| (LENGTH (ELT |val'| 0)))
           (COND ((NULL (|isRectangularList| |val'| |n| |m|)) NIL)
                 (#1# (|coerceInt| |object| (LIST '|Matrix| |D'|))))))))
       ((AND (CONSP |type|) (EQ (CAR |type|) '|Expression|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |type|))
              (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                   (PROGN (SETQ D (CAR |ISTMP#1|)) #1#))))
        (COND
         ((|ofCategory| |type| '(|Field|))
          (PROGN
           (SETQ |num| (CAR |val'|))
           (SETQ |den| (CDR |val'|))
           (COND
            ((NOT
              (AND (CONSP |num|) (EQUAL (CAR |num|) 0)
                   (PROGN (SETQ |num| (CDR |num|)) #1#)))
             NIL)
            ((NOT
              (AND (CONSP |den|) (EQUAL (CAR |den|) 0)
                   (PROGN (SETQ |den| (CDR |den|)) #1#)))
             NIL)
            (#1#
             (|objNewWrap| (CONS |num| |den|) (LIST |$QuotientField| D))))))
         (#1# NIL)))
       ((AND (CONSP |type|) (EQ (CAR |type|) '|SimpleAlgebraicExtension|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |type|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |k| (CAR |ISTMP#1|))
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|)
                         (PROGN
                          (SETQ |rep| (CAR |ISTMP#2|))
                          (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                          (AND (CONSP |ISTMP#3|)
                               (EQ (CDR |ISTMP#3|) NIL))))))))
        (PROGN
         (SETQ |val'| (|retract| (|objNew| |val| |rep|)))
         ((LAMBDA ()
            (LOOP
             (COND
              ((NOT
                (AND (NOT (EQ |val'| '|failed|))
                     (NOT (EQUAL (|objMode| |val'|) |k|))))
               (RETURN NIL))
              (#1# (SETQ |val'| (|retract| |val'|)))))))
         (COND ((EQ |val'| '|failed|) NIL) (#1# |val'|))))
       ((AND (CONSP |type|) (EQ (CAR |type|) '|UnivariatePuiseuxSeries|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |type|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |coef| (CAR |ISTMP#1|))
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|)
                         (PROGN
                          (SETQ |var| (CAR |ISTMP#2|))
                          (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                          (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                               (PROGN (SETQ |cen| (CAR |ISTMP#3|)) #1#))))))))
        (|coerceInt| |object|
         (LIST '|UnivariateLaurentSeries| |coef| |var| |cen|)))
       ((AND (CONSP |type|) (EQ (CAR |type|) '|UnivariateLaurentSeries|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |type|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |coef| (CAR |ISTMP#1|))
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|)
                         (PROGN
                          (SETQ |var| (CAR |ISTMP#2|))
                          (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                          (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                               (PROGN (SETQ |cen| (CAR |ISTMP#3|)) #1#))))))))
        (|coerceInt| |object|
         (LIST '|UnivariateTaylorSeries| |coef| |var| |cen|)))
       ((AND (CONSP |type|) (EQ (CAR |type|) '|FunctionCalled|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |type|))
              (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                   (PROGN (SETQ |name| (CAR |ISTMP#1|)) #1#))))
        (COND ((NULL (SETQ |m| (|get| |name| '|mode| |$e|))) NIL)
              ((|isPartialMode| |m|) NIL) (#1# (|objNew| |val| |m|))))
       (#1# NIL))))))

; coerceOrConvertOrRetract(T,m) ==
;   $useConvertForCoercions : local := true
;   coerceOrRetract(T,m)

(DEFUN |coerceOrConvertOrRetract| (T$ |m|)
  (PROG (|$useConvertForCoercions|)
    (DECLARE (SPECIAL |$useConvertForCoercions|))
    (RETURN
     (PROGN (SETQ |$useConvertForCoercions| T) (|coerceOrRetract| T$ |m|)))))

; coerceOrRetract(T,m) ==
;   (t' := coerceInteractive(T,m)) => t'
;   t := T
;   ans := nil
;   repeat
;     ans => return ans
;     t := retract t   -- retract is new name for pullback
;     t = 'failed => return ans
;     ans := coerceInteractive(t,m)
;   ans

(DEFUN |coerceOrRetract| (T$ |m|)
  (PROG (|t'| |t| |ans|)
    (RETURN
     (COND ((SETQ |t'| (|coerceInteractive| T$ |m|)) |t'|)
           (#1='T
            (PROGN
             (SETQ |t| T$)
             (SETQ |ans| NIL)
             ((LAMBDA ()
                (LOOP
                 (COND (NIL (RETURN NIL))
                       (#1#
                        (COND (|ans| (RETURN |ans|))
                              (#1#
                               (PROGN
                                (SETQ |t| (|retract| |t|))
                                (COND ((EQ |t| '|failed|) (RETURN |ans|))
                                      (#1#
                                       (SETQ |ans|
                                               (|coerceInteractive| |t|
                                                |m|))))))))))))
             |ans|))))))

; coerceRetract(object,t2) ==
;   -- tries to handle cases such as P I -> I
;   (val := objValUnwrap(object)) = "$fromCoerceable$" => NIL
;   t1 := objMode object
;   t2 = $OutputForm => NIL
;   isEqualOrSubDomain(t1,$Integer) and typeIsASmallInteger(t2) and SINTP(val) =>
;     objNewWrap(val,t2)
;   t1 = $Integer    => NIL
;   t1 = $Symbol     => NIL
;   t1 = $OutputForm => NIL
;   (c := retractByFunction(object, t2)) => c
;   NIL

(DEFUN |coerceRetract| (|object| |t2|)
  (PROG (|val| |t1| |c|)
    (RETURN
     (COND
      ((EQ (SETQ |val| (|objValUnwrap| |object|)) '|$fromCoerceable$|) NIL)
      (#1='T
       (PROGN
        (SETQ |t1| (|objMode| |object|))
        (COND ((EQUAL |t2| |$OutputForm|) NIL)
              ((AND (|isEqualOrSubDomain| |t1| |$Integer|)
                    (|typeIsASmallInteger| |t2|) (SINTP |val|))
               (|objNewWrap| |val| |t2|))
              ((EQUAL |t1| |$Integer|) NIL) ((EQUAL |t1| |$Symbol|) NIL)
              ((EQUAL |t1| |$OutputForm|) NIL)
              ((SETQ |c| (|retractByFunction| |object| |t2|)) |c|)
              (#1# NIL))))))))

; findRetractMms1(st, tt) ==
;     target := ['Union, tt, '"failed"]
;     fn := 'retractIfCan
;     mms := append(findFunctionInDomain(fn, tt, target, [st], [st], NIL, 'T),
;                   findFunctionInDomain(fn, st, target, [st],[st], NIL, 'T))
;     mms => orderMms(fn, mms, [st], [st], target)
;     mms

(DEFUN |findRetractMms1| (|st| |tt|)
  (PROG (|target| |fn| |mms|)
    (RETURN
     (PROGN
      (SETQ |target| (LIST '|Union| |tt| "failed"))
      (SETQ |fn| '|retractIfCan|)
      (SETQ |mms|
              (APPEND
               (|findFunctionInDomain| |fn| |tt| |target| (LIST |st|)
                (LIST |st|) NIL 'T)
               (|findFunctionInDomain| |fn| |st| |target| (LIST |st|)
                (LIST |st|) NIL 'T)))
      (COND (|mms| (|orderMms| |fn| |mms| (LIST |st|) (LIST |st|) |target|))
            ('T |mms|))))))

; retractByFunction(object,u) ==
;   -- tries to retract by using function "retractIfCan"
;   -- if the type belongs to the correct category.
;   $reportBottomUpFlag: local := NIL
;   t := objMode object
;   -- JHD/CRF not ofCategory(t,['RetractableTo,u]) => NIL
;   val := objValUnwrap object
;   -- try to get and apply the function "retractable?"
;   target := ['Union,u,'"failed"]
;   funName := 'retractIfCan
;   if $reportBottomUpFlag then
;     sayFunctionSelection(funName,[t],target,NIL,
;       '"coercion facility (retraction)")
;   mms := findRetractMms(t, u)
;   if $reportBottomUpFlag then
;     sayFunctionSelectionResult(funName,[t],mms)
;   null mms => NIL
;
;   -- [[dc, :.], slot, .] := first mms
;   dc := CAAAR mms
;   slot := CADAR mms
;   fun := interpLookup(funName, [target,t], dc)
; --+
;   NULL fun => NIL
;   first(fun) = function Undef => NIL
; --+
;   object' := coerceUnion2Branch objNewWrap(SPADCALL(val,fun),target)
;   u' := objMode object'
;   u = u' => object'
;   NIL

(DEFUN |retractByFunction| (|object| |u|)
  (PROG (|$reportBottomUpFlag| |u'| |object'| |fun| |slot| |dc| |mms| |funName|
         |target| |val| |t|)
    (DECLARE (SPECIAL |$reportBottomUpFlag|))
    (RETURN
     (PROGN
      (SETQ |$reportBottomUpFlag| NIL)
      (SETQ |t| (|objMode| |object|))
      (SETQ |val| (|objValUnwrap| |object|))
      (SETQ |target| (LIST '|Union| |u| "failed"))
      (SETQ |funName| '|retractIfCan|)
      (COND
       (|$reportBottomUpFlag|
        (|sayFunctionSelection| |funName| (LIST |t|) |target| NIL
         "coercion facility (retraction)")))
      (SETQ |mms| (|findRetractMms| |t| |u|))
      (COND
       (|$reportBottomUpFlag|
        (|sayFunctionSelectionResult| |funName| (LIST |t|) |mms|)))
      (COND ((NULL |mms|) NIL)
            (#1='T
             (PROGN
              (SETQ |dc| (CAAAR |mms|))
              (SETQ |slot| (CADAR |mms|))
              (SETQ |fun| (|interpLookup| |funName| (LIST |target| |t|) |dc|))
              (COND ((NULL |fun|) NIL) ((EQUAL (CAR |fun|) #'|Undef|) NIL)
                    (#1#
                     (PROGN
                      (SETQ |object'|
                              (|coerceUnion2Branch|
                               (|objNewWrap| (SPADCALL |val| |fun|) |target|)))
                      (SETQ |u'| (|objMode| |object'|))
                      (COND ((EQUAL |u| |u'|) |object'|) (#1# NIL))))))))))))

; constantInDomain?(form,domainForm) ==
;     opAlist := getOperationAlistFromLisplib first domainForm
;     key := opOf form
;     entryList := LASSOC(key,opAlist)
;     entryList is [[., ., ., type]] and type in '(CONST ASCONST) => true
;     key = "One" => constantInDomain?(["1"], domainForm)
;     key = "Zero" => constantInDomain?(["0"], domainForm)
;     false

(DEFUN |constantInDomain?| (|form| |domainForm|)
  (PROG (|opAlist| |key| |entryList| |ISTMP#1| |ISTMP#2| |ISTMP#3| |ISTMP#4|
         |type|)
    (RETURN
     (PROGN
      (SETQ |opAlist| (|getOperationAlistFromLisplib| (CAR |domainForm|)))
      (SETQ |key| (|opOf| |form|))
      (SETQ |entryList| (LASSOC |key| |opAlist|))
      (COND
       ((AND (CONSP |entryList|) (EQ (CDR |entryList|) NIL)
             (PROGN
              (SETQ |ISTMP#1| (CAR |entryList|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|)
                         (PROGN
                          (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                          (AND (CONSP |ISTMP#3|)
                               (PROGN
                                (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                                (AND (CONSP |ISTMP#4|) (EQ (CDR |ISTMP#4|) NIL)
                                     (PROGN
                                      (SETQ |type| (CAR |ISTMP#4|))
                                      #1='T)))))))))
             (|member| |type| '(CONST ASCONST)))
        T)
       ((EQ |key| '|One|) (|constantInDomain?| (LIST '|1|) |domainForm|))
       ((EQ |key| '|Zero|) (|constantInDomain?| (LIST '|0|) |domainForm|))
       (#1# NIL))))))

; getConstantFromDomain1(form,domainForm) ==
;     isPartialMode domainForm => NIL
;     opAlist := getOperationAlistFromLisplib first domainForm
;     key := opOf form
;     entryList := LASSOC(key,opAlist)
;     entryList isnt [[sig, ., ., .]] =>
;         key = "One" => getConstantFromDomain(["1"], domainForm)
;         key = "Zero" => getConstantFromDomain(["0"], domainForm)
;         throwKeyedMsg("S2IC0008",[form,domainForm])
;     -- i.e., there should be exactly one item under this key of that form
;     domain := evalDomain domainForm
;     SPADCALL compiledLookupCheck(key,sig,domain)

(DEFUN |getConstantFromDomain1| (|form| |domainForm|)
  (PROG (|opAlist| |key| |entryList| |ISTMP#1| |sig| |ISTMP#2| |ISTMP#3|
         |ISTMP#4| |domain|)
    (RETURN
     (COND ((|isPartialMode| |domainForm|) NIL)
           (#1='T
            (PROGN
             (SETQ |opAlist|
                     (|getOperationAlistFromLisplib| (CAR |domainForm|)))
             (SETQ |key| (|opOf| |form|))
             (SETQ |entryList| (LASSOC |key| |opAlist|))
             (COND
              ((NOT
                (AND (CONSP |entryList|) (EQ (CDR |entryList|) NIL)
                     (PROGN
                      (SETQ |ISTMP#1| (CAR |entryList|))
                      (AND (CONSP |ISTMP#1|)
                           (PROGN
                            (SETQ |sig| (CAR |ISTMP#1|))
                            (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                            (AND (CONSP |ISTMP#2|)
                                 (PROGN
                                  (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                                  (AND (CONSP |ISTMP#3|)
                                       (PROGN
                                        (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                                        (AND (CONSP |ISTMP#4|)
                                             (EQ (CDR |ISTMP#4|) NIL)))))))))))
               (COND
                ((EQ |key| '|One|)
                 (|getConstantFromDomain| (LIST '|1|) |domainForm|))
                ((EQ |key| '|Zero|)
                 (|getConstantFromDomain| (LIST '|0|) |domainForm|))
                (#1# (|throwKeyedMsg| 'S2IC0008 (LIST |form| |domainForm|)))))
              (#1#
               (PROGN
                (SETQ |domain| (|evalDomain| |domainForm|))
                (SPADCALL (|compiledLookupCheck| |key| |sig| |domain|)))))))))))

; domainOne(domain) == getConstantFromDomain('(One),domain)

(DEFUN |domainOne| (|domain|)
  (PROG () (RETURN (|getConstantFromDomain| '(|One|) |domain|))))

; domainZero(domain) == getConstantFromDomain('(Zero),domain)

(DEFUN |domainZero| (|domain|)
  (PROG () (RETURN (|getConstantFromDomain| '(|Zero|) |domain|))))

; equalOne(object, domain) ==
;   -- tries using constant One and "=" from domain
;   -- object should not be wrapped
;   algEqual(object, getConstantFromDomain('(One),domain), domain)

(DEFUN |equalOne| (|object| |domain|)
  (PROG ()
    (RETURN
     (|algEqual| |object| (|getConstantFromDomain| '(|One|) |domain|)
      |domain|))))

; equalZero(object, domain) ==
;   -- tries using constant Zero and "=" from domain
;   -- object should not be wrapped
;   algEqual(object, getConstantFromDomain('(Zero),domain), domain)

(DEFUN |equalZero| (|object| |domain|)
  (PROG ()
    (RETURN
     (|algEqual| |object| (|getConstantFromDomain| '(|Zero|) |domain|)
      |domain|))))

; algEqual(object1, object2, domain) ==
;   -- sees if 2 objects of the same domain are equal by using the
;   -- "=" from the domain
;   -- objects should not be wrapped
; --  eqfunc := getFunctionFromDomain("=",domain,[domain,domain])
;   eqfunc := compiledLookupCheck("=",[$Boolean,'$,'$],evalDomain domain)
;   SPADCALL(object1,object2, eqfunc)

(DEFUN |algEqual| (|object1| |object2| |domain|)
  (PROG (|eqfunc|)
    (RETURN
     (PROGN
      (SETQ |eqfunc|
              (|compiledLookupCheck| '= (LIST |$Boolean| '$ '$)
               (|evalDomain| |domain|)))
      (SPADCALL |object1| |object2| |eqfunc|)))))

; canCoerce1(t1,t2) ==
;   -- general test for coercion
;   -- the result is NIL if it fails
;   t1 = t2 => true
;   absolutelyCanCoerceByCheating(t1,t2) or t1 = '(None) or t2 = '(Any) or
;     t1 in '((Mode) (Type) (Category)) =>
;       t2 = $OutputForm => true
;       NIL
;     -- next is for tagged union selectors for the time being
;     t1 is ['Variable,=t2] or t2 is ['Variable,=t1] => true
;     STRINGP t1 =>
;       t2 = $String => true
;       t2 = $OutputForm => true
;       t2 is ['Union,:.] => canCoerceUnion(t1,t2)
;       t2 is ['Variable,v] and (t1 = PNAME(v)) => true
;       NIL
;     STRINGP t2 =>
;       t1 is ['Variable,v] and (t2 = PNAME(v)) => true
;       NIL
;     atom t1 or atom t2 => NIL
;     null isValidType(t2) => NIL
;
;     absolutelyCannotCoerce(t1,t2) => NIL
;
;     nt1 := first t1
;     nt2 := first t2
;
;     EQ(nt1,'Mapping) => EQ(nt2,'Any)
;     EQ(nt2,'Mapping) =>
;       EQ(nt1,'Variable) or EQ(nt1,'FunctionCalled) =>
;         canCoerceExplicit2Mapping(t1,t2)
;       NIL
;     EQ(nt1,'Union) or EQ(nt2,'Union) => canCoerceUnion(t1,t2)
;
;     -- efficiency hack
;     t1 is ['Segment, s1] and t2 is ['UniversalSegment, s2] and
;         (isEqualOrSubDomain(s1, s2) or canCoerce(s1, s2)) => true
;
;     t1 is ['Tuple,S] and t2 ~= '(OutputForm) => canCoerce(['List, S], t2)
;
;     isRingT2 := ofCategory(t2,'(Ring))
;     isRingT2 and isEqualOrSubDomain(t1,$Integer) => true
;     (ans := canCoerceTopMatching(t1,t2,nt1,nt2)) ~= 'maybe => ans
;     t2 = $Integer => canCoerceLocal(t1,t2)   -- is true
;     ans := canCoerceTower(t1,t2) or
;       [.,:arg]:= deconstructT t2
;       arg and
;         t:= last arg
;         canCoerce(t1,t) and canCoerceByFunction(t,t2) and 'T
;     ans or (t1 in '((PositiveInteger) (NonNegativeInteger))
;       and canCoerce($Integer,t2))

(DEFUN |canCoerce1| (|t1| |t2|)
  (PROG (|ISTMP#1| |v| |nt1| |nt2| |s1| |s2| S |isRingT2| |ans| |LETTMP#1|
         |arg| |t|)
    (RETURN
     (COND ((EQUAL |t1| |t2|) T)
           (#1='T
            (OR (|absolutelyCanCoerceByCheating| |t1| |t2|)
                (EQUAL |t1| '(|None|)) (EQUAL |t2| '(|Any|))
                (COND
                 ((|member| |t1| '((|Mode|) (|Type|) (|Category|)))
                  (COND ((EQUAL |t2| |$OutputForm|) T) (#1# NIL)))
                 ((OR
                   (AND (CONSP |t1|) (EQ (CAR |t1|) '|Variable|)
                        (PROGN
                         (SETQ |ISTMP#1| (CDR |t1|))
                         (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                              (EQUAL (CAR |ISTMP#1|) |t2|))))
                   (AND (CONSP |t2|) (EQ (CAR |t2|) '|Variable|)
                        (PROGN
                         (SETQ |ISTMP#1| (CDR |t2|))
                         (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                              (EQUAL (CAR |ISTMP#1|) |t1|)))))
                  T)
                 ((STRINGP |t1|)
                  (COND ((EQUAL |t2| |$String|) T)
                        ((EQUAL |t2| |$OutputForm|) T)
                        ((AND (CONSP |t2|) (EQ (CAR |t2|) '|Union|))
                         (|canCoerceUnion| |t1| |t2|))
                        ((AND (CONSP |t2|) (EQ (CAR |t2|) '|Variable|)
                              (PROGN
                               (SETQ |ISTMP#1| (CDR |t2|))
                               (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                                    (PROGN (SETQ |v| (CAR |ISTMP#1|)) #1#)))
                              (EQUAL |t1| (PNAME |v|)))
                         T)
                        (#1# NIL)))
                 ((STRINGP |t2|)
                  (COND
                   ((AND (CONSP |t1|) (EQ (CAR |t1|) '|Variable|)
                         (PROGN
                          (SETQ |ISTMP#1| (CDR |t1|))
                          (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                               (PROGN (SETQ |v| (CAR |ISTMP#1|)) #1#)))
                         (EQUAL |t2| (PNAME |v|)))
                    T)
                   (#1# NIL)))
                 ((OR (ATOM |t1|) (ATOM |t2|)) NIL)
                 ((NULL (|isValidType| |t2|)) NIL)
                 ((|absolutelyCannotCoerce| |t1| |t2|) NIL)
                 (#1#
                  (PROGN
                   (SETQ |nt1| (CAR |t1|))
                   (SETQ |nt2| (CAR |t2|))
                   (COND ((EQ |nt1| '|Mapping|) (EQ |nt2| '|Any|))
                         ((EQ |nt2| '|Mapping|)
                          (COND
                           ((OR (EQ |nt1| '|Variable|)
                                (EQ |nt1| '|FunctionCalled|))
                            (|canCoerceExplicit2Mapping| |t1| |t2|))
                           (#1# NIL)))
                         ((OR (EQ |nt1| '|Union|) (EQ |nt2| '|Union|))
                          (|canCoerceUnion| |t1| |t2|))
                         ((AND (CONSP |t1|) (EQ (CAR |t1|) '|Segment|)
                               (PROGN
                                (SETQ |ISTMP#1| (CDR |t1|))
                                (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                                     (PROGN (SETQ |s1| (CAR |ISTMP#1|)) #1#)))
                               (CONSP |t2|) (EQ (CAR |t2|) '|UniversalSegment|)
                               (PROGN
                                (SETQ |ISTMP#1| (CDR |t2|))
                                (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                                     (PROGN (SETQ |s2| (CAR |ISTMP#1|)) #1#)))
                               (OR (|isEqualOrSubDomain| |s1| |s2|)
                                   (|canCoerce| |s1| |s2|)))
                          T)
                         ((AND (CONSP |t1|) (EQ (CAR |t1|) '|Tuple|)
                               (PROGN
                                (SETQ |ISTMP#1| (CDR |t1|))
                                (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                                     (PROGN (SETQ S (CAR |ISTMP#1|)) #1#)))
                               (NOT (EQUAL |t2| '(|OutputForm|))))
                          (|canCoerce| (LIST '|List| S) |t2|))
                         (#1#
                          (PROGN
                           (SETQ |isRingT2| (|ofCategory| |t2| '(|Ring|)))
                           (COND
                            ((AND |isRingT2|
                                  (|isEqualOrSubDomain| |t1| |$Integer|))
                             T)
                            ((NOT
                              (EQ
                               (SETQ |ans|
                                       (|canCoerceTopMatching| |t1| |t2| |nt1|
                                        |nt2|))
                               '|maybe|))
                             |ans|)
                            ((EQUAL |t2| |$Integer|)
                             (|canCoerceLocal| |t1| |t2|))
                            (#1#
                             (PROGN
                              (SETQ |ans|
                                      (OR (|canCoerceTower| |t1| |t2|)
                                          (PROGN
                                           (SETQ |LETTMP#1|
                                                   (|deconstructT| |t2|))
                                           (SETQ |arg| (CDR |LETTMP#1|))
                                           (AND |arg|
                                                (PROGN
                                                 (SETQ |t| (|last| |arg|))
                                                 (AND (|canCoerce| |t1| |t|)
                                                      (|canCoerceByFunction|
                                                       |t| |t2|)
                                                      'T))))))
                              (OR |ans|
                                  (AND
                                   (|member| |t1|
                                    '((|PositiveInteger|)
                                      (|NonNegativeInteger|)))
                                   (|canCoerce| |$Integer|
                                    |t2|))))))))))))))))))

; canCoerceFrom0(t1,t2) ==
; -- top level test for coercion, which transfers all RN, RF and RR into
; -- equivalent types
;   startTimingProcess 'querycoerce
;   q :=
;     isEqualOrSubDomain(t1,t2) or t1 = '(None) or t2 = '(Any) or
;
;       -- make sure we are trying to coerce to a legal type
;       -- in particular, polynomials are repeated, etc.
;       null isValidType(t2) => NIL
;       null isLegitimateMode(t2,nil,nil) => NIL
;
;       t1 = $RationalNumber =>
;         isEqualOrSubDomain(t2,$Integer) => NIL
;         canCoerce(t1, t2)
;       canCoerce(t1, t2)
;   stopTimingProcess 'querycoerce
;   q

(DEFUN |canCoerceFrom0| (|t1| |t2|)
  (PROG (|q|)
    (RETURN
     (PROGN
      (|startTimingProcess| '|querycoerce|)
      (SETQ |q|
              (OR (|isEqualOrSubDomain| |t1| |t2|) (EQUAL |t1| '(|None|))
                  (EQUAL |t2| '(|Any|))
                  (COND ((NULL (|isValidType| |t2|)) NIL)
                        ((NULL (|isLegitimateMode| |t2| NIL NIL)) NIL)
                        ((EQUAL |t1| |$RationalNumber|)
                         (COND ((|isEqualOrSubDomain| |t2| |$Integer|) NIL)
                               (#1='T (|canCoerce| |t1| |t2|))))
                        (#1# (|canCoerce| |t1| |t2|)))))
      (|stopTimingProcess| '|querycoerce|)
      |q|))))

; isSubTowerOf(t1,t2) ==
;   -- assumes RF and RN stuff has been expanded
;   -- tests whether t1 is somewhere inside t2
;   isEqualOrSubDomain(t1,t2) => true
;   null (u := underDomainOf t2) => nil
;   isSubTowerOf(t1,u)

(DEFUN |isSubTowerOf| (|t1| |t2|)
  (PROG (|u|)
    (RETURN
     (COND ((|isEqualOrSubDomain| |t1| |t2|) T)
           ((NULL (SETQ |u| (|underDomainOf| |t2|))) NIL)
           ('T (|isSubTowerOf| |t1| |u|))))))

; canCoerceTopMatching(t1,t2,tt1,tt2) ==
;   -- returns true, nil or maybe
;   -- for example, if t1 = P[x] D1 and t2 = P[y] D2 and x = y then
;   -- canCoerce will only be true if D1 = D2
;   not EQ(tt1,tt2) => 'maybe
;   doms := '(Polynomial List Matrix FiniteSet Vector Stream)
;   MEMQ(tt1,doms) => canCoerce(CADR t1, CADR t2)
;   not (MEMQ(tt1,$univariateDomains) or MEMQ(tt2,$multivariateDomains)) =>
;     'maybe
;   u2 := deconstructT t2
;   1 = #u2 => NIL
;   u1 := deconstructT t1
;   1 = #u1 => NIL                             -- no under domain
;   first(u1) ~= first(u2) => 'maybe
;   canCoerce(underDomainOf t1, underDomainOf t2)

(DEFUN |canCoerceTopMatching| (|t1| |t2| |tt1| |tt2|)
  (PROG (|doms| |u2| |u1|)
    (RETURN
     (COND ((NULL (EQ |tt1| |tt2|)) '|maybe|)
           (#1='T
            (PROGN
             (SETQ |doms|
                     '(|Polynomial| |List| |Matrix| |FiniteSet| |Vector|
                       |Stream|))
             (COND ((MEMQ |tt1| |doms|) (|canCoerce| (CADR |t1|) (CADR |t2|)))
                   ((NULL
                     (OR (MEMQ |tt1| |$univariateDomains|)
                         (MEMQ |tt2| |$multivariateDomains|)))
                    '|maybe|)
                   (#1#
                    (PROGN
                     (SETQ |u2| (|deconstructT| |t2|))
                     (COND ((EQL 1 (LENGTH |u2|)) NIL)
                           (#1#
                            (PROGN
                             (SETQ |u1| (|deconstructT| |t1|))
                             (COND ((EQL 1 (LENGTH |u1|)) NIL)
                                   ((NOT (EQUAL (CAR |u1|) (CAR |u2|)))
                                    '|maybe|)
                                   (#1#
                                    (|canCoerce| (|underDomainOf| |t1|)
                                     (|underDomainOf| |t2|))))))))))))))))

; canCoerceExplicit2Mapping(t1,t is ['Mapping,target,:argl]) ==
;   -- determines if there a mapping called var with the given args
;   -- and target
;   $useCoerceOrCroak: local := nil
;   t1 is ['Variable,var] =>
;     null (mms :=selectMms1(var,target,argl,[NIL for a in argl],true)) => NIL
;     mm := CAAR mms
;     mm is [., targ, :.] =>
;       targ = target => true
;       false
;     false
;   t1 is ['FunctionCalled,fun] =>
;     funNode := mkAtreeNode fun
;     transferPropsToNode(fun,funNode)
;     mms := CATCH('coerceOrCroaker, selectLocalMms(funNode,fun,argl,target))
;     CONSP mms =>
;       mms is [[['interpOnly,:.],:.]] => nil
;       mm := CAAR mms
;       mm is [., targ, :.] =>
;         targ = target => true
;         false
;       false
;     NIL
;   NIL

(DEFUN |canCoerceExplicit2Mapping| (|t1| |t|)
  (PROG (|$useCoerceOrCroak| |ISTMP#2| |funNode| |fun| |targ| |mm| |mms| |var|
         |ISTMP#1| |argl| |target|)
    (DECLARE (SPECIAL |$useCoerceOrCroak|))
    (RETURN
     (PROGN
      (SETQ |target| (CADR . #1=(|t|)))
      (SETQ |argl| (CDDR . #1#))
      (SETQ |$useCoerceOrCroak| NIL)
      (COND
       ((AND (CONSP |t1|) (EQ (CAR |t1|) '|Variable|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |t1|))
              (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                   (PROGN (SETQ |var| (CAR |ISTMP#1|)) #2='T))))
        (COND
         ((NULL
           (SETQ |mms|
                   (|selectMms1| |var| |target| |argl|
                    ((LAMBDA (|bfVar#5| |bfVar#4| |a|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#4|)
                              (PROGN (SETQ |a| (CAR |bfVar#4|)) NIL))
                          (RETURN (NREVERSE |bfVar#5|)))
                         (#2# (SETQ |bfVar#5| (CONS NIL |bfVar#5|))))
                        (SETQ |bfVar#4| (CDR |bfVar#4|))))
                     NIL |argl| NIL)
                    T)))
          NIL)
         (#2#
          (PROGN
           (SETQ |mm| (CAAR |mms|))
           (COND
            ((AND (CONSP |mm|)
                  (PROGN
                   (SETQ |ISTMP#1| (CDR |mm|))
                   (AND (CONSP |ISTMP#1|)
                        (PROGN (SETQ |targ| (CAR |ISTMP#1|)) #2#))))
             (COND ((EQUAL |targ| |target|) T) (#2# NIL)))
            (#2# NIL))))))
       ((AND (CONSP |t1|) (EQ (CAR |t1|) '|FunctionCalled|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |t1|))
              (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                   (PROGN (SETQ |fun| (CAR |ISTMP#1|)) #2#))))
        (PROGN
         (SETQ |funNode| (|mkAtreeNode| |fun|))
         (|transferPropsToNode| |fun| |funNode|)
         (SETQ |mms|
                 (CATCH '|coerceOrCroaker|
                   (|selectLocalMms| |funNode| |fun| |argl| |target|)))
         (COND
          ((CONSP |mms|)
           (COND
            ((AND (CONSP |mms|) (EQ (CDR |mms|) NIL)
                  (PROGN
                   (SETQ |ISTMP#1| (CAR |mms|))
                   (AND (CONSP |ISTMP#1|)
                        (PROGN
                         (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                         (AND (CONSP |ISTMP#2|)
                              (EQ (CAR |ISTMP#2|) '|interpOnly|))))))
             NIL)
            (#2#
             (PROGN
              (SETQ |mm| (CAAR |mms|))
              (COND
               ((AND (CONSP |mm|)
                     (PROGN
                      (SETQ |ISTMP#1| (CDR |mm|))
                      (AND (CONSP |ISTMP#1|)
                           (PROGN (SETQ |targ| (CAR |ISTMP#1|)) #2#))))
                (COND ((EQUAL |targ| |target|) T) (#2# NIL)))
               (#2# NIL))))))
          (#2# NIL))))
       (#2# NIL))))))

; canCoerceUnion(t1,t2) ==
;   -- sees if one can coerce to or from a Union Domain
;   -- assumes one of t1 and t2 is one
;
;   -- get the domains in the union, checking for tagged unions
;   if (isUnion1 := t1 is ['Union,:uds1]) then
;     unionDoms1 :=
;       uds1 and first uds1 is [":",:.] => [t for [.,.,t] in uds1]
;       uds1
;   if (isUnion2 := t2 is ['Union,:uds2]) then
;     unionDoms2 :=
;       uds2 and first uds2 is [":",:.] => [t for [.,.,t] in uds2]
;       uds2
;
;   isUnion2 =>
;     member(t1,unionDoms2) => true
;     isUnion1 =>
;       and/[or/[canCoerce(ud1,ud2) for ud2 in unionDoms2]
;         for ud1 in unionDoms1]
;     or/[canCoerce(t1,ud) for ud in unionDoms2]
;   -- next, a little lie
;   t1 is ['Union,d1, ='"failed"] and t2 = d1 => true
;   isUnion1 =>
;     and/[canCoerce(ud,t2) for ud in unionDoms1]
;   keyedSystemError("S2GE0016",['"canCoerceUnion",
;      '"called with 2 non-Unions"])

(DEFUN |canCoerceUnion| (|t1| |t2|)
  (PROG (|uds1| |isUnion1| |ISTMP#1| |ISTMP#2| |t| |unionDoms1| |uds2|
         |isUnion2| |unionDoms2| |d1|)
    (RETURN
     (PROGN
      (COND
       ((SETQ |isUnion1|
                (AND (CONSP |t1|) (EQ (CAR |t1|) '|Union|)
                     (PROGN (SETQ |uds1| (CDR |t1|)) #1='T)))
        (SETQ |unionDoms1|
                (COND
                 ((AND |uds1|
                       (PROGN
                        (SETQ |ISTMP#1| (CAR |uds1|))
                        (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|:|))))
                  ((LAMBDA (|bfVar#8| |bfVar#7| |bfVar#6|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#7|)
                            (PROGN (SETQ |bfVar#6| (CAR |bfVar#7|)) NIL))
                        (RETURN (NREVERSE |bfVar#8|)))
                       (#1#
                        (AND (CONSP |bfVar#6|)
                             (PROGN
                              (SETQ |ISTMP#1| (CDR |bfVar#6|))
                              (AND (CONSP |ISTMP#1|)
                                   (PROGN
                                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                    (AND (CONSP |ISTMP#2|)
                                         (EQ (CDR |ISTMP#2|) NIL)
                                         (PROGN
                                          (SETQ |t| (CAR |ISTMP#2|))
                                          #1#)))))
                             (SETQ |bfVar#8| (CONS |t| |bfVar#8|)))))
                      (SETQ |bfVar#7| (CDR |bfVar#7|))))
                   NIL |uds1| NIL))
                 (#1# |uds1|)))))
      (COND
       ((SETQ |isUnion2|
                (AND (CONSP |t2|) (EQ (CAR |t2|) '|Union|)
                     (PROGN (SETQ |uds2| (CDR |t2|)) #1#)))
        (SETQ |unionDoms2|
                (COND
                 ((AND |uds2|
                       (PROGN
                        (SETQ |ISTMP#1| (CAR |uds2|))
                        (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|:|))))
                  ((LAMBDA (|bfVar#11| |bfVar#10| |bfVar#9|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#10|)
                            (PROGN (SETQ |bfVar#9| (CAR |bfVar#10|)) NIL))
                        (RETURN (NREVERSE |bfVar#11|)))
                       (#1#
                        (AND (CONSP |bfVar#9|)
                             (PROGN
                              (SETQ |ISTMP#1| (CDR |bfVar#9|))
                              (AND (CONSP |ISTMP#1|)
                                   (PROGN
                                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                    (AND (CONSP |ISTMP#2|)
                                         (EQ (CDR |ISTMP#2|) NIL)
                                         (PROGN
                                          (SETQ |t| (CAR |ISTMP#2|))
                                          #1#)))))
                             (SETQ |bfVar#11| (CONS |t| |bfVar#11|)))))
                      (SETQ |bfVar#10| (CDR |bfVar#10|))))
                   NIL |uds2| NIL))
                 (#1# |uds2|)))))
      (COND
       (|isUnion2|
        (COND ((|member| |t1| |unionDoms2|) T)
              (|isUnion1|
               ((LAMBDA (|bfVar#15| |bfVar#14| |ud1|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#14|)
                         (PROGN (SETQ |ud1| (CAR |bfVar#14|)) NIL))
                     (RETURN |bfVar#15|))
                    (#1#
                     (PROGN
                      (SETQ |bfVar#15|
                              ((LAMBDA (|bfVar#13| |bfVar#12| |ud2|)
                                 (LOOP
                                  (COND
                                   ((OR (ATOM |bfVar#12|)
                                        (PROGN
                                         (SETQ |ud2| (CAR |bfVar#12|))
                                         NIL))
                                    (RETURN |bfVar#13|))
                                   (#1#
                                    (PROGN
                                     (SETQ |bfVar#13|
                                             (|canCoerce| |ud1| |ud2|))
                                     (COND (|bfVar#13| (RETURN |bfVar#13|))))))
                                  (SETQ |bfVar#12| (CDR |bfVar#12|))))
                               NIL |unionDoms2| NIL))
                      (COND ((NOT |bfVar#15|) (RETURN NIL))))))
                   (SETQ |bfVar#14| (CDR |bfVar#14|))))
                T |unionDoms1| NIL))
              (#1#
               ((LAMBDA (|bfVar#17| |bfVar#16| |ud|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#16|)
                         (PROGN (SETQ |ud| (CAR |bfVar#16|)) NIL))
                     (RETURN |bfVar#17|))
                    (#1#
                     (PROGN
                      (SETQ |bfVar#17| (|canCoerce| |t1| |ud|))
                      (COND (|bfVar#17| (RETURN |bfVar#17|))))))
                   (SETQ |bfVar#16| (CDR |bfVar#16|))))
                NIL |unionDoms2| NIL))))
       ((AND (CONSP |t1|) (EQ (CAR |t1|) '|Union|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |t1|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |d1| (CAR |ISTMP#1|))
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                         (EQUAL (CAR |ISTMP#2|) "failed")))))
             (EQUAL |t2| |d1|))
        T)
       (|isUnion1|
        ((LAMBDA (|bfVar#19| |bfVar#18| |ud|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#18|) (PROGN (SETQ |ud| (CAR |bfVar#18|)) NIL))
              (RETURN |bfVar#19|))
             (#1#
              (PROGN
               (SETQ |bfVar#19| (|canCoerce| |ud| |t2|))
               (COND ((NOT |bfVar#19|) (RETURN NIL))))))
            (SETQ |bfVar#18| (CDR |bfVar#18|))))
         T |unionDoms1| NIL))
       (#1#
        (|keyedSystemError| 'S2GE0016
         (LIST "canCoerceUnion" "called with 2 non-Unions"))))))))

; canCoerceByMap(t1,t2) ==
;   -- idea is this: if t1 is D U1 and t2 is D U2, then look for
;   -- map: (U1 -> U2, D U1) -> D U2.  If it exists, then answer true
;   -- if canCoerceFrom(t1,t2).
;   u2 := deconstructT t2
;   1 = #u2 => NIL
;   u1 := deconstructT t1
;   1 = #u1 => NIL                             -- no under domain
;   first(u1) ~= first(u2) => NIL
;   top := CAAR u1
;   u1 := underDomainOf t1
;   u2 := underDomainOf t2
;
;   absolutelyCannotCoerce(u1,u2) => NIL
;
;   -- save some time for those we know about
;   know := '(List Vector Segment Stream UniversalSegment Array
;     Polynomial UnivariatePolynomial SquareMatrix Matrix)
;   top in know => canCoerce(u1,u2)
;
;   null selectMms1('map,t2,[['Mapping,u2,u1],t1],
;     [['Mapping,u2,u1],u1],NIL) => NIL
;   -- don't bother checking for Undef, so avoid instantiation
;   canCoerce(u1,u2)

(DEFUN |canCoerceByMap| (|t1| |t2|)
  (PROG (|u2| |u1| |top| |know|)
    (RETURN
     (PROGN
      (SETQ |u2| (|deconstructT| |t2|))
      (COND ((EQL 1 (LENGTH |u2|)) NIL)
            (#1='T
             (PROGN
              (SETQ |u1| (|deconstructT| |t1|))
              (COND ((EQL 1 (LENGTH |u1|)) NIL)
                    ((NOT (EQUAL (CAR |u1|) (CAR |u2|))) NIL)
                    (#1#
                     (PROGN
                      (SETQ |top| (CAAR |u1|))
                      (SETQ |u1| (|underDomainOf| |t1|))
                      (SETQ |u2| (|underDomainOf| |t2|))
                      (COND ((|absolutelyCannotCoerce| |u1| |u2|) NIL)
                            (#1#
                             (PROGN
                              (SETQ |know|
                                      '(|List| |Vector| |Segment| |Stream|
                                        |UniversalSegment| |Array| |Polynomial|
                                        |UnivariatePolynomial| |SquareMatrix|
                                        |Matrix|))
                              (COND
                               ((|member| |top| |know|)
                                (|canCoerce| |u1| |u2|))
                               ((NULL
                                 (|selectMms1| '|map| |t2|
                                  (LIST (LIST '|Mapping| |u2| |u1|) |t1|)
                                  (LIST (LIST '|Mapping| |u2| |u1|) |u1|) NIL))
                                NIL)
                               (#1# (|canCoerce| |u1| |u2|))))))))))))))))

; canCoerceTower(t1,t2) ==
; -- tries to find a coercion between top level t2 and somewhere inside t1
; -- builds new bubbled type, for which coercion is called recursively
;   canCoerceByMap(t1,t2) or newCanCoerceCommute(t1,t2) or
;    canCoerceLocal(t1,t2) or canCoercePermute(t1,t2) or
;     [c1,:arg1]:= deconstructT t1
;     arg1 and
;       TL:= NIL
;       arg:= arg1
;       until x or not arg repeat x:=
;         t:= last arg
;         [c,:arg]:= deconstructT t
;         TL:= [c,arg,:TL]
;         arg and coerceIntTest(t,t2) and
;           CDDR TL =>
;             s := constructM(c1, replaceLast(arg1, bubbleConstructor TL))
;             canCoerceLocal(t1,s) and
;               [c2,:arg2]:= deconstructT last s
;               s1:= bubbleConstructor [c2,arg2,c1,arg1]
;               canCoerceCommute(s,s1) and canCoerceLocal(s1,t2)
;           s:= bubbleConstructor [c,arg,c1,arg1]
;           newCanCoerceCommute(t1,s) and canCoerceLocal(s,t2)
;       x

(DEFUN |canCoerceTower| (|t1| |t2|)
  (PROG (|LETTMP#1| |c1| |arg1| TL |arg| |t| |c| |s| |c2| |arg2| |s1| |x|)
    (RETURN
     (OR (|canCoerceByMap| |t1| |t2|) (|newCanCoerceCommute| |t1| |t2|)
         (|canCoerceLocal| |t1| |t2|) (|canCoercePermute| |t1| |t2|)
         (PROGN
          (SETQ |LETTMP#1| (|deconstructT| |t1|))
          (SETQ |c1| (CAR |LETTMP#1|))
          (SETQ |arg1| (CDR |LETTMP#1|))
          (AND |arg1|
               (PROGN
                (SETQ TL NIL)
                (SETQ |arg| |arg1|)
                ((LAMBDA (|bfVar#20|)
                   (LOOP
                    (COND (|bfVar#20| (RETURN NIL))
                          (#1='T
                           (SETQ |x|
                                   (PROGN
                                    (SETQ |t| (|last| |arg|))
                                    (SETQ |LETTMP#1| (|deconstructT| |t|))
                                    (SETQ |c| (CAR |LETTMP#1|))
                                    (SETQ |arg| (CDR |LETTMP#1|))
                                    (SETQ TL (CONS |c| (CONS |arg| TL)))
                                    (AND |arg| (|coerceIntTest| |t| |t2|)
                                         (COND
                                          ((CDDR TL)
                                           (PROGN
                                            (SETQ |s|
                                                    (|constructM| |c1|
                                                     (|replaceLast| |arg1|
                                                      (|bubbleConstructor|
                                                       TL))))
                                            (AND (|canCoerceLocal| |t1| |s|)
                                                 (PROGN
                                                  (SETQ |LETTMP#1|
                                                          (|deconstructT|
                                                           (|last| |s|)))
                                                  (SETQ |c2| (CAR |LETTMP#1|))
                                                  (SETQ |arg2|
                                                          (CDR |LETTMP#1|))
                                                  (SETQ |s1|
                                                          (|bubbleConstructor|
                                                           (LIST |c2| |arg2|
                                                                 |c1| |arg1|)))
                                                  (AND
                                                   (|canCoerceCommute| |s|
                                                    |s1|)
                                                   (|canCoerceLocal| |s1|
                                                    |t2|))))))
                                          (#1#
                                           (PROGN
                                            (SETQ |s|
                                                    (|bubbleConstructor|
                                                     (LIST |c| |arg| |c1|
                                                           |arg1|)))
                                            (AND
                                             (|newCanCoerceCommute| |t1| |s|)
                                             (|canCoerceLocal| |s|
                                              |t2|))))))))))
                    (SETQ |bfVar#20| (OR |x| (NULL |arg|)))))
                 NIL)
                |x|)))))))

; canCoerceLocal(t1,t2) ==
;   -- test for coercion on top level
;   p := ASSQ(first t1, $CoerceTable)
;   p and ASSQ(first t2, rest p) is [., :[tag, fun]] =>
;     tag='partial => NIL
;     tag='total   => true
;     (functionp(fun) and
;        (v:=CATCH('coerceFailure,FUNCALL(fun,'_$fromCoerceable_$,t1,t2)))
;          and v ~= $coerceFailure)  or  canCoerceByFunction(t1,t2)
;   canCoerceByFunction(t1,t2)

(DEFUN |canCoerceLocal| (|t1| |t2|)
  (PROG (|p| |ISTMP#1| |ISTMP#2| |tag| |ISTMP#3| |fun| |v|)
    (RETURN
     (PROGN
      (SETQ |p| (ASSQ (CAR |t1|) |$CoerceTable|))
      (COND
       ((AND |p|
             (PROGN
              (SETQ |ISTMP#1| (ASSQ (CAR |t2|) (CDR |p|)))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|)
                         (PROGN
                          (SETQ |tag| (CAR |ISTMP#2|))
                          (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                          (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                               (PROGN
                                (SETQ |fun| (CAR |ISTMP#3|))
                                #1='T))))))))
        (COND ((EQ |tag| '|partial|) NIL) ((EQ |tag| '|total|) T)
              (#1#
               (OR
                (AND (|functionp| |fun|)
                     (SETQ |v|
                             (CATCH '|coerceFailure|
                               (FUNCALL |fun| '|$fromCoerceable$| |t1| |t2|)))
                     (NOT (EQUAL |v| |$coerceFailure|)))
                (|canCoerceByFunction| |t1| |t2|)))))
       (#1# (|canCoerceByFunction| |t1| |t2|)))))))

; canCoerceCommute(t1,t2) ==
; -- THIS IS OUT-MODED AND WILL GO AWAY SOON  RSS 2-87
; -- t1 is t2 with the two top level constructors commuted
; -- looks for the existence of a commuting function
;   p := ASSQ(first t1, $CommuteTable)
;   p and ASSQ(first t2, rest p) is [., :['commute, .]]

(DEFUN |canCoerceCommute| (|t1| |t2|)
  (PROG (|p| |ISTMP#1| |ISTMP#2| |ISTMP#3|)
    (RETURN
     (PROGN
      (SETQ |p| (ASSQ (CAR |t1|) |$CommuteTable|))
      (AND |p|
           (PROGN
            (SETQ |ISTMP#1| (ASSQ (CAR |t2|) (CDR |p|)))
            (AND (CONSP |ISTMP#1|)
                 (PROGN
                  (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                  (AND (CONSP |ISTMP#2|) (EQ (CAR |ISTMP#2|) '|commute|)
                       (PROGN
                        (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                        (AND (CONSP |ISTMP#3|)
                             (EQ (CDR |ISTMP#3|) NIL))))))))))))

; newCanCoerceCommute(t1,t2) ==
;   coerceIntCommute(objNewWrap("$fromCoerceable$",t1),t2)

(DEFUN |newCanCoerceCommute| (|t1| |t2|)
  (PROG ()
    (RETURN (|coerceIntCommute| (|objNewWrap| '|$fromCoerceable$| |t1|) |t2|))))

; canCoercePermute(t1,t2) ==
;   -- try to generate a sequence of transpositions that will convert
;   -- t1 into t2
;   t2 in '((Integer) (OutputForm)) => NIL
;   towers := computeTTTranspositions(t1,t2)
;   -- at this point, first towers = t1 and last towers should be similar
;   -- to t2 in the sense that the components of t1 are in the same order
;   -- as in t2. If length towers = 2 and t2 = last towers, we quit to
;   -- avoid an infinite loop.
;   NULL towers or NULL rest towers => NIL
;   NULL CDDR towers and t2 = CADR towers => NIL
;   -- do the coercions successively, quitting if any fail
;   ok := true
;   for t in rest towers while ok repeat
;     ok := canCoerce(t1,t)
;     if ok then t1 := t
;   ok

(DEFUN |canCoercePermute| (|t1| |t2|)
  (PROG (|towers| |ok|)
    (RETURN
     (COND ((|member| |t2| '((|Integer|) (|OutputForm|))) NIL)
           (#1='T
            (PROGN
             (SETQ |towers| (|computeTTTranspositions| |t1| |t2|))
             (COND ((OR (NULL |towers|) (NULL (CDR |towers|))) NIL)
                   ((AND (NULL (CDDR |towers|)) (EQUAL |t2| (CADR |towers|)))
                    NIL)
                   (#1#
                    (PROGN
                     (SETQ |ok| T)
                     ((LAMBDA (|bfVar#21| |t|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#21|)
                               (PROGN (SETQ |t| (CAR |bfVar#21|)) NIL)
                               (NOT |ok|))
                           (RETURN NIL))
                          (#1#
                           (PROGN
                            (SETQ |ok| (|canCoerce| |t1| |t|))
                            (COND (|ok| (SETQ |t1| |t|))))))
                         (SETQ |bfVar#21| (CDR |bfVar#21|))))
                      (CDR |towers|) NIL)
                     |ok|)))))))))

; canConvertByFunction(m1,m2) ==
;   null $useConvertForCoercions => NIL
;   canCoerceByFunction1(m1,m2,'convert)

(DEFUN |canConvertByFunction| (|m1| |m2|)
  (PROG ()
    (RETURN
     (COND ((NULL |$useConvertForCoercions|) NIL)
           ('T (|canCoerceByFunction1| |m1| |m2| '|convert|))))))

; canCoerceByFunction(m1,m2) == canCoerceByFunction1(m1,m2,'coerce)

(DEFUN |canCoerceByFunction| (|m1| |m2|)
  (PROG () (RETURN (|canCoerceByFunction1| |m1| |m2| '|coerce|))))

; canCoerceByFunction1(m1,m2,fun) ==
;   -- calls selectMms with $Coerce=NIL and tests for required target=m2
;   $declaredMode:local:= NIL
;   $reportBottomUpFlag:local:= NIL
;   l := selectMms1(fun, m2, [m1], [m1], NIL)
;   [x for x in l | x is [sig,:.] and CADR sig = m2 and
;       CADDR sig = m1] and true

(DEFUN |canCoerceByFunction1| (|m1| |m2| |fun|)
  (PROG (|$reportBottomUpFlag| |$declaredMode| |sig| |l|)
    (DECLARE (SPECIAL |$reportBottomUpFlag| |$declaredMode|))
    (RETURN
     (PROGN
      (SETQ |$declaredMode| NIL)
      (SETQ |$reportBottomUpFlag| NIL)
      (SETQ |l| (|selectMms1| |fun| |m2| (LIST |m1|) (LIST |m1|) NIL))
      (AND
       ((LAMBDA (|bfVar#23| |bfVar#22| |x|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#22|) (PROGN (SETQ |x| (CAR |bfVar#22|)) NIL))
             (RETURN (NREVERSE |bfVar#23|)))
            (#1='T
             (AND (CONSP |x|) (PROGN (SETQ |sig| (CAR |x|)) #1#)
                  (EQUAL (CADR |sig|) |m2|) (EQUAL (CADDR |sig|) |m1|)
                  (SETQ |bfVar#23| (CONS |x| |bfVar#23|)))))
           (SETQ |bfVar#22| (CDR |bfVar#22|))))
        NIL |l| NIL)
       T)))))

; absolutelyCanCoerceByCheating(t1,t2) ==
;   -- this typically involves subdomains and towers where the only
;   -- difference is a subdomain
;   isEqualOrSubDomain(t1,t2) => true
;   typeIsASmallInteger(t1) and t2 = $Integer => true
;   ATOM(t1) or ATOM(t2) => false
;   [tl1,:u1] := deconstructT t1
;   [tl2,:u2] := deconstructT t2
;   tl1 = '(Stream) and tl2 = '(InfiniteTuple) =>
;     #u1 ~= #u2 => false
;     "and"/[absolutelyCanCoerceByCheating(x1,x2) for x1 in u1 for x2 in u2]
;   tl1 ~= tl2 => false
;   #u1 ~= #u2 => false
;   "and"/[absolutelyCanCoerceByCheating(x1,x2) for x1 in u1 for x2 in u2]

(DEFUN |absolutelyCanCoerceByCheating| (|t1| |t2|)
  (PROG (|LETTMP#1| |tl1| |u1| |tl2| |u2|)
    (RETURN
     (COND ((|isEqualOrSubDomain| |t1| |t2|) T)
           ((AND (|typeIsASmallInteger| |t1|) (EQUAL |t2| |$Integer|)) T)
           ((OR (ATOM |t1|) (ATOM |t2|)) NIL)
           (#1='T
            (PROGN
             (SETQ |LETTMP#1| (|deconstructT| |t1|))
             (SETQ |tl1| (CAR |LETTMP#1|))
             (SETQ |u1| (CDR |LETTMP#1|))
             (SETQ |LETTMP#1| (|deconstructT| |t2|))
             (SETQ |tl2| (CAR |LETTMP#1|))
             (SETQ |u2| (CDR |LETTMP#1|))
             (COND
              ((AND (EQUAL |tl1| '(|Stream|)) (EQUAL |tl2| '(|InfiniteTuple|)))
               (COND ((NOT (EQL (LENGTH |u1|) (LENGTH |u2|))) NIL)
                     (#1#
                      ((LAMBDA (|bfVar#26| |bfVar#24| |x1| |bfVar#25| |x2|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#24|)
                                (PROGN (SETQ |x1| (CAR |bfVar#24|)) NIL)
                                (ATOM |bfVar#25|)
                                (PROGN (SETQ |x2| (CAR |bfVar#25|)) NIL))
                            (RETURN |bfVar#26|))
                           (#1#
                            (PROGN
                             (SETQ |bfVar#26|
                                     (|absolutelyCanCoerceByCheating| |x1|
                                      |x2|))
                             (COND ((NOT |bfVar#26|) (RETURN NIL))))))
                          (SETQ |bfVar#24| (CDR |bfVar#24|))
                          (SETQ |bfVar#25| (CDR |bfVar#25|))))
                       T |u1| NIL |u2| NIL))))
              ((NOT (EQUAL |tl1| |tl2|)) NIL)
              ((NOT (EQL (LENGTH |u1|) (LENGTH |u2|))) NIL)
              (#1#
               ((LAMBDA (|bfVar#29| |bfVar#27| |x1| |bfVar#28| |x2|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#27|)
                         (PROGN (SETQ |x1| (CAR |bfVar#27|)) NIL)
                         (ATOM |bfVar#28|)
                         (PROGN (SETQ |x2| (CAR |bfVar#28|)) NIL))
                     (RETURN |bfVar#29|))
                    (#1#
                     (PROGN
                      (SETQ |bfVar#29|
                              (|absolutelyCanCoerceByCheating| |x1| |x2|))
                      (COND ((NOT |bfVar#29|) (RETURN NIL))))))
                   (SETQ |bfVar#27| (CDR |bfVar#27|))
                   (SETQ |bfVar#28| (CDR |bfVar#28|))))
                T |u1| NIL |u2| NIL)))))))))

; absolutelyCannotCoerce(t1,t2) ==
;   -- response of true means "definitely cannot coerce"
;   -- this is largely an efficiency hack
;   ATOM(t1) or ATOM(t2) => NIL
;   t2 = '(None) => true
;   n1   := first t1
;   n2   := first t2
;   QFI  := [$QuotientField, $Integer]
;   int2 := isEqualOrSubDomain(t2,$Integer)
;   scalars := '(Float DoubleFloat)
;
;   MEMQ(n1,scalars) and int2 => true
;   (t1 = QFI) and int2       => true
;
;   num2 := int2 or MEMQ(n2,scalars) or (t2 = QFI)
;   isVar1 := MEMQ(n1,'(Variable Symbol))
;
;   num2 and isVar1 => true
;   num2 and MEMQ(n1,$univariateDomains) => true
;   num2 and MEMQ(n1,$multivariateDomains) => true
;   miscpols :=  '(Polynomial SimpleAlgebraicExtension)
;   num2 and MEMQ(n1,miscpols) => true
;
;   aggs :=  '(
;     Matrix List Vector Stream Array RectangularMatrix FiniteSet
;        )
;   u1 := underDomainOf t1
;   u2 := underDomainOf t2
;   MEMQ(n1,aggs) and (u1 = t2) => true
;   MEMQ(n2,aggs) and (u2 = t1) => true
;
;   algs :=  '(
;     SquareMatrix RectangularMatrix Quaternion
;        )
;   nonpols := append(aggs,algs)
;   num2 and MEMQ(n1,nonpols) => true
;   isVar1 and MEMQ(n2,nonpols) and
;     absolutelyCannotCoerce(t1,u2) => true
;
;   (MEMQ(n1,scalars) or (t1 = QFI)) and (t2 = '(Polynomial (Integer))) =>
;     true
;
;   v2 := deconstructT t2
;   1 = #v2 => NIL
;   v1 := deconstructT t1
;   1 = #v1 => NIL
;   first(v1) ~= first(v2) => NIL
;   absolutelyCannotCoerce(u1,u2)

(DEFUN |absolutelyCannotCoerce| (|t1| |t2|)
  (PROG (|n1| |n2| QFI |int2| |scalars| |num2| |isVar1| |miscpols| |aggs| |u1|
         |u2| |algs| |nonpols| |v2| |v1|)
    (RETURN
     (COND ((OR (ATOM |t1|) (ATOM |t2|)) NIL) ((EQUAL |t2| '(|None|)) T)
           (#1='T
            (PROGN
             (SETQ |n1| (CAR |t1|))
             (SETQ |n2| (CAR |t2|))
             (SETQ QFI (LIST |$QuotientField| |$Integer|))
             (SETQ |int2| (|isEqualOrSubDomain| |t2| |$Integer|))
             (SETQ |scalars| '(|Float| |DoubleFloat|))
             (COND ((AND (MEMQ |n1| |scalars|) |int2|) T)
                   ((AND (EQUAL |t1| QFI) |int2|) T)
                   (#1#
                    (PROGN
                     (SETQ |num2|
                             (OR |int2| (MEMQ |n2| |scalars|)
                                 (EQUAL |t2| QFI)))
                     (SETQ |isVar1| (MEMQ |n1| '(|Variable| |Symbol|)))
                     (COND ((AND |num2| |isVar1|) T)
                           ((AND |num2| (MEMQ |n1| |$univariateDomains|)) T)
                           ((AND |num2| (MEMQ |n1| |$multivariateDomains|)) T)
                           (#1#
                            (PROGN
                             (SETQ |miscpols|
                                     '(|Polynomial|
                                       |SimpleAlgebraicExtension|))
                             (COND ((AND |num2| (MEMQ |n1| |miscpols|)) T)
                                   (#1#
                                    (PROGN
                                     (SETQ |aggs|
                                             '(|Matrix| |List| |Vector|
                                               |Stream| |Array|
                                               |RectangularMatrix|
                                               |FiniteSet|))
                                     (SETQ |u1| (|underDomainOf| |t1|))
                                     (SETQ |u2| (|underDomainOf| |t2|))
                                     (COND
                                      ((AND (MEMQ |n1| |aggs|)
                                            (EQUAL |u1| |t2|))
                                       T)
                                      ((AND (MEMQ |n2| |aggs|)
                                            (EQUAL |u2| |t1|))
                                       T)
                                      (#1#
                                       (PROGN
                                        (SETQ |algs|
                                                '(|SquareMatrix|
                                                  |RectangularMatrix|
                                                  |Quaternion|))
                                        (SETQ |nonpols| (APPEND |aggs| |algs|))
                                        (COND
                                         ((AND |num2| (MEMQ |n1| |nonpols|)) T)
                                         ((AND |isVar1| (MEMQ |n2| |nonpols|)
                                               (|absolutelyCannotCoerce| |t1|
                                                |u2|))
                                          T)
                                         ((AND
                                           (OR (MEMQ |n1| |scalars|)
                                               (EQUAL |t1| QFI))
                                           (EQUAL |t2|
                                                  '(|Polynomial| (|Integer|))))
                                          T)
                                         (#1#
                                          (PROGN
                                           (SETQ |v2| (|deconstructT| |t2|))
                                           (COND ((EQL 1 (LENGTH |v2|)) NIL)
                                                 (#1#
                                                  (PROGN
                                                   (SETQ |v1|
                                                           (|deconstructT|
                                                            |t1|))
                                                   (COND
                                                    ((EQL 1 (LENGTH |v1|)) NIL)
                                                    ((NOT
                                                      (EQUAL (CAR |v1|)
                                                             (CAR |v2|)))
                                                     NIL)
                                                    (#1#
                                                     (|absolutelyCannotCoerce|
                                                      |u1|
                                                      |u2|)))))))))))))))))))))))))))

; typeIsASmallInteger x == (x = $SingleInteger)

(DEFUN |typeIsASmallInteger| (|x|)
  (PROG () (RETURN (EQUAL |x| |$SingleInteger|))))

; typeToInputForm(t) == typeToForm(t, '(InputForm))

(DEFUN |typeToInputForm| (|t|)
  (PROG () (RETURN (|typeToForm| |t| '(|InputForm|)))))

; typeToOutputForm(t) == typeToForm(t, $OutputForm)

(DEFUN |typeToOutputForm| (|t|)
  (PROG () (RETURN (|typeToForm| |t| |$OutputForm|))))

; typeToForm(t, toForm) ==
;     t0 := devaluate(t)
;     [op,:argl] := t0
;     coSig := rest GETDATABASE(op, 'COSIG)
;     sig := getConstructorSignature t0
;     ml := replaceSharps(rest sig, t0)
;     nl := [fn(x, t1, c, toForm) for x in argl for t1 in ml_
;                                 for c in coSig] where
;         fn(x, t1, c, toForm) ==
;             c => typeToForm(x, toForm)
;             algCoerceInteractive(x, t1, toForm)
;     [op, :nl]

(DEFUN |typeToForm| (|t| |toForm|)
  (PROG (|t0| |op| |argl| |coSig| |sig| |ml| |nl|)
    (RETURN
     (PROGN
      (SETQ |t0| (|devaluate| |t|))
      (SETQ |op| (CAR |t0|))
      (SETQ |argl| (CDR |t0|))
      (SETQ |coSig| (CDR (GETDATABASE |op| 'COSIG)))
      (SETQ |sig| (|getConstructorSignature| |t0|))
      (SETQ |ml| (|replaceSharps| (CDR |sig|) |t0|))
      (SETQ |nl|
              ((LAMBDA
                   (|bfVar#33| |bfVar#30| |x| |bfVar#31| |t1| |bfVar#32| |c|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#30|)
                        (PROGN (SETQ |x| (CAR |bfVar#30|)) NIL)
                        (ATOM |bfVar#31|)
                        (PROGN (SETQ |t1| (CAR |bfVar#31|)) NIL)
                        (ATOM |bfVar#32|)
                        (PROGN (SETQ |c| (CAR |bfVar#32|)) NIL))
                    (RETURN (NREVERSE |bfVar#33|)))
                   ('T
                    (SETQ |bfVar#33|
                            (CONS (|typeToForm,fn| |x| |t1| |c| |toForm|)
                                  |bfVar#33|))))
                  (SETQ |bfVar#30| (CDR |bfVar#30|))
                  (SETQ |bfVar#31| (CDR |bfVar#31|))
                  (SETQ |bfVar#32| (CDR |bfVar#32|))))
               NIL |argl| NIL |ml| NIL |coSig| NIL))
      (CONS |op| |nl|)))))
(DEFUN |typeToForm,fn| (|x| |t1| |c| |toForm|)
  (PROG ()
    (RETURN
     (COND (|c| (|typeToForm| |x| |toForm|))
           ('T (|algCoerceInteractive| |x| |t1| |toForm|))))))

; coerceInteractive(triple,t2) ==
;   -- bind flag for recording/reporting instantiations
;   -- (see recordInstantiation)
;   t1 := objMode triple
;   val := objVal triple
;   null(t2) or t2 = $EmptyMode => NIL
;   t2 = t1 => triple
;   t2 = '$NoValueMode => objNew(val,t2)
;   if t2 is ['SubDomain,x,.] then t2:= x
;   -- JHD added category Aug 1996 for BasicMath
;   t1 in '((Category) (Mode) (Type)) =>
;     t2 = $OutputForm => objNewWrap(typeToOutputForm(val), t2)
;     t2 = '(InputForm) => objNewWrap(typeToInputForm(val), t2)
;     NIL
;   t1 = '$NoValueMode =>
;     if $compilingMap then clearDependentMaps($mapName,nil)
;     throwKeyedMsg("S2IC0009",[t2,$mapName])
;   $insideCoerceInteractive: local := true
;   expr2 := EQUAL(t2,$OutputForm)
;   if expr2 then startTimingProcess 'print
;   else startTimingProcess 'coercion
;   -- next 2 lines handle cases like '"failed"
;   result :=
;     expr2 and t1 is ['Variable,var] => objNewWrap(var,$OutputForm)
;     coerceInt0(triple,t2)
;   if expr2 then stopTimingProcess 'print
;   else stopTimingProcess 'coercion
;   result

(DEFUN |coerceInteractive| (|triple| |t2|)
  (PROG (|$insideCoerceInteractive| |result| |var| |expr2| |ISTMP#2| |x|
         |ISTMP#1| |val| |t1|)
    (DECLARE (SPECIAL |$insideCoerceInteractive|))
    (RETURN
     (PROGN
      (SETQ |t1| (|objMode| |triple|))
      (SETQ |val| (|objVal| |triple|))
      (COND ((OR (NULL |t2|) (EQUAL |t2| |$EmptyMode|)) NIL)
            ((EQUAL |t2| |t1|) |triple|)
            ((EQ |t2| '|$NoValueMode|) (|objNew| |val| |t2|))
            (#1='T
             (PROGN
              (COND
               ((AND (CONSP |t2|) (EQ (CAR |t2|) '|SubDomain|)
                     (PROGN
                      (SETQ |ISTMP#1| (CDR |t2|))
                      (AND (CONSP |ISTMP#1|)
                           (PROGN
                            (SETQ |x| (CAR |ISTMP#1|))
                            (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                            (AND (CONSP |ISTMP#2|)
                                 (EQ (CDR |ISTMP#2|) NIL))))))
                (SETQ |t2| |x|)))
              (COND
               ((|member| |t1| '((|Category|) (|Mode|) (|Type|)))
                (COND
                 ((EQUAL |t2| |$OutputForm|)
                  (|objNewWrap| (|typeToOutputForm| |val|) |t2|))
                 ((EQUAL |t2| '(|InputForm|))
                  (|objNewWrap| (|typeToInputForm| |val|) |t2|))
                 (#1# NIL)))
               ((EQ |t1| '|$NoValueMode|)
                (PROGN
                 (COND (|$compilingMap| (|clearDependentMaps| |$mapName| NIL)))
                 (|throwKeyedMsg| 'S2IC0009 (LIST |t2| |$mapName|))))
               (#1#
                (PROGN
                 (SETQ |$insideCoerceInteractive| T)
                 (SETQ |expr2| (EQUAL |t2| |$OutputForm|))
                 (COND (|expr2| (|startTimingProcess| '|print|))
                       (#1# (|startTimingProcess| '|coercion|)))
                 (SETQ |result|
                         (COND
                          ((AND |expr2| (CONSP |t1|)
                                (EQ (CAR |t1|) '|Variable|)
                                (PROGN
                                 (SETQ |ISTMP#1| (CDR |t1|))
                                 (AND (CONSP |ISTMP#1|)
                                      (EQ (CDR |ISTMP#1|) NIL)
                                      (PROGN
                                       (SETQ |var| (CAR |ISTMP#1|))
                                       #1#))))
                           (|objNewWrap| |var| |$OutputForm|))
                          (#1# (|coerceInt0| |triple| |t2|))))
                 (COND (|expr2| (|stopTimingProcess| '|print|))
                       (#1# (|stopTimingProcess| '|coercion|)))
                 |result|))))))))))

; coerceInt0(triple,t2) ==
;   -- top level interactive coercion, which transfers all RN, RF and RR
;   -- into equivalent types
;   val := objVal triple
;   t1  := objMode triple
;
;   val='_$fromCoerceable_$ => canCoerceFrom(t1,t2)
;   t1 = t2 => triple
;   -- t1 is ['Mapping,:.] and t2 ~= '(Any) => NIL
;   -- note: may be able to coerce TO mapping
;   -- treat Exit like Any
;   -- handle case where we must generate code
;   null(isWrapped val) and
;     (t1 isnt ['FunctionCalled,:.] or not $genValue)=>
;       intCodeGenCOERCE(triple,t2)
;   t1 = $Any and t2 ~= $OutputForm and ([t1',:val'] := unwrap val) and
;     (ans := coerceInt0(objNewWrap(val',t1'),t2)) => ans
;   x := coerceInt(triple, t2) => x
;   NIL

(DEFUN |coerceInt0| (|triple| |t2|)
  (PROG (|val| |t1| |LETTMP#1| |t1'| |val'| |ans| |x|)
    (RETURN
     (PROGN
      (SETQ |val| (|objVal| |triple|))
      (SETQ |t1| (|objMode| |triple|))
      (COND ((EQ |val| '|$fromCoerceable$|) (|canCoerceFrom| |t1| |t2|))
            ((EQUAL |t1| |t2|) |triple|)
            ((AND (NULL (|isWrapped| |val|))
                  (OR
                   (NOT (AND (CONSP |t1|) (EQ (CAR |t1|) '|FunctionCalled|)))
                   (NULL |$genValue|)))
             (|intCodeGenCOERCE| |triple| |t2|))
            ((AND (EQUAL |t1| |$Any|) (NOT (EQUAL |t2| |$OutputForm|))
                  (PROGN
                   (SETQ |LETTMP#1| (|unwrap| |val|))
                   (SETQ |t1'| (CAR |LETTMP#1|))
                   (SETQ |val'| (CDR |LETTMP#1|))
                   |LETTMP#1|)
                  (SETQ |ans| (|coerceInt0| (|objNewWrap| |val'| |t1'|) |t2|)))
             |ans|)
            ((SETQ |x| (|coerceInt| |triple| |t2|)) |x|) ('T NIL))))))

; coerceInt(triple, t2) ==
;   val := coerceInt1(triple, t2) => val
;   t1 := objMode triple
;   t1 is ['Variable, :.] =>
;     newMode := getMinimalVarMode(unwrap objVal triple, nil)
;     newVal := coerceInt(triple, newMode)
;     coerceInt(newVal, t2)
;   nil

(DEFUN |coerceInt| (|triple| |t2|)
  (PROG (|val| |t1| |newMode| |newVal|)
    (RETURN
     (COND ((SETQ |val| (|coerceInt1| |triple| |t2|)) |val|)
           (#1='T
            (PROGN
             (SETQ |t1| (|objMode| |triple|))
             (COND
              ((AND (CONSP |t1|) (EQ (CAR |t1|) '|Variable|))
               (PROGN
                (SETQ |newMode|
                        (|getMinimalVarMode| (|unwrap| (|objVal| |triple|))
                         NIL))
                (SETQ |newVal| (|coerceInt| |triple| |newMode|))
                (|coerceInt| |newVal| |t2|)))
              (#1# NIL))))))))

; coerceInt1(triple,t2) ==
;   -- general interactive coercion
;   -- the result is a new triple with type m2 or NIL (= failed)
;   $useCoerceOrCroak: local := true
;   t2 = $EmptyMode => NIL
;   t1 := objMode triple
;   t1=t2 => triple
;   val := objVal triple
;   absolutelyCanCoerceByCheating(t1,t2) => objNew(val,t2)
;   isSubDomain(t2, t1) => coerceSubDomain(val, t1, t2)
;
;   if typeIsASmallInteger(t1) then
;     (t2 = $Integer) or typeIsASmallInteger(t2) => return objNew(val,t2)
;     sintp := SINTP val
;     sintp and (t2 = $PositiveInteger) and val > 0 => return objNew(val,t2)
;     sintp and (t2 = $NonNegativeInteger) and val >= 0 => return objNew(val,t2)
;
;   typeIsASmallInteger(t2) and isEqualOrSubDomain(t1, $Integer)_
;       and INTEGERP val =>
;     SINTP val => objNew(val,t2)
;     NIL
;
;   t2 = $Void => objNew(voidValue(),$Void)
;   t2 = $Any => objNewWrap([t1,:unwrap val],'(Any))
;
;   t1 = $Any and t2 ~= $OutputForm and ([t1',:val'] := unwrap val) and
;     (ans := coerceInt(objNewWrap(val',t1'),t2)) => ans
;
;   -- next is for tagged union selectors for the time being
;   t1 is ['Variable,=t2] or t2 is ['Variable,=t1] => objNew(val,t2)
;
;   STRINGP t2 =>
;     t1 is ['Variable,v] and (t2 = PNAME(v)) => objNewWrap(t2,t2)
;     val' := unwrap val
;     (t2 = val') and ((val' = t1) or (t1 = $String)) => objNew(val,t2)
;     NIL
;   --  t1 is ['Tuple,S] and t2 ~= '(OutputForm) =>
;   t1 is ['Tuple,S]  =>
;     coerceInt1(objNewWrap(asTupleAsList unwrap val, ['List, S]), t2)
;   t1 is ['Union,:.] => coerceIntFromUnion(triple,t2)
;   t2 is ['Union,:.] => coerceInt2Union(triple,t2)
;   (STRINGP t1) and (t2 = $String) => objNew(val,$String)
;   (STRINGP t1) and (t2 is ['Variable,v]) =>
;     t1 = PNAME(v) => objNewWrap(v,t2)
;     NIL
;   (STRINGP t1) and (t1 = unwrap val) =>
;     t2 = $OutputForm => objNew(STRCONC('"_"", t1, '"_""), $OutputForm)
;     NIL
;   atom t1 => NIL
;
;   if t1 = $AnonymousFunction and (t2 is ['Mapping,target,:margl]) then
;     $useCoerceOrCroak := nil
;     [.,vars,:body] := unwrap val
;     vars :=
;       atom vars => [vars]
;       vars is ['Tuple,:.] => rest vars
;       vars
;     #margl ~= #vars => 'continue
;     tree := mkAtree ['ADEF,vars,[target,:margl],[NIL for x in rest t2],:body]
;     CATCH('coerceOrCroaker, bottomUp tree) = 'croaked => nil
;     return getValue tree
;
;   (t1 = $Symbol) and (t2 is ['Mapping,target,:margl]) =>
;     null (mms := selectMms1(unwrap val,nil,margl,margl,target)) => NIL
;     [dc,targ,:argl] := CAAR mms
;     targ ~= target => NIL
;     $genValue =>
;       fun := getFunctionFromDomain1(unwrap val, dc, targ, argl)
;       objNewWrap(fun,t2)
;     val := NRTcompileEvalForm(unwrap val, rest CAAR mms, evalDomain dc)
;     objNew(val, t2)
;   (t1 is ['Variable,sym]) and (t2 is ['Mapping,target,:margl]) =>
;     null (mms := selectMms1(sym,target,margl,margl,NIL)) =>
;        null (mms := selectMms1(sym,target,margl,margl,true)) => NIL
;     [dc,targ,:argl] := CAAR mms
;     targ ~= target => NIL
;     dc is ["__FreeFunction__",:freeFun] => objNew( freeFun, t2 )
;     $genValue => objNewWrap(getFunctionFromDomain1(sym, dc, targ, argl), t2)
;     val := NRTcompileEvalForm(sym, rest CAAR mms, evalDomain dc)
;     objNew(val, t2)
;   (t1 is ['FunctionCalled,sym]) and (t2 is ['Mapping,target,:margl]) =>
;     symNode := mkAtreeNode sym
;     transferPropsToNode(sym,symNode)
;     null (mms := selectLocalMms(symNode,sym,margl,target)) => NIL
;     [dc,targ,:argl] := CAAR mms
;     targ ~= target => NIL
;     ml := [target,:margl]
;     intName :=
;       or/[mm for mm in mms | (mm is [[., :ml1],oldName,:.]
;         and compareTypeLists(ml1,ml))] => [COERCE(oldName, 'FUNCTION)]
;       NIL
;     null intName => NIL
;     objNewWrap(intName,t2)
;   (t1 is ['FunctionCalled,sym]) =>
;     t2 = $OutputForm => coerceByFunction(objNewWrap(val, t1), t2)
;     (t3 := get(sym,'mode,$e)) and t3 is ['Mapping,:.] =>
;       (triple' := coerceInt(triple,t3)) => coerceInt(triple',t2)
;       NIL
;     NIL
;
;   EQ(first(t1), 'Variable) and PAIRP(t2) and
;     (isEqualOrSubDomain(t2,$Integer) or
;       (t2 = [$QuotientField, $Integer]) or MEMQ(first(t2),
;         '(Float DoubleFloat))) => NIL
;
;   ans := coerceRetract(triple,t2) or coerceIntTower(triple,t2) or
;     [.,:arg]:= deconstructT t2
;     arg and
;       t:= coerceInt(triple,last arg)
;       t and coerceByFunction(t,t2)
;   ans or (isSubDomain(t1,$Integer) and
;     coerceInt(objNew(val,$Integer),t2)) or
;       coerceIntAlgebraicConstant(triple,t2) or
;         coerceIntX(val,t1,t2)

(DEFUN |coerceInt1| (|triple| |t2|)
  (PROG (|$useCoerceOrCroak| |t| |arg| |triple'| |t3| |intName| |oldName|
         |ISTMP#2| |ml1| |ml| |symNode| |freeFun| |sym| |fun| |argl| |targ|
         |dc| |mms| |tree| |body| |vars| |margl| |target| S |v| |ISTMP#1| |ans|
         |val'| |t1'| |LETTMP#1| |sintp| |val| |t1|)
    (DECLARE (SPECIAL |$useCoerceOrCroak|))
    (RETURN
     (PROGN
      (SETQ |$useCoerceOrCroak| T)
      (COND ((EQUAL |t2| |$EmptyMode|) NIL)
            (#1='T
             (PROGN
              (SETQ |t1| (|objMode| |triple|))
              (COND ((EQUAL |t1| |t2|) |triple|)
                    (#1#
                     (PROGN
                      (SETQ |val| (|objVal| |triple|))
                      (COND
                       ((|absolutelyCanCoerceByCheating| |t1| |t2|)
                        (|objNew| |val| |t2|))
                       ((|isSubDomain| |t2| |t1|)
                        (|coerceSubDomain| |val| |t1| |t2|))
                       (#1#
                        (PROGN
                         (COND
                          ((|typeIsASmallInteger| |t1|)
                           (COND
                            ((OR (EQUAL |t2| |$Integer|)
                                 (|typeIsASmallInteger| |t2|))
                             (RETURN (|objNew| |val| |t2|)))
                            (#1#
                             (PROGN
                              (SETQ |sintp| (SINTP |val|))
                              (COND
                               ((AND |sintp| (EQUAL |t2| |$PositiveInteger|)
                                     (< 0 |val|))
                                (RETURN (|objNew| |val| |t2|)))
                               ((AND |sintp| (EQUAL |t2| |$NonNegativeInteger|)
                                     (NOT (MINUSP |val|)))
                                (RETURN (|objNew| |val| |t2|)))))))))
                         (COND
                          ((AND (|typeIsASmallInteger| |t2|)
                                (|isEqualOrSubDomain| |t1| |$Integer|)
                                (INTEGERP |val|))
                           (COND ((SINTP |val|) (|objNew| |val| |t2|))
                                 (#1# NIL)))
                          ((EQUAL |t2| |$Void|)
                           (|objNew| (|voidValue|) |$Void|))
                          ((EQUAL |t2| |$Any|)
                           (|objNewWrap| (CONS |t1| (|unwrap| |val|))
                            '(|Any|)))
                          ((AND (EQUAL |t1| |$Any|)
                                (NOT (EQUAL |t2| |$OutputForm|))
                                (PROGN
                                 (SETQ |LETTMP#1| (|unwrap| |val|))
                                 (SETQ |t1'| (CAR |LETTMP#1|))
                                 (SETQ |val'| (CDR |LETTMP#1|))
                                 |LETTMP#1|)
                                (SETQ |ans|
                                        (|coerceInt|
                                         (|objNewWrap| |val'| |t1'|) |t2|)))
                           |ans|)
                          ((OR
                            (AND (CONSP |t1|) (EQ (CAR |t1|) '|Variable|)
                                 (PROGN
                                  (SETQ |ISTMP#1| (CDR |t1|))
                                  (AND (CONSP |ISTMP#1|)
                                       (EQ (CDR |ISTMP#1|) NIL)
                                       (EQUAL (CAR |ISTMP#1|) |t2|))))
                            (AND (CONSP |t2|) (EQ (CAR |t2|) '|Variable|)
                                 (PROGN
                                  (SETQ |ISTMP#1| (CDR |t2|))
                                  (AND (CONSP |ISTMP#1|)
                                       (EQ (CDR |ISTMP#1|) NIL)
                                       (EQUAL (CAR |ISTMP#1|) |t1|)))))
                           (|objNew| |val| |t2|))
                          ((STRINGP |t2|)
                           (COND
                            ((AND (CONSP |t1|) (EQ (CAR |t1|) '|Variable|)
                                  (PROGN
                                   (SETQ |ISTMP#1| (CDR |t1|))
                                   (AND (CONSP |ISTMP#1|)
                                        (EQ (CDR |ISTMP#1|) NIL)
                                        (PROGN
                                         (SETQ |v| (CAR |ISTMP#1|))
                                         #1#)))
                                  (EQUAL |t2| (PNAME |v|)))
                             (|objNewWrap| |t2| |t2|))
                            (#1#
                             (PROGN
                              (SETQ |val'| (|unwrap| |val|))
                              (COND
                               ((AND (EQUAL |t2| |val'|)
                                     (OR (EQUAL |val'| |t1|)
                                         (EQUAL |t1| |$String|)))
                                (|objNew| |val| |t2|))
                               (#1# NIL))))))
                          ((AND (CONSP |t1|) (EQ (CAR |t1|) '|Tuple|)
                                (PROGN
                                 (SETQ |ISTMP#1| (CDR |t1|))
                                 (AND (CONSP |ISTMP#1|)
                                      (EQ (CDR |ISTMP#1|) NIL)
                                      (PROGN (SETQ S (CAR |ISTMP#1|)) #1#))))
                           (|coerceInt1|
                            (|objNewWrap| (|asTupleAsList| (|unwrap| |val|))
                             (LIST '|List| S))
                            |t2|))
                          ((AND (CONSP |t1|) (EQ (CAR |t1|) '|Union|))
                           (|coerceIntFromUnion| |triple| |t2|))
                          ((AND (CONSP |t2|) (EQ (CAR |t2|) '|Union|))
                           (|coerceInt2Union| |triple| |t2|))
                          ((AND (STRINGP |t1|) (EQUAL |t2| |$String|))
                           (|objNew| |val| |$String|))
                          ((AND (STRINGP |t1|) (CONSP |t2|)
                                (EQ (CAR |t2|) '|Variable|)
                                (PROGN
                                 (SETQ |ISTMP#1| (CDR |t2|))
                                 (AND (CONSP |ISTMP#1|)
                                      (EQ (CDR |ISTMP#1|) NIL)
                                      (PROGN (SETQ |v| (CAR |ISTMP#1|)) #1#))))
                           (COND
                            ((EQUAL |t1| (PNAME |v|)) (|objNewWrap| |v| |t2|))
                            (#1# NIL)))
                          ((AND (STRINGP |t1|) (EQUAL |t1| (|unwrap| |val|)))
                           (COND
                            ((EQUAL |t2| |$OutputForm|)
                             (|objNew| (STRCONC "\"" |t1| "\"") |$OutputForm|))
                            (#1# NIL)))
                          ((ATOM |t1|) NIL)
                          (#1#
                           (PROGN
                            (COND
                             ((AND (EQUAL |t1| |$AnonymousFunction|)
                                   (CONSP |t2|) (EQ (CAR |t2|) '|Mapping|)
                                   (PROGN
                                    (SETQ |ISTMP#1| (CDR |t2|))
                                    (AND (CONSP |ISTMP#1|)
                                         (PROGN
                                          (SETQ |target| (CAR |ISTMP#1|))
                                          (SETQ |margl| (CDR |ISTMP#1|))
                                          #1#))))
                              (SETQ |$useCoerceOrCroak| NIL)
                              (SETQ |LETTMP#1| (|unwrap| |val|))
                              (SETQ |vars| (CADR . #2=(|LETTMP#1|)))
                              (SETQ |body| (CDDR . #2#))
                              (SETQ |vars|
                                      (COND ((ATOM |vars|) (LIST |vars|))
                                            ((AND (CONSP |vars|)
                                                  (EQ (CAR |vars|) '|Tuple|))
                                             (CDR |vars|))
                                            (#1# |vars|)))
                              (COND
                               ((NOT (EQL (LENGTH |margl|) (LENGTH |vars|)))
                                '|continue|)
                               (#1#
                                (PROGN
                                 (SETQ |tree|
                                         (|mkAtree|
                                          (CONS 'ADEF
                                                (CONS |vars|
                                                      (CONS
                                                       (CONS |target| |margl|)
                                                       (CONS
                                                        ((LAMBDA
                                                             (|bfVar#35|
                                                              |bfVar#34| |x|)
                                                           (LOOP
                                                            (COND
                                                             ((OR
                                                               (ATOM
                                                                |bfVar#34|)
                                                               (PROGN
                                                                (SETQ |x|
                                                                        (CAR
                                                                         |bfVar#34|))
                                                                NIL))
                                                              (RETURN
                                                               (NREVERSE
                                                                |bfVar#35|)))
                                                             (#1#
                                                              (SETQ |bfVar#35|
                                                                      (CONS NIL
                                                                            |bfVar#35|))))
                                                            (SETQ |bfVar#34|
                                                                    (CDR
                                                                     |bfVar#34|))))
                                                         NIL (CDR |t2|) NIL)
                                                        |body|))))))
                                 (COND
                                  ((EQ
                                    (CATCH '|coerceOrCroaker|
                                      (|bottomUp| |tree|))
                                    '|croaked|)
                                   NIL)
                                  (#1# (RETURN (|getValue| |tree|)))))))))
                            (COND
                             ((AND (EQUAL |t1| |$Symbol|) (CONSP |t2|)
                                   (EQ (CAR |t2|) '|Mapping|)
                                   (PROGN
                                    (SETQ |ISTMP#1| (CDR |t2|))
                                    (AND (CONSP |ISTMP#1|)
                                         (PROGN
                                          (SETQ |target| (CAR |ISTMP#1|))
                                          (SETQ |margl| (CDR |ISTMP#1|))
                                          #1#))))
                              (COND
                               ((NULL
                                 (SETQ |mms|
                                         (|selectMms1| (|unwrap| |val|) NIL
                                          |margl| |margl| |target|)))
                                NIL)
                               (#1#
                                (PROGN
                                 (SETQ |LETTMP#1| (CAAR |mms|))
                                 (SETQ |dc| (CAR |LETTMP#1|))
                                 (SETQ |targ| (CADR . #3=(|LETTMP#1|)))
                                 (SETQ |argl| (CDDR . #3#))
                                 (COND ((NOT (EQUAL |targ| |target|)) NIL)
                                       (|$genValue|
                                        (PROGN
                                         (SETQ |fun|
                                                 (|getFunctionFromDomain1|
                                                  (|unwrap| |val|) |dc| |targ|
                                                  |argl|))
                                         (|objNewWrap| |fun| |t2|)))
                                       (#1#
                                        (PROGN
                                         (SETQ |val|
                                                 (|NRTcompileEvalForm|
                                                  (|unwrap| |val|)
                                                  (CDR (CAAR |mms|))
                                                  (|evalDomain| |dc|)))
                                         (|objNew| |val| |t2|))))))))
                             ((AND (CONSP |t1|) (EQ (CAR |t1|) '|Variable|)
                                   (PROGN
                                    (SETQ |ISTMP#1| (CDR |t1|))
                                    (AND (CONSP |ISTMP#1|)
                                         (EQ (CDR |ISTMP#1|) NIL)
                                         (PROGN
                                          (SETQ |sym| (CAR |ISTMP#1|))
                                          #1#)))
                                   (CONSP |t2|) (EQ (CAR |t2|) '|Mapping|)
                                   (PROGN
                                    (SETQ |ISTMP#1| (CDR |t2|))
                                    (AND (CONSP |ISTMP#1|)
                                         (PROGN
                                          (SETQ |target| (CAR |ISTMP#1|))
                                          (SETQ |margl| (CDR |ISTMP#1|))
                                          #1#))))
                              (COND
                               ((NULL
                                 (SETQ |mms|
                                         (|selectMms1| |sym| |target| |margl|
                                          |margl| NIL)))
                                (COND
                                 ((NULL
                                   (SETQ |mms|
                                           (|selectMms1| |sym| |target| |margl|
                                            |margl| T)))
                                  (IDENTITY NIL))))
                               (#1#
                                (PROGN
                                 (SETQ |LETTMP#1| (CAAR |mms|))
                                 (SETQ |dc| (CAR |LETTMP#1|))
                                 (SETQ |targ| (CADR . #4=(|LETTMP#1|)))
                                 (SETQ |argl| (CDDR . #4#))
                                 (COND ((NOT (EQUAL |targ| |target|)) NIL)
                                       ((AND (CONSP |dc|)
                                             (EQ (CAR |dc|) '|_FreeFunction_|)
                                             (PROGN
                                              (SETQ |freeFun| (CDR |dc|))
                                              #1#))
                                        (|objNew| |freeFun| |t2|))
                                       (|$genValue|
                                        (|objNewWrap|
                                         (|getFunctionFromDomain1| |sym| |dc|
                                          |targ| |argl|)
                                         |t2|))
                                       (#1#
                                        (PROGN
                                         (SETQ |val|
                                                 (|NRTcompileEvalForm| |sym|
                                                  (CDR (CAAR |mms|))
                                                  (|evalDomain| |dc|)))
                                         (|objNew| |val| |t2|))))))))
                             ((AND (CONSP |t1|)
                                   (EQ (CAR |t1|) '|FunctionCalled|)
                                   (PROGN
                                    (SETQ |ISTMP#1| (CDR |t1|))
                                    (AND (CONSP |ISTMP#1|)
                                         (EQ (CDR |ISTMP#1|) NIL)
                                         (PROGN
                                          (SETQ |sym| (CAR |ISTMP#1|))
                                          #1#)))
                                   (CONSP |t2|) (EQ (CAR |t2|) '|Mapping|)
                                   (PROGN
                                    (SETQ |ISTMP#1| (CDR |t2|))
                                    (AND (CONSP |ISTMP#1|)
                                         (PROGN
                                          (SETQ |target| (CAR |ISTMP#1|))
                                          (SETQ |margl| (CDR |ISTMP#1|))
                                          #1#))))
                              (PROGN
                               (SETQ |symNode| (|mkAtreeNode| |sym|))
                               (|transferPropsToNode| |sym| |symNode|)
                               (COND
                                ((NULL
                                  (SETQ |mms|
                                          (|selectLocalMms| |symNode| |sym|
                                           |margl| |target|)))
                                 NIL)
                                (#1#
                                 (PROGN
                                  (SETQ |LETTMP#1| (CAAR |mms|))
                                  (SETQ |dc| (CAR |LETTMP#1|))
                                  (SETQ |targ| (CADR . #5=(|LETTMP#1|)))
                                  (SETQ |argl| (CDDR . #5#))
                                  (COND ((NOT (EQUAL |targ| |target|)) NIL)
                                        (#1#
                                         (PROGN
                                          (SETQ |ml| (CONS |target| |margl|))
                                          (SETQ |intName|
                                                  (COND
                                                   (((LAMBDA
                                                         (|bfVar#37| |bfVar#36|
                                                          |mm|)
                                                       (LOOP
                                                        (COND
                                                         ((OR (ATOM |bfVar#36|)
                                                              (PROGN
                                                               (SETQ |mm|
                                                                       (CAR
                                                                        |bfVar#36|))
                                                               NIL))
                                                          (RETURN |bfVar#37|))
                                                         (#1#
                                                          (AND (CONSP |mm|)
                                                               (PROGN
                                                                (SETQ |ISTMP#1|
                                                                        (CAR
                                                                         |mm|))
                                                                (AND
                                                                 (CONSP
                                                                  |ISTMP#1|)
                                                                 (PROGN
                                                                  (SETQ |ml1|
                                                                          (CDR
                                                                           |ISTMP#1|))
                                                                  #1#)))
                                                               (PROGN
                                                                (SETQ |ISTMP#2|
                                                                        (CDR
                                                                         |mm|))
                                                                (AND
                                                                 (CONSP
                                                                  |ISTMP#2|)
                                                                 (PROGN
                                                                  (SETQ |oldName|
                                                                          (CAR
                                                                           |ISTMP#2|))
                                                                  #1#)))
                                                               (|compareTypeLists|
                                                                |ml1| |ml|)
                                                               (PROGN
                                                                (SETQ |bfVar#37|
                                                                        |mm|)
                                                                (COND
                                                                 (|bfVar#37|
                                                                  (RETURN
                                                                   |bfVar#37|)))))))
                                                        (SETQ |bfVar#36|
                                                                (CDR
                                                                 |bfVar#36|))))
                                                     NIL |mms| NIL)
                                                    (LIST
                                                     (COERCE |oldName|
                                                             'FUNCTION)))
                                                   (#1# NIL)))
                                          (COND ((NULL |intName|) NIL)
                                                (#1#
                                                 (|objNewWrap| |intName|
                                                  |t2|)))))))))))
                             ((AND (CONSP |t1|)
                                   (EQ (CAR |t1|) '|FunctionCalled|)
                                   (PROGN
                                    (SETQ |ISTMP#1| (CDR |t1|))
                                    (AND (CONSP |ISTMP#1|)
                                         (EQ (CDR |ISTMP#1|) NIL)
                                         (PROGN
                                          (SETQ |sym| (CAR |ISTMP#1|))
                                          #1#))))
                              (COND
                               ((EQUAL |t2| |$OutputForm|)
                                (|coerceByFunction| (|objNewWrap| |val| |t1|)
                                 |t2|))
                               ((AND (SETQ |t3| (|get| |sym| '|mode| |$e|))
                                     (CONSP |t3|) (EQ (CAR |t3|) '|Mapping|))
                                (COND
                                 ((SETQ |triple'| (|coerceInt| |triple| |t3|))
                                  (|coerceInt| |triple'| |t2|))
                                 (#1# NIL)))
                               (#1# NIL)))
                             ((AND (EQ (CAR |t1|) '|Variable|) (CONSP |t2|)
                                   (OR (|isEqualOrSubDomain| |t2| |$Integer|)
                                       (EQUAL |t2|
                                              (LIST |$QuotientField|
                                                    |$Integer|))
                                       (MEMQ (CAR |t2|)
                                             '(|Float| |DoubleFloat|))))
                              NIL)
                             (#1#
                              (PROGN
                               (SETQ |ans|
                                       (OR (|coerceRetract| |triple| |t2|)
                                           (|coerceIntTower| |triple| |t2|)
                                           (PROGN
                                            (SETQ |LETTMP#1|
                                                    (|deconstructT| |t2|))
                                            (SETQ |arg| (CDR |LETTMP#1|))
                                            (AND |arg|
                                                 (PROGN
                                                  (SETQ |t|
                                                          (|coerceInt| |triple|
                                                           (|last| |arg|)))
                                                  (AND |t|
                                                       (|coerceByFunction| |t|
                                                        |t2|)))))))
                               (OR |ans|
                                   (AND (|isSubDomain| |t1| |$Integer|)
                                        (|coerceInt|
                                         (|objNew| |val| |$Integer|) |t2|))
                                   (|coerceIntAlgebraicConstant| |triple| |t2|)
                                   (|coerceIntX| |val| |t1|
                                    |t2|)))))))))))))))))))))

; coerceSubDomain(val, tSuper, tSub) ==
;   -- Try to coerce from a sub domain to a super domain
;   val = '_$fromCoerceable_$ => nil
;   super := GETDATABASE(first tSub, 'SUPERDOMAIN)
;   superDomain := first super
;   superDomain = tSuper =>
;     coerceImmediateSubDomain(val, tSuper, tSub, CADR super)
;   coerceSubDomain(val, tSuper, superDomain) =>
;     coerceImmediateSubDomain(val, superDomain, tSub, CADR super)
;   nil

(DEFUN |coerceSubDomain| (|val| |tSuper| |tSub|)
  (PROG (|super| |superDomain|)
    (RETURN
     (COND ((EQ |val| '|$fromCoerceable$|) NIL)
           (#1='T
            (PROGN
             (SETQ |super| (GETDATABASE (CAR |tSub|) 'SUPERDOMAIN))
             (SETQ |superDomain| (CAR |super|))
             (COND
              ((EQUAL |superDomain| |tSuper|)
               (|coerceImmediateSubDomain| |val| |tSuper| |tSub|
                (CADR |super|)))
              ((|coerceSubDomain| |val| |tSuper| |superDomain|)
               (|coerceImmediateSubDomain| |val| |superDomain| |tSub|
                (CADR |super|)))
              (#1# NIL))))))))

; coerceImmediateSubDomain(val, tSuper, tSub, pred) ==
;   predfn := getSubDomainPredicate(tSuper, tSub, pred)
;   FUNCALL(predfn, val, nil) => objNew(val, tSub)
;   nil

(DEFUN |coerceImmediateSubDomain| (|val| |tSuper| |tSub| |pred|)
  (PROG (|predfn|)
    (RETURN
     (PROGN
      (SETQ |predfn| (|getSubDomainPredicate| |tSuper| |tSub| |pred|))
      (COND ((FUNCALL |predfn| |val| NIL) (|objNew| |val| |tSub|)) ('T NIL))))))

; getSubDomainPredicate(tSuper, tSub, pred) ==
;   $env: local := $InteractiveFrame
;   predfn := HGET($superHash, CONS(tSuper, tSub)) => predfn
;   name := GENSYM()
;   decl := ['_:, name, ['Mapping, $Boolean, tSuper]]
;   interpret(decl, nil)
;   arg := GENSYM()
;   pred' := SUBST(arg, "#1", pred)
;   defn := ['DEF, [name, arg], '(NIL NIL), '(NIL NIL), removeZeroOne pred']
;   interpret(defn, nil)
;   op := mkAtree name
;   transferPropsToNode(name, op)
;   predfn := CADAR selectLocalMms(op, name, [tSuper],$Boolean)
;   HPUT($superHash, CONS(tSuper, tSub), predfn)
;   predfn

(DEFUN |getSubDomainPredicate| (|tSuper| |tSub| |pred|)
  (PROG (|$env| |op| |defn| |pred'| |arg| |decl| |name| |predfn|)
    (DECLARE (SPECIAL |$env|))
    (RETURN
     (PROGN
      (SETQ |$env| |$InteractiveFrame|)
      (COND
       ((SETQ |predfn| (HGET |$superHash| (CONS |tSuper| |tSub|))) |predfn|)
       ('T
        (PROGN
         (SETQ |name| (GENSYM))
         (SETQ |decl| (LIST '|:| |name| (LIST '|Mapping| |$Boolean| |tSuper|)))
         (|interpret| |decl| NIL)
         (SETQ |arg| (GENSYM))
         (SETQ |pred'| (SUBST |arg| '|#1| |pred|))
         (SETQ |defn|
                 (LIST 'DEF (LIST |name| |arg|) '(NIL NIL) '(NIL NIL)
                       (|removeZeroOne| |pred'|)))
         (|interpret| |defn| NIL)
         (SETQ |op| (|mkAtree| |name|))
         (|transferPropsToNode| |name| |op|)
         (SETQ |predfn|
                 (CADAR
                  (|selectLocalMms| |op| |name| (LIST |tSuper|) |$Boolean|)))
         (HPUT |$superHash| (CONS |tSuper| |tSub|) |predfn|)
         |predfn|)))))))

; coerceIntX(val,t1, t2) ==
;   -- some experimental things
;   t1 = '(List (None)) =>
;     -- this will almost always be an empty list
;     null unwrap val =>
;       -- try getting a better flavor of List
;       null (t0 := underDomainOf(t2)) => NIL
;       coerceInt(objNewWrap(val,['List,t0]),t2)
;     NIL
;   NIL

(DEFUN |coerceIntX| (|val| |t1| |t2|)
  (PROG (|t0|)
    (RETURN
     (COND
      ((EQUAL |t1| '(|List| (|None|)))
       (COND
        ((NULL (|unwrap| |val|))
         (COND ((NULL (SETQ |t0| (|underDomainOf| |t2|))) NIL)
               (#1='T
                (|coerceInt| (|objNewWrap| |val| (LIST '|List| |t0|)) |t2|))))
        (#1# NIL)))
      (#1# NIL)))))

; compareTypeLists(tl1,tl2) ==
;   -- returns true if every type in tl1 is = or is a subdomain of
;   -- the corresponding type in tl2
;   for t1 in tl1 for t2 in tl2 repeat
;     null isEqualOrSubDomain(t1,t2) => return NIL
;   true

(DEFUN |compareTypeLists| (|tl1| |tl2|)
  (PROG ()
    (RETURN
     (PROGN
      ((LAMBDA (|bfVar#38| |t1| |bfVar#39| |t2|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#38|) (PROGN (SETQ |t1| (CAR |bfVar#38|)) NIL)
                (ATOM |bfVar#39|) (PROGN (SETQ |t2| (CAR |bfVar#39|)) NIL))
            (RETURN NIL))
           ('T
            (COND
             ((NULL (|isEqualOrSubDomain| |t1| |t2|))
              (IDENTITY (RETURN NIL))))))
          (SETQ |bfVar#38| (CDR |bfVar#38|))
          (SETQ |bfVar#39| (CDR |bfVar#39|))))
       |tl1| NIL |tl2| NIL)
      T))))

; coerceIntAlgebraicConstant(object,t2) ==
;   -- should use = from domain, but have to check on defaults code
;   t1 := objMode object
;   val := objValUnwrap object
;   ofCategory(t1,'(Monoid)) and ofCategory(t2,'(Monoid)) and
;     val = getConstantFromDomain('(One),t1) =>
;       objNewWrap(getConstantFromDomain('(One),t2),t2)
;   ofCategory(t1,'(AbelianMonoid)) and ofCategory(t2,'(AbelianMonoid)) and
;     val = getConstantFromDomain('(Zero),t1) =>
;       objNewWrap(getConstantFromDomain('(Zero),t2),t2)
;   NIL

(DEFUN |coerceIntAlgebraicConstant| (|object| |t2|)
  (PROG (|t1| |val|)
    (RETURN
     (PROGN
      (SETQ |t1| (|objMode| |object|))
      (SETQ |val| (|objValUnwrap| |object|))
      (COND
       ((AND (|ofCategory| |t1| '(|Monoid|)) (|ofCategory| |t2| '(|Monoid|))
             (EQUAL |val| (|getConstantFromDomain| '(|One|) |t1|)))
        (|objNewWrap| (|getConstantFromDomain| '(|One|) |t2|) |t2|))
       ((AND (|ofCategory| |t1| '(|AbelianMonoid|))
             (|ofCategory| |t2| '(|AbelianMonoid|))
             (EQUAL |val| (|getConstantFromDomain| '(|Zero|) |t1|)))
        (|objNewWrap| (|getConstantFromDomain| '(|Zero|) |t2|) |t2|))
       ('T NIL))))))

; stripUnionTags doms ==
;   [if dom is [":",.,dom'] then dom' else dom for dom in doms]

(DEFUN |stripUnionTags| (|doms|)
  (PROG (|ISTMP#1| |ISTMP#2| |dom'|)
    (RETURN
     ((LAMBDA (|bfVar#41| |bfVar#40| |dom|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#40|) (PROGN (SETQ |dom| (CAR |bfVar#40|)) NIL))
           (RETURN (NREVERSE |bfVar#41|)))
          (#1='T
           (SETQ |bfVar#41|
                   (CONS
                    (COND
                     ((AND (CONSP |dom|) (EQ (CAR |dom|) '|:|)
                           (PROGN
                            (SETQ |ISTMP#1| (CDR |dom|))
                            (AND (CONSP |ISTMP#1|)
                                 (PROGN
                                  (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                  (AND (CONSP |ISTMP#2|)
                                       (EQ (CDR |ISTMP#2|) NIL)
                                       (PROGN
                                        (SETQ |dom'| (CAR |ISTMP#2|))
                                        #1#))))))
                      |dom'|)
                     (#1# |dom|))
                    |bfVar#41|))))
         (SETQ |bfVar#40| (CDR |bfVar#40|))))
      NIL |doms| NIL))))

; isTaggedUnion u ==
;   u is ['Union,:tl] and tl and first tl is [":",.,.] and true

(DEFUN |isTaggedUnion| (|u|)
  (PROG (|tl| |ISTMP#1| |ISTMP#2| |ISTMP#3|)
    (RETURN
     (AND (CONSP |u|) (EQ (CAR |u|) '|Union|) (PROGN (SETQ |tl| (CDR |u|)) 'T)
          |tl|
          (PROGN
           (SETQ |ISTMP#1| (CAR |tl|))
           (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|:|)
                (PROGN
                 (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                 (AND (CONSP |ISTMP#2|)
                      (PROGN
                       (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                       (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)))))))
          T))))

; getUnionOrRecordTags u ==
;   tags := nil
;   if u is ['Union, :tl] or u is ['Record, :tl] then
;       for t in tl repeat
;          if t is [":",tag,.] then tags := cons(tag, tags)
;   tags

(DEFUN |getUnionOrRecordTags| (|u|)
  (PROG (|tags| |tl| |ISTMP#1| |tag| |ISTMP#2|)
    (RETURN
     (PROGN
      (SETQ |tags| NIL)
      (COND
       ((OR
         (AND (CONSP |u|) (EQ (CAR |u|) '|Union|)
              (PROGN (SETQ |tl| (CDR |u|)) #1='T))
         (AND (CONSP |u|) (EQ (CAR |u|) '|Record|)
              (PROGN (SETQ |tl| (CDR |u|)) #1#)))
        ((LAMBDA (|bfVar#42| |t|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#42|) (PROGN (SETQ |t| (CAR |bfVar#42|)) NIL))
              (RETURN NIL))
             (#1#
              (COND
               ((AND (CONSP |t|) (EQ (CAR |t|) '|:|)
                     (PROGN
                      (SETQ |ISTMP#1| (CDR |t|))
                      (AND (CONSP |ISTMP#1|)
                           (PROGN
                            (SETQ |tag| (CAR |ISTMP#1|))
                            (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                            (AND (CONSP |ISTMP#2|)
                                 (EQ (CDR |ISTMP#2|) NIL))))))
                (SETQ |tags| (CONS |tag| |tags|))))))
            (SETQ |bfVar#42| (CDR |bfVar#42|))))
         |tl| NIL)))
      |tags|))))

; coerceUnion2Branch(object) ==
;   [.,:unionDoms] := objMode object
;   doms := unionDoms
;   predList:= mkPredList doms
;   doms := stripUnionTags doms
;   val' := objValUnwrap object
;   predicate := NIL
;   targetType:= NIL
;   for typ in doms for pred in predList while not targetType repeat
;       predicate := pred
;       pred is ["EQCAR", "#1", i] =>
;           if EQCAR(val', i) then targetType := typ
;       evalSharpOne(pred,val') =>
;           targetType := typ
;   null targetType => keyedSystemError("S2IC0013",NIL)
;   predicate is ['EQCAR, ., p] => objNewWrap(rest val', targetType)
;   objNew(objVal object,targetType)

(DEFUN |coerceUnion2Branch| (|object|)
  (PROG (|LETTMP#1| |unionDoms| |doms| |predList| |val'| |predicate|
         |targetType| |ISTMP#1| |ISTMP#2| |i| |p|)
    (RETURN
     (PROGN
      (SETQ |LETTMP#1| (|objMode| |object|))
      (SETQ |unionDoms| (CDR |LETTMP#1|))
      (SETQ |doms| |unionDoms|)
      (SETQ |predList| (|mkPredList| |doms|))
      (SETQ |doms| (|stripUnionTags| |doms|))
      (SETQ |val'| (|objValUnwrap| |object|))
      (SETQ |predicate| NIL)
      (SETQ |targetType| NIL)
      ((LAMBDA (|bfVar#43| |typ| |bfVar#44| |pred|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#43|) (PROGN (SETQ |typ| (CAR |bfVar#43|)) NIL)
                (ATOM |bfVar#44|) (PROGN (SETQ |pred| (CAR |bfVar#44|)) NIL)
                |targetType|)
            (RETURN NIL))
           (#1='T
            (PROGN
             (SETQ |predicate| |pred|)
             (COND
              ((AND (CONSP |pred|) (EQ (CAR |pred|) 'EQCAR)
                    (PROGN
                     (SETQ |ISTMP#1| (CDR |pred|))
                     (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|#1|)
                          (PROGN
                           (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                           (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                (PROGN (SETQ |i| (CAR |ISTMP#2|)) #1#))))))
               (COND ((EQCAR |val'| |i|) (SETQ |targetType| |typ|))))
              ((|evalSharpOne| |pred| |val'|) (SETQ |targetType| |typ|))))))
          (SETQ |bfVar#43| (CDR |bfVar#43|))
          (SETQ |bfVar#44| (CDR |bfVar#44|))))
       |doms| NIL |predList| NIL)
      (COND ((NULL |targetType|) (|keyedSystemError| 'S2IC0013 NIL))
            ((AND (CONSP |predicate|) (EQ (CAR |predicate|) 'EQCAR)
                  (PROGN
                   (SETQ |ISTMP#1| (CDR |predicate|))
                   (AND (CONSP |ISTMP#1|)
                        (PROGN
                         (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                         (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                              (PROGN (SETQ |p| (CAR |ISTMP#2|)) #1#))))))
             (|objNewWrap| (CDR |val'|) |targetType|))
            (#1# (|objNew| (|objVal| |object|) |targetType|)))))))

; coerceBranch2Union(object,union) ==
;   -- assumes type is a member of unionDoms
;   doms := rest union
;   predList:= mkPredList doms
;   doms := stripUnionTags doms
;   p := position(objMode object,doms)
;   p = -1 => keyedSystemError("S2IC0014",[objMode object,union])
;   val := objVal object
;   predList.p is ['EQCAR,.,tag] =>
;     objNewWrap([removeQuote tag,:unwrap val],union)
;   objNew(val,union)

(DEFUN |coerceBranch2Union| (|object| |union|)
  (PROG (|doms| |predList| |p| |val| |ISTMP#1| |ISTMP#2| |ISTMP#3| |tag|)
    (RETURN
     (PROGN
      (SETQ |doms| (CDR |union|))
      (SETQ |predList| (|mkPredList| |doms|))
      (SETQ |doms| (|stripUnionTags| |doms|))
      (SETQ |p| (|position| (|objMode| |object|) |doms|))
      (COND
       ((EQUAL |p| (- 1))
        (|keyedSystemError| 'S2IC0014 (LIST (|objMode| |object|) |union|)))
       (#1='T
        (PROGN
         (SETQ |val| (|objVal| |object|))
         (COND
          ((PROGN
            (SETQ |ISTMP#1| (ELT |predList| |p|))
            (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) 'EQCAR)
                 (PROGN
                  (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                  (AND (CONSP |ISTMP#2|)
                       (PROGN
                        (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                        (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                             (PROGN (SETQ |tag| (CAR |ISTMP#3|)) #1#)))))))
           (|objNewWrap| (CONS (|removeQuote| |tag|) (|unwrap| |val|))
            |union|))
          (#1# (|objNew| |val| |union|))))))))))

; coerceInt2Union(object,union) ==
;   -- coerces to a Union type, adding numeric tags
;   -- first cut
;   unionDoms := stripUnionTags rest union
;   t1 := objMode object
;   member(t1,unionDoms) => coerceBranch2Union(object,union)
;   val := objVal object
;   val' := unwrap val
;   (t1 = $String) and member(val',unionDoms) =>
;     coerceBranch2Union(objNew(val,val'),union)
;   noCoerce := true
;   val' := nil
;   for d in unionDoms while noCoerce repeat
;     (val' := coerceInt(object,d)) => noCoerce := nil
;   val' => coerceBranch2Union(val',union)
;   NIL

(DEFUN |coerceInt2Union| (|object| |union|)
  (PROG (|unionDoms| |t1| |val| |val'| |noCoerce|)
    (RETURN
     (PROGN
      (SETQ |unionDoms| (|stripUnionTags| (CDR |union|)))
      (SETQ |t1| (|objMode| |object|))
      (COND
       ((|member| |t1| |unionDoms|) (|coerceBranch2Union| |object| |union|))
       (#1='T
        (PROGN
         (SETQ |val| (|objVal| |object|))
         (SETQ |val'| (|unwrap| |val|))
         (COND
          ((AND (EQUAL |t1| |$String|) (|member| |val'| |unionDoms|))
           (|coerceBranch2Union| (|objNew| |val| |val'|) |union|))
          (#1#
           (PROGN
            (SETQ |noCoerce| T)
            (SETQ |val'| NIL)
            ((LAMBDA (|bfVar#45| |d|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#45|) (PROGN (SETQ |d| (CAR |bfVar#45|)) NIL)
                      (NOT |noCoerce|))
                  (RETURN NIL))
                 (#1#
                  (COND
                   ((SETQ |val'| (|coerceInt| |object| |d|))
                    (IDENTITY (SETQ |noCoerce| NIL))))))
                (SETQ |bfVar#45| (CDR |bfVar#45|))))
             |unionDoms| NIL)
            (COND (|val'| (|coerceBranch2Union| |val'| |union|))
                  (#1# NIL))))))))))))

; coerceIntFromUnion(object,t2) ==
;   -- coerces from a Union type to something else
;   coerceInt(coerceUnion2Branch object,t2)

(DEFUN |coerceIntFromUnion| (|object| |t2|)
  (PROG () (RETURN (|coerceInt| (|coerceUnion2Branch| |object|) |t2|))))

; coerceIntByMap(triple,t2) ==
;   -- idea is this: if t1 is D U1 and t2 is D U2, then look for
;   -- map: (U1 -> U2, D U1) -> D U2.  If it exists, then create a
;   -- function to do the coercion on the element level and call the
;   -- map function.
;   t1 := objMode triple
;   t2 = t1 => triple
;   u2 := deconstructT t2    -- compute t2 first because of Expression
;   1 = #u2 => NIL           -- no under domain
;   u1 := deconstructT t1
;   1 = #u1 => NIL
;   CAAR u1 ~= CAAR u2 => nil  -- constructors not equal
;   not valueArgsEqual?(t1, t2) => NIL
; --  first u1 ~= first u2 => NIL
;   top := CAAR u1
;   u1 := underDomainOf t1
;   u2 := underDomainOf t2
;
;   -- handle a couple of special cases for subdomains of Integer
;   top in '(List Vector Segment Stream UniversalSegment Array)
;     and isSubDomain(u1,u2) => objNew(objVal triple, t2)
;
;   args := [['Mapping,u2,u1],t1]
;   if $reportBottomUpFlag then
;     sayFunctionSelection('map,args,t2,NIL,
;       '"coercion facility (map)")
;   mms := selectMms1('map,t2,args,args,NIL)
;   if $reportBottomUpFlag then
;     sayFunctionSelectionResult('map,args,mms)
;   null mms => NIL
;
;   [[dc, :sig], slot, .] := first mms
;   fun := compiledLookup('map,sig,evalDomain(dc))
;   NULL fun => NIL
;   [fn,:d]:= fun
;   fn = function Undef => NIL
;   -- now compile a function to do the coercion
;   code := ['SPADCALL,['CONS,["function","coerceIntByMapInner"],MKQ [u1,:u2]],
;     wrapped2Quote objVal triple,MKQ fun]
;   -- and apply the function
;   val := CATCH('coerceFailure,timedEvaluate code)
;   (val = $coerceFailure) => NIL
;   objNewWrap(val,t2)

(DEFUN |coerceIntByMap| (|triple| |t2|)
  (PROG (|t1| |u2| |u1| |top| |args| |mms| |LETTMP#1| |dc| |sig| |slot| |fun|
         |fn| |d| |code| |val|)
    (RETURN
     (PROGN
      (SETQ |t1| (|objMode| |triple|))
      (COND ((EQUAL |t2| |t1|) |triple|)
            (#1='T
             (PROGN
              (SETQ |u2| (|deconstructT| |t2|))
              (COND ((EQL 1 (LENGTH |u2|)) NIL)
                    (#1#
                     (PROGN
                      (SETQ |u1| (|deconstructT| |t1|))
                      (COND ((EQL 1 (LENGTH |u1|)) NIL)
                            ((NOT (EQUAL (CAAR |u1|) (CAAR |u2|))) NIL)
                            ((NULL (|valueArgsEqual?| |t1| |t2|)) NIL)
                            (#1#
                             (PROGN
                              (SETQ |top| (CAAR |u1|))
                              (SETQ |u1| (|underDomainOf| |t1|))
                              (SETQ |u2| (|underDomainOf| |t2|))
                              (COND
                               ((AND
                                 (|member| |top|
                                  '(|List| |Vector| |Segment| |Stream|
                                    |UniversalSegment| |Array|))
                                 (|isSubDomain| |u1| |u2|))
                                (|objNew| (|objVal| |triple|) |t2|))
                               (#1#
                                (PROGN
                                 (SETQ |args|
                                         (LIST (LIST '|Mapping| |u2| |u1|)
                                               |t1|))
                                 (COND
                                  (|$reportBottomUpFlag|
                                   (|sayFunctionSelection| '|map| |args| |t2|
                                    NIL "coercion facility (map)")))
                                 (SETQ |mms|
                                         (|selectMms1| '|map| |t2| |args|
                                          |args| NIL))
                                 (COND
                                  (|$reportBottomUpFlag|
                                   (|sayFunctionSelectionResult| '|map| |args|
                                    |mms|)))
                                 (COND ((NULL |mms|) NIL)
                                       (#1#
                                        (PROGN
                                         (SETQ |LETTMP#1| (CAR |mms|))
                                         (SETQ |dc| (CAAR . #2=(|LETTMP#1|)))
                                         (SETQ |sig| (CDAR . #2#))
                                         (SETQ |slot| (CADR |LETTMP#1|))
                                         (SETQ |fun|
                                                 (|compiledLookup| '|map| |sig|
                                                  (|evalDomain| |dc|)))
                                         (COND ((NULL |fun|) NIL)
                                               (#1#
                                                (PROGN
                                                 (SETQ |fn| (CAR |fun|))
                                                 (SETQ |d| (CDR |fun|))
                                                 (COND
                                                  ((EQUAL |fn| #'|Undef|) NIL)
                                                  (#1#
                                                   (PROGN
                                                    (SETQ |code|
                                                            (LIST 'SPADCALL
                                                                  (LIST 'CONS
                                                                        (LIST
                                                                         '|function|
                                                                         '|coerceIntByMapInner|)
                                                                        (MKQ
                                                                         (CONS
                                                                          |u1|
                                                                          |u2|)))
                                                                  (|wrapped2Quote|
                                                                   (|objVal|
                                                                    |triple|))
                                                                  (MKQ |fun|)))
                                                    (SETQ |val|
                                                            (CATCH
                                                                '|coerceFailure|
                                                              (|timedEvaluate|
                                                               |code|)))
                                                    (COND
                                                     ((EQUAL |val|
                                                             |$coerceFailure|)
                                                      NIL)
                                                     (#1#
                                                      (|objNewWrap| |val|
                                                       |t2|))))))))))))))))))))))))))))

; coerceIntByMapInner(arg,[u1,:u2]) == coerceOrThrowFailure(arg,u1,u2)

(DEFUN |coerceIntByMapInner| (|arg| |bfVar#46|)
  (PROG (|u1| |u2|)
    (RETURN
     (PROGN
      (SETQ |u1| (CAR |bfVar#46|))
      (SETQ |u2| (CDR |bfVar#46|))
      (|coerceOrThrowFailure| |arg| |u1| |u2|)))))

; valueArgsEqual?(t1, t2) ==
;   -- returns true if the object-valued arguments to t1 and t2 are the same
;   -- under coercion
;   coSig := rest GETDATABASE(first t1, 'COSIG)
;   constrSig := rest getConstructorSignature first t1
;   tl1 := replaceSharps(constrSig, t1)
;   tl2 := replaceSharps(constrSig, t2)
;   not MEMQ(NIL, coSig) => true
;   done := false
;   value := true
;   for a1 in rest t1 for a2 in rest t2 for cs in coSig
;     for m1 in tl1 for m2 in tl2 while not done repeat
;           not cs =>
;             trip := objNewWrap(a1, m1)
;             newVal := coerceInt(trip, m2)
;             null newVal => (done := true; value := false)
;             not algEqual(a2, objValUnwrap newVal, m2) =>
;               (done := true; value := false)
;   value

(DEFUN |valueArgsEqual?| (|t1| |t2|)
  (PROG (|coSig| |constrSig| |tl1| |tl2| |done| |value| |trip| |newVal|)
    (RETURN
     (PROGN
      (SETQ |coSig| (CDR (GETDATABASE (CAR |t1|) 'COSIG)))
      (SETQ |constrSig| (CDR (|getConstructorSignature| (CAR |t1|))))
      (SETQ |tl1| (|replaceSharps| |constrSig| |t1|))
      (SETQ |tl2| (|replaceSharps| |constrSig| |t2|))
      (COND ((NULL (MEMQ NIL |coSig|)) T)
            (#1='T
             (PROGN
              (SETQ |done| NIL)
              (SETQ |value| T)
              ((LAMBDA
                   (|bfVar#47| |a1| |bfVar#48| |a2| |bfVar#49| |cs| |bfVar#50|
                    |m1| |bfVar#51| |m2|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#47|)
                        (PROGN (SETQ |a1| (CAR |bfVar#47|)) NIL)
                        (ATOM |bfVar#48|)
                        (PROGN (SETQ |a2| (CAR |bfVar#48|)) NIL)
                        (ATOM |bfVar#49|)
                        (PROGN (SETQ |cs| (CAR |bfVar#49|)) NIL)
                        (ATOM |bfVar#50|)
                        (PROGN (SETQ |m1| (CAR |bfVar#50|)) NIL)
                        (ATOM |bfVar#51|)
                        (PROGN (SETQ |m2| (CAR |bfVar#51|)) NIL) |done|)
                    (RETURN NIL))
                   (#1#
                    (COND
                     ((NULL |cs|)
                      (IDENTITY
                       (PROGN
                        (SETQ |trip| (|objNewWrap| |a1| |m1|))
                        (SETQ |newVal| (|coerceInt| |trip| |m2|))
                        (COND
                         ((NULL |newVal|)
                          (PROGN (SETQ |done| T) (SETQ |value| NIL)))
                         ((NULL
                           (|algEqual| |a2| (|objValUnwrap| |newVal|) |m2|))
                          (PROGN (SETQ |done| T) (SETQ |value| NIL))))))))))
                  (SETQ |bfVar#47| (CDR |bfVar#47|))
                  (SETQ |bfVar#48| (CDR |bfVar#48|))
                  (SETQ |bfVar#49| (CDR |bfVar#49|))
                  (SETQ |bfVar#50| (CDR |bfVar#50|))
                  (SETQ |bfVar#51| (CDR |bfVar#51|))))
               (CDR |t1|) NIL (CDR |t2|) NIL |coSig| NIL |tl1| NIL |tl2| NIL)
              |value|)))))))

; coerceIntTower(triple,t2) ==
;   -- tries to find a coercion from top level t2 to somewhere inside t1
;   -- builds new argument type, for which coercion is called recursively
;   x := coerceIntByMap(triple,t2) => x
;   x := coerceIntCommute(triple,t2) => x
;   x := coerceIntPermute(triple,t2) => x
;   x := coerceIntSpecial(triple,t2) => x
;   x := coerceIntTableOrFunction(triple,t2) => x
;   t1 := objMode triple
;   [c1,:arg1]:= deconstructT t1
;   arg1 and
;     TL:= NIL
;     arg:= arg1
;     until x or not arg repeat
;       t:= last arg
;       [c,:arg]:= deconstructT t
;       TL:= [c,arg,:TL]
;       x := arg and coerceIntTest(t,t2) =>
;         CDDR TL =>
;           s := constructM(c1, replaceLast(arg1, bubbleConstructor TL))
;           (null isValidType(s)) => (x := NIL)
;           x := (coerceIntByMap(triple,s) or
;             coerceIntTableOrFunction(triple,s)) =>
;               [c2,:arg2]:= deconstructT last s
;               s:= bubbleConstructor [c2,arg2,c1,arg1]
;               (null isValidType(s)) => (x := NIL)
;               x:= coerceIntCommute(x,s) =>
;                 x := (coerceIntByMap(x,t2) or
;                   coerceIntTableOrFunction(x,t2))
;         s:= bubbleConstructor [c,arg,c1,arg1]
;         (null isValidType(s)) => (x := NIL)
;         x:= coerceIntCommute(triple,s) =>
;           x:= (coerceIntByMap(x,t2) or
;             coerceIntTableOrFunction(x,t2))
;     x

(DEFUN |coerceIntTower| (|triple| |t2|)
  (PROG (|x| |t1| |LETTMP#1| |c1| |arg1| TL |arg| |t| |c| |s| |c2| |arg2|)
    (RETURN
     (COND ((SETQ |x| (|coerceIntByMap| |triple| |t2|)) |x|)
           ((SETQ |x| (|coerceIntCommute| |triple| |t2|)) |x|)
           ((SETQ |x| (|coerceIntPermute| |triple| |t2|)) |x|)
           ((SETQ |x| (|coerceIntSpecial| |triple| |t2|)) |x|)
           ((SETQ |x| (|coerceIntTableOrFunction| |triple| |t2|)) |x|)
           (#1='T
            (PROGN
             (SETQ |t1| (|objMode| |triple|))
             (SETQ |LETTMP#1| (|deconstructT| |t1|))
             (SETQ |c1| (CAR |LETTMP#1|))
             (SETQ |arg1| (CDR |LETTMP#1|))
             (AND |arg1|
                  (PROGN
                   (SETQ TL NIL)
                   (SETQ |arg| |arg1|)
                   ((LAMBDA (|bfVar#52|)
                      (LOOP
                       (COND (|bfVar#52| (RETURN NIL))
                             (#1#
                              (PROGN
                               (SETQ |t| (|last| |arg|))
                               (SETQ |LETTMP#1| (|deconstructT| |t|))
                               (SETQ |c| (CAR |LETTMP#1|))
                               (SETQ |arg| (CDR |LETTMP#1|))
                               (SETQ TL (CONS |c| (CONS |arg| TL)))
                               (COND
                                ((SETQ |x|
                                         (AND |arg|
                                              (|coerceIntTest| |t| |t2|)))
                                 (COND
                                  ((CDDR TL)
                                   (PROGN
                                    (SETQ |s|
                                            (|constructM| |c1|
                                             (|replaceLast| |arg1|
                                              (|bubbleConstructor| TL))))
                                    (COND
                                     ((NULL (|isValidType| |s|))
                                      (SETQ |x| NIL))
                                     ((SETQ |x|
                                              (OR
                                               (|coerceIntByMap| |triple| |s|)
                                               (|coerceIntTableOrFunction|
                                                |triple| |s|)))
                                      (PROGN
                                       (SETQ |LETTMP#1|
                                               (|deconstructT| (|last| |s|)))
                                       (SETQ |c2| (CAR |LETTMP#1|))
                                       (SETQ |arg2| (CDR |LETTMP#1|))
                                       (SETQ |s|
                                               (|bubbleConstructor|
                                                (LIST |c2| |arg2| |c1|
                                                      |arg1|)))
                                       (COND
                                        ((NULL (|isValidType| |s|))
                                         (SETQ |x| NIL))
                                        ((SETQ |x|
                                                 (|coerceIntCommute| |x| |s|))
                                         (SETQ |x|
                                                 (OR
                                                  (|coerceIntByMap| |x| |t2|)
                                                  (|coerceIntTableOrFunction|
                                                   |x| |t2|))))))))))
                                  (#1#
                                   (PROGN
                                    (SETQ |s|
                                            (|bubbleConstructor|
                                             (LIST |c| |arg| |c1| |arg1|)))
                                    (COND
                                     ((NULL (|isValidType| |s|))
                                      (SETQ |x| NIL))
                                     ((SETQ |x|
                                              (|coerceIntCommute| |triple|
                                               |s|))
                                      (SETQ |x|
                                              (OR (|coerceIntByMap| |x| |t2|)
                                                  (|coerceIntTableOrFunction|
                                                   |x| |t2|)))))))))))))
                       (SETQ |bfVar#52| (OR |x| (NULL |arg|)))))
                    NIL)
                   |x|))))))))

; coerceIntSpecial(triple,t2) ==
;   t1 := objMode triple
;   t2 is ['SimpleAlgebraicExtension,R,U,.] and t1 = R =>
;     null (x := coerceInt(triple,U)) => NIL
;     coerceInt(x,t2)
;   NIL

(DEFUN |coerceIntSpecial| (|triple| |t2|)
  (PROG (|t1| |ISTMP#1| R |ISTMP#2| U |ISTMP#3| |x|)
    (RETURN
     (PROGN
      (SETQ |t1| (|objMode| |triple|))
      (COND
       ((AND (CONSP |t2|) (EQ (CAR |t2|) '|SimpleAlgebraicExtension|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |t2|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ R (CAR |ISTMP#1|))
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|)
                         (PROGN
                          (SETQ U (CAR |ISTMP#2|))
                          (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                          (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)))))))
             (EQUAL |t1| R))
        (COND ((NULL (SETQ |x| (|coerceInt| |triple| U))) NIL)
              (#1='T (|coerceInt| |x| |t2|))))
       (#1# NIL))))))

; coerceIntTableOrFunction(triple,t2) ==
;   -- this function does the actual coercion to t2, but not to an
;   -- argument type of t2
;   null isValidType t2 => NIL  -- added 9-18-85 by RSS
;   null isLegitimateMode(t2,NIL,NIL) => NIL  -- added 6-28-87 by RSS
;   t1 := objMode triple
;   p := ASSQ(first t1, $CoerceTable)
;   p and ASSQ(first t2, rest p) is [., :[tag, fun]] =>
;     val := objVal triple
;     fun='Identity => objNew(val,t2)
;     tag='total =>
;       coerceByTable(fun,val,t1,t2,'T) or coerceByFunction(triple,t2)
;     coerceByTable(fun,val,t1,t2,NIL) or coerceByFunction(triple,t2)
;   coerceByFunction(triple,t2)

(DEFUN |coerceIntTableOrFunction| (|triple| |t2|)
  (PROG (|t1| |p| |ISTMP#1| |ISTMP#2| |tag| |ISTMP#3| |fun| |val|)
    (RETURN
     (COND ((NULL (|isValidType| |t2|)) NIL)
           ((NULL (|isLegitimateMode| |t2| NIL NIL)) NIL)
           (#1='T
            (PROGN
             (SETQ |t1| (|objMode| |triple|))
             (SETQ |p| (ASSQ (CAR |t1|) |$CoerceTable|))
             (COND
              ((AND |p|
                    (PROGN
                     (SETQ |ISTMP#1| (ASSQ (CAR |t2|) (CDR |p|)))
                     (AND (CONSP |ISTMP#1|)
                          (PROGN
                           (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                           (AND (CONSP |ISTMP#2|)
                                (PROGN
                                 (SETQ |tag| (CAR |ISTMP#2|))
                                 (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                                 (AND (CONSP |ISTMP#3|)
                                      (EQ (CDR |ISTMP#3|) NIL)
                                      (PROGN
                                       (SETQ |fun| (CAR |ISTMP#3|))
                                       #1#))))))))
               (PROGN
                (SETQ |val| (|objVal| |triple|))
                (COND ((EQ |fun| '|Identity|) (|objNew| |val| |t2|))
                      ((EQ |tag| '|total|)
                       (OR (|coerceByTable| |fun| |val| |t1| |t2| 'T)
                           (|coerceByFunction| |triple| |t2|)))
                      (#1#
                       (OR (|coerceByTable| |fun| |val| |t1| |t2| NIL)
                           (|coerceByFunction| |triple| |t2|))))))
              (#1# (|coerceByFunction| |triple| |t2|)))))))))

; coerceCommuteTest(t1,t2) ==
;   null isLegitimateMode(t2,NIL,NIL) => NIL
;
;   -- sees whether t1 = D1 D2 R and t2 = D2 D1 S
;   null (u1 := underDomainOf t1) => NIL
;   null (u2 := underDomainOf t2) => NIL
;
;   -- must have underdomains (ie, R and S must be there)
;
;   null (v1 := underDomainOf u1) => NIL
;   null (v2 := underDomainOf u2) => NIL
;
;   -- now check that cross of constructors is correct
;   (first(deconstructT t1) = first(deconstructT u2)) and
;     (first(deconstructT t2) = first(deconstructT u1))

(DEFUN |coerceCommuteTest| (|t1| |t2|)
  (PROG (|u1| |u2| |v1| |v2|)
    (RETURN
     (COND ((NULL (|isLegitimateMode| |t2| NIL NIL)) NIL)
           ((NULL (SETQ |u1| (|underDomainOf| |t1|))) NIL)
           ((NULL (SETQ |u2| (|underDomainOf| |t2|))) NIL)
           ((NULL (SETQ |v1| (|underDomainOf| |u1|))) NIL)
           ((NULL (SETQ |v2| (|underDomainOf| |u2|))) NIL)
           ('T
            (AND
             (EQUAL (CAR (|deconstructT| |t1|)) (CAR (|deconstructT| |u2|)))
             (EQUAL (CAR (|deconstructT| |t2|))
                    (CAR (|deconstructT| |u1|)))))))))

; coerceIntCommute(obj,target) ==
;   -- note that the value in obj may be $fromCoerceable$, for canCoerce
;   source := objMode obj
;   null coerceCommuteTest(source,target) => NIL
;   S := underDomainOf source
;   T := underDomainOf target
;   source = T => NIL      -- handle in other ways
;
;   source is [D,:.] =>
;     fun := GETL(D,'coerceCommute) or
;            INTERN STRCONC('"commute",STRINGIMAGE D)
;     functionp fun =>
;       PUT(D,'coerceCommute,fun)
;       u := objValUnwrap obj
;       c := CATCH('coerceFailure,FUNCALL(fun,u,source,S,target,T))
;       (c = $coerceFailure) => NIL
;       u = "$fromCoerceable$" => c
;       objNewWrap(c,target)
;     NIL
;   NIL

(DEFUN |coerceIntCommute| (|obj| |target|)
  (PROG (|source| S T$ D |fun| |u| |c|)
    (RETURN
     (PROGN
      (SETQ |source| (|objMode| |obj|))
      (COND ((NULL (|coerceCommuteTest| |source| |target|)) NIL)
            (#1='T
             (PROGN
              (SETQ S (|underDomainOf| |source|))
              (SETQ T$ (|underDomainOf| |target|))
              (COND ((EQUAL |source| T$) NIL)
                    ((AND (CONSP |source|) (PROGN (SETQ D (CAR |source|)) #1#))
                     (PROGN
                      (SETQ |fun|
                              (OR (GETL D '|coerceCommute|)
                                  (INTERN
                                   (STRCONC "commute" (STRINGIMAGE D)))))
                      (COND
                       ((|functionp| |fun|)
                        (PROGN
                         (PUT D '|coerceCommute| |fun|)
                         (SETQ |u| (|objValUnwrap| |obj|))
                         (SETQ |c|
                                 (CATCH '|coerceFailure|
                                   (FUNCALL |fun| |u| |source| S |target| T$)))
                         (COND ((EQUAL |c| |$coerceFailure|) NIL)
                               ((EQ |u| '|$fromCoerceable$|) |c|)
                               (#1# (|objNewWrap| |c| |target|)))))
                       (#1# NIL))))
                    (#1# NIL)))))))))

; coerceIntPermute(object,t2) ==
;   t2 in '((Integer) (OutputForm)) => NIL
;   t1 := objMode object
;   towers := computeTTTranspositions(t1,t2)
;   -- at this point, first towers = t1 and last towers should be similar
;   -- to t2 in the sense that the components of t1 are in the same order
;   -- as in t2. If length towers = 2 and t2 = last towers, we quit to
;   -- avoid an infinite loop.
;   NULL towers or NULL rest towers => NIL
;   NULL CDDR towers and t2 = CADR towers => NIL
;   -- do the coercions successively, quitting if any fail
;   ok := true
;   for t in rest towers while ok repeat
;     null (object := coerceInt(object,t)) => ok := NIL
;   ok => object
;   NIL

(DEFUN |coerceIntPermute| (|object| |t2|)
  (PROG (|t1| |towers| |ok|)
    (RETURN
     (COND ((|member| |t2| '((|Integer|) (|OutputForm|))) NIL)
           (#1='T
            (PROGN
             (SETQ |t1| (|objMode| |object|))
             (SETQ |towers| (|computeTTTranspositions| |t1| |t2|))
             (COND ((OR (NULL |towers|) (NULL (CDR |towers|))) NIL)
                   ((AND (NULL (CDDR |towers|)) (EQUAL |t2| (CADR |towers|)))
                    NIL)
                   (#1#
                    (PROGN
                     (SETQ |ok| T)
                     ((LAMBDA (|bfVar#53| |t|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#53|)
                               (PROGN (SETQ |t| (CAR |bfVar#53|)) NIL)
                               (NOT |ok|))
                           (RETURN NIL))
                          (#1#
                           (COND
                            ((NULL (SETQ |object| (|coerceInt| |object| |t|)))
                             (IDENTITY (SETQ |ok| NIL))))))
                         (SETQ |bfVar#53| (CDR |bfVar#53|))))
                      (CDR |towers|) NIL)
                     (COND (|ok| |object|) (#1# NIL)))))))))))

; computeTTTranspositions(t1,t2) ==
;   -- decompose t1 into its tower parts
;   tl1 := decomposeTypeIntoTower t1
;   tl2 := decomposeTypeIntoTower t2
;   -- if not at least 2 parts, don't bother working here
;   null (rest tl1 and rest tl2) => NIL
;   -- determine the relative order of the parts of t1 in t2
;   p2 := [position(d1,tl2) for d1 in tl1]
;   member(-1,p2) => NIL            -- something not present
;   -- if they are all ascending, this function will do nothing
;   p2' := MSORT p2
;   p2 = p2' => NIL
;   -- if anything is repeated twice, leave
;   p2' ~= MSORT REMDUP p2' => NIL
;   -- create a list of permutations that transform the tower parts
;   -- of t1 into the order they are in in t2
;   n1 := #tl1
;   p2 := LIST2VEC compress(p2,0,# REMDUP tl1) where
;     compress(l,start,len) ==
;       start >= len => l
;       member(start,l) => compress(l,start+1,len)
;       compress([(i < start => i; i - 1) for i in l],start,len)
;   -- p2 now has the same position numbers as p1, we need to determine
;   -- a list of permutations that takes p1 into p2.
;   -- them
;   perms := permuteToOrder(p2,n1-1,0)
;   towers := [tl1]
;   tower := LIST2VEC tl1
;   for perm in perms repeat
;     t := tower.(first perm)
;     tower.(first perm) := tower.(rest perm)
;     tower.(rest perm) := t
;     towers := CONS(VEC2LIST tower,towers)
;   towers := [reassembleTowerIntoType tower for tower in towers]
;   if first(towers) ~= t2 then towers := cons(t2, towers)
;   NREVERSE towers

(DEFUN |computeTTTranspositions| (|t1| |t2|)
  (PROG (|tl1| |tl2| |p2| |p2'| |n1| |perms| |towers| |tower| |t|)
    (RETURN
     (PROGN
      (SETQ |tl1| (|decomposeTypeIntoTower| |t1|))
      (SETQ |tl2| (|decomposeTypeIntoTower| |t2|))
      (COND ((NULL (AND (CDR |tl1|) (CDR |tl2|))) NIL)
            (#1='T
             (PROGN
              (SETQ |p2|
                      ((LAMBDA (|bfVar#55| |bfVar#54| |d1|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#54|)
                                (PROGN (SETQ |d1| (CAR |bfVar#54|)) NIL))
                            (RETURN (NREVERSE |bfVar#55|)))
                           (#1#
                            (SETQ |bfVar#55|
                                    (CONS (|position| |d1| |tl2|)
                                          |bfVar#55|))))
                          (SETQ |bfVar#54| (CDR |bfVar#54|))))
                       NIL |tl1| NIL))
              (COND ((|member| (- 1) |p2|) NIL)
                    (#1#
                     (PROGN
                      (SETQ |p2'| (MSORT |p2|))
                      (COND ((EQUAL |p2| |p2'|) NIL)
                            ((NOT (EQUAL |p2'| (MSORT (REMDUP |p2'|)))) NIL)
                            (#1#
                             (PROGN
                              (SETQ |n1| (LENGTH |tl1|))
                              (SETQ |p2|
                                      (LIST2VEC
                                       (|computeTTTranspositions,compress| |p2|
                                        0 (LENGTH (REMDUP |tl1|)))))
                              (SETQ |perms|
                                      (|permuteToOrder| |p2| (- |n1| 1) 0))
                              (SETQ |towers| (LIST |tl1|))
                              (SETQ |tower| (LIST2VEC |tl1|))
                              ((LAMBDA (|bfVar#58| |perm|)
                                 (LOOP
                                  (COND
                                   ((OR (ATOM |bfVar#58|)
                                        (PROGN
                                         (SETQ |perm| (CAR |bfVar#58|))
                                         NIL))
                                    (RETURN NIL))
                                   (#1#
                                    (PROGN
                                     (SETQ |t| (ELT |tower| (CAR |perm|)))
                                     (SETF (ELT |tower| (CAR |perm|))
                                             (ELT |tower| (CDR |perm|)))
                                     (SETF (ELT |tower| (CDR |perm|)) |t|)
                                     (SETQ |towers|
                                             (CONS (VEC2LIST |tower|)
                                                   |towers|)))))
                                  (SETQ |bfVar#58| (CDR |bfVar#58|))))
                               |perms| NIL)
                              (SETQ |towers|
                                      ((LAMBDA (|bfVar#60| |bfVar#59| |tower|)
                                         (LOOP
                                          (COND
                                           ((OR (ATOM |bfVar#59|)
                                                (PROGN
                                                 (SETQ |tower|
                                                         (CAR |bfVar#59|))
                                                 NIL))
                                            (RETURN (NREVERSE |bfVar#60|)))
                                           (#1#
                                            (SETQ |bfVar#60|
                                                    (CONS
                                                     (|reassembleTowerIntoType|
                                                      |tower|)
                                                     |bfVar#60|))))
                                          (SETQ |bfVar#59| (CDR |bfVar#59|))))
                                       NIL |towers| NIL))
                              (COND
                               ((NOT (EQUAL (CAR |towers|) |t2|))
                                (SETQ |towers| (CONS |t2| |towers|))))
                              (NREVERSE |towers|))))))))))))))
(DEFUN |computeTTTranspositions,compress| (|l| |start| |len|)
  (PROG ()
    (RETURN
     (COND ((NOT (< |start| |len|)) |l|)
           ((|member| |start| |l|)
            (|computeTTTranspositions,compress| |l| (+ |start| 1) |len|))
           (#1='T
            (|computeTTTranspositions,compress|
             ((LAMBDA (|bfVar#57| |bfVar#56| |i|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#56|)
                       (PROGN (SETQ |i| (CAR |bfVar#56|)) NIL))
                   (RETURN (NREVERSE |bfVar#57|)))
                  (#1#
                   (SETQ |bfVar#57|
                           (CONS (COND ((< |i| |start|) |i|) (#1# (- |i| 1)))
                                 |bfVar#57|))))
                 (SETQ |bfVar#56| (CDR |bfVar#56|))))
              NIL |l| NIL)
             |start| |len|))))))

; decomposeTypeIntoTower t ==
;   ATOM t => [t]
;   d := deconstructT t
;   NULL rest d => [t]
;   rd := REVERSE t
;   [reverse QCDR rd,:decomposeTypeIntoTower QCAR rd]

(DEFUN |decomposeTypeIntoTower| (|t|)
  (PROG (|d| |rd|)
    (RETURN
     (COND ((ATOM |t|) (LIST |t|))
           (#1='T
            (PROGN
             (SETQ |d| (|deconstructT| |t|))
             (COND ((NULL (CDR |d|)) (LIST |t|))
                   (#1#
                    (PROGN
                     (SETQ |rd| (REVERSE |t|))
                     (CONS (REVERSE (QCDR |rd|))
                           (|decomposeTypeIntoTower| (QCAR |rd|))))))))))))

; reassembleTowerIntoType tower ==
;   ATOM tower => tower
;   NULL rest tower => first tower
;   [:top,t,s] := tower
;   reassembleTowerIntoType [:top,[:t,s]]

(DEFUN |reassembleTowerIntoType| (|tower|)
  (PROG (|LETTMP#1| |s| |t| |top|)
    (RETURN
     (COND ((ATOM |tower|) |tower|) ((NULL (CDR |tower|)) (CAR |tower|))
           ('T
            (PROGN
             (SETQ |LETTMP#1| (REVERSE |tower|))
             (SETQ |s| (CAR |LETTMP#1|))
             (SETQ |t| (CADR . #1=(|LETTMP#1|)))
             (SETQ |top| (NREVERSE (CDDR . #1#)))
             (|reassembleTowerIntoType|
              (APPEND |top| (CONS (APPEND |t| (CONS |s| NIL)) NIL)))))))))

; permuteToOrder(p,n,start) ==
;   -- p is a vector of the numbers 0..n. This function returns a list
;   -- of swaps of adjacent elements so that p will be in order. We only
;   -- begin looking at index start
;   r := n - start
;   r <= 0 => NIL
;   r = 1 =>
;     p.r < p.(r+1) => NIL
;     [[r,:(r+1)]]
;   p.start = start => permuteToOrder(p,n,start+1)
;   -- bubble up element start to the top. Find out where it is
;   stpos := NIL
;   for i in start+1..n while not stpos repeat
;     if p.i = start then stpos := i
;   perms := NIL
;   while stpos ~= start repeat
;     x := stpos - 1
;     perms := [[x,:stpos],:perms]
;     t := p.stpos
;     p.stpos := p.x
;     p.x := t
;     stpos := x
;   APPEND(NREVERSE perms,permuteToOrder(p,n,start+1))

(DEFUN |permuteToOrder| (|p| |n| |start|)
  (PROG (|r| |stpos| |perms| |x| |t|)
    (RETURN
     (PROGN
      (SETQ |r| (- |n| |start|))
      (COND ((NOT (< 0 |r|)) NIL)
            ((EQL |r| 1)
             (COND ((< (ELT |p| |r|) (ELT |p| (+ |r| 1))) NIL)
                   (#1='T (LIST (CONS |r| (+ |r| 1))))))
            ((EQUAL (ELT |p| |start|) |start|)
             (|permuteToOrder| |p| |n| (+ |start| 1)))
            (#1#
             (PROGN
              (SETQ |stpos| NIL)
              ((LAMBDA (|i|)
                 (LOOP
                  (COND ((OR (> |i| |n|) |stpos|) (RETURN NIL))
                        (#1#
                         (COND
                          ((EQUAL (ELT |p| |i|) |start|) (SETQ |stpos| |i|)))))
                  (SETQ |i| (+ |i| 1))))
               (+ |start| 1))
              (SETQ |perms| NIL)
              ((LAMBDA ()
                 (LOOP
                  (COND ((EQUAL |stpos| |start|) (RETURN NIL))
                        (#1#
                         (PROGN
                          (SETQ |x| (- |stpos| 1))
                          (SETQ |perms| (CONS (CONS |x| |stpos|) |perms|))
                          (SETQ |t| (ELT |p| |stpos|))
                          (SETF (ELT |p| |stpos|) (ELT |p| |x|))
                          (SETF (ELT |p| |x|) |t|)
                          (SETQ |stpos| |x|)))))))
              (APPEND (NREVERSE |perms|)
                      (|permuteToOrder| |p| |n| (+ |start| 1))))))))))

; coerceIntTest(t1,t2) ==
;   -- looks whether there exists a table entry or a coercion function
;   -- thus the type can be bubbled before coerceIntTableOrFunction is called
;   t1=t2 or
;     b:=
;       p := ASSQ(first t1, $CoerceTable)
;       p and ASSQ(first t2, rest p)
;     b or coerceConvertMmSelection('coerce,t1,t2) or
;       ($useConvertForCoercions and
;         coerceConvertMmSelection('convert,t1,t2))

(DEFUN |coerceIntTest| (|t1| |t2|)
  (PROG (|p| |b|)
    (RETURN
     (OR (EQUAL |t1| |t2|)
         (PROGN
          (SETQ |b|
                  (PROGN
                   (SETQ |p| (ASSQ (CAR |t1|) |$CoerceTable|))
                   (AND |p| (ASSQ (CAR |t2|) (CDR |p|)))))
          (OR |b| (|coerceConvertMmSelection| '|coerce| |t1| |t2|)
              (AND |$useConvertForCoercions|
                   (|coerceConvertMmSelection| '|convert| |t1| |t2|))))))))

; coerceByTable(fn,x,t1,t2,isTotalCoerce) ==
;   -- catch point for 'failure in boot coercions
;   t2 = $OutputForm => NIL
;   isWrapped x =>
;     x:= unwrap x
;     c:= CATCH('coerceFailure,FUNCALL(fn,x,t1,t2))
;     c=$coerceFailure => NIL
;     objNewWrap(c,t2)
;   isTotalCoerce => objNew([fn,x,MKQ t1,MKQ t2],t2)
;   objNew(['catchCoerceFailure,MKQ fn,x,MKQ t1,MKQ t2],t2)

(DEFUN |coerceByTable| (|fn| |x| |t1| |t2| |isTotalCoerce|)
  (PROG (|c|)
    (RETURN
     (COND ((EQUAL |t2| |$OutputForm|) NIL)
           ((|isWrapped| |x|)
            (PROGN
             (SETQ |x| (|unwrap| |x|))
             (SETQ |c| (CATCH '|coerceFailure| (FUNCALL |fn| |x| |t1| |t2|)))
             (COND ((EQUAL |c| |$coerceFailure|) NIL)
                   (#1='T (|objNewWrap| |c| |t2|)))))
           (|isTotalCoerce|
            (|objNew| (LIST |fn| |x| (MKQ |t1|) (MKQ |t2|)) |t2|))
           (#1#
            (|objNew|
             (LIST '|catchCoerceFailure| (MKQ |fn|) |x| (MKQ |t1|) (MKQ |t2|))
             |t2|))))))

; catchCoerceFailure(fn,x,t1,t2) ==
;   -- compiles a catchpoint for compiling boot coercions
;   c:= CATCH('coerceFailure,FUNCALL(fn,x,t1,t2))
;   c = $coerceFailure =>
;     throwKeyedMsgCannotCoerceWithValue(wrap unwrap x,t1,t2)
;   c

(DEFUN |catchCoerceFailure| (|fn| |x| |t1| |t2|)
  (PROG (|c|)
    (RETURN
     (PROGN
      (SETQ |c| (CATCH '|coerceFailure| (FUNCALL |fn| |x| |t1| |t2|)))
      (COND
       ((EQUAL |c| |$coerceFailure|)
        (|throwKeyedMsgCannotCoerceWithValue| (|wrap| (|unwrap| |x|)) |t1|
         |t2|))
       ('T |c|))))))

; coercionFailure() ==
;   -- does the throw on coercion failure
;   THROW('coerceFailure,$coerceFailure)

(DEFUN |coercionFailure| ()
  (PROG () (RETURN (THROW '|coerceFailure| |$coerceFailure|))))

; coerceByFunction(T,m2) ==
;   -- using the new modemap selection without coercions
;   -- should not be called by canCoerceFrom
;   x := objVal T
;   x = '_$fromCoerceable_$ => NIL
;   m2 is ['Union,:.] => NIL
;   m1 := objMode T
;   m2 is ['Boolean,:.] and m1 is ['Equation,ud] =>
;       isWrapped x =>
;           dcVector := evalDomain ud
;           fun := NRTcompiledLookup("=", [$Boolean, '$, '$], dcVector)
;           [fn, :d]:= fun
;           x := unwrap x
;           mkObjWrap(SPADCALL(first x, rest x, fun), m2)
;       dcVector := evalDomain m1
;       fun := NRTcompileEvalForm("coerce", [$Boolean, '$], dcVector)
;       code := ['SPADCALL, x, fun]
;       objNew(code, $Boolean)
;   -- If more than one function is found, any should suffice, I think -scm
;   if not (mm := coerceConvertMmSelection(funName := 'coerce,m1,m2)) then
;     mm := coerceConvertMmSelection(funName := 'convert,m1,m2)
;   mm =>
;     [[dc,tar,:args],slot,.]:= mm
;     fun:=
;       isWrapped x =>
;         interpLookup(funName, slot, dc)
;       NRTcompileEvalForm(funName, slot, evalDomain(dc))
;     [fn,:d]:= fun
;     fn = function Undef => NIL
;     isWrapped x =>
;       val := CATCH('coerceFailure, SPADCALL(unwrap x,fun))
;       (val = $coerceFailure) => NIL
;       objNewWrap(val,m2)
;     env := fun
;     code := ['SPADCALL, x, env]
; --  tar is ['Union,:.] => objNew(['failCheck,code],m2)
;     objNew(code,m2)
;   NIL

(DEFUN |coerceByFunction| (T$ |m2|)
  (PROG (|x| |m1| |ISTMP#1| |ud| |dcVector| |fun| |fn| |d| |code| |funName|
         |mm| |dc| |tar| |args| |slot| |val| |env|)
    (RETURN
     (PROGN
      (SETQ |x| (|objVal| T$))
      (COND ((EQ |x| '|$fromCoerceable$|) NIL)
            ((AND (CONSP |m2|) (EQ (CAR |m2|) '|Union|)) NIL)
            (#1='T
             (PROGN
              (SETQ |m1| (|objMode| T$))
              (COND
               ((AND (CONSP |m2|) (EQ (CAR |m2|) '|Boolean|) (CONSP |m1|)
                     (EQ (CAR |m1|) '|Equation|)
                     (PROGN
                      (SETQ |ISTMP#1| (CDR |m1|))
                      (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                           (PROGN (SETQ |ud| (CAR |ISTMP#1|)) #1#))))
                (COND
                 ((|isWrapped| |x|)
                  (PROGN
                   (SETQ |dcVector| (|evalDomain| |ud|))
                   (SETQ |fun|
                           (|NRTcompiledLookup| '= (LIST |$Boolean| '$ '$)
                            |dcVector|))
                   (SETQ |fn| (CAR |fun|))
                   (SETQ |d| (CDR |fun|))
                   (SETQ |x| (|unwrap| |x|))
                   (|mkObjWrap| (SPADCALL (CAR |x|) (CDR |x|) |fun|) |m2|)))
                 (#1#
                  (PROGN
                   (SETQ |dcVector| (|evalDomain| |m1|))
                   (SETQ |fun|
                           (|NRTcompileEvalForm| '|coerce| (LIST |$Boolean| '$)
                            |dcVector|))
                   (SETQ |code| (LIST 'SPADCALL |x| |fun|))
                   (|objNew| |code| |$Boolean|)))))
               (#1#
                (PROGN
                 (COND
                  ((NULL
                    (SETQ |mm|
                            (|coerceConvertMmSelection|
                             (SETQ |funName| '|coerce|) |m1| |m2|)))
                   (SETQ |mm|
                           (|coerceConvertMmSelection|
                            (SETQ |funName| '|convert|) |m1| |m2|))))
                 (COND
                  (|mm|
                   (PROGN
                    (SETQ |dc| (CAAR . #2=(|mm|)))
                    (SETQ |tar| (CADAR . #2#))
                    (SETQ |args| (CDDAR . #2#))
                    (SETQ |slot| (CADR |mm|))
                    (SETQ |fun|
                            (COND
                             ((|isWrapped| |x|)
                              (|interpLookup| |funName| |slot| |dc|))
                             (#1#
                              (|NRTcompileEvalForm| |funName| |slot|
                               (|evalDomain| |dc|)))))
                    (SETQ |fn| (CAR |fun|))
                    (SETQ |d| (CDR |fun|))
                    (COND ((EQUAL |fn| #'|Undef|) NIL)
                          ((|isWrapped| |x|)
                           (PROGN
                            (SETQ |val|
                                    (CATCH '|coerceFailure|
                                      (SPADCALL (|unwrap| |x|) |fun|)))
                            (COND ((EQUAL |val| |$coerceFailure|) NIL)
                                  (#1# (|objNewWrap| |val| |m2|)))))
                          (#1#
                           (PROGN
                            (SETQ |env| |fun|)
                            (SETQ |code| (LIST 'SPADCALL |x| |env|))
                            (|objNew| |code| |m2|))))))
                  (#1# NIL))))))))))))

; hasCorrectTarget(m,sig is [dc,tar,:.]) ==
;   -- tests whether the target of signature sig is either m or a union
;   -- containing m. It also discards TEQ as it is not meant to be
;   -- used at top-level
;   dc is ['TypeEquivalence,:.] => NIL
;   m=tar => 'T
;   tar is ['Union,t,'failed] => t=m
;   tar is ['Union,'failed,t] and t=m

(DEFUN |hasCorrectTarget| (|m| |sig|)
  (PROG (|dc| |tar| |ISTMP#1| |t| |ISTMP#2|)
    (RETURN
     (PROGN
      (SETQ |dc| (CAR |sig|))
      (SETQ |tar| (CADR |sig|))
      (COND ((AND (CONSP |dc|) (EQ (CAR |dc|) '|TypeEquivalence|)) NIL)
            ((EQUAL |m| |tar|) 'T)
            ((AND (CONSP |tar|) (EQ (CAR |tar|) '|Union|)
                  (PROGN
                   (SETQ |ISTMP#1| (CDR |tar|))
                   (AND (CONSP |ISTMP#1|)
                        (PROGN
                         (SETQ |t| (CAR |ISTMP#1|))
                         (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                         (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                              (EQ (CAR |ISTMP#2|) '|failed|))))))
             (EQUAL |t| |m|))
            (#1='T
             (AND (CONSP |tar|) (EQ (CAR |tar|) '|Union|)
                  (PROGN
                   (SETQ |ISTMP#1| (CDR |tar|))
                   (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|failed|)
                        (PROGN
                         (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                         (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                              (PROGN (SETQ |t| (CAR |ISTMP#2|)) #1#)))))
                  (EQUAL |t| |m|))))))))

; intCodeGenCOERCE(triple,t2) ==
;   -- NOTE: returns a triple
;   t1 := objMode triple
;   t1 = $EmptyMode => NIL
;   t1 = t2 => triple
;   val := objVal triple
;
;   val is ['THROW,label,code] =>
;     if label is ['QUOTE, l] then label := l
;     null($compilingMap) or (label ~= mapCatchName($mapName)) =>
;       objNew(['THROW,label,wrapped2Quote objVal
;         intCodeGenCOERCE(objNew(code,t1),t2)],t2)
;     -- we have a return statement. just send it back as is
;     objNew(val,t2)
;
;   val is ['PROGN,:code,lastCode] =>
;     objNew(['PROGN,:code,wrapped2Quote objVal
;       intCodeGenCOERCE(objNew(lastCode,t1),t2)],t2)
;
;   val is ['COND,:conds] =>
;     objNew(['COND,
;       :[[p,wrapped2Quote objVal intCodeGenCOERCE(objNew(v,t1),t2)]
;         for [p,v] in conds]],t2)
;
;   -- specially handle subdomain
;   absolutelyCanCoerceByCheating(t1,t2) => objNew(val,t2)
;
;   -- specially handle coerce to Any
;   t2 = '(Any) => objNew(['CONS,MKQ t1,val],t2)
;
;   -- optimize coerces from Any
;   (t1 = '(Any)) and (val is [ ='CONS,t1',val']) =>
;     intCodeGenCOERCE(objNew(val',removeQuote t1'),t2)
;
;   -- specially handle coerce from Equation to Boolean
;   (t1 is ['Equation,:.]) and (t2 = $Boolean) =>
;     coerceByFunction(triple,t2)
;
;   -- next is hack for if-then-elses
;   (t1 = '$NoValueMode) and (val is ['COND,pred]) =>
;     code :=
;       ['COND,pred,
;         [MKQ true,['throwKeyedMsg,MKQ "S2IM0016",MKQ $mapName]]]
;     objNew(code,t2)
;
;   -- optimize coerces to OutputForm
;   t2 = $OutputForm =>
;     coerceByFunction(triple,t2)
;
;   isSubDomain(t1, $Integer) =>
;     intCodeGenCOERCE(objNew(val, $Integer), t2)
;
;   -- generate code
;   -- 1. See if the coercion will go through (absolutely)
;   --    Must be careful about variables or else things like
;   --    P I --> P[x] P I might not have the x in the original polynomial
;   --    put in the correct place
;
;   (not containsVariables(t2)) and canCoerceByFunction(t1,t2) =>
;     -- try coerceByFunction
;     (not canCoerceByMap(t1,t2)) and
;       (code := coerceByFunction(triple,t2)) => code
;     intCodeGenCoerce1(val,t1,t2)
;
;   -- 2. Set up a failure point otherwise
;
;   intCodeGenCoerce1(val,t1,t2)

(DEFUN |intCodeGenCOERCE| (|triple| |t2|)
  (PROG (|t1| |val| |ISTMP#1| |label| |ISTMP#2| |code| |l| |lastCode| |conds|
         |p| |v| |t1'| |val'| |pred|)
    (RETURN
     (PROGN
      (SETQ |t1| (|objMode| |triple|))
      (COND ((EQUAL |t1| |$EmptyMode|) NIL) ((EQUAL |t1| |t2|) |triple|)
            (#1='T
             (PROGN
              (SETQ |val| (|objVal| |triple|))
              (COND
               ((AND (CONSP |val|) (EQ (CAR |val|) 'THROW)
                     (PROGN
                      (SETQ |ISTMP#1| (CDR |val|))
                      (AND (CONSP |ISTMP#1|)
                           (PROGN
                            (SETQ |label| (CAR |ISTMP#1|))
                            (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                            (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                 (PROGN (SETQ |code| (CAR |ISTMP#2|)) #1#))))))
                (PROGN
                 (COND
                  ((AND (CONSP |label|) (EQ (CAR |label|) 'QUOTE)
                        (PROGN
                         (SETQ |ISTMP#1| (CDR |label|))
                         (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                              (PROGN (SETQ |l| (CAR |ISTMP#1|)) #1#))))
                   (SETQ |label| |l|)))
                 (COND
                  ((OR (NULL |$compilingMap|)
                       (NOT (EQUAL |label| (|mapCatchName| |$mapName|))))
                   (|objNew|
                    (LIST 'THROW |label|
                          (|wrapped2Quote|
                           (|objVal|
                            (|intCodeGenCOERCE| (|objNew| |code| |t1|) |t2|))))
                    |t2|))
                  (#1# (|objNew| |val| |t2|)))))
               ((AND (CONSP |val|) (EQ (CAR |val|) 'PROGN)
                     (PROGN
                      (SETQ |ISTMP#1| (CDR |val|))
                      (AND (CONSP |ISTMP#1|)
                           (PROGN (SETQ |ISTMP#2| (REVERSE |ISTMP#1|)) #1#)
                           (CONSP |ISTMP#2|)
                           (PROGN
                            (SETQ |lastCode| (CAR |ISTMP#2|))
                            (SETQ |code| (CDR |ISTMP#2|))
                            #1#)
                           (PROGN (SETQ |code| (NREVERSE |code|)) #1#))))
                (|objNew|
                 (CONS 'PROGN
                       (APPEND |code|
                               (CONS
                                (|wrapped2Quote|
                                 (|objVal|
                                  (|intCodeGenCOERCE|
                                   (|objNew| |lastCode| |t1|) |t2|)))
                                NIL)))
                 |t2|))
               ((AND (CONSP |val|) (EQ (CAR |val|) 'COND)
                     (PROGN (SETQ |conds| (CDR |val|)) #1#))
                (|objNew|
                 (CONS 'COND
                       ((LAMBDA (|bfVar#63| |bfVar#62| |bfVar#61|)
                          (LOOP
                           (COND
                            ((OR (ATOM |bfVar#62|)
                                 (PROGN
                                  (SETQ |bfVar#61| (CAR |bfVar#62|))
                                  NIL))
                             (RETURN (NREVERSE |bfVar#63|)))
                            (#1#
                             (AND (CONSP |bfVar#61|)
                                  (PROGN
                                   (SETQ |p| (CAR |bfVar#61|))
                                   (SETQ |ISTMP#1| (CDR |bfVar#61|))
                                   (AND (CONSP |ISTMP#1|)
                                        (EQ (CDR |ISTMP#1|) NIL)
                                        (PROGN
                                         (SETQ |v| (CAR |ISTMP#1|))
                                         #1#)))
                                  (SETQ |bfVar#63|
                                          (CONS
                                           (LIST |p|
                                                 (|wrapped2Quote|
                                                  (|objVal|
                                                   (|intCodeGenCOERCE|
                                                    (|objNew| |v| |t1|)
                                                    |t2|))))
                                           |bfVar#63|)))))
                           (SETQ |bfVar#62| (CDR |bfVar#62|))))
                        NIL |conds| NIL))
                 |t2|))
               ((|absolutelyCanCoerceByCheating| |t1| |t2|)
                (|objNew| |val| |t2|))
               ((EQUAL |t2| '(|Any|))
                (|objNew| (LIST 'CONS (MKQ |t1|) |val|) |t2|))
               ((AND (EQUAL |t1| '(|Any|)) (CONSP |val|)
                     (EQUAL (CAR |val|) 'CONS)
                     (PROGN
                      (SETQ |ISTMP#1| (CDR |val|))
                      (AND (CONSP |ISTMP#1|)
                           (PROGN
                            (SETQ |t1'| (CAR |ISTMP#1|))
                            (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                            (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                 (PROGN (SETQ |val'| (CAR |ISTMP#2|)) #1#))))))
                (|intCodeGenCOERCE| (|objNew| |val'| (|removeQuote| |t1'|))
                 |t2|))
               ((AND (CONSP |t1|) (EQ (CAR |t1|) '|Equation|)
                     (EQUAL |t2| |$Boolean|))
                (|coerceByFunction| |triple| |t2|))
               ((AND (EQ |t1| '|$NoValueMode|) (CONSP |val|)
                     (EQ (CAR |val|) 'COND)
                     (PROGN
                      (SETQ |ISTMP#1| (CDR |val|))
                      (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                           (PROGN (SETQ |pred| (CAR |ISTMP#1|)) #1#))))
                (PROGN
                 (SETQ |code|
                         (LIST 'COND |pred|
                               (LIST (MKQ T)
                                     (LIST '|throwKeyedMsg| (MKQ 'S2IM0016)
                                           (MKQ |$mapName|)))))
                 (|objNew| |code| |t2|)))
               ((EQUAL |t2| |$OutputForm|) (|coerceByFunction| |triple| |t2|))
               ((|isSubDomain| |t1| |$Integer|)
                (|intCodeGenCOERCE| (|objNew| |val| |$Integer|) |t2|))
               ((AND (NULL (|containsVariables| |t2|))
                     (|canCoerceByFunction| |t1| |t2|))
                (COND
                 ((AND (NULL (|canCoerceByMap| |t1| |t2|))
                       (SETQ |code| (|coerceByFunction| |triple| |t2|)))
                  |code|)
                 (#1# (|intCodeGenCoerce1| |val| |t1| |t2|))))
               (#1# (|intCodeGenCoerce1| |val| |t1| |t2|))))))))))

; intCodeGenCoerce1(val,t1,t2) ==
;   -- Internal function to previous one
;   -- designed to ensure that we don't use coerceOrCroak on mappings
; --(t2 is ['Mapping,:.]) => THROW('coerceOrCroaker, 'croaked)
;   objNew(['coerceOrCroak,mkObjCode(['wrap,val],t1),
;         MKQ t2, MKQ $mapName],t2)

(DEFUN |intCodeGenCoerce1| (|val| |t1| |t2|)
  (PROG ()
    (RETURN
     (|objNew|
      (LIST '|coerceOrCroak| (|mkObjCode| (LIST '|wrap| |val|) |t1|) (MKQ |t2|)
            (MKQ |$mapName|))
      |t2|))))
