(let ((numbers ()))
(with-open-file (in-stream "input.txt" :direction :input)
    (loop
        (setf numbers (cons (read in-stream) numbers))
        (or (read-char in-stream nil nil) (return))
    )
)
(dotimes (n (- 2020 (length numbers)))
 (setf numbers (cons (1+ (or (position (car numbers) (cdr numbers)) -1))
                     numbers
               ))
 
)
(print (car numbers))
)