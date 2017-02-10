//
//  CsFrameLayout.h
//  cs_framelayout
//
//  Created by 梁慧聪 on 2017/1/6.
//  Copyright © 2017年 梁慧聪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class CsFrameLayout;
typedef void(^End)();
typedef CsFrameLayout * (^SpaceEqual)(CGFloat to);
typedef CsFrameLayout * (^MarginToView)(id viewOrViewsArray, CGFloat value);
@class CsFrameLayoutModel;
@interface CsFrameLayout : NSObject
- (instancetype)initWithView:(UIView *)view;
-(CsFrameLayout *(^)(CGFloat to))equalTo;
-(CsFrameLayout *(^)(CGFloat offset))offset;
@property(nonatomic) CsFrameLayout *left;
@property(nonatomic) CsFrameLayout *right;
@property(nonatomic) CsFrameLayout *top;
@property(nonatomic) CsFrameLayout *bottom;
@property(nonatomic) CsFrameLayout *width;
@property(nonatomic) CsFrameLayout *height;
@property(nonatomic) CsFrameLayout *centerX;
@property(nonatomic) CsFrameLayout *centerY;
@property(nonatomic) CsFrameLayout *center;

@property(nonatomic) CsFrameLayout *origin;
@property(nonatomic) CsFrameLayout *size;

@property(nonatomic) CsFrameLayout *sizeToFit;

@property(nonatomic,copy) SpaceEqual leftSpaceEqual;
@property(nonatomic,copy) SpaceEqual rightSpaceEqual;
@property(nonatomic,copy) SpaceEqual topSpaceEqual;
@property(nonatomic,copy) SpaceEqual bottomSpaceEqual;
@property(nonatomic,copy) SpaceEqual widthEqual;
@property(nonatomic,copy) SpaceEqual heightEqual;
@property(nonatomic,copy) SpaceEqual centerXEqual;
@property(nonatomic,copy) SpaceEqual centerYEqual;
@property(nonatomic,copy) SpaceEqual centerEqual;

/* 设置距离其它view的间距 */

/** 左边到其参照view之间的间距，参数为“(View 或者 view数组, CGFloat)”  */
@property (nonatomic, copy, readonly) MarginToView leftSpaceToView;
/** 右边到其参照view之间的间距，参数为“(View, CGFloat)”  */
@property (nonatomic, copy, readonly) MarginToView rightSpaceToView;
/** 顶部到其参照view之间的间距，参数为“(View 或者 view数组, CGFloat)”  */
@property (nonatomic, copy, readonly) MarginToView topSpaceToView;
/** 底部到其参照view之间的间距，参数为“(View, CGFloat)”  */
@property (nonatomic, copy, readonly) MarginToView bottomSpaceToView;



@property(nonatomic) End end;
-(void)render;
@end
