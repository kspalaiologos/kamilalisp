
; )package "BOOT"

(IN-PACKAGE "BOOT")

; DEFPARAMETER($mpolyTTRules, '( _
;   ((Resolve (RN) (mpoly1 x t1)) . (mpoly1 x (Resolve (RN) t1))) _
;   ((Resolve (UP x t1) (mpoly1 y t2)) . _
;     (Resolve t1 (mpoly1 (Incl x y) t2))) _
;   ((Resolve (mpoly1 x t1) (G t2)) . _
;     (mpoly1 x (G (VarEqual t1 t2)))) _
;   ((Resolve (VARIABLE x) (mpoly1 y t2)) . _
;     (mpoly1 (Incl x y) t2)) _
;   ((Resolve (mpoly1 x t1) (mpoly1 y t2)) . _
;     (mpoly1 (SetEqual x y) (Resolve t1 t2))) _
;   ((Resolve (mpoly1 x t1) (mpoly1 y t2)) . _
;     (mpoly1 x (Resolve t1 (mpoly1 (SetComp y x) t2)))) _
;   ((Resolve (mpoly1 x t1) (mpoly1 y t2)) . _
;     (mpoly1 y (Resolve (mpoly1 (SetComp x y) t1) t2))) _
;   ((Resolve (mpoly1 x t1) (mpoly1 y t2)) . _
;     (mpoly1 (SetInter x y) (Resolve _
;       (mpoly1 (SetDiff x y) t1) (mpoly1 (SetDiff y x) t2)))) _
;   ))

(DEFPARAMETER |$mpolyTTRules|
  '(((|Resolve| (RN) (|mpoly1| |x| |t1|)) |mpoly1| |x| (|Resolve| (RN) |t1|))
    ((|Resolve| (UP |x| |t1|) (|mpoly1| |y| |t2|)) |Resolve| |t1|
     (|mpoly1| (|Incl| |x| |y|) |t2|))
    ((|Resolve| (|mpoly1| |x| |t1|) (G |t2|)) |mpoly1| |x|
     (G (|VarEqual| |t1| |t2|)))
    ((|Resolve| (VARIABLE |x|) (|mpoly1| |y| |t2|)) |mpoly1| (|Incl| |x| |y|)
     |t2|)
    ((|Resolve| (|mpoly1| |x| |t1|) (|mpoly1| |y| |t2|)) |mpoly1|
     (|SetEqual| |x| |y|) (|Resolve| |t1| |t2|))
    ((|Resolve| (|mpoly1| |x| |t1|) (|mpoly1| |y| |t2|)) |mpoly1| |x|
     (|Resolve| |t1| (|mpoly1| (|SetComp| |y| |x|) |t2|)))
    ((|Resolve| (|mpoly1| |x| |t1|) (|mpoly1| |y| |t2|)) |mpoly1| |y|
     (|Resolve| (|mpoly1| (|SetComp| |x| |y|) |t1|) |t2|))
    ((|Resolve| (|mpoly1| |x| |t1|) (|mpoly1| |y| |t2|)) |mpoly1|
     (|SetInter| |x| |y|)
     (|Resolve| (|mpoly1| (|SetDiff| |x| |y|) |t1|)
      (|mpoly1| (|SetDiff| |y| |x|) |t2|)))))

