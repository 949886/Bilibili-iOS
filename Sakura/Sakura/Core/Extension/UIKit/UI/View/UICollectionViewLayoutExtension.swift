//
//  UICollectionViewLayoutExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/11/21.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

//MARK: - UICollectionViewLayout

extension UICollectionViewLayout
{
    @objc public func isFirstInSection(_ indexPath: IndexPath) -> Bool {
        return 0 == indexPath.row
    }
    
    @objc public func isLastInSection(_ indexPath: IndexPath) -> Bool {
        if let itemCount = collectionView?.dataSource?.collectionView(collectionView ?? UICollectionView(), numberOfItemsInSection: indexPath.section) {
            return (itemCount - 1) == indexPath.row
        }
        return false
    }
    
    @objc public func isFirstLine(_ indexPath: IndexPath) -> Bool {
        let firstItem = IndexPath(item: 0, section: indexPath.section)
        let firstItemAttributes = layoutAttributesForItem(at: firstItem)
        let thisItemAttributes = layoutAttributesForItem(at: indexPath)
        return firstItemAttributes?.frame.origin.y == thisItemAttributes?.frame.origin.y
    }
    
    @objc public func isLastLine(_ indexPath: IndexPath) -> Bool {
        if let itemCount = collectionView?.dataSource?.collectionView(collectionView ?? UICollectionView(), numberOfItemsInSection: indexPath.section) {
            let lastItem = IndexPath(item: itemCount - 1, section: indexPath.section)
            let lastItemAttributes = layoutAttributesForItem(at: lastItem)
            let thisItemAttributes = layoutAttributesForItem(at: indexPath)
            return lastItemAttributes?.frame.origin.y == thisItemAttributes?.frame.origin.y
        }
        return false
    }
    
    @objc public func isFirstOfLine(_ indexPath: IndexPath) -> Bool {
        if isFirstInSection(indexPath) {
            return true
        }
        
        let previousIndexPath = IndexPath(item: indexPath.row - 1, section: indexPath.section)
        let cellAttributes = layoutAttributesForItem(at: indexPath)
        let previousCellAttributes = layoutAttributesForItem(at: previousIndexPath)
        return !(cellAttributes?.frame.origin.y == previousCellAttributes?.frame.origin.y)
    }
    
    @objc public func isLastOfLine(_ indexPath: IndexPath) -> Bool {
        if isLastInSection(indexPath) {
            return true
        }
    
        let cellAttributes = layoutAttributesForItem(at: indexPath)
        let nextIndexPath = IndexPath(item: indexPath.row + 1, section: indexPath.section)
        let nextCellAttributes = layoutAttributesForItem(at: nextIndexPath)
        return !(cellAttributes?.frame.origin.y == nextCellAttributes?.frame.origin.y)
    }
}


//MARK: - UICollectionViewFlowLayout

extension UICollectionViewFlowLayout
{
    public var columnCount: Int {
        get { return getAssociatedObject(key: "columnCount") as? Int ?? 0 }
        set {
            setAssociatedObject(key: "columnCount", value: newValue)
            setItemSizeBy(rowCount: rowCount, columnCount: newValue)
        }
    }
    
    public var rowCount: Int {
        get { return getAssociatedObject(key: "rowCount") as? Int ?? 1 }
        set {
            setAssociatedObject(key: "rowCount", value: newValue)
            setItemSizeBy(rowCount: newValue, columnCount: columnCount)
        }
    }
    
    private func setItemSizeBy(rowCount: Int, columnCount: Int) {
        if columnCount == 0 || rowCount == 0 {
            self.itemSize = .zero
            return
        }
        
        if let collectionView = self.collectionView {
            let sections = collectionView.dataSource?.numberOfSections?(in: collectionView).f ?? 0
            
            let totalWidth = collectionView.width - (sectionInset.left + sectionInset.right) * sections
            let totalHeight = collectionView.height - (sectionInset.left + sectionInset.right) * sections
            let width = totalWidth / columnCount.f - (minimumInteritemSpacing / columnCount.f * (columnCount.f - 1))
            let height = totalHeight / rowCount.f - (minimumLineSpacing / rowCount.f * (rowCount.f - 1))
            self.itemSize = CGSize(width: width, height: height)
        }
    }
    
}
