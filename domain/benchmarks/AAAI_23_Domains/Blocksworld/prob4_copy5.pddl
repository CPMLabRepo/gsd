(define (problem BLOCKS-8-1)
(:domain BLOCKS)
(:objects B A G C F D H E - block)
(:INIT (CLEAR E) (CLEAR H) (CLEAR D) (ONTABLE C)
 (ONTABLE D) (ON E C) (ON A B) (HANDEMPTY))
(:goal (AND (ON C D) (ON D B) (ON B G) (ON G F) (ON F H) (ON H A) (ON A E)))
)