//  File name   : UIBezierPath+Extensions.swift
//
//  Author      : Thien Chu
//  Created date: 7/6/18
//  Version     : 1.00
//  --------------------------------------------------------------
//  Copyright © 2018 Home. All rights reserved.
//  --------------------------------------------------------------

import UIKit

public extension UIBezierPath  {
    
    func drawHeart(with originalRect: CGRect, scale: Double) -> UIBezierPath {
        
        let scaledWidth = (originalRect.size.width * CGFloat(scale))
        let scaledXValue = ((originalRect.size.width) - scaledWidth) / 2
        let scaledHeight = (originalRect.size.height * CGFloat(scale))
        let scaledYValue = ((originalRect.size.height) - scaledHeight) / 2
        
        let scaledRect = CGRect(x: scaledXValue, y: scaledYValue, width: scaledWidth, height: scaledHeight)
        
        move(to: CGPoint(x: originalRect.size.width/2, y: scaledRect.origin.y + scaledRect.size.height))
        
        addCurve(to: CGPoint(x: scaledRect.origin.x, y: scaledRect.origin.y + (scaledRect.size.height/4)),
                      controlPoint1:CGPoint(x: scaledRect.origin.x + (scaledRect.size.width/2), y: scaledRect.origin.y + (scaledRect.size.height*3/4)) ,
                      controlPoint2: CGPoint(x: scaledRect.origin.x, y: scaledRect.origin.y + (scaledRect.size.height/2)) )
        
        addArc(withCenter: CGPoint( x: scaledRect.origin.x + (scaledRect.size.width/4),y: scaledRect.origin.y + (scaledRect.size.height/4)),
                    radius: (scaledRect.size.width/4),
                    startAngle: CGFloat(Double.pi),
                    endAngle: 0,
                    clockwise: true)
        
        addArc(withCenter: CGPoint( x: scaledRect.origin.x + (scaledRect.size.width * 3/4),y: scaledRect.origin.y + (scaledRect.size.height/4)),
                    radius: (scaledRect.size.width/4),
                    startAngle: CGFloat(Double.pi),
                    endAngle: 0,
                    clockwise: true)
        
        addCurve(to: CGPoint(x: originalRect.size.width/2, y: scaledRect.origin.y + scaledRect.size.height),
                      controlPoint1: CGPoint(x: scaledRect.origin.x + scaledRect.size.width, y: scaledRect.origin.y + (scaledRect.size.height/2)),
                      controlPoint2: CGPoint(x: scaledRect.origin.x + (scaledRect.size.width/2), y: scaledRect.origin.y + (scaledRect.size.height*3/4)) )
        
        close()
        
        return self
    }
    
    func drawCircle(with originalRect: CGRect, scale: Double) -> UIBezierPath {
        
        let scaledWidth = (originalRect.size.width * CGFloat(scale))
        let scaledHeight = (originalRect.size.height * CGFloat(scale))
        
        let radius = min(scaledWidth, scaledHeight) / 2
        
        addArc(withCenter: CGPoint(x: originalRect.size.width / 2, y: originalRect.size.height / 2), radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        
        return self
    }
    
    func drawPolygon(with originalRect: CGRect, scale: Double, paths cordinators: [Cordinator]) -> UIBezierPath {
        
        let scaledWidth = (originalRect.size.width * CGFloat(scale))
        let scaledHeight = (originalRect.size.height * CGFloat(scale))
        
        let paths = cordinators.map { (cordinator) -> CGPoint in
            return CGPoint(x: cordinator.x * scaledWidth, y: cordinator.y * scaledHeight)
        }
        
        if paths.count >= 3 {
            move(to: paths[0])
            
            for index in 1..<paths.count {
                addLine(to: paths[index])
            }
            
            close()
        }
        
        return self
    }
}
