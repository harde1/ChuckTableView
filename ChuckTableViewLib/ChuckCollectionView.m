//
//  ChuckCollectionView.m
//  ChuckTableView
//
//  Created by 梁慧聪 on 2016/11/30.
//  Copyright © 2016年 liangdianxiong. All rights reserved.
//

#import "ChuckCollectionView.h"
#import "UICollectionViewCell+Chuck.h"
#import "UICollectionReusableView+Chuck.h"
#import "NSMutableArray+Chuck.h"
@implementation ChuckCollectionView

//基础配置
- (id)initWithFrame:(CGRect)frame
collectionViewLayout:(UICollectionViewLayout *)layout
         vcDelegate:(id<ChuckDelegate>)delegate
     configureBlock:(CellConfigureBefore)before
cellDidselectConfig:(CellDidselectConfigureBefore)cellDidselectConfigBefore
//headFootConfigureBefore:(HeadFootConfigureBefore) headFootConfigureBefore
{
    if(self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.cellConfigureBefore = [before copy];
        self.cellDidselectConfigBefore = [cellDidselectConfigBefore copy];
        //        self.headFootConfigureBefore = [headFootConfigureBefore copy];
        self.delegate = self;
        self.dataSource = self;
        self.vcDelegate = delegate;
        
        //添加对Account的监听
        [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        [self registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"footerRefresh"];
    }
    return self;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint p = [change[@"new"] CGPointValue];
        CGPoint op = [change[@"old"] CGPointValue];
        if (op.y < p.y) {
            //往下滚动
            CGFloat lastPageY = self.contentSize.height-self.frame.size.height;
            if (lastPageY - 20 < p.y && !self.showFootRefresh) {
                self.showFootRefresh = YES;
                [self reloadData];
            }
        }
    }
}
-(void)dealloc{
    [self removeObserver:self forKeyPath:@"contentOffset"];
}
-(NSMutableArray *)modelSource{
    if (!_modelSource) {
        _modelSource = [NSMutableArray array];
    }
    return _modelSource;
}
//自增量的sectionRow数组，添加元素，更改元素
//如果越界了就填充数据
-(void)ifBeyondSection:(NSInteger)section{
    //0 -->1
    if (section>=self.modelSource.count) {
        //填充足够的空数组
        for (NSInteger i=self.modelSource.count; i<section+1; i++) {
            [self.modelSource addObject:[[NSMutableArray alloc]init]];
        }
    }
}

#pragma mark -- 添加元素 --
//section 0
- (void)addModel:(id)model {
    [self addModel:model cellClass:UICollectionViewCell.class section:0];
}
- (void)addModels:(NSArray *)models {
    if(![models isKindOfClass:[NSArray class]]) return;
    for (id model in models) {
        [self addModel:model];
    }
}
- (void)addModel:(id)model cellClass:(Class)cellClass{
    if(!model||![cellClass isSubclassOfClass:[UICollectionViewCell class]]) return;
    [self addModel:model cellClass:cellClass section:0 allowEdit:NO editStyle:UITableViewCellEditingStyleNone];
}
//section any
- (void)addModel:(id)model section:(NSInteger)section{
    [self addModel:model cellClass:UICollectionViewCell.class section:section];
}
- (void)addModels:(NSArray *)models section:(NSInteger)section{
    if(![models isKindOfClass:[NSArray class]]) return;
    for (id model in models) {
        [self addModel:model section:section];
    }
}
- (void)addModels:(NSArray *)models cellClass:(Class)cellClass section:(NSInteger)section{
    if(![models isKindOfClass:[NSArray class]]) return;
    for (id model in models) {
        [self addModel:model cellClass:cellClass section:section];
    }
}

