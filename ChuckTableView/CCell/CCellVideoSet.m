//
//  CCellVideoSet.m
//  ChuckTableView
//
//  Created by 梁慧聪 on 2017/1/6.
//  Copyright © 2017年 liangdianxiong. All rights reserved.
//

#import "CCellVideoSet.h"
#import "UICollectionViewCell+Chuck.h"
#import "UtilScreenSize.h"
#import "CsFrame.h"
@interface CCellVideoSet()
@property (nonatomic, strong) ChuckCollectionView *collect;
@property (nonatomic, strong) UILabel *lbTitle;
@end

@implementation CCellVideoSet
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.collect];
        [self.contentView addSubview:self.lbTitle];
        [self resetFrame];
        [self.collect addModel:@""];
        [self.collect addModel:@""];
        [self.collect addModel:@""];
    }
    return self;
}
-(void)resetFrame{
    self.lbTitle.cslayout
    .leftSpaceEqual(PxToPt(30))
    .topSpaceEqual(PxToPt(30))
    .widthEqual(self.width-PxToPt(30)*2).end();
    [self.lbTitle sizeToFit];
    
    self.collect.cslayout
    .leftSpaceEqual(PxToPt(30))
    .topSpaceEqual(self.lbTitle.bottom+PxToPt(20))
    .widthEqual(self.width-PxToPt(30)*2)
    .heightEqual(PxToPt(180)).end();
    
    
    
    self.chuckModel.cellHeight = self.collect.bottom + PxToPt(30);
}
-(ChuckCollectionView *)collect{
    if (!_collect) {
        UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc]init];
        flow.itemSize = CGSizeMake(PxToPt(280), PxToPt(180));
        flow.minimumInteritemSpacing = PxToPt(20);
        flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collect = [[ChuckCollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flow vcDelegate:nil configureBlock:^(UICollectionViewCell *cell, id model, NSIndexPath *indexPath) {
            cell.backgroundColor = [UIColor lightGrayColor];
        } cellDidselectConfig:^(UICollectionViewCell *cell, id model, NSIndexPath *indexPath) {
            
        }];
        _collect.backgroundColor = [UIColor clearColor];
    }
    return _collect;
}
-(UILabel *)lbTitle{
    if (!_lbTitle) {
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.text = @"视频分集";
    }
    return _lbTitle;
}
@end
