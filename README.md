# ChuckTableView

高度封装tableView，简化操作

  1、容易操作的cell增删改查

  2、滚到最后

  3、可以自定义的上拉加载更多


# 例子

#初始化

- -(id)initWithFrame:(CGRect)frame
              style:(UITableViewStyle)style
      defaultHeight:(CGFloat)height
         vcDelegate:(id)delegate
     configureBlock:(CellConfigureBefore)before
cellDidselectConfig:(CellDidselectConfigureBefore)cellDidselectConfigBefore;

  初始化后，就配置了基础的默认cell高度，cell的UI与model的默认配置和点击配置

```

SmartTableView* sd = nil;

sd = [[SmartTableView alloc]

    initWithFrame:self.view.bounds

            style:0

    defaultHeight:60

      vcDelegate:self

  configureBlock:^(UITableViewCell* cell, id model, NSIndexPath *indexPath) {

    //默认cell配置

    if (![cell isMemberOfClass:[UITableViewCell class]]) {

    return;

    }

    cell.detailTextLabel.text = model;

    cell.textLabel.text = model;

    } cellDidselectConfig:^(id cell, id model, NSIndexPath *indexPath) {

    //默认点击cell配置

    NSLog(@"点击到了：%@",model);

}];

```

#导入数据model,一个model对应一个cell

 1、不指定cell类型，就默认采用UITableViewCell

-  [tableView addModel:@"我是XibAutpHeightCell，在s0,r0"];

-  [tableView addModel:@"我是XibAutpHeightCell，在s0,r0" cellClass:XibAutpHeightCell.class];

 2、随意指定插入的section,不用担心数组越界的问题

-  [tableView addModels:@[@"我在预设置里面,s2,r0",@"因为我是UItableViewCell,s2,r1"] section:2];

 3、编辑模式

-  [tableView addModels:@[@"我是删除模式,s0,r2",@"我是删除模式,s0,r3"] cellClass:XibAutpHeightCell.class editStyle:UITableViewCellEditingStyleDelete];

#事件逻辑，在cell的m文件中导入#import "UITableViewCell+Smart.h"

a、cellForRow事件，与tableView等同名事件操作一致

- -(void)tableView:(SmartTableView *)tableView vcDelegate:(id)vcDelegate cellForRowWithModel:(id)model atIndexPath:(NSIndexPath *)indexPath;

b、heightForRow事件，与tableView等同名事件操作一致，不设置在有约束情况下，自动计算高度，没有约束情况下，采用默认高度

- -(CGFloat)tableView:(SmartTableView *)tableView vcDelegate:(id)vcDelegate heightForRowWithModel:(id)model atIndexPath:(NSIndexPath *)indexPath;

c、didSelectRowWithModel事件，与tableView等同名事件操作一致

- -(void)tableView:(SmartTableView *)tableView vcDelegate:(id)vcDelegate didSelectRowWithModel:(id)model atIndexPath:(NSIndexPath *)indexPath;

d、编辑事件，与tableView等同名事件操作一致

- -(void)tableView:(SmartTableView *)tableView vcDelegate:(id)vcDelegate commitEditingWithModel:(id)model style:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

#自定义的上拉加载更多

- -(UIView *)tableView:(SmartTableView *)tableView viewForFooterRefresh:(UITableViewCell *)cell{

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

#常用APi
//获取元素

- -(id)modelsAtIndexPath:(NSIndexPath *)indexPath;

//获取到smartModel

- -(SmartModel *)smartModelAtIndexPath:(NSIndexPath *)indexPath;

//清空所有数据

- -(void)clearTableViewCell;

//滚动到最后,动画时间

- -(void)scrollToBottomAnimationTime:(CGFloat)time;

//隐藏上拉加载更多

- -(void)dismissFooterRefresh;


