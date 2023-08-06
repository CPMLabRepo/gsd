(define (domain BLOCKS)
  (:requirements :strips :typing)
  (:types block)
  (:predicates (p)
           (q)
           (r)
           (s)
           (t)
           )

(:action act1
:parameters ()
:precondition
(and
( p)
)
:effect
(and
(q)
(r)
)
)

(:action act2
:parameters ()
:precondition
(and
(s)
)
:effect
(and
(t)
)
)

(:action act3
:parameters ()
:precondition
(and
(r)
)
:effect
(and
(t)
)
)



)
