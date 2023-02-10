//
//  MonteCarlo.swift
//  Testassigment 3
//
//  Created by IIT phys 440 on 2/10/23.
//

// This file is where we calcualte the montecarlo integration
// An importnat note, was this code was orginally modifed for calculating a circle. I modifed this code to work for our assignment function, e^(-x)



import Foundation
import SwiftUI


class MonteCarloTest: NSObject, ObservableObject {
    
    @MainActor @Published var insideData = [(xPoint: Double, yPoint: Double)]()
    @MainActor @Published var outsideData = [(xPoint: Double, yPoint: Double)]()
    @Published var totalGuessesString = ""
    @Published var guessesString = ""
    @Published var EXPS = ""
    @Published var enableButton = true
    
    //This test variable is just a substitute will be changed lagter
    // I kept on changin this value and the variable name due to many errors
    var Test = 0.0
    var guesses = 1
    var totalGuesses = 0
    var totalIntegral = 0.0
    var horizontalBound = 5.0
    var verticalBound = 10000.0
    var firstTimeThroughLoop = true
    
    @MainActor init(withData data: Bool){
        
        super.init()
        
        insideData = []
        outsideData = []
        
    }


   // calculate the value of e^(-x) with bounding box
    func calculateTest() async {
        
        var maxGuesses = 0.0
        let boundingBoxCalculator = BoundingBox()
        
        
        maxGuesses = Double(guesses)
        
        let newValue = await calculateMonteCarloIntegral(horizontalBound: horizontalBound, verticalBound: verticalBound, maxGuesses: maxGuesses)
        
        totalIntegral = totalIntegral + newValue
        
        totalGuesses = totalGuesses + guesses
        
        await updateTotalGuessesString(text: "\(totalGuesses)")
        
        //totalGuessesString = "\(totalGuesses)"
        
        ///Calculates the value of e^(-x) from the bounds provided
        
        
        //Here we only want a 2 dimentsional figure, thus the 3rd length of sidelength3 will be zero.
        Test = 1 - ((totalIntegral/Double(totalGuesses)) * boundingBoxCalculator.calculateSurfaceArea(numberOfSides: 2, lengthOfSide1: 1.0, lengthOfSide2: 1.0, lengthOfSide3: 0.0))
        
        
        //we must update the strings to provide the correct quantities
        await updateEXPS(text: "\(Test)")
        
       
        
       
        
    }

    /// calculates the Monte Carlo Integral of e^(-x)
    ///
    /// - Parameters:
    ///   - side lengths of bounding box
    ///   - maxGuesses: number of guesses to use in the calculaton
    /// - Returns: ratio of points inside to total guesses. Must mulitply by area of box in calling function
    func calculateMonteCarloIntegral(horizontalBound: Double, verticalBound: Double, maxGuesses: Double) async -> Double {
        
        var numberOfGuesses = 0.0
        var pointsInBound = 0.0
        var integral = 0.0
        var point = (xPoint: 0.0, yPoint: 0.0)
        let horizontalBound = 1.0
        let verticalBound = 1.0
        
        var newInsidePoints : [(xPoint: Double, yPoint: Double)] = []
        var newOutsidePoints : [(xPoint: Double, yPoint: Double)] = []
        
        
        while numberOfGuesses < maxGuesses {
            
            /* Calculate 2 random values within the box */
            /* Determine the distance from that point to the origin */
            /* If the distance is less than the unit radius count the point being within the Unit Circle */
            point.xPoint = Double.random(in: 0.0...horizontalBound)
            point.yPoint = Double.random(in: 0.0...verticalBound)
            
//            ExPoint = sqrt(pow(point.xPoint) + pow(point.yPoint,2.0))
            // if inside the circle add to the number of points in the radius
            if((point.yPoint <= oneMinusEX(x: point.xPoint))){
                pointsInBound += 1.0
                
                
                newInsidePoints.append(point)
               
            }
            else { //if outside the circle do not add to the number of points in the radius
                
                
                newOutsidePoints.append(point)

                
            }
            
            numberOfGuesses += 1.0
            
            
            
            
            }

        
        integral = Double(pointsInBound)
        
        //Append the points to the arrays needed for the displays
        //Don't attempt to draw more than 250,000 points to keep the display updating speed reasonable.
        
        if ((totalGuesses < 500001) || (firstTimeThroughLoop)){
        
//            insideData.append(contentsOf: newInsidePoints)
//            outsideData.append(contentsOf: newOutsidePoints)
            
            var plotInsidePoints = newInsidePoints
            var plotOutsidePoints = newOutsidePoints
            
            if (newInsidePoints.count > 750001) {
                
                plotInsidePoints.removeSubrange(750001..<newInsidePoints.count)
            }
            
            if (newOutsidePoints.count > 750001){
                plotOutsidePoints.removeSubrange(750001..<newOutsidePoints.count)
                
            }
            
            await updateData(insidePoints: plotInsidePoints, outsidePoints: plotOutsidePoints)
            firstTimeThroughLoop = false
        }
        
        return integral
        }
    
    
    /// updateData
    /// The function runs on the main thread so it can update the GUI
    /// - Parameters:
    ///   - insidePoints: points inside the circle of the given radius
    ///   - outsidePoints: points outside the circle of the given radius
    @MainActor func updateData(insidePoints: [(xPoint: Double, yPoint: Double)] , outsidePoints: [(xPoint: Double, yPoint: Double)]){
        
        insideData.append(contentsOf: insidePoints)
        outsideData.append(contentsOf: outsidePoints)
    }
    
    /// updateTotalGuessesString
    /// The function runs on the main thread so it can update the GUI
    /// - Parameter text: contains the string containing the number of total guesses
    @MainActor func updateTotalGuessesString(text:String){
        
        self.totalGuessesString = text
        
    }
    
    /// updatePiString
    /// The function runs on the main thread so it can update the GUI
    /// - Parameter text: contains the string containing the current value of Pi
    @MainActor func updateEXPS(text:String){
        
        self.EXPS = text
        
    }
    
    
    /// setButton Enable
    /// Toggles the state of the Enable Button on the Main Thread
    /// - Parameter state: Boolean describing whether the button should be enabled.
    @MainActor func setButtonEnable(state: Bool){
        
        
        if state {
            
            Task.init {
                await MainActor.run {
                    
                    
                    self.enableButton = true
                }
            }
            
            
                
        }
        else{
            
            Task.init {
                await MainActor.run {
                    
                    
                    self.enableButton = false
                }
            }
                
        }
        
    }

}


