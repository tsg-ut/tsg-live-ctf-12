(declare-datatype Tree (
	(node (left Tree) (right Tree))
	(leaf)
))

(declare-datatype Bl (
	(cons (value Bool) (node Bl))
	(nil)
))

; (define-fun-rec notv ((v Bl)) Bl (
; 	match v (
; 		(nil nil)
; 		((cons b c) (cons (not b) c))	
; 	)
; ))

(define-fun-rec insert ((x Tree) (v Bl)) Tree
	(match v (
		((nil) (node leaf leaf))
		((cons b c) (
			match x (
				((node ln rn) (ite b (
					node (insert ln c) rn
				) (
					node ln (insert rn c)
				)))
				((leaf) (ite b (
					node (insert leaf c) leaf
				) (
					node leaf (insert leaf c)
				)))
			)
		))
	))
)

(define-fun-rec tostr ((x Tree)) String 
	(match x (
		((node ln rn) (str.++ "(" (tostr ln) (tostr rn) ")"))
		(leaf "()") 
	))
)

; (define-fun-rec tostr ((x Tree) (t String)) Bool 
;	(match x (
;		((node ln rn) (exists
;			((ls String) (rs String)) 
;			(and (= t (str.++ "(" ls rs ")"))
;			(and (tostr ln ls) (tostr rn rs)))))
;		(leaf (= t "()"))
;	))
;	)

(define-fun-rec i2v_old ((x Int)) Bl
	(ite (= x 0)
		nil
	(
		cons (= 1 (mod x 2)) (i2v_old (div x 2))
	))
)

(define-fun-rec i2v ((x Int) (v Bl)) Bl
	(ite (= x 0)
		v
		(cons (= 1 (mod x 2)) (cons (= x 1) (i2v (div x 2) v)))
	)
)

(define-fun-rec ij2v ((x Int) (y Int)) Bl
	(i2v x (i2v y nil))
)

; (define-fun insert ((x (Tree Int))) (Tree Int)  
; 	(node (left x) (right x))
; )

; (declare-datatypes ((Tree 1)) (
;	 (par (X) (
;		(node (left (Tree X)) (right (Tree X)))
;		(leaf (value X))
;	 ))
; ))

(define-fun s2cl ((s String)) Int (ite (= " " s) 32 (ite (= "!" s) 33 (ite (= """" s) 34 (ite (= "#" s) 35 (ite (= "$" s) 36 (ite (= "%" s) 37 (ite (= "&" s) 38 (ite (= "'" s) 39 (ite (= "(" s) 40 (ite (= ")" s) 41 (ite (= "*" s) 42 (ite (= "+" s) 43 (ite (= "," s) 44 (ite (= "-" s) 45 (ite (= "." s) 46 (ite (= "/" s) 47 (ite (= "0" s) 48 (ite (= "1" s) 49 (ite (= "2" s) 50 (ite (= "3" s) 51 (ite (= "4" s) 52 (ite (= "5" s) 53 (ite (= "6" s) 54 (ite (= "7" s) 55 (ite (= "8" s) 56 (ite (= "9" s) 57 (ite (= ":" s) 58 (ite (= ";" s) 59 (ite (= "<" s) 60 (ite (= "=" s) 61 (ite (= ">" s) 62 (ite (= "?" s) 63 (ite (= "@" s) 64 (ite (= "A" s) 65 (ite (= "B" s) 66 (ite (= "C" s) 67 (ite (= "D" s) 68 (ite (= "E" s) 69 (ite (= "F" s) 70 (ite (= "G" s) 71 (ite (= "H" s) 72 (ite (= "I" s) 73 (ite (= "J" s) 74 (ite (= "K" s) 75 (ite (= "L" s) 76 (ite (= "M" s) 77 (ite (= "N" s) 78 (ite (= "O" s) 79 (ite (= "P" s) 80 (ite (= "Q" s) 81 (ite (= "R" s) 82 (ite (= "S" s) 83 (ite (= "T" s) 84 (ite (= "U" s) 85 (ite (= "V" s) 86 (ite (= "W" s) 87 (ite (= "X" s) 88 (ite (= "Y" s) 89 (ite (= "Z" s) 90 (ite (= "[" s) 91 (ite (= "\" s) 92 (ite (= "]" s) 93 (ite (= "^" s) 94 (ite (= "_" s) 95 (ite (= "`" s) 96 (ite (= "a" s) 97 (ite (= "b" s) 98 (ite (= "c" s) 99 (ite (= "d" s) 100 (ite (= "e" s) 101 (ite (= "f" s) 102 (ite (= "g" s) 103 (ite (= "h" s) 104 (ite (= "i" s) 105 (ite (= "j" s) 106 (ite (= "k" s) 107 (ite (= "l" s) 108 (ite (= "m" s) 109 (ite (= "n" s) 110 (ite (= "o" s) 111 (ite (= "p" s) 112 (ite (= "q" s) 113 (ite (= "r" s) 114 (ite (= "s" s) 115 (ite (= "t" s) 116 (ite (= "u" s) 117 (ite (= "v" s) 118 (ite (= "w" s) 119 (ite (= "x" s) 120 (ite (= "y" s) 121 (ite (= "z" s) 122 (ite (= "{" s) 123 (ite (= "|" s) 124 (ite (= "}" s) 125 (ite (= "~" s) 126 -1))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

(define-fun-rec s2tree ((s String) (i Int)) Tree (
	ite (< i 0) leaf (
		insert (s2tree s (- i 1)) (ij2v (s2cl (str.at s i)) (+ 1 i))
	)
))

(define-fun flag2s ((s String)) String
	(tostr (s2tree s (- (str.len s) 1)))
)


; (define-fun-rec s2tree ((s String) (i Int) (t Tree)) Bool (
; 	ite (< i 0) (= t leaf)
; 		(exists ((x Tree))
; 			(and
; 				(= t (insert x (ij2v (s2cl (str.at s i)) (+ 1 i))))
; 				(s2tree s (- i 1) x))
; 		)
; ))

; (declare-fun v () Int)
; (declare-fun p () Tree)
; (declare-fun ts () String)

; (declare-fun si () String)
; (assert (= 34 (s2cl si)))
; (assert (= si (str.at ts 0)))

; (assert (= v 123))
; (assert (= p (insert leaf (i2v v))))
; (assert (= ts (tostr p)))
; (assert (= s "(((()(()()))())())"))
; (assert (= ts "(((()((((()())())())()))())())"))

(declare-fun fs () String)
(declare-fun ts () String)
(assert (= fs "TSGLIVE{H4ve_y0u_tried_trie_ba5ed_encryp7ion?}"))
(assert (= ts (flag2s fs)))
(check-sat)
(get-value (fs ts))

; (get-value (v p ts si))


; (declare-datatypes ((Tree 1)) (
;	(par (X) ((node (Tree X) (Tree X)) (leaf (value X))))
;)

