
(SDEFUN |INTALG;F2UPR| ((|f| (F)) ($ (|SparseUnivariatePolynomial| R)))
        (SPADCALL (|INTALG;F2R| |f| $) (QREFELT $ 20))) 

(SDEFUN |INTALG;F2R| ((|f| (F)) ($ (R)))
        (SPADCALL (SPADCALL (SPADCALL |f| (QREFELT $ 21)) (QREFELT $ 23))
                  (QREFELT $ 24))) 

(SDEFUN |INTALG;IRF_to_IR|
        ((|irf| (|IntegrationResult| F)) ($ (|IntegrationResult| R)))
        (SPADCALL (CONS (|function| |INTALG;F2R|) $) |irf| (QREFELT $ 29))) 

(SDEFUN |INTALG;R_to_F| ((|f| (R)) ($ (|Union| F "failed")))
        (SPROG
         ((|f2| (UP)) (|u2| (|Union| UP "failed")) (|f1| (|Fraction| UP))
          (|u1| (|Union| (|Fraction| UP) "failed")))
         (SEQ (LETT |u1| (SPADCALL |f| (QREFELT $ 31)))
              (EXIT
               (COND ((QEQCAR |u1| 1) (CONS 1 "failed"))
                     (#1='T
                      (SEQ (LETT |f1| (QCDR |u1|))
                           (LETT |u2| (SPADCALL |f1| (QREFELT $ 33)))
                           (EXIT
                            (COND ((QEQCAR |u2| 1) (CONS 1 "failed"))
                                  (#1#
                                   (SEQ (LETT |f2| (QCDR |u2|))
                                        (EXIT
                                         (SPADCALL |f2|
                                                   (QREFELT $ 35)))))))))))))) 

