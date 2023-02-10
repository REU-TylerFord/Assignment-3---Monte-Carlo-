//
//  ContentView.swift
//  Testassigment 3
//
//  Created by IIT phys 440 on 2/9/23.
//


import SwiftUI

struct ContentView: View {
    
    
    @State var horizontalBound = 1.0
    @State var verticalBound = 1.0
    @State var EXPS = "0.0"
    @State var totalGuesses = 0.0
    @State var totalIntegral = 0.0
    @State var guessString = "100"
    @State var totalGuessString = "0"
   
    
    
    // Setup the GUI to monitor the data from the Monte Carlo Integral Calculator
    @ObservedObject var monteCarlo = MonteCarloTest(withData: true)
    
    //Setup the GUI View
    var body: some View {
        HStack{
            
            VStack{
                
                VStack(alignment: .center) {
                    Text("Guesses")
                        .font(.callout)
                        .bold()
                    TextField("# Guesses", text: $guessString)
                        .padding()
                }
                .padding(.top, 5.0)
                
                VStack(alignment: .center) {
                    Text("Total Guesses")
                        .font(.callout)
                        .bold()
                    TextField("# Total Guesses", text: $totalGuessString)
                        .padding()
                }
                
                VStack(alignment: .center) {
                    Text("e^(-x)")
                        .font(.callout)
                        .bold()
                    TextField("# e^(-x)", text: $EXPS)
                        .padding()
                }
                
                VStack(alignment: .center) {
                    Text("This problem will utilize a special integration method that takes")
                    Text("the value of randomly generated points between some boundary")
                    Text("and calcualtes the ratio of points in and out of desired area.")
                    Text("The 1st value is number of current guesses")
                    Text("The 2nd value is total number of current guesses")
                    Text("The 3rd value is integrated value of e^(-x)")
                        
                        
                }
                
                Button("PRESS ME", action: {Task.init{await self.calculateTest()}})
                    .padding()
                    .disabled(monteCarlo.enableButton == false)
                
                Button("Clear Everything", action: {self.clear()})
                    .padding(.bottom, 5.0)
                    .disabled(monteCarlo.enableButton == false)
                
                if (!monteCarlo.enableButton){
                    
                    ProgressView()
                }
                
                
            }
            .padding()
            
            //DrawingField
            
            
            drawingView(blackLayer:$monteCarlo.insideData, purpleLayer: $monteCarlo.outsideData)
                .padding()
                .aspectRatio(1, contentMode: .fit)
                .drawingGroup()
            // Stop the window shrinking to zero.
            Spacer()
            
        }
    }
    
    func calculateTest() async {
        
        
        monteCarlo.setButtonEnable(state: false)
        
        monteCarlo.guesses = Int(guessString)!
        monteCarlo.horizontalBound = horizontalBound
        monteCarlo.verticalBound = verticalBound
        monteCarlo.totalGuesses = Int(totalGuessString) ?? Int(0.0)
        await monteCarlo.calculateTest()
        totalGuessString = monteCarlo.totalGuessesString
        monteCarlo.setButtonEnable(state: true)
        EXPS =  monteCarlo.EXPS
    }
    
    func clear(){
        
        guessString = "0"
        totalGuessString = "0.0"
        monteCarlo.totalGuesses = 0
        monteCarlo.totalIntegral = 0.0
        monteCarlo.insideData = []
        monteCarlo.outsideData = []
        monteCarlo.firstTimeThroughLoop = true
        EXPS =  ""
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
 


struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
