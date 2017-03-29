//
//  SegmentCell.m
//  Bilibili
//
//  Created by LunarEclipse on 16/9/4.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "SegmentCell.h"
#import "LiveCell.h"
#import "VideoCell.h"
#import "BangumiCell.h"
#import "BangumiRecommendCell.h"
#import "SegmentFooter.h"
#import "RecBangumiFooter.h"

#import "models.h"
#import "extension.h"

#import "WebViewControll.h"

#define CELL_ID @"Cell"

#define FOOTER_REGION_ID @"RegionFooter"
#define FOOTER_BANGUMI_ID @"BangumiFooter"
#define RECOMMEND_LIVE_ID @"RecommendLiveCell"

#define BANGUMI_RECOMMEND_CELL @"bangumisRecommend"

#define ROW_HEIGHT 150
#define BANGUMI_ROW_HEIGHT 200
#define PADDING 4

@import YYKit;
@import SDWebImage;
@import ReactiveObjC;


#pragma mark - SegmentCell

@interface SegmentCell ()

@property (nonatomic, strong) UICollectionViewFlowLayout * layout;

@property (nonatomic, strong) LiveHomePartition * partition;
@property (nonatomic, strong) RecommendSegment * recSegment;
@property (nonatomic, strong) BangumiSegment * bangumiSegment;

@property (nonatomic, copy) NSMutableDictionary * cellHeights;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *refreshButtonBottom;

@end

@implementation SegmentCell

#pragma mark Initialization

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initialize];
}

- (void)initialize
{
    _cellHeights = [NSMutableDictionary new];
    
    _layout = [UICollectionViewFlowLayout new];
    _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _layout.minimumInteritemSpacing = 0;
    _layout.minimumLineSpacing = 0;
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.collectionViewLayout = _layout;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _collectionView.contentInset = UIEdgeInsetsMake(PADDING, PADDING, PADDING, PADDING);
}

#pragma mark Override

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark Methods

- (void)setupLive:(LiveHomePartition *)partition
{
    _partition = partition;
    _type = SegmentCellLive;
    
    //若该segment为热门推荐则将会在中间插入一条直播间推广（一般为bilibili音乐台）
    if ([_partition.info.area isEqualToString:@"hot"])
    {
        NSMutableArray * array = partition.lives.mutableCopy;
        [array insertObjects:_partition.banner_data atIndex:array.count * 0.5];
        _data = array;
    }
    else _data = partition.lives;
    
    //计算CollectionView的高度
    [self caculateHeight];
    
    //加载xib并刷新数据
    [_collectionView registerNib:[UINib nibWithNibName:@"LiveCell" bundle:nil] forCellWithReuseIdentifier:CELL_ID];
    [_collectionView reloadData];
}

