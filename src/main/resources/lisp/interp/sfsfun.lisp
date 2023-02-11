
; )package "BOOT"

(IN-PACKAGE "BOOT")

; FloatError(formatstring,arg) ==
; --        ERROR(formatstring,arg)
;         ERROR FORMAT([],formatstring,arg)

(DEFUN |FloatError| (|formatstring| |arg|)
  (PROG () (RETURN (ERROR (FORMAT NIL |formatstring| |arg|)))))

; float(x) == FLOAT(x, 0.0)

(DEFUN |float| (|x|) (PROG () (RETURN (FLOAT |x| 0.0))))

; fracpart(x) ==
;         CADR(MULTIPLE_-VALUE_-LIST(FLOOR(x)))

(DEFUN |fracpart| (|x|)
  (PROG () (RETURN (CADR (MULTIPLE-VALUE-LIST (FLOOR |x|))))))

; intpart(x) ==
;         first(MULTIPLE_-VALUE_-LIST(FLOOR(x)))

(DEFUN |intpart| (|x|)
  (PROG () (RETURN (CAR (MULTIPLE-VALUE-LIST (FLOOR |x|))))))

; negintp(x) ==
;         if ZEROP IMAGPART(x) and x<0.0 and ZEROP fracpart(x)
;         then
;                 true
;         else
;                 false

