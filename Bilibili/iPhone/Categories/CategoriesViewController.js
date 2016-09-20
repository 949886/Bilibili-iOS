require('UICollectionViewFlowLayout,UICollectionView,UIScreen,UIColor,CategoryCell,UIImage,NSIndexPath');
require('JPEngine').defineStruct({
                                 "name": "UIEdgeInsets",
                                 "types": "FFFF",
                                 "keys": ["top", "left", "bottom", "right"]
})

defineClass('CategoriesViewController', {
            viewDidLoad: function() {
            self.super().viewDidLoad();
            
            _images = ["home_region_icon_live", "home_region_icon_13", "home_region_icon_1", "home_region_icon_3",
                       "home_region_icon_129", "home_region_icon_4", "home_region_icon_36", "home_region_icon_life",
                       "home_region_icon_119", "home_region_icon_fashion", "home_region_gamecenter", "home_region_icon_entertainment",
                       "home_region_icon_23", "home_region_icon_5"
                       ];
            
            var width = UIScreen.mainScreen().bounds().width;
            
            //Initialize CollectionView
            var layout = UICollectionViewFlowLayout.new();
            layout.setMinimumLineSpacing(16);
            layout.setMinimumInteritemSpacing(24);
            layout.setItemSize({width: width / 3 - 24 * 2, height:width / 3 - 24 * 2});
            
            _collectionView = UICollectionView.alloc().initWithFrame_collectionViewLayout(self.view().bounds(), layout);
            _collectionView.setScrollEnabled(NO);
            _collectionView.setBackgroundColor(UIColor.colorWithWhite_alpha(0.95, 1.000));
            _collectionView.setAutoresizingMask(1 << 1 | 1 << 4);  //FlexibleWidth | FlexibleHeight
            _collectionView.setContentInset({top: 20, left: 20, bottom: 20, right: 20});
            _collectionView.setDataSource(self);
            _collectionView.setDelegate(self);
            _collectionView.registerClass_forCellWithReuseIdentifier(CategoryCell.class(), "CategoryCell");
            self.contentView().addSubview(_collectionView);
            },
            numberOfSectionsInCollectionView: function(collectionView) {
                return 1;
            },
            
            collectionView_numberOfItemsInSection: function(collectionView, section) {
                return _images.length;
            },
            
            collectionView_cellForItemAtIndexPath: function(collectionView, indexPath) {
                var cell = _collectionView.dequeueReusableCellWithReuseIdentifier_forIndexPath("CategoryCell", indexPath);
                cell.imageView().setImage(UIImage.imageNamed(_images[indexPath.row()]));
                return cell;
            },
});