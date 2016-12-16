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
@property(nonatomic,strong)ChuckTableView * sd;

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
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self setNavigationItem];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _sd = [[ChuckTableView alloc]initWithFrame:self.view.bounds
                                         style:0
                                 defaultHeight:100
                                    vcDelegate:self
                                configureBlock:^(UITableViewCell* cell, id model, NSIndexPath *indexPath) {
                                    //默认cell配置
                                    if (![cell isMemberOfClass:[UITableViewCell class]]) {
                                        return;
                                    }
                                    cell.detailTextLabel.text = model;
                                    cell.textLabel.text = model;
                                    cell.backgroundColor = [UIColor grayColor];
                                } cellDidselectConfig:nil];
    [self.view addSubview:_sd];
    [self configTopRefresh];
    //自动高度
    [_sd addModel:@"我是XibAutpHeightCell，在s0,r0" cellClass:XibAutpHeightCell.class];
    [_sd addModel:@"我是XibAutpHeightCell，在s0,r1" cellClass:XibAutpHeightCell.class];
    [_sd addModels:@[@"我是删除模式,s0,r2",@"我是删除模式,s0,r3"] cellClass:XibAutpHeightCell.class editStyle:UITableViewCellEditingStyleDelete];
    [_sd addModel:@"haha2,s0,r4" cellClass:XibAutpHeightCell.class];
    [_sd addModels:@[@"我是删除模式,s3,r0",@"我是删除模式,s3,r1"] cellClass:XibAutpHeightCell.class section:3 editStyle:UITableViewCellEditingStyleDelete];
    [_sd addModel:@"我是XibAutpHeightCell，在s3,r2" cellClass:XibAutpHeightCell.class section:3];
    [_sd addModel:@"我是XibAutpHeightCell，在s0,r5" cellClass:XibAutpHeightCell.class];
    [_sd addModels:@[@"我在预设置里面,s2,r0",@"因为我是UItableViewCell,s2,r1"] section:2];
    [_sd addModels:@[@"我是XibAutpHeightCell，在s5,r0",@"我是XibAutpHeightCell，在s5,r1"] cellClass:XibAutpHeightCell.class section:5];
    [_sd addModels:@[@"我是XibAutpHeightCell，在s1,r0",@"我是XibAutpHeightCell，在s1,r1"] cellClass:XibAutpHeightCell.class section:1];
    [_sd addModels:@[@"我是删除模式,s1,r2",@"我是删除模式,s1,r3"] cellClass:XibAutpHeightCell.class section:1 editStyle:UITableViewCellEditingStyleDelete];
    [_sd addModel:@"我是XibAutpHeightCell，在s0,r6" cellClass:XibAutpHeightCell.class];
    [_sd addModel:@"我是XibAutpHeightCell，在s10,r0" cellClass:XibAutpHeightCell.class section:10];
    [_sd addModels:@[@"我是XibAutpHeightCell，在s9,r0",@"我是XibAutpHeightCell，在s9,r1",@"我是XibAutpHeightCell，在s9,r2",@"我是XibAutpHeightCell，在s9,r3",@"我是XibAutpHeightCell，在s9,r4"] cellClass:XibAutpHeightCell.class section:9];
    [_sd addModel:@"我是ChuckCell，在s0,r0" cellClass:ChuckCell.class];
    [_sd addModel:@"我是ChuckCell，在s0,r1" cellClass:ChuckCell.class];
    [_sd addModels:@[@"我是删除模式,s0,r2",@"我是删除模式,s0,r3"] cellClass:ChuckCell.class editStyle:UITableViewCellEditingStyleDelete];
    [_sd addModel:@"haha2,s0,r4" cellClass:ChuckCell.class];
    [_sd addModels:@[@"我是删除模式,s3,r0",@"我是删除模式,s3,r1"] cellClass:ChuckCell.class section:3 editStyle:UITableViewCellEditingStyleDelete];
    [_sd addModel:@"我是ChuckCell，在s3,r2" cellClass:ChuckCell.class section:3];
    [_sd addModel:@"我是ChuckCell，在s0,r5" cellClass:ChuckCell.class];
    [_sd addModels:@[@"我在预设置里面,s2,r0",@"因为我是UItableViewCell,s2,r1"] section:2];
    [_sd addModels:@[@"我是ChuckCell，在s5,r0",@"我是ChuckCell，在s5,r1"] cellClass:ChuckCell.class section:5];
    [_sd addModels:@[@"我是ChuckCell，在s1,r0",@"我是ChuckCell，在s1,r1"] cellClass:ChuckCell.class section:1];
    [_sd addModels:@[@"我是删除模式,s1,r2",@"我是删除模式,s1,r3"] cellClass:ChuckCell.class section:1 editStyle:UITableViewCellEditingStyleDelete];
    [_sd addModel:@"我是ChuckCell，在s0,r6" cellClass:ChuckCell.class];
    [_sd addModel:@"我是ChuckCell，在s10,r0" cellClass:ChuckCell.class section:10];
    [_sd addModels:@[@"我是ChuckCell，在s9,r0",@"我是ChuckCell，在s9,r1",@"我是ChuckCell，在s9,r2",@"我是ChuckCell，在s9,r3",@"我是ChuckCell，在s9,r4"] cellClass:ChuckCell.class section:9];
    
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
    [_sd dismissFooterRefresh];
    [self.tableViewController.refreshControl  endRefreshing]; //停止刷新
}

-(void)doShouCang{
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:11];
    [_sd insertModel:@"我插, 自动滚到最后" cellClass:XibAutpHeightCell.class indexPath:indexPath animation:UITableViewRowAnimationLeft];
    [_sd scrollToBottomAnimationTime:1];
}
-(void)delShouCang{
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:11];
    [_sd removeIndexPath:indexPath animation:UITableViewRowAnimationRight];
}


-(void)configTopRefresh{
    self.tableViewController = [[UITableViewController alloc] init];
    self.tableViewController.tableView = _sd;
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
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:vItems];
    self.navigationItem.rightBarButtonItem = rightItem;
}
@end
