//
//  UIView+CsFrameLayout.m
//  cs_framelayout
//
//  Created by 梁慧聪 on 2017/1/6.
//  Copyright © 2017年 梁慧聪. All rights reserved.
//

#import "UIView+CsFrameLayout.h"
#import <objc/runtime.h>
@implementation UIView (CsFrameLayout)
- (CsFrameLayout *)ownLayout
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setOwnLayout:(CsFrameLayout *)ownLayout
{
    objc_setAssociatedObject(self, @selector(ownLayout), ownLayout, OBJC_ASSOCIATION_RETAIN);
}

-(CsFrameLayout *)cslayout{
    CsFrameLayout *layout = [self ownLayout];
    if (!layout) {
        layout = [[CsFrameLayout alloc]initWithView:self];
        [self setOwnLayout:layout];
    }
    return layout;
}

@end
