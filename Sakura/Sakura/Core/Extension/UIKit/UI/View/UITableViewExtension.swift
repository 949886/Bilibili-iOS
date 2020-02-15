//
//  UITableViewExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/1/2.
//  Copyright © 2017 YaeSakura. All rights reserved.
//

import Foundation

extension UITableView
{
    
    /// Default selections of collecion view.
    /// 'nil' is selecte none. [] is select all.
    @objc public var defaultSelections : [IndexPath]? {
        set {
            setAssociatedObject(key: "defaultSelections", value: newValue)

            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
                [unowned self] in
                
                //Not empty.
                for indexPath in newValue ?? [] {
                    self.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                }
                
                //If an empty array('[]'), select all.
                if newValue?.count == 0 {
                    for section in 0..<self.numberOfSections {
                        for row in 0..<self.numberOfRows(inSection: section) {
                            self.selectRow(at: IndexPath(row: row, section: section), animated: false, scrollPosition: .none)
                        }
                    }
                }
            }
        }
        get { return getAssociatedObject(key: "defaultSelections") as? [IndexPath] }
    }
    
    @objc public var autolayoutTableViewHeader : UIView? {
        get { return self.tableHeaderView }
        set { autolayoutHeaderFooterView(newValue, 0) }
    }
    
    @objc public var autolayoutTableViewFooter : UIView? {
        get { return self.tableHeaderView }
        set { autolayoutHeaderFooterView(newValue, 1) }
    }
    
    private func autolayoutHeaderFooterView(_ headerOrFooter: UIView?, _ type: Int /* 0: header, 1: footer */) {
        if let view = headerOrFooter {
            self.tableHeaderView = view
            view.setNeedsLayout()
            view.layoutIfNeeded()
            let height = view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            var frame = view.frame
            frame.size.height = height
            view.frame = frame
            if type == 0 { self.tableHeaderView = view }
            else { self.tableFooterView = view }
        } else {
            if type == 0 { self.tableHeaderView = nil }
            else { self.tableFooterView = nil }
        }
    }
    
}


extension UITableViewCell
{
    var tableView: UITableView? {
        return nil
    }
}
