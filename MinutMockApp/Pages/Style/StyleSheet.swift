//
//  StyleSheet.swift
//  MinutMockApp
//
//  Created by Alexander Lins on 2024-04-16.
//

import SwiftUI

// MARK: VIEW ELEMENTS
extension View {
    func personalBackground() -> some View {
        self
            .background(LinearGradient(gradient: Gradient(colors: [.black, Color(red: 0.14117647058, green: 0.16470588235294117, blue: 0.21568627450980393)]), startPoint: .center, endPoint: .bottom))
    }
    
    func hexagonColor() -> some View {
        self
            .frame(height: 75)
            .foregroundStyle(LinearGradient(colors: [Color(red: 1, green: 0.7, blue: 0.6), .orange , .red], startPoint: .top, endPoint: .bottom))
            .shadow(color: .orange, radius: 5)
    }
}

// MARK: FONT ELEMENTS
extension Text {
    func personalTitle() -> some View {
        self
            .foregroundColor(.white)
            .opacity(0.85)
            .multilineTextAlignment(.leading)
            .font(Font.custom("Avenir", size: 50))
            .bold()
    }
    
    func personalSubtitle() -> some View {
        self
            .foregroundColor(.white)
            .opacity(0.85)
            .multilineTextAlignment(.leading)
            .font(Font.custom("Avenir", size: 20))
            .bold()
    }
    
    func personalBody() -> some View {
        self
            .foregroundColor(.white)
            .opacity(0.8)
            .multilineTextAlignment(.leading)
            .font(Font.custom("Avenir", size: 20))
    }
    
    func personalCaption() -> some View {
        self
            .foregroundColor(.white)
            .opacity(0.8)
            .multilineTextAlignment(.leading)
            .font(Font.custom("Avenir", size: 12))
            
    }
    
    func personalTag() -> some View {
        self
            .foregroundColor(.white)
            .opacity(0.8)
            .multilineTextAlignment(.leading)
            .font(Font.custom("Avenir", size: 14))
            .bold()
    }
    
    func personalDescription() -> some View {
        self
            .foregroundColor(.white)
            .opacity(0.8)
            .multilineTextAlignment(.leading)
            .font(Font.custom("Avenir", size: 16))
    }
    
    func nextPage() -> some View {
        self
            .foregroundStyle(.white)
            .font(Font.custom("Avenir", size: 15))
            .bold()
    }
}

// MARK: HEXAGON

struct Hexagon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Calculate the center of the rect and the radius based on the rect dimensions
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        
        // Calculate the points of the hexagon
        let angleOffset = CGFloat(Double.pi / 6)
        let points = (0..<6).map { i -> CGPoint in
            let angle = angleOffset + (CGFloat(i) * CGFloat(Double.pi / 3))
            let pointX = center.x + radius * cos(angle)
            let pointY = center.y + radius * sin(angle)
            return CGPoint(x: pointX, y: pointY)
        }
        
        // Move to the first point to start the hexagon
        path.move(to: points[0])
        
        // Connect each point with lines
        for point in points.dropFirst() {
            path.addLine(to: point)
        }
        
        // Close the hexagon path
        path.closeSubpath()
        
        return path
    }
}

extension Image {
    func gameThumbnail() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .background(LinearGradient(gradient: Gradient(colors: [.clear, Color(red: 0.14117647058, green: 0.16470588235294117, blue: 0.21568627450980393)]), startPoint: .center, endPoint: .bottom))
    }
    
    func gamePlatform() -> some View {
        self
            .resizable()
            .frame(width: 14, height: 14)
            .foregroundStyle(.white)
    }
}
