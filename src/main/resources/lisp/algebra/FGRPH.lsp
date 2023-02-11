
(DEFPARAMETER |FiniteGraph;CAT| 'NIL) 

(DECLAIM (NOTINLINE |FiniteGraph;|)) 

(DEFPARAMETER |FiniteGraph;AL| 'NIL) 

(DEFUN |FiniteGraph| (|t#1|)
  (LET (#1=#:G743 (#2=#:G744 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |FiniteGraph;AL|)) (CDR #1#))
          (T
           (SETQ |FiniteGraph;AL|
                   (|cons5| (CONS #2# (SETQ #1# (|FiniteGraph;| #2#)))
                            |FiniteGraph;AL|))
           #1#)))) 

(DEFUN |FiniteGraph;| (|t#1|)
  (SPROG ((#1=#:G742 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND (|FiniteGraph;CAT|)
                                         ('T
                                          (LETT |FiniteGraph;CAT|
                                                (|Join| (|SetCategory|)
                                                        (|mkCategory|
                                                         '(((|addObject!|
                                                             ($ $ |t#1|))
                                                            T)
                                                           ((|addObject!|
                                                             ($ $
                                                              (|Record|
                                                               (|:| |value|
                                                                    |t#1|)
                                                               (|:| |posX|
                                                                    (|NonNegativeInteger|))
                                                               (|:| |posY|
                                                                    (|NonNegativeInteger|)))))
                                                            T)
                                                           ((|addArrow!|
                                                             ($ $
                                                              (|Record|
                                                               (|:| |name|
                                                                    (|String|))
                                                               (|:| |arrType|
                                                                    (|NonNegativeInteger|))
                                                               (|:| |fromOb|
                                                                    (|NonNegativeInteger|))
                                                               (|:| |toOb|
                                                                    (|NonNegativeInteger|))
                                                               (|:| |xOffset|
                                                                    (|Integer|))
                                                               (|:| |yOffset|
                                                                    (|Integer|))
                                                               (|:| |map|
                                                                    (|List|
                                                                     (|NonNegativeInteger|))))))
                                                            T)
                                                           ((|addArrow!|
                                                             ($ $ (|String|)
                                                              (|NonNegativeInteger|)
                                                              (|NonNegativeInteger|)))
                                                            T)
                                                           ((|addArrow!|
                                                             ($ $ (|String|)
                                                              (|NonNegativeInteger|)
                                                              (|NonNegativeInteger|)
                                                              (|List|
                                                               (|NonNegativeInteger|))))
                                                            T)
                                                           ((|addArrow!|
                                                             ($ $ (|String|)
                                                              |t#1| |t#1|))
                                                            T)
                                                           ((|getVertices|
                                                             ((|List|
                                                               (|Record|
                                                                (|:| |value|
                                                                     |t#1|)
                                                                (|:| |posX|
                                                                     (|NonNegativeInteger|))
                                                                (|:| |posY|
                                                                     (|NonNegativeInteger|))))
                                                              $))
                                                            T)
                                                           ((|getVertexIndex|
                                                             ((|NonNegativeInteger|)
                                                              $ |t#1|))
                                                            T)
                                                           ((|getArrows|
                                                             ((|List|
                                                               (|Record|
                                                                (|:| |name|
                                                                     (|String|))
                                                                (|:| |arrType|
                                                                     (|NonNegativeInteger|))
                                                                (|:| |fromOb|
                                                                     (|NonNegativeInteger|))
                                                                (|:| |toOb|
                                                                     (|NonNegativeInteger|))
                                                                (|:| |xOffset|
                                                                     (|Integer|))
                                                                (|:| |yOffset|
                                                                     (|Integer|))
                                                                (|:| |map|
                                                                     (|List|
                                                                      (|NonNegativeInteger|)))))
                                                              $))
                                                            T)
                                                           ((|flatten|
                                                             ($
                                                              (|DirectedGraph|
                                                               $)))
                                                            T)
                                                           ((|initial| ($)) T)
                                                           ((|terminal|
                                                             ($ |t#1|))
                                                            T)
                                                           ((|cycleOpen|
                                                             ($ (|List| |t#1|)
                                                              (|String|)))
                                                            T)
                                                           ((|cycleClosed|
                                                             ($ (|List| |t#1|)
                                                              (|String|)))
                                                            T)
                                                           ((|unit|
                                                             ($ (|List| |t#1|)
                                                              (|String|)))
                                                            T)
                                                           ((|kgraph|
                                                             ($ (|List| |t#1|)
                                                              (|String|)))
                                                            T)
                                                           ((|isDirectSuccessor?|
                                                             ((|Boolean|) $
                                                              (|NonNegativeInteger|)
                                                              (|NonNegativeInteger|)))
                                                            T)
                                                           ((|isGreaterThan?|
                                                             ((|Boolean|) $
                                                              (|NonNegativeInteger|)
                                                              (|NonNegativeInteger|)))
                                                            T)
                                                           ((|max|
                                                             ((|NonNegativeInteger|)
                                                              $))
                                                            T)
                                                           ((|max|
                                                             ((|NonNegativeInteger|)
                                                              $
                                                              (|List|
                                                               (|NonNegativeInteger|))))
                                                            T)
                                                           ((|min|
                                                             ((|NonNegativeInteger|)
                                                              $))
                                                            T)
                                                           ((|min|
                                                             ((|NonNegativeInteger|)
                                                              $
                                                              (|List|
                                                               (|NonNegativeInteger|))))
                                                            T)
                                                           ((|isFixPoint?|
                                                             ((|Boolean|) $
                                                              (|NonNegativeInteger|)))
                                                            T)
                                                           ((|arrowName|
                                                             ((|String|) $
                                                              (|NonNegativeInteger|)
                                                              (|NonNegativeInteger|)))
                                                            T)
                                                           ((|getArrowIndex|
                                                             ((|NonNegativeInteger|)
                                                              $
                                                              (|NonNegativeInteger|)
                                                              (|NonNegativeInteger|)))
                                                            T)
                                                           ((|inDegree|
                                                             ((|NonNegativeInteger|)
                                                              $
                                                              (|NonNegativeInteger|)))
                                                            T)
                                                           ((|outDegree|
                                                             ((|NonNegativeInteger|)
                                                              $
                                                              (|NonNegativeInteger|)))
                                                            T)
                                                           ((|nodeFromNode|
                                                             ((|List|
                                                               (|NonNegativeInteger|))
                                                              $
                                                              (|NonNegativeInteger|)))
                                                            T)
                                                           ((|nodeToNode|
                                                             ((|List|
                                                               (|NonNegativeInteger|))
                                                              $
                                                              (|NonNegativeInteger|)))
                                                            T)
                                                           ((|arrowsFromNode|
                                                             ((|List|
                                                               (|NonNegativeInteger|))
                                                              $
                                                              (|NonNegativeInteger|)))
                                                            T)
                                                           ((|arrowsToNode|
                                                             ((|List|
                                                               (|NonNegativeInteger|))
                                                              $
                                                              (|NonNegativeInteger|)))
                                                            T)
                                                           ((|nodeFromArrow|
                                                             ((|List|
                                                               (|NonNegativeInteger|))
                                                              $
                                                              (|NonNegativeInteger|)))
                                                            T)
                                                           ((|nodeToArrow|
                                                             ((|List|
                                                               (|NonNegativeInteger|))
                                                              $
                                                              (|NonNegativeInteger|)))
                                                            T)
                                                           ((|arrowsFromArrow|
                                                             ((|List|
                                                               (|NonNegativeInteger|))
                                                              $
                                                              (|NonNegativeInteger|)))
                                                            T)
                                                           ((|arrowsToArrow|
                                                             ((|List|
                                                               (|NonNegativeInteger|))
                                                              $
                                                              (|NonNegativeInteger|)))
                                                            T)
                                                           ((|routeNodes|
                                                             ((|List|
                                                               (|NonNegativeInteger|))
                                                              $
                                                              (|NonNegativeInteger|)
                                                              (|NonNegativeInteger|)))
                                                            T)
                                                           ((|routeArrows|
                                                             ((|List|
                                                               (|NonNegativeInteger|))
                                                              $
                                                              (|NonNegativeInteger|)
                                                              (|NonNegativeInteger|)))
                                                            T)
                                                           ((|distance|
                                                             ((|Integer|) $
                                                              (|NonNegativeInteger|)
                                                              (|NonNegativeInteger|)))
                                                            T)
                                                           ((+ ($ $ $)) T)
                                                           ((|merge| ($ $ $))
                                                            T)
                                                           ((|spanningTreeArrow|
                                                             ((|Tree|
                                                               (|Integer|))
                                                              $
                                                              (|NonNegativeInteger|)))
                                                            T)
                                                           ((|spanningForestArrow|
                                                             ((|List|
                                                               (|Tree|
                                                                (|Integer|)))
                                                              $))
                                                            T)
                                                           ((|spanningTreeNode|
                                                             ((|Tree|
                                                               (|Integer|))
                                                              $
                                                              (|NonNegativeInteger|)))
                                                            T)
                                                           ((|spanningForestNode|
                                                             ((|List|
                                                               (|Tree|
                                                                (|Integer|)))
                                                              $))
                                                            T)
                                                           ((|loopsNodes|
                                                             ((|List| (|Loop|))
                                                              $))
                                                            T)
                                                           ((|loopsAtNode|
                                                             ((|List| (|Loop|))
                                                              $
                                                              (|NonNegativeInteger|)))
                                                            T)
                                                           ((|loopsArrows|
                                                             ((|List| (|Loop|))
                                                              $))
                                                            T)
                                                           ((|isAcyclic?|
                                                             ((|Boolean|) $))
                                                            T)
                                                           ((|incidenceMatrix|
                                                             ((|Matrix|
                                                               (|Integer|))
                                                              $))
                                                            T)
                                                           ((|adjacencyMatrix|
                                                             ((|Matrix|
                                                               (|NonNegativeInteger|))
                                                              $))
                                                            T)
                                                           ((|laplacianMatrix|
                                                             ((|Matrix|
                                                               (|Integer|))
                                                              $))
                                                            T)
                                                           ((|distanceMatrix|
                                                             ((|Matrix|
                                                               (|Integer|))
                                                              $))
                                                            T)
                                                           ((|isFunctional?|
                                                             ((|Boolean|) $))
                                                            T)
                                                           ((|isDirected?|
                                                             ((|Boolean|)))
                                                            T)
                                                           ((|subdiagramSvg|
                                                             ((|Void|)
                                                              (|Scene|
                                                               (|SCartesian|
                                                                2))
                                                              $ (|Boolean|)
                                                              (|Boolean|)))
                                                            T)
                                                           ((|diagramSvg|
                                                             ((|Void|)
                                                              (|String|) $
                                                              (|Boolean|)))
                                                            T)
                                                           ((|diagramsSvg|
                                                             ((|Void|)
                                                              (|String|)
                                                              (|List| $)
                                                              (|Boolean|)))
                                                            T)
                                                           ((|deepDiagramSvg|
                                                             ((|Void|)
                                                              (|String|) $
                                                              (|Boolean|)))
                                                            T)
                                                           ((|diagramWidth|
                                                             ((|NonNegativeInteger|)
                                                              $))
                                                            T)
                                                           ((|diagramHeight|
                                                             ((|NonNegativeInteger|)
                                                              $))
                                                            T)
                                                           ((|createWidth|
                                                             ((|NonNegativeInteger|)
                                                              (|NonNegativeInteger|)))
                                                            T)
                                                           ((|createX|
                                                             ((|NonNegativeInteger|)
                                                              (|NonNegativeInteger|)
                                                              (|NonNegativeInteger|)))
                                                            T)
                                                           ((|createY|
                                                             ((|NonNegativeInteger|)
                                                              (|NonNegativeInteger|)
                                                              (|NonNegativeInteger|)))
                                                            T)
                                                           ((|looseEquals|
                                                             ((|Boolean|) $ $))
                                                            T)
                                                           ((|map|
                                                             ($ $
                                                              (|List|
                                                               (|NonNegativeInteger|))
                                                              (|List| |t#1|)
                                                              (|Integer|)
                                                              (|Integer|)))
                                                            T)
                                                           ((|mapContra|
                                                             ($ $
                                                              (|List|
                                                               (|NonNegativeInteger|))
                                                              (|List| |t#1|)
                                                              (|Integer|)
                                                              (|Integer|)))
                                                            T))
                                                         NIL NIL NIL)))))))
           (SETELT #1# 0 (LIST '|FiniteGraph| |t#1|))))) 
