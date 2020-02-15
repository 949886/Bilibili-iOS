//
//  UILoadingController.swift
//  Sakura
//
//  Created by YaeSakura on 2017/9/19.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

class UILoadingController: UIViewController
{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    enum State {
        case initial
        case loading
        case success
        case failed
    }
}
