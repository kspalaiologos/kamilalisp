
(PUT '|ISUPS;makeTerm| '|SPADreplace| 'CONS) 

(SDEFUN |ISUPS;makeTerm|
        ((|exp| (|Integer|)) (|coef| (|Coef|))
         ($ (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
        (CONS |exp| |coef|)) 

(PUT '|ISUPS;getCoef| '|SPADreplace| 'QCDR) 

(SDEFUN |ISUPS;getCoef|
        ((|term| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))
         ($ (|Coef|)))
        (QCDR |term|)) 

(PUT '|ISUPS;getExpon| '|SPADreplace| 'QCAR) 

(SDEFUN |ISUPS;getExpon|
        ((|term| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))
         ($ (|Integer|)))
        (QCAR |term|)) 

(PUT '|ISUPS;makeSeries;RS$;4| '|SPADreplace| 'CONS) 

(SDEFUN |ISUPS;makeSeries;RS$;4|
        ((|refer| (|Reference| (|OrderedCompletion| (|Integer|))))
         (|x| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
         ($ ($)))
        (CONS |refer| |x|)) 

(PUT '|ISUPS;getRef;$R;5| '|SPADreplace| 'QCAR) 

(SDEFUN |ISUPS;getRef;$R;5|
        ((|ups| ($)) ($ (|Reference| (|OrderedCompletion| (|Integer|)))))
        (QCAR |ups|)) 

(PUT '|ISUPS;getStream;$S;6| '|SPADreplace| 'QCDR) 

(SDEFUN |ISUPS;getStream;$S;6|
        ((|ups| ($))
         ($ (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))))
        (QCDR |ups|)) 

(SDEFUN |ISUPS;monomial;CoefI$;7|
        ((|coef| (|Coef|)) (|expon| (|Integer|)) ($ ($)))
        (SPROG
         ((|st| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
          (|nix| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))))
         (SEQ (LETT |nix| (SPADCALL (QREFELT $ 14)))
              (LETT |st|
                    (COND ((SPADCALL |coef| (QREFELT $ 16)) |nix|)
                          ('T
                           (SPADCALL (|ISUPS;makeTerm| |expon| |coef| $) |nix|
                                     (QREFELT $ 17)))))
              (EXIT
               (SPADCALL (SPADCALL (SPADCALL (QREFELT $ 19)) (QREFELT $ 20))
                         |st| (QREFELT $ 11)))))) 

(SDEFUN |ISUPS;monomial?;$B;8| ((|ups| ($)) ($ (|Boolean|)))
        (COND ((SPADCALL (SPADCALL |ups| (QREFELT $ 13)) (QREFELT $ 23)) NIL)
              ('T
               (SPADCALL
                (SPADCALL (SPADCALL |ups| (QREFELT $ 13)) (QREFELT $ 24))
                (QREFELT $ 23))))) 

(SDEFUN |ISUPS;coerce;I$;9| ((|n| (|Integer|)) ($ ($)))
        (SPADCALL (SPADCALL |n| (QREFELT $ 26)) (QREFELT $ 27))) 

(SDEFUN |ISUPS;coerce;Coef$;10| ((|r| (|Coef|)) ($ ($)))
        (SPADCALL |r| 0 (QREFELT $ 22))) 

(SDEFUN |ISUPS;iSeries|
        ((|x| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
         (|refer| (|Reference| (|OrderedCompletion| (|Integer|))))
         ($ (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))))
        (SPROG NIL
               (SEQ
                (SPADCALL (CONS #'|ISUPS;iSeries!0| (VECTOR |refer| $ |x|))
                          (QREFELT $ 35))))) 

(SDEFUN |ISUPS;iSeries!0| (($$ NIL))
        (PROG (|x| $ |refer|)
          (LETT |x| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |refer| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SEQ
             (COND
              ((SPADCALL |x| (QREFELT $ 23))
               (SEQ (SPADCALL |refer| (SPADCALL (QREFELT $ 19)) (QREFELT $ 31))
                    (EXIT (SPADCALL (QREFELT $ 14)))))
              ('T
               (SEQ
                (SPADCALL |refer|
                          (SPADCALL
                           (|ISUPS;getExpon| (SPADCALL |x| (QREFELT $ 32)) $)
                           (QREFELT $ 33))
                          (QREFELT $ 31))
                (EXIT
                 (SPADCALL (SPADCALL |x| (QREFELT $ 32))
                           (|ISUPS;iSeries| (SPADCALL |x| (QREFELT $ 24))
                            |refer| $)
                           (QREFELT $ 17))))))))))) 

(SDEFUN |ISUPS;series;S$;12|
        ((|x| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
         ($ ($)))
        (SPROG
         ((|refer| (|Reference| (|OrderedCompletion| (|Integer|))))
          (|n| (|Integer|)))
         (SEQ
          (COND ((SPADCALL |x| (QREFELT $ 23)) (|spadConstant| $ 29))
                ('T
                 (SEQ
                  (LETT |n| (|ISUPS;getExpon| (SPADCALL |x| (QREFELT $ 32)) $))
                  (LETT |refer|
                        (SPADCALL (SPADCALL |n| (QREFELT $ 33))
                                  (QREFELT $ 20)))
                  (EXIT
                   (SPADCALL |refer| (|ISUPS;iSeries| |x| |refer| $)
                             (QREFELT $ 11))))))))) 

(SDEFUN |ISUPS;characteristic;Nni;13| (($ (|NonNegativeInteger|)))
        (SPADCALL (QREFELT $ 38))) 

(SDEFUN |ISUPS;Zero;$;14| (($ ($)))
        (SPADCALL (|spadConstant| $ 30) 0 (QREFELT $ 22))) 

(SDEFUN |ISUPS;One;$;15| (($ ($)))
        (SPADCALL (|spadConstant| $ 41) 0 (QREFELT $ 22))) 

(SDEFUN |ISUPS;iExtend|
        ((|st| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
         (|n| (|OrderedCompletion| (|Integer|)))
         (|refer| (|Reference| (|OrderedCompletion| (|Integer|))))
         ($ (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))))
        (SEQ
         (COND
          ((SPADCALL (SPADCALL |refer| (QREFELT $ 42)) |n| (QREFELT $ 43))
           (COND
            ((SPADCALL |st| (QREFELT $ 44))
             (SEQ (SPADCALL |refer| (SPADCALL (QREFELT $ 19)) (QREFELT $ 31))
                  (EXIT |st|)))
            ((SPADCALL |st| (QREFELT $ 45))
             (|ISUPS;iExtend| (SPADCALL |st| (QREFELT $ 24)) |n| |refer| $))
            (#1='T
             (|ISUPS;iExtend| (SPADCALL |st| (QREFELT $ 46)) |n| |refer| $))))
          (#1# |st|)))) 

(SDEFUN |ISUPS;extend;$I$;17| ((|x| ($)) (|n| (|Integer|)) ($ ($)))
        (SEQ
         (|ISUPS;iExtend| (SPADCALL |x| (QREFELT $ 13))
          (SPADCALL |n| (QREFELT $ 33)) (SPADCALL |x| (QREFELT $ 12)) $)
         (EXIT |x|))) 

(SDEFUN |ISUPS;complete;2$;18| ((|x| ($)) ($ ($)))
        (SEQ
         (|ISUPS;iExtend| (SPADCALL |x| (QREFELT $ 13))
          (SPADCALL (QREFELT $ 19)) (SPADCALL |x| (QREFELT $ 12)) $)
         (EXIT |x|))) 

(SDEFUN |ISUPS;iTruncate0|
        ((|x| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
         (|xRefer| (|Reference| (|OrderedCompletion| (|Integer|))))
         (|refer| (|Reference| (|OrderedCompletion| (|Integer|))))
         (|minExp| (|OrderedCompletion| (|Integer|))) (|maxExp| (|Integer|))
         (|n| (|Integer|))
         ($ (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))))
        (SPROG NIL
               (SEQ
                (SPADCALL
                 (CONS #'|ISUPS;iTruncate0!0|
                       (VECTOR |minExp| |maxExp| |xRefer| |n| |refer| $ |x|))
                 (QREFELT $ 35))))) 

(SDEFUN |ISUPS;iTruncate0!0| (($$ NIL))
        (PROG (|x| $ |refer| |n| |xRefer| |maxExp| |minExp|)
          (LETT |x| (QREFELT $$ 6))
          (LETT $ (QREFELT $$ 5))
          (LETT |refer| (QREFELT $$ 4))
          (LETT |n| (QREFELT $$ 3))
          (LETT |xRefer| (QREFELT $$ 2))
          (LETT |maxExp| (QREFELT $$ 1))
          (LETT |minExp| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|nn| NIL) (|xTerm| NIL) (|nx| NIL) (|degr| NIL))
                   (SEQ
                    (COND
                     ((SPADCALL |x| (QREFELT $ 44))
                      (SEQ
                       (SPADCALL |refer| (SPADCALL (QREFELT $ 19))
                                 (QREFELT $ 31))
                       (EXIT (SPADCALL (QREFELT $ 14)))))
                     ('T
                      (SEQ (LETT |nn| (SPADCALL |n| (QREFELT $ 33)))
                           (SEQ G190
                                (COND
                                 ((NULL
                                   (SPADCALL (SPADCALL |xRefer| (QREFELT $ 42))
                                             |nn| (QREFELT $ 43)))
                                  (GO G191)))
                                (SEQ (EXIT (SPADCALL |x| (QREFELT $ 46)))) NIL
                                (GO G190) G191 (EXIT NIL))
                           (EXIT
                            (COND
                             ((SPADCALL |x| (QREFELT $ 45))
                              (SEQ
                               (LETT |nx|
                                     (|ISUPS;getExpon|
                                      (LETT |xTerm|
                                            (SPADCALL |x| (QREFELT $ 32)))
                                      $))
                               (EXIT
                                (COND
                                 ((SPADCALL |nx| |maxExp| (QREFELT $ 49))
                                  (SEQ
                                   (SPADCALL |refer| (SPADCALL (QREFELT $ 19))
                                             (QREFELT $ 31))
                                   (EXIT (SPADCALL (QREFELT $ 14)))))
                                 ('T
                                  (SEQ
                                   (SPADCALL |refer|
                                             (SPADCALL |nx| (QREFELT $ 33))
                                             (QREFELT $ 31))
                                   (EXIT
                                    (COND
                                     ((SPADCALL (SPADCALL |nx| (QREFELT $ 33))
                                                |minExp| (QREFELT $ 50))
                                      (SPADCALL
                                       (|ISUPS;makeTerm| |nx|
                                        (|ISUPS;getCoef| |xTerm| $) $)
                                       (|ISUPS;iTruncate0|
                                        (SPADCALL |x| (QREFELT $ 24)) |xRefer|
                                        |refer| |minExp| |maxExp|
                                        (SPADCALL |nx| (|spadConstant| $ 51)
                                                  (QREFELT $ 52))
                                        $)
                                       (QREFELT $ 17)))
                                     ('T
                                      (|ISUPS;iTruncate0|
                                       (SPADCALL |x| (QREFELT $ 24)) |xRefer|
                                       |refer| |minExp| |maxExp|
                                       (SPADCALL |nx| (|spadConstant| $ 51)
                                                 (QREFELT $ 52))
                                       $))))))))))
                             ('T
                              (SEQ
                               (LETT |degr|
                                     (SPADCALL
                                      (SPADCALL |xRefer| (QREFELT $ 42))
                                      (QREFELT $ 53)))
                               (SPADCALL |refer|
                                         (SPADCALL |degr| (QREFELT $ 33))
                                         (QREFELT $ 31))
                               (EXIT
                                (|ISUPS;iTruncate0| |x| |xRefer| |refer|
                                 |minExp| |maxExp|
                                 (SPADCALL |degr| (|spadConstant| $ 51)
                                           (QREFELT $ 52))
                                 $))))))))))))))) 

(SDEFUN |ISUPS;iTruncate|
        ((|ups| ($)) (|minExp| (|OrderedCompletion| (|Integer|)))
         (|maxExp| (|Integer|)) ($ ($)))
        (SPROG
         ((|refer| (|Reference| (|OrderedCompletion| (|Integer|))))
          (|degr| (|Integer|)) (|deg| (|Integer|))
          (|xRefer| (|Reference| (|OrderedCompletion| (|Integer|))))
          (|x| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))))
         (SEQ (LETT |x| (SPADCALL |ups| (QREFELT $ 13)))
              (LETT |xRefer| (SPADCALL |ups| (QREFELT $ 12)))
              (EXIT
               (COND ((SPADCALL |x| (QREFELT $ 44)) (|spadConstant| $ 29))
                     ((SPADCALL |x| (QREFELT $ 45))
                      (SEQ
                       (LETT |deg|
                             (|ISUPS;getExpon| (SPADCALL |x| (QREFELT $ 32))
                              $))
                       (LETT |refer|
                             (SPADCALL (SPADCALL (- |deg| 1) (QREFELT $ 33))
                                       (QREFELT $ 20)))
                       (EXIT
                        (SPADCALL |refer|
                                  (|ISUPS;iTruncate0| |x| |xRefer| |refer|
                                   |minExp| |maxExp| |deg| $)
                                  (QREFELT $ 11)))))
                     ('T
                      (SEQ
                       (LETT |degr|
                             (SPADCALL (SPADCALL |xRefer| (QREFELT $ 42))
                                       (QREFELT $ 53)))
                       (LETT |refer|
                             (SPADCALL (SPADCALL |degr| (QREFELT $ 33))
                                       (QREFELT $ 20)))
                       (EXIT
                        (SPADCALL |refer|
                                  (|ISUPS;iTruncate0| |x| |xRefer| |refer|
                                   |minExp| |maxExp| (+ |degr| 1) $)
                                  (QREFELT $ 11)))))))))) 

(SDEFUN |ISUPS;truncate;$I$;21| ((|ups| ($)) (|n| (|Integer|)) ($ ($)))
        (|ISUPS;iTruncate| |ups| (SPADCALL (QREFELT $ 54)) |n| $)) 

(SDEFUN |ISUPS;truncate;$2I$;22|
        ((|ups| ($)) (|n1| #1=(|Integer|)) (|n2| #1#) ($ ($)))
        (SPROG ((|#G41| #1#) (|#G40| #1#))
               (SEQ
                (COND
                 ((> |n1| |n2|)
                  (PROGN
                   (LETT |#G40| |n2|)
                   (LETT |#G41| |n1|)
                   (LETT |n1| |#G40|)
                   (LETT |n2| |#G41|))))
                (EXIT
                 (|ISUPS;iTruncate| |ups| (SPADCALL |n1| (QREFELT $ 33)) |n2|
                  $))))) 

(SDEFUN |ISUPS;iCoefficient|
        ((|st| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
         (|n| (|Integer|)) ($ (|Coef|)))
        (SPROG
         ((|expon| (|Integer|))
          (|term| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
         (SEQ
          (COND
           ((SPADCALL |st| (QREFELT $ 45))
            (SEQ (LETT |term| (SPADCALL |st| (QREFELT $ 32)))
                 (LETT |expon| (|ISUPS;getExpon| |term| $))
                 (EXIT
                  (COND ((> |expon| |n|) (|spadConstant| $ 30))
                        ((EQL |expon| |n|) (|ISUPS;getCoef| |term| $))
                        (#1='T
                         (|ISUPS;iCoefficient| (SPADCALL |st| (QREFELT $ 24))
                          |n| $))))))
           (#1# (|spadConstant| $ 30)))))) 

(SDEFUN |ISUPS;coefficient;$ICoef;24|
        ((|x| ($)) (|n| (|Integer|)) ($ (|Coef|)))
        (SEQ (SPADCALL |x| |n| (QREFELT $ 47))
             (EXIT (|ISUPS;iCoefficient| (SPADCALL |x| (QREFELT $ 13)) |n| $)))) 

(SDEFUN |ISUPS;elt;$ICoef;25| ((|x| ($)) (|n| (|Integer|)) ($ (|Coef|)))
        (SPADCALL |x| |n| (QREFELT $ 57))) 

(SDEFUN |ISUPS;iOrder|
        ((|st| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
         (|n| (|OrderedCompletion| (|Integer|)))
         (|refer| (|Reference| (|OrderedCompletion| (|Integer|))))
         ($ (|Integer|)))
        (SPROG ((|degr| (|Integer|)) (|r| (|Integer|)))
               (SEQ
                (COND
                 ((SPADCALL |st| (QREFELT $ 44))
                  (COND
                   ((SPADCALL |n| (QREFELT $ 59))
                    (SPADCALL |n| (QREFELT $ 53)))
                   (#1='T (|error| "order: series has infinite order"))))
                 ((SPADCALL |st| (QREFELT $ 45))
                  (SEQ
                   (LETT |r|
                         (|ISUPS;getExpon| (SPADCALL |st| (QREFELT $ 32)) $))
                   (EXIT
                    (COND
                     ((SPADCALL (SPADCALL |r| (QREFELT $ 33)) |n|
                                (QREFELT $ 50))
                      (SPADCALL |n| (QREFELT $ 53)))
                     (#1# |r|)))))
                 (#1#
                  (SEQ
                   (LETT |degr|
                         (SPADCALL (SPADCALL |refer| (QREFELT $ 42))
                                   (QREFELT $ 53)))
                   (EXIT
                    (COND
                     ((SPADCALL (SPADCALL |degr| (QREFELT $ 33)) |n|
                                (QREFELT $ 50))
                      (SPADCALL |n| (QREFELT $ 53)))
                     (#1#
                      (|ISUPS;iOrder| (SPADCALL |st| (QREFELT $ 46)) |n|
                       |refer| $)))))))))) 

(SDEFUN |ISUPS;order;$I;27| ((|x| ($)) ($ (|Integer|)))
        (|ISUPS;iOrder| (SPADCALL |x| (QREFELT $ 13)) (SPADCALL (QREFELT $ 19))
         (SPADCALL |x| (QREFELT $ 12)) $)) 

(SDEFUN |ISUPS;order;$2I;28| ((|x| ($)) (|n| #1=(|Integer|)) ($ #1#))
        (|ISUPS;iOrder| (SPADCALL |x| (QREFELT $ 13))
         (SPADCALL |n| (QREFELT $ 33)) (SPADCALL |x| (QREFELT $ 12)) $)) 

(SDEFUN |ISUPS;terms;$S;29|
        ((|x| ($))
         ($ (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))))
        (SPADCALL |x| (QREFELT $ 13))) 

(SDEFUN |ISUPS;zero?;$B;30| ((|ups| ($)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G950 NIL) (#2=#:G951 NIL) (|i| NIL)
          (|count| (|NonNegativeInteger|))
          (|n| (|OrderedCompletion| (|Integer|)))
          (|ref| (|Reference| (|OrderedCompletion| (|Integer|))))
          (|x| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))))
         (SEQ
          (EXIT
           (SEQ (LETT |x| (SPADCALL |ups| (QREFELT $ 13)))
                (LETT |ref| (SPADCALL |ups| (QREFELT $ 12)))
                (EXIT
                 (COND
                  ((|eql_SI|
                    (SPADCALL (LETT |n| (SPADCALL |ref| (QREFELT $ 42)))
                              (QREFELT $ 64))
                    1)
                   (SPADCALL |x| (QREFELT $ 44)))
                  ('T
                   (SEQ (LETT |count| |$streamCount|)
                        (SEQ (LETT |i| 1) (LETT #2# |count|) G190
                             (COND ((|greater_SI| |i| #2#) (GO G191)))
                             (SEQ
                              (EXIT
                               (COND
                                ((SPADCALL |x| (QREFELT $ 44))
                                 (PROGN (LETT #1# 'T) (GO #3=#:G949)))
                                ((SPADCALL |x| (QREFELT $ 45))
                                 (PROGN (LETT #1# NIL) (GO #3#)))
                                ('T (SPADCALL |x| (QREFELT $ 46))))))
                             (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                             (EXIT NIL))
                        (EXIT NIL)))))))
          #3# (EXIT #1#)))) 

(SDEFUN |ISUPS;=;2$B;31| ((|ups1| ($)) (|ups2| ($)) ($ (|Boolean|)))
        (SPADCALL (SPADCALL |ups1| |ups2| (QREFELT $ 66)) (QREFELT $ 65))) 

(SDEFUN |ISUPS;iMap1|
        ((|cFcn| (|Mapping| |Coef| |Coef| (|Integer|)))
         (|eFcn| (|Mapping| (|Integer|) (|Integer|))) (|check?| (|Boolean|))
         (|x| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
         (|xRefer| (|Reference| (|OrderedCompletion| (|Integer|))))
         (|refer| (|Reference| (|OrderedCompletion| (|Integer|))))
         (|n| (|Integer|))
         ($ (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))))
        (SPROG NIL
               (SEQ
                (SPADCALL
                 (CONS #'|ISUPS;iMap1!0|
                       (VECTOR |check?| |eFcn| |cFcn| |xRefer| |n| |refer| $
                               |x|))
                 (QREFELT $ 35))))) 

(SDEFUN |ISUPS;iMap1!0| (($$ NIL))
        (PROG (|x| $ |refer| |n| |xRefer| |cFcn| |eFcn| |check?|)
          (LETT |x| (QREFELT $$ 7))
          (LETT $ (QREFELT $$ 6))
          (LETT |refer| (QREFELT $$ 5))
          (LETT |n| (QREFELT $$ 4))
          (LETT |xRefer| (QREFELT $$ 3))
          (LETT |cFcn| (QREFELT $$ 2))
          (LETT |eFcn| (QREFELT $$ 1))
          (LETT |check?| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG
             ((|nn| NIL) (|xTerm| NIL) (|xCoef| NIL) (|nx| NIL) (|newCoef| NIL)
              (|m| NIL) (|degr| NIL))
             (SEQ
              (COND
               ((SPADCALL |x| (QREFELT $ 44))
                (SEQ
                 (SPADCALL |refer| (SPADCALL (QREFELT $ 19)) (QREFELT $ 31))
                 (EXIT (SPADCALL (QREFELT $ 14)))))
               ('T
                (SEQ (LETT |nn| (SPADCALL |n| (QREFELT $ 33)))
                     (SEQ G190
                          (COND
                           ((NULL
                             (SPADCALL (SPADCALL |xRefer| (QREFELT $ 42)) |nn|
                                       (QREFELT $ 43)))
                            (GO G191)))
                          (SEQ (EXIT (SPADCALL |x| (QREFELT $ 46)))) NIL
                          (GO G190) G191 (EXIT NIL))
                     (EXIT
                      (COND
                       ((SPADCALL |x| (QREFELT $ 44))
                        (SEQ
                         (SPADCALL |refer| (SPADCALL (QREFELT $ 19))
                                   (QREFELT $ 31))
                         (EXIT (SPADCALL (QREFELT $ 14)))))
                       ((SPADCALL |x| (QREFELT $ 45))
                        (SEQ
                         (LETT |xCoef|
                               (|ISUPS;getCoef|
                                (LETT |xTerm| (SPADCALL |x| (QREFELT $ 32)))
                                $))
                         (LETT |nx| (|ISUPS;getExpon| |xTerm| $))
                         (LETT |newCoef| (SPADCALL |xCoef| |nx| |cFcn|))
                         (LETT |m| (SPADCALL |nx| |eFcn|))
                         (SPADCALL |refer| (SPADCALL |m| (QREFELT $ 33))
                                   (QREFELT $ 31))
                         (EXIT
                          (COND
                           (|check?|
                            (COND
                             ((SPADCALL |newCoef| (QREFELT $ 16))
                              (|ISUPS;iMap1| |cFcn| |eFcn| |check?|
                               (SPADCALL |x| (QREFELT $ 24)) |xRefer| |refer|
                               (SPADCALL |nx| (|spadConstant| $ 51)
                                         (QREFELT $ 52))
                               $))
                             ('T
                              (SPADCALL (|ISUPS;makeTerm| |m| |newCoef| $)
                                        (|ISUPS;iMap1| |cFcn| |eFcn| |check?|
                                         (SPADCALL |x| (QREFELT $ 24)) |xRefer|
                                         |refer|
                                         (SPADCALL |nx| (|spadConstant| $ 51)
                                                   (QREFELT $ 52))
                                         $)
                                        (QREFELT $ 17)))))
                           ('T
                            (SPADCALL (|ISUPS;makeTerm| |m| |newCoef| $)
                                      (|ISUPS;iMap1| |cFcn| |eFcn| |check?|
                                       (SPADCALL |x| (QREFELT $ 24)) |xRefer|
                                       |refer|
                                       (SPADCALL |nx| (|spadConstant| $ 51)
                                                 (QREFELT $ 52))
                                       $)
                                      (QREFELT $ 17)))))))
                       ('T
                        (SEQ
                         (LETT |degr|
                               (SPADCALL (SPADCALL |xRefer| (QREFELT $ 42))
                                         (QREFELT $ 53)))
                         (SPADCALL |refer|
                                   (SPADCALL (SPADCALL |degr| |eFcn|)
                                             (QREFELT $ 33))
                                   (QREFELT $ 31))
                         (EXIT
                          (|ISUPS;iMap1| |cFcn| |eFcn| |check?| |x| |xRefer|
                           |refer|
                           (SPADCALL |degr| (|spadConstant| $ 51)
                                     (QREFELT $ 52))
                           $))))))))))))))) 

(SDEFUN |ISUPS;iMap2|
        ((|cFcn| (|Mapping| |Coef| |Coef| (|Integer|)))
         (|eFcn| (|Mapping| (|Integer|) (|Integer|))) (|check?| (|Boolean|))
         (|ups| ($)) ($ ($)))
        (SPROG
         ((|refer| (|Reference| (|OrderedCompletion| (|Integer|))))
          (|degr| (|Integer|)) (|deg| (|Integer|))
          (|x| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
          (|xRefer| (|Reference| (|OrderedCompletion| (|Integer|)))))
         (SEQ (LETT |xRefer| (SPADCALL |ups| (QREFELT $ 12)))
              (LETT |x| (SPADCALL |ups| (QREFELT $ 13)))
              (EXIT
               (COND ((SPADCALL |x| (QREFELT $ 44)) (|spadConstant| $ 29))
                     ((SPADCALL |x| (QREFELT $ 45))
                      (SEQ
                       (LETT |deg|
                             (|ISUPS;getExpon| (SPADCALL |x| (QREFELT $ 32))
                              $))
                       (LETT |refer|
                             (SPADCALL
                              (SPADCALL (SPADCALL (- |deg| 1) |eFcn|)
                                        (QREFELT $ 33))
                              (QREFELT $ 20)))
                       (EXIT
                        (SPADCALL |refer|
                                  (|ISUPS;iMap1| |cFcn| |eFcn| |check?| |x|
                                   |xRefer| |refer| |deg| $)
                                  (QREFELT $ 11)))))
                     ('T
                      (SEQ
                       (LETT |degr|
                             (SPADCALL (SPADCALL |xRefer| (QREFELT $ 42))
                                       (QREFELT $ 53)))
                       (LETT |refer|
                             (SPADCALL
                              (SPADCALL (SPADCALL |degr| |eFcn|)
                                        (QREFELT $ 33))
                              (QREFELT $ 20)))
                       (EXIT
                        (SPADCALL |refer|
                                  (|ISUPS;iMap1| |cFcn| |eFcn| |check?| |x|
                                   |xRefer| |refer| (+ |degr| 1) $)
                                  (QREFELT $ 11)))))))))) 

(SDEFUN |ISUPS;map;M2$;34|
        ((|fcn| (|Mapping| |Coef| |Coef|)) (|x| ($)) ($ ($)))
        (|ISUPS;iMap2| (CONS #'|ISUPS;map;M2$;34!0| |fcn|)
         (LIST #'|ISUPS;map;M2$;34!1|) 'T |x| $)) 

(SDEFUN |ISUPS;map;M2$;34!1| ((|z| NIL) ($$ NIL)) |z|) 

(SDEFUN |ISUPS;map;M2$;34!0| ((|y| NIL) (|n| NIL) (|fcn| NIL))
        (SPADCALL |y| |fcn|)) 

(SDEFUN |ISUPS;differentiate;2$;35| ((|x| ($)) ($ ($)))
        (|ISUPS;iMap2| (CONS #'|ISUPS;differentiate;2$;35!0| $)
         (CONS #'|ISUPS;differentiate;2$;35!1| $) 'T |x| $)) 

(SDEFUN |ISUPS;differentiate;2$;35!1| ((|z| NIL) ($ NIL))
        (SPADCALL |z| (|spadConstant| $ 51) (QREFELT $ 71))) 

(SDEFUN |ISUPS;differentiate;2$;35!0| ((|y| NIL) (|n| NIL) ($ NIL))
        (SPADCALL |n| |y| (QREFELT $ 70))) 

(SDEFUN |ISUPS;multiplyCoefficients;M2$;36|
        ((|f| (|Mapping| |Coef| (|Integer|))) (|x| ($)) ($ ($)))
        (SPROG NIL
               (|ISUPS;iMap2|
                (CONS #'|ISUPS;multiplyCoefficients;M2$;36!0| (VECTOR $ |f|))
                (LIST #'|ISUPS;multiplyCoefficients;M2$;36!1|) 'T |x| $))) 

(SDEFUN |ISUPS;multiplyCoefficients;M2$;36!1| ((|z| NIL) ($$ NIL)) |z|) 

(SDEFUN |ISUPS;multiplyCoefficients;M2$;36!0| ((|y| NIL) (|n| NIL) ($$ NIL))
        (PROG (|f| $)
          (LETT |f| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL (SPADCALL |n| |f|) |y| (QREFELT $ 73)))))) 

(SDEFUN |ISUPS;multiplyExponents;$Pi$;37|
        ((|x| ($)) (|n| (|PositiveInteger|)) ($ ($)))
        (SPROG NIL
               (|ISUPS;iMap2| (LIST #'|ISUPS;multiplyExponents;$Pi$;37!0|)
                (CONS #'|ISUPS;multiplyExponents;$Pi$;37!1| (VECTOR $ |n|)) NIL
                |x| $))) 

(SDEFUN |ISUPS;multiplyExponents;$Pi$;37!1| ((|z| NIL) ($$ NIL))
        (PROG (|n| $)
          (LETT |n| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |n| |z| (QREFELT $ 77)))))) 

(SDEFUN |ISUPS;multiplyExponents;$Pi$;37!0| ((|y| NIL) (|m| NIL) ($$ NIL)) |y|) 

(SDEFUN |ISUPS;iPlus1|
        ((|op| (|Mapping| |Coef| |Coef| |Coef|))
         (|x| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
         (|xRefer| (|Reference| (|OrderedCompletion| (|Integer|))))
         (|y| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
         (|yRefer| (|Reference| (|OrderedCompletion| (|Integer|))))
         (|refer| (|Reference| (|OrderedCompletion| (|Integer|))))
         (|n| (|Integer|))
         ($ (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))))
        (SPROG NIL
               (SEQ
                (SPADCALL
                 (CONS #'|ISUPS;iPlus1!8|
                       (VECTOR |xRefer| |n| |refer| |yRefer| |y| |op| $ |x|))
                 (QREFELT $ 35))))) 

(SDEFUN |ISUPS;iPlus1!8| (($$ NIL))
        (PROG (|x| $ |op| |y| |yRefer| |refer| |n| |xRefer|)
          (LETT |x| (QREFELT $$ 7))
          (LETT $ (QREFELT $$ 6))
          (LETT |op| (QREFELT $$ 5))
          (LETT |y| (QREFELT $$ 4))
          (LETT |yRefer| (QREFELT $$ 3))
          (LETT |refer| (QREFELT $$ 2))
          (LETT |n| (QREFELT $$ 1))
          (LETT |xRefer| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG
             ((|nn| NIL) (|coef| NIL) (|xTerm| NIL) (|xCoef| NIL) (|nx| NIL)
              (|yTerm| NIL) (|yCoef| NIL) (|ny| NIL) (|degr| NIL)
              (|xyRef| NIL))
             (SEQ
              (COND
               ((SPADCALL |x| (QREFELT $ 44))
                (|ISUPS;iMap1| (CONS #'|ISUPS;iPlus1!0| (VECTOR |op| $))
                 (LIST #'|ISUPS;iPlus1!1|) NIL |y| |yRefer| |refer| |n| $))
               ((SPADCALL |y| (QREFELT $ 44))
                (|ISUPS;iMap1| (CONS #'|ISUPS;iPlus1!2| (VECTOR |op| $))
                 (LIST #'|ISUPS;iPlus1!3|) NIL |x| |xRefer| |refer| |n| $))
               ('T
                (SEQ (LETT |nn| (SPADCALL |n| (QREFELT $ 33)))
                     (SEQ G190
                          (COND
                           ((NULL
                             (SPADCALL (SPADCALL |xRefer| (QREFELT $ 42)) |nn|
                                       (QREFELT $ 43)))
                            (GO G191)))
                          (SEQ (EXIT (SPADCALL |x| (QREFELT $ 46)))) NIL
                          (GO G190) G191 (EXIT NIL))
                     (SEQ G190
                          (COND
                           ((NULL
                             (SPADCALL (SPADCALL |yRefer| (QREFELT $ 42)) |nn|
                                       (QREFELT $ 43)))
                            (GO G191)))
                          (SEQ (EXIT (SPADCALL |y| (QREFELT $ 46)))) NIL
                          (GO G190) G191 (EXIT NIL))
                     (EXIT
                      (COND
                       ((SPADCALL |x| (QREFELT $ 44))
                        (|ISUPS;iMap1|
                         (CONS #'|ISUPS;iPlus1!4| (VECTOR |op| $))
                         (LIST #'|ISUPS;iPlus1!5|) NIL |y| |yRefer| |refer| |n|
                         $))
                       ((SPADCALL |y| (QREFELT $ 44))
                        (|ISUPS;iMap1|
                         (CONS #'|ISUPS;iPlus1!6| (VECTOR |op| $))
                         (LIST #'|ISUPS;iPlus1!7|) NIL |x| |xRefer| |refer| |n|
                         $))
                       ('T
                        (SEQ
                         (COND
                          ((SPADCALL |x| (QREFELT $ 45))
                           (COND
                            ((SPADCALL |y| (QREFELT $ 45))
                             (EXIT
                              (SEQ
                               (LETT |xCoef|
                                     (|ISUPS;getCoef|
                                      (LETT |xTerm|
                                            (SPADCALL |x| (QREFELT $ 32)))
                                      $))
                               (LETT |nx| (|ISUPS;getExpon| |xTerm| $))
                               (LETT |yCoef|
                                     (|ISUPS;getCoef|
                                      (LETT |yTerm|
                                            (SPADCALL |y| (QREFELT $ 32)))
                                      $))
                               (LETT |ny| (|ISUPS;getExpon| |yTerm| $))
                               (EXIT
                                (COND
                                 ((SPADCALL |nx| |ny| (QREFELT $ 79))
                                  (SEQ
                                   (SPADCALL |refer|
                                             (SPADCALL |nx| (QREFELT $ 33))
                                             (QREFELT $ 31))
                                   (EXIT
                                    (COND
                                     ((SPADCALL
                                       (LETT |coef|
                                             (SPADCALL |xCoef| |yCoef| |op|))
                                       (QREFELT $ 16))
                                      (|ISUPS;iPlus1| |op|
                                       (SPADCALL |x| (QREFELT $ 24)) |xRefer|
                                       (SPADCALL |y| (QREFELT $ 24)) |yRefer|
                                       |refer|
                                       (SPADCALL |nx| (|spadConstant| $ 51)
                                                 (QREFELT $ 52))
                                       $))
                                     ('T
                                      (SPADCALL
                                       (|ISUPS;makeTerm| |nx| |coef| $)
                                       (|ISUPS;iPlus1| |op|
                                        (SPADCALL |x| (QREFELT $ 24)) |xRefer|
                                        (SPADCALL |y| (QREFELT $ 24)) |yRefer|
                                        |refer|
                                        (SPADCALL |nx| (|spadConstant| $ 51)
                                                  (QREFELT $ 52))
                                        $)
                                       (QREFELT $ 17)))))))
                                 ((SPADCALL |nx| |ny| (QREFELT $ 80))
                                  (SEQ
                                   (SPADCALL |refer|
                                             (SPADCALL |nx| (QREFELT $ 33))
                                             (QREFELT $ 31))
                                   (EXIT
                                    (SPADCALL
                                     (|ISUPS;makeTerm| |nx|
                                      (SPADCALL |xCoef| (|spadConstant| $ 30)
                                                |op|)
                                      $)
                                     (|ISUPS;iPlus1| |op|
                                      (SPADCALL |x| (QREFELT $ 24)) |xRefer|
                                      |y| |yRefer| |refer|
                                      (SPADCALL |nx| (|spadConstant| $ 51)
                                                (QREFELT $ 52))
                                      $)
                                     (QREFELT $ 17)))))
                                 ('T
                                  (SEQ
                                   (SPADCALL |refer|
                                             (SPADCALL |ny| (QREFELT $ 33))
                                             (QREFELT $ 31))
                                   (EXIT
                                    (SPADCALL
                                     (|ISUPS;makeTerm| |ny|
                                      (SPADCALL (|spadConstant| $ 30) |yCoef|
                                                |op|)
                                      $)
                                     (|ISUPS;iPlus1| |op| |x| |xRefer|
                                      (SPADCALL |y| (QREFELT $ 24)) |yRefer|
                                      |refer|
                                      (SPADCALL |ny| (|spadConstant| $ 51)
                                                (QREFELT $ 52))
                                      $)
                                     (QREFELT $ 17)))))))))))))
                         (EXIT
                          (COND
                           ((SPADCALL |x| (QREFELT $ 45))
                            (SEQ
                             (LETT |xCoef|
                                   (|ISUPS;getCoef|
                                    (LETT |xTerm|
                                          (SPADCALL |x| (QREFELT $ 32)))
                                    $))
                             (LETT |nx| (|ISUPS;getExpon| |xTerm| $))
                             (LETT |degr|
                                   (SPADCALL (SPADCALL |yRefer| (QREFELT $ 42))
                                             (QREFELT $ 53)))
                             (EXIT
                              (COND
                               ((SPADCALL |degr| |nx| (QREFELT $ 80))
                                (SEQ
                                 (SPADCALL |refer|
                                           (SPADCALL |yRefer| (QREFELT $ 42))
                                           (QREFELT $ 31))
                                 (EXIT
                                  (|ISUPS;iPlus1| |op| |x| |xRefer| |y|
                                   |yRefer| |refer|
                                   (SPADCALL |degr| (|spadConstant| $ 51)
                                             (QREFELT $ 52))
                                   $))))
                               ('T
                                (SEQ
                                 (SPADCALL |refer|
                                           (SPADCALL |nx| (QREFELT $ 33))
                                           (QREFELT $ 31))
                                 (EXIT
                                  (SPADCALL
                                   (|ISUPS;makeTerm| |nx|
                                    (SPADCALL |xCoef| (|spadConstant| $ 30)
                                              |op|)
                                    $)
                                   (|ISUPS;iPlus1| |op|
                                    (SPADCALL |x| (QREFELT $ 24)) |xRefer| |y|
                                    |yRefer| |refer|
                                    (SPADCALL |nx| (|spadConstant| $ 51)
                                              (QREFELT $ 52))
                                    $)
                                   (QREFELT $ 17)))))))))
                           ((SPADCALL |y| (QREFELT $ 45))
                            (SEQ
                             (LETT |yCoef|
                                   (|ISUPS;getCoef|
                                    (LETT |yTerm|
                                          (SPADCALL |y| (QREFELT $ 32)))
                                    $))
                             (LETT |ny| (|ISUPS;getExpon| |yTerm| $))
                             (LETT |degr|
                                   (SPADCALL (SPADCALL |xRefer| (QREFELT $ 42))
                                             (QREFELT $ 53)))
                             (EXIT
                              (COND
                               ((SPADCALL |degr| |ny| (QREFELT $ 80))
                                (SEQ
                                 (SPADCALL |refer|
                                           (SPADCALL |xRefer| (QREFELT $ 42))
                                           (QREFELT $ 31))
                                 (EXIT
                                  (|ISUPS;iPlus1| |op| |x| |xRefer| |y|
                                   |yRefer| |refer|
                                   (SPADCALL |degr| (|spadConstant| $ 51)
                                             (QREFELT $ 52))
                                   $))))
                               ('T
                                (SEQ
                                 (SPADCALL |refer|
                                           (SPADCALL |ny| (QREFELT $ 33))
                                           (QREFELT $ 31))
                                 (EXIT
                                  (SPADCALL
                                   (|ISUPS;makeTerm| |ny|
                                    (SPADCALL (|spadConstant| $ 30) |yCoef|
                                              |op|)
                                    $)
                                   (|ISUPS;iPlus1| |op| |x| |xRefer|
                                    (SPADCALL |y| (QREFELT $ 24)) |yRefer|
                                    |refer|
                                    (SPADCALL |ny| (|spadConstant| $ 51)
                                              (QREFELT $ 52))
                                    $)
                                   (QREFELT $ 17)))))))))
                           ('T
                            (SEQ
                             (SPADCALL |refer|
                                       (LETT |xyRef|
                                             (SPADCALL
                                              (SPADCALL |xRefer|
                                                        (QREFELT $ 42))
                                              (SPADCALL |yRefer|
                                                        (QREFELT $ 42))
                                              (QREFELT $ 81)))
                                       (QREFELT $ 31))
                             (EXIT
                              (|ISUPS;iPlus1| |op| |x| |xRefer| |y| |yRefer|
                               |refer|
                               (SPADCALL (SPADCALL |xyRef| (QREFELT $ 53))
                                         (|spadConstant| $ 51) (QREFELT $ 52))
                               $))))))))))))))))))) 

(SDEFUN |ISUPS;iPlus1!7| ((|z| NIL) ($$ NIL)) |z|) 

(SDEFUN |ISUPS;iPlus1!6| ((|x1| NIL) (|m| NIL) ($$ NIL))
        (PROG ($ |op|)
          (LETT $ (QREFELT $$ 1))
          (LETT |op| (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x1| (|spadConstant| $ 30) |op|))))) 

(SDEFUN |ISUPS;iPlus1!5| ((|z| NIL) ($$ NIL)) |z|) 

(SDEFUN |ISUPS;iPlus1!4| ((|x1| NIL) (|m| NIL) ($$ NIL))
        (PROG ($ |op|)
          (LETT $ (QREFELT $$ 1))
          (LETT |op| (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL (|spadConstant| $ 30) |x1| |op|))))) 

(SDEFUN |ISUPS;iPlus1!3| ((|z| NIL) ($$ NIL)) |z|) 

(SDEFUN |ISUPS;iPlus1!2| ((|x1| NIL) (|m| NIL) ($$ NIL))
        (PROG ($ |op|)
          (LETT $ (QREFELT $$ 1))
          (LETT |op| (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x1| (|spadConstant| $ 30) |op|))))) 

(SDEFUN |ISUPS;iPlus1!1| ((|z| NIL) ($$ NIL)) |z|) 

(SDEFUN |ISUPS;iPlus1!0| ((|x1| NIL) (|m| NIL) ($$ NIL))
        (PROG ($ |op|)
          (LETT $ (QREFELT $$ 1))
          (LETT |op| (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL (|spadConstant| $ 30) |x1| |op|))))) 

(SDEFUN |ISUPS;iPlus2|
        ((|op| (|Mapping| |Coef| |Coef| |Coef|)) (|ups1| ($)) (|ups2| ($))
         ($ ($)))
        (SPROG
         ((|refer| (|Reference| (|OrderedCompletion| (|Integer|))))
          (|deg| (|Integer|)) (|yDeg| #1=(|Integer|)) (#2=#:G1212 NIL)
          (|y| #3=(|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
          (|yRefer| #4=(|Reference| (|OrderedCompletion| (|Integer|))))
          (|xDeg| #1#) (|x| #3#) (|xRefer| #4#))
         (SEQ
          (EXIT
           (SEQ (LETT |xRefer| (SPADCALL |ups1| (QREFELT $ 12)))
                (LETT |x| (SPADCALL |ups1| (QREFELT $ 13)))
                (LETT |xDeg|
                      (COND
                       ((SPADCALL |x| (QREFELT $ 44))
                        (PROGN
                         (LETT #2#
                               (SPADCALL
                                (CONS #'|ISUPS;iPlus2!0| (VECTOR |op| $))
                                |ups2| (QREFELT $ 69)))
                         (GO #5=#:G1211)))
                       ((SPADCALL |x| (QREFELT $ 45))
                        (- (|ISUPS;getExpon| (SPADCALL |x| (QREFELT $ 32)) $)
                           1))
                       (#6='T
                        (SPADCALL (SPADCALL |xRefer| (QREFELT $ 42))
                                  (QREFELT $ 53)))))
                (LETT |yRefer| (SPADCALL |ups2| (QREFELT $ 12)))
                (LETT |y| (SPADCALL |ups2| (QREFELT $ 13)))
                (LETT |yDeg|
                      (COND
                       ((SPADCALL |y| (QREFELT $ 44))
                        (PROGN
                         (LETT #2#
                               (SPADCALL
                                (CONS #'|ISUPS;iPlus2!1| (VECTOR |op| $))
                                |ups1| (QREFELT $ 69)))
                         (GO #5#)))
                       ((SPADCALL |y| (QREFELT $ 45))
                        (- (|ISUPS;getExpon| (SPADCALL |y| (QREFELT $ 32)) $)
                           1))
                       (#6#
                        (SPADCALL (SPADCALL |yRefer| (QREFELT $ 42))
                                  (QREFELT $ 53)))))
                (LETT |deg| (MIN |xDeg| |yDeg|))
                (LETT |refer|
                      (SPADCALL (SPADCALL |deg| (QREFELT $ 33))
                                (QREFELT $ 20)))
                (EXIT
                 (SPADCALL |refer|
                           (|ISUPS;iPlus1| |op| |x| |xRefer| |y| |yRefer|
                            |refer| (+ |deg| 1) $)
                           (QREFELT $ 11)))))
          #5# (EXIT #2#)))) 

(SDEFUN |ISUPS;iPlus2!1| ((|z| NIL) ($$ NIL))
        (PROG ($ |op|)
          (LETT $ (QREFELT $$ 1))
          (LETT |op| (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |z| (|spadConstant| $ 30) |op|))))) 

(SDEFUN |ISUPS;iPlus2!0| ((|z| NIL) ($$ NIL))
        (PROG ($ |op|)
          (LETT $ (QREFELT $$ 1))
          (LETT |op| (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL (|spadConstant| $ 30) |z| |op|))))) 

(SDEFUN |ISUPS;+;3$;40| ((|x| ($)) (|y| ($)) ($ ($)))
        (|ISUPS;iPlus2| (ELT $ 82) |x| |y| $)) 

(SDEFUN |ISUPS;-;3$;41| ((|x| ($)) (|y| ($)) ($ ($)))
        (|ISUPS;iPlus2| (ELT $ 84) |x| |y| $)) 

(SDEFUN |ISUPS;-;2$;42| ((|y| ($)) ($ ($)))
        (|ISUPS;iMap2| (CONS #'|ISUPS;-;2$;42!0| $) (LIST #'|ISUPS;-;2$;42!1|)
         NIL |y| $)) 

(SDEFUN |ISUPS;-;2$;42!1| ((|z| NIL) ($$ NIL)) |z|) 

(SDEFUN |ISUPS;-;2$;42!0| ((|x| NIL) (|n| NIL) ($ NIL))
        (SPADCALL |x| (QREFELT $ 85))) 

(SDEFUN |ISUPS;*;I2$;43| ((|n| (|Integer|)) (|x| ($)) ($ ($)))
        (SPROG NIL
               (COND ((ZEROP |n|) (|spadConstant| $ 29))
                     ('T
                      (SPADCALL (CONS #'|ISUPS;*;I2$;43!0| (VECTOR $ |n|)) |x|
                                (QREFELT $ 69)))))) 

(SDEFUN |ISUPS;*;I2$;43!0| ((|z| NIL) ($$ NIL))
        (PROG (|n| $)
          (LETT |n| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |n| |z| (QREFELT $ 70)))))) 

(SDEFUN |ISUPS;*;Nni2$;44| ((|n| (|NonNegativeInteger|)) (|x| ($)) ($ ($)))
        (SPROG NIL
               (COND ((ZEROP |n|) (|spadConstant| $ 29))
                     ('T
                      (SPADCALL (CONS #'|ISUPS;*;Nni2$;44!0| (VECTOR $ |n|))
                                |x| (QREFELT $ 69)))))) 

(SDEFUN |ISUPS;*;Nni2$;44!0| ((|z| NIL) ($$ NIL))
        (PROG (|n| $)
          (LETT |n| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |n| |z| (QREFELT $ 88)))))) 

(SDEFUN |ISUPS;*;Pi2$;45| ((|n| (|PositiveInteger|)) (|x| ($)) ($ ($)))
        (SPROG NIL
               (COND ((ZEROP |n|) (|spadConstant| $ 29))
                     ('T
                      (SPADCALL (CONS #'|ISUPS;*;Pi2$;45!0| (VECTOR $ |n|)) |x|
                                (QREFELT $ 69)))))) 

(SDEFUN |ISUPS;*;Pi2$;45!0| ((|z| NIL) ($$ NIL))
        (PROG (|n| $)
          (LETT |n| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |n| |z| (QREFELT $ 90)))))) 

(SDEFUN |ISUPS;productByTerm|
        ((|coef| (|Coef|)) (|expon| (|Integer|))
         (|x| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
         (|xRefer| (|Reference| (|OrderedCompletion| (|Integer|))))
         (|refer| (|Reference| (|OrderedCompletion| (|Integer|))))
         (|n| (|Integer|))
         ($ (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))))
        (SPROG NIL
               (|ISUPS;iMap1|
                (CONS #'|ISUPS;productByTerm!0| (VECTOR $ |coef|))
                (CONS #'|ISUPS;productByTerm!1| (VECTOR $ |expon|)) 'T |x|
                |xRefer| |refer| |n| $))) 

(SDEFUN |ISUPS;productByTerm!1| ((|z| NIL) ($$ NIL))
        (PROG (|expon| $)
          (LETT |expon| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |z| |expon| (QREFELT $ 52)))))) 

(SDEFUN |ISUPS;productByTerm!0| ((|y| NIL) (|m| NIL) ($$ NIL))
        (PROG (|coef| $)
          (LETT |coef| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |coef| |y| (QREFELT $ 73)))))) 

(SDEFUN |ISUPS;productLazyEval|
        ((|x| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
         (|xRefer| (|Reference| (|OrderedCompletion| (|Integer|))))
         (|y| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
         (|yRefer| (|Reference| (|OrderedCompletion| (|Integer|))))
         (|nn| (|OrderedCompletion| (|Integer|))) ($ (|Void|)))
        (SPROG
         ((|yDeg| (|OrderedCompletion| (|Integer|)))
          (|xDeg| (|OrderedCompletion| (|Integer|))))
         (SEQ
          (COND
           ((OR (SPADCALL |x| (QREFELT $ 44)) (SPADCALL |y| (QREFELT $ 44)))
            (SPADCALL (QREFELT $ 93)))
           ('T
            (COND
             ((SPADCALL |x| (QREFELT $ 45))
              (COND ((SPADCALL |y| (QREFELT $ 45)) (SPADCALL (QREFELT $ 93)))
                    (#1='T
                     (SEQ
                      (LETT |xDeg|
                            (SPADCALL
                             (|ISUPS;getExpon| (SPADCALL |x| (QREFELT $ 32)) $)
                             (QREFELT $ 33)))
                      (SEQ G190
                           (COND
                            ((NULL
                              (SPADCALL
                               (SPADCALL |xDeg|
                                         (SPADCALL |yRefer| (QREFELT $ 42))
                                         (QREFELT $ 94))
                               |nn| (QREFELT $ 43)))
                             (GO G191)))
                           (SEQ (EXIT (SPADCALL |y| (QREFELT $ 46)))) NIL
                           (GO G190) G191 (EXIT NIL))
                      (EXIT (SPADCALL (QREFELT $ 93)))))))
             ((SPADCALL |y| (QREFELT $ 45))
              (SEQ
               (LETT |yDeg|
                     (SPADCALL
                      (|ISUPS;getExpon| (SPADCALL |y| (QREFELT $ 32)) $)
                      (QREFELT $ 33)))
               (SEQ G190
                    (COND
                     ((NULL
                       (SPADCALL
                        (SPADCALL |yDeg| (SPADCALL |xRefer| (QREFELT $ 42))
                                  (QREFELT $ 94))
                        |nn| (QREFELT $ 43)))
                      (GO G191)))
                    (SEQ (EXIT (SPADCALL |x| (QREFELT $ 46)))) NIL (GO G190)
                    G191 (EXIT NIL))
               (EXIT (SPADCALL (QREFELT $ 93)))))
             (#1#
              (SEQ (SPADCALL |x| (QREFELT $ 46))
                   (COND
                    ((SPADCALL |y| (QREFELT $ 95))
                     (SPADCALL |y| (QREFELT $ 46))))
                   (EXIT
                    (|ISUPS;productLazyEval| |x| |xRefer| |y| |yRefer| |nn|
                     $)))))))))) 

(SDEFUN |ISUPS;iTimes|
        ((|x| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
         (|xRefer| (|Reference| (|OrderedCompletion| (|Integer|))))
         (|y| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
         (|yRefer| (|Reference| (|OrderedCompletion| (|Integer|))))
         (|refer| (|Reference| (|OrderedCompletion| (|Integer|))))
         (|n| (|Integer|))
         ($ (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))))
        (SPROG NIL
               (SEQ
                (SPADCALL
                 (CONS #'|ISUPS;iTimes!0|
                       (VECTOR |refer| $ |n| |yRefer| |y| |xRefer| |x|))
                 (QREFELT $ 35))))) 

(SDEFUN |ISUPS;iTimes!0| (($$ NIL))
        (PROG (|x| |xRefer| |y| |yRefer| |n| $ |refer|)
          (LETT |x| (QREFELT $$ 6))
          (LETT |xRefer| (QREFELT $$ 5))
          (LETT |y| (QREFELT $$ 4))
          (LETT |yRefer| (QREFELT $$ 3))
          (LETT |n| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |refer| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG
             ((|xTerm| NIL) (|xCoef| NIL) (|yTerm| NIL) (|yCoef| NIL)
              (|expon| NIL) (|scRefer| NIL) (|scMult| NIL) (|prRefer| NIL)
              (|pr| NIL) (|sm| NIL) (|coef| NIL) (|xExpon| NIL) (|yExpon| NIL)
              (|degr| NIL) (|xDegr| NIL) (|yDegr| NIL))
             (SEQ
              (|ISUPS;productLazyEval| |x| |xRefer| |y| |yRefer|
               (SPADCALL |n| (QREFELT $ 33)) $)
              (COND
               ((OR (SPADCALL |x| (QREFELT $ 44))
                    (SPADCALL |y| (QREFELT $ 44)))
                (EXIT
                 (SEQ
                  (SPADCALL |refer| (SPADCALL (QREFELT $ 19)) (QREFELT $ 31))
                  (EXIT (SPADCALL (QREFELT $ 14)))))))
              (COND
               ((SPADCALL |x| (QREFELT $ 45))
                (COND
                 ((SPADCALL |y| (QREFELT $ 45))
                  (EXIT
                   (SEQ
                    (LETT |xCoef|
                          (|ISUPS;getCoef|
                           (LETT |xTerm| (SPADCALL |x| (QREFELT $ 32))) $))
                    (LETT |xExpon| (|ISUPS;getExpon| |xTerm| $))
                    (LETT |yCoef|
                          (|ISUPS;getCoef|
                           (LETT |yTerm| (SPADCALL |y| (QREFELT $ 32))) $))
                    (LETT |yExpon| (|ISUPS;getExpon| |yTerm| $))
                    (LETT |expon| (SPADCALL |xExpon| |yExpon| (QREFELT $ 52)))
                    (SPADCALL |refer| (SPADCALL |expon| (QREFELT $ 33))
                              (QREFELT $ 31))
                    (LETT |scRefer|
                          (SPADCALL (SPADCALL |expon| (QREFELT $ 33))
                                    (QREFELT $ 20)))
                    (LETT |scMult|
                          (|ISUPS;productByTerm| |xCoef| |xExpon|
                           (SPADCALL |y| (QREFELT $ 24)) |yRefer| |scRefer|
                           (SPADCALL |yExpon| (|spadConstant| $ 96)
                                     (QREFELT $ 52))
                           $))
                    (LETT |prRefer|
                          (SPADCALL (SPADCALL |expon| (QREFELT $ 33))
                                    (QREFELT $ 20)))
                    (LETT |pr|
                          (|ISUPS;iTimes| (SPADCALL |x| (QREFELT $ 24))
                           |xRefer| |y| |yRefer| |prRefer|
                           (SPADCALL |expon| (|spadConstant| $ 96)
                                     (QREFELT $ 52))
                           $))
                    (LETT |sm|
                          (|ISUPS;iPlus1| (ELT $ 82) |scMult| |scRefer| |pr|
                           |prRefer| |refer|
                           (SPADCALL |expon| (|spadConstant| $ 96)
                                     (QREFELT $ 52))
                           $))
                    (EXIT
                     (COND
                      ((SPADCALL
                        (LETT |coef| (SPADCALL |xCoef| |yCoef| (QREFELT $ 73)))
                        (QREFELT $ 16))
                       |sm|)
                      ('T
                       (SPADCALL (|ISUPS;makeTerm| |expon| |coef| $) |sm|
                                 (QREFELT $ 17)))))))))))
              (EXIT
               (COND
                ((SPADCALL |x| (QREFELT $ 45))
                 (SEQ
                  (LETT |xExpon|
                        (|ISUPS;getExpon| (SPADCALL |x| (QREFELT $ 32)) $))
                  (LETT |degr|
                        (SPADCALL (SPADCALL |yRefer| (QREFELT $ 42))
                                  (QREFELT $ 53)))
                  (SPADCALL |refer|
                            (SPADCALL (SPADCALL |xExpon| |degr| (QREFELT $ 52))
                                      (QREFELT $ 33))
                            (QREFELT $ 31))
                  (EXIT
                   (|ISUPS;iTimes| |x| |xRefer| |y| |yRefer| |refer|
                    (SPADCALL (SPADCALL |xExpon| |degr| (QREFELT $ 52))
                              (|spadConstant| $ 96) (QREFELT $ 52))
                    $))))
                ((SPADCALL |y| (QREFELT $ 45))
                 (SEQ
                  (LETT |yExpon|
                        (|ISUPS;getExpon| (SPADCALL |y| (QREFELT $ 32)) $))
                  (LETT |degr|
                        (SPADCALL (SPADCALL |xRefer| (QREFELT $ 42))
                                  (QREFELT $ 53)))
                  (SPADCALL |refer|
                            (SPADCALL (SPADCALL |yExpon| |degr| (QREFELT $ 52))
                                      (QREFELT $ 33))
                            (QREFELT $ 31))
                  (EXIT
                   (|ISUPS;iTimes| |x| |xRefer| |y| |yRefer| |refer|
                    (SPADCALL (SPADCALL |yExpon| |degr| (QREFELT $ 52))
                              (|spadConstant| $ 96) (QREFELT $ 52))
                    $))))
                ('T
                 (SEQ
                  (LETT |xDegr|
                        (SPADCALL (SPADCALL |xRefer| (QREFELT $ 42))
                                  (QREFELT $ 53)))
                  (LETT |yDegr|
                        (SPADCALL (SPADCALL |yRefer| (QREFELT $ 42))
                                  (QREFELT $ 53)))
                  (SPADCALL |refer|
                            (SPADCALL (SPADCALL |xDegr| |yDegr| (QREFELT $ 52))
                                      (QREFELT $ 33))
                            (QREFELT $ 31))
                  (EXIT
                   (|ISUPS;iTimes| |x| |xRefer| |y| |yRefer| |refer|
                    (SPADCALL (SPADCALL |xDegr| |yDegr| (QREFELT $ 52))
                              (|spadConstant| $ 96) (QREFELT $ 52))
                    $)))))))))))) 

(SDEFUN |ISUPS;*;3$;49| ((|ups1| ($)) (|ups2| ($)) ($ ($)))
        (SPROG
         ((|refer| (|Reference| (|OrderedCompletion| (|Integer|))))
          (|deg| (|Integer|)) (|yDeg| #1=(|Integer|)) (#2=#:G1298 NIL)
          (|y| #3=(|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
          (|yRefer| #4=(|Reference| (|OrderedCompletion| (|Integer|))))
          (|xDeg| #1#) (|x| #3#) (|xRefer| #4#))
         (SEQ
          (EXIT
           (SEQ (LETT |xRefer| (SPADCALL |ups1| (QREFELT $ 12)))
                (LETT |x| (SPADCALL |ups1| (QREFELT $ 13)))
                (LETT |xDeg|
                      (COND
                       ((SPADCALL |x| (QREFELT $ 44))
                        (PROGN
                         (LETT #2# (|spadConstant| $ 29))
                         (GO #5=#:G1297)))
                       ((SPADCALL |x| (QREFELT $ 45))
                        (- (|ISUPS;getExpon| (SPADCALL |x| (QREFELT $ 32)) $)
                           1))
                       (#6='T
                        (SPADCALL (SPADCALL |xRefer| (QREFELT $ 42))
                                  (QREFELT $ 53)))))
                (LETT |yRefer| (SPADCALL |ups2| (QREFELT $ 12)))
                (LETT |y| (SPADCALL |ups2| (QREFELT $ 13)))
                (LETT |yDeg|
                      (COND
                       ((SPADCALL |y| (QREFELT $ 44))
                        (PROGN (LETT #2# (|spadConstant| $ 29)) (GO #5#)))
                       ((SPADCALL |y| (QREFELT $ 45))
                        (- (|ISUPS;getExpon| (SPADCALL |y| (QREFELT $ 32)) $)
                           1))
                       (#6#
                        (SPADCALL (SPADCALL |yRefer| (QREFELT $ 42))
                                  (QREFELT $ 53)))))
                (LETT |deg| (+ (+ |xDeg| |yDeg|) 1))
                (LETT |refer|
                      (SPADCALL (SPADCALL |deg| (QREFELT $ 33))
                                (QREFELT $ 20)))
                (EXIT
                 (SPADCALL |refer|
                           (|ISUPS;iTimes| |x| |xRefer| |y| |yRefer| |refer|
                            (+ |deg| 1) $)
                           (QREFELT $ 11)))))
          #5# (EXIT #2#)))) 

(SDEFUN |ISUPS;iDivide|
        ((|x| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
         (|xRefer| (|Reference| (|OrderedCompletion| (|Integer|))))
         (|y| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
         (|yRefer| (|Reference| (|OrderedCompletion| (|Integer|))))
         (|rym| (|Coef|)) (|m| (|Integer|))
         (|refer| (|Reference| (|OrderedCompletion| (|Integer|))))
         (|n| (|Integer|))
         ($ (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))))
        (SPROG NIL
               (SEQ
                (SPADCALL
                 (CONS #'|ISUPS;iDivide!0|
                       (VECTOR |yRefer| |y| |rym| |xRefer| |m| |n| |refer| $
                               |x|))
                 (QREFELT $ 35))))) 

(SDEFUN |ISUPS;iDivide!0| (($$ NIL))
        (PROG (|x| $ |refer| |n| |m| |xRefer| |rym| |y| |yRefer|)
          (LETT |x| (QREFELT $$ 8))
          (LETT $ (QREFELT $$ 7))
          (LETT |refer| (QREFELT $$ 6))
          (LETT |n| (QREFELT $$ 5))
          (LETT |m| (QREFELT $$ 4))
          (LETT |xRefer| (QREFELT $$ 3))
          (LETT |rym| (QREFELT $$ 2))
          (LETT |y| (QREFELT $$ 1))
          (LETT |yRefer| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG
             ((|nm| NIL) (|xTerm| NIL) (|newCoef| NIL) (|nx| NIL)
              (|prodRefer| NIL) (|prod| NIL) (|sumRefer| NIL) (|sum| NIL)
              (|term| NIL) (|degr| NIL))
             (SEQ
              (COND
               ((SPADCALL |x| (QREFELT $ 44))
                (SEQ
                 (SPADCALL |refer| (SPADCALL (QREFELT $ 19)) (QREFELT $ 31))
                 (EXIT (SPADCALL (QREFELT $ 14)))))
               ('T
                (SEQ
                 (LETT |nm|
                       (SPADCALL (SPADCALL |n| |m| (QREFELT $ 52))
                                 (QREFELT $ 33)))
                 (SEQ G190
                      (COND
                       ((NULL
                         (SPADCALL (SPADCALL |xRefer| (QREFELT $ 42)) |nm|
                                   (QREFELT $ 43)))
                        (GO G191)))
                      (SEQ (EXIT (SPADCALL |x| (QREFELT $ 46)))) NIL (GO G190)
                      G191 (EXIT NIL))
                 (EXIT
                  (COND
                   ((SPADCALL |x| (QREFELT $ 44))
                    (SEQ
                     (SPADCALL |refer| (SPADCALL (QREFELT $ 19))
                               (QREFELT $ 31))
                     (EXIT (SPADCALL (QREFELT $ 14)))))
                   ((SPADCALL |x| (QREFELT $ 45))
                    (SEQ
                     (LETT |newCoef|
                           (SPADCALL
                            (|ISUPS;getCoef|
                             (LETT |xTerm| (SPADCALL |x| (QREFELT $ 32))) $)
                            |rym| (QREFELT $ 73)))
                     (LETT |nx| (|ISUPS;getExpon| |xTerm| $))
                     (LETT |prodRefer|
                           (SPADCALL (SPADCALL |nx| (QREFELT $ 33))
                                     (QREFELT $ 20)))
                     (LETT |prod|
                           (|ISUPS;productByTerm|
                            (SPADCALL |newCoef| (QREFELT $ 85))
                            (SPADCALL |nx| |m| (QREFELT $ 71))
                            (SPADCALL |y| (QREFELT $ 24)) |yRefer| |prodRefer|
                            (|spadConstant| $ 96) $))
                     (LETT |sumRefer|
                           (SPADCALL (SPADCALL |nx| (QREFELT $ 33))
                                     (QREFELT $ 20)))
                     (LETT |sum|
                           (|ISUPS;iPlus1| (ELT $ 82)
                            (SPADCALL |x| (QREFELT $ 24)) |xRefer| |prod|
                            |prodRefer| |sumRefer|
                            (SPADCALL |nx| (|spadConstant| $ 96)
                                      (QREFELT $ 52))
                            $))
                     (SPADCALL |refer|
                               (SPADCALL (SPADCALL |nx| |m| (QREFELT $ 71))
                                         (QREFELT $ 33))
                               (QREFELT $ 31))
                     (LETT |term|
                           (|ISUPS;makeTerm| (SPADCALL |nx| |m| (QREFELT $ 71))
                            |newCoef| $))
                     (EXIT
                      (SPADCALL |term|
                                (|ISUPS;iDivide| |sum| |sumRefer| |y| |yRefer|
                                 |rym| |m| |refer|
                                 (SPADCALL (SPADCALL |nx| |m| (QREFELT $ 71))
                                           (|spadConstant| $ 96)
                                           (QREFELT $ 52))
                                 $)
                                (QREFELT $ 17)))))
                   ('T
                    (SEQ
                     (LETT |degr|
                           (SPADCALL (SPADCALL |xRefer| (QREFELT $ 42))
                                     (QREFELT $ 53)))
                     (SPADCALL |refer|
                               (SPADCALL (SPADCALL |degr| |m| (QREFELT $ 71))
                                         (QREFELT $ 33))
                               (QREFELT $ 31))
                     (EXIT
                      (|ISUPS;iDivide| |x| |xRefer| |y| |yRefer| |rym| |m|
                       |refer|
                       (SPADCALL (SPADCALL |degr| |m| (QREFELT $ 71))
                                 (|spadConstant| $ 96) (QREFELT $ 52))
                       $))))))))))))))) 

(SDEFUN |ISUPS;divide|
        ((|ups1| ($)) (|deg1| (|Integer|)) (|ups2| ($)) (|deg2| (|Integer|))
         (|r| (|Coef|)) ($ ($)))
        (SPROG
         ((|refer| (|Reference| (|OrderedCompletion| (|Integer|))))
          (|y| #1=(|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
          (|yRefer| #2=(|Reference| (|OrderedCompletion| (|Integer|))))
          (|x| #1#) (|xRefer| #2#))
         (SEQ (LETT |xRefer| (SPADCALL |ups1| (QREFELT $ 12)))
              (LETT |x| (SPADCALL |ups1| (QREFELT $ 13)))
              (LETT |yRefer| (SPADCALL |ups2| (QREFELT $ 12)))
              (LETT |y| (SPADCALL |ups2| (QREFELT $ 13)))
              (LETT |refer|
                    (SPADCALL (SPADCALL (- |deg1| |deg2|) (QREFELT $ 33))
                              (QREFELT $ 20)))
              (EXIT
               (SPADCALL |refer|
                         (|ISUPS;iDivide| |x| |xRefer| |y| |yRefer| |r| |deg2|
                          |refer| (+ (- |deg1| |deg2|) 1) $)
                         (QREFELT $ 11)))))) 

(SDEFUN |ISUPS;iExquo;2$BU;52|
        ((|ups1| ($)) (|ups2| ($)) (|taylor?| (|Boolean|))
         ($ (|Union| $ "failed")))
        (SPROG
         ((|nx| (|Integer|)) (#1=#:G1358 NIL) (#2=#:G1360 NIL)
          (|deg| #3=(|Integer|)) (|nn| (|OrderedCompletion| (|Integer|)))
          (|ry| (|Union| |Coef| "failed")) (|ny| #3#) (|yCoef| (|Coef|))
          (|yTerm| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))
          (#4=#:G1359 NIL) (|n| (|Integer|))
          (|y| #5=(|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
          (|x| #5#) (|xRefer| (|Reference| (|OrderedCompletion| (|Integer|)))))
         (SEQ
          (EXIT
           (SEQ (LETT |xRefer| (SPADCALL |ups1| (QREFELT $ 12)))
                (LETT |x| (SPADCALL |ups1| (QREFELT $ 13)))
                (LETT |y| (SPADCALL |ups2| (QREFELT $ 13))) (LETT |n| 0)
                (SEQ G190
                     (COND
                      ((NULL (NULL (SPADCALL |y| (QREFELT $ 45)))) (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((SPADCALL |y| (QREFELT $ 44))
                         (PROGN (LETT #2# (CONS 1 "failed")) (GO #6=#:G1357)))
                        ('T
                         (SEQ
                          (EXIT
                           (SEQ (SPADCALL |y| (QREFELT $ 46))
                                (LETT |n| (+ |n| 1))
                                (EXIT
                                 (COND
                                  ((> |n| 1000)
                                   (PROGN
                                    (LETT #4#
                                          (PROGN
                                           (LETT #2# (CONS 1 "failed"))
                                           (GO #6#)))
                                    (GO #7=#:G1337)))))))
                          #7# (EXIT #4#))))))
                     NIL (GO G190) G191 (EXIT NIL))
                (LETT |yCoef|
                      (|ISUPS;getCoef|
                       (LETT |yTerm| (SPADCALL |y| (QREFELT $ 32))) $))
                (LETT |ny| (|ISUPS;getExpon| |yTerm| $))
                (LETT |ry| (SPADCALL |yCoef| (QREFELT $ 99)))
                (EXIT
                 (COND ((QEQCAR |ry| 1) (CONS 1 "failed"))
                       (#8='T
                        (SEQ (LETT |nn| (SPADCALL |ny| (QREFELT $ 33)))
                             (COND
                              (|taylor?|
                               (SEQ G190
                                    (COND
                                     ((NULL
                                       (SPADCALL
                                        (SPADCALL |xRefer| (QREFELT $ 42)) |nn|
                                        (QREFELT $ 43)))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (COND
                                       ((SPADCALL |x| (QREFELT $ 44))
                                        (PROGN
                                         (LETT #2#
                                               (CONS 0 (|spadConstant| $ 29)))
                                         (GO #6#)))
                                       ((SPADCALL |x| (QREFELT $ 45))
                                        (PROGN
                                         (LETT #2# (CONS 1 "failed"))
                                         (GO #6#)))
                                       ('T (SPADCALL |x| (QREFELT $ 46))))))
                                    NIL (GO G190) G191 (EXIT NIL))))
                             (EXIT
                              (COND
                               ((SPADCALL (SPADCALL |y| (QREFELT $ 24))
                                          (QREFELT $ 23))
                                (CONS 0
                                      (|ISUPS;iMap2|
                                       (CONS #'|ISUPS;iExquo;2$BU;52!0|
                                             (VECTOR $ |ry|))
                                       (CONS #'|ISUPS;iExquo;2$BU;52!1|
                                             (VECTOR $ |ny|))
                                       NIL |ups1| $)))
                               ((SPADCALL |x| (QREFELT $ 44))
                                (CONS 0 (|spadConstant| $ 29)))
                               (#8#
                                (SEQ
                                 (LETT |nx|
                                       (COND
                                        ((SPADCALL |x| (QREFELT $ 45))
                                         (SEQ
                                          (EXIT
                                           (SEQ
                                            (SEQ
                                             (LETT |deg|
                                                   (|ISUPS;getExpon|
                                                    (SPADCALL |x|
                                                              (QREFELT $ 32))
                                                    $))
                                             (EXIT
                                              (COND
                                               ((< |deg| |ny|)
                                                (COND
                                                 (|taylor?|
                                                  (PROGN
                                                   (LETT #1#
                                                         (PROGN
                                                          (LETT #2#
                                                                (CONS 1
                                                                      "failed"))
                                                          (GO #6#)))
                                                   (GO #9=#:G1351))))))))
                                            (EXIT (- |deg| 1))))
                                          #9# (EXIT #1#)))
                                        (#8#
                                         (SPADCALL
                                          (SPADCALL |xRefer| (QREFELT $ 42))
                                          (QREFELT $ 53)))))
                                 (EXIT
                                  (CONS 0
                                        (|ISUPS;divide| |ups1| |nx| |ups2| |ny|
                                         (QCDR |ry|) $)))))))))))))
          #6# (EXIT #2#)))) 

(SDEFUN |ISUPS;iExquo;2$BU;52!1| ((|z| NIL) ($$ NIL))
        (PROG (|ny| $)
          (LETT |ny| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |z| |ny| (QREFELT $ 71)))))) 

(SDEFUN |ISUPS;iExquo;2$BU;52!0| ((|y1| NIL) (|m| NIL) ($$ NIL))
        (PROG (|ry| $)
          (LETT |ry| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |y1| (QCDR |ry|) (QREFELT $ 73)))))) 

(SDEFUN |ISUPS;taylorQuoByVar;2$;53| ((|ups| ($)) ($ ($)))
        (|ISUPS;iMap2| (LIST #'|ISUPS;taylorQuoByVar;2$;53!0|)
         (CONS #'|ISUPS;taylorQuoByVar;2$;53!1| $) NIL
         (SPADCALL |ups|
                   (SPADCALL (SPADCALL |ups| 0 (QREFELT $ 57)) 0
                             (QREFELT $ 22))
                   (QREFELT $ 66))
         $)) 

(SDEFUN |ISUPS;taylorQuoByVar;2$;53!1| ((|z| NIL) ($ NIL))
        (SPADCALL |z| (|spadConstant| $ 51) (QREFELT $ 71))) 

(SDEFUN |ISUPS;taylorQuoByVar;2$;53!0| ((|y| NIL) (|n| NIL) ($$ NIL)) |y|) 

(SDEFUN |ISUPS;compose0|
        ((|x| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
         (|xRefer| (|Reference| (|OrderedCompletion| (|Integer|))))
         (|y| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
         (|yRefer| (|Reference| (|OrderedCompletion| (|Integer|))))
         (|yOrd| (|Integer|)) (|y1| ($)) (|yn0| ($)) (|n0| (|Integer|))
         (|refer| (|Reference| (|OrderedCompletion| (|Integer|))))
         (|n| (|Integer|))
         ($ (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))))
        (SPROG NIL
               (SEQ
                (SPADCALL
                 (CONS #'|ISUPS;compose0!2|
                       (VECTOR |n0| |yn0| |y1| |yRefer| |y| |n| |yOrd| |xRefer|
                               |refer| $ |x|))
                 (QREFELT $ 35))))) 

(SDEFUN |ISUPS;compose0!2| (($$ NIL))
        (PROG (|x| $ |refer| |xRefer| |yOrd| |n| |y| |yRefer| |y1| |yn0| |n0|)
          (LETT |x| (QREFELT $$ 10))
          (LETT $ (QREFELT $$ 9))
          (LETT |refer| (QREFELT $$ 8))
          (LETT |xRefer| (QREFELT $$ 7))
          (LETT |yOrd| (QREFELT $$ 6))
          (LETT |n| (QREFELT $$ 5))
          (LETT |y| (QREFELT $$ 4))
          (LETT |yRefer| (QREFELT $$ 3))
          (LETT |y1| (QREFELT $$ 2))
          (LETT |yn0| (QREFELT $$ 1))
          (LETT |n0| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG
             ((|x_ord| NIL) (#1=#:G1412 NIL) (|xTerm| NIL) (|xCoef| NIL)
              (|n1| NIL) (#2=#:G1403 NIL) (|yn1| NIL) (|z| NIL) (|zRefer| NIL)
              (|prodRefer| NIL) (|prod| NIL) (|coRefer| NIL) (|co| NIL)
              (|degr| NIL))
             (SEQ
              (COND
               ((SPADCALL |x| (QREFELT $ 44))
                (SEQ
                 (SPADCALL |refer| (SPADCALL (QREFELT $ 19)) (QREFELT $ 31))
                 (EXIT (SPADCALL (QREFELT $ 14)))))
               ('T
                (SEQ
                 (SEQ
                  (EXIT
                   (SEQ G190 NIL
                        (SEQ (LETT |x_ord| (SPADCALL |xRefer| (QREFELT $ 42)))
                             (EXIT
                              (COND
                               ((SPADCALL (SPADCALL |x_ord| (QREFELT $ 64))
                                          (|spadConstant| $ 107)
                                          (QREFELT $ 103))
                                (PROGN (LETT #1# 1) (GO #3=#:G1400)))
                               ((SPADCALL
                                 (SPADCALL |yOrd|
                                           (SPADCALL |x_ord| (QREFELT $ 53))
                                           (QREFELT $ 104))
                                 |n| (QREFELT $ 80))
                                (SPADCALL |x| (QREFELT $ 46)))
                               ('T (PROGN (LETT #1# |$NoValue|) (GO #3#))))))
                        NIL (GO G190) G191 (EXIT NIL)))
                  #3# (EXIT #1#))
                 (EXIT
                  (COND
                   ((SPADCALL |x| (QREFELT $ 45))
                    (SEQ
                     (LETT |xCoef|
                           (|ISUPS;getCoef|
                            (LETT |xTerm| (SPADCALL |x| (QREFELT $ 32))) $))
                     (LETT |n1| (|ISUPS;getExpon| |xTerm| $))
                     (EXIT
                      (COND
                       ((SPADCALL |n1| (QREFELT $ 105))
                        (SEQ
                         (SPADCALL |refer| (SPADCALL |n1| (QREFELT $ 33))
                                   (QREFELT $ 31))
                         (EXIT
                          (SPADCALL (|ISUPS;makeTerm| |n1| |xCoef| $)
                                    (|ISUPS;compose0|
                                     (SPADCALL |x| (QREFELT $ 24)) |xRefer| |y|
                                     |yRefer| |yOrd| |y1| |yn0| |n0| |refer|
                                     (SPADCALL |n1| (|spadConstant| $ 96)
                                               (QREFELT $ 52))
                                     $)
                                    (QREFELT $ 17)))))
                       ('T
                        (SEQ
                         (LETT |yn1|
                               (SPADCALL |yn0|
                                         (SPADCALL |y1|
                                                   (PROG1
                                                       (LETT #2#
                                                             (SPADCALL |n1|
                                                                       |n0|
                                                                       (QREFELT
                                                                        $ 71)))
                                                     (|check_subtype2|
                                                      (>= #2# 0)
                                                      '(|NonNegativeInteger|)
                                                      '(|Integer|) #2#))
                                                   (QREFELT $ 106))
                                         (QREFELT $ 97)))
                         (LETT |z| (SPADCALL |yn1| (QREFELT $ 13)))
                         (LETT |zRefer| (SPADCALL |yn1| (QREFELT $ 12)))
                         (LETT |degr| (SPADCALL |yOrd| |n1| (QREFELT $ 104)))
                         (LETT |prodRefer|
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL |degr| (|spadConstant| $ 96)
                                           (QREFELT $ 71))
                                 (QREFELT $ 33))
                                (QREFELT $ 20)))
                         (LETT |prod|
                               (|ISUPS;iMap1|
                                (CONS #'|ISUPS;compose0!0| (VECTOR $ |xCoef|))
                                (LIST #'|ISUPS;compose0!1|) 'T |z| |zRefer|
                                |prodRefer| |degr| $))
                         (LETT |coRefer|
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL |degr| |yOrd| (QREFELT $ 52))
                                  (|spadConstant| $ 96) (QREFELT $ 71))
                                 (QREFELT $ 33))
                                (QREFELT $ 20)))
                         (LETT |co|
                               (|ISUPS;compose0| (SPADCALL |x| (QREFELT $ 24))
                                |xRefer| |y| |yRefer| |yOrd| |y1| |yn1| |n1|
                                |coRefer|
                                (SPADCALL |degr| |yOrd| (QREFELT $ 52)) $))
                         (SPADCALL |refer|
                                   (SPADCALL
                                    (SPADCALL |degr| (|spadConstant| $ 96)
                                              (QREFELT $ 71))
                                    (QREFELT $ 33))
                                   (QREFELT $ 31))
                         (EXIT
                          (|ISUPS;iPlus1| (ELT $ 82) |prod| |prodRefer| |co|
                           |coRefer| |refer| |degr| $))))))))
                   ('T
                    (SEQ
                     (LETT |degr|
                           (SPADCALL |yOrd|
                                     (SPADCALL
                                      (SPADCALL
                                       (SPADCALL |xRefer| (QREFELT $ 42))
                                       (QREFELT $ 53))
                                      (|spadConstant| $ 96) (QREFELT $ 52))
                                     (QREFELT $ 104)))
                     (SPADCALL |refer|
                               (SPADCALL
                                (SPADCALL |degr| (|spadConstant| $ 96)
                                          (QREFELT $ 71))
                                (QREFELT $ 33))
                               (QREFELT $ 31))
                     (EXIT
                      (|ISUPS;compose0| |x| |xRefer| |y| |yRefer| |yOrd| |y1|
                       |yn0| |n0| |refer| |degr| $))))))))))))))) 

(SDEFUN |ISUPS;compose0!1| ((|m| NIL) ($$ NIL)) |m|) 

(SDEFUN |ISUPS;compose0!0| ((|s| NIL) (|k| NIL) ($$ NIL))
        (PROG (|xCoef| $)
          (LETT |xCoef| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |xCoef| |s| (QREFELT $ 73)))))) 

(SDEFUN |ISUPS;iCompose;3$;55| ((|ups1| ($)) (|ups2| ($)) ($ ($)))
        (SPROG
         ((|compRefer| (|Reference| (|OrderedCompletion| (|Integer|))))
          (|yOrd| (|Integer|)) (#1=#:G1424 NIL) (#2=#:G1425 NIL) (|i| NIL)
          (|n| (|Integer|))
          (|yRefer| #3=(|Reference| (|OrderedCompletion| (|Integer|))))
          (|y| #4=(|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
          (|xRefer| #3#) (|x| #4#))
         (SEQ
          (EXIT
           (SEQ (LETT |x| (SPADCALL |ups1| (QREFELT $ 13)))
                (LETT |xRefer| (SPADCALL |ups1| (QREFELT $ 12)))
                (LETT |y| (SPADCALL |ups2| (QREFELT $ 13)))
                (LETT |yRefer| (SPADCALL |ups2| (QREFELT $ 12)))
                (LETT |n| |$streamCount|)
                (SEQ (LETT |i| 1) (LETT #2# |n|) G190
                     (COND
                      ((OR (|greater_SI| |i| #2#)
                           (NULL (NULL (SPADCALL |y| (QREFELT $ 45)))))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((SPADCALL |y| (QREFELT $ 44))
                         (PROGN
                          (LETT #1#
                                (SPADCALL (SPADCALL |ups1| 0 (QREFELT $ 57))
                                          (QREFELT $ 27)))
                          (GO #5=#:G1423)))
                        ('T (SPADCALL |y| (QREFELT $ 46))))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (EXIT
                 (COND
                  ((SPADCALL |y| (QREFELT $ 44))
                   (SPADCALL (SPADCALL |ups1| 0 (QREFELT $ 57))
                             (QREFELT $ 27)))
                  (#6='T
                   (SEQ
                    (LETT |yOrd|
                          (COND
                           ((SPADCALL |y| (QREFELT $ 45))
                            (|ISUPS;getExpon| (SPADCALL |y| (QREFELT $ 32)) $))
                           (#6#
                            (SPADCALL (SPADCALL |yRefer| (QREFELT $ 42))
                                      (QREFELT $ 53)))))
                    (LETT |compRefer|
                          (SPADCALL (SPADCALL -1 (QREFELT $ 33))
                                    (QREFELT $ 20)))
                    (EXIT
                     (SPADCALL |compRefer|
                               (|ISUPS;compose0| |x| |xRefer| |y| |yRefer|
                                |yOrd| |ups2| (|spadConstant| $ 40) 0
                                |compRefer| 0 $)
                               (QREFELT $ 11)))))))))
          #5# (EXIT #1#)))) 

(SDEFUN |ISUPS;integrate;2$;56| ((|x| ($)) ($ ($)))
        (|ISUPS;iMap2| (CONS #'|ISUPS;integrate;2$;56!0| $)
         (CONS #'|ISUPS;integrate;2$;56!1| $) 'T |x| $)) 

(SDEFUN |ISUPS;integrate;2$;56!1| ((|z| NIL) ($ NIL))
        (SPADCALL |z| (|spadConstant| $ 51) (QREFELT $ 52))) 

(SDEFUN |ISUPS;integrate;2$;56!0| ((|y| NIL) (|n| NIL) ($ NIL))
        (SPADCALL
         (SPADCALL (|spadConstant| $ 51)
                   (SPADCALL |n| (|spadConstant| $ 51) (QREFELT $ 52))
                   (QREFELT $ 110))
         |y| (QREFELT $ 111))) 

(SDEFUN |ISUPS;integ0|
        ((|x| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
         (|intRef| (|Reference| (|OrderedCompletion| (|Integer|))))
         (|ansRef| (|Reference| (|OrderedCompletion| (|Integer|))))
         (|n| (|Integer|))
         ($ (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))))
        (SPROG NIL
               (SEQ
                (SPADCALL
                 (CONS #'|ISUPS;integ0!0| (VECTOR |ansRef| |x| |intRef| $ |n|))
                 (QREFELT $ 35))))) 

(SDEFUN |ISUPS;integ0!0| (($$ NIL))
        (PROG (|n| $ |intRef| |x| |ansRef|)
          (LETT |n| (QREFELT $$ 4))
          (LETT $ (QREFELT $$ 3))
          (LETT |intRef| (QREFELT $$ 2))
          (LETT |x| (QREFELT $$ 1))
          (LETT |ansRef| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG
             ((|nLess1| NIL) (|xTerm| NIL) (|xCoef| NIL) (|nx| NIL) (|n1| NIL)
              (|degr| NIL))
             (SEQ
              (LETT |nLess1|
                    (SPADCALL
                     (SPADCALL |n| (|spadConstant| $ 96) (QREFELT $ 71))
                     (QREFELT $ 33)))
              (SEQ G190
                   (COND
                    ((NULL
                      (SPADCALL (SPADCALL |intRef| (QREFELT $ 42)) |nLess1|
                                (QREFELT $ 43)))
                     (GO G191)))
                   (SEQ (EXIT (SPADCALL |x| (QREFELT $ 46)))) NIL (GO G190)
                   G191 (EXIT NIL))
              (EXIT
               (COND
                ((SPADCALL |x| (QREFELT $ 44))
                 (SEQ
                  (SPADCALL |ansRef| (SPADCALL (QREFELT $ 19)) (QREFELT $ 31))
                  (EXIT (SPADCALL (QREFELT $ 14)))))
                ((SPADCALL |x| (QREFELT $ 45))
                 (SEQ
                  (LETT |xCoef|
                        (|ISUPS;getCoef|
                         (LETT |xTerm| (SPADCALL |x| (QREFELT $ 32))) $))
                  (LETT |nx| (|ISUPS;getExpon| |xTerm| $))
                  (SPADCALL |ansRef|
                            (SPADCALL
                             (LETT |n1|
                                   (SPADCALL |nx| (|spadConstant| $ 96)
                                             (QREFELT $ 52)))
                             (QREFELT $ 33))
                            (QREFELT $ 31))
                  (EXIT
                   (SPADCALL
                    (|ISUPS;makeTerm| |n1|
                     (SPADCALL
                      (SPADCALL (SPADCALL |n1| (QREFELT $ 113))
                                (QREFELT $ 114))
                      |xCoef| (QREFELT $ 111))
                     $)
                    (|ISUPS;integ0| (SPADCALL |x| (QREFELT $ 24)) |intRef|
                     |ansRef| |n1| $)
                    (QREFELT $ 17)))))
                ('T
                 (SEQ
                  (LETT |degr|
                        (SPADCALL (SPADCALL |intRef| (QREFELT $ 42))
                                  (QREFELT $ 53)))
                  (SPADCALL |ansRef|
                            (SPADCALL
                             (SPADCALL |degr| (|spadConstant| $ 96)
                                       (QREFELT $ 52))
                             (QREFELT $ 33))
                            (QREFELT $ 31))
                  (EXIT
                   (|ISUPS;integ0| |x| |intRef| |ansRef|
                    (SPADCALL |degr| 2 (QREFELT $ 52)) $)))))))))))) 

(SDEFUN |ISUPS;integ1|
        ((|x| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
         (|intRef| (|Reference| (|OrderedCompletion| (|Integer|))))
         (|ansRef| (|Reference| (|OrderedCompletion| (|Integer|))))
         ($ (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))))
        (|ISUPS;integ0| |x| |intRef| |ansRef| 1 $)) 

(SDEFUN |ISUPS;lazyInteg|
        ((|a| (|Coef|))
         (|xf|
          (|Mapping|
           (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))))
         (|intRef| (|Reference| (|OrderedCompletion| (|Integer|))))
         (|ansRef| (|Reference| (|OrderedCompletion| (|Integer|))))
         ($ (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))))
        (SPROG
         ((|ansStr|
           (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))))
         (SEQ
          (LETT |ansStr|
                (|ISUPS;integ1| (SPADCALL |xf| (QREFELT $ 35)) |intRef|
                 |ansRef| $))
          (EXIT
           (SPADCALL (|ISUPS;makeTerm| 0 |a| $) |ansStr| (QREFELT $ 17)))))) 

(SDEFUN |ISUPS;cPower;$Coef$;60| ((|f| ($)) (|r| (|Coef|)) ($ ($)))
        (SPROG
         ((|ansStr|
           (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
          (|ansRef| #1=(|Reference| (|OrderedCompletion| (|Integer|))))
          (|intRef| #1#)
          (|yStr| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
          (|yRef| (|Reference| (|OrderedCompletion| (|Integer|)))) (|y| ($))
          (|fInv| ($)) (#2=#:G1460 NIL) (|fp| ($)))
         (SEQ (LETT |fp| (SPADCALL |f| (QREFELT $ 72)))
              (LETT |fInv|
                    (PROG2
                        (LETT #2#
                              (SPADCALL (|spadConstant| $ 40) |f| NIL
                                        (QREFELT $ 100)))
                        (QCDR #2#)
                      (|check_union2| (QEQCAR #2# 0) $ (|Union| $ "failed")
                                      #2#)))
              (LETT |y|
                    (SPADCALL (SPADCALL |r| |fp| (QREFELT $ 115)) |fInv|
                              (QREFELT $ 97)))
              (LETT |yRef| (SPADCALL |y| (QREFELT $ 12)))
              (LETT |yStr| (SPADCALL |y| (QREFELT $ 13)))
              (LETT |intRef|
                    (SPADCALL (SPADCALL -1 (QREFELT $ 33)) (QREFELT $ 20)))
              (LETT |ansRef|
                    (SPADCALL (SPADCALL 0 (QREFELT $ 33)) (QREFELT $ 20)))
              (LETT |ansStr|
                    (SPADCALL
                     (CONS #'|ISUPS;cPower;$Coef$;60!1|
                           (VECTOR |ansRef| |yStr| |yRef| |intRef| $))
                     (QREFELT $ 118)))
              (EXIT (SPADCALL |ansRef| |ansStr| (QREFELT $ 11)))))) 

(SDEFUN |ISUPS;cPower;$Coef$;60!1| ((|s| NIL) ($$ NIL))
        (PROG ($ |intRef| |yRef| |yStr| |ansRef|)
          (LETT $ (QREFELT $$ 4))
          (LETT |intRef| (QREFELT $$ 3))
          (LETT |yRef| (QREFELT $$ 2))
          (LETT |yStr| (QREFELT $$ 1))
          (LETT |ansRef| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG NIL
                   (|ISUPS;lazyInteg| (|spadConstant| $ 41)
                    (CONS #'|ISUPS;cPower;$Coef$;60!0|
                          (VECTOR $ |intRef| |yRef| |yStr| |ansRef| |s|))
                    |intRef| |ansRef| $)))))) 

(SDEFUN |ISUPS;cPower;$Coef$;60!0| (($$ NIL))
        (PROG (|s| |ansRef| |yStr| |yRef| |intRef| $)
          (LETT |s| (QREFELT $$ 5))
          (LETT |ansRef| (QREFELT $$ 4))
          (LETT |yStr| (QREFELT $$ 3))
          (LETT |yRef| (QREFELT $$ 2))
          (LETT |intRef| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|ISUPS;iTimes| |s| |ansRef| |yStr| |yRef| |intRef|
             (|spadConstant| $ 107) $))))) 

(SDEFUN |ISUPS;iExp| ((|f| ($)) (|cc| (|Coef|)) ($ ($)))
        (SPROG
         ((|ansStr|
           (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
          (|ansRef| #1=(|Reference| (|OrderedCompletion| (|Integer|))))
          (|intRef| #1#)
          (|fpStr|
           (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
          (|fpRef| (|Reference| (|OrderedCompletion| (|Integer|)))) (|fp| ($)))
         (SEQ (LETT |fp| (SPADCALL |f| (QREFELT $ 72)))
              (LETT |fpRef| (SPADCALL |fp| (QREFELT $ 12)))
              (LETT |fpStr| (SPADCALL |fp| (QREFELT $ 13)))
              (LETT |intRef|
                    (SPADCALL (SPADCALL -1 (QREFELT $ 33)) (QREFELT $ 20)))
              (LETT |ansRef|
                    (SPADCALL (SPADCALL 0 (QREFELT $ 33)) (QREFELT $ 20)))
              (LETT |ansStr|
                    (SPADCALL
                     (CONS #'|ISUPS;iExp!1|
                           (VECTOR |ansRef| |fpStr| |fpRef| |intRef| $ |cc|))
                     (QREFELT $ 118)))
              (EXIT (SPADCALL |ansRef| |ansStr| (QREFELT $ 11)))))) 

(SDEFUN |ISUPS;iExp!1| ((|s| NIL) ($$ NIL))
        (PROG (|cc| $ |intRef| |fpRef| |fpStr| |ansRef|)
          (LETT |cc| (QREFELT $$ 5))
          (LETT $ (QREFELT $$ 4))
          (LETT |intRef| (QREFELT $$ 3))
          (LETT |fpRef| (QREFELT $$ 2))
          (LETT |fpStr| (QREFELT $$ 1))
          (LETT |ansRef| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG NIL
                   (|ISUPS;lazyInteg| |cc|
                    (CONS #'|ISUPS;iExp!0|
                          (VECTOR $ |intRef| |fpRef| |fpStr| |ansRef| |s|))
                    |intRef| |ansRef| $)))))) 

(SDEFUN |ISUPS;iExp!0| (($$ NIL))
        (PROG (|s| |ansRef| |fpStr| |fpRef| |intRef| $)
          (LETT |s| (QREFELT $$ 5))
          (LETT |ansRef| (QREFELT $$ 4))
          (LETT |fpStr| (QREFELT $$ 3))
          (LETT |fpRef| (QREFELT $$ 2))
          (LETT |intRef| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|ISUPS;iTimes| |s| |ansRef| |fpStr| |fpRef| |intRef|
             (|spadConstant| $ 102) $))))) 

(SDEFUN |ISUPS;sincos0|
        ((|sinc| (|Coef|)) (|cosc| (|Coef|))
         (|list|
          (|List|
           (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))))
         (|sinRef| (|Reference| (|OrderedCompletion| (|Integer|))))
         (|cosRef| (|Reference| (|OrderedCompletion| (|Integer|))))
         (|fpStr| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
         (|fpRef| (|Reference| (|OrderedCompletion| (|Integer|))))
         (|fpStr2|
          (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
         (|fpRef2| (|Reference| (|OrderedCompletion| (|Integer|))))
         ($
          (|List|
           (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))))
        (SPROG
         ((|prodStr2|
           #1=(|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
          (|prodStr1| #1#)
          (|prodRef2| #2=(|Reference| (|OrderedCompletion| (|Integer|))))
          (|prodRef1| #2#)
          (|cosStr|
           (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
          (|sinStr|
           (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))))
         (SEQ (LETT |sinStr| (|SPADfirst| |list|))
              (LETT |cosStr| (SPADCALL |list| (QREFELT $ 121)))
              (LETT |prodRef1|
                    (SPADCALL (SPADCALL -1 (QREFELT $ 33)) (QREFELT $ 20)))
              (LETT |prodRef2|
                    (SPADCALL (SPADCALL -1 (QREFELT $ 33)) (QREFELT $ 20)))
              (LETT |prodStr1|
                    (|ISUPS;iTimes| |cosStr| |cosRef| |fpStr| |fpRef|
                     |prodRef1| 0 $))
              (LETT |prodStr2|
                    (|ISUPS;iTimes| |sinStr| |sinRef| |fpStr2| |fpRef2|
                     |prodRef2| 0 $))
              (EXIT
               (LIST
                (|ISUPS;lazyInteg| |sinc| (CONS #'|ISUPS;sincos0!0| |prodStr1|)
                 |prodRef1| |sinRef| $)
                (|ISUPS;lazyInteg| |cosc| (CONS #'|ISUPS;sincos0!1| |prodStr2|)
                 |prodRef2| |cosRef| $)))))) 

(SDEFUN |ISUPS;sincos0!1| ((|prodStr2| NIL)) |prodStr2|) 

(SDEFUN |ISUPS;sincos0!0| ((|prodStr1| NIL)) |prodStr1|) 

(SDEFUN |ISUPS;iSincos|
        ((|f| ($)) (|sinc| (|Coef|)) (|cosc| (|Coef|)) (|sign| (|Integer|))
         ($ (|Record| (|:| |%sin| $) (|:| |%cos| $))))
        (SPROG
         ((|cosStr|
           (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
          (|sinStr|
           (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
          (|sincos|
           (|List|
            (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))))
          (|cosRef| #1=(|Reference| (|OrderedCompletion| (|Integer|))))
          (|sinRef| #1#)
          (|fpStr2|
           #2=(|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
          (|fpRef2| #3=(|Reference| (|OrderedCompletion| (|Integer|))))
          (|fp2| ($)) (|fpStr| #2#) (|fpRef| #3#) (|fp| ($)))
         (SEQ (LETT |fp| (SPADCALL |f| (QREFELT $ 72)))
              (LETT |fpRef| (SPADCALL |fp| (QREFELT $ 12)))
              (LETT |fpStr| (SPADCALL |fp| (QREFELT $ 13)))
              (LETT |fp2|
                    (COND ((EQL |sign| 1) |fp|)
                          (#4='T (SPADCALL |fp| (QREFELT $ 86)))))
              (LETT |fpRef2| (SPADCALL |fp2| (QREFELT $ 12)))
              (LETT |fpStr2| (SPADCALL |fp2| (QREFELT $ 13)))
              (LETT |sinRef|
                    (SPADCALL (SPADCALL 0 (QREFELT $ 33)) (QREFELT $ 20)))
              (LETT |cosRef|
                    (SPADCALL (SPADCALL 0 (QREFELT $ 33)) (QREFELT $ 20)))
              (LETT |sincos|
                    (SPADCALL
                     (CONS #'|ISUPS;iSincos!0|
                           (VECTOR $ |fpRef2| |fpStr2| |fpRef| |fpStr| |cosRef|
                                   |sinRef| |cosc| |sinc|))
                     2 (QREFELT $ 123)))
              (LETT |sinStr|
                    (COND
                     ((SPADCALL |sinc| (QREFELT $ 16))
                      (SPADCALL (|SPADfirst| |sincos|) (QREFELT $ 24)))
                     (#4# (|SPADfirst| |sincos|))))
              (LETT |cosStr|
                    (COND
                     ((SPADCALL |cosc| (QREFELT $ 16))
                      (SPADCALL (SPADCALL |sincos| (QREFELT $ 121))
                                (QREFELT $ 24)))
                     (#4# (SPADCALL |sincos| (QREFELT $ 121)))))
              (EXIT
               (CONS (SPADCALL |sinRef| |sinStr| (QREFELT $ 11))
                     (SPADCALL |cosRef| |cosStr| (QREFELT $ 11))))))) 

(SDEFUN |ISUPS;iSincos!0| ((|s| NIL) ($$ NIL))
        (PROG (|sinc| |cosc| |sinRef| |cosRef| |fpStr| |fpRef| |fpStr2|
               |fpRef2| $)
          (LETT |sinc| (QREFELT $$ 8))
          (LETT |cosc| (QREFELT $$ 7))
          (LETT |sinRef| (QREFELT $$ 6))
          (LETT |cosRef| (QREFELT $$ 5))
          (LETT |fpStr| (QREFELT $$ 4))
          (LETT |fpRef| (QREFELT $$ 3))
          (LETT |fpStr2| (QREFELT $$ 2))
          (LETT |fpRef2| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|ISUPS;sincos0| |sinc| |cosc| |s| |sinRef| |cosRef| |fpStr|
             |fpRef| |fpStr2| |fpRef2| $))))) 

(SDEFUN |ISUPS;tan0|
        ((|cc| (|Coef|))
         (|ansStr|
          (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
         (|ansRef| (|Reference| (|OrderedCompletion| (|Integer|))))
         (|fpStr| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
         (|fpRef| (|Reference| (|OrderedCompletion| (|Integer|))))
         (|sign| (|Integer|))
         ($ (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))))
        (SPROG
         ((|intRef| #1=(|Reference| (|OrderedCompletion| (|Integer|))))
          (|yStr| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
          (|yRef| #1#)
          (|oneRef| (|Reference| (|OrderedCompletion| (|Integer|))))
          (|oneStr|
           (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
          (|one| ($))
          (|sqStr|
           (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
          (|sqRef| #1#))
         (SEQ
          (LETT |sqRef| (SPADCALL (SPADCALL -1 (QREFELT $ 33)) (QREFELT $ 20)))
          (LETT |sqStr|
                (|ISUPS;iTimes| |ansStr| |ansRef| |ansStr| |ansRef| |sqRef| 0
                 $))
          (LETT |one| (|spadConstant| $ 40))
          (LETT |oneStr| (SPADCALL |one| (QREFELT $ 13)))
          (LETT |oneRef| (SPADCALL |one| (QREFELT $ 12)))
          (LETT |yRef| (SPADCALL (SPADCALL -1 (QREFELT $ 33)) (QREFELT $ 20)))
          (LETT |yStr|
                (COND
                 ((EQL |sign| 1)
                  (|ISUPS;iPlus1| (ELT $ 82) |oneStr| |oneRef| |sqStr| |sqRef|
                   |yRef| 0 $))
                 ('T
                  (|ISUPS;iPlus1| (ELT $ 84) |oneStr| |oneRef| |sqStr| |sqRef|
                   |yRef| 0 $))))
          (LETT |intRef|
                (SPADCALL (SPADCALL -1 (QREFELT $ 33)) (QREFELT $ 20)))
          (EXIT
           (|ISUPS;lazyInteg| |cc|
            (CONS #'|ISUPS;tan0!0|
                  (VECTOR $ |intRef| |fpRef| |fpStr| |yRef| |yStr|))
            |intRef| |ansRef| $))))) 

(SDEFUN |ISUPS;tan0!0| (($$ NIL))
        (PROG (|yStr| |yRef| |fpStr| |fpRef| |intRef| $)
          (LETT |yStr| (QREFELT $$ 5))
          (LETT |yRef| (QREFELT $$ 4))
          (LETT |fpStr| (QREFELT $$ 3))
          (LETT |fpRef| (QREFELT $$ 2))
          (LETT |intRef| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|ISUPS;iTimes| |yStr| |yRef| |fpStr| |fpRef| |intRef|
             (|spadConstant| $ 102) $))))) 

(SDEFUN |ISUPS;iTan|
        ((|f| ($)) (|fp| ($)) (|cc| (|Coef|)) (|sign| (|Integer|)) ($ ($)))
        (SPROG
         ((|ansStr|
           (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
          (|ansRef| (|Reference| (|OrderedCompletion| (|Integer|))))
          (|fpStr|
           (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
          (|fpRef| (|Reference| (|OrderedCompletion| (|Integer|)))))
         (SEQ (LETT |fpRef| (SPADCALL |fp| (QREFELT $ 12)))
              (LETT |fpStr| (SPADCALL |fp| (QREFELT $ 13)))
              (LETT |ansRef|
                    (SPADCALL (SPADCALL 0 (QREFELT $ 33)) (QREFELT $ 20)))
              (LETT |ansStr|
                    (SPADCALL
                     (CONS #'|ISUPS;iTan!0|
                           (VECTOR $ |sign| |fpRef| |fpStr| |ansRef| |cc|))
                     (QREFELT $ 118)))
              (EXIT
               (COND
                ((SPADCALL |cc| (QREFELT $ 16))
                 (SPADCALL |ansRef| (SPADCALL |ansStr| (QREFELT $ 24))
                           (QREFELT $ 11)))
                ('T (SPADCALL |ansRef| |ansStr| (QREFELT $ 11)))))))) 

(SDEFUN |ISUPS;iTan!0| ((|s| NIL) ($$ NIL))
        (PROG (|cc| |ansRef| |fpStr| |fpRef| |sign| $)
          (LETT |cc| (QREFELT $$ 5))
          (LETT |ansRef| (QREFELT $$ 4))
          (LETT |fpStr| (QREFELT $$ 3))
          (LETT |fpRef| (QREFELT $$ 2))
          (LETT |sign| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN (|ISUPS;tan0| |cc| |s| |ansRef| |fpStr| |fpRef| |sign| $))))) 

(SDEFUN |ISUPS;orderOrFailed| ((|uts| ($)) ($ (|Union| (|Integer|) "failed")))
        (SPROG
         ((#1=#:G1504 NIL) (|n| NIL)
          (|x| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))))
         (SEQ
          (EXIT
           (SEQ (LETT |x| (SPADCALL |uts| (QREFELT $ 13)))
                (SEQ (LETT |n| 0) G190
                     (COND ((|greater_SI| |n| 1000) (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((SPADCALL |x| (QREFELT $ 44))
                         (PROGN (LETT #1# (CONS 0 -1)) (GO #2=#:G1503)))
                        ((SPADCALL |x| (QREFELT $ 45))
                         (PROGN
                          (LETT #1#
                                (CONS 0
                                      (|ISUPS;getExpon|
                                       (SPADCALL |x| (QREFELT $ 32)) $)))
                          (GO #2#)))
                        ('T (SPADCALL |x| (QREFELT $ 46))))))
                     (LETT |n| (|inc_SI| |n|)) (GO G190) G191 (EXIT NIL))
                (EXIT (CONS 1 "failed"))))
          #2# (EXIT #1#)))) 

(SDEFUN |ISUPS;cRationalPower;$F$;67|
        ((|uts| ($)) (|r| (|Fraction| (|Integer|))) ($ ($)))
        (SPROG
         ((|uts2| ($)) (|uts1| ($)) (|ccPow| (|Coef|)) (#1=#:G1519 NIL)
          (#2=#:G1513 NIL) (|num| (|Integer|))
          (|ccInv| (|Union| |Coef| "failed")) (|cc| (|Coef|))
          (|n| (|Union| (|Integer|) "failed")) (|order| (|Integer|))
          (|ord0| (|Union| (|Integer|) "failed")))
         (SEQ (LETT |ord0| (|ISUPS;orderOrFailed| |uts| $))
              (EXIT
               (COND
                ((QEQCAR |ord0| 1)
                 (|error| "^: series with many leading zero coefficients"))
                (#3='T
                 (SEQ (LETT |order| (QCDR |ord0|))
                      (LETT |n|
                            (SPADCALL |order| (SPADCALL |r| (QREFELT $ 133))
                                      (QREFELT $ 134)))
                      (EXIT
                       (COND
                        ((QEQCAR |n| 1)
                         (|error| "^: rational power does not exist"))
                        (#3#
                         (SEQ
                          (LETT |cc| (SPADCALL |uts| |order| (QREFELT $ 57)))
                          (LETT |ccInv| (SPADCALL |cc| (QREFELT $ 99)))
                          (EXIT
                           (COND
                            ((QEQCAR |ccInv| 1)
                             (|error| (STRCONC "^: " (QREFELT $ 130))))
                            (#3#
                             (SEQ
                              (LETT |ccPow|
                                    (COND
                                     ((SPADCALL |cc| (|spadConstant| $ 41)
                                                (QREFELT $ 135))
                                      |cc|)
                                     ((EQL (SPADCALL |r| (QREFELT $ 133)) 1)
                                      (COND
                                       ((NULL
                                         (MINUSP
                                          (LETT |num|
                                                (SPADCALL |r|
                                                          (QREFELT $ 136)))))
                                        (SPADCALL |cc|
                                                  (PROG1 (LETT #2# |num|)
                                                    (|check_subtype2|
                                                     (>= #2# 0)
                                                     '(|NonNegativeInteger|)
                                                     '(|Integer|) #2#))
                                                  (QREFELT $ 137)))
                                       ('T
                                        (SPADCALL (QCDR |ccInv|)
                                                  (PROG1 (LETT #1# (- |num|))
                                                    (|check_subtype2|
                                                     (>= #1# 0)
                                                     '(|NonNegativeInteger|)
                                                     '(|Integer|) #1#))
                                                  (QREFELT $ 137)))))
                                     ((QREFELT $ 131)
                                      (SPADCALL |cc| |r| (QREFELT $ 138)))
                                     (#3#
                                      (|error|
                                       "^ rational power of coefficient undefined"))))
                              (LETT |uts1|
                                    (SPADCALL (QCDR |ccInv|) |uts|
                                              (QREFELT $ 115)))
                              (LETT |uts2|
                                    (SPADCALL |uts1|
                                              (SPADCALL (|spadConstant| $ 41)
                                                        (- |order|)
                                                        (QREFELT $ 22))
                                              (QREFELT $ 97)))
                              (EXIT
                               (SPADCALL
                                (SPADCALL |ccPow|
                                          (* (QCDR |n|)
                                             (SPADCALL |r| (QREFELT $ 136)))
                                          (QREFELT $ 22))
                                (SPADCALL |uts2| (SPADCALL |r| (QREFELT $ 139))
                                          (QREFELT $ 119))
                                (QREFELT $ 97)))))))))))))))))) 

(SDEFUN |ISUPS;cExp;2$;68| ((|uts| ($)) ($ ($)))
        (SPROG ((|cc| (|Coef|)))
               (COND
                ((SPADCALL (LETT |cc| (SPADCALL |uts| 0 (QREFELT $ 57)))
                           (QREFELT $ 16))
                 (|ISUPS;iExp| |uts| (|spadConstant| $ 41) $))
                ((QREFELT $ 132)
                 (|ISUPS;iExp| |uts| (SPADCALL |cc| (QREFELT $ 141)) $))
                ('T (|error| (STRCONC "exp: " (QREFELT $ 124))))))) 

(SDEFUN |ISUPS;cLog;2$;69| ((|uts| ($)) ($ ($)))
        (SPROG ((|y| ($)) (#1=#:G1532 NIL) (|cc| (|Coef|)))
               (SEQ
                (COND
                 ((SPADCALL (LETT |cc| (SPADCALL |uts| 0 (QREFELT $ 57)))
                            (QREFELT $ 16))
                  (|error| "log: constant coefficient should not be 0"))
                 ((SPADCALL |cc| (|spadConstant| $ 41) (QREFELT $ 135))
                  (SPADCALL
                   (SPADCALL (SPADCALL |uts| (QREFELT $ 72))
                             (PROG2
                                 (LETT #1#
                                       (SPADCALL (|spadConstant| $ 40) |uts| 'T
                                                 (QREFELT $ 100)))
                                 (QCDR #1#)
                               (|check_union2| (QEQCAR #1# 0) $
                                               (|Union| $ #2="failed") #1#))
                             (QREFELT $ 97))
                   (QREFELT $ 112)))
                 ((QREFELT $ 132)
                  (SEQ
                   (LETT |y|
                         (PROG2
                             (LETT #1#
                                   (SPADCALL (|spadConstant| $ 40) |uts| 'T
                                             (QREFELT $ 100)))
                             (QCDR #1#)
                           (|check_union2| (QEQCAR #1# 0) $ (|Union| $ #2#)
                                           #1#)))
                   (EXIT
                    (SPADCALL
                     (SPADCALL (SPADCALL |cc| (QREFELT $ 143)) (QREFELT $ 27))
                     (SPADCALL
                      (SPADCALL |y| (SPADCALL |uts| (QREFELT $ 72))
                                (QREFELT $ 97))
                      (QREFELT $ 112))
                     (QREFELT $ 83)))))
                 ('T (|error| (STRCONC "log: " (QREFELT $ 124)))))))) 

(SDEFUN |ISUPS;sincos|
        ((|uts| ($)) ($ (|Record| (|:| |%sin| $) (|:| |%cos| $))))
        (SPROG ((|cc| (|Coef|)))
               (COND
                ((SPADCALL (LETT |cc| (SPADCALL |uts| 0 (QREFELT $ 57)))
                           (QREFELT $ 16))
                 (|ISUPS;iSincos| |uts| (|spadConstant| $ 30)
                  (|spadConstant| $ 41) -1 $))
                ((QREFELT $ 132)
                 (|ISUPS;iSincos| |uts| (SPADCALL |cc| (QREFELT $ 145))
                  (SPADCALL |cc| (QREFELT $ 146)) -1 $))
                ('T (|error| (STRCONC "sincos: " (QREFELT $ 124))))))) 

(SDEFUN |ISUPS;cSin;2$;71| ((|uts| ($)) ($ ($)))
        (QCAR (|ISUPS;sincos| |uts| $))) 

(SDEFUN |ISUPS;cCos;2$;72| ((|uts| ($)) ($ ($)))
        (QCDR (|ISUPS;sincos| |uts| $))) 

(SDEFUN |ISUPS;cTan;2$;73| ((|uts| ($)) ($ ($)))
        (SPROG ((|cc| (|Coef|)))
               (COND
                ((SPADCALL (LETT |cc| (SPADCALL |uts| 0 (QREFELT $ 57)))
                           (QREFELT $ 16))
                 (|ISUPS;iTan| |uts| (SPADCALL |uts| (QREFELT $ 72))
                  (|spadConstant| $ 30) 1 $))
                ((QREFELT $ 132)
                 (|ISUPS;iTan| |uts| (SPADCALL |uts| (QREFELT $ 72))
                  (SPADCALL |cc| (QREFELT $ 149)) 1 $))
                ('T (|error| (STRCONC "tan: " (QREFELT $ 124))))))) 

(SDEFUN |ISUPS;cCot;2$;74| ((|uts| ($)) ($ ($)))
        (SPROG ((|cc| (|Coef|)))
               (COND
                ((SPADCALL |uts| (QREFELT $ 65))
                 (|error| "cot: cot(0) is undefined"))
                ((SPADCALL (LETT |cc| (SPADCALL |uts| 0 (QREFELT $ 57)))
                           (QREFELT $ 16))
                 (|error| (|error| (STRCONC "cot: " (QREFELT $ 125)))))
                ((QREFELT $ 132)
                 (|ISUPS;iTan| |uts|
                  (SPADCALL (SPADCALL |uts| (QREFELT $ 72)) (QREFELT $ 86))
                  (SPADCALL |cc| (QREFELT $ 151)) 1 $))
                ('T (|error| (STRCONC "cot: " (QREFELT $ 124))))))) 

(SDEFUN |ISUPS;cSec;2$;75| ((|uts| ($)) ($ ($)))
        (SPROG ((#1=#:G1556 NIL) (|cosUts| ($)) (|cc| (|Coef|)))
               (SEQ
                (COND
                 ((SPADCALL (LETT |cc| (SPADCALL |uts| 0 (QREFELT $ 57)))
                            (QREFELT $ 16))
                  (PROG2
                      (LETT #1#
                            (SPADCALL (|spadConstant| $ 40)
                                      (SPADCALL |uts| (QREFELT $ 148)) 'T
                                      (QREFELT $ 100)))
                      (QCDR #1#)
                    (|check_union2| (QEQCAR #1# 0) $ (|Union| $ #2="failed")
                                    #1#)))
                 ((QREFELT $ 132)
                  (SEQ (LETT |cosUts| (SPADCALL |uts| (QREFELT $ 148)))
                       (EXIT
                        (COND
                         ((SPADCALL (SPADCALL |cosUts| 0 (QREFELT $ 57))
                                    (QREFELT $ 16))
                          (|error| (STRCONC "sec: " (QREFELT $ 125))))
                         (#3='T
                          (PROG2
                              (LETT #1#
                                    (SPADCALL (|spadConstant| $ 40) |cosUts| 'T
                                              (QREFELT $ 100)))
                              (QCDR #1#)
                            (|check_union2| (QEQCAR #1# 0) $ (|Union| $ #2#)
                                            #1#)))))))
                 (#3# (|error| (STRCONC "sec: " (QREFELT $ 124)))))))) 

(SDEFUN |ISUPS;cCsc;2$;76| ((|uts| ($)) ($ ($)))
        (SPROG ((#1=#:G1563 NIL) (|sinUts| ($)))
               (SEQ
                (COND
                 ((SPADCALL |uts| (QREFELT $ 65))
                  (|error| "csc: csc(0) is undefined"))
                 ((QREFELT $ 132)
                  (SEQ (LETT |sinUts| (SPADCALL |uts| (QREFELT $ 147)))
                       (EXIT
                        (COND
                         ((SPADCALL (SPADCALL |sinUts| 0 (QREFELT $ 57))
                                    (QREFELT $ 16))
                          (|error| (STRCONC "csc: " (QREFELT $ 125))))
                         (#2='T
                          (PROG2
                              (LETT #1#
                                    (SPADCALL (|spadConstant| $ 40) |sinUts| 'T
                                              (QREFELT $ 100)))
                              (QCDR #1#)
                            (|check_union2| (QEQCAR #1# 0) $
                                            (|Union| $ "failed") #1#)))))))
                 (#2# (|error| (STRCONC "csc: " (QREFELT $ 124)))))))) 

(SDEFUN |ISUPS;cAsin;2$;77| ((|uts| ($)) ($ ($)))
        (SPROG
         ((|c0| ($)) (#1=#:G1584 NIL) (|order| (|Integer|))
          (|ord| (|Union| (|Integer|) "failed")) (|x| ($)) (|cc| (|Coef|)))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL (LETT |cc| (SPADCALL |uts| 0 (QREFELT $ 57)))
                       (QREFELT $ 16))
             (SPADCALL
              (SPADCALL
               (SPADCALL
                (SPADCALL (|spadConstant| $ 40)
                          (SPADCALL |uts| |uts| (QREFELT $ 97)) (QREFELT $ 66))
                (SPADCALL (SPADCALL 1 2 (QREFELT $ 110)) (QREFELT $ 155))
                (QREFELT $ 140))
               (SPADCALL |uts| (QREFELT $ 72)) (QREFELT $ 97))
              (QREFELT $ 112)))
            ((QREFELT $ 132)
             (SEQ
              (LETT |x|
                    (SPADCALL (|spadConstant| $ 40)
                              (SPADCALL |uts| |uts| (QREFELT $ 97))
                              (QREFELT $ 66)))
              (COND
               ((OR (SPADCALL |cc| (|spadConstant| $ 41) (QREFELT $ 135))
                    (SPADCALL |cc|
                              (SPADCALL (|spadConstant| $ 41) (QREFELT $ 85))
                              (QREFELT $ 135)))
                (EXIT
                 (SEQ (LETT |ord| (|ISUPS;orderOrFailed| |x| $))
                      (EXIT
                       (COND
                        ((QEQCAR |ord| 1)
                         (|error| (STRCONC "asin: " (QREFELT $ 127))))
                        ((EQL (LETT |order| (QCDR |ord|)) -1)
                         (PROGN
                          (LETT #1#
                                (SPADCALL (SPADCALL |cc| (QREFELT $ 156))
                                          (QREFELT $ 27)))
                          (GO #2=#:G1583)))
                        ((ODDP |order|)
                         (|error| (STRCONC "asin: " (QREFELT $ 126))))
                        (#3='T
                         (SEQ
                          (LETT |c0|
                                (SPADCALL (SPADCALL |cc| (QREFELT $ 156))
                                          (QREFELT $ 27)))
                          (EXIT
                           (SPADCALL |c0|
                                     (SPADCALL
                                      (SPADCALL
                                       (SPADCALL |x|
                                                 (SPADCALL
                                                  (SPADCALL 1 2
                                                            (QREFELT $ 110))
                                                  (QREFELT $ 155))
                                                 (QREFELT $ 140))
                                       (SPADCALL |uts| (QREFELT $ 72))
                                       (QREFELT $ 97))
                                      (QREFELT $ 112))
                                     (QREFELT $ 83)))))))))))
              (LETT |c0|
                    (SPADCALL (SPADCALL |cc| (QREFELT $ 156)) (QREFELT $ 27)))
              (EXIT
               (SPADCALL |c0|
                         (SPADCALL
                          (SPADCALL
                           (SPADCALL |x|
                                     (SPADCALL (SPADCALL 1 2 (QREFELT $ 110))
                                               (QREFELT $ 155))
                                     (QREFELT $ 140))
                           (SPADCALL |uts| (QREFELT $ 72)) (QREFELT $ 97))
                          (QREFELT $ 112))
                         (QREFELT $ 83)))))
            (#3# (|error| (STRCONC "asin: " (QREFELT $ 124))))))
          #2# (EXIT #1#)))) 

(SDEFUN |ISUPS;cAcos;2$;78| ((|uts| ($)) ($ ($)))
        (SPROG
         ((|c0| ($)) (#1=#:G1601 NIL) (|order| (|Integer|))
          (|ord| (|Union| (|Integer|) "failed")) (|cc| (|Coef|)) (|x| ($)))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL |uts| (QREFELT $ 65))
             (COND
              ((QREFELT $ 132)
               (SPADCALL (SPADCALL (|spadConstant| $ 30) (QREFELT $ 158))
                         (QREFELT $ 27)))
              (#2='T (|error| (STRCONC "acos: " (QREFELT $ 124))))))
            ((QREFELT $ 132)
             (SEQ
              (LETT |x|
                    (SPADCALL (|spadConstant| $ 40)
                              (SPADCALL |uts| |uts| (QREFELT $ 97))
                              (QREFELT $ 66)))
              (LETT |cc| (SPADCALL |uts| 0 (QREFELT $ 57)))
              (COND
               ((OR (SPADCALL |cc| (|spadConstant| $ 41) (QREFELT $ 135))
                    (SPADCALL |cc|
                              (SPADCALL (|spadConstant| $ 41) (QREFELT $ 85))
                              (QREFELT $ 135)))
                (EXIT
                 (SEQ (LETT |ord| (|ISUPS;orderOrFailed| |x| $))
                      (EXIT
                       (COND
                        ((QEQCAR |ord| 1)
                         (|error| (STRCONC "acos: " (QREFELT $ 127))))
                        ((EQL (LETT |order| (QCDR |ord|)) -1)
                         (PROGN
                          (LETT #1#
                                (SPADCALL (SPADCALL |cc| (QREFELT $ 158))
                                          (QREFELT $ 27)))
                          (GO #3=#:G1600)))
                        ((ODDP |order|)
                         (|error| (STRCONC "acos: " (QREFELT $ 126))))
                        (#2#
                         (SEQ
                          (LETT |c0|
                                (SPADCALL (SPADCALL |cc| (QREFELT $ 158))
                                          (QREFELT $ 27)))
                          (EXIT
                           (SPADCALL |c0|
                                     (SPADCALL
                                      (SPADCALL
                                       (SPADCALL
                                        (SPADCALL |x|
                                                  (SPADCALL
                                                   (SPADCALL 1 2
                                                             (QREFELT $ 110))
                                                   (QREFELT $ 155))
                                                  (QREFELT $ 140))
                                        (SPADCALL |uts| (QREFELT $ 72))
                                        (QREFELT $ 97))
                                       (QREFELT $ 86))
                                      (QREFELT $ 112))
                                     (QREFELT $ 83)))))))))))
              (LETT |c0|
                    (SPADCALL (SPADCALL |cc| (QREFELT $ 158)) (QREFELT $ 27)))
              (EXIT
               (SPADCALL |c0|
                         (SPADCALL
                          (SPADCALL
                           (SPADCALL
                            (SPADCALL |x|
                                      (SPADCALL (SPADCALL 1 2 (QREFELT $ 110))
                                                (QREFELT $ 155))
                                      (QREFELT $ 140))
                            (SPADCALL |uts| (QREFELT $ 72)) (QREFELT $ 97))
                           (QREFELT $ 86))
                          (QREFELT $ 112))
                         (QREFELT $ 83)))))
            (#2# (|error| (STRCONC "acos: " (QREFELT $ 124))))))
          #3# (EXIT #1#)))) 

(SDEFUN |ISUPS;cAtan;2$;79| ((|uts| ($)) ($ ($)))
        (SPROG ((|y| (|Union| $ #1="failed")) (#2=#:G1604 NIL) (|cc| (|Coef|)))
               (SEQ
                (COND
                 ((SPADCALL (LETT |cc| (SPADCALL |uts| 0 (QREFELT $ 57)))
                            (QREFELT $ 16))
                  (SEQ
                   (LETT |y|
                         (PROG2
                             (LETT #2#
                                   (SPADCALL (|spadConstant| $ 40)
                                             (SPADCALL (|spadConstant| $ 40)
                                                       (SPADCALL |uts| |uts|
                                                                 (QREFELT $
                                                                          97))
                                                       (QREFELT $ 83))
                                             'T (QREFELT $ 100)))
                             (QCDR #2#)
                           (|check_union2| (QEQCAR #2# 0) $ (|Union| $ #1#)
                                           #2#)))
                   (EXIT
                    (SPADCALL
                     (SPADCALL |y| (SPADCALL |uts| (QREFELT $ 72))
                               (QREFELT $ 97))
                     (QREFELT $ 112)))))
                 ((QREFELT $ 132)
                  (SEQ
                   (LETT |y|
                         (SPADCALL (|spadConstant| $ 40)
                                   (SPADCALL (|spadConstant| $ 40)
                                             (SPADCALL |uts| |uts|
                                                       (QREFELT $ 97))
                                             (QREFELT $ 83))
                                   'T (QREFELT $ 100)))
                   (EXIT
                    (COND
                     ((QEQCAR |y| 1)
                      (|error| (STRCONC "atan: " (QREFELT $ 128))))
                     (#3='T
                      (SPADCALL
                       (SPADCALL (SPADCALL |cc| (QREFELT $ 160))
                                 (QREFELT $ 27))
                       (SPADCALL
                        (SPADCALL (QCDR |y|) (SPADCALL |uts| (QREFELT $ 72))
                                  (QREFELT $ 97))
                        (QREFELT $ 112))
                       (QREFELT $ 83)))))))
                 (#3# (|error| (STRCONC "atan: " (QREFELT $ 124)))))))) 

(SDEFUN |ISUPS;cAcot;2$;80| ((|uts| ($)) ($ ($)))
        (SPROG ((|cc| (|Coef|)) (|y| (|Union| $ "failed")))
               (SEQ
                (COND
                 ((QREFELT $ 132)
                  (SEQ
                   (LETT |y|
                         (SPADCALL (|spadConstant| $ 40)
                                   (SPADCALL (|spadConstant| $ 40)
                                             (SPADCALL |uts| |uts|
                                                       (QREFELT $ 97))
                                             (QREFELT $ 83))
                                   'T (QREFELT $ 100)))
                   (EXIT
                    (COND
                     ((QEQCAR |y| 1)
                      (|error| (STRCONC "acot: " (QREFELT $ 128))))
                     (#1='T
                      (SEQ (LETT |cc| (SPADCALL |uts| 0 (QREFELT $ 57)))
                           (EXIT
                            (SPADCALL
                             (SPADCALL (SPADCALL |cc| (QREFELT $ 162))
                                       (QREFELT $ 27))
                             (SPADCALL
                              (SPADCALL
                               (SPADCALL (QCDR |y|)
                                         (SPADCALL |uts| (QREFELT $ 72))
                                         (QREFELT $ 97))
                               (QREFELT $ 86))
                              (QREFELT $ 112))
                             (QREFELT $ 83)))))))))
                 (#1# (|error| (STRCONC "acot: " (QREFELT $ 124)))))))) 

(SDEFUN |ISUPS;cAsec;2$;81| ((|uts| ($)) ($ ($)))
        (SPROG
         ((|z| (|Union| $ "failed")) (|y| ($)) (#1=#:G1635 NIL)
          (|order| (|Integer|)) (|ord| (|Union| (|Integer|) "failed"))
          (|x| ($)) (|cc| (|Coef|)))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL (LETT |cc| (SPADCALL |uts| 0 (QREFELT $ 57)))
                       (QREFELT $ 16))
             (|error| "asec: constant coefficient should not be 0"))
            ((QREFELT $ 132)
             (SEQ
              (LETT |x|
                    (SPADCALL (SPADCALL |uts| |uts| (QREFELT $ 97))
                              (|spadConstant| $ 40) (QREFELT $ 66)))
              (LETT |y|
                    (COND
                     ((OR (SPADCALL |cc| (|spadConstant| $ 41) (QREFELT $ 135))
                          (SPADCALL |cc|
                                    (SPADCALL (|spadConstant| $ 41)
                                              (QREFELT $ 85))
                                    (QREFELT $ 135)))
                      (SEQ (LETT |ord| (|ISUPS;orderOrFailed| |x| $))
                           (EXIT
                            (COND
                             ((QEQCAR |ord| 1)
                              (|error| (STRCONC "asec: " (QREFELT $ 127))))
                             ((EQL (LETT |order| (QCDR |ord|)) -1)
                              (PROGN
                               (LETT #1#
                                     (SPADCALL (SPADCALL |cc| (QREFELT $ 164))
                                               (QREFELT $ 27)))
                               (GO #2=#:G1634)))
                             ((ODDP |order|)
                              (|error| (STRCONC "asec: " (QREFELT $ 126))))
                             (#3='T
                              (SPADCALL
                               (SPADCALL |x|
                                         (SPADCALL
                                          (SPADCALL 1 2 (QREFELT $ 110))
                                          (QREFELT $ 155))
                                         (QREFELT $ 140))
                               (SPADCALL |uts| (QREFELT $ 72))
                               (QREFELT $ 97)))))))
                     ('T
                      (SPADCALL
                       (SPADCALL |x|
                                 (SPADCALL (SPADCALL 1 2 (QREFELT $ 110))
                                           (QREFELT $ 155))
                                 (QREFELT $ 140))
                       (SPADCALL |uts| (QREFELT $ 72)) (QREFELT $ 97)))))
              (LETT |z| (SPADCALL |y| |uts| 'T (QREFELT $ 100)))
              (EXIT
               (COND
                ((QEQCAR |z| 1) (|error| (STRCONC "asec: " (QREFELT $ 130))))
                (#3#
                 (SPADCALL
                  (SPADCALL (SPADCALL |cc| (QREFELT $ 164)) (QREFELT $ 27))
                  (SPADCALL (QCDR |z|) (QREFELT $ 112)) (QREFELT $ 83)))))))
            (#3# (|error| (STRCONC "asec: " (QREFELT $ 124))))))
          #2# (EXIT #1#)))) 

(SDEFUN |ISUPS;cAcsc;2$;82| ((|uts| ($)) ($ ($)))
        (SPROG
         ((|z| (|Union| $ "failed")) (|y| ($)) (#1=#:G1654 NIL)
          (|order| (|Integer|)) (|ord| (|Union| (|Integer|) "failed"))
          (|x| ($)) (|cc| (|Coef|)))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL (LETT |cc| (SPADCALL |uts| 0 (QREFELT $ 57)))
                       (QREFELT $ 16))
             (|error| "acsc: constant coefficient should not be 0"))
            ((QREFELT $ 132)
             (SEQ
              (LETT |x|
                    (SPADCALL (SPADCALL |uts| |uts| (QREFELT $ 97))
                              (|spadConstant| $ 40) (QREFELT $ 66)))
              (LETT |y|
                    (COND
                     ((OR (SPADCALL |cc| (|spadConstant| $ 41) (QREFELT $ 135))
                          (SPADCALL |cc|
                                    (SPADCALL (|spadConstant| $ 41)
                                              (QREFELT $ 85))
                                    (QREFELT $ 135)))
                      (SEQ (LETT |ord| (|ISUPS;orderOrFailed| |x| $))
                           (EXIT
                            (COND
                             ((QEQCAR |ord| 1)
                              (|error| (STRCONC "acsc: " (QREFELT $ 127))))
                             ((EQL (LETT |order| (QCDR |ord|)) -1)
                              (PROGN
                               (LETT #1#
                                     (SPADCALL (SPADCALL |cc| (QREFELT $ 166))
                                               (QREFELT $ 27)))
                               (GO #2=#:G1653)))
                             ((ODDP |order|)
                              (|error| (STRCONC "acsc: " (QREFELT $ 126))))
                             (#3='T
                              (SPADCALL
                               (SPADCALL
                                (SPADCALL |x|
                                          (SPADCALL
                                           (SPADCALL 1 2 (QREFELT $ 110))
                                           (QREFELT $ 155))
                                          (QREFELT $ 140))
                                (SPADCALL |uts| (QREFELT $ 72)) (QREFELT $ 97))
                               (QREFELT $ 86)))))))
                     ('T
                      (SPADCALL
                       (SPADCALL
                        (SPADCALL |x|
                                  (SPADCALL (SPADCALL 1 2 (QREFELT $ 110))
                                            (QREFELT $ 155))
                                  (QREFELT $ 140))
                        (SPADCALL |uts| (QREFELT $ 72)) (QREFELT $ 97))
                       (QREFELT $ 86)))))
              (LETT |z| (SPADCALL |y| |uts| 'T (QREFELT $ 100)))
              (EXIT
               (COND
                ((QEQCAR |z| 1) (|error| (STRCONC "asec: " (QREFELT $ 130))))
                (#3#
                 (SPADCALL
                  (SPADCALL (SPADCALL |cc| (QREFELT $ 166)) (QREFELT $ 27))
                  (SPADCALL (QCDR |z|) (QREFELT $ 112)) (QREFELT $ 83)))))))
            (#3# (|error| (STRCONC "acsc: " (QREFELT $ 124))))))
          #2# (EXIT #1#)))) 

(SDEFUN |ISUPS;sinhcosh|
        ((|uts| ($)) ($ (|Record| (|:| |%sinh| $) (|:| |%cosh| $))))
        (SPROG
         ((|tmp| (|Record| (|:| |%sin| $) (|:| |%cos| $))) (|cc| (|Coef|)))
         (SEQ
          (COND
           ((SPADCALL (LETT |cc| (SPADCALL |uts| 0 (QREFELT $ 57)))
                      (QREFELT $ 16))
            (SEQ
             (LETT |tmp|
                   (|ISUPS;iSincos| |uts| (|spadConstant| $ 30)
                    (|spadConstant| $ 41) 1 $))
             (EXIT (CONS (QCAR |tmp|) (QCDR |tmp|)))))
           ((QREFELT $ 132)
            (SEQ
             (LETT |tmp|
                   (|ISUPS;iSincos| |uts| (SPADCALL |cc| (QREFELT $ 168))
                    (SPADCALL |cc| (QREFELT $ 169)) 1 $))
             (EXIT (CONS (QCAR |tmp|) (QCDR |tmp|)))))
           ('T (|error| (STRCONC "sinhcosh: " (QREFELT $ 124)))))))) 

(SDEFUN |ISUPS;cSinh;2$;84| ((|uts| ($)) ($ ($)))
        (QCAR (|ISUPS;sinhcosh| |uts| $))) 

(SDEFUN |ISUPS;cCosh;2$;85| ((|uts| ($)) ($ ($)))
        (QCDR (|ISUPS;sinhcosh| |uts| $))) 

(SDEFUN |ISUPS;cTanh;2$;86| ((|uts| ($)) ($ ($)))
        (SPROG ((|cc| (|Coef|)))
               (COND
                ((SPADCALL (LETT |cc| (SPADCALL |uts| 0 (QREFELT $ 57)))
                           (QREFELT $ 16))
                 (|ISUPS;iTan| |uts| (SPADCALL |uts| (QREFELT $ 72))
                  (|spadConstant| $ 30) -1 $))
                ((QREFELT $ 132)
                 (|ISUPS;iTan| |uts| (SPADCALL |uts| (QREFELT $ 72))
                  (SPADCALL |cc| (QREFELT $ 172)) -1 $))
                ('T (|error| (STRCONC "tanh: " (QREFELT $ 124))))))) 

(SDEFUN |ISUPS;cCoth;2$;87| ((|uts| ($)) ($ ($)))
        (SPROG ((#1=#:G1673 NIL) (|tanhUts| ($)))
               (SEQ (LETT |tanhUts| (SPADCALL |uts| (QREFELT $ 173)))
                    (EXIT
                     (COND
                      ((SPADCALL |tanhUts| (QREFELT $ 65))
                       (|error| "coth: coth(0) is undefined"))
                      ((SPADCALL (SPADCALL |tanhUts| 0 (QREFELT $ 57))
                                 (QREFELT $ 16))
                       (|error| (STRCONC "coth: " (QREFELT $ 125))))
                      ('T
                       (PROG2
                           (LETT #1#
                                 (SPADCALL (|spadConstant| $ 40) |tanhUts| 'T
                                           (QREFELT $ 100)))
                           (QCDR #1#)
                         (|check_union2| (QEQCAR #1# 0) $ (|Union| $ "failed")
                                         #1#)))))))) 

(SDEFUN |ISUPS;cSech;2$;88| ((|uts| ($)) ($ ($)))
        (SPROG ((#1=#:G1680 NIL) (|coshUts| ($)))
               (SEQ (LETT |coshUts| (SPADCALL |uts| (QREFELT $ 171)))
                    (EXIT
                     (COND
                      ((SPADCALL (SPADCALL |coshUts| 0 (QREFELT $ 57))
                                 (QREFELT $ 16))
                       (|error| (STRCONC "sech: " (QREFELT $ 125))))
                      ('T
                       (PROG2
                           (LETT #1#
                                 (SPADCALL (|spadConstant| $ 40) |coshUts| 'T
                                           (QREFELT $ 100)))
                           (QCDR #1#)
                         (|check_union2| (QEQCAR #1# 0) $ (|Union| $ "failed")
                                         #1#)))))))) 

(SDEFUN |ISUPS;cCsch;2$;89| ((|uts| ($)) ($ ($)))
        (SPROG ((#1=#:G1686 NIL) (|sinhUts| ($)))
               (SEQ (LETT |sinhUts| (SPADCALL |uts| (QREFELT $ 170)))
                    (EXIT
                     (COND
                      ((SPADCALL (SPADCALL |sinhUts| 0 (QREFELT $ 57))
                                 (QREFELT $ 16))
                       (|error| (STRCONC "csch: " (QREFELT $ 125))))
                      ('T
                       (PROG2
                           (LETT #1#
                                 (SPADCALL (|spadConstant| $ 40) |sinhUts| 'T
                                           (QREFELT $ 100)))
                           (QCDR #1#)
                         (|check_union2| (QEQCAR #1# 0) $ (|Union| $ "failed")
                                         #1#)))))))) 

(SDEFUN |ISUPS;cAsinh;2$;90| ((|uts| ($)) ($ ($)))
        (SPROG
         ((#1=#:G1699 NIL) (|order| (|Integer|))
          (|ord| (|Union| (|Integer|) "failed")) (|cc| (|Coef|)) (|x| ($)))
         (SEQ
          (EXIT
           (SEQ
            (LETT |x|
                  (SPADCALL (|spadConstant| $ 40)
                            (SPADCALL |uts| |uts| (QREFELT $ 97))
                            (QREFELT $ 83)))
            (EXIT
             (COND
              ((SPADCALL (LETT |cc| (SPADCALL |uts| 0 (QREFELT $ 57)))
                         (QREFELT $ 16))
               (SPADCALL
                (SPADCALL |uts|
                          (SPADCALL |x| (SPADCALL 1 2 (QREFELT $ 110))
                                    (QREFELT $ 140))
                          (QREFELT $ 83))
                (QREFELT $ 144)))
              ((QREFELT $ 132)
               (SEQ (LETT |ord| (|ISUPS;orderOrFailed| |x| $))
                    (EXIT
                     (COND
                      ((QEQCAR |ord| 1)
                       (|error| (STRCONC "asinh: " (QREFELT $ 127))))
                      ((EQL (LETT |order| (QCDR |ord|)) -1)
                       (PROGN
                        (LETT #1#
                              (SPADCALL (SPADCALL |cc| (QREFELT $ 177))
                                        (QREFELT $ 27)))
                        (GO #2=#:G1698)))
                      ((ODDP |order|)
                       (|error| (STRCONC "asinh: " (QREFELT $ 126))))
                      (#3='T
                       (SPADCALL
                        (SPADCALL |uts|
                                  (SPADCALL |x| (SPADCALL 1 2 (QREFELT $ 110))
                                            (QREFELT $ 140))
                                  (QREFELT $ 83))
                        (QREFELT $ 144)))))))
              (#3# (|error| (STRCONC "asinh: " (QREFELT $ 124))))))))
          #2# (EXIT #1#)))) 

(SDEFUN |ISUPS;cAcosh;2$;91| ((|uts| ($)) ($ ($)))
        (SPROG
         ((#1=#:G1714 NIL) (|order| (|Integer|))
          (|ord| (|Union| (|Integer|) "failed")) (|x| ($)) (|cc| (|Coef|)))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL |uts| (QREFELT $ 65))
             (COND
              ((QREFELT $ 132)
               (SPADCALL (SPADCALL (|spadConstant| $ 30) (QREFELT $ 179))
                         (QREFELT $ 27)))
              (#2='T (|error| (STRCONC "acosh: " (QREFELT $ 124))))))
            ((QREFELT $ 132)
             (SEQ (LETT |cc| (SPADCALL |uts| 0 (QREFELT $ 57)))
                  (LETT |x|
                        (SPADCALL (SPADCALL |uts| |uts| (QREFELT $ 97))
                                  (|spadConstant| $ 40) (QREFELT $ 66)))
                  (COND
                   ((OR (SPADCALL |cc| (|spadConstant| $ 41) (QREFELT $ 135))
                        (SPADCALL |cc|
                                  (SPADCALL (|spadConstant| $ 41)
                                            (QREFELT $ 85))
                                  (QREFELT $ 135)))
                    (EXIT
                     (SEQ (LETT |ord| (|ISUPS;orderOrFailed| |x| $))
                          (EXIT
                           (COND
                            ((QEQCAR |ord| 1)
                             (|error| (STRCONC "acosh: " (QREFELT $ 127))))
                            ((EQL (LETT |order| (QCDR |ord|)) -1)
                             (PROGN
                              (LETT #1#
                                    (SPADCALL (SPADCALL |cc| (QREFELT $ 179))
                                              (QREFELT $ 27)))
                              (GO #3=#:G1713)))
                            ((ODDP |order|)
                             (|error| (STRCONC "acosh: " (QREFELT $ 126))))
                            (#2#
                             (SPADCALL
                              (SPADCALL |uts|
                                        (SPADCALL |x|
                                                  (SPADCALL 1 2
                                                            (QREFELT $ 110))
                                                  (QREFELT $ 140))
                                        (QREFELT $ 83))
                              (QREFELT $ 144)))))))))
                  (EXIT
                   (SPADCALL
                    (SPADCALL |uts|
                              (SPADCALL |x| (SPADCALL 1 2 (QREFELT $ 110))
                                        (QREFELT $ 140))
                              (QREFELT $ 83))
                    (QREFELT $ 144)))))
            (#2# (|error| (STRCONC "acosh: " (QREFELT $ 124))))))
          #3# (EXIT #1#)))) 

(SDEFUN |ISUPS;cAtanh;2$;92| ((|uts| ($)) ($ ($)))
        (SPROG ((|cc| (|Coef|)) (|half| (|Coef|)))
               (SEQ
                (LETT |half|
                      (SPADCALL
                       (SPADCALL (SPADCALL 2 (QREFELT $ 113)) (QREFELT $ 114))
                       (QREFELT $ 139)))
                (EXIT
                 (COND
                  ((SPADCALL (LETT |cc| (SPADCALL |uts| 0 (QREFELT $ 57)))
                             (QREFELT $ 16))
                   (SPADCALL |half|
                             (SPADCALL
                              (SPADCALL
                               (SPADCALL (|spadConstant| $ 40) |uts|
                                         (QREFELT $ 83))
                               (QREFELT $ 144))
                              (SPADCALL
                               (SPADCALL (|spadConstant| $ 40) |uts|
                                         (QREFELT $ 66))
                               (QREFELT $ 144))
                              (QREFELT $ 66))
                             (QREFELT $ 115)))
                  ((QREFELT $ 132)
                   (COND
                    ((OR (SPADCALL |cc| (|spadConstant| $ 41) (QREFELT $ 135))
                         (SPADCALL |cc|
                                   (SPADCALL (|spadConstant| $ 41)
                                             (QREFELT $ 85))
                                   (QREFELT $ 135)))
                     (|error| (STRCONC "atanh: " (QREFELT $ 128))))
                    ('T
                     (SPADCALL |half|
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL (|spadConstant| $ 40) |uts|
                                           (QREFELT $ 83))
                                 (QREFELT $ 144))
                                (SPADCALL
                                 (SPADCALL (|spadConstant| $ 40) |uts|
                                           (QREFELT $ 66))
                                 (QREFELT $ 144))
                                (QREFELT $ 66))
                               (QREFELT $ 115)))))
                  ('T (|error| (STRCONC "atanh: " (QREFELT $ 124))))))))) 

(SDEFUN |ISUPS;cAcoth;2$;93| ((|uts| ($)) ($ ($)))
        (SPROG ((|half| (|Coef|)) (|cc| (|Coef|)))
               (SEQ
                (COND
                 ((SPADCALL |uts| (QREFELT $ 65))
                  (COND
                   ((QREFELT $ 132)
                    (SPADCALL (SPADCALL (|spadConstant| $ 30) (QREFELT $ 182))
                              (QREFELT $ 27)))
                   (#1='T (|error| (STRCONC "acoth: " (QREFELT $ 124))))))
                 ((QREFELT $ 132)
                  (SEQ (LETT |cc| (SPADCALL |uts| 0 (QREFELT $ 57)))
                       (LETT |half|
                             (SPADCALL
                              (SPADCALL (SPADCALL 2 (QREFELT $ 113))
                                        (QREFELT $ 114))
                              (QREFELT $ 139)))
                       (COND
                        ((OR
                          (SPADCALL |cc| (|spadConstant| $ 41) (QREFELT $ 135))
                          (SPADCALL |cc|
                                    (SPADCALL (|spadConstant| $ 41)
                                              (QREFELT $ 85))
                                    (QREFELT $ 135)))
                         (EXIT (|error| (STRCONC "acoth: " (QREFELT $ 128))))))
                       (EXIT
                        (SPADCALL |half|
                                  (SPADCALL
                                   (SPADCALL
                                    (SPADCALL |uts| (|spadConstant| $ 40)
                                              (QREFELT $ 83))
                                    (QREFELT $ 144))
                                   (SPADCALL
                                    (SPADCALL |uts| (|spadConstant| $ 40)
                                              (QREFELT $ 66))
                                    (QREFELT $ 144))
                                   (QREFELT $ 66))
                                  (QREFELT $ 115)))))
                 (#1# (|error| (STRCONC "acoth: " (QREFELT $ 124)))))))) 

(SDEFUN |ISUPS;cAsech;2$;94| ((|uts| ($)) ($ ($)))
        (SPROG
         ((|utsInv| (|Union| $ "failed")) (#1=#:G1745 NIL)
          (|order| (|Integer|)) (|ord| (|Union| (|Integer|) "failed"))
          (|x| ($)) (|cc| (|Coef|)))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL |uts| (QREFELT $ 65))
             (|error| "asech: asech(0) is undefined"))
            ((QREFELT $ 132)
             (COND
              ((SPADCALL (LETT |cc| (SPADCALL |uts| 0 (QREFELT $ 57)))
                         (QREFELT $ 16))
               (|error| (STRCONC "asech: " (QREFELT $ 129))))
              (#2='T
               (SEQ
                (LETT |x|
                      (SPADCALL (|spadConstant| $ 40)
                                (SPADCALL |uts| |uts| (QREFELT $ 97))
                                (QREFELT $ 66)))
                (COND
                 ((OR (SPADCALL |cc| (|spadConstant| $ 41) (QREFELT $ 135))
                      (SPADCALL |cc|
                                (SPADCALL (|spadConstant| $ 41) (QREFELT $ 85))
                                (QREFELT $ 135)))
                  (EXIT
                   (SEQ (LETT |ord| (|ISUPS;orderOrFailed| |x| $))
                        (EXIT
                         (COND
                          ((QEQCAR |ord| 1)
                           (|error| (STRCONC "asech: " (QREFELT $ 127))))
                          ((EQL (LETT |order| (QCDR |ord|)) -1)
                           (PROGN
                            (LETT #1#
                                  (SPADCALL (SPADCALL |cc| (QREFELT $ 184))
                                            (QREFELT $ 27)))
                            (GO #3=#:G1744)))
                          ((ODDP |order|)
                           (|error| (STRCONC "asech: " (QREFELT $ 126))))
                          (#2#
                           (SEQ
                            (LETT |utsInv|
                                  (SPADCALL (|spadConstant| $ 40) |uts| 'T
                                            (QREFELT $ 100)))
                            (EXIT
                             (COND
                              ((QEQCAR |utsInv| 1)
                               (|error| (STRCONC "asech: " (QREFELT $ 130))))
                              (#2#
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL (|spadConstant| $ 40)
                                           (SPADCALL |x|
                                                     (SPADCALL 1 2
                                                               (QREFELT $ 110))
                                                     (QREFELT $ 140))
                                           (QREFELT $ 83))
                                 (QCDR |utsInv|) (QREFELT $ 97))
                                (QREFELT $ 144)))))))))))))
                (LETT |utsInv|
                      (SPADCALL (|spadConstant| $ 40) |uts| 'T
                                (QREFELT $ 100)))
                (EXIT
                 (COND
                  ((QEQCAR |utsInv| 1)
                   (|error| (STRCONC "asech: " (QREFELT $ 130))))
                  (#2#
                   (SPADCALL
                    (SPADCALL
                     (SPADCALL (|spadConstant| $ 40)
                               (SPADCALL |x| (SPADCALL 1 2 (QREFELT $ 110))
                                         (QREFELT $ 140))
                               (QREFELT $ 83))
                     (QCDR |utsInv|) (QREFELT $ 97))
                    (QREFELT $ 144)))))))))
            (#2# (|error| (STRCONC "asech: " (QREFELT $ 124))))))
          #3# (EXIT #1#)))) 

(SDEFUN |ISUPS;cAcsch;2$;95| ((|uts| ($)) ($ ($)))
        (SPROG
         ((|utsInv| (|Union| $ "failed")) (#1=#:G1760 NIL)
          (|order| (|Integer|)) (|ord| (|Union| (|Integer|) "failed"))
          (|x| ($)) (|cc| (|Coef|)))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL |uts| (QREFELT $ 65))
             (|error| "acsch: acsch(0) is undefined"))
            ((QREFELT $ 132)
             (COND
              ((SPADCALL (LETT |cc| (SPADCALL |uts| 0 (QREFELT $ 57)))
                         (QREFELT $ 16))
               (|error| (STRCONC "acsch: " (QREFELT $ 129))))
              (#2='T
               (SEQ
                (LETT |x|
                      (SPADCALL (SPADCALL |uts| |uts| (QREFELT $ 97))
                                (|spadConstant| $ 40) (QREFELT $ 83)))
                (LETT |ord| (|ISUPS;orderOrFailed| |x| $))
                (EXIT
                 (COND
                  ((QEQCAR |ord| 1)
                   (|error| (STRCONC "acsc: " (QREFELT $ 127))))
                  ((EQL (LETT |order| (QCDR |ord|)) -1)
                   (PROGN
                    (LETT #1#
                          (SPADCALL (SPADCALL |cc| (QREFELT $ 186))
                                    (QREFELT $ 27)))
                    (GO #3=#:G1759)))
                  ((ODDP |order|)
                   (|error| (STRCONC "acsch: " (QREFELT $ 126))))
                  (#2#
                   (SEQ
                    (LETT |utsInv|
                          (SPADCALL (|spadConstant| $ 40) |uts| 'T
                                    (QREFELT $ 100)))
                    (EXIT
                     (COND
                      ((QEQCAR |utsInv| 1)
                       (|error| (STRCONC "acsch: " (QREFELT $ 130))))
                      (#2#
                       (SPADCALL
                        (SPADCALL
                         (SPADCALL (|spadConstant| $ 40)
                                   (SPADCALL |x| (SPADCALL 1 2 (QREFELT $ 110))
                                             (QREFELT $ 140))
                                   (QREFELT $ 83))
                         (QCDR |utsInv|) (QREFELT $ 97))
                        (QREFELT $ 144)))))))))))))
            (#2# (|error| (STRCONC "acsch: " (QREFELT $ 124))))))
          #3# (EXIT #1#)))) 

(PUT '|ISUPS;factorials?| '|SPADreplace| '(XLAM NIL NIL)) 

(SDEFUN |ISUPS;factorials?| (($ (|Boolean|))) NIL) 

(SDEFUN |ISUPS;termOutput|
        ((|k| (|Fraction| (|Integer|))) (|c| (|Coef|)) (|vv| (|OutputForm|))
         ($ (|OutputForm|)))
        (SPROG ((|mon| (|OutputForm|)))
               (SEQ
                (COND
                 ((SPADCALL |k| (|spadConstant| $ 188) (QREFELT $ 189))
                  (SPADCALL |c| (QREFELT $ 191)))
                 (#1='T
                  (SEQ
                   (LETT |mon|
                         (COND
                          ((SPADCALL |k| (|spadConstant| $ 192)
                                     (QREFELT $ 189))
                           |vv|)
                          (#1#
                           (SPADCALL |vv| (SPADCALL |k| (QREFELT $ 193))
                                     (QREFELT $ 194)))))
                   (EXIT
                    (COND
                     ((SPADCALL |c| (|spadConstant| $ 41) (QREFELT $ 135))
                      |mon|)
                     ((SPADCALL |c|
                                (SPADCALL (|spadConstant| $ 41) (QREFELT $ 85))
                                (QREFELT $ 135))
                      (SPADCALL |mon| (QREFELT $ 195)))
                     (#1#
                      (SPADCALL (SPADCALL |c| (QREFELT $ 191)) |mon|
                                (QREFELT $ 196))))))))))) 

(PUT '|ISUPS;showAll?| '|SPADreplace| '(XLAM NIL 'T)) 

(SDEFUN |ISUPS;showAll?| (($ (|Boolean|))) 'T) 

(SDEFUN |ISUPS;seriesToOutputForm;SRSCoefFOf;99|
        ((|st| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
         (|refer| (|Reference| (|OrderedCompletion| (|Integer|))))
         (|var| (|Symbol|)) (|cen| (|Coef|)) (|r| (|Fraction| (|Integer|)))
         ($ (|OutputForm|)))
        (SPROG
         ((|l| (|List| (|OutputForm|))) (|deg| (|Union| (|Integer|) "failed"))
          (|term| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))
          (|vv| (|OutputForm|)))
         (SEQ
          (LETT |vv|
                (COND
                 ((SPADCALL |cen| (QREFELT $ 16))
                  (SPADCALL |var| (QREFELT $ 198)))
                 (#1='T
                  (SPADCALL
                   (SPADCALL (SPADCALL |var| (QREFELT $ 198))
                             (SPADCALL |cen| (QREFELT $ 191)) (QREFELT $ 199))
                   (QREFELT $ 200)))))
          (LETT |l| NIL)
          (SEQ G190 (COND ((NULL (SPADCALL |st| (QREFELT $ 45))) (GO G191)))
               (SEQ (LETT |term| (SPADCALL |st| (QREFELT $ 32)))
                    (LETT |l|
                          (CONS
                           (|ISUPS;termOutput|
                            (SPADCALL (|ISUPS;getExpon| |term| $) |r|
                                      (QREFELT $ 201))
                            (|ISUPS;getCoef| |term| $) |vv| $)
                           |l|))
                    (EXIT (LETT |st| (SPADCALL |st| (QREFELT $ 24)))))
               NIL (GO G190) G191 (EXIT NIL))
          (LETT |l|
                (COND ((SPADCALL |st| (QREFELT $ 44)) |l|)
                      (#1#
                       (SEQ
                        (LETT |deg|
                              (SPADCALL (SPADCALL |refer| (QREFELT $ 42))
                                        (QREFELT $ 203)))
                        (EXIT
                         (COND
                          ((QEQCAR |deg| 0)
                           (CONS
                            (SPADCALL (SPADCALL 'O (QREFELT $ 198))
                                      (LIST
                                       (SPADCALL |vv|
                                                 (SPADCALL
                                                  (SPADCALL (+ (QCDR |deg|) 1)
                                                            |r|
                                                            (QREFELT $ 201))
                                                  (QREFELT $ 193))
                                                 (QREFELT $ 194)))
                                      (QREFELT $ 205))
                            |l|))
                          (#1# |l|)))))))
          (EXIT
           (COND ((NULL |l|) (SPADCALL (|spadConstant| $ 30) (QREFELT $ 191)))
                 (#1#
                  (SPADCALL (ELT $ 206) (NREVERSE |l|) (QREFELT $ 209)))))))) 

(DECLAIM (NOTINLINE |InnerSparseUnivariatePowerSeries;|)) 

(DEFUN |InnerSparseUnivariatePowerSeries| (#1=#:G1796)
  (SPROG NIL
         (PROG (#2=#:G1797)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|InnerSparseUnivariatePowerSeries|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|InnerSparseUnivariatePowerSeries;| #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|InnerSparseUnivariatePowerSeries|)))))))))) 

(DEFUN |InnerSparseUnivariatePowerSeries;| (|#1|)
  (SPROG
   ((|pv$| NIL) (#1=#:G1790 NIL) (#2=#:G1791 NIL) (#3=#:G1792 NIL)
    (#4=#:G1795 NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT |dv$| (LIST '|InnerSparseUnivariatePowerSeries| DV$1))
    (LETT $ (GETREFV 218))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#1|
                                                       '(|Algebra|
                                                         (|Fraction|
                                                          (|Integer|))))
                                        (|HasCategory| |#1|
                                                       '(|IntegralDomain|))
                                        (|HasCategory| |#1|
                                                       '(|CharacteristicNonZero|))
                                        (|HasCategory| |#1|
                                                       '(|CharacteristicZero|))
                                        (LETT #4#
                                              (|HasCategory| |#1|
                                                             '(|CommutativeRing|)))
                                        (OR #4#
                                            (|HasCategory| |#1|
                                                           '(|IntegralDomain|)))
                                        (|HasSignature| |#1|
                                                        (LIST '*
                                                              (LIST
                                                               (|devaluate|
                                                                |#1|)
                                                               '(|Integer|)
                                                               (|devaluate|
                                                                |#1|))))
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|PartialDifferentialRing|
                                                          (|Symbol|)))
                                         (|HasSignature| |#1|
                                                         (LIST '*
                                                               (LIST
                                                                (|devaluate|
                                                                 |#1|)
                                                                '(|Integer|)
                                                                (|devaluate|
                                                                 |#1|)))))
                                        (|HasCategory| (|Integer|)
                                                       '(|SemiGroup|))
                                        (|HasCategory| (|Integer|)
                                                       '(|Comparable|))
                                        (|HasCategory| |#1| '(|Field|))
                                        (|HasSignature| |#1|
                                                        (LIST '^
                                                              (LIST
                                                               (|devaluate|
                                                                |#1|)
                                                               (|devaluate|
                                                                |#1|)
                                                               '(|Integer|))))
                                        (AND
                                         (|HasSignature| |#1|
                                                         (LIST '^
                                                               (LIST
                                                                (|devaluate|
                                                                 |#1|)
                                                                (|devaluate|
                                                                 |#1|)
                                                                '(|Integer|))))
                                         (|HasSignature| |#1|
                                                         (LIST '|coerce|
                                                               (LIST
                                                                (|devaluate|
                                                                 |#1|)
                                                                '(|Symbol|)))))
                                        (LETT #3#
                                              (|HasCategory| |#1|
                                                             '(|SemiRing|)))
                                        (OR #3#
                                            (|HasSignature| |#1|
                                                            (LIST '*
                                                                  (LIST
                                                                   (|devaluate|
                                                                    |#1|)
                                                                   '(|Integer|)
                                                                   (|devaluate|
                                                                    |#1|)))))
                                        (LETT #2#
                                              (|HasCategory| |#1| '(|Ring|)))
                                        (OR #2#
                                            (|HasSignature| |#1|
                                                            (LIST '*
                                                                  (LIST
                                                                   (|devaluate|
                                                                    |#1|)
                                                                   '(|Integer|)
                                                                   (|devaluate|
                                                                    |#1|)))))
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|Algebra|
                                                          (|Fraction|
                                                           (|Integer|))))
                                         (|HasCategory| |#1|
                                                        '(|CharacteristicNonZero|))
                                         (|HasCategory| |#1|
                                                        '(|CharacteristicZero|))
                                         #4#
                                         (|HasCategory| |#1|
                                                        '(|IntegralDomain|))
                                         #2#
                                         (|HasSignature| |#1|
                                                         (LIST '*
                                                               (LIST
                                                                (|devaluate|
                                                                 |#1|)
                                                                '(|Integer|)
                                                                (|devaluate|
                                                                 |#1|)))))
                                        (|HasCategory| |#1| '(|AbelianMonoid|))
                                        (|HasCategory| |#1|
                                                       '(|CancellationAbelianMonoid|))
                                        (LETT #1#
                                              (|HasCategory| |#1|
                                                             '(|AbelianGroup|)))
                                        (OR
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|Algebra|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          (|HasCategory|
                                           (|Fraction| (|Integer|))
                                           '(|AbelianMonoid|)))
                                         #1#
                                         (|HasCategory| |#1|
                                                        '(|AbelianMonoid|))
                                         (|HasCategory| |#1|
                                                        '(|CancellationAbelianMonoid|))
                                         (|HasSignature| |#1|
                                                         (LIST '*
                                                               (LIST
                                                                (|devaluate|
                                                                 |#1|)
                                                                '(|Integer|)
                                                                (|devaluate|
                                                                 |#1|)))))
                                        (OR #1#
                                            (|HasCategory| |#1|
                                                           '(|CancellationAbelianMonoid|))
                                            (|HasSignature| |#1|
                                                            (LIST '*
                                                                  (LIST
                                                                   (|devaluate|
                                                                    |#1|)
                                                                   '(|Integer|)
                                                                   (|devaluate|
                                                                    |#1|)))))
                                        (OR #1#
                                            (|HasSignature| |#1|
                                                            (LIST '*
                                                                  (LIST
                                                                   (|devaluate|
                                                                    |#1|)
                                                                   '(|Integer|)
                                                                   (|devaluate|
                                                                    |#1|)))))))))
    (|haddProp| |$ConstructorCache| '|InnerSparseUnivariatePowerSeries|
                (LIST DV$1) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (AND (|HasCategory| |#1| '(|IntegralDomain|))
         (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))
         (|augmentPredVector| $ 16777216))
    (AND #4# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))
         (|augmentPredVector| $ 33554432))
    (AND
     (OR (AND #4# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND (|HasCategory| |#1| '(|IntegralDomain|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))))
     (|augmentPredVector| $ 67108864))
    (AND
     (OR (AND #4# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND (|HasCategory| |#1| '(|IntegralDomain|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         #3#
         (|HasSignature| |#1|
                         (LIST '*
                               (LIST (|devaluate| |#1|) '(|Integer|)
                                     (|devaluate| |#1|)))))
     (|augmentPredVector| $ 134217728))
    (AND
     (OR (AND #4# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND (|HasCategory| |#1| '(|IntegralDomain|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         #2#
         (|HasSignature| |#1|
                         (LIST '*
                               (LIST (|devaluate| |#1|) '(|Integer|)
                                     (|devaluate| |#1|)))))
     (|augmentPredVector| $ 268435456))
    (AND
     (OR (|HasCategory| |#1| '(|AbelianMonoid|))
         (AND #4# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND (|HasCategory| |#1| '(|IntegralDomain|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| $ '(|AbelianMonoid|))
         (|HasSignature| |#1|
                         (LIST '*
                               (LIST (|devaluate| |#1|) '(|Integer|)
                                     (|devaluate| |#1|)))))
     (|augmentPredVector| $ 536870912))
    (AND
     (OR (|HasCategory| |#1| '(|CancellationAbelianMonoid|))
         (AND #4# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND (|HasCategory| |#1| '(|IntegralDomain|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| $ '(|AbelianGroup|))
         (|HasSignature| |#1|
                         (LIST '*
                               (LIST (|devaluate| |#1|) '(|Integer|)
                                     (|devaluate| |#1|)))))
     (|augmentPredVector| $ 1073741824))
    (AND
     (OR #1# (AND #4# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND (|HasCategory| |#1| '(|IntegralDomain|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| $ '(|AbelianGroup|))
         (|HasSignature| |#1|
                         (LIST '*
                               (LIST (|devaluate| |#1|) '(|Integer|)
                                     (|devaluate| |#1|)))))
     (|augmentPredVector| $ 2147483648))
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 7
              (|Record|
               (|:| |%ord| (|Reference| (|OrderedCompletion| (|Integer|))))
               (|:| |%str|
                    (|Stream|
                     (|Record| (|:| |k| (|Integer|)) (|:| |c| |#1|))))))
    (COND
     ((|testBitVector| |pv$| 1)
      (PROGN
       (QSETREFV $ 112 (CONS (|dispatchFunction| |ISUPS;integrate;2$;56|) $))
       NIL
       NIL
       NIL
       (QSETREFV $ 119 (CONS (|dispatchFunction| |ISUPS;cPower;$Coef$;60|) $))
       NIL
       NIL
       NIL
       NIL
       NIL
       (QSETREFV $ 124 "series expansion involves transcendental constants")
       (QSETREFV $ 125 "series expansion has terms of negative degree")
       (QSETREFV $ 126 "series expansion has terms of fractional degree")
       (QSETREFV $ 127 "series expansion may have terms of fractional degree")
       (QSETREFV $ 128 "series expansion has logarithmic term")
       (QSETREFV $ 129
                 "series expansion has terms of negative degree or logarithmic term")
       (QSETREFV $ 130 "leading coefficient not invertible")
       NIL
       (QSETREFV $ 131
                 (|HasSignature| |#1|
                                 (LIST '^
                                       (LIST (|devaluate| |#1|)
                                             (|devaluate| |#1|)
                                             '(|Fraction| (|Integer|))))))
       (QSETREFV $ 132
                 (|HasCategory| |#1| '(|TranscendentalFunctionCategory|)))
       (QSETREFV $ 140
                 (CONS (|dispatchFunction| |ISUPS;cRationalPower;$F$;67|) $))
       (QSETREFV $ 142 (CONS (|dispatchFunction| |ISUPS;cExp;2$;68|) $))
       (QSETREFV $ 144 (CONS (|dispatchFunction| |ISUPS;cLog;2$;69|) $))
       NIL
       (QSETREFV $ 147 (CONS (|dispatchFunction| |ISUPS;cSin;2$;71|) $))
       (QSETREFV $ 148 (CONS (|dispatchFunction| |ISUPS;cCos;2$;72|) $))
       (QSETREFV $ 150 (CONS (|dispatchFunction| |ISUPS;cTan;2$;73|) $))
       (QSETREFV $ 152 (CONS (|dispatchFunction| |ISUPS;cCot;2$;74|) $))
       (QSETREFV $ 153 (CONS (|dispatchFunction| |ISUPS;cSec;2$;75|) $))
       (QSETREFV $ 154 (CONS (|dispatchFunction| |ISUPS;cCsc;2$;76|) $))
       (QSETREFV $ 157 (CONS (|dispatchFunction| |ISUPS;cAsin;2$;77|) $))
       (QSETREFV $ 159 (CONS (|dispatchFunction| |ISUPS;cAcos;2$;78|) $))
       (QSETREFV $ 161 (CONS (|dispatchFunction| |ISUPS;cAtan;2$;79|) $))
       (QSETREFV $ 163 (CONS (|dispatchFunction| |ISUPS;cAcot;2$;80|) $))
       (QSETREFV $ 165 (CONS (|dispatchFunction| |ISUPS;cAsec;2$;81|) $))
       (QSETREFV $ 167 (CONS (|dispatchFunction| |ISUPS;cAcsc;2$;82|) $))
       NIL
       (QSETREFV $ 170 (CONS (|dispatchFunction| |ISUPS;cSinh;2$;84|) $))
       (QSETREFV $ 171 (CONS (|dispatchFunction| |ISUPS;cCosh;2$;85|) $))
       (QSETREFV $ 173 (CONS (|dispatchFunction| |ISUPS;cTanh;2$;86|) $))
       (QSETREFV $ 174 (CONS (|dispatchFunction| |ISUPS;cCoth;2$;87|) $))
       (QSETREFV $ 175 (CONS (|dispatchFunction| |ISUPS;cSech;2$;88|) $))
       (QSETREFV $ 176 (CONS (|dispatchFunction| |ISUPS;cCsch;2$;89|) $))
       (QSETREFV $ 178 (CONS (|dispatchFunction| |ISUPS;cAsinh;2$;90|) $))
       (QSETREFV $ 180 (CONS (|dispatchFunction| |ISUPS;cAcosh;2$;91|) $))
       (QSETREFV $ 181 (CONS (|dispatchFunction| |ISUPS;cAtanh;2$;92|) $))
       (QSETREFV $ 183 (CONS (|dispatchFunction| |ISUPS;cAcoth;2$;93|) $))
       (QSETREFV $ 185 (CONS (|dispatchFunction| |ISUPS;cAsech;2$;94|) $))
       (QSETREFV $ 187 (CONS (|dispatchFunction| |ISUPS;cAcsch;2$;95|) $)))))
    $))) 

(MAKEPROP '|InnerSparseUnivariatePowerSeries| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep| (|Reference| 18)
              (|Record| (|:| |k| 21) (|:| |c| 6)) (|Stream| 9)
              |ISUPS;makeSeries;RS$;4| |ISUPS;getRef;$R;5|
              |ISUPS;getStream;$S;6| (0 . |empty|) (|Boolean|) (4 . |zero?|)
              (9 . |concat|) (|OrderedCompletion| 21) (15 . |plusInfinity|)
              (19 . |ref|) (|Integer|) |ISUPS;monomial;CoefI$;7|
              (24 . |empty?|) (29 . |rst|) |ISUPS;monomial?;$B;8|
              (34 . |coerce|) |ISUPS;coerce;Coef$;10| |ISUPS;coerce;I$;9|
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |ISUPS;Zero;$;14|) $))
              (39 . |Zero|) (43 . |setelt!|) (49 . |frst|) (54 . |coerce|)
              (|Mapping| $) (59 . |delay|) |ISUPS;series;S$;12|
              (|NonNegativeInteger|) (64 . |characteristic|)
              |ISUPS;characteristic;Nni;13|
              (CONS IDENTITY (FUNCALL (|dispatchFunction| |ISUPS;One;$;15|) $))
              (68 . |One|) (72 . |elt|) (77 . <) (83 . |explicitlyEmpty?|)
              (88 . |explicitEntries?|) (93 . |lazyEvaluate|)
              |ISUPS;extend;$I$;17| |ISUPS;complete;2$;18| (98 . >) (104 . >=)
              (110 . |One|) (114 . +) (120 . |retract|) (125 . |minusInfinity|)
              |ISUPS;truncate;$I$;21| |ISUPS;truncate;$2I$;22|
              |ISUPS;coefficient;$ICoef;24| |ISUPS;elt;$ICoef;25|
              (129 . |finite?|) |ISUPS;order;$I;27| |ISUPS;order;$2I;28|
              |ISUPS;terms;$S;29| (|SingleInteger|) (134 . |whatInfinity|)
              |ISUPS;zero?;$B;30| |ISUPS;-;3$;41| |ISUPS;=;2$B;31|
              (|Mapping| 6 6) |ISUPS;map;M2$;34| (139 . *) (145 . -)
              |ISUPS;differentiate;2$;35| (151 . *) (|Mapping| 6 21)
              |ISUPS;multiplyCoefficients;M2$;36| (|PositiveInteger|) (157 . *)
              |ISUPS;multiplyExponents;$Pi$;37| (163 . =) (169 . <)
              (175 . |min|) (181 . +) |ISUPS;+;3$;40| (187 . -) (193 . -)
              |ISUPS;-;2$;42| |ISUPS;*;I2$;43| (198 . *) |ISUPS;*;Nni2$;44|
              (204 . *) |ISUPS;*;Pi2$;45| (|Void|) (210 . |void|) (214 . +)
              (220 . |lazy?|) (225 . |One|) |ISUPS;*;3$;49|
              (|Union| $ '"failed") (229 . |recip|) |ISUPS;iExquo;2$BU;52|
              |ISUPS;taylorQuoByVar;2$;53| (234 . |Zero|) (238 . ~=) (244 . *)
              (250 . |zero?|) (255 . ^) (261 . |Zero|) |ISUPS;iCompose;3$;55|
              (|Fraction| 21) (265 . /) (271 . *) (277 . |integrate|)
              (282 . |coerce|) (287 . |inv|) (292 . *) (|Mapping| 10 10)
              (|ParadoxicalCombinatorsForStreams| 9) (298 . Y) (303 . |cPower|)
              (|List| 10) (309 . |second|) (|Mapping| 120 120) (314 . Y)
              'TRCONST 'NPOWERS 'FPOWERS 'MAYFPOW 'LOGS 'NPOWLOG 'NOTINV
              'RATPOWERS 'TRANSFCN (320 . |denom|) (325 . |exquo|) (331 . =)
              (337 . |numer|) (342 . ^) (348 . ^) (354 . |coerce|)
              (359 . |cRationalPower|) (365 . |exp|) (370 . |cExp|)
              (375 . |log|) (380 . |cLog|) (385 . |sin|) (390 . |cos|)
              (395 . |cSin|) (400 . |cCos|) (405 . |tan|) (410 . |cTan|)
              (415 . |cot|) (420 . |cCot|) (425 . |cSec|) (430 . |cCsc|)
              (435 . -) (440 . |asin|) (445 . |cAsin|) (450 . |acos|)
              (455 . |cAcos|) (460 . |atan|) (465 . |cAtan|) (470 . |acot|)
              (475 . |cAcot|) (480 . |asec|) (485 . |cAsec|) (490 . |acsc|)
              (495 . |cAcsc|) (500 . |sinh|) (505 . |cosh|) (510 . |cSinh|)
              (515 . |cCosh|) (520 . |tanh|) (525 . |cTanh|) (530 . |cCoth|)
              (535 . |cSech|) (540 . |cCsch|) (545 . |asinh|) (550 . |cAsinh|)
              (555 . |acosh|) (560 . |cAcosh|) (565 . |cAtanh|) (570 . |acoth|)
              (575 . |cAcoth|) (580 . |asech|) (585 . |cAsech|) (590 . |acsch|)
              (595 . |cAcsch|) (600 . |Zero|) (604 . =) (|OutputForm|)
              (610 . |coerce|) (615 . |One|) (619 . |coerce|) (624 . ^)
              (630 . -) (635 . *) (|Symbol|) (641 . |coerce|) (646 . -)
              (652 . |paren|) (657 . *) (|Union| 21 '"failed")
              (663 . |retractIfCan|) (|List| $) (668 . |prefix|) (674 . +)
              (|Mapping| 190 190 190) (|List| 190) (680 . |reduce|)
              |ISUPS;seriesToOutputForm;SRSCoefFOf;99|
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|List| 197) (|List| 37) (|List| 9) (|Stream| 6) (|HashState|)
              (|String|))
           '#(~= 686 |zero?| 692 |variable| 697 |unitNormal| 702
              |unitCanonical| 707 |unit?| 712 |truncate| 717 |terms| 730
              |taylorQuoByVar| 735 |subtractIfCan| 740 |seriesToOutputForm| 746
              |series| 755 |sample| 760 |rightRecip| 764 |rightPower| 769
              |reductum| 781 |recip| 786 |pole?| 791 |order| 796 |opposite?|
              807 |one?| 813 |multiplyExponents| 818 |multiplyCoefficients| 824
              |monomial?| 830 |monomial| 835 |map| 841 |makeSeries| 847
              |leftRecip| 853 |leftPower| 858 |leadingTerm| 870
              |leadingSupport| 875 |leadingMonomial| 880 |leadingCoefficient|
              885 |latex| 890 |integrate| 895 |iExquo| 900 |iCompose| 907
              |hashUpdate!| 913 |hash| 919 |getStream| 924 |getRef| 929
              |extend| 934 |exquo| 940 |eval| 946 |elt| 952 |differentiate| 964
              |degree| 1001 |constructOrdered| 1006 |construct| 1011 |complete|
              1016 |commutator| 1021 |coerce| 1027 |coefficient| 1052
              |charthRoot| 1058 |characteristic| 1063 |center| 1067 |cTanh|
              1072 |cTan| 1077 |cSinh| 1082 |cSin| 1087 |cSech| 1092 |cSec|
              1097 |cRationalPower| 1102 |cPower| 1108 |cLog| 1114 |cExp| 1119
              |cCsch| 1124 |cCsc| 1129 |cCoth| 1134 |cCot| 1139 |cCosh| 1144
              |cCos| 1149 |cAtanh| 1154 |cAtan| 1159 |cAsinh| 1164 |cAsin| 1169
              |cAsech| 1174 |cAsec| 1179 |cAcsch| 1184 |cAcsc| 1189 |cAcoth|
              1194 |cAcot| 1199 |cAcosh| 1204 |cAcos| 1209 |associator| 1214
              |associates?| 1221 |approximate| 1227 |antiCommutator| 1233
              |annihilate?| 1239 ^ 1245 |Zero| 1257 |One| 1261 D 1265 = 1302 /
              1308 - 1314 + 1325 * 1331)
           'NIL
           (CONS
            (|makeByteWordVec2| 24
                                '(0 0 0 2 6 1 6 2 3 4 5 8 7 18 15 18 0 1 6 5 0
                                  0 0 1 17 0 0 0 0 0 1 1 18 24 23 15 15 0 0 22
                                  15 0 0 0 6 0 0 0 6 2 17 9))
            (CONS
             '#(|UnivariatePowerSeriesCategory&| |PowerSeriesCategory&|
                |AbelianMonoidRing&| NIL NIL |Algebra&| |Algebra&|
                |EntireRing&| NIL NIL |Algebra&| |PartialDifferentialRing&|
                |DifferentialRing&| NIL NIL |Rng&| NIL |Module&| |Module&|
                |Module&| NIL NIL NIL NIL |NonAssociativeRing&| NIL NIL NIL NIL
                NIL NIL NIL |NonAssociativeRng&| |AbelianGroup&| NIL NIL NIL
                |NonAssociativeSemiRng&| NIL |AbelianMonoid&| |MagmaWithUnit&|
                |Magma&| |AbelianSemiGroup&| |SetCategory&| NIL NIL
                |BasicType&| NIL NIL NIL NIL NIL)
             (CONS
              '#((|UnivariatePowerSeriesCategory| 6 21)
                 (|PowerSeriesCategory| 6 21 (|SingletonAsOrderedSet|))
                 (|AbelianMonoidRing| 6 21) (|IntegralDomain|)
                 (|CommutativeRing|) (|Algebra| 109) (|Algebra| $$)
                 (|EntireRing|) (|CharacteristicNonZero|)
                 (|CharacteristicZero|) (|Algebra| 6)
                 (|PartialDifferentialRing| 197) (|DifferentialRing|) (|Ring|)
                 (|SemiRing|) (|Rng|) (|SemiRng|) (|Module| 109) (|Module| $$)
                 (|Module| 6) (|IndexedProductCategory| 6 21) (|BiModule| 6 6)
                 (|BiModule| $$ $$) (|BiModule| 109 109) (|NonAssociativeRing|)
                 (|AbelianProductCategory| 6) (|LeftModule| 6)
                 (|RightModule| 6) (|RightModule| $$) (|LeftModule| $$)
                 (|LeftModule| 109) (|RightModule| 109) (|NonAssociativeRng|)
                 (|AbelianGroup|) (|CancellationAbelianMonoid|)
                 (|NonAssociativeSemiRing|) (|Monoid|)
                 (|NonAssociativeSemiRng|) (|SemiGroup|) (|AbelianMonoid|)
                 (|MagmaWithUnit|) (|Magma|) (|AbelianSemiGroup|)
                 (|SetCategory|) (|CommutativeStar|)
                 (|VariablesCommuteWithCoefficients|) (|BasicType|)
                 (|CoercibleTo| 190) (|TwoSidedRecip|) (|noZeroDivisors|)
                 (|unitsKnown|) (|Eltable| $$ $$))
              (|makeByteWordVec2| 217
                                  '(0 10 0 14 1 6 15 0 16 2 10 0 9 0 17 0 18 0
                                    19 1 8 0 18 20 1 10 15 0 23 1 10 0 0 24 1 6
                                    0 21 26 0 6 0 30 2 8 18 0 18 31 1 10 9 0 32
                                    1 18 0 21 33 1 10 0 34 35 0 6 37 38 0 6 0
                                    41 1 8 18 0 42 2 18 15 0 0 43 1 10 15 0 44
                                    1 10 15 0 45 1 10 0 0 46 2 21 15 0 0 49 2
                                    18 15 0 0 50 0 21 0 51 2 21 0 0 0 52 1 18
                                    21 0 53 0 18 0 54 1 18 15 0 59 1 18 63 0 64
                                    2 6 0 21 0 70 2 21 0 0 0 71 2 6 0 0 0 73 2
                                    21 0 76 0 77 2 21 15 0 0 79 2 21 15 0 0 80
                                    2 18 0 0 0 81 2 6 0 0 0 82 2 6 0 0 0 84 1 6
                                    0 0 85 2 6 0 37 0 88 2 6 0 76 0 90 0 92 0
                                    93 2 18 0 0 0 94 1 10 15 0 95 0 76 0 96 1 6
                                    98 0 99 0 21 0 102 2 21 15 0 0 103 2 21 0 0
                                    0 104 1 21 15 0 105 2 0 0 0 37 106 0 37 0
                                    107 2 109 0 21 21 110 2 6 0 109 0 111 1 0 0
                                    0 112 1 109 0 21 113 1 109 0 0 114 2 0 0 6
                                    0 115 1 117 10 116 118 2 0 0 0 6 119 1 120
                                    10 0 121 2 117 120 122 21 123 1 109 21 0
                                    133 2 21 98 0 0 134 2 6 15 0 0 135 1 109 21
                                    0 136 2 6 0 0 37 137 2 6 0 0 109 138 1 6 0
                                    109 139 2 0 0 0 109 140 1 6 0 0 141 1 0 0 0
                                    142 1 6 0 0 143 1 0 0 0 144 1 6 0 0 145 1 6
                                    0 0 146 1 0 0 0 147 1 0 0 0 148 1 6 0 0 149
                                    1 0 0 0 150 1 6 0 0 151 1 0 0 0 152 1 0 0 0
                                    153 1 0 0 0 154 1 109 0 0 155 1 6 0 0 156 1
                                    0 0 0 157 1 6 0 0 158 1 0 0 0 159 1 6 0 0
                                    160 1 0 0 0 161 1 6 0 0 162 1 0 0 0 163 1 6
                                    0 0 164 1 0 0 0 165 1 6 0 0 166 1 0 0 0 167
                                    1 6 0 0 168 1 6 0 0 169 1 0 0 0 170 1 0 0 0
                                    171 1 6 0 0 172 1 0 0 0 173 1 0 0 0 174 1 0
                                    0 0 175 1 0 0 0 176 1 6 0 0 177 1 0 0 0 178
                                    1 6 0 0 179 1 0 0 0 180 1 0 0 0 181 1 6 0 0
                                    182 1 0 0 0 183 1 6 0 0 184 1 0 0 0 185 1 6
                                    0 0 186 1 0 0 0 187 0 109 0 188 2 109 15 0
                                    0 189 1 6 190 0 191 0 109 0 192 1 109 190 0
                                    193 2 190 0 0 0 194 1 190 0 0 195 2 190 0 0
                                    0 196 1 197 190 0 198 2 190 0 0 0 199 1 190
                                    0 0 200 2 109 0 21 0 201 1 18 202 0 203 2
                                    190 0 0 204 205 2 190 0 0 0 206 2 208 190
                                    207 0 209 2 0 15 0 0 1 1 30 15 0 65 1 0 197
                                    0 1 1 25 211 0 1 1 25 0 0 1 1 25 15 0 1 2 0
                                    0 0 21 55 3 0 0 0 21 21 56 1 0 10 0 62 1 0
                                    0 0 101 2 31 98 0 0 1 5 0 190 10 8 197 6
                                    109 210 1 0 0 10 36 0 30 0 1 1 28 98 0 1 2
                                    28 0 0 37 1 2 0 0 0 76 1 1 10 0 0 1 1 28 98
                                    0 1 1 0 15 0 1 1 0 21 0 60 2 0 21 0 21 61 2
                                    30 15 0 0 1 1 28 15 0 1 2 0 0 0 76 78 2 0 0
                                    74 0 75 1 0 15 0 25 2 0 0 6 21 22 2 0 0 68
                                    0 69 2 0 0 8 10 11 1 28 98 0 1 2 28 0 0 37
                                    1 2 0 0 0 76 1 1 10 9 0 1 1 10 21 0 1 1 0 0
                                    0 1 1 0 6 0 1 1 0 217 0 1 1 1 0 0 112 3 0
                                    98 0 0 15 100 2 0 0 0 0 108 2 0 216 216 0 1
                                    1 0 63 0 1 1 0 10 0 13 1 0 8 0 12 2 0 0 0
                                    21 47 2 25 98 0 0 1 2 12 215 0 6 1 2 9 0 0
                                    0 1 2 0 6 0 21 58 2 8 0 0 197 1 3 8 0 0 197
                                    37 1 2 8 0 0 212 1 3 8 0 0 212 213 1 1 7 0
                                    0 72 2 7 0 0 37 1 1 0 21 0 1 1 10 0 214 1 1
                                    0 0 214 1 1 0 0 0 48 2 29 0 0 0 1 1 26 0 6
                                    27 1 29 0 21 28 1 27 0 0 1 1 1 0 109 1 1 0
                                    190 0 1 2 0 6 0 21 57 1 3 98 0 1 0 29 37 39
                                    1 0 6 0 1 1 1 0 0 173 1 1 0 0 150 1 1 0 0
                                    170 1 1 0 0 147 1 1 0 0 175 1 1 0 0 153 2 1
                                    0 0 109 140 2 1 0 0 6 119 1 1 0 0 144 1 1 0
                                    0 142 1 1 0 0 176 1 1 0 0 154 1 1 0 0 174 1
                                    1 0 0 152 1 1 0 0 171 1 1 0 0 148 1 1 0 0
                                    181 1 1 0 0 161 1 1 0 0 178 1 1 0 0 157 1 1
                                    0 0 185 1 1 0 0 165 1 1 0 0 187 1 1 0 0 167
                                    1 1 0 0 183 1 1 0 0 163 1 1 0 0 180 1 1 0 0
                                    159 3 29 0 0 0 0 1 2 25 15 0 0 1 2 13 6 0
                                    21 1 2 0 0 0 0 1 2 29 15 0 0 1 2 28 0 0 37
                                    106 2 0 0 0 76 1 0 30 0 29 0 28 0 40 2 8 0
                                    0 197 1 3 8 0 0 197 37 1 2 8 0 0 212 1 3 8
                                    0 0 212 213 1 1 7 0 0 1 2 7 0 0 37 1 2 0 15
                                    0 0 67 2 11 0 0 6 1 2 32 0 0 0 66 1 32 0 0
                                    86 2 0 0 0 0 83 2 32 0 21 0 87 2 30 0 37 0
                                    89 2 1 0 0 109 1 2 1 0 109 0 1 2 0 0 6 0
                                    115 2 0 0 0 6 1 2 0 0 0 0 97 2 0 0 76 0
                                    91)))))
           '|lookupComplete|)) 
