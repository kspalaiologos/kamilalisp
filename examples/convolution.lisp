    (defun cell (mat) \if (/= (rank mat) 2)
      (raise "Expected a matrix.")
      \lambda (x y) \let-seq
        (def h (tally mat))
        (def w (tally (car mat)))
        \cond
          ((and (< x 0) (< y 0)) mat$[- (+ y 1)]$[- (+ x 1)])
          ((and (< x 0) (< y h)) mat$[#0 y]$[- (+ x 1)])
          ((and (< x 0) (>= y h)) mat$[- (- (* 2 h) 1) y]$[- (+ x 1)])
          ((and (< x w) (< y 0)) mat$[- (+ y 1)]$[#0 x])
          ((and (< x w) (>= y h)) mat$[- (- (* 2 h) 1) y]$[#0 x])
          ((and (>= x w) (< y 0)) mat$[- (+ y 1)]$[- (- (* 2 w) 1) x])
          ((and (>= x w) (< y h)) mat$[#0 y]$[- (- (* 2 w) 1) x])
          ((and (>= x w) (>= y h)) mat$[- (- (* 2 h) 1) y]$[- (- (* 2 w) 1) x])
          \mat$[#0 y]$[#0 x])
    
    (defun convolve-step (cell-mat kern x y) \let-seq
      (def kern-h \tally kern)
      (def kern-w \tally (car kern))
      (case (/= kern-h kern-w)
        \raise "Expected a square kernel.")
      (case (or (/= (mod kern-h 2) 1) (/= (mod kern-w 2) 1))
        \raise "Expected an odd-sized kernel.")
      (def kern-c \floor (/ kern-w 2))
      (def conv-range \flatten@outer-product
        (range (- x kern-c) \- (+ x kern-w) kern-c)
        (range (- y kern-c) \- (+ y kern-h) kern-c))
      (def conv-mat \:$(lift cell-mat) conv-range)
      \foldl + 0 \* (flatten conv-mat) \flatten kern)

    (defun public:convolve (mat kern) \let-seq
      (def cell-mat (cell mat))
      \parallel-map-idx (lambda (y row)
        \parallel-map-idx (lambda (x _e)
          \convolve-step cell-mat kern x y) row) mat)
    
    (defun public:convolve-rgb (img kern) (let-seq
      ; Extract the R, G and B channels of the image data.
      (def r \$($(^/ 255)@bit:unpack _ '(0 8))%[0] img)
      (def g \$($(^/ 255)@bit:unpack _ '(8 16))%[0] img)
      (def b \$($(^/ 255)@bit:unpack _ '(16 24))%[0] img)
      ; Convolve each channel and convert back to integer values.
      (defun quantize x (cond ((< x 0) 0) ((> x 1) 255) ((round@* x 255))))
      (def r \quantize%[0] \public:convolve r kern)
      (def g \quantize%[0] \public:convolve g kern)
      (def b \quantize%[0] \public:convolve b kern)
      ; Merge the channels back together.
      ((lambda (r g b)
        (bit:pack
          (tie 0 8 r)
          (tie 8 16 g)
          (tie 16 24 b)
          (tie 24 32 255)))%[0] r g b)))

    "OK"