; DEFPARAMETER($generalTTRules, '( _
;   ((Resolve (L (L t1)) (M t2)) . (M (Resolve t1 t2))) _
;   ((Resolve (EQ t1) (B)) . (B)) _
;   ((Resolve (SY) t1) . (Resolve (P (I)) t1)) _
;   ((Resolve (M t1) (SM x t2)) . (M (Resolve t1 t2))) _
;   ((Resolve (M t1) (RM x y t2)) . (M (Resolve t1 t2))) _
;   ((Resolve (SM x t1) (RM y y t2)) . _
;     (SM (VarEqual x y) (Resolve t1 t2))) _
;   ((Resolve (V t1) (L t2)) . (V (Resolve t1 t2))) _
;   ((Resolve (FR t1) (FR t2)) . (FR (Resolve t1 t2))) _
;   ((Resolve (F) (RN)) . (F) ) _
;  _
;   ((Resolve (OV x) (OV y)) . (OV (SetUnion x y))) _
;   ((Resolve (P t1) (UP y t2)) . (Resolve (P t1) t2)) _
;  _
;   ((Resolve (UP y t1) (G t2)) . (UP y (G (VarEqual t1 t2)))) _
;   ((Resolve (P t1) (P t2)) . (P (Resolve t1 t2))) _
;   ((Resolve (G t1) (G t2)) . (G (Resolve t1 t2))) _
;   ((Resolve (G t1) (P t2)) . (P (G (VarEqual t1 t2)))) _
;  _
;   ((Resolve (AF t1) (EF t2)) . (EF (Resolve t1 t2))) _
;   ((Resolve (AF t1) (LF t2)) . (LF (Resolve t1 t2))) _
;   ((Resolve (AF t1) (FE t2)) . (FE (Resolve t1 t2))) _
;   ((Resolve (EF t1) (LF t2)) . (LF (Resolve t1 t2))) _
;   ((Resolve (EF t1) (FE t2)) . (FE (Resolve t1 t2))) _
;   ((Resolve (LF t1) (FE t2)) . (FE (Resolve t1 t2))) _
;  _
;   ((Resolve (RN) (P t1)) . (P (Resolve (RN) t1))) _
;   ((Resolve (RN) (UP x t1)) . (UP x (Resolve (RN) t1))) _
;   ((Resolve (RN) (UPS x t1)) . (UPS x (Resolve (RN) t1))) _
;  _
;   ((Resolve (P t1) (AF t2)) . (AF (Resolve t1 t2 ))) _
;   ((Resolve (P t1) (EF t2)) . (EF (Resolve t1 t2 ))) _
;   ((Resolve (P t1) (LF t2)) . (LF (Resolve t1 t2 ))) _
;  _
;   ((Resolve (MP x t1) (DMP y t2)) . _
;     (MP (SetEqual x y) (Resolve t1 t2))) _
;   ((Resolve (MP x t1) (DMP y t2)) . _
;     (MP x (Resolve t1 (DMP (SetComp y x) t2)))) _
;   ((Resolve (MP x t1) (DMP y t2)) . _
;     (MP y (Resolve (MP (SetComp x y) t1) t2))) _
;   ((Resolve (MP x t1) (DMP y t2)) . _
;     (MP (SetInter x y) (Resolve _
;       (MP (SetDiff x y) t1) (DMP (SetDiff y x) t2)))) _
;  _
;   ((Resolve (MP x t1) (NDMP y t2)) . _
;     (MP (SetEqual x y) (Resolve t1 t2))) _
;   ((Resolve (MP x t1) (NDMP y t2)) . _
;     (MP x (Resolve t1 (NDMP (SetComp y x) t2)))) _
;   ((Resolve (MP x t1) (NDMP y t2)) . _
;     (MP y (Resolve (MP (SetComp x y) t1) t2))) _
;   ((Resolve (MP x t1) (NDMP y t2)) . _
;     (MP (SetInter x y) (Resolve _
;       (MP (SetDiff x y) t1) (NDMP (SetDiff y x) t2)))) _
;  _
;   ((Resolve (DMP x t1) (NDMP y t2)) . _
;     (DMP (SetEqual x y) (Resolve t1 t2))) _
;   ((Resolve (DMP x t1) (NDMP y t2)) . _
;     (DMP x (Resolve t1 (NDMP (SetComp y x) t2)))) _
;   ((Resolve (DMP x t1) (NDMP y t2)) . _
;     (DMP y (Resolve (DMP (SetComp x y) t1) t2))) _
;   ((Resolve (DMP x t1) (NDMP y t2)) . _
;     (DMP (SetInter x y) (Resolve _
;       (DMP (SetDiff x y) t1) (NDMP (SetDiff y x) t2)))) _
;   ))

