//
//  ChuckDataSource.m
//  ChuckTableView
//
//  Created by cong on 2016/10/28.
//  Copyright © 2016年 liangdianxiong. All rights reserved.
//

#import "ChuckTableView.h"
#import <objc/message.h>

#import "UITableViewCell+Chuck.h"
@interface ChuckTableView ()

@end
@implementation ChuckTableView
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
            [self.modelSource addObject:[NSMutableArray array]];
        }
    }
}
-(UIView *)getRefreshView{
    
    if (_showFootRefresh && _vcDelegate && [_vcDelegate respondsToSelector:@selector(tableView:viewForFooterRefresh:)]) {
        UIView * refresh = [_vcDelegate tableView:self viewForFooterRefresh:nil];
        return refresh;
    }
    return nil;
}
//如果有上拉加载更多
-(UIView *)ifExistFooterRefresh:(NSIndexPath *)indexPath{
    
    if (indexPath.section+1 == [self numberOfSection] && indexPath.row == [self numberOfRowsAtSection:indexPath.section]) {
        UIView * refresh = [self getRefreshView];
        return refresh;
    }
    return nil;
}
-(void)upSertModel:(ChuckModel *)chuckModel indexPath:(NSIndexPath *)indexPath{
    if (![indexPath isKindOfClass:[NSIndexPath class]]) return;
    [self ifBeyondSection:indexPath.section];
    if (indexPath.row>=[self.modelSource[indexPath.section] count]) {
        //填充足够的空ChuckModel,
        for (NSInteger i=[self.modelSource[indexPath.section] count]; i<indexPath.row; i++) {
            [self.modelSource[indexPath.section] addObject:[[ChuckModel alloc]initEmptyIndexPath:chuckModel.indexPath]];
        }
        [self.modelSource[indexPath.section] addObject:chuckModel];
        return;
    }
    self.modelSource[indexPath.section][indexPath.row] = chuckModel;
}

