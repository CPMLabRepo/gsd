(define (problem BLOCKS-7-2)
(:domain BLOCKS)
(:objects E G C D F A B - block)
(:INIT (CLEAR B) (CLEAR A) (ONTABLE D) (ON C G)
 (ON A D))
(:goal (AND (ON E B) (ON B F) (ON F D) (ON D A) (ON A C) (ON C G)))
)