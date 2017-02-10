//
//  EnterController.m
//  ChuckTableView
//
//  Created by 梁慧聪 on 2017/1/4.
//  Copyright © 2017年 liangdianxiong. All rights reserved.
//

#import "EnterController.h"
#import "ChuckTableView.h"
@interface EnterController ()<ChuckDelegate>

@end

@implementation EnterController
/**
 
 目的封装tableview,减少操作步骤
 
 减少数据操作上面的麻烦
 
 解耦，不与controller有太多联系
 
 section\row随意操作，不会数组越界
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    ChuckTableView* tableView = nil;
    tableView = [[ChuckTableView alloc]
                 initWithFrame:self.view.bounds
                 style:0
                 heightForRow:^CGFloat(id cell, id model, NSIndexPath *indexPath) {
                     if (indexPath.row==0) {
                         return 100;
                     }
                     return 60;
                 }
                 vcDelegate:self
                 configureBlock:^(UITableViewCell* cell, id model, NSIndexPath *indexPath) {
                     cell.textLabel.adjustsFontSizeToFitWidth = YES;
                     cell.textLabel.numberOfLines=0;
                     cell.textLabel.text = model;
                     
                 } cellDidselectConfig:^(id cell, id model, NSIndexPath *indexPath) {
                     //默认点击cell配置
                     NSLog(@"点击到了：%@",model);
                     if (indexPath.row!=0) {
                         UIViewController * vc = ( UIViewController *)[[NSClassFromString(model) alloc]init];
                         [self.navigationController pushViewController:vc animated:YES];
                     }
                     
                 }];
    
    [self.view addSubview:tableView];
    
    [tableView addModel:@"做这个库的目的就是为了快速搭建tableView,减少一些重复的操作，把操作简单化"];
    
    [tableView addModels:@[
                           @"ViewController",
                           @"SimpleController",
                           @"CollectController",
                           @"StarCardController",
                           @"ReviewController"
                           ]];
}

@end
