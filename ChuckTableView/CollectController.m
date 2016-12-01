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
@interface CollectController ()<ChuckDelegate>

@end

@implementation CollectController

- (void)viewDidLoad {
    [super viewDidLoad];

    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc]init];
    flow.minimumLineSpacing = 10;
    flow.itemSize = CGSizeMake((self.view.frame.size.width - 10 * 2 - 10)/2., (self.view.frame.size.width - 10 * 2 - 10)/2.);
    flow.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flow.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 40);
    flow.footerReferenceSize = CGSizeMake(self.view.frame.size.width, 40);

    ChuckCollectionView* sd =
    [[ChuckCollectionView alloc]
     initWithFrame:self.view.bounds
     collectionViewLayout:flow
     defaultHeadSize:CGSizeMake(self.view.frame.size.width, 100)
     defaultFootSize:CGSizeMake(self.view.frame.size.width, 100)
     vcDelegate:self
     configureBlock:^(UICollectionViewCell *cell, id model, NSIndexPath *indexPath) {
         cell.backgroundColor = [UIColor redColor];
     } cellDidselectConfig:^(UICollectionViewCell *cell, id model, NSIndexPath *indexPath) {
         NSLog(@"点击到什么：%@",model);
     }headFootConfigureBefore:^(UICollectionReusableView * view, id model, NSString *kind, NSUInteger section) {
         NSLog(@"headFootConfigureBefore点击到什么：%@",model);
         view.backgroundColor = [UIColor orangeColor];
     }];
    [self.view addSubview:sd];


     [sd addHeadModel:@"hello world"];
    sd.backgroundColor = [UIColor whiteColor];
    [sd addModel:@"hello world" cellClass:ChuckCCell.class];
    for (int i=0; i<20; i++) {
        [sd addModel:@"hello world"];
    }
    [sd addFootModel:@"hello world"];
    [sd addModel:@"hello world" cellClass:ChuckCCell.class];

}

@end