//添加元素 -- start
- (void)addModel:(id)model cellClass:(Class)cellClass section:(NSInteger)section{
    if(!model||![cellClass isSubclassOfClass:[UICollectionViewCell class]]) return;
    [self addModel:model cellClass:cellClass section:section allowEdit:NO editStyle:UITableViewCellEditingStyleNone];
}
//添加元素 -- final
-(void)addModel:(id)model cellClass:(Class)cellClass section:(NSInteger)section allowEdit:(BOOL)edit editStyle:(UITableViewCellEditingStyle)editStyle{
    if(!model||![cellClass isSubclassOfClass:[UICollectionViewCell class]]) return;
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForItem:[self numberOfRowsAtSection:section] inSection:section];
    
    [self storeModel:model cellClass:cellClass allowEdit:edit editStyle:editStyle indexPath:indexPath];
}
//保存model
- (void)storeModel:(id)model cellClass:(Class)cellClass allowEdit:(BOOL)edit editStyle:(UITableViewCellEditingStyle)editStyle indexPath:(NSIndexPath *)indexPath{
    if(!model||![cellClass isSubclassOfClass:[UICollectionViewCell class]]) return;
    
    //保存model
    ChuckModel * chuckModel = [self configModel:model cellClass:cellClass allowEdit:edit editStyle:editStyle indexPath:indexPath];
    [self upSertModel:chuckModel indexPath:indexPath];
    
    //注册cell
    if (![self.config containsObject:NSStringFromClass(cellClass)]) {
        [self.config addObject:NSStringFromClass(cellClass)];
        [self registerCell:cellClass];
    }
    
}
#pragma -- model操作 --
//model - 插入或者更新model
-(void)upSertModel:(ChuckModel *)chuckModel indexPath:(NSIndexPath *)indexPath{
    if (![indexPath isKindOfClass:[NSIndexPath class]]) return;
    [self ifBeyondSection:indexPath.section];
    if (indexPath.item>=[self.modelSource[indexPath.section] count]) {
        //填充足够的空ChuckModel,
        for (NSInteger i=[self.modelSource[indexPath.section] count]; i<indexPath.item; i++) {
            [self.modelSource[indexPath.section] addObject:[[ChuckModel alloc]initEmptyIndexPath:chuckModel.indexPath]];
        }
        [self.modelSource[indexPath.section] addObject:chuckModel];
        return;
    }
    self.modelSource[indexPath.section][indexPath.item] = chuckModel;
}
//model
- (ChuckModel*)configModel:(id)model cellClass:(Class)cellClass allowEdit:(BOOL)edit editStyle:(UITableViewCellEditingStyle)editStyle indexPath:(NSIndexPath *)indexPath{
    return [[ChuckModel alloc]initWithModel:model cellClass:cellClass allowEdit:edit editStyle:editStyle indexPath:indexPath];
}
- (ChuckModel *)getModelAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.modelSource count]>indexPath.section) {
        if ([self.modelSource[indexPath.section] count]>indexPath.item) {
            return self.modelSource[indexPath.section][indexPath.item];
        }
    }
    return [[ChuckModel alloc] initEmptyIndexPath:indexPath];
}
-(HeadFootModel *)getHeadFootModelAtSection:(NSUInteger)section kind:(NSString *)kind{
    return  [kind isEqualToString:UICollectionElementKindSectionFooter]?[self getFootModelAtSection:section]:[self getHeadModelAtSection:section];
}
- (HeadFootModel *)getHeadModelAtSection:(NSUInteger)section{
    NSMutableArray * arr = self.modelSource[section];
    if (!arr.headModel) {
        arr.headModel = [[HeadFootModel alloc] initEmptySection:section];
        //注册cell
        if (![self.config containsObject:@"UICollectionReusableView"]) {
            [self.config addObject:@"UICollectionReusableView"];
            [self registerHeadFootCell:UICollectionReusableView.class isFoot:NO];
        }
    }
    return [self.modelSource[section] headModel];
}
- (HeadFootModel *)getFootModelAtSection:(NSUInteger)section{
    NSMutableArray * arr = self.modelSource[section];
    
    if (!arr.footModel) {
        arr.footModel = [[HeadFootModel alloc] initEmptySection:section];
        //注册cell
        if (![self.config containsObject:@"UICollectionReusableView"]) {
            [self.config addObject:@"UICollectionReusableView"];
            [self registerHeadFootCell:UICollectionReusableView.class isFoot:YES];
        }
    }
    return [self.modelSource[section] footModel];
}
//注册cell
-(void)registerCell:(Class)cellClass{
    NSString * nibpath =  [[NSBundle mainBundle] pathForResource:NSStringFromClass(cellClass) ofType:@"nib"];
    if ([nibpath isKindOfClass:[NSString class]]) {
        [self registerNib:[UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
    }else{
        [self registerClass:cellClass forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
    }
}
-(void)registerHeadFootCell:(Class)cellClass isFoot:(BOOL)isFoot{
    if (![cellClass isSubclassOfClass:[UICollectionReusableView class]]) {
        return;
    }
    NSString * nibpath =  [[NSBundle mainBundle] pathForResource:NSStringFromClass(cellClass) ofType:@"nib"];
    if ([nibpath isKindOfClass:[NSString class]]) {
        [self registerNib:[UINib nibWithNibName:NSStringFromClass(cellClass)  bundle:nil]forSupplementaryViewOfKind:isFoot?UICollectionElementKindSectionFooter:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(cellClass)];
    }else{
        [self registerClass:cellClass forSupplementaryViewOfKind:isFoot?UICollectionElementKindSectionFooter:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(cellClass)];
    }
}
-(NSInteger)numberOfRowsAtSection:(NSInteger)section{
    [self ifBeyondSection:section];
    return [self.modelSource[section] count];
}
-(NSInteger)numberOfSection{
    return self.modelSource.count;
}
#pragma mark collectionViewHead&foot
//section 0
- (void)addHeadModel:(id)model{
    [self addHeadModel:model cellClass:UICollectionReusableView.class section:0];
}
- (void)addHeadModels:(NSArray *)models{
    if(![models isKindOfClass:[NSArray class]]) return;
    for (id model in models) {
        [self addHeadModel:model];
    }
}
- (void)addHeadModel:(id)model cellClass:(Class)cellClass{
    if(!model||![cellClass isSubclassOfClass:[UICollectionReusableView class]]) return;
    [self addHeadFootModel:model cellClass:cellClass section:0 isFoot:NO editStyle:UITableViewCellEditingStyleNone];
}
//section any
- (void)addHeadModel:(id)model section:(NSInteger)section{
    [self addHeadModel:model cellClass:UICollectionReusableView.class section:section];
}
- (void)addHeadModels:(NSArray *)models section:(NSInteger)section{
    if(![models isKindOfClass:[NSArray class]]) return;
    for (id model in models) {
        [self addHeadModel:model section:0];
    }
}
- (void)addHeadModels:(NSArray *)models cellClass:(Class)cellClass section:(NSInteger)section{
    if(![models isKindOfClass:[NSArray class]]) return;
    for (id model in models) {
        [self addHeadModel:model cellClass:cellClass section:section];
    }
}


//section 0
- (void)addFootModel:(id)model{
    [self addFootModel:model cellClass:UICollectionReusableView.class section:0];
}
- (void)addFootModels:(NSArray *)models{
    if(![models isKindOfClass:[NSArray class]]) return;
    for (id model in models) {
        [self addFootModel:model];
    }
}
- (void)addFootModel:(id)model cellClass:(Class)cellClass{
    if(!model||![cellClass isSubclassOfClass:[UICollectionReusableView class]]) return;
    [self addHeadFootModel:model cellClass:cellClass section:0 isFoot:YES editStyle:UITableViewCellEditingStyleNone];
}
//section any
- (void)addFootModel:(id)model section:(NSInteger)section{
    [self addFootModel:model cellClass:UICollectionReusableView.class section:section];
}
- (void)addFootModels:(NSArray *)models section:(NSInteger)section{
    if(![models isKindOfClass:[NSArray class]]) return;
    for (id model in models) {
        [self addFootModel:model section:0];
    }
}
- (void)addFootModels:(NSArray *)models cellClass:(Class)cellClass section:(NSInteger)section{
    if(![models isKindOfClass:[NSArray class]]) return;
    for (id model in models) {
        [self addFootModel:model cellClass:cellClass section:section];
    }
}


//添加head元素 -- start
- (void)addHeadModel:(id)model cellClass:(Class)cellClass section:(NSInteger)section{
    if(!model||![cellClass isSubclassOfClass:[UICollectionReusableView class]]) return;
    [self addHeadFootModel:model cellClass:cellClass section:section isFoot:NO editStyle:UITableViewCellEditingStyleNone];
}
- (void)addFootModel:(id)model cellClass:(Class)cellClass section:(NSInteger)section{
    if(!model||![cellClass isSubclassOfClass:[UICollectionReusableView class]]) return;
    [self addHeadFootModel:model cellClass:cellClass section:section isFoot:YES editStyle:UITableViewCellEditingStyleNone];
}
//添加head元素 -- final
-(void)addHeadFootModel:(id)model cellClass:(Class)cellClass section:(NSInteger)section isFoot:(BOOL)isFoot editStyle:(UITableViewCellEditingStyle)editStyle{
    if(!model||![cellClass isSubclassOfClass:[UICollectionReusableView class]]) return;
    [self ifBeyondSection:section];//扩充大小
    [self storeHeadModel:model cellClass:cellClass isFoot:isFoot editStyle:editStyle section:section];
}
//保存model
- (void)storeHeadModel:(id)model cellClass:(Class)cellClass isFoot:(BOOL)isFoot editStyle:(UITableViewCellEditingStyle)editStyle section:(NSUInteger)section{
    if(!model||![cellClass isSubclassOfClass:[UICollectionReusableView class]]) return;
    
    //保存model
    NSMutableArray * chuckMutableArray = self.modelSource[section];
    if (isFoot) {
        if (chuckMutableArray.footModel&&section==0) {
            
            [self addHeadFootModel:model cellClass:cellClass section:self.modelSource.count isFoot:isFoot editStyle:editStyle];
            return;
        }
        chuckMutableArray.footModel = [[HeadFootModel alloc]initWithHeadFootModel:model
                                                                        cellClass:cellClass
                                                                             kind:UICollectionElementKindSectionFooter
                                                                        editStyle:editStyle
                                                                          section:section];
    }else{
        if (chuckMutableArray.headModel&&section==0) {
            [self addHeadFootModel:model cellClass:cellClass section:self.modelSource.count isFoot:isFoot editStyle:editStyle];
            return;
        }
        chuckMutableArray.headModel = [[HeadFootModel alloc]initWithHeadFootModel:model
                                                                        cellClass:cellClass
                                                                             kind:UICollectionElementKindSectionHeader
                                                                        editStyle:editStyle
                                                                          section:section];
    }
    
    
    //注册cell
    if (![self.config containsObject:NSStringFromClass(cellClass)]) {
        [self.config addObject:NSStringFromClass(cellClass)];
        [self registerHeadFootCell:cellClass isFoot:isFoot];
    }
    
}
#pragma mark UICollectionViewDataSource
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellforChuckModel:(ChuckModel *)chuckModel forIndexPath:(NSIndexPath *)indexPath{
    //    NSString * footerRefresh = @"footerRefresh";
    //    UIView * refresh =  [self ifExistFooterRefresh:indexPath];
    //    if (refresh) {
    //        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:footerRefresh forIndexPath:indexPath];
    //        cell.contentView.backgroundColor = [UIColor clearColor];
    //        [cell.contentView addSubview:refresh];
    //
    //        return cell;
    //    }
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:chuckModel.identifier forIndexPath:indexPath];
    return cell;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView reusableViewforHeadFootModel:(HeadFootModel *)headFootModel section:(NSUInteger)section{
    
    UICollectionReusableView *view =
    [collectionView dequeueReusableSupplementaryViewOfKind:headFootModel.kind
                                       withReuseIdentifier:headFootModel.identifier
                                              forIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
    return view;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [self numberOfSection];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //    if (section+1 == [self numberOfSection]) {
    //        UIView * refresh = [self getRefreshView];
    //        if (refresh) {
    //            return [self numberOfRowsAtSection:section]+1;
    //        }
    //    }
    return [self numberOfRowsAtSection:section];
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //normal cell
    ChuckModel *chuckModel = [self getModelAtIndexPath:indexPath];
    UICollectionViewCell *cell = [self collectionView:collectionView cellforChuckModel:chuckModel forIndexPath:indexPath];
    id model = chuckModel.model;
    
    if(self.cellConfigureBefore) {
        self.cellConfigureBefore(cell, model,indexPath);
    }
    if ([cell respondsToSelector:@selector(collectionView:vcDelegate:cellForRowWithModel:atIndexPath:)]) {
        [cell collectionView:self vcDelegate:self.vcDelegate cellForRowWithModel:model atIndexPath:indexPath];
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    HeadFootModel * headFootModel = [self getHeadFootModelAtSection:indexPath.section kind:kind];
    UICollectionReusableView *view = [self collectionView:collectionView reusableViewforHeadFootModel:headFootModel section:indexPath.section];
    id model = headFootModel.model;
    //    if(self.headFootConfigureBefore&&model) {
    //        self.headFootConfigureBefore(view, model,kind,indexPath.section);
    //    }
    if ([view respondsToSelector:@selector(collectionView:vcDelegate:model:viewForSupplementaryElementOfKind:atIndexPath:)]&&headFootModel.model) {
        [view collectionView:self vcDelegate:self.vcDelegate model:model viewForSupplementaryElementOfKind:kind atIndexPath:indexPath];
    }
    return view;
}
////返回头headerView的大小
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    CGSize size=CGSizeZero;
//    HeadFootModel * headFootModel = [self getHeadFootModelAtSection:section kind:UICollectionElementKindSectionHeader];
//    if (!headFootModel.model) {
//        return size;
//    }
//    if ([self.vcDelegate respondsToSelector:@selector(collectionView:layout:referenceSizeForKind:model:inSection:)]) {
//        return  [self.vcDelegate collectionView:self layout:collectionViewLayout referenceSizeForKind:UICollectionElementKindSectionHeader model:headFootModel.model inSection:section];
//    }
//    return size;
//}
//////返回头footerView的大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    CGSize size=CGSizeZero;
//    HeadFootModel * headFootModel = [self getHeadFootModelAtSection:section kind:UICollectionElementKindSectionFooter];
//    if (!headFootModel.model) {
//        return size;
//    }
//    if ([self.vcDelegate respondsToSelector:@selector(collectionView:layout:referenceSizeForKind:model:inSection:)]) {
//        return  [self.vcDelegate collectionView:self layout:collectionViewLayout referenceSizeForKind:UICollectionElementKindSectionFooter model:headFootModel.model inSection:section];
//    }
//    return size;
//}
#pragma mark -- UICollectionViewDelegate --
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //    if ([self ifExistFooterRefresh:indexPath]) {
    //        return;
    //    }
    ChuckModel *chuckModel = [self getModelAtIndexPath:indexPath];
    UICollectionViewCell *cell = [self collectionView:collectionView cellforChuckModel:chuckModel forIndexPath:indexPath];
    if(self.cellDidselectConfigBefore) {
        self.cellDidselectConfigBefore(cell, chuckModel.model,indexPath);
    }
    if ([cell respondsToSelector:@selector(collectionView:vcDelegate:didSelectRowWithModel:atIndexPath:)]) {
        [cell collectionView:self vcDelegate:self.vcDelegate didSelectRowWithModel:chuckModel.model atIndexPath:indexPath];
    }
}
#pragma mark -- 上拉加载更多 ---
//-(UIView *)getRefreshView{
//    if (_showFootRefresh && _vcDelegate && [_vcDelegate respondsToSelector:@selector(collectionView:viewForFooterRefresh:)]) {
//        UIView * refresh = [_vcDelegate collectionView:self viewForFooterRefresh:nil];
//        return refresh;
//    }
//    return nil;
//}
//如果有上拉加载更多
//-(UIView *)ifExistFooterRefresh:(NSIndexPath *)indexPath{
//    if (indexPath.section+1 == [self numberOfSection] && indexPath.item == [self numberOfRowsAtSection:indexPath.section]) {
//        UIView * refresh = [self getRefreshView];
//        return refresh;
//    }
//    return nil;
//}

- (void)dismissFooterRefresh{
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismissFooter) object:nil];
    [self performSelector:@selector(dismissFooter) withObject:nil afterDelay:0.3];
}
- (void)dismissFooter{
    __weak typeof(self) wSelf = self;
    wSelf.showFootRefresh = NO;
    [wSelf reloadData];
}


#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_vcDelegate && [_vcDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [_vcDelegate scrollViewDidScroll:self];
    }
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView NS_AVAILABLE_IOS(3_2){
    if (_vcDelegate && [_vcDelegate respondsToSelector:@selector(scrollViewDidZoom:)]) {
        [_vcDelegate scrollViewDidZoom:self];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (_vcDelegate && [_vcDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [_vcDelegate scrollViewWillBeginDragging:self];
    }
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0){
    if (_vcDelegate && [_vcDelegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [_vcDelegate scrollViewWillEndDragging:self withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (_vcDelegate && [_vcDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [_vcDelegate scrollViewDidEndDragging:self willDecelerate:decelerate];
    }
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if (_vcDelegate && [_vcDelegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
        [_vcDelegate scrollViewWillBeginDecelerating:self];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (_vcDelegate && [_vcDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [_vcDelegate scrollViewDidEndDecelerating:self];
    }
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    if (_vcDelegate && [_vcDelegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
        [_vcDelegate scrollViewDidEndScrollingAnimation:self];
    }
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view NS_AVAILABLE_IOS(3_2){
    if (_vcDelegate && [_vcDelegate respondsToSelector:@selector(scrollViewWillBeginZooming:withView:)]) {
        [_vcDelegate scrollViewWillBeginZooming:self withView:view];
    }
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale{
    if (_vcDelegate && [_vcDelegate respondsToSelector:@selector(scrollViewDidEndZooming:withView:atScale:)]) {
        [_vcDelegate scrollViewDidEndZooming:self withView:view atScale:scale];
    }
}
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    
    if (_vcDelegate && [_vcDelegate respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
        [_vcDelegate scrollViewDidScrollToTop:self];
    }
}
-(void)insertModel:(id)model cellClass:(Class)cellClass indexPath:(NSIndexPath *)indexPath completion:(void (^ __nullable)(BOOL finished))completion{
    if(!model||![cellClass isSubclassOfClass:[UICollectionViewCell class]]) return;
    [self insertModel:model cellClass:cellClass allowEdit:NO editStyle:0 indexPath:indexPath completion:completion];
}
-(void)insertModel:(id)model cellClass:(Class)cellClass allowEdit:(BOOL)edit editStyle:(UITableViewCellEditingStyle)editStyle indexPath:(NSIndexPath *)indexPath  completion:(void (^ __nullable)(BOOL finished))completion{
    
    if(!model||![cellClass isSubclassOfClass:[UICollectionViewCell class]]) return;
    if (indexPath.section>=[self numberOfSection]) {
        NSLog(@"warning:----- Exception: removeIndexPath by indexPath ------");
        return;
    }
    if (indexPath.item>[self.modelSource[indexPath.section] count]) {
        NSLog(@"warning:----- Exception: removeIndexPath by indexPath ------");
        return;
    }
    ChuckModel * chuckModel = [self configModel:model cellClass:cellClass allowEdit:edit editStyle:editStyle indexPath:indexPath];
    //     [self ifBeyondSection:indexPath.section];
    //    if (indexPath.row>=[self.modelSource[indexPath.section] count]) {
    //        //填充足够的空ChuckModel,
    //        for (NSInteger i=[self.modelSource[indexPath.section] count]; i<indexPath.row; i++) {
    //            [self.modelSource[indexPath.section] addObject:[[ChuckModel alloc]initEmptyIndexPath:chuckModel.indexPath]];
    //        }
    //        //[self.modelSource[indexPath.section] addObject:chuckModel];
    //    }
    [self.modelSource[indexPath.section] insertObject:chuckModel atIndex:indexPath.row];
    if ([self.modelSource[indexPath.section] count]!=1) {
        [self performBatchUpdates:^{
            [self insertItemsAtIndexPaths:@[indexPath]];
        } completion:^(BOOL finished) {
            if (completion) {
                completion(YES);
            }
            [self delayAnimationReload];
        }];
    }
    [self changeIndexPath:[NSIndexPath indexPathForItem:indexPath.item+1 inSection:indexPath.section]];
    [self reloadData];
}
//---------删除模式
-(void)removeIndexPath:(NSIndexPath * _Nonnull)indexPath completion:(void (^__nullable)(BOOL finished))completion{
    //    __weak typeof(self) wSelf = self;
    if (indexPath.section>=[self numberOfSection]) {
        NSLog(@"warning:----- Exception: removeIndexPath by indexPath ------");
        return;
    }
    if (indexPath.item>=[self.modelSource[indexPath.section] count]) {
        NSLog(@"warning:----- Exception: removeIndexPath by indexPath ------");
        return;
    }
    
    [self ifBeyondSection:indexPath.section];
    if (indexPath.item>=[self.modelSource[indexPath.section] count]) {
        //填充足够的空ChuckModel,
        for (NSInteger i=[self.modelSource[indexPath.section] count]; i<indexPath.item+1; i++) {
            [self.modelSource[indexPath.section] addObject:[[ChuckModel alloc]initEmptyIndexPath:indexPath]];
        }
    }
    [self.modelSource[indexPath.section] removeObjectAtIndex:indexPath.item];
    [self changeIndexPath:[NSIndexPath indexPathForRow:indexPath.item-1 inSection:indexPath.section]];
    [self performBatchUpdates:^{
        [self deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        if (completion) {
            completion(YES);
        }
        [self delayAnimationReload];
    }];
    
}
-(void)removeSection:(NSUInteger)section completion:(void (^ __nullable)(BOOL finished))completion{
    if (section>=[self numberOfSection]) {
        NSLog(@"warning:----- Exception: removeIndexPath by indexPath ------");
        return;
    }
    //    __weak typeof(self) wSelf = self;
    [self ifBeyondSection:section];
    [self.modelSource removeObjectAtIndex:section];
    [self changeSection:section];
    
    [self performBatchUpdates:^{
        [self deleteSections:[NSIndexSet indexSetWithIndex:section]];
    } completion:^(BOOL finished) {
        if (completion) {
            completion(YES);
        }
    }];
}
-(void)replaceSection:(NSUInteger)section models:(NSArray *_Nonnull)models cellClass:(Class)cellClass completion:(void (^ __nullable)(BOOL finished))completion{
    if (section>=[self numberOfSection]) {
        NSLog(@"warning:----- Exception: removeIndexPath by indexPath ------");
        return;
    }
    if (![models isKindOfClass:[NSArray class]]) {
        
        return;
    }
    if (models.count==0) {
        return;
    }
    //    __weak typeof(self) wSelf = self;
    [self ifBeyondSection:section];
    NSMutableArray * arr = [[NSMutableArray alloc]initWithCapacity:models.count];
    int i=0;
    for (id model in models) {
        ChuckModel * chuckModel = [self configModel:model cellClass:cellClass allowEdit:NO editStyle:0 indexPath:[NSIndexPath indexPathForItem:i++ inSection:section]];
        [arr addObject:chuckModel];
    }
    
    [self.modelSource insertObject:arr atIndex:section];
    [self.modelSource removeObjectAtIndex:section+1];
    [self changeSection:section];
    
    [self performBatchUpdates:^{
        //        [self reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(section, section+1)]];
        [self reloadSections:[NSIndexSet indexSetWithIndex:section]];
    } completion:^(BOOL finished) {
        if (completion) {
            completion(YES);
        }
    }];
}
-(void)removeSectionRange:(NSRange)range completion:(void (^ __nullable)(BOOL finished))completion{
    if (range.length>=[self numberOfSection]) {
        NSLog(@"warning:----- Exception: removeIndexPath by indexPath ------");
        return;
    }
    //    __weak typeof(self) wSelf = self;
    [self ifBeyondSection:range.length];
    [self.modelSource removeObjectsInRange:range];
    //删除的救在原地处理
    [self changeSection:range.location];
    [self performBatchUpdates:^{
        [self deleteSections:[NSIndexSet indexSetWithIndexesInRange:range]];
    } completion:^(BOOL finished) {
        if (completion) {
            completion(YES);
        }
    }];
}
-(void)changeIndexPath:(NSIndexPath *)indexPath{
    //修改它之后的所有cell的row+1
    for (NSInteger i=indexPath.row; i<[self.modelSource[indexPath.section] count]; i++) {
        NSIndexPath * ni = [NSIndexPath indexPathForItem:i inSection:indexPath.section];
        ChuckModel * chuckModel = [self chuckModelAtIndexPath:ni];
        chuckModel.indexPath = ni;
    }
}
-(void)changeSection:(NSUInteger)section{
    //修改它之后的所有cell的row+1
    for (NSInteger i=section; i<[self.modelSource count]; i++) {
        
        NSIndexPath * ni = [NSIndexPath indexPathForRow:0 inSection:i];
        [self changeIndexPath:ni];
    }
}
- (ChuckModel *)chuckModelAtIndexPath:(NSIndexPath *)indexPath {
    return [self getModelAtIndexPath:indexPath];
}
-(void)delayAnimationReload{
    //    __weak typeof(self) wSelf = self;
    //    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0/*延迟执行时间*/ * NSEC_PER_SEC));
    //    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
    //        [wSelf reloadData];
    //    });
}
@end
