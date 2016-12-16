//
//  CollectController.m
//  ChuckTableView
//
//  Created by 梁慧聪 on 2016/11/30.
//  Copyright © 2016年 liangdianxiong. All rights reserved.
//

#import "CollectController.h"
#import "ChuckCollectionView.h"
#import "ChuckCCell.h"
#import "ChuckCRView.h"
#import "ChuckLayout.h"
@interface CollectController ()<ChuckDelegate>
@property(nonatomic,strong)ChuckCollectionView* collect;
@property(nonatomic,strong) UIRefreshControl *refreshControl;
@end

@implementation CollectController
/**
 布局的责任在于UICollectionViewLayout
 ChuckCollectionView只是用于数据组装的
 */
- (void)viewDidLoad {
    [super viewDidLoad];

    CGFloat mainScreenWidth = [UIScreen mainScreen].bounds.size.width;
    NSInteger per = 3;
    NSInteger perAdd = per+1;
    ChuckLayout * chuckLayout = [[ChuckLayout alloc]initItemSize:^CGSize(id model, NSInteger section) {
         //根据section返回cell大小
        if (section==0) {
            return (CGSize){mainScreenWidth - 10 - 10,50};
        }else if(section==1){
            return (CGSize){((mainScreenWidth - 10 - 10)-10*(per-1))/per,((mainScreenWidth - 10 - 10)-10)/per};
        }else{
            return (CGSize){((mainScreenWidth - 10 - 10)-10*(perAdd-1))/perAdd,((mainScreenWidth - 10 - 10)-10)/perAdd};
        }
    } interitemSpacingIndexPath:^CGFloat(id model, NSInteger section) {
        //根据section返回cell与cell间隔
        return 10;
    } lineSpacingIndexPath:^CGFloat(id model, NSInteger section) {
        //根据section返回行距
        return 10;
    } contentInsetIndexPath:^UIEdgeInsets(id model, NSInteger section) {
        //根据section返回内嵌
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }];

    ChuckCollectionView* collect =
    [[ChuckCollectionView alloc]
     initWithFrame:self.view.bounds
     collectionViewLayout:chuckLayout
     vcDelegate:self
     configureBlock:^(UICollectionViewCell *cell, id model, NSIndexPath *indexPath) {
         cell.backgroundColor = [UIColor redColor];
     } cellDidselectConfig:^(UICollectionViewCell *cell, id model, NSIndexPath *indexPath) {
         NSLog(@"点击到什么：%@",model);
     }];
    [self.view addSubview:collect];
    _collect = collect;
    collect.backgroundColor = [UIColor whiteColor];
    [collect addModel:@"hello world" cellClass:ChuckCCell.class];
    for (int i=0; i<2; i++) {
        [collect addModel:@"hello world"];
    }
    [collect addModel:@"hello world" cellClass:ChuckCCell.class];
    for (int i=0; i<3; i++) {
        [collect addModel:@"hello world" section:1];
    }
    for (int i=0; i<10; i++) {
        [collect addModel:@"hello world" section:2];
    }
    [self setNavigationItem];
    [self configTopRefresh];
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
    [self.collect addSubview:refreshControl];
    self.collect.alwaysBounceVertical = YES;
}
-(void)topRefresh{

    NSLog(@"UIRefreshControl 一定要在UITableViewController里面使用，要在UIViewControll使用，只能这样写了");
    [self performSelector:@selector(delayDismiss) withObject:nil afterDelay:2];
}
-(void)delayDismiss{
    [_refreshControl  endRefreshing]; //停止刷新
}
-(void)scrollViewDidScroll:(ChuckTableView *)tableView{
    if (tableView.contentOffset.y >= tableView.contentSize.height-tableView.frame.size.height - 20) {
        [self performSelector:@selector(delayDismiss) withObject:nil afterDelay:2];
    }
}
-(void)doShouCang{

    [_collect addModel:@"hello world"];
    [_collect reloadData];
}
-(void)delShouCang{
    
    
}
@end
