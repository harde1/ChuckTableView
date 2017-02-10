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
//contentSize发生变化时候调用
- (void)chuckContentSizeChange:(CGSize)contentSize;
#pragma mark ChuckTableView
//head
- (UIView *)tableView:(ChuckTableView *)tableView viewForHeaderInSection:(NSInteger)section;
- (CGFloat)tableView:(ChuckTableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (UIView *)tableView:(ChuckTableView *)tableView viewForFooterRefresh:(UITableViewCell *)cell;



#pragma mark ChuckCollectionView
//- (UIView *)collectionView:(ChuckCollectionView *)collectionView viewForHeaderInSection:(NSInteger)section;
//- (CGFloat)collectionView:(ChuckCollectionView *)collectionView heightForHeaderInSection:(NSInteger)section;
//-(CGSize)collectionView:(ChuckCollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForKind:(NSString *)kind model:(id)model inSection:(NSInteger)section;
//- (UIView *)collectionView:(ChuckCollectionView *)collectionView viewForFooterRefresh:(UICollectionViewCell *)cell;

#pragma mark Scroll Event
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidZoom:(UIScrollView *)scrollView NS_AVAILABLE_IOS(3_2);
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:( inout CGPoint * )targetContentOffset NS_AVAILABLE_IOS(5_0);
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView;
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:( UIView *)view NS_AVAILABLE_IOS(3_2);
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:( UIView *)view atScale:(CGFloat)scale;
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView;
@end
