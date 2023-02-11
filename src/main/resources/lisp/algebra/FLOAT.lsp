
(SDEFUN |FLOAT;writeOMFloat|
        ((|dev| (|OpenMathDevice|)) (|x| ($)) ($ (|Void|)))
        (SEQ (SPADCALL |dev| (QREFELT $ 10))
             (SPADCALL |dev| "bigfloat1" "bigfloat" (QREFELT $ 12))
             (SPADCALL |dev| (SPADCALL |x| (QREFELT $ 14)) (QREFELT $ 15))
             (SPADCALL |dev| 2 (QREFELT $ 15))
             (SPADCALL |dev| (SPADCALL |x| (QREFELT $ 16)) (QREFELT $ 15))
             (EXIT (SPADCALL |dev| (QREFELT $ 17))))) 

(SDEFUN |FLOAT;OMwrite;Omd$BV;2|
        ((|dev| (|OpenMathDevice|)) (|x| ($)) (|wholeObj| (|Boolean|))
         ($ (|Void|)))
        (SEQ (COND (|wholeObj| (SPADCALL |dev| (QREFELT $ 18))))
             (|FLOAT;writeOMFloat| |dev| |x| $)
             (EXIT (COND (|wholeObj| (SPADCALL |dev| (QREFELT $ 19))))))) 

(SDEFUN |FLOAT;shift2| ((|x| (|Integer|)) (|y| (|Integer|)) ($ (|Integer|)))
        (* (SPADCALL |x| (QREFELT $ 22))
           (ASH (* (SPADCALL |x| (QREFELT $ 22)) |x|) |y|))) 

(SDEFUN |FLOAT;asin;2$;4| ((|x| ($)) ($ ($)))
        (SPROG ((|r| ($)))
               (SEQ
                (COND ((SPADCALL |x| (QREFELT $ 23)) (|spadConstant| $ 24))
                      ((SPADCALL |x| (QREFELT $ 25))
                       (SPADCALL
                        (SPADCALL (SPADCALL |x| (QREFELT $ 26)) (QREFELT $ 27))
                        (QREFELT $ 26)))
                      ((SPADCALL |x| (|spadConstant| $ 28) (QREFELT $ 29))
                       (SPADCALL (SPADCALL (QREFELT $ 30)) 2 (QREFELT $ 31)))
                      ((SPADCALL |x| (|spadConstant| $ 28) (QREFELT $ 32))
                       (|error|
                        (SPADCALL
                         (LIST "asin: argument > 1 in magnitude" ": "
                               (SPADCALL |x| (QREFELT $ 33)))
                         (QREFELT $ 35))))
                      ('T
                       (SEQ (SPADCALL 5 (QREFELT $ 37))
                            (LETT |r|
                                  (SPADCALL
                                   (SPADCALL |x|
                                             (SPADCALL
                                              (|FLOAT;sub|
                                               (|spadConstant| $ 28)
                                               (|FLOAT;times| |x| |x| $) $)
                                              (QREFELT $ 38))
                                             (QREFELT $ 39))
                                   (QREFELT $ 40)))
                            (SPADCALL 5 (QREFELT $ 41))
                            (EXIT (SPADCALL |r| (QREFELT $ 42))))))))) 

(SDEFUN |FLOAT;acos;2$;5| ((|x| ($)) ($ ($)))
        (SPROG ((|r| ($)))
               (SEQ
                (COND
                 ((SPADCALL |x| (QREFELT $ 23))
                  (SPADCALL (SPADCALL (QREFELT $ 30)) 2 (QREFELT $ 31)))
                 ((SPADCALL |x| (QREFELT $ 25))
                  (SEQ (SPADCALL 3 (QREFELT $ 37))
                       (LETT |r|
                             (SPADCALL (SPADCALL (QREFELT $ 30))
                                       (SPADCALL (SPADCALL |x| (QREFELT $ 26))
                                                 (QREFELT $ 43))
                                       (QREFELT $ 44)))
                       (SPADCALL 3 (QREFELT $ 41))
                       (EXIT (SPADCALL |r| (QREFELT $ 42)))))
                 ((SPADCALL |x| (|spadConstant| $ 28) (QREFELT $ 29))
                  (|spadConstant| $ 24))
                 ((SPADCALL |x| (|spadConstant| $ 28) (QREFELT $ 32))
                  (|error|
                   (SPADCALL
                    (LIST "acos: argument > 1 in magnitude" ": "
                          (SPADCALL |x| (QREFELT $ 33)))
                    (QREFELT $ 35))))
                 ('T
                  (SEQ (SPADCALL 5 (QREFELT $ 37))
                       (LETT |r|
                             (SPADCALL
                              (SPADCALL
                               (SPADCALL
                                (|FLOAT;sub| (|spadConstant| $ 28)
                                 (|FLOAT;times| |x| |x| $) $)
                                (QREFELT $ 38))
                               |x| (QREFELT $ 39))
                              (QREFELT $ 40)))
                       (SPADCALL 5 (QREFELT $ 41))
                       (EXIT (SPADCALL |r| (QREFELT $ 42))))))))) 