(DEFPARAMETER |$generalTTRules|
  '(((|Resolve| (L (L |t1|)) (M |t2|)) M (|Resolve| |t1| |t2|))
    ((|Resolve| (EQ |t1|) (B)) B)
    ((|Resolve| (SY) |t1|) |Resolve| (P (I)) |t1|)
    ((|Resolve| (M |t1|) (SM |x| |t2|)) M (|Resolve| |t1| |t2|))
    ((|Resolve| (M |t1|) (RM |x| |y| |t2|)) M (|Resolve| |t1| |t2|))
    ((|Resolve| (SM |x| |t1|) (RM |y| |y| |t2|)) SM (|VarEqual| |x| |y|)
     (|Resolve| |t1| |t2|))
    ((|Resolve| (V |t1|) (L |t2|)) V (|Resolve| |t1| |t2|))
    ((|Resolve| (FR |t1|) (FR |t2|)) FR (|Resolve| |t1| |t2|))
    ((|Resolve| (F) (RN)) F)
    ((|Resolve| (OV |x|) (OV |y|)) OV (|SetUnion| |x| |y|))
    ((|Resolve| (P |t1|) (UP |y| |t2|)) |Resolve| (P |t1|) |t2|)
    ((|Resolve| (UP |y| |t1|) (G |t2|)) UP |y| (G (|VarEqual| |t1| |t2|)))
    ((|Resolve| (P |t1|) (P |t2|)) P (|Resolve| |t1| |t2|))
    ((|Resolve| (G |t1|) (G |t2|)) G (|Resolve| |t1| |t2|))
    ((|Resolve| (G |t1|) (P |t2|)) P (G (|VarEqual| |t1| |t2|)))
    ((|Resolve| (AF |t1|) (EF |t2|)) EF (|Resolve| |t1| |t2|))
    ((|Resolve| (AF |t1|) (LF |t2|)) LF (|Resolve| |t1| |t2|))
    ((|Resolve| (AF |t1|) (FE |t2|)) FE (|Resolve| |t1| |t2|))
    ((|Resolve| (EF |t1|) (LF |t2|)) LF (|Resolve| |t1| |t2|))
    ((|Resolve| (EF |t1|) (FE |t2|)) FE (|Resolve| |t1| |t2|))
    ((|Resolve| (LF |t1|) (FE |t2|)) FE (|Resolve| |t1| |t2|))
    ((|Resolve| (RN) (P |t1|)) P (|Resolve| (RN) |t1|))
    ((|Resolve| (RN) (UP |x| |t1|)) UP |x| (|Resolve| (RN) |t1|))
    ((|Resolve| (RN) (UPS |x| |t1|)) UPS |x| (|Resolve| (RN) |t1|))
    ((|Resolve| (P |t1|) (AF |t2|)) AF (|Resolve| |t1| |t2|))
    ((|Resolve| (P |t1|) (EF |t2|)) EF (|Resolve| |t1| |t2|))
    ((|Resolve| (P |t1|) (LF |t2|)) LF (|Resolve| |t1| |t2|))
    ((|Resolve| (MP |x| |t1|) (DMP |y| |t2|)) MP (|SetEqual| |x| |y|)
     (|Resolve| |t1| |t2|))
    ((|Resolve| (MP |x| |t1|) (DMP |y| |t2|)) MP |x|
     (|Resolve| |t1| (DMP (|SetComp| |y| |x|) |t2|)))
    ((|Resolve| (MP |x| |t1|) (DMP |y| |t2|)) MP |y|
     (|Resolve| (MP (|SetComp| |x| |y|) |t1|) |t2|))
    ((|Resolve| (MP |x| |t1|) (DMP |y| |t2|)) MP (|SetInter| |x| |y|)
     (|Resolve| (MP (|SetDiff| |x| |y|) |t1|) (DMP (|SetDiff| |y| |x|) |t2|)))
    ((|Resolve| (MP |x| |t1|) (NDMP |y| |t2|)) MP (|SetEqual| |x| |y|)
     (|Resolve| |t1| |t2|))
    ((|Resolve| (MP |x| |t1|) (NDMP |y| |t2|)) MP |x|
     (|Resolve| |t1| (NDMP (|SetComp| |y| |x|) |t2|)))
    ((|Resolve| (MP |x| |t1|) (NDMP |y| |t2|)) MP |y|
     (|Resolve| (MP (|SetComp| |x| |y|) |t1|) |t2|))
    ((|Resolve| (MP |x| |t1|) (NDMP |y| |t2|)) MP (|SetInter| |x| |y|)
     (|Resolve| (MP (|SetDiff| |x| |y|) |t1|) (NDMP (|SetDiff| |y| |x|) |t2|)))
    ((|Resolve| (DMP |x| |t1|) (NDMP |y| |t2|)) DMP (|SetEqual| |x| |y|)
     (|Resolve| |t1| |t2|))
    ((|Resolve| (DMP |x| |t1|) (NDMP |y| |t2|)) DMP |x|
     (|Resolve| |t1| (NDMP (|SetComp| |y| |x|) |t2|)))
    ((|Resolve| (DMP |x| |t1|) (NDMP |y| |t2|)) DMP |y|
     (|Resolve| (DMP (|SetComp| |x| |y|) |t1|) |t2|))
    ((|Resolve| (DMP |x| |t1|) (NDMP |y| |t2|)) DMP (|SetInter| |x| |y|)
     (|Resolve| (DMP (|SetDiff| |x| |y|) |t1|)
      (NDMP (|SetDiff| |y| |x|) |t2|)))))

