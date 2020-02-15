//
//  NotificationExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/5/19.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

extension NotificationCenter
{
    public func postOnMainThread(_ notification: Notification) {
        DispatchQueue.main.async {
            self.post(notification)
        }
    }
    
    public func postOnMainThread(name aName: NSNotification.Name, object anObject: Any?) {
        DispatchQueue.main.async {
            self.post(name: aName, object: anObject)
        }
    }
    
    public func postOnMainThread(name aName: NSNotification.Name, object anObject: Any?, userInfo aUserInfo: [AnyHashable : Any]? = nil) {
        DispatchQueue.main.async {
            self.post(name: aName, object: anObject, userInfo: aUserInfo)
        }
    }
}