(SDEFUN |INTALG;algintexp|
        ((|f| (R)) (|derivation| (|Mapping| UP UP))
         (|rec_int| (|Mapping| #1=(|IntegrationResult| F) F))
         ($ (|IntegrationResult| R)))
        (SPROG
         ((|u|
           (|Union|
            (|List|
             (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                       (|:| |coeff| (|SparseUnivariatePolynomial| R))
                       (|:| |logand| (|SparseUnivariatePolynomial| R))))
            "failed"))
          (|res1| #1#) (|p1u| (|Union| F "failed")) (|p| (R))
          (|h| (|Record| (|:| |answer| R) (|:| |logpart| R))) (|ff| (R))
          (|w| (|Vector| R))
          (|r|
           (|Record| (|:| |polyPart| (|LaurentPolynomial| F UP))
                     (|:| |fracPart| (|Fraction| UP))))
          (#2=#:G830 NIL) (|i| NIL) (|vf| (|Vector| (|Fraction| UP)))
          (|vp| (|Vector| (|LaurentPolynomial| F UP)))
          (|n| (|NonNegativeInteger|)) (|v| #3=(|Vector| UP)) (|d| (UP))
          (|c| (|Record| (|:| |num| #3#) (|:| |den| UP))))
         (SEQ (LETT |d| (QCDR (LETT |c| (SPADCALL |f| (QREFELT $ 37)))))
              (LETT |v| (QCAR |c|))
              (LETT |vp|
                    (MAKEARR1 (LETT |n| (QVSIZE |v|)) (|spadConstant| $ 39)))
              (LETT |vf| (MAKEARR1 |n| (|spadConstant| $ 42)))
              (SEQ (LETT |i| (SPADCALL |v| (QREFELT $ 45)))
                   (LETT #2# (QVSIZE |v|)) G190 (COND ((> |i| #2#) (GO G191)))
                   (SEQ
                    (LETT |r|
                          (SPADCALL
                           (SPADCALL (QAREF1O |v| |i| 1) |d| (QREFELT $ 46))
                           (QREFELT $ 48)))
                    (QSETAREF1O |vf| |i| (QCDR |r|) 1)
                    (EXIT (QSETAREF1O |vp| |i| (QCAR |r|) 1)))
                   (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
              (LETT |ff|
                    (SPADCALL |vf| (LETT |w| (SPADCALL (QREFELT $ 50)))
                              (QREFELT $ 52)))
              (LETT |h| (SPADCALL |ff| |derivation| (QREFELT $ 56)))
              (LETT |p|
                    (SPADCALL (SPADCALL (ELT $ 57) |vp| (QREFELT $ 61)) |w|
                              (QREFELT $ 52)))
              (COND
               ((NULL (SPADCALL |p| (QREFELT $ 63)))
                (EXIT
                 (|error|
                  "integrate: implementation incomplete (has polynomial part)"))))
              (EXIT
               (COND
                ((SPADCALL (QCDR |h|) (QREFELT $ 63))
                 (SPADCALL (QCAR |h|) (QREFELT $ 64)))
                (#4='T
                 (SEQ (LETT |p1u| (|INTALG;R_to_F| (QCDR |h|) $))
                      (EXIT
                       (COND
                        ((QEQCAR |p1u| 0)
                         (SEQ (LETT |res1| (SPADCALL (QCDR |p1u|) |rec_int|))
                              (EXIT
                               (SPADCALL
                                (SPADCALL (QCAR |h|) NIL NIL (QREFELT $ 69))
                                (|INTALG;IRF_to_IR| |res1| $)
                                (QREFELT $ 70)))))
                        (#4#
                         (SEQ
                          (LETT |u|
                                (|INTALG;alglogint| (QCDR |h|) |derivation| $))
                          (EXIT
                           (COND
                            ((QEQCAR |u| 1)
                             (SPADCALL (QCAR |h|) NIL
                                       (LIST
                                        (CONS
                                         (SPADCALL |p| (QCDR |h|)
                                                   (QREFELT $ 71))
                                         (QREFELT $ 12)))
                                       (QREFELT $ 69)))
                            (#4#
                             (SPADCALL (QCAR |h|) (QCDR |u|) NIL
                                       (QREFELT $ 69)))))))))))))))) 

(SDEFUN |INTALG;algintprim|
        ((|f| (R)) (|derivation| (|Mapping| UP UP))
         (|rec_int| (|Mapping| #1=(|IntegrationResult| F) F))
         ($ (|IntegrationResult| R)))
        (SPROG
         ((|u|
           (|Union|
            (|List|
             (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                       (|:| |coeff| (|SparseUnivariatePolynomial| R))
                       (|:| |logand| (|SparseUnivariatePolynomial| R))))
            "failed"))
          (|res1| #1#) (|p1u| (|Union| F "failed"))
          (|h| (|Record| (|:| |answer| R) (|:| |logpart| R))))
         (SEQ (LETT |h| (SPADCALL |f| |derivation| (QREFELT $ 56)))
              (EXIT
               (COND
                ((SPADCALL (QCDR |h|) (QREFELT $ 63))
                 (SPADCALL (QCAR |h|) (QREFELT $ 64)))
                (#2='T
                 (SEQ (LETT |p1u| (|INTALG;R_to_F| (QCDR |h|) $))
                      (EXIT
                       (COND
                        ((QEQCAR |p1u| 0)
                         (SEQ (LETT |res1| (SPADCALL (QCDR |p1u|) |rec_int|))
                              (EXIT
                               (SPADCALL
                                (SPADCALL (QCAR |h|) NIL NIL (QREFELT $ 69))
                                (|INTALG;IRF_to_IR| |res1| $)
                                (QREFELT $ 70)))))
                        (#2#
                         (SEQ
                          (LETT |u|
                                (|INTALG;alglogint| (QCDR |h|) |derivation| $))
                          (EXIT
                           (COND
                            ((QEQCAR |u| 1)
                             (SPADCALL (QCAR |h|) NIL
                                       (LIST (CONS (QCDR |h|) (QREFELT $ 12)))
                                       (QREFELT $ 69)))
                            (#2#
                             (SPADCALL (QCAR |h|) (QCDR |u|) NIL
                                       (QREFELT $ 69)))))))))))))))) 

(SDEFUN |INTALG;find_multiples|
        ((|f1|
          (|Record| (|:| |factor| UP) (|:| |exponent| (|NonNegativeInteger|))))
         (|lp|
          (|List|
           (|Record| (|:| |factor| UP)
                     (|:| |exponent| (|NonNegativeInteger|)))))
         ($
          (|Record|
           (|:| |result1|
                (|List|
                 (|Record| (|:| |factor| UP)
                           (|:| |exponent| (|NonNegativeInteger|))
                           (|:| |coeff| (|Fraction| (|Integer|))))))
           (|:| |result2|
                (|List|
                 (|Record| (|:| |factor| UP)
                           (|:| |exponent| (|NonNegativeInteger|))))))))
        (SPROG
         ((|res|
           (|List|
            (|Record| (|:| |factor| UP) (|:| |exponent| (|NonNegativeInteger|))
                      (|:| |coeff| (|Fraction| (|Integer|))))))
          (|rr|
           (|List|
            (|Record| (|:| |factor| UP)
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (|nfac| (|Fraction| (|Integer|))) (|nfac_ok| (|Boolean|))
          (|ndu| #1=(|Union| (|Integer|) "failed")) (|nnu| #1#)
          (|facu| (|Union| (|Fraction| (|Integer|)) "failed")) (|fac| (F))
          (|cp| (F)) (|p| (UP)) (#2=#:G873 NIL) (|f| NIL)
          (|n| #3=(|NonNegativeInteger|)) (|rp1| (UP)) (#4=#:G872 NIL)
          (|l| #3#) (|cp1| (F)) (|k| (|NonNegativeInteger|)) (|p1| (UP)))
         (SEQ (LETT |p1| (QCAR |f1|))
              (LETT |res|
                    (LIST (VECTOR |p1| (QCDR |f1|) (|spadConstant| $ 73))))
              (LETT |rr| NIL) (LETT |k| (SPADCALL |p1| (QREFELT $ 75)))
              (LETT |rp1| (SPADCALL |p1| (QREFELT $ 76)))
              (SEQ
               (EXIT
                (SEQ G190
                     (COND
                      ((NULL
                        (SPADCALL |rp1| (|spadConstant| $ 77) (QREFELT $ 78)))
                       (GO G191)))
                     (SEQ (LETT |cp1| (SPADCALL |rp1| (QREFELT $ 79)))
                          (LETT |l| (SPADCALL |rp1| (QREFELT $ 75)))
                          (COND
                           ((ODDP (- |k| |l|))
                            (PROGN (LETT #4# 1) (GO #5=#:G850))))
                          (EXIT (LETT |rp1| (SPADCALL |rp1| (QREFELT $ 76)))))
                     NIL (GO G190) G191 (EXIT NIL)))
               #5# (EXIT #4#))
              (LETT |n| (- |k| |l|))
              (SEQ (LETT |f| NIL) (LETT #2# |lp|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |f| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |rr| (CONS |f| |rr|)) (LETT |p| (QCAR |f|))
                        (EXIT
                         (COND
                          ((SPADCALL (SPADCALL |p| (QREFELT $ 75)) |k|
                                     (QREFELT $ 80))
                           "iterate")
                          ('T
                           (SEQ (LETT |cp| (SPADCALL |p| |l| (QREFELT $ 81)))
                                (EXIT
                                 (COND
                                  ((SPADCALL |cp| (|spadConstant| $ 41)
                                             (QREFELT $ 82))
                                   "iterate")
                                  ('T
                                   (SEQ
                                    (LETT |fac|
                                          (SPADCALL |cp| |cp1| (QREFELT $ 83)))
                                    (LETT |facu|
                                          (SPADCALL |fac| (QREFELT $ 85)))
                                    (EXIT
                                     (COND ((QEQCAR |facu| 1) "iterate")
                                           ('T
                                            (SEQ (LETT |nfac| (QCDR |facu|))
                                                 (LETT |nfac_ok| 'T)
                                                 (COND
                                                  ((> |n| 1)
                                                   (SEQ
                                                    (LETT |nnu|
                                                          (SPADCALL
                                                           (SPADCALL |nfac|
                                                                     (QREFELT $
                                                                              88))
                                                           |n| (QREFELT $ 91)))
                                                    (EXIT
                                                     (COND
                                                      ((QEQCAR |nnu| 1)
                                                       (LETT |nfac_ok| NIL))
                                                      ('T
                                                       (SEQ
                                                        (LETT |ndu|
                                                              (SPADCALL
                                                               (SPADCALL |nfac|
                                                                         (QREFELT
                                                                          $
                                                                          92))
                                                               |n|
                                                               (QREFELT $ 91)))
                                                        (EXIT
                                                         (COND
                                                          ((QEQCAR |ndu| 1)
                                                           (LETT |nfac_ok|
                                                                 NIL))
                                                          ('T
                                                           (LETT |nfac|
                                                                 (SPADCALL
                                                                  (QCDR |nnu|)
                                                                  (QCDR |ndu|)
                                                                  (QREFELT $
                                                                           93)))))))))))))
                                                 (EXIT
                                                  (COND
                                                   (|nfac_ok|
                                                    (COND
                                                     ((SPADCALL |p1|
                                                                (SPADCALL
                                                                 (SPADCALL
                                                                  (SPADCALL
                                                                   |nfac|
                                                                   (QREFELT $
                                                                            94))
                                                                  (- |k|)
                                                                  (QREFELT $
                                                                           95))
                                                                 (SPADCALL |p|
                                                                           (SPADCALL
                                                                            (SPADCALL
                                                                             |nfac|
                                                                             (QREFELT
                                                                              $
                                                                              94))
                                                                            1
                                                                            (QREFELT
                                                                             $
                                                                             96))
                                                                           (QREFELT
                                                                            $
                                                                            97))
                                                                 (QREFELT $
                                                                          98))
                                                                (QREFELT $ 78))
                                                      "iterate")
                                                     ('T
                                                      (SEQ
                                                       (LETT |res|
                                                             (CONS
                                                              (VECTOR |p|
                                                                      (QCDR
                                                                       |f|)
                                                                      |nfac|)
                                                              |res|))
                                                       (EXIT
                                                        (LETT |rr|
                                                              (CDR |rr|)))))))
                                                   ('T
                                                    "iterate"))))))))))))))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (LETT |res| (NREVERSE |res|)) (EXIT (CONS |res| |rr|))))) 

(SDEFUN |INTALG;handle_multiples1|
        ((|rec|
          (|Record| (|:| |num| R) (|:| |den| UP) (|:| |derivden| UP)
                    (|:| |gd| UP)))
         (|lp|
          (|List|
           (|Record| (|:| |factor| UP) (|:| |exponent| (|NonNegativeInteger|))
                     (|:| |coeff| #1=(|Fraction| (|Integer|))))))
         (|cc| (|Integer|))
         ($
          (|Record|
           (|:| |result1|
                (|List|
                 (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                           (|:| |coeff| (|SparseUnivariatePolynomial| R))
                           (|:| |logand| (|SparseUnivariatePolynomial| R)))))
           (|:| |result2|
                (|List|
                 (|Record| (|:| |factor| UP)
                           (|:| |exponent| (|NonNegativeInteger|))
                           (|:| |coeff| (|Fraction| (|Integer|)))
                           (|:| |scalar| F)
                           (|:| |divisor| (|FiniteDivisor| F UP UPUP R)))))
           (|:| |result3|
                (|List|
                 (|Record| (|:| |factor| UP)
                           (|:| |exponent| (|NonNegativeInteger|))
                           (|:| |coeff| (|Fraction| (|Integer|)))))))))
        (SPROG
         ((|llg|
           (|List|
            (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                      (|:| |coeff| (|SparseUnivariatePolynomial| R))
                      (|:| |logand| (|SparseUnivariatePolynomial| R)))))
          (|nlog|
           (|List|
            (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                      (|:| |coeff| (|SparseUnivariatePolynomial| R))
                      (|:| |logand| (|SparseUnivariatePolynomial| R)))))
          (|nlp|
           (|List|
            #2=(|Record| (|:| |factor| UP)
                         (|:| |exponent| (|NonNegativeInteger|))
                         (|:| |coeff| (|Fraction| (|Integer|)))
                         (|:| |scalar| F)
                         (|:| |divisor| (|FiniteDivisor| F UP UPUP R)))))
          (|pc2| #2#)
          (|rc|
           (|Union|
            (|Record| (|:| |order| (|NonNegativeInteger|)) (|:| |function| R))
            "failed"))
          (|di| (|FiniteDivisor| F UP UPUP R))
          (|di2| #3=(|FiniteDivisor| F UP UPUP R)) (|di1| #3#) (|na| (F))
          (|nfac| #1#) (#4=#:G901 NIL) (|peq| NIL) (|alpha| (F)) (|p| (UP))
          (|pc1|
           (|Record| (|:| |factor| UP) (|:| |exponent| (|NonNegativeInteger|))
                     (|:| |coeff| (|Fraction| (|Integer|))))))
         (SEQ (LETT |nlp| NIL) (LETT |llg| NIL) (LETT |pc1| (|SPADfirst| |lp|))
              (LETT |p| (QVELT |pc1| 0))
              (LETT |alpha| (SPADCALL (|INTALG;UP2SUP| |p| $) (QREFELT $ 100)))
              (SEQ (LETT |peq| NIL) (LETT #4# |lp|) G190
                   (COND
                    ((OR (ATOM #4#) (PROGN (LETT |peq| (CAR #4#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |nfac| (QVELT |peq| 2))
                        (LETT |na|
                              (SPADCALL (SPADCALL |nfac| (QREFELT $ 94))
                                        |alpha| (QREFELT $ 101)))
                        (LETT |di1|
                              (SPADCALL (QVELT |rec| 0) (QVELT |rec| 1)
                                        (QVELT |rec| 2) (QVELT |rec| 3) |na|
                                        (QREFELT $ 103)))
                        (LETT |di2|
                              (SPADCALL (QVELT |rec| 0) (QVELT |rec| 1)
                                        (QVELT |rec| 2) (QVELT |rec| 3)
                                        (SPADCALL |na| (QREFELT $ 104))
                                        (QREFELT $ 103)))
                        (LETT |di| (SPADCALL |di1| |di2| (QREFELT $ 105)))
                        (LETT |rc| (SPADCALL |di| (QREFELT $ 109)))
                        (EXIT
                         (COND
                          ((QEQCAR |rc| 1)
                           (SEQ
                            (LETT |pc2|
                                  (VECTOR (QVELT |peq| 0) (QVELT |peq| 1)
                                          (QVELT |peq| 2)
                                          (SPADCALL |na|
                                                    (SPADCALL |cc|
                                                              (QREFELT $ 110))
                                                    (QREFELT $ 83))
                                          |di|))
                            (EXIT (LETT |nlp| (CONS |pc2| |nlp|)))))
                          ('T
                           (SEQ
                            (LETT |nlog|
                                  (|INTALG;mkLog| |p|
                                   (SPADCALL |nfac|
                                             (SPADCALL
                                              (SPADCALL |cc|
                                                        (SPADCALL
                                                         (QCAR (QCDR |rc|))
                                                         (QREFELT $ 111))
                                                        (QREFELT $ 112))
                                              (QREFELT $ 113))
                                             (QREFELT $ 114))
                                   (QCDR (QCDR |rc|)) |alpha| $))
                            (EXIT
                             (LETT |llg|
                                   (SPADCALL |nlog| |llg|
                                             (QREFELT $ 115)))))))))
                   (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
              (EXIT (VECTOR |llg| |nlp| NIL))))) 

(SDEFUN |INTALG;handle_multiples|
        ((|rec|
          (|Record| (|:| |num| R) (|:| |den| UP) (|:| |derivden| UP)
                    (|:| |gd| UP)))
         (|lp|
          (|List|
           #1=(|Record| (|:| |factor| UP)
                        (|:| |exponent| (|NonNegativeInteger|))
                        (|:| |coeff| #2=(|Fraction| (|Integer|))))))
         ($
          (|Record|
           (|:| |result1|
                (|List|
                 (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                           (|:| |coeff| (|SparseUnivariatePolynomial| R))
                           (|:| |logand| (|SparseUnivariatePolynomial| R)))))
           (|:| |result2|
                (|List|
                 (|Record| (|:| |factor| UP)
                           (|:| |exponent| (|NonNegativeInteger|))
                           (|:| |coeff| (|Fraction| (|Integer|)))
                           (|:| |scalar| F)
                           (|:| |divisor| (|FiniteDivisor| F UP UPUP R)))))
           (|:| |result3|
                (|List|
                 (|Record| (|:| |factor| UP)
                           (|:| |exponent| (|NonNegativeInteger|))
                           (|:| |coeff| (|Fraction| (|Integer|)))))))))
        (SPROG
         ((#3=#:G923 NIL)
          (|ff|
           (|Record| (|:| |factor| UP) (|:| |exponent| (|NonNegativeInteger|))
                     (|:| |coeff| (|Fraction| (|Integer|)))))
          (|fu|
           (|Union|
            (|Record| (|:| |factor| UP) (|:| |exponent| (|NonNegativeInteger|))
                      (|:| |coeff| (|Fraction| (|Integer|))))
            "failed"))
          (|nfac| #2#) (#4=#:G926 NIL) (|peq| NIL) (|lp1| (|List| #1#))
          (#5=#:G925 NIL) (#6=#:G924 NIL) (|p| (UP))
          (|pc1|
           (|Record| (|:| |factor| UP) (|:| |exponent| (|NonNegativeInteger|))
                     (|:| |coeff| (|Fraction| (|Integer|))))))
         (SEQ
          (EXIT
           (SEQ (LETT |pc1| (|SPADfirst| |lp|)) (LETT |p| (QVELT |pc1| 0))
                (EXIT
                 (COND
                  ((SPADCALL |p|
                             (SPADCALL |p|
                                       (SPADCALL
                                        (SPADCALL (|spadConstant| $ 87)
                                                  (QREFELT $ 104))
                                        1 (QREFELT $ 96))
                                       (QREFELT $ 97))
                             (QREFELT $ 116))
                   (|INTALG;handle_multiples1| |rec| |lp| 2 $))
                  (#7='T
                   (SEQ
                    (LETT |lp1|
                          (PROGN
                           (LETT #6# NIL)
                           (SEQ (LETT |peq| NIL) (LETT #5# |lp|) G190
                                (COND
                                 ((OR (ATOM #5#)
                                      (PROGN (LETT |peq| (CAR #5#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (COND
                                   ((SPADCALL (QVELT |peq| 2)
                                              (|spadConstant| $ 117)
                                              (QREFELT $ 118))
                                    (LETT #6# (CONS |peq| #6#))))))
                                (LETT #5# (CDR #5#)) (GO G190) G191
                                (EXIT (NREVERSE #6#)))))
                    (EXIT
                     (COND
                      ((SPADCALL (LENGTH |lp|) (* 2 (LENGTH |lp1|))
                                 (QREFELT $ 80))
                       (VECTOR NIL NIL |lp|))
                      (#7#
                       (SEQ
                        (SEQ (LETT |peq| NIL) (LETT #4# |lp1|) G190
                             (COND
                              ((OR (ATOM #4#)
                                   (PROGN (LETT |peq| (CAR #4#)) NIL))
                               (GO G191)))
                             (SEQ (LETT |nfac| (QVELT |peq| 2))
                                  (LETT |fu|
                                        (SPADCALL
                                         (CONS #'|INTALG;handle_multiples!0|
                                               (VECTOR $ |nfac|))
                                         |lp| (QREFELT $ 125)))
                                  (EXIT
                                   (COND
                                    ((QEQCAR |fu| 1)
                                     (PROGN
                                      (LETT #3# (VECTOR NIL NIL |lp|))
                                      (GO #8=#:G922)))
                                    ('T
                                     (SEQ (LETT |ff| (QCDR |fu|))
                                          (EXIT
                                           (COND
                                            ((SPADCALL (QVELT |ff| 1)
                                                       (QVELT |peq| 1)
                                                       (QREFELT $ 80))
                                             (PROGN
                                              (LETT #3# (VECTOR NIL NIL |lp|))
                                              (GO #8#))))))))))
                             (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
                        (EXIT
                         (|INTALG;handle_multiples1| |rec| |lp1| 1
                          $))))))))))))
          #8# (EXIT #3#)))) 

(SDEFUN |INTALG;handle_multiples!0| ((|x| NIL) ($$ NIL))
        (PROG (|nfac| $)
          (LETT |nfac| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (QVELT |x| 2) (SPADCALL |nfac| (QREFELT $ 119))
                      (QREFELT $ 120)))))) 

(SDEFUN |INTALG;get_coeffs0| ((|lp| (|List| UP)) ($ (|List| F)))
        (SPROG ((|res| (|List| F)) (#1=#:G931 NIL) (|p| NIL))
               (SEQ (LETT |res| NIL)
                    (SEQ (LETT |p| NIL) (LETT #1# |lp|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |p| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |res|
                                 (SPADCALL (SPADCALL |p| (QREFELT $ 127)) |res|
                                           (QREFELT $ 128)))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |res|)))) 

(SDEFUN |INTALG;get_coeffs1| ((|pp| (UPUP)) ($ (|List| UP)))
        (SPROG
         ((|dlp| #1=(|List| UP)) (|nlp| #1#) (|lp| (|List| (|Fraction| UP))))
         (SEQ (LETT |lp| (SPADCALL |pp| (QREFELT $ 130)))
              (LETT |nlp| (SPADCALL (ELT $ 131) |lp| (QREFELT $ 135)))
              (LETT |dlp| (SPADCALL (ELT $ 136) |lp| (QREFELT $ 135)))
              (EXIT (SPADCALL |nlp| |dlp| (QREFELT $ 137)))))) 

(SDEFUN |INTALG;get_coeffs|
        ((|rec|
          (|Record| (|:| |num| R) (|:| |den| UP) (|:| |derivden| UP)
                    (|:| |gd| UP)))
         ($ (|List| F)))
        (SPROG ((|dlp| #1=(|List| UP)) (|nlp| #1#) (|clp| (|List| UP)))
               (SEQ
                (LETT |clp|
                      (LIST (QVELT |rec| 1) (QVELT |rec| 2) (QVELT |rec| 3)))
                (LETT |nlp|
                      (|INTALG;get_coeffs1|
                       (SPADCALL (QVELT |rec| 0) (QREFELT $ 138)) $))
                (LETT |dlp|
                      (|INTALG;get_coeffs1| (SPADCALL (QREFELT $ 139)) $))
                (EXIT
                 (|INTALG;get_coeffs0|
                  (SPADCALL |clp| (SPADCALL |nlp| |dlp| (QREFELT $ 137))
                            (QREFELT $ 137))
                  $))))) 

(SDEFUN |INTALG;classify_divisors|
        ((|rec|
          (|Record| (|:| |num| R) (|:| |den| UP) (|:| |derivden| UP)
                    (|:| |gd| UP)))
         (|r| (UP))
         ($
          (|Record|
           (|:| |result1|
                (|List|
                 (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                           (|:| |coeff| (|SparseUnivariatePolynomial| R))
                           (|:| |logand| (|SparseUnivariatePolynomial| R)))))
           (|:| |result2|
                (|List|
                 (|List|
                  (|Record| (|:| |factor| UP)
                            (|:| |exponent| (|NonNegativeInteger|))
                            (|:| |coeff| (|Fraction| (|Integer|)))
                            (|:| |scalar| F)
                            (|:| |divisor| (|FiniteDivisor| F UP UPUP R))))))
           (|:| |result3|
                (|List|
                 (|List|
                  (|Record| (|:| |factor| UP)
                            (|:| |exponent| (|NonNegativeInteger|))
                            (|:| |coeff| (|Fraction| (|Integer|))))))))))
        (SPROG
         ((|nlm2|
           (|List|
            (|List|
             (|Record| (|:| |factor| UP)
                       (|:| |exponent| (|NonNegativeInteger|))
                       (|:| |coeff| (|Fraction| (|Integer|)))))))
          (|nlp2|
           (|List|
            (|Record| (|:| |factor| UP) (|:| |exponent| (|NonNegativeInteger|))
                      (|:| |coeff| (|Fraction| (|Integer|))))))
          (|nlm1|
           (|List|
            (|List|
             (|Record| (|:| |factor| UP)
                       (|:| |exponent| (|NonNegativeInteger|))
                       (|:| |coeff| (|Fraction| (|Integer|))) (|:| |scalar| F)
                       (|:| |divisor| (|FiniteDivisor| F UP UPUP R))))))
          (|nlp1|
           (|List|
            (|Record| (|:| |factor| UP) (|:| |exponent| (|NonNegativeInteger|))
                      (|:| |coeff| (|Fraction| (|Integer|))) (|:| |scalar| F)
                      (|:| |divisor| (|FiniteDivisor| F UP UPUP R)))))
          (|llg|
           (|List|
            (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                      (|:| |coeff| (|SparseUnivariatePolynomial| R))
                      (|:| |logand| (|SparseUnivariatePolynomial| R)))))
          (|rr2|
           (|Record|
            (|:| |result1|
                 (|List|
                  (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                            (|:| |coeff| (|SparseUnivariatePolynomial| R))
                            (|:| |logand| (|SparseUnivariatePolynomial| R)))))
            (|:| |result2|
                 (|List|
                  (|Record| (|:| |factor| UP)
                            (|:| |exponent| (|NonNegativeInteger|))
                            (|:| |coeff| (|Fraction| (|Integer|)))
                            (|:| |scalar| F)
                            (|:| |divisor| (|FiniteDivisor| F UP UPUP R)))))
            (|:| |result3|
                 (|List|
                  (|Record| (|:| |factor| UP)
                            (|:| |exponent| (|NonNegativeInteger|))
                            (|:| |coeff| (|Fraction| (|Integer|))))))))
          (#1=#:G965 NIL) (|lp| NIL)
          (|lm|
           (|List|
            (|List|
             (|Record| (|:| |factor| UP)
                       (|:| |exponent| (|NonNegativeInteger|))
                       (|:| |coeff| (|Fraction| (|Integer|)))))))
          (|lf|
           (|List|
            (|Record| (|:| |factor| UP)
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (|rp|
           (|Record|
            (|:| |result1|
                 (|List|
                  (|Record| (|:| |factor| UP)
                            (|:| |exponent| (|NonNegativeInteger|))
                            (|:| |coeff| (|Fraction| (|Integer|))))))
            (|:| |result2|
                 (|List|
                  (|Record| (|:| |factor| UP)
                            (|:| |exponent| (|NonNegativeInteger|)))))))
          (|u| (|Factored| UP))
          (|u0| (|Factored| (|SparseUnivariatePolynomial| F)))
          (|cl| (|List| F)))
         (SEQ (LETT |cl| (|INTALG;get_coeffs| |rec| $))
              (LETT |u0|
                    (SPADCALL
                     (SPADCALL (SPADCALL |r| (QREFELT $ 140)) (QREFELT $ 142))
                     |cl| (QREFELT $ 145)))
              (LETT |u|
                    (SPADCALL (CONS (|function| |INTALG;SUP2UP|) $) |u0|
                              (QREFELT $ 149)))
              (LETT |lf| (SPADCALL |u| (QREFELT $ 152))) (LETT |lm| NIL)
              (SEQ G190 (COND ((NULL (NULL (NULL |lf|))) (GO G191)))
                   (SEQ
                    (LETT |rp|
                          (|INTALG;find_multiples| (|SPADfirst| |lf|)
                           (CDR |lf|) $))
                    (LETT |lf| (QCDR |rp|))
                    (EXIT (LETT |lm| (CONS (QCAR |rp|) |lm|))))
                   NIL (GO G190) G191 (EXIT NIL))
              (LETT |llg| NIL) (LETT |nlm1| NIL) (LETT |nlm2| NIL)
              (SEQ (LETT |lp| NIL) (LETT #1# |lm|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |lp| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |rr2| (|INTALG;handle_multiples| |rec| |lp| $))
                        (LETT |llg|
                              (SPADCALL (QVELT |rr2| 0) |llg| (QREFELT $ 115)))
                        (COND
                         ((NULL (NULL (LETT |nlp1| (QVELT |rr2| 1))))
                          (LETT |nlm1| (CONS |nlp1| |nlm1|))))
                        (EXIT
                         (COND
                          ((NULL (NULL (LETT |nlp2| (QVELT |rr2| 2))))
                           (LETT |nlm2| (CONS |nlp2| |nlm2|))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (VECTOR |llg| |nlm1| |nlm2|))))) 

(SDEFUN |INTALG;get_lf|
        ((|ll1|
          (|List|
           (|List|
            (|Record| (|:| |factor| UP) (|:| |exponent| (|NonNegativeInteger|))
                      (|:| |coeff| (|Fraction| (|Integer|))) (|:| |scalar| F)
                      (|:| |divisor| (|FiniteDivisor| F UP UPUP R))))))
         (|ll2|
          (|List|
           (|List|
            (|Record| (|:| |factor| UP) (|:| |exponent| (|NonNegativeInteger|))
                      (|:| |coeff| (|Fraction| (|Integer|)))))))
         ($ (|List| UP)))
        (SPROG
         ((#1=#:G982 NIL) (|peq| NIL) (#2=#:G981 NIL) (#3=#:G980 NIL)
          (#4=#:G979 NIL))
         (SEQ (COND ((NULL |ll1|) (COND ((NULL |ll2|) (EXIT NIL)))))
              (EXIT
               (COND
                ((> (+ (LENGTH |ll1|) (LENGTH |ll2|)) 1)
                 (|error|
                  "integrate: implementation incomplete (irrational residues)"))
                ((NULL |ll1|)
                 (PROGN
                  (LETT #4# NIL)
                  (SEQ (LETT |peq| NIL) (LETT #3# (|SPADfirst| |ll2|)) G190
                       (COND
                        ((OR (ATOM #3#) (PROGN (LETT |peq| (CAR #3#)) NIL))
                         (GO G191)))
                       (SEQ (EXIT (LETT #4# (CONS (QVELT |peq| 0) #4#))))
                       (LETT #3# (CDR #3#)) (GO G190) G191
                       (EXIT (NREVERSE #4#)))))
                ('T
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |peq| NIL) (LETT #1# (|SPADfirst| |ll1|)) G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |peq| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ (EXIT (LETT #2# (CONS (QVELT |peq| 0) #2#))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#)))))))))) 

(SDEFUN |INTALG;get_la|
        ((|ll1|
          (|List|
           (|List|
            (|Record| (|:| |factor| UP) (|:| |exponent| (|NonNegativeInteger|))
                      (|:| |coeff| (|Fraction| (|Integer|))) (|:| |scalar| F)
                      (|:| |divisor| (|FiniteDivisor| F UP UPUP R))))))
         (|ll2|
          (|List|
           (|List|
            (|Record| (|:| |factor| UP) (|:| |exponent| (|NonNegativeInteger|))
                      (|:| |coeff| (|Fraction| (|Integer|)))))))
         ($ (|List| F)))
        (SPROG ((#1=#:G989 NIL) (|lfac| NIL) (#2=#:G988 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |lfac| NIL)
                      (LETT #1# (|INTALG;get_lf| |ll1| |ll2| $)) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |lfac| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS
                               (SPADCALL (SPADCALL |lfac| 0 (QREFELT $ 81))
                                         (QREFELT $ 104))
                               #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |INTALG;get_ld|
        ((|rec|
          (|Record| (|:| |num| R) (|:| |den| UP) (|:| |derivden| UP)
                    (|:| |gd| UP)))
         (|ll1|
          (|List|
           (|List|
            (|Record| (|:| |factor| UP) (|:| |exponent| (|NonNegativeInteger|))
                      (|:| |coeff| (|Fraction| (|Integer|))) (|:| |scalar| F)
                      (|:| |divisor| (|FiniteDivisor| F UP UPUP R))))))
         (|ll2|
          (|List|
           (|List|
            (|Record| (|:| |factor| UP) (|:| |exponent| (|NonNegativeInteger|))
                      (|:| |coeff| (|Fraction| (|Integer|)))))))
         ($ (|List| (|FiniteDivisor| F UP UPUP R))))
        (SPROG
         ((#1=#:G1007 NIL) (|peq| NIL) (#2=#:G1006 NIL) (#3=#:G1005 NIL)
          (|a| NIL) (#4=#:G1004 NIL))
         (SEQ (COND ((NULL |ll1|) (COND ((NULL |ll2|) (EXIT NIL)))))
              (EXIT
               (COND
                ((> (+ (LENGTH |ll1|) (LENGTH |ll2|)) 1)
                 (|error|
                  "integrate: implementation incomplete (irrational residues)"))
                ((NULL |ll1|)
                 (PROGN
                  (LETT #4# NIL)
                  (SEQ (LETT |a| NIL)
                       (LETT #3# (|INTALG;get_la| |ll1| |ll2| $)) G190
                       (COND
                        ((OR (ATOM #3#) (PROGN (LETT |a| (CAR #3#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #4#
                               (CONS
                                (SPADCALL (QVELT |rec| 0) (QVELT |rec| 1)
                                          (QVELT |rec| 2) (QVELT |rec| 3) |a|
                                          (QREFELT $ 103))
                                #4#))))
                       (LETT #3# (CDR #3#)) (GO G190) G191
                       (EXIT (NREVERSE #4#)))))
                ('T
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |peq| NIL) (LETT #1# (|SPADfirst| |ll1|)) G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |peq| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ (EXIT (LETT #2# (CONS (QVELT |peq| 4) #2#))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#)))))))))) 

(SDEFUN |INTALG;palglogint|
        ((|f| (R)) (|derivation| (|Mapping| UP UP))
         ($
          (|Union|
           (|List|
            (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                      (|:| |coeff| (|SparseUnivariatePolynomial| R))
                      (|:| |logand| (|SparseUnivariatePolynomial| R))))
           "failed")))
        (SPROG
         ((|tr1u|
           (|Union|
            (|List|
             (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                       (|:| |coeff| (|SparseUnivariatePolynomial| R))
                       (|:| |logand| (|SparseUnivariatePolynomial| R))))
            "failed"))
          (|v1| (|FiniteDivisor| F UP UPUP R)) (|alpha| (F))
          (|ld| (|List| (|FiniteDivisor| F UP UPUP R))) (|la| (|List| F))
          (|bb| (F)) (#1=#:G1087 NIL) (|fcf| (UP))
          (|lins2|
           (|List|
            #2=(|List|
                (|Record| (|:| |factor| UP)
                          (|:| |exponent| (|NonNegativeInteger|))
                          (|:| |coeff| (|Fraction| (|Integer|)))))))
          (|fc2|
           (|Record| (|:| |factor| UP) (|:| |exponent| (|NonNegativeInteger|))
                     (|:| |coeff| (|Fraction| (|Integer|)))))
          (|nfl2|
           (|List|
            (|Record| (|:| |factor| UP) (|:| |exponent| (|NonNegativeInteger|))
                      (|:| |coeff| (|Fraction| (|Integer|))))))
          (#3=#:G1064 NIL)
          (|lins1|
           (|List|
            #4=(|List|
                (|Record| (|:| |factor| UP)
                          (|:| |exponent| (|NonNegativeInteger|))
                          (|:| |coeff| (|Fraction| (|Integer|)))
                          (|:| |scalar| F)
                          (|:| |divisor| (|FiniteDivisor| F UP UPUP R))))))
          (|fc1|
           (|Record| (|:| |factor| UP) (|:| |exponent| (|NonNegativeInteger|))
                     (|:| |coeff| (|Fraction| (|Integer|))) (|:| |scalar| F)
                     (|:| |divisor| (|FiniteDivisor| F UP UPUP R))))
          (|nfl1|
           (|List|
            (|Record| (|:| |factor| UP) (|:| |exponent| (|NonNegativeInteger|))
                      (|:| |coeff| (|Fraction| (|Integer|))) (|:| |scalar| F)
                      (|:| |divisor| (|FiniteDivisor| F UP UPUP R)))))
          (#5=#:G1100 NIL) (|nfl| NIL) (#6=#:G1099 NIL) (#7=#:G1098 NIL)
          (#8=#:G1097 NIL)
          (|nlins2|
           (|List|
            (|List|
             (|Record| (|:| |factor| UP)
                       (|:| |exponent| (|NonNegativeInteger|))
                       (|:| |coeff| (|Fraction| (|Integer|)))))))
          (|root_fails| (|Integer|))
          (|pp|
           (|Union|
            (|List|
             (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                       (|:| |coeff| (|SparseUnivariatePolynomial| R))
                       (|:| |logand| (|SparseUnivariatePolynomial| R))))
            "failed"))
          (#9=#:G1096 NIL) (|nlins1| (|List| #4#)) (#10=#:G1095 NIL)
          (#11=#:G1094 NIL) (|nfacs2| (|List| #2#)) (|nfacs1| (|List| #4#))
          (|ppr|
           (|Record|
            (|:| |result1|
                 (|List|
                  (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                            (|:| |coeff| (|SparseUnivariatePolynomial| R))
                            (|:| |logand| (|SparseUnivariatePolynomial| R)))))
            (|:| |result2|
                 (|List|
                  (|List|
                   (|Record| (|:| |factor| UP)
                             (|:| |exponent| (|NonNegativeInteger|))
                             (|:| |coeff| (|Fraction| (|Integer|)))
                             (|:| |scalar| F)
                             (|:| |divisor| (|FiniteDivisor| F UP UPUP R))))))
            (|:| |result3|
                 (|List|
                  (|List|
                   (|Record| (|:| |factor| UP)
                             (|:| |exponent| (|NonNegativeInteger|))
                             (|:| |coeff| (|Fraction| (|Integer|)))))))))
          (|r| (UP))
          (|rec|
           (|Record| (|:| |num| R) (|:| |den| UP) (|:| |derivden| UP)
                     (|:| |gd| UP))))
         (SEQ (LETT |rec| (SPADCALL |f| |derivation| (QREFELT $ 154)))
              (EXIT
               (COND
                ((SPADCALL
                  (LETT |r| (SPADCALL |f| |derivation| (QREFELT $ 156)))
                  (QREFELT $ 157))
                 (CONS 0 NIL))
                (#12='T
                 (SEQ (LETT |ppr| (|INTALG;classify_divisors| |rec| |r| $))
                      (LETT |nfacs1| (QVELT |ppr| 1))
                      (LETT |nfacs2| (QVELT |ppr| 2))
                      (COND
                       ((NULL |nfacs1|)
                        (COND
                         ((NULL |nfacs2|) (EXIT (CONS 0 (QVELT |ppr| 0)))))))
                      (LETT |nlins1|
                            (PROGN
                             (LETT #11# NIL)
                             (SEQ (LETT |nfl| NIL) (LETT #10# |nfacs1|) G190
                                  (COND
                                   ((OR (ATOM #10#)
                                        (PROGN (LETT |nfl| (CAR #10#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (COND
                                     ((>
                                       (SPADCALL (QVELT (|SPADfirst| |nfl|) 0)
                                                 (QREFELT $ 75))
                                       1)
                                      (LETT #11# (CONS |nfl| #11#))))))
                                  (LETT #10# (CDR #10#)) (GO G190) G191
                                  (EXIT (NREVERSE #11#)))))
                      (LETT |nlins2| NIL) (LETT |root_fails| 0)
                      (SEQ (LETT |nfl| NIL) (LETT #9# |nfacs2|) G190
                           (COND
                            ((OR (ATOM #9#) (PROGN (LETT |nfl| (CAR #9#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((>
                                (SPADCALL (QVELT (|SPADfirst| |nfl|) 0)
                                          (QREFELT $ 75))
                                1)
                               (SEQ (LETT |fcf| (QVELT (|SPADfirst| |nfl|) 0))
                                    (COND
                                     ((EQL (SPADCALL |fcf| (QREFELT $ 75)) 3)
                                      (COND
                                       ((EQL
                                         (SPADCALL
                                          (SPADCALL |fcf| (QREFELT $ 76))
                                          (QREFELT $ 75))
                                         0)
                                        (EXIT
                                         (SEQ
                                          (LETT |pp|
                                                (|INTALG;do_root| |fcf| |rec|
                                                 $))
                                          (EXIT
                                           (COND
                                            ((QEQCAR |pp| 1)
                                             (SEQ
                                              (LETT |nlins2|
                                                    (CONS |nfl| |nlins2|))
                                              (EXIT
                                               (LETT |root_fails|
                                                     (+ |root_fails|
                                                        (LENGTH |nfl|))))))
                                            ('T
                                             (QSETVELT |ppr| 0
                                                       (SPADCALL (QCDR |pp|)
                                                                 (QVELT |ppr|
                                                                        0)
                                                                 (QREFELT $
                                                                          115))))))))))))
                                    (EXIT
                                     (LETT |nlins2|
                                           (CONS |nfl| |nlins2|))))))))
                           (LETT #9# (CDR #9#)) (GO G190) G191 (EXIT NIL))
                      (LETT |nlins2| (NREVERSE |nlins2|))
                      (COND
                       ((EQL |root_fails| 1)
                        (COND
                         ((EQL (LENGTH |nlins2|) 1)
                          (COND
                           ((EQL (LENGTH |nlins1|) 0)
                            (EXIT (CONS 1 "failed"))))))))
                      (EXIT
                       (COND
                        ((> (+ (LENGTH |nlins1|) (LENGTH |nlins2|)) 1)
                         (|error|
                          #13="integrate: implementation incomplete (residue poly has multiple non-linear factors)"))
                        (#12#
                         (SEQ
                          (LETT |lins1|
                                (PROGN
                                 (LETT #8# NIL)
                                 (SEQ (LETT |nfl| NIL) (LETT #7# |nfacs1|) G190
                                      (COND
                                       ((OR (ATOM #7#)
                                            (PROGN (LETT |nfl| (CAR #7#)) NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (COND
                                         ((EQL
                                           (SPADCALL
                                            (QVELT (|SPADfirst| |nfl|) 0)
                                            (QREFELT $ 75))
                                           1)
                                          (LETT #8# (CONS |nfl| #8#))))))
                                      (LETT #7# (CDR #7#)) (GO G190) G191
                                      (EXIT (NREVERSE #8#)))))
                          (LETT |lins2|
                                (PROGN
                                 (LETT #6# NIL)
                                 (SEQ (LETT |nfl| NIL) (LETT #5# |nfacs2|) G190
                                      (COND
                                       ((OR (ATOM #5#)
                                            (PROGN (LETT |nfl| (CAR #5#)) NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (COND
                                         ((EQL
                                           (SPADCALL
                                            (QVELT (|SPADfirst| |nfl|) 0)
                                            (QREFELT $ 75))
                                           1)
                                          (LETT #6# (CONS |nfl| #6#))))))
                                      (LETT #5# (CDR #5#)) (GO G190) G191
                                      (EXIT (NREVERSE #6#)))))
                          (COND
                           ((NULL |nlins2|)
                            (COND
                             ((NULL |lins2|)
                              (COND
                               ((NULL |nfacs1|)
                                (EXIT (CONS 0 (QVELT |ppr| 0)))))))))
                          (COND
                           ((NULL |nfacs2|)
                            (COND
                             ((NULL |nlins1|)
                              (COND
                               ((EQL (LENGTH |lins1|) 1)
                                (COND
                                 ((EQL (LENGTH (|SPADfirst| |lins1|)) 1)
                                  (EXIT (CONS 1 "failed"))))))))))
                          (COND
                           ((> (LENGTH |nfacs1|) 0)
                            (COND
                             ((EQL (LENGTH |nlins2|) 0)
                              (EXIT
                               (SEQ
                                (COND
                                 ((EQL (LENGTH |nlins1|) 1)
                                  (SEQ (LETT |nfl1| (|SPADfirst| |nlins1|))
                                       (COND
                                        ((NULL (NULL (CDR |nfl1|)))
                                         (EXIT (|error| #13#))))
                                       (LETT |fc1| (|SPADfirst| |nfl1|))
                                       (EXIT (LETT |fcf| (QVELT |fc1| 0)))))
                                 ((> (LENGTH |lins1|) 1)
                                  (|error|
                                   #14="integrate: implementation incomplete (irrational residues)"))
                                 (#12#
                                  (SEQ (LETT |nfl1| (|SPADfirst| |lins1|))
                                       (EXIT
                                        (COND
                                         ((NULL (CDR |nfl1|)) (|error| #14#))
                                         (#12#
                                          (SEQ
                                           (LETT |fc1| (|SPADfirst| |nfl1|))
                                           (LETT |fcf| (QVELT |fc1| 0))
                                           (EXIT
                                            (LETT |lins1|
                                                  (LIST (CDR |nfl1|)))))))))))
                                (EXIT
                                 (COND
                                  ((SPADCALL
                                    (LETT |bb|
                                          (SPADCALL |fcf|
                                                    (PROG1
                                                        (LETT #3#
                                                              (-
                                                               (SPADCALL |fcf|
                                                                         (QREFELT
                                                                          $
                                                                          75))
                                                               1))
                                                      (|check_subtype2|
                                                       (>= #3# 0)
                                                       '(|NonNegativeInteger|)
                                                       '(|Integer|) #3#))
                                                    (QREFELT $ 81)))
                                    (QREFELT $ 158))
                                   (COND
                                    ((SPADCALL |fcf|
                                               (SPADCALL |fcf|
                                                         (SPADCALL
                                                          (SPADCALL
                                                           (|spadConstant| $
                                                                           87)
                                                           (QREFELT $ 104))
                                                          1 (QREFELT $ 96))
                                                         (QREFELT $ 97))
                                               (QREFELT $ 116))
                                     (COND
                                      ((EQL (SPADCALL |fcf| (QREFELT $ 75)) 2)
                                       (CONS 1 "failed"))
                                      (#12#
                                       (SEQ
                                        (COND
                                         ((NULL |nfacs2|)
                                          (COND
                                           ((EQL (LENGTH |nfacs1|) 1)
                                            (COND
                                             ((EQL
                                               (SPADCALL |fcf| (QREFELT $ 75))
                                               4)
                                              (EXIT (CONS 1 "failed"))))))))
                                        (EXIT
                                         (|error|
                                          #15="Not integrable (provided residues have no relations)"))))))
                                    (#12# (|error| #15#))))
                                  (#12#
                                   (SEQ
                                    (LETT |la|
                                          (|INTALG;get_la| |lins1| |lins2| $))
                                    (LETT |ld|
                                          (|INTALG;get_ld| |rec| |lins1|
                                           |lins2| $))
                                    (LETT |tr1u|
                                          (|INTALG;trace1| |fcf| |la| |ld|
                                           (QVELT |fc1| 4) (QVELT |fc1| 3) |bb|
                                           $))
                                    (EXIT
                                     (COND
                                      ((QEQCAR |tr1u| 1) (CONS 1 "failed"))
                                      (#12#
                                       (CONS 0
                                             (SPADCALL (QVELT |ppr| 0)
                                                       (QCDR |tr1u|)
                                                       (QREFELT $
                                                                115))))))))))))))))
                          (EXIT
                           (COND
                            ((> (+ (LENGTH |lins1|) (LENGTH |lins2|)) 1)
                             (|error| #14#))
                            (#12#
                             (SEQ
                              (COND
                               ((EQL (LENGTH |nlins2|) 1)
                                (SEQ (LETT |nfl2| (|SPADfirst| |nlins2|))
                                     (COND
                                      ((NULL (NULL (CDR |nfl2|)))
                                       (EXIT (|error| #13#))))
                                     (EXIT (LETT |fc2| (|SPADfirst| |nfl2|)))))
                               ((> (LENGTH |lins2|) 1) (|error| #14#))
                               (#12#
                                (SEQ (LETT |nfl2| (|SPADfirst| |lins2|))
                                     (LETT |fc2| (|SPADfirst| |nfl2|))
                                     (EXIT
                                      (LETT |lins2| (LIST (CDR |nfl2|)))))))
                              (LETT |fcf| (QVELT |fc2| 0))
                              (EXIT
                               (COND
                                ((SPADCALL
                                  (LETT |bb|
                                        (SPADCALL |fcf|
                                                  (PROG1
                                                      (LETT #1#
                                                            (-
                                                             (SPADCALL |fcf|
                                                                       (QREFELT
                                                                        $ 75))
                                                             1))
                                                    (|check_subtype2|
                                                     (>= #1# 0)
                                                     '(|NonNegativeInteger|)
                                                     '(|Integer|) #1#))
                                                  (QREFELT $ 81)))
                                  (QREFELT $ 158))
                                 (|error|
                                  (|error|
                                   "integrate: implementation incomplete (trace 0)")))
                                (#12#
                                 (SEQ
                                  (LETT |la|
                                        (|INTALG;get_la| |lins1| |lins2| $))
                                  (LETT |ld|
                                        (|INTALG;get_ld| |rec| |lins1| |lins2|
                                         $))
                                  (LETT |alpha|
                                        (SPADCALL (|INTALG;UP2SUP| |fcf| $)
                                                  (QREFELT $ 100)))
                                  (LETT |v1|
                                        (SPADCALL (QVELT |rec| 0)
                                                  (QVELT |rec| 1)
                                                  (QVELT |rec| 2)
                                                  (QVELT |rec| 3) |alpha|
                                                  (QREFELT $ 103)))
                                  (LETT |tr1u|
                                        (|INTALG;trace1| |fcf| |la| |ld| |v1|
                                         |alpha| |bb| $))
                                  (EXIT
                                   (COND ((QEQCAR |tr1u| 1) (CONS 1 "failed"))
                                         (#12#
                                          (CONS 0
                                                (SPADCALL (QVELT |ppr| 0)
                                                          (QCDR |tr1u|)
                                                          (QREFELT $
                                                                   115))))))))))))))))))))))))) 

(SDEFUN |INTALG;do_root|
        ((|q| (UP))
         (|rec|
          (|Record| (|:| |num| R) (|:| |den| UP) (|:| |derivden| UP)
                    (|:| |gd| UP)))
         ($
          (|Union|
           (|List|
            (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                      (|:| |coeff| (|SparseUnivariatePolynomial| R))
                      (|:| |logand| (|SparseUnivariatePolynomial| R))))
           "failed")))
        (SPROG
         ((|rc|
           (|Union|
            (|Record| (|:| |order| (|NonNegativeInteger|)) (|:| |function| R))
            "failed"))
          (|vp| (|FiniteDivisor| F UP UPUP R))
          (|vp2| (|FiniteDivisor| F UP UPUP R))
          (|vp1| (|FiniteDivisor| F UP UPUP R))
          (|v3| #1=(|FiniteDivisor| F UP UPUP R)) (|v2| #1#) (|v1| #1#)
          (|w1| (F)) (|beta| (F)) (|alpha| (F)))
         (SEQ (LETT |alpha| (SPADCALL (|INTALG;UP2SUP| |q| $) (QREFELT $ 100)))
              (LETT |beta|
                    (SPADCALL
                     (SPADCALL (SPADCALL 3 (QREFELT $ 110)) (QREFELT $ 104))
                     (QREFELT $ 159)))
              (LETT |w1|
                    (SPADCALL
                     (SPADCALL |beta| (|spadConstant| $ 87) (QREFELT $ 160))
                     (SPADCALL 2 (QREFELT $ 110)) (QREFELT $ 83)))
              (LETT |v1|
                    (SPADCALL (QVELT |rec| 0) (QVELT |rec| 1) (QVELT |rec| 2)
                              (QVELT |rec| 3) |alpha| (QREFELT $ 103)))
              (LETT |v2|
                    (SPADCALL (QVELT |rec| 0) (QVELT |rec| 1) (QVELT |rec| 2)
                              (QVELT |rec| 3)
                              (SPADCALL |w1| |alpha| (QREFELT $ 101))
                              (QREFELT $ 103)))
              (LETT |v3|
                    (SPADCALL (QVELT |rec| 0) (QVELT |rec| 1) (QVELT |rec| 2)
                              (QVELT |rec| 3)
                              (SPADCALL (SPADCALL |w1| 2 (QREFELT $ 162))
                                        |alpha| (QREFELT $ 101))
                              (QREFELT $ 103)))
              (LETT |vp1| (SPADCALL 2 |v1| (QREFELT $ 163)))
              (LETT |vp2| (SPADCALL |v2| |v3| (QREFELT $ 164)))
              (LETT |vp| (SPADCALL |vp1| |vp2| (QREFELT $ 105)))
              (LETT |rc| (SPADCALL |vp| (QREFELT $ 109)))
              (EXIT
               (COND ((QEQCAR |rc| 1) (CONS 1 "failed"))
                     ('T
                      (CONS 0
                            (|INTALG;mkLog| |q|
                             (SPADCALL
                              (SPADCALL (* (QCAR (QCDR |rc|)) 3)
                                        (QREFELT $ 111))
                              (QREFELT $ 113))
                             (QCDR (QCDR |rc|)) |alpha| $)))))))) 

(SDEFUN |INTALG;UP2SUP| ((|p| (UP)) ($ (|SparseUnivariatePolynomial| F)))
        (SPADCALL (LIST #'|INTALG;UP2SUP!0|) |p| (QREFELT $ 167))) 

(SDEFUN |INTALG;UP2SUP!0| ((|x| NIL) ($$ NIL)) |x|) 

(SDEFUN |INTALG;SUP2UP| ((|p| (|SparseUnivariatePolynomial| F)) ($ (UP)))
        (SPADCALL (LIST #'|INTALG;SUP2UP!0|) |p| (QREFELT $ 169))) 

(SDEFUN |INTALG;SUP2UP!0| ((|x| NIL) ($$ NIL)) |x|) 

(SDEFUN |INTALG;varRoot?|
        ((|p| (UP)) (|derivation| (|Mapping| F F)) ($ (|Boolean|)))
        (SPROG ((#1=#:G1124 NIL) (#2=#:G1125 NIL) (#3=#:G1126 NIL) (|c| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ
                   (EXIT
                    (SEQ (LETT |c| NIL)
                         (LETT #3# (SPADCALL |p| (QREFELT $ 127))) G190
                         (COND
                          ((OR (ATOM #3#) (PROGN (LETT |c| (CAR #3#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL (SPADCALL |c| |derivation|)
                                       (|spadConstant| $ 41) (QREFELT $ 170))
                             (PROGN
                              (LETT #1# (PROGN (LETT #2# 'T) (GO #4=#:G1123)))
                              (GO #5=#:G1121))))))
                         (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL)))
                   #5# (EXIT #1#))
                  (EXIT NIL)))
                #4# (EXIT #2#)))) 

(SDEFUN |INTALG;pLogDeriv|
        ((|log|
          (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                    (|:| |coeff| (|SparseUnivariatePolynomial| R))
                    (|:| |logand| (|SparseUnivariatePolynomial| R))))
         (|derivation| (|Mapping| R R)) ($ (R)))
        (SPROG
         ((|ans| (R)) (|algans| #1=(|SparseUnivariatePolynomial| R))
          (#2=#:G1154 NIL) (|i| NIL)
          (|diflog|
           (|Union|
            (|Record| (|:| |coef1| #1#)
                      (|:| |coef2| (|SparseUnivariatePolynomial| R)))
            "failed"))
          (|numlog| (|SparseUnivariatePolynomial| R)) (|c| (R))
          (|n| (|NonNegativeInteger|)))
         (SEQ
          (COND
           ((SPADCALL (SPADCALL |derivation| (QVELT |log| 1) (QREFELT $ 172))
                      (|spadConstant| $ 173) (QREFELT $ 174))
            (|error| "can only handle logs with constant coefficients"))
           (#3='T
            (SEQ (LETT |n| (SPADCALL (QVELT |log| 1) (QREFELT $ 175)))
                 (EXIT
                  (COND
                   ((EQL |n| 1)
                    (SEQ
                     (LETT |c|
                           (SPADCALL
                            (SPADCALL
                             (SPADCALL
                              (SPADCALL (QVELT |log| 1) (QREFELT $ 176))
                              (QREFELT $ 177))
                             (SPADCALL (QVELT |log| 1) (QREFELT $ 177))
                             (QREFELT $ 178))
                            (QREFELT $ 179)))
                     (LETT |ans|
                           (SPADCALL (QVELT |log| 2) |c| (QREFELT $ 180)))
                     (EXIT
                      (SPADCALL
                       (SPADCALL
                        (SPADCALL (SPADCALL (QVELT |log| 0) (QREFELT $ 181))
                                  |c| (QREFELT $ 182))
                        (SPADCALL |ans| |derivation|) (QREFELT $ 182))
                       |ans| (QREFELT $ 178)))))
                   (#3#
                    (SEQ
                     (LETT |numlog|
                           (SPADCALL |derivation| (QVELT |log| 2)
                                     (QREFELT $ 172)))
                     (LETT |diflog|
                           (SPADCALL (QVELT |log| 2) (QVELT |log| 1) |numlog|
                                     (QREFELT $ 185)))
                     (EXIT
                      (COND
                       ((QEQCAR |diflog| 1) (|error| "this shouldn't happen"))
                       (#3#
                        (SEQ (LETT |algans| (QCAR (QCDR |diflog|)))
                             (LETT |ans| (|spadConstant| $ 11))
                             (SEQ (LETT |i| 0) (LETT #2# (- |n| 1)) G190
                                  (COND ((|greater_SI| |i| #2#) (GO G191)))
                                  (SEQ
                                   (LETT |algans|
                                         (SPADCALL
                                          (SPADCALL |algans|
                                                    (SPADCALL
                                                     (|spadConstant| $ 186) 1
                                                     (QREFELT $ 187))
                                                    (QREFELT $ 188))
                                          (QVELT |log| 1) (QREFELT $ 189)))
                                   (EXIT
                                    (LETT |ans|
                                          (SPADCALL |ans|
                                                    (SPADCALL |algans| |i|
                                                              (QREFELT $ 190))
                                                    (QREFELT $ 71)))))
                                  (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                  (EXIT NIL))
                             (EXIT
                              (SPADCALL
                               (SPADCALL (QVELT |log| 0) (QREFELT $ 181)) |ans|
                               (QREFELT $ 182))))))))))))))))) 

(SDEFUN |INTALG;R2UP|
        ((|f| (R)) (|k| (|Kernel| F)) ($ (|SparseUnivariatePolynomial| R)))
        (SPROG ((|g| (F)) (|y| (F)) (|x| (F)))
               (SEQ (LETT |x| (SPADCALL (QREFELT $ 17) (QREFELT $ 192)))
                    (LETT |g|
                          (SPADCALL
                           (SPADCALL (CONS #'|INTALG;R2UP!0| (VECTOR $ |x|))
                                     (SPADCALL |f| (QREFELT $ 138))
                                     (QREFELT $ 197))
                           (LETT |y| (SPADCALL (QREFELT $ 18) (QREFELT $ 192)))
                           (QREFELT $ 198)))
                    (EXIT
                     (SPADCALL
                      (CONS #'|INTALG;R2UP!1|
                            (VECTOR $ (QREFELT $ 18) (QREFELT $ 17)))
                      (SPADCALL |g| |k| (SPADCALL |k| (QREFELT $ 199))
                                (QREFELT $ 201))
                      (QREFELT $ 203)))))) 

(SDEFUN |INTALG;R2UP!1| ((|x1| NIL) ($$ NIL))
        (PROG (|dumx| |dumy| $)
          (LETT |dumx| (QREFELT $$ 2))
          (LETT |dumy| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|INTALG;rlift| |x1| |dumx| |dumy| $))))) 

(SDEFUN |INTALG;R2UP!0| ((|f1| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |f1| |x| (QREFELT $ 194)))))) 

(SDEFUN |INTALG;univ| ((|f| (F)) (|k| (|Kernel| F)) ($ (|Fraction| UP)))
        (SPROG ((|g| (|Fraction| (|SparseUnivariatePolynomial| F))))
               (SEQ (LETT |g| (SPADCALL |f| |k| (QREFELT $ 205)))
                    (EXIT
                     (SPADCALL
                      (|INTALG;SUP2UP| (SPADCALL |g| (QREFELT $ 207)) $)
                      (|INTALG;SUP2UP| (SPADCALL |g| (QREFELT $ 208)) $)
                      (QREFELT $ 46)))))) 

(SDEFUN |INTALG;rlift|
        ((|f| (F)) (|kx| (|Kernel| F)) (|ky| (|Kernel| F)) ($ (R)))
        (SPROG ((|uf| (|Fraction| (|SparseUnivariatePolynomial| F))))
               (SEQ (LETT |uf| (SPADCALL |f| |ky| (QREFELT $ 205)))
                    (EXIT
                     (SPADCALL
                      (SPADCALL (CONS #'|INTALG;rlift!0| (VECTOR $ |kx|))
                                (SPADCALL |uf| (QREFELT $ 209))
                                (QREFELT $ 212))
                      (QREFELT $ 213)))))) 

(SDEFUN |INTALG;rlift!0| ((|x1| NIL) ($$ NIL))
        (PROG (|kx| $)
          (LETT |kx| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|INTALG;univ| |x1| |kx| $))))) 

(SDEFUN |INTALG;trace1|
        ((|q| (UP)) (|la| (|List| F))
         (|ld| (|List| (|FiniteDivisor| F UP UPUP R)))
         (|v1| (|FiniteDivisor| F UP UPUP R)) (|alpha| (F)) (|b| (F))
         ($
          (|Union|
           (|List|
            (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                      (|:| |coeff| (|SparseUnivariatePolynomial| R))
                      (|:| |logand| (|SparseUnivariatePolynomial| R))))
           "failed")))
        (SPROG
         ((|rc|
           (|Union|
            (|Record| (|:| |order| (|NonNegativeInteger|)) (|:| |function| R))
            "failed"))
          (|v2| (|FiniteDivisor| F UP UPUP R))
          (|v0| #1=(|FiniteDivisor| F UP UPUP R)) (#2=#:G1169 NIL)
          (#3=#:G1168 #1#) (#4=#:G1170 #1#) (#5=#:G1180 NIL) (|a| NIL)
          (#6=#:G1181 NIL) (|dv| NIL)
          (|cd|
           (|Record| (|:| |num| (|List| (|Integer|))) (|:| |den| (|Integer|))))
          (#7=#:G1179 NIL) (#8=#:G1178 NIL))
         (SEQ
          (LETT |cd|
                (SPADCALL
                 (PROGN
                  (LETT #8# NIL)
                  (SEQ (LETT |a| NIL) (LETT #7# |la|) G190
                       (COND
                        ((OR (ATOM #7#) (PROGN (LETT |a| (CAR #7#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #8#
                               (CONS
                                (SPADCALL (SPADCALL |a| |b| (QREFELT $ 83))
                                          (QREFELT $ 214))
                                #8#))))
                       (LETT #7# (CDR #7#)) (GO G190) G191
                       (EXIT (NREVERSE #8#))))
                 (QREFELT $ 218)))
          (LETT |v0|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |dv| NIL) (LETT #6# |ld|) (LETT |a| NIL)
                      (LETT #5# (QCAR |cd|)) G190
                      (COND
                       ((OR (ATOM #5#) (PROGN (LETT |a| (CAR #5#)) NIL)
                            (ATOM #6#) (PROGN (LETT |dv| (CAR #6#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (PROGN
                         (LETT #4# (SPADCALL |a| |dv| (QREFELT $ 219)))
                         (COND
                          (#2# (LETT #3# (SPADCALL #3# #4# (QREFELT $ 164))))
                          ('T (PROGN (LETT #3# #4#) (LETT #2# 'T)))))))
                      (LETT #5# (PROG1 (CDR #5#) (LETT #6# (CDR #6#))))
                      (GO G190) G191 (EXIT NIL))
                 (COND (#2# #3#) (#9='T (|spadConstant| $ 220)))))
          (LETT |v2|
                (SPADCALL |v0| (SPADCALL (QCDR |cd|) |v1| (QREFELT $ 219))
                          (QREFELT $ 105)))
          (LETT |rc| (SPADCALL |v2| (QREFELT $ 109)))
          (EXIT
           (COND
            ((QEQCAR |rc| 1)
             (COND ((<= (SPADCALL |q| (QREFELT $ 75)) 2) (CONS 1 "failed"))
                   (#9#
                    (|error|
                     "Not integrable (provided residues have no relations)"))))
            (#9#
             (CONS 0
                   (|INTALG;mkLog| |q|
                    (SPADCALL
                     (SPADCALL (- (* (QCAR (QCDR |rc|)) (QCDR |cd|)))
                               (QREFELT $ 111))
                     (QREFELT $ 113))
                    (QCDR (QCDR |rc|)) |alpha| $)))))))) 

(SDEFUN |INTALG;mkLog|
        ((|q| (UP)) (|scalr| (|Fraction| (|Integer|))) (|lgd| (R))
         (|alpha| (F))
         ($
          (|List|
           (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                     (|:| |coeff| (|SparseUnivariatePolynomial| R))
                     (|:| |logand| (|SparseUnivariatePolynomial| R))))))
        (COND
         ((<= (SPADCALL |q| (QREFELT $ 75)) 1)
          (LIST
           (VECTOR |scalr|
                   (SPADCALL
                    (SPADCALL (|spadConstant| $ 186) 1 (QREFELT $ 187))
                    (|INTALG;F2UPR| |alpha| $) (QREFELT $ 221))
                   (SPADCALL |lgd| (QREFELT $ 20)))))
         ('T
          (LIST
           (VECTOR |scalr|
                   (SPADCALL (CONS (|function| |INTALG;F2R|) $) |q|
                             (QREFELT $ 223))
                   (|INTALG;R2UP| |lgd| (SPADCALL |alpha| (QREFELT $ 224))
                    $)))))) 

(SDEFUN |INTALG;pole_parts|
        ((|lc| (|List| (|Fraction| UP))) (|ii| (|Integer|)) ($ (|List| UP)))
        (SPROG
         ((#1=#:G1191 NIL) (|c| NIL) (#2=#:G1190 NIL)
          (|nn| (|NonNegativeInteger|)) (#3=#:G1185 NIL))
         (SEQ
          (LETT |nn|
                (PROG1 (LETT #3# (- |ii| 1))
                  (|check_subtype2| (>= #3# 0) '(|NonNegativeInteger|)
                                    '(|Integer|) #3#)))
          (EXIT
           (PROGN
            (LETT #2# NIL)
            (SEQ (LETT |c| NIL) (LETT #1# |lc|) G190
                 (COND
                  ((OR (ATOM #1#) (PROGN (LETT |c| (CAR #1#)) NIL)) (GO G191)))
                 (SEQ
                  (EXIT
                   (LETT #2#
                         (CONS
                          (SPADCALL
                           (SPADCALL
                            (SPADCALL (|spadConstant| $ 87) |nn|
                                      (QREFELT $ 96))
                            (SPADCALL |c| (QREFELT $ 131)) (QREFELT $ 225))
                           (SPADCALL |c| (QREFELT $ 136)) (QREFELT $ 226))
                          #2#))))
                 (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT (NREVERSE #2#)))))))) 

(SDEFUN |INTALG;get_e_coeffs|
        ((|f| (R)) (|e_forms| (|List| R)) (|der| (|Mapping| UP UP))
         ($ (|Union| (|List| F) "failed")))
        (SPROG
         ((#1=#:G1224 NIL) (#2=#:G1228 NIL) (|c| NIL) (|cl| (|List| F))
          (|pu| #3=(|Union| (|Vector| F) "failed"))
          (|sol|
           (|Record| (|:| |particular| #3#)
                     (|:| |basis| (|List| (|Vector| F)))))
          (|r_sys|
           (|Record| (|:| |mat| (|Matrix| F)) (|:| |vec| (|Vector| F))))
          (|e_mat| (|Matrix| UP)) (|ll| (|List| (|List| UP))) (#4=#:G1227 NIL)
          (|e_f| NIL) (#5=#:G1226 NIL) (|fv| (|Vector| UP)) (#6=#:G1223 NIL)
          (|inf_integral| (|Boolean|)) (#7=#:G1225 NIL) (|ii| (|Integer|))
          (|rf| (|Fraction| UP)) (|r| (UPUP)) (|p| (UPUP)) (|g| (R))
          (|dx| (UP)) (|f_c| (|List| (|Fraction| UP)))
          (|f_c0| (|Vector| (|Fraction| UP)))
          (|i_mat| (|Matrix| (|Fraction| UP))))
         (SEQ
          (EXIT
           (COND ((SPADCALL (LENGTH |e_forms|) 1 (QREFELT $ 227)) (CONS 0 NIL))
                 (#8='T
                  (SEQ (LETT |i_mat| (SPADCALL (QREFELT $ 229)))
                       (LETT |f_c0| (SPADCALL |f| (QREFELT $ 230)))
                       (LETT |f_c|
                             (SPADCALL
                              (SPADCALL |f_c0| |i_mat| (QREFELT $ 231))
                              (QREFELT $ 232)))
                       (LETT |inf_integral| 'T)
                       (LETT |dx|
                             (SPADCALL
                              (SPADCALL (|spadConstant| $ 87) 1 (QREFELT $ 96))
                              |der|))
                       (EXIT
                        (COND
                         ((SPADCALL |dx| (|spadConstant| $ 233) (QREFELT $ 78))
                          (CONS 0 NIL))
                         (#8#
                          (SEQ (LETT |g| (SPADCALL (QREFELT $ 234)))
                               (LETT |p| (SPADCALL (QREFELT $ 139)))
                               (LETT |ii| 2)
                               (COND
                                ((EQL (SPADCALL |p| (QREFELT $ 235)) 2)
                                 (COND
                                  ((EQL
                                    (SPADCALL
                                     (LETT |r| (SPADCALL |p| (QREFELT $ 236)))
                                     (QREFELT $ 235))
                                    0)
                                   (SEQ
                                    (LETT |rf| (SPADCALL |r| (QREFELT $ 237)))
                                    (EXIT
                                     (COND
                                      ((EQL
                                        (SPADCALL
                                         (SPADCALL |rf| (QREFELT $ 131))
                                         (QREFELT $ 75))
                                        3)
                                       (LETT |ii| 1)))))))))
                               (SEQ
                                (EXIT
                                 (SEQ (LETT |c| NIL) (LETT #7# |f_c|) G190
                                      (COND
                                       ((OR (ATOM #7#)
                                            (PROGN (LETT |c| (CAR #7#)) NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (COND
                                         ((<
                                           (-
                                            (SPADCALL
                                             (SPADCALL |c| (QREFELT $ 136))
                                             (QREFELT $ 75))
                                            (SPADCALL
                                             (SPADCALL |c| (QREFELT $ 131))
                                             (QREFELT $ 75)))
                                           |ii|)
                                          (SEQ (LETT |inf_integral| NIL)
                                               (EXIT
                                                (PROGN
                                                 (LETT #6# 1)
                                                 (GO #9=#:G1202))))))))
                                      (LETT #7# (CDR #7#)) (GO G190) G191
                                      (EXIT NIL)))
                                #9# (EXIT #6#))
                               (EXIT
                                (COND (|inf_integral| (CONS 0 NIL))
                                      ((NULL |e_forms|) (CONS 1 "failed"))
                                      (#8#
                                       (SEQ
                                        (LETT |fv|
                                              (SPADCALL
                                               (|INTALG;pole_parts| |f_c| |ii|
                                                $)
                                               (QREFELT $ 238)))
                                        (EXIT
                                         (COND
                                          ((SPADCALL |fv| (QREFELT $ 239))
                                           (CONS 0 NIL))
                                          (#8#
                                           (SEQ
                                            (LETT |ll|
                                                  (PROGN
                                                   (LETT #5# NIL)
                                                   (SEQ (LETT |e_f| NIL)
                                                        (LETT #4# |e_forms|)
                                                        G190
                                                        (COND
                                                         ((OR (ATOM #4#)
                                                              (PROGN
                                                               (LETT |e_f|
                                                                     (CAR #4#))
                                                               NIL))
                                                          (GO G191)))
                                                        (SEQ
                                                         (EXIT
                                                          (LETT #5#
                                                                (CONS
                                                                 (|INTALG;pole_parts|
                                                                  (SPADCALL
                                                                   (SPADCALL
                                                                    (SPADCALL
                                                                     |e_f|
                                                                     (QREFELT $
                                                                              230))
                                                                    |i_mat|
                                                                    (QREFELT $
                                                                             231))
                                                                   (QREFELT $
                                                                            232))
                                                                  |ii| $)
                                                                 #5#))))
                                                        (LETT #4# (CDR #4#))
                                                        (GO G190) G191
                                                        (EXIT
                                                         (NREVERSE #5#)))))
                                            (LETT |e_mat|
                                                  (SPADCALL |ll|
                                                            (QREFELT $ 242)))
                                            (LETT |r_sys|
                                                  (SPADCALL
                                                   (SPADCALL |e_mat|
                                                             (QREFELT $ 243))
                                                   |fv| (QREFELT $ 246)))
                                            (LETT |sol|
                                                  (SPADCALL (QCAR |r_sys|)
                                                            (QCDR |r_sys|)
                                                            (QREFELT $ 252)))
                                            (LETT |pu| (QCAR |sol|))
                                            (EXIT
                                             (COND
                                              ((QEQCAR |pu| 1)
                                               (CONS 1 "failed"))
                                              (#8#
                                               (SEQ
                                                (LETT |cl|
                                                      (SPADCALL (QCDR |pu|)
                                                                (QREFELT $
                                                                         253)))
                                                (SEQ (LETT |c| NIL)
                                                     (LETT #2# |cl|) G190
                                                     (COND
                                                      ((OR (ATOM #2#)
                                                           (PROGN
                                                            (LETT |c|
                                                                  (CAR #2#))
                                                            NIL))
                                                       (GO G191)))
                                                     (SEQ
                                                      (EXIT
                                                       (COND
                                                        ((SPADCALL
                                                          (SPADCALL
                                                           (SPADCALL |c|
                                                                     (QREFELT $
                                                                              21))
                                                           |der|)
                                                          (|spadConstant| $ 77)
                                                          (QREFELT $ 78))
                                                         (PROGN
                                                          (LETT #1#
                                                                (CONS 1
                                                                      "failed"))
                                                          (GO #10=#:G1222))))))
                                                     (LETT #2# (CDR #2#))
                                                     (GO G190) G191 (EXIT NIL))
                                                (EXIT
                                                 (CONS 0
                                                       |cl|))))))))))))))))))))))
          #10# (EXIT #1#)))) 

(SDEFUN |INTALG;gen_answer|
        ((|h| (|Record| (|:| |answer| R) (|:| |logpart| R)))
         (|u|
          (|List|
           (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                     (|:| |coeff| (|SparseUnivariatePolynomial| R))
                     (|:| |logand| (|SparseUnivariatePolynomial| R)))))
         (|el_f|
          (|Record| (|:| |result1| #1=(|Fraction| UP)) (|:| |result2| F)))
         ($
          (|Record| (|:| |result1| (|IntegrationResult| R))
                    (|:| |result2| F))))
        (SPROG ((|ans1| (R)) (|dn1| (UP)) (|nr1| (UP)) (|r1| #1#))
               (SEQ (LETT |r1| (QCAR |el_f|))
                    (LETT |ans1|
                          (COND
                           ((SPADCALL |r1| (|spadConstant| $ 42)
                                      (QREFELT $ 254))
                            (|spadConstant| $ 11))
                           ('T
                            (SEQ (LETT |nr1| (SPADCALL |r1| (QREFELT $ 131)))
                                 (LETT |dn1| (SPADCALL |r1| (QREFELT $ 136)))
                                 (EXIT
                                  (SPADCALL
                                   (SPADCALL (LIST (|spadConstant| $ 77) |nr1|)
                                             (QREFELT $ 238))
                                   |dn1| (QREFELT $ 255)))))))
                    (EXIT
                     (CONS
                      (SPADCALL (SPADCALL (QCAR |h|) |ans1| (QREFELT $ 71)) |u|
                                NIL (QREFELT $ 69))
                      (QCDR |el_f|)))))) 

(SDEFUN |INTALG;palgintegrate;RFMR;31|
        ((|f| (R)) (|x| (F)) (|derivation| (|Mapping| UP UP))
         ($
          (|Record| (|:| |result1| (|IntegrationResult| R))
                    (|:| |result2| F))))
        (SPROG
         ((|el_f|
           (|Union|
            (|Record| (|:| |result1| (|Fraction| UP)) (|:| |result2| F))
            "failed"))
          (|e_c| (F)) (|pol| (UP)) (|var| (F)) (|f_c| (R)) (|difFirstKind| (R))
          (#1=#:G1255 NIL) (#2=#:G1254 (R)) (#3=#:G1256 (R)) (#4=#:G1285 NIL)
          (|lg| NIL) (#5=#:G1277 NIL)
          (|u|
           (|Union|
            (|List|
             (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                       (|:| |coeff| (|SparseUnivariatePolynomial| R))
                       (|:| |logand| (|SparseUnivariatePolynomial| R))))
            "failed"))
          (|h_lp| (R)) (#6=#:G1283 NIL) (|c_i| NIL) (#7=#:G1284 NIL)
          (|e_f| NIL) (#8=#:G1282 NIL) (|e_coeffs| (|List| F))
          (|e_cu| (|Union| (|List| F) "failed")) (|f_forms| (|List| R))
          (#9=#:G1281 NIL) (|el| NIL) (#10=#:G1280 NIL) (|e_forms| (|List| R))
          (#11=#:G1279 NIL) (#12=#:G1278 NIL)
          (|ell_lst|
           (|List|
            (|Record| (|:| |f_form| R) (|:| |e_form| R) (|:| |f_var| F)
                      (|:| |f_pol| UP))))
          (|h| (|Record| (|:| |answer| R) (|:| |logpart| R))))
         (SEQ (LETT |h| (SPADCALL |f| |derivation| (QREFELT $ 56)))
              (EXIT
               (COND
                ((SPADCALL (QCDR |h|) (QREFELT $ 63))
                 (CONS (SPADCALL (QCAR |h|) (QREFELT $ 64))
                       (|spadConstant| $ 41)))
                (#13='T
                 (SEQ
                  (LETT |ell_lst| (SPADCALL |derivation| |x| (QREFELT $ 259)))
                  (LETT |e_forms|
                        (PROGN
                         (LETT #12# NIL)
                         (SEQ (LETT |el| NIL) (LETT #11# |ell_lst|) G190
                              (COND
                               ((OR (ATOM #11#)
                                    (PROGN (LETT |el| (CAR #11#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT (LETT #12# (CONS (QVELT |el| 1) #12#))))
                              (LETT #11# (CDR #11#)) (GO G190) G191
                              (EXIT (NREVERSE #12#)))))
                  (LETT |f_forms|
                        (PROGN
                         (LETT #10# NIL)
                         (SEQ (LETT |el| NIL) (LETT #9# |ell_lst|) G190
                              (COND
                               ((OR (ATOM #9#)
                                    (PROGN (LETT |el| (CAR #9#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT (LETT #10# (CONS (QVELT |el| 0) #10#))))
                              (LETT #9# (CDR #9#)) (GO G190) G191
                              (EXIT (NREVERSE #10#)))))
                  (LETT |e_cu|
                        (|INTALG;get_e_coeffs| (QCDR |h|) |e_forms|
                         |derivation| $))
                  (EXIT
                   (COND
                    ((QEQCAR |e_cu| 1)
                     (CONS
                      (SPADCALL (QCAR |h|) NIL
                                (LIST (CONS (QCDR |h|) (QREFELT $ 12)))
                                (QREFELT $ 69))
                      (|spadConstant| $ 41)))
                    (#13#
                     (SEQ (LETT |e_coeffs| (QCDR |e_cu|))
                          (EXIT
                           (COND
                            ((< 1 (LENGTH |e_coeffs|))
                             (CONS
                              (SPADCALL (QCAR |h|) NIL
                                        (LIST (CONS (QCDR |h|) (QREFELT $ 12)))
                                        (QREFELT $ 69))
                              (|spadConstant| $ 41)))
                            (#13#
                             (SEQ
                              (EXIT
                               (SEQ
                                (LETT |h_lp|
                                      (COND ((NULL |e_coeffs|) (QCDR |h|))
                                            (#13#
                                             (SPADCALL (QCDR |h|)
                                                       (SPADCALL (ELT $ 71)
                                                                 (PROGN
                                                                  (LETT #8#
                                                                        NIL)
                                                                  (SEQ
                                                                   (LETT |e_f|
                                                                         NIL)
                                                                   (LETT #7#
                                                                         |e_forms|)
                                                                   (LETT |c_i|
                                                                         NIL)
                                                                   (LETT #6#
                                                                         |e_coeffs|)
                                                                   G190
                                                                   (COND
                                                                    ((OR
                                                                      (ATOM
                                                                       #6#)
                                                                      (PROGN
                                                                       (LETT
                                                                        |c_i|
                                                                        (CAR
                                                                         #6#))
                                                                       NIL)
                                                                      (ATOM
                                                                       #7#)
                                                                      (PROGN
                                                                       (LETT
                                                                        |e_f|
                                                                        (CAR
                                                                         #7#))
                                                                       NIL))
                                                                     (GO
                                                                      G191)))
                                                                   (SEQ
                                                                    (EXIT
                                                                     (LETT #8#
                                                                           (CONS
                                                                            (SPADCALL
                                                                             (SPADCALL
                                                                              (SPADCALL
                                                                               |c_i|
                                                                               (QREFELT
                                                                                $
                                                                                21))
                                                                              (QREFELT
                                                                               $
                                                                               23))
                                                                             |e_f|
                                                                             (QREFELT
                                                                              $
                                                                              260))
                                                                            #8#))))
                                                                   (LETT #6#
                                                                         (PROG1
                                                                             (CDR
                                                                              #6#)
                                                                           (LETT
                                                                            #7#
                                                                            (CDR
                                                                             #7#))))
                                                                   (GO G190)
                                                                   G191
                                                                   (EXIT
                                                                    (NREVERSE
                                                                     #8#))))
                                                                 (QREFELT $
                                                                          263))
                                                       (QREFELT $ 264)))))
                                (COND
                                 ((SPADCALL |h_lp| (QREFELT $ 265))
                                  (SEQ
                                   (LETT |u|
                                         (|INTALG;palglogint| |h_lp|
                                          |derivation| $))
                                   (EXIT
                                    (COND
                                     ((QEQCAR |u| 1)
                                      (PROGN
                                       (LETT #5#
                                             (CONS
                                              (SPADCALL (QCAR |h|) NIL
                                                        (LIST
                                                         (CONS (QCDR |h|)
                                                               (QREFELT $ 12)))
                                                        (QREFELT $ 69))
                                              (|spadConstant| $ 41)))
                                       (GO #14=#:G1271)))))))
                                 (#13#
                                  (EXIT
                                   (CONS
                                    (SPADCALL (QCAR |h|) NIL
                                              (LIST
                                               (CONS (QCDR |h|)
                                                     (QREFELT $ 12)))
                                              (QREFELT $ 69))
                                    (|spadConstant| $ 41)))))
                                (LETT |difFirstKind|
                                      (SPADCALL |h_lp|
                                                (PROGN
                                                 (LETT #1# NIL)
                                                 (SEQ (LETT |lg| NIL)
                                                      (LETT #4# (QCDR |u|))
                                                      G190
                                                      (COND
                                                       ((OR (ATOM #4#)
                                                            (PROGN
                                                             (LETT |lg|
                                                                   (CAR #4#))
                                                             NIL))
                                                        (GO G191)))
                                                      (SEQ
                                                       (EXIT
                                                        (PROGN
                                                         (LETT #3#
                                                               (|INTALG;pLogDeriv|
                                                                |lg|
                                                                (CONS
                                                                 #'|INTALG;palgintegrate;RFMR;31!0|
                                                                 (VECTOR $
                                                                         |derivation|))
                                                                $))
                                                         (COND
                                                          (#1#
                                                           (LETT #2#
                                                                 (SPADCALL #2#
                                                                           #3#
                                                                           (QREFELT
                                                                            $
                                                                            71))))
                                                          ('T
                                                           (PROGN
                                                            (LETT #2# #3#)
                                                            (LETT #1# 'T)))))))
                                                      (LETT #4# (CDR #4#))
                                                      (GO G190) G191
                                                      (EXIT NIL))
                                                 (COND (#1# #2#)
                                                       (#13#
                                                        (|spadConstant| $
                                                                        11))))
                                                (QREFELT $ 264)))
                                (EXIT
                                 (COND
                                  ((SPADCALL |difFirstKind| (QREFELT $ 63))
                                   (COND
                                    ((NULL |e_coeffs|)
                                     (CONS
                                      (SPADCALL (QCAR |h|) (QCDR |u|) NIL
                                                (QREFELT $ 69))
                                      (|spadConstant| $ 41)))
                                    (#13#
                                     (SEQ
                                      (LETT |var|
                                            (QVELT
                                             (SPADCALL |ell_lst| 1
                                                       (QREFELT $ 267))
                                             2))
                                      (LETT |pol|
                                            (QVELT
                                             (SPADCALL |ell_lst| 1
                                                       (QREFELT $ 267))
                                             3))
                                      (LETT |el_f|
                                            (SPADCALL |var| |pol|
                                                      (|spadConstant| $ 11)
                                                      (SPADCALL
                                                       (SPADCALL
                                                        (SPADCALL
                                                         (|SPADfirst|
                                                          |e_coeffs|)
                                                         (QREFELT $ 21))
                                                        (QREFELT $ 23))
                                                       (QREFELT $ 24))
                                                      (QREFELT $ 270)))
                                      (EXIT
                                       (COND
                                        ((QEQCAR |el_f| 1)
                                         (CONS
                                          (SPADCALL (QCAR |h|) NIL
                                                    (LIST
                                                     (CONS (QCDR |h|)
                                                           (QREFELT $ 12)))
                                                    (QREFELT $ 69))
                                          (|spadConstant| $ 41)))
                                        (#13#
                                         (|INTALG;gen_answer| |h| (QCDR |u|)
                                          (QCDR |el_f|) $))))))))
                                  ((SPADCALL (LENGTH |f_forms|) 1
                                             (QREFELT $ 227))
                                   (CONS
                                    (SPADCALL (QCAR |h|) (QCDR |u|)
                                              (LIST
                                               (CONS |difFirstKind|
                                                     (QREFELT $ 12)))
                                              (QREFELT $ 69))
                                    (|spadConstant| $ 41)))
                                  (#13#
                                   (SEQ
                                    (LETT |f_c|
                                          (SPADCALL |difFirstKind|
                                                    (SPADCALL |f_forms| 1
                                                              (QREFELT $ 271))
                                                    (QREFELT $ 178)))
                                    (EXIT
                                     (COND
                                      ((SPADCALL
                                        (SPADCALL |f_c| (QREFELT $ 272))
                                        (|spadConstant| $ 11) (QREFELT $ 273))
                                       (COND
                                        ((NULL |e_coeffs|)
                                         (CONS
                                          (SPADCALL (QCAR |h|) (QCDR |u|)
                                                    (LIST
                                                     (CONS |difFirstKind|
                                                           (QREFELT $ 12)))
                                                    (QREFELT $ 69))
                                          (|spadConstant| $ 41)))
                                        (#13#
                                         (CONS
                                          (SPADCALL (QCAR |h|) NIL
                                                    (LIST
                                                     (CONS (QCDR |h|)
                                                           (QREFELT $ 12)))
                                                    (QREFELT $ 69))
                                          (|spadConstant| $ 41)))))
                                      (#13#
                                       (SEQ
                                        (LETT |var|
                                              (QVELT
                                               (SPADCALL |ell_lst| 1
                                                         (QREFELT $ 267))
                                               2))
                                        (LETT |pol|
                                              (QVELT
                                               (SPADCALL |ell_lst| 1
                                                         (QREFELT $ 267))
                                               3))
                                        (LETT |e_c|
                                              (COND
                                               ((NULL |e_coeffs|)
                                                (|spadConstant| $ 41))
                                               (#13#
                                                (|SPADfirst| |e_coeffs|))))
                                        (LETT |el_f|
                                              (SPADCALL |var| |pol| |f_c|
                                                        (SPADCALL
                                                         (SPADCALL
                                                          (SPADCALL |e_c|
                                                                    (QREFELT $
                                                                             21))
                                                          (QREFELT $ 23))
                                                         (QREFELT $ 24))
                                                        (QREFELT $ 270)))
                                        (EXIT
                                         (COND
                                          ((QEQCAR |el_f| 1)
                                           (COND
                                            ((NULL |e_coeffs|)
                                             (CONS
                                              (SPADCALL (QCAR |h|) (QCDR |u|)
                                                        (LIST
                                                         (CONS |difFirstKind|
                                                               (QREFELT $ 12)))
                                                        (QREFELT $ 69))
                                              (|spadConstant| $ 41)))
                                            (#13#
                                             (CONS
                                              (SPADCALL (QCAR |h|) NIL
                                                        (LIST
                                                         (CONS (QCDR |h|)
                                                               (QREFELT $ 12)))
                                                        (QREFELT $ 69))
                                              (|spadConstant| $ 41)))))
                                          (#13#
                                           (|INTALG;gen_answer| |h| (QCDR |u|)
                                            (QCDR |el_f|) $))))))))))))))
                              #14# (EXIT #5#)))))))))))))))) 

(SDEFUN |INTALG;palgintegrate;RFMR;31!0| ((|x1| NIL) ($$ NIL))
        (PROG (|derivation| $)
          (LETT |derivation| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x1| |derivation| (QREFELT $ 266)))))) 

(SDEFUN |INTALG;algintegrate;RMMIr;32|
        ((|f| (R)) (|derivation| (|Mapping| UP UP))
         (|rec_int| (|Mapping| (|IntegrationResult| F) F))
         ($ (|IntegrationResult| R)))
        (SPROG
         ((#1=#:G1299 NIL) (|xx| (|Union| UP "failed")) (|x'| (UP)) (|x| (UP)))
         (SEQ
          (LETT |x'|
                (SPADCALL
                 (LETT |x| (SPADCALL (|spadConstant| $ 87) 1 (QREFELT $ 96)))
                 |derivation|))
          (EXIT
           (COND
            ((ZEROP (SPADCALL |x'| (QREFELT $ 75)))
             (|INTALG;algintprim| |f| |derivation| |rec_int| $))
            ('T
             (SEQ
              (EXIT
               (SEQ
                (SEQ (LETT |xx| (SPADCALL |x'| |x| (QREFELT $ 277)))
                     (EXIT
                      (COND
                       ((QEQCAR |xx| 0)
                        (COND
                         ((QEQCAR (SPADCALL (QCDR |xx|) (QREFELT $ 35)) 0)
                          (PROGN
                           (LETT #1#
                                 (|INTALG;algintexp| |f| |derivation| |rec_int|
                                  $))
                           (GO #2=#:G1295))))))))
                (EXIT (|error| "should not happen"))))
              #2# (EXIT #1#)))))))) 

(SDEFUN |INTALG;try_logs|
        ((|f| (R)) (|derivation| (|Mapping| UP UP)) (|r| (UP))
         (|lp| (|List| UP))
         ($
          (|Union|
           (|List|
            (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                      (|:| |coeff| (|SparseUnivariatePolynomial| R))
                      (|:| |logand| (|SparseUnivariatePolynomial| R))))
           "failed")))
        (SPROG
         ((|llg|
           (|List|
            (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                      (|:| |coeff| (|SparseUnivariatePolynomial| R))
                      (|:| |logand| (|SparseUnivariatePolynomial| R)))))
          (|nlog|
           (|List|
            (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                      (|:| |coeff| (|SparseUnivariatePolynomial| R))
                      (|:| |logand| (|SparseUnivariatePolynomial| R)))))
          (#1=#:G1313 NIL) (|gu| (|Union| R "failed"))
          (|di| (|FiniteDivisor| F UP UPUP R)) (|alpha| (F)) (|p| (UP))
          (#2=#:G1314 NIL) (|fac| NIL)
          (|lf|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| UP)
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (|u| (|Factored| UP))
          (|u0| (|Factored| (|SparseUnivariatePolynomial| F)))
          (|rec|
           (|Record| (|:| |num| R) (|:| |den| UP) (|:| |derivden| UP)
                     (|:| |gd| UP))))
         (SEQ
          (EXIT
           (SEQ (LETT |rec| (SPADCALL |f| |derivation| (QREFELT $ 154)))
                (LETT |u0|
                      (SPADCALL (SPADCALL |r| (QREFELT $ 142)) NIL
                                (QREFELT $ 145)))
                (LETT |u|
                      (SPADCALL (CONS (|function| |INTALG;SUP2UP|) $) |u0|
                                (QREFELT $ 149)))
                (LETT |lf| (SPADCALL |u| (QREFELT $ 283))) (LETT |llg| NIL)
                (SEQ (LETT |fac| NIL) (LETT #2# |lf|) G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |fac| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ (LETT |p| (QVELT |fac| 1))
                          (LETT |alpha|
                                (SPADCALL (|INTALG;UP2SUP| |p| $)
                                          (QREFELT $ 100)))
                          (LETT |di|
                                (SPADCALL (QVELT |rec| 0) (QVELT |rec| 1)
                                          (QVELT |rec| 2) (QVELT |rec| 3)
                                          |alpha| (QREFELT $ 103)))
                          (LETT |gu|
                                (SPADCALL |di| (- (QVELT |fac| 2)) NIL
                                          (QREFELT $ 285)))
                          (EXIT
                           (COND
                            ((QEQCAR |gu| 1)
                             (PROGN
                              (LETT #1# (CONS 1 "failed"))
                              (GO #3=#:G1312)))
                            ('T
                             (SEQ
                              (LETT |nlog|
                                    (|INTALG;mkLog| |p| (|spadConstant| $ 73)
                                     (QCDR |gu|) |alpha| $))
                              (EXIT
                               (LETT |llg|
                                     (SPADCALL |nlog| |llg|
                                               (QREFELT $ 115)))))))))
                     (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                (EXIT (CONS 0 |llg|))))
          #3# (EXIT #1#)))) 

(SDEFUN |INTALG;alglogint|
        ((|f| (R)) (|derivation| (|Mapping| UP UP))
         ($
          (|Union|
           (|List|
            (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                      (|:| |coeff| (|SparseUnivariatePolynomial| R))
                      (|:| |logand| (|SparseUnivariatePolynomial| R))))
           "failed")))
        (SPROG
         ((|diff1| (R)) (#1=#:G1322 NIL) (#2=#:G1321 (R)) (#3=#:G1323 (R))
          (#4=#:G1330 NIL) (|lg| NIL)
          (|ll|
           (|List|
            (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                      (|:| |coeff| (|SparseUnivariatePolynomial| R))
                      (|:| |logand| (|SparseUnivariatePolynomial| R)))))
          (|lu|
           (|Union|
            (|List|
             (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                       (|:| |coeff| (|SparseUnivariatePolynomial| R))
                       (|:| |logand| (|SparseUnivariatePolynomial| R))))
            "failed"))
          (|lp| (|List| UP)) (|dxx| (UP)) (|xx| (UP)) (|r| (UP)))
         (SEQ
          (LETT |r|
                (SPADCALL (SPADCALL |f| |derivation| (QREFELT $ 156))
                          (QREFELT $ 140)))
          (EXIT
           (COND
            ((|INTALG;varRoot?| |r|
              (CONS #'|INTALG;alglogint!0| (VECTOR |derivation| $)) $)
             (CONS 1 "failed"))
            (#5='T
             (SEQ (LETT |xx| (SPADCALL (|spadConstant| $ 87) 1 (QREFELT $ 96)))
                  (LETT |dxx| (SPADCALL |xx| |derivation|))
                  (LETT |lp|
                        (SEQ
                         (COND
                          ((EQL (SPADCALL |dxx| (QREFELT $ 75)) 1)
                           (COND
                            ((SPADCALL (SPADCALL |dxx| (QREFELT $ 76))
                                       (|spadConstant| $ 77) (QREFELT $ 116))
                             (EXIT (LIST |xx|))))))
                         (EXIT NIL)))
                  (LETT |lu| (|INTALG;try_logs| |f| |derivation| |r| |lp| $))
                  (EXIT
                   (COND
                    ((QEQCAR |lu| 1)
                     (|error|
                      #6="integrate: implementation incomplete (constant residues)"))
                    (#5#
                     (SEQ (LETT |ll| (QCDR |lu|))
                          (LETT |diff1|
                                (SPADCALL |f|
                                          (PROGN
                                           (LETT #1# NIL)
                                           (SEQ (LETT |lg| NIL) (LETT #4# |ll|)
                                                G190
                                                (COND
                                                 ((OR (ATOM #4#)
                                                      (PROGN
                                                       (LETT |lg| (CAR #4#))
                                                       NIL))
                                                  (GO G191)))
                                                (SEQ
                                                 (EXIT
                                                  (PROGN
                                                   (LETT #3#
                                                         (|INTALG;pLogDeriv|
                                                          |lg|
                                                          (CONS
                                                           #'|INTALG;alglogint!1|
                                                           (VECTOR $
                                                                   |derivation|))
                                                          $))
                                                   (COND
                                                    (#1#
                                                     (LETT #2#
                                                           (SPADCALL #2# #3#
                                                                     (QREFELT $
                                                                              71))))
                                                    ('T
                                                     (PROGN
                                                      (LETT #2# #3#)
                                                      (LETT #1# 'T)))))))
                                                (LETT #4# (CDR #4#)) (GO G190)
                                                G191 (EXIT NIL))
                                           (COND (#1# #2#)
                                                 (#5# (|spadConstant| $ 11))))
                                          (QREFELT $ 264)))
                          (EXIT
                           (COND
                            ((SPADCALL |diff1| (QREFELT $ 63)) (CONS 0 |ll|))
                            (#5# (|error| #6#))))))))))))))) 

(SDEFUN |INTALG;alglogint!1| ((|x1| NIL) ($$ NIL))
        (PROG (|derivation| $)
          (LETT |derivation| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x1| |derivation| (QREFELT $ 266)))))) 

(SDEFUN |INTALG;alglogint!0| ((|x1| NIL) ($$ NIL))
        (PROG ($ |derivation|)
          (LETT $ (QREFELT $$ 1))
          (LETT |derivation| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL (SPADCALL |x1| (QREFELT $ 21)) |derivation|)
                      (QREFELT $ 286)))))) 

(DECLAIM (NOTINLINE |AlgebraicIntegrate;|)) 

(DEFUN |AlgebraicIntegrate| (&REST #1=#:G1331)
  (SPROG NIL
         (PROG (#2=#:G1332)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|AlgebraicIntegrate|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |AlgebraicIntegrate;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|AlgebraicIntegrate|)))))))))) 

(DEFUN |AlgebraicIntegrate;| (|#1| |#2| |#3| |#4| |#5|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$5 NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT DV$5 (|devaluate| |#5|))
    (LETT |dv$| (LIST '|AlgebraicIntegrate| DV$1 DV$2 DV$3 DV$4 DV$5))
    (LETT $ (GETREFV 287))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|AlgebraicIntegrate|
                (LIST DV$1 DV$2 DV$3 DV$4 DV$5) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (QSETREFV $ 10 |#5|)
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 12 (|spadConstant| $ 11))
    (QSETREFV $ 17 (SPADCALL (SPADCALL (QREFELT $ 14)) (QREFELT $ 16)))
    (QSETREFV $ 18 (SPADCALL (SPADCALL (QREFELT $ 14)) (QREFELT $ 16)))
    $))) 

(MAKEPROP '|AlgebraicIntegrate| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|) (0 . |Zero|)
              '|dummy| (|Symbol|) (4 . |new|) (|Kernel| 7) (8 . |kernel|)
              '|dumx| '|dumy| (|SparseUnivariatePolynomial| 10) (13 . |coerce|)
              (18 . |coerce|) (|Fraction| 8) (23 . |coerce|) (28 . |coerce|)
              (|IntegrationResult| 10) (|Mapping| 10 7) (|IntegrationResult| 7)
              (|IntegrationResultFunctions2| 7 10) (33 . |map|)
              (|Union| 22 '#1="failed") (39 . |retractIfCan|)
              (|Union| 8 '"failed") (44 . |retractIfCan|) (|Union| 7 '#1#)
              (49 . |retractIfCan|) (|Record| (|:| |num| 44) (|:| |den| 8))
              (54 . |integralCoordinates|) (|LaurentPolynomial| 7 8)
              (59 . |Zero|) (63 . |Zero|) (67 . |Zero|) (71 . |Zero|)
              (|Integer|) (|Vector| 8) (75 . |minIndex|) (80 . /)
              (|Record| (|:| |polyPart| $) (|:| |fracPart| 22))
              (86 . |separate|) (|Vector| $) (91 . |integralBasis|)
              (|Vector| 22) (95 . |represents|)
              (|Record| (|:| |answer| 10) (|:| |logpart| 10)) (|Mapping| 8 8)
              (|AlgebraicHermiteIntegration| 7 8 9 10)
              (101 . |HermiteIntegrate|) (107 . |convert|) (|Mapping| 22 38)
              (|Vector| 38) (|VectorFunctions2| 38 22) (112 . |map|)
              (|Boolean|) (118 . |zero?|) (123 . |coerce|)
              (|Record| (|:| |scalar| 72) (|:| |coeff| 19) (|:| |logand| 19))
              (|List| 65) (|Record| (|:| |integrand| 10) (|:| |intvar| 10))
              (|List| 67) (128 . |mkAnswer|) (135 . +) (141 . +)
              (|Fraction| 43) (147 . |One|) (|NonNegativeInteger|)
              (151 . |degree|) (156 . |reductum|) (161 . |Zero|) (165 . ~=)
              (171 . |leadingCoefficient|) (176 . ~=) (182 . |coefficient|)
              (188 . =) (194 . /) (|Union| 72 '#1#) (200 . |retractIfCan|)
              (205 . |One|) (209 . |One|) (213 . |numer|)
              (|Union| 43 '"failed") (|IntegerRoots| 43)
              (218 . |perfectNthRoot|) (224 . |denom|) (229 . /)
              (235 . |coerce|) (240 . ^) (246 . |monomial|) (252 . |elt|)
              (258 . *) (|SparseUnivariatePolynomial| $) (264 . |rootOf|)
              (269 . *) (|FiniteDivisor| 7 8 9 10) (275 . |divisor|) (284 . -)
              (289 . -) (|Record| (|:| |order| 74) (|:| |function| 10))
              (|Union| 106 '"failed") (|PointsOfFiniteOrder| 6 7 8 9 10)
              (295 . |torsionIfCan|) (300 . |coerce|) (305 . |coerce|)
              (310 . *) (316 . |inv|) (321 . *) (327 . |concat|) (333 . =)
              (339 . |Zero|) (343 . >) (349 . -) (354 . =)
              (|Record| (|:| |factor| 8) (|:| |exponent| 74) (|:| |coeff| 72))
              (|Union| 121 '"failed") (|Mapping| 62 121) (|List| 121)
              (360 . |find|) (|List| 7) (366 . |coefficients|) (371 . |concat|)
              (|List| 22) (377 . |coefficients|) (382 . |numer|) (|List| 8)
              (|Mapping| 8 22) (|ListFunctions2| 22 8) (387 . |map|)
              (393 . |denom|) (398 . |concat|) (404 . |lift|)
              (409 . |definingPolynomial|) (413 . |primitivePart|)
              (|SparseUnivariatePolynomial| 7) (418 . |makeSUP|)
              (|Factored| 141) (|ExpressionFactorPolynomial| 6 7)
              (423 . |factor|) (|Factored| 8) (|Mapping| 8 141)
              (|FactoredFunctions2| 141 8) (429 . |map|)
              (|Record| (|:| |factor| 8) (|:| |exponent| 74)) (|List| 150)
              (435 . |factors|)
              (|Record| (|:| |num| $) (|:| |den| 8) (|:| |derivden| 8)
                        (|:| |gd| 8))
              (440 . |algSplitSimple|) (|DoubleResultantPackage| 7 8 9 10)
              (446 . |doubleResultant|) (452 . |ground?|) (457 . |zero?|)
              (462 . |sqrt|) (467 . -) (|PositiveInteger|) (473 . ^) (479 . *)
              (485 . +) (|Mapping| 7 7)
              (|UnivariatePolynomialCategoryFunctions2| 7 8 7 141)
              (491 . |map|)
              (|UnivariatePolynomialCategoryFunctions2| 7 141 7 8)
              (497 . |map|) (503 . ~=) (|Mapping| 10 10) (509 . |map|)
              (515 . |Zero|) (519 . ~=) (525 . |degree|) (530 . |reductum|)
              (535 . |leadingCoefficient|) (540 . /) (546 . -) (551 . |elt|)
              (557 . |coerce|) (562 . *)
              (|Record| (|:| |coef1| $) (|:| |coef2| $))
              (|Union| 183 '"failed") (568 . |extendedEuclidean|) (575 . |One|)
              (579 . |monomial|) (585 . *) (591 . |rem|) (597 . |coefficient|)
              (|Kernel| $) (603 . |coerce|) (|Fraction| $) (608 . |elt|)
              (|Mapping| 7 22)
              (|UnivariatePolynomialCategoryFunctions2| 22 9 7 8) (614 . |map|)
              (620 . |elt|) (626 . |minPoly|)
              (|PolynomialCategoryQuotientFunctions| (|IndexedExponents| 15) 15
                                                     6
                                                     (|SparseMultivariatePolynomial|
                                                      6 15)
                                                     7)
              (631 . |univariate|)
              (|UnivariatePolynomialCategoryFunctions2| 7 141 10 19)
              (638 . |map|) (|Fraction| 99) (644 . |univariate|)
              (|Fraction| 141) (650 . |numer|) (655 . |denom|)
              (660 . |retract|) (|Mapping| 22 7)
              (|UnivariatePolynomialCategoryFunctions2| 7 141 22 9)
              (665 . |map|) (671 . |reduce|) (676 . |retract|)
              (|Record| (|:| |num| (|List| 43)) (|:| |den| 43)) (|List| 72)
              (|InnerCommonDenominator| 43 72 (|List| 43) 216)
              (681 . |splitDenominator|) (686 . *) (692 . |Zero|) (696 . -)
              (|UnivariatePolynomialCategoryFunctions2| 7 8 10 19)
              (702 . |map|) (708 . |retract|) (713 . *) (719 . |quo|)
              (725 . ~=) (|Matrix| 22)
              (731 . |inverseIntegralMatrixAtInfinity|) (735 . |coordinates|)
              (740 . *) (746 . |parts|) (751 . |One|) (755 . |generator|)
              (759 . |degree|) (764 . |reductum|) (769 . |retract|)
              (774 . |vector|) (779 . |zero?|) (|List| 132) (|Matrix| 8)
              (784 . |matrix|) (789 . |transpose|)
              (|Record| (|:| |mat| 249) (|:| |vec| 250)) (|Matrix| $)
              (794 . |reducedSystem|) (|Union| 250 '"failed")
              (|Record| (|:| |particular| 247) (|:| |basis| (|List| 250)))
              (|Matrix| 7) (|Vector| 7) (|LinearSystemMatrixPackage1| 7)
              (800 . |solve|) (806 . |parts|) (811 . =) (817 . |represents|)
              (|Record| (|:| |f_form| 10) (|:| |e_form| 10) (|:| |f_var| 7)
                        (|:| |f_pol| 8))
              (|List| 256) (|GenerateEllipticIntegrals| 7 8 9 10)
              (823 . |get_elliptics|) (829 . *) (|Mapping| 10 10 10)
              (|List| 10) (835 . |reduce|) (841 . -)
              (847 . |integralAtInfinity?|) (852 . |differentiate|)
              (858 . |elt|) (|Record| (|:| |result1| 22) (|:| |result2| 7))
              (|Union| 268 '"failed") (864 . |gen_ef|) (872 . |elt|)
              (878 . |differentiate|) (883 . ~=)
              (|Record| (|:| |result1| 25) (|:| |result2| 7))
              |INTALG;palgintegrate;RFMR;31| (|Union| $ '"failed")
              (889 . |exquo|) (|Mapping| 27 7) |INTALG;algintegrate;RMMIr;32|
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 280) (|:| |factor| 8) (|:| |exponent| 74))
              (|List| 281) (895 . |factorList|) (|Union| 10 '"failed")
              (900 . |generator|) (907 . |retract|))
           '#(|palgintegrate| 912 |algintegrate| 919) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|algintegrate|
                                 ((|IntegrationResult| |#5|) |#5|
                                  (|Mapping| |#3| |#3|)
                                  (|Mapping| (|IntegrationResult| |#2|) |#2|)))
                                T)
                              '((|palgintegrate|
                                 ((|Record|
                                   (|:| |result1| (|IntegrationResult| |#5|))
                                   (|:| |result2| |#2|))
                                  |#5| |#2| (|Mapping| |#3| |#3|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 286
                                            '(0 10 0 11 0 13 0 14 1 15 0 13 16
                                              1 19 0 10 20 1 8 0 7 21 1 22 0 8
                                              23 1 10 0 22 24 2 28 25 26 27 29
                                              1 10 30 0 31 1 22 32 0 33 1 8 34
                                              0 35 1 10 36 0 37 0 38 0 39 0 6 0
                                              40 0 7 0 41 0 22 0 42 1 44 43 0
                                              45 2 22 0 8 8 46 1 38 47 22 48 0
                                              10 49 50 2 10 0 51 49 52 2 55 53
                                              10 54 56 1 38 22 0 57 2 60 51 58
                                              59 61 1 10 62 0 63 1 25 0 10 64 3
                                              25 0 10 66 68 69 2 25 0 0 0 70 2
                                              10 0 0 0 71 0 72 0 73 1 8 74 0 75
                                              1 8 0 0 76 0 8 0 77 2 8 62 0 0 78
                                              1 8 7 0 79 2 74 62 0 0 80 2 8 7 0
                                              74 81 2 7 62 0 0 82 2 7 0 0 0 83
                                              1 7 84 0 85 0 6 0 86 0 7 0 87 1
                                              72 43 0 88 2 90 89 43 74 91 1 72
                                              43 0 92 2 72 0 43 43 93 1 7 0 72
                                              94 2 7 0 0 43 95 2 8 0 7 74 96 2
                                              8 0 0 0 97 2 8 0 7 0 98 1 7 0 99
                                              100 2 7 0 0 0 101 5 102 0 10 8 8
                                              8 7 103 1 7 0 0 104 2 102 0 0 0
                                              105 1 108 107 102 109 1 7 0 43
                                              110 1 72 0 43 111 2 72 0 43 0 112
                                              1 72 0 0 113 2 72 0 0 72 114 2 66
                                              0 0 0 115 2 8 62 0 0 116 0 72 0
                                              117 2 72 62 0 0 118 1 72 0 0 119
                                              2 72 62 0 0 120 2 124 122 123 0
                                              125 1 8 126 0 127 2 126 0 0 0 128
                                              1 9 129 0 130 1 22 8 0 131 2 134
                                              132 133 129 135 1 22 8 0 136 2
                                              132 0 0 0 137 1 10 9 0 138 0 10 9
                                              139 1 8 0 0 140 1 8 141 0 142 2
                                              144 143 141 126 145 2 148 146 147
                                              143 149 1 146 151 0 152 2 10 153
                                              0 54 154 2 155 8 10 54 156 1 8 62
                                              0 157 1 7 62 0 158 1 7 0 0 159 2
                                              7 0 0 0 160 2 7 0 0 161 162 2 102
                                              0 161 0 163 2 102 0 0 0 164 2 166
                                              141 165 8 167 2 168 8 165 141 169
                                              2 7 62 0 0 170 2 19 0 171 0 172 0
                                              19 0 173 2 19 62 0 0 174 1 19 74
                                              0 175 1 19 0 0 176 1 19 10 0 177
                                              2 10 0 0 0 178 1 10 0 0 179 2 19
                                              10 0 10 180 1 10 0 72 181 2 10 0
                                              0 0 182 3 19 184 0 0 0 185 0 10 0
                                              186 2 19 0 10 74 187 2 19 0 0 0
                                              188 2 19 0 0 0 189 2 19 10 0 74
                                              190 1 7 0 191 192 2 8 7 193 7 194
                                              2 196 8 195 9 197 2 8 7 0 7 198 1
                                              7 99 191 199 3 200 141 7 15 141
                                              201 2 202 19 26 141 203 2 7 204 0
                                              191 205 1 206 141 0 207 1 206 141
                                              0 208 1 206 141 0 209 2 211 9 210
                                              141 212 1 10 0 9 213 1 7 72 0 214
                                              1 217 215 216 218 2 102 0 43 0
                                              219 0 102 0 220 2 19 0 0 0 221 2
                                              222 19 26 8 223 1 7 191 0 224 2 8
                                              0 0 0 225 2 8 0 0 0 226 2 43 62 0
                                              0 227 0 10 228 229 1 10 51 0 230
                                              2 228 51 51 0 231 1 51 129 0 232
                                              0 8 0 233 0 10 0 234 1 9 74 0 235
                                              1 9 0 0 236 1 9 22 0 237 1 44 0
                                              132 238 1 44 62 0 239 1 241 0 240
                                              242 1 241 0 0 243 2 8 244 245 49
                                              246 2 251 248 249 250 252 1 250
                                              126 0 253 2 22 62 0 0 254 2 10 0
                                              44 8 255 2 258 257 54 7 259 2 10
                                              0 22 0 260 2 262 10 261 0 263 2
                                              10 0 0 0 264 1 10 62 0 265 2 10 0
                                              0 54 266 2 257 256 0 43 267 4 258
                                              269 7 8 10 10 270 2 262 10 0 43
                                              271 1 10 0 0 272 2 10 62 0 0 273
                                              2 8 276 0 0 277 1 146 282 0 283 3
                                              102 284 0 43 132 285 1 8 7 0 286
                                              3 0 274 10 7 54 275 3 0 25 10 54
                                              278 279)))))
           '|lookupComplete|)) 
