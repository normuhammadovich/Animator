//
//  AnimationManager.swift
//  Animator_Starter
//
//  Created by Chingiz Jumanov on 23/11/22.
//

import UIKit

class AnimationManager {
    
    // Calculated screen bounds
    class var screenBounds: CGRect {
        return UIScreen.main.bounds
    }
    
    // Screen positions
    class var screenRight: CGPoint {
        return CGPoint(x: screenBounds.maxX, y: screenBounds.midY)
    }
    
    class var screenTop: CGPoint {
        return CGPoint(x: screenBounds.midX, y: screenBounds.minY)
    }
    
    class var screenLeft: CGPoint {
        return CGPoint(x: screenBounds.minX, y: screenBounds.midY)
    }
    
    class var screenBottom: CGPoint {
        return CGPoint(x: screenBounds.midX, y: screenBounds.maxY)
    }
    
    // Tracking variables
    var constraintOrigins = [CGFloat]()
    var currentConstraint: [NSLayoutConstraint]!
    
    
    init(activeConstrainst: [NSLayoutConstraint]) {
        
        for constraint in activeConstrainst {
            constraintOrigins.append(constraint.constant)
            constraint.constant -= AnimationManager.screenBounds.width
        }
        
        currentConstraint = activeConstrainst
        
    }
    
}
