(define (problem BLOCKS-7-1)
(:domain BLOCKS)
(:objects E B D F G C A - block)
(:INIT (CLEAR A) (CLEAR C) (ONTABLE G) (ON D B)
 (ON E F))
(:goal (AND (ON A E) (ON E B) (ON B F) (ON F G) (ON G C) (ON C D)))
)