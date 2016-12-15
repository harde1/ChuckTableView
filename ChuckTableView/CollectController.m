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
        if (section==0) {
            return (CGSize){mainScreenWidth - 10 - 10,50};
        }else if(section==1){
            return (CGSize){((mainScreenWidth - 10 - 10)-10*(per-1))/per,((mainScreenWidth - 10 - 10)-10)/per};
        }else{
            return (CGSize){((mainScreenWidth - 10 - 10)-10*(perAdd-1))/perAdd,((mainScreenWidth - 10 - 10)-10)/perAdd};
        }

    } interitemSpacingIndexPath:^CGFloat(id model, NSInteger section) {
        return 10;
    } lineSpacingIndexPath:^CGFloat(id model, NSInteger section) {
        return 10;
    } contentInsetIndexPath:^UIEdgeInsets(id model, NSInteger section) {
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }];

    ChuckCollectionView* sd =
    [[ChuckCollectionView alloc]
     initWithFrame:self.view.bounds
     collectionViewLayout:chuckLayout
     vcDelegate:self
     configureBlock:^(UICollectionViewCell *cell, id model, NSIndexPath *indexPath) {
         cell.backgroundColor = [UIColor redColor];
     } cellDidselectConfig:^(UICollectionViewCell *cell, id model, NSIndexPath *indexPath) {
         NSLog(@"点击到什么：%@",model);
     }];
    [self.view addSubview:sd];

    sd.backgroundColor = [UIColor whiteColor];
    [sd addModel:@"hello world" cellClass:ChuckCCell.class];
    for (int i=0; i<2; i++) {
        [sd addModel:@"hello world"];
    }
    [sd addModel:@"hello world" cellClass:ChuckCCell.class];
    for (int i=0; i<3; i++) {
        [sd addModel:@"hello world" section:1];
    }
    for (int i=0; i<10; i++) {
        [sd addModel:@"hello world" section:2];
    }
}
@end