- (void)setupRecommend:(RecommendSegment *)segment
{
    _recSegment = segment;
    _type = SegmentCellRecommend;
    _data = segment.elements;
    
    //计算CollectionView的高度
    [self caculateHeight];
    
    //加载Cell的xib和Footer并刷新数据
    [_collectionView registerNib:[UINib nibWithNibName:@"VideoCell" bundle:nil] forCellWithReuseIdentifier:CELL_ID];
    [_collectionView registerNib:[UINib nibWithNibName:@"LiveCell" bundle:nil] forCellWithReuseIdentifier:RECOMMEND_LIVE_ID];
    [_collectionView registerClass:[SegmentFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FOOTER_REGION_ID];
    [_collectionView registerNib:[UINib nibWithNibName:@"RecBangumiFooter" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FOOTER_BANGUMI_ID];
    [_collectionView reloadData];
}

- (void)setupBangumi:(BangumiSegment *)segment
{
    _bangumiSegment = segment;
    _type = SegmentCellBangumi;
    _data = segment.bangumis;

    if (segment.isRecommend)
        _layout.minimumLineSpacing = 8;
    else _layout.minimumLineSpacing = 0;
    
    //计算CollectionView的高度
    [self caculateHeight];
    
//    //加载xib并刷新数据
    [_collectionView registerNib:[UINib nibWithNibName:@"BangumiCell" bundle:nil] forCellWithReuseIdentifier:CELL_ID];
    [_collectionView registerNib:[UINib nibWithNibName:@"BangumiRecommendCell" bundle:nil] forCellWithReuseIdentifier:BANGUMI_RECOMMEND_CELL];
//    [_collectionView reloadData];
}

#pragma mark Delegate

/* UICollectionViewDataSource */

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self presentCount];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    
    if (_type == SegmentCellLive && _data)
    {
        if(indexPath.row > _data.count) return cell;
        LiveModel * live = _data[indexPath.row];
        LiveCell * liveCell = (LiveCell *)cell;
        
        [liveCell setup:live];
        
        //若该segment为热门推荐则会在cell标题前高亮显示分区名
        if ([_partition.info.area isEqualToString:@"hot"])
        {
            NSString * title = [NSString stringWithFormat:@"%@ %@", live.area, live.title];
            NSDictionary * attributes = @{NSForegroundColorAttributeName : [UIColor orangeColor]};
            NSMutableAttributedString * aString = [[NSMutableAttributedString alloc] initWithString:title];
            [aString setAttributes:attributes range:NSMakeRange(0, live.area.length)];
            liveCell.titleLabel.attributedText = aString;
        }
        else liveCell.titleLabel.text = live.title;
    }
    
    
    if (_type == SegmentCellRecommend && _data)
    {
        if(indexPath.row > _data.count) return cell;
        
        RecommendElement * element = _data[indexPath.row];
        
        //If region type is live.
        if ([_recSegment.type isEqualToString:@"live"])
        {
            LiveCell * liveCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:RECOMMEND_LIVE_ID forIndexPath:indexPath];
            LiveModel * live = [LiveModel new];
            live.room_id = [element.param integerValue];
            [liveCell setup:live];
            
            liveCell.usernameLabel.text = element.name;
            liveCell.titleLabel.text = element.title;
            liveCell.viewersLabel.text = [NSString stringWithFormat:@"%@", [NSString integer2Chinese:element.online]];
            [liveCell.coverImageView sd_setImageWithURL:[NSURL URLWithString:element.cover] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
            return liveCell;
        }
        
        //Besides live, bangumi.
        VideoCell * videoCell = (VideoCell *)cell;
        [videoCell setup:element type:_recSegment.type];
    }
    
    
    if (_type == SegmentCellBangumi && _data)
    {
        if(indexPath.row > _data.count) return cell;
        
        if (_bangumiSegment.index != 2)
        {
            BangumiModel * bangumi = _data[indexPath.row];
            BangumiCell * bangumiCell = (BangumiCell *)cell;
            [bangumiCell setup:bangumi];
            
            if (_bangumiSegment.index == 0)
            {
                bangumiCell.episodeLabel.hidden = NO;
                bangumiCell.viewersLabel.text = [NSString stringWithFormat:NSLocalizedString(@"home_bangumi_viewers", nil), [NSString integer2Chinese:bangumi.watching_count]];
            }
            else if (_bangumiSegment.index == 1)
            {
                bangumiCell.episodeLabel.hidden = YES;
                bangumiCell.viewersLabel.text = [NSString stringWithFormat:NSLocalizedString(@"home_bangumi_followers", nil), [NSString integer2Chinese:bangumi.favourites]];
            }
        }
    }
    
    return cell;
}

//Footer
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (_type != SegmentCellRecommend) return nil;
    if (![kind isEqualToString:UICollectionElementKindSectionFooter]) return nil;
    
    if ([_recSegment.type isEqualToString:@"region"] && _recSegment.banners != nil)
    {
        SegmentFooter * footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FOOTER_REGION_ID forIndexPath:indexPath];
        [footer setup:_recSegment.banners];
        return footer;
    }
    
    if ([_recSegment.type isEqualToString:@"bangumi"])
    {
        RecBangumiFooter * footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FOOTER_BANGUMI_ID forIndexPath:indexPath];
        return footer;
    }
    
    return nil;
}


