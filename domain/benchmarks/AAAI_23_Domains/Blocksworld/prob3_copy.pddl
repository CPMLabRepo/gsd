(define (problem BLOCKS-8-0)
(:domain BLOCKS)
(:objects H G F E C B D A - block)
(:INIT (CLEAR A) (CLEAR D) (CLEAR C) (ONTABLE E) (ONTABLE F)
 (ON D H) (ON H F) (HANDEMPTY))
(:goal (AND (ON D F) (ON F E) (ON E H) (ON H C) (ON C A) (ON A G) (ON G B)))
)