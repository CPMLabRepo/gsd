(define (problem BLOCKS-7-1)
(:domain BLOCKS)
(:objects E B D F G C A - block)
(:INIT (ON A G) (ON C D) (ON D B)
 (ON B E) (HANDEMPTY))
(:goal (AND (ON A E) (ON E B) (ON B F) (ON F G) (ON G C) (ON C D)))
)