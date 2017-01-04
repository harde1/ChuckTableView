//
//  CollectCellTopBar.m
//  ChuckTableView
//
//  Created by 梁慧聪 on 2017/1/4.
//  Copyright © 2017年 liangdianxiong. All rights reserved.
//

#import "CollectCellTopBar.h"
#import "UICollectionViewCell+Chuck.h"
@interface CollectCellTopBar()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constHeight;

@end
@implementation CollectCellTopBar

- (void)awakeFromNib {
    [super awakeFromNib];
    self.constHeight.constant = 140.0/1324 * [UIApplication sharedApplication].keyWindow.bounds.size.height;
}

@end
