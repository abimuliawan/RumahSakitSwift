//
//  UIButtonExtension.swift
//  TugasBesarRS
//
//  Created by Mac OS on 26/11/18.
//  Copyright © 2018 Tugas Besar Kelompok 1. All rights reserved.
//

import UIKit


extension UIButton{
    func shake(){
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.3
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x-5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x+5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: nil)
    }
    
    func pulse(){
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.3
        pulse.fromValue = 0.95
        pulse.toValue = 1
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
}
