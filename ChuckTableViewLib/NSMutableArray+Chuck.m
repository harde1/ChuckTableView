//
//  NSMutableArray+Chuck.m
//  ChuckTableView
//
//  Created by 梁慧聪 on 2016/12/1.
//  Copyright © 2016年 liangdianxiong. All rights reserved.
//

#import "NSMutableArray+Chuck.h"
#import <objc/runtime.h>
static const void *tagKey = &tagKey;
static const void *tagFootKey = &tagFootKey;
@implementation NSMutableArray (Chuck)
- (HeadFootModel *)headModel {
    return objc_getAssociatedObject(self, tagKey);
}
- (void)setHeadModel:(HeadFootModel *)headModel {
    objc_setAssociatedObject(self, tagKey, headModel, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (HeadFootModel *)footModel {
    return objc_getAssociatedObject(self, tagFootKey);
}
- (void)setFootModel:(HeadFootModel *)footModel {
    objc_setAssociatedObject(self, tagFootKey, footModel, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end