-(NSMutableArray *)tableViewConfig{
    if (!_tableViewConfig) {
        _tableViewConfig= [NSMutableArray array];
    }
    return _tableViewConfig;
}
//基础配置
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style defaultHeight:(CGFloat)height vcDelegate:(id)delegate configureBlock:(CellConfigureBefore)before cellDidselectConfig:(CellDidselectConfigureBefore)cellDidselectConfigBefore{
    if(self = [super initWithFrame:frame style:style]) {
        self.cellConfigureBefore = [before copy];
        self.cellDidselectConfigBefore = [cellDidselectConfigBefore copy];
        self.delegate = self;
        self.dataSource = self;
        self.defaultHeight = height;
        self.vcDelegate = delegate;
        
        //添加对Account的监听
        [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
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
//添加元素
- (void)addModel:(id)model {
    [self addModel:model cellClass:UITableViewCell.class];
}
- (void)addModel:(id)model section:(NSInteger)section{
    [self addModel:model cellClass:UITableViewCell.class section:section];
}
- (void)addModels:(NSArray *)models {
    if(![models isKindOfClass:[NSArray class]]) return;
    for (id model in models) {
        [self addModel:model];
    }
}
- (void)addModels:(NSArray *)models section:(NSInteger)section{
    if(![models isKindOfClass:[NSArray class]]) return;
    for (id model in models) {
        [self addModel:model section:section];
    }
}



- (void)addModel:(id)model cellClass:(Class)cellClass{
    if(!model||![cellClass isSubclassOfClass:[UITableViewCell class]]) return;
    [self addModel:model cellClass:cellClass section:0 allowEdit:NO editStyle:UITableViewCellEditingStyleNone];
}
- (void)addModel:(id)model cellClass:(Class)cellClass editStyle:(UITableViewCellEditingStyle)editStyle{
    if(!model||![cellClass isSubclassOfClass:[UITableViewCell class]]) return;
    [self addModel:model cellClass:cellClass section:0 allowEdit:YES editStyle:editStyle];
}
- (void)addModel:(id)model cellClass:(Class)cellClass section:(NSInteger)section{
    if(!model||![cellClass isSubclassOfClass:[UITableViewCell class]]) return;
    [self addModel:model cellClass:cellClass section:section allowEdit:NO editStyle:UITableViewCellEditingStyleNone];
}

- (void)addModels:(NSArray *)models cellClass:(Class)cellClass section:(NSInteger)section{
    if(![models isKindOfClass:[NSArray class]]) return;
    for (id model in models) {
        [self addModel:model cellClass:cellClass section:section];
    }
}




//------编辑模式
- (void)addModel:(id)model editStyle:(UITableViewCellEditingStyle)editStyle{
    [self addModel:model cellClass:UITableViewCell.class editStyle:editStyle];
}

- (void)addModels:(NSArray *)models editStyle:(UITableViewCellEditingStyle)editStyle{
    if(![models isKindOfClass:[NSArray class]]) return;
    for (id model in models) {
        [self addModel:model editStyle:editStyle];
    }
}
- (void)addModels:(NSArray *)models section:(NSInteger)section editStyle:(UITableViewCellEditingStyle)editStyle{
    if(![models isKindOfClass:[NSArray class]]) return;
    for (id model in models) {
        [self addModel:model section:section editStyle:editStyle];
    }
}
- (void)addModels:(NSArray *)models cellClass:(Class)cellClass section:(NSInteger)section editStyle:(UITableViewCellEditingStyle)editStyle{
    if(![models isKindOfClass:[NSArray class]]) return;
    for (id model in models) {
        [self addModel:model cellClass:cellClass section:section editStyle:editStyle];
    }
}
- (void)addModels:(NSArray *)models cellClass:(Class)cellClass editStyle:(UITableViewCellEditingStyle)editStyle{
    if(![models isKindOfClass:[NSArray class]]) return;
    for (id model in models) {
        [self addModel:model cellClass:cellClass section:0 editStyle:editStyle];
    }
}

- (void)addModel:(id)model section:(NSInteger)section editStyle:(UITableViewCellEditingStyle)editStyle{
    [self addModel:model cellClass:UITableViewCell.class section:section editStyle:editStyle];
}

- (void)addModel:(id)model cellClass:(Class)cellClass section:(NSInteger)section editStyle:(UITableViewCellEditingStyle)editStyle{
    if(!model||![cellClass isSubclassOfClass:[UITableViewCell class]]) return;
    [self addModel:model cellClass:cellClass section:section allowEdit:YES editStyle:editStyle];
}


//添加元素 -- final
-(void)addModel:(id)model cellClass:(Class)cellClass section:(NSInteger)section allowEdit:(BOOL)edit editStyle:(UITableViewCellEditingStyle)editStyle{
    if(!model||![cellClass isSubclassOfClass:[UITableViewCell class]]) return;
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:[self numberOfRowsAtSection:section] inSection:section];
    [self storeModel:model cellClass:cellClass allowEdit:edit editStyle:editStyle indexPath:indexPath];
}






//保存model
- (void)storeModel:(id)model cellClass:(Class)cellClass allowEdit:(BOOL)edit editStyle:(UITableViewCellEditingStyle)editStyle indexPath:(NSIndexPath *)indexPath{
    if(!model||![cellClass isSubclassOfClass:[UITableViewCell class]]) return;
    
    //保存model
    ChuckModel * chuckModel = [self configModel:model cellClass:cellClass allowEdit:edit editStyle:editStyle indexPath:indexPath];
    [self upSertModel:chuckModel indexPath:indexPath];
    
    //注册cell
    if (![self.tableViewConfig containsObject:NSStringFromClass(cellClass)]) {
        [self.tableViewConfig addObject:NSStringFromClass(cellClass)];
        [self registerCell:cellClass];
    }
    
}
//model
- (ChuckModel*)configModel:(id)model cellClass:(Class)cellClass allowEdit:(BOOL)edit editStyle:(UITableViewCellEditingStyle)editStyle indexPath:(NSIndexPath *)indexPath{
    return [[ChuckModel alloc]initWithModel:model cellClass:cellClass allowEdit:edit editStyle:editStyle indexPath:indexPath];
}

//注册cell
-(void)registerCell:(Class)cellClass{
    NSString * nibpath =  [[NSBundle mainBundle] pathForResource:NSStringFromClass(cellClass) ofType:@"nib"];
    if ([nibpath isKindOfClass:[NSString class]]) {
        [self registerNib:[UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil] forCellReuseIdentifier:NSStringFromClass(cellClass)];
    }else{
        [self registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
    }
}

-(NSInteger)numberOfRowsAtSection:(NSInteger)section{
    [self ifBeyondSection:section];
    return [self.modelSource[section] count];
}
-(NSInteger)numberOfSection{
    return self.modelSource.count;
}

- (ChuckModel *)getModelAtIndexPath:(NSIndexPath *)indexPath{
    return self.modelSource[indexPath.section][indexPath.row];
}

-(void)removeIndexPath:(NSIndexPath *)indexPath animation:(UITableViewRowAnimation)animation{
    if (indexPath.section>=[self numberOfSection]) {
        NSLog(@"warning:----- Exception: removeIndexPath by indexPath ------");
        return;
    }
    if (indexPath.row>=[self.modelSource[indexPath.section] count]) {
        NSLog(@"warning:----- Exception: removeIndexPath by indexPath ------");
        return;
    }
    
    [self ifBeyondSection:indexPath.section];
    if (indexPath.row>=[self.modelSource[indexPath.section] count]) {
        //填充足够的空ChuckModel,
        for (NSInteger i=[self.modelSource[indexPath.section] count]; i<indexPath.row+1; i++) {
            [self.modelSource[indexPath.section] addObject:[[ChuckModel alloc]initEmptyIndexPath:indexPath]];
        }
    }
    [self.modelSource[indexPath.section] removeObjectAtIndex:indexPath.row];
    [self beginUpdates];
    [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
    [self endUpdates];
    [self changeIndexPath:[NSIndexPath indexPathForRow:indexPath.row-1 inSection:indexPath.section]];
    if ([self.modelSource[indexPath.section] count]==0) {
        [self.modelSource removeLastObject];
    }
    [self delayAnimationReload];
    
}

-(void)changeIndexPath:(NSIndexPath *)indexPath{
    //修改它之后的所有cell的row+1
    for (NSInteger i=indexPath.row+1; i<[self.modelSource[indexPath.section] count]; i++) {
        NSIndexPath * ni = [NSIndexPath indexPathForRow:i inSection:indexPath.section];
        ChuckModel * chuckModel = [self chuckModelAtIndexPath:ni];
        chuckModel.indexPath = ni;
    }
}

//插入的意思，就是，
//1、在A与B之间插入一个C，变成ACB,
//2、或者在A前面插入一个C，变成CA，所以indexPath的下一个必须有值，
//3、插入越界的，不是插入，而是改变整个结构去兼容这个indexPath
-(void)insertModel:(id)model cellClass:(Class)cellClass indexPath:(NSIndexPath *)indexPath animation:(UITableViewRowAnimation)animation{
    if(!model||![cellClass isSubclassOfClass:[UITableViewCell class]]) return;
    [self insertModel:model cellClass:cellClass allowEdit:NO editStyle:UITableViewCellEditingStyleNone indexPath:indexPath animation:animation];
}
-(void)insertModel:(id)model cellClass:(Class)cellClass allowEdit:(BOOL)edit editStyle:(UITableViewCellEditingStyle)editStyle indexPath:(NSIndexPath *)indexPath  animation:(UITableViewRowAnimation)animation{
    
    if(!model||![cellClass isSubclassOfClass:[UITableViewCell class]]) return;
    
    ChuckModel * chuckModel = [self configModel:model cellClass:cellClass allowEdit:edit editStyle:editStyle indexPath:indexPath];
    [self ifBeyondSection:indexPath.section];
    if (indexPath.row>=[self.modelSource[indexPath.section] count]) {
        //填充足够的空ChuckModel,
        for (NSInteger i=[self.modelSource[indexPath.section] count]; i<indexPath.row; i++) {
            [self.modelSource[indexPath.section] addObject:[[ChuckModel alloc]initEmptyIndexPath:chuckModel.indexPath]];
        }
        //[self.modelSource[indexPath.section] addObject:chuckModel];
    }
    [self.modelSource[indexPath.section] insertObject:chuckModel atIndex:indexPath.row];
    if ([self.modelSource[indexPath.section] count]!=1) {
        [self beginUpdates];
        [self insertRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
        [self endUpdates];
    }
    [self changeIndexPath:indexPath];
    [self reloadData];
}


-(void)delayAnimationReload{
    __weak typeof(self) wSelf = self;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [wSelf reloadData];
    });
    //[wSelf reloadData];
}

#pragma mark UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellforChuckModel:(ChuckModel *)chuckModel forIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:chuckModel.identifier
                                                            forIndexPath:indexPath];
    if (!cell) {
        cell = [[NSClassFromString(chuckModel.identifier) alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:chuckModel.identifier];
    }
    return cell;
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self numberOfSection];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section+1 == [self numberOfSection]) {
        
        UIView * refresh = [self getRefreshView];
        if (refresh) {
            return [self numberOfRowsAtSection:section]+1;
        }
    }
    
    return [self numberOfRowsAtSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    __weak typeof(self) wSelf = self;
    //footer refresh cell
    NSString * footerRefresh = @"footerRefresh";
    UIView * refresh =  [self ifExistFooterRefresh:indexPath];
    if (refresh) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:footerRefresh];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:footerRefresh];
        }
        cell.contentView.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:refresh];
        
        return cell;
    }
    
    return [self tableView:tableView cellForIndexPath:indexPath];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForIndexPath:(NSIndexPath *)indexPath{
    
    
    //normal cell
    ChuckModel *chuckModel = [self getModelAtIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:chuckModel.identifier];
    if (!cell) {
        cell = [[NSClassFromString(chuckModel.identifier) alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:chuckModel.identifier];
    }
    
    id model = chuckModel.model;
    
    if(self.cellConfigureBefore) {
        self.cellConfigureBefore(cell, model,indexPath);
    }
    if ([cell respondsToSelector:@selector(tableView:vcDelegate:cellForRowWithModel:atIndexPath:)]) {
        [cell tableView:self vcDelegate:self.vcDelegate cellForRowWithModel:model atIndexPath:indexPath];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UIView * refresh = [self ifExistFooterRefresh:indexPath];
    if (refresh) {
        return refresh.frame.size.height;
    }
    UITableViewCell * cell =  [self tableView:tableView cellForIndexPath:indexPath];
    ChuckModel *chuckModel = [self getModelAtIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(tableView:vcDelegate:heightForRowWithModel:atIndexPath:)]) {
        return  [cell tableView:self vcDelegate:self.vcDelegate heightForRowWithModel:chuckModel.model atIndexPath:indexPath];
    }
    
    if (![cell isMemberOfClass:[UITableViewCell class]]) {
        [cell layoutIfNeeded];
        [cell updateConstraintsIfNeeded];
        CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        if (height==0) {
            return self.defaultHeight;
        }
        return height;
    }
    
    return self.defaultHeight;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (_vcDelegate && [_vcDelegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        return  [_vcDelegate tableView:self viewForHeaderInSection:section];
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (_vcDelegate && [_vcDelegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
        return  [_vcDelegate tableView:self heightForHeaderInSection:section];
    }
    return 0;
}

#pragma mark UITableViewDelegate
//互动
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell =  [self tableView:tableView cellForIndexPath:indexPath];
    ChuckModel *chuckModel = [self getModelAtIndexPath:indexPath];
    
    if(self.cellDidselectConfigBefore) {
        self.cellDidselectConfigBefore(cell, chuckModel.model,indexPath);
    }
    if ([cell respondsToSelector:@selector(tableView:vcDelegate:didSelectRowWithModel:atIndexPath:)]) {
        [cell tableView:self vcDelegate:self.vcDelegate didSelectRowWithModel:chuckModel.model atIndexPath:indexPath];
    }
}

#pragma mark --- 编辑模式 ---
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self ifExistFooterRefresh:indexPath]) {
        return NO;
    }
    return [self getModelAtIndexPath:indexPath].edit;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self ifExistFooterRefresh:indexPath]) {
        return UITableViewCellEditingStyleNone;
    }
    return [self getModelAtIndexPath:indexPath].editStyle;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    ChuckModel *chuckModel = [self getModelAtIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(tableView:vcDelegate:commitEditingWithModel:style:forRowAtIndexPath:)]) {
        [cell tableView:self vcDelegate:self.vcDelegate commitEditingWithModel:chuckModel.model style:chuckModel.editStyle forRowAtIndexPath:indexPath];
    }
    
}


#pragma mark 常用APi
-(void)clearTableViewCell{
    [self.modelSource removeAllObjects];
}
//获取元素
- (id)modelsAtIndexPath:(NSIndexPath *)indexPath {
    return [self getModelAtIndexPath:indexPath].model;
}
- (ChuckModel *)chuckModelAtIndexPath:(NSIndexPath *)indexPath {
    return [self getModelAtIndexPath:indexPath];
}
-(void)scrollToBottomAnimationTime:(CGFloat)time{
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(doTheLast:) object:@(time)];
    [self performSelector:@selector(doTheLast:) withObject:@(time) afterDelay:0.3];
}
-(void)doTheLast:(NSNumber *)time{
    //    __weak typeof(self) wSelf = self;
    //    CGFloat y = self.contentSize.height - self.frame.size.height;
    if (self.contentSize.height<=self.frame.size.height) {
        return;
    }
    [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.modelSource[ [self numberOfSection]-1] count]-1 inSection:[self numberOfSection]-1] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
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
@end
