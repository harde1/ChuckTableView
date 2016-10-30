//
//  SmartDataSource.m
//  ChuckTableView
//
//  Created by cong on 2016/10/28.
//  Copyright © 2016年 liangdianxiong. All rights reserved.
//

#import "SmartTableView.h"
#import <objc/message.h>
@interface SmartTableView () {
    NSMutableArray *m_Models;
}
@property(nonatomic,strong) NSMutableDictionary *m_dict;
@property(nonatomic,strong) NSMutableDictionary *tableViewConfig;
@end
@implementation SmartTableView

-(NSMutableDictionary *)m_dict{
    if (!_m_dict) {
        _m_dict = [NSMutableDictionary dictionary];
    }
    return _m_dict;
}
-(NSMutableDictionary *)tableViewConfig{
    if (!_tableViewConfig) {
        _tableViewConfig= [NSMutableDictionary dictionary];
        //默认为一个section
        [_tableViewConfig setObject:[NSNumber numberWithInteger:1] forKey:[self getSectionKey]];
    }
    return _tableViewConfig;
}
//基础配置
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style configureBlock:(CellConfigureBefore)before {
    if(self = [super initWithFrame:frame style:style]) {
        _cellConfigureBefore = [before copy];
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
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

- (void)addModels:(NSArray *)models cellClass:(Class)cellClass section:(NSInteger)section{
    if(![models isKindOfClass:[NSArray class]]) return;
    for (id model in models) {
        [self addModel:model cellClass:cellClass section:section];
    }
}

- (void)addModel:(id)model cellClass:(Class)cellClass{
    if(!model||![cellClass isSubclassOfClass:[UITableViewCell class]]) return;
    [self addModel:model cellClass:cellClass section:0 allowEdit:NO editStyle:UITableViewCellEditingStyleNone];
}
- (void)addModel:(id)model cellClass:(Class)cellClass section:(NSInteger)section{
    if(!model||![cellClass isSubclassOfClass:[UITableViewCell class]]) return;
    [self addModel:model cellClass:cellClass section:section allowEdit:NO editStyle:UITableViewCellEditingStyleNone];
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
    [self.m_dict setObject:[self configModel:model cellClass:cellClass allowEdit:edit editStyle:editStyle indexPath:indexPath] forKey:[self getKeyByIndexPath:indexPath]];
    //注册cell
    [self registerCell:cellClass];
    //获取section和row的数量
    NSInteger row = [[self.tableViewConfig objectForKey:[self getRowKeyBySection:indexPath.section]] integerValue];
    //递增1
    [self.tableViewConfig setObject:[NSNumber numberWithInteger:row+1] forKey:[self getRowKeyBySection:indexPath.section]];
    //如果导入的section大于现在存在的section数量，那么indexPath.section+1就是现在的section数量
    NSInteger sectionCount = [[self.tableViewConfig objectForKey:[self getSectionKey]] integerValue];
    if (indexPath.section>=sectionCount) {
        [self.tableViewConfig setObject:[NSNumber numberWithInteger:indexPath.section+1] forKey:[self getSectionKey]];
    }
}
//model
- (SmartModel*)configModel:(id)model cellClass:(Class)cellClass allowEdit:(BOOL)edit editStyle:(UITableViewCellEditingStyle)editStyle indexPath:(NSIndexPath *)indexPath{
    return [[SmartModel alloc]initWithModel:model cellClass:cellClass allowEdit:edit editStyle:editStyle indexPath:indexPath];
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
-(NSString *)getKeyByIndexPath:(NSIndexPath *)indexPath{
    return [NSString stringWithFormat:@"Smart_%ld_%ld",indexPath.section,indexPath.row];
}
-(NSString *)getRowKeyBySection:(NSInteger)section{
    return [NSString stringWithFormat:@"Smart_section_row_%ld",section];
}
-(NSString *)getSectionKey{
    return @"Smart_section";
}
-(NSInteger)numberOfRowsAtSection:(NSInteger)section{
    return [[self.tableViewConfig objectForKey:[self getRowKeyBySection:section]] integerValue];
}
-(NSInteger)numberOfSection{
    return [[self.tableViewConfig objectForKey:[self getSectionKey]] integerValue];
}
//获取元素
- (id)modelsAtIndexPath:(NSIndexPath *)indexPath {
    return [self getModelAtIndexPath:indexPath].model;
}
- (SmartModel *)getModelAtIndexPath:(NSIndexPath *)indexPath{
    return [self.m_dict objectForKey:[self getKeyByIndexPath:indexPath]];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellforSmartModel:(SmartModel *)smartModel forIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:smartModel.identifier
                                                            forIndexPath:indexPath];
    if (!cell) {
        cell = [[NSClassFromString(smartModel.identifier) alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:smartModel.identifier];
    }
    return cell;
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self numberOfSection];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self numberOfRowsAtSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self tableView:tableView cellForIndexPath:indexPath];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForIndexPath:(NSIndexPath *)indexPath{
    SmartModel *smartModel = [self getModelAtIndexPath:indexPath];
    if (!smartModel) {
        return [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"sss"];
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:smartModel.identifier];
    if (!cell) {
        cell = [[NSClassFromString(smartModel.identifier) alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:smartModel.identifier];
    }
    
    id model = smartModel.model;
    
    if(self.cellConfigureBefore) {
        self.cellConfigureBefore(cell, model,indexPath);
    }
    if ([cell respondsToSelector:@selector(tableView:cellForRowWithModel:atIndexPath:)]) {
        [cell tableView:tableView cellForRowWithModel:model atIndexPath:indexPath];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell =  [self tableView:tableView cellForIndexPath:indexPath];
    SmartModel *smartModel = [self getModelAtIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(tableView:heightForRowWithModel:atIndexPath:)]) {
     return  [cell tableView:tableView heightForRowWithModel:smartModel.model atIndexPath:indexPath];
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
    view.backgroundColor = [UIColor redColor];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

#pragma mark UITableViewDelegate
//互动
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell =  [self tableView:tableView cellForIndexPath:indexPath];
    SmartModel *smartModel = [self getModelAtIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(tableView:heightForRowWithModel:atIndexPath:)]) {
        [cell tableView:tableView didSelectRowWithModel:smartModel.model atIndexPath:indexPath];
    }
}
@end
