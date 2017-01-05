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
@property(nonatomic,strong,nonnull) NSMutableArray *  collectViewConfig;
//存放model,chuckModel，chuckModel.model就是传进来的model
@property(nonatomic,strong,nonnull) NSMutableArray *  modelSource;
//header是什么用的
@property (nonatomic, weak,nullable)  id <ChuckDelegate> vcDelegate;
//上拉加载更多是否在显示
@property (nonatomic, assign) BOOL showFootRefresh;

//--------- For StoryBoard

@property (nonatomic, strong,nonnull) IBInspectable NSString *cellIdentifier;
@property (nonatomic, copy,nullable) CellConfigureBefore cellConfigureBefore;
@property (nonatomic, copy,nullable) CellDidselectConfigureBefore cellDidselectConfigBefore;
//@property (nonatomic, copy) HeadFootConfigureBefore headFootConfigureBefore;

- (id _Nonnull)initWithFrame:(CGRect)frame
collectionViewLayout:(UICollectionViewLayout * _Nullable)layout
         vcDelegate:(id<ChuckDelegate> _Nullable)delegate
     configureBlock:(CellConfigureBefore _Nullable)before
cellDidselectConfig:(CellDidselectConfigureBefore _Nullable)cellDidselectConfigBefore;
//headFootConfigureBefore:(HeadFootConfigureBefore) headFootConfigureBefore;
//获取元素
- (id _Nullable)modelsAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (ChuckModel * _Nullable)chuckModelAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
//清空所有数据
-(void)clearTableViewCell;
//section 0
- (void)addModel:(id _Nonnull)model;
- (void)addModels:(NSArray * _Nonnull)models;
- (void)addModel:(id _Nonnull)model cellClass:(Class _Nonnull)cellClass;
//section any
- (void)addModel:(id _Nonnull)model section:(NSInteger)section;
- (void)addModels:(NSArray * _Nonnull)models section:(NSInteger)section;
- (void)addModels:(NSArray * _Nonnull)models cellClass:(Class _Nonnull)cellClass section:(NSInteger)section;

//model base
- (void)addModel:(id _Nonnull)model cellClass:(Class _Nonnull)cellClass section:(NSInteger)section;

- (ChuckModel * _Nonnull)getModelAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
//---------插入
-(void)insertModel:(id _Nonnull)model cellClass:(Class _Nonnull)cellClass indexPath:(NSIndexPath * _Nonnull)indexPath completion:(void (^ __nullable)(BOOL finished))completion;
//---------删除模式
-(void)remove:(NSIndexPath  * _Nonnull )indexPath completion:(void (^ __nullable)(BOOL finished))completion;
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