(SDEFUN |FLOAT;atan;3$;6| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG ((|theta| ($)))
               (SEQ
                (COND
                 ((SPADCALL |x| (|spadConstant| $ 24) (QREFELT $ 29))
                  (COND
                   ((SPADCALL |y| (|spadConstant| $ 24) (QREFELT $ 32))
                    (SPADCALL (SPADCALL (QREFELT $ 30)) 2 (QREFELT $ 31)))
                   ((SPADCALL |y| (|spadConstant| $ 24) (QREFELT $ 45))
                    (SPADCALL
                     (SPADCALL (SPADCALL (QREFELT $ 30)) 2 (QREFELT $ 31))
                     (QREFELT $ 26)))
                   (#1='T (|spadConstant| $ 24))))
                 (#1#
                  (SEQ
                   (LETT |theta|
                         (SPADCALL
                          (SPADCALL (SPADCALL |y| |x| (QREFELT $ 39))
                                    (QREFELT $ 46))
                          (QREFELT $ 40)))
                   (COND
                    ((SPADCALL |x| (|spadConstant| $ 24) (QREFELT $ 45))
                     (LETT |theta|
                           (SPADCALL (SPADCALL (QREFELT $ 30)) |theta|
                                     (QREFELT $ 44)))))
                   (COND
                    ((SPADCALL |y| (|spadConstant| $ 24) (QREFELT $ 45))
                     (LETT |theta| (SPADCALL |theta| (QREFELT $ 26)))))
                   (EXIT |theta|))))))) 

(SDEFUN |FLOAT;atan;2$;7| ((|x| ($)) ($ ($)))
        (SPROG
         ((|t| ($)) (#1=#:G835 NIL) (|i| NIL) (|k| (|Integer|)) (#2=#:G834 NIL)
          (|r| ($)))
         (SEQ
          (EXIT
           (COND ((SPADCALL |x| (QREFELT $ 23)) (|spadConstant| $ 24))
                 ((SPADCALL |x| (QREFELT $ 25))
                  (SPADCALL
                   (SPADCALL (SPADCALL |x| (QREFELT $ 26)) (QREFELT $ 40))
                   (QREFELT $ 26)))
                 (#3='T
                  (SEQ
                   (COND
                    ((SPADCALL |x| (|spadConstant| $ 28) (QREFELT $ 32))
                     (SEQ (SPADCALL 4 (QREFELT $ 37))
                          (LETT |r|
                                (COND
                                 ((SPADCALL (SPADCALL |x| (QREFELT $ 48))
                                            (QREFELT $ 23))
                                  (COND
                                   ((SPADCALL |x|
                                              (CONS (SPADCALL (QREFELT $ 49))
                                                    0)
                                              (QREFELT $ 45))
                                    (|FLOAT;atanInverse|
                                     (SPADCALL |x| (QREFELT $ 50)) $))
                                   (#3#
                                    (SPADCALL
                                     (SPADCALL (|spadConstant| $ 28) |x|
                                               (QREFELT $ 39))
                                     (QREFELT $ 40)))))
                                 (#3#
                                  (SPADCALL
                                   (SPADCALL (|spadConstant| $ 28) |x|
                                             (QREFELT $ 39))
                                   (QREFELT $ 40)))))
                          (LETT |r|
                                (SPADCALL
                                 (SPADCALL (SPADCALL (QREFELT $ 30)) 2
                                           (QREFELT $ 31))
                                 |r| (QREFELT $ 44)))
                          (SPADCALL 4 (QREFELT $ 41))
                          (EXIT
                           (PROGN
                            (LETT #2# (SPADCALL |r| (QREFELT $ 42)))
                            (GO #4=#:G833))))))
                   (LETT |k|
                         (QUOTIENT2
                          (SPADCALL (- (SPADCALL (QREFELT $ 49)) 100)
                                    (QREFELT $ 52))
                          5))
                   (LETT |k|
                         (MAX 0 (+ (+ 2 |k|) (SPADCALL |x| (QREFELT $ 53)))))
                   (SPADCALL (* 2 |k|) (QREFELT $ 37))
                   (SEQ (LETT |i| 1) (LETT #1# |k|) G190
                        (COND ((|greater_SI| |i| #1#) (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT |x|
                                (SPADCALL |x|
                                          (SPADCALL (|spadConstant| $ 28)
                                                    (SPADCALL
                                                     (SPADCALL
                                                      (|spadConstant| $ 28)
                                                      (SPADCALL |x| |x|
                                                                (QREFELT $ 54))
                                                      (QREFELT $ 55))
                                                     (QREFELT $ 38))
                                                    (QREFELT $ 55))
                                          (QREFELT $ 39)))))
                        (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                   (LETT |t| (|FLOAT;atanSeries| |x| $))
                   (SPADCALL (* 2 |k|) (QREFELT $ 41))
                   (LETT |t| (SPADCALL |t| |k| (QREFELT $ 56)))
                   (EXIT (SPADCALL |t| (QREFELT $ 42)))))))
          #4# (EXIT #2#)))) 

(SDEFUN |FLOAT;atanSeries| ((|x| ($)) ($ ($)))
        (SPROG
         ((|t| #1=(|Integer|)) (|s| #2=(|Integer|)) (|i| NIL) (|m| #1#)
          (|y| ($)) (|d| #2#) (|p| (|NonNegativeInteger|)))
         (SEQ
          (LETT |p|
                (+
                 (+ (SPADCALL (QREFELT $ 49))
                    (INTEGER-LENGTH (SPADCALL (QREFELT $ 49))))
                 2))
          (LETT |s| (LETT |d| (ASH 1 |p|)))
          (LETT |y| (|FLOAT;times| |x| |x| $))
          (LETT |t|
                (LETT |m|
                      (- (|FLOAT;shift2| (QCAR |y|) (+ (QCDR |y|) |p|) $))))
          (SEQ (LETT |i| 3) G190
               (COND ((NULL (SPADCALL |t| 0 (QREFELT $ 57))) (GO G191)))
               (SEQ (LETT |s| (+ |s| (QUOTIENT2 |t| |i|)))
                    (EXIT (LETT |t| (QUOTIENT2 (* |m| |t|) |d|))))
               (LETT |i| (|add_SI| |i| 2)) (GO G190) G191 (EXIT NIL))
          (EXIT (SPADCALL |x| (CONS |s| (- |p|)) (QREFELT $ 54)))))) 

(SDEFUN |FLOAT;atanInverse| ((|n| (|Integer|)) ($ ($)))
        (SPROG
         ((|t| #1=(|Integer|)) (|s| #1#) (|k| NIL) (|e| (|Integer|))
          (|n2| (|Integer|)))
         (SEQ (LETT |n2| (- (* |n| |n|)))
              (LETT |e|
                    (+
                     (+
                      (+ (SPADCALL (QREFELT $ 49))
                         (INTEGER-LENGTH (SPADCALL (QREFELT $ 49))))
                      (INTEGER-LENGTH |n|))
                     1))
              (LETT |s| (QUOTIENT2 (ASH 1 |e|) |n|))
              (LETT |t| (QUOTIENT2 |s| |n2|))
              (SEQ (LETT |k| 3) G190
                   (COND ((NULL (SPADCALL |t| 0 (QREFELT $ 57))) (GO G191)))
                   (SEQ (LETT |s| (+ |s| (QUOTIENT2 |t| |k|)))
                        (EXIT (LETT |t| (QUOTIENT2 |t| |n2|))))
                   (LETT |k| (|add_SI| |k| 2)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL (CONS |s| (- |e|)) (QREFELT $ 42)))))) 

(SDEFUN |FLOAT;sin;2$;10| ((|x| ($)) ($ ($)))
        (SPROG
         ((|r| ($)) (#1=#:G868 NIL) (|i| NIL) (#2=#:G862 NIL) (|k| (|Integer|))
          (|s| (|Integer|)) (|p| (|PositiveInteger|)))
         (SEQ (LETT |s| (SPADCALL |x| (QREFELT $ 58)))
              (LETT |x| (SPADCALL |x| (QREFELT $ 46)))
              (LETT |p| (SPADCALL (QREFELT $ 49))) (SPADCALL 4 (QREFELT $ 37))
              (COND
               ((SPADCALL |x| (CONS 6 0) (QREFELT $ 32))
                (SEQ (SPADCALL |p| (QREFELT $ 37))
                     (LETT |x|
                           (SPADCALL
                            (SPADCALL 2 (SPADCALL (QREFELT $ 30))
                                      (QREFELT $ 59))
                            (SPADCALL
                             (SPADCALL
                              (SPADCALL |x| (SPADCALL (QREFELT $ 30))
                                        (QREFELT $ 39))
                              2 (QREFELT $ 31))
                             (QREFELT $ 48))
                            (QREFELT $ 54)))
                     (EXIT (SPADCALL |p| (QREFELT $ 60))))))
              (COND
               ((SPADCALL |x| (CONS 3 0) (QREFELT $ 32))
                (SEQ (SPADCALL |p| (QREFELT $ 37)) (LETT |s| (- |s|))
                     (LETT |x|
                           (SPADCALL |x| (SPADCALL (QREFELT $ 30))
                                     (QREFELT $ 44)))
                     (EXIT (SPADCALL |p| (QREFELT $ 60))))))
              (COND
               ((SPADCALL |x| (CONS 3 -1) (QREFELT $ 32))
                (SEQ (SPADCALL |p| (QREFELT $ 37))
                     (LETT |x|
                           (SPADCALL (SPADCALL (QREFELT $ 30)) |x|
                                     (QREFELT $ 44)))
                     (EXIT (SPADCALL |p| (QREFELT $ 41))))))
              (LETT |k|
                    (QUOTIENT2
                     (SPADCALL (- (SPADCALL (QREFELT $ 49)) 100)
                               (QREFELT $ 52))
                     4))
              (LETT |k| (MAX 0 (+ (+ 2 |k|) (SPADCALL |x| (QREFELT $ 53)))))
              (COND
               ((> |k| 0)
                (SEQ (SPADCALL |k| (QREFELT $ 37))
                     (EXIT
                      (LETT |x|
                            (SPADCALL |x|
                                      (EXPT 3
                                            (PROG1 (LETT #2# |k|)
                                              (|check_subtype2| (>= #2# 0)
                                                                '(|NonNegativeInteger|)
                                                                '(|Integer|)
                                                                #2#)))
                                      (QREFELT $ 31)))))))
              (LETT |r| (|FLOAT;sinSeries| |x| $))
              (SEQ (LETT |i| 1) (LETT #1# |k|) G190
                   (COND ((|greater_SI| |i| #1#) (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |r|
                           (SPADCALL (|FLOAT;itimes| 3 |r| $)
                                     (SPADCALL (SPADCALL |r| 3 (QREFELT $ 61))
                                               2 (QREFELT $ 56))
                                     (QREFELT $ 44)))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (SPADCALL |p| (QREFELT $ 60))
              (EXIT (SPADCALL |s| |r| (QREFELT $ 62)))))) 

(SDEFUN |FLOAT;sinSeries| ((|x| ($)) ($ ($)))
        (SPROG
         ((|t| (|Integer|)) (|s| #1=(|Integer|)) (|i| NIL) (|m| (|Integer|))
          (|d| #1#) (|y| ($)) (|p| (|NonNegativeInteger|)))
         (SEQ
          (LETT |p|
                (+
                 (+ (SPADCALL (QREFELT $ 49))
                    (INTEGER-LENGTH (SPADCALL (QREFELT $ 49))))
                 2))
          (LETT |y| (|FLOAT;times| |x| |x| $))
          (LETT |s| (LETT |d| (ASH 1 |p|)))
          (LETT |m| (- (|FLOAT;shift2| (QCAR |y|) (+ (QCDR |y|) |p|) $)))
          (LETT |t| (QUOTIENT2 |m| 6))
          (SEQ (LETT |i| 4) G190
               (COND ((NULL (SPADCALL |t| 0 (QREFELT $ 57))) (GO G191)))
               (SEQ (LETT |s| (+ |s| |t|))
                    (LETT |t| (QUOTIENT2 (* |m| |t|) (* |i| (+ |i| 1))))
                    (EXIT (LETT |t| (QUOTIENT2 |t| |d|))))
               (LETT |i| (|add_SI| |i| 2)) (GO G190) G191 (EXIT NIL))
          (EXIT (SPADCALL |x| (CONS |s| (- |p|)) (QREFELT $ 54)))))) 

(SDEFUN |FLOAT;cos;2$;12| ((|x| ($)) ($ ($)))
        (SPROG
         ((|r| ($)) (#1=#:G888 NIL) (|i| NIL) (|k| (|Integer|)) (#2=#:G887 NIL)
          (|s| (|Integer|)) (|p| (|PositiveInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |s| 1) (LETT |x| (SPADCALL |x| (QREFELT $ 46)))
                (LETT |p| (SPADCALL (QREFELT $ 49)))
                (SPADCALL 4 (QREFELT $ 37))
                (COND
                 ((SPADCALL |x| (CONS 6 0) (QREFELT $ 32))
                  (SEQ (SPADCALL |p| (QREFELT $ 37))
                       (LETT |x|
                             (SPADCALL
                              (SPADCALL 2 (SPADCALL (QREFELT $ 30))
                                        (QREFELT $ 59))
                              (SPADCALL
                               (SPADCALL
                                (SPADCALL |x| (SPADCALL (QREFELT $ 30))
                                          (QREFELT $ 39))
                                2 (QREFELT $ 31))
                               (QREFELT $ 48))
                              (QREFELT $ 54)))
                       (EXIT (SPADCALL |p| (QREFELT $ 41))))))
                (COND
                 ((SPADCALL |x| (CONS 3 0) (QREFELT $ 32))
                  (SEQ (SPADCALL |p| (QREFELT $ 37)) (LETT |s| (- |s|))
                       (LETT |x|
                             (SPADCALL |x| (SPADCALL (QREFELT $ 30))
                                       (QREFELT $ 44)))
                       (EXIT (SPADCALL |p| (QREFELT $ 41))))))
                (COND
                 ((SPADCALL |x| (CONS 1 0) (QREFELT $ 32))
                  (SEQ (SPADCALL |p| (QREFELT $ 37))
                       (LETT |x|
                             (SPADCALL
                              (SPADCALL (SPADCALL (QREFELT $ 30)) 2
                                        (QREFELT $ 31))
                              |x| (QREFELT $ 44)))
                       (SPADCALL |p| (QREFELT $ 60))
                       (LETT |x| (SPADCALL |x| (QREFELT $ 42)))
                       (EXIT
                        (PROGN
                         (LETT #2#
                               (SPADCALL |s| (SPADCALL |x| (QREFELT $ 63))
                                         (QREFELT $ 62)))
                         (GO #3=#:G886))))))
                (LETT |k|
                      (QUOTIENT2
                       (SPADCALL (- (SPADCALL (QREFELT $ 49)) 100)
                                 (QREFELT $ 52))
                       3))
                (LETT |k| (MAX 0 (+ (+ 2 |k|) (SPADCALL |x| (QREFELT $ 53)))))
                (COND
                 ((> |k| 0)
                  (SEQ
                   (SPADCALL (+ |k| (EXPT (INTEGER-LENGTH |k|) 2))
                             (QREFELT $ 37))
                   (EXIT (LETT |x| (SPADCALL |x| (- |k|) (QREFELT $ 56)))))))
                (LETT |r| (|FLOAT;cosSeries| |x| $))
                (SEQ (LETT |i| 1) (LETT #1# |k|) G190
                     (COND ((|greater_SI| |i| #1#) (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT |r|
                             (SPADCALL
                              (SPADCALL (SPADCALL |r| |r| (QREFELT $ 54)) 1
                                        (QREFELT $ 56))
                              (|spadConstant| $ 28) (QREFELT $ 44)))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (SPADCALL |p| (QREFELT $ 60))
                (EXIT (SPADCALL |s| |r| (QREFELT $ 62)))))
          #3# (EXIT #2#)))) 

(SDEFUN |FLOAT;cosSeries| ((|x| ($)) ($ ($)))
        (SPROG
         ((|t| (|Integer|)) (|s| #1=(|Integer|)) (|i| NIL) (|m| (|Integer|))
          (|d| #1#) (|y| ($)) (|p| (|NonNegativeInteger|)))
         (SEQ
          (LETT |p|
                (+
                 (+ (SPADCALL (QREFELT $ 49))
                    (INTEGER-LENGTH (SPADCALL (QREFELT $ 49))))
                 1))
          (LETT |y| (|FLOAT;times| |x| |x| $))
          (LETT |s| (LETT |d| (ASH 1 |p|)))
          (LETT |m| (- (|FLOAT;shift2| (QCAR |y|) (+ (QCDR |y|) |p|) $)))
          (LETT |t| (QUOTIENT2 |m| 2))
          (SEQ (LETT |i| 3) G190
               (COND ((NULL (SPADCALL |t| 0 (QREFELT $ 57))) (GO G191)))
               (SEQ (LETT |s| (+ |s| |t|))
                    (LETT |t| (QUOTIENT2 (* |m| |t|) (* |i| (+ |i| 1))))
                    (EXIT (LETT |t| (QUOTIENT2 |t| |d|))))
               (LETT |i| (|add_SI| |i| 2)) (GO G190) G191 (EXIT NIL))
          (EXIT (SPADCALL (CONS |s| (- |p|)) (QREFELT $ 42)))))) 

(SDEFUN |FLOAT;tan;2$;14| ((|x| ($)) ($ ($)))
        (SPROG
         ((|t| ($)) (|c| ($)) (|s| (|Integer|)) (|p| (|PositiveInteger|)))
         (SEQ (LETT |s| (SPADCALL |x| (QREFELT $ 58)))
              (LETT |x| (SPADCALL |x| (QREFELT $ 46)))
              (LETT |p| (SPADCALL (QREFELT $ 49))) (SPADCALL 6 (QREFELT $ 37))
              (COND
               ((SPADCALL |x| (CONS 3 0) (QREFELT $ 32))
                (SEQ (SPADCALL |p| (QREFELT $ 37))
                     (LETT |x|
                           (SPADCALL (SPADCALL (QREFELT $ 30))
                                     (SPADCALL
                                      (SPADCALL |x| (SPADCALL (QREFELT $ 30))
                                                (QREFELT $ 39))
                                      (QREFELT $ 48))
                                     (QREFELT $ 54)))
                     (EXIT (SPADCALL |p| (QREFELT $ 41))))))
              (COND
               ((SPADCALL |x| (CONS 3 -1) (QREFELT $ 32))
                (SEQ (SPADCALL |p| (QREFELT $ 37))
                     (LETT |x|
                           (SPADCALL (SPADCALL (QREFELT $ 30)) |x|
                                     (QREFELT $ 44)))
                     (LETT |s| (- |s|)) (EXIT (SPADCALL |p| (QREFELT $ 41))))))
              (COND
               ((SPADCALL |x| (|spadConstant| $ 28) (QREFELT $ 32))
                (SEQ (LETT |c| (SPADCALL |x| (QREFELT $ 64)))
                     (EXIT
                      (LETT |t|
                            (SPADCALL
                             (SPADCALL
                              (SPADCALL (|spadConstant| $ 28)
                                        (SPADCALL |c| |c| (QREFELT $ 54))
                                        (QREFELT $ 44))
                              (QREFELT $ 38))
                             |c| (QREFELT $ 39))))))
               ('T
                (SEQ (LETT |c| (SPADCALL |x| (QREFELT $ 63)))
                     (EXIT
                      (LETT |t|
                            (SPADCALL |c|
                                      (SPADCALL
                                       (SPADCALL (|spadConstant| $ 28)
                                                 (SPADCALL |c| |c|
                                                           (QREFELT $ 54))
                                                 (QREFELT $ 44))
                                       (QREFELT $ 38))
                                      (QREFELT $ 39)))))))
              (SPADCALL |p| (QREFELT $ 60))
              (EXIT (SPADCALL |s| |t| (QREFELT $ 62)))))) 

(SDEFUN |FLOAT;pi;$;15| (($ ($)))
        (COND
         ((<= (SPADCALL (QREFELT $ 49)) (QCAR (QREFELT $ 66)))
          (SPADCALL (QCDR (QREFELT $ 66)) (QREFELT $ 42)))
         ('T
          (QCDR
           (SETELT $ 66
                   (CONS (SPADCALL (QREFELT $ 49)) (|FLOAT;piRamanujan| $))))))) 

(SDEFUN |FLOAT;piRamanujan| (($ ($)))
        (SPROG
         ((|t| (|Integer|)) (|m| (|Integer|)) (|s| (|Integer|)) (|i| NIL)
          (|j| NIL) (|d| (|Integer|)) (|n| (|NonNegativeInteger|)))
         (SEQ
          (LETT |n|
                (+
                 (+ (SPADCALL (QREFELT $ 49))
                    (INTEGER-LENGTH (SPADCALL (QREFELT $ 49))))
                 11))
          (LETT |t| (QUOTIENT2 (ASH 1 |n|) 882)) (LETT |d| (* 4 (EXPT 882 2)))
          (LETT |s| 0)
          (SEQ (LETT |j| 1123) (LETT |i| 2) G190
               (COND ((NULL (SPADCALL |t| 0 (QREFELT $ 57))) (GO G191)))
               (SEQ (LETT |s| (+ |s| (* |j| |t|)))
                    (LETT |m|
                          (-
                           (* (* (- |i| 1) (- (* 2 |i|) 1)) (- (* 2 |i|) 3))))
                    (EXIT
                     (LETT |t| (QUOTIENT2 (* |m| |t|) (* |d| (EXPT |i| 3))))))
               (LETT |i|
                     (PROG1 (|add_SI| |i| 2) (LETT |j| (|add_SI| |j| 21460))))
               (GO G190) G191 (EXIT NIL))
          (EXIT
           (SPADCALL (|spadConstant| $ 28) (CONS |s| (- (- |n|) 2))
                     (QREFELT $ 39)))))) 

(SDEFUN |FLOAT;sinh;2$;17| ((|x| ($)) ($ ($)))
        (SPROG ((|s| ($)) (|e| ($)) (|lost| (|Integer|)))
               (SEQ
                (COND ((SPADCALL |x| (QREFELT $ 23)) (|spadConstant| $ 24))
                      (#1='T
                       (SEQ
                        (LETT |lost| (MAX (- (SPADCALL |x| (QREFELT $ 53))) 0))
                        (EXIT
                         (COND ((> (* 2 |lost|) (SPADCALL (QREFELT $ 49))) |x|)
                               (#1#
                                (SEQ (SPADCALL (+ 5 |lost|) (QREFELT $ 37))
                                     (LETT |e| (SPADCALL |x| (QREFELT $ 68)))
                                     (LETT |s|
                                           (SPADCALL
                                            (SPADCALL |e|
                                                      (SPADCALL
                                                       (|spadConstant| $ 28)
                                                       |e| (QREFELT $ 39))
                                                      (QREFELT $ 44))
                                            2 (QREFELT $ 31)))
                                     (SPADCALL (+ 5 |lost|) (QREFELT $ 41))
                                     (EXIT
                                      (SPADCALL |s| (QREFELT $ 42))))))))))))) 

(SDEFUN |FLOAT;cosh;2$;18| ((|x| ($)) ($ ($)))
        (SPROG ((|c| ($)) (|e| ($)))
               (SEQ (SPADCALL 5 (QREFELT $ 37))
                    (LETT |e| (SPADCALL |x| (QREFELT $ 68)))
                    (LETT |c|
                          (SPADCALL
                           (SPADCALL |e|
                                     (SPADCALL (|spadConstant| $ 28) |e|
                                               (QREFELT $ 39))
                                     (QREFELT $ 55))
                           2 (QREFELT $ 31)))
                    (SPADCALL 5 (QREFELT $ 41))
                    (EXIT (SPADCALL |c| (QREFELT $ 42)))))) 

(SDEFUN |FLOAT;tanh;2$;19| ((|x| ($)) ($ ($)))
        (SPROG ((|t| ($)) (|e| ($)) (|lost| (|Integer|)))
               (SEQ
                (COND ((SPADCALL |x| (QREFELT $ 23)) (|spadConstant| $ 24))
                      (#1='T
                       (SEQ
                        (LETT |lost| (MAX (- (SPADCALL |x| (QREFELT $ 53))) 0))
                        (EXIT
                         (COND ((> (* 2 |lost|) (SPADCALL (QREFELT $ 49))) |x|)
                               (#1#
                                (SEQ (SPADCALL (+ 6 |lost|) (QREFELT $ 37))
                                     (LETT |e| (SPADCALL |x| (QREFELT $ 68)))
                                     (LETT |e|
                                           (SPADCALL |e| |e| (QREFELT $ 54)))
                                     (LETT |t|
                                           (SPADCALL
                                            (SPADCALL |e| (|spadConstant| $ 28)
                                                      (QREFELT $ 44))
                                            (SPADCALL |e| (|spadConstant| $ 28)
                                                      (QREFELT $ 55))
                                            (QREFELT $ 39)))
                                     (SPADCALL (+ 6 |lost|) (QREFELT $ 41))
                                     (EXIT
                                      (SPADCALL |t| (QREFELT $ 42))))))))))))) 

(SDEFUN |FLOAT;asinh;2$;20| ((|x| ($)) ($ ($)))
        (SPROG ((|r| ($)) (#1=#:G931 NIL) (|p| (|Integer|)))
               (SEQ
                (EXIT
                 (SEQ (LETT |p| (MIN 0 (SPADCALL |x| (QREFELT $ 53))))
                      (COND
                       ((OR (SPADCALL |x| (QREFELT $ 23))
                            (< (* 2 |p|) (- (SPADCALL (QREFELT $ 49)))))
                        (PROGN (LETT #1# |x|) (GO #2=#:G930))))
                      (SPADCALL (- 5 |p|) (QREFELT $ 37))
                      (LETT |r|
                            (SPADCALL
                             (SPADCALL |x|
                                       (SPADCALL
                                        (SPADCALL (|spadConstant| $ 28)
                                                  (SPADCALL |x| |x|
                                                            (QREFELT $ 54))
                                                  (QREFELT $ 55))
                                        (QREFELT $ 38))
                                       (QREFELT $ 55))
                             (QREFELT $ 72)))
                      (SPADCALL (- 5 |p|) (QREFELT $ 41))
                      (EXIT (SPADCALL |r| (QREFELT $ 42)))))
                #2# (EXIT #1#)))) 

(SDEFUN |FLOAT;acosh;2$;21| ((|x| ($)) ($ ($)))
        (SPROG ((|r| ($)))
               (SEQ
                (COND
                 ((SPADCALL |x| (|spadConstant| $ 28) (QREFELT $ 45))
                  (|error|
                   (SPADCALL
                    (LIST "acosh: invalid argument" ": "
                          (SPADCALL |x| (QREFELT $ 33)))
                    (QREFELT $ 35)))))
                (SPADCALL 5 (QREFELT $ 37))
                (LETT |r|
                      (SPADCALL
                       (SPADCALL |x|
                                 (SPADCALL
                                  (|FLOAT;sub| (|FLOAT;times| |x| |x| $)
                                   (|spadConstant| $ 28) $)
                                  (QREFELT $ 38))
                                 (QREFELT $ 55))
                       (QREFELT $ 72)))
                (SPADCALL 5 (QREFELT $ 41))
                (EXIT (SPADCALL |r| (QREFELT $ 42)))))) 

(SDEFUN |FLOAT;atanh;2$;22| ((|x| ($)) ($ ($)))
        (SPROG ((|r| ($)) (#1=#:G940 NIL) (|p| (|Integer|)))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((OR (SPADCALL |x| (|spadConstant| $ 28) (QREFELT $ 32))
                        (SPADCALL |x|
                                  (SPADCALL (|spadConstant| $ 28)
                                            (QREFELT $ 26))
                                  (QREFELT $ 45)))
                    (|error|
                     (SPADCALL
                      (LIST "atanh: invalid argument" ": "
                            (SPADCALL |x| (QREFELT $ 33)))
                      (QREFELT $ 35)))))
                  (LETT |p| (MIN 0 (SPADCALL |x| (QREFELT $ 53))))
                  (COND
                   ((OR (SPADCALL |x| (QREFELT $ 23))
                        (< (* 2 |p|) (- (SPADCALL (QREFELT $ 49)))))
                    (PROGN (LETT #1# |x|) (GO #2=#:G939))))
                  (SPADCALL (- 5 |p|) (QREFELT $ 37))
                  (LETT |r|
                        (SPADCALL
                         (SPADCALL
                          (SPADCALL
                           (SPADCALL |x| (|spadConstant| $ 28) (QREFELT $ 55))
                           (SPADCALL (|spadConstant| $ 28) |x| (QREFELT $ 44))
                           (QREFELT $ 39))
                          (QREFELT $ 72))
                         2 (QREFELT $ 31)))
                  (SPADCALL (- 5 |p|) (QREFELT $ 41))
                  (EXIT (SPADCALL |r| (QREFELT $ 42)))))
                #2# (EXIT #1#)))) 

(SDEFUN |FLOAT;log;2$;23| ((|x| ($)) ($ ($)))
        (SPROG
         ((|l| ($)) (|m| #1=(|Integer|)) (|ek| ($)) (#2=#:G945 NIL)
          (|k| (|Integer|)) (|n| #1#) (|p| (|PositiveInteger|)))
         (SEQ
          (COND
           ((SPADCALL |x| (QREFELT $ 25))
            (|error|
             (SPADCALL
              (LIST "log: negative argument" ": "
                    (SPADCALL |x| (QREFELT $ 33)))
              (QREFELT $ 35))))
           ((SPADCALL |x| (QREFELT $ 23)) (|error| "log 0 generated"))
           (#3='T
            (SEQ (LETT |p| (SPADCALL (QREFELT $ 49)))
                 (SPADCALL 5 (QREFELT $ 37))
                 (SEQ (LETT |n| (SPADCALL |x| (QREFELT $ 53)))
                      (EXIT (COND ((< |n| 0) (LETT |n| (+ |n| 1))))))
                 (LETT |l|
                       (COND ((EQL |n| 0) (|spadConstant| $ 24))
                             (#3#
                              (SEQ
                               (LETT |x| (SPADCALL |x| (- |n|) (QREFELT $ 56)))
                               (EXIT
                                (SPADCALL |n| (SPADCALL (QREFELT $ 76))
                                          (QREFELT $ 62)))))))
                 (LETT |k| (QUOTIENT2 (SPADCALL (- |p| 100) (QREFELT $ 52)) 3))
                 (COND
                  ((> |k| 1)
                   (SEQ
                    (LETT |k|
                          (MAX 1
                               (+ |k|
                                  (SPADCALL
                                   (SPADCALL |x| (|spadConstant| $ 28)
                                             (QREFELT $ 44))
                                   (QREFELT $ 53)))))
                    (SPADCALL |k| (QREFELT $ 37))
                    (LETT |ek|
                          (|FLOAT;expInverse|
                           (EXPT 2
                                 (PROG1 (LETT #2# |k|)
                                   (|check_subtype2| (>= #2# 0)
                                                     '(|NonNegativeInteger|)
                                                     '(|Integer|) #2#)))
                           $))
                    (SPADCALL (QUOTIENT2 |p| 2) (QREFELT $ 41))
                    (LETT |m|
                          (SPADCALL (|FLOAT;square| |x| |k| $) (QREFELT $ 53)))
                    (SPADCALL (QUOTIENT2 |p| 2) (QREFELT $ 37))
                    (LETT |m| (QUOTIENT2 (* 6847196937 |m|) 9878417065))
                    (LETT |x|
                          (SPADCALL |x| (SPADCALL |ek| (- |m|) (QREFELT $ 77))
                                    (QREFELT $ 54)))
                    (EXIT
                     (LETT |l|
                           (SPADCALL |l| (CONS |m| (- |k|))
                                     (QREFELT $ 55)))))))
                 (LETT |l|
                       (SPADCALL |l| (|FLOAT;logSeries| |x| $) (QREFELT $ 55)))
                 (SPADCALL |p| (QREFELT $ 60))
                 (EXIT (SPADCALL |l| (QREFELT $ 42))))))))) 

(SDEFUN |FLOAT;logSeries| ((|x| ($)) ($ ($)))
        (SPROG
         ((|t| #1=(|Integer|)) (|s| #2=(|Integer|)) (|i| NIL) (|m| #1#)
          (|z| ($)) (|d| #2#) (|y| ($)) (|p| #3=(|NonNegativeInteger|))
          (|g| #3#))
         (SEQ
          (LETT |p|
                (+ (SPADCALL (QREFELT $ 49))
                   (LETT |g|
                         (+ (INTEGER-LENGTH (SPADCALL (QREFELT $ 49))) 3))))
          (SPADCALL |g| (QREFELT $ 37))
          (LETT |y|
                (SPADCALL (SPADCALL |x| (|spadConstant| $ 28) (QREFELT $ 44))
                          (SPADCALL |x| (|spadConstant| $ 28) (QREFELT $ 55))
                          (QREFELT $ 39)))
          (SPADCALL |g| (QREFELT $ 41)) (LETT |s| (LETT |d| (ASH 1 |p|)))
          (LETT |z| (|FLOAT;times| |y| |y| $))
          (LETT |t|
                (LETT |m| (|FLOAT;shift2| (QCAR |z|) (+ (QCDR |z|) |p|) $)))
          (SEQ (LETT |i| 3) G190
               (COND ((NULL (SPADCALL |t| 0 (QREFELT $ 57))) (GO G191)))
               (SEQ (LETT |s| (+ |s| (QUOTIENT2 |t| |i|)))
                    (EXIT (LETT |t| (QUOTIENT2 (* |m| |t|) |d|))))
               (LETT |i| (|add_SI| |i| 2)) (GO G190) G191 (EXIT NIL))
          (EXIT (SPADCALL |y| (CONS |s| (- 1 |p|)) (QREFELT $ 54)))))) 

(SDEFUN |FLOAT;log2;$;25| (($ ($)))
        (SPROG
         ((|t| (|Integer|)) (|s| (|Integer|)) (|k| NIL)
          (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (SPADCALL (QREFELT $ 49)))
              (EXIT
               (COND
                ((<= |n| (QCAR (QREFELT $ 78)))
                 (SPADCALL (QCDR (QREFELT $ 78)) (QREFELT $ 42)))
                ('T
                 (SEQ (LETT |n| (+ (+ |n| (INTEGER-LENGTH |n|)) 3))
                      (LETT |s| (QUOTIENT2 (ASH 1 (+ |n| 1)) 3))
                      (LETT |t| (QUOTIENT2 |s| 9))
                      (SEQ (LETT |k| 3) G190
                           (COND
                            ((NULL (SPADCALL |t| 0 (QREFELT $ 57))) (GO G191)))
                           (SEQ (LETT |s| (+ |s| (QUOTIENT2 |t| |k|)))
                                (EXIT (LETT |t| (QUOTIENT2 |t| 9))))
                           (LETT |k| (|add_SI| |k| 2)) (GO G190) G191
                           (EXIT NIL))
                      (SETELT $ 78
                              (CONS (SPADCALL (QREFELT $ 49))
                                    (CONS |s| (- |n|))))
                      (EXIT
                       (SPADCALL (QCDR (QREFELT $ 78)) (QREFELT $ 42)))))))))) 

(SDEFUN |FLOAT;log10;$;26| (($ ($)))
        (SPROG
         ((|t| (|Integer|)) (|s| (|Integer|)) (|k| NIL)
          (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (SPADCALL (QREFELT $ 49)))
              (EXIT
               (COND
                ((<= |n| (QCAR (QREFELT $ 79)))
                 (SPADCALL (QCDR (QREFELT $ 79)) (QREFELT $ 42)))
                ('T
                 (SEQ (LETT |n| (+ (+ |n| (INTEGER-LENGTH |n|)) 5))
                      (LETT |s| (QUOTIENT2 (ASH 1 (+ |n| 1)) 9))
                      (LETT |t| (QUOTIENT2 |s| 81))
                      (SEQ (LETT |k| 3) G190
                           (COND
                            ((NULL (SPADCALL |t| 0 (QREFELT $ 57))) (GO G191)))
                           (SEQ (LETT |s| (+ |s| (QUOTIENT2 |t| |k|)))
                                (EXIT (LETT |t| (QUOTIENT2 |t| 81))))
                           (LETT |k| (|add_SI| |k| 2)) (GO G190) G191
                           (EXIT NIL))
                      (SPADCALL 2 (QREFELT $ 37))
                      (SETELT $ 79
                              (CONS (SPADCALL (QREFELT $ 49))
                                    (SPADCALL (CONS |s| (- |n|))
                                              (SPADCALL 3
                                                        (SPADCALL
                                                         (QREFELT $ 76))
                                                        (QREFELT $ 59))
                                              (QREFELT $ 55))))
                      (SPADCALL 2 (QREFELT $ 41))
                      (EXIT
                       (SPADCALL (QCDR (QREFELT $ 79)) (QREFELT $ 42)))))))))) 

(SDEFUN |FLOAT;log2;2$;27| ((|x| ($)) ($ ($)))
        (SPROG ((|r| ($)))
               (SEQ (SPADCALL 2 (QREFELT $ 37))
                    (LETT |r|
                          (SPADCALL (SPADCALL |x| (QREFELT $ 72))
                                    (SPADCALL (QREFELT $ 76)) (QREFELT $ 39)))
                    (SPADCALL 2 (QREFELT $ 41))
                    (EXIT (SPADCALL |r| (QREFELT $ 42)))))) 

(SDEFUN |FLOAT;log10;2$;28| ((|x| ($)) ($ ($)))
        (SPROG ((|r| ($)))
               (SEQ (SPADCALL 2 (QREFELT $ 37))
                    (LETT |r|
                          (SPADCALL (SPADCALL |x| (QREFELT $ 72))
                                    (SPADCALL (QREFELT $ 80)) (QREFELT $ 39)))
                    (SPADCALL 2 (QREFELT $ 41))
                    (EXIT (SPADCALL |r| (QREFELT $ 42)))))) 

(SDEFUN |FLOAT;exp;2$;29| ((|x| ($)) ($ ($)))
        (SPROG
         ((|e| ($)) (|k| (|Integer|)) (#1=#:G981 NIL) (|e1| ($))
          (|n| (|Integer|)) (|p| (|PositiveInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |p| (SPADCALL (QREFELT $ 49)))
                (SPADCALL 5 (QREFELT $ 37)) (LETT |e1| (|spadConstant| $ 28))
                (COND
                 ((SPADCALL (LETT |n| (SPADCALL |x| (QREFELT $ 50))) 0
                            (QREFELT $ 57))
                  (SEQ (SPADCALL (INTEGER-LENGTH |n|) (QREFELT $ 37))
                       (LETT |e1|
                             (SPADCALL (SPADCALL (QREFELT $ 83)) |n|
                                       (QREFELT $ 77)))
                       (SPADCALL (INTEGER-LENGTH |n|) (QREFELT $ 41))
                       (EXIT (LETT |x| (SPADCALL |x| (QREFELT $ 48)))))))
                (COND
                 ((SPADCALL |x| (QREFELT $ 23))
                  (SEQ (SPADCALL |p| (QREFELT $ 60))
                       (EXIT
                        (PROGN
                         (LETT #1# (SPADCALL |e1| (QREFELT $ 42)))
                         (GO #2=#:G980))))))
                (LETT |k| (QUOTIENT2 (SPADCALL (- |p| 100) (QREFELT $ 52)) 3))
                (LETT |k| (MAX 0 (+ (+ 2 |k|) (SPADCALL |x| (QREFELT $ 53)))))
                (COND
                 ((> |k| 0)
                  (SEQ (SPADCALL |k| (QREFELT $ 37))
                       (EXIT
                        (LETT |x| (SPADCALL |x| (- |k|) (QREFELT $ 56)))))))
                (LETT |e| (|FLOAT;expSeries| |x| $))
                (COND ((> |k| 0) (LETT |e| (|FLOAT;square| |e| |k| $))))
                (SPADCALL |p| (QREFELT $ 60))
                (EXIT (SPADCALL |e| |e1| (QREFELT $ 54)))))
          #2# (EXIT #1#)))) 

(SDEFUN |FLOAT;expSeries| ((|x| ($)) ($ ($)))
        (SPROG
         ((|t| #1=(|Integer|)) (|s| #2=(|Integer|)) (|i| NIL) (|n| #1#)
          (|d| #2#) (|p| (|NonNegativeInteger|)))
         (SEQ
          (LETT |p|
                (+
                 (+ (SPADCALL (QREFELT $ 49))
                    (INTEGER-LENGTH (SPADCALL (QREFELT $ 49))))
                 1))
          (LETT |s| (LETT |d| (ASH 1 |p|)))
          (LETT |t|
                (LETT |n| (|FLOAT;shift2| (QCAR |x|) (+ (QCDR |x|) |p|) $)))
          (SEQ (LETT |i| 2) G190
               (COND ((NULL (SPADCALL |t| 0 (QREFELT $ 57))) (GO G191)))
               (SEQ (LETT |s| (+ |s| |t|))
                    (LETT |t| (QUOTIENT2 (* |n| |t|) |i|))
                    (EXIT (LETT |t| (QUOTIENT2 |t| |d|))))
               (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
          (EXIT (SPADCALL (CONS |s| (- |p|)) (QREFELT $ 42)))))) 

(SDEFUN |FLOAT;mat0|
        ((|n0| #1=(|Integer|)) (|bl| (|Integer|)) (|ki| (|Integer|))
         ($
          (|Record| (|:| |highn| (|Integer|))
                    (|:| |matr| (|Matrix| (|Integer|))))))
        (SPROG
         ((|i| #1#) (|m22| #2=(|Integer|)) (|m21| #3=(|Integer|))
          (|m12| (|Integer|)) (|m11| (|Integer|)) (|#G60| #4=(|Integer|))
          (|#G59| #4#) (|#G58| #2#) (|#G57| #3#))
         (SEQ (LETT |m11| 1) (LETT |m12| 0) (LETT |m21| 0) (LETT |m22| 1)
              (LETT |i| |n0|)
              (SEQ G190
                   (COND ((NULL (< (INTEGER-LENGTH |m11|) |bl|)) (GO G191)))
                   (SEQ
                    (PROGN
                     (LETT |#G57| |m21|)
                     (LETT |#G58| |m22|)
                     (LETT |#G59| (+ |m11| (* |i| |m21|)))
                     (LETT |#G60| (+ |m12| (* |i| |m22|)))
                     (LETT |m11| |#G57|)
                     (LETT |m12| |#G58|)
                     (LETT |m21| |#G59|)
                     (LETT |m22| |#G60|))
                    (EXIT (LETT |i| (+ |i| |ki|))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT
               (CONS |i|
                     (SPADCALL (LIST (LIST |m11| |m12|) (LIST |m21| |m22|))
                               (QREFELT $ 86))))))) 

(SDEFUN |FLOAT;mat1|
        ((|n0| (|Integer|)) (|bl| (|Integer|)) (|ki| (|Integer|))
         ($
          #1=(|Record| (|:| |highn| (|Integer|))
                       (|:| |matr| (|Matrix| (|Integer|))))))
        (SPROG
         ((|r2| #1#) (|bl1| (|Integer|)) (|m1| (|Matrix| (|Integer|)))
          (|r1| #1#))
         (SEQ
          (COND ((<= |bl| 300) (|FLOAT;mat0| |n0| |bl| |ki| $))
                ('T
                 (SEQ (LETT |bl1| (QUOTIENT2 |bl| 2))
                      (LETT |r1| (|FLOAT;mat1| |n0| |bl1| |ki| $))
                      (LETT |m1| (QCDR |r1|))
                      (LETT |bl1|
                            (- |bl|
                               (INTEGER-LENGTH
                                (SPADCALL |m1| 1 1 (QREFELT $ 87)))))
                      (LETT |r2| (|FLOAT;mat1| (QCAR |r1|) |bl1| |ki| $))
                      (EXIT
                       (CONS (QCAR |r2|)
                             (SPADCALL (QCDR |r2|) |m1| (QREFELT $ 88)))))))))) 

(SDEFUN |FLOAT;expInverse| ((|k| (|Integer|)) ($ ($)))
        (SPROG
         ((|q1| (|Integer|)) (|p1| (|Integer|)) (|mm0| (|Matrix| (|Integer|)))
          (|l| (|NonNegativeInteger|)) (|ki| #1=(|Integer|)) (|k0| #1#)
          (|q0| (|Integer|)) (|p0| (|Integer|)))
         (SEQ (LETT |p1| (+ (* 2 |k|) 1)) (LETT |p0| 1)
              (LETT |q1| (- (* 2 |k|) 1)) (LETT |q0| 1) (LETT |k0| (* 6 |k|))
              (LETT |ki| (* 4 |k|))
              (LETT |l| (QUOTIENT2 (+ (SPADCALL (QREFELT $ 49)) 1) 2))
              (LETT |mm0|
                    (SPADCALL (LIST (LIST |p0| |q0|) (LIST |p1| |q1|))
                              (QREFELT $ 86)))
              (LETT |mm0|
                    (SPADCALL (QCDR (|FLOAT;mat1| |k0| |l| |ki| $)) |mm0|
                              (QREFELT $ 88)))
              (LETT |p1| (SPADCALL |mm0| 2 1 (QREFELT $ 87)))
              (LETT |q1| (SPADCALL |mm0| 2 2 (QREFELT $ 87)))
              (EXIT (|FLOAT;dvide| (CONS |p1| 0) (CONS |q1| 0) $))))) 

(SDEFUN |FLOAT;exp1;$;34| (($ ($)))
        (SEQ
         (COND
          ((> (SPADCALL (QREFELT $ 49)) (QCAR (QREFELT $ 89)))
           (SETELT $ 89
                   (CONS (SPADCALL (QREFELT $ 49)) (|FLOAT;expInverse| 1 $)))))
         (EXIT (SPADCALL (QCDR (QREFELT $ 89)) (QREFELT $ 42))))) 

(SDEFUN |FLOAT;sqrt;2$;35| ((|x| ($)) ($ ($)))
        (SPROG
         ((|i| (|Integer|)) (|p| (|Integer|)) (|l| (|Integer|))
          (|e| (|Integer|)) (|m| (|Integer|)))
         (SEQ
          (COND
           ((SPADCALL |x| (QREFELT $ 25))
            (|error|
             (SPADCALL
              (LIST "sqrt: negative argument" ": "
                    (SPADCALL |x| (QREFELT $ 33)))
              (QREFELT $ 35))))
           ('T
            (SEQ (LETT |m| (QCAR |x|)) (LETT |e| (QCDR |x|))
                 (LETT |l| (INTEGER-LENGTH |m|))
                 (LETT |p| (+ (- (* 2 (SPADCALL (QREFELT $ 49))) |l|) 2))
                 (COND ((ODDP (- |e| |l|)) (LETT |p| (- |p| 1))))
                 (LETT |i| (|FLOAT;shift2| (QCAR |x|) |p| $))
                 (LETT |i| (SPADCALL |i| (QREFELT $ 52)))
                 (EXIT
                  (SPADCALL (CONS |i| (QUOTIENT2 (- |e| |p|) 2))
                            (QREFELT $ 42))))))))) 

(SDEFUN |FLOAT;bits;Pi;36| (($ (|PositiveInteger|))) (QREFELT $ 6)) 

(SDEFUN |FLOAT;bits;2Pi;37| ((|n| #1=(|PositiveInteger|)) ($ #1#))
        (SPROG ((|t| (|PositiveInteger|)))
               (SEQ (LETT |t| (QREFELT $ 6)) (SETELT $ 6 |n|) (EXIT |t|)))) 

(SDEFUN |FLOAT;precision;Pi;38| (($ (|PositiveInteger|)))
        (SPADCALL (QREFELT $ 49))) 

(SDEFUN |FLOAT;precision;2Pi;39| ((|n| #1=(|PositiveInteger|)) ($ #1#))
        (SPADCALL |n| (QREFELT $ 60))) 

(SDEFUN |FLOAT;increasePrecision;IPi;40|
        ((|n| (|Integer|)) ($ (|PositiveInteger|)))
        (SPROG ((#1=#:G1017 NIL) (|b| (|PositiveInteger|)))
               (SEQ (LETT |b| (SPADCALL (QREFELT $ 49)))
                    (SPADCALL
                     (PROG1 (LETT #1# (+ |b| |n|))
                       (|check_subtype2| (> #1# 0) '(|PositiveInteger|)
                                         '(|Integer|) #1#))
                     (QREFELT $ 60))
                    (EXIT |b|)))) 

(SDEFUN |FLOAT;decreasePrecision;IPi;41|
        ((|n| (|Integer|)) ($ (|PositiveInteger|)))
        (SPROG ((#1=#:G1021 NIL) (|b| (|PositiveInteger|)))
               (SEQ (LETT |b| (SPADCALL (QREFELT $ 49)))
                    (SPADCALL
                     (PROG1 (LETT #1# (- |b| |n|))
                       (|check_subtype2| (> #1# 0) '(|PositiveInteger|)
                                         '(|Integer|) #1#))
                     (QREFELT $ 60))
                    (EXIT |b|)))) 

(SDEFUN |FLOAT;ceillog10base2|
        ((|n| (|PositiveInteger|)) ($ (|PositiveInteger|)))
        (SPROG ((#1=#:G1025 NIL))
               (PROG1 (LETT #1# (QUOTIENT2 (+ (* 13301 |n|) 4003) 4004))
                 (|check_subtype2| (> #1# 0) '(|PositiveInteger|)
                                   '(|NonNegativeInteger|) #1#)))) 

(SDEFUN |FLOAT;digits;Pi;43| (($ (|PositiveInteger|)))
        (SPROG ((#1=#:G1028 NIL))
               (PROG1
                   (LETT #1#
                         (MAX 1
                              (QUOTIENT2
                               (* 4004 (- (SPADCALL (QREFELT $ 49)) 1))
                               13301)))
                 (|check_subtype2| (> #1# 0) '(|PositiveInteger|) '(|Integer|)
                                   #1#)))) 

(SDEFUN |FLOAT;digits;2Pi;44| ((|n| #1=(|PositiveInteger|)) ($ #1#))
        (SPROG ((|t| (|PositiveInteger|)))
               (SEQ (LETT |t| (SPADCALL (QREFELT $ 91)))
                    (SPADCALL (+ 1 (|FLOAT;ceillog10base2| |n| $))
                              (QREFELT $ 60))
                    (EXIT |t|)))) 

(SDEFUN |FLOAT;order;$I;45| ((|a| ($)) ($ (|Integer|)))
        (- (+ (INTEGER-LENGTH (QCAR |a|)) (QCDR |a|)) 1)) 

(SDEFUN |FLOAT;relerror;3$;46| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL
         (SPADCALL (SPADCALL |a| |b| (QREFELT $ 44)) |b| (QREFELT $ 39))
         (QREFELT $ 46))) 

(PUT '|FLOAT;Zero;$;47| '|SPADreplace| '(XLAM NIL (CONS 0 0))) 

(SDEFUN |FLOAT;Zero;$;47| (($ ($))) (CONS 0 0)) 

(PUT '|FLOAT;One;$;48| '|SPADreplace| '(XLAM NIL (CONS 1 0))) 

(SDEFUN |FLOAT;One;$;48| (($ ($))) (CONS 1 0)) 

(PUT '|FLOAT;base;Pi;49| '|SPADreplace| '(XLAM NIL 2)) 

(SDEFUN |FLOAT;base;Pi;49| (($ (|PositiveInteger|))) 2) 

(PUT '|FLOAT;mantissa;$I;50| '|SPADreplace| 'QCAR) 

(SDEFUN |FLOAT;mantissa;$I;50| ((|x| ($)) ($ (|Integer|))) (QCAR |x|)) 

(PUT '|FLOAT;exponent;$I;51| '|SPADreplace| 'QCDR) 

(SDEFUN |FLOAT;exponent;$I;51| ((|x| ($)) ($ (|Integer|))) (QCDR |x|)) 

(SDEFUN |FLOAT;one?;$B;52| ((|a| ($)) ($ (|Boolean|)))
        (SPADCALL |a| (|spadConstant| $ 28) (QREFELT $ 29))) 

(SDEFUN |FLOAT;zero?;$B;53| ((|a| ($)) ($ (|Boolean|))) (ZEROP (QCAR |a|))) 

(SDEFUN |FLOAT;negative?;$B;54| ((|a| ($)) ($ (|Boolean|))) (MINUSP (QCAR |a|))) 

(SDEFUN |FLOAT;positive?;$B;55| ((|a| ($)) ($ (|Boolean|))) (PLUSP (QCAR |a|))) 

(SDEFUN |FLOAT;chop| ((|x| ($)) (|p| (|PositiveInteger|)) ($ ($)))
        (SPROG ((|e| (|Integer|)))
               (SEQ (LETT |e| (- (INTEGER-LENGTH (QCAR |x|)) |p|))
                    (COND
                     ((> |e| 0)
                      (LETT |x|
                            (CONS (|FLOAT;shift2| (QCAR |x|) (- |e|) $)
                                  (+ (QCDR |x|) |e|)))))
                    (EXIT |x|)))) 

(SDEFUN |FLOAT;float;2I$;57| ((|m| #1=(|Integer|)) (|e| #1#) ($ ($)))
        (SPADCALL (CONS |m| |e|) (QREFELT $ 42))) 

(SDEFUN |FLOAT;float;2IPi$;58|
        ((|m| #1=(|Integer|)) (|e| #1#) (|b| (|PositiveInteger|)) ($ ($)))
        (SPROG ((|r| ($)))
               (SEQ
                (COND ((EQL |m| 0) (|spadConstant| $ 24))
                      ('T
                       (SEQ (SPADCALL 4 (QREFELT $ 37))
                            (LETT |r|
                                  (SPADCALL |m|
                                            (SPADCALL (CONS |b| 0) |e|
                                                      (QREFELT $ 77))
                                            (QREFELT $ 62)))
                            (SPADCALL 4 (QREFELT $ 41))
                            (EXIT (SPADCALL |r| (QREFELT $ 42))))))))) 

(SDEFUN |FLOAT;normalize;2$;59| ((|x| ($)) ($ ($)))
        (SPROG ((|y| (|Integer|)) (|e| (|Integer|)) (|m| (|Integer|)))
               (SEQ (LETT |m| (QCAR |x|))
                    (EXIT
                     (COND ((EQL |m| 0) (|spadConstant| $ 24))
                           (#1='T
                            (SEQ
                             (LETT |e|
                                   (- (INTEGER-LENGTH |m|)
                                      (SPADCALL (QREFELT $ 49))))
                             (COND
                              ((> |e| 0)
                               (SEQ (LETT |y| (|FLOAT;shift2| |m| (- 1 |e|) $))
                                    (COND
                                     ((ODDP |y|)
                                      (SEQ
                                       (LETT |y|
                                             (QUOTIENT2
                                              (COND ((> |y| 0) (+ |y| 1))
                                                    (#1# (- |y| 1)))
                                              2))
                                       (EXIT
                                        (COND
                                         ((> (INTEGER-LENGTH |y|)
                                             (SPADCALL (QREFELT $ 49)))
                                          (SEQ (LETT |y| (QUOTIENT2 |y| 2))
                                               (EXIT
                                                (LETT |e| (+ |e| 1)))))))))
                                     (#1# (LETT |y| (QUOTIENT2 |y| 2))))
                                    (EXIT
                                     (LETT |x|
                                           (CONS |y| (+ (QCDR |x|) |e|)))))))
                             (EXIT |x|)))))))) 

(SDEFUN |FLOAT;shift;$I$;60| ((|x| ($)) (|n| (|Integer|)) ($ ($)))
        (CONS (QCAR |x|) (+ (QCDR |x|) |n|))) 

(SDEFUN |FLOAT;=;2$B;61| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (COND ((EQL (QCDR |x|) (QCDR |y|)) (EQL (QCAR |x|) (QCAR |y|)))
              ((EQL (SPADCALL |x| (QREFELT $ 53))
                    (SPADCALL |y| (QREFELT $ 53)))
               (COND
                ((EQL (SPADCALL |x| (QREFELT $ 58))
                      (SPADCALL |y| (QREFELT $ 58)))
                 (SPADCALL (SPADCALL |x| |y| (QREFELT $ 44)) (QREFELT $ 23)))
                (#1='T NIL)))
              (#1# NIL))) 

(SDEFUN |FLOAT;<;2$B;62| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SEQ
         (COND ((EQL (QCAR |y|) 0) (< (QCAR |x|) 0))
               ((EQL (QCAR |x|) 0) (> (QCAR |y|) 0))
               (#1='T
                (SEQ
                 (COND
                  ((SPADCALL |x| (QREFELT $ 25))
                   (COND ((SPADCALL |y| (QREFELT $ 96)) (EXIT 'T)))))
                 (COND
                  ((SPADCALL |y| (QREFELT $ 25))
                   (COND ((SPADCALL |x| (QREFELT $ 96)) (EXIT NIL)))))
                 (EXIT
                  (COND
                   ((< (SPADCALL |x| (QREFELT $ 53))
                       (SPADCALL |y| (QREFELT $ 53)))
                    (SPADCALL |x| (QREFELT $ 96)))
                   ((> (SPADCALL |x| (QREFELT $ 53))
                       (SPADCALL |y| (QREFELT $ 53)))
                    (SPADCALL |x| (QREFELT $ 25)))
                   (#1#
                    (SPADCALL (SPADCALL |x| |y| (QREFELT $ 44))
                              (QREFELT $ 25)))))))))) 

(SDEFUN |FLOAT;abs;2$;63| ((|x| ($)) ($ ($)))
        (COND ((SPADCALL |x| (QREFELT $ 25)) (SPADCALL |x| (QREFELT $ 26)))
              ('T (SPADCALL |x| (QREFELT $ 42))))) 

(SDEFUN |FLOAT;ceiling;2$;64| ((|x| ($)) ($ ($)))
        (SPROG ((#1=#:G1080 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((SPADCALL |x| (QREFELT $ 25))
                    (PROGN
                     (LETT #1#
                           (SPADCALL
                            (SPADCALL (SPADCALL |x| (QREFELT $ 26))
                                      (QREFELT $ 99))
                            (QREFELT $ 26)))
                     (GO #2=#:G1079))))
                  (EXIT
                   (COND
                    ((SPADCALL (SPADCALL |x| (QREFELT $ 48)) (QREFELT $ 23))
                     |x|)
                    ('T
                     (SPADCALL (SPADCALL |x| (QREFELT $ 100))
                               (|spadConstant| $ 28) (QREFELT $ 55)))))))
                #2# (EXIT #1#)))) 

(SDEFUN |FLOAT;wholePart;$I;65| ((|x| ($)) ($ (|Integer|)))
        (|FLOAT;shift2| (QCAR |x|) (QCDR |x|) $)) 

(SDEFUN |FLOAT;floor;2$;66| ((|x| ($)) ($ ($)))
        (COND
         ((SPADCALL |x| (QREFELT $ 25))
          (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 26)) (QREFELT $ 101))
                    (QREFELT $ 26)))
         ('T (SPADCALL |x| (QREFELT $ 100))))) 

(SDEFUN |FLOAT;round;2$;67| ((|x| ($)) ($ ($)))
        (SPROG ((|half| ($)))
               (SEQ (LETT |half| (CONS (SPADCALL |x| (QREFELT $ 58)) -1))
                    (EXIT
                     (SPADCALL (SPADCALL |x| |half| (QREFELT $ 55))
                               (QREFELT $ 100)))))) 

(SDEFUN |FLOAT;sign;$I;68| ((|x| ($)) ($ (|Integer|)))
        (COND ((< (QCAR |x|) 0) -1) ('T 1))) 

(SDEFUN |FLOAT;truncate;2$;69| ((|x| ($)) ($ ($)))
        (SPROG ((#1=#:G1093 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((>= (QCDR |x|) 0) (PROGN (LETT #1# |x|) (GO #2=#:G1092))))
                  (EXIT
                   (SPADCALL (CONS (|FLOAT;shift2| (QCAR |x|) (QCDR |x|) $) 0)
                             (QREFELT $ 42)))))
                #2# (EXIT #1#)))) 

(SDEFUN |FLOAT;recip;$U;70| ((|x| ($)) ($ (|Union| $ "failed")))
        (COND
         ((SPADCALL |x| (|spadConstant| $ 24) (QREFELT $ 29))
          (CONS 1 "failed"))
         ('T (CONS 0 (SPADCALL (|spadConstant| $ 28) |x| (QREFELT $ 39)))))) 

(SDEFUN |FLOAT;differentiate;2$;71| ((|x| ($)) ($ ($))) (|spadConstant| $ 24)) 

(SDEFUN |FLOAT;-;2$;72| ((|x| ($)) ($ ($)))
        (SPADCALL (|FLOAT;negate| |x| $) (QREFELT $ 42))) 

(SDEFUN |FLOAT;negate| ((|x| ($)) ($ ($))) (CONS (- (QCAR |x|)) (QCDR |x|))) 

(SDEFUN |FLOAT;+;3$;74| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPADCALL (|FLOAT;plus| |x| |y| $) (QREFELT $ 42))) 

(SDEFUN |FLOAT;-;3$;75| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPADCALL (|FLOAT;plus| |x| (|FLOAT;negate| |y| $) $) (QREFELT $ 42))) 

(SDEFUN |FLOAT;sub| ((|x| ($)) (|y| ($)) ($ ($)))
        (|FLOAT;plus| |x| (|FLOAT;negate| |y| $) $)) 

(SDEFUN |FLOAT;plus| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG
         ((|mw| (|Integer|)) (|ey| #1=(|Integer|)) (|ex| #1#)
          (|my| #2=(|Integer|)) (|mx| #2#) (|#G119| #1#) (|#G118| #1#)
          (|#G117| #2#) (|#G116| #2#) (|de| (|Integer|)))
         (SEQ (LETT |mx| (QCAR |x|)) (LETT |my| (QCAR |y|))
              (EXIT
               (COND ((EQL |mx| 0) |y|) ((EQL |my| 0) |x|)
                     (#3='T
                      (SEQ (LETT |ex| (QCDR |x|)) (LETT |ey| (QCDR |y|))
                           (EXIT
                            (COND ((EQL |ex| |ey|) (CONS (+ |mx| |my|) |ex|))
                                  (#3#
                                   (SEQ
                                    (LETT |de|
                                          (-
                                           (- (+ |ex| (INTEGER-LENGTH |mx|))
                                              |ey|)
                                           (INTEGER-LENGTH |my|)))
                                    (EXIT
                                     (COND
                                      ((> |de| (+ (SPADCALL (QREFELT $ 49)) 1))
                                       |x|)
                                      ((< |de|
                                          (- (+ (SPADCALL (QREFELT $ 49)) 1)))
                                       |y|)
                                      (#3#
                                       (SEQ
                                        (COND
                                         ((< |ex| |ey|)
                                          (PROGN
                                           (LETT |#G116| |my|)
                                           (LETT |#G117| |mx|)
                                           (LETT |#G118| |ey|)
                                           (LETT |#G119| |ex|)
                                           (LETT |mx| |#G116|)
                                           (LETT |my| |#G117|)
                                           (LETT |ex| |#G118|)
                                           (LETT |ey| |#G119|))))
                                        (LETT |mw|
                                              (+ |my|
                                                 (|FLOAT;shift2| |mx|
                                                  (- |ex| |ey|) $)))
                                        (EXIT (CONS |mw| |ey|))))))))))))))))) 

(SDEFUN |FLOAT;*;3$;78| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPADCALL (|FLOAT;times| |x| |y| $) (QREFELT $ 42))) 

(SDEFUN |FLOAT;*;I2$;79| ((|x| (|Integer|)) (|y| ($)) ($ ($)))
        (COND
         ((> (INTEGER-LENGTH |x|) (SPADCALL (QREFELT $ 49)))
          (SPADCALL (SPADCALL (CONS |x| 0) (QREFELT $ 42)) |y| (QREFELT $ 54)))
         ('T (SPADCALL (CONS (* |x| (QCAR |y|)) (QCDR |y|)) (QREFELT $ 42))))) 

(SDEFUN |FLOAT;/;3$;80| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPADCALL (|FLOAT;dvide| |x| |y| $) (QREFELT $ 42))) 

(SDEFUN |FLOAT;/;$I$;81| ((|x| ($)) (|y| (|Integer|)) ($ ($)))
        (COND
         ((> (INTEGER-LENGTH |y|) (SPADCALL (QREFELT $ 49)))
          (SPADCALL |x| (SPADCALL (CONS |y| 0) (QREFELT $ 42)) (QREFELT $ 39)))
         ('T (SPADCALL |x| (CONS |y| 0) (QREFELT $ 39))))) 

(SDEFUN |FLOAT;inv;2$;82| ((|x| ($)) ($ ($)))
        (SPADCALL (|spadConstant| $ 28) |x| (QREFELT $ 39))) 

(SDEFUN |FLOAT;times| ((|x| ($)) (|y| ($)) ($ ($)))
        (CONS (* (QCAR |x|) (QCAR |y|)) (+ (QCDR |x|) (QCDR |y|)))) 

(SDEFUN |FLOAT;itimes| ((|n| (|Integer|)) (|y| ($)) ($ ($)))
        (CONS (* |n| (QCAR |y|)) (QCDR |y|))) 

(SDEFUN |FLOAT;dvide| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG ((|ew| (|Integer|)) (|mw| (|Integer|)))
               (SEQ
                (LETT |ew|
                      (+
                       (+
                        (- (INTEGER-LENGTH (QCAR |y|))
                           (INTEGER-LENGTH (QCAR |x|)))
                        (SPADCALL (QREFELT $ 49)))
                       1))
                (LETT |mw|
                      (QUOTIENT2 (|FLOAT;shift2| (QCAR |x|) |ew| $)
                                 (QCAR |y|)))
                (LETT |ew| (- (- (QCDR |x|) (QCDR |y|)) |ew|))
                (EXIT (CONS |mw| |ew|))))) 

(SDEFUN |FLOAT;square| ((|x| ($)) (|n| (|Integer|)) ($ ($)))
        (SPROG
         ((|ex| (|Integer|)) (|ma| (|Integer|)) (|l| (|Integer|))
          (#1=#:G1133 NIL) (|k| NIL))
         (SEQ (LETT |ma| (QCAR |x|)) (LETT |ex| (QCDR |x|))
              (SEQ (LETT |k| 1) (LETT #1# |n|) G190
                   (COND ((|greater_SI| |k| #1#) (GO G191)))
                   (SEQ (LETT |ma| (* |ma| |ma|)) (LETT |ex| (+ |ex| |ex|))
                        (LETT |l|
                              (- (SPADCALL (QREFELT $ 49))
                                 (INTEGER-LENGTH |ma|)))
                        (LETT |ma| (|FLOAT;shift2| |ma| |l| $))
                        (EXIT (LETT |ex| (- |ex| |l|))))
                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |ma| |ex|))))) 

(SDEFUN |FLOAT;power| ((|x| ($)) (|n| (|Integer|)) ($ ($)))
        (SPROG ((|z| ($)) (#1=#:G1141 NIL) (|y| ($)))
               (SEQ
                (EXIT
                 (SEQ (LETT |y| (|spadConstant| $ 28)) (LETT |z| |x|)
                      (EXIT
                       (SEQ G190 NIL
                            (SEQ
                             (COND
                              ((ODDP |n|)
                               (LETT |y|
                                     (|FLOAT;chop| (|FLOAT;times| |y| |z| $)
                                      (SPADCALL (QREFELT $ 49)) $))))
                             (SEQ (LETT |n| (QUOTIENT2 |n| 2))
                                  (EXIT
                                   (COND
                                    ((EQL |n| 0)
                                     (PROGN (LETT #1# |y|) (GO #2=#:G1140))))))
                             (EXIT
                              (LETT |z|
                                    (|FLOAT;chop| (|FLOAT;times| |z| |z| $)
                                     (SPADCALL (QREFELT $ 49)) $))))
                            NIL (GO G190) G191 (EXIT NIL)))))
                #2# (EXIT #1#)))) 

(SDEFUN |FLOAT;^;3$;88| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG ((|r| ($)) (|p| (|Integer|)))
               (SEQ
                (COND
                 ((SPADCALL |x| (|spadConstant| $ 24) (QREFELT $ 29))
                  (COND
                   ((SPADCALL |y| (|spadConstant| $ 24) (QREFELT $ 29))
                    (|error| "0^0 is undefined"))
                   ((SPADCALL |y| (|spadConstant| $ 24) (QREFELT $ 45))
                    (|error| "division by 0"))
                   (#1='T (|spadConstant| $ 24))))
                 ((SPADCALL |y| (|spadConstant| $ 24) (QREFELT $ 29))
                  (|spadConstant| $ 28))
                 ((SPADCALL |y| (|spadConstant| $ 28) (QREFELT $ 29)) |x|)
                 ((SPADCALL |x| (|spadConstant| $ 28) (QREFELT $ 29))
                  (|spadConstant| $ 28))
                 (#1#
                  (SEQ (LETT |p| (+ (ABS (SPADCALL |y| (QREFELT $ 53))) 5))
                       (SPADCALL |p| (QREFELT $ 37))
                       (LETT |r|
                             (SPADCALL
                              (SPADCALL |y| (SPADCALL |x| (QREFELT $ 72))
                                        (QREFELT $ 54))
                              (QREFELT $ 68)))
                       (SPADCALL |p| (QREFELT $ 41))
                       (EXIT (SPADCALL |r| (QREFELT $ 42))))))))) 

(SDEFUN |FLOAT;^;$F$;89| ((|x| ($)) (|r| (|Fraction| (|Integer|))) ($ ($)))
        (SPROG ((|y| ($)) (#1=#:G1152 NIL) (|d| (|Integer|)) (|n| (|Integer|)))
               (SEQ
                (EXIT
                 (COND
                  ((SPADCALL |x| (|spadConstant| $ 24) (QREFELT $ 29))
                   (COND
                    ((SPADCALL |r| (|spadConstant| $ 109) (QREFELT $ 110))
                     (|spadConstant| $ 28))
                    ((SPADCALL |r| (|spadConstant| $ 109) (QREFELT $ 111))
                     (|error| "division by 0"))
                    (#2='T (|spadConstant| $ 24))))
                  ((SPADCALL |r| (|spadConstant| $ 109) (QREFELT $ 110))
                   (|spadConstant| $ 28))
                  ((SPADCALL |r| (|spadConstant| $ 112) (QREFELT $ 110)) |x|)
                  ((SPADCALL |x| (|spadConstant| $ 28) (QREFELT $ 29))
                   (|spadConstant| $ 28))
                  (#2#
                   (SEQ (LETT |n| (SPADCALL |r| (QREFELT $ 113)))
                        (LETT |d| (SPADCALL |r| (QREFELT $ 114)))
                        (EXIT
                         (COND
                          ((SPADCALL |x| (QREFELT $ 25))
                           (COND
                            ((ODDP |d|)
                             (COND
                              ((ODDP |n|)
                               (PROGN
                                (LETT #1#
                                      (SPADCALL
                                       (SPADCALL (SPADCALL |x| (QREFELT $ 26))
                                                 |r| (QREFELT $ 115))
                                       (QREFELT $ 26)))
                                (GO #3=#:G1151)))
                              (#2#
                               (PROGN
                                (LETT #1#
                                      (SPADCALL (SPADCALL |x| (QREFELT $ 26))
                                                |r| (QREFELT $ 115)))
                                (GO #3#)))))
                            (#2# (|error| "negative root"))))
                          (#2#
                           (SEQ
                            (COND
                             ((EQL |d| 2)
                              (COND
                               ((EQL |n| 1)
                                (PROGN
                                 (LETT #1# (SPADCALL |x| (QREFELT $ 38)))
                                 (GO #3#)))
                               (#2#
                                (SEQ
                                 (SPADCALL (INTEGER-LENGTH |n|) (QREFELT $ 37))
                                 (LETT |y| (SPADCALL |x| (QREFELT $ 38)))
                                 (LETT |y| (SPADCALL |y| |n| (QREFELT $ 77)))
                                 (SPADCALL (INTEGER-LENGTH |n|) (QREFELT $ 41))
                                 (EXIT
                                  (PROGN
                                   (LETT #1# (SPADCALL |y| (QREFELT $ 42)))
                                   (GO #3#))))))))
                            (LETT |y|
                                  (SPADCALL (CONS |n| 0) (CONS |d| 0)
                                            (QREFELT $ 39)))
                            (EXIT (SPADCALL |x| |y| (QREFELT $ 107)))))))))))
                #3# (EXIT #1#)))) 

(SDEFUN |FLOAT;^;$I$;90| ((|x| ($)) (|n| (|Integer|)) ($ ($)))
        (SPROG ((|y| ($)) (|p| (|PositiveInteger|)))
               (SEQ
                (COND
                 ((SPADCALL |x| (|spadConstant| $ 24) (QREFELT $ 29))
                  (COND ((EQL |n| 0) (|spadConstant| $ 28))
                        ((< |n| 0) (|error| "division by 0"))
                        (#1='T (|spadConstant| $ 24))))
                 ((EQL |n| 0) (|spadConstant| $ 28)) ((EQL |n| 1) |x|)
                 ((SPADCALL |x| (|spadConstant| $ 28) (QREFELT $ 29))
                  (|spadConstant| $ 28))
                 (#1#
                  (SEQ (LETT |p| (SPADCALL (QREFELT $ 49)))
                       (SPADCALL (+ (+ |p| (INTEGER-LENGTH |n|)) 2)
                                 (QREFELT $ 60))
                       (LETT |y| (|FLOAT;power| |x| (ABS |n|) $))
                       (COND
                        ((< |n| 0)
                         (LETT |y|
                               (|FLOAT;dvide| (|spadConstant| $ 28) |y| $))))
                       (SPADCALL |p| (QREFELT $ 60))
                       (EXIT (SPADCALL |y| (QREFELT $ 42))))))))) 

(SDEFUN |FLOAT;convert10| ((|x| ($)) (|d| (|Integer|)) ($ ($)))
        (SPROG
         ((|h| ($)) (|r| #1=(|Integer|)) (#2=#:G1158 NIL)
          (|b| (|PositiveInteger|)) (|q| #3=(|Integer|))
          (|#G149| (|Record| (|:| |quotient| #3#) (|:| |remainder| #1#)))
          (|e| (|Integer|)) (|m| (|Integer|)))
         (SEQ (LETT |m| (QCAR |x|)) (LETT |e| (QCDR |x|))
              (LETT |b| (SPADCALL (QREFELT $ 49)))
              (PROGN
               (LETT |#G149| (DIVIDE2 (ABS |e|) |b|))
               (LETT |q| (QCAR |#G149|))
               (LETT |r| (QCDR |#G149|))
               |#G149|)
              (LETT |b| (EXPT 2 |b|))
              (LETT |r|
                    (EXPT 2
                          (PROG1 (LETT #2# |r|)
                            (|check_subtype2| (>= #2# 0)
                                              '(|NonNegativeInteger|)
                                              '(|Integer|) #2#))))
              (LETT |h| (|FLOAT;power10| (CONS |b| 0) |q| (+ |d| 5) $))
              (LETT |h|
                    (|FLOAT;chop10| (CONS (* |r| (QCAR |h|)) (QCDR |h|))
                     (+ |d| 5) $))
              (EXIT
               (COND
                ((< |e| 0)
                 (LETT |h| (|FLOAT;quotient10| (CONS |m| 0) |h| |d| $)))
                ('T (|FLOAT;times10| (CONS |m| 0) |h| |d| $))))))) 

(SDEFUN |FLOAT;ceilLength10| ((|n| (|Integer|)) ($ (|Integer|)))
        (+ (QUOTIENT2 (* 146 (INTEGER-LENGTH |n|)) 485) 1)) 

(SDEFUN |FLOAT;floorLength10| ((|n| (|Integer|)) ($ (|Integer|)))
        (QUOTIENT2 (* 643 (INTEGER-LENGTH |n|)) 2136)) 

(SDEFUN |FLOAT;length10| ((|n| (|Integer|)) ($ (|Integer|)))
        (SPROG
         ((|lower| #1=(|Integer|)) (#2=#:G1166 NIL) (|upper| #1#)
          (|ln| (|Integer|)))
         (SEQ (LETT |ln| (INTEGER-LENGTH (LETT |n| (ABS |n|))))
              (LETT |upper| (QUOTIENT2 (* 76573 |ln|) 254370))
              (LETT |lower| (QUOTIENT2 (* 21306 (- |ln| 1)) 70777))
              (EXIT
               (COND ((EQL |upper| |lower|) (+ |upper| 1))
                     ('T
                      (SEQ
                       (LETT |n|
                             (QUOTIENT2 |n|
                                        (EXPT 10
                                              (PROG1 (LETT #2# |lower|)
                                                (|check_subtype2| (>= #2# 0)
                                                                  '(|NonNegativeInteger|)
                                                                  '(|Integer|)
                                                                  #2#)))))
                       (SEQ G190 (COND ((NULL (>= |n| 10)) (GO G191)))
                            (SEQ (LETT |n| (QUOTIENT2 |n| 10))
                                 (EXIT (LETT |lower| (+ |lower| 1))))
                            NIL (GO G190) G191 (EXIT NIL))
                       (EXIT (+ |lower| 1))))))))) 

(SDEFUN |FLOAT;chop10| ((|x| ($)) (|p| (|Integer|)) ($ ($)))
        (SPROG ((#1=#:G1174 NIL) (|e| (|Integer|)))
               (SEQ (LETT |e| (- (|FLOAT;floorLength10| (QCAR |x|) $) |p|))
                    (COND
                     ((> |e| 0)
                      (LETT |x|
                            (CONS
                             (QUOTIENT2 (QCAR |x|)
                                        (EXPT 10
                                              (PROG1 (LETT #1# |e|)
                                                (|check_subtype2| (>= #1# 0)
                                                                  '(|NonNegativeInteger|)
                                                                  '(|Integer|)
                                                                  #1#))))
                             (+ (QCDR |x|) |e|)))))
                    (EXIT |x|)))) 

(SDEFUN |FLOAT;normalize10| ((|x| ($)) (|p| (|Integer|)) ($ ($)))
        (SPROG
         ((|ex| (|Integer|)) (|ma| (|Integer|)) (#1=#:G1182 NIL)
          (|r| #2=(|Integer|))
          (|#G159|
           (|Record| (|:| |quotient| (|Integer|)) (|:| |remainder| #2#)))
          (#3=#:G1178 NIL) (|e| (|Integer|)))
         (SEQ (LETT |ma| (QCAR |x|)) (LETT |ex| (QCDR |x|))
              (LETT |e| (- (|FLOAT;length10| |ma| $) |p|))
              (COND
               ((> |e| 0)
                (SEQ
                 (LETT |ma|
                       (QUOTIENT2 |ma|
                                  (EXPT 10
                                        (PROG1 (LETT #3# (- |e| 1))
                                          (|check_subtype2| (>= #3# 0)
                                                            '(|NonNegativeInteger|)
                                                            '(|Integer|)
                                                            #3#)))))
                 (LETT |ex| (+ |ex| |e|))
                 (PROGN
                  (LETT |#G159| (DIVIDE2 |ma| 10))
                  (LETT |ma| (QCAR |#G159|))
                  (LETT |r| (QCDR |#G159|))
                  |#G159|)
                 (EXIT
                  (COND
                   ((> |r| 4)
                    (SEQ (LETT |ma| (+ |ma| 1))
                         (EXIT
                          (COND
                           ((EQL |ma|
                                 (EXPT 10
                                       (PROG1 (LETT #1# |p|)
                                         (|check_subtype2| (>= #1# 0)
                                                           '(|NonNegativeInteger|)
                                                           '(|Integer|) #1#))))
                            (SEQ (LETT |ma| 1)
                                 (EXIT (LETT |ex| (+ |ex| |p|))))))))))))))
              (EXIT (CONS |ma| |ex|))))) 

(SDEFUN |FLOAT;times10| ((|x| ($)) (|y| ($)) (|p| (|Integer|)) ($ ($)))
        (|FLOAT;normalize10| (|FLOAT;times| |x| |y| $) |p| $)) 

(SDEFUN |FLOAT;quotient10| ((|x| ($)) (|y| ($)) (|p| (|Integer|)) ($ ($)))
        (SPROG ((|ew| (|Integer|)) (|mw| (|Integer|)) (#1=#:G1215 NIL))
               (SEQ
                (LETT |ew|
                      (+
                       (+
                        (- (|FLOAT;floorLength10| (QCAR |y|) $)
                           (|FLOAT;ceilLength10| (QCAR |x|) $))
                        |p|)
                       2))
                (COND ((< |ew| 0) (LETT |ew| 0)))
                (LETT |mw|
                      (QUOTIENT2
                       (* (QCAR |x|)
                          (EXPT 10
                                (PROG1 (LETT #1# |ew|)
                                  (|check_subtype2| (>= #1# 0)
                                                    '(|NonNegativeInteger|)
                                                    '(|Integer|) #1#))))
                       (QCAR |y|)))
                (LETT |ew| (- (- (QCDR |x|) (QCDR |y|)) |ew|))
                (EXIT (|FLOAT;normalize10| (CONS |mw| |ew|) |p| $))))) 

(SDEFUN |FLOAT;power10|
        ((|x| ($)) (|n| #1=(|Integer|)) (|d| (|Integer|)) ($ ($)))
        (SPROG
         ((|z| ($)) (#2=#:G1225 NIL) (|e| #1#) (|y| ($)) (|p| (|Integer|)))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL |x| (|spadConstant| $ 24) (QREFELT $ 29))
             (|spadConstant| $ 24))
            ((EQL |n| 0) (|spadConstant| $ 28)) ((EQL |n| 1) |x|)
            ((SPADCALL |x| (|spadConstant| $ 28) (QREFELT $ 29))
             (|spadConstant| $ 28))
            ('T
             (SEQ (LETT |p| (+ (+ |d| (INTEGER-LENGTH |n|)) 1)) (LETT |e| |n|)
                  (LETT |y| (|spadConstant| $ 28)) (LETT |z| |x|)
                  (EXIT
                   (SEQ G190 NIL
                        (SEQ
                         (COND
                          ((ODDP |e|)
                           (LETT |y|
                                 (|FLOAT;chop10| (|FLOAT;times| |y| |z| $) |p|
                                  $))))
                         (SEQ (LETT |e| (QUOTIENT2 |e| 2))
                              (EXIT
                               (COND
                                ((EQL |e| 0)
                                 (PROGN (LETT #2# |y|) (GO #3=#:G1224))))))
                         (EXIT
                          (LETT |z|
                                (|FLOAT;chop10| (|FLOAT;times| |z| |z| $) |p|
                                 $))))
                        NIL (GO G190) G191 (EXIT NIL)))))))
          #3# (EXIT #2#)))) 

(SDEFUN |FLOAT;padFromLeft| ((|s| (|String|)) ($ (|String|)))
        (SPROG
         ((|j| (|Integer|)) (#1=#:G1234 NIL) (|i| NIL) (|t| (|String|))
          (#2=#:G1227 NIL) (|n| (|Integer|)))
         (SEQ
          (COND ((ZEROP (QREFELT $ 116)) |s|)
                ('T
                 (SEQ (LETT |n| (- (QCSIZE |s|) 1))
                      (LETT |t|
                            (|make_full_CVEC2|
                             (PROG1
                                 (LETT #2#
                                       (+ (+ |n| 1)
                                          (QUOTIENT2 |n| (QREFELT $ 116))))
                               (|check_subtype2| (>= #2# 0)
                                                 '(|NonNegativeInteger|)
                                                 '(|Integer|) #2#))
                             (SPADCALL (QREFELT $ 120))))
                      (SEQ (LETT |j| (SPADCALL |t| (QREFELT $ 121)))
                           (LETT |i| 0) (LETT #1# |n|) G190
                           (COND ((|greater_SI| |i| #1#) (GO G191)))
                           (SEQ
                            (SPADCALL |t| |j|
                                      (SPADCALL |s|
                                                (+ |i|
                                                   (SPADCALL |s|
                                                             (QREFELT $ 121)))
                                                (QREFELT $ 122))
                                      (QREFELT $ 123))
                            (EXIT
                             (COND
                              ((EQL (REM (+ |i| 1) (QREFELT $ 116)) 0)
                               (LETT |j| (+ |j| 1))))))
                           (LETT |i|
                                 (PROG1 (|inc_SI| |i|) (LETT |j| (+ |j| 1))))
                           (GO G190) G191 (EXIT NIL))
                      (EXIT |t|))))))) 

(SDEFUN |FLOAT;padFromRight| ((|s| (|String|)) ($ (|String|)))
        (SPROG
         ((|j| #1=(|Integer|)) (|i| NIL) (|t| (|String|)) (#2=#:G1236 NIL)
          (|n| #1#))
         (SEQ
          (COND ((EQL (QREFELT $ 116) 0) |s|)
                ('T
                 (SEQ (LETT |n| (- (QCSIZE |s|) 1))
                      (LETT |t|
                            (|make_full_CVEC2|
                             (PROG1
                                 (LETT #2#
                                       (+ (+ |n| 1)
                                          (QUOTIENT2 |n| (QREFELT $ 116))))
                               (|check_subtype2| (>= #2# 0)
                                                 '(|NonNegativeInteger|)
                                                 '(|Integer|) #2#))
                             (SPADCALL (QREFELT $ 120))))
                      (SEQ (LETT |j| (SPADCALL |t| (QREFELT $ 124)))
                           (LETT |i| |n|) G190 (COND ((< |i| 0) (GO G191)))
                           (SEQ
                            (SPADCALL |t| |j|
                                      (SPADCALL |s|
                                                (+ |i|
                                                   (SPADCALL |s|
                                                             (QREFELT $ 121)))
                                                (QREFELT $ 122))
                                      (QREFELT $ 123))
                            (EXIT
                             (COND
                              ((EQL (REM (+ (- |n| |i|) 1) (QREFELT $ 116)) 0)
                               (LETT |j| (- |j| 1))))))
                           (LETT |i| (PROG1 (+ |i| -1) (LETT |j| (+ |j| -1))))
                           (GO G190) G191 (EXIT NIL))
                      (EXIT |t|))))))) 

(SDEFUN |FLOAT;fixed| ((|f| ($)) ($ (|String|)))
        (SPROG
         ((|t| (|String|)) (#1=#:G1262 NIL) (|n| (|NonNegativeInteger|))
          (|s| (|String|)) (#2=#:G1258 NIL) (#3=#:G1256 NIL)
          (|p| #4=(|Integer|)) (|o| #5=(|Integer|)) (|e| (|Integer|))
          (|m| (|Integer|)) (|g| ($)) (|l| (|Integer|)) (|dd| #4#) (|bl| #5#)
          (#6=#:G1248 NIL) (#7=#:G1244 NIL) (|d| #4#))
         (SEQ
          (LETT |d|
                (COND ((EQL (QREFELT $ 118) -1) (SPADCALL (QREFELT $ 91)))
                      (#8='T (QREFELT $ 118))))
          (EXIT
           (COND
            ((SPADCALL |f| (QREFELT $ 23))
             (COND ((EQL (QREFELT $ 118) -1) "0.0")
                   (#8#
                    (STRCONC "0"
                             (STRCONC "."
                                      (|FLOAT;padFromLeft|
                                       (|make_full_CVEC2|
                                        (PROG1 (LETT #7# |d|)
                                          (|check_subtype2| (>= #7# 0)
                                                            '(|NonNegativeInteger|)
                                                            '(|Integer|) #7#))
                                        (|STR_to_CHAR| #9="0"))
                                       $))))))
            ((ZEROP (SPADCALL |f| (QREFELT $ 16)))
             (STRCONC
              (|FLOAT;padFromRight| (STRINGIMAGE (SPADCALL |f| (QREFELT $ 14)))
               $)
              (STRCONC "."
                       (|FLOAT;padFromLeft|
                        (|make_full_CVEC2|
                         (PROG1 (LETT #6# |d|)
                           (|check_subtype2| (>= #6# 0) '(|NonNegativeInteger|)
                                             '(|Integer|) #6#))
                         (|STR_to_CHAR| #9#))
                        $))))
            ((SPADCALL |f| (QREFELT $ 25))
             (STRCONC "-" (|FLOAT;fixed| (SPADCALL |f| (QREFELT $ 46)) $)))
            (#8#
             (SEQ (LETT |bl| (+ (INTEGER-LENGTH (QCAR |f|)) (QCDR |f|)))
                  (LETT |dd|
                        (COND
                         ((OR (EQL (QREFELT $ 118) -1) (NULL (> |bl| 0))) |d|)
                         ('T (+ (+ (QUOTIENT2 (* 146 |bl|) 485) 1) |d|))))
                  (LETT |g|
                        (|FLOAT;convert10| (SPADCALL |f| (QREFELT $ 46)) |dd|
                         $))
                  (LETT |m| (QCAR |g|)) (LETT |e| (QCDR |g|))
                  (COND
                   ((SPADCALL (QREFELT $ 118) -1 (QREFELT $ 57))
                    (SEQ (LETT |l| (|FLOAT;length10| |m| $))
                         (EXIT
                          (COND
                           ((> (- |e|) (QREFELT $ 118))
                            (COND
                             ((< (- |e|) (* 2 (SPADCALL (QREFELT $ 91))))
                              (SEQ
                               (LETT |g|
                                     (|FLOAT;normalize10| |g|
                                      (+ (+ |l| |e|) (QREFELT $ 118)) $))
                               (LETT |m| (QCAR |g|))
                               (EXIT (LETT |e| (QCDR |g|))))))))))))
                  (LETT |s| (STRINGIMAGE |m|)) (LETT |n| (QCSIZE |s|))
                  (LETT |o| (+ |e| |n|))
                  (LETT |p|
                        (COND ((EQL (QREFELT $ 118) -1) |n|)
                              (#8# (QREFELT $ 118))))
                  (COND
                   ((>= |e| 0)
                    (SEQ
                     (LETT |s|
                           (STRCONC |s|
                                    (|make_full_CVEC2|
                                     (PROG1 (LETT #3# |e|)
                                       (|check_subtype2| (>= #3# 0)
                                                         '(|NonNegativeInteger|)
                                                         '(|Integer|) #3#))
                                     (|STR_to_CHAR| #9#))))
                     (EXIT (LETT |t| ""))))
                   ((<= |o| 0)
                    (SEQ
                     (LETT |t|
                           (STRCONC
                            (|make_full_CVEC2|
                             (PROG1 (LETT #2# (- |o|))
                               (|check_subtype2| (>= #2# 0)
                                                 '(|NonNegativeInteger|)
                                                 '(|Integer|) #2#))
                             (|STR_to_CHAR| #9#))
                            |s|))
                     (EXIT (LETT |s| "0"))))
                   (#8#
                    (SEQ
                     (LETT |t|
                           (SPADCALL |s|
                                     (SPADCALL
                                      (+ |o| (SPADCALL |s| (QREFELT $ 121)))
                                      (- (+ |n| (SPADCALL |s| (QREFELT $ 121)))
                                         1)
                                      (QREFELT $ 126))
                                     (QREFELT $ 127)))
                     (EXIT
                      (LETT |s|
                            (SPADCALL |s|
                                      (SPADCALL (SPADCALL |s| (QREFELT $ 121))
                                                (-
                                                 (+ |o|
                                                    (SPADCALL |s|
                                                              (QREFELT $ 121)))
                                                 1)
                                                (QREFELT $ 126))
                                      (QREFELT $ 127)))))))
                  (LETT |n| (QCSIZE |t|))
                  (COND
                   ((EQL (QREFELT $ 118) -1)
                    (SEQ
                     (LETT |t|
                           (SPADCALL |t| (|STR_to_CHAR| #9#) (QREFELT $ 128)))
                     (EXIT (COND ((EQUAL |t| "") (LETT |t| "0"))))))
                   ((> |n| |p|)
                    (LETT |t|
                          (SPADCALL |t|
                                    (SPADCALL (SPADCALL |t| (QREFELT $ 121))
                                              (-
                                               (+ |p|
                                                  (SPADCALL |t|
                                                            (QREFELT $ 121)))
                                               1)
                                              (QREFELT $ 126))
                                    (QREFELT $ 127))))
                   (#8#
                    (LETT |t|
                          (STRCONC |t|
                                   (|make_full_CVEC2|
                                    (PROG1 (LETT #1# (- |p| |n|))
                                      (|check_subtype2| (>= #1# 0)
                                                        '(|NonNegativeInteger|)
                                                        '(|Integer|) #1#))
                                    (|STR_to_CHAR| #9#))))))
                  (EXIT
                   (STRCONC (|FLOAT;padFromRight| |s| $)
                            (STRCONC "." (|FLOAT;padFromLeft| |t| $))))))))))) 

(SDEFUN |FLOAT;floating| ((|f| ($)) ($ (|String|)))
        (SPROG
         ((|s| (|String|)) (|o| (|Integer|)) (|n| (|NonNegativeInteger|))
          (|e| (|Integer|)) (|m| (|Integer|)) (|g| ($)) (|d| (|Integer|))
          (|t| (|String|)))
         (SEQ
          (COND ((SPADCALL |f| (QREFELT $ 23)) "0.0")
                ((SPADCALL |f| (QREFELT $ 25))
                 (STRCONC "-"
                          (|FLOAT;floating| (SPADCALL |f| (QREFELT $ 46)) $)))
                (#1='T
                 (SEQ
                  (LETT |t| (COND ((ZEROP (QREFELT $ 116)) "E") (#1# " E ")))
                  (EXIT
                   (COND
                    ((ZEROP (SPADCALL |f| (QREFELT $ 16)))
                     (SEQ
                      (LETT |s| (STRINGIMAGE (SPADCALL |f| (QREFELT $ 14))))
                      (EXIT
                       (SPADCALL
                        (LIST "0." (|FLOAT;padFromLeft| |s| $) |t|
                              (STRINGIMAGE (QCSIZE |s|)))
                        (QREFELT $ 35)))))
                    (#1#
                     (SEQ
                      (LETT |d|
                            (COND
                             ((EQL (QREFELT $ 118) -1)
                              (SPADCALL (QREFELT $ 91)))
                             (#1# (QREFELT $ 118))))
                      (LETT |g| (|FLOAT;convert10| |f| |d| $))
                      (LETT |m| (QCAR |g|)) (LETT |e| (QCDR |g|))
                      (LETT |s| (STRINGIMAGE |m|)) (LETT |n| (QCSIZE |s|))
                      (LETT |o| (+ |e| |n|))
                      (LETT |s| (|FLOAT;padFromLeft| |s| $))
                      (EXIT
                       (SPADCALL (LIST "0." |s| |t| (STRINGIMAGE |o|))
                                 (QREFELT $ 35))))))))))))) 

(SDEFUN |FLOAT;general| ((|f| ($)) ($ (|String|)))
        (SPROG
         ((|s| (|String|)) (|t| (|String|)) (#1=#:G1294 NIL) (#2=#:G1287 NIL)
          (#3=#:G1285 NIL) (|o| (|Integer|)) (|n| (|NonNegativeInteger|))
          (|e| (|Integer|)) (|m| (|Integer|)) (|g| ($)) (#4=#:G1305 NIL)
          (|d| (|Integer|)))
         (SEQ
          (COND ((SPADCALL |f| (QREFELT $ 23)) "0.0")
                ((SPADCALL |f| (QREFELT $ 25))
                 (STRCONC "-"
                          (|FLOAT;general| (SPADCALL |f| (QREFELT $ 46)) $)))
                (#5='T
                 (SEQ
                  (LETT |d|
                        (COND
                         ((EQL (QREFELT $ 118) -1) (SPADCALL (QREFELT $ 91)))
                         (#5# (QREFELT $ 118))))
                  (EXIT
                   (COND
                    ((ZEROP (SPADCALL |f| (QREFELT $ 16)))
                     (SEQ
                      (EXIT
                       (SEQ (LETT |d| (+ |d| 1))
                            (LETT |s|
                                  (STRINGIMAGE (SPADCALL |f| (QREFELT $ 14))))
                            (COND
                             ((SPADCALL (QREFELT $ 118) -1 (QREFELT $ 57))
                              (SEQ (LETT |e| (QCSIZE |s|))
                                   (EXIT
                                    (COND
                                     ((> |e| |d|)
                                      (PROGN
                                       (LETT #4#
                                             (SEQ
                                              (LETT |t|
                                                    (COND
                                                     ((ZEROP (QREFELT $ 116))
                                                      "E")
                                                     (#5# " E ")))
                                              (EXIT
                                               (SPADCALL
                                                (LIST "0."
                                                      (|FLOAT;padFromLeft| |s|
                                                       $)
                                                      |t| (STRINGIMAGE |e|))
                                                (QREFELT $ 35)))))
                                       (GO #6=#:G1284))))))))
                            (EXIT
                             (|FLOAT;padFromRight| (STRCONC |s| ".0") $))))
                      #6# (EXIT #4#)))
                    (#5#
                     (SEQ (LETT |g| (|FLOAT;convert10| |f| |d| $))
                          (LETT |m| (QCAR |g|)) (LETT |e| (QCDR |g|))
                          (LETT |s| (STRINGIMAGE |m|)) (LETT |n| (QCSIZE |s|))
                          (LETT |o| (+ |n| |e|))
                          (EXIT
                           (COND
                            ((> |o| 0)
                             (COND
                              ((<= |o| (MAX |n| |d|))
                               (SEQ
                                (COND
                                 ((> |o| |n|)
                                  (LETT |s|
                                        (STRCONC |s|
                                                 (|make_full_CVEC2|
                                                  (PROG1 (LETT #3# (- |o| |n|))
                                                    (|check_subtype2|
                                                     (>= #3# 0)
                                                     '(|NonNegativeInteger|)
                                                     '(|Integer|) #3#))
                                                  (|STR_to_CHAR| #7="0"))))))
                                (LETT |t|
                                      (SPADCALL
                                       (SPADCALL |s|
                                                 (SPADCALL
                                                  (+ |o|
                                                     (SPADCALL |s|
                                                               (QREFELT $
                                                                        121)))
                                                  (-
                                                   (+ |n|
                                                      (SPADCALL |s|
                                                                (QREFELT $
                                                                         121)))
                                                   1)
                                                  (QREFELT $ 126))
                                                 (QREFELT $ 127))
                                       (|STR_to_CHAR| #7#) (QREFELT $ 128)))
                                (COND ((EQUAL |t| "") (LETT |t| "0"))
                                      (#5#
                                       (LETT |t| (|FLOAT;padFromLeft| |t| $))))
                                (LETT |s|
                                      (|FLOAT;padFromRight|
                                       (SPADCALL |s|
                                                 (SPADCALL
                                                  (SPADCALL |s|
                                                            (QREFELT $ 121))
                                                  (-
                                                   (+ |o|
                                                      (SPADCALL |s|
                                                                (QREFELT $
                                                                         121)))
                                                   1)
                                                  (QREFELT $ 126))
                                                 (QREFELT $ 127))
                                       $))
                                (EXIT (STRCONC |s| (STRCONC "." |t|)))))
                              ((<= |o| 0)
                               (COND
                                ((>= |o| -5)
                                 (STRCONC #8="0."
                                          (|FLOAT;padFromLeft|
                                           (STRCONC
                                            (|make_full_CVEC2|
                                             (PROG1 (LETT #2# (- |o|))
                                               (|check_subtype2| (>= #2# 0)
                                                                 '(|NonNegativeInteger|)
                                                                 '(|Integer|)
                                                                 #2#))
                                             (|STR_to_CHAR| #7#))
                                            (SPADCALL |s| (|STR_to_CHAR| #7#)
                                                      (QREFELT $ 128)))
                                           $)))
                                (#5#
                                 (SEQ
                                  (LETT |t|
                                        (|FLOAT;padFromLeft|
                                         (SPADCALL |s| (|STR_to_CHAR| #7#)
                                                   (QREFELT $ 128))
                                         $))
                                  (LETT |s|
                                        (COND ((ZEROP (QREFELT $ 116)) #9="E")
                                              (#5# #10=" E ")))
                                  (EXIT
                                   (SPADCALL
                                    (LIST #11="0." |t| |s|
                                          (STRINGIMAGE (+ |e| |n|)))
                                    (QREFELT $ 35)))))))
                              (#5#
                               (SEQ
                                (LETT |t|
                                      (|FLOAT;padFromLeft|
                                       (SPADCALL |s| (|STR_to_CHAR| #7#)
                                                 (QREFELT $ 128))
                                       $))
                                (LETT |s|
                                      (COND ((ZEROP (QREFELT $ 116)) #9#)
                                            (#5# #10#)))
                                (EXIT
                                 (SPADCALL
                                  (LIST #11# |t| |s| (STRINGIMAGE (+ |e| |n|)))
                                  (QREFELT $ 35)))))))
                            ((<= |o| 0)
                             (COND
                              ((>= |o| -5)
                               (STRCONC #8#
                                        (|FLOAT;padFromLeft|
                                         (STRCONC
                                          (|make_full_CVEC2|
                                           (PROG1 (LETT #1# (- |o|))
                                             (|check_subtype2| (>= #1# 0)
                                                               '(|NonNegativeInteger|)
                                                               '(|Integer|)
                                                               #1#))
                                           (|STR_to_CHAR| #7#))
                                          (SPADCALL |s| (|STR_to_CHAR| #7#)
                                                    (QREFELT $ 128)))
                                         $)))
                              (#5#
                               (SEQ
                                (LETT |t|
                                      (|FLOAT;padFromLeft|
                                       (SPADCALL |s| (|STR_to_CHAR| #7#)
                                                 (QREFELT $ 128))
                                       $))
                                (LETT |s|
                                      (COND ((ZEROP (QREFELT $ 116)) #9#)
                                            (#5# #10#)))
                                (EXIT
                                 (SPADCALL
                                  (LIST #11# |t| |s| (STRINGIMAGE (+ |e| |n|)))
                                  (QREFELT $ 35)))))))
                            (#5#
                             (SEQ
                              (LETT |t|
                                    (|FLOAT;padFromLeft|
                                     (SPADCALL |s| (|STR_to_CHAR| #7#)
                                               (QREFELT $ 128))
                                     $))
                              (LETT |s|
                                    (COND ((ZEROP (QREFELT $ 116)) #9#)
                                          (#5# #10#)))
                              (EXIT
                               (SPADCALL
                                (LIST #11# |t| |s| (STRINGIMAGE (+ |e| |n|)))
                                (QREFELT $ 35))))))))))))))))) 

(SDEFUN |FLOAT;outputSpacing;NniV;105|
        ((|n| (|NonNegativeInteger|)) ($ (|Void|))) (SETELT $ 116 |n|)) 

(SDEFUN |FLOAT;outputFixed;V;106| (($ (|Void|)))
        (SEQ (SETELT $ 117 "fixed") (EXIT (SETELT $ 118 -1)))) 

(SDEFUN |FLOAT;outputFixed;NniV;107|
        ((|n| (|NonNegativeInteger|)) ($ (|Void|)))
        (SEQ (SETELT $ 117 "fixed") (EXIT (SETELT $ 118 |n|)))) 

(SDEFUN |FLOAT;outputGeneral;V;108| (($ (|Void|)))
        (SEQ (SETELT $ 117 "general") (EXIT (SETELT $ 118 -1)))) 

(SDEFUN |FLOAT;outputGeneral;NniV;109|
        ((|n| (|NonNegativeInteger|)) ($ (|Void|)))
        (SEQ (SETELT $ 117 "general") (EXIT (SETELT $ 118 |n|)))) 

(SDEFUN |FLOAT;outputFloating;V;110| (($ (|Void|)))
        (SEQ (SETELT $ 117 "floating") (EXIT (SETELT $ 118 -1)))) 

(SDEFUN |FLOAT;outputFloating;NniV;111|
        ((|n| (|NonNegativeInteger|)) ($ (|Void|)))
        (SEQ (SETELT $ 117 "floating") (EXIT (SETELT $ 118 |n|)))) 

(SDEFUN |FLOAT;convert;$S;112| ((|f| ($)) ($ (|String|)))
        (SPROG
         ((#1=#:G1325 NIL) (|s| (|String|)) (|b| (|Integer|)) (#2=#:G1320 NIL))
         (SEQ
          (LETT |b|
                (SEQ
                 (COND
                  ((EQL (QREFELT $ 118) -1)
                   (COND
                    ((NULL (SPADCALL |f| (QREFELT $ 23)))
                     (EXIT
                      (SPADCALL
                       (PROG1
                           (LETT #2#
                                 (INTEGER-LENGTH
                                  (ABS (SPADCALL |f| (QREFELT $ 14)))))
                         (|check_subtype2| (> #2# 0) '(|PositiveInteger|)
                                           '(|Integer|) #2#))
                       (QREFELT $ 60)))))))
                 (EXIT 0)))
          (LETT |s|
                (COND ((EQUAL (QREFELT $ 117) "fixed") (|FLOAT;fixed| |f| $))
                      ((EQUAL (QREFELT $ 117) "floating")
                       (|FLOAT;floating| |f| $))
                      ((EQUAL (QREFELT $ 117) "general")
                       (|FLOAT;general| |f| $))
                      (#3='T (|make_full_CVEC| 0))))
          (COND
           ((> |b| 0)
            (SPADCALL
             (PROG1 (LETT #1# |b|)
               (|check_subtype2| (> #1# 0) '(|PositiveInteger|) '(|Integer|)
                                 #1#))
             (QREFELT $ 60))))
          (EXIT
           (COND ((EQUAL |s| (|make_full_CVEC| 0)) (|error| "bad output mode"))
                 (#3# |s|)))))) 

(SDEFUN |FLOAT;coerce;$Of;113| ((|f| ($)) ($ (|OutputForm|)))
        (COND
         ((SPADCALL |f| (|spadConstant| $ 24) (QREFELT $ 138))
          (SPADCALL (SPADCALL |f| (QREFELT $ 137)) (QREFELT $ 140)))
         ('T
          (SPADCALL (SPADCALL (SPADCALL |f| (QREFELT $ 26)) (QREFELT $ 141))
                    (QREFELT $ 142))))) 

(SDEFUN |FLOAT;convert;$If;114| ((|f| ($)) ($ (|InputForm|)))
        (SPADCALL
         (LIST (SPADCALL '|float| (QREFELT $ 145))
               (SPADCALL (SPADCALL |f| (QREFELT $ 14)) (QREFELT $ 147))
               (SPADCALL (SPADCALL |f| (QREFELT $ 16)) (QREFELT $ 147))
               (SPADCALL (SPADCALL (QREFELT $ 94)) (QREFELT $ 146)))
         (QREFELT $ 148))) 

(PUT '|FLOAT;convert;2$;115| '|SPADreplace| '(XLAM (|x|) |x|)) 

(SDEFUN |FLOAT;convert;2$;115| ((|x| ($)) ($ (|Float|))) |x|) 

(SDEFUN |FLOAT;convert;$Df;116| ((|x| ($)) ($ (|DoubleFloat|)))
        (|makeSF| (QCAR |x|) (QCDR |x|))) 

(SDEFUN |FLOAT;coerce;$Df;117| ((|x| ($)) ($ (|DoubleFloat|)))
        (SPADCALL |x| (QREFELT $ 153))) 

(SDEFUN |FLOAT;convert;Df$;118| ((|sf| (|DoubleFloat|)) ($ ($)))
        (SPADCALL (SPADCALL |sf| (QREFELT $ 155))
                  (SPADCALL |sf| (QREFELT $ 156)) (FLOAT-RADIX 0.0)
                  (QREFELT $ 98))) 

(SDEFUN |FLOAT;retract;$F;119| ((|f| ($)) ($ (|Fraction| (|Integer|))))
        (SPROG ((#1=#:G1337 NIL))
               (SPADCALL |f|
                         (PROG1 (LETT #1# (- (SPADCALL (QREFELT $ 49)) 1))
                           (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                             '(|Integer|) #1#))
                         2 (QREFELT $ 158)))) 

(SDEFUN |FLOAT;retractIfCan;$U;120|
        ((|f| ($)) ($ (|Union| (|Fraction| (|Integer|)) "failed")))
        (SPROG ((#1=#:G1343 NIL))
               (CONS 0
                     (SPADCALL |f|
                               (PROG1
                                   (LETT #1# (- (SPADCALL (QREFELT $ 49)) 1))
                                 (|check_subtype2| (>= #1# 0)
                                                   '(|NonNegativeInteger|)
                                                   '(|Integer|) #1#))
                               2 (QREFELT $ 158))))) 

(SDEFUN |FLOAT;retract;$I;121| ((|f| ($)) ($ (|Integer|)))
        (SPROG ((|n| (|Integer|)))
               (SEQ (LETT |n| (SPADCALL |f| (QREFELT $ 50)))
                    (EXIT
                     (COND
                      ((SPADCALL |f| (SPADCALL |n| (QREFELT $ 162))
                                 (QREFELT $ 29))
                       |n|)
                      ('T (|error| "Not an integer"))))))) 

(SDEFUN |FLOAT;retractIfCan;$U;122|
        ((|f| ($)) ($ (|Union| (|Integer|) "failed")))
        (SPROG ((|n| (|Integer|)))
               (SEQ (LETT |n| (SPADCALL |f| (QREFELT $ 50)))
                    (EXIT
                     (COND
                      ((SPADCALL |f| (SPADCALL |n| (QREFELT $ 162))
                                 (QREFELT $ 29))
                       (CONS 0 |n|))
                      ('T (CONS 1 "failed"))))))) 

(SDEFUN |FLOAT;rationalApproximation;$NniF;123|
        ((|f| ($)) (|d| (|NonNegativeInteger|)) ($ (|Fraction| (|Integer|))))
        (SPADCALL |f| |d| 10 (QREFELT $ 158))) 

(SDEFUN |FLOAT;rationalApproximation;$2NniF;124|
        ((|f| ($)) (|d| (|NonNegativeInteger|)) (|b| (|NonNegativeInteger|))
         ($ (|Fraction| (|Integer|))))
        (SPROG
         ((|t| #1=(|Integer|)) (|s| #2=(|Integer|)) (|#G222| #3=(|Integer|))
          (|#G221| #1#) (|q1| #4=(|Integer|)) (|q0| #4#)
          (|#G220| #5=(|Integer|)) (|#G219| #4#) (|p1| #4#) (|p0| #4#)
          (|#G218| #5#) (|#G217| #4#) (#6=#:G1375 NIL) (|q2| #5#) (|p2| #5#)
          (|r| #3#) (|q| #7=(|Integer|))
          (|#G216| (|Record| (|:| |quotient| #7#) (|:| |remainder| #3#)))
          (|tol| (|NonNegativeInteger|)) (|de| (|PositiveInteger|))
          (#8=#:G1366 NIL) (#9=#:G1364 NIL) (|ex| (|Integer|)) (|nu| #2#))
         (SEQ
          (EXIT
           (SEQ (LETT |nu| (QCAR |f|)) (LETT |ex| (QCDR |f|))
                (COND
                 ((>= |ex| 0)
                  (PROGN
                   (LETT #6#
                         (SPADCALL
                          (* |nu|
                             (EXPT 2
                                   (PROG1 (LETT #9# |ex|)
                                     (|check_subtype2| (>= #9# 0)
                                                       '(|NonNegativeInteger|)
                                                       '(|Integer|) #9#))))
                          1 (QREFELT $ 167)))
                   (GO #10=#:G1374))))
                (LETT |de|
                      (EXPT 2
                            (PROG1 (LETT #8# (- |ex|))
                              (|check_subtype2| (>= #8# 0)
                                                '(|NonNegativeInteger|)
                                                '(|Integer|) #8#))))
                (COND ((< |b| 2) (|error| "base must be > 1")))
                (LETT |tol| (EXPT |b| |d|)) (LETT |s| |nu|) (LETT |t| |de|)
                (LETT |p0| 0) (LETT |p1| 1) (LETT |q0| 1) (LETT |q1| 0)
                (EXIT
                 (SEQ G190 NIL
                      (SEQ
                       (PROGN
                        (LETT |#G216| (DIVIDE2 |s| |t|))
                        (LETT |q| (QCAR |#G216|))
                        (LETT |r| (QCDR |#G216|))
                        |#G216|)
                       (LETT |p2| (+ (* |q| |p1|) |p0|))
                       (LETT |q2| (+ (* |q| |q1|) |q0|))
                       (COND
                        ((OR (EQL |r| 0)
                             (< (* |tol| (ABS (- (* |nu| |q2|) (* |de| |p2|))))
                                (* |de| (ABS |p2|))))
                         (PROGN
                          (LETT #6# (SPADCALL |p2| |q2| (QREFELT $ 167)))
                          (GO #10#))))
                       (PROGN
                        (LETT |#G217| |p1|)
                        (LETT |#G218| |p2|)
                        (LETT |p0| |#G217|)
                        (LETT |p1| |#G218|))
                       (PROGN
                        (LETT |#G219| |q1|)
                        (LETT |#G220| |q2|)
                        (LETT |q0| |#G219|)
                        (LETT |q1| |#G220|))
                       (EXIT
                        (PROGN
                         (LETT |#G221| |t|)
                         (LETT |#G222| |r|)
                         (LETT |s| |#G221|)
                         (LETT |t| |#G222|))))
                      NIL (GO G190) G191 (EXIT NIL)))))
          #10# (EXIT #6#)))) 

(SDEFUN |FLOAT;hashUpdate!;Hs$Hs;125|
        ((|s| (|HashState|)) (|x| ($)) ($ (|HashState|)))
        (SPROG
         ((|e| (|Integer|)) (|m| (|Integer|)) (#1=#:G1379 NIL)
          (|tmp| (|Union| (|Integer|) #2="failed")))
         (SEQ (LETT |m| (QCAR |x|)) (LETT |e| (QCDR |x|))
              (SEQ G190
                   (COND
                    ((NULL
                      (QEQCAR (LETT |tmp| (SPADCALL |m| 2 (QREFELT $ 168))) 0))
                     (GO G191)))
                   (SEQ
                    (LETT |m|
                          (PROG2 (LETT #1# |tmp|)
                              (QCDR #1#)
                            (|check_union2| (QEQCAR #1# 0) (|Integer|)
                                            (|Union| (|Integer|) #2#) #1#)))
                    (EXIT (LETT |e| (+ |e| 1))))
                   NIL (GO G190) G191 (EXIT NIL))
              (LETT |s| (SPADCALL |s| |m| (QREFELT $ 170)))
              (EXIT (SPADCALL |s| |e| (QREFELT $ 170)))))) 

(DECLAIM (NOTINLINE |Float;|)) 

(DEFUN |Float| ()
  (SPROG NIL
         (PROG (#1=#:G1409)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|Float|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|Float|
                             (LIST (CONS NIL (CONS 1 (|Float;|))))))
                    (LETT #1# T))
                (COND ((NOT #1#) (HREM |$ConstructorCache| '|Float|)))))))))) 

(DEFUN |Float;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|Float|))
          (LETT $ (GETREFV 185))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|Float| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (AND (|HasCategory| $ '(|arbitraryPrecision|))
               (|augmentPredVector| $ 1))
          (AND (|not| (|HasCategory| $ '(|arbitraryExponent|)))
               (|not| (|HasCategory| $ '(|arbitraryPrecision|)))
               (|augmentPredVector| $ 2))
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6 68)
          (QSETREFV $ 7
                    (|Record| (|:| |mantissa| (|Integer|))
                              (|:| |exponent| (|Integer|))))
          (QSETREFV $ 66 (CONS 1 (CONS 1 2)))
          (QSETREFV $ 78 (CONS 1 (|spadConstant| $ 28)))
          (QSETREFV $ 79 (CONS 1 (CONS 1 1)))
          (QSETREFV $ 89 (CONS 1 (CONS 1 1)))
          (QSETREFV $ 116 10)
          (QSETREFV $ 117 "general")
          (QSETREFV $ 118 -1)
          $))) 

(MAKEPROP '|Float| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL 'BITS '|Rep| (|Void|) (|OpenMathDevice|)
              (0 . |OMputApp|) (|String|) (5 . |OMputSymbol|) (|Integer|)
              |FLOAT;mantissa;$I;50| (12 . |OMputInteger|)
              |FLOAT;exponent;$I;51| (18 . |OMputEndApp|) (23 . |OMputObject|)
              (28 . |OMputEndObject|) (|Boolean|) |FLOAT;OMwrite;Omd$BV;2|
              (33 . |sign|) |FLOAT;zero?;$B;53|
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |FLOAT;Zero;$;47|) $))
              |FLOAT;negative?;$B;54| |FLOAT;-;2$;72| |FLOAT;asin;2$;4|
              (CONS IDENTITY (FUNCALL (|dispatchFunction| |FLOAT;One;$;48|) $))
              |FLOAT;=;2$B;61| |FLOAT;pi;$;15| |FLOAT;/;$I$;81| (38 . >)
              (44 . |toString|) (|List| $) (49 . |concat|) (|PositiveInteger|)
              |FLOAT;increasePrecision;IPi;40| |FLOAT;sqrt;2$;35|
              |FLOAT;/;3$;80| |FLOAT;atan;2$;7|
              |FLOAT;decreasePrecision;IPi;41| |FLOAT;normalize;2$;59|
              |FLOAT;acos;2$;5| |FLOAT;-;3$;75| |FLOAT;<;2$B;62|
              |FLOAT;abs;2$;63| |FLOAT;atan;3$;6| (54 . |fractionPart|)
              |FLOAT;bits;Pi;36| |FLOAT;wholePart;$I;65| (|IntegerRoots| 13)
              (59 . |approxSqrt|) |FLOAT;order;$I;45| |FLOAT;*;3$;78|
              |FLOAT;+;3$;74| |FLOAT;shift;$I$;60| (64 . ~=) |FLOAT;sign;$I;68|
              (70 . *) |FLOAT;bits;2Pi;37| (76 . ^) |FLOAT;*;I2$;79|
              |FLOAT;sin;2$;10| |FLOAT;cos;2$;12| |FLOAT;tan;2$;14| 'P
              |FLOAT;precision;Pi;38| |FLOAT;exp;2$;29| |FLOAT;sinh;2$;17|
              |FLOAT;cosh;2$;18| |FLOAT;tanh;2$;19| |FLOAT;log;2$;23|
              |FLOAT;asinh;2$;20| |FLOAT;acosh;2$;21| |FLOAT;atanh;2$;22|
              |FLOAT;log2;$;25| |FLOAT;^;$I$;90| 'L2 'L10 |FLOAT;log10;$;26|
              |FLOAT;log2;2$;27| |FLOAT;log10;2$;28| |FLOAT;exp1;$;34|
              (|List| (|List| 13)) (|Matrix| 13) (82 . |matrix|) (87 . |elt|)
              (94 . *) 'E |FLOAT;precision;2Pi;39| |FLOAT;digits;Pi;43|
              |FLOAT;digits;2Pi;44| |FLOAT;relerror;3$;46| |FLOAT;base;Pi;49|
              |FLOAT;one?;$B;52| |FLOAT;positive?;$B;55| |FLOAT;float;2I$;57|
              |FLOAT;float;2IPi$;58| |FLOAT;floor;2$;66| |FLOAT;truncate;2$;69|
              |FLOAT;ceiling;2$;64| |FLOAT;round;2$;67| (|Union| $ '"failed")
              |FLOAT;recip;$U;70| |FLOAT;differentiate;2$;71| |FLOAT;inv;2$;82|
              |FLOAT;^;3$;88| (|Fraction| 13) (100 . |Zero|) (104 . =)
              (110 . <) (116 . |One|) (120 . |numer|) (125 . |denom|)
              |FLOAT;^;$F$;89| 'SPACING 'OUTMODE 'OUTPREC (|Character|)
              (130 . |escape|) (134 . |minIndex|) (139 . |elt|)
              (145 . |setelt!|) (152 . |maxIndex|) (|UniversalSegment| 13)
              (157 . SEGMENT) (163 . |elt|) (169 . |rightTrim|)
              (|NonNegativeInteger|) |FLOAT;outputSpacing;NniV;105|
              |FLOAT;outputFixed;V;106| |FLOAT;outputFixed;NniV;107|
              |FLOAT;outputGeneral;V;108| |FLOAT;outputGeneral;NniV;109|
              |FLOAT;outputFloating;V;110| |FLOAT;outputFloating;NniV;111|
              |FLOAT;convert;$S;112| (175 . >=) (|OutputForm|)
              (181 . |message|) |FLOAT;coerce;$Of;113| (186 . -) (|Symbol|)
              (|InputForm|) (191 . |convert|) (196 . |convert|)
              (201 . |convert|) (206 . |convert|) |FLOAT;convert;$If;114|
              (|Float|) |FLOAT;convert;2$;115| (|DoubleFloat|)
              |FLOAT;convert;$Df;116| |FLOAT;coerce;$Df;117| (211 . |mantissa|)
              (216 . |exponent|) |FLOAT;convert;Df$;118|
              |FLOAT;rationalApproximation;$2NniF;124| |FLOAT;retract;$F;119|
              (|Union| 108 '"failed") |FLOAT;retractIfCan;$U;120|
              (221 . |coerce|) |FLOAT;retract;$I;121| (|Union| 13 '"failed")
              |FLOAT;retractIfCan;$U;122|
              |FLOAT;rationalApproximation;$NniF;123| (226 . /) (232 . |exquo|)
              (|HashState|) (238 . |hashUpdate!|) |FLOAT;hashUpdate!;Hs$Hs;125|
              (|PatternMatchResult| 150 $) (|Pattern| 150) (|Factored| $)
              (|Record| (|:| |coef1| $) (|:| |coef2| $))
              (|Union| 175 '#1="failed") (|Union| 34 '#1#)
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (|Record| (|:| |coef| 34) (|:| |generator| $))
              (|SparseUnivariatePolynomial| $)
              (|Record| (|:| |llcm_res| $) (|:| |coeff1| $) (|:| |coeff2| $))
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|SingleInteger|))
           '#(~= 244 |zero?| 250 |wholePart| 255 |unitNormal| 260
              |unitCanonical| 265 |unit?| 270 |truncate| 275 |toString| 280
              |tanh| 291 |tan| 296 |subtractIfCan| 301 |squareFreePart| 307
              |squareFree| 312 |sqrt| 317 |smaller?| 322 |sizeLess?| 328 |sinh|
              334 |sin| 339 |sign| 344 |shift| 349 |sech| 355 |sec| 360
              |sample| 365 |round| 369 |rightRecip| 374 |rightPower| 379
              |retractIfCan| 391 |retract| 401 |rem| 411 |relerror| 417 |recip|
              423 |rationalApproximation| 428 |quo| 441 |principalIdeal| 447
              |prime?| 452 |precision| 457 |positive?| 466 |pi| 471
              |patternMatch| 475 |outputSpacing| 482 |outputGeneral| 487
              |outputFloating| 496 |outputFixed| 505 |order| 514 |opposite?|
              519 |one?| 525 |nthRoot| 530 |normalize| 536 |norm| 541
              |negative?| 546 |multiEuclidean| 551 |min| 557 |max| 567
              |mantissa| 577 |log2| 582 |log10| 591 |log| 600 |leftRecip| 605
              |leftPower| 610 |lcmCoef| 622 |lcm| 628 |latex| 639 |inv| 644
              |increasePrecision| 649 |hashUpdate!| 654 |hash| 660
              |gcdPolynomial| 665 |gcd| 671 |fractionPart| 682 |floor| 687
              |float| 692 |factor| 705 |extendedEuclidean| 710 |exquo| 723
              |expressIdealMember| 729 |exponent| 735 |exp1| 740 |exp| 744
              |euclideanSize| 749 |divide| 754 |digits| 760 |differentiate| 769
              |decreasePrecision| 780 |csch| 785 |csc| 790 |coth| 795 |cot| 800
              |cosh| 805 |cos| 810 |convert| 815 |commutator| 845 |coerce| 851
              |characteristic| 876 |ceiling| 880 |bits| 885 |base| 894 |atanh|
              898 |atan| 903 |associator| 914 |associates?| 921 |asinh| 927
              |asin| 932 |asech| 937 |asec| 942 |antiCommutator| 947
              |annihilate?| 953 |acsch| 959 |acsc| 964 |acoth| 969 |acot| 974
              |acosh| 979 |acos| 984 |abs| 989 ^ 994 |Zero| 1024 |One| 1028
              |OMwrite| 1032 D 1056 >= 1067 > 1073 = 1079 <= 1085 < 1091 / 1097
              - 1109 + 1120 * 1126)
           'NIL
           (CONS
            (|makeByteWordVec2| 1
                                '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                  0 0 0 0 0 0 0 0 0 0 0))
            (CONS
             '#(|FloatingPointSystem&| |RealNumberSystem&| |Field&|
                |EuclideanDomain&| NIL |UniqueFactorizationDomain&|
                |GcdDomain&| NIL |OrderedRing&| |DivisionRing&| NIL NIL
                |DifferentialRing&| NIL |Algebra&| |EntireRing&| |Algebra&| NIL
                |Rng&| NIL |Module&| |Module&| NIL NIL NIL NIL
                |NonAssociativeRing&| NIL NIL NIL NIL |NonAssociativeRng&| NIL
                NIL |AbelianGroup&| NIL NIL NIL NIL |OrderedSet&| NIL
                |MagmaWithUnit&| |NonAssociativeSemiRng&| |AbelianMonoid&| NIL
                NIL |Magma&| |AbelianSemiGroup&|
                |TranscendentalFunctionCategory&| |RetractableTo&|
                |RetractableTo&| NIL NIL |SetCategory&| NIL NIL
                |ElementaryFunctionCategory&| NIL |HyperbolicFunctionCategory&|
                |ArcTrigonometricFunctionCategory&|
                |TrigonometricFunctionCategory&| NIL NIL |OpenMath&| NIL NIL
                NIL |RadicalCategory&| NIL NIL NIL NIL |PartialOrder&| NIL NIL
                NIL NIL NIL |BasicType&| NIL)
             (CONS
              '#((|FloatingPointSystem|) (|RealNumberSystem|) (|Field|)
                 (|EuclideanDomain|) (|PrincipalIdealDomain|)
                 (|UniqueFactorizationDomain|) (|GcdDomain|) (|IntegralDomain|)
                 (|OrderedRing|) (|DivisionRing|) (|CommutativeRing|)
                 (|LeftOreRing|) (|DifferentialRing|) (|CharacteristicZero|)
                 (|Algebra| 108) (|EntireRing|) (|Algebra| $$) (|Ring|) (|Rng|)
                 (|SemiRing|) (|Module| 108) (|Module| $$) (|SemiRng|)
                 (|OrderedAbelianGroup|) (|BiModule| 108 108)
                 (|BiModule| $$ $$) (|NonAssociativeRing|)
                 (|OrderedCancellationAbelianMonoid|) (|RightModule| 108)
                 (|LeftModule| 108) (|LeftModule| $$) (|NonAssociativeRng|)
                 (|RightModule| $$) (|OrderedAbelianMonoid|) (|AbelianGroup|)
                 (|OrderedAbelianSemiGroup|) (|Monoid|)
                 (|NonAssociativeSemiRing|) (|CancellationAbelianMonoid|)
                 (|OrderedSet|) (|SemiGroup|) (|MagmaWithUnit|)
                 (|NonAssociativeSemiRng|) (|AbelianMonoid|)
                 (|PatternMatchable| 150) (|Comparable|) (|Magma|)
                 (|AbelianSemiGroup|) (|TranscendentalFunctionCategory|)
                 (|RetractableTo| 108) (|RetractableTo| 13) (|RealConstant|)
                 (|CommutativeStar|) (|SetCategory|) (|arbitraryExponent|)
                 (|arbitraryPrecision|) (|ElementaryFunctionCategory|)
                 (|ArcHyperbolicFunctionCategory|)
                 (|HyperbolicFunctionCategory|)
                 (|ArcTrigonometricFunctionCategory|)
                 (|TrigonometricFunctionCategory|) (|ConvertibleTo| 144)
                 (|CoercibleTo| 152) (|OpenMath|) (|ConvertibleTo| 11)
                 (|Approximate|) (|ConvertibleTo| 173) (|RadicalCategory|)
                 (|CoercibleFrom| 108) (|CoercibleFrom| 13)
                 (|ConvertibleTo| 150) (|ConvertibleTo| 152) (|PartialOrder|)
                 (|canonicalsClosed|) (|canonicalUnitNormal|)
                 (|noZeroDivisors|) (|TwoSidedRecip|) (|unitsKnown|)
                 (|BasicType|) (|CoercibleTo| 139))
              (|makeByteWordVec2| 184
                                  '(1 9 8 0 10 3 9 8 0 11 11 12 2 9 8 0 13 15 1
                                    9 8 0 17 1 9 8 0 18 1 9 8 0 19 1 13 13 0 22
                                    2 0 20 0 0 32 1 0 11 0 33 1 11 0 34 35 1 0
                                    0 0 48 1 51 13 13 52 2 13 20 0 0 57 2 0 0
                                    36 0 59 2 0 0 0 36 61 1 85 0 84 86 3 85 13
                                    0 13 13 87 2 85 0 0 0 88 0 108 0 109 2 108
                                    20 0 0 110 2 108 20 0 0 111 0 108 0 112 1
                                    108 13 0 113 1 108 13 0 114 0 119 0 120 1
                                    11 13 0 121 2 11 119 0 13 122 3 11 119 0 13
                                    119 123 1 11 13 0 124 2 125 0 13 13 126 2
                                    11 0 0 125 127 2 11 0 0 119 128 2 0 20 0 0
                                    138 1 139 0 11 140 1 139 0 0 142 1 144 0
                                    143 145 1 36 144 0 146 1 13 144 0 147 1 144
                                    0 34 148 1 152 13 0 155 1 152 13 0 156 1 0
                                    0 13 162 2 108 0 13 13 167 2 13 103 0 0 168
                                    2 13 169 169 0 170 2 0 20 0 0 1 1 0 20 0 23
                                    1 0 13 0 50 1 0 183 0 1 1 0 0 0 1 1 0 20 0
                                    1 1 0 0 0 100 2 0 11 0 129 1 1 0 11 0 33 1
                                    0 0 0 71 1 0 0 0 65 2 0 103 0 0 1 1 0 0 0 1
                                    1 0 174 0 1 1 0 0 0 38 2 0 20 0 0 1 2 0 20
                                    0 0 1 1 0 0 0 69 1 0 0 0 63 1 0 13 0 58 2 0
                                    0 0 13 56 1 0 0 0 1 1 0 0 0 1 0 0 0 1 1 0 0
                                    0 102 1 0 103 0 1 2 0 0 0 129 1 2 0 0 0 36
                                    1 1 0 160 0 161 1 0 164 0 165 1 0 108 0 159
                                    1 0 13 0 163 2 0 0 0 0 1 2 0 0 0 0 93 1 0
                                    103 0 104 3 0 108 0 129 129 158 2 0 108 0
                                    129 166 2 0 0 0 0 1 1 0 180 34 1 1 0 20 0 1
                                    1 1 36 36 90 0 0 36 67 1 0 20 0 96 0 0 0 30
                                    3 0 172 0 173 172 1 1 0 8 129 130 1 0 8 129
                                    134 0 0 8 133 0 0 8 135 1 0 8 129 136 0 0 8
                                    131 1 0 8 129 132 1 0 13 0 53 2 0 20 0 0 1
                                    1 0 20 0 95 2 0 0 0 13 1 1 0 0 0 42 1 0 0 0
                                    1 1 0 20 0 25 2 0 177 34 0 1 0 2 0 1 2 0 0
                                    0 0 1 0 2 0 1 2 0 0 0 0 1 1 0 13 0 14 1 0 0
                                    0 81 0 0 0 76 1 0 0 0 82 0 0 0 80 1 0 0 0
                                    72 1 0 103 0 1 2 0 0 0 129 1 2 0 0 0 36 1 2
                                    0 182 0 0 1 2 0 0 0 0 1 1 0 0 34 1 1 0 11 0
                                    1 1 0 0 0 106 1 1 36 13 37 2 0 169 169 0
                                    171 1 0 184 0 1 2 0 181 181 181 1 2 0 0 0 0
                                    1 1 0 0 34 1 1 0 0 0 48 1 0 0 0 99 3 0 0 13
                                    13 36 98 2 0 0 13 13 97 1 0 174 0 1 3 0 176
                                    0 0 0 1 2 0 178 0 0 1 2 0 103 0 0 1 2 0 177
                                    34 0 1 1 0 13 0 16 0 0 0 83 1 0 0 0 68 1 0
                                    129 0 1 2 0 179 0 0 1 1 1 36 36 92 0 0 36
                                    91 1 0 0 0 105 2 0 0 0 129 1 1 1 36 13 41 1
                                    0 0 0 1 1 0 0 0 1 1 0 0 0 1 1 0 0 0 1 1 0 0
                                    0 70 1 0 0 0 64 1 0 0 152 157 1 0 144 0 149
                                    1 0 11 0 137 1 0 173 0 1 1 0 152 0 153 1 0
                                    150 0 151 2 0 0 0 0 1 1 0 152 0 154 1 0 0
                                    108 1 1 0 0 13 162 1 0 0 0 1 1 0 139 0 141
                                    0 0 129 1 1 0 0 0 101 1 1 36 36 60 0 0 36
                                    49 0 0 36 94 1 0 0 0 75 2 0 0 0 0 47 1 0 0
                                    0 40 3 0 0 0 0 0 1 2 0 20 0 0 1 1 0 0 0 73
                                    1 0 0 0 27 1 0 0 0 1 1 0 0 0 1 2 0 0 0 0 1
                                    2 0 20 0 0 1 1 0 0 0 1 1 0 0 0 1 1 0 0 0 1
                                    1 0 0 0 1 1 0 0 0 74 1 0 0 0 43 1 0 0 0 46
                                    2 0 0 0 0 107 2 0 0 0 108 115 2 0 0 0 13 77
                                    2 0 0 0 129 1 2 0 0 0 36 61 0 0 0 24 0 0 0
                                    28 2 0 8 9 0 1 3 0 8 9 0 20 21 2 0 11 0 20
                                    1 1 0 11 0 1 1 0 0 0 1 2 0 0 0 129 1 2 0 20
                                    0 0 138 2 0 20 0 0 32 2 0 20 0 0 29 2 0 20
                                    0 0 1 2 0 20 0 0 45 2 0 0 0 13 31 2 0 0 0 0
                                    39 2 0 0 0 0 44 1 0 0 0 26 2 0 0 0 0 55 2 0
                                    0 108 0 1 2 0 0 0 108 1 2 0 0 129 0 1 2 0 0
                                    13 0 62 2 0 0 0 0 54 2 0 0 36 0 59)))))
           '|lookupComplete|)) 

(MAKEPROP '|Float| 'NILADIC T) 
