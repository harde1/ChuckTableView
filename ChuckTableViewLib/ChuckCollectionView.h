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
@property (nonatomic, copy) CellConfigureBefore cellConfigureBefore;
@property (nonatomic, copy) CellDidselectConfigureBefore cellDidselectConfigBefore;
//@property (nonatomic, copy) HeadFootConfigureBefore headFootConfigureBefore;

- (id)initWithFrame:(CGRect)frame
collectionViewLayout:(UICollectionViewLayout *)layout
         vcDelegate:(id<ChuckDelegate>)delegate
     configureBlock:(CellConfigureBefore)before
cellDidselectConfig:(CellDidselectConfigureBefore)cellDidselectConfigBefore;
//headFootConfigureBefore:(HeadFootConfigureBefore) headFootConfigureBefore;
//获取元素
- (id)modelsAtIndexPath:(NSIndexPath *)indexPath;
- (ChuckModel *)chuckModelAtIndexPath:(NSIndexPath *)indexPath;
//清空所有数据
-(void)clearTableViewCell;
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

- (ChuckModel *)getModelAtIndexPath:(NSIndexPath *)indexPath;
//---------插入
-(void)insertModel:(id)model cellClass:(Class)cellClass indexPath:(NSIndexPath *)indexPath completion:(void (^ __nullable)(BOOL finished))completion;
//---------删除模式
-(void)removeIndexPath:(NSIndexPath * _Nonnull)indexPath completion:(void (^__nullable)(BOOL finished))completion;
-(void)removeSection:(NSUInteger)section completion:(void (^ __nullable)(BOOL finished))completion;
//删除什么section到什么section 1-2 ，包含1和2
-(void)removeSectionRange:(NSRange)range completion:(void (^ __nullable)(BOOL finished))completion;
//---------替换模式
-(void)replaceSection:(NSUInteger)section models:(NSArray * _Nonnull)models cellClass:(_Nonnull Class)cellClass completion:(void (^ __nullable)(BOOL finished))completion;

//-(UIView *)ifExistFooterRefresh:(NSIndexPath *)indexPath;
//-(UIView *)getRefreshView;
//隐藏上拉加载更多
//- (void)dismissFooterRefresh;
//所有关于头和脚的都用cell来完成，下面的代码废弃
//#pragma mark collectionViewHead&foot
////section 0
//- (void)addHeadModel:(id)model;
//- (void)addHeadModels:(NSArray *)models;
//- (void)addHeadModel:(id)model cellClass:(Class)cellClass;
////section any
//- (void)addHeadModel:(id)model section:(NSInteger)section;
//- (void)addHeadModels:(NSArray *)models section:(NSInteger)section;
//- (void)addHeadModels:(NSArray *)models cellClass:(Class)cellClass section:(NSInteger)section;
////section 0
//- (void)addFootModel:(id)model;
//- (void)addFootModels:(NSArray *)models;
//- (void)addFootModel:(id)model cellClass:(Class)cellClass;
////section any
//- (void)addFootModel:(id)model section:(NSInteger)section;
//- (void)addFootModels:(NSArray *)models section:(NSInteger)section;
//- (void)addFootModels:(NSArray *)models cellClass:(Class)cellClass section:(NSInteger)section;




@end
