//
//  UICollectionViewExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2016/12/22.
//  Copyright © 2016 Sakura. All rights reserved.
//

import Foundation

extension UICollectionView
{
    
    /// Default selections of collecion view.
    /// 'nil' is selecte none. [] is select all.
    public var defaultSelections : [IndexPath]? {
        set {
            setAssociatedObject(key: "defaultSelections", value: newValue)
            self.performBatchUpdates(nil) {
                [unowned self] _ in
                
                //Not nil.
                for indexPath in newValue ?? [] {
                    self.selectItem(at: indexPath, animated: false, scrollPosition: [])
                }
                
                //If an empty array('[]'), select all.
                if newValue?.count == 0 {
                    for section in 0..<self.numberOfSections {
                        for row in 0..<self.numberOfItems(inSection: section) {
                            self.selectItem(at: IndexPath(row: row, section: section), animated: false, scrollPosition: [])
                        }
                    }
                }
            }
        }
        get { return getAssociatedObject(key: "defaultSelections") as? [IndexPath] }
    }
    
}