; createResolveTTRules(nameList, abList) ==
;   -- expand multivariate polynomial rules
;   mps := '(MP DMP NDMP)
;   mpRules := "append"/[SUBST(mp,'mpoly1,$mpolyTTRules) for mp in mps]
;   $Res := CONS('(t1 t2 x y),
;     EQSUBSTLIST(nameList, abList, append($generalTTRules, mpRules)))
;   true

(DEFUN |createResolveTTRules| (|nameList| |abList|)
  (PROG (|mps| |mpRules|)
    (RETURN
     (PROGN
      (SETQ |mps| '(MP DMP NDMP))
      (SETQ |mpRules|
              ((LAMBDA (|bfVar#2| |bfVar#1| |mp|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#1|)
                        (PROGN (SETQ |mp| (CAR |bfVar#1|)) NIL))
                    (RETURN |bfVar#2|))
                   ('T
                    (SETQ |bfVar#2|
                            (APPEND |bfVar#2|
                                    (SUBST |mp| '|mpoly1| |$mpolyTTRules|)))))
                  (SETQ |bfVar#1| (CDR |bfVar#1|))))
               NIL |mps| NIL))
      (SETQ |$Res|
              (CONS '(|t1| |t2| |x| |y|)
                    (EQSUBSTLIST |nameList| |abList|
                     (APPEND |$generalTTRules| |mpRules|))))
      T))))

; DEFPARAMETER($mpolyTMRules, '( _
;   ((Resolve (mpoly1 x t1) (P t2)) . (Resolve t1 (P t2))) _
;   ((Resolve (mpoly1 (x) t1) (UP x t2)) . (UP x (Resolve t1 t2))) _
;   ((Resolve (mpoly1 x t1) (UP y t2)) . _
;     (UP y (Resolve (mpoly1 (Diff x y) t1) t2))) _
;   ((Resolve (UP x t1) (mpoly1 y t2)) . _
;     (Resolve t1 (mpoly1 (Incl x y) t2))) _
;   ((Resolve (VARIABLE x) (mpoly1 y t2)) . _
;     (mpoly1 (Incl x y) (Resolve (I) t2))) _
;   ((Resolve (mpoly1 x t1) (mpoly2 y t2)) . _
;     (Resolve t1 (mpoly2 (SetIncl x y) t2))) _
;   ((Resolve (mpoly1 x t1) (mpoly2 y t2)) . _
;     (mpoly2 y (Resolve (mpoly1 (SetComp x y) t1) t2))) _
;   ((Resolve (mpoly1 x t1) (mpoly2 y t2)) . _
;     (Resolve (mpoly1 (SetDiff x y) t1) (mpoly2 y t2))) _
;  ))

(DEFPARAMETER |$mpolyTMRules|
  '(((|Resolve| (|mpoly1| |x| |t1|) (P |t2|)) |Resolve| |t1| (P |t2|))
    ((|Resolve| (|mpoly1| (|x|) |t1|) (UP |x| |t2|)) UP |x|
     (|Resolve| |t1| |t2|))
    ((|Resolve| (|mpoly1| |x| |t1|) (UP |y| |t2|)) UP |y|
     (|Resolve| (|mpoly1| (|Diff| |x| |y|) |t1|) |t2|))
    ((|Resolve| (UP |x| |t1|) (|mpoly1| |y| |t2|)) |Resolve| |t1|
     (|mpoly1| (|Incl| |x| |y|) |t2|))
    ((|Resolve| (VARIABLE |x|) (|mpoly1| |y| |t2|)) |mpoly1| (|Incl| |x| |y|)
     (|Resolve| (I) |t2|))
    ((|Resolve| (|mpoly1| |x| |t1|) (|mpoly2| |y| |t2|)) |Resolve| |t1|
     (|mpoly2| (|SetIncl| |x| |y|) |t2|))
    ((|Resolve| (|mpoly1| |x| |t1|) (|mpoly2| |y| |t2|)) |mpoly2| |y|
     (|Resolve| (|mpoly1| (|SetComp| |x| |y|) |t1|) |t2|))
    ((|Resolve| (|mpoly1| |x| |t1|) (|mpoly2| |y| |t2|)) |Resolve|
     (|mpoly1| (|SetDiff| |x| |y|) |t1|) (|mpoly2| |y| |t2|))))

; DEFPARAMETER($generalTMRules, '( _
;   ((Resolve (VARIABLE x) (P t1)) . (P (Resolve (I) t1))) _
;   ((Resolve (VARIABLE x) (UP y t1)) . _
;     (UP (VarEqual x y) (Resolve (I) t1))) _
;   ((Resolve (VARIABLE x) (UPS y t1)) . _
;     (UPS (VarEqual x y) (Resolve (I) t1))) _
;   ((Resolve (VARIABLE x) (EF t1)) . (EF t1)) _
;   ((Resolve (L (L (SY))) (M _*_*)) . (M (P (I)))) _
;   ((Resolve (L (L (SY))) (SM x _*_*)) . (SM x (P (I)))) _
;   ((Resolve (L (L t1)) (M t2)) . (M (Resolve t1 t2))) _
;   ((Resolve (L (L t1)) (SM x t2)) . (SM x (Resolve t1 t2))) _
;   ((Resolve (L (L t1)) (RM x y t2)) . (RM x y (Resolve t1 t2))) _
;   ((Resolve (SY) t1) . (Resolve (P (I)) t1)) _
;   ((Resolve (VARIABLE x) t1) . (Resolve (P (I)) t1)) _
;   ((Resolve (SM x t1) (M t2)) . (M (Resolve t1 t2))) _
;   ((Resolve (RM x y t1) (M t2)) . (M (Resolve t1 t2))) _
;  _
;   ((Resolve (M t1) (L _*_*)) . (L (L t1))) _
;   ((Resolve (SM x t1) (L _*_*)) . (L (L t1))) _
;   ((Resolve (RM x y t1) (L _*_*)) . (L (L t1))) _
;   ((Resolve (M t1) (L t2)) . (L (Resolve (L t1) t2))) _
;   ((Resolve (SM x t1) (L t2)) . (L (Resolve (L t1) t2))) _
;   ((Resolve (RM x y t1) (L t2)) . (L (Resolve (L t1) t2))) _
;  _
;   ((Resolve (M t1) (V _*_*)) . (V (V t1))) _
;   ((Resolve (SM x t1) (V _*_*)) . (V (V t1))) _
;   ((Resolve (RM x y t1) (V _*_*)) . (V (V t1))) _
;   ((Resolve (M t1) (V t2)) . (V (Resolve (V t1) t2))) _
;   ((Resolve (SM x t1) (V t2)) . (V (Resolve (V t1) t2))) _
;   ((Resolve (RM x y t1) (V t2)) . (V (Resolve (V t1) t2))) _
;  _
;   ((Resolve (L t1) (V t2)) . (V (Resolve t1 t2))) _
;   ((Resolve (V t1) (L t2)) . (L (Resolve t1 t2))) _
;   ((Resolve (FR t1) (FR t2)) . (FR (Resolve t1 t2))) _
;   ((Resolve (UP x t1) (P t2)) . (Resolve t1 (P t2))) _
;  ))

(DEFPARAMETER |$generalTMRules|
  '(((|Resolve| (VARIABLE |x|) (P |t1|)) P (|Resolve| (I) |t1|))
    ((|Resolve| (VARIABLE |x|) (UP |y| |t1|)) UP (|VarEqual| |x| |y|)
     (|Resolve| (I) |t1|))
    ((|Resolve| (VARIABLE |x|) (UPS |y| |t1|)) UPS (|VarEqual| |x| |y|)
     (|Resolve| (I) |t1|))
    ((|Resolve| (VARIABLE |x|) (EF |t1|)) EF |t1|)
    ((|Resolve| (L (L (SY))) (M **)) M (P (I)))
    ((|Resolve| (L (L (SY))) (SM |x| **)) SM |x| (P (I)))
    ((|Resolve| (L (L |t1|)) (M |t2|)) M (|Resolve| |t1| |t2|))
    ((|Resolve| (L (L |t1|)) (SM |x| |t2|)) SM |x| (|Resolve| |t1| |t2|))
    ((|Resolve| (L (L |t1|)) (RM |x| |y| |t2|)) RM |x| |y|
     (|Resolve| |t1| |t2|))
    ((|Resolve| (SY) |t1|) |Resolve| (P (I)) |t1|)
    ((|Resolve| (VARIABLE |x|) |t1|) |Resolve| (P (I)) |t1|)
    ((|Resolve| (SM |x| |t1|) (M |t2|)) M (|Resolve| |t1| |t2|))
    ((|Resolve| (RM |x| |y| |t1|) (M |t2|)) M (|Resolve| |t1| |t2|))
    ((|Resolve| (M |t1|) (L **)) L (L |t1|))
    ((|Resolve| (SM |x| |t1|) (L **)) L (L |t1|))
    ((|Resolve| (RM |x| |y| |t1|) (L **)) L (L |t1|))
    ((|Resolve| (M |t1|) (L |t2|)) L (|Resolve| (L |t1|) |t2|))
    ((|Resolve| (SM |x| |t1|) (L |t2|)) L (|Resolve| (L |t1|) |t2|))
    ((|Resolve| (RM |x| |y| |t1|) (L |t2|)) L (|Resolve| (L |t1|) |t2|))
    ((|Resolve| (M |t1|) (V **)) V (V |t1|))
    ((|Resolve| (SM |x| |t1|) (V **)) V (V |t1|))
    ((|Resolve| (RM |x| |y| |t1|) (V **)) V (V |t1|))
    ((|Resolve| (M |t1|) (V |t2|)) V (|Resolve| (V |t1|) |t2|))
    ((|Resolve| (SM |x| |t1|) (V |t2|)) V (|Resolve| (V |t1|) |t2|))
    ((|Resolve| (RM |x| |y| |t1|) (V |t2|)) V (|Resolve| (V |t1|) |t2|))
    ((|Resolve| (L |t1|) (V |t2|)) V (|Resolve| |t1| |t2|))
    ((|Resolve| (V |t1|) (L |t2|)) L (|Resolve| |t1| |t2|))
    ((|Resolve| (FR |t1|) (FR |t2|)) FR (|Resolve| |t1| |t2|))
    ((|Resolve| (UP |x| |t1|) (P |t2|)) |Resolve| |t1| (P |t2|))))

; DEFPARAMETER($newResolveAbbreviations, '( _
;     (P .  Polynomial) _
;     (G .  Complex) _
;     (L .  List) _
;     (M .  Matrix) _
;     (EQ . Equation) _
;     (B .  Boolean) _
;     (SY . Symbol) _
;     (I .  Integer) _
;     (SM . SquareMatrix) _
;     (RM . RectangularMatrix) _
;     (V .  Vector) _
;     (FR . Factored) _
;     (F .  Float) _
;     (OV . OrderedVariableList) _
;     (UP . UnivariatePolynomial) _
;     (DMP . DistributedMultivariatePolynomial) _
;     (MP . MultivariatePolynomial) _
;     (HDMP . HomogeneousDistributedMultivariatePolynomial) _
;     (QF . Fraction) _
;     (UPS . UnivariatePowerSeries) _
;     (VARIABLE . Variable) _
;  ))

(DEFPARAMETER |$newResolveAbbreviations|
  '((P . |Polynomial|) (G . |Complex|) (L . |List|) (M . |Matrix|)
    (EQ . |Equation|) (B . |Boolean|) (SY . |Symbol|) (I . |Integer|)
    (SM . |SquareMatrix|) (RM . |RectangularMatrix|) (V . |Vector|)
    (FR . |Factored|) (F . |Float|) (OV . |OrderedVariableList|)
    (UP . |UnivariatePolynomial|) (DMP . |DistributedMultivariatePolynomial|)
    (MP . |MultivariatePolynomial|)
    (HDMP . |HomogeneousDistributedMultivariatePolynomial|) (QF . |Fraction|)
    (UPS . |UnivariatePowerSeries|) (VARIABLE . |Variable|)))

; createResolveTMRules(nameList, abList) ==
;   -- expand multivariate polynomial rules
;   mps := '(MP DMP NDMP)
;   mpRules0 := "append"/[SUBST(mp,'mpoly1,$mpolyTMRules) for mp in mps]
;   mpRules := "append"/[SUBST(mp,'mpoly2,mpRules0) for mp in mps]
;   $ResMode := CONS('(t1 t2 x y),
;     EQSUBSTLIST(nameList, abList, append(mpRules, $generalTMRules)))
;   true

(DEFUN |createResolveTMRules| (|nameList| |abList|)
  (PROG (|mps| |mpRules0| |mpRules|)
    (RETURN
     (PROGN
      (SETQ |mps| '(MP DMP NDMP))
      (SETQ |mpRules0|
              ((LAMBDA (|bfVar#4| |bfVar#3| |mp|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#3|)
                        (PROGN (SETQ |mp| (CAR |bfVar#3|)) NIL))
                    (RETURN |bfVar#4|))
                   (#1='T
                    (SETQ |bfVar#4|
                            (APPEND |bfVar#4|
                                    (SUBST |mp| '|mpoly1| |$mpolyTMRules|)))))
                  (SETQ |bfVar#3| (CDR |bfVar#3|))))
               NIL |mps| NIL))
      (SETQ |mpRules|
              ((LAMBDA (|bfVar#6| |bfVar#5| |mp|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#5|)
                        (PROGN (SETQ |mp| (CAR |bfVar#5|)) NIL))
                    (RETURN |bfVar#6|))
                   (#1#
                    (SETQ |bfVar#6|
                            (APPEND |bfVar#6|
                                    (SUBST |mp| '|mpoly2| |mpRules0|)))))
                  (SETQ |bfVar#5| (CDR |bfVar#5|))))
               NIL |mps| NIL))
      (SETQ |$ResMode|
              (CONS '(|t1| |t2| |x| |y|)
                    (EQSUBSTLIST |nameList| |abList|
                     (APPEND |mpRules| |$generalTMRules|))))
      T))))

; initializeRuleSets() ==
;   abList := ASSOCLEFT $newResolveAbbreviations
;   nameList := ASSOCRIGHT $newResolveAbbreviations
;   createResolveTTRules(nameList, abList)
;   createResolveTMRules(nameList, abList)
;   $ruleSetsInitialized := true
;   true

(DEFUN |initializeRuleSets| ()
  (PROG (|nameList| |abList|)
    (RETURN
     (PROGN
      (SETQ |abList| (ASSOCLEFT |$newResolveAbbreviations|))
      (SETQ |nameList| (ASSOCRIGHT |$newResolveAbbreviations|))
      (|createResolveTTRules| |nameList| |abList|)
      (|createResolveTMRules| |nameList| |abList|)
      (SETQ |$ruleSetsInitialized| T)
      T))))
