(define (problem BLOCKS-7-1)
(:domain BLOCKS)
(:objects E B D F G C A - block)
(:INIT (CLEAR A) (CLEAR C) (ONTABLE G) (ONTABLE F) (ON A G) )
(:goal (AND (ON A E) (ON E B) (ON B F) (ON F G) (ON G C) (ON C D)))
)