/* UICollectionViewDelegateFlowLayout */

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_type == SegmentCellLive)
    {
        if ([_partition.info.area isEqualToString:@"hot"] && indexPath.row == _partition.lives.count / 2)
            return CGSizeMake(kScreenWidth - PADDING * 2, ROW_HEIGHT);
    }
    if(_type == SegmentCellBangumi)
    {
        if (_bangumiSegment.isRecommend){
            CGSize size = [_cellHeights[@(indexPath.row)] CGSizeValue];
            return size;
        }
        
        else return CGSizeMake(kScreenWidth / 3 - ceilf(2.0 * PADDING / 3), (kScreenWidth / 3 - ceilf(2.0 * PADDING / 3)) * 1.25 + 50);
    }
    
    return CGSizeMake(kScreenWidth / 2 - PADDING, ROW_HEIGHT);
}

//Footer size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (_type != SegmentCellRecommend) return CGSizeZero;
    if (!((_recSegment.banners != nil &&  [_recSegment.type isEqualToString:@"region"])  ||
          [_recSegment.type isEqualToString:@"bangumi"])) return CGSizeZero;
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    return CGSizeMake(screenWidth, 100);
}


#pragma mark IBAction

//Segment标题栏的点击事件，会跳转到分区的详细页面
- (IBAction)onClickTitleButton:(id)sender
{
    
}

- (IBAction)onClickRefreshButton:(id)sender
{
    //720°旋转动画
    [CATransaction begin];
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.byValue = @(4 * M_PI);
    rotationAnimation.duration = 1;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.refreshButton.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    [CATransaction commit];
    
    //刷新数据
    [self refreshData];
}

#pragma mark Encapsulation

//CollectionView要显示的Cell的数量
-(NSInteger)presentCount
{
    if (!_data) return 0;
    
    switch (_type)
    {
        case SegmentCellLive:
            if ([_partition.info.area isEqualToString:@"hot"])
                return _data.count;
            else return (_data.count > 4) ? 4 : _data.count;
        case SegmentCellRecommend:
            if ([_recSegment.type isEqualToString:@"recommend"])
                return _data.count;
            else return (_data.count > 4) ? 4 : _data.count;
        default: return _data.count;
    }
}

//计算CollectionView的height
-(void)caculateHeight
{
    if (_type == SegmentCellLive)
    {
        NSInteger row = ceil(0.5 * [self presentCount]);
        _collectionViewHeight.constant = row * ROW_HEIGHT;
    }
    
    if(_type == SegmentCellRecommend)
    {
        NSInteger row = ceil(0.5 * [self presentCount]);
        _collectionViewHeight.constant = row * ROW_HEIGHT;
        
        if ((_recSegment.banners != nil &&  [_recSegment.type isEqualToString:@"region"])  ||
            [_recSegment.type isEqualToString:@"bangumi"])
        {
            _refreshButtonBottom.constant = 100;
            _collectionViewHeight.constant += 100;
        }
        else _refreshButtonBottom.constant = 5;
        
        if ([_recSegment.type isEqualToString:@"activity"])
        {
            _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            _collectionViewHeight.constant =  ROW_HEIGHT + 2 * PADDING;
            _collectionView.scrollEnabled = YES;
            _collectionView.bounces = YES;
        }
        else
        {
            _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
            _collectionView.scrollEnabled = NO;
            _collectionView.bounces = NO;
        }
    }
    
    if(_type == SegmentCellBangumi)
    {
        if (!_bangumiSegment.isRecommend)
        {
            CGSize cellSize = [self collectionView:self.collectionView layout:_layout sizeForItemAtIndexPath:[NSIndexPath new]];
            NSInteger row = ceil([self presentCount] / 3.0);
            _collectionViewHeight.constant =  cellSize.height * row;
        }
        else
        {
            CGFloat totalHeight = 0;
            for (int i = 0; i < _data.count; ++i) {
                BangumiRecommendModel * bangumiRec = _data[i];
                NSInteger lines = [bangumiRec.desc componentsSeparatedByString:@"\n"].count;
                CGSize size = CGSizeMake(kScreenWidth - PADDING * 2, 160 + 14 * lines);
                _cellHeights[@(i)] = [NSValue valueWithCGSize:size];
                totalHeight += size.height;
            }
            _collectionViewHeight.constant = totalHeight;
        }
    }
}

-(void)refreshData
{
    if (_type == SegmentCellLive)
    {
        //TODO: Refresh Event.
    }
    
    if (_type == SegmentCellRecommend)
    {
        
    }
}

@end
