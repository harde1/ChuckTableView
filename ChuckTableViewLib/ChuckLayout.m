//
//  WaterLayout.m
//  ChuckTableView
//
//  Created by 梁慧聪 on 2016/12/12.
//  Copyright © 2016年 liangdianxiong. All rights reserved.
//

#import "ChuckLayout.h"
#import "ChuckCollectionView.h"
@interface ChuckLayout()
@property(nonatomic,copy)CGSize(^itemSize)(id model,NSInteger section);
@property(nonatomic,copy)CGFloat(^interitemSpacing)(id model,NSInteger section);
@property(nonatomic,copy)CGFloat(^lineSpacing)(id model,NSInteger section);
@property(nonatomic,copy)UIEdgeInsets(^contentInset)(NSInteger section);
/**
 *  布局信息
 */
@property (nonatomic, strong) NSMutableArray *layoutInfoArr;
/**
 *  内容尺寸
 */
@property (nonatomic, assign) CGSize contentSize;

@end
@implementation ChuckLayout
-(NSMutableArray *)layoutInfoArr{
    if (!_layoutInfoArr) {
        _layoutInfoArr = [[NSMutableArray alloc] init];
    }
    return _layoutInfoArr;
}
-(instancetype)initItemSize:(CGSize (^)(id model,NSInteger section))itemSize
  interitemSpacingIndexPath:(CGFloat (^)(id model,NSInteger section))interitemSpacing
       lineSpacingIndexPath:(CGFloat (^)(id model,NSInteger section))lineSpacing
      contentInsetIndexPath:(UIEdgeInsets (^)(NSInteger section))contentInset{
    if (self = [super init]) {
        self.itemSize = itemSize;
        self.interitemSpacing = interitemSpacing;
        self.lineSpacing = lineSpacing;
        self.contentInset = contentInset;
    }
    return self;
}
//预先布局
//需求，是一个flow布局
//可以单独确定每个section的cell不同的size
- (void)prepareLayout{
    [super prepareLayout];
    [self.layoutInfoArr removeAllObjects];
    CGFloat mainScreenWidth = [UIScreen mainScreen].bounds.size.width;
    
    //numberOfSections
    NSInteger numberOfSections = [self.collectionView numberOfSections];
    for (NSInteger section = 0; section < numberOfSections; section++){
        NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
        NSMutableArray *subArr = [[NSMutableArray alloc] init];
        //添加到二维数组
        
        for (NSInteger item = 0; item < numberOfItems; item++){
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            //行距
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            if (self.layoutInfoArr.count==section) {
                [self.layoutInfoArr addObject:subArr];
            }
            [subArr addObject:attributes];
        }
        
    }
    //存储布局信息
    UICollectionViewLayoutAttributes *attributes = [[self.layoutInfoArr lastObject] lastObject];
    UIEdgeInsets contentSectionInset = self.contentInset?self.contentInset(numberOfSections-1):UIEdgeInsetsZero;
    //保存内容尺寸
    self.contentSize = (CGSize){mainScreenWidth,CGRectGetMaxY(attributes.frame)+contentSectionInset.bottom};
}
- (CGSize)collectionViewContentSize{
    return self.contentSize;
}
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSMutableArray *layoutAttributesArr = [NSMutableArray array];
    [self.layoutInfoArr enumerateObjectsUsingBlock:^(NSArray *array, NSUInteger i, BOOL * _Nonnull stop) {
        [array enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if(CGRectIntersectsRect(obj.frame, rect)) {
                [layoutAttributesArr addObject:obj];
            }
        }];
    }];
    return layoutAttributesArr;
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.layoutInfoArr) {
        if (self.layoutInfoArr.count>indexPath.section) {
            if ([self.layoutInfoArr[indexPath.section] count]>indexPath.item) {
                return self.layoutInfoArr[indexPath.section][indexPath.item];
            }
        }
    }
    ///  基本参数
    ChuckCollectionView * collect = (ChuckCollectionView *)self.collectionView;
    ChuckModel * model = [collect getModelAtIndexPath:indexPath];
    CGFloat mainScreenWidth = [UIScreen mainScreen].bounds.size.width;
    //section里面的cell size
    CGSize itemSectionSize = self.itemSize?self.itemSize(model.model,indexPath.section):CGSizeZero;
    //cell与cell之间的距离
    CGFloat interitemSectionSpacing = self.interitemSpacing?self.interitemSpacing(model.model,indexPath.section):0.f;
    //行距
    CGFloat lineSectionSpacing= self.lineSpacing?self.lineSpacing(model.model,indexPath.section):0.f;
    //整个section内嵌距离
    UIEdgeInsets contentSectionInset = self.contentInset?self.contentInset(indexPath.section):UIEdgeInsetsZero;
    
    CGFloat maxItemWidth = mainScreenWidth - contentSectionInset.left - contentSectionInset.right;
    NSInteger maxItemPerRow = maxItemWidth/itemSectionSize.width;
    //每行可以有多少个item,至少有一个
    maxItemPerRow = maxItemPerRow==0?1:maxItemPerRow;
    CGRect framePre = [[[self.layoutInfoArr lastObject] lastObject] frame];
    
    //行首 行尾 行中
    BOOL isRowFirst = indexPath.item==0?YES:(indexPath.item%(maxItemPerRow) == 0?YES:NO);
    BOOL isRowLast = maxItemPerRow==1?YES:((indexPath.item+1)%(maxItemPerRow) == 0?YES:NO);
    BOOL isMid = !isRowLast && !isRowFirst;
    
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    //只有确定是第一个，就要contentSectionInset.left
    CGFloat x = isRowFirst?contentSectionInset.left:CGRectGetMaxX(framePre)+interitemSectionSpacing;
    CGFloat y = 0;
    
    if (indexPath.section==0 && indexPath.item==0) {
        y = contentSectionInset.top;
    }
    else if (isRowFirst){
        y = CGRectGetMaxY(framePre)+lineSectionSpacing;
    }
    else if(isMid){
        y = CGRectGetMinY(framePre);
    }
    else if(isRowLast){
        y = CGRectGetMinY(framePre);
    }
    attributes.frame = (CGRect){(int)x,(int)y,(int)itemSectionSize.width,(int)itemSectionSize.height};
    NSLog(@"layout:(%ld,%ld),%d,%d,%d,%@,%@",(long)indexPath.section,(long)indexPath.item,isRowFirst,isMid,isRowLast,NSStringFromCGRect(attributes.frame),NSStringFromCGRect(framePre));
    return attributes;
}
//- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
//    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
//
//    return attributes;
//}

-(void)setItemSizeSection:(CGSize (^)(id model,NSInteger section))itemSize{
    _itemSize = itemSize;
}
-(void)setInteritemSpacingIndexPath:(CGFloat (^)(id model,NSInteger section))interitemSpacing{
    _interitemSpacing = interitemSpacing;
}
-(void)setLineSpacingIndexPath:(CGFloat (^)(id model,NSInteger section))lineSpacing{
    _lineSpacing = lineSpacing;
}
-(void)setContentInsetIndexPath:(UIEdgeInsets (^)(NSInteger section))contentInset{
    _contentInset = contentInset;
}
/*!
 *  多次调用 只要滑出范围就会 调用
 *  当CollectionView的显示范围发生改变的时候，是否重新发生布局
 *  一旦重新刷新 布局，就会重新调用
 *  1.layoutAttributesForElementsInRect：方法
 *  2.preparelayout方法
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
-(void)reload{
    //    self.layoutInfoArr = @[];
}
@end
