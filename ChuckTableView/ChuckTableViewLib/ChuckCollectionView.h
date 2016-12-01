//
//  ChuckCollectionView.h
//  ChuckTableView
//
//  Created by 梁慧聪 on 2016/11/30.
//  Copyright © 2016年 liangdianxiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChuckDelegate.h"
#import "ChuckModel.h"
#import "HeadFootModel.h"

@interface ChuckCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource>
//存放注册的cell类型，字符串格式
@property(nonatomic,strong) NSMutableArray *config;
//存放model,chuckModel，chuckModel.model就是传进来的model
@property(nonatomic,strong) NSMutableArray *modelSource;
//header是什么用的
@property (nonatomic, weak) id<ChuckDelegate> vcDelegate;
//上拉加载更多是否在显示
@property (nonatomic, assign) BOOL showFootRefresh;

//--------- For StoryBoard

@property (nonatomic, strong) IBInspectable NSString *cellIdentifier;
@property (nonatomic,assign)CGSize headSize;
@property (nonatomic,assign)CGSize footSize;
@property (nonatomic, copy) CellConfigureBefore cellConfigureBefore;
@property (nonatomic, copy) CellDidselectConfigureBefore cellDidselectConfigBefore;
@property (nonatomic, copy) HeadFootConfigureBefore headFootConfigureBefore;

- (id)initWithFrame:(CGRect)frame
collectionViewLayout:(UICollectionViewLayout *)layout
    defaultHeadSize:(CGSize)headSize
defaultFootSize:(CGSize)footSize
         vcDelegate:(id<ChuckDelegate>)delegate
     configureBlock:(CellConfigureBefore)before
cellDidselectConfig:(CellDidselectConfigureBefore)cellDidselectConfigBefore
headFootConfigureBefore:(HeadFootConfigureBefore) headFootConfigureBefore;
//section 0
- (void)addModel:(id)model;
- (void)addModels:(NSArray *)models;
- (void)addModel:(id)model cellClass:(Class)cellClass;
//section any
- (void)addModel:(id)model section:(NSInteger)section;
- (void)addModels:(NSArray *)models section:(NSInteger)section;
- (void)addModels:(NSArray *)models cellClass:(Class)cellClass section:(NSInteger)section;

//model base
- (void)addModel:(id)model cellClass:(Class)cellClass section:(NSInteger)section;

#pragma mark collectionViewHead&foot
//section 0
- (void)addHeadModel:(id)model;
- (void)addHeadModels:(NSArray *)models;
- (void)addHeadModel:(id)model cellClass:(Class)cellClass;
//section any
- (void)addHeadModel:(id)model section:(NSInteger)section;
- (void)addHeadModels:(NSArray *)models section:(NSInteger)section;
- (void)addHeadModels:(NSArray *)models cellClass:(Class)cellClass section:(NSInteger)section;
//section 0
- (void)addFootModel:(id)model;
- (void)addFootModels:(NSArray *)models;
- (void)addFootModel:(id)model cellClass:(Class)cellClass;
//section any
- (void)addFootModel:(id)model section:(NSInteger)section;
- (void)addFootModels:(NSArray *)models section:(NSInteger)section;
- (void)addFootModels:(NSArray *)models cellClass:(Class)cellClass section:(NSInteger)section;
@end
