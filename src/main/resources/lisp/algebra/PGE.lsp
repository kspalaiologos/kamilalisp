
(SDEFUN |PGE;llli2gp|
        ((|l| (|List| (|List| (|List| (|Integer|)))))
         ($ (|PermutationGroup| (|Integer|))))
        (SPADCALL (SPADCALL (ELT $ 8) |l| (QREFELT $ 13)) (QREFELT $ 15))) 

(SDEFUN |PGE;li1n| ((|n| (|Integer|)) ($ (|List| (|Integer|))))
        (SPROG ((#1=#:G722 NIL) (|i| NIL) (#2=#:G721 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |i| 1) (LETT #1# |n|) G190
                      (COND ((|greater_SI| |i| #1#) (GO G191)))
                      (SEQ (EXIT (LETT #2# (CONS |i| #2#))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |PGE;youngGroup;LPg;3|
        ((|l| (|List| (|Integer|))) ($ (|PermutationGroup| (|Integer|))))
        (SPROG
         ((|element| (|Integer|))
          (|gens| (|List| (|List| (|List| (|Integer|))))) (#1=#:G734 NIL)
          (|i| NIL) (#2=#:G733 NIL) (#3=#:G732 NIL) (|n| NIL))
         (SEQ (LETT |gens| NIL) (LETT |element| 1)
              (SEQ (LETT |n| NIL) (LETT #3# |l|) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |n| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((> |n| 1)
                       (SEQ
                        (LETT |gens|
                              (CONS
                               (SPADCALL
                                (PROGN
                                 (LETT #2# NIL)
                                 (SEQ (LETT |i| |element|)
                                      (LETT #1# (- (+ |element| |n|) 1)) G190
                                      (COND ((> |i| #1#) (GO G191)))
                                      (SEQ (EXIT (LETT #2# (CONS |i| #2#))))
                                      (LETT |i| (+ |i| 1)) (GO G190) G191
                                      (EXIT (NREVERSE #2#))))
                                (QREFELT $ 18))
                               |gens|))
                        (COND
                         ((>= |n| 3)
                          (LETT |gens|
                                (CONS (LIST (LIST |element| (+ |element| 1)))
                                      |gens|))))
                        (EXIT (LETT |element| (+ |element| |n|))))))))
                   (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (|PGE;llli2gp|
                (COND ((EQL (LENGTH |gens|) 0) (LIST (LIST (LIST 1))))
                      ('T |gens|))
                $))))) 

(SDEFUN |PGE;youngGroup;PPg;4|
        ((|lambda| (|Partition|)) ($ (|PermutationGroup| (|Integer|))))
        (SPADCALL (SPADCALL |lambda| (QREFELT $ 21)) (QREFELT $ 19))) 

(SDEFUN |PGE;rubiksGroup;Pg;5| (($ (|PermutationGroup| (|Integer|))))
        (SPROG
         ((|b| (|List| (|List| (|Integer|))))
          (|l| (|List| (|List| (|Integer|))))
          (|d| (|List| (|List| (|Integer|))))
          (|u| (|List| (|List| (|Integer|))))
          (|r| (|List| (|List| (|Integer|))))
          (|f| (|List| (|List| (|Integer|)))))
         (SEQ
          (LETT |f|
                (LIST (LIST 11 13 15 17) (LIST 12 14 16 18) (LIST 51 31 21 41)
                      (LIST 53 33 23 43) (LIST 52 32 22 42)))
          (LETT |r|
                (LIST (LIST 21 23 25 27) (LIST 22 24 26 28) (LIST 13 37 67 43)
                      (LIST 15 31 61 45) (LIST 14 38 68 44)))
          (LETT |u|
                (LIST (LIST 31 33 35 37) (LIST 32 34 36 38) (LIST 13 51 63 25)
                      (LIST 11 57 61 23) (LIST 12 58 62 24)))
          (LETT |d|
                (LIST (LIST 41 43 45 47) (LIST 42 44 46 48) (LIST 17 21 67 55)
                      (LIST 15 27 65 53) (LIST 16 28 66 54)))
          (LETT |l|
                (LIST (LIST 51 53 55 57) (LIST 52 54 56 58) (LIST 11 41 65 35)
                      (LIST 17 47 63 33) (LIST 18 48 64 34)))
          (LETT |b|
                (LIST (LIST 61 63 65 67) (LIST 62 64 66 68) (LIST 45 25 35 55)
                      (LIST 47 27 37 57) (LIST 46 26 36 56)))
          (EXIT (|PGE;llli2gp| (LIST |f| |r| |u| |d| |l| |b|) $))))) 

(SDEFUN |PGE;mathieu11;LPg;6|
        ((|l| (|List| (|Integer|))) ($ (|PermutationGroup| (|Integer|))))
        (SPROG ((|a| (|List| (|List| (|Integer|)))))
               (SEQ (LETT |l| (SPADCALL |l| (QREFELT $ 24)))
                    (EXIT
                     (COND
                      ((SPADCALL (LENGTH |l|) 11 (QREFELT $ 27))
                       (|error| "Exactly 11 integers for mathieu11 needed !"))
                      ('T
                       (SEQ
                        (LETT |a|
                              (LIST
                               (LIST (SPADCALL |l| 1 (QREFELT $ 28))
                                     (SPADCALL |l| 10 (QREFELT $ 28)))
                               (LIST (SPADCALL |l| 2 (QREFELT $ 28))
                                     (SPADCALL |l| 8 (QREFELT $ 28)))
                               (LIST (SPADCALL |l| 3 (QREFELT $ 28))
                                     (SPADCALL |l| 11 (QREFELT $ 28)))
                               (LIST (SPADCALL |l| 5 (QREFELT $ 28))
                                     (SPADCALL |l| 7 (QREFELT $ 28)))))
                        (EXIT
                         (|PGE;llli2gp|
                          (LIST |a|
                                (LIST
                                 (LIST (SPADCALL |l| 1 (QREFELT $ 28))
                                       (SPADCALL |l| 4 (QREFELT $ 28))
                                       (SPADCALL |l| 7 (QREFELT $ 28))
                                       (SPADCALL |l| 6 (QREFELT $ 28)))
                                 (LIST (SPADCALL |l| 2 (QREFELT $ 28))
                                       (SPADCALL |l| 11 (QREFELT $ 28))
                                       (SPADCALL |l| 10 (QREFELT $ 28))
                                       (SPADCALL |l| 9 (QREFELT $ 28)))))
                          $))))))))) 

(SDEFUN |PGE;mathieu11;Pg;7| (($ (|PermutationGroup| (|Integer|))))
        (SPADCALL (|PGE;li1n| 11 $) (QREFELT $ 29))) 

(SDEFUN |PGE;mathieu12;LPg;8|
        ((|l| (|List| (|Integer|))) ($ (|PermutationGroup| (|Integer|))))
        (SPROG ((|a| (|List| (|List| (|Integer|)))))
               (SEQ (LETT |l| (SPADCALL |l| (QREFELT $ 24)))
                    (EXIT
                     (COND
                      ((SPADCALL (LENGTH |l|) 12 (QREFELT $ 27))
                       (|error| "Exactly 12 integers for mathieu12 needed !"))
                      ('T
                       (SEQ
                        (LETT |a|
                              (LIST
                               (LIST (SPADCALL |l| 1 (QREFELT $ 28))
                                     (SPADCALL |l| 2 (QREFELT $ 28))
                                     (SPADCALL |l| 3 (QREFELT $ 28))
                                     (SPADCALL |l| 4 (QREFELT $ 28))
                                     (SPADCALL |l| 5 (QREFELT $ 28))
                                     (SPADCALL |l| 6 (QREFELT $ 28))
                                     (SPADCALL |l| 7 (QREFELT $ 28))
                                     (SPADCALL |l| 8 (QREFELT $ 28))
                                     (SPADCALL |l| 9 (QREFELT $ 28))
                                     (SPADCALL |l| 10 (QREFELT $ 28))
                                     (SPADCALL |l| 11 (QREFELT $ 28)))))
                        (EXIT
                         (|PGE;llli2gp|
                          (LIST |a|
                                (LIST
                                 (LIST (SPADCALL |l| 1 (QREFELT $ 28))
                                       (SPADCALL |l| 6 (QREFELT $ 28))
                                       (SPADCALL |l| 5 (QREFELT $ 28))
                                       (SPADCALL |l| 8 (QREFELT $ 28))
                                       (SPADCALL |l| 3 (QREFELT $ 28))
                                       (SPADCALL |l| 7 (QREFELT $ 28))
                                       (SPADCALL |l| 4 (QREFELT $ 28))
                                       (SPADCALL |l| 2 (QREFELT $ 28))
                                       (SPADCALL |l| 9 (QREFELT $ 28))
                                       (SPADCALL |l| 10 (QREFELT $ 28)))
                                 (LIST (SPADCALL |l| 11 (QREFELT $ 28))
                                       (SPADCALL |l| 12 (QREFELT $ 28)))))
                          $))))))))) 

(SDEFUN |PGE;mathieu12;Pg;9| (($ (|PermutationGroup| (|Integer|))))
        (SPADCALL (|PGE;li1n| 12 $) (QREFELT $ 31))) 

(SDEFUN |PGE;mathieu22;LPg;10|
        ((|l| (|List| (|Integer|))) ($ (|PermutationGroup| (|Integer|))))
        (SPROG
         ((|b| (|List| (|List| #1=(|Integer|)))) (|a| (|List| (|List| #1#))))
         (SEQ (LETT |l| (SPADCALL |l| (QREFELT $ 24)))
              (EXIT
               (COND
                ((SPADCALL (LENGTH |l|) 22 (QREFELT $ 27))
                 (|error| "Exactly 22 integers for mathieu22 needed !"))
                ('T
                 (SEQ
                  (LETT |a|
                        (LIST
                         (LIST (SPADCALL |l| 1 (QREFELT $ 28))
                               (SPADCALL |l| 2 (QREFELT $ 28))
                               (SPADCALL |l| 4 (QREFELT $ 28))
                               (SPADCALL |l| 8 (QREFELT $ 28))
                               (SPADCALL |l| 16 (QREFELT $ 28))
                               (SPADCALL |l| 9 (QREFELT $ 28))
                               (SPADCALL |l| 18 (QREFELT $ 28))
                               (SPADCALL |l| 13 (QREFELT $ 28))
                               (SPADCALL |l| 3 (QREFELT $ 28))
                               (SPADCALL |l| 6 (QREFELT $ 28))
                               (SPADCALL |l| 12 (QREFELT $ 28)))
                         (LIST (SPADCALL |l| 5 (QREFELT $ 28))
                               (SPADCALL |l| 10 (QREFELT $ 28))
                               (SPADCALL |l| 20 (QREFELT $ 28))
                               (SPADCALL |l| 17 (QREFELT $ 28))
                               (SPADCALL |l| 11 (QREFELT $ 28))
                               (SPADCALL |l| 22 (QREFELT $ 28))
                               (SPADCALL |l| 21 (QREFELT $ 28))
                               (SPADCALL |l| 19 (QREFELT $ 28))
                               (SPADCALL |l| 15 (QREFELT $ 28))
                               (SPADCALL |l| 7 (QREFELT $ 28))
                               (SPADCALL |l| 14 (QREFELT $ 28)))))
                  (LETT |b|
                        (LIST
                         (LIST (SPADCALL |l| 1 (QREFELT $ 28))
                               (SPADCALL |l| 2 (QREFELT $ 28))
                               (SPADCALL |l| 6 (QREFELT $ 28))
                               (SPADCALL |l| 18 (QREFELT $ 28)))
                         (LIST (SPADCALL |l| 3 (QREFELT $ 28))
                               (SPADCALL |l| 15 (QREFELT $ 28)))
                         (LIST (SPADCALL |l| 5 (QREFELT $ 28))
                               (SPADCALL |l| 8 (QREFELT $ 28))
                               (SPADCALL |l| 21 (QREFELT $ 28))
                               (SPADCALL |l| 13 (QREFELT $ 28)))
                         (LIST (SPADCALL |l| 7 (QREFELT $ 28))
                               (SPADCALL |l| 9 (QREFELT $ 28))
                               (SPADCALL |l| 20 (QREFELT $ 28))
                               (SPADCALL |l| 12 (QREFELT $ 28)))
                         (LIST (SPADCALL |l| 10 (QREFELT $ 28))
                               (SPADCALL |l| 16 (QREFELT $ 28)))
                         (LIST (SPADCALL |l| 11 (QREFELT $ 28))
                               (SPADCALL |l| 19 (QREFELT $ 28))
                               (SPADCALL |l| 14 (QREFELT $ 28))
                               (SPADCALL |l| 22 (QREFELT $ 28)))))
                  (EXIT (|PGE;llli2gp| (LIST |a| |b|) $))))))))) 

(SDEFUN |PGE;mathieu22;Pg;11| (($ (|PermutationGroup| (|Integer|))))
        (SPADCALL (|PGE;li1n| 22 $) (QREFELT $ 33))) 

(SDEFUN |PGE;mathieu23;LPg;12|
        ((|l| (|List| (|Integer|))) ($ (|PermutationGroup| (|Integer|))))
        (SPROG
         ((|b| (|List| (|List| #1=(|Integer|)))) (|a| (|List| (|List| #1#))))
         (SEQ (LETT |l| (SPADCALL |l| (QREFELT $ 24)))
              (EXIT
               (COND
                ((SPADCALL (LENGTH |l|) 23 (QREFELT $ 27))
                 (|error| "Exactly 23 integers for mathieu23 needed !"))
                ('T
                 (SEQ
                  (LETT |a|
                        (LIST
                         (LIST (SPADCALL |l| 1 (QREFELT $ 28))
                               (SPADCALL |l| 2 (QREFELT $ 28))
                               (SPADCALL |l| 3 (QREFELT $ 28))
                               (SPADCALL |l| 4 (QREFELT $ 28))
                               (SPADCALL |l| 5 (QREFELT $ 28))
                               (SPADCALL |l| 6 (QREFELT $ 28))
                               (SPADCALL |l| 7 (QREFELT $ 28))
                               (SPADCALL |l| 8 (QREFELT $ 28))
                               (SPADCALL |l| 9 (QREFELT $ 28))
                               (SPADCALL |l| 10 (QREFELT $ 28))
                               (SPADCALL |l| 11 (QREFELT $ 28))
                               (SPADCALL |l| 12 (QREFELT $ 28))
                               (SPADCALL |l| 13 (QREFELT $ 28))
                               (SPADCALL |l| 14 (QREFELT $ 28))
                               (SPADCALL |l| 15 (QREFELT $ 28))
                               (SPADCALL |l| 16 (QREFELT $ 28))
                               (SPADCALL |l| 17 (QREFELT $ 28))
                               (SPADCALL |l| 18 (QREFELT $ 28))
                               (SPADCALL |l| 19 (QREFELT $ 28))
                               (SPADCALL |l| 20 (QREFELT $ 28))
                               (SPADCALL |l| 21 (QREFELT $ 28))
                               (SPADCALL |l| 22 (QREFELT $ 28))
                               (SPADCALL |l| 23 (QREFELT $ 28)))))
                  (LETT |b|
                        (LIST
                         (LIST (SPADCALL |l| 2 (QREFELT $ 28))
                               (SPADCALL |l| 16 (QREFELT $ 28))
                               (SPADCALL |l| 9 (QREFELT $ 28))
                               (SPADCALL |l| 6 (QREFELT $ 28))
                               (SPADCALL |l| 8 (QREFELT $ 28)))
                         (LIST (SPADCALL |l| 3 (QREFELT $ 28))
                               (SPADCALL |l| 12 (QREFELT $ 28))
                               (SPADCALL |l| 13 (QREFELT $ 28))
                               (SPADCALL |l| 18 (QREFELT $ 28))
                               (SPADCALL |l| 4 (QREFELT $ 28)))
                         (LIST (SPADCALL |l| 7 (QREFELT $ 28))
                               (SPADCALL |l| 17 (QREFELT $ 28))
                               (SPADCALL |l| 10 (QREFELT $ 28))
                               (SPADCALL |l| 11 (QREFELT $ 28))
                               (SPADCALL |l| 22 (QREFELT $ 28)))
                         (LIST (SPADCALL |l| 14 (QREFELT $ 28))
                               (SPADCALL |l| 19 (QREFELT $ 28))
                               (SPADCALL |l| 21 (QREFELT $ 28))
                               (SPADCALL |l| 20 (QREFELT $ 28))
                               (SPADCALL |l| 15 (QREFELT $ 28)))))
                  (EXIT (|PGE;llli2gp| (LIST |a| |b|) $))))))))) 

(SDEFUN |PGE;mathieu23;Pg;13| (($ (|PermutationGroup| (|Integer|))))
        (SPADCALL (|PGE;li1n| 23 $) (QREFELT $ 35))) 

(SDEFUN |PGE;mathieu24;LPg;14|
        ((|l| (|List| (|Integer|))) ($ (|PermutationGroup| (|Integer|))))
        (SPROG
         ((|b| (|List| (|List| #1=(|Integer|)))) (|a| (|List| (|List| #1#))))
         (SEQ (LETT |l| (SPADCALL |l| (QREFELT $ 24)))
              (EXIT
               (COND
                ((SPADCALL (LENGTH |l|) 24 (QREFELT $ 27))
                 (|error| "Exactly 24 integers for mathieu24 needed !"))
                ('T
                 (SEQ
                  (LETT |a|
                        (LIST
                         (LIST (SPADCALL |l| 1 (QREFELT $ 28))
                               (SPADCALL |l| 16 (QREFELT $ 28))
                               (SPADCALL |l| 10 (QREFELT $ 28))
                               (SPADCALL |l| 22 (QREFELT $ 28))
                               (SPADCALL |l| 24 (QREFELT $ 28)))
                         (LIST (SPADCALL |l| 2 (QREFELT $ 28))
                               (SPADCALL |l| 12 (QREFELT $ 28))
                               (SPADCALL |l| 18 (QREFELT $ 28))
                               (SPADCALL |l| 21 (QREFELT $ 28))
                               (SPADCALL |l| 7 (QREFELT $ 28)))
                         (LIST (SPADCALL |l| 4 (QREFELT $ 28))
                               (SPADCALL |l| 5 (QREFELT $ 28))
                               (SPADCALL |l| 8 (QREFELT $ 28))
                               (SPADCALL |l| 6 (QREFELT $ 28))
                               (SPADCALL |l| 17 (QREFELT $ 28)))
                         (LIST (SPADCALL |l| 9 (QREFELT $ 28))
                               (SPADCALL |l| 11 (QREFELT $ 28))
                               (SPADCALL |l| 13 (QREFELT $ 28))
                               (SPADCALL |l| 19 (QREFELT $ 28))
                               (SPADCALL |l| 15 (QREFELT $ 28)))))
                  (LETT |b|
                        (LIST
                         (LIST (SPADCALL |l| 1 (QREFELT $ 28))
                               (SPADCALL |l| 22 (QREFELT $ 28))
                               (SPADCALL |l| 13 (QREFELT $ 28))
                               (SPADCALL |l| 14 (QREFELT $ 28))
                               (SPADCALL |l| 6 (QREFELT $ 28))
                               (SPADCALL |l| 20 (QREFELT $ 28))
                               (SPADCALL |l| 3 (QREFELT $ 28))
                               (SPADCALL |l| 21 (QREFELT $ 28))
                               (SPADCALL |l| 8 (QREFELT $ 28))
                               (SPADCALL |l| 11 (QREFELT $ 28)))
                         (LIST (SPADCALL |l| 2 (QREFELT $ 28))
                               (SPADCALL |l| 10 (QREFELT $ 28)))
                         (LIST (SPADCALL |l| 4 (QREFELT $ 28))
                               (SPADCALL |l| 15 (QREFELT $ 28))
                               (SPADCALL |l| 18 (QREFELT $ 28))
                               (SPADCALL |l| 17 (QREFELT $ 28))
                               (SPADCALL |l| 16 (QREFELT $ 28))
                               (SPADCALL |l| 5 (QREFELT $ 28))
                               (SPADCALL |l| 9 (QREFELT $ 28))
                               (SPADCALL |l| 19 (QREFELT $ 28))
                               (SPADCALL |l| 12 (QREFELT $ 28))
                               (SPADCALL |l| 7 (QREFELT $ 28)))
                         (LIST (SPADCALL |l| 23 (QREFELT $ 28))
                               (SPADCALL |l| 24 (QREFELT $ 28)))))
                  (EXIT (|PGE;llli2gp| (LIST |a| |b|) $))))))))) 

(SDEFUN |PGE;mathieu24;Pg;15| (($ (|PermutationGroup| (|Integer|))))
        (SPADCALL (|PGE;li1n| 24 $) (QREFELT $ 37))) 

(SDEFUN |PGE;janko2;LPg;16|
        ((|l| (|List| (|Integer|))) ($ (|PermutationGroup| (|Integer|))))
        (SPROG
         ((|b| (|List| (|List| #1=(|Integer|)))) (|a| (|List| (|List| #1#))))
         (SEQ (LETT |l| (SPADCALL |l| (QREFELT $ 24)))
              (EXIT
               (COND
                ((SPADCALL (LENGTH |l|) 100 (QREFELT $ 27))
                 (|error| "Exactly 100 integers for janko2 needed !"))
                ('T
                 (SEQ
                  (LETT |a|
                        (LIST
                         (LIST (SPADCALL |l| 2 (QREFELT $ 28))
                               (SPADCALL |l| 3 (QREFELT $ 28))
                               (SPADCALL |l| 4 (QREFELT $ 28))
                               (SPADCALL |l| 5 (QREFELT $ 28))
                               (SPADCALL |l| 6 (QREFELT $ 28))
                               (SPADCALL |l| 7 (QREFELT $ 28))
                               (SPADCALL |l| 8 (QREFELT $ 28)))
                         (LIST (SPADCALL |l| 9 (QREFELT $ 28))
                               (SPADCALL |l| 10 (QREFELT $ 28))
                               (SPADCALL |l| 11 (QREFELT $ 28))
                               (SPADCALL |l| 12 (QREFELT $ 28))
                               (SPADCALL |l| 13 (QREFELT $ 28))
                               (SPADCALL |l| 14 (QREFELT $ 28))
                               (SPADCALL |l| 15 (QREFELT $ 28)))
                         (LIST (SPADCALL |l| 16 (QREFELT $ 28))
                               (SPADCALL |l| 17 (QREFELT $ 28))
                               (SPADCALL |l| 18 (QREFELT $ 28))
                               (SPADCALL |l| 19 (QREFELT $ 28))
                               (SPADCALL |l| 20 (QREFELT $ 28))
                               (SPADCALL |l| 21 (QREFELT $ 28))
                               (SPADCALL |l| 22 (QREFELT $ 28)))
                         (LIST (SPADCALL |l| 23 (QREFELT $ 28))
                               (SPADCALL |l| 24 (QREFELT $ 28))
                               (SPADCALL |l| 25 (QREFELT $ 28))
                               (SPADCALL |l| 26 (QREFELT $ 28))
                               (SPADCALL |l| 27 (QREFELT $ 28))
                               (SPADCALL |l| 28 (QREFELT $ 28))
                               (SPADCALL |l| 29 (QREFELT $ 28)))
                         (LIST (SPADCALL |l| 30 (QREFELT $ 28))
                               (SPADCALL |l| 31 (QREFELT $ 28))
                               (SPADCALL |l| 32 (QREFELT $ 28))
                               (SPADCALL |l| 33 (QREFELT $ 28))
                               (SPADCALL |l| 34 (QREFELT $ 28))
                               (SPADCALL |l| 35 (QREFELT $ 28))
                               (SPADCALL |l| 36 (QREFELT $ 28)))
                         (LIST (SPADCALL |l| 37 (QREFELT $ 28))
                               (SPADCALL |l| 38 (QREFELT $ 28))
                               (SPADCALL |l| 39 (QREFELT $ 28))
                               (SPADCALL |l| 40 (QREFELT $ 28))
                               (SPADCALL |l| 41 (QREFELT $ 28))
                               (SPADCALL |l| 42 (QREFELT $ 28))
                               (SPADCALL |l| 43 (QREFELT $ 28)))
                         (LIST (SPADCALL |l| 44 (QREFELT $ 28))
                               (SPADCALL |l| 45 (QREFELT $ 28))
                               (SPADCALL |l| 46 (QREFELT $ 28))
                               (SPADCALL |l| 47 (QREFELT $ 28))
                               (SPADCALL |l| 48 (QREFELT $ 28))
                               (SPADCALL |l| 49 (QREFELT $ 28))
                               (SPADCALL |l| 50 (QREFELT $ 28)))
                         (LIST (SPADCALL |l| 51 (QREFELT $ 28))
                               (SPADCALL |l| 52 (QREFELT $ 28))
                               (SPADCALL |l| 53 (QREFELT $ 28))
                               (SPADCALL |l| 54 (QREFELT $ 28))
                               (SPADCALL |l| 55 (QREFELT $ 28))
                               (SPADCALL |l| 56 (QREFELT $ 28))
                               (SPADCALL |l| 57 (QREFELT $ 28)))
                         (LIST (SPADCALL |l| 58 (QREFELT $ 28))
                               (SPADCALL |l| 59 (QREFELT $ 28))
                               (SPADCALL |l| 60 (QREFELT $ 28))
                               (SPADCALL |l| 61 (QREFELT $ 28))
                               (SPADCALL |l| 62 (QREFELT $ 28))
                               (SPADCALL |l| 63 (QREFELT $ 28))
                               (SPADCALL |l| 64 (QREFELT $ 28)))
                         (LIST (SPADCALL |l| 65 (QREFELT $ 28))
                               (SPADCALL |l| 66 (QREFELT $ 28))
                               (SPADCALL |l| 67 (QREFELT $ 28))
                               (SPADCALL |l| 68 (QREFELT $ 28))
                               (SPADCALL |l| 69 (QREFELT $ 28))
                               (SPADCALL |l| 70 (QREFELT $ 28))
                               (SPADCALL |l| 71 (QREFELT $ 28)))
                         (LIST (SPADCALL |l| 72 (QREFELT $ 28))
                               (SPADCALL |l| 73 (QREFELT $ 28))
                               (SPADCALL |l| 74 (QREFELT $ 28))
                               (SPADCALL |l| 75 (QREFELT $ 28))
                               (SPADCALL |l| 76 (QREFELT $ 28))
                               (SPADCALL |l| 77 (QREFELT $ 28))
                               (SPADCALL |l| 78 (QREFELT $ 28)))
                         (LIST (SPADCALL |l| 79 (QREFELT $ 28))
                               (SPADCALL |l| 80 (QREFELT $ 28))
                               (SPADCALL |l| 81 (QREFELT $ 28))
                               (SPADCALL |l| 82 (QREFELT $ 28))
                               (SPADCALL |l| 83 (QREFELT $ 28))
                               (SPADCALL |l| 84 (QREFELT $ 28))
                               (SPADCALL |l| 85 (QREFELT $ 28)))
                         (LIST (SPADCALL |l| 86 (QREFELT $ 28))
                               (SPADCALL |l| 87 (QREFELT $ 28))
                               (SPADCALL |l| 88 (QREFELT $ 28))
                               (SPADCALL |l| 89 (QREFELT $ 28))
                               (SPADCALL |l| 90 (QREFELT $ 28))
                               (SPADCALL |l| 91 (QREFELT $ 28))
                               (SPADCALL |l| 92 (QREFELT $ 28)))
                         (LIST (SPADCALL |l| 93 (QREFELT $ 28))
                               (SPADCALL |l| 94 (QREFELT $ 28))
                               (SPADCALL |l| 95 (QREFELT $ 28))
                               (SPADCALL |l| 96 (QREFELT $ 28))
                               (SPADCALL |l| 97 (QREFELT $ 28))
                               (SPADCALL |l| 98 (QREFELT $ 28))
                               (SPADCALL |l| 99 (QREFELT $ 28)))))
                  (LETT |b|
                        (LIST
                         (LIST (SPADCALL |l| 1 (QREFELT $ 28))
                               (SPADCALL |l| 74 (QREFELT $ 28))
                               (SPADCALL |l| 83 (QREFELT $ 28))
                               (SPADCALL |l| 21 (QREFELT $ 28))
                               (SPADCALL |l| 36 (QREFELT $ 28))
                               (SPADCALL |l| 77 (QREFELT $ 28))
                               (SPADCALL |l| 44 (QREFELT $ 28))
                               (SPADCALL |l| 80 (QREFELT $ 28))
                               (SPADCALL |l| 64 (QREFELT $ 28))
                               (SPADCALL |l| 2 (QREFELT $ 28))
                               (SPADCALL |l| 34 (QREFELT $ 28))
                               (SPADCALL |l| 75 (QREFELT $ 28))
                               (SPADCALL |l| 48 (QREFELT $ 28))
                               (SPADCALL |l| 17 (QREFELT $ 28))
                               (SPADCALL |l| 100 (QREFELT $ 28)))
                         (LIST (SPADCALL |l| 3 (QREFELT $ 28))
                               (SPADCALL |l| 15 (QREFELT $ 28))
                               (SPADCALL |l| 31 (QREFELT $ 28))
                               (SPADCALL |l| 52 (QREFELT $ 28))
                               (SPADCALL |l| 19 (QREFELT $ 28))
                               (SPADCALL |l| 11 (QREFELT $ 28))
                               (SPADCALL |l| 73 (QREFELT $ 28))
                               (SPADCALL |l| 79 (QREFELT $ 28))
                               (SPADCALL |l| 26 (QREFELT $ 28))
                               (SPADCALL |l| 56 (QREFELT $ 28))
                               (SPADCALL |l| 41 (QREFELT $ 28))
                               (SPADCALL |l| 99 (QREFELT $ 28))
                               (SPADCALL |l| 39 (QREFELT $ 28))
                               (SPADCALL |l| 84 (QREFELT $ 28))
                               (SPADCALL |l| 90 (QREFELT $ 28)))
                         (LIST (SPADCALL |l| 4 (QREFELT $ 28))
                               (SPADCALL |l| 57 (QREFELT $ 28))
                               (SPADCALL |l| 86 (QREFELT $ 28))
                               (SPADCALL |l| 63 (QREFELT $ 28))
                               (SPADCALL |l| 85 (QREFELT $ 28))
                               (SPADCALL |l| 95 (QREFELT $ 28))
                               (SPADCALL |l| 82 (QREFELT $ 28))
                               (SPADCALL |l| 97 (QREFELT $ 28))
                               (SPADCALL |l| 98 (QREFELT $ 28))
                               (SPADCALL |l| 81 (QREFELT $ 28))
                               (SPADCALL |l| 8 (QREFELT $ 28))
                               (SPADCALL |l| 69 (QREFELT $ 28))
                               (SPADCALL |l| 38 (QREFELT $ 28))
                               (SPADCALL |l| 43 (QREFELT $ 28))
                               (SPADCALL |l| 58 (QREFELT $ 28)))
                         (LIST (SPADCALL |l| 5 (QREFELT $ 28))
                               (SPADCALL |l| 66 (QREFELT $ 28))
                               (SPADCALL |l| 49 (QREFELT $ 28))
                               (SPADCALL |l| 59 (QREFELT $ 28))
                               (SPADCALL |l| 61 (QREFELT $ 28)))
                         (LIST (SPADCALL |l| 6 (QREFELT $ 28))
                               (SPADCALL |l| 68 (QREFELT $ 28))
                               (SPADCALL |l| 89 (QREFELT $ 28))
                               (SPADCALL |l| 94 (QREFELT $ 28))
                               (SPADCALL |l| 92 (QREFELT $ 28))
                               (SPADCALL |l| 20 (QREFELT $ 28))
                               (SPADCALL |l| 13 (QREFELT $ 28))
                               (SPADCALL |l| 54 (QREFELT $ 28))
                               (SPADCALL |l| 24 (QREFELT $ 28))
                               (SPADCALL |l| 51 (QREFELT $ 28))
                               (SPADCALL |l| 87 (QREFELT $ 28))
                               (SPADCALL |l| 27 (QREFELT $ 28))
                               (SPADCALL |l| 76 (QREFELT $ 28))
                               (SPADCALL |l| 23 (QREFELT $ 28))
                               (SPADCALL |l| 67 (QREFELT $ 28)))
                         (LIST (SPADCALL |l| 7 (QREFELT $ 28))
                               (SPADCALL |l| 72 (QREFELT $ 28))
                               (SPADCALL |l| 22 (QREFELT $ 28))
                               (SPADCALL |l| 35 (QREFELT $ 28))
                               (SPADCALL |l| 30 (QREFELT $ 28))
                               (SPADCALL |l| 70 (QREFELT $ 28))
                               (SPADCALL |l| 47 (QREFELT $ 28))
                               (SPADCALL |l| 62 (QREFELT $ 28))
                               (SPADCALL |l| 45 (QREFELT $ 28))
                               (SPADCALL |l| 46 (QREFELT $ 28))
                               (SPADCALL |l| 40 (QREFELT $ 28))
                               (SPADCALL |l| 28 (QREFELT $ 28))
                               (SPADCALL |l| 65 (QREFELT $ 28))
                               (SPADCALL |l| 93 (QREFELT $ 28))
                               (SPADCALL |l| 42 (QREFELT $ 28)))
                         (LIST (SPADCALL |l| 9 (QREFELT $ 28))
                               (SPADCALL |l| 71 (QREFELT $ 28))
                               (SPADCALL |l| 37 (QREFELT $ 28))
                               (SPADCALL |l| 91 (QREFELT $ 28))
                               (SPADCALL |l| 18 (QREFELT $ 28))
                               (SPADCALL |l| 55 (QREFELT $ 28))
                               (SPADCALL |l| 96 (QREFELT $ 28))
                               (SPADCALL |l| 60 (QREFELT $ 28))
                               (SPADCALL |l| 16 (QREFELT $ 28))
                               (SPADCALL |l| 53 (QREFELT $ 28))
                               (SPADCALL |l| 50 (QREFELT $ 28))
                               (SPADCALL |l| 25 (QREFELT $ 28))
                               (SPADCALL |l| 32 (QREFELT $ 28))
                               (SPADCALL |l| 14 (QREFELT $ 28))
                               (SPADCALL |l| 33 (QREFELT $ 28)))
                         (LIST (SPADCALL |l| 10 (QREFELT $ 28))
                               (SPADCALL |l| 78 (QREFELT $ 28))
                               (SPADCALL |l| 88 (QREFELT $ 28))
                               (SPADCALL |l| 29 (QREFELT $ 28))
                               (SPADCALL |l| 12 (QREFELT $ 28)))))
                  (EXIT (|PGE;llli2gp| (LIST |a| |b|) $))))))))) 

(SDEFUN |PGE;janko2;Pg;17| (($ (|PermutationGroup| (|Integer|))))
        (SPADCALL (|PGE;li1n| 100 $) (QREFELT $ 39))) 

(SDEFUN |PGE;abelianGroup;LPg;18|
        ((|l| (|List| (|PositiveInteger|)))
         ($ (|PermutationGroup| (|Integer|))))
        (SPROG
         ((|element| (|Integer|))
          (|gens| (|List| (|List| (|List| (|Integer|))))) (#1=#:G780 NIL)
          (|i| NIL) (#2=#:G779 NIL) (#3=#:G778 NIL) (|n| NIL))
         (SEQ (LETT |gens| NIL) (LETT |element| 1)
              (SEQ (LETT |n| NIL) (LETT #3# |l|) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |n| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((> |n| 1)
                       (SEQ
                        (LETT |gens|
                              (CONS
                               (SPADCALL
                                (PROGN
                                 (LETT #2# NIL)
                                 (SEQ (LETT |i| |element|)
                                      (LETT #1# (- (+ |element| |n|) 1)) G190
                                      (COND ((> |i| #1#) (GO G191)))
                                      (SEQ (EXIT (LETT #2# (CONS |i| #2#))))
                                      (LETT |i| (+ |i| 1)) (GO G190) G191
                                      (EXIT (NREVERSE #2#))))
                                (QREFELT $ 18))
                               |gens|))
                        (EXIT (LETT |element| (+ |element| |n|))))))))
                   (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (|PGE;llli2gp|
                (COND ((EQL (LENGTH |gens|) 0) (LIST (LIST (LIST 1))))
                      ('T |gens|))
                $))))) 

(SDEFUN |PGE;alternatingGroup;LPg;19|
        ((|l| (|List| (|Integer|))) ($ (|PermutationGroup| (|Integer|))))
        (SPROG
         ((|gens| (|List| (|List| (|List| #1=(|Integer|)))))
          (|tmp| (|List| #1#)) (#2=#:G790 NIL) (|i| NIL) (#3=#:G789 NIL))
         (SEQ (LETT |l| (SPADCALL |l| (QREFELT $ 24)))
              (EXIT
               (COND
                ((EQL (LENGTH |l|) 0)
                 (|error| "Cannot construct alternating group on empty set"))
                ((< (LENGTH |l|) 3)
                 (|PGE;llli2gp|
                  (LIST (LIST (LIST (SPADCALL |l| 1 (QREFELT $ 28))))) $))
                ((EQL (LENGTH |l|) 3)
                 (|PGE;llli2gp|
                  (LIST
                   (LIST
                    (LIST (SPADCALL |l| 1 (QREFELT $ 28))
                          (SPADCALL |l| 2 (QREFELT $ 28))
                          (SPADCALL |l| 3 (QREFELT $ 28)))))
                  $))
                (#4='T
                 (SEQ
                  (LETT |tmp|
                        (PROGN
                         (LETT #3# NIL)
                         (SEQ (LETT |i| 3) (LETT #2# (LENGTH |l|)) G190
                              (COND ((> |i| #2#) (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #3#
                                      (CONS (SPADCALL |l| |i| (QREFELT $ 28))
                                            #3#))))
                              (LETT |i| (+ |i| 1)) (GO G190) G191
                              (EXIT (NREVERSE #3#)))))
                  (LETT |gens|
                        (LIST (LIST |tmp|)
                              (LIST
                               (LIST (SPADCALL |l| 1 (QREFELT $ 28))
                                     (SPADCALL |l| 2 (QREFELT $ 28))
                                     (SPADCALL |l| 3 (QREFELT $ 28))))))
                  (EXIT
                   (COND ((ODDP (LENGTH |l|)) (|PGE;llli2gp| |gens| $))
                         (#4#
                          (SEQ
                           (SPADCALL |gens| 1
                                     (CONS
                                      (LIST (SPADCALL |l| 1 (QREFELT $ 28))
                                            (SPADCALL |l| 2 (QREFELT $ 28)))
                                      (SPADCALL |gens| 1 (QREFELT $ 43)))
                                     (QREFELT $ 44))
                           (EXIT (|PGE;llli2gp| |gens| $))))))))))))) 

(SDEFUN |PGE;alternatingGroup;PiPg;20|
        ((|n| (|PositiveInteger|)) ($ (|PermutationGroup| (|Integer|))))
        (SPADCALL (|PGE;li1n| |n| $) (QREFELT $ 45))) 

(SDEFUN |PGE;symmetricGroup;LPg;21|
        ((|l| (|List| (|Integer|))) ($ (|PermutationGroup| (|Integer|))))
        (SEQ (LETT |l| (SPADCALL |l| (QREFELT $ 24)))
             (EXIT
              (COND
               ((EQL (LENGTH |l|) 0)
                (|error| "Cannot construct symmetric group on empty set !"))
               ((< (LENGTH |l|) 3) (|PGE;llli2gp| (LIST (LIST |l|)) $))
               ('T
                (|PGE;llli2gp|
                 (LIST (LIST |l|)
                       (LIST
                        (LIST (SPADCALL |l| 1 (QREFELT $ 28))
                              (SPADCALL |l| 2 (QREFELT $ 28)))))
                 $)))))) 

(SDEFUN |PGE;symmetricGroup;PiPg;22|
        ((|n| (|PositiveInteger|)) ($ (|PermutationGroup| (|Integer|))))
        (SPADCALL (|PGE;li1n| |n| $) (QREFELT $ 48))) 

(SDEFUN |PGE;cyclicGroup;LPg;23|
        ((|l| (|List| (|Integer|))) ($ (|PermutationGroup| (|Integer|))))
        (SEQ (LETT |l| (SPADCALL |l| (QREFELT $ 24)))
             (EXIT
              (COND
               ((EQL (LENGTH |l|) 0)
                (|error| "Cannot construct cyclic group on empty set"))
               ('T (|PGE;llli2gp| (LIST (LIST |l|)) $)))))) 

(SDEFUN |PGE;cyclicGroup;PiPg;24|
        ((|n| (|PositiveInteger|)) ($ (|PermutationGroup| (|Integer|))))
        (SPADCALL (|PGE;li1n| |n| $) (QREFELT $ 50))) 

(SDEFUN |PGE;dihedralGroup;LPg;25|
        ((|l| (|List| (|Integer|))) ($ (|PermutationGroup| (|Integer|))))
        (SPROG
         ((|tmp| (|List| (|List| (|Integer|)))) (#1=#:G805 NIL) (|i| NIL)
          (#2=#:G804 NIL))
         (SEQ (LETT |l| (SPADCALL |l| (QREFELT $ 24)))
              (EXIT
               (COND
                ((< (LENGTH |l|) 3)
                 (|error| "in dihedralGroup: Minimum of 3 elements needed !"))
                ('T
                 (SEQ
                  (LETT |tmp|
                        (PROGN
                         (LETT #2# NIL)
                         (SEQ (LETT |i| 1)
                              (LETT #1# (QUOTIENT2 (LENGTH |l|) 2)) G190
                              (COND ((|greater_SI| |i| #1#) (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #2#
                                      (CONS
                                       (LIST (SPADCALL |l| |i| (QREFELT $ 28))
                                             (SPADCALL |l|
                                                       (+ (- (LENGTH |l|) |i|)
                                                          1)
                                                       (QREFELT $ 28)))
                                       #2#))))
                              (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                              (EXIT (NREVERSE #2#)))))
                  (EXIT (|PGE;llli2gp| (LIST (LIST |l|) |tmp|) $))))))))) 

(SDEFUN |PGE;dihedralGroup;PiPg;26|
        ((|n| (|PositiveInteger|)) ($ (|PermutationGroup| (|Integer|))))
        (COND ((EQL |n| 1) (SPADCALL 2 (QREFELT $ 49)))
              ((EQL |n| 2)
               (|PGE;llli2gp| (LIST (LIST (LIST 1 2)) (LIST (LIST 3 4))) $))
              ('T (SPADCALL (|PGE;li1n| |n| $) (QREFELT $ 52))))) 

(DECLAIM (NOTINLINE |PermutationGroupExamples;|)) 

(DEFUN |PermutationGroupExamples| ()
  (SPROG NIL
         (PROG (#1=#:G808)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|PermutationGroupExamples|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|PermutationGroupExamples|
                             (LIST
                              (CONS NIL
                                    (CONS 1 (|PermutationGroupExamples;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache|
                        '|PermutationGroupExamples|)))))))))) 

(DEFUN |PermutationGroupExamples;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|PermutationGroupExamples|))
          (LETT $ (GETREFV 54))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PermutationGroupExamples| NIL
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|PermutationGroupExamples| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|List| 17) (|Permutation| 26)
              (0 . |cycles|) (|List| 7) (|Mapping| 7 6) (|List| 6)
              (|ListFunctions2| 6 7) (5 . |map|) (|PermutationGroup| 26)
              (11 . |coerce|) (16 . |One|) (|List| 26) (20 . |list|)
              |PGE;youngGroup;LPg;3| (|Partition|) (25 . |convert|)
              |PGE;youngGroup;PPg;4| |PGE;rubiksGroup;Pg;5|
              (30 . |removeDuplicates|) (|Boolean|) (|Integer|) (35 . ~=)
              (41 . |elt|) |PGE;mathieu11;LPg;6| |PGE;mathieu11;Pg;7|
              |PGE;mathieu12;LPg;8| |PGE;mathieu12;Pg;9| |PGE;mathieu22;LPg;10|
              |PGE;mathieu22;Pg;11| |PGE;mathieu23;LPg;12|
              |PGE;mathieu23;Pg;13| |PGE;mathieu24;LPg;14|
              |PGE;mathieu24;Pg;15| |PGE;janko2;LPg;16| |PGE;janko2;Pg;17|
              (|List| 46) |PGE;abelianGroup;LPg;18| (47 . |elt|)
              (53 . |setelt!|) |PGE;alternatingGroup;LPg;19|
              (|PositiveInteger|) |PGE;alternatingGroup;PiPg;20|
              |PGE;symmetricGroup;LPg;21| |PGE;symmetricGroup;PiPg;22|
              |PGE;cyclicGroup;LPg;23| |PGE;cyclicGroup;PiPg;24|
              |PGE;dihedralGroup;LPg;25| |PGE;dihedralGroup;PiPg;26|)
           '#(|youngGroup| 60 |symmetricGroup| 70 |rubiksGroup| 80 |mathieu24|
              84 |mathieu23| 93 |mathieu22| 102 |mathieu12| 111 |mathieu11| 120
              |janko2| 129 |dihedralGroup| 138 |cyclicGroup| 148
              |alternatingGroup| 158 |abelianGroup| 168)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|symmetricGroup|
                                 ((|PermutationGroup| (|Integer|))
                                  (|PositiveInteger|)))
                                T)
                              '((|symmetricGroup|
                                 ((|PermutationGroup| (|Integer|))
                                  (|List| (|Integer|))))
                                T)
                              '((|alternatingGroup|
                                 ((|PermutationGroup| (|Integer|))
                                  (|PositiveInteger|)))
                                T)
                              '((|alternatingGroup|
                                 ((|PermutationGroup| (|Integer|))
                                  (|List| (|Integer|))))
                                T)
                              '((|abelianGroup|
                                 ((|PermutationGroup| (|Integer|))
                                  (|List| (|PositiveInteger|))))
                                T)
                              '((|cyclicGroup|
                                 ((|PermutationGroup| (|Integer|))
                                  (|PositiveInteger|)))
                                T)
                              '((|cyclicGroup|
                                 ((|PermutationGroup| (|Integer|))
                                  (|List| (|Integer|))))
                                T)
                              '((|dihedralGroup|
                                 ((|PermutationGroup| (|Integer|))
                                  (|PositiveInteger|)))
                                T)
                              '((|dihedralGroup|
                                 ((|PermutationGroup| (|Integer|))
                                  (|List| (|Integer|))))
                                T)
                              '((|mathieu11|
                                 ((|PermutationGroup| (|Integer|))
                                  (|List| (|Integer|))))
                                T)
                              '((|mathieu11|
                                 ((|PermutationGroup| (|Integer|))))
                                T)
                              '((|mathieu12|
                                 ((|PermutationGroup| (|Integer|))
                                  (|List| (|Integer|))))
                                T)
                              '((|mathieu12|
                                 ((|PermutationGroup| (|Integer|))))
                                T)
                              '((|mathieu22|
                                 ((|PermutationGroup| (|Integer|))
                                  (|List| (|Integer|))))
                                T)
                              '((|mathieu22|
                                 ((|PermutationGroup| (|Integer|))))
                                T)
                              '((|mathieu23|
                                 ((|PermutationGroup| (|Integer|))
                                  (|List| (|Integer|))))
                                T)
                              '((|mathieu23|
                                 ((|PermutationGroup| (|Integer|))))
                                T)
                              '((|mathieu24|
                                 ((|PermutationGroup| (|Integer|))
                                  (|List| (|Integer|))))
                                T)
                              '((|mathieu24|
                                 ((|PermutationGroup| (|Integer|))))
                                T)
                              '((|janko2|
                                 ((|PermutationGroup| (|Integer|))
                                  (|List| (|Integer|))))
                                T)
                              '((|janko2| ((|PermutationGroup| (|Integer|))))
                                T)
                              '((|rubiksGroup|
                                 ((|PermutationGroup| (|Integer|))))
                                T)
                              '((|youngGroup|
                                 ((|PermutationGroup| (|Integer|))
                                  (|List| (|Integer|))))
                                T)
                              '((|youngGroup|
                                 ((|PermutationGroup| (|Integer|))
                                  (|Partition|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 53
                                            '(1 7 0 6 8 2 12 9 10 11 13 1 14 0
                                              9 15 0 7 0 16 1 6 0 17 18 1 20 17
                                              0 21 1 17 0 0 24 2 26 25 0 0 27 2
                                              17 26 0 26 28 2 11 6 0 26 43 3 11
                                              6 0 26 6 44 1 0 14 20 22 1 0 14
                                              17 19 1 0 14 46 49 1 0 14 17 48 0
                                              0 14 23 1 0 14 17 37 0 0 14 38 1
                                              0 14 17 35 0 0 14 36 0 0 14 34 1
                                              0 14 17 33 1 0 14 17 31 0 0 14 32
                                              1 0 14 17 29 0 0 14 30 0 0 14 40
                                              1 0 14 17 39 1 0 14 17 52 1 0 14
                                              46 53 1 0 14 46 51 1 0 14 17 50 1
                                              0 14 46 47 1 0 14 17 45 1 0 14 41
                                              42)))))
           '|lookupComplete|)) 

(MAKEPROP '|PermutationGroupExamples| 'NILADIC T) 
