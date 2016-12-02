//
//  NSMutableArray+Chuck.h
//  ChuckTableView
//
//  Created by 梁慧聪 on 2016/12/1.
//  Copyright © 2016年 liangdianxiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HeadFootModel.h"
@interface NSMutableArray (Chuck)
// 在UIImage中新建一个tag属性
@property (nonatomic, strong) HeadFootModel *headModel;
@property (nonatomic, strong) HeadFootModel *footModel;
@end
