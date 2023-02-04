
(defun public:huffman-encode (b) (○⊢¨
    (def ft \:[,⍧ ⍴∘⍎⍕ ⍎] \⌸ b)
    (defun ipq (pq el)
        \⍠⊣ pq el \⍴? (λ x \< (⍎ x) (⍎ el)) pq)
    (defun hstep pq
        \↕ (= 1 \⍴ pq) pq \ipq (⍕⍕ pq)
            \,⍧ (+ (⍎⍎ pq) (⍎∘⍎⍕ pq)) 
                (,⍧ (⍎⍕∘⍎ pq) (⍎⍕∘⍎⍕ pq)))
    (def htree \⍎∘⍕⍎ \→≡ hstep ft$[⍋ \⍎%[1] ft])
    (defun tag (t c) (↕ (= 0 \⍴ t) (,⍧ t (⌽ c))
        (⍠ (tag (⍎ t) (⍟ 0 c))
           (tag (⍎⍕ t) (⍟ 1 c)))))
    (def htab \⍡¨ ⍴⍴ \tag htree '⍬)
    (def eid \∊ (⍎ htab)$[∊?%[0 1] b (⍕ htab)])
    (def p \↑ (⌶∧ (+ (⍴ eid) 7) -8) eid)
    (,⍧ (⍴ eid) htab \:$(- _ 128)∘:$(⊥⍟ 2) \⍡ (⍉↩ (⍴ p) (↑ 8 '(1))) p)
))

(defun public:huffman-decode (b) (○⊢¨
    (def htab (⍎⍕ b))
    (defun unhuf (s d) (○⊢¨
        (def mi \⍎∘⍸∘:⍠⊂← (,⍧ s) (⍎ htab))
        (def nd (⍠ d \,⍧ (⍎⍕ htab)$[#0 mi]))
        (def ns (↓ (⍴ (⍎ htab)$[#0 mi]) s))
        (↕ (= 0 \⍴ ns) nd \unhuf ns nd)
    ))
    (unhuf (↑ (⍎ b) \∊∘:(λ x \⌽∘↑ 8 \⌽∘⊤⍟ 2 (+ 128 x)) \⍎∘⍕⍕ b) '⍬)
))
