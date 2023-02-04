
(defun public:huffman-encode (b) (○⊢¨
    (○← ft \:[,⍧ ⍴∘⍎⍕ ⍎] \⌸ b)
    (⍥← ipq (pq el) \⍠⊣ pq el \⍴? (λ x \< (⍎ x) (⍎ el)) pq)
    (⍥← hstep pq \↕ (= 1 \⍴ pq) pq \ipq (⍕⍕ pq)
        \,⍧ (+ (⍎⍎ pq) (⍎∘⍎⍕ pq)) (,⍧ (⍎⍕∘⍎ pq) (⍎⍕∘⍎⍕ pq)))
    (○← htree \⍎∘⍕⍎ \→≡ hstep ft$[⍋ \⍎%[1] ft])
    (⍥← tag (t c) (↕ (= 0 \⍴ t) (,⍧ t (⌽ c))
        (⍠ (tag (⍎ t) (⍟ 0 c)) (tag (⍎⍕ t) (⍟ 1 c)))))
    (○← htab \⍡¨ ⍴⍴ \tag htree '⍬)
    (○← eid \∊ (⍎ htab)$[∊?%[0 1] b (⍕ htab)])
    (○← p \↑ (⌶∧ (+ (⍴ eid) 7) -8) eid)
    (,⍧ (⍴ eid) htab \:$(- _ 128)∘:$(⊥⍟ 2) \⍡ (⍉↩ (⍴ p) (↑ 8 '(1))) p)
))

(defun public:huffman-decode (b) (○⊢¨
    (○← htab (⍎⍕ b)) (⍥← unhuf (s d) (○⊢¨
        (○← mi \⍎∘⍸∘:⍠⊂← (,⍧ s) (⍎ htab)) (○← nd (⍠ d \,⍧ (⍎⍕ htab)$[#0 mi]))
        (○← ns (↓ (⍴ (⍎ htab)$[#0 mi]) s)) (↕ (= 0 \⍴ ns) nd \&0 ns nd)))
    (unhuf (↑ (⍎ b) \∊∘:(λ x \⌽∘↑ 8 \⌽∘⊤⍟ 2 (+ 128 x)) \⍎∘⍕⍕ b) '⍬)
))
