//
//  ViewController.m
//  ChuckTableView
//
//  Created by cong on 2016/10/28.
//  Copyright © 2016年 liangdianxiong. All rights reserved.
//

#import "ViewController.h"
#import "ChuckTableView.h"
#import "ChuckCell.h"
#import "XibAutpHeightCell.h"
@interface ViewController ()<ChuckDelegate>
@property(nonatomic,strong)ChuckTableView * tableView;

@property(nonatomic, strong) UITableViewController *tableViewController;
@end

@implementation ViewController

/**
 
 目的封装tableview,减少操作步骤
 
 减少数据操作上面的麻烦
 
 解耦，不与controller有太多联系
 
 section\row随意操作，不会数组越界
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:self.tableView];
    //1、不声明section，默认为0
    [self.tableView addModel:@"不声明section，默认为0" cellClass:ChuckCell.class];
    //2、自动检测是xib还是class文件，cell里面实现heightFoRow方法的以该方法对高度的优先级最高，xib默认自动计算高度
    [self.tableView addModel:@"自动检测是xib还是class文件，cell里面实现heightFoRow方法的以该方法对高度的优先级最高，xib默认自动计算高度" cellClass:XibAutpHeightCell.class];
    //3、支持编辑模式简化操作
//    [self.tableView addModels:@[@"左滑进入删除模式",
//                                @"左滑进入删除模式"]
//                    cellClass:ChuckCell.class editStyle:UITableViewCellEditingStyleDelete];
//    //4、支持多个model同时导入
//    [self.tableView addModels:@[
//                                @"左滑进入删除模式，支持多个model同时导入，任意指定section插入不回数组越界",
//                                @"左滑进入删除模式，支持多个model同时导入，任意指定section插入不回数组越界"]
//                    cellClass:XibAutpHeightCell.class section:3 editStyle:UITableViewCellEditingStyleDelete];
//    //5、指定相应的section，不会数组越界，会自动填充cell满足条件
//    [self.tableView addModel:@"自动检测是xib还是class文件，cell里面实现heightFoRow方法的以该方法对高度的优先级最高，xib默认自动计算高度" cellClass:ChuckCell.class section:5];
//    //6、不指定类型，默认为UItableViewCell
//    [self.tableView addModels:@[@"不指定类型，默认为UItableViewCell",@"不指定类型，默认为UItableViewCell"] section:2];
//    [self.tableView addModels:@[@"左滑进入删除模式，支持多个model同时导入，任意指定section插入不回数组越界",@"左滑进入删除模式，支持多个model同时导入，任意指定section插入不回数组越界"] cellClass:XibAutpHeightCell.class section:1 editStyle:UITableViewCellEditingStyleDelete];
//    [self.tableView addModel:@"自动检测是xib还是class文件，cell里面实现heightFoRow方法的以该方法对高度的优先级最高，xib默认自动计算高度" cellClass:ChuckCell.class section:10];
//    [self.tableView addModels:@[
//                                @"自动检测是xib还是class文件，cell里面实现heightFoRow方法的以该方法对高度的优先级最高，xib默认自动计算高度",
//                                @"自动检测是xib还是class文件，cell里面实现heightFoRow方法的以该方法对高度的优先级最高，xib默认自动计算高度",
//                                @"自动检测是xib还是class文件，cell里面实现heightFoRow方法的以该方法对高度的优先级最高，xib默认自动计算高度",
//                                @"自动检测是xib还是class文件，cell里面实现heightFoRow方法的以该方法对高度的优先级最高，xib默认自动计算高度"] cellClass:XibAutpHeightCell.class section:9];
//    [self.tableView addModel:@"ChuckCell" cellClass:ChuckCell.class];
//    [self.tableView addModels:@[@"左滑进入删除模式，支持多个model同时导入，任意指定section插入不回数组越界",@"左滑进入删除模式，支持多个model同时导入，任意指定section插入不回数组越界"] cellClass:ChuckCell.class editStyle:UITableViewCellEditingStyleDelete];
//    [self.tableView addModel:@"ChuckCell" cellClass:ChuckCell.class];
//    [self.tableView addModels:@[@"不指定类型，默认为UItableViewCell,任意指定section插入不回数组越界",
//                                @"不指定类型，默认为UItableViewCell,任意指定section插入不回数组越界"]
//                      section:2];
//    [self.tableView addModels:@[@"自动检测是xib还是class文件，cell里面实现heightFoRow方法的以该方法对高度的优先级最高，xib默认自动计算高度",@"自动检测是xib还是class文件，cell里面实现heightFoRow方法的以该方法对高度的优先级最高，xib默认自动计算高度"] cellClass:XibAutpHeightCell.class section:5];
//    [self.tableView addModel:@"自动检测是xib还是class文件，cell里面实现heightFoRow方法的以该方法对高度的优先级最高，xib默认自动计算高度" cellClass:XibAutpHeightCell.class];
//    [self.tableView addModel:@"ChuckCell" cellClass:ChuckCell.class section:10];
//    [self.tableView addModels:@[@"任意指定section插入不回数组越界",
//                                @"任意指定section插入不回数组越界",
//                                @"任意指定section插入不回数组越界",
//                                @"任意指定section插入不回数组越界",
//                                @"任意指定section插入不回数组越界"]
//                    cellClass:ChuckCell.class section:9];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.tableView.frame = self.view.bounds;
}
-(ChuckTableView *)tableView{
    if (!_tableView) {
        _tableView = [[ChuckTableView alloc]initWithFrame:self.view.bounds
                                                    style:0
                                             heightForRow:^CGFloat(id cell, id model, NSIndexPath *indexPath) {
                                                 return 100;
                                             }
                                               vcDelegate:self
                                           configureBlock:^(UITableViewCell* cell, id model, NSIndexPath *indexPath) {
                                               //默认cell配置
                                               if (![cell isMemberOfClass:[UITableViewCell class]]) {
                                                   return;
                                               }
                                               cell.detailTextLabel.text = model;
                                               cell.textLabel.text = model;
                                               cell.backgroundColor = [UIColor redColor];
                                           } cellDidselectConfig:nil];
        [self setNavigationItem];
        [self configTopRefresh];
    }
    return _tableView;
}





































-(UIView *)tableView:(ChuckTableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel *view = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    view.text = [NSString stringWithFormat:@"section - %ld",section];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}
-(CGFloat)tableView:(ChuckTableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
-(UIView *)tableView:(ChuckTableView *)tableView viewForFooterRefresh:(UITableViewCell *)cell{
    UIView * v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    lb.text = @"下载中";
    lb.textAlignment = NSTextAlignmentCenter;
    [v addSubview:lb];
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    //设置显示位置
    indicator.center = CGPointMake(v.center.x-50, v.center.y);
    [indicator startAnimating];
    
    indicator.color = [UIColor redColor];
    
    //将这个控件加到父容器中。
    [v addSubview:indicator];
    return v;
}


-(void)scrollViewDidScroll:(ChuckTableView *)tableView{
    if (tableView.contentOffset.y >= tableView.contentSize.height-tableView.frame.size.height - 20) {
        [self performSelector:@selector(delayDismiss) withObject:nil afterDelay:2];
    }
}
-(void)delayDismiss{
    [self.tableView dismissFooterRefresh];
    [self.tableViewController.refreshControl  endRefreshing]; //停止刷新
}



-(void)doShouCang{
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    [self.tableView insertModel:@"我插, 自动滚到最后" cellClass:XibAutpHeightCell.class indexPath:indexPath animation:UITableViewRowAnimationLeft];
    [self.tableView scrollToBottomAnimationTime:1];
}
-(void)delShouCang{
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    [self.tableView removeIndexPath:indexPath animation:UITableViewRowAnimationRight];
}


-(void)configTopRefresh{
    self.tableViewController = [[UITableViewController alloc] init];
    self.tableViewController.tableView = _tableView;
    self.tableViewController.refreshControl = [[UIRefreshControl alloc] init];
    self.tableViewController.refreshControl.tintColor = [UIColor redColor]; //设置刷新控件的颜色
    self.tableViewController.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"]; //设置刷新控件显示的文字
    [self.tableViewController.refreshControl addTarget:self action:@selector(topRefresh) forControlEvents:UIControlEventValueChanged];
}
-(void)topRefresh{
    
    NSLog(@"UIRefreshControl 一定要在UITableViewController里面使用，要在UIViewControll使用，只能这样写了");
    [self performSelector:@selector(delayDismiss) withObject:nil afterDelay:2];
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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:vItems];
}


@end
