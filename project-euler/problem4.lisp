
(= 906609 \foldl1 max \filter [= #0 reverse]@to-string \flatten \[(outer-product *) #0 #0] \range 100 1000)
