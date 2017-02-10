//
//  ChuckModel.m
//  ChuckTableView
//
//  Created by cong on 2016/10/28.
//  Copyright © 2016年 liangdianxiong. All rights reserved.
//

#import "ChuckModel.h"

@implementation ChuckModel
- (id)initWithModel:(id)model cellClass:(Class)cellClass allowEdit:(BOOL)edit editStyle:(UITableViewCellEditingStyle)editStyle indexPath:(NSIndexPath *)indexPath{
    if (self = [super init]) {
        self.model = model;
        self.identifier = NSStringFromClass(cellClass);
        self.edit = edit;
        self.editStyle = editStyle;
        self.indexPath = indexPath;
    }
    return self;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"[\nidentifier:%@\nmodel:%@\nedit:%@\neditStyle:%@\nsection:%@\nrow:%@\n]",self.identifier,self.model,self.edit?@"YES":@"NO",@(self.editStyle),@(self.indexPath.section),@(self.indexPath.row)];
}

- (id)initEmptyIndexPath:(NSIndexPath *)indexPath{
    if (self = [super init]) {
        self.model = nil;
        self.identifier = @"UITableViewCell";
        self.edit = NO;
        self.editStyle = UITableViewCellEditingStyleNone;
        self.indexPath = indexPath;
    }
    return self;
}
- (id)initCollectViewEmptyIndexPath:(NSIndexPath *)indexPath{
    if (self = [super init]) {
        self.model = nil;
        self.identifier = @"UICollectionViewCell";
        self.edit = NO;
        self.editStyle = UITableViewCellEditingStyleNone;
        self.indexPath = indexPath;
    }
    return self;
}
-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}
@end
