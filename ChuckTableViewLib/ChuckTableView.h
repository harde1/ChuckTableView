//
//  ChuckDataSource.h
//  ChuckTableView
//
//  Created by cong on 2016/10/28.
//  Copyright © 2016年 liangdianxiong. All rights reserved.
//

#import <UIKit/UIKit.h>
//  实现的方法
#import "ChuckDelegate.h"
#import <objc/objc.h>
#import "ChuckModel.h"
typedef void (^CellConfigureBefore)(id cell, id model, NSIndexPath * indexPath);
typedef void (^CellDidselectConfigureBefore)(id cell, id model, NSIndexPath * indexPath);
IB_DESIGNABLE
@interface ChuckTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
//存放注册的cell类型，字符串格式
@property(nonatomic,strong) NSMutableArray *tableViewConfig;
//存放model,chuckModel，chuckModel.model就是传进来的model
@property(nonatomic,strong) NSMutableArray *modelSource;
//不给高度时候的默认cell高度
@property (nonatomic, assign) CGFloat defaultHeight;
//header是什么用的
@property (nonatomic, weak) id<ChuckDelegate> vcDelegate;
//上拉加载更多是否在显示
@property (nonatomic, assign) BOOL showFootRefresh;

//--------- For StoryBoard

@property (nonatomic, strong) IBInspectable NSString *cellIdentifier;

@property (nonatomic, copy) CellConfigureBefore cellConfigureBefore;
@property (nonatomic, copy) CellDidselectConfigureBefore cellDidselectConfigBefore;


- (id)initWithFrame:(CGRect)frame
              style:(UITableViewStyle)style
      defaultHeight:(CGFloat)height
         vcDelegate:(id)delegate
     configureBlock:(CellConfigureBefore)before
cellDidselectConfig:(CellDidselectConfigureBefore)cellDidselectConfigBefore;

#pragma mark 常用APi
//获取元素
- (id)modelsAtIndexPath:(NSIndexPath *)indexPath;
- (ChuckModel *)chuckModelAtIndexPath:(NSIndexPath *)indexPath;
//清空所有数据
-(void)clearTableViewCell;
//滚动到最后,动画时间
-(void)scrollToBottomAnimationTime:(CGFloat)time;
//隐藏上拉加载更多
- (void)dismissFooterRefresh;

//--------增加一个model，等于增加一个cell
- (void)addModel:(id)model;

- (void)addModels:(NSArray *)models;

- (void)addModel:(id)model cellClass:(Class)cellClass;

- (void)addModel:(id)model section:(NSInteger)section;
- (void)addModels:(NSArray *)models section:(NSInteger)section;

- (void)addModel:(id)model cellClass:(Class)cellClass section:(NSInteger)section;
- (void)addModels:(NSArray *)models cellClass:(Class)cellClass section:(NSInteger)section;

//---------编辑模式
- (void)addModel:(id)model editStyle:(UITableViewCellEditingStyle)editStyle;
- (void)addModel:(id)model section:(NSInteger)section editStyle:(UITableViewCellEditingStyle)editStyle;
- (void)addModel:(id)model cellClass:(Class)cellClass editStyle:(UITableViewCellEditingStyle)editStyle;
- (void)addModel:(id)model cellClass:(Class)cellClass section:(NSInteger)section editStyle:(UITableViewCellEditingStyle)editStyle;
- (void)addModels:(NSArray *)models editStyle:(UITableViewCellEditingStyle)editStyle;
- (void)addModels:(NSArray *)models section:(NSInteger)section editStyle:(UITableViewCellEditingStyle)editStyle;
- (void)addModels:(NSArray *)models cellClass:(Class)cellClass editStyle:(UITableViewCellEditingStyle)editStyle;
- (void)addModels:(NSArray *)models cellClass:(Class)cellClass section:(NSInteger)section editStyle:(UITableViewCellEditingStyle)editStyle;
- (void)addModel:(id)model cellClass:(Class)cellClass section:(NSInteger)section allowEdit:(BOOL)edit editStyle:(UITableViewCellEditingStyle)editStyle;

//---------删除模式
-(void)removeIndexPath:(NSIndexPath *)indexPath animation:(UITableViewRowAnimation)animation;

//---------插入一个cell
//插入的意思，就是，
//1、在A与B之间插入一个C，变成ACB,
//2、或者在A前面插入一个C，变成CA，所以indexPath的下一个必须有值，
//3、插入越界的，不是插入，而是改变整个结构去兼容这个indexPath
-(void)insertModel:(id)model cellClass:(Class)cellClass indexPath:(NSIndexPath *)indexPath animation:(UITableViewRowAnimation)animation;
-(void)insertModel:(id)model cellClass:(Class)cellClass allowEdit:(BOOL)edit editStyle:(UITableViewCellEditingStyle)editStyle indexPath:(NSIndexPath *)indexPath  animation:(UITableViewRowAnimation)animation;


@end
