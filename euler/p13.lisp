
(println@str-join@$(take 10)@str-explode (
    to-string (foldl1' + (map parse-num (
        str-split (file-get "euler/p13.data") (ucs '(10)))))))
