//
//  UIViewPager.swift
//  Sakura
//
//  Created by YaeSakura on 2017/1/15.
//  Copyright © 2017 YaeSakura. All rights reserved.
//

import Foundation

open class UIViewPager: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    public var index: UInt = 0
    public var startIndex: UInt = 0
    
//    private var collectionView
//    private var flowLayout
    
    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    private func initialize() {
        
    }
    
    //MARK: Delegate
    
    /* UIScrollViewDelegate */
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    /* UICollectionViewDataSource */
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    /* UICollectionViewDelegate */
    
    
}
