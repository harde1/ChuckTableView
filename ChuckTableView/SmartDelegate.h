//
//  SmartConfigure.h
//  ChuckTableView
//
//  Created by cong on 2016/10/28.
//  Copyright © 2016年 liangdianxiong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SmartTableView;
@protocol SmartDelegate <NSObject>

@optional
//head
- (UIView *)tableView:(SmartTableView *)tableView viewForHeaderInSection:(NSInteger)section;
- (CGFloat)tableView:(SmartTableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (UIView *)tableView:(SmartTableView *)tableView viewForFooterRefresh:(UITableViewCell *)cell;




- (void)scrollViewDidScroll:(SmartTableView *)tableView;
- (void)scrollViewDidZoom:(SmartTableView *)tableView NS_AVAILABLE_IOS(3_2);
- (void)scrollViewWillBeginDragging:(SmartTableView *)tableView;
- (void)scrollViewWillEndDragging:(SmartTableView *)tableView withVelocity:(CGPoint)velocity targetContentOffset:( inout CGPoint * )targetContentOffset NS_AVAILABLE_IOS(5_0);
- (void)scrollViewDidEndDragging:(SmartTableView *)tableView willDecelerate:(BOOL)decelerate;
- (void)scrollViewWillBeginDecelerating:(SmartTableView *)tableView; - (void)scrollViewDidEndDecelerating:(SmartTableView *)tableView;
- (void)scrollViewDidEndScrollingAnimation:(SmartTableView *)tableView;- (UIView *)viewForZoomingInScrollView:(SmartTableView *)tableView;
- (void)scrollViewWillBeginZooming:(SmartTableView *)tableView withView:( UIView *)view NS_AVAILABLE_IOS(3_2);
- (void)scrollViewDidEndZooming:(SmartTableView *)tableView withView:( UIView *)view atScale:(CGFloat)scale;
- (void)scrollViewDidScrollToTop:(SmartTableView *)tableView;
@end
