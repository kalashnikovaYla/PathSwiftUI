//
//  ContentView.swift
//  PathSwiftUI
//
//  Created by sss on 01.05.2023.
//

import SwiftUI

struct DoneShape: Shape{
    
    var progress = 0.1
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRelativeArc(center: CGPoint(x: rect.midX, y: rect.maxY),
                            radius: rect.midX,
                            startAngle: .degrees(180),
                            delta: .degrees(180 * progress))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
    
}



struct ContentView: View {
    
    @State var progress = 0.0
    
    var body: some View {
        VStack {
            DoneShape(progress: 1)
                .trim(from: 0, to: progress)
                .stroke(.purple, lineWidth: 5)
                .frame(height: 196)
                .background(Color(uiColor: .systemGray5))
            Spacer()
            Slider(value: $progress)
                .padding()
             
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//Линия с отступами
struct MyDriver: View {
    let lineWidth: CGFloat
    var color = Color.red
    
    var body: some View {
        GeometryReader { proxy in
            Path { path in
                path.move(to: CGPoint(x: 20, y: 50))
                path.addLine(to: CGPoint(x: proxy.size.width - 20, y: 50))
            }
            .strokedPath(StrokeStyle(lineWidth: lineWidth, lineCap: .round))
            .foregroundColor(color)
        }
    }
}


//Треугольник
struct TriangleView: View {
     
    var body: some View {
        GeometryReader { proxy in
            let midX = proxy.frame(in: .local).midX
            let width: CGFloat = 200
            
            Path { path in
                
                path.move(to: CGPoint(x: midX, y: 10))
                path.addLine(to: CGPoint(x: midX + (width/2), y: 170))
                path.addLine(to: CGPoint(x: midX - (width/2), y: 170))
                path.closeSubpath()
            }
            //.strokedPath(StrokeStyle(lineWidth: 5)) - будет заливка красным если убрать
            //.foregroundColor(.red)
            .fill(.pink)
        }
    }
}


//Прямоугольник
struct RectangleView: View {
     
    var body: some View {
        GeometryReader { proxy in
           
            Path { path in
                path.addRect(CGRect(x: 10, y: 100, width: proxy.size.width - 20, height: 100))
            }
             
            .fill(.pink)
        }
    }
}


struct CurvedShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let startPoint = CGPoint(x: rect.width * 0.65, y: 0)
        
        path.move(to: startPoint)
        
        path.addCurve(to: CGPoint(x: rect.width, y: rect.height / 2),
                      control1: CGPoint(x: rect.width * 0.85, y: 0),
                      control2: CGPoint(x: rect.width, y: rect.height * 0.1))
        
        path.addCurve(to: CGPoint(x: rect.width/2, y: rect.height),
                      control1: CGPoint(x: rect.width, y: rect.height * 0.9),
                      control2: CGPoint(x: rect.width * 0.75, y: rect.height))
        
        path.addCurve(to: CGPoint(x: 0, y: rect.height * 0.7),
                      control1: CGPoint(x: rect.width * 0.35, y: rect.height),
                      control2: CGPoint(x: 0, y: rect.height))
        
        path.addCurve(to: CGPoint(x: rect.width * 0.3, y: rect.height * 0.3),
                      control1: CGPoint(x: 0, y: rect.height * 0.4),
                      control2: CGPoint(x: rect.width * 0.17, y: rect.height * 0.45))
        
        path.addCurve(to: startPoint,
                      control1: CGPoint(x: rect.width * 0.42, y: rect.height * 0.16),
                      control2: CGPoint(x: rect.width * 0.46 , y: 0))
        return path
    }
    
}


struct RoundedBottomRectangle: Shape{
    
    var curveOffset: CGFloat = 10
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.maxX, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addQuadCurve(to: CGPoint(x: 0, y: rect.maxY), control: CGPoint(x: rect.midX, y: rect.maxY + curveOffset))
        path.addLine(to: CGPoint(x: 0, y: 0))
        return path
    }
    
}
