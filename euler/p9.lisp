
(defun sol (n)
    ($(foldl1' *)@car@$(filter $(/= 'nil))@flatten (map (lambda (a) (
        map (lambda (b) (
            if (= [[a * a] + [b * b]] [[[n - a] - b] ** 2])
                (tie a b [[n - a] - b])
                'nil
        )) (range a (floor@/ n 2))
    )) (range 1 (floor@/ n 3)))))

(println@sol 1000)
