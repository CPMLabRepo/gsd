(define (problem logistics-4-1)
(:domain logistics)
(:objects
  apn1 - airplane
  apt2 apt1 - airport
  pos2 pos1 - location
  cit2 cit1 - city
  tru2 tru1 - truck
  obj23 obj22 obj21 obj13 obj12 obj11 - package)

(:init (at tru1 pos1) 
 (at obj12 pos1)(at tru2 pos2) (at obj22 pos2)
 (in-city pos1 cit1) (in-city apt1 cit1) (in-city pos2 cit2)
 (in-city apt2 cit2))

(:goal (and (at obj12 apt2) (at obj13 apt1) (at obj21 apt2) (at obj11 pos2)))
)