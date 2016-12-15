//
//  ChuckCellConfigure.h
//  ChuckTableView
//
//  Created by cong on 2016/10/28.
//  Copyright © 2016年 liangdianxiong. All rights reserved.
//
//  cell要实现的方法
#import <Foundation/Foundation.h>
#import "ChuckTableView.h"
#import "ChuckCollectionView.h"
@protocol ChuckCellConfigure <NSObject>
@optional
- (void)tableView:(ChuckTableView *)tableView vcDelegate:(id)vcDelegate cellForRowWithModel:(id)model atIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(ChuckTableView *)tableView vcDelegate:(id)vcDelegate heightForRowWithModel:(id)model atIndexPath:(NSIndexPath *)indexPath;
-(void)tableView:(ChuckTableView *)tableView vcDelegate:(id)vcDelegate didSelectRowWithModel:(id)model atIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(ChuckTableView *)tableView vcDelegate:(id)vcDelegate commitEditingWithModel:(id)model style:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;


#pragma mark -- ChuckCollectionView --
- (void)collectionView:(ChuckCollectionView *)collectionView vcDelegate:(id)vcDelegate cellForRowWithModel:(id)model atIndexPath:(NSIndexPath *)indexPath;
-(void)collectionView:(ChuckCollectionView *)collectionView vcDelegate:(id)vcDelegate didSelectRowWithModel:(id)model atIndexPath:(NSIndexPath *)indexPath;

//-(CGSize)collectionView:(ChuckCollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout  model:(id)model referenceSizeForHeaderInSection:(NSInteger)section;
//- (CGSize)collectionView:(ChuckCollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout model:(id)model referenceSizeForFooterInSection:(NSInteger)section;


- (void)collectionView:(ChuckCollectionView *)collectionView vcDelegate:(id)vcDelegate model:(id)model viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;
@end
