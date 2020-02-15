//
//  UICollectionViewGridLayout.swift
//  Sakura
//
//  Created by YaeSakura on 2017/4/20.
//  Copyright © 2017 YaeSakura. All rights reserved.
//

import Foundation

@objcMembers
open class UICollectionViewGridLayout: UICollectionViewLayout
{
    public var columnCount = 3 { didSet { invalidateLayout() } }
    
    // MARK: - Override
    
    open override var collectionViewContentSize: CGSize {
        return self.collectionView?.bounds.size ?? .zero
    }
    
    open override func prepare() {
        
    }
    
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return nil
    }
    
    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return nil
    }
    
    open override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}

@objc protocol UICollectionViewGridLayoutDelegate: UICollectionViewDelegate {
    @objc func collectionView(_ collectionView: UICollectionView,
                        heightForRow: Int) -> CGFloat
    @objc optional func collectionView(_ collectionView: UICollectionView,
                                       rowSpacingForSection section: Int) -> CGFloat
    
}
