//
//  Drawing.swift
//  Testassigment 3
//
//  Created by IIT phys 440 on 2/10/23.
//



import SwiftUI

struct drawingView: View {
    
    @Binding var blackLayer : [(xPoint: Double, yPoint: Double)]
    @Binding var purpleLayer : [(xPoint: Double, yPoint: Double)]
    
    var body: some View {
    
        
        ZStack{
        
            drawIntegral(drawingPoints: blackLayer )
                .stroke(Color.purple)
            
            drawIntegral(drawingPoints: purpleLayer )
                .stroke(Color.black)
        }
        .background(Color.white)
        .aspectRatio(1, contentMode: .fill)
        
    }
}

struct DrawingView_Previews: PreviewProvider {
    
    @State static var blackLayer : [(xPoint: Double, yPoint: Double)] = [(0.0, 0.0), (0.0, 0.0), (0.0, 0.0), (0.0, 0.0)]
    @State static var purpleLayer : [(xPoint: Double, yPoint: Double)] = [(0.0, 0.0), (0.0, 0.0), (0.0, 0.0), (0.0, 0.0)]
    
    static var previews: some View {
       
        
        drawingView(blackLayer: $blackLayer, purpleLayer: $purpleLayer)
            .aspectRatio(1, contentMode: .fill)
            //.drawingGroup()
           
    }
}



struct drawIntegral: Shape {
    
   
    let smoothness : CGFloat = 1.0
    var drawingPoints: [(xPoint: Double, yPoint: Double)]  ///Array of tuples
    
    func path(in rect: CGRect) -> Path {
        
               
        // draw from the center of our rectangle
        let center = CGPoint(x: rect.width / 8, y: rect.height / 8)
        let scale = rect.width / 2
        

        // Create the Path for the display
        
        var path = Path()
        
        for item in drawingPoints {
            
            path.addRect(CGRect(x: item.xPoint*Double(scale)+Double(center.x), y: item.yPoint*Double(scale)+Double(center.y), width: 1.0 , height: 1.0))
            
        }


        return (path)
    }
}

