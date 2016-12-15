//
//  ChuckConfigure.h
//  ChuckTableView
//
//  Created by cong on 2016/10/28.
//  Copyright © 2016年 liangdianxiong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ChuckTableView;
@class ChuckCollectionView;
@protocol ChuckDelegate <NSObject>

@optional
#pragma mark ChuckTableView
//head
- (UIView *)tableView:(ChuckTableView *)tableView viewForHeaderInSection:(NSInteger)section;
- (CGFloat)tableView:(ChuckTableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (UIView *)tableView:(ChuckTableView *)tableView viewForFooterRefresh:(UITableViewCell *)cell;



#pragma mark ChuckCollectionView
- (UIView *)collectionView:(ChuckCollectionView *)collectionView viewForHeaderInSection:(NSInteger)section;
- (CGFloat)collectionView:(ChuckCollectionView *)collectionView heightForHeaderInSection:(NSInteger)section;
-(CGSize)collectionView:(ChuckCollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForKind:(NSString *)kind model:(id)model inSection:(NSInteger)section;
- (UIView *)collectionView:(ChuckCollectionView *)collectionView viewForFooterRefresh:(UICollectionViewCell *)cell;

#pragma mark Scroll Event
- (void)scrollViewDidScroll:(ChuckTableView *)tableView;
- (void)scrollViewDidZoom:(ChuckTableView *)tableView NS_AVAILABLE_IOS(3_2);
- (void)scrollViewWillBeginDragging:(ChuckTableView *)tableView;
- (void)scrollViewWillEndDragging:(ChuckTableView *)tableView withVelocity:(CGPoint)velocity targetContentOffset:( inout CGPoint * )targetContentOffset NS_AVAILABLE_IOS(5_0);
- (void)scrollViewDidEndDragging:(ChuckTableView *)tableView willDecelerate:(BOOL)decelerate;
- (void)scrollViewWillBeginDecelerating:(ChuckTableView *)tableView; - (void)scrollViewDidEndDecelerating:(ChuckTableView *)tableView;
- (void)scrollViewDidEndScrollingAnimation:(ChuckTableView *)tableView;- (UIView *)viewForZoomingInScrollView:(ChuckTableView *)tableView;
- (void)scrollViewWillBeginZooming:(ChuckTableView *)tableView withView:( UIView *)view NS_AVAILABLE_IOS(3_2);
- (void)scrollViewDidEndZooming:(ChuckTableView *)tableView withView:( UIView *)view atScale:(CGFloat)scale;
- (void)scrollViewDidScrollToTop:(ChuckTableView *)tableView;
@end
