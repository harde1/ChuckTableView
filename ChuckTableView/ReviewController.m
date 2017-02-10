//
//  ReviewController.m
//  ChuckTableView
//
//  Created by 梁慧聪 on 2017/1/5.
//  Copyright © 2017年 liangdianxiong. All rights reserved.
//

#import "ReviewController.h"
#import "ChuckCollectionView.h"
#import "ChuckLayout.h"
#import "UIView+Metrics.h"

#import "CCellPlayer.h"
#import "CCellTitleShare.h"

#import "UtilScreenSize.h"
#import "CCellDetail.h"
#import "CCellVideoSet.h"
@interface ReviewController ()<ChuckDelegate>
@property(nonatomic,strong)ChuckCollectionView* collect;
@property(nonatomic,strong)ChuckLayout * layout;
@end

@implementation ReviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.collect];
    [self.collect addModel:@"" cellClass:CCellPlayer.class];
    [self.collect addModel:@"" cellClass:CCellTitleShare.class section:1];
    [self.collect addModel:@"" cellClass:CCellDetail.class section:1];
    [self.collect addModel:@"" cellClass:CCellVideoSet.class section:2];
    
    for (int i=0; i<10; i++) {
        [self.collect addModel:@"" section:3];
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.collect.frame = self.view.bounds;
}
-(ChuckCollectionView *)collect{
    if (!_collect) {
        _collect =
        [[ChuckCollectionView alloc]
         initWithFrame:self.view.bounds
         collectionViewLayout:self.layout
         vcDelegate:self
         configureBlock:^(UICollectionViewCell *cell, id model, NSIndexPath *indexPath) {
             cell.contentView.backgroundColor = [UIColor whiteColor];
         } cellDidselectConfig:^(UICollectionViewCell *cell, id model, NSIndexPath *indexPath) {
             NSLog(@"点击到什么：%@,%ld,%ld",model,indexPath.section,indexPath.item);
         }];
        _collect.backgroundColor = UIColorFromRGB(0xf1f1f1);
    }
    return _collect;
}

-(ChuckLayout *)layout{
    __weak typeof(self) wSelf = self;
    if (!_layout) {
        _layout = [[ChuckLayout alloc] initItemSize:^CGSize(id model,ChuckModel * chuckModel, NSInteger section) {
            
            if (section==0) {
                return CGSizeMake(wSelf.view.width, 200);
            }
            if ([chuckModel.identifier isEqualToString:@"CCellDetail"]) {
                return CGSizeMake(wSelf.view.width, chuckModel.cellHeight==0?200:chuckModel.cellHeight);
            }
            if ([chuckModel.identifier isEqualToString:@"CCellVideoSet"]) {
                return CGSizeMake(wSelf.view.width, chuckModel.cellHeight==0?PxToPt(300):chuckModel.cellHeight);
            }
            return CGSizeMake(wSelf.view.width, 60);
        } interitemSpacingIndexPath:^CGFloat(id model,ChuckModel * chuckModel, NSInteger section) {
            return 10;
        } lineSpacingIndexPath:^CGFloat(id model,ChuckModel * chuckModel, NSInteger section) {
            return 1;
        } contentInsetIndexPath:^UIEdgeInsets(NSInteger section) {
            return UIEdgeInsetsZero;
        }];
    }
    return _layout;
}

@end
