//
//  Toast.swift
//  Sakura
//
//  Created by YaeSakura on 2016/12/21.
//  Copyright © 2016 Sakura. All rights reserved.
//

import Foundation

public class Toast
{
    
    private var duration: TimeInterval = 2.5
    private var delay: TimeInterval = 0
    
    private var gravity: TimeInterval = 2.5
    
    // MARK: Singleton
    
    private static let instance: Toast = {
        let instance = Toast()
        return instance
    }()
    
    //MARK: Methods
    
    public static func makeText(text: String, duration: Double = 2.5) -> Toast {
        return instance
    }
    
    
    public func show() {
        
    }
    
    public func setGravity(_ loaction: Int, _ offsetX: Float, _ offsetY: Float) -> Toast {
        return .instance
    }
    
}
