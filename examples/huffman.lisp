
(defun public:huffman-encode (buf) (let-seq
    ; Compute the frequencies of each symbol in the file.
    (def freq-tab \:[tie tally@cadr car] \group buf)
    ; Sort by the frequencies in descending order.
    (def freq-pq freq-tab$[grade-up \car%[1] freq-tab])
    ; Helper: Insert an element into a priority queue.
    (defun insert-pq (pq el)
        \insert pq el
            \count (lambda x \< (car x) (car el)) pq)
    ; Perform a step of Huffman tree building.
    (defun huffman-step pq
        \if (= 1 \tally pq) pq
            \insert-pq (cddr pq)
                \tie (+ (caar pq) (car@cadr pq)) 
                    (tie (cadr@car pq) (cadr@cadr pq)))
    ; Build a Huffman tree from a frequency table.
    (def huffman-tree \car@cdar \converge huffman-step freq-pq)
    (defun tag (t code) (
        if (= 0 \tally t)
            (tie t (reverse code))
            (append (tag (car t) (cons 0 code))
                (tag (cadr t) (cons 1 code)))))
    (def huffman-tab \bipartition rank \tag huffman-tree 'nil)
    (def encoding-ids
        \flatten (car huffman-tab)$[$(car@index-of)%[1 1] (tie buf) (cdr huffman-tab)])
    (def padded \take (bit:and (+ (tally encoding-ids) 7) -8) encoding-ids)
    (tie (tally encoding-ids) huffman-tab
        \:$(- _ 128)@:$(decode 2) \partition (cycle (tally padded) (take 8 '(1))) padded)
))

(defun public:huffman-decode (buf) (let-seq
    (def bit-len (car buf))
    (def huffman-table (cadr buf))
    (def bit-stream (take bit-len \flatten@:(lambda x \reverse@take 8 \reverse@encode 2 (+ 128 x)) \car@cddr buf))
    (defun unhuffman-step (stream dec) (let-seq
        (def match-idx \car@where@:starts-with (tie stream) (car huffman-table))
        (def match-len \tally (car huffman-table)$[#0 match-idx])
        (def new-dec (append dec \tie (cadr huffman-table)$[#0 match-idx]))
        (def new-stream (drop match-len stream))
        (if (= 0 \tally new-stream) new-dec
            \unhuffman-step new-stream new-dec)
    ))
    (unhuffman-step bit-stream 'nil)
))
