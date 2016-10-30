//
//  SmartModel.h
//  ChuckTableView
//
//  Created by cong on 2016/10/28.
//  Copyright © 2016年 liangdianxiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SmartModel : NSObject
@property(nonatomic,strong)id model;
@property(nonatomic,copy)NSString *identifier;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,assign)BOOL edit;
@property(nonatomic,assign)UITableViewCellEditingStyle editStyle;
@property(nonatomic,assign)CGFloat cellHeight;
- (id)initEmptyIndexPath:(NSIndexPath *)indexPath;
- (id)initWithModel:(id)model cellClass:(Class)cellClass allowEdit:(BOOL)edit editStyle:(UITableViewCellEditingStyle)editStyle indexPath:(NSIndexPath *)indexPath;
@end
