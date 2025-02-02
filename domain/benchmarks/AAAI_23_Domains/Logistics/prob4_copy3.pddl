(define (problem logistics-5-0)
(:domain logistics)
(:objects
  apn1 - airplane
  apt2 apt1 - airport
  pos2 pos1 - location
  cit2 cit1 - city
  tru2 tru1 - truck
  obj23 obj22 obj21 obj13 obj12 obj11 - package)

(:init (at apn1 apt1) (at tru1 pos1) (at obj11 pos1)
 (at obj12 pos1) (at tru2 pos2) (at obj21 pos2) (at obj23 pos2) (in-city pos1 cit1))
(:goal (and (at obj23 apt2) (at obj22 apt1) (at obj13 apt2) (at obj12 pos2)
            (at obj11 pos2)))
)