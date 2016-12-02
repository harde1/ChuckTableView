//
//  HeadFootModel.h
//  ChuckTableView
//
//  Created by 梁慧聪 on 2016/11/30.
//  Copyright © 2016年 liangdianxiong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeadFootModel : NSObject<NSCopying,NSMutableCopying>
@property(nonatomic,strong)id model;
@property(nonatomic,assign)BOOL isFoot;//是脚
@property(nonatomic,copy)NSString *kind;
@property(nonatomic,copy)NSString *identifier;
@property(nonatomic,assign)NSUInteger section;
@property(nonatomic,assign)BOOL edit;
@property(nonatomic,assign)NSInteger editStyle;
@property(nonatomic,assign)float height;
- (id)initEmptySection:(NSUInteger)section;
- (id)initWithHeadFootModel:(id)model
                  cellClass:(Class)cellClass
                  kind:(NSString *)kind
                  editStyle:(NSInteger)editStyle
                    section:(NSUInteger)section;
@end