(DEFUN |negintp| (|x|)
  (PROG ()
    (RETURN
     (COND
      ((AND (ZEROP (IMAGPART |x|)) (< |x| 0.0) (ZEROP (|fracpart| |x|))) T)
      ('T NIL)))))

; DEFCONSTANT(dfPi, 3.14159265358979323846264338328)

(DEFCONSTANT |dfPi| 3.141592653589793)

; horner(l,x) ==
;         result := 0
;         for el in l repeat
;                 result := result *x + el
;         return result

(DEFUN |horner| (|l| |x|)
  (PROG (|result|)
    (RETURN
     (PROGN
      (SETQ |result| 0)
      ((LAMBDA (|bfVar#1| |el|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#1|) (PROGN (SETQ |el| (CAR |bfVar#1|)) NIL))
            (RETURN NIL))
           ('T (SETQ |result| (+ (* |result| |x|) |el|))))
          (SETQ |bfVar#1| (CDR |bfVar#1|))))
       |l| NIL)
      (RETURN |result|)))))

; r_gamma (x) ==
;         if COMPLEXP(x) then FloatError('"Gamma not implemented for complex value ~D",x)
;         ZEROP (x-1.0) => 1.0
;         if x>20 then gammaStirling(x) else gammaRatapprox(x)

(DEFUN |r_gamma| (|x|)
  (PROG ()
    (RETURN
     (PROGN
      (COND
       ((COMPLEXP |x|)
        (|FloatError| "Gamma not implemented for complex value ~D" |x|)))
      (COND ((ZEROP (- |x| 1.0)) 1.0)
            (#1='T
             (COND ((< 20 |x|) (|gammaStirling| |x|))
                   (#1# (|gammaRatapprox| |x|)))))))))

; r_lngamma (x) ==
;         if x>20 then lnrgammaRatapprox(x) else LOG(gammaRatapprox(x))

(DEFUN |r_lngamma| (|x|)
  (PROG ()
    (RETURN
     (COND ((< 20 |x|) (|lnrgammaRatapprox| |x|))
           ('T (LOG (|gammaRatapprox| |x|)))))))

; cbeta(z,w) ==
;         cgamma(z)*cgamma(w)/(cgamma(z+w))

(DEFUN |cbeta| (|z| |w|)
  (PROG ()
    (RETURN (/ (* (|cgamma| |z|) (|cgamma| |w|)) (|cgamma| (+ |z| |w|))))))

; gammaStirling(x) ==
;        EXP(r_lngamma(x))

(DEFUN |gammaStirling| (|x|) (PROG () (RETURN (EXP (|r_lngamma| |x|)))))

; lnrgammaRatapprox(x) ==
;        (x-.5)*LOG(x) - x + LOG(SQRT(2.0*dfPi)) + phiRatapprox(x)

(DEFUN |lnrgammaRatapprox| (|x|)
  (PROG ()
    (RETURN
     (+ (+ (- (* (- |x| 0.5) (LOG |x|)) |x|) (LOG (SQRT (* 2.0 |dfPi|))))
        (|phiRatapprox| |x|)))))

; phiRatapprox(x) ==
;         arg := 1/(x^2)
;         p := horner([.0666629070402007526,_
;                      .6450730291289920251389,_
;                      .670827838343321349614617,_
;                      .12398282342474941538685913],arg);
;         q := horner([1.0,7.996691123663644194772,_
;                       8.09952718948975574728214,_
;                       1.48779388109699298468156],arg);
;         result := p/(x*q)
;         result

(DEFUN |phiRatapprox| (|x|)
  (PROG (|arg| |p| |q| |result|)
    (RETURN
     (PROGN
      (SETQ |arg| (/ 1 (EXPT |x| 2)))
      (SETQ |p|
              (|horner|
               (LIST 0.06666290704020075 0.6450730291289921 0.6708278383433213
                     0.12398282342474941)
               |arg|))
      (SETQ |q|
              (|horner|
               (LIST 1.0 7.996691123663643 8.099527189489756
                     1.4877938810969928)
               |arg|))
      (SETQ |result| (/ |p| (* |x| |q|)))
      |result|))))

; gammaRatapprox (x) ==
;         if (x>=2 and x<=3)
;         then
;                 result := gammaRatkernel(x)
;         else
;                 if x>3
;                 then
;                      n := FLOOR(x)-2
;                      a := x-n-2
;                      reducedarg := 2+a
;                      prod := */[reducedarg+i for i in 0..n-1]
;                      result := prod* gammaRatapprox(reducedarg)
;                 else
;                    if (2>x and x>0)
;                    then
;                      n := 2-FLOOR(x)
;                      a := x-FLOOR(x)
;                      reducedarg := 2+a
;                      prod := */[x+i for i in 0..n-1]
;                      result := gammaRatapprox(reducedarg)/prod
;                  else
;                         Pi := dfPi
;                         lx := MULTIPLE_-VALUE_-LIST(FLOOR(x))
;                         intpartx := first(lx)+1
;                         restx := CADR(lx)
;                         if ZEROP restx  -- case of negative non-integer value
;                         then
;                           FloatError ('"Gamma undefined for non-positive integers: ~D",x)
;                         else
;                           result := Pi/(gammaRatapprox(1.0-x)*(-1.0)^(intpartx+1)*SIN(restx*Pi))
;         result

(DEFUN |gammaRatapprox| (|x|)
  (PROG (|result| |n| |a| |reducedarg| |prod| |Pi| |lx| |intpartx| |restx|)
    (RETURN
     (PROGN
      (COND
       ((AND (NOT (< |x| 2)) (NOT (< 3 |x|)))
        (SETQ |result| (|gammaRatkernel| |x|)))
       ((< 3 |x|) (SETQ |n| (- (FLOOR |x|) 2)) (SETQ |a| (- (- |x| |n|) 2))
        (SETQ |reducedarg| (+ 2 |a|))
        (SETQ |prod|
                ((LAMBDA (|bfVar#3| |bfVar#2| |i|)
                   (LOOP
                    (COND ((> |i| |bfVar#2|) (RETURN |bfVar#3|))
                          (#1='T
                           (SETQ |bfVar#3|
                                   (* |bfVar#3| (+ |reducedarg| |i|)))))
                    (SETQ |i| (+ |i| 1))))
                 1 (- |n| 1) 0))
        (SETQ |result| (* |prod| (|gammaRatapprox| |reducedarg|))))
       ((AND (< |x| 2) (< 0 |x|)) (SETQ |n| (- 2 (FLOOR |x|)))
        (SETQ |a| (- |x| (FLOOR |x|))) (SETQ |reducedarg| (+ 2 |a|))
        (SETQ |prod|
                ((LAMBDA (|bfVar#5| |bfVar#4| |i|)
                   (LOOP
                    (COND ((> |i| |bfVar#4|) (RETURN |bfVar#5|))
                          (#1# (SETQ |bfVar#5| (* |bfVar#5| (+ |x| |i|)))))
                    (SETQ |i| (+ |i| 1))))
                 1 (- |n| 1) 0))
        (SETQ |result| (/ (|gammaRatapprox| |reducedarg|) |prod|)))
       (#1# (SETQ |Pi| |dfPi|) (SETQ |lx| (MULTIPLE-VALUE-LIST (FLOOR |x|)))
        (SETQ |intpartx| (+ (CAR |lx|) 1)) (SETQ |restx| (CADR |lx|))
        (COND
         ((ZEROP |restx|)
          (|FloatError| "Gamma undefined for non-positive integers: ~D" |x|))
         (#1#
          (SETQ |result|
                  (/ |Pi|
                     (*
                      (* (|gammaRatapprox| (- 1.0 |x|))
                         (EXPT (- 1.0) (+ |intpartx| 1)))
                      (SIN (* |restx| |Pi|)))))))))
      |result|))))

; gammaRatkernel(x) ==
;            p := horner(REVERSE([3786.01050348257245475108,_
;                         2077.45979389418732098416,_
;                         893.58180452374981423868,_
;                         222.1123961680117948396,_
;                         48.95434622790993805232,_
;                         6.12606745033608429879,_
;                         .778079585613300575867]),x-2)
;            q := horner(REVERSE([3786.01050348257187258861,_
;                         476.79386050368791516095,_
;                         -867.23098753110299445707,_
;                         83.55005866791976957459,_
;                         50.78847532889540973716,_
;                         -13.40041478578134826274,_
;                         1]),x-2.0)
;            p/q

(DEFUN |gammaRatkernel| (|x|)
  (PROG (|p| |q|)
    (RETURN
     (PROGN
      (SETQ |p|
              (|horner|
               (REVERSE
                (LIST 3786.0105034825724 2077.4597938941874 893.5818045237497
                      222.11239616801177 48.95434622790993 6.126067450336084
                      0.7780795856133006))
               (- |x| 2)))
      (SETQ |q|
              (|horner|
               (REVERSE
                (LIST 3786.010503482572 476.79386050368794 (- 867.230987531103)
                      83.55005866791977 50.7884753288954 (- 13.400414785781347)
                      1))
               (- |x| 2.0)))
      (/ |p| |q|)))))

; cgammat(x) ==
;         MAX(0.1, MIN(10.0, 10.0*SQRT(2.0) - ABS(x)))

(DEFUN |cgammat| (|x|)
  (PROG () (RETURN (MAX 0.1 (MIN 10.0 (- (* 10.0 (SQRT 2.0)) (ABS |x|)))))))

; cgamma (z) ==
;         z2 := IMAGPART(z)
;         z1 := REALPART(z)       --- call real valued gamma if z is real
;         if ZEROP z2
;         then    result := r_gamma(z1)
;         else
;                 result := clngamma(z1,z2,z)
;                 result := EXP(result)
;         result

(DEFUN |cgamma| (|z|)
  (PROG (|z2| |z1| |result|)
    (RETURN
     (PROGN
      (SETQ |z2| (IMAGPART |z|))
      (SETQ |z1| (REALPART |z|))
      (COND ((ZEROP |z2|) (SETQ |result| (|r_gamma| |z1|)))
            ('T (SETQ |result| (|clngamma| |z1| |z2| |z|))
             (SETQ |result| (EXP |result|))))
      |result|))))

; lncgamma(z) ==
;    clngamma(REALPART z, IMAGPART z, z)

(DEFUN |lncgamma| (|z|)
  (PROG () (RETURN (|clngamma| (REALPART |z|) (IMAGPART |z|) |z|))))

; clngamma(z1,z2,z) ==
;         --- conjugate of gamma is gamma of conjugate.  map 2nd and 4th quads
;         --- to first and third quadrants
;         if z1<0.0
;         then if z2 > 0.0
;                 then result := CONJUGATE(clngammacase1(z1,-z2,COMPLEX(z1,-z2)))
;                 else result := clngammacase1(z1,z2,z)
;         else if z2 < 0.0
;                 then result := CONJUGATE(clngammacase23(z1,-z2,_
;                                 COMPLEX(z1,-z2)))
;                 else result := clngammacase23(z1,z2,z)
;         result

(DEFUN |clngamma| (|z1| |z2| |z|)
  (PROG (|result|)
    (RETURN
     (PROGN
      (COND
       ((< |z1| 0.0)
        (COND
         ((< 0.0 |z2|)
          (SETQ |result|
                  (CONJUGATE
                   (|clngammacase1| |z1| (- |z2|) (COMPLEX |z1| (- |z2|))))))
         (#1='T (SETQ |result| (|clngammacase1| |z1| |z2| |z|)))))
       ((< |z2| 0.0)
        (SETQ |result|
                (CONJUGATE
                 (|clngammacase23| |z1| (- |z2|) (COMPLEX |z1| (- |z2|))))))
       (#1# (SETQ |result| (|clngammacase23| |z1| |z2| |z|))))
      |result|))))

; clngammacase1(z1,z2,z) ==
;         result1 := PiMinusLogSinPi(z1,z2,z)
;         result2 := clngamma(1.0-z1,-z2,1.0-z)
;         result1-result2

(DEFUN |clngammacase1| (|z1| |z2| |z|)
  (PROG (|result1| |result2|)
    (RETURN
     (PROGN
      (SETQ |result1| (|PiMinusLogSinPi| |z1| |z2| |z|))
      (SETQ |result2| (|clngamma| (- 1.0 |z1|) (- |z2|) (- 1.0 |z|)))
      (- |result1| |result2|)))))

; PiMinusLogSinPi(z1,z2,z) ==
;         cgammaG(z1,z2)  - logH(z1,z2,z)

(DEFUN |PiMinusLogSinPi| (|z1| |z2| |z|)
  (PROG () (RETURN (- (|cgammaG| |z1| |z2|) (|logH| |z1| |z2| |z|)))))

; cgammaG(z1,z2) ==
;         LOG(2*dfPi) + dfPi*z2 - COMPLEX(0.0,1.0)*dfPi*(z1-.5)

(DEFUN |cgammaG| (|z1| |z2|)
  (PROG ()
    (RETURN
     (- (+ (LOG (* 2 |dfPi|)) (* |dfPi| |z2|))
        (* (* (COMPLEX 0.0 1.0) |dfPi|) (- |z1| 0.5))))))

; logH(z1,z2,z) ==
;         z1bar := CADR(MULTIPLE_-VALUE_-LIST(FLOOR(z1))) ---frac part of z1
;         piz1bar := dfPi*z1bar
;         piz2 := dfPi*z2
;         twopiz2 := 2.0*piz2
;         i := COMPLEX(0.0,1.0)
;         part2 := EXP(twopiz2)*(2.0*SIN(piz1bar)^2 + SIN(2.0*piz1bar)*i)
;         part1 := -TANH(piz2)*(1.0+EXP(twopiz2))
; --- part1 is another way of saying 1 - exp(2*Pi*z1bar)
;         LOG(part1+part2)

(DEFUN |logH| (|z1| |z2| |z|)
  (PROG (|z1bar| |piz1bar| |piz2| |twopiz2| |i| |part2| |part1|)
    (RETURN
     (PROGN
      (SETQ |z1bar| (CADR (MULTIPLE-VALUE-LIST (FLOOR |z1|))))
      (SETQ |piz1bar| (* |dfPi| |z1bar|))
      (SETQ |piz2| (* |dfPi| |z2|))
      (SETQ |twopiz2| (* 2.0 |piz2|))
      (SETQ |i| (COMPLEX 0.0 1.0))
      (SETQ |part2|
              (* (EXP |twopiz2|)
                 (+ (* 2.0 (EXPT (SIN |piz1bar|) 2))
                    (* (SIN (* 2.0 |piz1bar|)) |i|))))
      (SETQ |part1| (- (* (TANH |piz2|) (+ 1.0 (EXP |twopiz2|)))))
      (LOG (+ |part1| |part2|))))))

; clngammacase23(z1,z2,z) ==
;         tz2 := cgammat(z2)
;         if (z1 < tz2)
;         then result:= clngammacase2(z1,z2,tz2,z)
;         else result:= clngammacase3(z)
;         result

(DEFUN |clngammacase23| (|z1| |z2| |z|)
  (PROG (|tz2| |result|)
    (RETURN
     (PROGN
      (SETQ |tz2| (|cgammat| |z2|))
      (COND
       ((< |z1| |tz2|) (SETQ |result| (|clngammacase2| |z1| |z2| |tz2| |z|)))
       ('T (SETQ |result| (|clngammacase3| |z|))))
      |result|))))

; clngammacase2(z1,z2,tz2,z) ==
;         n := float(CEILING(tz2-z1))
;         zpn := z+n
;         (z-.5)*LOG(zpn) - (zpn) + cgammaBernsum(zpn) - cgammaAdjust(logS(z1,z2,z,n,zpn))

(DEFUN |clngammacase2| (|z1| |z2| |tz2| |z|)
  (PROG (|n| |zpn|)
    (RETURN
     (PROGN
      (SETQ |n| (|float| (CEILING (- |tz2| |z1|))))
      (SETQ |zpn| (+ |z| |n|))
      (- (+ (- (* (- |z| 0.5) (LOG |zpn|)) |zpn|) (|cgammaBernsum| |zpn|))
         (|cgammaAdjust| (|logS| |z1| |z2| |z| |n| |zpn|)))))))

; logS(z1,z2,z,n,zpn) ==
;         sum := 0.0
;         for k in 0..(n-1) repeat
;                 if z1+k < 5.0 - 0.6*z2
;                 then sum := sum + LOG((z+k)/zpn)
;                 else sum := sum + LOG(1.0 - (n-k)/zpn)
;         sum

(DEFUN |logS| (|z1| |z2| |z| |n| |zpn|)
  (PROG (|sum|)
    (RETURN
     (PROGN
      (SETQ |sum| 0.0)
      ((LAMBDA (|bfVar#6| |k|)
         (LOOP
          (COND ((> |k| |bfVar#6|) (RETURN NIL))
                (#1='T
                 (COND
                  ((< (+ |z1| |k|) (- 5.0 (* 0.6000000000000001 |z2|)))
                   (SETQ |sum| (+ |sum| (LOG (/ (+ |z| |k|) |zpn|)))))
                  (#1#
                   (SETQ |sum|
                           (+ |sum| (LOG (- 1.0 (/ (- |n| |k|) |zpn|)))))))))
          (SETQ |k| (+ |k| 1))))
       (- |n| 1) 0)
      |sum|))))

; cgammaAdjust(z) ==
;         if IMAGPART(z)<0.0
;         then result := z + COMPLEX(0.0, 2.0*dfPi)
;         else result := z
;         result

(DEFUN |cgammaAdjust| (|z|)
  (PROG (|result|)
    (RETURN
     (PROGN
      (COND
       ((< (IMAGPART |z|) 0.0)
        (SETQ |result| (+ |z| (COMPLEX 0.0 (* 2.0 |dfPi|)))))
       ('T (SETQ |result| |z|)))
      |result|))))

; clngammacase3(z) ==
;         (z- .5)*LOG(z) - z + cgammaBernsum(z)

(DEFUN |clngammacase3| (|z|)
  (PROG ()
    (RETURN (+ (- (* (- |z| 0.5) (LOG |z|)) |z|) (|cgammaBernsum| |z|)))))

; cgammaBernsum (z) ==
;         sum := LOG(2.0*dfPi)/2.0
;         zterm := z
;         zsquaredinv := 1.0/(z*z)
;         l:= [.083333333333333333333, -.0027777777777777777778,_
;                 .00079365079365079365079,  -.00059523809523809523810,_
;                 .00084175084175084175084, -.0019175269175269175269,_
;                 .0064102564102564102564]
;         for m in 1..7 for el in l repeat
;                 zterm := zterm*zsquaredinv
;                 sum := sum + el*zterm
;         sum

(DEFUN |cgammaBernsum| (|z|)
  (PROG (|sum| |zterm| |zsquaredinv| |l|)
    (RETURN
     (PROGN
      (SETQ |sum| (/ (LOG (* 2.0 |dfPi|)) 2.0))
      (SETQ |zterm| |z|)
      (SETQ |zsquaredinv| (/ 1.0 (* |z| |z|)))
      (SETQ |l|
              (LIST 0.08333333333333331 (- 0.002777777777777778)
                    7.936507936507937e-4 (- 5.952380952380952e-4)
                    8.417508417508417e-4 (- 0.0019175269175269176)
                    0.006410256410256411))
      ((LAMBDA (|m| |bfVar#7| |el|)
         (LOOP
          (COND
           ((OR (> |m| 7) (ATOM |bfVar#7|)
                (PROGN (SETQ |el| (CAR |bfVar#7|)) NIL))
            (RETURN NIL))
           ('T
            (PROGN
             (SETQ |zterm| (* |zterm| |zsquaredinv|))
             (SETQ |sum| (+ |sum| (* |el| |zterm|))))))
          (SETQ |m| (+ |m| 1))
          (SETQ |bfVar#7| (CDR |bfVar#7|))))
       1 |l| NIL)
      |sum|))))

; $PsiAsymptoticBern := VECTOR(0.0, 0.1666666666666667, -0.03333333333333333, 0.02380952380952381,_
;               -0.03333333333333333, 0.07575757575757576, -0.2531135531135531, 1.166666666666667,_
;               -7.092156862745098, 54.97117794486216, -529.1242424242424, 6192.123188405797,_
;               -86580.25311355311, 1425517.166666667, -27298231.06781609, 601580873.9006424,_
;               -15116315767.09216, 429614643061.1667, -13711655205088.33, 488332318973593.2,_
;               -19296579341940070.0,  841693047573682600.0, -40338071854059460000.0)

(EVAL-WHEN (EVAL LOAD)
  (SETQ |$PsiAsymptoticBern|
          (VECTOR 0.0 0.16666666666666669 (- 0.03333333333333333)
                  0.02380952380952381 (- 0.03333333333333333)
                  0.07575757575757576 (- 0.2531135531135531) 1.1666666666666672
                  (- 7.092156862745099) 54.97117794486216 (- 529.1242424242424)
                  6192.123188405797 (- 86580.2531135531) 1425517.166666667
                  (- 2.729823106781609e7) 6.015808739006424e8
                  (- 1.5116315767092161e10) 4.2961464306116675e11
                  (- 1.371165520508833e13) 4.8833231897359325e14
                  (- 1.929657934194007e16) 8.416930475736827e17
                  (- 4.033807185405946e19))))

; PsiAsymptotic(n,x) ==
;         xn := x^n
;         xnp1 := xn*x
;         xsq := x*x
;         xterm := xsq
;         factterm := r_gamma(n+2)/2.0/r_gamma(float(n+1))
;         --- initialize to 1/n!
;         sum := AREF($PsiAsymptoticBern,1)*factterm/xterm
;         for k in 2..22 repeat
;                 xterm := xterm * xsq
;                 if n=0 then factterm := 1.0/float(2*k)
;                 else if n=1 then factterm := 1
;                 else factterm := factterm * float(2*k+n-1)*float(2*k+n-2)/(float(2*k)*float(2*k-1))
;                 sum := sum + AREF($PsiAsymptoticBern,k)*factterm/xterm
;         PsiEps(n,x) + 1.0/(2.0*xnp1) + 1.0/xn * sum

(DEFUN |PsiAsymptotic| (|n| |x|)
  (PROG (|xn| |xnp1| |xsq| |xterm| |factterm| |sum|)
    (RETURN
     (PROGN
      (SETQ |xn| (EXPT |x| |n|))
      (SETQ |xnp1| (* |xn| |x|))
      (SETQ |xsq| (* |x| |x|))
      (SETQ |xterm| |xsq|)
      (SETQ |factterm|
              (/ (/ (|r_gamma| (+ |n| 2)) 2.0)
                 (|r_gamma| (|float| (+ |n| 1)))))
      (SETQ |sum| (/ (* (AREF |$PsiAsymptoticBern| 1) |factterm|) |xterm|))
      ((LAMBDA (|k|)
         (LOOP
          (COND ((> |k| 22) (RETURN NIL))
                (#1='T
                 (PROGN
                  (SETQ |xterm| (* |xterm| |xsq|))
                  (COND
                   ((EQL |n| 0) (SETQ |factterm| (/ 1.0 (|float| (* 2 |k|)))))
                   ((EQL |n| 1) (SETQ |factterm| 1))
                   (#1#
                    (SETQ |factterm|
                            (/
                             (*
                              (* |factterm| (|float| (- (+ (* 2 |k|) |n|) 1)))
                              (|float| (- (+ (* 2 |k|) |n|) 2)))
                             (* (|float| (* 2 |k|))
                                (|float| (- (* 2 |k|) 1)))))))
                  (SETQ |sum|
                          (+ |sum|
                             (/ (* (AREF |$PsiAsymptoticBern| |k|) |factterm|)
                                |xterm|))))))
          (SETQ |k| (+ |k| 1))))
       2)
      (+ (+ (|PsiEps| |n| |x|) (/ 1.0 (* 2.0 |xnp1|)))
         (* (/ 1.0 |xn|) |sum|))))))

; PsiEps(n,x) ==
;         if n = 0
;         then
;                 result := -LOG(x)
;         else
;                 result :=  1.0/(float(n)*(x^n))
;         result

(DEFUN |PsiEps| (|n| |x|)
  (PROG (|result|)
    (RETURN
     (PROGN
      (COND ((EQL |n| 0) (SETQ |result| (- (LOG |x|))))
            ('T (SETQ |result| (/ 1.0 (* (|float| |n|) (EXPT |x| |n|))))))
      |result|))))

; PsiAsymptoticOrder(n,x,nterms) ==
;         sum := 0
;         xterm := 1.0
;         np1 := n+1
;         for k in 0..nterms repeat
;                 xterm := (x+float(k))^np1
;                 sum := sum + 1.0/xterm
;         sum

(DEFUN |PsiAsymptoticOrder| (|n| |x| |nterms|)
  (PROG (|sum| |xterm| |np1|)
    (RETURN
     (PROGN
      (SETQ |sum| 0)
      (SETQ |xterm| 1.0)
      (SETQ |np1| (+ |n| 1))
      ((LAMBDA (|k|)
         (LOOP
          (COND ((> |k| |nterms|) (RETURN NIL))
                ('T
                 (PROGN
                  (SETQ |xterm| (EXPT (+ |x| (|float| |k|)) |np1|))
                  (SETQ |sum| (+ |sum| (/ 1.0 |xterm|))))))
          (SETQ |k| (+ |k| 1))))
       0)
      |sum|))))

; r_psi(n,x) ==
;         if x<=0.0
;         then
;                 if ZEROP fracpart(x)
;                 then FloatError('"singularity encountered at ~D",x)
;                 else
;                         m := MOD(n,2)
;                         sign := (-1)^m
;                         if fracpart(x)=.5
;                         then
;                                 skipit := 1
;                         else
;                                 skipit := 0
;                         sign*((dfPi^(n + 1))*cotdiffeval(n, dfPi*(-x), skipit)
;                             + r_psi(n, 1.0 - x))
;         else if n=0
;         then
;                 - rPsiW(n,x)
;         else
;                 r_gamma(float(n+1))*rPsiW(n,x)*(-1)^MOD(n+1,2)

(DEFUN |r_psi| (|n| |x|)
  (PROG (|m| |sign| |skipit|)
    (RETURN
     (COND
      ((NOT (< 0.0 |x|))
       (COND
        ((ZEROP (|fracpart| |x|))
         (|FloatError| "singularity encountered at ~D" |x|))
        (#1='T (SETQ |m| (MOD |n| 2)) (SETQ |sign| (EXPT (- 1) |m|))
         (COND ((EQUAL (|fracpart| |x|) 0.5) (SETQ |skipit| 1))
               (#1# (SETQ |skipit| 0)))
         (* |sign|
            (+
             (* (EXPT |dfPi| (+ |n| 1))
                (|cotdiffeval| |n| (* |dfPi| (- |x|)) |skipit|))
             (|r_psi| |n| (- 1.0 |x|)))))))
      ((EQL |n| 0) (- (|rPsiW| |n| |x|)))
      (#1#
       (* (* (|r_gamma| (|float| (+ |n| 1))) (|rPsiW| |n| |x|))
          (EXPT (- 1) (MOD (+ |n| 1) 2))))))))

; rPsiW(n,x) ==
;         if (x <=0 or n < 0)
;         then
;                 HardError('"rPsiW not implemented for negative n or non-positive x")
;         nd := 6         -- magic number for number of digits in a word?
;         alpha := 3.5 + .40*nd
;         beta := 0.21 + (.008677e-3)*(nd-3) + (.0006038e-4)*(nd-3)^2
;         xmin := float(FLOOR(alpha + beta*n) + 1)
;         if n>0
;         then
;                 a := MIN(0,1.0/float(n)*LOG(DOUBLE_-FLOAT_-EPSILON/MIN(1.0,x)))
;                 c := EXP(a)
;                 if ABS(a) >= 0.001
;                 then
;                         fln := x/c*(1.0-c)
;                 else
;                         fln := -x*a/c
;                 bign := FLOOR(fln) + 1
; --- Amos says to use alternative series for large order if ordinary
; --- backwards recurrence too expensive
;                 if (bign < 15) and (xmin > 7.0+x)
;                 then
;                         return PsiAsymptoticOrder(n,x,bign)
;         if x>= xmin
;         then
;                 return PsiAsymptotic(n,x)
; ---ordinary case -- use backwards recursion
;         PsiBack(n,x,xmin)

(DEFUN |rPsiW| (|n| |x|)
  (PROG (|nd| |alpha| |beta| |xmin| |a| |c| |fln| |bign|)
    (RETURN
     (PROGN
      (COND
       ((OR (NOT (< 0 |x|)) (MINUSP |n|))
        (|HardError|
         "rPsiW not implemented for negative n or non-positive x")))
      (SETQ |nd| 6)
      (SETQ |alpha| (+ 3.5 (* 0.4 |nd|)))
      (SETQ |beta|
              (+ (+ 0.21 (* 8.677e-6 (- |nd| 3)))
                 (* 6.038e-8 (EXPT (- |nd| 3) 2))))
      (SETQ |xmin| (|float| (+ (FLOOR (+ |alpha| (* |beta| |n|))) 1)))
      (COND
       ((< 0 |n|)
        (SETQ |a|
                (MIN 0
                     (* (/ 1.0 (|float| |n|))
                        (LOG (/ DOUBLE-FLOAT-EPSILON (MIN 1.0 |x|))))))
        (SETQ |c| (EXP |a|))
        (COND
         ((NOT (< (ABS |a|) 0.001)) (SETQ |fln| (* (/ |x| |c|) (- 1.0 |c|))))
         ('T (SETQ |fln| (- (/ (* |x| |a|) |c|)))))
        (SETQ |bign| (+ (FLOOR |fln|) 1))
        (COND
         ((AND (< |bign| 15) (< (+ 7.0 |x|) |xmin|))
          (RETURN (|PsiAsymptoticOrder| |n| |x| |bign|))))))
      (COND ((NOT (< |x| |xmin|)) (RETURN (|PsiAsymptotic| |n| |x|))))
      (|PsiBack| |n| |x| |xmin|)))))

; PsiBack(n,x,xmin) ==
;         xintpart := PsiIntpart(x)
;         x0 := x-xintpart                ---frac part of x
;         result := PsiAsymptotic(n,x0+xmin+1.0)
;         for k in xmin..xintpart by -1 repeat
; --- Why not decrement from x?   See Amos p. 498
;                 result := result + 1.0/((x0 + float(k))^(n+1))
;         result

(DEFUN |PsiBack| (|n| |x| |xmin|)
  (PROG (|xintpart| |x0| |result|)
    (RETURN
     (PROGN
      (SETQ |xintpart| (|PsiIntpart| |x|))
      (SETQ |x0| (- |x| |xintpart|))
      (SETQ |result| (|PsiAsymptotic| |n| (+ (+ |x0| |xmin|) 1.0)))
      ((LAMBDA (|bfVar#8| |k|)
         (LOOP
          (COND
           ((COND ((MINUSP |bfVar#8|) (< |k| |xintpart|))
                  (T (> |k| |xintpart|)))
            (RETURN NIL))
           ('T
            (SETQ |result|
                    (+ |result|
                       (/ 1.0 (EXPT (+ |x0| (|float| |k|)) (+ |n| 1)))))))
          (SETQ |k| (+ |k| |bfVar#8|))))
       (- 1) |xmin|)
      |result|))))

; PsiIntpart(x) ==
;         if x<0
;         then
;                 result :=  -PsiInpart(-x)
;         else
;                 result := FLOOR(x)
;         return result

(DEFUN |PsiIntpart| (|x|)
  (PROG (|result|)
    (RETURN
     (PROGN
      (COND ((MINUSP |x|) (SETQ |result| (- (|PsiInpart| (- |x|)))))
            ('T (SETQ |result| (FLOOR |x|))))
      (RETURN |result|)))))

; cotdiffeval(n,z,skipit) ==
; ---skip=1 if arg z is known to be an exact multiple of Pi/2
;         a := MAKE_-ARRAY(n+2)
;         SETF(AREF(a,0),0.0)
;         SETF(AREF(a,1),1.0)
;         for i in 2..n repeat
;                 SETF(AREF(a,i),0.0)
;         for l in 1..n repeat
;                 m := MOD(l+1,2)
;                 for k in m..l+1 by 2 repeat
;                         if k<1
;                         then
;                                 t1 := 0
;                         else
;                                 t1 := -AREF(a,k-1)*(k-1)
;                         if k>l
;                         then
;                                 t2 := 0
;                         else
;                                 t2 := -AREF(a,k+1)*(k+1)
;                         SETF(AREF(a,k), t1+t2)
;         --- evaluate d^N/dX^N cot(z) via Horner-like rule
;         v := COT(z)
;         sq := v^2
;         s := AREF(a,n+1)
;         for i in (n-1)..0 by -2 repeat
;                 s := s*sq + AREF(a,i)
;         m := MOD(n,2)
;         if m=0
;         then
;                 s := s*v
;         if skipit=1
;         then
;                 if m=0
;                 then
;                         return 0
;                 else
;                         return AREF(a,0)
;         else
;                 return s

(DEFUN |cotdiffeval| (|n| |z| |skipit|)
  (PROG (|a| |m| |t1| |t2| |v| |sq| |s|)
    (RETURN
     (PROGN
      (SETQ |a| (MAKE-ARRAY (+ |n| 2)))
      (SETF (AREF |a| 0) 0.0)
      (SETF (AREF |a| 1) 1.0)
      ((LAMBDA (|i|)
         (LOOP
          (COND ((> |i| |n|) (RETURN NIL)) (#1='T (SETF (AREF |a| |i|) 0.0)))
          (SETQ |i| (+ |i| 1))))
       2)
      ((LAMBDA (|l|)
         (LOOP
          (COND ((> |l| |n|) (RETURN NIL))
                (#1#
                 (PROGN
                  (SETQ |m| (MOD (+ |l| 1) 2))
                  ((LAMBDA (|bfVar#9| |k|)
                     (LOOP
                      (COND ((> |k| |bfVar#9|) (RETURN NIL))
                            (#1#
                             (PROGN
                              (COND ((< |k| 1) (SETQ |t1| 0))
                                    (#1#
                                     (SETQ |t1|
                                             (-
                                              (* (AREF |a| (- |k| 1))
                                                 (- |k| 1))))))
                              (COND ((< |l| |k|) (SETQ |t2| 0))
                                    (#1#
                                     (SETQ |t2|
                                             (-
                                              (* (AREF |a| (+ |k| 1))
                                                 (+ |k| 1))))))
                              (SETF (AREF |a| |k|) (+ |t1| |t2|)))))
                      (SETQ |k| (+ |k| 2))))
                   (+ |l| 1) |m|))))
          (SETQ |l| (+ |l| 1))))
       1)
      (SETQ |v| (COT |z|))
      (SETQ |sq| (EXPT |v| 2))
      (SETQ |s| (AREF |a| (+ |n| 1)))
      ((LAMBDA (|bfVar#10| |i|)
         (LOOP
          (COND
           ((COND ((MINUSP |bfVar#10|) (< |i| 0)) (T (> |i| 0))) (RETURN NIL))
           (#1# (SETQ |s| (+ (* |s| |sq|) (AREF |a| |i|)))))
          (SETQ |i| (+ |i| |bfVar#10|))))
       (- 2) (- |n| 1))
      (SETQ |m| (MOD |n| 2))
      (COND ((EQL |m| 0) (SETQ |s| (* |s| |v|))))
      (COND
       ((EQL |skipit| 1)
        (COND ((EQL |m| 0) (RETURN 0)) (#1# (RETURN (AREF |a| 0)))))
       (#1# (RETURN |s|)))))))

; cPsi(n,z) ==
;         x := REALPART(z)
;         y := IMAGPART(z)
;         if ZEROP y
;         then    --- call real function if real
;                 return r_psi(n, x)
;         if y<0.0
;         then    -- if imagpart(z) negative, take conjugate of conjugate
;                 conjresult := cPsi(n,COMPLEX(x,-y))
;                 return COMPLEX(REALPART(conjresult),-IMAGPART(conjresult))
;         nterms := 22
;         bound := 10.0
;         if x<0.0 --- and ABS(z)>bound and ABS(y)<bound
;         then
;                 FloatError('"Psi implementation can't compute at ~S ",[n,z])
; ---             return cpsireflect(n,x,y,z)
;         else if (x>0.0 and ABS(z)>bound ) --- or (x<0.0 and ABS(y)>bound)
;         then
;                 return PsiXotic(n,PsiAsymptotic(n,z))
;         else            --- use recursion formula
;                 m := CEILING(SQRT(bound*bound - y*y) - x + 1.0)
;                 result := COMPLEX(0.0,0.0)
;                 for k in 0..(m-1) repeat
;                         result := result + 1.0/((z + float(k))^(n+1))
;                 return PsiXotic(n,result+PsiAsymptotic(n,z+m))

(DEFUN |cPsi| (|n| |z|)
  (PROG (|x| |y| |conjresult| |nterms| |bound| |m| |result|)
    (RETURN
     (PROGN
      (SETQ |x| (REALPART |z|))
      (SETQ |y| (IMAGPART |z|))
      (COND ((ZEROP |y|) (RETURN (|r_psi| |n| |x|))))
      (COND
       ((< |y| 0.0) (SETQ |conjresult| (|cPsi| |n| (COMPLEX |x| (- |y|))))
        (RETURN
         (COMPLEX (REALPART |conjresult|) (- (IMAGPART |conjresult|))))))
      (SETQ |nterms| 22)
      (SETQ |bound| 10.0)
      (COND
       ((< |x| 0.0)
        (|FloatError| "Psi implementation can't compute at ~S "
         (LIST |n| |z|)))
       ((AND (< 0.0 |x|) (< |bound| (ABS |z|)))
        (RETURN (|PsiXotic| |n| (|PsiAsymptotic| |n| |z|))))
       (#1='T
        (SETQ |m|
                (CEILING
                 (+ (- (SQRT (- (* |bound| |bound|) (* |y| |y|))) |x|) 1.0)))
        (SETQ |result| (COMPLEX 0.0 0.0))
        ((LAMBDA (|bfVar#11| |k|)
           (LOOP
            (COND ((> |k| |bfVar#11|) (RETURN NIL))
                  (#1#
                   (SETQ |result|
                           (+ |result|
                              (/ 1.0
                                 (EXPT (+ |z| (|float| |k|)) (+ |n| 1)))))))
            (SETQ |k| (+ |k| 1))))
         (- |m| 1) 0)
        (RETURN
         (|PsiXotic| |n| (+ |result| (|PsiAsymptotic| |n| (+ |z| |m|)))))))))))

; PsiXotic(n,result) ==
;         r_gamma(float(n+1))*(-1)^MOD(n+1,2)*result

(DEFUN |PsiXotic| (|n| |result|)
  (PROG ()
    (RETURN
     (* (* (|r_gamma| (|float| (+ |n| 1))) (EXPT (- 1) (MOD (+ |n| 1) 2)))
        |result|))))

; chebf01 (c,z) ==
; --- w scale factor so that 0<z/w<1
; --- n    n+2 coefficients will be produced stored in an array
; ---  indexed from 0 to n+1.
; --- See Luke's books for further explanation
;         n := 75 --- ad hoc decision
; ---     if ABS(z)/ABS(c) > 200.0 and ABS(z)>10000.0
; ---     then
; ---             FloatError('"cheb0F1 not implemented for ~S < 1",[c,z])
;         w := 2.0*z
; --- arr will be used to store the Cheb. series coefficients
;         four:= 4.0
;         start := EXPT(10.0, -200)
;         n1 := n+1
;         n2 := n+2
;         a3 := 0.0
;         a2 := 0.0
;         a1 := start     -- arbitrary starting value
;         z1 := four/w
;         ncount := n1
;         arr := MAKE_-ARRAY(n2)
;         SETF(AREF(arr,ncount) , start)  -- start off
;         x1 := n2
;         c1 := 1.0 - c
;         for ncount in n..0 by -1 repeat
;                 divfac := 1.0/x1
;                 x1 := x1 -1.0
;                 SETF(AREF(arr,ncount) ,_
;                         x1*((divfac+z1*(x1-c1))*a1 +_
;                         (1.0/x1 + z1*(x1+c1+1.0))*a2-divfac*a3))
;                 a3 := a2
;                 a2 := a1
;                 a1 := AREF(arr,ncount)
;         SETF(AREF(arr,0),AREF(arr,0)/2.0)
; --  compute scale factor
;         rho := AREF(arr,0)
;         sum := rho
;         p := 1.0
;         for i in 1..n1 repeat
;                 rho := rho - p*AREF(arr,i)
;                 sum := sum+AREF(arr,i)
;                 p := -p
;         for l in 0..n1 repeat
;                 SETF(AREF(arr,l), AREF(arr,l)/rho)
;         sum := sum/rho
; ---     Now evaluate array at argument
;         b := 0.0
;         temp := 0.0
;         for i in (n+1)..0 by -1 repeat
;                 cc := b
;                 b := temp
;                 temp := -cc + AREF(arr,i)
;         temp

(DEFUN |chebf01| (|c| |z|)
  (PROG (|n| |w| |four| |start| |n1| |n2| |a3| |a2| |a1| |z1| |ncount| |arr|
         |x1| |c1| |divfac| |rho| |sum| |p| |b| |temp| |cc|)
    (RETURN
     (PROGN
      (SETQ |n| 75)
      (SETQ |w| (* 2.0 |z|))
      (SETQ |four| 4.0)
      (SETQ |start| (EXPT 10.0 (- 200)))
      (SETQ |n1| (+ |n| 1))
      (SETQ |n2| (+ |n| 2))
      (SETQ |a3| 0.0)
      (SETQ |a2| 0.0)
      (SETQ |a1| |start|)
      (SETQ |z1| (/ |four| |w|))
      (SETQ |ncount| |n1|)
      (SETQ |arr| (MAKE-ARRAY |n2|))
      (SETF (AREF |arr| |ncount|) |start|)
      (SETQ |x1| |n2|)
      (SETQ |c1| (- 1.0 |c|))
      ((LAMBDA (|bfVar#12| |ncount|)
         (LOOP
          (COND
           ((COND ((MINUSP |bfVar#12|) (< |ncount| 0)) (T (> |ncount| 0)))
            (RETURN NIL))
           (#1='T
            (PROGN
             (SETQ |divfac| (/ 1.0 |x1|))
             (SETQ |x1| (- |x1| 1.0))
             (SETF (AREF |arr| |ncount|)
                     (* |x1|
                        (-
                         (+ (* (+ |divfac| (* |z1| (- |x1| |c1|))) |a1|)
                            (* (+ (/ 1.0 |x1|) (* |z1| (+ (+ |x1| |c1|) 1.0)))
                               |a2|))
                         (* |divfac| |a3|))))
             (SETQ |a3| |a2|)
             (SETQ |a2| |a1|)
             (SETQ |a1| (AREF |arr| |ncount|)))))
          (SETQ |ncount| (+ |ncount| |bfVar#12|))))
       (- 1) |n|)
      (SETF (AREF |arr| 0) (/ (AREF |arr| 0) 2.0))
      (SETQ |rho| (AREF |arr| 0))
      (SETQ |sum| |rho|)
      (SETQ |p| 1.0)
      ((LAMBDA (|i|)
         (LOOP
          (COND ((> |i| |n1|) (RETURN NIL))
                (#1#
                 (PROGN
                  (SETQ |rho| (- |rho| (* |p| (AREF |arr| |i|))))
                  (SETQ |sum| (+ |sum| (AREF |arr| |i|)))
                  (SETQ |p| (- |p|)))))
          (SETQ |i| (+ |i| 1))))
       1)
      ((LAMBDA (|l|)
         (LOOP
          (COND ((> |l| |n1|) (RETURN NIL))
                (#1# (SETF (AREF |arr| |l|) (/ (AREF |arr| |l|) |rho|))))
          (SETQ |l| (+ |l| 1))))
       0)
      (SETQ |sum| (/ |sum| |rho|))
      (SETQ |b| 0.0)
      (SETQ |temp| 0.0)
      ((LAMBDA (|bfVar#13| |i|)
         (LOOP
          (COND
           ((COND ((MINUSP |bfVar#13|) (< |i| 0)) (T (> |i| 0))) (RETURN NIL))
           (#1#
            (PROGN
             (SETQ |cc| |b|)
             (SETQ |b| |temp|)
             (SETQ |temp| (+ (- |cc|) (AREF |arr| |i|))))))
          (SETQ |i| (+ |i| |bfVar#13|))))
       (- 1) (+ |n| 1))
      |temp|))))

; chebf01coefmake (c,w,n) ==
; --- arr will be used to store the Cheb. series coefficients
;         four:= 4.0
;         start := EXPT(10.0, -200)
;         n1 := n+1
;         n2 := n+2
;         a3 := 0.0
;         a2 := 0.0
;         a1 := start     -- arbitrary starting value
;         z1 := four/w
;         ncount := n1
;         arr := MAKE_-ARRAY(n2)
;         SETF(AREF(arr,ncount) , start)  -- start off
;         x1 := n2
;         c1 := 1.0 - c
;         for ncount in n..0 by -1 repeat
;                 divfac := 1.0/x1
;                 x1 := x1 -1.0
;                 SETF(AREF(arr,ncount) ,_
;                         x1*((divfac+z1*(x1-c1))*a1 +_
;                         (1.0/x1 + z1*(x1+c1+1.0))*a2-divfac*a3))
;                 a3 := a2
;                 a2 := a1
;                 a1 := AREF(arr,ncount)
;         SETF(AREF(arr,0),AREF(arr,0)/2.0)
; --  compute scale factor
;         rho := AREF(arr,0)
;         sum := rho
;         p := 1.0
;         for i in 1..n1 repeat
;                 rho := rho - p*AREF(arr,i)
;                 sum := sum+AREF(arr,i)
;                 p := -p
;         for l in 0..n1 repeat
;                 SETF(AREF(arr,l), AREF(arr,l)/rho)
;         sum := sum/rho
;         return([sum,arr])

(DEFUN |chebf01coefmake| (|c| |w| |n|)
  (PROG (|four| |start| |n1| |n2| |a3| |a2| |a1| |z1| |ncount| |arr| |x1| |c1|
         |divfac| |rho| |sum| |p|)
    (RETURN
     (PROGN
      (SETQ |four| 4.0)
      (SETQ |start| (EXPT 10.0 (- 200)))
      (SETQ |n1| (+ |n| 1))
      (SETQ |n2| (+ |n| 2))
      (SETQ |a3| 0.0)
      (SETQ |a2| 0.0)
      (SETQ |a1| |start|)
      (SETQ |z1| (/ |four| |w|))
      (SETQ |ncount| |n1|)
      (SETQ |arr| (MAKE-ARRAY |n2|))
      (SETF (AREF |arr| |ncount|) |start|)
      (SETQ |x1| |n2|)
      (SETQ |c1| (- 1.0 |c|))
      ((LAMBDA (|bfVar#14| |ncount|)
         (LOOP
          (COND
           ((COND ((MINUSP |bfVar#14|) (< |ncount| 0)) (T (> |ncount| 0)))
            (RETURN NIL))
           (#1='T
            (PROGN
             (SETQ |divfac| (/ 1.0 |x1|))
             (SETQ |x1| (- |x1| 1.0))
             (SETF (AREF |arr| |ncount|)
                     (* |x1|
                        (-
                         (+ (* (+ |divfac| (* |z1| (- |x1| |c1|))) |a1|)
                            (* (+ (/ 1.0 |x1|) (* |z1| (+ (+ |x1| |c1|) 1.0)))
                               |a2|))
                         (* |divfac| |a3|))))
             (SETQ |a3| |a2|)
             (SETQ |a2| |a1|)
             (SETQ |a1| (AREF |arr| |ncount|)))))
          (SETQ |ncount| (+ |ncount| |bfVar#14|))))
       (- 1) |n|)
      (SETF (AREF |arr| 0) (/ (AREF |arr| 0) 2.0))
      (SETQ |rho| (AREF |arr| 0))
      (SETQ |sum| |rho|)
      (SETQ |p| 1.0)
      ((LAMBDA (|i|)
         (LOOP
          (COND ((> |i| |n1|) (RETURN NIL))
                (#1#
                 (PROGN
                  (SETQ |rho| (- |rho| (* |p| (AREF |arr| |i|))))
                  (SETQ |sum| (+ |sum| (AREF |arr| |i|)))
                  (SETQ |p| (- |p|)))))
          (SETQ |i| (+ |i| 1))))
       1)
      ((LAMBDA (|l|)
         (LOOP
          (COND ((> |l| |n1|) (RETURN NIL))
                (#1# (SETF (AREF |arr| |l|) (/ (AREF |arr| |l|) |rho|))))
          (SETQ |l| (+ |l| 1))))
       0)
      (SETQ |sum| (/ |sum| |rho|))
      (RETURN (LIST |sum| |arr|))))))

; chebstarevalarr(coefarr,x,n) ==          -- evaluation of sum(C(n)*T*(n,x))
;
;         b := 0
;         temp := 0
;         y := 2*(2*x-1)
;
;         for i in (n+1)..0 by -1 repeat
;                 c := b
;                 b := temp
;                 temp := y*b -c + AREF(coefarr,i)
;         temp - y*b/2

(DEFUN |chebstarevalarr| (|coefarr| |x| |n|)
  (PROG (|b| |temp| |y| |c|)
    (RETURN
     (PROGN
      (SETQ |b| 0)
      (SETQ |temp| 0)
      (SETQ |y| (* 2 (- (* 2 |x|) 1)))
      ((LAMBDA (|bfVar#15| |i|)
         (LOOP
          (COND
           ((COND ((MINUSP |bfVar#15|) (< |i| 0)) (T (> |i| 0))) (RETURN NIL))
           ('T
            (PROGN
             (SETQ |c| |b|)
             (SETQ |b| |temp|)
             (SETQ |temp| (+ (- (* |y| |b|) |c|) (AREF |coefarr| |i|))))))
          (SETQ |i| (+ |i| |bfVar#15|))))
       (- 1) (+ |n| 1))
      (- |temp| (/ (* |y| |b|) 2))))))

; BesselJ(v,z) ==
; ---Ad hoc boundaries for approximation
;         B1:= 10
;         B2:= 10
;         n := 50         --- number of terms in Chebychev series.
;         --- tests for negative integer order
;         (FLOATP(v) and ZEROP fracpart(v) and (v<0)) or (COMPLEXP(v) and ZEROP IMAGPART(v) and ZEROP fracpart(REALPART(v)) and REALPART(v)<0.0) =>
;              --- odd or even according to v (9.1.5 A&S)
;              --- $J_{-n}(z)=(-1)^{n} J_{n}(z)$
;              BesselJ(-v,z)*EXPT(-1.0,v)
;         (FLOATP(z) and  (z<0)) or (COMPLEXP(z) and REALPART(z)<0.0) =>
;           --- negative argument (9.1.35 A&S)
;           --- $J_{\nu}(z e^{m \pi i}) = e^{m \nu \pi i} J_{\nu}(z)$
;              BesselJ(v,-z)*EXPT(-1.0,v)
;         ZEROP z and ((FLOATP(v) and (v>=0.0)) or (COMPLEXP(v) and
;            ZEROP IMAGPART(v) and REALPART(v)>=0.0)) =>  --- zero arg, pos. real order
;             ZEROP v => 1.0  --- J(0,0)=1
;             0.0  --- J(v,0)=0 for real v>0
;         rv := ABS(v)
;         rz := ABS(z)
;         (rz>B1) and (rz > B2*rv) =>  --- asymptotic argument
;             BesselJAsympt(v,z)
;         (rv>B1) and (rv > B2*rz) => --- asymptotic order
;             BesselJAsymptOrder(v,z)
;         (rz< B1) and (rv<B1) =>       --- small order and argument
;                  arg := -(z*z)/4.0
;                  w := 2.0*arg
;                  vp1 := v+1.0
;                  [sum,arr] := chebf01coefmake(vp1,w,n)
;                  ---if we get NaNs then half n
;                  while not _=(sum,sum) repeat
;                         n:=FLOOR(n/2)
;                         [sum,arr] := chebf01coefmake(vp1,w,n)
;                  ---now n is safe, can we increase it (we know that 2*n is bad)?
;                  chebstarevalarr(arr,arg/w,n)/cgamma(vp1)*EXPT(z/2.0,v)
;         true => BesselJRecur(v,z)
;         FloatError('"BesselJ not implemented for ~S", [v,z])

(DEFUN |BesselJ| (|v| |z|)
  (PROG (B1 B2 |n| |rv| |rz| |arg| |w| |vp1| |LETTMP#1| |sum| |arr|)
    (RETURN
     (PROGN
      (SETQ B1 10)
      (SETQ B2 10)
      (SETQ |n| 50)
      (COND
       ((OR (AND (FLOATP |v|) (ZEROP (|fracpart| |v|)) (MINUSP |v|))
            (AND (COMPLEXP |v|) (ZEROP (IMAGPART |v|))
                 (ZEROP (|fracpart| (REALPART |v|))) (< (REALPART |v|) 0.0)))
        (* (|BesselJ| (- |v|) |z|) (EXPT (- 1.0) |v|)))
       ((OR (AND (FLOATP |z|) (MINUSP |z|))
            (AND (COMPLEXP |z|) (< (REALPART |z|) 0.0)))
        (* (|BesselJ| |v| (- |z|)) (EXPT (- 1.0) |v|)))
       ((AND (ZEROP |z|)
             (OR (AND (FLOATP |v|) (NOT (< |v| 0.0)))
                 (AND (COMPLEXP |v|) (ZEROP (IMAGPART |v|))
                      (NOT (< (REALPART |v|) 0.0)))))
        (COND ((ZEROP |v|) 1.0) (#1='T 0.0)))
       (#1#
        (PROGN
         (SETQ |rv| (ABS |v|))
         (SETQ |rz| (ABS |z|))
         (COND
          ((AND (< B1 |rz|) (< (* B2 |rv|) |rz|)) (|BesselJAsympt| |v| |z|))
          ((AND (< B1 |rv|) (< (* B2 |rz|) |rv|))
           (|BesselJAsymptOrder| |v| |z|))
          ((AND (< |rz| B1) (< |rv| B1))
           (PROGN
            (SETQ |arg| (- (/ (* |z| |z|) 4.0)))
            (SETQ |w| (* 2.0 |arg|))
            (SETQ |vp1| (+ |v| 1.0))
            (SETQ |LETTMP#1| (|chebf01coefmake| |vp1| |w| |n|))
            (SETQ |sum| (CAR |LETTMP#1|))
            (SETQ |arr| (CADR |LETTMP#1|))
            ((LAMBDA ()
               (LOOP
                (COND ((= |sum| |sum|) (RETURN NIL))
                      (#1#
                       (PROGN
                        (SETQ |n| (FLOOR (/ |n| 2)))
                        (SETQ |LETTMP#1| (|chebf01coefmake| |vp1| |w| |n|))
                        (SETQ |sum| (CAR |LETTMP#1|))
                        (SETQ |arr| (CADR |LETTMP#1|))
                        |LETTMP#1|))))))
            (* (/ (|chebstarevalarr| |arr| (/ |arg| |w|) |n|) (|cgamma| |vp1|))
               (EXPT (/ |z| 2.0) |v|))))
          (T (|BesselJRecur| |v| |z|))
          (#1#
           (|FloatError| "BesselJ not implemented for ~S"
            (LIST |v| |z|)))))))))))

; BesselJRecur(v,z) ==
;         -- boost order
;         --Numerical.Recipes. suggest so:=v+sqrt(n.s.f.^2*v)
;         so:=15.0*z
;         -- reduce order until non-zero
;         while ZEROP ABS(BesselJAsymptOrder(so,z)) repeat so:=so/2.0
;         if ABS(so)<ABS(z) then so:=v+18.*SQRT(v)
;         m:= FLOOR(ABS(so-v))+1
;         w:=MAKE_-ARRAY(m)
;         SETF(AREF(w,m-1),BesselJAsymptOrder(v+m-1,z))
;         SETF(AREF(w,m-2),BesselJAsymptOrder(v+m-2,z))
;         for i in m-3 .. 0 by -1 repeat
;           SETF(AREF(w,i), 2.0 * (v+i+1.0) * AREF(w,i+1) /z -AREF(w,i+2))
;         AREF(w,0)

(DEFUN |BesselJRecur| (|v| |z|)
  (PROG (|so| |m| |w|)
    (RETURN
     (PROGN
      (SETQ |so| (* 15.0 |z|))
      ((LAMBDA ()
         (LOOP
          (COND
           ((NOT (ZEROP (ABS (|BesselJAsymptOrder| |so| |z|)))) (RETURN NIL))
           (#1='T (SETQ |so| (/ |so| 2.0)))))))
      (COND ((< (ABS |so|) (ABS |z|)) (SETQ |so| (+ |v| (* 18.0 (SQRT |v|))))))
      (SETQ |m| (+ (FLOOR (ABS (- |so| |v|))) 1))
      (SETQ |w| (MAKE-ARRAY |m|))
      (SETF (AREF |w| (- |m| 1)) (|BesselJAsymptOrder| (- (+ |v| |m|) 1) |z|))
      (SETF (AREF |w| (- |m| 2)) (|BesselJAsymptOrder| (- (+ |v| |m|) 2) |z|))
      ((LAMBDA (|bfVar#16| |i|)
         (LOOP
          (COND
           ((COND ((MINUSP |bfVar#16|) (< |i| 0)) (T (> |i| 0))) (RETURN NIL))
           (#1#
            (SETF (AREF |w| |i|)
                    (-
                     (/ (* (* 2.0 (+ (+ |v| |i|) 1.0)) (AREF |w| (+ |i| 1)))
                        |z|)
                     (AREF |w| (+ |i| 2))))))
          (SETQ |i| (+ |i| |bfVar#16|))))
       (- 1) (- |m| 3))
      (AREF |w| 0)))))

; BesselI(v,z) ==
;         B1 := 15.0
;         B2 := 10.0
;         ZEROP(z) and FLOATP(v) and (v>=0.0) =>  --- zero arg, pos. real order
;             ZEROP(v) => 1.0  --- I(0,0)=1
;             0.0             --- I(v,0)=0 for real v>0
; --- Transformations for negative integer orders
;         FLOATP(v) and ZEROP(fracpart(v)) and (v<0) => BesselI(-v,z)
; --- Halfplane transformations for Re(z)<0
;         REALPART(z)<0.0 => BesselI(v,-z)*EXPT(-1.0,v)
; --- Conjugation for complex order and real argument
;         REALPART(v)<0.0 and not ZEROP IMAGPART(v) and FLOATP(z) =>
;               CONJUGATE(BesselI(CONJUGATE(v),z))
; ---We now know that Re(z)>= 0.0
;         ABS(z) > B1 =>    --- asymptotic argument case
;                                 FloatError('"BesselI not implemented for ~S",[v,z])
;         ABS(v) > B1 =>
;                                 FloatError('"BesselI not implemented for ~S",[v,z])
; ---     case of small argument and order
;         REALPART(v)>= 0.0 =>  besselIback(v,z)
;         REALPART(v)< 0.0 =>
;                         chebterms := 50
;                         besselIcheb(z,v,chebterms)
;         FloatError('"BesselI not implemented for ~S",[v,z])

(DEFUN |BesselI| (|v| |z|)
  (PROG (B1 B2 |chebterms|)
    (RETURN
     (PROGN
      (SETQ B1 15.0)
      (SETQ B2 10.0)
      (COND
       ((AND (ZEROP |z|) (FLOATP |v|) (NOT (< |v| 0.0)))
        (COND ((ZEROP |v|) 1.0) (#1='T 0.0)))
       ((AND (FLOATP |v|) (ZEROP (|fracpart| |v|)) (MINUSP |v|))
        (|BesselI| (- |v|) |z|))
       ((< (REALPART |z|) 0.0) (* (|BesselI| |v| (- |z|)) (EXPT (- 1.0) |v|)))
       ((AND (< (REALPART |v|) 0.0) (NULL (ZEROP (IMAGPART |v|))) (FLOATP |z|))
        (CONJUGATE (|BesselI| (CONJUGATE |v|) |z|)))
       ((< B1 (ABS |z|))
        (|FloatError| "BesselI not implemented for ~S" (LIST |v| |z|)))
       ((< B1 (ABS |v|))
        (|FloatError| "BesselI not implemented for ~S" (LIST |v| |z|)))
       ((NOT (< (REALPART |v|) 0.0)) (|besselIback| |v| |z|))
       ((< (REALPART |v|) 0.0)
        (PROGN (SETQ |chebterms| 50) (|besselIcheb| |z| |v| |chebterms|)))
       (#1# (|FloatError| "BesselI not implemented for ~S" (LIST |v| |z|))))))))

; besselIcheb(z,v,n) ==
;         arg := (z*z)/4.0
;         w := 2.0*arg;
;         vp1 := v+1.0;
;         [sum,arr] := chebf01coefmake(vp1,w,n)
;         result := chebstarevalarr(arr,arg/w,n)/cgamma(vp1)*EXPT(z/2.0,v)

(DEFUN |besselIcheb| (|z| |v| |n|)
  (PROG (|arg| |w| |vp1| |LETTMP#1| |sum| |arr| |result|)
    (RETURN
     (PROGN
      (SETQ |arg| (/ (* |z| |z|) 4.0))
      (SETQ |w| (* 2.0 |arg|))
      (SETQ |vp1| (+ |v| 1.0))
      (SETQ |LETTMP#1| (|chebf01coefmake| |vp1| |w| |n|))
      (SETQ |sum| (CAR |LETTMP#1|))
      (SETQ |arr| (CADR |LETTMP#1|))
      (SETQ |result|
              (*
               (/ (|chebstarevalarr| |arr| (/ |arg| |w|) |n|) (|cgamma| |vp1|))
               (EXPT (/ |z| 2.0) |v|)))))))

; besselIback(v,z) ==
;         ipv := IMAGPART(v)
;         rpv := REALPART(v)
;         lm := MULTIPLE_-VALUE_-LIST(FLOOR(rpv))
;         m := first(lm)    --- floor of real part of v
;         n := 2*MAX(20,m+10)  --- how large the back recurrence should be
;         tv := CADR(lm)+(v-rpv) ---  fractional part of real part of v
;                         --- plus imaginary part of v
;         vp1 := tv+1.0;
;         result := BesselIBackRecur(v,m,tv,z,'"I",n)
;         result := result/cgamma(vp1)*EXPT(z/2.0,tv)

(DEFUN |besselIback| (|v| |z|)
  (PROG (|ipv| |rpv| |lm| |m| |n| |tv| |vp1| |result|)
    (RETURN
     (PROGN
      (SETQ |ipv| (IMAGPART |v|))
      (SETQ |rpv| (REALPART |v|))
      (SETQ |lm| (MULTIPLE-VALUE-LIST (FLOOR |rpv|)))
      (SETQ |m| (CAR |lm|))
      (SETQ |n| (* 2 (MAX 20 (+ |m| 10))))
      (SETQ |tv| (+ (CADR |lm|) (- |v| |rpv|)))
      (SETQ |vp1| (+ |tv| 1.0))
      (SETQ |result| (|BesselIBackRecur| |v| |m| |tv| |z| "I" |n|))
      (SETQ |result|
              (* (/ |result| (|cgamma| |vp1|)) (EXPT (/ |z| 2.0) |tv|)))))))

; BesselIBackRecur(largev,argm,v,z,type,n) ==
; --- v + m = largev
;         one := 1.0
;         two := 2.0
;         zero := 0.0
;         start := EXPT(10.0,-40)
;         z2 := two/z
;         m2 := n+3
;         w:=MAKE_-ARRAY(m2+1)
;         SETF(AREF(w,m2), zero) --- start off
;         if type = '"I"
;         then
;                 val := one
;         else
;                 val := -one
;         m1 := n+2
;         SETF(AREF(w,m1), start)
;         m := n+1
;         xm := float(m)
;         ct1 := z2*(xm+v)
;         --- initialize
;         for m in (n+1)..1 by -1 repeat
;                 SETF(AREF(w,m), AREF(w,m+1)*ct1 + val*AREF(w,m+2))
;                 ct1 := ct1 - z2
;         m := 1 + FLOOR(n/2)
;         m2 := m + m -1
;         if (v=0)
;         then
;                 pn := AREF(w, m2 + 2)
;                 for m2 in (2*m-1)..3 by -2 repeat
;                         pn := AREF(w, m2) - val *pn
;                 pn := AREF(w,1) - val*(pn+pn)
;         else
;                 v1 := v-one
;                 xm := float(m)
;                 ct1 := v + xm + xm
;                 pn := ct1*AREF(w, m2 + 2)
;                 for m2 in (m+m -1)..3 by -2 repeat
;                         ct1 := ct1 - two
;                         pn := ct1*AREF(w,m2) - val*pn/xm*(v1+xm)
;                         xm := xm - one
;                 pn := AREF(w,1) - val * pn
;         m1 := n+2
;         for m in 1..m1 repeat
;                 SETF(AREF(w,m), AREF(w,m)/pn)
;         AREF(w,argm+1)

(DEFUN |BesselIBackRecur| (|largev| |argm| |v| |z| |type| |n|)
  (PROG (|one| |two| |zero| |start| |z2| |m2| |w| |val| |m1| |m| |xm| |ct1|
         |pn| |v1|)
    (RETURN
     (PROGN
      (SETQ |one| 1.0)
      (SETQ |two| 2.0)
      (SETQ |zero| 0.0)
      (SETQ |start| (EXPT 10.0 (- 40)))
      (SETQ |z2| (/ |two| |z|))
      (SETQ |m2| (+ |n| 3))
      (SETQ |w| (MAKE-ARRAY (+ |m2| 1)))
      (SETF (AREF |w| |m2|) |zero|)
      (COND ((EQUAL |type| "I") (SETQ |val| |one|))
            (#1='T (SETQ |val| (- |one|))))
      (SETQ |m1| (+ |n| 2))
      (SETF (AREF |w| |m1|) |start|)
      (SETQ |m| (+ |n| 1))
      (SETQ |xm| (|float| |m|))
      (SETQ |ct1| (* |z2| (+ |xm| |v|)))
      ((LAMBDA (|bfVar#17| |m|)
         (LOOP
          (COND
           ((COND ((MINUSP |bfVar#17|) (< |m| 1)) (T (> |m| 1))) (RETURN NIL))
           (#1#
            (PROGN
             (SETF (AREF |w| |m|)
                     (+ (* (AREF |w| (+ |m| 1)) |ct1|)
                        (* |val| (AREF |w| (+ |m| 2)))))
             (SETQ |ct1| (- |ct1| |z2|)))))
          (SETQ |m| (+ |m| |bfVar#17|))))
       (- 1) (+ |n| 1))
      (SETQ |m| (+ 1 (FLOOR (/ |n| 2))))
      (SETQ |m2| (- (+ |m| |m|) 1))
      (COND
       ((EQL |v| 0) (SETQ |pn| (AREF |w| (+ |m2| 2)))
        ((LAMBDA (|bfVar#18| |m2|)
           (LOOP
            (COND
             ((COND ((MINUSP |bfVar#18|) (< |m2| 3)) (T (> |m2| 3)))
              (RETURN NIL))
             (#1# (SETQ |pn| (- (AREF |w| |m2|) (* |val| |pn|)))))
            (SETQ |m2| (+ |m2| |bfVar#18|))))
         (- 2) (- (* 2 |m|) 1))
        (SETQ |pn| (- (AREF |w| 1) (* |val| (+ |pn| |pn|)))))
       (#1# (SETQ |v1| (- |v| |one|)) (SETQ |xm| (|float| |m|))
        (SETQ |ct1| (+ (+ |v| |xm|) |xm|))
        (SETQ |pn| (* |ct1| (AREF |w| (+ |m2| 2))))
        ((LAMBDA (|bfVar#19| |m2|)
           (LOOP
            (COND
             ((COND ((MINUSP |bfVar#19|) (< |m2| 3)) (T (> |m2| 3)))
              (RETURN NIL))
             (#1#
              (PROGN
               (SETQ |ct1| (- |ct1| |two|))
               (SETQ |pn|
                       (- (* |ct1| (AREF |w| |m2|))
                          (* (/ (* |val| |pn|) |xm|) (+ |v1| |xm|))))
               (SETQ |xm| (- |xm| |one|)))))
            (SETQ |m2| (+ |m2| |bfVar#19|))))
         (- 2) (- (+ |m| |m|) 1))
        (SETQ |pn| (- (AREF |w| 1) (* |val| |pn|)))))
      (SETQ |m1| (+ |n| 2))
      ((LAMBDA (|m|)
         (LOOP
          (COND ((> |m| |m1|) (RETURN NIL))
                (#1# (SETF (AREF |w| |m|) (/ (AREF |w| |m|) |pn|))))
          (SETQ |m| (+ |m| 1))))
       1)
      (AREF |w| (+ |argm| 1))))))

; BesselasymptA(mu,zsqr,zfth) ==
;         (mu -1)/(16.0*zsqr) * (1 + (mu - 13.0)/(8.0*zsqr) + _
;                 (mu^2 - 53.0*mu + 412.0)/(48.0*zfth))

(DEFUN |BesselasymptA| (|mu| |zsqr| |zfth|)
  (PROG ()
    (RETURN
     (* (/ (- |mu| 1) (* 16.0 |zsqr|))
        (+ (+ 1 (/ (- |mu| 13.0) (* 8.0 |zsqr|)))
           (/ (+ (- (EXPT |mu| 2) (* 53.0 |mu|)) 412.0) (* 48.0 |zfth|)))))))

; BesselasymptB(mu,z,zsqr,zfth) ==
;         musqr := mu*mu
;         z + (mu-1.0)/(8.0*z) *(1.0 + (mu - 25.0)/(48.0*zsqr) + _
;                 (musqr - 114.0*mu + 1073.0)/(640.0*zfth) +_
;                 (5.0*mu*musqr - 1535.0*musqr + 54703.0*mu - 375733.0)/(128.0*zsqr*zfth))

(DEFUN |BesselasymptB| (|mu| |z| |zsqr| |zfth|)
  (PROG (|musqr|)
    (RETURN
     (PROGN
      (SETQ |musqr| (* |mu| |mu|))
      (+ |z|
         (* (/ (- |mu| 1.0) (* 8.0 |z|))
            (+
             (+ (+ 1.0 (/ (- |mu| 25.0) (* 48.0 |zsqr|)))
                (/ (+ (- |musqr| (* 114.0 |mu|)) 1073.0) (* 640.0 |zfth|)))
             (/
              (-
               (+ (- (* (* 5.0 |mu|) |musqr|) (* 1535.0 |musqr|))
                  (* 54703.0 |mu|))
               375733.0)
              (* (* 128.0 |zsqr|) |zfth|)))))))))

; BesselJAsympt (v,z) ==
;         pi := dfPi
;         mu := 4.0*v*v
;         zsqr := z*z
;         zfth := zsqr*zsqr
;         SQRT(2.0/(pi*z))*EXP(BesselasymptA(mu,zsqr,zfth))*_
;                 COS(BesselasymptB(mu,z,zsqr,zfth) - pi*v/2.0 - pi/4.0)

(DEFUN |BesselJAsympt| (|v| |z|)
  (PROG (|pi| |mu| |zsqr| |zfth|)
    (RETURN
     (PROGN
      (SETQ |pi| |dfPi|)
      (SETQ |mu| (* (* 4.0 |v|) |v|))
      (SETQ |zsqr| (* |z| |z|))
      (SETQ |zfth| (* |zsqr| |zsqr|))
      (*
       (* (SQRT (/ 2.0 (* |pi| |z|)))
          (EXP (|BesselasymptA| |mu| |zsqr| |zfth|)))
       (COS
        (- (- (|BesselasymptB| |mu| |z| |zsqr| |zfth|) (/ (* |pi| |v|) 2.0))
           (/ |pi| 4.0))))))))

; BesselIAsympt(v,z,n) ==
;         i := COMPLEX(0.0, 1.0)
;         if (REALPART(z) = 0.0)
;         then return EXPT(i,v)*BesselJ(v,-IMAGPART(z))
;         sum1 := 0.0
;         sum2 := 0.0
;         fourvsq := 4.0*v^2
;         two := 2.0
;         eight := 8.0
;         term1 := 1.0
; ---             sum1, sum2, fourvsq,two,i,eight,term1])
;         for r in 1..n repeat
;                 term1 := -term1 *(fourvsq-(two*float(r)-1.0)^2)/_
;                         (float(r)*eight*z)
;                 sum1 := sum1 + term1
;                 sum2 := sum2 + ABS(term1)
;         sqrttwopiz := SQRT(two*dfPi*z)
;         EXP(z)/sqrttwopiz*(1.0 + sum1 ) +_
;                 EXP(-(float(n)+.5)*dfPi*i)*EXP(-z)/sqrttwopiz*(1.0+ sum2)

(DEFUN |BesselIAsympt| (|v| |z| |n|)
  (PROG (|i| |sum1| |sum2| |fourvsq| |two| |eight| |term1| |sqrttwopiz|)
    (RETURN
     (PROGN
      (SETQ |i| (COMPLEX 0.0 1.0))
      (COND
       ((EQUAL (REALPART |z|) 0.0)
        (RETURN (* (EXPT |i| |v|) (|BesselJ| |v| (- (IMAGPART |z|)))))))
      (SETQ |sum1| 0.0)
      (SETQ |sum2| 0.0)
      (SETQ |fourvsq| (* 4.0 (EXPT |v| 2)))
      (SETQ |two| 2.0)
      (SETQ |eight| 8.0)
      (SETQ |term1| 1.0)
      ((LAMBDA (|r|)
         (LOOP
          (COND ((> |r| |n|) (RETURN NIL))
                ('T
                 (PROGN
                  (SETQ |term1|
                          (-
                           (/
                            (* |term1|
                               (- |fourvsq|
                                  (EXPT (- (* |two| (|float| |r|)) 1.0) 2)))
                            (* (* (|float| |r|) |eight|) |z|))))
                  (SETQ |sum1| (+ |sum1| |term1|))
                  (SETQ |sum2| (+ |sum2| (ABS |term1|))))))
          (SETQ |r| (+ |r| 1))))
       1)
      (SETQ |sqrttwopiz| (SQRT (* (* |two| |dfPi|) |z|)))
      (+ (* (/ (EXP |z|) |sqrttwopiz|) (+ 1.0 |sum1|))
         (*
          (/
           (* (EXP (- (* (* (+ (|float| |n|) 0.5) |dfPi|) |i|))) (EXP (- |z|)))
           |sqrttwopiz|)
          (+ 1.0 |sum2|)))))))

; BesselJAsymptOrder(v,z) ==
;         sechalpha := z/v
;         alpha := ACOSH(1.0/sechalpha)
;         tanhalpha := SQRT(1.0-(sechalpha*sechalpha))
;     --  cothalpha := 1.0/tanhalpha
;         ca := 1.0/tanhalpha
;
;         Pi := dfPi
;         ca2:=ca*ca
;         ca4:=ca2*ca2
;         ca8:=ca4*ca4
;         EXP(-v*(alpha-tanhalpha))/SQRT(2.0*Pi*v*tanhalpha)*_
;         (1.0+_
;         horner([              -5.0,                3.0],_
;                                                                 ca2)*ca/(v*24.0)+_
;         horner([             385.0,             -462.0,              81.0],_
;                                                                 ca2)*ca2/(1152.0*v*v)+_
;         horner([         -425425.0,           765765.0,         -369603.0,             30375.0],_
;                                                                 ca2)*ca2*ca/(414720.0*v*v*v)+_
;         horner([       185910725.0,       -446185740.0,       349922430.0,        -94121676.0,         4465125.0],_
;                                                                 ca2)*ca4/(39813120.0*v*v*v*v)+_
;         horner([   -188699385875.0,     566098157625.0,   -614135872350.0,     284499769554.0,    -49286948607.0,      1519035525.0],_
;                                                                 ca2)*ca4*ca/(6688604160.0*v*v*v*v*v)+_
;         horner([1023694168371875.0,-3685299006138750.0,5104696716244125.0,-3369032068261860.0,1050760774457901.0,-127577298354750.0,2757049477875.0],_
;                                                                 ca2)*ca4*ca2/(4815794995200.0*v*v*v*v*v*v))

(DEFUN |BesselJAsymptOrder| (|v| |z|)
  (PROG (|sechalpha| |alpha| |tanhalpha| |ca| |Pi| |ca2| |ca4| |ca8|)
    (RETURN
     (PROGN
      (SETQ |sechalpha| (/ |z| |v|))
      (SETQ |alpha| (ACOSH (/ 1.0 |sechalpha|)))
      (SETQ |tanhalpha| (SQRT (- 1.0 (* |sechalpha| |sechalpha|))))
      (SETQ |ca| (/ 1.0 |tanhalpha|))
      (SETQ |Pi| |dfPi|)
      (SETQ |ca2| (* |ca| |ca|))
      (SETQ |ca4| (* |ca2| |ca2|))
      (SETQ |ca8| (* |ca4| |ca4|))
      (*
       (/ (EXP (- (* |v| (- |alpha| |tanhalpha|))))
          (SQRT (* (* (* 2.0 |Pi|) |v|) |tanhalpha|)))
       (+
        (+
         (+
          (+
           (+
            (+ 1.0
               (/ (* (|horner| (LIST (- 5.0) 3.0) |ca2|) |ca|) (* |v| 24.0)))
            (/ (* (|horner| (LIST 385.0 (- 462.0) 81.0) |ca2|) |ca2|)
               (* (* 1152.0 |v|) |v|)))
           (/
            (*
             (*
              (|horner| (LIST (- 425425.0) 765765.0 (- 369603.0) 30375.0)
               |ca2|)
              |ca2|)
             |ca|)
            (* (* (* 414720.0 |v|) |v|) |v|)))
          (/
           (*
            (|horner|
             (LIST 1.85910725e8 (- 4.4618574e8) 3.4992243e8 (- 9.4121676e7)
                   4465125.0)
             |ca2|)
            |ca4|)
           (* (* (* (* 3.981312e7 |v|) |v|) |v|) |v|)))
         (/
          (*
           (*
            (|horner|
             (LIST (- 1.88699385875e11) 5.66098157625e11 (- 6.1413587235e11)
                   2.84499769554e11 (- 4.9286948607e10) 1.519035525e9)
             |ca2|)
            |ca4|)
           |ca|)
          (* (* (* (* (* 6.68860416e9 |v|) |v|) |v|) |v|) |v|)))
        (/
         (*
          (*
           (|horner|
            (LIST 1.023694168371875e15 (- 3.6852990061387505e15)
                  5.104696716244125e15 (- 3.36903206826186e15)
                  1.050760774457901e15 (- 1.2757729835475e14)
                  2.757049477875e12)
            |ca2|)
           |ca4|)
          |ca2|)
         (* (* (* (* (* (* 4.8157949952e12 |v|) |v|) |v|) |v|) |v|) |v|))))))))

; BesselIAsymptOrder(v,vz) ==
;         z := vz/v
;         Pi := dfPi
; ---     Use reflection formula (Atlas, p. 492)  if v not in right half plane;  Is this always accurate?
;         if REALPART(v)<0.0
;         then return BesselIAsymptOrder(-v,vz) + 2.0/Pi*SIN(-v*Pi)*BesselKAsymptOrder(-v,vz)
; ---     Use the reflection formula (Atlas, p. 496) if z not in right half plane;
;         if REALPART(vz) < 0.0
;         then return EXPT(-1.0,v)*BesselIAsymptOrder(v,-vz)
;         vinv := 1.0/v
;         opzsqroh := SQRT(1.0+z*z)
;         eta := opzsqroh + LOG(z/(1.0+opzsqroh))
;         p := 1.0/opzsqroh
;         p2 := p*p
;         p4 := p2*p2
;         u0p := 1.
;         u1p := 1.0/8.0*p-5.0/24.0*p*p2
;         u2p := (9.0/128.0+(-77.0/192.0+385.0/1152.0*p2)*p2)*p2
;         u3p := (75.0/1024.0+(-4563.0/5120.0+(17017.0/9216.0-85085.0/82944.0*p2)_
;                 *p2)*p2)*p2*p
;         u4p := (3675.0/32768.0+(-96833.0/40960.0+(144001.0/16384.0+(-7436429.0/663552.0+37182145.0/7962624.0*p2)*p2)*p2)*p2)*p4
;         u5p := (59535.0/262144.0+(-67608983.0/9175040.0+(250881631.0/5898240.0+(-108313205.0/1179648.0+(5391411025.0/63700992.0-5391411025.0/191102976.0*p2)*p2)*p2)*p2)*p2)*p4*p
;         hornerresult := horner([u5p,u4p,u3p,u2p,u1p,u0p],vinv)
;         EXP(v*eta)/(SQRT(2.0*Pi*v)*SQRT(opzsqroh))*hornerresult

(DEFUN |BesselIAsymptOrder| (|v| |vz|)
  (PROG (|z| |Pi| |vinv| |opzsqroh| |eta| |p| |p2| |p4| |u0p| |u1p| |u2p| |u3p|
         |u4p| |u5p| |hornerresult|)
    (RETURN
     (PROGN
      (SETQ |z| (/ |vz| |v|))
      (SETQ |Pi| |dfPi|)
      (COND
       ((< (REALPART |v|) 0.0)
        (RETURN
         (+ (|BesselIAsymptOrder| (- |v|) |vz|)
            (* (* (/ 2.0 |Pi|) (SIN (- (* |v| |Pi|))))
               (|BesselKAsymptOrder| (- |v|) |vz|))))))
      (COND
       ((< (REALPART |vz|) 0.0)
        (RETURN (* (EXPT (- 1.0) |v|) (|BesselIAsymptOrder| |v| (- |vz|))))))
      (SETQ |vinv| (/ 1.0 |v|))
      (SETQ |opzsqroh| (SQRT (+ 1.0 (* |z| |z|))))
      (SETQ |eta| (+ |opzsqroh| (LOG (/ |z| (+ 1.0 |opzsqroh|)))))
      (SETQ |p| (/ 1.0 |opzsqroh|))
      (SETQ |p2| (* |p| |p|))
      (SETQ |p4| (* |p2| |p2|))
      (SETQ |u0p| 1.0)
      (SETQ |u1p| (- (* (/ 1.0 8.0) |p|) (* (* (/ 5.0 24.0) |p|) |p2|)))
      (SETQ |u2p|
              (*
               (+ (/ 9.0 128.0)
                  (* (+ (- (/ 77.0 192.0)) (* (/ 385.0 1152.0) |p2|)) |p2|))
               |p2|))
      (SETQ |u3p|
              (*
               (*
                (+ (/ 75.0 1024.0)
                   (*
                    (+ (- (/ 4563.0 5120.0))
                       (* (- (/ 17017.0 9216.0) (* (/ 85085.0 82944.0) |p2|))
                          |p2|))
                    |p2|))
                |p2|)
               |p|))
      (SETQ |u4p|
              (*
               (+ (/ 3675.0 32768.0)
                  (*
                   (+ (- (/ 96833.0 40960.0))
                      (*
                       (+ (/ 144001.0 16384.0)
                          (*
                           (+ (- (/ 7436429.0 663552.0))
                              (* (/ 3.7182145e7 7962624.0) |p2|))
                           |p2|))
                       |p2|))
                   |p2|))
               |p4|))
      (SETQ |u5p|
              (*
               (*
                (+ (/ 59535.0 262144.0)
                   (*
                    (+ (- (/ 6.7608983e7 9175040.0))
                       (*
                        (+ (/ 2.50881631e8 5898240.0)
                           (*
                            (+ (- (/ 1.08313205e8 1179648.0))
                               (*
                                (- (/ 5.391411025e9 6.3700992e7)
                                   (* (/ 5.391411025e9 1.91102976e8) |p2|))
                                |p2|))
                            |p2|))
                        |p2|))
                    |p2|))
                |p4|)
               |p|))
      (SETQ |hornerresult|
              (|horner| (LIST |u5p| |u4p| |u3p| |u2p| |u1p| |u0p|) |vinv|))
      (*
       (/ (EXP (* |v| |eta|))
          (* (SQRT (* (* 2.0 |Pi|) |v|)) (SQRT |opzsqroh|)))
       |hornerresult|)))))

; BesselKAsymptOrder (v,vz) ==
;         z := vz/v
;         vinv := 1.0/v
;         opzsqroh := SQRT(1.0+z*z)
;         eta := opzsqroh + LOG(z/(1.0+opzsqroh))
;         p := 1.0/opzsqroh
;         p2 := p^2
;         p4 := p2^2
;         u0p := 1.
;         u1p := (1.0/8.0*p-5.0/24.0*p^3)*(-1.0)
;         u2p := (9.0/128.0+(-77.0/192.0+385.0/1152.0*p2)*p2)*p2
;         u3p := ((75.0/1024.0+(-4563.0/5120.0+(17017.0/9216.0-85085.0/82944.0*p2)_
;                 *p2)*p2)*p2*p)*(-1.0)
;         u4p := (3675.0/32768.0+(-96833.0/40960.0+(144001.0/16384.0+(-7436429.0/663552.0+37182145.0/7962624.0*p2)*p2)*p2)*p2)*p4
;         u5p := ((59535.0/262144.0+(-67608983.0/9175040.0+(250881631.0/5898240.0+(-108313205.0/1179648.0+(5391411025.0/63700992.0-5391411025.0/191102976.0*p2)*p2)*p2)*p2)*p2)*p4*p)*(-1.0)
;         hornerresult := horner([u5p,u4p,u3p,u2p,u1p,u0p],vinv)
;         SQRT(dfPi/(2.0*v))*EXP(-v*eta)/(SQRT(opzsqroh))*hornerresult

(DEFUN |BesselKAsymptOrder| (|v| |vz|)
  (PROG (|z| |vinv| |opzsqroh| |eta| |p| |p2| |p4| |u0p| |u1p| |u2p| |u3p|
         |u4p| |u5p| |hornerresult|)
    (RETURN
     (PROGN
      (SETQ |z| (/ |vz| |v|))
      (SETQ |vinv| (/ 1.0 |v|))
      (SETQ |opzsqroh| (SQRT (+ 1.0 (* |z| |z|))))
      (SETQ |eta| (+ |opzsqroh| (LOG (/ |z| (+ 1.0 |opzsqroh|)))))
      (SETQ |p| (/ 1.0 |opzsqroh|))
      (SETQ |p2| (EXPT |p| 2))
      (SETQ |p4| (EXPT |p2| 2))
      (SETQ |u0p| 1.0)
      (SETQ |u1p|
              (* (- (* (/ 1.0 8.0) |p|) (* (/ 5.0 24.0) (EXPT |p| 3)))
                 (- 1.0)))
      (SETQ |u2p|
              (*
               (+ (/ 9.0 128.0)
                  (* (+ (- (/ 77.0 192.0)) (* (/ 385.0 1152.0) |p2|)) |p2|))
               |p2|))
      (SETQ |u3p|
              (*
               (*
                (*
                 (+ (/ 75.0 1024.0)
                    (*
                     (+ (- (/ 4563.0 5120.0))
                        (* (- (/ 17017.0 9216.0) (* (/ 85085.0 82944.0) |p2|))
                           |p2|))
                     |p2|))
                 |p2|)
                |p|)
               (- 1.0)))
      (SETQ |u4p|
              (*
               (+ (/ 3675.0 32768.0)
                  (*
                   (+ (- (/ 96833.0 40960.0))
                      (*
                       (+ (/ 144001.0 16384.0)
                          (*
                           (+ (- (/ 7436429.0 663552.0))
                              (* (/ 3.7182145e7 7962624.0) |p2|))
                           |p2|))
                       |p2|))
                   |p2|))
               |p4|))
      (SETQ |u5p|
              (*
               (*
                (*
                 (+ (/ 59535.0 262144.0)
                    (*
                     (+ (- (/ 6.7608983e7 9175040.0))
                        (*
                         (+ (/ 2.50881631e8 5898240.0)
                            (*
                             (+ (- (/ 1.08313205e8 1179648.0))
                                (*
                                 (- (/ 5.391411025e9 6.3700992e7)
                                    (* (/ 5.391411025e9 1.91102976e8) |p2|))
                                 |p2|))
                             |p2|))
                         |p2|))
                     |p2|))
                 |p4|)
                |p|)
               (- 1.0)))
      (SETQ |hornerresult|
              (|horner| (LIST |u5p| |u4p| |u3p| |u2p| |u1p| |u0p|) |vinv|))
      (*
       (/ (* (SQRT (/ |dfPi| (* 2.0 |v|))) (EXP (- (* |v| |eta|))))
          (SQRT |opzsqroh|))
       |hornerresult|)))))

; s_to_c(c) == COMPLEX(first c, CDR c)

(DEFUN |s_to_c| (|c|) (PROG () (RETURN (COMPLEX (CAR |c|) (CDR |c|)))))

; c_to_s(c) == CONS(REALPART c, IMAGPART c)

(DEFUN |c_to_s| (|c|) (PROG () (RETURN (CONS (REALPART |c|) (IMAGPART |c|)))))

; c_to_r(c) ==
;     r := REALPART c
;     i := IMAGPART c
;     if ZEROP(i) or (ABS(i) <  1.0E-10*(ABS r)) then
;         r
;     else
;         error "Result is not real."

(DEFUN |c_to_r| (|c|)
  (PROG (|r| |i|)
    (RETURN
     (PROGN
      (SETQ |r| (REALPART |c|))
      (SETQ |i| (IMAGPART |c|))
      (COND
       ((OR (ZEROP |i|) (< (ABS |i|) (* 9.999999999999999e-11 (ABS |r|)))) |r|)
       ('T (|error| '|Result is not real.|)))))))

; c_to_rf(c) == COERCE(c_to_r(c), 'DOUBLE_-FLOAT)

(DEFUN |c_to_rf| (|c|) (PROG () (RETURN (COERCE (|c_to_r| |c|) 'DOUBLE-FLOAT))))

; c_lngamma(z) ==  c_to_s(lncgamma(s_to_c z))

(DEFUN |c_lngamma| (|z|)
  (PROG () (RETURN (|c_to_s| (|lncgamma| (|s_to_c| |z|))))))

; c_gamma(z) ==  c_to_s(cgamma (s_to_c z))

(DEFUN |c_gamma| (|z|) (PROG () (RETURN (|c_to_s| (|cgamma| (|s_to_c| |z|))))))

; c_psi(n, z) == c_to_s(cPsi(n, s_to_c(z)))

(DEFUN |c_psi| (|n| |z|)
  (PROG () (RETURN (|c_to_s| (|cPsi| |n| (|s_to_c| |z|))))))

; r_besselj(n, x) == c_to_r(BesselJ(n, x))

(DEFUN |r_besselj| (|n| |x|) (PROG () (RETURN (|c_to_r| (|BesselJ| |n| |x|)))))

; c_besselj(v, z) == c_to_s(BesselJ(s_to_c(v), s_to_c(z)))

(DEFUN |c_besselj| (|v| |z|)
  (PROG () (RETURN (|c_to_s| (|BesselJ| (|s_to_c| |v|) (|s_to_c| |z|))))))

; r_besseli(n, x) == c_to_r(BesselI(n, x))

(DEFUN |r_besseli| (|n| |x|) (PROG () (RETURN (|c_to_r| (|BesselI| |n| |x|)))))

; c_besseli(v, z) == c_to_s(BesselI(s_to_c(v), s_to_c(z)))

(DEFUN |c_besseli| (|v| |z|)
  (PROG () (RETURN (|c_to_s| (|BesselI| (|s_to_c| |v|) (|s_to_c| |z|))))))

; c_hyper0f1(a, z) == c_to_s(chebf01(s_to_c(a), s_to_c(z)))

(DEFUN |c_hyper0f1| (|a| |z|)
  (PROG () (RETURN (|c_to_s| (|chebf01| (|s_to_c| |a|) (|s_to_c| |z|))))))
