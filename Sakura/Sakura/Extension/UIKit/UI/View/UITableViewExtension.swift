//
//  UITableViewExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/1/2.
//  Copyright © 2017 Sakura. All rights reserved.
//

import Foundation

extension UITableView {
    
    var autolayoutTableViewHeader : UIView? {
        get { return self.tableHeaderView }
        set { autolayoutHeaderFooterView(newValue, 0) }
    }
    
    var autolayoutTableViewFooter : UIView? {
        get { return self.tableHeaderView }
        set { autolayoutHeaderFooterView(newValue, 1) }
    }
    
    private func autolayoutHeaderFooterView(_ headerOrFooter: UIView?, _ type: Int /* 0: header, 1: footer */) {
        if let view = headerOrFooter {
            self.tableHeaderView = view
            view.setNeedsLayout()
            view.layoutIfNeeded()
            let height = view.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
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
