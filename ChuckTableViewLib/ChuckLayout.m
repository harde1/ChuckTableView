//
//  WaterLayout.m
//  ChuckTableView
//
//  Created by 梁慧聪 on 2016/12/12.
//  Copyright © 2016年 liangdianxiong. All rights reserved.
//

#import "ChuckLayout.h"
@interface ChuckLayout()
@property(nonatomic,copy)CGSize(^itemSize)(id model,NSInteger section);
@property(nonatomic,copy)CGFloat(^interitemSpacing)(id model,NSInteger section);
@property(nonatomic,copy)CGFloat(^lineSpacing)(id model,NSInteger section);
@property(nonatomic,copy)UIEdgeInsets(^contentInset)(id model,NSInteger section);
@property(nonatomic,assign)CGRect framePre;
/**
 *  布局信息
 */
@property (nonatomic, strong) NSArray *layoutInfoArr;
/**
 *  内容尺寸
 */
@property (nonatomic, assign) CGSize contentSize;

@end
@implementation ChuckLayout
-(instancetype)initItemSize:(CGSize (^)(id model,NSInteger section))itemSize
  interitemSpacingIndexPath:(CGFloat (^)(id model,NSInteger section))interitemSpacing
       lineSpacingIndexPath:(CGFloat (^)(id model,NSInteger section))lineSpacing
      contentInsetIndexPath:(UIEdgeInsets (^)(id model,NSInteger section))contentInset{
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
    CGFloat mainScreenWidth = [UIScreen mainScreen].bounds.size.width;
    //在这里面就把东西都计算好了
    NSMutableArray *layoutInfoArr = [NSMutableArray array];
    NSInteger maxNumberOfItems = 0;
    CGFloat maxHeight = 0;

    //numberOfSections
    NSInteger numberOfSections = [self.collectionView numberOfSections];
    for (NSInteger section = 0; section < numberOfSections; section++){
        NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
        NSMutableArray *subArr = [NSMutableArray arrayWithCapacity:numberOfItems];

        for (NSInteger item = 0; item < numberOfItems; item++){
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            //行距
            CGFloat lineSectionSpacing= self.lineSpacing?self.lineSpacing(nil,indexPath.section):0.f;
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];

            UICollectionViewLayoutAttributes *headFootAttributes = [self layoutAttributesForSupplementaryViewOfKind:@"" atIndexPath:indexPath];

            maxHeight = indexPath.item==0?(CGRectGetMaxY(headFootAttributes.frame)>0?(CGRectGetMaxY(headFootAttributes.frame) + lineSectionSpacing):0):0 + CGRectGetMaxY(attributes.frame);

            [subArr addObject:attributes];
        }
        if(maxNumberOfItems < numberOfItems){
            maxNumberOfItems = numberOfItems;
        }
        //添加到二维数组
        [layoutInfoArr addObject:[subArr copy]];
    }
    //存储布局信息
    self.layoutInfoArr = [layoutInfoArr copy];
    //保存内容尺寸
    self.contentSize = (CGSize){mainScreenWidth,maxHeight};
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
        return self.layoutInfoArr[indexPath.section][indexPath.item];
    }
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];

    CGFloat mainScreenWidth = [UIScreen mainScreen].bounds.size.width;
    //section里面的cell size
    CGSize itemSectionSize = self.itemSize?self.itemSize(nil,indexPath.section):CGSizeZero;
    //cell与cell之间的距离
    CGFloat interitemSectionSpacing = self.interitemSpacing?self.interitemSpacing(nil,indexPath.section):0.f;
    //行距
    CGFloat lineSectionSpacing= self.lineSpacing?self.lineSpacing(nil,indexPath.section):0.f;
    //整个section内嵌距离
    UIEdgeInsets contentSectionInset = self.contentInset?self.contentInset(nil,indexPath.section):UIEdgeInsetsZero;

    //每行可以有多少个item
    CGFloat maxItemWidth = mainScreenWidth - contentSectionInset.left - contentSectionInset.right;
    NSInteger maxItemPerRow = maxItemWidth/itemSectionSize.width;//至少有一个
    maxItemPerRow = maxItemPerRow==0?1:maxItemPerRow;
    
    CGRect framePre = self.framePre;

    BOOL isRowFirst = indexPath.item==0?YES:(indexPath.item%(maxItemPerRow) == 0?YES:NO);
    BOOL isRowLast = maxItemPerRow==1?YES:((indexPath.item+1)%(maxItemPerRow) == 0?YES:NO);
    BOOL isMid = !(isRowLast && isRowFirst);
    //只有确定是第一个，就要contentSectionInset.left
    CGFloat x = isRowFirst?contentSectionInset.left:CGRectGetMaxX(framePre)+interitemSectionSpacing;
  
    CGFloat y= isRowFirst?(isRowLast&&indexPath.item>0?(CGRectGetMaxY(framePre)+lineSectionSpacing):(indexPath.section==0?contentSectionInset.top:(CGRectGetMaxY(framePre)+lineSectionSpacing))):CGRectGetMinY(framePre);

    if (indexPath.section==0 && indexPath.item==0) {
        y = contentSectionInset.top;
    }
    else if (isRowFirst){
        //要考虑头
        y = CGRectGetMaxY(framePre)+lineSectionSpacing;
    }else if(isMid){
        y = CGRectGetMinY(framePre);
    }else if(isRowLast){
        y = CGRectGetMinY(framePre);
    }


    attributes.frame = (CGRect){x,y,itemSectionSize.width,itemSectionSize.height};
    self.framePre = attributes.frame;
    NSLog(@"%@\n%@\n%d,%d",indexPath,NSStringFromCGRect(self.framePre),isRowFirst,isRowLast);

    return attributes;
}
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];

    return attributes;
}

-(void)setItemSizeSection:(CGSize (^)(id model,NSInteger section))itemSize{
    _itemSize = itemSize;
}
-(void)setInteritemSpacingIndexPath:(CGFloat (^)(id model,NSInteger section))interitemSpacing{
    _interitemSpacing = interitemSpacing;
}
-(void)setLineSpacingIndexPath:(CGFloat (^)(id model,NSInteger section))lineSpacing{
    _lineSpacing = lineSpacing;
}
-(void)setContentInsetIndexPath:(UIEdgeInsets (^)(id model,NSInteger section))contentInset{
    _contentInset = contentInset;
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
@end
