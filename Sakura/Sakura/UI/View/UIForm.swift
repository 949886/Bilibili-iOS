//
//  UIForm.swift
//  Sakura
//
//  Created by YaeSakura on 2017/1/17.
//  Copyright © 2017 YaeSakura. All rights reserved.
//

import Foundation

//MARK: - UIForm

open class UIForm: UIView
{
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    public let sections = [Section]()
    
    //MARK: Initialization
    
    public init() {
        super.init(frame: .zero)
        self.initialize()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    private func initialize() {
        self.onCreate(form: self)
    }
    
    open func onCreate(form: UIForm) {
        
    }
    
    open class Section
    {
        public var form: UIForm!
        
        private var rows = [Row]()
        public var header: Header? = nil
        public var footer: Footer? = nil
        
        public init() {
            
        }
        
        public func append(_ row: Row) {
            self.rows.append(row)
        }
        
        public func insert(_ row: Row, at index: Int) {
            
        }
    }
    
    open class Row
    {
        public var form: UIForm!
        
        public init() {
            
        }
        
        public init(type: Types) {
            
        }
        
        public static func `default`(text: String) -> Row {
            return Row()
        }
        
        public static func `default`(text: String, initializer: ((Row) -> Void)?) -> Row {
            return Row()
        }
        
        public static func custom(text: String) -> Row {
            return Row()
        }
        
        public func register(class: AnyClass, id: String) -> Row {
            return self
        }
        
        public func register(nib: String, id: String) -> Row {
            return self
        }
        
        public func count(_ num: UInt) -> UIForm {
            return form
        }
        
        public enum Types {
            case `default`(text: String, subtitle: String?, view: UIView?)
            case `switch`
            case text
            case table(cell: UITableViewCell, delegate: Any?)
            case grid(cell: UICollectionViewCell, delegate: Any?)
            case custom(cell: Cell, id: String)
        }
    }
    
    open class Cell: UIView {
        
    }
    
    open class Header: UIView {
        public var form: UIForm!
    }
    
    open class Footer: UIView {
        public var form: UIForm!
    }
    
    fileprivate class Spacing: NSObject {
        
    }
    
    
    public typealias SimpleFuntion = (() -> Void)?
}


//MARK: - Operators


infix operator -- : UIFormPrecedence
infix operator ---- : UIFormPrecedence
infix operator ~ : UIFormPrecedence

precedencegroup UIFormPrecedence {
    associativity: left
    higherThan: AdditionPrecedence
}

@discardableResult
public func -- (section: UIForm.Section, row: UIForm.Row) -> UIForm {
    return section.form
}

extension UIForm {
    
    @discardableResult
    public static func -- (form1: UIForm, form2: UIForm) -> UIForm {
        return form1
    }
    
    @discardableResult
    public static func -- (form: UIForm, section: Section) -> UIForm {
        return form
    }
    
    @discardableResult
    public static func -- (form: UIForm, row: Row) -> UIForm {
        return form
    }
    
    @discardableResult
    public static func -- (form: UIForm, header: Header) -> UIForm {
        return form
    }
    
    @discardableResult
    public static func -- (form: UIForm, footer: Footer) -> UIForm {
        return form
    }
    
    @discardableResult
    public static func -- (form: UIForm, height: Double) -> UIForm {
        return form
    }
    
    @discardableResult
    public static func ~ (form: UIForm, count: Int) -> UIForm {
        return form
    }
    
}

//MARK: - Delegate

public protocol UIFormDelegate
{
    
}
