//
//  CollectController.m
//  ChuckTableView
//
//  Created by 梁慧聪 on 2016/11/30.
//  Copyright © 2016年 liangdianxiong. All rights reserved.
//

#import "CollectController.h"
#import "ChuckCollectionView.h"
#import "ChuckLayout.h"

#import "CCellTopBar.h"
#import "CCellHomeHeader.h"
#import "CCellHomeCell.h"
const CGFloat ZYTopViewH = 350;
@interface CollectController ()<ChuckDelegate>
@property(nonatomic,strong)ChuckCollectionView* collect;
@property(nonatomic,strong)UIRefreshControl *refreshControl;
@property(nonatomic,strong)ChuckLayout * layout;
@end

@implementation CollectController
/**
 布局的责任在于UICollectionViewLayout
 ChuckCollectionView只是用于数据组装的
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collect];
    
    self.collect.backgroundColor = [UIColor whiteColor];
    [self.collect addModel:@{@"title":@"点击这里替换整个section 2"} cellClass:CCellTopBar.class];
    
    [self.collect addModel:@"" cellClass:CCellHomeHeader.class section:1];
    [self.collect addModel:@"cell内容的位置" cellClass:CCellHomeCell.class section:1+1];
    [self.collect addModel:@"cell内容的位置" cellClass:CCellHomeCell.class section:1+1];
    [self.collect addModel:@"cell内容的位置" cellClass:CCellHomeCell.class section:1+1];
    [self.collect addModel:@"cell内容的位置" cellClass:CCellHomeCell.class section:1+1];
    
    [self.collect addModel:@"" cellClass:CCellHomeHeader.class section:3];
    
    [self.collect addModel:@"cell内容的位置" cellClass:CCellHomeCell.class section:3+1];
    [self.collect addModel:@"cell内容的位置" cellClass:CCellHomeCell.class section:3+1];
    [self.collect addModel:@"cell内容的位置" cellClass:CCellHomeCell.class section:3+1];
    [self.collect addModel:@"cell内容的位置" cellClass:CCellHomeCell.class section:3+1];
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _collect.frame = self.view.bounds;
}
-(ChuckCollectionView *)collect{
    if (!_collect) {
        _collect =
        [[ChuckCollectionView alloc]
         initWithFrame:self.view.bounds
         collectionViewLayout:self.layout
         vcDelegate:self
         configureBlock:^(UICollectionViewCell *cell, id model, NSIndexPath *indexPath) {
             
         } cellDidselectConfig:^(UICollectionViewCell *cell, id model, NSIndexPath *indexPath) {
             NSLog(@"点击到什么：%@,%ld,%ld",model,indexPath.section,indexPath.item);
         }];
        [self setNavigationItem];
        [self configTopRefresh];
    }
    return _collect;
}
//插入一个
-(void)doShouCang{
    
    [_collect insertModel:@"" cellClass:CCellHomeCell.class indexPath:[NSIndexPath indexPathForItem:0 inSection:3+1] completion:^(BOOL finished) {
        
    }];
    
}
//删除一个
-(void)delShouCang{
    
    [_collect removeIndexPath:[NSIndexPath indexPathForItem:0 inSection:3+1] completion:^(BOOL finished) {
        
    }];
}
-(ChuckLayout *)layout{
    if (!_layout) {
        CCellType (^whichType)(NSInteger section) = ^(NSInteger section){
            if (section==0) return TopBar;
            if (section%2!=0) return HomeHeader;
            return HomeCell;
        };
        
        NSInteger perRow = 2;
        CGFloat width = self.view.frame.size.width;
        CGFloat leftRight = PxToPt(26);
        
        UIEdgeInsets sectionInset = UIEdgeInsetsMake(leftRight, leftRight, leftRight, leftRight);
        
        CGFloat interitemSpacing = PxToPt(20);
        CGFloat lineSpacing = PxToPt(20);
        CGFloat w = (width-interitemSpacing * (perRow -1) - sectionInset.left -sectionInset.right)/perRow * 1.0;
        CGFloat h = w;
        
        _layout = [[ChuckLayout alloc]initItemSize:^CGSize(id model,ChuckModel * chuckModel, NSInteger section) {
            switch (whichType(section)) {
                case TopBar:
                    return CGSizeMake(width,PxToPt(100));
                    break;
                case HomeHeader:
                    return CGSizeMake(width - leftRight * 2, PxToPt(90));
                    break;
                case HomeCell:
                    return (CGSize){w,h};
                    break;
            }
            return (CGSize){w,h};
        } interitemSpacingIndexPath:^CGFloat(id model,ChuckModel * chuckModel, NSInteger section) {
            
            return interitemSpacing;
        } lineSpacingIndexPath:^CGFloat(id model,ChuckModel * chuckModel, NSInteger section) {
            
            return lineSpacing;
        } contentInsetIndexPath:^UIEdgeInsets(NSInteger section) {
            if (whichType(section)==TopBar) return UIEdgeInsetsZero;
            if (whichType(section)==HomeHeader) return UIEdgeInsetsMake(5, leftRight, 0, leftRight);
            return sectionInset;
        }];
    }
    return _layout;
}




- (void)setNavigationItem{
    UIView * vItems = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 140, 60)];
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    rightButton.frame = CGRectMake(0, 0, 60, 60);
    [rightButton setTitle:@"插入" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(doShouCang) forControlEvents:UIControlEventTouchUpInside];
    
    [vItems addSubview:rightButton];
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    leftButton.frame = CGRectMake(80, 0, 60, 60);
    [leftButton setTitle:@"删除" forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(delShouCang) forControlEvents:UIControlEventTouchUpInside];
    [vItems addSubview:leftButton];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:vItems];
    self.navigationItem.rightBarButtonItem = rightItem;
}
-(void)configTopRefresh{
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    _refreshControl = refreshControl;
    refreshControl.tintColor = [UIColor grayColor];
    [refreshControl addTarget:self action:@selector(topRefresh) forControlEvents:UIControlEventValueChanged];
    [_collect addSubview:refreshControl];
    _collect.alwaysBounceVertical = YES;
}
-(void)topRefresh{
    
    NSLog(@"UIRefreshControl 一定要在UITableViewController里面使用，要在UIViewControll使用，只能这样写了");
    [self performSelector:@selector(delayDismiss) withObject:nil afterDelay:2];
}
-(void)delayDismiss{
    [_refreshControl  endRefreshing]; //停止刷新
}
@end
