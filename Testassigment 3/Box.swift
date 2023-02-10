//
//  Box.swift
//  Testassigment 3
//
//  Created by IIT phys 440 on 2/10/23.
//

// Tyler Ford - Phys 440
// This code is to calculate the surface area of a bounding box and the volume
// It tkaes in 3 parameters, the legnth of side one, the legnth of side two, and the length of side three
// This code was reused from Prof. Terry github
// Thank you for providing us with this!!!!

import Foundation
import SwiftUI

class BoundingBox: NSObject {
    
    
   //Here is a function that calculates the volume
    func calculateVolume(lengthOfSide1: Double, lengthOfSide2: Double, lengthOfSide3: Double) -> Double {
        
        //returns all sidelengths
        return (lengthOfSide1*lengthOfSide2*lengthOfSide3)
        
    }
    
   //here is a function that calcualtes the surface area
    func calculateSurfaceArea(numberOfSides: Int, lengthOfSide1: Double, lengthOfSide2: Double, lengthOfSide3: Double) -> Double {
        
        var surfaceArea = 0.0
        
        
        if numberOfSides == 2 {
            
            surfaceArea = lengthOfSide1*lengthOfSide2
            
        } else if numberOfSides == 6 {
            
            surfaceArea = 2*lengthOfSide1*lengthOfSide2 + 2*lengthOfSide2*lengthOfSide3 + 2*lengthOfSide1*lengthOfSide3
            
            
        } else {
            
            surfaceArea = 0.0
            
        }
        //returns a single value that is the surface area
        return (surfaceArea)
    }

}






































































