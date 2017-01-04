//
//  CollectCellContent.m
//  ChuckTableView
//
//  Created by 梁慧聪 on 2017/1/4.
//  Copyright © 2017年 liangdianxiong. All rights reserved.
//

#import "CollectCellContent.h"
#import "UtilScreenSize.h"
@implementation CollectCellContent

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = UIColorFromRGB(0xf5f5f5);
}

@end
