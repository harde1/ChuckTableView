//
//  HeadFootModel.m
//  ChuckTableView
//
//  Created by 梁慧聪 on 2016/11/30.
//  Copyright © 2016年 liangdianxiong. All rights reserved.
//

#import "HeadFootModel.h"

@implementation HeadFootModel
- (id)initWithHeadFootModel:(id)model
                  cellClass:(Class)cellClass
                  kind:(NSString *)kind
                  editStyle:(NSInteger)editStyle
                    section:(NSUInteger)section{
    if (self = [super init]) {
        self.model = model;
        self.identifier = NSStringFromClass(cellClass);
        self.kind = kind;
        self.editStyle = editStyle;
        self.section = section;
    }
    return self;
}
- (id)initEmptySection:(NSUInteger)section{
    if (self = [super init]) {
        self.model = nil;
        self.identifier = @"UICollectionReusableView";
        self.kind = @"UICollectionElementKindSectionHeader";
        self.editStyle = 0;
        self.section = section;
    }
    return self;
}
- (id)copyWithZone:(NSZone *)zone
{
    HeadFootModel *copy = [[[self class] allocWithZone:zone] init];
    copy.model = self.model;
    copy.identifier = self.identifier;
    copy.kind = self.kind;
    copy.editStyle = self.editStyle;
    copy.section = self.section;

    return copy;
}
- (id)mutableCopyWithZone:(NSZone *)zone
{
    HeadFootModel *copy =  [[HeadFootModel allocWithZone:zone] init];;
    copy.model = self.model;
    copy.identifier = self.identifier;
    copy.kind = self.kind;
    copy.editStyle = self.editStyle;
    copy.section = self.section;
    return copy;
}
-(NSString *)description{
    return [NSString stringWithFormat:@"[\nidentifier:%@\nmodel:%@\nkind:%@\neditStyle:%@\nsection:%@\n]",self.identifier,self.model,self.kind,@(self.editStyle),@(self.section)];
}
@end
