//
//  NSObjectExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/4/24.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation
import ObjectiveC

//MARK: - Associated Objects

extension NSObject
{
    //MARK: Get & Set
    
    public func getAssociatedObject(key: String) -> Any? {
        return _associatedObjects[key] ?? nil
    }
    
    public func setAssociatedObject(key: String, value: Any?) {
        _associatedObjects[key] = value
    }
    
    //MARK: Private
    
    private struct AssociatedKey {
        static var associatedObjects: Void?
    }
    
    private var _associatedObjects: [String:Any?] {
        get { return _getAssociatedObjects() }
        set { _setAssociatedObjects(newValue) }
    }
    
    private func _getAssociatedObjects() -> [String:Any?] {
        return objc_getAssociatedObject(self, &AssociatedKey.associatedObjects) as? [String:Any?] ?? [:]
    }
    
    private func _setAssociatedObjects(_ objects: [String:Any?]) {
        objc_setAssociatedObject(self, &AssociatedKey.associatedObjects, objects, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
}

extension NSObjectProtocol
{
    //MARK: Get & Set
    
    public func getAssociatedObject(key: String) -> Any? {
        return _associatedObjects[key] ?? nil
    }
    
    public func setAssociatedObject(key: String, value: Any?) {
        _associatedObjects[key] = value
    }
    
    //MARK: Private
    
    private var _associatedObjects: [String:Any?] {
        get { return _getAssociatedObjects() }
        set { _setAssociatedObjects(newValue) }
    }
    
    private func _getAssociatedObjects() -> [String:Any?] {
        return objc_getAssociatedObject(self, &NSObjectProtocolAssociatedObjects) as? [String:Any?] ?? [:]
    }
    
    private func _setAssociatedObjects(_ objects: [String:Any?]) {
        objc_setAssociatedObject(self, &NSObjectProtocolAssociatedObjects, objects, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}

private var NSObjectProtocolAssociatedObjects: Void?


//MARK: - Runtime

extension NSObject
{
    //Mark: Swizzle
    
    /// Exchange IMP of original method & swizzled method.
    ///
    /// - Parameters:
    ///   - originalSelector: Selector of original method.
    ///   - swizzledSelector: Selector of swizzled method.
    public static func swizzle(_ originalSelector: Selector, _ swizzledSelector: Selector) {
        DispatchQueue.once(token: "\(self.self)\(originalSelector)\(swizzledSelector)", execute: {
            let clazz = self.self
            
            if  let originalMethod = class_getInstanceMethod(clazz, originalSelector),
                let swizzledMethod = class_getInstanceMethod(clazz, swizzledSelector) {
                if class_addMethod(clazz, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod)) {
                    class_replaceMethod(clazz, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
                } else { method_exchangeImplementations(originalMethod, swizzledMethod) }
            }
        })
    }
    
    
    //MARK: Misc
    
    /// Print all ivars of a nsobject.
    public static func printIvars() {
        
        var outCount: UInt32 = 0
        let ivars = class_copyIvarList(self.self, &outCount);
        for i in 0...Int(outCount) {
            if  let ivar = ivars?.advanced(by: i).pointee,
                let ivarName = ivar_getName(ivar),
                let ivarType = ivar_getTypeEncoding(ivar) {
                print("Name: \(String(cString: ivarName)), " +
                    "Type: \(String(cString: ivarType))")
            }
        }
        free(ivars)
        
        if let superclass = self.superclass() as? NSObject.Type {
            superclass.printIvars()
        }
    }
}
