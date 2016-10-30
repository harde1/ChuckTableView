//
//  SmartDataSource.h
//  ChuckTableView
//
//  Created by cong on 2016/10/28.
//  Copyright © 2016年 liangdianxiong. All rights reserved.
//

#import <UIKit/UIKit.h>
//  实现的方法
#import "SmartDelegate.h"
#import <objc/objc.h>
#import "UITableViewCell+Smart.h"
#import "SmartModel.h"
typedef void (^CellConfigureBefore)(id cell, id model, NSIndexPath * indexPath);


IB_DESIGNABLE
@interface SmartTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style configureBlock:(CellConfigureBefore)before;
//--------- For StoryBoard
//@property (nonatomic, weak) IBInspectable UITableView *tableView;

@property (nonatomic, strong) IBInspectable NSString *cellIdentifier;

@property (nonatomic, copy) CellConfigureBefore cellConfigureBefore;

//---------Public
- (void)addModel:(id)model;
- (void)addModel:(id)model section:(NSInteger)section;

- (void)addModels:(NSArray *)models;
- (void)addModels:(NSArray *)models section:(NSInteger)section;
- (void)addModels:(NSArray *)models cellClass:(Class)cellClass section:(NSInteger)section;

- (void)addModel:(id)model cellClass:(Class)cellClass;
- (void)addModel:(id)model cellClass:(Class)cellClass section:(NSInteger)section;

-(void)addModel:(id)model cellClass:(Class)cellClass section:(NSInteger)section allowEdit:(BOOL)edit editStyle:(UITableViewCellEditingStyle)editStyle;

- (id)modelsAtIndexPath:(NSIndexPath *)indexPath;


@end
