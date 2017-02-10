//
//  UICollectionViewCell+Chuck.m
//  ChuckTableView
//
//  Created by 梁慧聪 on 2016/11/30.
//  Copyright © 2016年 liangdianxiong. All rights reserved.
//

#import "UICollectionViewCell+Chuck.h"
#import "ChuckCollectionView.h"
#import <objc/runtime.h>
@implementation UICollectionViewCell (Chuck)
- (ChuckCollectionView *)chuckCollectionView
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setChuckCollectionView:(ChuckCollectionView *)chuckCollectionView
{
    objc_setAssociatedObject(self, @selector(chuckCollectionView), chuckCollectionView, OBJC_ASSOCIATION_RETAIN);
}

-(ChuckModel *)chuckModel{
 return objc_getAssociatedObject(self, _cmd);
}
- (void)setChuckModel:(ChuckModel *)chuckModel
{
    objc_setAssociatedObject(self, @selector(chuckModel), chuckModel, OBJC_ASSOCIATION_RETAIN);
}
-(id)chuckDelegate{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setChuckDelegate:(id)chuckDelegate
{
    objc_setAssociatedObject(self, @selector(chuckDelegate), chuckDelegate, OBJC_ASSOCIATION_RETAIN);
}
@end
