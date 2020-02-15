//
//  UICascaderController.swift
//  Sakura
//
//  Created by YaeSakura on 2017/10/13.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

class UICascaderController: UITabBarController
{
    public lazy var sideBar: SideBar = {
        let bar = SideBar(frame: CGRect(x: 0, y: 0, width: 64, height: UIScreen.main.bounds.height))
        self.setValue(bar, forKey: "tabBar")
        return bar
    }()
    
    //    @IBInspectable var viewControllers: [UIViewController] = []
    
    //MARK: Override
    
    override func loadView() {
        super.loadView()
        self.setValue(sideBar, forKey: "tabBar")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.tabBar.frame = CGRect(x: 0, y: 0, width: 64, height: UIScreen.main.bounds.height)
    }
    
    
    class SideBar: UITabBar
    {
        override func layoutSubviews() {
            
        }
    }
}
