(
(define-fun inv ((G16 Bool) (G2 Bool) (G6 Bool)) Bool (or G16 (not G6)))
)
(
(define-fun inv ((G11 Bool) (G12 Bool) (G16 Bool) (G2 Bool)) Bool (= G11 (and G12 G16)))
)
(
(define-fun inv ((CK Bool) (G10 Bool) (G11 Bool)) Bool (not (and G10 G11)))
)
(
(define-fun inv ((G13 Bool) (G6 Bool) (G8 Bool) (G9 Bool)) Bool (or G13 (not G8)))
)
(
(define-fun inv ((G17 Bool) (G6 Bool) (G7 Bool)) Bool (or G17 (not G6)))
)
(
(define-fun inv ((G11 Bool) (G13 Bool) (GND Bool)) Bool (not (and G11 G13)))
)
(
(define-fun inv ((G16 Bool) (G2 Bool) (G5 Bool) (G8 Bool)) Bool (or G16 (not G5)))
)
(
(define-fun inv ((G0 Bool) (G11 Bool) (G15 Bool) (G16 Bool) (G7 Bool)) Bool (not (and G11 G7)))
)
(
(define-fun inv ((G12 Bool) (G17 Bool) (G6 Bool) (G7 Bool)) Bool (= G6 G7))
)
(
(define-fun inv ((G0 Bool) (G11 Bool) (G12 Bool) (G6 Bool)) Bool (not (and G11 G6)))
)
(
(define-fun inv ((CK Bool) (G12 Bool) (G6 Bool) (GND Bool)) Bool (not (and G12 G6)))
)
(
(define-fun inv ((G10 Bool) (G16 Bool) (G2 Bool) (G3 Bool) (G9 Bool)) Bool (= G16 (or G3 (not G9))))
)
(
(define-fun inv ((G1 Bool) (G11 Bool) (G12 Bool) (G16 Bool) (G2 Bool)) Bool (= G11 (and G11 G16)))
)
(
(define-fun inv ((G1 Bool) (G10 Bool) (G15 Bool) (G9 Bool) (GND Bool)) Bool (= G10 (and G10 G9)))
)
(
(define-fun inv ((G0 Bool) (G10 Bool) (G5 Bool) (G8 Bool) (G9 Bool)) Bool (or G0 (not G10)))
)
(
(define-fun inv ((G1 Bool) (G13 Bool) (G14 Bool) (G17 Bool)) Bool (= G13 (and G13 G17)))
)
(
(define-fun inv ((G0 Bool) (G3 Bool) (G6 Bool)) Bool (or G0 (not (and G3 G6))))
)
(
(define-fun inv ((CK Bool) (G14 Bool) (G3 Bool) (G8 Bool)) Bool (not (and CK G8)))
)
(
(define-fun inv ((G15 Bool) (G16 Bool) (G2 Bool) (G9 Bool) (GND Bool)) Bool (or G15 G9))
)
(
(define-fun inv ((G11 Bool) (G13 Bool) (G15 Bool) (G7 Bool)) Bool (= G13 (and G13 (= G15 G7))))
)
(
(define-fun inv ((G10 Bool) (G12 Bool) (G17 Bool) (G5 Bool) (G8 Bool)) Bool (not (and G12 G8)))
)
(
(define-fun inv ((G11 Bool) (G12 Bool) (G14 Bool) (G16 Bool)) Bool (= G11 (and G11 G12)))
)
(
(define-fun inv ((CK Bool) (G11 Bool) (G7 Bool) (VDD Bool)) Bool (not (and G11 G7)))
)
(
(define-fun inv ((G0 Bool) (G1 Bool) (G3 Bool) (G6 Bool) (GND Bool)) Bool (not (and G6 GND)))
)
(
(define-fun inv ((G11 Bool) (G12 Bool) (G5 Bool) (GND Bool)) Bool (not (and G12 G5)))
)
(
(define-fun inv ((CK Bool) (G1 Bool) (G15 Bool) (G5 Bool) (G6 Bool)) Bool (= G5 G6))
)
(
(define-fun inv ((G11 Bool) (G14 Bool) (G9 Bool)) Bool (or G11 (or G14 G9)))
)
(
(define-fun inv ((CK Bool) (G1 Bool) (G12 Bool) (G2 Bool) (G7 Bool)) Bool (not (and G1 G12)))
)
(
(define-fun inv ((CK Bool) (G10 Bool) (G5 Bool) (G6 Bool) (G8 Bool)) Bool (= G5 G6))
)
(
(define-fun inv ((CK Bool) (G11 Bool) (G14 Bool) (G6 Bool) (G7 Bool)) Bool (= G6 G7))
)
(
(define-fun inv ((CK Bool) (G12 Bool) (G2 Bool) (G5 Bool)) Bool (not (and CK G5)))
)
(
(define-fun inv ((G10 Bool) (G14 Bool) (G16 Bool)) Bool (not (and G10 G14)))
)
(
(define-fun inv ((G0 Bool) (G12 Bool) (G14 Bool) (G17 Bool) (VDD Bool)) Bool (not (= G0 G14)))
)
(
(define-fun inv ((G0 Bool) (G1 Bool) (G17 Bool) (G9 Bool) (GND Bool)) Bool (or G9 (not (and G1 GND))))
)
