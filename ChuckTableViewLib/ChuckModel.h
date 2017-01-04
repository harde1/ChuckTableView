//
//  ChuckModel.h
//  ChuckTableView
//
//  Created by cong on 2016/10/28.
//  Copyright © 2016年 liangdianxiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadFootModel.h"
typedef void (^CellConfigureBefore)(id cell, id model, NSIndexPath * indexPath);
typedef void (^CellDidselectConfigureBefore)(id cell, id model, NSIndexPath * indexPath);
typedef void (^HeadFootConfigureBefore)(UICollectionReusableView * view, id model,NSString * kind, NSUInteger section);
@interface ChuckModel : NSObject
@property(nonatomic,strong)id model;
@property(nonatomic,copy)NSString *identifier;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,assign)BOOL edit;
@property(nonatomic,assign)UITableViewCellEditingStyle editStyle;
@property(nonatomic,assign)CGFloat cellHeight;
- (id)initEmptyIndexPath:(NSIndexPath *)indexPath;
- (id)initCollectViewEmptyIndexPath:(NSIndexPath *)indexPath;
- (id)initWithModel:(id)model cellClass:(Class)cellClass allowEdit:(BOOL)edit editStyle:(UITableViewCellEditingStyle)editStyle indexPath:(NSIndexPath *)indexPath;
@end
