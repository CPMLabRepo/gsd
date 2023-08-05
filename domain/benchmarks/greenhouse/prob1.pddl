(define (problem greenhouse)
    (:domain greenhouse)
    (:objects 
        left-arm,
        right-arm,
        hose,
        water-pail,
        square0-0, square0-1, square0-2, square0-3, square0-4, 
        square1-0, square1-1, square1-2, square1-3, square1-4, 
        square2-0, square2-1, square2-2, square2-3, square2-4, 
        square3-0, square3-1, square3-2, square3-3, square3-4,
        square4-0, square4-1, square4-2, square4-3, square4-4) 
    

    (:INIT 
        (human-square-place square0-0) (human-square-place square0-1) (human-square-place square0-2) (human-square-place square0-3) (human-square-place square0-4) 
        (human-square-place square1-0) (human-square-place square1-1) (human-square-place square1-2) (human-square-place square1-3) (human-square-place square1-4) 
        (human-square-place square2-0) (human-square-place square2-1) (human-square-place square2-2) (human-square-place square2-3) (human-square-place square2-4) 
        (human-square-place square3-0) (human-square-place square3-1) (human-square-place square3-2) (human-square-place square3-3) (human-square-place square3-4)
        (human-square-place square4-0) (human-square-place square4-1) (human-square-place square4-2) (human-square-place square4-3) (human-square-place square4-4)

        (human-square-conn square0-0 square1-0) (human-square-conn square0-0 square0-1) (human-square-conn square0-1 square1-1) 
        (human-square-conn square0-1 square0-2) (human-square-conn square0-1 square0-0) (human-square-conn square0-2 square1-2)
        (human-square-conn square0-2 square0-3) (human-square-conn square0-2 square0-1) (human-square-conn square0-3 square1-3)
        (human-square-conn square0-3 square0-4) (human-square-conn square0-3 square0-2) (human-square-conn square0-4 square1-4)
        (human-square-conn square0-4 square0-3) (human-square-conn square1-0 square2-0) (human-square-conn square1-0 square0-0)
        (human-square-conn square1-0 square1-1) (human-square-conn square1-1 square2-1) (human-square-conn square1-1 square0-1)
        (human-square-conn square1-1 square1-2) (human-square-conn square1-1 square1-0) (human-square-conn square1-2 square2-2)
        (human-square-conn square1-2 square0-2) (human-square-conn square1-2 square1-3) (human-square-conn square1-2 square1-1)
        (human-square-conn square1-3 square2-3) (human-square-conn square1-3 square0-3) (human-square-conn square1-3 square1-4)
        (human-square-conn square1-3 square1-2) (human-square-conn square1-4 square2-4) (human-square-conn square1-4 square0-4)
        (human-square-conn square1-4 square1-3) (human-square-conn square2-0 square3-0) (human-square-conn square2-0 square1-0)
        (human-square-conn square2-0 square2-1) (human-square-conn square2-1 square3-1) (human-square-conn square2-1 square1-1)
        (human-square-conn square2-1 square2-2) (human-square-conn square2-1 square2-0) (human-square-conn square2-2 square3-2)
        (human-square-conn square2-2 square1-2) (human-square-conn square2-2 square2-3) (human-square-conn square2-2 square2-1)
        (human-square-conn square2-3 square3-3) (human-square-conn square2-3 square1-3) (human-square-conn square2-3 square2-4)
        (human-square-conn square2-3 square2-2) (human-square-conn square2-4 square3-4) (human-square-conn square2-4 square1-4)
        (human-square-conn square2-4 square2-3) (human-square-conn square3-0 square4-0) (human-square-conn square3-0 square2-0)
        (human-square-conn square3-0 square3-1) (human-square-conn square3-1 square4-1) (human-square-conn square3-1 square2-1)
        (human-square-conn square3-1 square3-2) (human-square-conn square3-1 square3-0) (human-square-conn square3-2 square4-2)
        (human-square-conn square3-2 square2-2) (human-square-conn square3-2 square3-3) (human-square-conn square3-2 square3-1)
        (human-square-conn square3-3 square4-3) (human-square-conn square3-3 square2-3) (human-square-conn square3-3 square3-4)
        (human-square-conn square3-3 square3-2) (human-square-conn square3-4 square4-4) (human-square-conn square3-4 square2-4)
        (human-square-conn square3-4 square3-3) (human-square-conn square4-0 square3-0) (human-square-conn square4-0 square4-1)
        (human-square-conn square4-1 square3-1) (human-square-conn square4-1 square4-2) (human-square-conn square4-1 square4-0)
        (human-square-conn square4-2 square3-2) (human-square-conn square4-2 square4-3) (human-square-conn square4-2 square4-1)
        (human-square-conn square4-3 square3-3) (human-square-conn square4-3 square4-4) (human-square-conn square4-3 square4-2)
        (human-square-conn square4-4 square3-4) (human-square-conn square4-4 square4-3)
        
        (human-plant-watered square1-2) (human-plant-watered square2-2)
        (human-plant-watered square3-2) (human-plant-watered square1-1)
        (human-plant-watered square3-1)
        
        (human-location hose square2-1) (human-location water-pail square0-4)
        (human-location square0-0)
        (human-handempty left-arm) (human-handempty right-arm)
        
        (human-can-act human) 
        
        
        (robot-square-place square0-0) (robot-square-place square0-1) (robot-square-place square0-2) (robot-square-place square0-3) (robot-square-place square0-4) 
        (robot-square-place square1-0) (robot-square-place square1-1) (robot-square-place square1-2) (robot-square-place square1-3) (robot-square-place square1-4) 
        (robot-square-place square2-0) (robot-square-place square2-1) (robot-square-place square2-2) (robot-square-place square2-3) (robot-square-place square2-4) 
        (robot-square-place square3-0) (robot-square-place square3-1) (robot-square-place square3-2) (robot-square-place square3-3) (robot-square-place square3-4)
        (robot-square-place square4-0) (robot-square-place square4-1) (robot-square-place square4-2) (robot-square-place square4-3) (robot-square-place square4-4)

        (robot-square-conn square0-0 square1-0) (robot-square-conn square0-0 square0-1) (robot-square-conn square0-1 square1-1) 
        (robot-square-conn square0-1 square0-2) (robot-square-conn square0-1 square0-0) (robot-square-conn square0-2 square1-2)
        (robot-square-conn square0-2 square0-3) (robot-square-conn square0-2 square0-1) (robot-square-conn square0-3 square1-3)
        (robot-square-conn square0-3 square0-4) (robot-square-conn square0-3 square0-2) (robot-square-conn square0-4 square1-4)
        (robot-square-conn square0-4 square0-3) (robot-square-conn square1-0 square2-0) (robot-square-conn square1-0 square0-0)
        (robot-square-conn square1-0 square1-1) (robot-square-conn square1-1 square2-1) (robot-square-conn square1-1 square0-1)
        (robot-square-conn square1-1 square1-2) (robot-square-conn square1-1 square1-0) (robot-square-conn square1-2 square2-2)
        (robot-square-conn square1-2 square0-2) (robot-square-conn square1-2 square1-3) (robot-square-conn square1-2 square1-1)
        (robot-square-conn square1-3 square2-3) (robot-square-conn square1-3 square0-3) (robot-square-conn square1-3 square1-4)
        (robot-square-conn square1-3 square1-2) (robot-square-conn square1-4 square2-4) (robot-square-conn square1-4 square0-4)
        (robot-square-conn square1-4 square1-3) (robot-square-conn square2-0 square3-0) (robot-square-conn square2-0 square1-0)
        (robot-square-conn square2-0 square2-1) (robot-square-conn square2-1 square3-1) (robot-square-conn square2-1 square1-1)
        (robot-square-conn square2-1 square2-2) (robot-square-conn square2-1 square2-0) (robot-square-conn square2-2 square3-2)
        (robot-square-conn square2-2 square1-2) (robot-square-conn square2-2 square2-3) (robot-square-conn square2-2 square2-1)
        (robot-square-conn square2-3 square3-3) (robot-square-conn square2-3 square1-3) (robot-square-conn square2-3 square2-4)
        (robot-square-conn square2-3 square2-2) (robot-square-conn square2-4 square3-4) (robot-square-conn square2-4 square1-4)
        (robot-square-conn square2-4 square2-3) (robot-square-conn square3-0 square4-0) (robot-square-conn square3-0 square2-0)
        (robot-square-conn square3-0 square3-1) (robot-square-conn square3-1 square4-1) (robot-square-conn square3-1 square2-1)
        (robot-square-conn square3-1 square3-2) (robot-square-conn square3-1 square3-0) (robot-square-conn square3-2 square4-2)
        (robot-square-conn square3-2 square2-2) (robot-square-conn square3-2 square3-3) (robot-square-conn square3-2 square3-1)
        (robot-square-conn square3-3 square4-3) (robot-square-conn square3-3 square2-3) (robot-square-conn square3-3 square3-4)
        (robot-square-conn square3-3 square3-2) (robot-square-conn square3-4 square4-4) (robot-square-conn square3-4 square2-4)
        (robot-square-conn square3-4 square3-3) (robot-square-conn square4-0 square3-0) (robot-square-conn square4-0 square4-1)
        (robot-square-conn square4-1 square3-1) (robot-square-conn square4-1 square4-2) (robot-square-conn square4-1 square4-0)
        (robot-square-conn square4-2 square3-2) (robot-square-conn square4-2 square4-3) (robot-square-conn square4-2 square4-1)
        (robot-square-conn square4-3 square3-3) (robot-square-conn square4-3 square4-4) (robot-square-conn square4-3 square4-2)
        (robot-square-conn square4-4 square3-4) (robot-square-conn square4-4 square4-3)
        
        (robot-plant-watered square1-2) (robot-plant-watered square2-2)
        (robot-plant-watered square3-2) (robot-plant-watered square1-1)
        (robot-plant-watered square3-1)
        
        (robot-location hose square2-1) (robot-location water-pail square0-4)
        (robot-location square0-0)
        (robot-handempty left-arm) (robot-handempty right-arm)

        (= (total-cost) 0)
        
    )

    (:goal (and 
        (fluents-check) 
        ) ) 
    (:metric minimize (total-cost)) 
)





