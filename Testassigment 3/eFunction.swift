//
//  eFunction.swift
//  Testassigment 3
//
//  Created by IIT phys 440 on 2/10/23.
//

//Here is a simple function that I created to use in montecarlo integration. This helped flip y values as the original e^-x was inverted
import Foundation

   




//This is the function for 1 - e ^ (x)

func oneMinusEX(x: Double) -> Double {
    
        return (1 - exp(-x))
    
}


